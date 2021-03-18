Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C0340667
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhCRNGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21437 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhCRNGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072792; x=1647608792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4ds/DRIrv63enKd4gbTtluhlQ9Tr4y2t6F0kVQdmG3A=;
  b=Nyr33ON2TCH2eDvzY6KOxNVLuoKFQm30JX9GycPGR1ijIHdkq1tuQhUg
   /ZgfkCxLzOqsGuMYNiSUThZDt6l6mechSGwBVqNPf3dYsO2lGAaCd2pz0
   9p/Zt1oaDBS+LQgACLmKOiocUbk7CIKN6bjfpQomDMOL0e7Gzh1JwJ5kl
   OwBK9ttG+CVlvpS1Fb12mYQmeXs+46Zdtzr75q/v9eF2Y32seSVR5iq7I
   Siog5oyulBdfp5tYHLw3+a5s+qg/gFjc37ZASA7MX3mkZjmers7bE2syR
   bGkX+n/ZjIiLTwcO/J0l8dlMfjn3MmLGkH+AdHKmxsyYvGNPNgL8Jl3O3
   g==;
IronPort-SDR: 0gDulKH7joBO7DRiYHlS9u2WKkEHl8L0IEoktoKXS5PkzyiTJBterj5JY4rHvplYQdY2aA+pNW
 75nB/3Gb3bfduUFZmPTuYqMbp679xlt15XXVpAje5khlj1ANPW0l3TdDT6Ja3eAnVlenu5mIId
 L65ODjJqasnluhkW8NCCk7j2haqEbgNaV9qV7lP2qnux4nJLQUEU8acpp7svGFl5Ry4gF3LT5W
 PQPItpVd7rDprup3z2FSYrXf5ipFHzEQi1RB8xFazH6ytaP4fH9Mzfj81frRDyQgVr8lue95Kt
 I8M=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="273192181"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:06:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWbtxd8xOYE40rtM8OebqlRz6d2RnXjwYlQArC/WddiKhMzfUGe1h6r1+HcZF5T3zfgP5JZ4AYoLISUbKYS/u/kww8Cfqt3qt0eUnXIDhdXQeqWEDC3hC7KoQwYdI7HcYmSjlYMg/TR6We1eAMHoDCEoZLqibeViKWHL6QtPC6RpJKbWegByYW0R/2xEXhXflLS867m56EQyJcpQzGIDzjJBvH4dvsSz82qEGl9025GPJhf5Ft6VLhiOFP6zT5Q7D2gdQvq0s6n5yjU4VSGBJE8HQ/Q701M0bE3RLNYex6hBXMHeb5u+0oQgfIiAS7IjivNpRu8naS9HkkFvUE6xhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YRKAcytJ/VRtOkvDqrJ5/QVgSgs1BgggwvCEHOH5WQ=;
 b=YIb3BM8Oj3wFDF7nrmE3Tpr5gw6CruzIqYcgeTKo/CAMUAa9jEFLiB5TQtRu16p3V6mX7pnSzFTdDA7Vq5e5uaC0UAFSnkeDqWzRYU+SQ3mzpqKZQZC7228xVNdKf9chc+q93AllVPkPxeZFBKWufHb+2Zz2aovVgNw0R2oG6+D4w0dDCaFAogtRtOg8izP3ECvwN7Gl26tGov1MGKFZ3TlarRQnE0MOu07ciSl8kq+56/Tbr58zXiWQJx6UY5zuYcbvhDad4eaz2Lz5JQtzlUB2SuIjw2oNDSP94fYu3NPCYdRQdRVQqhFeV+Qot4m1a3Hs4E6P2q3bzsUyBZjbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YRKAcytJ/VRtOkvDqrJ5/QVgSgs1BgggwvCEHOH5WQ=;
 b=jKGBqIV3Hww/U7q0s1Z41eCYjcRHQ9NeDkxGtv6Q3cESq98YEPdW/QyOeKSK5QtZvbpdgBhOoPpbos91MQCDeKYtQma6jL4JC8wLq2yHMqcOJsNS1Z7alfb5tkZwVtIwntpTt3RhPII1Bp5opdVCd4c4M6Uqk6t1F771DpYl4mk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:06:29 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:06:29 +0000
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
Subject: [RFC PATCH v3 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Thu, 18 Mar 2021 18:35:12 +0530
Message-Id: <20210318130512.1025416-9-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318130512.1025416-1-anup.patel@wdc.com>
References: <20210318130512.1025416-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.155.94]
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:06:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c519e9d6-c061-457b-d1f9-08d8ea0ea544
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0826D8B49A0DBCBEC24AF39D8D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg2XBt+QiTNqyzxa/riM/jfTPJvlFpcmR7DqVBdgpH9LiL2IzkOYirh/q1VhceXMJxNWugQrnmdKKBkMUysfh2ki4O95KZjEFx+Ut1tQiJUykJQJcNWYnEpnDWSNJLLJJSGULFCUYdIhTKMZuPbl0VvkgdAHyfQyn0b83EWD+ehQ0Uj+2eqzOYHtA4DccExjYWRL0khxEx8YVWqQ/uyi8o3iAHz670+rBLhwAKnppgyZYTPp8YmU1pG3YlBg1wSDV0WVXNGHXfePQov8I0RAftNbZz9JTfpfnJefyPnWoPnJ/CPZHIYlS4eOUpGDx6KVAcuXZ7KLGppTy0OguCxU0R/53k5oI714ss01QW7ft4thLOEyr9N+hDqjg/R3ES2F7Dmm7S6W0L9sHw1QQv1aBMG2yJs6YNyEjuv/+WDE1xqhYsUm9S8WyGvhaFRO4c03bfRPwrhv+DeWXuQajQf6taaTK3+q/G5CoDB/fSz4YkHwHeBmeL46kMly5O7y4iic8V1kFO0DfaRDmIYafMWbfQ5o/74eqetxpYPZkwsYgpehCRUsYfxaicZaBvyqd8BuvHxKlz2LtX+T2m82XudXV0Qvi3M3vobuR9ky2RdS1ZKk45kHV8hhfLYX0QWvmp0d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(6666004)(66476007)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R6RsAhR5LNGueJwe3aJIV0gw5ggbeL1nA1OGpiBNcegBQsiiRmVfWgGVYUtd?=
 =?us-ascii?Q?qzE3ka56umuupHAjBgleVqhE5efnqXvZWNVbrZtcfinZTDiZEqm+7HWCWgnZ?=
 =?us-ascii?Q?XcDv9ZdLD/vzXuWRHpexN4DWdJ8uQpGVgbtIQp7CxWxJ8k9mJxXIMzZdB5DW?=
 =?us-ascii?Q?5+PtCIAjmEPBVpGTiFm9hmSYy4Ox362E85L1v1NEY+U99xVJDriMbwOPvc52?=
 =?us-ascii?Q?apkrwyw1W0WuxUd5DDEl8/aTTLpAkeGhACPc2Rm7iMOcJOzSHunvOuZpQ83k?=
 =?us-ascii?Q?eDRF37ZziQGL049oFLjGbmTVO492Gs4rCjOJdfh4e7PfwsG3N8pwyo86dJjX?=
 =?us-ascii?Q?N9IxG6ZFGQPxnbt2Po2GIJ1Y27EMlvci+8qBUtioM7eGzPqnJJothsLpp/Vr?=
 =?us-ascii?Q?QQf0y0v6lRGZGNRoLv0Me2hf6ZK8EBrDqpFL6GwihJo89mbsaJ9ML2YbpUJp?=
 =?us-ascii?Q?qgTzlIwrsMrY70hSWSoqx/u7whz9J9LZaqORVhhd6P/uoKnyy0LvJU2ACFdy?=
 =?us-ascii?Q?BD3hatQp6OP6i1pbm14xGkf2JaYV187Y9lCg13W9zHu5Sz8IYbW6IJBR3NVT?=
 =?us-ascii?Q?gBqRc2tbntTuOWP8Ni6bauhqE4LknyRrPMtYvrk1bgWxCoDtJ1/r96IgHciH?=
 =?us-ascii?Q?P0JrNw/c3Bsx92F2Xe6UpqrgiTbcolEAbAJu0v9GhNR4kbk1cY6EXjwKluLr?=
 =?us-ascii?Q?UdBO5sQ2WdWXSXOnPCh4zPwAeZX5Uu1eSRCtyijq1Yv/K9tklHrXRaPqE5An?=
 =?us-ascii?Q?K1gSmpGEic1Szz8MlNzilK32rJ4yQwZ2pa00K+pAI4I9R+D7kEtXCnafBypv?=
 =?us-ascii?Q?UTMUZwNU7r4CE9+fG/Ab0O7svwkar3/dfZn0TQ2v2fYgXRgJU39tq5OawnMP?=
 =?us-ascii?Q?0pGCIWoQfWBmgIFW3PzJBk2z+QczcYo2jWZJgT1Gl8sd1N3J5GSOQCN21ngu?=
 =?us-ascii?Q?iridNQz2zPwt4gqckdXPIxd1uVcCWUwxVEvDF5PP2KrBJttsEqjTrQG59hU8?=
 =?us-ascii?Q?85EYBxRNbrC/Dscddft35A2ptm1jBPKM7Slcj6HORdgKphi3TlnOVrciaJ0i?=
 =?us-ascii?Q?LQMr5F3XJKtwdA8eq9kGdTX9zJ/wtjBUqguqEPk02FhkoZKCY4nxBTdlvSkB?=
 =?us-ascii?Q?8XYvwnJKaZjQNwL0egiiJ9k16WiCHL5LbbcOlM9pJG4C98mtfHCvd8ANACiL?=
 =?us-ascii?Q?mtGtPe8O/NUhMgBdwEjJLMfKvbEk91Pxe31HscmOn/CNmpRYM0f8hANvTTpB?=
 =?us-ascii?Q?FB1Z5PtKZhQk/toyM0Sm5xJYSw6/u/H6ZgBQVLfQPDYaEVT5FcFBiE0Jf7lm?=
 =?us-ascii?Q?x5p+yLIg7hTZZbxCj09AsPHx?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c519e9d6-c061-457b-d1f9-08d8ea0ea544
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:06:29.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jVU5bnbWfrZYm8ThksBuPJWNRNYcSw0h43etuAzmtbZqYs1AWinU6OVAE8IzZjwv4WoBkEwkS1yscDEdSy0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We enable RISC-V SBI CPU Idle driver for QEMU virt machine to test
SBI HSM Supend on QEMU.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig.socs           | 3 +++
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 7efcece8896c..efdf6fbe18dd 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -19,6 +19,9 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RISCV_SBI_CPUIDLE if CPU_IDLE
 	help
 	  This enables support for QEMU Virt Machine.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index dc4927c0e44b..aac26c20bbf5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -19,6 +19,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 332e43a4a2c3..2285c95e34b3 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
-- 
2.25.1

