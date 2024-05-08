Return-Path: <linux-pm+bounces-7670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A968C038A
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C891F21F05
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E812B175;
	Wed,  8 May 2024 17:46:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9F12B151
	for <linux-pm@vger.kernel.org>; Wed,  8 May 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190368; cv=none; b=e4C8cdHXzeYXKr0eLLhwKpDyO4C1Db3q0NvNDWJvTiYuaSUMgukKBNuxhXK9R+W8O/WE9XWKD9b18vxSF8gWqNaKcBRoICREKRavgC2fwj75f1hKEdcSXTnKN4wSCLPwv0dp8X2+1aYP1Ts+kitMrmbJuuSpmNSXCQUkC8vzD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190368; c=relaxed/simple;
	bh=f8PbXGqF82lXHQlKyIX8tEfHkeLPJzChVRHjKD0oLGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3tHU4oLtY9ndWnhK12HfaZe8d3juhV3ic4hU1zmqvzPlCqu2Ih3oy2ot0ErN8cU4ifOIr6bXFaLIT+7+C/Ov9whhCsMH8BRveTFMhyqWM9iPyufLvTgK64DPDA73GSKv8kPZgIAZ7VnP5FcUYDyGnaMZ3zyXSE8GkZP2c9pQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s4lMg-0007oy-75; Wed, 08 May 2024 19:46:02 +0200
Message-ID: <a08ac1e225d29797cf8d375c5cf4c331f66c92a8.camel@pengutronix.de>
Subject: Re: [PATCH v1] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
From: Lucas Stach <l.stach@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 08 May 2024 19:46:01 +0200
In-Reply-To: <20240418155151.355133-1-ivitro@gmail.com>
References: <20240418155151.355133-1-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

Am Donnerstag, dem 18.04.2024 um 16:51 +0100 schrieb Vitor Soares:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> During the probe, the genpd power_dev is added to the dpm_list after
> blk_ctrl due to its parent/child relationship. Making the blk_ctrl
> suspend after and resume before the genpd power_dev.
>=20
> As a consequence, the system hangs when resuming the VPU due to the
> power domain dependency.
>=20
> To ensure the proper suspend/resume order, add a device link betweem
> blk_ctrl and genpd power_dev. It guarantees genpd power_dev is suspended
> after and resumed before blk-ctrl.
>=20
> Cc: <stable@vger.kernel.org>
> Closes: https://lore.kernel.org/all/fccbb040330a706a4f7b34875db1d896a0bf8=
1c8.camel@gmail.com/
> Link: https://lore.kernel.org/all/20240409085802.290439-1-ivitro@gmail.co=
m/
> Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>=20
> This is a new patch, but is a follow-up of:
> https://lore.kernel.org/all/20240409085802.290439-1-ivitro@gmail.com/
>=20
> As suggested by Lucas, we are addressing this PM issue in the imx8m-blk-c=
trl
> driver instead of in the imx8mm.dtsi.
>=20
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index ca942d7929c2..cd0d2296080d 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -283,6 +283,20 @@ static int imx8m_blk_ctrl_probe(struct platform_devi=
ce *pdev)
>  			goto cleanup_pds;
>  		}
> =20
> +		/*
> +		 * Enforce suspend/resume ordering by making genpd power_dev a
> +		 * provider of blk-ctrl. Genpd power_dev is suspended after and
> +		 * resumed before blk-ctrl.
> +		 */
> +		if (!device_link_add(dev, domain->power_dev, DL_FLAG_STATELESS)) {
> +			ret =3D -EINVAL;
> +			dev_err_probe(dev, ret,
> +				      "failed to link to %s\n", data->name);
> +			pm_genpd_remove(&domain->genpd);
> +			dev_pm_domain_detach(domain->power_dev, true);
> +			goto cleanup_pds;
> +		}
> +
>  		/*
>  		 * We use runtime PM to trigger power on/off of the upstream GPC
>  		 * domain, as a strict hierarchical parent/child power domain
> @@ -324,6 +338,7 @@ static int imx8m_blk_ctrl_probe(struct platform_devic=
e *pdev)
>  	of_genpd_del_provider(dev->of_node);
>  cleanup_pds:
>  	for (i--; i >=3D 0; i--) {
> +		device_link_remove(dev, bc->domains[i].power_dev);
>  		pm_genpd_remove(&bc->domains[i].genpd);
>  		dev_pm_domain_detach(bc->domains[i].power_dev, true);
>  	}
> @@ -343,6 +358,7 @@ static void imx8m_blk_ctrl_remove(struct platform_dev=
ice *pdev)
>  	for (i =3D 0; bc->onecell_data.num_domains; i++) {
>  		struct imx8m_blk_ctrl_domain *domain =3D &bc->domains[i];
> =20
> +		device_link_remove(&pdev->dev, domain->power_dev);
>  		pm_genpd_remove(&domain->genpd);
>  		dev_pm_domain_detach(domain->power_dev, true);
>  	}


