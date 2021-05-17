Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF10382CE5
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhEQNKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:10:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59389 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhEQNKv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621256975; x=1652792975;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=c6Rsz4vFtLv8S9PCqBXIFGB/9VsJ/b0tHA8tmJe5iTE=;
  b=Cv1p9LLgR5ukYKvvcJ8FuUjFC0DANuObpwzpv5teTxSYYKsrR4eEYCgv
   f1HtGNbWKUeqDIh8nPHu/JoAKAT6BnuptHWFL+iwHg54FkBA1KGEFd9gh
   DpFEFNjBKuwaFMeDiamcw1jvgNU8DffA2QNoTEr3vY2HYVEg8DEmFW3p/
   H54+Lf+JLSMP4+c8T1veKySj1CHE25+q8lrLQnQgoR/AUJs5/iBCkBo0M
   FloeutuGFfVpvNfsWR2Jm3hkM2vZzDhZm7yYS0IO0IsIS8zLdoJfSced0
   fR3y8BQbE+zAB1XBk8DoLXHXk8hiz+pKd2v6U/nhLSHkn6YWj88qzUeWd
   A==;
IronPort-SDR: uksjLh87tc/59ZfMke7NuJVtZ2F/tB5QSpsooRkyIK9lD4zygaOTMZa6S0LqpfP0aduccnT3TU
 umt7VKSiY3SIRQs6ZL5/xDGp7O7vIxIj9d39lCrac9fRTSwnM68LG2dh030EuRX0YVdk1OQILZ
 WBPnRBlp/RN9uE3MalyFviEU1mn0N/Y6lGxEHEnf8qhu8U2TBnjJCfhCvCD6oIRC5NqtNoIzIO
 qmst7VGFDyxoiw2qa0Eczs17l8lKfOqVvLPeyl3qFpE/HEVv5zfso1Onn/RQac/Am9GF6Emx9G
 JrQ=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="167757085"
