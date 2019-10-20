Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EDCDE076
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 22:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfJTUgI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 16:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfJTUgH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 16:36:07 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBB220640;
        Sun, 20 Oct 2019 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571603767;
        bh=ifCajNv4Ohgf7WSyNQAWLBIiQvg/bJhJ/UazM3U8rzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDJ2Y6CDL9Y9t69vLhoFkm2O8D1e01eN9P46Hyk94gOTdIn5m/EuXKg0Ru6aktPrE
         hKJUJTSx9dp1eGr3k4OGE8Q0peytV5WAJWBPScqWzfxbEsrwKq9/QzftiZxqjXH8HW
         75WOl7ItDEmODZk5lTwDPfvqh1nja3eDFPBfYJHg=
Received: by earth.universe (Postfix, from userid 1000)
        id 0CDBC3C0CA0; Sun, 20 Oct 2019 22:36:05 +0200 (CEST)
Date:   Sun, 20 Oct 2019 22:36:05 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/5] cpcap battery simplification and calibrate support
Message-ID: <20191020203605.gt5in2dvvtpgtafm@earth.universe>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d675tyaz4w6hwbuw"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--d675tyaz4w6hwbuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 09, 2019 at 02:06:16PM -0700, Tony Lindgren wrote:
> Hi,
>=20
> This set of changes simplifies the coulomb counter code for cpcap-battery.
> And the last patch in the series add support for coulomb counter calibrat=
ion
> on probe.
>=20
> Regards,
>=20
> Tony
>=20
> Tony Lindgren (5):
>   power: supply: cpcap-battery: Move coulomb counter units per lsb to
>     ddata
>   power: supply: cpcap-battery: Simplify coulomb counter calculation
>     with div_s64
>   power: supply: cpcap-battery: Simplify short term power average
>     calculation
>   power: supply: cpcap-battery: Read and save integrator register CCI
>   power: supply: cpcap-battery: Add basic coulomb counter calibrate
>     support
>=20
>  drivers/power/supply/cpcap-battery.c | 178 +++++++++++++++++++--------
>  1 file changed, 125 insertions(+), 53 deletions(-)

Thanks, queued.

-- Sebastian

--d675tyaz4w6hwbuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sxTQACgkQ2O7X88g7
+prG5w//eJ+MxklCTFUIwDNuQf/C9rQzoQ4sz0mri4m1Sptd9FJQ/wq4/cvIV0iA
/jYL/W7NDyXNvJCgIUFP+2VtfnTMCeuQfRuzdMI8Yq+Vj6QD84gCVxf8k6cRHF+Z
ynQ06U6I7d6968mAqEGUPr60NrN381X75L7ZWZJwD80FUapYsNGGkhxgUCZjORT8
4J/GxNNbyv1O4m2utSFFyjISJ1it3c53z3veEomnDj6utJT1n/txt7vZY+0nBN5q
Dcrj2LdDgUi4ZAJEKrnqj9fU2/oLOh9XlMEASiF/4GKOly5Nk9zjJFfLnH1BsxEZ
YZFX42bRJXF46lZ9mATZxyyhWCEQ4jmhij94Dh646G7PAlHMGBTSy4JBzVx/DvrJ
VHwTOE/m0fVXRCu/ZpzwQDMskgaYIreTTBWub0CP0oIX8bNgKzRFzNJHKU0pRF4E
hKJXmYoK0tSz4REICA8PN4QqFwdPz7jidtLmqmEVmO5+bJ2jZfWo7CkXoW9PQNSE
tU4PEcSYHpeuUNvTLa0N5KeS/4VWM9EOJfeiKOzXqv4hz1/aAAQgc1iKnVpDCLOS
zhW3oDpIFHq4BqEob8BYbFNwD2JmccLN9QENCT6jL5JkO30vO6BsvDDjCBodwsEX
WqFNYOBOv7vKnc4qC6/aVXkRc2EuX11ZLV+hl6XcA+cK5R/V3IA=
=O6Kq
-----END PGP SIGNATURE-----

--d675tyaz4w6hwbuw--
