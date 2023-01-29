Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA1680324
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jan 2023 00:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjA2XsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Jan 2023 18:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA2XsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2023 18:48:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6293FC
        for <linux-pm@vger.kernel.org>; Sun, 29 Jan 2023 15:48:17 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57E63660086E;
        Sun, 29 Jan 2023 23:48:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675036096;
        bh=ReGUfVtIsO+fZNQq9gHKTSGJdZQ6xFBLbr6P3bGm69I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZBGuZQyNx33z5KsoxgvUVl96TEDl4VRx/e2TIBPsC5Ry3LQh80tZPHFefFfFT0uH
         ddM2at42YZCmoLbfT7wn5AJlstk5VYF7cy+jl0VID2l1alYe2i64trkNI29CUrrJua
         koiJUbUMYkG51Xa2pWfaUkUCAO5fJ0R7dcXsMIU4R8DRboVEfo01KD/vSw3WDHHvKa
         QdH3EcOBknHLAwxk5qsBmzhk70jBR4f0zOu1V5L2z82eQQ0fSOuF4L9bmRsPN2vr7R
         oPOhPIFlzizcSLVg8QIWXZlPYvU0N52tZey8qRjemEfAGgkRvuQcIDM2WJp1HCUIPq
         omrPq3QaB5anw==
Received: by mercury (Postfix, from userid 1000)
        id 2A2A01060A24; Mon, 30 Jan 2023 00:48:13 +0100 (CET)
Date:   Mon, 30 Jan 2023 00:48:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] power: supply: bq25890: Remaining dual-charger
 support patches
Message-ID: <20230129234813.gfebop4hh7p7g7js@mercury.elektranox.org>
References: <20230125105850.17935-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lijpkjb47oyuiwn7"
Content-Disposition: inline
In-Reply-To: <20230125105850.17935-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lijpkjb47oyuiwn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 25, 2023 at 11:58:48AM +0100, Hans de Goede wrote:
> Hi Sebastian, Marek,
>=20
> Most of my recent bq25890 series has been merged into:
> linux-power-supply.git/for-next except for these 2.
>=20
> AFAIK there are no outstanding review remarks wrt this 2 patches,
> so I'm resending them to avoid them falling through the cracks
> (or to restart / renew the discussion surrounding them if
> necessary).

Yes, I just lacked more review time. Both are merged now.

Thanks,

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
>=20
> Hans de Goede (2):
>   power: supply: bq25890: Add support for having a secondary charger IC
>   power: supply: bq25890: Add new linux,iinlim-percentage property
>=20
>  drivers/power/supply/bq25890_charger.c | 76 ++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.39.0
>=20

--lijpkjb47oyuiwn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPXBbwACgkQ2O7X88g7
+pqQdBAAjjuCKAD8UeHFyo3sy6kjcNdxlar9aba9d+zCsABpGVuMmSMCQk1QAX2h
3XRgPC48BHuzhYoo3DOisS2BFScLu78yT9t5EvH+p6Sa9ZI92NgoCLMSY0DezlBU
rbF8i5R35/DryYEW/LAdlo89DAtGIkgBEbB9g9upou7ETKllvcj/YBKKqkFVCzzT
EwLLxbvXLC/3kMZYc93GntPfLxHY+2coV1P+EDP7B0djO0ogwLqWPBxwHeo7mRPw
NZVDZjpb3W0/oOGFpz+a/x8Bbeblh+8V/2DQj4YkagA1yIeQTilghbdFaDqX7qHZ
9cz87RpmNhWn19GB512NFWPnOVnu+2Txk144taV0i1yi2zU7Scny2hqQhr4OiRvY
LjOKbJ7dN9ibJdC9PODNhCVtm95OiPDwO45qS/P5fhGym2KB8x2fDC7Lh/fhpg2V
3OyFaQwknrFtQSOeFddPMm4rp43LeeincznaLngzUe1XnQwCqhYolHvey8De5+BN
1yGZFkkh0GQ4SUZIf9e6WLX9XB7gb4rdvVABE+/IK+THl5U/Gc1dns7TIkyQB0VR
Mur3HrmwCgPqptNYP6arI20HdLnqdYBm2U8BSdyhbuLuFTtk2+qZ7i9+2Oz5tWQj
BxmVRwXk1nXUQ2OznyemP+AaQmT34WYECHfyfwBTy7qnwP9070M=
=qQ0/
-----END PGP SIGNATURE-----

--lijpkjb47oyuiwn7--
