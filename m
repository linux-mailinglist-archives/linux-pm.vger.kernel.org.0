Return-Path: <linux-pm+bounces-43186-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFO7MLF1nmnCVQQAu9opvQ
	(envelope-from <linux-pm+bounces-43186-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 05:08:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358B1917C9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 05:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 271EC303ED85
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 04:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C294B246788;
	Wed, 25 Feb 2026 04:08:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810A1ACEDF;
	Wed, 25 Feb 2026 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992492; cv=none; b=qo5Pv+5eULvHn5jR7exVvfdMkSzUiWa2U/mKinKg+nr846bfhG8H6cD9PXI9Q2adOEDVfEXf5Hg/9uSFoNVQSn6uVWM51fimcGf+sufK3SgLFM7GG5jzMiSLNAj2+gnu6u5oJlMSxW47kXPBtopX2LjWK/MXyo3C6uFqWLwBMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992492; c=relaxed/simple;
	bh=pBG51dN+at3FTBWtB/0OKOsFiQ8+6HNAR0s0DNYu4qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UENIObmIgmIQc8u43zJLRCjdXc08aR28WFj/nsb33NAqrIiFUtZci2vyw/Lm/Eh0H2jha+GYxQAbPqejGN1vkpHNitKV4BXWSfU29w4ve/Jr729yS+UrQ53skHlQu+dE2kTSsq3YxdUPTSjORKr3lrCFnZtAXExApFj6tXLyQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fLLY40WJ3zKm4B;
	Wed, 25 Feb 2026 12:03:20 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 61965402AB;
	Wed, 25 Feb 2026 12:08:07 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Feb
 2026 12:08:06 +0800
Message-ID: <a9cbeebf-4029-4eb0-b486-9615b03b3c93@hisilicon.com>
Date: Wed, 25 Feb 2026 12:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: drop invariance when FIE is disabled
To: Penghe Geng <pgeng@nvidia.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>, Ionela Voinescu
	<ionela.voinescu@arm.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
References: <20260220224920.416602-1-pgeng@nvidia.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260220224920.416602-1-pgeng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[zhanjie9@hisilicon.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-43186-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,hisilicon.com:mid]
X-Rspamd-Queue-Id: 9358B1917C9
X-Rspamd-Action: no action


On 2/21/2026 6:49 AM, Penghe Geng wrote:
> CONFIG_ACPI_CPPC_CPUFREQ_FIE gates CPPC counter-based frequency
> invariance support. When FIE is disabled, the CPPC driver does not
> register a frequency scale source, but cpufreq_register_driver() still
> enables cpufreq_freq_invariance for target/fast-switch drivers.
> 
> Disable cpufreq frequency invariance after CPPC driver registration when
> FIE is disabled. This avoids scheduler behavior mismatch when no
> invariance updates are provided, which can cause major performance
> regressions on sensitive platforms.
Hi Penghe,

IIUC, even if CPPC FIE is not there, cpufreq still updates frequency scales
in cpufreq_freq_transition_end() and cpufreq_driver_fast_switch(), so the
frequency scale number is still somewhat meaningful and the
'cpufreq_freq_invariance' static key reflects that correctly.

Any numbers or evidence of that "performance regressions" so that we can
understand the issue better?

Thanks,
Jie
> 
> Export cpufreq_disable_freq_invariance() so modular cppc_cpufreq can call
> it.
> 
> Fixes: 1eb5dde674f5 ("cpufreq: CPPC: Add support for frequency invariance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 4 ++++
>  drivers/cpufreq/cpufreq.c      | 8 ++++++++
>  include/linux/cpufreq.h        | 3 +++
>  3 files changed, 15 insertions(+)
> 
...

