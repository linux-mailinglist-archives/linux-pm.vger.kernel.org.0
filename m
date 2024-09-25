Return-Path: <linux-pm+bounces-14721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB2986487
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC7F1F28A16
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5611208D1;
	Wed, 25 Sep 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qiJ7C2J0"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863812F5B;
	Wed, 25 Sep 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280784; cv=none; b=F+7CbzCJRYJt44wGPhpJ28S/Z+4ehJplYuGCt0L3g/n5/JA9EgRfeFUT01tdWOOu0SKQJxJeXJGEpWknTPEIQ/eoeDDH9Ux8465nbx++i80Ol12GkGUj7fE9iLHphfJSuRH70SxA5/NoYr7Kyxc27Je2pLts4bTSuRuWbPsrcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280784; c=relaxed/simple;
	bh=OO2N0MlWDN0Lh2XfHNJMedIUwrmR2LNmHR79B3i0gaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SaK4kPlwOnprQa26mL83sj8EJ4H76MoY4YXRhIn4vkkitzoS31cV3GhJ+2AQTsAbzMA2blyxuT26TZPJGuZldaCln3cidM47Vs4lU1zC+PM6f9wjDDRAohxXNO5iyhrA9t7KS+WOgomq5tKu+xUkWUEEw3852HP3aZd9kQLzy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qiJ7C2J0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PGCrtI120414;
	Wed, 25 Sep 2024 11:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727280773;
	bh=usMqwaFjtbUHhvdgniW/2exXtWe9frXJJ19B3XP9a3s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qiJ7C2J0oRE3zhKmtajbV0CEPR8+zhOJ390s1kgGaC7POUMZV8gx2WSyLP1x+cUef
	 /FqczTibZkijzrx3p1HIimxX7yv4Gm3QBBt/GLMu5lOCiOUsv+uW7xoLhaMmflW3Li
	 krwX48edxbL/me4Yd2yHCcnZpnMlUFdisUCae644=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PGCrms015577
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 11:12:53 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 11:12:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 11:12:52 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PGCqtA065205;
	Wed, 25 Sep 2024 11:12:52 -0500
Message-ID: <809b9eaa-a539-4309-95a3-c9fc9c39288b@ti.com>
Date: Wed, 25 Sep 2024 11:12:52 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in
 AM62 family
To: Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Bryan Brattlof
	<bb@ti.com>
References: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
 <20240925-ti-cpufreq-fixes-v5-v6-6-46f41a903e01@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240925-ti-cpufreq-fixes-v5-v6-6-46f41a903e01@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/25/24 9:54 AM, Dhruva Gole wrote:
> With the Silicon revision being taken directly from socinfo, there's no
> longer any need for reading any SOC register for revision from this driver.
> Hence, we do not require any rev_offset for AM62 family of devices.
> The efuse offset should be 0x0 for AM625 as well, as the syscon
> register being used from DT refers to the efuse_offset directly.
> 
> However, to maintain the backward compatibility with old devicetree, also
> add condition to handle the case where we have the wrong offset and add
> the older efuse_offset value there such that we don't end up reading the
> wrong register offset.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/cpufreq/ti-cpufreq.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index ba621ce1cdda694c98867422dbb7f10c0df2afef..8a97b95b4c44a76b12cab76ddc0f9a5b8ae73f84 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -313,10 +313,9 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
>   
>   static struct ti_cpufreq_soc_data am625_soc_data = {
>   	.efuse_xlate = am625_efuse_xlate,
> -	.efuse_offset = 0x0018,
> +	.efuse_offset = 0x0,
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
> -	.rev_offset = 0x0014,
>   	.multi_regulator = false,
>   };
>   
> @@ -325,7 +324,6 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
>   	.efuse_offset = 0x0,
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
> -	.rev_offset = 0x0014,
>   	.multi_regulator = false,
>   };
>   
> @@ -334,7 +332,6 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
>   	.efuse_offset = 0x0,
>   	.efuse_mask = 0x07c0,
>   	.efuse_shift = 0x6,
> -	.rev_offset = 0x0014,
>   	.multi_regulator = false,
>   };
>   
> @@ -349,11 +346,25 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
>   				u32 *efuse_value)
>   {
>   	struct device *dev = opp_data->cpu_dev;
> +	struct device_node *np = opp_data->opp_node;
>   	u32 efuse;
>   	int ret;
>   
> -	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
> -			  &efuse);
> +	/*
> +	 * The following check is used as a way to check if this is an older devicetree

"check is used as a way to check" sound redundant, maybe just:

This checks for old AM625 Devicetrees where the syscon was a phandle
to the wkup_conf parent, this required a hard-coded offset to
the efuse register.

> +	 * being used where the entire wkup_conf node was marked as "syscon",
> +	 * "simple-mfd".
> +	 * Since this bug only affects AM625, make sure it enters this condition
> +	 * only for that SoC.
> +	 */
> +	if (of_device_is_compatible(np, "simple-mfd") &&
> +	    of_device_is_compatible(np, "ti,am625")) {

Kinda hacky, but keeping backwards compat often is hacky..

Does `of_device_is_compatible(np, "ti,am625")` actually work here? I'm assuming you
tested with an old DT to make sure this path ever got taken. Maybe put a warning
here that an old DT is in use and the user should update at some point.

Andrew

> +		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset + 0x0018,
> +				  &efuse);
> +	} else {
> +		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
> +				  &efuse);
> +	}
>   	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
>   		/* not a syscon register! */
>   		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> 

