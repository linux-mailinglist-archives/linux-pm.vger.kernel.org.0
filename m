Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E80398804
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFBLZf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:25:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27555 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFBLZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633032; x=1654169032;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WTqnJhZdl70KgU4uXhJMEOab2vyTXopdWA+7RbajbgU=;
  b=VK3PhjA+YSnKgPgKLahBzbWZ4N9a5Ua8X477D55MJdyQ9pLzjULbi7nO
   xvH0hIRb3fLZRxepYOITy+OvQbRroBY0WPJI2fAuBsuTTTmF8+u8wuQM+
   RWJO7xShhxZv8GbWPbODqNShujzjlcxiobdVgoTvml5idmR46o+vsD4/1
   4oMVHThZ2opGlmv6gmGNQtjLQI7WLRx93+6ywo0ah42wIgFfOViA/8kpy
   oSHdM63M+oRBAdW+C/1dB0eeByAtqhKZkNi6E8Dvzc+HR2qwRnnYNsCYR
   oZruNICv94M92w8aonNFDibeyIgnYD19KFgdh3TsHc7i2tkAfv3ZQFZTB
   g==;
IronPort-SDR: W2P1Br+2rVf3XbIGmfz8sexRCbb+kFaemMjWRVAlVoPifExVFS+HCHVGDiKqVZONcKW4CE5RN7
 SpWSuAGeaZVcu4rJ2w7R8tbLNUCAqGG4k7B3TFNZjGecEXdz0BEY5RlJDsxlyUa2A+bIVnkaDm
 gQgIiggQ56CZgEMjG73DuM5kNVszSKZxvSj0qbYao3jfsDK4w5njSbyroW/tL3GxiuRnhnuuMp
 Hwm0ZtKoOoal/VtmF1X89FmNDrHvcilgHCvsLos2yJVjEhFER8RtyBpoMMqY50ucldeEfkR7Km
 3OE=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="281803637"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:23:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcMbLMgCYf6vC6Iu4Vz+pYHoPXj50NrBTox/64BzS788sYP21DKsbDvuREZxBGTdsfjg8OdaJ7PRz1r1sYmlly9FV15D10FobAoJ/cBCUhs2Fa7V9Ym+J0slihW682TEUBR8mUPJu46s0FtPMKvBHrjcC/dV5Arosx+YJF5jFJ+hEqh5/cmOzLW5miFZh7xuhTRymS73R8ZJaGZ96wzHrt/G8FYohe8YtR4nL1/KVYNmU9Q3s1lOwW2DAGHc/bz3AU07id51BUSswNyqKrYDoWPvVa1y6mcj019IyEnuFvLsGTR5n3/v2qVNEiBndYx1g4rZvDpczpwFbAyXRnfIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwwN18iejUL/rIj2Ulfk1oOcGUuzC4ODBx0QjZWLR78=;
 b=Qlwt5d6mKpWM/9lxBS54UbC6qz8cqvl+dqzL7FeEo9h1lBSXI8jZm84k/zF7zdCm8Uqg0vqaJVGjrCYVR3cDlYBTqg5ziiEYIwy4G3Kr/zB4atNJStfN2QFB0wI1Ixj1jq/GhpV3CDtVU4KiMfCtsnJherEysWKxyPPUcPozZMhoGAt7T7+ys19ZK9IKEKT9+4Wol4K83XcFc8VcXDoSzxCxb9EVd4n9JWqS7ygUkrL76ia6/ybc6dAMYwSFhXifbfutycPK3dVFGUtqgnjfcNVmO9BiMILxHYXs0YsN0BrqEP7CVgPge01rBheu9yhG7hy7Jcs0FDu3CAD0GroL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwwN18iejUL/rIj2Ulfk1oOcGUuzC4ODBx0QjZWLR78=;
 b=Mz29LyxnCTkZ9mBkzd0qo2ZsqpCxMQP6wgrKIgp5rPeEKcnwVXraxPmN64paR9S6g4O4y1xG0eg1dglpERy2IT55r75/JpVCoES8eubXDS6slv/H5M20ppfi2/ZhznUa6LAjor32rnl3fAWNicM+gCrvCMZP1CEe/suWtz7kSSk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 11:23:49 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:23:49 +0000
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
Subject: [PATCH v5 0/8] RISC-V CPU Idle Support
Date:   Wed,  2 Jun 2021 16:53:13 +0530
Message-Id: <20210602112321.2241566-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.70.115]
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:23:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22fa278d-b646-43ac-612c-08d925b8e47f
X-MS-TrafficTypeDiagnostic: CO6PR04MB7810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7810E52A12EB0DD7505E41308D3D9@CO6PR04MB7810.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yN3bJYMRPCXFcb+V7d8G9+laI6FR5r16zdKE+iduGxpqa4/Hlp+XkrD1wdkhdJ9kpblk3xl/DMKmH4cMxYprhVQbm8eqmXM2t/iimMwAI8ZvOAYy3+ajMaBIonhQ85XSWd38/bu0/csVgEki8Y/ts0CEg8QhN/tAnNMQjoLgGsvtxNA8igovG0EyPZr6IVZAfKUMFq0b9brxDPmistcQYd4ATZeT7B4FgDTR1iRyHMtCJzoLrZQmI/nQL8H+Bjjtpjd+PzeLu6keioSPsJ50phhWvf2qYhDR0IJGzpSpk5pJF40nnAUP0gwPBA59HqRa4PI/CaEPVmO5YGQFze2kNXllXkuAjiBtLcEYT3+/dlAsRL05rsjw8GKPm1Fw985GY+P7f5OYAm5aKNRxFnItKfHUWBY7FIvlZJnBtL0tVGIweMp/Bsp7ZTd9SZa2WhRmv4r93RWdV8PaqodanezynGjbA8KySp4KckrHOhxEPAXDU3l/k+KokSyFBWXLsNGHbrFSONDCFfGyefsQmH228MSxtYFIWpoBIg6hdmp6/wPN6NQpJBN5wIngNHOFF3ElpugH55153Y4dpKo5jM/s8eM/8zfMUUmfT2ygDuSF9Khyzlayw0gJ1ZI1RuoHdWOmY8uQaeHiSL3z/fyNwWY9NunEdrD6YTrr6CwbzEw0nCRp/wvsHCaMlrTNYvGXPSqCexQ0KX4oGYD10Iknhfgef7SScRoPAUbGSyGao4CDGe6BoPbZCePwqPJLDf9mBAcEXDSOxEY91FmFWDbcWrct/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(186003)(16526019)(7416002)(8676002)(6666004)(86362001)(44832011)(4326008)(8886007)(2616005)(478600001)(956004)(966005)(38350700002)(38100700002)(8936002)(26005)(110136005)(316002)(1076003)(5660300002)(36756003)(2906002)(54906003)(83380400001)(7696005)(52116002)(66946007)(55016002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cagKfwr15fMD+NLnXdP3QZvDhyDasYdSaDPtg8JVbmMETUgFOv2NHu3vjb7J?=
 =?us-ascii?Q?3FiyeklK5c1AdqoR1Aa0uOx56LJLrNeaSSWU39Pcm5TPnDWhRVuo+r7hA9Fz?=
 =?us-ascii?Q?SOy8tnGvHLNuANEYxDNUkLIZcpTmaKQKDtGgPkX4I28jxtWcCkagdQzPM1Fo?=
 =?us-ascii?Q?UaxCBCBCaRWZ5tCQ4PJZpsO5WTBFbppsWXx0CCIEVXUi7mxrMEkymFnO6tpD?=
 =?us-ascii?Q?lBf2DAg4/DrgIalArjqtJI4c4QkqMHNlXZmsH7+mrrgnmpnYtl/FK6ZlBZdd?=
 =?us-ascii?Q?t5xOXO/85rpLGWM79lDTARZ3aAR0t3pB6g86NmUKyLr+5bApvUpgCgZxZfQb?=
 =?us-ascii?Q?S8uQoi4sHTkNHDwbbWCdOAnLzkWyBzAo21UKPgP67bwPV8h+dQ3gLLnaPIIr?=
 =?us-ascii?Q?4Bnx9cqHzGHxYCzIj/a4Oh98tmBa7F+AdpL2F4Y7iyctQGjJx5cSHdA8kAey?=
 =?us-ascii?Q?tFjGde7hr+BSIoRw25fMhWw5QneTd3a1UVnabQiJXlp1qEULpmm/bb1AtMK9?=
 =?us-ascii?Q?1n6h0fsJDVWqgmLdYtqEL7Qw3+LJ0cSm41nflchfmBfjb2oXqNClmG4mWIIi?=
 =?us-ascii?Q?cAhBcm8zCr45IbNOjZfmTVzqoJZfhvTkg/RaQg3zE2qLn+zGPjdrWrkKlfe/?=
 =?us-ascii?Q?jqcyLWMW4l6Gve5JW9od0TUqx9kKhbNH8+Wbap8y2Z5PdPqGzsU6Zc4GzCtg?=
 =?us-ascii?Q?9fUbvdpKEp1eva1596a+rb0KXrK8joeicetmvFU5Ac3NIi2Owetsjo4VR6J2?=
 =?us-ascii?Q?tr3aWLVFKO0EgGkgdZ+0apqXjWhniq69zNfzbOYkCqRzed6TAc0yeYW0Jv/s?=
 =?us-ascii?Q?tvrL64Hri7bEG2ZqoNLcBDWAJO5PAcB+zWnFdeBDimPRX1iAEgJoim6KOF+K?=
 =?us-ascii?Q?MDF+61h/Jk3hBa2RXgoxmcKmXcOSNOR1OChCe6uO6ZqSBNW5PYy/3I6ilLLh?=
 =?us-ascii?Q?u6wEXJtk0urFuH1iKgMSENNNSfENBxbXd1q8mu0SEtDMVFvnpvnO9z4iohI/?=
 =?us-ascii?Q?FXvIblmme51MYthT/mzH7uHdPccjBUqxh4WowXJj7YP5FVMvhrSBjG2mY6xs?=
 =?us-ascii?Q?fsiut4xi3RRb0wjidt0glvL9Yf4OfRTGhJhiuIJi6mbzLRUC+Z7hJOaHsEVm?=
 =?us-ascii?Q?M9WyqrWkz7eCT+bivKi5pwdjerZomzfM8Qw3eXqJ3uzMR6sf0y+fwNH9DGxf?=
 =?us-ascii?Q?P5P+dOrlwlWl75aQsQJ3c7cVapUERr0Fdfi48VH18qC1PBV3yhgsO6j2r9L4?=
 =?us-ascii?Q?qkE24xPajWIQJxpVocsbj7vdNuEcZpjV2J9yehlpZsnh69viy9iPdU6m3CFQ?=
 =?us-ascii?Q?8VRA66G0YshnRMLzSS9BCEfv?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fa278d-b646-43ac-612c-08d925b8e47f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:23:48.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3QWMdRN6FURGaVUr0vj+F+Il6kqG6Ee9YEyAyfXtL6CRhpQUWsemtpz6qkqfiJ7Kl1AZlKmneTt3TT8pP77MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810
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

These patches can be found in riscv_sbi_hsm_suspend_v5 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

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

 .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/Kconfig.socs                       |   3 +
 arch/riscv/configs/defconfig                  |  13 +-
 arch/riscv/configs/rv32_defconfig             |   6 +-
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
 drivers/cpuidle/cpuidle-sbi.c                 | 626 ++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.c               | 182 +++++
 drivers/cpuidle/dt_idle_genpd.h               |  50 ++
 27 files changed, 1475 insertions(+), 183 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-sbi.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

-- 
2.25.1

