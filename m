Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0D577214
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiGPW6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPW6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 18:58:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E819C13
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 15:58:29 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BCA66601656;
        Sat, 16 Jul 2022 23:58:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658012308;
        bh=IoDExAjtqmzBLR5j9Oo4pjNz8GQs25jivQP0UEm47V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQ0qL+nV1TTfORVVGb7CO3ut0UpwwncN91AIPN5KRdqDnz5DE4WeCiy32yJqy4pLO
         Cq2bXM5DqKZNfvGsUxGFsVacC3iygyHNW2x9uwMCrwppAtCmE9ZsnSr0lOyfTEuKQu
         nDlTo1cBsJxPXzkBmnM8qS2iJBGRnGYaZm+DeHeWGEukr6BdmbmA9CdONKkZZ6Tsoi
         cUrJZRaq2u8kSJR0LQddh5wrOWq1+0PwEeoLcK/ErBE/X6CaJse3+qUoPYijHwifke
         H+UHL5X+JZP1z6uFdkay3AIBZ76iuNuApmE/3J3R1xIbhlDYgGLSWg5S1K90MWu2vZ
         FBLECTuJESgww==
Received: by mercury (Postfix, from userid 1000)
        id 4C8981060428; Sun, 17 Jul 2022 00:58:26 +0200 (CEST)
Date:   Sun, 17 Jul 2022 00:58:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Add MAINTAINERS entry
Message-ID: <20220716225826.yrpeor32myiqus43@mercury.elektranox.org>
References: <20220623143157.1842024-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xextwfz5t72xqe2q"
Content-Disposition: inline
In-Reply-To: <20220623143157.1842024-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xextwfz5t72xqe2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 23, 2022 at 04:31:57PM +0200, Linus Walleij wrote:
> I am maintaining these drivers so add patterns to MAINTAINERS
> for them.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..ffafa78732c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -260,6 +260,11 @@ W:	http://www.adaptec.com/
>  F:	Documentation/scsi/aacraid.rst
>  F:	drivers/scsi/aacraid/
> =20
> +AB8500 BATTERY AND CHARGER DRIVERS
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +F:	Documentation/devicetree/bindings/power/supply/*ab8500*
> +F:	drivers/power/supply/*ab8500*
> +
>  ABI/API
>  L:	linux-api@vger.kernel.org
>  F:	include/linux/syscalls.h
> --=20
> 2.36.1
>=20

--xextwfz5t72xqe2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTQpEACgkQ2O7X88g7
+ppvzxAAlzyKS0AQ2FAglm9ccAklXPzWKg1S89jrNQ3RF9sU1QpMdiJm9zs/meNI
2xjd+lImGsrcYh9HM+bzfs/60N6gx7NwQrYsIIMd3F6grXlzA92p0F9cSvJ/a7Iw
hgf+G9QcfLPVxfAKodIylYw7ZfWtaygfsIoR+5mp2ibiqOpH+NU8WCOfKhUXruhI
cwULRaD2o+G07s3HuDLb88tpil1UAKZIEo0qcdgrPwrm0WCKL4tphUuK1fKixZXQ
XhcOhfxVqrh+MFmdDZslxa5SHC/qWyQWBaOSw4wCU3EQzThC70NQ/zwkL+rfcRKB
NlI0si82wRz4Du8MwD1tZ0PBIUEMAFxi2KyQXmqdmuEmvIpyZSpZwbRXPbvR315R
Fikwl3fBTdMw+BWKXwKO6YGdOpe7viYmF81zFu9kIOBn47amcSK7/09HEXzj4JnO
1yayHO/EANd367ICf4h+fgV1RFYzk/MAK02wY0mt7VOLLDtp8iCdqBU4BKsLjG1u
OCY4+FqANyCC/eFYBdXoyMkcK3W3JK6riI6rKFb3PvSBvtVhLMDr0+8DtIDp3iuX
FAXeZNw6eKdlakS1TF9jZZsz8uIkqc0FtgEMWk+g4wG/uPUJrqJWuA2BZB/Mn4eR
hgUEJd5yLaNJpoa4YNRauapuJzoz2nMpTE8T8WcP5U0ota0KosY=
=afAu
-----END PGP SIGNATURE-----

--xextwfz5t72xqe2q--
