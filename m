Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF83CB855
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhGPOEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 10:04:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhGPOEl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 10:04:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6B6AE1F44129
Received: by earth.universe (Postfix, from userid 1000)
        id B439F3C0C97; Fri, 16 Jul 2021 16:01:43 +0200 (CEST)
Date:   Fri, 16 Jul 2021 16:01:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] power: supply: cw2015: use dev_err_probe to allow
 deferred probe
Message-ID: <20210716140143.xk46qdlqyby7s4y6@earth.universe>
References: <20210701220516.2738398-1-pbrobinson@gmail.com>
 <CABxcv=mHGeSHNo=eeA0cBpL+3s2Kx2nUrrJ+-xOqBx=ORza0yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ohpzp4d3rs6k2dsa"
Content-Disposition: inline
In-Reply-To: <CABxcv=mHGeSHNo=eeA0cBpL+3s2Kx2nUrrJ+-xOqBx=ORza0yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ohpzp4d3rs6k2dsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 02, 2021 at 12:14:40AM +0200, Javier Martinez Canillas wrote:
> On Fri, Jul 2, 2021 at 12:07 AM Peter Robinson <pbrobinson@gmail.com> wro=
te:
> >
> > Deal with deferred probe using dev_err_probe so the error is handled
> > and avoid logging lots probe defer information like the following:
> >
> > [    9.125121] cw2015 4-0062: Failed to register power supply
> > [    9.211131] cw2015 4-0062: Failed to register power supply
> >
> > Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge dri=
ver")
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
>=20
> Right, I also found this error message annoying and agree that's too nois=
y.
>=20
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks, queued (but would have been nicer to just return
dev_err_probe() instead of doing another round of PTR_ERR
conversion).

-- Sebastian

--ohpzp4d3rs6k2dsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDxkUcACgkQ2O7X88g7
+pru9BAAqQH9YNhp38I9qX4wnw9nwW8Xi+MPjv7FafnNonM9qQbd/d2je7AhiNhh
foQwyAzw/4JEhBHTxUf23cEl+4espI5MH4mPUs6rL1tSQ80kPDlwP89ODY7YeRxE
Ex4dL2mSuclgbt2IvUgZjV9EnN0RKFTTyIkNc0y0tAPZozY/h1ZKX0MxR+KJHuLB
OWwW/XT+zKYr3p5SgTcmHOnb1glvUEAeRs66kP20XOywfZeV4X3eYmRastFQC410
QAzjVFwdaMERsLKn8vjm1+KvdrcuPpt28PRCt/S0GruhaeVlLSGptJkUv/De7cmQ
PuA0LC7As17LQQkr/571scucRI2/FukimH/7OChIHoOOMRWqUK8X4k9VETgMAGGL
2j5EDE6zKqhdbKDeFKBZeci9pzW/D5ohgPKqCkYwYeSbUQ0DqtrJUzo/p8XM+DMQ
RSBqyF5c2SWnENvTpSrQ0ZBw/rV+IEb26KzOfFV28KMGJB1daDY/RbR4U7k/BwLS
PPq7vM+8Ao77tE3ADlkVKvPk4RMfLU3daWpb3Hbn3cIHasOI+Cmfvj5stdtv5QVr
A3QvX5b2CC1HcTAwsC0dzefP8dsOFUtWSrpU93hrR1adWUgUOCcNfLWQNER/gkiX
1l2DfJImP9OCH3EbtkwQpgflDykT2h1EvA1gackc1UErG4hYv54=
=hWpG
-----END PGP SIGNATURE-----

--ohpzp4d3rs6k2dsa--
