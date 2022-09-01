Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9B5AA163
	for <lists+linux-pm@lfdr.de>; Thu,  1 Sep 2022 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiIAVOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Sep 2022 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiIAVOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2022 17:14:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80C8E9B8;
        Thu,  1 Sep 2022 14:14:39 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A49C66601EAA;
        Thu,  1 Sep 2022 22:14:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662066877;
        bh=f4kzP+Lz3mllCLxdxO/7lY2KLrAYkHl5av9d6yYvEr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCvs5fs/pyf+HU2Qe3yyki+y/59wmBMPsjt3TjO1uoUGF+3zqtsbeVsJDatT9Ut4m
         rHHT9dlvEWGmy//YNERnNmnYr8MAKBItOOL7X0Q9t9v8JLVqUI7tuBkR27Qdo1BYAx
         FjuUtZRiz8jlp/arjFgIeBDn0OaFjOtYQ9xyXGIjNzd3NJeqDiFkPFWOSu7PXWVnuL
         IaMnYbKFt+RaF8ydRT73CxGaTeriGQAl8NgTE9LC5YnGUjeLtxkZfkMgWDUx35dprB
         NEBe1+f9YPFvsub06vcQ+qk3tf4ojv+bR8LBkcanCGgqRY49R1NCUneT2do8Ekryz9
         XsarkATff268w==
Received: by mercury (Postfix, from userid 1000)
        id EE70910606F6; Thu,  1 Sep 2022 23:14:34 +0200 (CEST)
Date:   Thu, 1 Sep 2022 23:14:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arvid Norlander <lkml@vorpal.se>
Cc:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH 3/3] docs: ABI: charge_control_end_threshold may not
 support all values
Message-ID: <20220901211434.pamkdwbfs5hmmdl6@mercury.elektranox.org>
References: <20220828192920.805253-1-lkml@vorpal.se>
 <20220828192920.805253-4-lkml@vorpal.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udveirm4sevnlflu"
Content-Disposition: inline
In-Reply-To: <20220828192920.805253-4-lkml@vorpal.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--udveirm4sevnlflu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 28, 2022 at 09:29:20PM +0200, Arvid Norlander wrote:
> Some laptops (for example Toshiba Satellite Z830) only supports some fixed
> values. Allow for this and document the expected behaviour in such cases.
>=20
> Wording suggested by Hans de Goede.
>=20
> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index a9ce63cfbe87..e434fc523291 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -364,7 +364,10 @@ Date:		April 2019
>  Contact:	linux-pm@vger.kernel.org
>  Description:
>  		Represents a battery percentage level, above which charging will
> -		stop.
> +		stop. Not all hardware is capable of setting this to an arbitrary
> +		percentage. Drivers will round written values to the nearest
> +		supported value. Reading back the value will show the actual
> +		threshold set by the driver.
> =20
>  		Access: Read, Write
> =20
> --=20
> 2.37.2
>=20

--udveirm4sevnlflu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMRILYACgkQ2O7X88g7
+poquQ//RsRs5DR0UrA6M53uK7DSy4plau3nleB7AT1xvNAcfGNKOVTRxrxFNoav
bJgMpOfDfud2AlwY/2ck4f4AQdJmAYm+xWoYgoN6lRpnMnb9RKKEuj9SSNxhXf08
etwDxz5SVC3w2AWZV4CIQR9iEwiDkbIuBO+MSh+QOJx81RZGeUijPDXdkHgObhOm
rjjLjxEYwfIHdXhdWG/7lh8+QCFEk0O3EIiTU7oOespDgmVtc3Tb3iyc/Ffc4hya
GYKMNQYRuU3V/DPIb3k8I3A2K6tTJPYr3zDpwoCAnmA/ofKKH7iDQwJgZfWP9ces
gA5HRMh+GNagloioEr0ktlo7n5Y5Wvnh8UDhlgAYmQWXfExC2pwQ13jlzTnCKnCI
O0yoOuu8g2nYhDLPDEGP3iHqgTFaeE8XG3i8JzF1wroIQfe1AbpcQ2KtuEFLxgAB
DCnhuOp5OBUZEEzRnkhjpBk0yrMlAIreeC40vA8xJ08itd00LqfeOHMSjMZtXUci
uXI9QbcExn2C611zbXkGHUjGpCFmwLzirTQAOdOnnZrNfNVjZvw78TA0YZ+ZqSl8
ts7g792LZzCJi5TNfBJ9u8ndkLs+Uku3Idp5UQGl5YaiDuzzv/1P/CAlrAYgaDp4
u6iG4A3Id/zV9QXZFK6o6uDr8bz7nzhaq3AWvUG6IBE+tdUPQsY=
=Ufi8
-----END PGP SIGNATURE-----

--udveirm4sevnlflu--
