Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59D3BDEA7
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 22:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGFVCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhGFVB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 17:01:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CCC061760
        for <linux-pm@vger.kernel.org>; Tue,  6 Jul 2021 13:59:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f11so12798144plg.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jul 2021 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0PBoIcqbc65Ea7VP0qFC6aAUDYW+WwmHWgilnraPFf8=;
        b=bag2+61IEn5zv40WALO9seg3t+Bh91fFOJVgNqS2ojhXIWZao47sLkLmcRAjniRsnY
         GUa7BZqHypqGUwZrDw0RlN3eLhqykQfy0ktv6tC2tZ2W6KiwCc2GzVmiMrtiowk7NkDn
         Vl5Lz7Rujnw5Q0p2jLBH8nl+KL/9N/j0ejdI3ZcVZLNbQ7Jp01dMF24pordORzYJrYU9
         lvXbVbKpGmZxYMPJS/hxQ+05ehQt5LvofS/r56y/wOhNMqSUFoWJyvuoCwZp3CsNck7z
         dDCx3jBv3Zm1+LaSkNQ3VKzlLj/gPei5L01ZhhgBWXlw6ETiw671j8JDDIEt2yyiez85
         5cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0PBoIcqbc65Ea7VP0qFC6aAUDYW+WwmHWgilnraPFf8=;
        b=bQu9sixwItIW59ZO3EfmDyBk6qIc4mTLWlEsLcjst6VSCRsyyLJIB3VwA24qSiYz5i
         mYcRkqHT2Y6wTH7f769TB4h9EWeecXAVLtS15y+1x8FP8dvAQwH1tpp6zhbbGeDP/Uin
         /jGVxoAzR67GU0ACCKNgCqueFgmwu0vuhGfNRcvq9/bHzxnddmAXSgMwnM68s9qQfxPq
         A9GOEjetnR7BvoeHwnqCm8hHMMjhhqlD6Bvi7dqTwnviqzNgjFhEQnxlhbbLBArQvHlm
         kQK7lsP3Uio6tkE5YOC7iwKZkigo89mHVomGCT/oSdl0NPlPXHxP/zhlyWWeD2M+Psse
         4XDA==
X-Gm-Message-State: AOAM532usIbsm7nsLRd8WARIOlZOjQFTVTCtt6K9xWfL9Fp0y/cz/Cdo
        aVdXTCmbbV6xEWHVzYhhxiXNNQ==
X-Google-Smtp-Source: ABdhPJzzExInJYeXPhXIYEiGqFxMLYlqTWxOzHBELFSbWOSs+Pnp5HP64Icyydt2eV1nPtBl/uv8fg==
X-Received: by 2002:a17:90a:8417:: with SMTP id j23mr17733738pjn.168.1625605160144;
        Tue, 06 Jul 2021 13:59:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g17sm20738691pgh.61.2021.07.06.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:59:19 -0700 (PDT)
Date:   Tue, 06 Jul 2021 13:59:19 -0700 (PDT)
X-Google-Original-Date: Tue, 06 Jul 2021 13:59:17 PDT (-0700)
Subject:     Re: [PATCH v7 0/8] RISC-V CPU Idle Support
In-Reply-To: <CAAhSdy00KAqg37PCAGwNXt_2HTpxGY68yTPNHDEbrSwdiLa2jw@mail.gmail.com>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, pavel@ucw.cz,
        robh+dt@kernel.org, milun.tripathy@gmail.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        liush@allwinnertech.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-baa27714-d293-409b-9c07-6b2d1043bfad@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Jun 2021 21:49:11 PDT (-0700), anup@brainfault.org wrote:
