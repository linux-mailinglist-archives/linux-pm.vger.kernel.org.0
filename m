Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F072502562
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 08:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbiDOGRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 02:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349899AbiDOGRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 02:17:31 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389140917
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 23:15:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h14so3467858ila.5
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmEp/mMGdmvE393WWBsKkqLvzhV/lIHVVl2pgkJlWKw=;
        b=Ea5b0mKvenPORYSnxIMfP0qRj7CZ1UXeFgpAe5H/W2rXWzn5F9X8ulED/rqpBJluHo
         geM986PtAN2iggf05Gn1CU+7BD6TKXfzir94MtF1E1pVyPZ50vBL+UDJupZ8Ay3xt0/b
         XqJbGSC7k3t+1eJfmSGsNwer1Q1S0udoyi55O2188QJUYfJjchKJ4XI4eDaS43x/yDKS
         fpCns2xJA7mc6IKkJBmZeA0Lc0FdqOFD3PidE4WUjwKG4bCTczjFs68+iVn0/Yq1mkvt
         JiEqzzI9R/HNlQXKwM2Sv2aAMATrwNR4+eoqj++55rCTlOBbvd0QaJfb31LYTKeVs4XP
         +6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmEp/mMGdmvE393WWBsKkqLvzhV/lIHVVl2pgkJlWKw=;
        b=Bb2JSj4Un6EORBsMOBVdxpUkhjk4IpeXJ53Wx00Bi7vXO8ntVjb+9Jhq9ReOzznHjU
         yUSliEqI8sxSSyD1/lMKiHzAuj2+QudjWOIs1lOajAzIzAi7/42BqqKdufrLy6KD1DnR
         3sulfwi46FzkcyJBxMNLp0dX7EpEdfrAPIS4hPKGsgh8vE2XWtb56Lec/6Rj3sLX78VU
         ws0I51ACcCv8csK80FWofkdEM1+aexQg9SJE/AbzNwaOXzXG4vWWCYmh0X/X91Xdk92c
         Zx3EprqvSwbAgCws3oLclnKre7EmHAof0YBNtSQkIxUa0mdVA3sgEoIVEP01OsxWcRyY
         cSaw==
X-Gm-Message-State: AOAM530Ll1vuYklrylsOOkSbJrSzCm0cT+uGrqlbTseF/xdFyqhRKk2o
        wdbUlzIBjfkotAtzCLRVRjn50aMMXL8H/h00W3EZrg==
X-Google-Smtp-Source: ABdhPJwcLVQCaKCPBevFx2nnK/pH8pbVZF8DcOsfzTmPQwBuqON2D1SO/RpJYvdJAlXbD/we/fGnqSHI6X1Xd9LlmcM=
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr2742492ild.5.1650003300783; Thu, 14 Apr
 2022 23:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com> <20220415055916.28350-11-rex-bc.chen@mediatek.com>
In-Reply-To: <20220415055916.28350-11-rex-bc.chen@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@google.com>
Date:   Fri, 15 Apr 2022 14:14:34 +0800
Message-ID: <CACb=7PXykpUgZ+QG93Bd-vWstq2V-k6G0zTg+D1q2WchJHPbig@mail.gmail.com>
Subject: Re: [PATCH V3 10/15] cpufreq: mediatek: Add counter to prevent
 infinite loop when tracking voltage
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>, roger.lu@mediatek.com,
        Kevin Hilman <khilman@baylibre.com>,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 15, 2022 at 1:59 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> To prevent infinite loop when tracking voltage, we calculate the maximum
> value for each platform data.
> We assume min voltage is 0 and tracking target voltage using
> min_volt_shift for each iteration.
> The retry_max is 3 times of expeted iteration count.
>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index cc44a7a9427a..d4c00237e862 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -86,6 +86,16 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>         struct regulator *proc_reg = info->proc_reg;
>         struct regulator *sram_reg = info->sram_reg;
>         int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
> +       int retry_max;
> +
> +       /*
> +        * We assume min voltage is 0 and tracking target voltage using
> +        * min_volt_shift for each iteration.
> +        * The retry_max is 3 times of expeted iteration count.
> +        */
> +       retry_max = 3 * DIV_ROUND_UP(max(info->soc_data->sram_max_volt,
> +                                        info->soc_data->proc_max_volt),
> +                                    info->soc_data->min_volt_shift);

mtk_cpufreq_voltage_tracking() will be called very frequently.
retry_max is the same every time mtk_cpufreq_voltage_tracking() is
called. Is it better to calculate before and store in
mtk_cpu_dvfs_info?

>
>         pre_vproc = regulator_get_voltage(proc_reg);
>         if (pre_vproc < 0) {
> @@ -151,6 +161,12 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>
>                 pre_vproc = vproc;
>                 pre_vsram = vsram;
> +
> +               if (--retry_max < 0) {
> +                       dev_err(info->cpu_dev,
> +                               "over loop count, failed to set voltage\n");
> +                       return -EINVAL;
> +               }
>         } while (vproc != new_vproc || vsram != new_vsram);
>
>         return 0;
> --
> 2.18.0
>
