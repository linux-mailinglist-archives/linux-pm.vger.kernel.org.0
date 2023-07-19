Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8690E75A0B6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 23:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGSVoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jul 2023 17:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSVoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2023 17:44:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D01FD7;
        Wed, 19 Jul 2023 14:44:15 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A5766600011;
        Wed, 19 Jul 2023 22:44:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689803053;
        bh=6VQ8lf+HrOctgWEaFNffFLBushL6K14eiELd11iJT+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMgtNT+OET8285KG/sp0BPNqspQzGRkXD3ECbLQfNyD/WYhbFwuU+mHmkVe9UcXpE
         Qh/IcMcy7mOo48A795xZa3Kp3hiCZQnpFzb+lcPnRdwMjVje2yTI9ZWVRCohCcwWW+
         CCYqxz7fUDuxQdIKH8DscEf774GBZYrbGpyYI4lcsjvisvhlHXQelBqQUkWCXiON/H
         mEe4G2I/QxfCi3erRn6V22xBU+glbt4y+X4ZqbjLQbzUXnLI6dhD7Kn5zVIjpkFPnw
         baG107Z4TtqJOU8pTPkqSLBYe8x4drlk/Eu3BEzdqgQvsCcGUufpQ62fmhx24n11m1
         LtGfsIjFhhUiw==
Received: by mercury (Postfix, from userid 1000)
        id 274EE1061639; Wed, 19 Jul 2023 23:44:10 +0200 (CEST)
Date:   Wed, 19 Jul 2023 23:44:10 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Set typing and props
Message-ID: <20230719214410.f4o6lqnsle73xtk4@mercury.elektranox.org>
References: <20230613213150.908462-1-linus.walleij@linaro.org>
 <CACRpkdbp0STSKxBG6qgpqu=xg0+-zAdK2se11oKhjD9MGQZ1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ufv35idcc564jfnh"
Content-Disposition: inline
In-Reply-To: <CACRpkdbp0STSKxBG6qgpqu=xg0+-zAdK2se11oKhjD9MGQZ1NA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ufv35idcc564jfnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, Jul 16, 2023 at 10:59:42PM +0200, Linus Walleij wrote:
> could you apply this patch please?
>=20
> It's a regression.

Sorry for the delay; it's merged to my fixes branch now.

Greetings,

-- Sebastian

--ufv35idcc564jfnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4WSkACgkQ2O7X88g7
+pqfWg/9G+eovlj68LYeO2I0SoG7Q37gwsBsfVJB8aCkedhtGEmWd9uE3NYKhnSB
GIqjyAgxmW7P9StfAFsMjdnTwsZK0FLz8P9arnAkfEysNIrVCEuJlsB+554Bba8c
bSyfL2ra9XJQu4HHP/oXe0o6lMWshLh7h+ye1DibgJriG8tt1X1vAiyknz0Ef2rS
mos5Lhd8xb8Swk2d7LMz+Aymviaxj5HFUUcXlVLIYE7QTNNv/TJBgnQU7zmhcceV
HRtks93I0tBQrOwgF49OCzbY6tTh1OQNcsF7rYXVy+3K1uw3jysujUsGL0sR/IK6
eXly11gORYsk65vJTsxESGcNK9GAq/4er5tO5SZK+Kj+AmBKHpp+J//arGplqo/2
sBX11hRnqjgkGRg6Uxk3D0UvEJ2ML8mll5QV9mhMe0Nd+VdkUsvm+fW/KnLxNQFA
GzskQPvsFPUP9RKtp776cCG0YTOFh7PV2TaTLpkrUZluGWyuZQBRkcpbFtxwpOoM
m7oB2PQMdCvxl1Bs2emQx2poVF1q9PqgXtobrnxYhpt1Gb7ebq3Mt+iQf7iTXx8C
d9g9tMheV9f0fz9Q4Zn/vp5uiM+bxpTa1Zzb25Ghhz/pwAQKvUucbS3H5bfl0yfC
dKt6Y/3rTIrXyu+nMF3O+2g54cS2M7RzqEx0rHPnFgKmNWNTGi0=
=r3So
-----END PGP SIGNATURE-----

--ufv35idcc564jfnh--
