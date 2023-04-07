Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC76DB683
	for <lists+linux-pm@lfdr.de>; Sat,  8 Apr 2023 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDGWgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 18:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDGWge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 18:36:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C295CA39
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 15:36:33 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1213666031D5;
        Fri,  7 Apr 2023 23:36:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680906992;
        bh=TOSfC5iqX1hP+7k4vzaoqsZU+XWCjjCVgx8w2Vk+KZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhYbmynsJH18iXuRuwbLx+FHeY/uiM5rXlmmGrmSb7zk35GHc1ZK3v7CVZ396+veP
         fl9K7fBavxDDW+YYlCqTzUgL3FmgBPMyv4nuou0p8t0mmzSqMLsQpj30c6LNe6IVeo
         Uv2qqzzJbtJh8iW2iP7INV/wUxX8n3mgQE0LbxJObMo2Ks8zfkxRW4efQyfkjh4cO9
         NELzcah76zATTXfzeuGugZnPBqmb6EgqGzYsstR+V4jZqesxEri1fFwNMTXhvCDlT1
         ZNsH6pKGcBt6VjAAdifO2ip0Si/5BLQRA0A/7cf7SaCgaezj+i4JwnHrAv2B5jajyU
         s8pluspPcH6yw==
Received: by mercury (Postfix, from userid 1000)
        id DAABB1062734; Sat,  8 Apr 2023 00:36:29 +0200 (CEST)
Date:   Sat, 8 Apr 2023 00:36:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, maccraft123mc@gmail.com, lee@kernel.org,
        jiapeng.chong@linux.alibaba.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/2] Fixes for rk817_charger driver
Message-ID: <20230407223629.lc3byhaeyrbi64re@mercury.elektranox.org>
References: <20230407161827.127473-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxsfezd5sathlmi7"
Content-Disposition: inline
In-Reply-To: <20230407161827.127473-1-macroalpha82@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sxsfezd5sathlmi7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 07, 2023 at 11:18:25AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> After using the driver for a few months I noticed a few issues that
> this patch series seeks to address. Namely, there appears to be some
> left over code that was used for debugging during development that is
> no longer needed. Additionally, when the state of charge drops to 0
> there is an issue with reading the value on boot because the columb
> counter appears to hold a signed value.
>=20
> With these fixes in place the battery driver appears to operate better
> and without the odd bug of an unsigned integer overflow on the columb
> counter.
>=20
> Chris Morgan (2):
>   power: supply: Remove unneeded code in rk817_charger
>   power: supply: Fix low SOC bugs in rk817 driver
>=20
>  drivers/power/supply/rk817_charger.c | 48 ++++++++++++++++------------
>  1 file changed, 28 insertions(+), 20 deletions(-)

Thanks, queued.

-- Sebastian

--sxsfezd5sathlmi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQwmuQACgkQ2O7X88g7
+ppcWA/0Duqw33fu1LJiAPhnjmwXuZin+BcasrBdx9/nKhrxU2u+CiOK44p1nbOI
bOltb3Ym1nokdPze98bVHVWoOsDzN4F/CjyGYpxv/LM4RJ+R10QcRdVn69P7KlKL
Qw2gkHugykTHmJFREeitn1UxXV030QArjZUecW3M1UK0fPw4pmuJM+l7fXSMxmHq
MK76tctBbBtgmNI+if23t+3KuauVyDjBIE/hNwTkMCjYweYWI4aCCFvFs9/LxihI
vMD1pKe4g6ejCacCd5b9PprJ0iKcCht33dRvQlP5se79YarUMil2FcLTNs66Y51h
QfdTusZk8qTZA7oEndhk70TQIQtTZJYH6qx0n/AEzB8JLBN05pgBr3pIHwwfWkEd
LEB9bDdBLRkUMq7arEpmgETygfn63VvFo2IhtwyizMuf/zSy4Y+luBTowl4dekcp
oYcd/YdAbPd3r9Aa2lKumVxTqDCHpqe0k1MULVrlWkuZ10Qt/8L87g2PAk21itNf
OXCCIRYedw7bAVxeHj/LKAGnNDNZ/yRa7AmaVhhNxmI85VdiUU00maBVVy/xLSer
zJNfVwKc3WjoKtW1hdwbiB6XHnXQU3eqKKsZzPM4lpVYtnQ4QYk17mrx8NXU5Gj4
LlNo6rkcZ9jZFjG4XxHqX2WJarnnx/L/C29xUCufSg8xgJYcig==
=rMZ7
-----END PGP SIGNATURE-----

--sxsfezd5sathlmi7--
