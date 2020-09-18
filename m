Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292152707B3
	for <lists+linux-pm@lfdr.de>; Fri, 18 Sep 2020 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRVD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Sep 2020 17:03:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33130 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVD0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2020 17:03:26 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 17:03:25 EDT
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B1ABB1C0B7C; Fri, 18 Sep 2020 22:56:43 +0200 (CEST)
Date:   Fri, 18 Sep 2020 22:56:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pm: runtime: fix timer_expires on 32bits arch
Message-ID: <20200918205643.GA4304@duo.ucw.cz>
References: <20200918165518.23246-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20200918165518.23246-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-09-18 19:55:18, Grygorii Strashko wrote:
> The commit 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> hrtimers") switched PM runtime autosuspend to use hrtimers and all related
> time accounting in ns, but missed update the struct
> dev_pm_info->timer_expires to u64. This causes timer_expires value to be
> truncated on 32bits architectures when assignment is done from u64 values:
>=20
> rpm_suspend()
> |- dev->power.timer_expires =3D expires;
>=20
> Hence, fix it by changing timer_expires type to u64.
>=20
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtime=
rs")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2UfCwAKCRAw5/Bqldv6
8gOOAKDAEBNUkiCrXacorVsvRCQSjhXbowCfcQxJkV+gbZcAwF3Y0JyY0GZPXBE=
=VqJV
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
