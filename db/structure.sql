SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: next_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.next_id() RETURNS bigint
    LANGUAGE plpgsql
    AS $$
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
      $$;


SET default_tablespace = '';

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id bigint DEFAULT public.next_id() NOT NULL,
    username character varying,
    session_id character varying,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    expiration timestamp without time zone,
    email character varying
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: global_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.global_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: queued_games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queued_games (
    id bigint DEFAULT public.next_id() NOT NULL,
    game_id bigint,
    account_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint DEFAULT public.next_id() NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    admin boolean DEFAULT false
);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: queued_games queued_games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queued_games
    ADD CONSTRAINT queued_games_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_user_id ON public.accounts USING btree (user_id);


--
-- Name: index_queued_games_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_queued_games_on_account_id ON public.queued_games USING btree (account_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20150314212339'),
('20150314212352'),
('20150314213329'),
('20150315200054'),
('20150315201117'),
('20150318042853'),
('20150325225442'),
('20220722013445'),
('20220722013446'),
('20220722013447'),
('20220727044512'),
('20220727045722'),
('20220727051237');


