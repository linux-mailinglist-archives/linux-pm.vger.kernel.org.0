Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC41CA2B3
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 07:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgEHFfk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 01:35:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32337 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbgEHFfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 01:35:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588916139; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=5fYVIpYpMlyU60GX56gjAg+98E401CnvmhRI1AZYvRw=; b=L1aezfJaGKrBGCClkvxNgdSuQSyCNNTQ3E/iqoEztj4GO5lpHmdQuzQL9YPZRJQuOQf0NfVh
 iqhU/a/Yc0R17ks7cpgFZr0GPK3KAZY/oVbcNnZFY6LzVb7HkNMk2e7aLN73Xd3ZiL6Kd69C
 fNofHCQJANv7eXggXl6vPQ/gLgY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb4efa8.7ffa51e476f8-smtp-out-n02;
 Fri, 08 May 2020 05:35:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CABEC44791; Fri,  8 May 2020 05:35:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 310E2C433F2;
        Fri,  8 May 2020 05:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 310E2C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 8 May 2020 11:05:23 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 04/14] sched: cpufreq: Move
 sched_cpufreq_governor_change()
Message-ID: <20200508053523.GH19464@codeaurora.org>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-5-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507181012.29791-5-qperret@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 07:10:02PM +0100, Quentin Perret wrote:
> CPUFreq calls into sched_cpufreq_governor_change() when switching
> governors, which triggers a sched domain rebuild when entering or
> exiting schedutil.
> 
> Move the function to sched/cpufreq.c to prepare the ground for the
> modularization of schedutil.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/cpufreq.c           | 33 ++++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c | 33 --------------------------------
>  2 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 7c2fe50fd76d..82f2dda61a55 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -75,3 +75,36 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
>  		(policy->dvfs_possible_from_any_cpu &&
>  		 rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
>  }
> +
> +#ifdef CONFIG_ENERGY_MODEL
> +extern bool sched_energy_update;
> +extern struct mutex sched_energy_mutex;
> +
> +static void rebuild_sd_workfn(struct work_struct *work)
> +{
> +	mutex_lock(&sched_energy_mutex);
> +	sched_energy_update = true;
> +	rebuild_sched_domains();
> +	sched_energy_update = false;
> +	mutex_unlock(&sched_energy_mutex);
> +}
> +static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> +
> +/*
> + * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> + * on governor changes to make sure the scheduler knows about it.
> + */

In the previous patch, you removed reference to schedutil and replaced it with
" an EAS-compatible CPUfreq governor (schedutil)". May be you could do the
same here.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
