Return-Path: <linux-pm+bounces-1109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633C811866
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29CDCB209E4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D985364;
	Wed, 13 Dec 2023 15:53:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC73B7
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 07:53:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDRXd-0000t5-N4; Wed, 13 Dec 2023 16:52:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDRXZ-00FbSV-8h; Wed, 13 Dec 2023 16:52:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rDRXY-002Mb8-UB; Wed, 13 Dec 2023 16:52:52 +0100
Date: Wed, 13 Dec 2023 16:52:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	David Airlie <airlied@gmail.com>, linux-clk@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Russell King <linux@armlinux.org.uk>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-sunxi@lists.linux.dev,
	Daniel Vetter <daniel@ffwll.ch>, linux-pm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kyungmin Park <kyungmin.park@samsung.com>, kernel@pengutronix.de,
	Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 0/5] clk: Make clk_rate_exclusive_get() return void
Message-ID: <20231213155252.eq6cdzk2vuwllzdu@pengutronix.de>
References: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>
 <ki5n3rz5n4oxj2hhc3rj6xpn3e2tdi7fcp2q7exjbzilrlqflp@przautvhuy4g>
 <20231213074300.4bq7wkfqd4jhhcr4@pengutronix.de>
 <2nvbag657mlniqwq7fbilapc6vfw5qumab3yd6bqul25ot6wcn@wdlkh5az2fgs>
 <20231213110829.bjaxjjiyy4ug7o67@pengutronix.de>
 <6wnsxbi27xdxjtaqaaaq5wtwwilp4jfw4mg5y2ctdl7xrs44ry@ns6y36pf7hge>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4rnwsmpqrmgwol6u"
