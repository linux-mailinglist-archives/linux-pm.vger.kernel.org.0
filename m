Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10D59EACF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiHWSTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiHWSTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 14:19:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CCD63FB;
        Tue, 23 Aug 2022 09:35:44 -0700 (PDT)
Received: from mercury (dyndsl-091-096-061-143.ewe-ip-backbone.de [91.96.61.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E72116601E65;
        Tue, 23 Aug 2022 17:35:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661272543;
        bh=I6/l5FGc7ng1XkPNikT1+GnIIzKiHFAjYhBWZniQqKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTvZeaO67T89sCDY/LfxjlPyaxUmC5spbMAWMBgrLvVvGqNwBg/v9UwAtxSt/FGyU
         T9KsVGgM48VVpgrt9HYfphE+25n7pWC9FTxSqt5YrVwFTGpz5vwmJCyn4Kyw0Fkm+o
         Mp+bbLWjcncgLGTEC32GSjaW7pROWNSMs0pYzwcUeHmiyR2/QpbfmHFuOOYuOzM6Nq
         2J0E/SUzCR1P7/ueMhZ1aSyNYV+0wpgQ9YvpDyyDddCVOlONnx213wxA5NLvx4Flpo
         OQMbWwHC6PEo4slCYRDf76Bhya7uwTXHEt0D5h1pV2ezcYQ9jPV59c2pQXl1vDvKeS
         Y02efsHVpXBZw==
Received: by mercury (Postfix, from userid 1000)
        id 9688210607D1; Tue, 23 Aug 2022 18:35:40 +0200 (CEST)
Date:   Tue, 23 Aug 2022 18:35:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v8 3/4] power: supply: Add charger driver for Rockchip
 RK817
Message-ID: <20220823163540.dg2z7fngaqklejvx@mercury.elektranox.org>
References: <20220808173809.11320-1-macroalpha82@gmail.com>
 <20220808173809.11320-4-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k5vvuauyyxuzzv7f"
Content-Disposition: inline
In-Reply-To: <20220808173809.11320-4-macroalpha82@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--k5vvuauyyxuzzv7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 08, 2022 at 12:38:08PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add support for the Rockchip rk817 battery charger integrated into the
> rk817 PMIC.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---

Looks mostly good. Just three things:

> [...]
> --- /dev/null
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -0,0 +1,1151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Charger Driver for Rockchip rk817
> + *
> + * Copyright (c) 2021

The Copyright line is incomplete.

> + *
> + * Authors: Maya Matuszczyk <maccraft123mc@gmail.com>
> + *	    Chris Morgan <macromorgan@hotmail.com>
> + */
> +
> +#include <linux/mfd/rk808.h>
> +#include <linux/irq.h>
> +#include <linux/of_gpio.h>
> [...]

Why are you including of_gpio.h? You are not using any.

> +	INIT_DELAYED_WORK(&charger->work, rk817_charging_monitor);
> +	/* Get and populate the first set of values. */
> +	schedule_delayed_work(&charger->work, 0);
> [...]

what happens with the delayed work when you remove the driver?
Check for devm_delayed_work_autocancel().


-- Sebastian

--k5vvuauyyxuzzv7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMFAdEACgkQ2O7X88g7
+ppU0A//Yz5BcYSiP+zyEzc3W5m3O+PVqEUTr1SyNqEARs3Su6fNpDlNiXQonkya
U4z59eDVQxQDPb3Am/KQucBJFy7stxk8yO5iRWhhth58Jw6RiEfaW/fwnRSQLjrY
6o/vjCM3eqB0mHjdzEbA5pLHpBCWQuA2iBM8V+FjB7tMUH72xqn8ttrXRXc9NgFJ
q2BVbhlfolxl2CkukIK1idKPOm0OyW48MIVygKkZL8BOXpjrryt9WeFDpmoqriLL
noo4DBOXvBAE1qnh58qGAp1YANsHO9zK6DB7OydvIst2LDpn0nC94BPvSmDPr94R
/GiRcK3FnNUcuYGg9uSy82EufO9p6zSKL37EN2Ly3DLVzyQ3r8f7KRUQGiksfx04
bd+Z2oELZ2X9lLxnPE0Ti0YI7pElfnkB+IMhQi2mUIUSeFbhvmyyhbfrbLAIatII
tfqYCLTJVHSl3iogbhOgXigROAs5qO5hBz/FESIxNDdlwTIjAsIVjzI0mfHN6uWf
GsmA9xm05An72dT1QGQPR4ebZnKS0oCABwKfSYWtLruJqpvVM3S/jEF3tcgEogoJ
QvNT4ExsjxI7tdjfu5P9f3tVKfAcl/p6gVtMJvn/rC4XeNAtarYI8Z1KXoy02Aq5
iU8psfucnjtIDrwssc+d+hcF+v41sKS/QPA0zlVt6fp3FXfTPVM=
=eosH
-----END PGP SIGNATURE-----

--k5vvuauyyxuzzv7f--
