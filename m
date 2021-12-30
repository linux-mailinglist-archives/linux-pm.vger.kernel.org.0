Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D68F481D48
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhL3Owo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 09:52:44 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:36808 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhL3Owo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 09:52:44 -0500
Received: by mail-qk1-f175.google.com with SMTP id i130so21835032qke.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 06:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEbbmYN9eWSKBtZkP33J2PEXK0dpc7EcDB7VExhJWdk=;
        b=EMDM6A4Zu7Q2abtVR4IQYZLS4qrhUvGvEWGPYMx95RAY0ILw+4X3UcFq06SDK8/L4A
         KlgGbov5xmpsbwOvDGk1RIs9FptfuKYzAiCvq8r01yXBLsNkV98OlyS8Wr94lqNLBW4K
         CnW1rSIFT//s450+KFd1s2wQQzl/SxB6IagbPt15a9ChUg3hUVQfGDP+ZQ8AU9LyLPv+
         GPU1I9ywQggVDMbXAXJFvWXZSXhM8ki+GwFzu4I4B6C1FcPAQ4biPrEWOJ4iQNG4GQ/n
         ZNGGycTP/7DlOo8bUOoYCoKmAFsjRieX8mDx9UG7pgF2p5G/To7NmWVp5Ii++3dmtKHV
         jmFA==
X-Gm-Message-State: AOAM531M/e5OFrcaackNlBt9ZhbQJW93jDMBFvThBKsYZpHr6Ia4JAhP
        KVlriPuhZqlTQAgvsNkPsYFcuviUiz0U0gG6aSQ=
X-Google-Smtp-Source: ABdhPJwK16kWK454jKHYX45zBw54qsxTmM+JyOIrbOrHFOOjc1RlCNxLtOhyzRgQgs0RI91L8jLpYpSdH87RbkNZvFY=
X-Received: by 2002:a05:620a:4721:: with SMTP id bs33mr22515540qkb.8.1640875963343;
 Thu, 30 Dec 2021 06:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20211229034635.tyh53sxs5uceoljm@vireshk-i7>
In-Reply-To: <20211229034635.tyh53sxs5uceoljm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 15:52:32 +0100
Message-ID: <CAJZ5v0h742vDZnMrDM0i3w=sXSSQa8cBf1FhLOk3_SNO-8W8Yg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.17-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 29, 2021 at 4:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Qcom cpufreq driver updates improve irq support (Ard Biesheuvel, Stephen Boyd,
>   and Vladimir Zapolskiy).
>
> - Fixes double devm_remap for mediatek driver (Hector Yuan).
>
> - Introduces thermal pressure helpers (Lukasz Luba).
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
>
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to d776790a55367b9313d03c364c04ff47e7f5ea83:
>
>   cpufreq: mediatek-hw: Fix double devm_remap in hotplug case (2021-12-27 09:44:53 +0530)
>
> ----------------------------------------------------------------
> Ard Biesheuvel (1):
>       cpufreq: qcom-cpufreq-hw: Avoid stack buffer for IRQ name
>
> Hector.Yuan (1):
>       cpufreq: mediatek-hw: Fix double devm_remap in hotplug case
>
> Lukasz Luba (5):
>       arch_topology: Introduce thermal pressure update function
>       thermal: cpufreq_cooling: Use new thermal pressure update function
>       cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu thermal pressure
>       cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
>       arch_topology: Remove unused topology_set_thermal_pressure() and related
>
> Stephen Boyd (1):
>       cpufreq: qcom-hw: Use optional irq API
>
> Vladimir Zapolskiy (2):
>       cpufreq: qcom-hw: Fix probable nested interrupt handling
>       cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts
>
>  arch/arm/include/asm/topology.h       |  2 +-
>  arch/arm64/include/asm/topology.h     |  2 +-
>  drivers/base/arch_topology.c          | 42 +++++++++++++++++++++++++++++++----
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 33 ++++++++++++++++++++++++---
>  drivers/cpufreq/qcom-cpufreq-hw.c     | 39 ++++++++++++++++----------------
>  drivers/thermal/cpufreq_cooling.c     |  6 +----
>  include/linux/arch_topology.h         |  4 ++--
>  include/linux/sched/topology.h        |  6 ++---
>  init/Kconfig                          |  2 +-
>  9 files changed, 96 insertions(+), 40 deletions(-)
>
> --

Pulled, thanks!