Content-Disposition: inline
In-Reply-To: <6wnsxbi27xdxjtaqaaaq5wtwwilp4jfw4mg5y2ctdl7xrs44ry@ns6y36pf7hge>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--4rnwsmpqrmgwol6u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:54:14PM +0100, Maxime Ripard wrote:
> On Wed, Dec 13, 2023 at 12:08:29PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Dec 13, 2023 at 09:36:49AM +0100, Maxime Ripard wrote:
> > > On Wed, Dec 13, 2023 at 08:43:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Wed, Dec 13, 2023 at 08:16:04AM +0100, Maxime Ripard wrote:
> > > > > On Tue, Dec 12, 2023 at 06:26:37PM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > clk_rate_exclusive_get() returns zero unconditionally. Most use=
rs "know"
> > > > > > that and don't check the return value. This series fixes the fo=
ur users
> > > > > > that do error checking on the returned value and then makes fun=
ction
> > > > > > return void.
> > > > > >=20
> > > > > > Given that the changes to the drivers are simple and so merge c=
onflicts
> > > > > > (if any) should be easy to handle, I suggest to merge this comp=
lete
> > > > > > series via the clk tree.
> > > > >=20
> > > > > I don't think it's the right way to go about it.
> > > > >=20
> > > > > clk_rate_exclusive_get() should be expected to fail. For example =
if
> > > > > there's another user getting an exclusive rate on the same clock.
> > > > >=20
> > > > > If we're not checking for it right now, then it should probably be
> > > > > fixed, but the callers checking for the error are right to do so =
if they
> > > > > rely on an exclusive rate. It's the ones that don't that should be
> > > > > modified.
> > > >=20
> > > > If some other consumer has already "locked" a clock that I call
> > > > clk_rate_exclusive_get() for, this isn't an error. In my bubble I c=
all
> > > > this function because I don't want the rate to change e.g. because I
> > > > setup some registers in the consuming device to provide a fixed UART
> > > > baud rate or i2c bus frequency (and that works as expected).
> > >=20
> > > [a long text of mostly right things (Uwe's interpretation) that are
> > > however totally unrelated to the patches under discussion.]
>=20
> I'm glad you consider it "mostly" right.

there was no offense intended. I didn't agree to all points, but didn't
think it was helpful to discuss that given that I considered them
orthogonal to my suggested modifications.
=20
> > The clk API works with and without my patches in exactly the same way.
> > It just makes more explicit that clk_rate_exclusive_get() cannot fail
> > today and removes the error handling from consumers that is never used.
>=20
> Not really, no.

What exactly do you oppose here? Both of my sentences are correct?!
=20
> An API is an interface, meant to provide an abstraction. The only
> relevant thing is whether or not that function, from an abstract point
> of view, can fail.

What is the ideal API that you imagine? For me the ideal API is:

A consumer might call clk_rate_exclusive_get() and after that returns
all other consumers are prohibited to change the rate of the clock
(directly and indirectly) until clk_rate_exclusive_put() is called. If
this ends in a double lock (i.e. two different consumers locked the
clock), then I cannot change the rate (and neither can anybody else).

That is fine iff I don't need to change the rate and just want to rely
on it to keep its current value (which is a valid use case). And if I
want to change the rate but another consumer prevents that, I handle
that in the same away as I handle all other failures to set the rate to
the value I need. I have to prepare for that anyhow even if I have
ensured that I'm the only one having exclusivity on that clock.

Letting clk_rate_exclusive_get() fail in the assumption that the
consumer also wants to modify the rate is wrong. The obvious point where
to stop such consumers is when they call clk_rate_set(). And those who
don't modify the rate then continue without interruption even if there
are two lockers.

This can easily be implemented without clk_rate_exclusive_get() ever
failing.

> Can you fail to get the exclusivity? Yes. On a theoretical basis, you
> can, and the function was explicitly documented as such.

Sure, you could modify the clk internals such that
clk_rate_exclusive_get() needs to allocate memory. Or that it fails if
another consumer already has called it. At least the latter is a change
in semantics that requires to review (and maybe fix) all users. Also
note that calling clk_rate_exclusive_get() essentially locks all parent
clocks up to the root clock. So if clk_rate_exclusive_get() fails in the
presence of another locker, you can only have one locker per clock
hierarchy because it's impossible that both grab the lock on the root
clock.

> > Is there anyone working on improving the clk framework regarding how clk
> > rate exclusivity works? I'd probably not notice, but I guess there is
> > noone that I need to consider for.
>=20
> I started working on it.

That is indeed a reason to postpone my patches. Feel free to Cc: me when
you're done. And please mention if you need longer than (say) 6 months,
then I'd argue that applying my patches now without caring for
out-of-tree users is the way to go.

My demand for such a rework would be that there is a function for=20
consumers to call that don't have the requirement for a certain rate but
only any fixed rate that results in locking the clock's rate to whatever
it currently is. Today that function exists and is called
clk_rate_exclusive_get(); this might not be the best name, so maybe
rename it to something that you consider more sensible at the start of
your rework?!

Semantically that is similar to read_lock() (which never fails and
still prevents any writers). And clk_set_rate() is like=20

	try_upgrade_read_lock_to_write_lock();
	actually_change_the_rate()
	downgrade_write_lock_to_read_lock();

where try_upgrade_read_lock_to_write_lock() fails if there are other
readers. So maybe a sensible name for today's clk_rate_exclusive_get()
is clk_rate_read_lock()?

If your variant of clk_rate_exclusive_get() might fail, you can already
prepare for me questioning why this is sensible and needed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4rnwsmpqrmgwol6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV501MACgkQj4D7WH0S
/k51hQf8CRNymicQ4BgKO3Qz+szmXEUKIg8qmLZG6f+sJ77H3mvg7zlbvpI/W/hI
rscYS06UjEHJM9ec8XTYACyQ1nJy98D8BxhawVTn+wrJa2z0tBDSg01HHBXZkVLe
xG6BYa5Dx94GTfhTXr9H4zwiLgchRz6/FFp4H49wHQ8rHLX6YYwLBUMq258vYNN8
Df1WULIGmruvRCkwWFyfhVC2OPyUy0FagJ5xsjJyRIavDaiFmuLEGg0avrbfEjN3
CMcsnDtQD1pALNhIWwvovcLint4Iap8vDz6O3+MyEDj65AZf8DzO8TJZjTYwGnoI
zj1/dV/j2h1+TK5lvLFOTKPzSD3u1Q==
=Nnb7
-----END PGP SIGNATURE-----

--4rnwsmpqrmgwol6u--

