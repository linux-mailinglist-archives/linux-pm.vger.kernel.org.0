Return-Path: <linux-pm+bounces-1000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7D80F556
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEBC1F214D8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2627E780;
	Tue, 12 Dec 2023 18:17:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44210A1;
	Tue, 12 Dec 2023 10:17:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538B0FEC;
	Tue, 12 Dec 2023 10:17:46 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36D963F762;
	Tue, 12 Dec 2023 10:16:58 -0800 (PST)
Date: Tue, 12 Dec 2023 18:16:55 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-clk@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 1/5] PM / devfreq: sun8i-a33-mbus: Simplify usage of
 clk_rate_exclusive_get()
Message-ID: <20231212181655.1a0d5971@donnerap.manchester.arm.com>
In-Reply-To: <5ef585a3d7bee42bac5be0e40efcfbc6e75adfff.1702400947.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>
	<5ef585a3d7bee42bac5be0e40efcfbc6e75adfff.1702400947.git.u.kleine-koenig@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 18:26:38 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> clk_rate_exclusive_get() returns 0 unconditionally. So remove error
> handling. This prepares making clk_rate_exclusive_get() return void.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks alright to me:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/devfreq/sun8i-a33-mbus.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
-mbus.c
> index 13d32213139f..bbc577556944 100644
> --- a/drivers/devfreq/sun8i-a33-mbus.c
> +++ b/drivers/devfreq/sun8i-a33-mbus.c
> @@ -381,18 +381,10 @@ static int sun8i_a33_mbus_probe(struct platform_dev=
ice *pdev)
>  				     "failed to enable bus clock\n");
> =20
>  	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
> -	ret =3D clk_rate_exclusive_get(priv->clk_dram);
> -	if (ret) {
> -		err =3D "failed to lock dram clock rate\n";
> -		goto err_disable_bus;
> -	}
> +	clk_rate_exclusive_get(priv->clk_dram);
> =20
>  	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
> -	ret =3D clk_rate_exclusive_get(priv->clk_mbus);
> -	if (ret) {
> -		err =3D "failed to lock mbus clock rate\n";
> -		goto err_unlock_dram;
> -	}
> +	clk_rate_exclusive_get(priv->clk_mbus);
> =20
>  	priv->gov_data.upthreshold	=3D 10;
>  	priv->gov_data.downdifferential	=3D  5;
> @@ -450,9 +442,7 @@ static int sun8i_a33_mbus_probe(struct platform_devic=
e *pdev)
>  	dev_pm_opp_remove_all_dynamic(dev);
>  err_unlock_mbus:
>  	clk_rate_exclusive_put(priv->clk_mbus);
> -err_unlock_dram:
>  	clk_rate_exclusive_put(priv->clk_dram);
> -err_disable_bus:
>  	clk_disable_unprepare(priv->clk_bus);
> =20
>  	return dev_err_probe(dev, ret, err);