Received: from mail-bn1nam07lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:09:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0KoC/LJRNhc7S3V2aQUvggO576eGZqNbONxqoltnmVPaeoVq3CA8aLTHRQRLZ1MB0A00F0EFMTdnK84sjeXkykpRTiQHYmOHPEaGoK4xJOigKRr2VZEeEm0PGfFr35cZYO7Ki+8C4Q3MSheSEI6YlYvB0o632jlNgGhDkiKuImQz8lFm2Ss4Hk+wq5gf9h3LypqLN9nLhvMZXmmCZbGCBzzI+NRRANBZ1YYJYqG5QJT1KJ7ZGfPv3i86gOc3T2BB5aolosjzusS58t1/JEtbtDxN8Ji5S4HRjGWqxO1jTYHyA91AnGKjiokToN9JIgY5WVD9u8MxMxJjeoFTkgU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X22BmW+VYG7capxoeh1ICZFcEe42+gO+TyA6Wu/yjpA=;
 b=c8eCRXBzIg1bUj6EBf9XlBumzokSKGbgbBoUsx3a6FzqlOp2GyhEPF4R7MG9BCNFXhggXtUx9bNy3qCYOqDYXXJZjImPs0s0tsAXmpbCuPAN9yCHkv9CFk1Yt0LpVYjxFJFqBmwuCKSP/Pj+f5M1cmRbUK0PaCra6yr176vbKyMhahPoBu6xmqsG3uik0OOuk34vfce6QQgJflRxa+FBwx2WclKUEAOnJXMq9f6vgABpx6SZkAJRswTCtjvQCNLJeUNNkJ97mI8pIpEPIexoa/CkOnAWnDoU4P4YyAI0SwEgtAmHUwA3xK5v0xORUVML1ulSf3m6Bjnk8bpWMdI6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X22BmW+VYG7capxoeh1ICZFcEe42+gO+TyA6Wu/yjpA=;
 b=WjW7yaH1d5TUDR6OaNDLhGtDH3vpklP4c8RQ0Qc3KHdgbt70u2l+9eeRk82OBT3aVe07EUbKWcQywhDxkIbdJ8L+oIaYRd+beTFNvdYdp3XZxIJkas/GtbDwGP0bYJ8uVqrWOozed3iFjh0aaQMCKSXQgOf/mSPRnycwuszv/Gk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7746.namprd04.prod.outlook.com (2603:10b6:5:356::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 13:09:12 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:09:12 +0000
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
Subject: [RFC PATCH v4 0/8] RISC-V CPU Idle Support
Date:   Mon, 17 May 2021 18:38:15 +0530
Message-Id: <20210517130823.796963-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.32.240]
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acf8216-f3f5-483f-5e40-08d91934f6bd
X-MS-TrafficTypeDiagnostic: CO6PR04MB7746:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB77466FA0B65CCF5DA6F2BCA78D2D9@CO6PR04MB7746.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fm8oIdGzOopeaxpMSGsaisLrI8fSYvaE4w9FLUtsfk2Ru2KgkCr4HZVDBQyPGya5ddhCJBDgYJTwoukTUChn0/ogfHcWXZ/YkHak4KK75luhU41g5JG/+qqabhk1/SA2FVUGCtPV5x+3nqQV/CmeURe1WKcF34bStVnSnM4Xyz9DH/M9ANOodMr3EpT7vHM9Ruj2N027W2+eojvAjdMSO783ADP6vEVU8/bZ8+X0yi0TvwfIVucGmZH41aFrm1AChcFKKLL2Qh1Z6FjPLClprVIHo+3G2Puy75qUnf1VC76tobEbrQmGezMWG28sQkGa3ADc2FBWOSXj2oBSb60egs1NVfcW/ErIo/Lfu2z88kqvymcVroSVNVVywsOr4EZS0OYFOm9e3req2K1yhqD7KlZrQpURCheBO4mc/nyzzH+ITdYNGaqAS/bS6pOpwvhqiJWITFJ/7OPEJ6tJyDw+4Au9hod8a+23cl+yDNynugtwlpH91xtYphSjhTe+b7oc/pSr2AZRgas9otNA9E9h1N/r21bfcfnC3124mudd/OitbmHicHYpek9hFr3a/5ZumGeMhkekVa0EqdH+f4iZZlqAJMsfYXG3YIrPSDUfsRWWRfQ//R8A/itP+390XXcMLGQC8g5YPkTg4mjEfYoyI3FO0rgTW16/IYlK1WmPwEhB2j8UcDmI95utHe1qhw78b5yaFFHOJdlwGBQHyNVAJUO76zcS/k+bYdC6Cpe9yws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(316002)(55016002)(8676002)(8936002)(2616005)(956004)(54906003)(36756003)(16526019)(186003)(1076003)(2906002)(66556008)(966005)(7416002)(6666004)(38100700002)(38350700002)(83380400001)(110136005)(66476007)(8886007)(86362001)(66946007)(44832011)(52116002)(7696005)(4326008)(26005)(5660300002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z5ZqFspSVOj4q457qKeR85ZJ+makGy7mysZgwnNoS1AwPkpeDX9JgAbp8M6X?=
 =?us-ascii?Q?eqIyrAFT5zoBjDKz2//J+rJiZ+7GpwO1w5tQ7MexwLLS4XXKGt7oipcDIwtZ?=
 =?us-ascii?Q?Bu4kc5B046DrpD6mzBr5fGRx9//fLxlsnY3a5Z7nqTXd6mMTd5ZL1EhrDMxh?=
 =?us-ascii?Q?o0eYodhXUlomFw9HZCYGBbjLA5YoaOxJPUpuhm2cTQfOEU+1pgDuM595plYg?=
 =?us-ascii?Q?tJfPLfV33tBgj8sgZxzUpojxeqdMdmedBeXCFNRB+Ni5inh0b6t0HbQ7m5Bz?=
 =?us-ascii?Q?9UaB+kqrI/XOnGfGkCutuIhct1GMFolqGajKp2HRV7VLU56X9sp85Ajhz2OO?=
 =?us-ascii?Q?dSE4M5h+YnOyXAoRdvIYKLFf83wOY65fEIX7VY8G2k1kNYHm0gxUQNdNctvN?=
 =?us-ascii?Q?GtdCMn035M/FFweFZLHv7ucb8TO9A432e1BVOnohnkeBWhoCaxxqfYWsm6C+?=
 =?us-ascii?Q?GgFuVNocTzb/WldGFf/dWfxLsHHD6/zCQK4c3RbOZxHDOcvSk5xhQlZ0e6/T?=
 =?us-ascii?Q?+6HtY94zNzQ+l8NEIDXobgDZVqIccDTplpH0xbZkQQ9ej+eoDi+KJ3PLk7QL?=
 =?us-ascii?Q?8ESRv/mfJwkha35Rk88FfL3YkM/6G1y4TBNcy6FhHO7pCi58srrvfJ8QpfA2?=
 =?us-ascii?Q?m/xdGvBwTs579Hm3zNXBnTfzzlX7s5ABHog2atU2OBTG/qJoz9XhGX2sb3oi?=
 =?us-ascii?Q?jiZ/nScSXL6tU5NpNiFkVpNOZWeeBieS/ZpsJ0qJcAsCjYhiALZm5pryH+Kv?=
 =?us-ascii?Q?Ha4JXN44TZ+YyMut+9Odzky6MHJiddi2b78fkDMSNpaMxcb665aywtPxqvXT?=
 =?us-ascii?Q?rP4qtF5Tw4RnU6oWiEiDpT6AkegQlW7wJbB1JAkuqS0zPDoQovm8uwRXQHcq?=
 =?us-ascii?Q?VNn+IACTgCMelrQ6RX2O/Y0j4KgEU5qmSBCoWOvIkGu4fKNhjiKeKjxh7NEd?=
 =?us-ascii?Q?EkhbP69v936l0QgJCw5E5/CJZBfvOH+qsEeVtvvSMyOrPhTPR7pjRmd2odD1?=
 =?us-ascii?Q?6WKNAk3vSPcC4FIvEkcUBF/Egmt83xKcjBAq1uNMVVnOZnnPobq6xFNknEAw?=
 =?us-ascii?Q?/PpIlNWqYEbrl+/6BYCgewM9k1iFV+UP556nB8dmSwSsr1s/JEoVGh1ORW6B?=
 =?us-ascii?Q?WDQG/flFfM9OFbSraOF8FSsJLU9qQFwndsyT8aKEKFM5x8cJrnAX/iypfec1?=
 =?us-ascii?Q?3zAwklhx8AW3G64HhTdrhBpN2aDOSuHpF8jMk9ZR9Js/B/YHAGVguwHTz/TN?=
 =?us-ascii?Q?SJ91Q2E8hp6dJnOj31icxzG+eGvh7x0CjyEiEmU3kb4Z233hIi6gma7mji+p?=
 =?us-ascii?Q?i7DhKPvXW+Ec+yNZ7A/8bEeJ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf8216-f3f5-483f-5e40-08d91934f6bd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:09:11.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IA1dQRiZZbUtJ/fsES5Cn3xjCZBqUJyo8vLUThJww0JfwJsgQ0MN4My0DSMYkyo/1H2rp6C+Etxkh/9m5vK+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7746
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

These patches can be found in riscv_sbi_hsm_suspend_v4 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

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
 MAINTAINERS                                   |   7 +
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
 drivers/cpuidle/cpuidle-sbi.c                 | 625 ++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.c               | 182 +++++
 drivers/cpuidle/dt_idle_genpd.h               |  50 ++
 27 files changed, 1467 insertions(+), 183 deletions(-)
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

