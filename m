Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36B33BF458
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 05:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGHD4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 23:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhGHD4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 23:56:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE3C061760
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 20:54:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso5719199wmh.4
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWa3MSZDHv15RjZ0z5EeC98vQiHtGeO/uXKzI8GzBFw=;
        b=XTCFr7170JgT/QHOQKK4OIXt9x5YcaLpXvKfdNAjUQNxxHB4+We8I/BYK5sweWKUdx
         Khde29SVANgVGQ07/jlLHi3Ly55pBIp8Ua3RStYF8B1eijhyS191g1LYWDJQ/q36y1CM
         Wes7FduTI10HEzdpBC2LDQpPCXfEcdbbUquQiuQ/8ElzBvkZP/4kiAXg2NAowGpEU46V
         eWawf+2L92tBhiinHxhQDUhPvQyGpuA/OR2mlD1+GBPqpY9lI9GParrCwTjfEnN1A50h
         r/bIRHfzvU9DpzKoEw0USBUyKhBe3k1N3As3CrGHEGCIiEqjXJJjf2MwSyx0mDfwRFZ4
         QGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWa3MSZDHv15RjZ0z5EeC98vQiHtGeO/uXKzI8GzBFw=;
        b=blXAgLINazTt1G3rNyMrh7oq1dy7wirvC8fQxoKbkVTP+8XNY8D3RzXq4GK5FdVH95
         +gJ1R1f0qIUeVAGy8/SlOELVda+p8yFDt4Cf9syhOOWMUyYqdYptKxLWlqiiJwouzDCs
         2Rggy05tIqmyY47azMua5fBTnmugSdoXuZUZDh9yRU8qVhW3brakZ4lseHn6OIqd7sJn
         yxy4CZtwdjV60pqKBbz2poIsbRJZF0riinIROhFJvGBSxUGH80cI1ffiI7Eof+6mLTXJ
         1nmJ3ZrBq1AB0oU4t0c0MjQqgxc/kf51ATUrxELOW4GbdhhRGNukw2JOV/Iol6nZZlJX
         7VkA==
X-Gm-Message-State: AOAM530dtUKjriNYdmCK+54sv/QISa5qdautQlJR5VoIx7XvxPegpM97
        5zPx9f0SF7ieACoPu0nzkJ5Zp1q3G7wwQcSgxGDn3g==
X-Google-Smtp-Source: ABdhPJx5pjQOButJOiL0ZDCL2KfyzjM7GnKT+FRKBaTw9/Vh+a8HUsBlndetR7xxCwd82zoAhU9bMDNtRcpg2p3RqNQ=
X-Received: by 2002:a05:600c:3399:: with SMTP id o25mr30069191wmp.3.1625716440637;
 Wed, 07 Jul 2021 20:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy00KAqg37PCAGwNXt_2HTpxGY68yTPNHDEbrSwdiLa2jw@mail.gmail.com>
 <mhng-baa27714-d293-409b-9c07-6b2d1043bfad@palmerdabbelt-glaptop>
