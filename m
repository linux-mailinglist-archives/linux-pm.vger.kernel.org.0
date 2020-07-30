Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E89232B9E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 08:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgG3F7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 01:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3F7u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 01:59:50 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB812083E
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 05:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596088789;
        bh=BHc8sdSpTVccKCyLCgqnAxB5xRQXDAGKg4tyDUDECSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ij677TMxu+aJeQS3sz3bSQlJu6dHpR1uCYS+d5ck5H2K+PAK2uQ26QwaGEORgsrRv
         ytcryaIkP0wKcSq0gBAknAaLg7EnNghKW9E6CSaA4+NL1kE693FrKjhcceAEcOJbnh
         KZuVBMxt2gtOiPkkXWSZwxie18gOizabhmD2kZR4=
Received: by mail-vs1-f44.google.com with SMTP id j186so13335331vsd.10
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 22:59:49 -0700 (PDT)
X-Gm-Message-State: AOAM532u0eCQxsiEVj8MXfFAUk2EKni9g2vgxqG0BhwOPEbZqD8xFcoD
        BtBQj+MH8TxINVWKqzKKfgA4X9A7fKeqHw05ClbSIw==
X-Google-Smtp-Source: ABdhPJxPBuuYiLcqs2lLQIQ7Uiliyjr+Ks2lXGLYVmoL+JZWEwX999c/bNDeqjRZ3CVGt4jRigJ1kfTR0eW5nTifMgc=
X-Received: by 2002:a67:e40a:: with SMTP id d10mr650578vsf.95.1596088788824;
 Wed, 29 Jul 2020 22:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
In-Reply-To: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Thu, 30 Jul 2020 11:29:38 +0530
X-Gmail-Original-Message-ID: <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com>
Message-ID: <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cached_resolved_idx can not be negative
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> It is not possible for cached_resolved_idx to be invalid here as the
> cpufreq core always sets index to a positive value.
>
> Change its type to unsigned int and fix qcom usage a bit.

Shouldn't you fix up idx in cpufreq_driver_resolve_freq() to be
unsigned int too?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 5 +----
>  include/linux/cpufreq.h           | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 0a04b6f03b9a..8c0842bd6c5a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -66,13 +66,10 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>                                                 unsigned int target_freq)
>  {
>         void __iomem *perf_state_reg = policy->driver_data;
> -       int index;
> +       unsigned int index;
>         unsigned long freq;
>
>         index = policy->cached_resolved_idx;
> -       if (index < 0)
> -               return 0;
> -
>         writel_relaxed(index, perf_state_reg);
>
>         freq = policy->freq_table[index].frequency;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index e62b022cb07e..58687a5bf9c8 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -127,7 +127,7 @@ struct cpufreq_policy {
>
>          /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>         unsigned int cached_target_freq;
> -       int cached_resolved_idx;
> +       unsigned int cached_resolved_idx;
>
>         /* Synchronization for frequency transitions */
>         bool                    transition_ongoing; /* Tracks transition status */
> --
> 2.14.1
>
