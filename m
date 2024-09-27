Return-Path: <linux-pm+bounces-14880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3F98863D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E4B2344A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73934273DC;
	Fri, 27 Sep 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UgYgjDtk"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C396AAD;
	Fri, 27 Sep 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443648; cv=none; b=Epmjoun5qC02EfIyvvH4LNDs+w+2v80e5ro9Dkjb1SVgJnfGh24YvFDcKHNi+4Mw/KAnVo5L94UQ8NBlyP2RlCFTO9huAGd7qQJJAZp6O/hx6sIvx3wMwJdFq2TY2DGefiuQAv/+++v+ffJ8wIxC1cqzNXyHpbMY4Ziy9X7DbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443648; c=relaxed/simple;
	bh=Jee1hp+0I7JxHs3iOVPdrygPNdq5QxvD0moDqalykeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg3YEIqlE/dJr3YfIFOmTnUviISOsOHi5iH0mgr/sZiB7lahIMWziOiodcr3xsW3QjMMkV5Inuk1Q/rK6an9V1T4/dzIVqiSIxBy1br6rDhwTvhJew6uaIjJur945TiQDVIbfCnv3foym/BAfwpiYFbfYAIAu4m4PlNvmIYARw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UgYgjDtk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48RDRBb0109961;
	Fri, 27 Sep 2024 08:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727443631;
	bh=ErNz+C4ju+kKjJuxkumlB09+OuXJTi+3cKXOxVFdnao=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UgYgjDtkhdGEi4F+8w3hrRZ7QQhFmkWrrfK1Uu3nM5QiSEiIZjdz3y81Wt/IL66kF
	 XTfc1XMT0A9GCrCkLBlrdg60V0kePde/VDrMKznizGD576nXSRhsvT2ALIICYlG6W1
	 l1HeXLevYbV40PZ+ZnxNjSg8VOTMPBbBF57gout8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48RDRBOO002983;
	Fri, 27 Sep 2024 08:27:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Sep 2024 08:27:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Sep 2024 08:27:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48RDRBLB040777;
	Fri, 27 Sep 2024 08:27:11 -0500
Date: Fri, 27 Sep 2024 08:27:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>
Subject: Re: [PATCH v7 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in
 AM62 family
Message-ID: <20240927132711.mfxv4nitr5ygx4tf@throat>
References: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
 <20240926-ti-cpufreq-fixes-v5-v7-6-3c94c398fe8f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240926-ti-cpufreq-fixes-v5-v7-6-3c94c398fe8f@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 14:04-20240926, Dhruva Gole wrote:
[...]

> +	/*
> +	 * This checks for old AM625 Devicetrees where the syscon was a phandle to the
> +	 * wkup_conf parent, this required a hard-coded offset to the efuse register.
> +	 * This node had the compatibles "syscon", "simple-mfd".
> +	 */
> +	if (of_device_is_compatible(np, "simple-mfd") &&
> +	    of_machine_is_compatible("ti,am625")) {
> +		dev_warn(dev,
> +			 "%s: An old devicetree is in use, please consider updating at some point!",
> +			 __func__);

No need to print.. just handle it seamlessly.

> +		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset + 0x0018,
> +				  &efuse);
> +	} else {
> +		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
> +				  &efuse);
> +	}
>  	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
>  		/* not a syscon register! */
>  		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +


All these hanky panky is because sycon does not report access fails when
syscon reg size is 1 word.

https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/
fixes that. With that applied, instead of using explicit property of the
syscon - which could change simple-mfd or simple-bus or what ever.. Let
us use the quirk for backward compatibility (introduced for similar
messy old code), consider the following (macro probably needs a better
naming):

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda..f0d76fc02ff2 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -93,6 +93,8 @@ struct ti_cpufreq_soc_data {
 	bool multi_regulator;
 /* Backward compatibility hack: Might have missing syscon */
 #define TI_QUIRK_SYSCON_MAY_BE_MISSING	0x1
+/* Backward compatibility hack: new syscon size is 1 register wide */
+#define TI_QUIRK_SYSCON_NEW_SINGLE_REG	0x2
 	u8 quirks;
 };
 
@@ -318,6 +320,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_shift = 0x6,
 	.rev_offset = 0x0014,
 	.multi_regulator = false,
+	.quirks = TI_QUIRK_SYSCON_NEW_SINGLE_REG,
 };
 
 static struct ti_cpufreq_soc_data am62a7_soc_data = {
@@ -354,6 +357,10 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
 			  &efuse);
+
+	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_NEW_SINGLE_REG && ret == -EIO)
+		ret = regmap_read(opp_data->syscon, 0x0, &efuse);
+
 	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
 		/* not a syscon register! */
 		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

