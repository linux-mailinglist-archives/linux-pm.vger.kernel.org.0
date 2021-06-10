Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0893A2A10
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJLVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 07:21:25 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39450 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJLVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 07:21:24 -0400
Received: by mail-oi1-f172.google.com with SMTP id m137so1714995oig.6;
        Thu, 10 Jun 2021 04:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR2n9RcVFmQNpFqcuPDMiWFTscN6MglKWG5i9DzogFk=;
        b=J6t+BVMli32xwPqSkNPqGpX0LhLPSjohaNd/MS26X58utkflJ5i9XIjng9Fo7Z3Cv/
         U7PYn59Opg6gP+ECn6lsK7O0HmrVAD0OinciJhWFbLtzoBupQpRh1X0voLAZOFCfqCr0
         5SqzKqjb832PucxCL+2672SAtQA0Mz4nd+b40+K61M8sdSlMbnJrrRzCOwg64cM8f9ub
         4jU33k4w3+vIQcgiK1SF5P3OrKxFDjUkY2C9BS/1Zl1GlwjRwtkI1rmQuWvw4EmXBqnu
         vRwgJLFRuvir9s5ZGKgV+3ansfjat7orBK/ksdQm0AnmRV+3ejMsaB5RRmb/nVlOUwwQ
         DZ7w==
X-Gm-Message-State: AOAM533UsiBk+cOO3enyPTE1fNuPyuysM/wemIQdPWrJ91xdRki5TSqO
        B2dv5PL5JjidMKfOUIH1I/wmLCtbQ3N+WxLk3bY=
X-Google-Smtp-Source: ABdhPJwm1+jKBtIqcbWHpbjqmp/Q2AtWoRgZ2lUwyomvCIlokusgZIMsVa6DZMO3D1lYpdl4wsd6KISgT+xkQex5hg0=
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr13731oiw.69.1623323956491;
 Thu, 10 Jun 2021 04:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org>
In-Reply-To: <28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jun 2021 13:19:05 +0200
Message-ID: <CAJZ5v0i+GvobLS=cM9kc9Cj4BhLcEmTzRoBsRvDqQjLO-o7yGA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cppc: Mark frequency invariance broken
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 10, 2021 at 9:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There are few races in the frequency invariance support for CPPC driver,
> namely the driver doesn't stop the kthread_work and irq_work on policy
> exit during suspend/resume or CPU hotplug.
>
> A proper fix won't be possible for the 5.13-rc, as it requires a lot of
> changes. Instead of reverting the patch, mark this feature BROKEN for
> now.
>
> Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Well, why don't we revert 4c38f2df71c8 instead?

Is there any particular reason for retaining it?

> ---
> Rafael, please apply this for v5.13-rc if it looks fine to you.
>
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a5c5f70acfc9..614c34350f41 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -22,6 +22,7 @@ config ACPI_CPPC_CPUFREQ
>  config ACPI_CPPC_CPUFREQ_FIE
>         bool "Frequency Invariance support for CPPC cpufreq driver"
>         depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
> +       depends on BROKEN
>         default y
>         help
>           This extends frequency invariance support in the CPPC cpufreq driver,
> --
> 2.31.1.272.g89b43f80a514
>
