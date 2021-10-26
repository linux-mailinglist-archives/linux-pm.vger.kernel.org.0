Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82143BE1D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 01:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhJZXui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 19:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbhJZXuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 19:50:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BBC061767
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 16:48:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r2so1069903pgl.10
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xwza6UlzVfIQQLUuHstHSQWG0hE12xpERozbdrPW5Tg=;
        b=bL5UUtVmpGXr2E5Swk1wrnFLDjzAL5Db5e0u7N0mi/tqyGsx6+GlK/MkA1PeZ0MiBH
         UqtEMnzlp4JbqIrOHDLM0X7xwdqxm+Q8XxYRc+jEfslnKpP7/aHhW6qvSVnH6excYZDb
         VC1IQvQSDaBfc7R44xET+k4hlApI/RL63bhahOqKT9YDZN693dpwNfoCBN4inVtOaevB
         bGax5fOJWR8FUq3dAHHrM5qU9UXizjS8YLq3e8e4Djy65nS3ZC+ArzwuQMAMNOH12B7A
         7el8VdsFddT3cD4ORzpcSHthBAHXQqBYYrDgxbVUSfbV3/tcjwQrnBfO5l8NcMVRwpXV
         V10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xwza6UlzVfIQQLUuHstHSQWG0hE12xpERozbdrPW5Tg=;
        b=Z1IJgUnF70nhAp2QwoSEkIwhGSuay6cT3K0WPG5tIH7+QmeQnBlZlH+5exRCtdE4u2
         479uJl2QjXz+7ejqGVE+RYXnoBFvCkQ+TUWRU3gNKbQjz5IGgbv0jbJHju1a31OQkYff
         Kwi/0PVNU+MvogZD3YKHecsegDnIIMkLJWo3TX9AsvRG8NhuhWbN68/QN6jPpi24Fz+w
         Q65ZpRA3ZjskQq+slm6jBKTchIUWnM+MYP4wKkLDbwFIdeRBqhx0sC9zSV+nFtl3MVCC
         O0ygqWziMTd8d9t4w1b4rPb6aHbU0IDBWv800NYIfwwEX7S4CwHlzdPSEvuQmD7u30OW
         bEpA==
X-Gm-Message-State: AOAM531Sjp0+i113RhVKt8M/fqA+RCP1LRNLO8V2x5F8wDR/0VUps4VX
        i6+UUKXCsqVZo0A2f8uZcrMPKQ==
X-Google-Smtp-Source: ABdhPJyRkUu4Ob775r7anWlvMiPOtSlIC4kpnedNkEQ7aHSpYHADrjTrcPXKvv/WmHKLJfAYPq7/Ng==
X-Received: by 2002:a63:8243:: with SMTP id w64mr16130369pgd.18.1635292092131;
        Tue, 26 Oct 2021 16:48:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:676c:ab93:f48d:23ae])
        by smtp.gmail.com with ESMTPSA id ls7sm1981133pjb.16.2021.10.26.16.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
X-Google-Original-Date: Tue, 26 Oct 2021 16:48:02 PDT (-0700)
Subject:     Re: [PATCH v9 0/8] RISC-V CPU Idle Support
In-Reply-To: <20211012095857.1314214-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, pavel@ucw.cz, robh+dt@kernel.org,
        milun.tripathy@gmail.com, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        liush@allwinnertech.com, anup@brainfault.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-63e8dc0c-278d-46e3-a617-abe1d68fcc6d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 Oct 2021 02:58:49 PDT (-0700), Anup Patel wrote:
> This series adds RISC-V CPU Idle support using SBI HSM suspend function.

This all generally looks good to me, I'm just not sure what the spec 
status is.  If one of you guys says it's frozen then that's good enough 
for me, please just either point me to something where that's been 
publicly said or just post here.

