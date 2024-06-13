Return-Path: <linux-pm+bounces-9079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ADC906B08
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D42B221B2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0031422B5;
	Thu, 13 Jun 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBdd6o8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111F13791B;
	Thu, 13 Jun 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278416; cv=none; b=a3Clj1j2wIEV0kbMgetXjfDaR7gxtoQfTlM056d18Y0rT9Qkofh671F1DIFlsV1Vx1ToPXah2qQZj36armym0wh+hGTPLCo9N16JLQNmi+CZpR4xPJD9b4swS2hHOIOFZx6h9uRVxLlORFTO1szaoWK2OpFSlV5t5dl3yA3D1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278416; c=relaxed/simple;
	bh=ucfrA2j0rBj3YvmedfvAcA3pDUmA+c5bWw/5+PdY7O0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOuvlsYgFBDZEknCd9GaBm+8UxmoEpuFGZqSLQytea9hmf0noRqk7sUeR9w3eiX3B9oA1r3NIBzl3iMHX42azh01Acq2T0Vo9zl6yCf9X2V9B1KptH4qzhWN+cZihyzFwyK78Xobhay4W4NR6sHBdQccFUX0Iq4eI2u7haX6Bdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TBdd6o8I; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DBXLb2070819;
	Thu, 13 Jun 2024 06:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718278401;
	bh=2C5M7WDgX8YUaJV0vHBdSVcnWLy+EfLkxH20fNG3az0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TBdd6o8INGJ4EqwaZeHWhJ0pZ/V98bmH+TWnzZWRyDUK32uIGxXwafBhjXrCm/6Lc
	 r3UW9AtBIBuzc5Ufy8RP+YrM7qc+KXiAzvY267WTRBcvyTWcjupneyJXnBkzHTcoHj
	 WpyK6p05wzrMkAJWGYtcjVZ1+zI6PeuJxz3mezmA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DBXL3U003734
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 06:33:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 06:33:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 06:33:20 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DBXKHf080886;
	Thu, 13 Jun 2024 06:33:20 -0500
Date: Thu, 13 Jun 2024 17:03:19 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Vibhore Vardhan
	<vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] cpufreq: ti: update OPP table for AM62Px SoCs
Message-ID: <20240613113319.kryllyhrqzcnjqgk@dhruva>
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
 <20240612-ti-opp-updates-v2-2-422b6747a254@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612-ti-opp-updates-v2-2-422b6747a254@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 12, 2024 at 18:17:35 -0500, Bryan Brattlof wrote:
> More speed grades for the AM62Px SoC family have been defined which
> unfortunately no longer align with the AM62x table. So create a new
> table with these new speed grades defined for the AM62Px
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a80698f3cfe65..6c84562de5c6b 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -69,6 +69,13 @@ enum {
>  #define AM62A7_SUPPORT_R_MPU_OPP		BIT(1)
>  #define AM62A7_SUPPORT_V_MPU_OPP		BIT(2)
>  
> +#define AM62P5_EFUSE_O_MPU_OPP			15
> +#define AM62P5_EFUSE_S_MPU_OPP			19
> +#define AM62P5_EFUSE_U_MPU_OPP			21
> +
> +#define AM62P5_SUPPORT_O_MPU_OPP		BIT(0)
> +#define AM62P5_SUPPORT_U_MPU_OPP		BIT(2)
> +
>  #define VERSION_COUNT				2
>  
>  struct ti_cpufreq_data;
> @@ -134,6 +141,23 @@ static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  	return BIT(efuse);
>  }
>  
> +static unsigned long am62p5_efuse_xlate(struct ti_cpufreq_data *opp_data,
> +					unsigned long efuse)
> +{
> +	unsigned long calc_efuse = AM62P5_SUPPORT_O_MPU_OPP;

This and he earlier patch, why not continue using the name convention
calculated_efuse like in am625 and dra ?

> +
> +	switch (efuse) {
> +	case AM62P5_EFUSE_U_MPU_OPP:
> +	case AM62P5_EFUSE_S_MPU_OPP:
> +		calc_efuse |= AM62P5_SUPPORT_U_MPU_OPP;
> +		fallthrough;
> +	case AM62P5_EFUSE_O_MPU_OPP:
> +		calc_efuse |= AM62P5_SUPPORT_O_MPU_OPP;
> +	}
> +
> +	return calc_efuse;
> +}
> +
>  static unsigned long am62a7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  					unsigned long efuse)

Otherwise, Looks good.
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

