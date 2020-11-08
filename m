Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205862AAA53
	for <lists+linux-pm@lfdr.de>; Sun,  8 Nov 2020 10:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgKHJ1n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 04:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgKHJ1l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2020 04:27:41 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BDC0613CF;
        Sun,  8 Nov 2020 01:27:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so7963057lfo.5;
        Sun, 08 Nov 2020 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1P0sLZeM+9gDyjPoTyis2g+fl//04kPmhTkJ+3czYA=;
        b=UqK5bERtp2v+yTvMC5jRbEfNBo5l5ORhw4fYQH3uG4DXzJf1sIhf5tKwQEE0E/XPd7
         oYOgX6254K3o11XkPHVd9HkLTHBYhjOqylwICMJQoybp6d7V4lF6ctpX3yM3ZBiAa8GE
         A6zS4vUPP4B5gtKxhDkeaiJ5BUL4teWBnUYtMv1xiFqmstX4vny6k72UmLxwCRGkT1a3
         7636WNxPazPHFUvIItvuC99um2or6hl36M/ekxkMRYi/yHqaH4RHd1vKyqTmnbEz5ai+
         6N8HmvFpP7avlcgbNdzehrKWLPh4xsPDfN2tthhWVvxB8xhRKq21RbDVOLK/4UZ18iiy
         gRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1P0sLZeM+9gDyjPoTyis2g+fl//04kPmhTkJ+3czYA=;
        b=VUjiPXP+6XmO++Y15js4jxKml2rkW+L3QiLCNqc/ljQKxeDqrBNPY89+4hpa6W+vEe
         rHuf0HmP9VDyVz/gFuXyqTP8QrSng06zKU80/MuFd+ptTx0sPX2Jofsv/ctVXmoRVs6q
         umoukpCNUy0uAIx7ZJl4YdkFcPqeV0leLOgLrCYUWyWM/x5ztDgmoRF1295ITUkzlhGS
         0tXHj5KYIompwpg8ieG8ldpH5y6cgMahm3A1CbFyH563JHwNybJb/MWHlVHYoMTs5fs0
         Vf73ellV8MKfga9re+m1U05gDoqu/vARxWHNERhcbw09mDO2G7rw1hxA7/rCYbCe9LGu
         bITw==
X-Gm-Message-State: AOAM530xbdNcIRN05BgPVhyTXQkXx8KiyNCoDWGZPdfeXvlCEQCni/0/
        nxsuH2+jgEIzJMk49yhV9KPpfP8MyYMRpmWsXETv8v110hY5K1B/FxM=
X-Google-Smtp-Source: ABdhPJz+eYZs6yF27eiSlSfqVuWEyhjpnJUQRL/KNZ6Ic6mddjScsMsSQmZ2ncLhaGdBBkuybz+dB1uSKbiUbM01ZYg=
X-Received: by 2002:a19:54e:: with SMTP id 75mr1988866lff.396.1604827658153;
 Sun, 08 Nov 2020 01:27:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604646059.git.viresh.kumar@linaro.org> <86e6dfb0b929e525b568d80e5e852f14487d9b94.1604646059.git.viresh.kumar@linaro.org>
In-Reply-To: <86e6dfb0b929e525b568d80e5e852f14487d9b94.1604646059.git.viresh.kumar@linaro.org>
From:   Ilia Lin <ilia.lin@gmail.com>
Date:   Sun, 8 Nov 2020 11:27:26 +0200
Message-ID: <CA+5LGR2dEk2cGm0maSUWVG2x-t33TWvd8=2UVqmmN+BWwB=CgQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: qcom-cpufreq-nvmem: dev_pm_opp_put_*()
 accepts NULL argument
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Ilia Lin <ilia.lin@kernel.org>

On Fri, Nov 6, 2020 at 9:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
> there is no need for us to carry the extra checks. Drop them.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index d06b37822c3d..747d602f221e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -397,19 +397,19 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>
>  free_genpd_opp:
>         for_each_possible_cpu(cpu) {
> -               if (IS_ERR_OR_NULL(drv->genpd_opp_tables[cpu]))
> +               if (IS_ERR(drv->genpd_opp_tables[cpu]))
>                         break;
>                 dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
>         }
>         kfree(drv->genpd_opp_tables);
>  free_opp:
>         for_each_possible_cpu(cpu) {
> -               if (IS_ERR_OR_NULL(drv->names_opp_tables[cpu]))
> +               if (IS_ERR(drv->names_opp_tables[cpu]))
>                         break;
>                 dev_pm_opp_put_prop_name(drv->names_opp_tables[cpu]);
>         }
>         for_each_possible_cpu(cpu) {
> -               if (IS_ERR_OR_NULL(drv->hw_opp_tables[cpu]))
> +               if (IS_ERR(drv->hw_opp_tables[cpu]))
>                         break;
>                 dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
>         }
> @@ -430,12 +430,9 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
>         platform_device_unregister(cpufreq_dt_pdev);
>
>         for_each_possible_cpu(cpu) {
> -               if (drv->names_opp_tables[cpu])
> -                       dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
> -               if (drv->hw_opp_tables[cpu])
> -                       dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
> -               if (drv->genpd_opp_tables[cpu])
> -                       dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
> +               dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
> +               dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
> +               dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
>         }
>
>         kfree(drv->names_opp_tables);
> --
> 2.25.0.rc1.19.g042ed3e048af
>
