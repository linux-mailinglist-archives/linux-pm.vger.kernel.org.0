Return-Path: <linux-pm+bounces-14644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8BF985477
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 09:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD13E1C20CBA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AB7158218;
	Wed, 25 Sep 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H14lax+p"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6B158208;
	Wed, 25 Sep 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250475; cv=none; b=FmR80nEPSxlPzukz32J6hFSn2OQhldUkZX0TjiogDPLBjfSoEBUlVQ8rnlzP/GKaNPGX4fxUb+Gj53e4jfsCWTv9Mf2gA2VwRUUmsf3S0LempoRnun5gDBJ/gw2xBem0q5ZIdPtuI/NlJvqcd+jMxA+R5RP/3lgdnPIbt7Bz6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250475; c=relaxed/simple;
	bh=AH30pQ+JgS5iaPpz3lQ/tcN+lDeS8h2ETDJoWhfx8Ew=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9RBNE9FKMuo0c8BP1uNPQvDNuInqwi1VRuYFr0CNUM67Gd2urS03TPbbXhXhA0cVmB8QBkVtXtI83crgDqZbUn+UBoHkDmhSGu7d1FbiNH1X12+MvwVNQDFXyGBeJfKXThg8eP03eM+l840mbQYw7k840z6Z1hohVUCaPO3dAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H14lax+p; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48P7leAh061514;
	Wed, 25 Sep 2024 02:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727250460;
	bh=PQ0co4Ma+pPlFS7bCsPfeWHITDOj9G31dJEWavo3etw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=H14lax+p2Ua6WxXGAuQ36/mYKeRoJ60KNBXzfyuDDTTBlXg0Y6nINFFF5c/eWY5Es
	 zUKfM8K8sbo3q3QJx/VT409QnN0xW7Dsjr0fa4jb3DeTE6dgEKtQkb74S4P5z5hsl7
	 qfJI530QHXRTcP2J2zY3fKnU3+RVVQA2o2+cPPtk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48P7leSv093666
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 02:47:40 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 02:47:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 02:47:39 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48P7lcAW004872;
	Wed, 25 Sep 2024 02:47:39 -0500
Date: Wed, 25 Sep 2024 13:17:38 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
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
        Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v5 0/6] ti: k3-am62{a,p}x-sk: add opp frequencies
Message-ID: <20240925074738.a43uwqen4dvbd5mc@lcpd911>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
 <20240924121544.62my7eqnudc76orl@subscribe>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240924121544.62my7eqnudc76orl@subscribe>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 24, 2024 at 07:15:44 -0500, Nishanth Menon wrote:
> On 15:20-20240924, Dhruva Gole wrote:
> [...]
> > 
> > I am sorry that this breaks compatibility with older AM625 devicetree.
> > However, the old devicetree was marking the entire wkup_conf as "syscon",
> > "simple-mfd" which was wrong and needed to be fixed.
> > 
> > This series finally tries to bring order to DT and the driver.
> > 
> > However, if there is still any way to maintain the backward
> > compatibility, then I am open to suggestions. Please try
> > and understand here that the ask for backward compatibility here
> > is to ask the driver to support a case where the register offset itself
> > was to be picked from a different node. I am not sure if there's any
> > cleaner way to do this.
> 
> 
> Have you tried to handle this with quirks? I am not in favor of breaking
> backward compatibility.

I was thinking of something on those lines, but quirks makes sense for
the case that there's a quirky behaviour in the SoC itself. Here it
seems to me that we are adding a quirk to handle quirk in some old devicetree.

There's no way to detect the devicetree version or somehow distinguish
within the driver if it's an old or a new DT. One way I could think of
is on these lines:

8<---------------------------------------------------------------------------
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 870ab0b376c1..e1b22c5d4ab8 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -93,6 +93,7 @@ struct ti_cpufreq_soc_data {
        bool multi_regulator;
 /* Backward compatibility hack: Might have missing syscon */
 #define TI_QUIRK_SYSCON_MAY_BE_MISSING 0x1
+#define TI_QUIRK_SYSCON_MAY_BE_INCORRECT       0x2
        u8 quirks;
 };

@@ -317,6 +318,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
        .efuse_mask = 0x07c0,
        .efuse_shift = 0x6,
        .multi_regulator = false,
+       .quirks = TI_QUIRK_SYSCON_MAY_BE_INCORRECT,
 };

 static struct ti_cpufreq_soc_data am62a7_soc_data = {
@@ -349,6 +351,9 @@ static int ti_cpufreq_get_efuse(struct
ti_cpufreq_data *opp_data,
        u32 efuse;
        int ret;

+       if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_INCORRECT )
+               opp_data->soc_data->efuse_offset = 0x0018;
+
        ret = regmap_read(opp_data->syscon,
opp_data->soc_data->efuse_offset,
                          &efuse);
        if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING
&& ret == -EIO) {

---------------------------------------------------------------------------->8

Then, additionally read the soc_data->syscon value, compare it against
some hard coded value to check if the address needs the 0x0018 offset or
not... All this feels extremely hackish and hence I was against doing
this.

Am I missing some other obvious way to distinguish between old/new DT? I
don't suppose we can just go ahead and create a new binding just for
this.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

