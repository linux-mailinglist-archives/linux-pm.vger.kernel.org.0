Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9104DD10E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 00:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiCQXL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCQXL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 19:11:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFBFD081F
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:10:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s29so11440523lfb.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8weo9MEf8kcGcy6IXBgdYOf+5hibHZzzCr4V47ohpLM=;
        b=a/Ni3TkJQLpX0Xe1CpUDgax54dRtYavSYy1iCPT5CJnmzLEx4Eezazdx3sWr/w/H7z
         d0S1/HiTfaSeg/u2SofuZbIunz4ECIDnSApaPtc7tVVXgh13LIBhz3X3o/8lPehB9sS1
         24VeVPtBKzJ5gElTg+V8XvW1onhdGn6BYieUe5tiEiPoYaG2GdxPglbMkaJOWtzilhnb
         pnG43owHHB5HT4yo3CrLKZLzBnJ+dg1+7na7WeSCLO6cs2mDLzfU1tjvpnLPBY2Dd+hI
         KMFNKA0hczRBg7pG8t+9okQzDRJ0e01AZRqj1G8lYlvsDDFKMOk8I81SO+u3tomZFvQN
         iWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8weo9MEf8kcGcy6IXBgdYOf+5hibHZzzCr4V47ohpLM=;
        b=vQx9VShD2gYBUN/+28Kq3AF/BFLppRuvOfE7HYXekzwgPjwnnUbdeS1x+59g9SAAUX
         nvlWq6wTpHFVHbxnT09/e3xYDWZvU9oxE2idNq4hQUYhf4TV3biXASq/iPpSBoBES38w
         opBdjbLKj9XOi0MJwH36X7ySJjcuyXSERYRHPsSb3ucMtXxHnsF1oNQIq1o29OOud2DA
         dYcQEOAnwDJYcGgLTd8cwm7KxvzYC+NrMqO4922TAy0fELectQLRvsmd+mKW2LEULGV8
         UkHZL6YP7Np4skIphOdU32EHrjaoVC3YO7qloA/a+Fq/YDtHJJYxClSL58hV+RSs+wNc
         7u0Q==
X-Gm-Message-State: AOAM532ZjQ8wUJ1b2mU27cH+nXTeHidMK9dAJfYnOVKb3JyW8ULiasBl
        bdp+KEYPYrNfW8I3jfFduJiaGg==