> Hi Palmer,
>
> On Thu, Jun 10, 2021 at 10:52 AM Anup Patel <anup.patel@wdc.com> wrote:
>>
>> This series adds RISC-V CPU Idle support using SBI HSM suspend function.
>> The RISC-V SBI CPU idle driver added by this series is highly inspired
>> from the ARM PSCI CPU idle driver.
>>
>> At high-level, this series includes the following changes:
>> 1) Preparatory arch/riscv patches (Patches 1 to 3)
>> 2) Defines for RISC-V SBI HSM suspend (Patch 4)
>> 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
>>    and ARM PSCI CPU idle driver (Patch 5)
>> 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
>>
>> These patches can be found in riscv_sbi_hsm_suspend_v7 branch at
>> https://github.com/avpatel/linux
>>
>> Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
>> support in all above projects (RISC-V SBI specification, OpenSBI, and
>> Linux RISC-V).
>>
>> Changes since v6:
>>  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
>>
>> Changes since v5:
>>  - Rebased on Linux-5.13-rc5
>>  - Removed unnecessary exports from PATCH5
>>  - Removed stray ";" from PATCH5
>>  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
>>    in PATCH6
>>
>> Changes since v4:
>>  - Rebased on Linux-5.13-rc2
>>  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
>>  - Added MAINTAINERS file entry for dt_idle_genpd
>>
>> Changes since v3:
>>  - Rebased on Linux-5.13-rc2
>>  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
>>  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
>>    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
>>
>> Changes since v2:
>>  - Rebased on Linux-5.12-rc3
>>  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
>>    idle states
>>  - Added "additionalProperties = false" for both idle-states node and
>>    child nodes in PATCH7
>>
>> Changes since v1:
>>  - Fixex minor typo in PATCH1
>>  - Use just "idle-states" as DT node name for CPU idle states
>>  - Added documentation for "cpu-idle-states" DT property in
>>    devicetree/bindings/riscv/cpus.yaml
>>  - Added documentation for "riscv,sbi-suspend-param" DT property in
>>    devicetree/bindings/riscv/idle-states.yaml
>>
>> Anup Patel (8):
>>   RISC-V: Enable CPU_IDLE drivers
>>   RISC-V: Rename relocate() and make it global
>>   RISC-V: Add arch functions for non-retentive suspend entry/exit
>>   RISC-V: Add SBI HSM suspend related defines
>>   cpuidle: Factor-out power domain related code from PSCI domain driver
>>   cpuidle: Add RISC-V SBI CPU idle driver
>>   dt-bindings: Add common bindings for ARM and RISC-V idle states
>>   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
>
> Can you please review this series ?
>
> It would be nice to consider this series for Linux-5.14.

I'd assumed this one was part of the 0.3.0 freeze.

>
> Regards,
> Anup
>
>>
>>  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
>>  .../devicetree/bindings/arm/psci.yaml         |   2 +-
>>  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
>>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>>  MAINTAINERS                                   |  14 +
>>  arch/riscv/Kconfig                            |   7 +
>>  arch/riscv/Kconfig.socs                       |   3 +
>>  arch/riscv/configs/defconfig                  |  13 +-
>>  arch/riscv/configs/rv32_defconfig             |   6 +-
>>  arch/riscv/include/asm/asm.h                  |  17 +
>>  arch/riscv/include/asm/cpuidle.h              |  24 +
>>  arch/riscv/include/asm/sbi.h                  |  27 +-
>>  arch/riscv/include/asm/suspend.h              |  35 +
>>  arch/riscv/kernel/Makefile                    |   2 +
>>  arch/riscv/kernel/asm-offsets.c               |   3 +
>>  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
>>  arch/riscv/kernel/head.S                      |  18 +-
>>  arch/riscv/kernel/process.c                   |   3 +-
>>  arch/riscv/kernel/suspend.c                   |  86 +++
>>  arch/riscv/kernel/suspend_entry.S             | 123 ++++
>>  drivers/cpuidle/Kconfig                       |   9 +
>>  drivers/cpuidle/Kconfig.arm                   |   1 +
>>  drivers/cpuidle/Kconfig.riscv                 |  15 +
>>  drivers/cpuidle/Makefile                      |   5 +
>>  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
>>  drivers/cpuidle/cpuidle-psci.h                |  15 +-
>>  drivers/cpuidle/cpuidle-sbi.c                 | 626 ++++++++++++++++++
>>  drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
>>  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
>>  29 files changed, 1472 insertions(+), 185 deletions(-)
>>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
>>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>>  create mode 100644 arch/riscv/include/asm/suspend.h
>>  create mode 100644 arch/riscv/kernel/suspend.c
>>  create mode 100644 arch/riscv/kernel/suspend_entry.S
>>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>>  create mode 100644 drivers/cpuidle/cpuidle-sbi.c
>>  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
>>  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
>>
>> --
>> 2.25.1
>>
