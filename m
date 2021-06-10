Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB63A23D0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFJFYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:24:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11425 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJFYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302570; x=1654838570;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=v77JGeRq/OFoDDMPH89Phrwt+HotDlUURzD1a6wAIPE=;
  b=CMhgTMPEfMO7587TMBEXbSuRMQucH8XHuz3S2fMipnF4IYGHHZlJFeG9
   xe3GyyB8PEyWjk8OL4mg1bk2rlhPWDE54yBgsl+FK1c46bE4feqf9uuEI
   nUrs7GfGZkx8qVZqhm3lL3rf5GGHOYrnSCNs6nKNMYjJ6QDfabnazvTtI
   PfxxhxGEabhkfDwJIP1ERD8+oK910HMk6v4dkiiw6MR3ByoiawPQg29fN
   6Y9AMpV8E5iEP2QlWpr9QGqJ7AD7LpUUJ30xpic93lPH6UPFT83ch3C2H
   l9u36BLNNref8Ki5yuspO4txxzcRkzkN4gx6an9DVAM25xTTNFBy7i4tv
   Q==;
IronPort-SDR: f37HqLk5n8cGmBgx4O4g548mT8JFiLwRqVA0XsyIZGSE7bxtU25/3mcpuaNwuARdCnKwkaQHKG
 BpRFiU8nUaTFHbMh0uNxecTS8HodUVPjjm03hUECOnrfb6HGxC1l/gIcRGTIO99mmAP7oION1e
 B0MNR7Vc7EcGwaAfHmhP/GdAxTyjW8zdgUVIWHJt5V6XENDBNjsMlOlj2Tdmc7WMDuXiolQZHc
 UbT1eRUEFhfMN/dfQq5zdrIqGTus/ThEG+3auYXubmJlHQePsX7DT4WiZaBjKhWMtDbY8ckliA
 rWk=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211767"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:22:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/DOK60FWeN69YfEqxv5Z8FVlDJSjOpuFGyQguIhe0uvR6ffY/e1XvQgnKINLEPSah12ifcKX6K7uogKYQZfJzHuYdhYCaM5rEmJW0pgFrGHsLJsvYwhSdfucAbxSxaU+xvCLPlhJ0xtVZtRCGYpjUx4zSMwgVBD+IzN3yS2nCx8VfE6ZD85sBv7QQZmfHrePcyl9kLMCuU4A3sGkEdgwbpo4OcmbnnJM+w0eoiMSRt1mhcgZYmHov0Xx2cZJCULYopI7S/BQhMjdkI1ocOmfl/JXOI2IcQAuZio1Uy3sgwkxO0XUTULmH4tnvCDnFkTJPH4HchVnzGbSDLkIF91lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYbJF/NGes/MKMjaUr6JFZIIqrKfEJxLf1+gxMRxvs4=;
 b=A0a0H/0gvXz42oXSBaBOvkpy8fdECi0RC1BQROrfILAFmWyE/Fju57/fJ2htNR3XZsnTmF6IUrjeOAhKyRgvHX9aRLyICYAuGAsyGnvYY7JSBXYkt8XCM5Z7R63MuyFphXpTVE477UQtEQ/2PYh5ovcCrsRt2mLcmF7yO1ujfF2F/OqvKUQBfvgz7kQaRsXNF1kw07LyNNyjM6m2yGaTiqVSwSB1cgOJbYhlx5ZARXsYXYOuq3s2g0HOFyw1ThPLrbVK/zyALwNK6BiX5uQj8sW9uExgpCJQDwctyV4HY34oMqi+K5h0LJBV/mssPPw25D8vOZc9nyK2DyakxZZcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYbJF/NGes/MKMjaUr6JFZIIqrKfEJxLf1+gxMRxvs4=;
 b=Ga0EK7BW4pxGDBbqwQ+NeWZ1ZV3Ghvex4TsqYZTJNGY5FLERR9RKm/1XRcXNl6uHlpPScdCOvA/om2IhZ18gMgeQOWO/VXr5PVSr057uFeB4XmkKPVCRc5yZWSRbiAemC+Yz/qygAfAeXAQG8bCZUe0lFADUSUUs5csR2CMuWi0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:22:44 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:22:44 +0000
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
Subject: [PATCH v7 0/8] RISC-V CPU Idle Support
Date:   Thu, 10 Jun 2021 10:52:13 +0530
Message-Id: <20210610052221.39958-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.172.180]
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cf4c61d-621e-41fb-8b46-08d92bcfc6e4
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB77788328A748DBD9C25918B58D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhK64JvoL5gCAGwsn7PJujdq8rkAGNVfSddhjCSViTpUGxoRb6CISQCrbexMAsJjNlkC7aTgwJFK6PqJzPJzRrg6oLbAw5dENKb9lL5oOJMW5pqJJKEgcwMZHCxMsF8zRRxRfuJ4ErDY65wD2zIqRHu4wvEmJecMB4TV16/A33AnxtrKCV0KnosnnMlxGZC3doHJMjX/cLw5p7BIMTuGq/wnB9u63g0XmzMtDgj+hv0u6UBHy2kxLDbEgzPB/oqFI2T9PR0OLPS5BZ3wGXvG5nIXUVBd1dvfVjzUTidH9KFYer7ihUUZISoH/zZ3UBvtiOzRBB6td1mZlkGm1wUZFlJZVASQRt7JcpeGcaE4iIt3mc+cs8FEdm8yei9vzU0n0lEo1R1q+kANc0hE4jmjfnPT3jBO+Hw5QVU1QZ7/7aHXIEbxJlX+VUVe7sEXkLkfFqh8OiBDhUP4IAvrT2lqnuPO+3ui1PcvKBHTu6mseamgNUpTZHaqfg0iqKi+DwROcqldzwWoM00rSfCmUuuNLyA5DSBZVyy6NYQv1KWG3G3m+iU72SH6ZDhtGW/NayQlTKwCK0mbDkEH9kAy+F5mjFx3ZtVnEEP47za2BJQr/hoo13PkiALIPMTOunHjbyW1cjDzDeY1PDKHk5uqtSA/LW6kYF36IXwwWnZbN9vD0Lz/wKxz1tY0kNGdR7lBLj5Ktt2a9w0aL7zAI0+A8Jf8wU343hS99oSdUBfIlQA93JoDl9YEXNzWidCok9eIcRItCAn81MIAf2DBRkxzuNB7dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(966005)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXpLXe6VBovtDGk4TaCgITGYitlV1+jhgeR0642XV1rdfl6CTCKtZfZImK4W?=
 =?us-ascii?Q?WdBx2E/uFRNKNjcbchFoaZkXG8RWBzk/svI4ySurBhh44ezrLH3mtCCoW69K?=
 =?us-ascii?Q?36dX66rg5KEzPinqhoLtjMsf0bMCHiSWm7EFkdPMyhC2EzlXWx86ymf1p6GB?=
 =?us-ascii?Q?ECvFvoO4v4Tne7F3JiYektNOeKLy7gWsEp3PFmIEitQXUErs5qWLqI9B3hvF?=
 =?us-ascii?Q?msaUuAnueXYvp4uP6YErUjtoEtHzdTDkqGvuHirZgQNTWLscGxgvtue5FCkO?=
 =?us-ascii?Q?Hb39FltelinFYlzof4y9eWwEYs7GtYbRnSzFPU7AC3Hs1ENlHVU4QgvDXOqX?=
 =?us-ascii?Q?REJ50iVW3wk+gkuhwVLeEpfAcMIlDSP8b75EqpknpwBn+cxBOMcbAP1hEYss?=
 =?us-ascii?Q?Fm0UdogK4N7N8oD3MgQnjzUY43kIGm1jyV8JJ8/dYv+IRzO8Kxech+6YCwX4?=
 =?us-ascii?Q?m6DbpFPcNO+7w2LvuSt/QEQD0hj+oYn2PDq5AxsNSA/Nguw0oUskDgguJs7K?=
 =?us-ascii?Q?PRVOGceDwVqacW+jvktRYsC5o/5vkAgUT79jZ6B3O6wvgUm8BGYq1ZZQksVD?=
 =?us-ascii?Q?/OvE6h4nhvK9jvWLYDr9YHjhOP0MfjNPu1h5aqa9Ez840TzLiYMfTy+DlkyG?=
 =?us-ascii?Q?x8vqbBbQ7rNUQ82eouqFiSkbCPwjfpeoFZkkfink/OmIHG7FmBrvAXtD/lQf?=
 =?us-ascii?Q?U1INjQuA7Z77s3rhX51yrM12YGMjkKYY3jO3Yc5Zj/mNpu0TwtUgaacADiP6?=
 =?us-ascii?Q?Qd4MvVm2k2tMZw+stbbGvWkCwSJZgaZsTB5eQOClxiaNM6uauAlSKEw9Td8X?=
 =?us-ascii?Q?0+ItgETB247ZTYiP33WTeRAw3TIsVdStYrCijPMKQ/yNYrneTD1ZkqreA7Zf?=
 =?us-ascii?Q?xVJDVh7DcqLZYl8eO8/3NSm2uSraVPDvYXnKSPwSGwMTBYmHAxv+YphE/D1Q?=
 =?us-ascii?Q?pm9HgvQ+MnRmJ/2wSmp4JJLwDehnxGvt7WUFqyWR1SD4ECOKIwdDoHpnAks2?=
 =?us-ascii?Q?sBtX1qxuUtUBQq7LH3atq9fcmxOwRWw1EGP/8V1Baj/xlPN/1x9Kl0W4b7yZ?=
 =?us-ascii?Q?tck1JfGqbjGqRg4XKui1X8AWhqNc37M5rhyL6fYGn0aI9MlkDdUK00dOKSHZ?=
 =?us-ascii?Q?ij0wRsIqG2zlS0tVaIgIp2XI7IcnYvRlYTk8kAvG0nEn3NeaMLGM6dvfoQTK?=
 =?us-ascii?Q?RiaXeCRtrP+jJw0hzOoW4ruNdBg+si4qq4O1ASvnPZ3vU339vG7OkrGjHMBl?=
 =?us-ascii?Q?TOHnU7rEssCrckgm8x7xtVWSlh4JpuJFzjkj50GZZRVtzDkoVXXBMXFQDzi2?=
 =?us-ascii?Q?SfVpNhLHCiOepbdjWKZ+ov8M?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf4c61d-621e-41fb-8b46-08d92bcfc6e4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:22:44.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TrkYq4WDcUVRVHcbxFeiwA72WWh6Ftr2btE3QfhkVRlxoftV3MbBpBQ7U7ctjMq3ZRTnYgA+rlWkFiJTGVs9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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

These patches can be found in riscv_sbi_hsm_suspend_v7 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

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
 drivers/cpuidle/dt_idle_genpd.c               | 177 +++++
 drivers/cpuidle/dt_idle_genpd.h               |  50 ++
 29 files changed, 1472 insertions(+), 185 deletions(-)
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

