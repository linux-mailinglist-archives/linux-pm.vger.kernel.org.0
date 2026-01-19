Return-Path: <linux-pm+bounces-41078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FFD3A47E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 11:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DACE30700DA
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAA3563F4;
	Mon, 19 Jan 2026 10:08:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A866357737
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817303; cv=none; b=pUahZRli4DGDX7ICrRrEU+kjqXYL+WkVnhG1AdPNGqGQABpEoReGVNe8nXZXCEP5om6bUAJ+a4PcjJ0Wrj+tpAoGxGfgOSypl5vKQVXBvyfXFYsQC61R2vgEmy91r5njATaWQukpditP4lHTIGaDZCppFO/Q6/N+EAYGiy7YBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817303; c=relaxed/simple;
	bh=2GX6IhXJ6v5G7zHAvAsR7o5C+ciHLuEcijuIEraeN8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atwdJD6DB4tDNXx989bzrYrm+eb8Vn66GCwMir40oEmn7vng9UxYchnhoTs/odOXktNictupoquPnmJzZpi9QzFIVSMlyZhRo+7iNSu0fyozDzWX/4SbDIfnd/qZXmp/OuJRhRlu4Tsdh7I7dO7cy5r/NrSwft4OgrHIdQW27f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1vhmB0-0001Mu-T6; Mon, 19 Jan 2026 11:08:02 +0100
Message-ID: <f31eef1eb99542e99486f3df84c90c304b7f2c9c.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] Fix the imx8mm gpu hang due to adb400 reset wrongly
From: Lucas Stach <l.stach@pengutronix.de>
To: Jacky Bai <ping.bai@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 19 Jan 2026 11:08:01 +0100
In-Reply-To: <20260119-imx8mm_gpu_power_domain-v1-1-34d81c766916@nxp.com>
References: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
	 <20260119-imx8mm_gpu_power_domain-v1-1-34d81c766916@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Am Montag, dem 19.01.2026 um 16:53 +0800 schrieb Jacky Bai:
> Due to the HW limitation on i.MX8MM, the gpumix, gpu2d and
> gpu3d share the same reset domain, that means when gpu2d/3d
> go through the power off/on cycle, the gpu2d/3d reset will
> also reset the gpumix domain, The GPUMIX ADB400 port also be
> reset. But the ADB400 must be put into power down before reset
> it.
>=20
> currently, gpumix, gpu2d/3d power domain use the pm runtime_pm
> to handle these power domain dependency, but in some corner case,
> the gpumix power off will be skipped, then the ADB400 port will
> be in active while gpu2d/3d doing the reset. The GPUMIX the ADB400
> port will be reset wrongly, so lead to unpredictable bus behavior.
>=20
> To simplify these domain on/off order & dependency, refine the
> code to directly handle GPUMIX domain on/off along with the
> gpu2d/3d power on/off flow.
>=20
I don't like that we are adding quite a bit of code to this driver just
to work around a issue on a single domain on a single SoC.

Wouldn't it be much easier and produce much the same results if we just
move the ADB hsk bits from the gpumix to the gpu domain? This would
mean we don't trigger the handshake when the gpumix domain is powered
up/down, but I guess that should be fine.

Regards,
Lucas

> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  drivers/pmdomain/imx/gpcv2.c | 100 ++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 84 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index b7cea89140ee8923f32486eab953c0e1a36bf06d..3a13aa7f1888863048106c243=
2eec80c7364c462 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -53,8 +53,7 @@
>  #define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
>  #define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
>  #define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
> -#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
> -#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
> +#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(9) | BIT(11))
>  #define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
>  #define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
>  #define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
> @@ -292,6 +291,13 @@ struct imx_pgc_domain {
>  		u32 hskack;
>  	} bits;
> =20
> +	const struct {
> +		u32 pxx;
> +		u32 hskreq;
> +		u32 hskack;
> +		unsigned long pgc;
> +	} parent_bits;
> +
>  	const int voltage;
>  	const bool keep_clocks;
>  	struct device *dev;
> @@ -335,6 +341,30 @@ static int imx_pgc_power_up(struct generic_pm_domain=
 *genpd)
>  		}
>  	}
> =20
> +	/* Need to do special handling for parent domain like GPUMIX on i.MX8MM=
 */
> +	if (domain->parent_bits.pxx) {
> +			/* request the domain to power up */
> +		regmap_update_bits(domain->regmap, domain->regs->pup,
> +				   domain->parent_bits.pxx, domain->parent_bits.pxx);
> +		/*
> +		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +		 * for PUP_REQ/PDN_REQ bit to be cleared
> +		 */
> +		ret =3D regmap_read_poll_timeout(domain->regmap,
> +					       domain->regs->pup, reg_val,
> +					       !(reg_val & domain->parent_bits.pxx),
> +					       0, USEC_PER_MSEC);
> +		if (ret)
> +			dev_err(domain->dev, "failed to command parent PGC\n");
> +
> +		/* disable power control */
> +		for_each_set_bit(pgc, &domain->parent_bits.pgc, 32) {
> +			regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(pgc),
> +					  GPC_PGC_CTRL_PCR);
> +		}
> +
> +	}
> +
>  	reset_control_assert(domain->reset);
> =20
>  	/* Enable reset clocks for all devices in the domain */
> @@ -376,6 +406,11 @@ static int imx_pgc_power_up(struct generic_pm_domain=
 *genpd)
