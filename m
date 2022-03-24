Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3A4E6698
	for <lists+linux-pm@lfdr.de>; Thu, 24 Mar 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbiCXQF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Mar 2022 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiCXQF0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2022 12:05:26 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253EC4925D
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2022 09:03:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w17-20020a056830111100b005b22c584b93so3578559otq.11
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2022 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fn2pXP9+ZdFW2HbCJBs5l/PTZ0dnRlKePUxoWYiAI7U=;
        b=pBoEHD4S82XFDlc55xyH+yxJI0WC7GlOoCkDUlR3GDdY6BkjwECbdxsGhil/ijw1vY
         ejgjvvA1uk4bLJ5r4sv6j3ro0zuZOMaK0deIYrQTQXV51Ou6/lxMVgYMmPStG/OTuC/B
         X5TpjONCw+7ztT+GHpDbuxQlDt3+XyUQdpaVXoumP3Zpvu10EemiAYymwL0ctRmYMacF
         Xa/F1Vx2w6+5Ux3+5Rx2Rsm/JjtRNL5toTuYpMc6/6OKy21IRAxSTJqIrXukIalCoTHZ
         Mt4I+FII5G7AEtebzrtIw+cau017JJoD8OG3yspmDaWwmTNUKa+/ckNZkz7VVU/G3EYV
         Pedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fn2pXP9+ZdFW2HbCJBs5l/PTZ0dnRlKePUxoWYiAI7U=;
        b=qcMMjwcfAhg/8qd/Xyu+pivnaRziniUxXBEU7IRTaL5JSsyXP1Zu9/TKf8U+ptenQ3
         Y+YEme/PgZG+VO5RVdZgXDIzXHXUNof2GG+djLReRm5IUpXdiTHng2DoqVcAIVS1dLVo
         1xo38MvM2/hqPAcz8GuS3+zA9vEcIaMeTYXjHDJ3Fq773ieU65OqhINaEecwLcBBriZy
         Kj1NJVoc8q5Wh/aklURJQ8o5g4SD2XBCGXe0ofxLb4l5Lr/zpsabRjSfLj0Bsxcg9r/K
         f6/ysZMOQncdRaRgqwqhFqCGCdCYBDyt9Y4KC8lghWdhT7+SiF59MTn3f0fV1f1Booxk
         9TBA==
X-Gm-Message-State: AOAM533ee4QaZtGuE+Q4HAwL43HNzeXnKnhZ0XuTyOa8zBWgUk0WQ8Q8
        bWzC2awPLMNTW+PI/vlEuEUAZQ==
X-Google-Smtp-Source: ABdhPJyoxWOPbPPEwPbiGsiAX8kQn2HHBqSmmwJ5h4zGAVUOFaithf0KmtyB6OZmXa4vRc24w+wWuw==
X-Received: by 2002:a05:6830:231c:b0:5b2:5e8a:14b5 with SMTP id u28-20020a056830231c00b005b25e8a14b5mr2460758ote.295.1648137829480;
        Thu, 24 Mar 2022 09:03:49 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id e12-20020a4aa60c000000b00324bb45d7ecsm1339447oom.48.2022.03.24.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:03:48 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:05:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v2 1/4] cpufreq: qcom-hw: drop affinity hint before
 freeing the IRQ
Message-ID: <YjyWtg8SbmUKNWZl@ripper>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309223938.3819715-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 09 Mar 14:39 PST 2022, Dmitry Baryshkov wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 618e436018c0..44d46e52baea 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -427,6 +427,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>  	mutex_unlock(&data->throttle_lock);
>  
>  	cancel_delayed_work_sync(&data->throttle_work);
> +	irq_set_affinity_hint(data->throttle_irq, NULL);
>  	free_irq(data->throttle_irq, data);
>  }
>  
> -- 
> 2.34.1
> 
