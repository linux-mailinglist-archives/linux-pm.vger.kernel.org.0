Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896123A146F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhFIMa1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:30:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39908 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhFIMaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623241709; x=1654777709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MeKl9jhPLjMFZAjDeIRMh39HlWEM175ktYhp3+Q4Yqc=;
  b=NrXjO5FHgVoare+BvRMBXnVu3rEgo2uEBla7A8ZgenjEhfUTYS+BEq/+
   3jI5HmhUXpeLdfbvSsC4Xk3OX3JpS+9igjBe28w4Ig95vLf23m0mi8i/5
   dqRNPNYDu9+brEOa64eVWTbGSkrUai9LPjlfc0vj1ec2FXdLw7LJnQFjd
   DpjoydZd3xmgnu3V145TQXId0rxgFLnkPsJsiLjdErWDmx6GqWkqMC9yo
   gbDh0aQ55NQZP/Eu9PzPMZKhcSUIIFJT9v/LFJwKrIdb0Y9Wyi58TVF+/
   DUwwsEOOt4/j1GUELYF5PHxg6GIpF2j2lj4h3mX7m3MS9XmsXCR0DtgTp
   g==;
IronPort-SDR: IPu8eI64jEH8ToJlY4syHXO2IdpWUCX38FdnToLuiS8yV2acv0XvXsMN1O3kDrcSiBiMW2VM4/
 5hC+CzUHyRs4ZJdWQLEi6joSFam8zXP4C0NsflwIOX2bPcUn1+WVnEXhszbFH/6/HDU2FuiPIm
 k/FyRrxFIpOe7CC3KfzwAwVFfU0R2ccTPXxCqTLdJ72Vj3TVe4TBgcuac39hvqzeeBjAMK8KXd
 nxTWej+w6xDOk2oEMOL3CDxtkzOSi+m4MpP/Yr4zAkkGqOvbQ1Wg9QdkyZp55hUm7GnrDxvUqU
 gC0=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="170576635"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:28:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjN/PpA1Gg0NYqgDcqtl3ferxkV2gDe734CmH03pwjnhMxBt1ysYIx+vU0tOTT2kt6M0V3G5qGJ+Dsw1Kpch911eu1W0M0p44putoClgV+eWIPy16R7kfIElirUVObr2I8Ik9fq5gIIc3EMzcRxmoagayxgBd2FbKPG7785WJT15YIqsK/ARH1JslerL0WGoOykBcZf8gvrV2WoaTS+oLUTRtjDZznlWNb/uhnKHGyOGMtlN2W0Y+MBs/k2Dkt9ypV+NFI5cFv8iySVYiKRtghBTOGRZr41uavYQD2fPGkfAEK2i4JnGApkZi4POqbS0uIfPLCgE4C50tRXZv2t1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdb7LYKd4zYfz891hXSsl1k21D0B8sMSIEAMlC4gzCs=;
 b=M/0x7ewdEeoO/dYKFneGi3sx8sfGRPBPFGbNzTUSCB6Z1Gtm/E1gZJw/YR89x3qrHHL0cap/y6ttM/1RQLT/K9YS7Cif+Rf7AdxfDUvwhqIgQtTsLHmU6KTTMjpZXXCyWZZjEMUPVixsHqGic1glUL34LiD92oEMiNKBRC5ISKD857xi1x09fIOVz8eU8yLuN4ulThrO2zVMqm4AsQBo8BogLqOcpziWMd5ClqlYE3Ns7Ip4r8AedWo5LEe4HqN3MOgDU72C+qVvtMjiWzplPPj+Civ0FFBmUqQgQzq0cFjId+x3yEyamSU9wj1vRXxtonmp0Afm7m/XlU/XiH0GHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdb7LYKd4zYfz891hXSsl1k21D0B8sMSIEAMlC4gzCs=;
 b=GVXOaz5XQIodTnzbKY3VanZMa1asDbH+nEmkB5lcEO6zL63WuBxLmbQoFESmhnnhAnkN7WqPICAHfR4D1e9ZXfC5jZW64XCe3uTgNPxMLuKx1coE2KBL5Fmi+XM8dCoLXzYKmZGCgtvw7y7806NLKV4MmNb36z1yLO4A33i6goM=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:28:16 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:28:16 +0000
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
        Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Wed,  9 Jun 2021 17:57:14 +0530
Message-Id: <20210609122715.3389-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609122715.3389-1-anup.patel@wdc.com>
References: <20210609122715.3389-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.172.176.125]
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:28:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d9397f-ecdd-461e-168a-08d92b420e64
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78430AC7CA28D4A9481234728D369@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au/MonpQNF3UC5XA5KR6ybSio3+wdQ3569CItKmc3RCtUZHs6wntxeQ2yPAtYsjs9eSNz0SWKSo6g3EOhsxawuBWB2HXC/nU4o8AqC5jnH4KU6+bmwM1IbQc1Bpq8xE+XNVq1q42NCOV4Iglmia7E1AHM/ejyT0N/7jt+uGdhuqAtDNduAud/f0+frIdTOHYE914T1ju9XYY8fOmz7+W/JEVDzh3kROohLTNY5Zfa5DvTUiSSLECr9NaydcPOqD1X2muRXgOZqacQD0X8IC/BN0TSZ/XrDBgAhjhco7Vyw0yiCc1uwnlVW6BA2dte09cAvfIOnOyz3KmDPkZTiFUiRlPbGCQcot5J0D8HmRGGt4/Ewom/EvUHj6c4M/SSa6D6kc5w18yyEdVw358Sb4khiqM9X7sqxzdNHvAZitjQEg0nL4+NnzaXpvCUVdS/IUNUCHmaapnYxAZn3cvDbQFANcnWGG4bB544AK2O9+3/9RjpaKU9XpHluBCQwweq+epUeJOGpDdDuDAT6Dyp7h1zVyvGwl0PXGaa0ZErcm4mYIHbls0hlNAYaPbXySWf2TzERXWluuGEIyV/kOZWAMGJ6YdQInPef/3kjAYLab5ptWTl/hKabQwA5so10OtmCISc/v4C7Loxg+YL5Vo0jvWR/GL2fHAqKDGpMt2pDNIf/maVYUPB0689bxOq8QW72iLmo2x4c2W4QSSIDWNJjclkl3fIGDwNM09LRh4K1rNLxMB2012wBOY8FhzypZC2alleZnn6RI3JUd0rlYIkwoeaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(4326008)(8676002)(8886007)(83380400001)(478600001)(30864003)(110136005)(956004)(316002)(86362001)(966005)(44832011)(2616005)(38350700002)(52116002)(2906002)(55236004)(7696005)(26005)(8936002)(38100700002)(1076003)(55016002)(66476007)(66556008)(66946007)(36756003)(16526019)(186003)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?glO9+8BUU7yBRIUIEQmc2zT31xsZnej2XFLOMUJsuU3Jdd6gEsEIWYnheBi1?=
 =?us-ascii?Q?v9+ljCMOLqRVGHB4gNV715udkUItl3/Jf+nb78CV7yMtwnAa0rypzsODFbQd?=
 =?us-ascii?Q?OtsziRpohocLGmmEU3b3+/0o1VjZNWqt8RdVewPw03Brqnngbz1FsCFNfxx7?=
 =?us-ascii?Q?+Vez8rGzRkHlrwo9xY2AGR86tSWfnwtFGbAx0gssl2o5RxPF273uSvTPO6aF?=
 =?us-ascii?Q?EhHpetMcpEaBvWN3myo31wGcJS2yaFyQlQG4jKUmE2H3G4H6I2V4CL4PVxvZ?=
 =?us-ascii?Q?h7++avY7BVcOGr7TpoFcDRRVBcaggtPMsYHx0GJm61wsbhjc33RSmjcl2+1k?=
 =?us-ascii?Q?YTcgMUU2nawm4vA0swyfgvS8hbkr3BiPPH+OXetvpWZJEMyX6K5uF0tukiFz?=
 =?us-ascii?Q?PfNE22ZPbDYMfIzViflxGy2lOkejbTkJj/rtsb39er+vEkiNQzuG4g56Rlcj?=
 =?us-ascii?Q?TL35nRLU7vv3+TGAckbUwOfSTiM/H5g2sYggLofYHu1HLOtwyLjZQ7tSB99E?=
 =?us-ascii?Q?76FC0HQjTraqpAARlTZ+N+jOfvwVuJLmD+ecOPfSI2l9JaJF50uk1F9Doug5?=
 =?us-ascii?Q?rdxxBLXThVRrMf1feTFk4HG8cOLXWMUeeqEagO1TMZT5Ig4uG3vmveGwGgf5?=
 =?us-ascii?Q?dyHR65JDW620KaLY+7h2jcE9V6Lk2yjxZdOXJy+vtmBGmeU8fmEJCLD6+ZuT?=
 =?us-ascii?Q?whVH9/Wdpb3ChpPAMBRLyMC+cqW/tszFpZJoLt/8uQWMKN/92fc/iVTE+RmA?=
 =?us-ascii?Q?l1WA2ablTGFsm68RTjkORGSeAhtrFJ3nzDffjQk5NcO+6IeiSU4jU12RgE89?=
 =?us-ascii?Q?r5XbhhR9+tLLHCeTkstQWjnqdeE1A2If+9hQ/JipMk8o7XjHyNM6VsahsRU2?=
 =?us-ascii?Q?zdnmQzuvt1HKDmDSJUFd1YjHrFvNOVa+LTXd5OuVMu123d6RnZCdFr7grDsx?=
 =?us-ascii?Q?HQ1sa+Cv1M4KesP+nA6tq4xd389Qcc8N7MJmmD3CkfDmS4OaP4AR7dCKu0lx?=
 =?us-ascii?Q?dkeu2PnhYN72R8+8YjuW2E9ZA53HNbAeHQBFDyPvp3ivKMllYHBU8f/t5lR2?=
 =?us-ascii?Q?24sRtq9hI2qLSNWjlUK45pLzoOeBL/BPDKIF4WT0FBKVJno1Rx8AI7gUB/Mj?=
 =?us-ascii?Q?zsM8hUeshTFdsokM+2nRFaSrI9KfREuxVg8MdjY16+lH/BwZrsTW4uPXvtWP?=
 =?us-ascii?Q?6UbqRUglgKB/TPjTcVJYNDxwOqyvtnfzABvmbEXhsW5szz7YBTFwwNEheSei?=
 =?us-ascii?Q?cvMo9l55tdCDMDfzB//rCA0D8dkJUw3loQW4n5z31IQ27pS37CE5R9hhF0DF?=
 =?us-ascii?Q?nuBlrCdOBJe7J10lHrQnnA6Y?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d9397f-ecdd-461e-168a-08d92b420e64
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:28:16.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTdo3GN30JMRplDZhIIiF3tK6Zu9qrofDxFHVjvc7AopgNF+IJCISKZ1WV3sy2Rz3kTa3VVVIbO2aFfKpmirXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RISC-V CPU idle states will be described in under the
/cpus/idle-states DT node in the same way as ARM CPU idle
states.

