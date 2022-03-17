Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE8B4DD10A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiCQXFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiCQXFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 19:05:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1482D0262
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:04:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s29so11421296lfb.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v5hUaXa8DWIIvu8HBz6v0ZliXpDUSika1ERBd0isrCY=;
        b=mrCpdvfXkCvXyxDzEuS46z1qzhc2PCiMOgw4oCy47qM3TrVL758vRm7+rpwJsuGJB5
         tfhGeToXcGTvBDtVM/+teUVPdvjXyHewJf245tWqnyNwk2fF9xH0NPTWphRqFvTIzVpA
         4nnNJaClQGP3Q4tUGC9qI/bmLLmBeCaHpRlxxzaYAsLJbj9JCZQ0+NWRfDvjll1GsQoY
         mYF+qh5iVyzLvDb+IcTfDB8HWqIkCFkMUBqBDKob9fibOVV1RzSynpTuU3BPLBYKt4C3
         E/o4SSCW6JgkPHFvXx6wzhvDAArm9C/0iha/sDSzaARDXzIu45t8wBZ6trHhdrhQB6pX
         DPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v5hUaXa8DWIIvu8HBz6v0ZliXpDUSika1ERBd0isrCY=;
        b=BnkDFao6uB9CE3RmjhhkPMSe5E27UOsXHgDj1x+zj12gR/j76oTSxRSvh6ZwdVkT6B
         8+sq+OcozZMkGy4Ye7GtnUbats769kvkddn68hcSXA1PapF/+9bBOqr6oIjUE8FPhAHV
         IAHexsLsxzXJOL/1XKdUyE4gldoJZBxulQ+yu9kQBr0LGb1dki874qXZLoOcF1G9hC58
         99nwHmRltuAokAuLVCUiBIrXWwSBaPzkoTMlsrkt32JDrOYjQpkv2D4EtBscgF1njrFB
         xwpBPwTRRzbXboUwwWdJmuEwSQJd0hZ9lepwuTURKRtB8ym5Ur+NKXIqW3dm02zDBmMT
         Df5w==
X-Gm-Message-State: AOAM530NHaU5+E7r8v6xEsBZeKFrMP3RKbZnhrk4jUG90RVNQHmg0oJK
        YUYI5scorePEFXsbi+ax8JAbfA==
X-Google-Smtp-Source: ABdhPJzJ8XD5VtxU4x5ket2sf9WXey3/1Xcx+NqZE4qSVWMWRFpY2/QC/ILIS4W26SImtmkXpS5XYA==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id y1-20020a056512334100b00433b033bd22mr4357991lfd.190.1647558273203;
        Thu, 17 Mar 2022 16:04:33 -0700 (PDT)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id 8-20020a2e1548000000b002463639d0f2sm566982ljv.68.2022.03.17.16.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 16:04:32 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] cpufreq: qcom-hw: fix the opp entries refcounting
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-4-dmitry.baryshkov@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <a170ee49-1f34-f170-7342-f04c0556ab8b@linaro.org>
Date:   Fri, 18 Mar 2022 01:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220309223938.3819715-4-dmitry.baryshkov@linaro.org>
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
> The qcom_lmh_dcvs_notify() will get the dev_pm_opp instance for
> throttling, but will not put it, ending up with leaking a reference
> count and the following backtrace when putting the CPU offline.
> 
> Correctly put the reference count of the returned opp instance.
> 
> [   84.418025] ------------[ cut here ]------------
> [   84.422770] WARNING: CPU: 7 PID: 43 at drivers/opp/core.c:1396 _opp_table_kref_release+0x188/0x190
> [   84.431966] Modules linked in:
> [   84.435106] CPU: 7 PID: 43 Comm: cpuhp/7 Tainted: G S                5.17.0-rc6-00388-g7cf3c0d89c44-dirty #721
> [   84.451631] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [   84.458781] pc : _opp_table_kref_release+0x188/0x190
> [   84.463878] lr : _opp_table_kref_release+0x78/0x190
> [   84.468885] sp : ffff80000841bc70
> [   84.472294] x29: ffff80000841bc70 x28: ffff6664afe3d000 x27: ffff1db6729e5908
> [   84.479621] x26: 0000000000000000 x25: 0000000000000000 x24: ffff1db6729e58e0
> [   84.486946] x23: ffff8000080a5000 x22: ffff1db40aad80e0 x21: ffff1db4002fec80
> [   84.494277] x20: ffff1db40aad8000 x19: ffffb751c3186300 x18: ffffffffffffffff
> [   84.501603] x17: 5300326563697665 x16: 645f676e696c6f6f x15: 00001186c1df5448
> [   84.508928] x14: 00000000000002e9 x13: 0000000000000000 x12: 0000000000000000
> [   84.516256] x11: ffffb751c3186368 x10: ffffb751c39a2a70 x9 : 0000000000000000
> [   84.523585] x8 : ffff1db4008edf00 x7 : ffffb751c328c000 x6 : 0000000000000001
> [   84.530916] x5 : 0000000000040000 x4 : 0000000000000001 x3 : ffff1db4008edf00
> [   84.538247] x2 : 0000000000000000 x1 : ffff1db400aa6100 x0 : ffff1db40aad80d0
> [   84.545579] Call trace:
> [   84.548101]  _opp_table_kref_release+0x188/0x190
> [   84.552842]  dev_pm_opp_remove_all_dynamic+0x8c/0xc0
> [   84.557949]  qcom_cpufreq_hw_cpu_exit+0x30/0xdc
> [   84.562608]  cpufreq_offline.isra.0+0x1b4/0x1d8
> [   84.567270]  cpuhp_cpufreq_offline+0x10/0x6c
> [   84.571663]  cpuhp_invoke_callback+0x16c/0x2b0
> [   84.576231]  cpuhp_thread_fun+0x190/0x250
> [   84.580353]  smpboot_thread_fn+0x12c/0x230
> [   84.584568]  kthread+0xfc/0x100
> [   84.587810]  ret_from_fork+0x10/0x20
> [   84.591490] irq event stamp: 3482
> [   84.594901] hardirqs last  enabled at (3481): [<ffffb751c13c3db0>] call_rcu+0x39c/0x50c
> [   84.603119] hardirqs last disabled at (3482): [<ffffb751c236b518>] el1_dbg+0x24/0x8c
> [   84.611074] softirqs last  enabled at (310): [<ffffb751c1290410>] _stext+0x410/0x588
> [   84.619028] softirqs last disabled at (305): [<ffffb751c131bf68>] __irq_exit_rcu+0x158/0x174
> [   84.627691] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 7c1bb002e1c3..fe638e141003 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -322,12 +322,18 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   
>   	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
>   	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
> -		dev_pm_opp_find_freq_ceil(dev, &freq_hz);
> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
>   
> -	throttled_freq = freq_hz / HZ_PER_KHZ;
> +	if (IS_ERR(opp)) {
> +		dev_warn_ratelimited(dev, "Can't find the OPP for throttling: %pe!\n", opp);
> +	} else {
> +		throttled_freq = freq_hz / HZ_PER_KHZ;
> +
> +		/* Update thermal pressure (the boost frequencies are accepted) */
> +		arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
>   
> -	/* Update thermal pressure (the boost frequencies are accepted) */
> -	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
> +		dev_pm_opp_put(opp);
> +	}
>   
>   	/*
>   	 * In the unlikely case policy is unregistered do not enable
> 

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir
