Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0017243C208
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbhJ0FKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 01:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJ0FKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 01:10:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A4C061570
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 22:08:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso5124611wmd.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJS/brQNo0A+LkLN5FqqyanpOzcRmHdv/6JPXTmm6gM=;
        b=KQW2OGokYWRJVNVe36ZB7kEkTEocjz98Ek9M2mkOpbOc4YYxTnhVV/7sKKnIW80cUO
         YyAKXjFk/CtB8fBnksqjNAlTMfrDttqhv3bSdUd56wGuSmMBYjY3GY9+AH/AklQoPmT1
         s9ZGyJkE8Z+OtAvEfEj1gk8uDGdA00M82yQ13wZhQ4zk6Si8IYNs22tgD1zIj8zsDGZ/
         BPRRrGUxKNb5xgglhjIkvWnw5QSW2j/R1BVysYv2uBrBVQ5ZsG259CC0sxwGB+1hwYHj
         hiJ7VeKoRvxi2/HlqR0/CDXYeV8ZsbcxwWJqW8hGiaa8jMti1CtKmQz4PtrAHDwzBUsV
         J7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJS/brQNo0A+LkLN5FqqyanpOzcRmHdv/6JPXTmm6gM=;
        b=ecwsGZWwiacCh+HHE0Ff3f88BZFKsCuE1Y7MI5ZbqCQ3+0VOfMGxe2gw94DJXd0sch
         HENM+4jLvV+fcns7WOOMUt0i8NZSwipqSWO1VHIMNv1WekVs+vxCm7xQGGPl+2HXNWbW
         KlrpoHOXN3qNeB1d72fe8k6Ikfw6z8kD/FPCSctwMQ/siAwbWbDPeR2diSq39OlulJuW
         xJo4z2Fzh9gUCvsypRNuieWJojmHm4aUSwu+lJa3tfOFqfd3wxBAtqddCGuAu+H1EJ6r
         dZWlBOTYGgLFvdtwFkSC5A2EFR30GT9X3YPRR4bMVoi45tgz2DQBydcqL9b72mS5KeIH
         SOxg==
X-Gm-Message-State: AOAM5306GUAZ/ZPw2AxiXnOQnPQE0kGzp+5Pb7rYUWK8gf1wGD9568n2
        8Z1br4AgEIEF+pK5ggDcXPkBii3kMrj4r4bSgEMfIg==
X-Google-Smtp-Source: ABdhPJxp1Xh4ACmDZb/EIk7dzPSyZXUmE9Gh5FiHJDQ+nohMkou7rJATHrJ6+wvPDIyrWc7PROtJPYicEpMdqwv2saA=
X-Received: by 2002:a1c:7201:: with SMTP id n1mr3286146wmc.176.1635311304078;
 Tue, 26 Oct 2021 22:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211012095857.1314214-1-anup.patel@wdc.com> <mhng-63e8dc0c-278d-46e3-a617-abe1d68fcc6d@palmerdabbelt-glaptop>
In-Reply-To: <mhng-63e8dc0c-278d-46e3-a617-abe1d68fcc6d@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Oct 2021 10:38:12 +0530
Message-ID: <CAAhSdy2GxKNMqwYMBU2fNn0NLMHKB2pRRvDCiidX32s39AY=_A@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] RISC-V CPU Idle Support
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Atish Patra <Atish.Patra@wdc.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
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

On Wed, Oct 27, 2021 at 5:18 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Tue, 12 Oct 2021 02:58:49 PDT (-0700), Anup Patel wrote:
> > This series adds RISC-V CPU Idle support using SBI HSM suspend function.
>
> This all generally looks good to me, I'm just not sure what the spec
> status is.  If one of you guys says it's frozen then that's good enough
> for me, please just either point me to something where that's been
> publicly said or just post here.

Atish is following up on the SBI spec process so maybe he can provide
an update on that ?

