Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDCE423B7E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbhJFKa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 06:30:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59449 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238030AbhJFKa1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 06:30:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633516115; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5gHobSVO2kPLJnKWdgczaJYxS33RSCMny/Mt0NGh7Zw=; b=kx8cKFT3cmEJc51aXPiHebA/T17FqugmG4KT5XLqSchAkBHIM1QCNpTjGYR+8uivirNPjXJ0
 V5nyVapBIVWCG9rtdkVBTO9GUfXWq/BvzXCkiFnbCw8vFKxPYBTo8HsgPC3Lv+oOmGOajjbm
 7rgYbWoHH5oKeJgj/G4aJOFWHYo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615d7a5330ce13d2b4e8e829 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 10:28:35
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CE51C4360C; Wed,  6 Oct 2021 10:28:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.29.129] (unknown [49.36.85.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43FD9C43460;
        Wed,  6 Oct 2021 10:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 43FD9C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinivas Rao L <lsrao@codeaurora.org>
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <fb86953a-8db0-e805-74fd-d904cb961807@codeaurora.org>
Date:   Wed, 6 Oct 2021 15:58:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929144451.113334-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thanks for the patch. Looks good to me.

Reviewed-by: Maulik Shah <mkshah@codeaurora.org>

Thanks,
Maulik

On 9/29/2021 8:14 PM, Ulf Hansson wrote:
> In the cpuidle-psci case, runtime PM in combination with the generic PM
> domain (genpd), may be used when entering/exiting an idlestate. More
> precisely, genpd relies on runtime PM to be enabled for the attached device
> (in this case it belongs to a CPU), to properly manage the reference
> counting of its PM domain.
> 
> This works fine most of the time, but during system suspend in the
> dpm_suspend_late() phase, the PM core disables runtime PM for all devices.
> Beyond this point and until runtime PM becomes re-enabled in the
> dpm_resume_early() phase, calls to pm_runtime_get|put*() will fail.
> 
> To make sure the reference counting in genpd becomes correct, we need to
> prevent cpuidle-psci from using runtime PM when it has been disabled for
> the device. Therefore, let's move the call to cpuidle_pause() from
> dpm_suspend_noirq() to dpm_suspend_late() - and cpuidle_resume() from
> dpm_resume_noirq() into dpm_resume_early().
> 
> Diagnosed-by: Maulik Shah <mkshah@codeaurora.org>
> Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/base/power/main.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index cbea78e79f3d..1c753b651272 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state)
>   
>   	resume_device_irqs();
>   	device_wakeup_disarm_wake_irqs();
> -
> -	cpuidle_resume();
>   }
>   
>   /**
> @@ -870,6 +868,7 @@ void dpm_resume_early(pm_message_t state)
>   	}
>   	mutex_unlock(&dpm_list_mtx);
>   	async_synchronize_full();
> +	cpuidle_resume();
>   	dpm_show_time(starttime, state, 0, "early");
>   	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
>   }
> @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state)
>   {
>   	int ret;
>   
> -	cpuidle_pause();
> -
>   	device_wakeup_arm_wake_irqs();
>   	suspend_device_irqs();
>   
> @@ -1467,6 +1464,7 @@ int dpm_suspend_late(pm_message_t state)
>   	int error = 0;
>   
>   	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> +	cpuidle_pause();
>   	mutex_lock(&dpm_list_mtx);
>   	pm_transition = state;
>   	async_error = 0;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
