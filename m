Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77C34064E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCRNGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21329 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCRNFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072743; x=1647608743;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=J6cOeikWsNwSYH65b7jvMHsnnToMn8Rl4DvSqkVb02E=;
  b=d0Gn88lvCui7tg2cc1FNKTTFconG1aAKoKspbhlF4i8FND3XnRWjzwp1
   arGsz2xWt/kyZE4Gi/5biudmnAcsuuebb3pz5DGXCjUYoFixkZA8XpVEJ
   CAuB341tH4uEN+CZekF9CfeT7B3t9bl7NvgZJtQU+FTsaRh76D4PBq1I0
   zc5lfkYyPmvMnf2dgrna38tcTEl8ocSx1pQyN/AFcGRNZHVbYq6hVYEdj
   pv6kjsBJVizuOqfgBpFWZGSj1e6QxOjIVlJ5hd7mlqVXxwXT9wDuoWpty
   hbKtSIPn8V//5vB1kfqSw/jjdhdnp414B5rStNfxAc4vH+AbFroiVpW6L
   Q==;
IronPort-SDR: TEJbsuMm1LVwaQRhhPmjwmKT43TGzGP1K0W9T1qlpQ2hlPEWHpIzmaxE/gFWrOKwqQoj1shn+c
 6tutxK5kCoybuqtDiZLH87rpTOGjNmym6v/Y4Bi8dQeHZrxcZPiR6x4qnEdyLCjE5Fyu5xtWpp
 j2g96xJjpxg52HncMzfIeK+q+E9lfhqx4f0WdbF9R5eoc53Ah1sDiXA0mWl01e1fiY2MDTJkcJ
 Tj1xsuW2EpJAUrfN/qs7EN3seZoNnAvRa1oeo9Cira5+bDAVaA264zI8P89lPXeKOwH984qHY6
 wBI=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="273192060"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:05:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Plgd757sShfvImaRYnKaFyxocKjZXEPnicuX+7D7o/aiDXOJc4h9qgS+2EMz/0lJToGhT3gPa5hNunrUqlLPnJFHtfyrMqFtU3HGPjfcPq2H6mAMijP6tSRAYSCENpoMBAt9nFuSYJAyvGtPq4O6Fso512Enw9vdGSGffzQACtZ5IwkgyzI8jtlnN1KT4mPOFn/L8IPrWjuVFR8/NduV15EU49olfsMPbp37AkHBZkbJs/UxIQLNeA+rJPlenxYUsVBEECccsDO1kPLrMXnP89538VmThRTYFcAv6lHm6qGcQpzCsa9TtfcclonmXQmCGmPqY6fYsWKiHJrVnOtzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqzWiQAIB8jdrEwJroxpDhOOuW0HjAu4BlfYVCMZ79Y=;
 b=an2vkCHiveOoC4EY9b5Z1VNj7PyVGdZOoKRcFK8UpLPqGmLo/RbyHxnIF/ha2DAnpOuStRVVp+Ijy6WCjyygLgF+t6GgP3bE+tX2ZazT54s040kqXZ+YyaMGm+EhxH2/7DPKWeqcqV62Ah0pAil81isWmtfQQyPd5TyU17Fd/7Bs39B6f6ooyU5VUrOXWJ21jeMxUb+EXbAL+a6rS2fMK96IeeXYWXfXgOZw7LD+Mw+HPaifGpiZhS148UJCUShoBBC2aY5k+HDFhrBgDJ5YSWltcpOG5wVqSwvRP5r4KtVPB3sfwSCrsz0a9EaEu/4euHTkPdg6FqdmUWN6TTdwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqzWiQAIB8jdrEwJroxpDhOOuW0HjAu4BlfYVCMZ79Y=;
 b=C6DgEuU5wSn1nJiPd5hqj6jB9XMd64I553oqxWS09s3UvhWhl281075jdK5mJ1Lliww8qFBb5S+z5mCGrBHQSdudkUuJH1cRE5uDxHVz+EFqKf22lLKMIdW41ibGrlpZoTGBpXKzab09TEEIi5WY9JzqikKpFIA8kK0sJoQLUlQ=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:05:40 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:05:40 +0000
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
Subject: [RFC PATCH v3 0/8] RISC-V CPU Idle Support
Date:   Thu, 18 Mar 2021 18:35:04 +0530
Message-Id: <20210318130512.1025416-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.155.94]
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:05:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01c05d98-117e-4626-720c-08d8ea0e87f2
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB08265C670CEE397D85BC83AB8D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zhthiNp3uZ0YKBk/4Uy7LwdB/yEehynDt/mAFdKfr1+nQsDVjEczbtu2z+VSZRjUL0ZvymVXkRlDYn39yp+76vrUrU4e/+K0TmVzS5Mqom5RGqYkveeqM78/TGhoAkURMTHp/QfhzW8owDIphh7nePBWDp6da2OvBgUEMN76+BoE3K+encaKN/xRCSUyfLijaAVlIjU95XxzJ1dsRfHSlw5zAnFfRE6A8xu+VfBn5vAuqeHyVW8tVJr9LVhuvoqBHOW4/+MI7oqDsSe7meBJlHll+jXqdc75XPevWWhUa41FZezhWt8/u599h+1ku6GCWNqjFU+j19/QPSfvdGTzfxJsMrDDa0S4C9sJL59LdIR70j6y8Ba4nuxpqbi29Zmv91e5Tvoda3uTw7w/bxrp7e9HYKkjDGq6yX0E0SpQPfh3+I/mQaD1TlWO1KP2+PoqrB/Cld0aMJM1Qr6Pen5SWiBJg5O8xRu2kajaqEV9YRq/N6NbnwxSqqNLlLwgsL6WyOz1K1LzmxGhiHthnNwvmaFMG0ggC1IxvuijfVyWdhfu6CZhTx5/cOIUkyDw/jGp2LwwkqHg318GfHmiwx4t+NNN/GPm8NGXbQvmzs5cwZTey3ksNy7yGHLGOnFuVj7WcgbVR+NShKKOSYJclTD1XN0dup+BlFe7nrKr/8PPrxkA8Hfds1tdshusWwu1JNi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(6666004)(66476007)(7696005)(83380400001)(52116002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kqm9OYDnGF7yXstLMPUIGupQUNLGsnd2+JqVVm1/m5KhejwwgpBxGIDqkNmb?=
 =?us-ascii?Q?9gAiE8FY8jtr+B8TeZHldklc307rSXS/OepG762ueUONznziUnudq82+erLF?=
 =?us-ascii?Q?vKddqeJZalM7WmXBJ84s3oGQKdnHTq9pgF/ZoPWqV42mFemAvLoukflR1O3a?=
 =?us-ascii?Q?nMV5PT37+nKd/1SpBPCMKw7KPiHzzSMdNl5NL2xq6+9qDKrfnhpILsHGWyiJ?=
 =?us-ascii?Q?9/7R7U/k/xsrG0SQpWrB3kLWzsyrp4KDzq9EBBQjkjhwTaRKUqg3XHu8DRbU?=
 =?us-ascii?Q?HB6h6WAY5MbNuwmFOH0IPNBp6g4Bjy3RhqNcDuxorF/lvxfAwN+jBbwh70Ot?=
 =?us-ascii?Q?sIvrbwPg1RdxVxFRIR4lb+9FwRatKA85MQYU8hHFz8VfWZPK9kngRvVhRhYD?=
 =?us-ascii?Q?upkCNwaFH+sidc4a+/InfUew0bOKtZ7Ak181jMEUwpx74xOj+IOpycGv3rJV?=
 =?us-ascii?Q?zYzo2LhhUMaTpnvZw0LuVNWoRJa6mog9HP2GfeqcpDaFzfmrCb43uFcB2JoD?=
 =?us-ascii?Q?AgY4fgEJc+Fc27TKtLhvuLEzXJQb8IHOns1YZed3PB+ddcbqgOCbYdr8451H?=
 =?us-ascii?Q?SrDYdWgL0DPtDB516yLTgL9+G+b2WfL7iUpZh7v2Ja3GtArROUpdt+xj8V4n?=
 =?us-ascii?Q?FF9T291NeJP0jG7Vjc9w6aIu+JPunJkljRqHpgN/kSI3tYJ0lcrzpVDO5Co4?=
 =?us-ascii?Q?c0ld5ljs8OC9jH0ZV6dJNPiwZ1YL966tqaseQGyjmbvQ/F94PjpQ6G3b7P6Y?=
 =?us-ascii?Q?NfQQYSRVsO6hjwHdqUAlUXO2F9ExTafpaMCjqj7/RvXw4D5ER+p4RxB9RPBT?=
 =?us-ascii?Q?/MW0HXDqrFIcR2PAe1nijAVy39nltevDPt2S6fChTFJtUD+ZSSMrmbptaKLv?=
 =?us-ascii?Q?L/LR/8vM47EEbg63ve+jNc4yE+n4OVUEDEn1mXeYrXCQJVHFcAuTCLCcCH2f?=
 =?us-ascii?Q?qlTTFUL8St3WvdXegzeD1fAhNLsN1017zPyLU0zI2hv1spnFrhfszWWNMLGn?=
 =?us-ascii?Q?sh7RF6/EJmgdi4JWcirp9ZEfB3byt4XwJdAlTjNy3dOeo9OpTJKp1JeHOkVX?=
 =?us-ascii?Q?N5qXYKt6I28HZ0GOvm3QPlgrlT4of+FjFJuw2qFZjiV0vc5+X0eSMOCiPufs?=
 =?us-ascii?Q?8keWHiTSjx20PD7+oL1ehsexHvfm6a3o9/o/YP1eePe0r7cbezd8FQK6fwEa?=
 =?us-ascii?Q?HDnCGsGnLz7UPALroT7A3AlHj4rnRnGvwSjjowSVbjkXxQAvIb/vKNN5kygC?=
 =?us-ascii?Q?6uVmqu6tuWfeyIpPA1CKdpu+cKevEEdkE6OJJbOr4vUJOAmjP2q/0lvB9W1W?=
 =?us-ascii?Q?9U9oUdSPKhr2ntBxgiITMSco?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c05d98-117e-4626-720c-08d8ea0e87f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:05:40.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9IFk8eaonRASVKT1rkyxmzW3t/f3VFWHIaiyu1RMuyOcWiU6yx4JHZan1ZrAWAO8KYrhj7npJZ9uM8Az1p+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
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

These patches can be found in riscv_sbi_hsm_suspend_v3 branch at
https://github.com/avpatel/linux

Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
support in all above projects (RISC-V SBI specification, OpenSBI, and
Linux RISC-V).

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

 .../bindings/{arm => cpu}/idle-states.yaml    | 228 +++++++-
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
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
 drivers/cpuidle/cpuidle-sbi.c                 | 502 ++++++++++++++++++
 ...{cpuidle-psci-domain.c => dt_idle_genpd.c} | 165 ++----
 drivers/cpuidle/dt_idle_genpd.h               |  42 ++
 26 files changed, 1184 insertions(+), 384 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
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