> =20
>  	reset_control_deassert(domain->reset);
> =20
> +	/* request parent ADB400 to power up */
> +	if (domain->parent_bits.hskreq)
> +		regmap_update_bits(domain->regmap, domain->regs->hsk,
> +				   domain->parent_bits.hskreq, domain->parent_bits.hskreq);
> +
>  	/* request the ADB400 to power up */
>  	if (domain->bits.hskreq) {
>  		regmap_update_bits(domain->regmap, domain->regs->hsk,
> @@ -438,6 +473,21 @@ static int imx_pgc_power_down(struct generic_pm_doma=
in *genpd)
>  		}
>  	}
> =20
> +	/* request the Parent domain ADB400 to power down */
> +	if (domain->parent_bits.hskreq) {
> +		regmap_clear_bits(domain->regmap, domain->regs->hsk,
> +				  domain->parent_bits.hskreq);
> +
> +		ret =3D regmap_read_poll_timeout(domain->regmap, domain->regs->hsk,
> +					       reg_val,
> +					       !(reg_val & domain->parent_bits.hskack),
> +					       0, USEC_PER_MSEC);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to power down parent ADB400\n");
> +			goto out_clk_disable;
> +		}
> +	}
> +
>  	/* request the ADB400 to power down */
>  	if (domain->bits.hskreq) {
>  		regmap_clear_bits(domain->regmap, domain->regs->hsk,
> @@ -477,6 +527,30 @@ static int imx_pgc_power_down(struct generic_pm_doma=
in *genpd)
>  		}
>  	}
> =20
> +	if (domain->parent_bits.pxx) {
> +		/* enable power control */
> +		for_each_set_bit(pgc, &domain->parent_bits.pgc, 32) {
> +			regmap_update_bits(domain->regmap, GPC_PGC_CTRL(pgc),
> +					   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> +		}
> +
> +		/* request the domain to power down */
> +		regmap_update_bits(domain->regmap, domain->regs->pdn,
> +				   domain->parent_bits.pxx, domain->parent_bits.pxx);
> +		/*
> +		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +		 * for PUP_REQ/PDN_REQ bit to be cleared
> +		 */
> +		ret =3D regmap_read_poll_timeout(domain->regmap,
> +					       domain->regs->pdn, reg_val,
> +					       !(reg_val & domain->parent_bits.pxx),
> +					       0, USEC_PER_MSEC);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to command Parent PGC\n");
> +			goto out_clk_disable;
> +		}
> +	}
> +
>  	/* Disable reset clocks for all devices in the domain */
>  	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> =20
> @@ -787,20 +861,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domain=
s[] =3D {
>  		.pgc   =3D BIT(IMX8MM_PGC_OTG2),
>  	},
> =20
> -	[IMX8MM_POWER_DOMAIN_GPUMIX] =3D {
> -		.genpd =3D {
> -			.name =3D "gpumix",
> -		},
> -		.bits  =3D {
> -			.pxx =3D IMX8MM_GPUMIX_SW_Pxx_REQ,
> -			.map =3D IMX8MM_GPUMIX_A53_DOMAIN,
> -			.hskreq =3D IMX8MM_GPUMIX_HSK_PWRDNREQN,
> -			.hskack =3D IMX8MM_GPUMIX_HSK_PWRDNACKN,
> -		},
> -		.pgc   =3D BIT(IMX8MM_PGC_GPUMIX),
> -		.keep_clocks =3D true,
> -	},
> -
>  	[IMX8MM_POWER_DOMAIN_GPU] =3D {
>  		.genpd =3D {
>  			.name =3D "gpu",
> @@ -811,6 +871,14 @@ static const struct imx_pgc_domain imx8mm_pgc_domain=
s[] =3D {
>  			.hskreq =3D IMX8MM_GPU_HSK_PWRDNREQN,
>  			.hskack =3D IMX8MM_GPU_HSK_PWRDNACKN,
>  		},
> +
> +		.parent_bits =3D {
> +			.pxx =3D IMX8MM_GPUMIX_SW_Pxx_REQ,
> +			.hskreq =3D IMX8MM_GPUMIX_HSK_PWRDNREQN,
> +			.hskack =3D IMX8MM_GPUMIX_HSK_PWRDNACKN,
> +			.pgc =3D BIT(IMX8MM_PGC_GPUMIX),
> +		},
> +
>  		.pgc   =3D BIT(IMX8MM_PGC_GPU2D) | BIT(IMX8MM_PGC_GPU3D),
>  	},
> =20
>=20


