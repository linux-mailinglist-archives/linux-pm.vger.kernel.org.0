Return-Path: <linux-pm+bounces-35944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EEBD1551
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB233BB90E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5301EEA54;
	Mon, 13 Oct 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LVnGE+F0"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539034BA42;
	Mon, 13 Oct 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327408; cv=none; b=oyu1TUSXsm5fTipzVTs4fDslo6JJjj+x3HJSLhT59X8MFoDKBYMWEifiBrxLq5Tq18lkA07Z67z36WOsftiAGMA4dTTxMwXvC0LIcGkklG3kTg41Yso7Co9KUwGiY9o3PeyzZPEk7ivIrhzp/CnuzQujtA/uPbsbuE6tp+S31Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327408; c=relaxed/simple;
	bh=II9PstpmWDTczQX7bhyjq4AqTAUxf3ZpRGR9ppyMc2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NzSZO65WIs0GM1QwAkIRJI47uZrBFV7vEZRnhuBxNRIX0WiDZdAyqrt/o+kn+HVt07UdO16nf5xTQTCvcmQtINmnSY6sM9VbrPZiPtCYDNT10NVGsq0rm/WA2rN3al8bJiGSspoun9KXC5gJ3S50h4EvrEB2utEf1DVIQaWMfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LVnGE+F0; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59D3nnCO730626;
	Sun, 12 Oct 2025 22:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760327389;
	bh=dCw0dkLniTXuadQJ1IK2N4d0zgAIPu2vQk8B/Rto7pY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LVnGE+F0ZtSxnzj1vRiYQ7BfQIzQavIgGhsBECpMtj9+CLC4rFIbkNrHqo7qnDo07
	 j20WoazHfLlTBFmqQUc7bkS7KsXuitGP/IzpCwU9rDA+wggUrKps9hSvJvYAgpkJuI
	 TFZL5GYVrwYMJM/O6AawXOr38m/+hyAxwquMVo9Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59D3nnx63521823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 12 Oct 2025 22:49:49 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 12
 Oct 2025 22:49:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 12 Oct 2025 22:49:48 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59D3njWf1399385;
	Sun, 12 Oct 2025 22:49:46 -0500
Message-ID: <029725c3-f747-4f90-9f6a-ef7eb133d7eb@ti.com>
Date: Mon, 13 Oct 2025 09:19:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.17-6.12] cpufreq: ti: Add support for AM62D2
To: Sasha Levin <sashal@kernel.org>, <patches@lists.linux.dev>,
        <stable@vger.kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
 <20251009155752.773732-85-sashal@kernel.org>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20251009155752.773732-85-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

This patch doesn't need to be backported. AM62D support itself was added 
recently in 6.17.

Thanks

On 09/10/25 21:25, Sasha Levin wrote:
> From: Paresh Bhagat <p-bhagat@ti.com>
>
> [ Upstream commit b5af45302ebc141662b2b60c713c9202e88c943c ]
>
> Add support for TI K3 AM62D2 SoC to read speed and revision values
> from hardware and pass to OPP layer. AM62D shares the same configuations
> as AM62A so use existing am62a7_soc_data.
>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> Based on my comprehensive analysis of this commit and the stable kernel
> backporting policies, here is my assessment:
>
> ## Backport Status: YES
>
> ### Detailed Analysis
>
> #### 1. **Explicit Policy Support**
> The Linux stable kernel rules (Documentation/process/stable-kernel-
> rules.rst, line 15) **explicitly allow device ID additions**:
>> "It must either fix a real bug that bothers people or **just add a
> device ID**."
>
> This commit adds device IDs for the AM62D2 SoC in two locations:
> - **Line 313** in `k3_cpufreq_soc[]`: Adds `{ .family = "AM62DX",
>    .revision = "SR1.0" }`
> - **Line 461** in `ti_cpufreq_of_match[]`: Adds `{ .compatible =
>    "ti,am62d2", .data = &am62a7_soc_data, }`
>
> #### 2. **Strong Historical Precedent**
> Similar commits for the AM62 SoC family were backported to stable trees:
>
> - **AM625 support** (aac0293a8f1cd): No Cc: stable tag, but present in
>    stable branches linux-6.10.y through 6.17.y
> - **AM62A7 support** (5008e4c8c31c6): No Cc: stable tag, but present in
>    stable branches linux-6.10.y through 6.17.y
> - **AM625 blacklist** (e66e20d71d79e): Also backported to stable
> - **AM62A7 blacklist** (b2b2029eb1788): Also backported to stable
>
> #### 3. **Minimal Risk Profile**
> - **Only 2 lines changed** (1 file, +2 insertions)
> - **Reuses existing configuration**: Uses `am62a7_soc_data` as stated in
>    commit message - no new code paths
> - **Isolated change**: Only affects AM62D2 hardware, no impact on other
>    SoCs
> - **Well-tested pattern**: Follows the exact same pattern as AM625,
>    AM62A7, and AM62P5 additions
>
> #### 4. **User Benefit**
> - Enables CPU frequency scaling on AM62D2 hardware
> - Users with AM62D2 boards (device tree support added in v6.17 via
>    commit 1544bca2f188e) need this for proper power management
> - Without this commit, AM62D2 systems cannot adjust CPU frequencies
>    based on load
>
> #### 5. **Companion Commit**
> There's a companion commit **fa40cbe1c86b6** "cpufreq: dt-platdev:
> Blacklist ti,am62d2 SoC" by the same author on the same date. Both
> should be backported together to prevent the generic cpufreq-dt driver
> from conflicting with ti-cpufreq.
>
> #### 6. **No Architectural Changes**
> - No new features beyond hardware enablement
> - No refactoring or code restructuring
> - No changes to existing functionality
> - Meets stable tree criteria: small, contained, low regression risk
>
> ### Conclusion
> This commit should be backported to stable kernel trees because it:
> 1. Falls under the explicit "device ID addition" exception in stable
>     rules
> 2. Has strong precedent with similar AM62 family commits being
>     backported
> 3. Provides essential functionality for AM62D2 hardware owners
> 4. Has minimal regression risk (2 lines, reuses existing data
>     structures)
> 5. Follows the established stable backporting pattern for this driver
>
>   drivers/cpufreq/ti-cpufreq.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 5a5147277cd0a..9a912d3093153 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -310,6 +310,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
>   	{ .family = "AM62X", .revision = "SR1.0" },
>   	{ .family = "AM62AX", .revision = "SR1.0" },
>   	{ .family = "AM62PX", .revision = "SR1.0" },
> +	{ .family = "AM62DX", .revision = "SR1.0" },
>   	{ /* sentinel */ }
>   };
>   
> @@ -457,6 +458,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
>   	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
>   	{ .compatible = "ti,am625", .data = &am625_soc_data, },
>   	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
> +	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
>   	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
>   	/* legacy */
>   	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },

