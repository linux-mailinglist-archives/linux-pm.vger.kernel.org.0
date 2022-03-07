Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD494D0A45
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiCGVub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiCGVu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 16:50:27 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5675613
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 13:49:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 12so16784499oix.12
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zfqWCmNF93ndPFXSv4QIBrq8EZ2SC7a6VA614x+TUnE=;
        b=shDY97p7I1uyQabU6J+jzftvf6umzae1jHePFV0Lz2wgJ1UcnJjf4lrjVwe7Tf6N47
         HZQ3CXxNbP1Cc/9mtwFLElmY1nGyj3fHV/LW3BmuMuzUHnUcj3p9s6jf2zGoB1uTBl3L
         hIA6s7/5plQpZ8YRTImRnSoajfwE2UvR13I9BWZQD2DOzOZvsru5HPzt39mBLFWE4rfb
         Hw99htBY29EHZpeOSxOXt/uIpxUrr6vjoi5qoPU7n5Kw0KAvpfvcJkstnfcGKviMAkch
         /NN91mFWSYNGeH7gsfiAyinhRhADZdoVTApqL+/n04dmsPQaIwpOYSu7ze4hQBK3vLz2
         BIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zfqWCmNF93ndPFXSv4QIBrq8EZ2SC7a6VA614x+TUnE=;
        b=MXXECthxGhVrMQ26EmubMFcVjVO+XEzWLqrMBZOqN/zqfiQvokk3WQNRF87N3jpR1E
         +TzK3/1LmT3+jTGc4732+AmI9CmjezBWRMyrNFIIu9iA0A/l25MLDQG7VG2nJyAvlf2k
         hvxd5hr29tAI/RzxQKFiLqlrFulnPVX28VUjOQfMorLz92YFwFvLTv9c6N7f5iz3xGqG
         GWNhGOBOOsag+/+bWyYRAc4Y1nLG6UhfiQCffR9QcOv1YjIxBRs8c8eImazojn3PpTW4
         fzfhuUJtn9g6SP1lWUOsN83et6j+rnfrDDtCxyyWvdLgI5D5+3AK5OwuSyakGaseVVXd
         s4UA==
X-Gm-Message-State: AOAM532Qyuwf954nkPazlBuNJxEN/23YY7OiDVPCKyhUlUWwrlr7DGme
        z7yO2qtXMIMLCk2Cly9kX/yd0Q==
X-Google-Smtp-Source: ABdhPJxd4XqRZVCtcapXK8E337XSK8otMU7IlqgivuLS+CNCqBiAXZP42JPQLdB8WMVbrqq7bp4uJA==
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id r11-20020a056808210b00b002d9a6d3b029mr680628oiw.182.1646689770944;
        Mon, 07 Mar 2022 13:49:30 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d62da000000b005b23f5488cdsm1089567otk.52.2022.03.07.13.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:49:30 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:51:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: qcom-hw: drop affinity hint before freeing
 the IRQ
Message-ID: <YiZ+UuionW6DsLQX@ripper>
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 07 Mar 07:30 PST 2022, Dmitry Baryshkov wrote:

> Drop affinity hint before freeing the throttling IRQ to fix the
> following trace:

Rather than relying on the reader of the git log having to read the
free_irq() implementation to figure out what the problem is, this could
simply state that one isn't allowed to free_irq() something with
affinity set.

Regards,
Bjorn

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
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index effbb680b453..740518d8ae16 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -412,6 +412,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
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
