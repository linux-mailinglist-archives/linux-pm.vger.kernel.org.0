Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E525932096E
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhBUJjl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:39:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6875 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUJjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900380; x=1645436380;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dpr/XfxthK+nJGZ4VnngtvKO2IR16j6rkRDJBkddDUw=;
  b=bFo/rImJH6puzYY+feU25cElmvJwo3nzL37nvbVw6Yi9rWUnQ1LSaaE3
   YaJa/XXskfQPPbXLkkyjc0tdu+xLMH/IILueXRzBlPxnCj2iufbyYchIF
   aUUn146UhF56PJkPQPJOvlh4Mf4Xyy+kBiKvkuf/5vxxe/Y7OYAkCLvHC
   q+IZlDbFWJ04l5eRqACi7I24xehCD4E/1DCrPFox7io7CGtP98YoCHzoq
   R2Y3Nw3lZL754WrjhhdddU+DgTZmdGmkw8rB1HbQOBjXjXD1NfoFWZEvj
   5xtp7hYVPR7PfTRvsvWkYCoD5oiT6qphH+nvzJEbB/SqAzSQ5h8yL2rim
   Q==;
IronPort-SDR: 4+OJZvNnWInKwnlUygVwpWmM7V/exlRnM7oQelPDdwL+6e2K3j8sRI6ouoYL0bHixPpLmNB1qt
 lMplzC1FKmnE2mu48mFfCKdKOhviu6r0/XOnDPHErNf+b5FzQIDlYaJgrcl8EVK9naE3z6oade
 ZcSTgPLGgFlLPIICvEV1B2G1cf76zH7naTpACnh6yp5m0t3I8QlQFFkkpJZo7vT1UpngUfziIR
 +XKiOCWPYFXmSkRk54OztmcO+K5t8wuloaILcxEsqznBMQRlguM8NhB+cZzKDXYOQbjCvZwyqV
 2NI=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="161607376"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:38:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwRohGg3zemnW5juk5yQhzzVjOvz5y7XovXXjAmAXklkAN6N4TqC/zL/O+bK6CW0OPAnjE0tmTrLM5m6TA/jV4eGuEjCp3d1wm3BnA2ijkaAALIdK6oavXxepXBotKlsGSkndX5/4XqKCRgI5lTfWUbudAsOGiwBnTbF0JrqVeR4RQyYFL1gRyc/8BixGtbfG5v7rB3P2JCxDIuM+Mwx781iqlJsVT8Yrg2RZJuLaPYKnma4t+if0d3wa8umEnTrgt9b0dBs2LAc/v5yl1DWVluyx7OvfPrycH/BXlTRgW9SFhvc+5QhINUpbVwba6ohqkPyFHTVm1i+KmtXpAYGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdLUe1HOtrY2wRwP2JscZ2Ct/uVgOiGk/A3L0KsYiwM=;
 b=Ny6/8peQ0By3cYbm+92OGkEW9/1sPP7K8JNbW9laTUnaTOZbqLQGZqHrDfRU7BLTU/ixfCXSHvdVjtK0zaL0vWqk3DNf8oaBaAytse1onfYVf/ORwVaxKFnIwSEWvtioIY5oveys9/dyr01XEaR6q9WZvJi69VYV29I24fHcZo8eMAbfskDU/9IUECWoDzB4B06QoMzBdHHP1yVqR9q+XV+hhgntPX90h2MTtI9QWN8YMVTj9Ym7hxgQGijwoUimnDzYeTbEawTUUDu/njb3K+OW5mHaQiBUDNOYqlvYBEevB7DOtDPjU67YKBIywSENjJxEnQeqFQua8lOAoYoLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdLUe1HOtrY2wRwP2JscZ2Ct/uVgOiGk/A3L0KsYiwM=;
 b=Zr0Xn6UVL+9X55xOI/hqBfGK9IIgp7v64+l/zNWIxqnQQftJuTFIyyMYqi9yVA4dGOh96eu460fKo4gO8LSe44m+glzi1aIsHDRyAjdTKxB39zW0MNlD9sb+5UtxN3BsVPGlciqhp8JxOMVRPRePINjeLMOMeYrU7CIMg1/c7zs=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:38:30 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:38:30 +0000
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
Subject: [RFC PATCH 0/8] RISC-V CPU Idle Support
Date:   Sun, 21 Feb 2021 15:07:50 +0530
Message-Id: <20210221093758.210981-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.171.12]
X-ClientProxiedBy: MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:38:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5cf8e83-c785-4efd-77ca-08d8d64c728b
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0459382CACA52A7926242CFC8D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3j/y8JvgT9lHnaf22Q/afIrGm3v4f7r4G1h86G+UOs2HYcOjETupOjlhvyk9AAGlAsbIiy+3x+TYJqNxm5b4dJUi6cPRykLWtkC9Ozvv+9U8nVoWFaZ31FHt1UIzGlBdU3UFTSyJikhDfyOCen79DasPqhIcvv8iurOqaD/XYHpdXFz/3YUgJu/1qnLZ8UNmN3vrFRAqYa7q+OQmVYKmRrIwGdRuCPJXRP7Xr9daHrZAlrUBtKQ5Cg/4xDXAHfxiKAJUednZvf/f3AylqoojmV6XtWXW+Ty7wQTcLSDDDLgcApeUoBcHh29gEhSE2Z1PyQbac0L/kEeAu3QpCIsVODLudRXU2psziPZs3M431PdYv0lmIyxwJfdqnMx1ibjBYnQq3pO8wAOyRwGoUtVOWqp0hQ4quTXVqBESb8bh8gl1Wk74//y/M7e4At3Nex8GDLpYAzJ9nCivtEqV24/KPo5i1mfYZAIjLs5Fz/sRMaPLDxsoTJ24e7UXhtjGTkPZtdX6cjiNwf8merygCUv14WoCa/4azFyy1+ETew+SfgtguLSJVshwbPLpGkAyjebxOzEOh+N5Kx5PIF9KCyyxfo69d7z27PPqP6fGQyn39E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(5660300002)(54906003)(110136005)(966005)(4326008)(66476007)(36756003)(83380400001)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u2V/BEXjT43Mhb8C+7+FjVdueJDHmbQJHy2/L2Ykns5UOjTU1Nmle41MbJe5?=
 =?us-ascii?Q?+nROspTkFN4etn6M57k0RQjPHIgqnMNV+LQxlPUW2zmQSwThcvjG/KyK2LnG?=
 =?us-ascii?Q?HIIlXNYHWJ3TBETuYTZXAC2O6C1cu/WDbZVcae9q9xJ8GeZgRsuTVCYC4DwB?=
 =?us-ascii?Q?GqFknBwhphsNBRYvEWds49Y+OYOnTa5GvysJfcwrVMDq/EappTINVNPWttcw?=
 =?us-ascii?Q?s1rdP5El60FZxI+Tk0y3hF43kPEtBeNMLHjNvxfop14Dek3rkvU1g6Vbpr5n?=
 =?us-ascii?Q?Pp7T5KnB6vgGQ7o3YYDIbc7jf6NpWE/hHhj5hBAyyVSTnMtagyCnJHcjmK/f?=
 =?us-ascii?Q?KBsYy4CcSw5VqLSV1uj9xfoCOYtDqv8XCu5OIjKGSApOXYpDrn4sGSaYJwOQ?=
 =?us-ascii?Q?xEcC2LMuG3Eh0P62k0rhwzwx5zO2NjEoKbHTYYiS7X8PPR7Y+S12qL2MokYi?=
 =?us-ascii?Q?Wjm3xMJLrw6lNDybSBLCAeavtpmh5PmCpfhP0wk3mWCXovHnGqFNnKGtTDM8?=
 =?us-ascii?Q?JURdaDcZIY2rfZq9yAI1FRXBUGYG3iUbjNXEawi7cfbhS0xk/iKRRwQD6Y4/?=
 =?us-ascii?Q?LF57+glU97vjH8YQtVSIN1RE9chwAX+1ydSdOYBD/CNiaAjajIj1Ar/oGBfk?=
 =?us-ascii?Q?w5JsOdP5yWKKWXVwF+yeeqxZ9Lzi2+SF2DAH6loBVzGH73ql1z3EA8UyZw92?=
 =?us-ascii?Q?ymSafI2K+QHl1KLvQk8e1GlVcV4kXgH29m6BlrmFFzRZwgFFkwBt8S8EIixK?=
 =?us-ascii?Q?gZ151Hom4qsqQKyXtXi1/cVRNAnBjoTGWQ7kEqinT8kbrHedlDyC/tLJbEB3?=
 =?us-ascii?Q?HrWGMaHCXPXOwb4kvhOSBDgpYqq5sk+dSnPkqk5tZSBxrucyHQkrpkf/DGfN?=
 =?us-ascii?Q?WkpEPI7Py2suyDUnpk39kitMvxdY+3i4gWFo9ixD3whb76QHZuEHF9n8yiMw?=
 =?us-ascii?Q?HIT87/92NNgn+dmuhiRA0I1VBY7lmtgwREc8ZM5DCuKi1keFN6s/hNQGzPhQ?=
 =?us-ascii?Q?4QuI0NwpSLU6UQ7siVkXGxHNYH1nDsqCsMcTZmUgfZqfOBJThMWsSAtzm2rj?=
 =?us-ascii?Q?vzGUnj9dCrVc1VR3j/b/P3KYWa7z4j2aLGunjxrVLOz1tzj595608e/dXHu5?=
 =?us-ascii?Q?gzmtQZDtqD5oQbDPavKNY+qPUWKN8TkGQR1Nb/WZV4UK59vDgznhYvseD6Dp?=
 =?us-ascii?Q?LrXmpGzhtwHvUhZ3KKFqp0kLUEwEpyjRtREeauvTYwuG7IytLXQjy5oNh/wo?=
 =?us-ascii?Q?xEeeXdtDVS7Ih8wqSSl312EkmtzxTGSougiAAOOe0gPC0/GHVk37B1s6DbcJ?=
 =?us-ascii?Q?nKZSc6rbrfP94T3RDQ0XN3Ev?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cf8e83-c785-4efd-77ca-08d8d64c728b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:38:30.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMkQ3l2gXbpDdna+qf7OsxEdLqy5L0NWO6Rse6RoDUgAx8tYWOirCpbx6Ll20whFytxnJsBBopUvTuvasX/YHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds RISC-V CPU Idle support using SBI HSM suspend function.