>
> > The RISC-V SBI CPU idle driver added by this series is highly inspired
> > from the ARM PSCI CPU idle driver.
> >
> > At high-level, this series includes the following changes:
> > 1) Preparatory arch/riscv patches (Patches 1 to 3)
> > 2) Defines for RISC-V SBI HSM suspend (Patch 4)
> > 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
> >    and ARM PSCI CPU idle driver (Patch 5)
> > 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
> >
> > These patches can be found in riscv_sbi_hsm_suspend_v9 branch at
> > https://github.com/avpatel/linux
> >
> > Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
> > support in all above projects (RISC-V SBI specification, OpenSBI, and
> > Linux RISC-V).
> >
> > Changes since v8:
> >  - Rebased on Linux-5.15-rc5
> >  - Fixed DT schema check errors in PATCH7
> >
> > Changes since v7:
> >  - Rebased on Linux-5.15-rc3
> >  - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6
> >
> > Changes since v6:
> >  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
> >
> > Changes since v5:
> >  - Rebased on Linux-5.13-rc5
> >  - Removed unnecessary exports from PATCH5
> >  - Removed stray ";" from PATCH5
> >  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
> >    in PATCH6
> >
> > Changes since v4:
> >  - Rebased on Linux-5.13-rc2
> >  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
> >  - Added MAINTAINERS file entry for dt_idle_genpd
> >
> > Changes since v3:
> >  - Rebased on Linux-5.13-rc2
> >  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
> >  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
> >    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
> >
> > Changes since v2:
> >  - Rebased on Linux-5.12-rc3
> >  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
> >    idle states
> >  - Added "additionalProperties = false" for both idle-states node and
> >    child nodes in PATCH7
> >
> > Changes since v1:
> >  - Fixex minor typo in PATCH1
> >  - Use just "idle-states" as DT node name for CPU idle states
> >  - Added documentation for "cpu-idle-states" DT property in
> >    devicetree/bindings/riscv/cpus.yaml
> >  - Added documentation for "riscv,sbi-suspend-param" DT property in
> >    devicetree/bindings/riscv/idle-states.yaml
> >
> > Anup Patel (8):
> >   RISC-V: Enable CPU_IDLE drivers
> >   RISC-V: Rename relocate() and make it global
> >   RISC-V: Add arch functions for non-retentive suspend entry/exit
> >   RISC-V: Add SBI HSM suspend related defines
> >   cpuidle: Factor-out power domain related code from PSCI domain driver
> >   cpuidle: Add RISC-V SBI CPU idle driver
> >   dt-bindings: Add common bindings for ARM and RISC-V idle states
> >   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
> >
> >  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
> >  .../devicetree/bindings/arm/psci.yaml         |   2 +-
> >  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
> >  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
> >  MAINTAINERS                                   |  14 +
> >  arch/riscv/Kconfig                            |   7 +
> >  arch/riscv/Kconfig.socs                       |   3 +
> >  arch/riscv/configs/defconfig                  |  15 +-
> >  arch/riscv/configs/rv32_defconfig             |   8 +-
> >  arch/riscv/include/asm/asm.h                  |  17 +
> >  arch/riscv/include/asm/cpuidle.h              |  24 +
> >  arch/riscv/include/asm/sbi.h                  |  27 +-
> >  arch/riscv/include/asm/suspend.h              |  35 +
> >  arch/riscv/kernel/Makefile                    |   2 +
> >  arch/riscv/kernel/asm-offsets.c               |   3 +
> >  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
> >  arch/riscv/kernel/head.S                      |  18 +-
> >  arch/riscv/kernel/process.c                   |   3 +-
> >  arch/riscv/kernel/suspend.c                   |  86 +++
> >  arch/riscv/kernel/suspend_entry.S             | 123 ++++
> >  drivers/cpuidle/Kconfig                       |   9 +
> >  drivers/cpuidle/Kconfig.arm                   |   1 +
> >  drivers/cpuidle/Kconfig.riscv                 |  15 +
> >  drivers/cpuidle/Makefile                      |   5 +
> >  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
> >  drivers/cpuidle/cpuidle-psci.h                |  15 +-
> >  drivers/cpuidle/cpuidle-riscv-sbi.c           | 626 ++++++++++++++++++
> >  drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
> >  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
>
> Some of the patches that touch drivers/cpuidle don't have Acks from the
> subsystem maintainers.  I'm OK taking this through the RISC-V tree, but
> I'd prefer to have acks first.  I'm also fine doing something like a
> shared tag between the trees, if that's better for folks.

The patches which touch the PSCI cpuidle driver have been already
reviewed by Ulf Hansson. Also, the DT bindings have been already
reviewed by Rob Herring.

I have addressed previous comments from Rafael and I was hoping
if Rafael can review it again.

Regards,
Anup

>
> >  29 files changed, 1474 insertions(+), 187 deletions(-)
> >  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
> >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> >  create mode 100644 arch/riscv/include/asm/suspend.h
> >  create mode 100644 arch/riscv/kernel/suspend.c
> >  create mode 100644 arch/riscv/kernel/suspend_entry.S
> >  create mode 100644 drivers/cpuidle/Kconfig.riscv
> >  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
