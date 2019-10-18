Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CADBF89
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfJRIKu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 04:10:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46719 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfJRIKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 04:10:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id z14so3430984vsz.13
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXiuhqjxfmBX/sG2OrevgXIiWecPGwPXk32tr5vuY04=;
        b=VwYlda01p1jGwF9Bcpj6zOR1x8neb/OGEpTbgXNmPn+0y3Ixie8hgSCR3GFMOMUQkO
         V9k0dUGqfvEGDXD71rbpvBsM2ctpv9jf3FpwvpX0hX4bz6Ekp05C5xf1Q6IdUk4Nyj6K
         YjRQ6pYobbBbJLhsXDmp2c13cqewriR1/czWC50D/ab4buHLg0b+4UATUYxC6rn0X0jc
         I+7ajpjy4re9wt4olcthlE5/90vhGY1EXdh0oi0gDqIu+WMsuXgBpYpy+eCQtU55pAHO
         UJqq4/ahTtdJr4RKEOVoIaGPgKrSvPFXJemWwoqt7v49mmou6EbE9yLTmRrqW5D+9EQm
         kW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXiuhqjxfmBX/sG2OrevgXIiWecPGwPXk32tr5vuY04=;
        b=EX+xSdE9C5096hILhOQ9kEOHwut4ZhQcFe6AVyrCTtDBTKeIfltSKjGRPqFRU2BnZT
         JiI2ofyBfXGHz47sghZS7sW7zWSKCulxM8m3NcWhQcT2Rifjwl9fY4ugpI4t0KCMlFDw
         LDm6ZIAQJVzVVWq0p+64i/E+ar1B37vrM207LDE5bWtc/aBNKts6h05mpHIraNi2rOi5
         Jezbugq6jReUSqgp3Giv7m5MTSVrBYs3nTw6Bz2HZ4DfxS5v3V517vk2c/ed/BeHrFXv
         q24r37B/WY2RNhLKcGT3xqKpSWXwvMqwXFkfQ8rHVywu0DABwhD377jA8WBRPEMvZc8L
         HxqQ==
X-Gm-Message-State: APjAAAU7wYXrCbldmDqK+MWa1jWK3ZZqLrWdyisOT/VXPM3zZAtZsBCs
        RDbgJvW31GK7pYeLsjztZ7P5rMl9VP1O3wuOaewXhg==
X-Google-Smtp-Source: APXvYqyYp0Yvnrsx2yfirIPl8CPOyfzoTsCZB6XxogSt1B4qW14k/8FyrHl8CQQX7yj4RKVw1UPExyXKcs5k4Nz0dnk=
X-Received: by 2002:a67:cf05:: with SMTP id y5mr4906975vsl.34.1571386249087;
 Fri, 18 Oct 2019 01:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 10:10:13 +0200
Message-ID: <CAPDyKFqcq6z=y67hQ4Gk8PayQ6R=b8B3hSv374A+4u-zuvrFaQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] cpuidle: psci: Support hierarchical CPU arrangement
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Oct 2019 at 13:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
>
> Lina Iyer (1):
>   cpuidle: dt: Support hierarchical CPU idle states
>
> Ulf Hansson (12):
>   cpuidle: psci: Fix potential access to unmapped memory
>   dt: psci: Update DT bindings to support hierarchical PSCI states
>   firmware: psci: Export functions to manage the OSI mode
>   of: base: Add of_get_cpu_state_node() to get idle states for a CPU
>     node
>   cpuidle: psci: Simplify OF parsing of CPU idle state nodes
>   cpuidle: psci: Support hierarchical CPU idle states
>   cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
>   cpuidle: psci: Add support for PM domains by using genpd
>   cpuidle: psci: Add a helper to attach a CPU to its PM domain
>   cpuidle: psci: Attach CPU devices to their PM domains
>   cpuidle: psci: Manage runtime PM in the idle path
>   arm64: dts: Convert to the hierarchical CPU topology layout for
>     MSM8916
>
>  .../devicetree/bindings/arm/psci.yaml         | 153 +++++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
>  drivers/cpuidle/Makefile                      |   4 +-
>  drivers/cpuidle/cpuidle-psci-domain.c         | 302 ++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.c                | 106 ++++--
>  drivers/cpuidle/cpuidle-psci.h                |  17 +
>  drivers/cpuidle/dt_idle_states.c              |   5 +-
>  drivers/firmware/psci/psci.c                  |  18 +-
>  drivers/of/base.c                             |  36 +++
>  include/linux/of.h                            |   8 +
>  include/linux/psci.h                          |   2 +
>  11 files changed, 673 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
>  create mode 100644 drivers/cpuidle/cpuidle-psci.h
>
> --
> 2.17.1
>

Sudeep, Lorenzo,

Just wanted to give you a gentle ping about this series, especially
patch1 is kind of urgent.

Kind regards
Uffe
