Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E4445A01
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhKDSxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 14:53:36 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41618 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhKDSxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 14:53:35 -0400
Received: by mail-oi1-f179.google.com with SMTP id l15so10756799oie.8;
        Thu, 04 Nov 2021 11:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ev5HXKkqWVCDbj/tditW3QWt6RjaGkutj3mkV4sBiWw=;
        b=F1PHV0hL2onpc7rlK02nbBuOosMoA3VkYQZo+x1gufRfJOPGZeFJ4e3ogvgyY9C/dB
         75F+j81EZ/z8x4BHJcdZtXYRfZ5EnnzdXXrrhQ0rAl6iykFlA/tCWGNuzic6m2EvlvSa
         DHDaHbza2CCND+SD2H6J8lp0mEnvOaaWB/yoTp5OjPq1NKRI0XKsN5TH++NR6h9Sel3f
         6F7Xq3NX+X2P1M6p77c7jvTqSMsNi+dI7zaEMiJyBOwRUhkzDmKOleB66BPb9xAiJj02
         ZCQq/0bwDZx3MVRR5mKXsT6EwyHkojabIt/xDVY5sj06KsDzCgfDvFPnDQ1cx/WrLGDO
         rukw==
X-Gm-Message-State: AOAM530qe64OWJjN8rYX0V9cJ9usjRZRnQJEg0u5ZIrEE/2km7GK/ilY
        1x+LULvAxhdavXtgswSOqsFXVDsdLA4wPs9AdklmGi/Y
X-Google-Smtp-Source: ABdhPJx008c8sZqfJALi2bG5vcrrQdoQ8pDHbc+mGECghfOHzCP1ytt8KXZggbXMhVL3CHKSaug+q7lPu5bya3nROmM=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr17833435oif.154.1636051856998;
 Thu, 04 Nov 2021 11:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211104102230.123679-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20211104102230.123679-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Nov 2021 19:50:46 +0100
Message-ID: <CAJZ5v0iACra=Ch3GVUV0AgfsSYyLv7F3VFzsb8i2vN=DTxSQXg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Clear HWP Status during HWP
 Interrupt enable
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 4, 2021 at 11:22 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> It is possible that some performance excursions happened before OS boot
> or enable HWP interrupts. So clear MSR_HWP_STATUS bits when we enable
> HWP interrupt. In this way a next excursion will results in a HWP
> interrupt.
>
> The status bits of MSR_HWP_STATUS must be cleared (0) by software so
> that a new status condition change will cause the hardware to set the
> bit again and issue the notification.
>
> Fixes: 57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1e6898dc76b6..54cf21896889 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1645,6 +1645,7 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
>
>                 /* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
>                 wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
> +               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
>         }
>  }
>
> --

Applied as 5.16-rc material, thanks!
