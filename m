Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB63B87F0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhF3Rtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 13:49:52 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35535 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhF3Rtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 13:49:52 -0400
Received: by mail-ot1-f41.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so3596275oti.2;
        Wed, 30 Jun 2021 10:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0XgWyFZDrmT/H0aoUSBhg+ke5B0GhsrurcaFTIWJWQ=;
        b=DIj/s5WKke38+rGSrav7A+0xNRsurLT0qPjU19wmOEhStqT3u7ajm0acmQs/kScNYO
         HgHegaIEz0DmAXwe6bt+x19RcutPhKBYsyjuroR4yF0HO0vzgUH4xW9110RL681gCEh3
         N2FdCxxCWRlv1s1oq1qiG8YyLK4IZPpHbTyvUfVY6paji0cmsUSeXg3GehXUgPzvek6Z
         mAbzA3+SkBQb2omOcciNfYrJ2+IerrTYPurrvwIo9cGBGTu7UJO8sjG7gedaABgThpE6
         NK+KTkM/T2n9ztZX8eZGUkMfm/EQ3UZ2OPtd7Ya3oepUTrtL39uZbAbXWLk+Q6MbK7xR
         ML3A==
X-Gm-Message-State: AOAM533k7ql6a7mv3ZwqALyVXiU1ueTOooU8MCsZQaDxT+w4O+KvDMxK
        CmkYrUU8dHytKjqKXTPJZv9Y90/7hKU4ZejxjPc=
X-Google-Smtp-Source: ABdhPJxwWx3tmHzoPh1fZYoh1qm2eKe3SjYZVp6OnZReK4+cCy5BZhr8KFdCe1G9B8A8eDU02bWfBgs6KW1bsk0/3uQ=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr10076387otm.260.1625075241865;
 Wed, 30 Jun 2021 10:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <b5ac439050ab3c5b92621e20490fe7f46d631ef6.1624946983.git.viresh.kumar@linaro.org>
In-Reply-To: <b5ac439050ab3c5b92621e20490fe7f46d631ef6.1624946983.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 19:47:11 +0200
Message-ID: <CAJZ5v0hwJwO4F3xJM697Y2SHfoPQ8PCgZNfG7WHHynGoqCZW_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        TungChen Shih <tung-chen.shih@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 29, 2021 at 8:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> __cpufreq_driver_target() open codes cpufreq_driver_resolve_freq(), lets
> make the former reuse the later.
>
> Separate out __resolve_freq() to accept relation as well as an argument
> and use it at both the locations.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 42 ++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc925b2a..d691c6c97c79 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -524,19 +524,8 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>
> -/**
> - * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
> - * one.
> - * @policy: associated policy to interrogate
> - * @target_freq: target frequency to resolve.
> - *
> - * The target to driver frequency mapping is cached in the policy.
> - *
> - * Return: Lowest driver-supported frequency greater than or equal to the
> - * given target_freq, subject to policy (min/max) and driver limitations.
> - */
> -unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> -                                        unsigned int target_freq)
> +static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> +               unsigned int target_freq, unsigned int relation)
>  {
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
>         policy->cached_target_freq = target_freq;
> @@ -545,7 +534,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>                 unsigned int idx;
>
>                 idx = cpufreq_frequency_table_target(policy, target_freq,
> -                                                    CPUFREQ_RELATION_L);
> +                                                    relation);
>                 policy->cached_resolved_idx = idx;
>                 return policy->freq_table[idx].frequency;
>         }
> @@ -555,6 +544,23 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>
>         return target_freq;
>  }
> +
> +/**
> + * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
> + * one.
> + * @policy: associated policy to interrogate
> + * @target_freq: target frequency to resolve.
> + *
> + * The target to driver frequency mapping is cached in the policy.
> + *
> + * Return: Lowest driver-supported frequency greater than or equal to the
> + * given target_freq, subject to policy (min/max) and driver limitations.
> + */
> +unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> +                                        unsigned int target_freq)
> +{
> +       return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_L);
> +}
>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>
>  unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> @@ -2225,13 +2231,11 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                             unsigned int relation)
>  {
>         unsigned int old_target_freq = target_freq;
> -       int index;
>
>         if (cpufreq_disabled())
>                 return -ENODEV;
>
> -       /* Make sure that target_freq is within supported range */
> -       target_freq = clamp_val(target_freq, policy->min, policy->max);
> +       target_freq = __resolve_freq(policy, target_freq, relation);
>
>         pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
>                  policy->cpu, target_freq, relation, old_target_freq);
> @@ -2252,9 +2256,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>         if (!cpufreq_driver->target_index)
>                 return -EINVAL;
>
> -       index = cpufreq_frequency_table_target(policy, target_freq, relation);
> -
> -       return __target_index(policy, index);
> +       return __target_index(policy, policy->cached_resolved_idx);
>  }
>  EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>
> --

Applied as 5.14-rc1 material along with the [2/2], thanks!
