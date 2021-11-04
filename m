Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF154453DE
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhKDNdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 09:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhKDNc7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 09:32:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60DC61106;
        Thu,  4 Nov 2021 13:30:20 +0000 (UTC)
Date:   Thu, 4 Nov 2021 09:30:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, lenb@kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix unchecked MSR 0x773 access
Message-ID: <20211104093019.60c0e157@gandalf.local.home>
In-Reply-To: <20211104051925.119941-1-srinivas.pandruvada@linux.intel.com>
References: <20211104051925.119941-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed,  3 Nov 2021 22:19:25 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> It is possible that on some platforms HWP interrupts are disabled. In
> that case accessing MSR 0x773 will result in warning.
> 
> So check X86_FEATURE_HWP_NOTIFY feature to access MSR 0x773. The other
> places in code where this MSR is accessed, already checks this feature
> except during disable path called during cpufreq offline and suspend
> callbacks.
> 
> Fixes: 57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
> Reported-by: Steven Rostedt <rostedt@goodmis.org>

I added this patch on top of the above commit and I verified that the issue
goes away. And just to confirm, I removed the patch, and the issue
reappeared.

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 349ddbaef796..1e6898dc76b6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1620,6 +1620,9 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
>  {
>  	unsigned long flags;
>  
> +	if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +		return;
> +
>  	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
>  	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
>  