This patch adds common bindings documentation for both ARM
and RISC-V idle states.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++++++++++++--
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 2 files changed, 217 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
similarity index 74%
rename from Documentation/devicetree/bindings/arm/idle-states.yaml
rename to Documentation/devicetree/bindings/cpu/idle-states.yaml
index 52bce5dbb11f..74466f160cb2 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
@@ -1,25 +1,30 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/idle-states.yaml#
+$id: http://devicetree.org/schemas/cpu/idle-states.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ARM idle states binding description
+title: Idle states binding description
 
 maintainers:
   - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+  - Anup Patel <anup.patel@wdc.com>
 
 description: |+
   ==========================================
   1 - Introduction
   ==========================================
 
-  ARM systems contain HW capable of managing power consumption dynamically,
-  where cores can be put in different low-power states (ranging from simple wfi
-  to power gating) according to OS PM policies. The CPU states representing the
-  range of dynamic idle states that a processor can enter at run-time, can be
-  specified through device tree bindings representing the parameters required to
-  enter/exit specific idle states on a given processor.
+  ARM and RISC-V systems contain HW capable of managing power consumption
+  dynamically, where cores can be put in different low-power states (ranging
+  from simple wfi to power gating) according to OS PM policies. The CPU states
+  representing the range of dynamic idle states that a processor can enter at
+  run-time, can be specified through device tree bindings representing the
+  parameters required to enter/exit specific idle states on a given processor.
+
+  ==========================================
+  2 - ARM idle states
+  ==========================================
 
   According to the Server Base System Architecture document (SBSA, [3]), the
   power states an ARM CPU can be put into are identified by the following list:
