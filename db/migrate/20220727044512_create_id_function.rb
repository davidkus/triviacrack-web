class CreateIdFunction < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE SEQUENCE public.global_id_seq;

      -- 43 bits for time  - ~278 years
      -- 10 bits for shard - 1024 shards
      -- 10 bits for seq   - 1024 / ms = 1024000 ids / seconds
      CREATE OR REPLACE FUNCTION public.next_id()
          RETURNS bigint
          LANGUAGE 'plpgsql'
      AS $BODY$
      DECLARE
          our_epoch bigint := 1658895183157;
          seq_id bigint;
          now_millis bigint;
          shard_id int := 1;
          result bigint:= 0;
      BEGIN
          SELECT nextval('public.global_id_seq') % 1024 INTO seq_id;

          SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
          result := (now_millis - our_epoch) << 21;
          result := result | (shard_id << 10);
          result := result | (seq_id);
        return result;
      END;
      $BODY$;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION public.next_id();
      DROP SEQUENCE public.global_id_seq;
    SQL
  end
end