In-Reply-To: <mhng-baa27714-d293-409b-9c07-6b2d1043bfad@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 7 Jul 2021 21:21:47 +0530
Message-ID: <CAAhSdy21kOR8f8=9R-1HQW4ncmVcJEFRjNWU1N+mLejAHgBcHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] RISC-V CPU Idle Support
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        liush <liush@allwinnertech.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 7, 2021 at 2:29 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 21 Jun 2021 21:49:11 PDT (-0700), anup@brainfault.org wrote:
> > Hi Palmer,
> >
> > On Thu, Jun 10, 2021 at 10:52 AM Anup Patel <anup.patel@wdc.com> wrote:
> >>
> >> This series adds RISC-V CPU Idle support using SBI HSM suspend function.
> >> The RISC-V SBI CPU idle driver added by this series is highly inspired
> >> from the ARM PSCI CPU idle driver.
> >>
> >> At high-level, this series includes the following changes:
> >> 1) Preparatory arch/riscv patches (Patches 1 to 3)
> >> 2) Defines for RISC-V SBI HSM suspend (Patch 4)
> >> 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
> >>    and ARM PSCI CPU idle driver (Patch 5)
> >> 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
> >>
> >> These patches can be found in riscv_sbi_hsm_suspend_v7 branch at
> >> https://github.com/avpatel/linux
> >>
> >> Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
> >> support in all above projects (RISC-V SBI specification, OpenSBI, and
> >> Linux RISC-V).
> >>
> >> Changes since v6:
> >>  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
> >>
> >> Changes since v5:
> >>  - Rebased on Linux-5.13-rc5
> >>  - Removed unnecessary exports from PATCH5
> >>  - Removed stray ";" from PATCH5
> >>  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
> >>    in PATCH6
> >>
> >> Changes since v4:
> >>  - Rebased on Linux-5.13-rc2
> >>  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
> >>  - Added MAINTAINERS file entry for dt_idle_genpd
> >>
> >> Changes since v3:
> >>  - Rebased on Linux-5.13-rc2
> >>  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
> >>  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
> >>    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
> >>
> >> Changes since v2:
> >>  - Rebased on Linux-5.12-rc3
> >>  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
> >>    idle states
> >>  - Added "additionalProperties = false" for both idle-states node and
> >>    child nodes in PATCH7
> >>
> >> Changes since v1:
> >>  - Fixex minor typo in PATCH1
> >>  - Use just "idle-states" as DT node name for CPU idle states
> >>  - Added documentation for "cpu-idle-states" DT property in
> >>    devicetree/bindings/riscv/cpus.yaml
> >>  - Added documentation for "riscv,sbi-suspend-param" DT property in
> >>    devicetree/bindings/riscv/idle-states.yaml
> >>
> >> Anup Patel (8):
> >>   RISC-V: Enable CPU_IDLE drivers
> >>   RISC-V: Rename relocate() and make it global
> >>   RISC-V: Add arch functions for non-retentive suspend entry/exit
> >>   RISC-V: Add SBI HSM suspend related defines
> >>   cpuidle: Factor-out power domain related code from PSCI domain driver
> >>   cpuidle: Add RISC-V SBI CPU idle driver
> >>   dt-bindings: Add common bindings for ARM and RISC-V idle states
> >>   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
> >
> > Can you please review this series ?
> >
> > It would be nice to consider this series for Linux-5.14.
>
> I'd assumed this one was part of the 0.3.0 freeze.

Yes, SBI HSM suspend call is part of SBI v0.3.0 release.
(Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0)

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> >>
> >>  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
> >>  .../devicetree/bindings/arm/psci.yaml         |   2 +-
> >>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
> >>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
> >>  MAINTAINERS                                   |  14 +
> >>  arch/riscv/Kconfig                            |   7 +
> >>  arch/riscv/Kconfig.socs                       |   3 +
> >>  arch/riscv/configs/defconfig                  |  13 +-
> >>  arch/riscv/configs/rv32_defconfig             |   6 +-
> >>  arch/riscv/include/asm/asm.h                  |  17 +
> >>  arch/riscv/include/asm/cpuidle.h              |  24 +
> >>  arch/riscv/include/asm/sbi.h                  |  27 +-
> >>  arch/riscv/include/asm/suspend.h              |  35 +
> >>  arch/riscv/kernel/Makefile                    |   2 +
> >>  arch/riscv/kernel/asm-offsets.c               |   3 +
> >>  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
> >>  arch/riscv/kernel/head.S                      |  18 +-
> >>  arch/riscv/kernel/process.c                   |   3 +-
> >>  arch/riscv/kernel/suspend.c                   |  86 +++
> >>  arch/riscv/kernel/suspend_entry.S             | 123 ++++
> >>  drivers/cpuidle/Kconfig                       |   9 +
> >>  drivers/cpuidle/Kconfig.arm                   |   1 +
> >>  drivers/cpuidle/Kconfig.riscv                 |  15 +
> >>  drivers/cpuidle/Makefile                      |   5 +
> >>  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
> >>  drivers/cpuidle/cpuidle-psci.h                |  15 +-
> >>  drivers/cpuidle/cpuidle-sbi.c                 | 626 ++++++++++++++++++
> >>  drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
> >>  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
> >>  29 files changed, 1472 insertions(+), 185 deletions(-)
> >>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> >>  create mode 100644 arch/riscv/include/asm/cpuidle.h
> >>  create mode 100644 arch/riscv/include/asm/suspend.h
> >>  create mode 100644 arch/riscv/kernel/suspend.c
> >>  create mode 100644 arch/riscv/kernel/suspend_entry.S
> >>  create mode 100644 drivers/cpuidle/Kconfig.riscv
> >>  create mode 100644 drivers/cpuidle/cpuidle-sbi.c
> >>  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
> >>  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
> >>
> >> --
> >> 2.25.1
> >>
