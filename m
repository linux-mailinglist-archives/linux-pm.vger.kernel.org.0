Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881324BA0EE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbiBQNVe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 08:21:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiBQNVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 08:21:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F82AED91
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 05:21:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m14so9936038lfu.4
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqpYw2hU4AfMpdecnlYRUtKQoN8L8CwL4tdQrOzhrbU=;
        b=LRBqktU2LOQCmUCWKN0qyj83PggUYqy2Lc8PnzwmA5idChQi2M2xA/M8JT/++U5Rh4
         Hm5L9TVlVW6zdcMkm6uuV7p7mROFpt2i/CL6P9C4bSgHpuAoX+ADnWVPNO18Di0aAx9X
         I8szoh+0W9ftm4sEBiy/zvI7g5mvWjYzbG1l7zyz8yhU7sXZSnxrPpKdrHlzv+6jeFce
         Q4UyojvMCEyhJVpn+245RhWAWr6PbYI06qlq7ev1bEaKv7WfHpJVopOrDj52gZhYxFkh
         LWQMBDCxNfHg4LcM2HaVS1vz3Exi6UxgnqWKi31v8Hg+vVD2q4xY3rY6nxfLkhUHPELc
         kw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqpYw2hU4AfMpdecnlYRUtKQoN8L8CwL4tdQrOzhrbU=;
        b=hEXLbmHtvO1kBHnI8o7NfcbgZl3KpiXtXRNBNZOCY6aZk7onKEDYJIgulx1MSHkq7r
         RBaqkaVU4PWPxPMQy02YoRD8RQJ9uBLil7za99LmC/JempZbbthZQ7M9kuOen5j0q8PM
         oVUAInZIzYBObwCQ950c264VD698p+fXHVi1FarwbBMcWtjM9TPOhM5BA0a790jiUWVu
         B0uuBlrXTJcganjv8lzQW8Z3ANvvs+dUjk0VGJpb+5ESJ/WBbfQW5Gmp1O5U9RSoovhz
         GKu6AT4sn6gGJuzSpf3tu1rvXkqQp10KXQrg55nIgIamJVat9wzzb70SfnuhfWOhbeV7
         5EtA==
X-Gm-Message-State: AOAM5309dulFyLQaxomgZXP5BDQ9ze9pCtKjGztfLR38YmxdArrfb/0v
        9ilT0CLZEThPnGtPc3oyPq3YkN5yg3LQunCCb4IKZQ==
X-Google-Smtp-Source: ABdhPJxQJwQ1+7LNtV1FQqLhYGYhR1qKHRiyqfHQCaDjPzoi2G7bYLOg4pwG0lFVTZmnzQgRAaOCO5LhX1us6kgS5yw=
X-Received: by 2002:a05:6512:2241:b0:441:ce2b:18ef with SMTP id
 i1-20020a056512224100b00441ce2b18efmr2059121lfu.167.1645104077907; Thu, 17
 Feb 2022 05:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-6-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-6-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:20:41 +0100
Message-ID: <CAPDyKFrX2tR_FdJ+SVJSBGso086Db8FpZiPv5m7FwQ9PLmMEEQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] powercap/dtpm/dtpm_cpu: Add exit function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Now that we can destroy the hierarchy, the code must remove what it
> had put in place at the creation. In our case, the cpu hotplug
> callbacks.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/powercap/dtpm_cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 71f45d2f5a60..bca2f912d349 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -299,8 +299,15 @@ static int dtpm_cpu_init(void)
>         return 0;
>  }
>
> +static void dtpm_cpu_exit(void)
> +{
> +       cpuhp_remove_state_nocalls(CPUHP_AP_ONLINE_DYN);
> +       cpuhp_remove_state_nocalls(CPUHP_AP_DTPM_CPU_DEAD);
> +}
> +
>  struct dtpm_subsys_ops dtpm_cpu_ops = {
>         .name = KBUILD_MODNAME,
>         .init = dtpm_cpu_init,
> +       .exit = dtpm_cpu_exit,
>         .setup = dtpm_cpu_setup,
>  };
> --
> 2.25.1
>