> The RISC-V SBI CPU idle driver added by this series is highly inspired
> from the ARM PSCI CPU idle driver.
>
> At high-level, this series includes the following changes:
> 1) Preparatory arch/riscv patches (Patches 1 to 3)
> 2) Defines for RISC-V SBI HSM suspend (Patch 4)
> 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
>    and ARM PSCI CPU idle driver (Patch 5)
> 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
>
> These patches can be found in riscv_sbi_hsm_suspend_v9 branch at
> https://github.com/avpatel/linux
>
> Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
> support in all above projects (RISC-V SBI specification, OpenSBI, and
> Linux RISC-V).
>
> Changes since v8:
>  - Rebased on Linux-5.15-rc5
>  - Fixed DT schema check errors in PATCH7
>
> Changes since v7:
>  - Rebased on Linux-5.15-rc3
>  - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6
>
> Changes since v6:
>  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
>
> Changes since v5:
>  - Rebased on Linux-5.13-rc5
>  - Removed unnecessary exports from PATCH5
>  - Removed stray ";" from PATCH5
>  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
>    in PATCH6
>
> Changes since v4:
>  - Rebased on Linux-5.13-rc2
>  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
>  - Added MAINTAINERS file entry for dt_idle_genpd
>
> Changes since v3:
>  - Rebased on Linux-5.13-rc2
>  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
>  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
>    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
>
> Changes since v2:
>  - Rebased on Linux-5.12-rc3
>  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
>    idle states
>  - Added "additionalProperties = false" for both idle-states node and
>    child nodes in PATCH7
>
> Changes since v1:
>  - Fixex minor typo in PATCH1
>  - Use just "idle-states" as DT node name for CPU idle states
>  - Added documentation for "cpu-idle-states" DT property in
>    devicetree/bindings/riscv/cpus.yaml
>  - Added documentation for "riscv,sbi-suspend-param" DT property in
>    devicetree/bindings/riscv/idle-states.yaml
>
> Anup Patel (8):
>   RISC-V: Enable CPU_IDLE drivers
>   RISC-V: Rename relocate() and make it global
>   RISC-V: Add arch functions for non-retentive suspend entry/exit
>   RISC-V: Add SBI HSM suspend related defines
>   cpuidle: Factor-out power domain related code from PSCI domain driver
>   cpuidle: Add RISC-V SBI CPU idle driver
>   dt-bindings: Add common bindings for ARM and RISC-V idle states
>   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
>
>  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
>  .../devicetree/bindings/arm/psci.yaml         |   2 +-
>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>  MAINTAINERS                                   |  14 +
>  arch/riscv/Kconfig                            |   7 +
>  arch/riscv/Kconfig.socs                       |   3 +
>  arch/riscv/configs/defconfig                  |  15 +-
>  arch/riscv/configs/rv32_defconfig             |   8 +-
>  arch/riscv/include/asm/asm.h                  |  17 +
>  arch/riscv/include/asm/cpuidle.h              |  24 +
>  arch/riscv/include/asm/sbi.h                  |  27 +-
>  arch/riscv/include/asm/suspend.h              |  35 +
>  arch/riscv/kernel/Makefile                    |   2 +
>  arch/riscv/kernel/asm-offsets.c               |   3 +
>  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
>  arch/riscv/kernel/head.S                      |  18 +-
>  arch/riscv/kernel/process.c                   |   3 +-
>  arch/riscv/kernel/suspend.c                   |  86 +++
>  arch/riscv/kernel/suspend_entry.S             | 123 ++++
>  drivers/cpuidle/Kconfig                       |   9 +
>  drivers/cpuidle/Kconfig.arm                   |   1 +
>  drivers/cpuidle/Kconfig.riscv                 |  15 +
>  drivers/cpuidle/Makefile                      |   5 +
>  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
>  drivers/cpuidle/cpuidle-psci.h                |  15 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c           | 626 ++++++++++++++++++
>  drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
>  drivers/cpuidle/dt_idle_genpd.h               |  50 ++

Some of the patches that touch drivers/cpuidle don't have Acks from the 
subsystem maintainers.  I'm OK taking this through the RISC-V tree, but 
I'd prefer to have acks first.  I'm also fine doing something like a 
shared tag between the trees, if that's better for folks.

>  29 files changed, 1474 insertions(+), 187 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>  create mode 100644 arch/riscv/include/asm/suspend.h
>  create mode 100644 arch/riscv/kernel/suspend.c
>  create mode 100644 arch/riscv/kernel/suspend_entry.S
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