@@ -43,8 +48,23 @@ description: |+
   The device tree binding definition for ARM idle states is the subject of this
   document.
 
+  ==========================================
+  3 - RISC-V idle states
+  ==========================================
+
+  On RISC-V systems, the HARTs (or CPUs) [6] can be put in platform specific
+  suspend (or idle) states (ranging from simple WFI, power gating, etc). The
+  RISC-V SBI v0.3 (or higher) [7] hart state management extension provides a
+  standard mechanism for OS to request HART state transitions.
+
+  The platform specific suspend (or idle) states of a hart can be either
+  retentive or non-rententive in nature. A retentive suspend state will
+  preserve HART registers and CSR values for all privilege modes whereas
+  a non-retentive suspend state will not preserve HART registers and CSR
+  values.
+
   ===========================================
-  2 - idle-states definitions
+  4 - idle-states definitions
   ===========================================
 
   Idle states are characterized for a specific system through a set of
@@ -211,10 +231,10 @@ description: |+
   properties specification that is the subject of the following sections.
 
   ===========================================
-  3 - idle-states node
+  5 - idle-states node
   ===========================================
 
-  ARM processor idle states are defined within the idle-states node, which is
+  The processor idle states are defined within the idle-states node, which is
   a direct child of the cpus node [1] and provides a container where the
   processor idle states, defined as device tree nodes, are listed.
 
@@ -223,7 +243,7 @@ description: |+
   just supports idle_standby, an idle-states node is not required.
 
   ===========================================
-  4 - References
+  6 - References
   ===========================================
 
   [1] ARM Linux Kernel documentation - CPUs bindings
@@ -238,9 +258,15 @@ description: |+
   [4] ARM Architecture Reference Manuals
       http://infocenter.arm.com/help/index.jsp
 
-  [6] ARM Linux Kernel documentation - Booting AArch64 Linux
+  [5] ARM Linux Kernel documentation - Booting AArch64 Linux
       Documentation/arm64/booting.rst
 
+  [6] RISC-V Linux Kernel documentation - CPUs bindings
+      Documentation/devicetree/bindings/riscv/cpus.yaml
+
+  [7] RISC-V Supervisor Binary Interface (SBI)
+      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
+
 properties:
   $nodename:
     const: idle-states
@@ -253,7 +279,7 @@ properties:
       On ARM 32-bit systems this property is optional
 
       This assumes that the "enable-method" property is set to "psci" in the cpu
-      node[6] that is responsible for setting up CPU idle management in the OS
+      node[5] that is responsible for setting up CPU idle management in the OS
       implementation.
     const: psci
 
@@ -265,8 +291,8 @@ patternProperties:
       as follows.
 
       The idle state entered by executing the wfi instruction (idle_standby
-      SBSA,[3][4]) is considered standard on all ARM platforms and therefore
-      must not be listed.
+      SBSA,[3][4]) is considered standard on all ARM and RISC-V platforms and
+      therefore must not be listed.
 
       In addition to the properties listed above, a state node may require
       additional properties specific to the entry-method defined in the
