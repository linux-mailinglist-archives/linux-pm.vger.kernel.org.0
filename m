Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EED4DD106
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 00:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiCQXFP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 19:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiCQXFO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 19:05:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616C220339
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:03:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g24so7999481lja.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aKa0E4vOM6XoErNr1Xiu6o5gCsnymkd7sAmW4KaQ+iA=;
        b=EQQ6F7sYc1Ye6/74Io/KKl31RQWQ/PjVx7woJjhZ5YD6ceEXNQz8PymRx8D8GVXJdE
         gealtedFZimlzccdfpOURcO16gPenpmY+G4zzpOwVPa5juQvnlBqFnjOok/vCmxT58pp
         QJfweg/xmMooF/eR6OqNW2ZM/SSQCqy6YB7tBSZBs9sTYmqbWH6KO0OCeWcogXgZ5ABc
         l8csxA2dGrmezP+8/4m+aa4t4LXL4HOQOGyoWMCEsdPexGN0WJuA8uOiDpX9zIdUiAwz
         PDe5TtHHnA6XPovcjFgSnap9+UEhUKiI8qu/GqWi9ZaJrytElJIVeTvWwBzxMRwVmQTO
         /pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aKa0E4vOM6XoErNr1Xiu6o5gCsnymkd7sAmW4KaQ+iA=;
        b=ONPL5pVjha4h0CytODmkZRsljOgIBq6lKm9Yhp6hweOotP28MSgu82Sm7DvKmdwIHw
         u6mL6nO8XJOgbVGnu3aQe7/2JjMcyGpURjiGOpa2SHe5BpoDRVpkDfGmNeqispvqrXYA
         mp8Kh8jPJU80O84Kzvu6qzufleNrpkI2spm5xQkwhzwb5KeC8W0Nsq6mdU8UGXOgVI0N
         jKjJulnXyEZLYcPbidampRNlHUd8u7Rk0kLtDAK+P59PFIBhDAs1L7+arxMPZJwk4CQP
         Sm2u6gHK7PNCRJACz81eEBS/XYo3IqzxdDE6nxBYsHFp0wfSemt7CMgM15IRJiaAQos+
         jLIg==
X-Gm-Message-State: AOAM530IxU8ixCMsu/DYRaww5nR05gYBWHNelQf34vW02gY7vIzvq7jJ
        UVa3BFw3Yof7GlSS+2B/fuHvr7m4yvprGd55
X-Google-Smtp-Source: ABdhPJxAAY/Pk2SqceL1+NfftMV+b1rXLlo7NjhthxiXqJU7gi935PAMCSKDSRKBfcxOTAQknU8pxg==
X-Received: by 2002:a05:651c:1a22:b0:249:1ef2:e4c7 with SMTP id by34-20020a05651c1a2200b002491ef2e4c7mr4335490ljb.15.1647558234993;
        Thu, 17 Mar 2022 16:03:54 -0700 (PDT)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id k11-20020ac2456b000000b004482043aac1sm571485lfm.263.2022.03.17.16.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 16:03:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] cpufreq: qcom-hw: drop affinity hint before
 freeing the IRQ
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-2-dmitry.baryshkov@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <d9fbc710-1bea-b6e9-4358-ab2ef0e941fa@linaro.org>
Date:   Fri, 18 Mar 2022 01:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220309223938.3819715-2-dmitry.baryshkov@linaro.org>
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
> Drop affinity hint before freeing the throttling IRQ to fix the
> following trace. One is not allowed to call free_irq() with an affinity
> hint in place (which was set by qcom_cpufreq_hw_lmh_init()).
> 
> [  185.114773] ------------[ cut here ]------------
> [  185.119517] WARNING: CPU: 7 PID: 43 at kernel/irq/manage.c:1887 free_irq+0x3a4/0x3dc
> [  185.127474] Modules linked in:
> [  185.130618] CPU: 7 PID: 43 Comm: cpuhp/7 Tainted: G S      W         5.17.0-rc6-00386-g67382a5b705d-dirty #690
> [  185.147125] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  185.154269] pc : free_irq+0x3a4/0x3dc
> [  185.158031] lr : free_irq+0x33c/0x3dc
> [  185.161792] sp : ffff80000841bc90
> [  185.165195] x29: ffff80000841bc90 x28: ffffa6edc5c3d000 x27: ffff6d93729e5908
> [  185.172515] x26: 0000000000000000 x25: ffff6d910109fc00 x24: ffff6d91011490e0
> [  185.179838] x23: ffff6d9101149218 x22: 0000000000000080 x21: 0000000000000000
> [  185.187163] x20: ffff6d9101149000 x19: ffff6d910ab61500 x18: ffffffffffffffff
> [  185.194487] x17: 2e35202020202020 x16: 2020202020202020 x15: ffff80008841b9a7
> [  185.201805] x14: 00000000000003c9 x13: 0000000000000001 x12: 0000000000000040
> [  185.209135] x11: ffff6d91005aab58 x10: ffff6d91005aab5a x9 : ffffc6a5ad1c5408
> [  185.216455] x8 : ffff6d91005adb88 x7 : 0000000000000000 x6 : ffffc6a5ab5a91f4
> [  185.223776] x5 : 0000000000000000 x4 : ffff6d91011490a8 x3 : ffffc6a5ad266108
> [  185.231098] x2 : 0000000013033204 x1 : ffff6d9101149000 x0 : ffff6d910a9cc000
> [  185.238421] Call trace:
> [  185.240932]  free_irq+0x3a4/0x3dc
> [  185.244334]  qcom_cpufreq_hw_cpu_exit+0x78/0xcc
> [  185.248985]  cpufreq_offline.isra.0+0x228/0x270
> [  185.253639]  cpuhp_cpufreq_offline+0x10/0x20
> [  185.258027]  cpuhp_invoke_callback+0x16c/0x2b0
> [  185.262592]  cpuhp_thread_fun+0x190/0x250
> [  185.266710]  smpboot_thread_fn+0x12c/0x230
> [  185.270914]  kthread+0xfc/0x100
> [  185.274145]  ret_from_fork+0x10/0x20
> [  185.277820] irq event stamp: 212
> [  185.281136] hardirqs last  enabled at (211): [<ffffc6a5ac57973c>] _raw_spin_unlock_irqrestore+0x8c/0xa0
> [  185.290775] hardirqs last disabled at (212): [<ffffc6a5ac572100>] __schedule+0x710/0xa10
> [  185.299081] softirqs last  enabled at (0): [<ffffc6a5ab50f7b0>] copy_process+0x7d0/0x1a14
> [  185.307475] softirqs last disabled at (0): [<0000000000000000>] 0x0
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 618e436018c0..44d46e52baea 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -427,6 +427,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>   	mutex_unlock(&data->throttle_lock);
>   
>   	cancel_delayed_work_sync(&data->throttle_work);
> +	irq_set_affinity_hint(data->throttle_irq, NULL);
>   	free_irq(data->throttle_irq, data);
>   }
>   
> 

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir
