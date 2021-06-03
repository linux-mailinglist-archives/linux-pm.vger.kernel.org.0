Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43CE39A629
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFCQsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 12:48:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51282 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCQsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 12:48:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 02ADE1F434B5
Received: by earth.universe (Postfix, from userid 1000)
        id 139813C0C95; Thu,  3 Jun 2021 18:46:41 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:46:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] power: ab8500: remove unused header
Message-ID: <20210603164641.wegkbkuyoaubhzq6@earth.universe>
References: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ok4y2okanwqenax"
Content-Disposition: inline
In-Reply-To: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4ok4y2okanwqenax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, both queued.

-- Sebastian

On Tue, Jun 01, 2021 at 03:35:59PM +0200, Krzysztof Kozlowski wrote:
> The ab8500.h header in linux/power is not referenced/included, so can be
> safely removed.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  include/linux/power/ab8500.h | 16 ----------------
>  1 file changed, 16 deletions(-)
>  delete mode 100644 include/linux/power/ab8500.h
>=20
> diff --git a/include/linux/power/ab8500.h b/include/linux/power/ab8500.h
> deleted file mode 100644
> index 51976b52f373..000000000000
> --- a/include/linux/power/ab8500.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) ST-Ericsson 2013
> - * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
> - */
> -
> -#ifndef PWR_AB8500_H
> -#define PWR_AB8500_H
> -
> -extern const struct abx500_res_to_temp ab8500_temp_tbl_a_thermistor[];
> -extern const int ab8500_temp_tbl_a_size;
> -
> -extern const struct abx500_res_to_temp ab8500_temp_tbl_b_thermistor[];
> -extern const int ab8500_temp_tbl_b_size;
> -
> -#endif /* PWR_AB8500_H */
> --=20
> 2.27.0
>=20

--4ok4y2okanwqenax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5B3AACgkQ2O7X88g7
+ppzDA/7BOvQJOI4AFA7I7r9DUU4K53pjXWi+JOsW+MadhaUssPILwDNi1Y4WcK7
eS5DSP+rq+mcZ04Dydk/NbWV3TFaz/cJ2R/KKDX91llpdZIRaULZbBoxokL6JHMu
A2/+ta0DkBxpQwj8xls9LOu2EvXjhdNVv9FxZcJUyyIa9/GVZtxvc8SYQKbSIU36
f/XU5fAzxh/uo4B3SkMefJertkl1zIE+miHatawkx8aeYq2hgHLnQqD6cRAurl9O
EF+947meY04tpBDdb5hasluXm9GlsSzRSbFujB2VCYausZH09YwKYQMgmeI7RilX
Dwiji06cWTKCKJFol6igcMJCsgNm0/ImapQCp3HtTydXArjSPr087JPdjqmiWWzh
cQwjw5SOPd35mDzQ8uj1Y3LzMl/pls0+I2E4YhvXb1xwv6v1QheZ8NQxOTnqx7Fw
cM0nFgVyIfzZbhBCIc+i879r7pBRxh7sveN8HKPuKJF19hGZS64iJIIFTeUx6RZM
E6HnNcuULtv9/MMin5l7XTpeSv2p5pSMl8Sw7pDEZaTSlREqEkbuLW9L/UgR22lV
AA2sU4BtwibLSpazVtnCDLfeNaye0dtMK7KnUjlJ2rnOAb8bbMhwSw4OQT8xn+54
n/h0Kzn15T2kjfC4uzMxVwILeowkYpp/Bbi2OeuBC6Si3C99Z8g=
=tW+Y
-----END PGP SIGNATURE-----

--4ok4y2okanwqenax--
