Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A562428873
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhJKIUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:20:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7017 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJKIUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940332; x=1665476332;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=M+XKn0zzQ6gbXKfrFZND7kVAQf5SVfd13U7HFuQ2GIM=;
  b=XmA6k71D+GMPkYqWpRZX5NzjtLLkzCieb9AXR1mhlFTnTw44GzzddqLJ
   DUPSbVQUC2pOAmvA2pLqVWTWZ8TX55sjVTimqkLj74T/S6qHoWkR8+DYZ
   bH9dh74G3exb/aaeVcjWxiGp+J/y29eIzo6vQGO87oUnqwsLTNLOha7nj
   h5NHifsYGAZONACOntGJLdCmqMvi7NWhMfIIzxZpwxBuoXvJ3WpY5QGl0
   U3jy1kRrryCiqN4sZCkVO0pXn1+pxoqr36A4LUHF2bxZrqpSslheKHjwz
   c2bLJna9TwWMU2SwrK+utnMONbmLeYqfaMUI/kTiroytWebI/Aei+6YDB
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286313122"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:18:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX0f0gi5RmooEG6vl6xpFKoSOdRqm5xTY8WexS3H+i3XjFRcEgzhFuH2Wr+HJCx3ZVgQPsThmXT9PNhfAUupanbelCc1Bkb20q0OT71UKZ2L5hLP28XrUmMw7/4sU3Q3o1ShD9YslPv3qP6RtYdaNGmO+5zlbqnGABrGCWs7qTDGt1YBWbbwu4c3f+UWrKZTemxxdHArkPWANgbr780kNydBSLI9ydaUMQYTtfEOrax7cXboiIJwT7ciiq2pY2D81mse5Mv0KTudcNQDTHsg9wfd9dMDLYcowHKsfV7QtnVQAdbFmGN4RuBfNnZrjCHXiy4Ht+rpWKWAGWoTIOOgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSv5z0D6yZTgho6E98W4tVcDev5hIl7i+B8hfSa/Q24=;
 b=L1MUwEWMlL3NoJ4bawsRS5mfHF0zTU02k/MKhrjlnsPNc46KJ5upvaecqOS1fzQ9D27XSAFCXhfEPBmmx0/PUecqNUqvrzkQ8mb0RnsV+rWhY1l+j8xaS1YNq5XFMy60r1xGwGofod9OTBr3piRNn9zL6bEIPEYutSIwbYrhzWg9c36qitDpGpFEpZcS1llmpLG6XX9Mweo47EJchA6CYpXQkDkTuEUNHAgb26uG6wpXrnZDBCZ9o/ssrM9mYqFRqrCkZNn9m9Zhcmlp8Qfehhqzi67DZKN75WCj4dBIp4+wKmgbHXKjpoMgdXylTUahxAqdLq7LwUmYPGViV+MXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSv5z0D6yZTgho6E98W4tVcDev5hIl7i+B8hfSa/Q24=;
 b=DDb60Qpbec2LwEUly4sgZ9lQE9rpbR7RWlT+dwZtPZVyPXY74tpPsftmLrW9eavWcKxczeOTFu6bvPIpIedoKN6RulgQMbRwxJTAbQicx1sB1AiB6NRdLYkHK3JkUF4k3p7uGf1boAjz4XqxX8XU1OMSQeFhBbvIge8RVu9LEcY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8331.namprd04.prod.outlook.com (2603:10b6:303:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:18:48 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:18:48 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v8 0/8] RISC-V CPU Idle Support
