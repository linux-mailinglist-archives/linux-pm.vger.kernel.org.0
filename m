Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECA4D0A40
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 22:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiCGVsy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 16:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343695AbiCGVsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 16:48:12 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8966210
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 13:47:17 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso19556258ooi.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdojC25WVGWceIMMUzvuMxibCrHu0iM2tuhlcyvUnds=;
        b=Bg4RRPU1OlwwMQXLlarxf1usWVdPJPsBl+gaWpDO64OycwN6aoL2tjEl8zjMZMazLU
         H7KGC63Ibw47VubUx9qFIXi4FO3xtPtHe8+/MvHOowy8v9aFmd64D6l2YYRjDLrmtywb
         UGRowMv0R1R+HTQ8+gpyM5QeZ29G7Vdr7RnOd0rgSR1DrQrbo7zWG6p90xhvzrgtXq1p
         XFZPtKtBQ75SKA1PdEn7l5ub/GBaKGCPGUr2wYkuhA50MCNSVBQk45VRE7GRUtUxLcqe
         YOb8VDKHoWRUUmws/iEZ/aaxE74B1EopJgdUI1PNAEBTZtOPhNRQMnqLz/fVx1ZgK4f8
         7AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdojC25WVGWceIMMUzvuMxibCrHu0iM2tuhlcyvUnds=;
        b=UItgpSYVBxeTQD6w8tKWDrM+h2h7M0dY6GfpXpyj7sSpAnoYsDoh/7QgajsdJzi2ry
         ZbEqLh89y46s5XDaP+5SGlR5BUmXYv1d/4GgktPvxk9XLkgu6C7TtDAyffowVPdJyKG3
         lI5vE+W+2mzUDGK11yC8+U2TE4CP+M3ByYA1ocTKozVqNleGIC1PUho27S8fnsI9LfxE
         c8rGonsvs+m4MxGmK63E70OrMl0x+HUZVc24OuONvziFjie8hnxJ53FfwQw+FkpupQJN
         EZHfVCzXv986Fa4CvO4C7q406bEeb/G2DM4kyWpvIH1wX2uKtVyGmdBiZ/xvc8EzfNm5
         cj2w==
X-Gm-Message-State: AOAM530U1vltqfNmdY79I9ZiqRugxY2bUX0KS9vaRW2sJwYgtYHxHRUK
        LvQInBZHHJ7r9E/zzM6I59VJqcj2u70W1g==
X-Google-Smtp-Source: ABdhPJyRfmUHvA7y8eYYxFON9aA6r+LyEuepXKZ6SPl7v3jADqcMR4oHSLR7B5HxUQIdU27AkmiOng==
X-Received: by 2002:a05:6870:d28d:b0:da:b3f:3234 with SMTP id d13-20020a056870d28d00b000da0b3f3234mr580688oae.228.1646689636634;
        Mon, 07 Mar 2022 13:47:16 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id m5-20020a056870194500b000d9a0818925sm6012406oak.25.2022.03.07.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:47:16 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:49:00 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] cpufreq: qcom-hw: fix the race between LMH worker
 and cpuhp
Message-ID: <YiZ9zFqz2hU8im4f@ripper>
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
 <20220307153050.3392700-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307153050.3392700-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 07 Mar 07:30 PST 2022, Dmitry Baryshkov wrote:

> qcom_lmh_dcvs_poll() can be running when the cpu is being put offline.
> This results in the following warning. The driver would disable the
> worker, but it happens closer to the end of cpufreq_offline(). Change
> the locking in the qcom_lmh_dcvs_poll(), so that the worker can not run
> in parallel with cpufreq_offline() call.
> 
> [   37.122433] ------------[ cut here ]------------
> [   37.127225] WARNING: CPU: 0 PID: 187 at drivers/base/arch_topology.c:180 topology_update_thermal_pressure+0xec/0x100

I don't have a warning on line 180 in arch_topology.c

I do however believe that my proposed patch for handling the race during
initialization would end up with a warning there.

As Viresh pointed out as I tried to land those upstream, they would
cause problems as policy->cpus changes during hotplug, i.e. something
very similar to what you're showing here.

Could it be that you're testing this in a tree that has those patches?


PS. The two patches that did land upstream in the end are:
4f774c4a65bf ("cpufreq: Reintroduce ready() callback")
ef8ee1cb8fc8 ("cpufreq: qcom-hw: Delay enabling throttle_irq")

> [   37.138098] Modules linked in:
> [   37.141279] CPU: 0 PID: 187 Comm: kworker/0:3 Tainted: G S                5.17.0-rc6-00389-g37c83d0b8710-dirty #713

389 patches off mainline is quite far off from the upstream, please try
to validate your changes on something closer to mainline.

Regards,
Bjorn

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
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 740518d8ae16..920c80d91c21 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -283,6 +283,23 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  	struct dev_pm_opp *opp;
>  	unsigned int freq;
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
>  	/*
>  	 * Get the h/w throttled frequency, normalize it using the
>  	 * registered opp table and use it to calculate thermal pressure.
> @@ -301,9 +318,10 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  
>  	/*
>  	 * In the unlikely case policy is unregistered do not enable
> -	 * polling or h/w interrupt
> +	 * polling or h/w interrupt.
> +	 * If we are here, we have the policy->rwsem read lock,
> +	 * cancel_throttle can be toggled only with the write lock.
>  	 */
> -	mutex_lock(&data->throttle_lock);
>  	if (data->cancel_throttle)
>  		goto out;
>  
> @@ -318,7 +336,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  				 msecs_to_jiffies(10));
>  
>  out:
> -	mutex_unlock(&data->throttle_lock);
> +	up_read(&policy->rwsem);
>  }
>  
>  static void qcom_lmh_dcvs_poll(struct work_struct *work)
> -- 
> 2.34.1
> 
