Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0785F221108
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgGOPbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 11:31:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36604 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOPbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 11:31:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id h17so2524029oie.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBW6K8+TvI8uJGpxP7UFZC6IWDomv3WMlukBT2EREJ8=;
        b=VlqaFVKSJbR6CSoDUrS51ibv0VsZVYTnN6b8Mf1wZU6CjcXZm8+mHDnMJYayGyRwQZ
         mz/SPVkL3mSHJLFVAZVNNEs3F+mqevlK407PSVOe8sUVcDKAluJZRfCmKvT1Gl7jMvCy
         5K8RMY6RdWvMhCr1ouHnLzjuMmQ2drcCANcWMlp0y1d6k626DqS1o8qlKn62spLaqQ2s
         5xqMPTeif+6ngXmphE+TSTNRaOA8pTyZlaSYiZ/6FBv3j1WVRtdL2ZPFkBKG1ixyir8g
         we0hvJsLUwsGo/Z12IsWHKkH2EWxNbiFXAKOY5klD8s6SL2OwVisQ/GMdEg8/rThun+B
         oDYg==
X-Gm-Message-State: AOAM531AGcT+MiSttFsL4r187EKwdecqXheAZddE0Ifv/ZuUgazXUyYK
        R27nFkgOTzvJaVu4vvI3PIIJunn98M06fQJBL/0=
X-Google-Smtp-Source: ABdhPJyPcMAbwjPmcWXoE1l3sJ3/XyN5pkKKHAxynAZQ8Iv3h7e9wh++pvMgo+IR4QFp5JObqq90pO3v8JlDpOpXUmQ=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr251044oiy.110.1594827078031;
 Wed, 15 Jul 2020 08:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714142355.29819-1-weiyongjun1@huawei.com>
In-Reply-To: <20200714142355.29819-1-weiyongjun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 17:31:06 +0200
Message-ID: <CAJZ5v0j17uaQ6zUufyn8LeKS88kS5GQLOMFF0QkNR4dP5-7+ZQ@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: powernv: Make some symbols static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux PM <linux-pm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:14 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/cpufreq/powernv-cpufreq.c:88:1: warning:
>  symbol 'pstate_revmap' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:383:18: warning:
>  symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:669:6: warning:
>  symbol 'gpstate_timer_handler' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:902:6: warning:
>  symbol 'powernv_cpufreq_work_fn' was not declared. Should it be static?
>
> Those symbols are not used outside of this file, so mark
> them static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8646eb197cd9..cf118263ec65 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -85,7 +85,7 @@ struct global_pstate_info {
>
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>
> -DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
> +static DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
>  /**
>   * struct pstate_idx_revmap_data: Entry in the hashmap pstate_revmap
>   *                               indexed by a function of pstate id.
> @@ -380,7 +380,7 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
>                 powernv_freqs[powernv_pstate_info.nominal].frequency);
>  }
>
> -struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
> +static struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
>         __ATTR_RO(cpuinfo_nominal_freq);
>
>  #define SCALING_BOOST_FREQS_ATTR_INDEX         2
> @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>   * according quadratic equation. Queues a new timer if it is still not equal
>   * to local pstate
>   */
> -void gpstate_timer_handler(struct timer_list *t)
> +static void gpstate_timer_handler(struct timer_list *t)
>  {
>         struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
>         struct cpufreq_policy *policy = gpstates->policy;
> @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>         .notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>
> -void powernv_cpufreq_work_fn(struct work_struct *work)
> +static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>         struct chip *chip = container_of(work, struct chip, throttle);
>         struct cpufreq_policy *policy;
>

Applied as 5.9 material, thanks!