Date:   Mon, 11 Oct 2021 13:48:12 +0530
Message-Id: <20211011081820.1135261-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:18:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8130c484-df45-48cf-10c0-08d98c8fc009
X-MS-TrafficTypeDiagnostic: CO6PR04MB8331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB83314013369FA8121CC794138DB59@CO6PR04MB8331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NVvYZJCWlGA2NVvyprFXtrKxgq+INlxUY5MwkZiijB8XXM5GY/MJbhNesRfL6pJVMZ2GPkbaVP3WtKRjJjxGnzBDV42VRc8gi5DMSPJRHaBstFVAYrmGHjD2WD1YCwrhzkTgO8pr+DJMwMRSO/mlwg5Z3xO8sXjuWdgoDPA/ISEzqUPIATpdJRyV5C+8Ujq8pHGLejyreN3Vy4x6tYAsH4CpTm47AtnnsnnwfQxxvrIFIDZBSkNmocVXWaYZR9JiEjgyD48x0ULc8+VTx++GHcEqQkm6Dnsr/BTEcWO7+sYRPYD+BoKAi0XzErkUvTeTEiuEMBJJ4RduExucEiywAHJsqWl0xsIw67oZ/rdR9jT9V5fgzjujMONHlCzN8mR2/ujQ40J2sO3xxDVYa4T8UUpnXe+Ho9Er5oB5qDdqIf1h2PE+pknJsrZNuf4UdI5BFngglzeexbyOqfUrAJaf18Wt5vTareVeAIadsvT0+7Cet752z/r3HtcQg5RrqWNEzMSc3jq+gbbrvE5D7v/NDQbW7S2E0I9NOinLIJuP7ugK+BjX8HQX54TpY974qMK1bG10MOfDV7kI8gjY5Sp3pzk5M6J+v0wJ+9PLCSFdwujho4Z0pUcsvUuePHhjGsXScVFh4y6CtrSs/KNt4ufy8BM43LIfmqTfYf3/zOGYzdclbt5RWDM58BF4u+NBREbfqLj5ikmBzf57h12GvDSyfbPdHviSqCwV+3XdNeUOQNDWZdzMhYcFNOV1fFVmTlQhN4y4P9XwQCP95EMM3+F+SWeW2ydDyZSz6O/fHZt5hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(110136005)(2616005)(2906002)(55016002)(44832011)(316002)(6666004)(54906003)(5660300002)(83380400001)(38350700002)(38100700002)(8676002)(26005)(86362001)(7416002)(1076003)(36756003)(508600001)(66946007)(8886007)(66556008)(4326008)(66476007)(8936002)(186003)(52116002)(7696005)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3djGXSAiGQgTDQWnebW3pWKRY0atKWE1ydGLKDg3nagb2jIv2VLoGJ5ZLH5O?=
 =?us-ascii?Q?SgZCOgyLaD/CUZDfLmSFmqXwVHTg+ioFS7fKwxruseI3aGexM63UH2tC89iz?=
 =?us-ascii?Q?+cPTW0K/MxUizalBfJzZwpVhYaLkNWJ83ULmc0D7jzH/mcqSS/JhEfxAjWJ6?=
 =?us-ascii?Q?G+hIpzFFYmFDnNLybp8IoXkvdE83eOL80an6F+RajBobnzRUwMFPLH3FPjdS?=
 =?us-ascii?Q?fRSZjfGG6Kzy7r5U653ERVl3GXFSdQoHw8QPfKiVHc2wjdysn3Z8Qn6+dc5u?=
 =?us-ascii?Q?bCXN/6o824Cy9Lnq0qlm/gx9WLs7CghHp0FSdNXUG7Wp5fGKTy7QuGlR1DuX?=
 =?us-ascii?Q?BvzyS6KLzQZMp9PjxfWFJTiEm8CAR1Pyell8MVnuQNQ+oI66DhEVGLvxqvDZ?=
 =?us-ascii?Q?HywHmbSslDxIN+nIBS94M13yraHPSOsikHTZB6Z5oKxsP9NVvJpasUvQ5aAU?=
 =?us-ascii?Q?lSM/W5XV+zryWUWB439+9HmE0lsmAw/AOJprzlkzBCGSIbZQ0dTxLmKcFz3l?=
 =?us-ascii?Q?mNVZQlFq1vS6W5hMyJmFIzsol2qX0OPXSFNhIoz09ZFNb8ZuWBFaFKmiBWTt?=
 =?us-ascii?Q?2gdu19YrE86LciQvYH7I/6NSR8/63YIaaIIgd93OGWpJBz0Q/wm2fam8l4TD?=
 =?us-ascii?Q?fmp5SyFQPZqqgPsrLhh73E7eUNcBnH6BRYB0OgYZ80GMkpOTMspST6qPO66U?=
 =?us-ascii?Q?xSYIKhFoyMUc++PnrXa+bwh0WvAmhHzXSxkVMxM6F+u/KIuCk6rGx8IfbhOi?=
 =?us-ascii?Q?8VeAn+1EZTWtzVcmvWpmE+tjN8HNCRD6M+ehyi9vmIF8ZbETiTbJPLlRgTLn?=
 =?us-ascii?Q?ottzLQIAo3I7WTwEda1Cnya5Z9fzH7gYn4LxZHIaPkg9iIHEDWtx8ZhlzBT+?=
 =?us-ascii?Q?h3Bga1NYi7ne/MZoc/ZPRyvzeZOrLA09yCiM+8+/mk/cZdhIXAkJ/4aad7gl?=
 =?us-ascii?Q?f/ai0PMX/wAZ+DEwUUpdT6fYL9HxPQ/TWkt2RD86tixbbJlXqzHAd/pqujjJ?=
 =?us-ascii?Q?Cg6TzQw4Bp5EGcw0hwhSwI2F8q+rVdBb/V7iDYLD3J7JdVYO4kDLUENbtMt9?=
 =?us-ascii?Q?SB5cQMnYUCyyVgQUiUFBpq42fsBL214qoAjvvnW3sdWuckpjtfdAj4Lo7S4Y?=
 =?us-ascii?Q?nKdimUj2+96CNe/niIGK3TeLM7J4YgBddxRCatOAUTyIHFfihz+GM/xuF7JT?=
 =?us-ascii?Q?YvkTs8wQR4ZNdUbTZk0AjC27YvXh46MHtTMWRLONNDPpkzQMEHKL66q6uSLF?=
 =?us-ascii?Q?dvKNiIgnBBkz32f78ZJ7RcVfy+U49v7wVwHhBqOq+Xy3T3rgErkPDq+IXvFf?=
 =?us-ascii?Q?teJLSLtVoaRmRcjJWyhQvdQh?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8130c484-df45-48cf-10c0-08d98c8fc009
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:18:48.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhdmLXGoKTwTYzuhsCM/Z62dh29ipf69HI2QQrbQ5EpS3tMgi06JAVqwniKpPI9fv8SH08OrJYjIBgtf+eZy+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8331
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds RISC-V CPU Idle support using SBI HSM suspend function.
The RISC-V SBI CPU idle driver added by this series is highly inspired
from the ARM PSCI CPU idle driver.

