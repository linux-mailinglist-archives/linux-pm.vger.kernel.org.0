Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF6440040
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhJ2Q0t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhJ2Q0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 12:26:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A6C061766
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 09:24:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v7so25685708ybq.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yy1Pu69CTYOO8y93IPHHXy+gewVMEnaZEHhribUrayE=;
        b=FPi8ZYqFXe4vuOcvy/4yVzWci05S+iwB0siamhjU/wuuPvoHUT4OIhni9OUVG/JAGm
         okoU2GhxH4z0fdNJYnROmiVrndlcH2gktUViMQLu2ItwM1onL23R9toc5uCqsPyYb6PE
         KXWUzMTwpqH7HGugEvwwcv+iAJ3X48GrCzmfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yy1Pu69CTYOO8y93IPHHXy+gewVMEnaZEHhribUrayE=;
        b=l5Cr4023iRjAKWOddstg5P7ecJG41jO+230d8x89bJlQGwU6uYDLop5T/aL6X48ctB
         v23WO06iJgTmoOdaLwtN6lsQvTkfoELpkozzc9hlrBDmruWuy72wTMvbGyaQapS3jTUD
         pS61nV6F3XDY4iCyXkG2G+z//KqNF7mbecL8zhTG0tIk0NDXx00HXqTDif6FB8NGqfP1
         w1Ys1FFE6qVPSnHOmhZPhmWdWDJL9yKQdoRJhOorNGrSgOR/XjprwR/2VLJZYf+GUo/q
         8O2ceUpPzDRSEZ/rVrDmoeHgGlMN7W2QaTAngN7FFiEuHaeutVizbCAjWrQrmM5HumMX
         XLAA==
X-Gm-Message-State: AOAM5338Jgfxy39rCaHvZKpqCQ3GWeVe/rcnq/WYuMqevj9tr3HHjVJ4
        VRxe16A97Pb+1qOmCOksgY8AvYHo350R+EycLkHi
X-Google-Smtp-Source: ABdhPJynd/AcoyLu4OKqiZTFhD4HUC5vhC4YJZjEm6dGvdRDSyXsZE7auw3/FxmLw/5V9GfrJ2ZvxaZfxsc2QOgbDhg=
X-Received: by 2002:a25:8408:: with SMTP id u8mr3609565ybk.258.1635524658932;
 Fri, 29 Oct 2021 09:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211012095857.1314214-1-anup.patel@wdc.com> <mhng-63e8dc0c-278d-46e3-a617-abe1d68fcc6d@palmerdabbelt-glaptop>
 <CAAhSdy2GxKNMqwYMBU2fNn0NLMHKB2pRRvDCiidX32s39AY=_A@mail.gmail.com>
In-Reply-To: <CAAhSdy2GxKNMqwYMBU2fNn0NLMHKB2pRRvDCiidX32s39AY=_A@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 29 Oct 2021 09:24:08 -0700
Message-ID: <CAOnJCULyy6LwCG76N70epSaeV8HZNBqnzv8x1qV_WnVqN16_2w@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] RISC-V CPU Idle Support
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
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

On Tue, Oct 26, 2021 at 10:08 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Oct 27, 2021 at 5:18 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >
> > On Tue, 12 Oct 2021 02:58:49 PDT (-0700), Anup Patel wrote:
> > > This series adds RISC-V CPU Idle support using SBI HSM suspend function.
> >
> > This all generally looks good to me, I'm just not sure what the spec
> > status is.  If one of you guys says it's frozen then that's good enough
> > for me, please just either point me to something where that's been
> > publicly said or just post here.
>
> Atish is following up on the SBI spec process so maybe he can provide
> an update on that ?
>

Here is the plan for SBI spec freeze process according to the newly
defined process by RVI.
https://docs.google.com/document/d/1-DZQ-5IzQlG1PLX8acic9SaLaU8SQIHRYewBrE1Zoxo/edit?usp=sharing

It's already presented to the chairs meeting and waiting for DoD
signoff. We can freeze the spec
and send it to the public review after that.

FYI: The spec version that will be frozen is tagged as 0.3.1 as we
can' travel back in time ;)