X-Google-Smtp-Source: ABdhPJyB5ecXAXzUffiGM1dJbjfnfE0dGds42/yrzPWtCfbwq0EPQ/nLiz6UNDFK/ZaAFmaYxPPLoQ==
X-Received: by 2002:a05:6512:2027:b0:448:bdb3:a238 with SMTP id s7-20020a056512202700b00448bdb3a238mr4327418lfs.266.1647558630536;
        Thu, 17 Mar 2022 16:10:30 -0700 (PDT)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id z17-20020ac24191000000b004483a4d9a3esm575015lfh.152.2022.03.17.16.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 16:10:30 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] cpufreq: qcom-hw: fix the race between LMH worker
 and cpuhp
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-3-dmitry.baryshkov@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <83344ef3-3b37-26d0-80a9-576d5e2f5098@linaro.org>
Date:   Fri, 18 Mar 2022 01:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220309223938.3819715-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 3/10/22 12:39 AM, Dmitry Baryshkov wrote:
> qcom_lmh_dcvs_poll() can be running when the cpu is being put offline.
> This results in the following warnings and an oops. The driver would
> disable the worker, but it happens closer to the end of
> cpufreq_offline(). Change the locking in the qcom_lmh_dcvs_poll(), so
> that the worker can not run in parallel with cpufreq_offline() call.
> 
> [   55.650435] (NULL device *): dev_pm_opp_find_freq_floor: Invalid argument freq=00000000709ccbf9
> [   55.659420] (NULL device *): Can't find the OPP for throttling: -EINVAL!
> [   55.666329] Unable to handle kernel paging request at virtual address ffffadfba4bb6d81
> [   55.674491] Mem abort info:
> [   55.677363]   ESR = 0x96000004
> [   55.680527]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   55.686001]   SET = 0, FnV = 0
> [   55.689164]   EA = 0, S1PTW = 0
> [   55.692418]   FSC = 0x04: level 0 translation fault
> [   55.697449] Data abort info:
> [   55.700426]   ISV = 0, ISS = 0x00000004
> [   55.704383]   CM = 0, WnR = 0
> [   55.707455] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000a98e9000
> [   55.714354] [ffffadfba4bb6d81] pgd=0000000000000000, p4d=0000000000000000
> [   55.721388] Internal error: Oops: 96000004 [#1] SMP
> [   55.726397] Modules linked in:
> [   55.729542] CPU: 7 PID: 162 Comm: kworker/7:1H Tainted: G S      W         5.17.0-rc6-00100-g04890a1d9672 #724
> [   55.746066] Workqueue: events_highpri qcom_lmh_dcvs_poll
> [   55.751527] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   55.758669] pc : cpufreq_cpu_get_raw+0x20/0x44
> [   55.763233] lr : qcom_cpufreq_hw_get+0x10/0x64
> [   55.767799] sp : ffff800009983d10
> [   55.771207] x29: ffff800009983d10 x28: ffffaa13a4f2b000 x27: ffff7b31329f9305
> [   55.778530] x26: ffffaa13a4f30af8 x25: ffffaa13a4f4e4c8 x24: ffff7b2ec2eda000
> [   55.785851] x23: ffffffffffffffea x22: ffff7b2ec2e9fc18 x21: ffff7b2ec2e9fc00
> [   55.793170] x20: 0000000000000100 x19: ffff7b2ec2e9fcc0 x18: ffffffffffffffff
> [   55.800490] x17: 726620746e656d75 x16: 6772612064696c61 x15: ffff8000899839c7
> [   55.807812] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   55.815140] x11: ffff7b2ec2e9fc80 x10: ffffaa13a59a1a70 x9 : 0000000000000000
> [   55.822468] x8 : ffff7b2eca6917c0 x7 : ffffaa13a528b000 x6 : 0000000000000001
> [   55.829788] x5 : 0000000000040000 x4 : 000000000000024f x3 : 0000000000000000
> [   55.837116] x2 : 0000000000000100 x1 : ffffaa13a4bb6d80 x0 : 000003e800000001
> [   55.844439] Call trace:
> [   55.846951]  cpufreq_cpu_get_raw+0x20/0x44
> [   55.851155]  qcom_lmh_dcvs_poll+0x104/0x160
> [   55.855452]  process_one_work+0x288/0x69c
> [   55.859574]  worker_thread+0x74/0x470
> [   55.863336]  kthread+0xfc/0x100
> [   55.866568]  ret_from_fork+0x10/0x20
> [   55.870246] Code: b00065c1 91360021 d503233f f8625800 (f8616800)
> [   55.876501] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 44d46e52baea..7c1bb002e1c3 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -296,6 +296,23 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   	struct dev_pm_opp *opp;
>   	unsigned int freq;
>   
> +	/*
> +	 * Synchronize against CPU going offline.
> +	 * cpufreq_offline() will get the write lock on policy->rwsem.
> +	 */
> +retry:
> +	if (unlikely(!down_read_trylock(&policy->rwsem))) {
> +		mutex_lock(&data->throttle_lock);
> +		if (data->cancel_throttle) {
> +			mutex_unlock(&data->throttle_lock);
> +			return;
> +		}
> +
> +		mutex_unlock(&data->throttle_lock);
> +
> +		schedule();
> +		goto retry;
> +	}

do you see an option here to base the logic on policy->cpus mask value instead of
the semaphore lock status? I believe it should be possible, and, if so, likely
it would be preferable.

>   	/*
>   	 * Get the h/w throttled frequency, normalize it using the
>   	 * registered opp table and use it to calculate thermal pressure.
> @@ -314,9 +331,10 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   
>   	/*
>   	 * In the unlikely case policy is unregistered do not enable
> -	 * polling or h/w interrupt
> +	 * polling or h/w interrupt.
> +	 * If we are here, we have the policy->rwsem read lock,
> +	 * cancel_throttle can be toggled only with the write lock.
>   	 */
> -	mutex_lock(&data->throttle_lock);
>   	if (data->cancel_throttle)
>   		goto out;
>   
> @@ -331,7 +349,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   				 msecs_to_jiffies(10));
>   
>   out:
> -	mutex_unlock(&data->throttle_lock);
> +	up_read(&policy->rwsem);
>   }
>   
>   static void qcom_lmh_dcvs_poll(struct work_struct *work)
> 

FWIW I can add my:

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir
