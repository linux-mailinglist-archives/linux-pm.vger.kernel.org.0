Return-Path: <linux-pm+bounces-35201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FFDB9527E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5826A4821AC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D7320A22;
	Tue, 23 Sep 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g1sll7v0"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41B3203A9;
	Tue, 23 Sep 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618572; cv=none; b=rBuD56fRnergBDgo5FlOqFdlnrpROWWCEpCNFohQkd/ysyqQwnVdI1cOEEOnz87V+RApW1lTbzw2p+jy6FY3VBlGTBBR2QtBwIF3g4sKsGXsm4rQWDmFDCNAfRMQqJzNhS/Gxgqcx2TuAsCunFcR5W//j0roNuC1qk959S7fkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618572; c=relaxed/simple;
	bh=7+3Ooj/bv0b+fzned/16t7uzOAswPQ/yY8I3sL3LuFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0u8SfhRg6mAEVh0KlfLJWIONG0+j+wFZ5rKj/R3J9rfFivDA2K/kIth+IvKvkwhTtmD1isAKXiWtmI1Z861/sV1KveIwgih4iCWcyHoFbpKFklbJA1MYu7qSQVDmaPb69RZLYMsBanogWLPaNDvEGD2g7UPrnxb7zTg6vr3RJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g1sll7v0; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58N99Cui1422043;
	Tue, 23 Sep 2025 04:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758618552;
	bh=e7jRsRbX+EPN0LhpJRnnhNbtHSVEcdIQc5SmuwV1j+I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=g1sll7v02Uit0xf86irWRYM2PR7Ry8BSQCP4AI2gGGp75H3vrWP1ehMx+bNp5OJta
	 4YWBfe49TxM+zAlsPBOeTkRIcYpoG7gDy0PZLk8kVXXGsJKHlRwW7npRb0Qw6jn6+D
	 izpg0Bad+cmtaw/k6tdNRUg1Wt7fP6/UtQfxl6g0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58N99CeD1862321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 04:09:12 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 04:09:11 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Tue, 23 Sep
 2025 04:09:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 04:09:11 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58N99Asg3997589;
	Tue, 23 Sep 2025 04:09:11 -0500
Date: Tue, 23 Sep 2025 14:39:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
CC: "Rafael J . wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        zhenglifeng <zhenglifeng1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: Replace pointer subtraction with iteration
 macros
Message-ID: <20250923090910.6ojsyi333ijyjmmo@lcpd911>
References: <20250923075553.45532-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923075553.45532-1-zhangzihuan@kylinos.cn>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 23, 2025 at 15:55:53 +0800, Zihuan Zhang wrote:
> The cpufreq documentation suggests avoiding direct pointer subtraction
> when working with entries in driver_freq_table, as it is relatively
> costly. Instead, the recommended approach is to use the provided
> iteration macros:

Thanks for the patch,
Just say "macro" not "macros".

> 
> - cpufreq_for_each_valid_entry_idx()
> 
> Replace pointer subtraction in freq_table.c with the macros
> cpufreq_for_each_entry_idx() and cpufreq_for_each_valid_entry_idx(), as

Where is "cpufreq_for_each_entry_idx" in this entire patch?
Please drop this reference, why confuse people?

> the index does not need initialization, avoiding unnecessary
> computation. This improves code clarity and follows the established
> cpufreq coding style.

You don't need to add all this to the commit message about the
unnecessary computation, code clarity, etc..
Please keep it to the point.

> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> 
> V2:
>  - Remove unnecessary initialization for current and remaining follow Rafael's suggestion

You didn't fix Rafael's first comment [1] about the $subject, and also please
add links to previous revisions for ease of review.

[1] > In the subject, this is just one macro, not multiple macros.


> ---
>  drivers/cpufreq/freq_table.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index d5111ee56e38..408fd8fee2e3 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -33,16 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>  	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
>  	unsigned int min_freq = ~0;
>  	unsigned int max_freq = 0;
> +	unsigned int i;
>  	unsigned int freq;
>  
> -	cpufreq_for_each_valid_entry(pos, table) {
> +	cpufreq_for_each_valid_entry_idx(pos, table, i) {
>  		freq = pos->frequency;
>  
>  		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>  		    && (pos->flags & CPUFREQ_BOOST_FREQ))
>  			continue;
>  
> -		pr_debug("table entry %u: %u kHz\n", (int)(pos - table), freq);
> +		pr_debug("table entry %u: %u kHz\n", i, freq);
>  		if (freq < min_freq)
>  			min_freq = freq;
>  		if (freq > max_freq)
> @@ -126,7 +127,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
>  	};
>  	struct cpufreq_frequency_table *pos;
>  	struct cpufreq_frequency_table *table = policy->freq_table;
> -	unsigned int freq, diff, i = 0;
> +	unsigned int freq, diff, i;
>  	int index;

Usually, it isn't advised to touch code that's not strictly relevant to
your patch. However since this seems like a minor fixup it's fine by
me... Upto Rafael whether he prefers to have/not have this unrelated change.

But atleast mention in your commit message that you're also removing the
initialization from cpufreq_table_index_unsorted as part of some minor cleanup
(which seems kinda unnecessary to me TBH in the first place)

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

