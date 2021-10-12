Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3297542A176
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhJLKBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 06:01:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17316 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhJLKBb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 06:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634032769; x=1665568769;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wkYIXN1pAyUjrObVDmlR1Nmuqmj9mBA80EuB6lFDjME=;
  b=Y07v1IYALacJxK6J/yHiiwiLYCeQqIlKV4V8efWTsSA3s6kIb0ZG1ZP9
   Y5pUumeBxfmbldf3hW9/6/nlXF2NTKQR/36mXU657FeMxET1jarkixhPa
   +AG8C3vRoPQVGn2cJICghM7+QivqBweIbjHY43cb61V0B3n2ilwAYGv55
   sgDLcqq6AzTadjzr+qtYYNYEUloDto6GvgdK3cfYLU1E/EqhVoINNZHdS
   /xycPLXWP7Asg1iMWkwiJkycGM0jqJ4kwXbFJATdbs0MOInpM7yhiNDVc
   +yLOhJrLgE1lmRAuVIiT/01hd+ToQeXBH56YGDwUwR1nA7aZD5CTCuCZy
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624291200"; 
   d="scan'208";a="286442608"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 17:59:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLnnTKablQvKuIINHB8mBCutYHRL1bRmpuT3FW0QPDLKeDIwZFKIW3Km5CMVYRo7RwDFVxx4ngL9fTK7szQZumXcRh90QVG98AxamVTxJn/eXFB18C2hs2skAgtYGCpzZJOR5xpFutUwynwOJ+L5re6J+gU0Ks4PjOiNno6c/HPY6vWiTVo3FnlGfNf0623DaP6uE1VlrNUCBwRcq5dOcZyy1YV3IoFlDY3/sj6OpFymUUgOHZ6QgfEPAlgoUJkb6PEa+tn08ZOntrsrwCp1D1tOFx2fj2SXwdsgux7Qng+87x8p+VvgJmHVOOasA6lFXbtrmqFprx42QAfR9vRWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZJ+3rFpeS3MzTRkgj/yHSOzSxNgD4C86YF+YnHeVpY=;
 b=IqV7XmxTft4Mb1D9wW55Rv2Wl3M/E8RwhQflg+YPIkLbuB6TDV61TFWVFxES4uoDexLeEH+WkS66D5gzthrwUcwbs0KaEchmuaRpxXQZV6CO9Y9nM8I4LD4YQl7QGFgNypxrslDvUYjI+am2xXPdcWUfhJkOPEV3y/RkLNtRGbYTEx9TlUBucUQJFx6LgjJQo65udPjibDQ9badZ6biAUYaDgKup3ghwXbJwYh8GdJsY7C7LLstWyGx9yq18nHuL39l2XOKsE1KQYzZmvxIie7lN4ls8O0B4BeUKbDgZGIV2lyD/r/O2Nw8uHyiAZrSCY41/tTpvMLGTh5eHCoG5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZJ+3rFpeS3MzTRkgj/yHSOzSxNgD4C86YF+YnHeVpY=;
 b=Tus+CaUScV/mGrvKg+rDXWASv3eXchSR+XAF7J89dwE69eL953yozSFmCWLSi0CoSbWuIAtK7Rs1kwbycjDGUEAnVxIs08PRHiQpeVeF5Y7jP2cyB1Wt0kiY9XM9FTlmDSQwtKaY4yjKLkarimhJDoDcsmNEEg4+bWZIFaOOeZs=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8348.namprd04.prod.outlook.com (2603:10b6:303:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 09:59:26 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:59:26 +0000
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
Subject: [PATCH v9 0/8] RISC-V CPU Idle Support
Date:   Tue, 12 Oct 2021 15:28:49 +0530
Message-Id: <20211012095857.1314214-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.114.63) by MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Tue, 12 Oct 2021 09:59:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe14d1c-7cac-404d-b9a5-08d98d66f94c
X-MS-TrafficTypeDiagnostic: CO6PR04MB8348:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB83485D1FE36F689A216676858DB69@CO6PR04MB8348.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa4F4ksnjj0ZUgsWaVwV7YQuzluJ8e1Lmn1U2ZgLonkfF6Ibf7b0YgTTluWdRxty9Q2+GoBM+LCGa/12/T3aFIOhAgBz6lImyq9EW9yrEoSQHKJyxQ3GIOWiL9D0ZNONFE7hLh143RKwDjVnfHC/F4EJ+1Qef9vnNh1vEaxPsd7B/lkukUMN9I/eaWpkIgLuIELFTkTtawrq+TxrDrNG9ckreR34UrP64U0yaFkQLcnaMLq4e4YEGXMqcos5U2WcHHy91g+ngwwkrWZGtamibb17Wlt1dJtU0Ha+ITPhbx9pbeeATaNMct2wUb1eppB4hOpup6ewY3v7K2kQZcy//UtA2XuOA6F/+PUhwE4aNojMMYeLY9AMLXAl9T4KsJem0WW9drbZYdDiLWrJKd8T5otpJw7gB3l7kFOwPt93tTf3gQPnr2Uf1ytTA+Fud0VObXSyTArmtKl6WPwa4X3pfOfjkRBFTEXWFF+HPL0VuazEa5AnR+SMW3vyNgB1tDeLcsAeGy2TvDUVh2DDekoMqVkF/X+DxsVXq92UPrQQwHhxmUIh2rnAh3GeG3d3rTTlhIZBV7oQRExlIyZdpsvjWjoO5eZbprRaHTswk2+loGsUY424PvnY5PgNRmyvJ7fJF4YaVvb2xaRsiTFrugySZzBUCyti5l2rP3jjarg6YOw7q+QEOxqPWUzRZheW8VrLLS1iCaLRZGW7DB9VHMy1xyj41CAx2KEvUJVREmpsXHdZ3f35Gtfw+qmyxTREYop8ttkoZvvl+XOvpYA5oTy58EOBAg7Ubbpkx3tR8sVJ4IQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(8936002)(6666004)(1076003)(8676002)(316002)(110136005)(44832011)(7416002)(508600001)(8886007)(54906003)(4326008)(2906002)(956004)(2616005)(38100700002)(55016002)(26005)(7696005)(83380400001)(36756003)(52116002)(186003)(38350700002)(66946007)(86362001)(66556008)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMTvMaVYUQJ7gDYhuQb3CKI+1xFImh0ZkHJGrSqidY6xdPApbIftyz237SBJ?=
 =?us-ascii?Q?FWW3aSwO1bx0tEBLPi8XGUDxd0dcRpUIoFFPu5N6JctYrNUjlfdNnDIs7uON?=
 =?us-ascii?Q?pnDm9ZREYbj2ZiQ3tZU+ezJXHJibfdx/XsZlbNzCbqOuauVDbRVTqQ83jbKo?=
 =?us-ascii?Q?m4zqM4kY+7WzqJL3I+XKzg9DyORPwNIluHTqRdTb0/LC1BK/wFvEQPxtsGBn?=
 =?us-ascii?Q?HWfC8jO1VI9DMzqCTU1+EaaRsOioAImxaSnP14v3W8VJu7PgsNxeMX3z7fUh?=
 =?us-ascii?Q?SWPbLTky7FYNrzqpSgGMSb2cgio4VMXRawVpVAiZOKdOmrEMvpvdPI/S+Bud?=
 =?us-ascii?Q?Z+6yBa+okDvdZ4OL93Lf4G+P6KNIT3n6Gw6yZxLrkjJSPmG+KgkBCw5puM2W?=
 =?us-ascii?Q?V7Yqelb89CTKsErg6McuYraNQeWpqRnj5BC0E5P5cGvp11YTZ6qTAnPOZPa5?=
 =?us-ascii?Q?criMjAeI8Eroj8nSfsBdUpJ0jLm3z1GvzWssEF7yMMx/nqAmO5sSJ3Gz1Nma?=
 =?us-ascii?Q?rSgkbfHBG3/d290edEtuCOqjfLPhJNxp2IwPe4K/M5VGtV6ey0hM02YUnpcZ?=
 =?us-ascii?Q?hd287eAm9shH1wz4xjSWOFLcFDZrDYYXYBx8Prbakbm83bVR0JFMsBTlVZA6?=
 =?us-ascii?Q?drG/b/LgAyj5NmtsWEO3JAoLaG2s7XzxpIXuqOnop38JL9yA6sgZhWsvFX6y?=
 =?us-ascii?Q?ItPzU9lxOgX6tKizxvaNOjyDyVEBRdzzsbYnDqU1zcHX+NAwj/lAb3qBZAka?=
 =?us-ascii?Q?iBbe+nuzeJ2LUJBmzLXHO/jl2mF83DlT8Oz86oLaq+FVkSdhbz9NnyPnq6CM?=
 =?us-ascii?Q?VC6dpu/Tm0FmcO0MoAZ2TCSw/VuI9xn95DHjU1DWlmsycSc4/Ph60B36t72+?=
 =?us-ascii?Q?1Gw8ATsulWFYS7VAPi1C6sv2FM5+cx+Hgr6S75IbJM3uMSK/0Zllkx638iRV?=
 =?us-ascii?Q?CFaYa6t5ozlMwzUGqlOLKqQV7y8/kp4tNreyyGLwRmt3n5DAzjLv2xeJo47v?=
 =?us-ascii?Q?L1dOCPZ/d/3r5GmbqEeN6XkNCzMm6X16hLCE9VC28YpOP2CdsQbVQHwxxU+N?=
 =?us-ascii?Q?3hvTVQ/yCHfC+14p2eoAmzSFpcsWM4Q99ov0iiMb/lh/AHd6iqbfvxXl9MvF?=
 =?us-ascii?Q?zPfM+n8QbC/ucKMbn10ixSz3uPXfCmf00ZD317i6XO3lAv24OQC5K9O1d+vH?=
 =?us-ascii?Q?6ef6x0CzMzKiqBjUFHLcAuHSx+35T9EtL6NDcksGwkZdO6Zs+AQC7SXm3A3h?=
 =?us-ascii?Q?9APCxn3rVlpQSQcCAsmJYT6982tyhcphauZltjYNxpsUB0hZB/k6sQFYcGdf?=
 =?us-ascii?Q?Tp2vtG73kPeGAPKT9G4LcQJL?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe14d1c-7cac-404d-b9a5-08d98d66f94c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:59:26.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNKf0EGNB8RpuZETYixCbMuNpa+mJvRjy0ziO/V0qDl0icYwRgA5od1bRjK+qbspYSZEgrcVsfjuQDGXOyCYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8348
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

These patches can be found in riscv_sbi_hsm_suspend_v9 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

Changes since v8:
 - Rebased on Linux-5.15-rc5
 - Fixed DT schema check errors in PATCH7

Changes since v7:
 - Rebased on Linux-5.15-rc3
 - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6

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
 arch/riscv/configs/defconfig                  |  15 +-
 arch/riscv/configs/rv32_defconfig             |   8 +-
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
 29 files changed, 1474 insertions(+), 187 deletions(-)
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