At high-level, this series includes the following changes:
1) Preparatory arch/riscv patches (Patches 1 to 3)
2) Defines for RISC-V SBI HSM suspend (Patch 4)
3) Preparatory patch to share code between RISC-V SBI CPU idle driver
   and ARM PSCI CPU idle driver (Patch 5)
4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)

These patches can be found in riscv_sbi_hsm_suspend_v8 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

Changes since v7:
 - Rebased on Linux-5.15-rc3

Changes since v6:
 - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"

Changes since v5:
 - Rebased on Linux-5.13-rc5
 - Removed unnecessary exports from PATCH5
 - Removed stray ";" from PATCH5
 - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
   in PATCH6

Changes since v4:
 - Rebased on Linux-5.13-rc2
 - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
 - Added MAINTAINERS file entry for dt_idle_genpd

Changes since v3:
 - Rebased on Linux-5.13-rc2
 - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
 - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
   sharing between ARM PSCI and RISC-V SBI drivers in PATCH5

Changes since v2:
 - Rebased on Linux-5.12-rc3
 - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
   idle states
 - Added "additionalProperties = false" for both idle-states node and
   child nodes in PATCH7

Changes since v1:
 - Fixex minor typo in PATCH1
 - Use just "idle-states" as DT node name for CPU idle states
 - Added documentation for "cpu-idle-states" DT property in
   devicetree/bindings/riscv/cpus.yaml
 - Added documentation for "riscv,sbi-suspend-param" DT property in
   devicetree/bindings/riscv/idle-states.yaml

Anup Patel (8):
  RISC-V: Enable CPU_IDLE drivers
  RISC-V: Rename relocate() and make it global
  RISC-V: Add arch functions for non-retentive suspend entry/exit
  RISC-V: Add SBI HSM suspend related defines
  cpuidle: Factor-out power domain related code from PSCI domain driver
  cpuidle: Add RISC-V SBI CPU idle driver
  dt-bindings: Add common bindings for ARM and RISC-V idle states
  RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine

 .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
 .../devicetree/bindings/arm/psci.yaml         |   2 +-
 .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/Kconfig.socs                       |   3 +
 arch/riscv/configs/defconfig                  |   2 +
 arch/riscv/configs/rv32_defconfig             |   2 +
 arch/riscv/include/asm/asm.h                  |  17 +
 arch/riscv/include/asm/cpuidle.h              |  24 +
 arch/riscv/include/asm/sbi.h                  |  27 +-
 arch/riscv/include/asm/suspend.h              |  35 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/asm-offsets.c               |   3 +
 arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
 arch/riscv/kernel/head.S                      |  18 +-
 arch/riscv/kernel/process.c                   |   3 +-
 arch/riscv/kernel/suspend.c                   |  86 +++
 arch/riscv/kernel/suspend_entry.S             | 123 ++++
 drivers/cpuidle/Kconfig                       |   9 +
 drivers/cpuidle/Kconfig.arm                   |   1 +
 drivers/cpuidle/Kconfig.riscv                 |  15 +
 drivers/cpuidle/Makefile                      |   5 +
 drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
 drivers/cpuidle/cpuidle-psci.h                |  15 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c           | 626 ++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
 drivers/cpuidle/dt_idle_genpd.h               |  50 ++
 29 files changed, 1467 insertions(+), 175 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

-- 
2.25.1

