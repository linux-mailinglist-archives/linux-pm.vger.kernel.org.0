Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A90456E6C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 12:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhKSLln (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 06:41:43 -0500
Received: from rome.phoronix.com ([192.211.48.82]:8288 "EHLO rome.phoronix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhKSLlm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 06:41:42 -0500
X-Greylist: delayed 1114 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 06:41:42 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ANNJ7mFtSezQSqS/LIqqo8SPM9BHtr+pZD5rKWf0pgQ=; b=P1S6xR92ZeXBcNRJ8w+pFQLmZG
        x7JkMnP6RW0DmUHrZ7lmUk4+0J4Ub1c8hdGhlek/3mYCJwe7rOjKSk+kVAmMsRdVRmBZvzX3n7PXU
        NwhkmaiXcAuEvx7ryjgaKFwGAGBRHjI3It0dLZz1qUkSPQjJpKk82FuTuWhroEkVQsobgvrxslTji
        z+HkjC0T9kkhy90AkceZkQ3x7sFxp+zz1MTiZcbQbCPtCgaIZp2+RqLw/o9DW+N2wS3As6FB4SRX9
        wWwXJrjIX9qef9dmulnXhCTT65e7rjjb4riScsC8juSXPt38cTPX2aAmWC3M1TJj0SNy+wT//qDI4
        F/jcEgaw==;
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:49234 helo=[192.168.86.57])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1mo1w3-00034b-KF; Fri, 19 Nov 2021 06:20:02 -0500
Message-ID: <a2a18288-fa7c-02fb-6376-730777823637@MichaelLarabel.com>
Date:   Fri, 19 Nov 2021 05:19:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] cpufreq: intel_pstate: ITMT support for overclocked
 system
Content-Language: en-CA
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ricardo.neri@intel.com, tim.c.chen@intel.com, peterz@infradead.org,
        arjan@linux.intel.com
References: <20211119051801.1432724-1-srinivas.pandruvada@linux.intel.com>
From:   Michael Larabel <Michael@MichaelLarabel.com>
In-Reply-To: <20211119051801.1432724-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - MichaelLarabel.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@michaellarabel.com
X-Authenticated-Sender: rome.phoronix.com: michael@michaellarabel.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/18/21 23:18, Srinivas Pandruvada wrote:
> On systems with overclocking enabled, CPPC Highest Performance can be
> hard coded to 0xff. In this case even if we have cores with different
> highest performance, ITMT can't be enabled as the current implementation
> depends on CPPC Highest Performance.
>
> On such systems we can use MSR_HWP_CAPABILITIES maximum performance field
> when CPPC.Highest Performance is 0xff.
>
> Due to legacy reasons, we can't solely depend on MSR_HWP_CAPABILITIES as
> in some older systems CPPC Highest Performance is the only way to identify
> different performing cores.
>
> Reported-by: Michael Larabel <Michael@MichaelLarabel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This patch was tested on one Alder Lake system by enabling Overclocking.
> Once overclocking is enabled, we see
> $cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
> 255 (P-Cores)
> 255 (P-Cores
> ...
> ...
> 255 (E-Cores)
> 255 (E-Cores)
> The real max performance for CPUs on this system was
> 0x40 for P-cores and 0x26 for E-cores.
> With this change applied we will see
> $cat /proc/sys/kernel/sched_itmt_enabled
> 1
> The resultant ITMT priorities
> for P-core 0x40, P-core HT sibling 0x10 and E-core 0x26


With this patch I can confirm that now sched_itmt_enabled = 1 and 
correct highest_perf with the ASUS ROG STRIX Z690-E GAMING WIFI board on 
the latest BIOS. Thanks.

Tested-by: Michael Larabel <Michael@MichaelLarabel.com>

Michael


>
>   drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 815df3daae9d..3106e62ffb25 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -338,6 +338,8 @@ static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
>   
>   static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
>   
> +#define CPPC_MAX_PERF	U8_MAX
> +
>   static void intel_pstate_set_itmt_prio(int cpu)
>   {
>   	struct cppc_perf_caps cppc_perf;
> @@ -348,6 +350,14 @@ static void intel_pstate_set_itmt_prio(int cpu)
>   	if (ret)
>   		return;
>   
> +	/*
> +	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
> +	 * In this case we can't use CPPC.highest_perf to enable ITMT.
> +	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
> +	 */
> +	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
> +		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
> +
>   	/*
>   	 * The priorities can be set regardless of whether or not
>   	 * sched_set_itmt_support(true) has been called and it is valid to
