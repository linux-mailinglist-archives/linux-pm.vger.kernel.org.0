Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17C9124071
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 08:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLRHhP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 02:37:15 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38676 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfLRHhP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 02:37:15 -0500
Received: by mail-vs1-f68.google.com with SMTP id v12so792014vsv.5
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 23:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=do6SVqqrSwYfkhVDYH5RikYbwbOxWPehu5jl8jI0+ro=;
        b=dRl6siJx8/e5LA8G0oj29mO4iXrBu9qbVmovo0gKnnEwC1hFh8awIvWNZc0Rr0BwEB
         loKd1AI31kRkpDHV5kbhNBbK8mvWpRSBooECgvRtbR/Lj5xgHkLRRC4wyOaiq3cOlv4O
         1K/YhNefY9Ae1Hr/nV7LgZ/55G+zlOaK+EBZLRIVuMTAgp0WzgLvplshDV4linqhCDZC
         OC9ziugqRL/g1VLvgl8/NTkLv6ezS0iRcYKx9pvI/ioOdyWHOPYdJ90Y0ohXlrkQ6cIA
         AaJjCinfFMs7aus+bmO1E0kWvobHHMBMhTZPx97Wm10IP1BNEG4PyjeTOOxbox0v+x13
         glZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=do6SVqqrSwYfkhVDYH5RikYbwbOxWPehu5jl8jI0+ro=;
        b=mVMceMCqpqfQhRaZyrjA58SHcj21Vhp0MCNs+UzgXMaeVFZb6vqZdFoWL49QtaH383
         DZ4oGQF71bmolLqCG3CnZj4s5b90HDJNkqNHnIiEmGeSJeLRBz5cvBA0EoBr6H3HPBs0
         aXWXjH3YUWw4utJKt/482n5GbO95gNKEvHUubsakvuEtBPU35GQ4ufefvT7yhMraO5NA
         /A9AeKs4UdI3fWmZalcbsvyCK/0LxzABzpHMtvGsRupdikR0acjVrrV3EexfzbAGalaT
         ybPl+FP+B4aAIDRRLnX2Jsmwo4ap3DUGWx9+BfNZ/Qsyv+BNI4Fy3rWHoJeSf7s8MzYU
         3lFg==
X-Gm-Message-State: APjAAAUraNCQaOWFRgjbTYsJdyfMNE435SdzqTF3LU5jOmAX6hvddLL3
        5nvfXmbSt7KrFNmXdGUQipD+phFhwadBhSUMblwB2A==
X-Google-Smtp-Source: APXvYqwgUxsqu+XwnIdw+nD/Mf13KCyvX5NTV1GCHYpw+JayUBeFvWW3aLmH5gcfiI9UpYv2GOoClnViaDRb37oAJ/U=
X-Received: by 2002:a67:f499:: with SMTP id o25mr488125vsn.165.1576654634125;
 Tue, 17 Dec 2019 23:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 08:36:38 +0100
Message-ID: <CAPDyKFoTKAs-sFZWNgY+Ym8-hQ_Ks2Qa+g3EtgfMPhEstHTddw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] cpuidle: psci: Support hierarchical CPU arrangement
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sudeep, Lorenzo,

On Wed, 11 Dec 2019 at 16:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v4:
>         - Mover the check for OSI support from psci_dt_attach_cpu() to the
>         caller's side of it.
>         - Add comment in the code about using the deepest idle state as the
>         triggering point for the domain state selection.
>         - Folded in a patch to enable support for CPU hotplug.

I believe I should have addressed all your provided inputs for this
version, unless you find something new, of course.

Then, would it be possible to get your blessing for this, before
Christmas, to allow this to cook for a while in linux-next via
Rafael's tree?

Kind regards
Uffe

>
> Changes in v3:
>         - Take one step further to completely avoid executing any OSI specific
>         code from the ->enter() callback, while operating in the default PSCI
>         Platform Coordinated mode.
>         - Update example for the PSCI DT bindings to make it compile with
>         "make dt_binding_check"
>
> Changes in v2:
>         - Avoid to affect the non-OSI path with specific changes for OSI. This
>         forced me to re-order the series and a caused more or less minor changes
>         to most of the patches.
>         - Updated the DT bindings for PSCI to clarify and to include the "psci"
>         name of the PM domain to attach to.
>         - Replaced patch1 with another patch from Sudeep, solving the same
>         problem, but in a different way.
>
> This series enables initial support for hierarchical CPU arrangement, managed
> by PSCI and its corresponding cpuidle driver. It's based on using the generic
> PM domain (genpd), which nowadays also supports devices belonging to CPUs.
>
> The last DTS patch enables the hierarchical topology to be used for the Qcom
> 410c Dragonboard, which supports the PSCI OS-initiated mode.
>
> More detailed background can be found from previous submissions [1].
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
>
> Lina Iyer (1):
>   cpuidle: dt: Support hierarchical CPU idle states
>
> Sudeep Holla (1):
>   cpuidle: psci: Align psci_power_state count with idle state count
>
> Ulf Hansson (12):
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
>   cpuidle: psci: Support CPU hotplug for the hierarchical model
>   cpuidle: psci: Add support for PM domains by using genpd
>   arm64: dts: Convert to the hierarchical CPU topology layout for
>     MSM8916
>
>  .../devicetree/bindings/arm/cpus.yaml         |  15 +
>  .../devicetree/bindings/arm/psci.yaml         | 104 ++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
>  drivers/cpuidle/Makefile                      |   4 +-
>  drivers/cpuidle/cpuidle-psci-domain.c         | 298 ++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.c                | 161 ++++++++--
>  drivers/cpuidle/cpuidle-psci.h                |  17 +
>  drivers/cpuidle/dt_idle_states.c              |   5 +-
>  drivers/firmware/psci/psci.c                  |  18 +-
>  drivers/of/base.c                             |  36 +++
>  include/linux/cpuhotplug.h                    |   1 +
>  include/linux/of.h                            |   8 +
>  include/linux/psci.h                          |   2 +
>  13 files changed, 691 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
>  create mode 100644 drivers/cpuidle/cpuidle-psci.h
>
> --
> 2.17.1
>
