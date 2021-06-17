Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B893AB4B7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhFQN32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 09:29:28 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:41811 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhFQN31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 09:29:27 -0400
Received: by mail-oo1-f41.google.com with SMTP id k21-20020a4a2a150000b029024955603642so1572299oof.8;
        Thu, 17 Jun 2021 06:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ollDyGm2vsE66p3W2pXSBidOuVtCigtqaBXQiBNHZRg=;
        b=iOBpvDGN782y6yKb7W/O+oZ8L1FXJrAXDGuWbqpBFMe4u/pn0QDXDemrbc3CVs06aR
         BSPoVpYAydYoXwuYth6HqQALPUZGWC8jnaN3snmpLd14wQaW1IelL/wWUiGmcpafNNC5
         HpfRv1+aBER1IPUTD3xkdhTCBmKaLFTybs2NRD0do4cyO06Yv6vNpTaKJ3POKxOvK5Yk
         IWrH8c+h89kxrQWkWP+KQVroyS+2GNFwFAjWrgAARf9EtuC46LQMm1FAFE5sGy7FaJVe
         Sp96+akH4AEEOAAtN268/Vi9ZTEQz+IFhvguMQRSGmWc3PExYEu2F92AbvNl0I4Gq9rb
         sTDQ==
X-Gm-Message-State: AOAM533XluPrsqF0smBCAU7zQQCc3hogVJJKMw9TXS1I2Sceao4W0/RU
        nwVwmNnON7VqLl6cjsigZEOUmC+RwjBio6M4I80=
X-Google-Smtp-Source: ABdhPJwJcA+js2nczb58BLINvmjOBBspq4YNKeZAcc/pO8Ne6Cwg9A+Dk8ePmdhLFXcCdvI9mChoVn4AJUY1CXaWyKU=
X-Received: by 2002:a4a:9bcb:: with SMTP id b11mr4502217ook.44.1623936438630;
 Thu, 17 Jun 2021 06:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623825358.git.viresh.kumar@linaro.org> <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
In-Reply-To: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 15:27:07 +0200
Message-ID: <CAJZ5v0iR2FeKGQRcAFzNWCvkoMOnnGOT6FThK1LBHFt=VWySww@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] cpufreq: intel_pstate: Migrate to ->exit()
 callback instead of ->stop_cpu()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 8:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
> interface") added the stop_cpu() callback to allow the drivers to do
> clean up before the CPU is completely down and its state can't be
> modified.
>
> At that time the CPU hotplug framework used to call the cpufreq core's
> registered notifier for different events like CPU_DOWN_PREPARE and
> CPU_POST_DEAD. The stop_cpu() callback was called during the
> CPU_DOWN_PREPARE event.
>
> This is no longer the case, cpuhp_cpufreq_offline() is called only once
> by the CPU hotplug core now and we don't really need two separate
> callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
> can be done from the exit() callback itself.
>
> Migrate to using the exit() callback instead of stop_cpu().
>
> Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 0e69dffd5a76..37ad42926904 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2374,17 +2374,11 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>         return 0;
>  }
>
> -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> -{
> -       pr_debug("CPU %d stopping\n", policy->cpu);
> -
> -       intel_pstate_clear_update_util_hook(policy->cpu);
> -}
> -
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
>         pr_debug("CPU %d exiting\n", policy->cpu);
>
> +       intel_pstate_clear_update_util_hook(policy->cpu);

This addresses the ->exit case, but it doesn't address the ->offline
case AFAICS.

>         policy->fast_switch_possible = false;
>
>         return 0;
> @@ -2451,7 +2445,6 @@ static struct cpufreq_driver intel_pstate = {
>         .resume         = intel_pstate_resume,
>         .init           = intel_pstate_cpu_init,
>         .exit           = intel_pstate_cpu_exit,
> -       .stop_cpu       = intel_pstate_stop_cpu,
>         .offline        = intel_pstate_cpu_offline,
>         .online         = intel_pstate_cpu_online,
>         .update_limits  = intel_pstate_update_limits,
> --
