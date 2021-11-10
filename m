Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA644CA77
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhKJUWS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 15:22:18 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36503 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhKJUWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 15:22:15 -0500
Received: by mail-ot1-f45.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so5691571otl.3;
        Wed, 10 Nov 2021 12:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3jNW2QCQDMvHTOO7KqwZhMkQiqPPHGYyYUVj5rp3es=;
        b=J6JTOt/WY6p/OVDDdGV0bV9KSb6EZ1/3LGxilutlKjt1YfLMYwmMQukFr4pI+RbRqS
         iXqiS+H/Aay6IsiPma0vxt189FLbvsa9Oq7ikMC9YMOPsdeptqHvsmKUCBbuQkAPhOIW
         VL6lCCnG9RFvJWFAEg9Yipg0HKwMrz/T4Tz7ztFBihzuiZ5ttfqGeoLHmqFNL2RrhDXu
         cmXpkD9RLfHYaFNBn4HAvqUb9HBuq9mayRSmnRhk7gF6w8HSPMMMX90Z4s3JMg3Dbj6j
         nO6060aL966S1X9NyjYugH1UuTS7TUDy7oqf0HUKrolas/8MGP2hggZeS6QIO1FXjdqv
         3gSw==
X-Gm-Message-State: AOAM533zN7EKAVYEz1b/IL/Biwl/9ZQ/V+8VSuBDNM2cnfAl2oFB1L8U
        vev1hzVoDPya78d4NhlcTomzsyyphUNpU7m6PM8=
X-Google-Smtp-Source: ABdhPJykLe7+FFt1wcRzRXrPpv/IUwIhd6JPATkeg3lh62mklJuj0p52asKmTs7c3AoQAWKJppE86PMewJyJQ+ofLj8=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr1584176otg.198.1636575566826;
 Wed, 10 Nov 2021 12:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20211107095001.GC11442@xsang-OptiPlex-9020> <20211108062345.273855-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211108062345.273855-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Nov 2021 21:19:15 +0100
Message-ID: <CAJZ5v0hYFiGa4MwiEx6czRPdEZmxWS7Wom5DKD2VueoDn+r3oA@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/dtpm_cpu: Fix suspend failure and kernel warning
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 8, 2021 at 7:24 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> When the ENERGY_MODEL and DTPM_CPU are enabled but actually without
> any energy model, at cpu hotplug time, the dead cpuhp callback fails
> leading to the warning.
>
> Actually, the check could be simplified and we only do an action if
> the dtpm cpu is enabled, otherwise we bail out without error.
>
> Fixes: 7a89d7eacf8e ("powercap/drivers/dtpm: Simplify the dtpm table")
> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Tested-by: Kenneth R. Crudup <kenny@panix.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: lkp@lists.01.org
> Cc: lkp@intel.com
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm_cpu.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 69eb5101b5c7..477042199d90 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -166,16 +166,13 @@ static struct dtpm_ops dtpm_ops = {
>
>  static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
>  {
> -       struct em_perf_domain *pd;
>         struct dtpm_cpu *dtpm_cpu;
>
> -       pd = em_cpu_get(cpu);
> -       if (!pd)
> -               return -EINVAL;
> -
>         dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
> +       if (dtpm_cpu)
> +               dtpm_update_power(&dtpm_cpu->dtpm);
>
> -       return dtpm_update_power(&dtpm_cpu->dtpm);
> +       return 0;
>  }
>
>  static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> --

Applied as 5.16-rc material, thanks!
