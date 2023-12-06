--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    diameter_ly numeric NOT NULL,
    distance_from_earth_ly integer,
    type text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(60) NOT NULL,
    mass_me numeric NOT NULL,
    planet_id integer NOT NULL,
    has_atmosphere boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    mass_me numeric NOT NULL,
    has_life boolean,
    type text,
    distance_from_earth_ly integer,
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: ship; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.ship (
    ship_id integer NOT NULL,
    name character varying(60) NOT NULL,
    location text
);


ALTER TABLE public.ship OWNER TO freecodecamp;

--
-- Name: ship_ship_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.ship_ship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ship_ship_id_seq OWNER TO freecodecamp;

--
-- Name: ship_ship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.ship_ship_id_seq OWNED BY public.ship.ship_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    mass_mo numeric NOT NULL,
    distance_from_earth_ly integer,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: ship ship_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.ship ALTER COLUMN ship_id SET DEFAULT nextval('public.ship_ship_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 87400, 26996, 'Sb');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 152000, 2500000, 'SA');
INSERT INTO public.galaxy VALUES (3, 'Messier 81', 96000, 8500000, 'SA');
INSERT INTO public.galaxy VALUES (4, 'Black Eye', 53800, 17300000, 'RSA');
INSERT INTO public.galaxy VALUES (5, 'Cartwheel', 144300, 500000000, 'S');
INSERT INTO public.galaxy VALUES (6, 'Cigar', 40800, 11400000, 'I0');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 0.0123, 1, false);
INSERT INTO public.moon VALUES (2, 'Io', 0.015, 5, false);
INSERT INTO public.moon VALUES (3, 'Europa', 0.008, 5, false);
INSERT INTO public.moon VALUES (4, 'Ganymede', 0.025, 5, false);
INSERT INTO public.moon VALUES (5, 'Phobos', 0.00001, 4, false);
INSERT INTO public.moon VALUES (6, 'Deimos', 0.00001, 4, false);
INSERT INTO public.moon VALUES (8, 'Tethys', 0.00001, 6, false);
INSERT INTO public.moon VALUES (7, 'Titan', 0.0225, 6, true);
INSERT INTO public.moon VALUES (9, 'Encladus', 0.00001, 6, false);
INSERT INTO public.moon VALUES (10, 'Telesto', 0.00001, 6, false);
INSERT INTO public.moon VALUES (11, 'Calypso', 0.00001, 6, false);
INSERT INTO public.moon VALUES (12, 'Dione', 0.00001, 6, false);
INSERT INTO public.moon VALUES (13, 'Helene', 0.00001, 6, false);
INSERT INTO public.moon VALUES (14, 'Rhea', 0.00001, 6, false);
INSERT INTO public.moon VALUES (15, 'Polydeuces', 0.00001, 6, false);
INSERT INTO public.moon VALUES (16, 'Mimas', 0.00001, 6, false);
INSERT INTO public.moon VALUES (17, 'Janus', 0.00001, 6, false);
INSERT INTO public.moon VALUES (18, 'Pandora', 0.00001, 6, false);
INSERT INTO public.moon VALUES (19, 'Pallene', 0.00001, 6, false);
INSERT INTO public.moon VALUES (20, 'Anthe', 0.00001, 6, false);
INSERT INTO public.moon VALUES (21, 'Methone', 0.00001, 6, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 1, true, 'Rocky', 0, 1);
INSERT INTO public.planet VALUES (2, 'Mercury', 0.055, false, 'Rocky', 0, 1);
INSERT INTO public.planet VALUES (3, 'Venus', 0.815, false, 'Rocky', 0, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 0.107, false, 'Rocky', 0, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 317.8, false, 'Gas', 0, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 95.159, false, 'Gas', 0, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 14.536, false, 'Gas', 0, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 17.147, false, 'Gas', 0, 1);
INSERT INTO public.planet VALUES (9, 'Alpha Centauri Bb', 0.5, false, 'rocky', 4, 9);
INSERT INTO public.planet VALUES (10, 'Proxima Centauri b', 9, false, 'Gas', 4, 10);
INSERT INTO public.planet VALUES (11, 'Tau Ceti b', 2, true, 'Rocky', 12, 5);
INSERT INTO public.planet VALUES (12, 'Tau Ceti g', 1.75, false, 'Rocky', 12, 5);
INSERT INTO public.planet VALUES (13, 'Tau Ceti f', 3.93, false, 'Rocky', 12, 5);


--
-- Data for Name: ship; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.ship VALUES (1, 'ISS', 'Low Earth Orbit');
INSERT INTO public.ship VALUES (2, 'Voyager', 'Interstellar Space - Milky Way');
INSERT INTO public.ship VALUES (3, 'Planet Express', 'Earth');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sol', 1, 0, 1);
INSERT INTO public.star VALUES (4, 'Alpha Centauri A', 1.08, 4, 1);
INSERT INTO public.star VALUES (5, 'Tau Ceti', 0.783, 12, 1);
INSERT INTO public.star VALUES (6, 'Epsilon Eridani', 0.82, 10, 1);
INSERT INTO public.star VALUES (7, 'Rho Alpha', 1.2, 152000, 2);
INSERT INTO public.star VALUES (8, 'Mu 92', 4.6, 17300000, 4);
INSERT INTO public.star VALUES (9, 'Alpha Centauri B', 0.9, 4, 1);
INSERT INTO public.star VALUES (10, 'Proxima Centauri', 0.122, 4, 1);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: ship_ship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.ship_ship_id_seq', 3, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 10, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: ship ship_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.ship
    ADD CONSTRAINT ship_name_key UNIQUE (name);


--
-- Name: ship ship_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.ship
    ADD CONSTRAINT ship_pkey PRIMARY KEY (ship_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--
