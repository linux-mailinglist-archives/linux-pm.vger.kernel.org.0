Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471F74D5CF7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Mar 2022 09:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiCKIFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Mar 2022 03:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCKIFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2022 03:05:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB677666C
        for <linux-pm@vger.kernel.org>; Fri, 11 Mar 2022 00:04:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bt26so13725437lfb.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Mar 2022 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IkoY8G9+086sgc/LyUoYvULb/93T0Z8aZS68S6B3ohQ=;
        b=Jl3znvTsi7Nxfs+wFrrm+V34YzsFu9RDWSHlBMxpWGm4+V2XKzZWUHpZSqQNFr0fVw
         Lty6oeQ6Zjzez1BKE+T8DjuQqceQvsZh0bTPGnGifxnbC5YBf9t3g56BTBYAmgikwXpf
         1BmRIgC9Xp/zo5LH/MEzxwtJl08/JQ5gv2+rxvps2Pn7hSV8R294L3jXr3cUmgk4TKmw
         DXqWjvoTA2UeZ8XTSrmrjcImH2f1DMzpjrf75LzFeHL9E9HTwHDQOElsxD5Iyh5SYNvZ
         ZOV0PbcnzbmJH3FuT6jp4/R3FWGlfIgQZYNNOZwNRMqklkDldVH6D2DiHHvm/5Uslduq
         xWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IkoY8G9+086sgc/LyUoYvULb/93T0Z8aZS68S6B3ohQ=;
        b=A3eB6YqQUpwmDJG+yJdFbUS1lB9EzeElB70fQk6+LxkRR/E8ODIoq9XX6KiRR31DJs
         I9HVvy7ED/+vTprljv5/ZLSzrlt/ToIOKDD+83x+cI3+SzYG+c03339K3TpLHE31p+/N
         UubArKdvB8xGFrAUbEluTRyWwQThX24xntXGzRvQrS7geNoKKArRCE4nUhut7/zR7Kt6
         l/OUm8oA8hWNYXRMIfjgUUg87TEldFymF5qcbjzkn+SgqzoJlxypmLdEbK3Fuzi1SjxQ
         1OYrpOaUfVJ9ws7WOJgPdh22T2MyQb3fI9EebgPyqWyRzdAegofWuOZZd+RQA4b3AFKS
         Y+YQ==
X-Gm-Message-State: AOAM531Dh+Ul/LzLtu5xXdYwknjsxQWLC6ZDHy3kpJNJchEKZeZ9Ybkc
        FH3RK7B9AdUmUc7i4lV3QRtbXA==
X-Google-Smtp-Source: ABdhPJxdwGenj5xlpgrfBIKfu8pAvIdqeHCYu0baOB+35Jz90jduZVXA5dv+qcchDIScwBxCM6uCyQ==
X-Received: by 2002:a05:6512:3248:b0:448:3231:2800 with SMTP id c8-20020a056512324800b0044832312800mr5611096lfr.24.1646985846289;
        Fri, 11 Mar 2022 00:04:06 -0800 (PST)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id bp3-20020a056512158300b0044318361eedsm1451084lfb.204.2022.03.11.00.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 00:04:05 -0800 (PST)
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
Message-ID: <ececf5e0-f8dd-03b8-18b1-bccf93b6c28f@linaro.org>
Date:   Fri, 11 Mar 2022 10:03:49 +0200
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

I suppose the fixed commit is 3ed6dfbd3bb98 ("cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts")

Otherwise looks correct.

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

--
Best wishes,
Vladimir