@@ -275,7 +301,27 @@ patternProperties:
 
     properties:
       compatible:
-        const: arm,idle-state
+        oneOf:
+          - const: arm,idle-state
+          - const: riscv,idle-state
+
+      arm,psci-suspend-param:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          power_state parameter to pass to the ARM PSCI suspend call.
+
+          Device tree nodes that require usage of PSCI CPU_SUSPEND function
+          (i.e. idle states node with entry-method property is set to "psci")
+          must specify this property.
+
+      riscv,sbi-suspend-param:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          suspend_type parameter to pass to the RISC-V SBI HSM suspend call.
+
+          This property is required in idle state nodes of device tree meant
+          for RISC-V systems. For more details on the suspend_type parameter
+          refer the SBI specifiation v0.3 (or higher) [7].
 
       local-timer-stop:
         description:
@@ -317,6 +363,8 @@ patternProperties:
         description:
           A string used as a descriptive name for the idle state.
 
+    additionalProperties: false
+
     required:
       - compatible
       - entry-latency-us
@@ -658,4 +706,150 @@ examples:
         };
     };
 
+  - |
+    // Example 3 (RISC-V 64-bit, 4-cpu systems, two clusters):
+
+    cpus {
+        #size-cells = <0>;
+        #address-cells = <1>;
+
+        cpu@0 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x0>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
+                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
+
+            cpu_intc0: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        cpu@1 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x1>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
+                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
+
+            cpu_intc1: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        cpu@10 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x10>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
+                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
+
+            cpu_intc10: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        cpu@11 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x11>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
+                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
+
+            cpu_intc11: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        idle-states {
+            CPU_RET_0_0: cpu-retentive-0-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x10000000>;
+                entry-latency-us = <20>;
+                exit-latency-us = <40>;
+                min-residency-us = <80>;
+            };
+
+            CPU_NONRET_0_0: cpu-nonretentive-0-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x90000000>;
+                entry-latency-us = <250>;
+                exit-latency-us = <500>;
+                min-residency-us = <950>;
+            };
+
+            CLUSTER_RET_0: cluster-retentive-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x11000000>;
+                local-timer-stop;
+                entry-latency-us = <50>;
+                exit-latency-us = <100>;
+                min-residency-us = <250>;
+                wakeup-latency-us = <130>;
+            };
+
+            CLUSTER_NONRET_0: cluster-nonretentive-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x91000000>;
+                local-timer-stop;
+                entry-latency-us = <600>;
+                exit-latency-us = <1100>;
+                min-residency-us = <2700>;
+                wakeup-latency-us = <1500>;
+            };
+
+            CPU_RET_1_0: cpu-retentive-1-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x10000010>;
+                entry-latency-us = <20>;
+                exit-latency-us = <40>;
+                min-residency-us = <80>;
+            };
+
+            CPU_NONRET_1_0: cpu-nonretentive-1-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x90000010>;
+                entry-latency-us = <250>;
+                exit-latency-us = <500>;
+                min-residency-us = <950>;
+            };
+
+            CLUSTER_RET_1: cluster-retentive-1 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x11000010>;
+                local-timer-stop;
+                entry-latency-us = <50>;
+                exit-latency-us = <100>;
+                min-residency-us = <250>;
+                wakeup-latency-us = <130>;
+            };
+
+            CLUSTER_NONRET_1: cluster-nonretentive-1 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x91000010>;
+                local-timer-stop;
+                entry-latency-us = <600>;
+                exit-latency-us = <1100>;
+                min-residency-us = <2700>;
+                wakeup-latency-us = <1500>;
+            };
+        };
+    };
+
 ...
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e534f6a7cfa1..482936630525 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -95,6 +95,12 @@ properties:
       - compatible
       - interrupt-controller
 
+  cpu-idle-states:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: |
+      List of phandles to idle state nodes supported
+      by this hart (see ./idle-states.yaml).
+
 required:
   - riscv,isa
   - interrupt-controller
-- 
2.25.1

