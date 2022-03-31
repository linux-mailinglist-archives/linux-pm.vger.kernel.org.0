Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34534EE077
	for <lists+linux-pm@lfdr.de>; Thu, 31 Mar 2022 20:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiCaScf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Mar 2022 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiCaSce (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2022 14:32:34 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A401403FD
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 11:30:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de3eda6b5dso237647fac.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=12COArG/0kW1ReQnxEs8p+rNzj9eJeHHcRr9VT9c/go=;
        b=MlabMwUY+f5xlFEVtJOV0azQSRDNc4MwxY46T6Kndu7bmgbN2uzGM01nYpVM41XLcr
         r9nkx+mEK7Am54IQK7lWuQnRAoX7iTsRFQsZaU3vND2RgOkP0NiSGjNsZU1ZbcpjXCm1
         9Gu/0CMN/DnRSqifJlW4lxkXTienNrXYmvGdteoullVEN1rFiqd8jY/obaAe9SSxBid/
         nVRucri6540KQEMFdBwZ159DVHxvgCiRhFWnMf6/LRZlB65Zww6GMRKqX+ZWDhuVOyLi
         W4/aljrAV7ycNSex2piYcCbTKajM3g/YlAplbteU5KYnJqfNpcL7z7k2VH983HfSsWEh
         K0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=12COArG/0kW1ReQnxEs8p+rNzj9eJeHHcRr9VT9c/go=;
        b=zOfY0Mvl+pYTAvs5VtGr47tva4NREJ/n1rooms7GxcQhsPsl5kug/fkom4MEk86uGr
         TOf3nT7TvWOYv84XuIQJV1pGZGVNcZwX0S7rFdCbgBcNy8Gye2vxtNIV6jHdTophQMrg
         tZrMkwOYranX+dUbwymFQs+TPdn81oCOSFp+OFkKPtyIhNMvn0EnKXox+0HzPTDJ8VU4
         n06KeaUkoWdLbUGY3VHMta0E0co0grTZVEU3BkIZZ3UQTCZO5J05XiO07u/iGKE1Lf22
         ExOllcHwYo+ZcWjkgRQQDaMJXcqrLcweT1Gj2HamGPZTA98qXdRmzL3mhos9vmefH9LE
         N4OA==
X-Gm-Message-State: AOAM530bo+Bm1R/c8gnwBDUKS32TuJyA+5XYKUJ8cAgaiQJzc3U9oMsH
        uCSN2PrHXjfWXav9VQvmqHxvZg==
X-Google-Smtp-Source: ABdhPJyW8FyUaaqt4ci3kVBMRememQmdGDXsoC9JihNV6PWaq1+9+BTJ30aXZ02x/gzJmFhhrJOGvA==
X-Received: by 2002:a05:6870:961c:b0:df:27ec:ed7f with SMTP id d28-20020a056870961c00b000df27eced7fmr3194195oaq.275.1648751446087;
        Thu, 31 Mar 2022 11:30:46 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id y7-20020a4a6247000000b00324e9bf46adsm92808oog.41.2022.03.31.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:30:45 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:33:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v4 2/4] cpufreq: qcom-hw: fix the race between LMH worker
 and cpuhp
Message-ID: <YkXz61vmG9f3ETRX@ripper>
References: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
 <20220326155153.7377-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326155153.7377-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat 26 Mar 08:51 PDT 2022, Dmitry Baryshkov wrote:

> The driver would disable the worker when cpu is being put offline, but
> it happens closer to the end of cpufreq_offline(). The function
> qcom_lmh_dcvs_poll() can be running in parallel with this, when
> policy->cpus already has been updated. Read policy->related_cpus
> instead.
> 
> [   37.122433] ------------[ cut here ]------------
> [   37.127225] WARNING: CPU: 0 PID: 187 at drivers/base/arch_topology.c:180 topology_update_thermal_pressure+0xec/0x100
> [   37.138098] Modules linked in:
> [   37.141279] CPU: 0 PID: 187 Comm: kworker/0:3 Tainted: G S                5.17.0-rc6-00389-g37c83d0b8710-dirty #713
> [   37.158306] Workqueue: events qcom_lmh_dcvs_poll
> [   37.163095] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   37.170278] pc : topology_update_thermal_pressure+0xec/0x100
> [   37.176131] lr : topology_update_thermal_pressure+0x20/0x100
> [   37.181977] sp : ffff800009b6bce0
> [   37.185402] x29: ffff800009b6bce0 x28: ffffd87abe92b000 x27: ffff04bd7292e205
> [   37.192792] x26: ffffd87abe930af8 x25: ffffd87abe94e4c8 x24: 0000000000000000
> [   37.200180] x23: ffff04bb01177018 x22: ffff04bb011770c0 x21: ffff04bb01177000
> [   37.207567] x20: ffff04bb0a419000 x19: 00000000000c4e00 x18: 0000000000000000
> [   37.214954] x17: 000000040044ffff x16: 004000b2b5503510 x15: 0000006aaa1326d2
> [   37.222333] x14: 0000000000000232 x13: 0000000000000001 x12: 0000000000000040
> [   37.229718] x11: ffff04bb00400000 x10: 968f57bd39f701c8 x9 : ffff04bb0acc8674
> [   37.237095] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffffd87abd90092c
> [   37.244478] x5 : 0000000000000016 x4 : 0000000000000000 x3 : 0000000000000100
> [   37.251852] x2 : ffff04bb0a419020 x1 : 0000000000000100 x0 : 0000000000000100
> [   37.259235] Call trace:
> [   37.261771]  topology_update_thermal_pressure+0xec/0x100
> [   37.267266]  qcom_lmh_dcvs_poll+0xbc/0x154
> [   37.271505]  process_one_work+0x288/0x69c
> [   37.275654]  worker_thread+0x74/0x470
> [   37.279450]  kthread+0xfc/0x100
> [   37.282712]  ret_from_fork+0x10/0x20
> [   37.286417] irq event stamp: 74
> [   37.289664] hardirqs last  enabled at (73): [<ffffd87abdd78af4>] _raw_spin_unlock_irq+0x44/0x80
> [   37.298632] hardirqs last disabled at (74): [<ffffd87abdd71fc0>] __schedule+0x710/0xa10
> [   37.306885] softirqs last  enabled at (58): [<ffffd87abcc90410>] _stext+0x410/0x588
> [   37.314778] softirqs last disabled at (51): [<ffffd87abcd1bf68>] __irq_exit_rcu+0x158/0x174
> [   37.323386] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 44d46e52baea..d39a0ef9ea45 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -290,7 +290,7 @@ static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>  static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  {
>  	struct cpufreq_policy *policy = data->policy;
> -	int cpu = cpumask_first(policy->cpus);
> +	int cpu = cpumask_first(policy->related_cpus);
>  	struct device *dev = get_cpu_device(cpu);
>  	unsigned long freq_hz, throttled_freq;
>  	struct dev_pm_opp *opp;
> -- 
> 2.35.1
> 