> >
> > > The RISC-V SBI CPU idle driver added by this series is highly inspired
> > > from the ARM PSCI CPU idle driver.
> > >
> > > At high-level, this series includes the following changes:
> > > 1) Preparatory arch/riscv patches (Patches 1 to 3)
> > > 2) Defines for RISC-V SBI HSM suspend (Patch 4)
> > > 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
> > >    and ARM PSCI CPU idle driver (Patch 5)
> > > 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
> > >
> > > These patches can be found in riscv_sbi_hsm_suspend_v9 branch at
> > > https://github.com/avpatel/linux
> > >
> > > Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
> > > support in all above projects (RISC-V SBI specification, OpenSBI, and
> > > Linux RISC-V).
> > >
> > > Changes since v8:
> > >  - Rebased on Linux-5.15-rc5
> > >  - Fixed DT schema check errors in PATCH7
> > >
> > > Changes since v7:
> > >  - Rebased on Linux-5.15-rc3
> > >  - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6
> > >
> > > Changes since v6:
> > >  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
> > >
> > > Changes since v5:
> > >  - Rebased on Linux-5.13-rc5
> > >  - Removed unnecessary exports from PATCH5
> > >  - Removed stray ";" from PATCH5
> > >  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
> > >    in PATCH6
> > >
> > > Changes since v4:
> > >  - Rebased on Linux-5.13-rc2
> > >  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
> > >  - Added MAINTAINERS file entry for dt_idle_genpd
> > >
> > > Changes since v3:
> > >  - Rebased on Linux-5.13-rc2
> > >  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
> > >  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
> > >    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
> > >
> > > Changes since v2:
> > >  - Rebased on Linux-5.12-rc3
> > >  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
> > >    idle states
> > >  - Added "additionalProperties = false" for both idle-states node and
> > >    child nodes in PATCH7
> > >
> > > Changes since v1:
> > >  - Fixex minor typo in PATCH1
> > >  - Use just "idle-states" as DT node name for CPU idle states
> > >  - Added documentation for "cpu-idle-states" DT property in
> > >    devicetree/bindings/riscv/cpus.yaml
> > >  - Added documentation for "riscv,sbi-suspend-param" DT property in
> > >    devicetree/bindings/riscv/idle-states.yaml
> > >
> > > Anup Patel (8):
> > >   RISC-V: Enable CPU_IDLE drivers
> > >   RISC-V: Rename relocate() and make it global
> > >   RISC-V: Add arch functions for non-retentive suspend entry/exit
> > >   RISC-V: Add SBI HSM suspend related defines
> > >   cpuidle: Factor-out power domain related code from PSCI domain driver
> > >   cpuidle: Add RISC-V SBI CPU idle driver
> > >   dt-bindings: Add common bindings for ARM and RISC-V idle states
> > >   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
> > >
> > >  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
> > >  .../devicetree/bindings/arm/psci.yaml         |   2 +-
> > >  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
> > >  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
> > >  MAINTAINERS                                   |  14 +
> > >  arch/riscv/Kconfig                            |   7 +
> > >  arch/riscv/Kconfig.socs                       |   3 +
> > >  arch/riscv/configs/defconfig                  |  15 +-
> > >  arch/riscv/configs/rv32_defconfig             |   8 +-
> > >  arch/riscv/include/asm/asm.h                  |  17 +
> > >  arch/riscv/include/asm/cpuidle.h              |  24 +
> > >  arch/riscv/include/asm/sbi.h                  |  27 +-
> > >  arch/riscv/include/asm/suspend.h              |  35 +
> > >  arch/riscv/kernel/Makefile                    |   2 +
> > >  arch/riscv/kernel/asm-offsets.c               |   3 +
> > >  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
> > >  arch/riscv/kernel/head.S                      |  18 +-
> > >  arch/riscv/kernel/process.c                   |   3 +-
> > >  arch/riscv/kernel/suspend.c                   |  86 +++
> > >  arch/riscv/kernel/suspend_entry.S             | 123 ++++
> > >  drivers/cpuidle/Kconfig                       |   9 +
> > >  drivers/cpuidle/Kconfig.arm                   |   1 +
> > >  drivers/cpuidle/Kconfig.riscv                 |  15 +
> > >  drivers/cpuidle/Makefile                      |   5 +
> > >  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
> > >  drivers/cpuidle/cpuidle-psci.h                |  15 +-
> > >  drivers/cpuidle/cpuidle-riscv-sbi.c           | 626 ++++++++++++++++++
> > >  drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
> > >  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
> >
> > Some of the patches that touch drivers/cpuidle don't have Acks from the
> > subsystem maintainers.  I'm OK taking this through the RISC-V tree, but
> > I'd prefer to have acks first.  I'm also fine doing something like a
> > shared tag between the trees, if that's better for folks.
>
> The patches which touch the PSCI cpuidle driver have been already
> reviewed by Ulf Hansson. Also, the DT bindings have been already
> reviewed by Rob Herring.
>
> I have addressed previous comments from Rafael and I was hoping
> if Rafael can review it again.
>
> Regards,
> Anup
>
> >
> > >  29 files changed, 1474 insertions(+), 187 deletions(-)
> > >  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> > >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> > >  create mode 100644 arch/riscv/include/asm/suspend.h
> > >  create mode 100644 arch/riscv/kernel/suspend.c
> > >  create mode 100644 arch/riscv/kernel/suspend_entry.S
> > >  create mode 100644 drivers/cpuidle/Kconfig.riscv
> > >  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
> > >  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
> > >  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