The RISC-V SBI CPU idle driver added by this series is highly inspired
from the ARM PSCI CPU idle driver.

At high-level, this series includes the following changes:
1) Preparatory arch/riscv patches (Patches 1 to 3)
2) Defines for RISC-V SBI HSM suspend (Patch 4)
3) Preparatory patch to shared code between RISC-V SBI CPU idle driver
   and ARM PSCI CPU idle driver (Patch 5)
4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)

These patches can be found in riscv_sbi_hsm_suspend_v1 branch at
https://github.com/avpatel/linux

The proposed SBI HSM suspend definition can be found in hsm_suspend_v3
branch at https://github.com/avpatel/riscv-sbi-doc

The OpenSBI implementation of SBI HSM suspend function can be found
in hsm_suspend_v1 branch at https://github.com/avpatel/opensbi

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

Anup Patel (8):
  RISC-V: Enable CPU_IDLE drivers
  RISC-V: Rename relocate() and make it global
  RISC-V: Add arch functions for non-retentive suspend entry/exit
  RISC-V: Add SBI HSM suspend related defines
  cpuidle: Factor-out power domain related code from PSCI domain driver
  cpuidle: Add RISC-V SBI CPU idle driver
  dt-bindings: Add bindings documentation for RISC-V idle states
  RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine

 .../bindings/riscv/idle-states.yaml           | 250 +++++++++
 MAINTAINERS                                   |   8 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/Kconfig.socs                       |   3 +
 arch/riscv/configs/defconfig                  |   8 +-
 arch/riscv/configs/rv32_defconfig             |   5 +-
 arch/riscv/include/asm/cpuidle.h              |  24 +
 arch/riscv/include/asm/sbi.h                  |  27 +-
 arch/riscv/include/asm/suspend.h              |  35 ++
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/asm-offsets.c               |   3 +
 arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
 arch/riscv/kernel/head.S                      |   7 +-
 arch/riscv/kernel/process.c                   |   3 +-
 arch/riscv/kernel/suspend.c                   |  86 +++
 arch/riscv/kernel/suspend_entry.S             | 116 ++++
 drivers/cpuidle/Kconfig                       |   9 +
 drivers/cpuidle/Kconfig.arm                   |   1 +
 drivers/cpuidle/Kconfig.riscv                 |  15 +
 drivers/cpuidle/Makefile                      |   5 +
 drivers/cpuidle/cpuidle-psci-domain.c         | 244 +--------
 drivers/cpuidle/cpuidle-psci.h                |  15 +-
 drivers/cpuidle/cpuidle-sbi.c                 | 503 ++++++++++++++++++
 ...{cpuidle-psci-domain.c => dt_idle_genpd.c} | 165 ++----
 drivers/cpuidle/dt_idle_genpd.h               |  42 ++
 25 files changed, 1218 insertions(+), 367 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-sbi.c
 copy drivers/cpuidle/{cpuidle-psci-domain.c => dt_idle_genpd.c} (52%)
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

-- 
2.25.1

