Return-Path: <linux-pm+bounces-21780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D73A3049B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0FE166A96
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AA1EE019;
	Tue, 11 Feb 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="sf8OOezD"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B61EB186;
	Tue, 11 Feb 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259375; cv=none; b=TNKNx1/rgbtxo6RppiZwbQI+P0HpYLAev4QiAVA0sQ8Awkq4C9w8iBuQ49Izul7Ywsw3+OtUyaQSCOVjT66nZc266Nq9D7UpGeo2t7yeMJ3dsL1NrYbqXZu3t8vw5Ms9eZ+WCuXEsckyBmZeAyL1G6PLSyk6zqNiYPKdnyHMw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259375; c=relaxed/simple;
	bh=FHABviBCLTQZchnRqmI9Jrk7UuzPN8EYjJLUJQ5Wtys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcB03jJubqyFe1IaWgoq7vs8htkZ7kn91ZSuIS6WMM38zYtvWQr5hu+2joqabUi/urHZk0BZ+kVVxCsGBDw1PJq9UmT2OGuhRPBbjT0RWnl7R2jIKwc7ElxD+ZxCKBfbUSFpek2qtgkJi3ZDNUSATek9i+mPxgpFbs84nW9jSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=sf8OOezD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OYk0p+JMseG7FVlttgOde/7MHMJ97BiQKK6RiBx2sNQ=; b=sf8OOezD7oVeV666W8vv/CGJxC
	qjpRpwEMd/yyYNm5Uj4tDClgnclKv2bC+kbxrWj/NN30KF8uy1pPScMuhnel1PZdHo0OZZOqnZKJz
	Bom1SPQSOUhYpRpmb47LUTUOT9g+kvVTKF4kFl8BcgT3jvzl8ZcvhjwTnITYeI8kCMeFnfgaJDZqx
	RGIhiaMT+cVHb16KykoJ8foZAzgJuiViuzspYy2UnMjbKX615w4s1mqvWYNPxrCiJGscWJW40Kdc8
	qNtx3577HJWYg9ci/DSsv2Dg9uI2tJHx+W3MyD+2vnvx3xEhpfEB7EwDwH7ENhC4Mi12nZ87+4VhI
	83tWFyig==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1thkoJ-0004nq-Qy; Tue, 11 Feb 2025 08:35:59 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject:
 Re: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform firmware
Date: Tue, 11 Feb 2025 08:35:58 +0100
Message-ID: <14847271.RDIVbhacDa@diego>
In-Reply-To: <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
References:
 <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 5. Februar 2025, 07:15:53 MEZ schrieb Shawn Lin:
> Inform firmware to keep the power domain on or off.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>


> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> - fix a compile warning
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index cb0f938..49842f1 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
>   */
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/err.h>
> @@ -20,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
>  #include <soc/rockchip/pm_domains.h>
> +#include <soc/rockchip/rockchip_sip.h>
>  #include <dt-bindings/power/px30-power.h>
>  #include <dt-bindings/power/rockchip,rv1126-power.h>
>  #include <dt-bindings/power/rk3036-power.h>
> @@ -540,6 +542,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>  	struct generic_pm_domain *genpd = &pd->genpd;
>  	u32 pd_pwr_offset = pd->info->pwr_offset;
>  	bool is_on, is_mem_on = false;
> +	struct arm_smccc_res res;
>  
>  	if (pd->info->pwr_mask == 0)
>  		return;
> @@ -567,6 +570,11 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>  			genpd->name, is_on);
>  		return;
>  	}
> +
> +	/* Inform firmware to keep this pd on or off */
> +	arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> +			pmu->info->pwr_offset + pd_pwr_offset,
> +			pd->info->pwr_mask, on, 0, 0, 0, &res);
>  }
>  
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
> 





