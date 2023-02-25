Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B796A2575
	for <lists+linux-pm@lfdr.de>; Sat, 25 Feb 2023 01:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBYAVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Feb 2023 19:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBYAVt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Feb 2023 19:21:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D996C1B9
        for <linux-pm@vger.kernel.org>; Fri, 24 Feb 2023 16:21:48 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19EFC6602FC5;
        Sat, 25 Feb 2023 00:21:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677284507;
        bh=GXjAMNuegiIuIHXr7dx59lp5L0Mu2/8FY7O5qIqLfbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0MqmZefXxXj9MxC0Im7jvfQVD5YjJ3mJ0BM+o4TKmKsTjeefhV072xx0gsmDtsy3
         LWfI6wvio+PODGwp0ULKb5Jn/KrnysD5IJSRHb0b6o+6y4ZhsVbWJ2KGo0fNNbJ6Ty
         r6OVllcLE95DTWMr+X3jPf/dI/u9AVm4IzOOtHUyFpmk6NtrjFSXAsp40oKcdgsQo0
         idNwTrpqiNvVy2PK9CS7iDNQ6T+KDVRGgWAhPDwyuJLQ3xp7BHmWezST062Ml0nRHp
         wnp5ttCZrlzbjSpNHX+gWf2J2gyT/VOsqf0YrVHFIN6BQxl27m6Z92Z8TuUJyGcCc8
         WqOpG/kbvBy+g==
Received: by mercury (Postfix, from userid 1000)
        id 7B67C1060924; Sat, 25 Feb 2023 01:21:44 +0100 (CET)
Date:   Sat, 25 Feb 2023 01:21:44 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-pm@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] ABI: testing: sysfs-class-power: Document absence of
 "present" property
Message-ID: <20230225002144.xymcucgpdlevu4a5@mercury.elektranox.org>
References: <20230220131018.1708991-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nlhbp6ms2jixeto"
Content-Disposition: inline
In-Reply-To: <20230220131018.1708991-1-hadess@hadess.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3nlhbp6ms2jixeto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 20, 2023 at 02:10:18PM +0100, Bastien Nocera wrote:
> Document how the absence of the "present" property in the sysfs
> power_supply class should be handled.
>=20
> Link: https://gitlab.freedesktop.org/upower/upower/-/merge_requests/173
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---

Thanks, queued for v6.3.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index e434fc523291..7c81f0a25a48 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -437,7 +437,8 @@ What:		/sys/class/power_supply/<supply_name>/present
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
>  Description:
> -		Reports whether a battery is present or not in the system.
> +		Reports whether a battery is present or not in the system. If the
> +		property does not exist, the battery is considered to be present.
> =20
>  		Access: Read
> =20
> --=20
> 2.39.1
>=20

--3nlhbp6ms2jixeto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmP5VJgACgkQ2O7X88g7
+ppGPA/9E5y7CGCoTQ4q/mYjHCsh/Pv1RvW+YBWOKoRcdkbliXLeXNWGKXT6IjcB
kR8j3dN0P8nkTXBAMyCDbKpbYJ+GmO30/Wd4JrR89Kw1KkezOW1UA9redv3Zwk4F
RuZ1P4yPSWzBCDJc+6R3+m9DCLhPVfibb7yikj+6R03hKe1oqqnOcEUg3bVYvsQu
l8Ohshf1vNmDHM7y9jAojcWutRgM/iLtC6DA/auIQq/EwgZtKZoMgZkQq3RxukqV
ycPDrtenfPKg6KmgCCR2EOp55N9pgSUABsCTeaXCPgYvU6Tf8i7crCcihdiBVeVw
JtFhqiSNM+ICOBbsIotm14dUrDiIsAQuZOS4/hcBx3jWt9WrWgccgo/Zzv3GxZPc
CLd2S9H6sji4vrKUiXh5qb5vEyFzCbc/rSRFZc6mh/LpV/UKvVQkx5IskO1gOveX
LgVgFwcAbWajiwQ32ln4SLEAs/3FIrKrH2T++d8khRFEagga7PKHkoqXthLjUJsB
ylsRS+VqBggZ3spCZG8OQirj6Gnvgs0dGfH0/CRCHSpf4ve3EPbkcy6EtyXdqf57
YSDbLsmgfy7rxwVCzbuTARbLkK7Qug89jX9zVgn3G75kQPHh2Fl4vTKbY297YG+C
NaYguSRtE0eZDAuOHKZ8B6ky/lBZWUOfHIYeAzeUxjmmhhGLXRc=
=+ARp
-----END PGP SIGNATURE-----

--3nlhbp6ms2jixeto--
