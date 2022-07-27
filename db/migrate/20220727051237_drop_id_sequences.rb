class DropIdSequences < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      DROP SEQUENCE public.users_id_seq;
      DROP SEQUENCE public.accounts_id_seq;
      DROP SEQUENCE public.queued_games_id_seq;
    SQL
  end
end
