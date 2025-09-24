Return-Path: <linux-pm+bounces-35264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB11B97F1A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 02:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321292A1713
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F41DF273;
	Wed, 24 Sep 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKDa67y6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39461DE3CA;
	Wed, 24 Sep 2025 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675132; cv=none; b=uUpS5dB2CkYP/PVw+gE5GUy7FIzKzkRJ5a8eDsUaOk40ca58Tv9lZDExEeRTCrNYiMbg9TXo0Yaed+eIEa4wmdVt7/gt57ccRA0aYEWZ4QAS4yRfvG6qBnDMtN3vW5EZIQ1gZNP99t5NqnFGtr3bmkGM6RRboh4d7N/B1NoEbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675132; c=relaxed/simple;
	bh=AVfHO1CTr0Qk1/2kp7j+A2HLBwT4+lGQ8iNME1oqqtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrYwiiEZvCt3spHp3yLZJzbd0hAU9ETFtHXt1gqeau+MG+2M1yO6XjkqxoVzs1r/VRsznJoI3gPSchNDkkZWPiBFvca/3h3WLWLp3cwkbAwQArC0P47UyxtxnAPCZSnM06GBv24aprQB42be184tV+PkECZ0qzJJ178y5J6okt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKDa67y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C316C4CEF5;
	Wed, 24 Sep 2025 00:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758675131;
	bh=AVfHO1CTr0Qk1/2kp7j+A2HLBwT4+lGQ8iNME1oqqtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKDa67y6SyEFw1qlA6a9iuqltKqS79FgbeO5XHRgbgEJrbRFMGLyes+sdJl4P9Kx1
	 1Bdl/6xJlKkXJG7OLvO5j5xgFuFwUY/k5DADcWja7MHn/iR7QkmOIi3LOPlPuWQpPA
	 zEDH4f9m4ww4taqjnFfi27ghihSD6O4b+BT8gujROOLRCQ4si+7r136kK3fNJDxc/r
	 4ea+MQIeBO5jArQvh2YxrjviMh46GmoB5n0zp3nR5+fS7Sl+T9lGw5ALVTxMzxSMFq
	 wEfjCBXp0IEJty2uolJs47GNwkp9Q+jJlk+b7NYqtTN1QHj8n7uolepgdwxV0VgxM7
	 tDKztVOK9js6g==
Date: Wed, 24 Sep 2025 08:52:06 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v4 4/5] usb: chipidea: ci_hdrc_imx: Set out of band
 wakeup for i.MX95
Message-ID: <aNNAtlP768mMPPVC@nchen-desktop>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
 <20250922-pm-v4-v4-4-ef48428e8fe0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-pm-v4-v4-4-ef48428e8fe0@nxp.com>

On 25-09-22 10:21:09, Peng Fan wrote:
> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> power domain(Digital logic) is off. There is still always on logic
> have the wakeup capability which is out band wakeup capbility.
> 
> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
> wakeup system even if HSIOMIX power domain is in off state.
> 
> Tested-by: Xu Yang <xu.yang_2@nxp.com>
> Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org> 

Feel free add my ack if power part has accepted.

Peter
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 11 ++++++++++-
>  include/linux/usb/chipidea.h       |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index d7c2a1a3c2715967203b98c819fa864e06a00a32..d4ee9e16332fe8b506711e4739c9008f73a377bf 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
>  		CI_HDRC_HAS_PORTSC_PEC_MISSED,
>  };
>  
> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
> +	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
> +};
> +
>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
>  	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
>  };
> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
>  	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
>  	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
>  	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
> +	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
>  	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
>  	{ /* sentinel */ }
>  };
> @@ -704,9 +709,13 @@ static int ci_hdrc_imx_suspend(struct device *dev)
>  
>  	pinctrl_pm_select_sleep_state(dev);
>  
> -	if (data->wakeup_irq > 0 && device_may_wakeup(dev))
> +	if (data->wakeup_irq > 0 && device_may_wakeup(dev)) {
>  		enable_irq_wake(data->wakeup_irq);
>  
> +		if (data->plat_data->flags & CI_HDRC_OUT_BAND_WAKEUP)
> +			device_set_out_band_wakeup(dev);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
>  #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
>  #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
> +#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> 
> -- 
> 2.37.1
> 

-- 

Best regards,
Peter

