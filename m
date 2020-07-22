Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE922988C
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgGVMug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 08:50:36 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54122 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbgGVMuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2020 08:50:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0A5721C0BD8; Wed, 22 Jul 2020 14:50:33 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:50:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Andreas Herrmann <herrmann.der.user@googlemail.com>,
        Dominik Brodowski <linux@brodo.de>,
        Paul Devriendt <paul.devriendt@amd.com>,
        Mark Langsdorf <mark.langsdorf@amd.com>
Subject: Re: [PATCH v2 10/13] cpufreq: powernow-k8: Mark 'hi' and 'lo' dummy
 variables as __always_unused
Message-ID: <20200722125032.25hui2f5bp7ydkp2@duo.ucw.cz>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-11-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l3djg72ps5umgd4c"
Content-Disposition: inline
In-Reply-To: <20200715082634.3024816-11-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--l3djg72ps5umgd4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-07-15 09:26:31, Lee Jones wrote:
> if we fail to use a variable, even a dummy ones, then the compiler
> complains that it is set but not used.  We know this is fine, so we
> set them as __always_unused here to let the compiler know.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/cpufreq/powernow-k8.c: In function =E2=80=98pending_bit_stuck=E2=
=80=99:
>  drivers/cpufreq/powernow-k8.c:89:10: warning: variable =E2=80=98hi=E2=80=
=99 set but not used [-Wunused-but-set-variable]
>  89 | u32 lo, hi;
>  | ^~
>  drivers/cpufreq/powernow-k8.c: In function =E2=80=98core_voltage_pre_tra=
nsition=E2=80=99:
>  drivers/cpufreq/powernow-k8.c:285:14: warning: variable =E2=80=98lo=E2=
=80=99 set but not used [-Wunused-but-set-variable]
>  285 | u32 maxvid, lo, rvomult =3D 1;
>  | ^~
>=20
> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> Cc: Dominik Brodowski <linux@brodo.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--l3djg72ps5umgd4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxg2GAAKCRAw5/Bqldv6
8r3jAKCAiOohMGojGKtPXWetfecCZlnSYQCfYAbGyyj7xOzM/bU3TGEFCnoEpyE=
=J9cR
-----END PGP SIGNATURE-----

--l3djg72ps5umgd4c--
