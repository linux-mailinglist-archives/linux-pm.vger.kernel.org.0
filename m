Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65624DE072
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJTUfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 16:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfJTUff (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 16:35:35 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E2121928;
        Sun, 20 Oct 2019 20:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571603735;
        bh=5b5wr87HoNjOB/IBjJpVV9X3WCNeB9MXMOprHKehRcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJlS6aOEMCm9SmwDrJdM1zeAOZZWqqf1L85dqBRrm1JPvV/G3pQDNI6gRJ3RUk4f1
         3dzeg0Bvf6g2ozge6UaC/9gvJ8AbkipeGo0nhb650161TRlo0RpFBk+/AehFDp0MPk
         nIl5AuVEGVubXSBaDnaydqispFVAji+j21JmXzwE=
Received: by earth.universe (Postfix, from userid 1000)
        id 7A22C3C0CA0; Sun, 20 Oct 2019 22:35:33 +0200 (CEST)
Date:   Sun, 20 Oct 2019 22:35:33 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 0/2] cpcap charger and battery fixes
Message-ID: <20191020203533.tjs6uy3wtxpgjp5v@earth.universe>
References: <20191016223005.9246-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kpnlt4him4x57frq"
Content-Disposition: inline
In-Reply-To: <20191016223005.9246-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kpnlt4him4x57frq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 16, 2019 at 03:30:03PM -0700, Tony Lindgren wrote:
> Hi,
>=20
> Here are few fixes for cpcap charger and battery. These can probably wait
> for v5.5 if preferred that way and can be applied separate from the 4.2V
> charger fix.
>=20
> Regards,
>=20
> Tony
>=20
> Changes since v2:
>=20
> - Drop the pointless test for latest->voltage >=3D 0 as noted by Pavel
>=20
> - Allow poweroff to trigger at 3.2V and lower as suggested by Pavel
>=20
> Changes since v1:
>=20
> - Sent the updated 4.2V voltage fix separately
>=20
> Tony Lindgren (2):
>   power: supply: cpcap-battery: Check voltage before orderly_poweroff
>   power: supply: cpcap-charger: Improve battery detection
>=20
>  drivers/power/supply/cpcap-battery.c | 8 +++++---
>  drivers/power/supply/cpcap-charger.c | 7 ++++---
>  2 files changed, 9 insertions(+), 6 deletions(-)

Thanks, queued.

-- Sebastian

--kpnlt4him4x57frq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sxRUACgkQ2O7X88g7
+prqfA//ZnYEZBCg73xyW/KmMfKpp5gC4gMdSyPMK5UDU4ca9G8Vi5rlb+Mq/Xyv
yPacv4ph7bik4rOHOKEKiXyjtHxZ6Qyh3SsebNZ4Gnbm5Ch6V8+XcqgIZp0O12gQ
aGCQhYJsRgL9aK62fiiSccptdjqy+vkKTcNekjdbmxNw4+aDCSB4/5MQ9q4J6jM3
RPm/58l3UWZRAh2OnEvuxMlpKxBjDVhhTQePPTfPsE0zi2PfkILMvikJzH97pzPY
U+0LGZg0utL3FaBLCq/OS7Zr2a8/9bO1t5H6DJK652/fmVHXhtMEZzcha0q3kp6h
MuapDTOMG+4515h0zwwKqWAoSn5GRGCebMC3KhaW9rK/8aMJk8rpUz9L2v+HaMdA
0Zr9PL+FUByIC9SYmZpZmHm7dIFUUWY1ln27fTaud20IuUP2B9baXOUAOP8xitqK
Lh2OjZ9ENMKrzKoHmBWjmJ5HnMUVRK9PMjku/VRsOG1wXoCsy+xY3oSDjlheNvBk
gxx28QZLoGFqCF1527UZucBMEmwVcuqBcjP+cV8V+Er/5yo56I2oSsBJDojWCFlv
8k2WUD0dIBsOtXm6XB5yGlBrYQ2Z6qdaYKawsDwKZlmAympWZvOG/IrQIa6wWd2x
0Oi35aK+I7g4nznlpdFPiUHmEnMYSSnBWpTtHEPS8Mzng+4b66c=
=oGxB
-----END PGP SIGNATURE-----

--kpnlt4him4x57frq--
