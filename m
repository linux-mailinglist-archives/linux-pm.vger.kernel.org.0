Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376F1F72AA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKLBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 06:01:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39379 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfKKLBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 06:01:30 -0500
Received: by mail-vs1-f68.google.com with SMTP id v77so1901550vsv.6
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mz3lNQ/pSTpjBy4/rt0FiWEYQmsAhg9p/dIjDzFfTO0=;
        b=CYxf1c35gK5NtcdsAKgFQmNcI0NRUCD1qc5CY7Gfkg1niJJ5ryezlxrJYmyYktCj7C
         hOQly/9/+7syg1PGyi+YO5GpLT2V/GOgJ+Ws/W0MVgPMPJzopRHddYN7/PjnwRV3w2Kd
         9GOYaABtA2QUb6wuTC25zWLpQYBcfm3gCKwh7fAVqmDMxXRTjo3GUvfn+yeKvYKuzVuQ
         tgvQEEhFVWu/gdUqcyziu4IuIRiiIgOcD6YHvik2uiewFqW+JuoLfUPP0H9zJFenCDhJ
         PYrKPxRbmrnO7JQwNGyZ0j8qI/jZZpbTGpcLOAUoprTSlWGfXHMe4DdmI4WzkODAuXml
         u+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mz3lNQ/pSTpjBy4/rt0FiWEYQmsAhg9p/dIjDzFfTO0=;
        b=T24/hMh5LVVATcDS4+lgS6ROQNloOGZ22wFtbn+gQWsNlG8OIEhzrcWAR0cFq5pa/w
         hsi9WL29DDxAfoS4dRmtfnm5wVHcTEo/Ukq2COcGB289I1RPhZxBidP/ucFL5q8arUs5
         H3nrrD/ANh40WLBF2gV1N2l+bzmMpBw5WfwWJEQGjJCgr8ZLwnm8hRoYznDfG9hubdL7
         3q/Fd8bpBOf3i2uaSap7CLHDPOB893fYaAIs1BFe6Fm95tclLBTvCJVt3WRU2jN4dGF9
         Q/kT+VTtA9pLoSlvexmyAjppaW1VnHPthyF+4iYPYo3iEtxUF8LnHqZ5VTSlb0lk6nVq
         dudQ==
X-Gm-Message-State: APjAAAU/zQMWbwHI9+VVnGeNlufQs4vQSPD6GyZI8WB1+W7ffP3HNKTJ
        wOg09+SAlJlZiQcarNSRo1rPK/UQckJP1bCYArjZNA==
X-Google-Smtp-Source: APXvYqx70uiAioSm0jvKz9MZFVmJvEQ0JqWGP534KhMvg5sjyFaaNuu21UzItkaDejfwEfEJIhd0ox49kFW3WNrTa3U=
X-Received: by 2002:a67:fc04:: with SMTP id o4mr17895409vsq.35.1573470088368;
 Mon, 11 Nov 2019 03:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Nov 2019 12:00:52 +0100
Message-ID: <CAPDyKFpiMK_P+4+n9wHc+68X6j44XOoTm=J8OXz5HkqoMxOsOg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] cpuidle: psci: Support hierarchical CPU arrangement
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 29 Oct 2019 at 17:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Avoid to affect the non-OSI path with specific changes for OSI. This
>         forced me to re-order the series and a caused more or less minor changes
>         to most of the patches.
>         - Updated the DT bindings for PSCI to clarify and to include the "psci"
>         name of the PM domain to attach to.
>         - Replaced patch1 with another patch from Sudeep, solving the same
>         problem, but in a different way.

Hi Sudeep and Lorenzo,

Apologize for nagging you about reviews, again. Can you please have a
look at the new version!?

Kind regards
Uffe

>
> This is the same coverletter as in v1:
>
> This series enables initial support for hierarchical CPU arrangement, managed
> by PSCI and its corresponding cpuidle driver. It's based on using the generic
> PM domain (genpd), which nowadays also supports devices belonging to CPUs.
>
> The last DTS patch enables the hierarchical topology to be used for the Qcom
> 410c Dragonboard, which supports the PSCI OS-initiated mode.
>
> Do note, most of the code in this series have been posted earlier, but from the
> latest version being reviewed, we agreed on that it was better to re-work the
> PSCI backend driver as a first step, simply to get a clean interface towards the
> cpuidle driver.
>
> Summary of the main-changes since the last submission [1]:
>
>  - Moved implementation from the psci FW dricer into cpuidle-psci.
>
>  - Re-requesting review of the DT bindings, as we have moved to yaml. No
>    changes as such, but tried to clarify a few things in the text.
>
>  - Drop the patch enabling support for CPU hotplug, postponing that to the next
>    step.
>
>  - Respect the hierarchical topology in DT only when OSI mode is supported.
>    This is to start simple and we can always extend the support on top.
>
> The series is also available at:
> git.linaro.org/people/ulf.hansson/linux-pm.git next
>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lwn.net/Articles/788306/
>
> Lina Iyer (1):
>   cpuidle: dt: Support hierarchical CPU idle states
>
> Sudeep Holla (1):
>   cpuidle: psci: Align psci_power_state count with idle state count
>
> Ulf Hansson (11):
>   dt: psci: Update DT bindings to support hierarchical PSCI states
>   firmware: psci: Export functions to manage the OSI mode
>   of: base: Add of_get_cpu_state_node() to get idle states for a CPU
>     node
>   cpuidle: psci: Simplify OF parsing of CPU idle state nodes
>   cpuidle: psci: Support hierarchical CPU idle states
>   cpuidle: psci: Add a helper to attach a CPU to its PM domain
>   cpuidle: psci: Attach CPU devices to their PM domains
>   cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
>   cpuidle: psci: Manage runtime PM in the idle path
>   cpuidle: psci: Add support for PM domains by using genpd
>   arm64: dts: Convert to the hierarchical CPU topology layout for
>     MSM8916
>
>  .../devicetree/bindings/arm/cpus.yaml         |  15 +
>  .../devicetree/bindings/arm/psci.yaml         | 102 ++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
>  drivers/cpuidle/Makefile                      |   4 +-
>  drivers/cpuidle/cpuidle-psci-domain.c         | 302 ++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.c                | 123 +++++--
>  drivers/cpuidle/cpuidle-psci.h                |  17 +
>  drivers/cpuidle/dt_idle_states.c              |   5 +-
>  drivers/firmware/psci/psci.c                  |  18 +-
>  drivers/of/base.c                             |  36 +++
>  include/linux/of.h                            |   8 +
>  include/linux/psci.h                          |   2 +
>  12 files changed, 654 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
>  create mode 100644 drivers/cpuidle/cpuidle-psci.h
>
> --
> 2.17.1
>
