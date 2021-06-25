Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434783B455A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFYOQQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 10:16:16 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:41841 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhFYOQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 10:16:16 -0400
Received: by mail-oo1-f46.google.com with SMTP id k21-20020a4a2a150000b029024955603642so2548794oof.8;
        Fri, 25 Jun 2021 07:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb2oox1oUIO8Ak6tDnGLYRSFQXaa3Y9McJsZ/3tyhSA=;
        b=Vwea9orpl0WkDz0W+2MbJxUK5dNaK8XpmPnoO16gKOOm0r2a2liejsGnhXqz5AJe6/
         3fs5G1Ik5NCS3LhE8RXy0T0qtxoU9g9kPnIfmkAYYxVeaw2ORx/bWLcg/I/MoIu5WeDn
         s7rrak/htNhSr1uviZG7bSoWq0tGOkzz6jR825Tx/QGorFyF0PHeYDUXOooXxpVIrYox
         Z5bxiN1pokycEiK2mQoqDS+Tp02hyaO7AIWDfmWTRExG3H2K47/Btjfv5kTEWKF1/4C/
         4C2l6RRWM6hk3b5/UGclPkr3ilYQI98us+7t/MnXBbW7AjX+J1jC9xI+7stb+TLJZ0J2
         y+zA==
X-Gm-Message-State: AOAM5301SQPdgvIPLkBkEpmruh9ag1MsyTqCh5dIlta9Ou8Zwp2WXjzF
        4lem/EZlqZtsp0MroQcs+kVwpnD2IWMLnif0yzk=
X-Google-Smtp-Source: ABdhPJw8M9hdAhNOk4vX0DAD2iZIO6vcnGIazvppe7fETJt+EqtFocDXvQ0NnG7QX7KzoyLNjT2n3Qd0MJYwqB/iyoo=
X-Received: by 2002:a4a:5285:: with SMTP id d127mr9265501oob.2.1624630432823;
 Fri, 25 Jun 2021 07:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210625134129.11885-1-tung-chen.shih@mediatek.com>
In-Reply-To: <20210625134129.11885-1-tung-chen.shih@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jun 2021 16:13:41 +0200
Message-ID: <CAJZ5v0hdbML+J5yYQpoEeQJhO_QriDmmRuUhcsWDBxK1t4sknA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cpufreq: fix the target freq not in the range of
 policy->min & max
To:     TungChen Shih <tung-chen.shih@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 25, 2021 at 3:41 PM TungChen Shih
<tung-chen.shih@mediatek.com> wrote:
>
>     In cpufreq_frequency_table_target(), this function will try to find
> an index for @target_freq in freq_table, and the frequency of selected
> index should be in the range [policy->min, policy->max], which means:
>
>     policy->min <= policy->freq_table[idx].frequency <= policy->max
>
>     Though "clamp_val(target_freq, policy->min, policy->max);" would
> have been called to check this condition, when policy->max or min is
> not exactly one of the frequency in the frequency table,
> policy->freq_table[idx].frequency may still go out of the range
>
>     For example, if our sorted freq_table is [3000, 2000, 1000], and
> suppose we have:
>
>     @target_freq = 2500
>     @policy->min = 2000
>     @policy->max = 2200
>     @relation = CPUFREQ_RELATION_L
>
> 1. After clamp_val(target_freq, policy->min, policy->max); @target_freq
> becomes 2200
> 2. Since we use CPUFREQ_REALTION_L, final selected freq will be 3000 which
> beyonds policy->max

As you accurately observed, the policy limits affect the target, not
the frequency that will be used, and "RELATION_L" means "the closest
frequency equal to or above the target".

You are not fixing a bug here IMO, you're changing the documented behavior.

> Signed-off-by: TungChen Shih <tung-chen.shih@mediatek.com>
> ---
>  include/linux/cpufreq.h | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 353969c7acd3..60cb15740fdf 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -975,21 +975,40 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>                                                  unsigned int target_freq,
>                                                  unsigned int relation)
>  {
> +       int idx = 0;
>         if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
>                 return cpufreq_table_index_unsorted(policy, target_freq,
>                                                     relation);
>
>         switch (relation) {
>         case CPUFREQ_RELATION_L:
> -               return cpufreq_table_find_index_l(policy, target_freq);
> +               idx = cpufreq_table_find_index_l(policy, target_freq);
> +               break;
>         case CPUFREQ_RELATION_H:
> -               return cpufreq_table_find_index_h(policy, target_freq);
> +               idx = cpufreq_table_find_index_h(policy, target_freq);
> +               break;
>         case CPUFREQ_RELATION_C:
> -               return cpufreq_table_find_index_c(policy, target_freq);
> +               idx = cpufreq_table_find_index_c(policy, target_freq);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>                 return 0;
>         }
> +
> +       /* target index verification */
> +       if (policy->freq_table[idx].frequency > policy->max) {
> +               if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> +                       idx--;
> +               else
> +                       idx++;
> +       } else if (policy->freq_table[idx].frequency < policy->min) {
> +               if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> +                       idx++;
> +               else
> +                       idx--;
> +       }
> +
> +       return idx;
>  }
>
>  static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
> --
> 2.18.0
>
