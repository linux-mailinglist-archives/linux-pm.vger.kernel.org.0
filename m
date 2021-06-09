Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3143A144E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFIM3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:29:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16006 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhFIM3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623241661; x=1654777661;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=I76/Ufb26uhC71/c8XcGcydZc5zpDeA6KsNaqsIgznk=;
  b=FjpbXI3nnscCWsu1WmIkb1lTMxCvgJf2XZhLpp0NtJE4L2tQwpZCtnIS
   vLxPmSX6xqj7hY+dMeF8NskscimguaUtqEOoC6qK9a7GlJsIjJpxxvFru
   vCm4j1hlaitXvy4xrZjl7H/J4T2CvZ6RUUj/hZLL46NwEYAVhnV1sol/b
   qJP4z5OpbLSEDxXSNL+NioLIjhRf76R2vFBnx71X1Bo6JGX2goqw3Fk0Z
   vXVFONcyASii/+ao9K6oK1TZT5j48PTnrwLxT8T4GsuvyV2tbCf2WeHdD
   nPMI1CPeq57I4tev8u+YjEQ4reNmFpDvc6cMnnKRI5d7f8DRVPaaYcHM/
   w==;
IronPort-SDR: 2Y2rwYYAk+KqsXPnhBpsK9Z10Qj7BiADLM7DTUxwNc/xDv0ZFrMMSKwr4wfNmeTP3XIKxjCd8q
 OzT23ae8XEQKmIdKSz9PV9gIu58IjBYWRD93uzASoYridRsunY7YjLvF7ZSqC3i4J7OAgC1gj5
 BxCzxk1GJ+tpHIefMKRmT/nFAYWPPLh8d4aTUXFdjB8j/hQFl7ys2MKLYY++00jDZpcIKU7+O6
 Owq1xWgr0zYfUhvRbaQURn9GR7L1NxlWUJB5mxbGtNuY8cCl/mIsg0Bnj/lyy6P9pTM2hd6aDb
 pnY=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="176057710"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:27:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht6NTwc5DC20kbVc7wmfann74tRggQkz/9RfDt7FFUdPFikl7WDdjJGFsWKacTXhi5WlCtdSSmfWZx16e+e3mBTqN1Y9frcDBR6fSCnwIW+TIfqFaHXbx5NvZnkQaDEN6WkZf9Ic+nLRVrvmKonoo+dbiLUk5WWBJXMU9HCRXDX8cGJkDoB1w9SvYQjvN4yE8H4/cvUVSHOhIoDnoKQ8rOUUuQyqsTtB+LqQTgDY3uqbs/Ms4dwgi+WGgWJ9QruY4uP1UTF3xlpvibsPPfcAOym0lkd02K0K87YD4879bAzTK84oZ9vZQ3BDNPrhKrT+3NhN27Jn4+aIdDtg7WkXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDqJbzooJhW2O5cLi+D00NiBCWVlzgC/bjJH6NpxeUo=;
 b=aDPAaJ12e/9qh8w464K4qK0lePnCe2N/yskumCEcDFVWLnquOI4i0NM1qe3i9/FKHMTf6zdGeEJSISvQ6DE4Jkh7A9RycvrwoNwKHRJlNRGLbovMDi20zsYOKDMfH7aoBKyXhrM0skdU6/VMz4DQs72daAHa2KNqOnnBZUKPK4oSdf3Ks7k3IAGaLrTl7A0HBpsSk9Lc7QnfakuTVMF2Fy7cWyTQXa70j1cwGKBNGMGV9nvHUj4/loLLXa03lALiVZIZ2EHk1LD5djbPVHtRJ5yXlIRlBH9Gjxt5283fYq6Ezcj+COwHP+BLM0KwpD4WHrrMs066uorOLC8dftNOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDqJbzooJhW2O5cLi+D00NiBCWVlzgC/bjJH6NpxeUo=;
 b=njYDIv3+7ojRpYlmhdiyu/BcANnSfda0MGtxI0P+1IFo58A8crVJHs+gXzJAoNNBu39LxXZUrIs9oMXhVtQD/97vGHlw6q0s6VpWgpUho0nnd+3kWzWfl4SEQN47gLv4h/MZkN0Da/V9Qz4so46H+56IeE9XJDBhetA62I3tHG8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:27:39 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:27:38 +0000
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
Subject: [PATCH v6 0/8] RISC-V CPU Idle Support
Date:   Wed,  9 Jun 2021 17:57:07 +0530
Message-Id: <20210609122715.3389-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.172.176.125]
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:27:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca30a6ed-06a7-47e2-f959-08d92b41f80a
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7843545ED9A13F022EA038828D369@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZptQZ2nPEYsBQJkeFF2bLHHISP6FxehwnZgmlLawQ0TmDWSpsG9zqDLGy2CdCYE8hF5f857FIRb/uNXh/QBNtSd/ES1WFElOxom3WeOmb37ZoQ0QN9JdOsCv4fnwUAby9vXmRMriC4BW1BSN7f7ezPCU7Jyucu2SJpoYJ+jXfwhX1qXHTygi2Jcw06k0suq5m8fSV+nPsCHFlfZkEToprQxfAuDCnV7aPc8cw0aD7rOR7Tw8/fhIXcNR0nM9SLJz8eqwTt6s6mWr2OYl3ktDJQu/oo6K2d6dEmqB+gdgYiL0uYBrr6AuxR+bWpaBRjnaeepaWW5f14AD9EAnNIJbHXU/fIQf2PZ+/uCUR7IhY5XTBodE8Fn2BM71anKEqv4xSAb7EJMYy7EGMl2CNf77Jf9huu201xjj8/RrD2n5FcFkpUhb2eO3xnYNAm+8ZewRHQlyISdb2e6W07gZehcaGnkpnCxuGJS/QrgYxrT0LJAMGAtYdBrOL8WEotNYOF23yNTUtIdZ13c30yMAIsg8mmq/T9soXyg4ytEvYMdFsa269xId0XphDz3GUqfXod/l/fhJrh0/stmMZtiN2B9I8YwidMwLA70HgoeNqZG8FHFW6om8Bk67ZoCme+Djfr2rn+Yv/kSnT2nCjzimHYAefpU7zS5Moieq8rv5cAWqroRpeqzvP4mNQP25YegZuD7+np4Y1hDId4yaKqaFRSznJkAQplwkQN7FS4/vzSOvBZBkiJ3OJz+SWK5hP3+6fcy4qkgpvEQp0pCLYmqynPHfQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(4326008)(8676002)(8886007)(83380400001)(478600001)(110136005)(956004)(316002)(86362001)(6666004)(966005)(44832011)(2616005)(38350700002)(52116002)(2906002)(55236004)(7696005)(26005)(8936002)(38100700002)(1076003)(55016002)(66476007)(66556008)(66946007)(36756003)(16526019)(186003)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ly+o00+C/Skc6TsBr1ztmUJyxEAe7CyQ0t0Br6BO52RNAuwFazZGKapwO/dI?=
 =?us-ascii?Q?PLAzbZCELzNK9wSQwpackGngihgX9T0Hot+k8TIvaVBLkgX4ELjeHTWg/x+7?=
 =?us-ascii?Q?m4/wcLdQy186ft3puFjzSuSFozao222ODh2KMbsYERAXUYMEBIxWhnQtEl62?=
 =?us-ascii?Q?8NSuHnxU/09emt1fHsWjno2tYjRQN72fFfmf6nWHR4cpdfqdvu3P+B39rZ23?=
 =?us-ascii?Q?N4IoSzasnseOAFqH349gtL8p9ye/EThb8+KFq0oJ7JLEOCw/lM6TaWXAyewX?=
 =?us-ascii?Q?dIKQvCoAprE0mmHnBWTq6m08/NSHXSf+pjuXEtNIzI0LOH/zR3No2SgtiZ1K?=
 =?us-ascii?Q?mhHoHxFzqRiGIiE9bsKnOpZDnxUTTJmEeUZA/0XIex2ojKvXqEAtlMLr1rmI?=
 =?us-ascii?Q?qlUgYod3x45WuxHSAF30VNQwjoyltwT65O7CBLpFTnPmr3L0aO3nuhB2c64e?=
 =?us-ascii?Q?5ds/lXkqiD5u8qzRrKXgjYTmTghH+09dMpiHWYOnmi44F5z2yMnHeWYf6Tyd?=
 =?us-ascii?Q?OB+/QGp1jR0jMTAk9gtJ88IMXSTlGZi6IIq4veg0EwyICSWSF01swVpKApko?=
 =?us-ascii?Q?BQAj/5QMv0cxL/6C2/rf3kQ6uN2illdoyOYDgvPK2PH/2VXWxnZMi6q61/OD?=
 =?us-ascii?Q?C53TlIyGr7DgklgjEXD0xGI8XohmB395G0VVZU+AMDNBfAiFOAH/VtmP3Ai+?=
 =?us-ascii?Q?zYJwDEuModgTVUgA05VtlrYGYnpxhS4SOxN6mLzHufVmy9FX03CxOooopj58?=
 =?us-ascii?Q?1g/Cceth59OuogXPqJn5FRgB3hNzpWf0tJTF+BjsWgw4JEoozRqhZgCire2V?=
 =?us-ascii?Q?uQVD0txpdB9xD4M2avJnJvjD8VkUAj6Z4t4F7KtNHY0kCRBAGI9hwUws01oT?=
 =?us-ascii?Q?jjEFBjEUfU0+FzzpYB6gYj7KUk4aTBdBCRu31GpaYGaH282V/sLeyX81TeBL?=
 =?us-ascii?Q?Fc4aIcz4h5Ed6D9zOTSAok9CHrN46A53MVmt42cfT1Mwf3lnppFSNHco1PWJ?=
 =?us-ascii?Q?PpPzgskxs8Tmp1ehV5F2y4GhuAioJxyxR6yB/tpayzwOQwX21PT6VtPwlNgI?=
 =?us-ascii?Q?gsmR8o5ADAZcOCfyDxxqYzTkNBdAgtscJ6/nFccgTI2G6y+M1K08E3a5oOsp?=
 =?us-ascii?Q?KEGJmicvAsgTM5Yh/vGNhvZJcSnU4gSI1a3CcVxmRdWvnog7Nn4K89Oli2dM?=
 =?us-ascii?Q?mnuY1hxImeDhn6Mz4HSSvLQdDDvCPhZoj+LvN3/reD+fTLg48VsSMiNrpdBS?=
 =?us-ascii?Q?Q4fevZh0C39LbmvhcNUbfr3RqdUr43gE3AkIV3z70MTIdqALLLykLZX7CNTl?=
 =?us-ascii?Q?sXmdHrWFt92Cx0qgGwQKVbmZ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca30a6ed-06a7-47e2-f959-08d92b41f80a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:27:38.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmguFZ3LI0cKyQmvh5PB+U7V4UAdojjuQynOT1fX4vc87e96y6kB2ZZcL8n5L/QPdJ16gJHqZLYI1UCI3u73+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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

These patches can be found in riscv_sbi_hsm_suspend_v6 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

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
 27 files changed, 1470 insertions(+), 183 deletions(-)
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

