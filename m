Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A282D42A18F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhJLKCS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 06:02:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42274 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhJLKCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 06:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634032805; x=1665568805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dfUTtGja3BYY9Z7jIhwOnaT5xqXTYX1QiwVLp8l2kyI=;
  b=guQmgQuHTsc+L/Ck6Q3MpV0ljjeiBKvwMi/THo6OhEW1sa02DcowNEry
   eTY2hXEL68um/GbIrjR1N9ao/F2td9sJz+95pAEGdQXLK2QD4jXXGJ+cy
   1zndzWkBjbz/cPK7KUGRi8UfbPMQmhaIu9IhBf70xUBzGwCbZt/5JAoms
   nOsYyLHv9K5+0ESHtpZziYZI4ab3fq/gLrpYIgJd5TNNHaEu5ItFLEA24
   L71iGcGYwbXXDIDF/019QOvoJO9z5NpOlH54fDCdu0yGJUOvaZwEMkQ+s
   Vj7nVSR/IbbE/Bf3QUCFgJbyAnDquJTEjwy8R78H1NF17jKDmSvJ7Xmjd
   g==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624291200"; 
   d="scan'208";a="294312946"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 18:00:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeHlV3JJJSRs6PLB4qR2Cza3slb43+hAyXl47o9H2FHYfZATjnhm56du906/89wHhp0oxG6HXXLjfhGjmGJaOigrFHiQAv+lSrrY6C9oS4CGBOoCquW+gxzekL60yHgshVM18aWeLCR+e57VFdzsgJHUUGRKuOaXZC9b3fyMkUrM8LDM01cBOeyGocf2fqsl/tPPd4S7NHwRcbPbBkbn+3V7q4B6rBEMrThyjTq0zThj2KFO3oTv4pLHJm1Xy+luGThuhcUn0XruBd2K82+BCrswbeO0BMc8Sw9NnFjM46yuICo0cf4uzWwKwQwD3Ti21eAl16iJePIVKT/lqhbrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPOK5HQbmkNWnvuotzfGuheTkjJSm/OQ2+vy3daIVHk=;
 b=OUqpRTVv72OaTCDyv0e574I1oB282p0h6fcSGu2kB9c6mUvH41Jr22WQT0t02lpG2xWkXhUvkZnLerI8ejVKTw4Wxy14zURICJ4u7c4kDvBe1KztY9QIJ2Bel47IezGWlSlQjMmQh8sih+014JiS3fO8Hp3utB/psHY3OuLUKOr+6gtrHocQ5DTWdZXHsGMr3xoBSsRFavTaIunhmfIPTyPVc4zLHkzaC/90StQlVNQwG8xCsnGyXKFc6Ype2JiaHY4tDFKxHMskmpvPuICJqcgDdC/AK2BmEHhBKxbkQGkO5Cq9/E3XLuTfVp7cJ73UAW+vC8TeilpxEdewYxXxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPOK5HQbmkNWnvuotzfGuheTkjJSm/OQ2+vy3daIVHk=;
 b=LzxCwnJz2JDuR/RJT+4uWWoDjg+CnZUzWbsE/jcg40Hng6NOT41bLseVt1jXZGNHT7vhMnAUocPfFGo2PLZ4fBFta2JQsDuA46oLeGdvJyUf/GSOLupHF7cuoBdePkD4GfXPXH2v0Eht/Yd3u0T/2XnDPgoIFdETuqzRVV++YWA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8347.namprd04.prod.outlook.com (2603:10b6:303:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 10:00:02 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 10:00:02 +0000
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
Subject: [PATCH v9 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Tue, 12 Oct 2021 15:28:56 +0530
Message-Id: <20211012095857.1314214-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012095857.1314214-1-anup.patel@wdc.com>
References: <20211012095857.1314214-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.114.63) by MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Tue, 12 Oct 2021 09:59:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 774b6d27-fbe1-4041-4ca4-08d98d670f29
X-MS-TrafficTypeDiagnostic: CO6PR04MB8347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB834709AC1B5A69609ABEB24B8DB69@CO6PR04MB8347.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpDvSJQDvjz3cbiX9iCmNk16Sp5uHaB3N8HTRxXoDvIGUmrTLfzH6mPwbvfjqbr5FRQvcJvRDRA4rKnnjLAc1XKthGbB6ZwJDyYp+gS1HjxsXVouyc9KEJALOCfx+cobUIeUuZbZxmMR1Vek4HeMJg1HIKqcP6u21z3vIVUMY3neNhxRILXYslxUE47jAoPHA/Zj5PsuniON7Fud4h/ZVP8hr6dpspvbdsTMoiOs6mwJuXHFIzLKHjklIFCdndfZfd2Jg1a/nJsTg1vlyDyY3XxSclWoV9iqfeGn63HGl8Fu4Hc9ilGEStJpFnO52ihCvEsA/N8RatXUnZJLROUL8vJ3t2S3BInWus/qJZXOiDd3KMfOwEJt5YWE+nGTTI3xQ41yJ1mFP9sdRtPh/ek+uramPshI74utlgukwE+s1Ez096J8AF174fO3pyKF4xhqhDLby/mHa+GIC7XJHMjhBx3lDBEKMcpI5KjxHQROPRDKVziflW8o/kYImxj8sfIdsDZYR1CKyqrVmpOaH0/6/rA4Dg1HJSM6XcghtNT7dlKBX89UariZEvoNR13Z+B3UiDp0QJxKwgu1RkMw9QoWqIaCMXjBlrLdKOhJDAM4Q5m434764+nVxcgl+enVV97VI+yQ+Cqw5r4HZAZhPfoc+FFdItDZ1agGSIjrRWf9FaFGzsN8PCrVBUSCvkRDDpw/h7CD76OeiNzBRUit7LrHZ7eaW88Qi8Oh1z1iur/5ACt88upqiayo4yxlef3Ari1HAEttwGp2ZFvS80PQxBrXHpwkJZqLS2pYHiTx0wbdwcw/O/qfzQ5Mvcv+v2Do9BOy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(52116002)(1076003)(44832011)(2906002)(7696005)(86362001)(8936002)(5660300002)(7416002)(4326008)(66556008)(38350700002)(966005)(8676002)(36756003)(30864003)(66946007)(38100700002)(54906003)(55016002)(66476007)(83380400001)(110136005)(8886007)(508600001)(316002)(2616005)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0i5VhjlcE3h3vsGqCbT6OH0JBKcvYQZrIqzRfkmcuZ7wvHSaD9eraOh6EvVL?=
 =?us-ascii?Q?Ike51JAS81IW04Ix/BBd3CwwOco7+g/RBSnjDO37MeacnKeFh4aS5CxiTUXi?=
 =?us-ascii?Q?Em0yGo1Pdl96gfd9PQTfkYtaz9Hdk34unaaAEJmDrbEaY4B29GlUc2isza6y?=
 =?us-ascii?Q?DOJch/FzHLrdrzSvf0TD4ljYjDk0YUe9NVG88ZSW4xUkJ/oa/hf1QmtZaKsg?=
 =?us-ascii?Q?FoT7H7AnbVdDldynkiAnxA7RGxO0zXGSF//TKf8DJEvgWaRdcYG2GcDw1m7+?=
 =?us-ascii?Q?4xTfd7lmU0EoEUBX8O+EUC70eDHrtUVRt8YcsuW1X30qe/FdoBM0slUBT0DR?=
 =?us-ascii?Q?2gVVyM8Jonl6IF0P+/WPAwecCjhJCFOxhJap37gPEXrul5nndWPr9jZQioV/?=
 =?us-ascii?Q?JWE9gkkbGu5LuBNzHF5iX2cMd89DLmBh4NtAqJyfYyjjXoFH59GGtzIqzzdu?=
 =?us-ascii?Q?eVkVJhOsFVD4nyGd99BAy4Sb/cWT3aOn6BhqrelY9yzUGmuWNRfkSysYbkBf?=
 =?us-ascii?Q?Vd6XYE9O4W3IwhPX1P2ctcfsbG5E3hBzPWtqonwMPb4p2E5pvOTxcCVbF3fQ?=
 =?us-ascii?Q?GwcWJM93N3AjQrq77dVQXv+QCgOcYPDRpC1CGNUADP86CPrV1uDzjb97g3bz?=
 =?us-ascii?Q?C2PYKodruknJ9hnZ4VZTyEoesIcKYuUyRZ9CQVXhOr54l0NFnlhI1RDvoPlb?=
 =?us-ascii?Q?FdJBAgrLYUNpPJbJX+/1B0qSPVIoEFbkWfcpS4ZOhaOVWF751P+BWD6ENcoX?=
 =?us-ascii?Q?tDLxPiRpDol/TXPf5QZ30UQm/fgOIlfdP5EiLpealvWbfSMQGnKQXLSewIaz?=
 =?us-ascii?Q?FVdTKJneSXicCUdijX5kARCdgm19J55iQ/pm1xwz9JhCpedDcx++35O+/yBO?=
 =?us-ascii?Q?Sk1/vIO10MDTKtVuLN+DjRnX67asoMp2f6DTG0nx1VZGBM8u1gL1BG6YpsGf?=
 =?us-ascii?Q?wNso5mNTy5R2Y6HuIgYKyyEEZxE5kS8T++Lj5ajnpuU7neG5poU6PA/QqnCJ?=
 =?us-ascii?Q?DfnvRf9jvU0SlKDJLun7zsE1dyxlYPsltCQZWw9ruF0JUdX7yxyzF/wFoE94?=
 =?us-ascii?Q?ImUAPb23Iq7ks6QP6DP4HAJlr1R9xaID5kJYZDhKfAJvnVs473due/LewOfo?=
 =?us-ascii?Q?KQZCwRH49FwGVekjxY2M1AQbBTOop2G+skTXDYPLvV6L0dJVT/0jKPWZg5KL?=
 =?us-ascii?Q?4+hvoo33sXGJOGdjfmbXOQ1c8noZh//e3v/q3FdFBJzF48MeKzUCAIh9wwnK?=
 =?us-ascii?Q?4bplHAGEdZ0IiRUAV78mrJsPRtjsEb/gMiUuMzskr98TXkPGihUw5dGHGbOn?=
 =?us-ascii?Q?vpYgaByck20xen4czhm5WNcV?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774b6d27-fbe1-4041-4ca4-08d98d670f29
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:00:02.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51tmywv7n2mQYXI9XMPM+MBGlPt+GDRv0vT7LqgxmB1YQotcGfOisOm9a/xRIwJKYk+Ebpz/oAL66S51Gl2uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8347
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
 .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
 .../devicetree/bindings/arm/psci.yaml         |   2 +-
 .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++++++++++++--
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 4 files changed, 219 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
index 6ce0b212ec6d..606b4b1b709d 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
@@ -81,4 +81,4 @@ Example:
 		};
 	};
 
-[1]. Documentation/devicetree/bindings/arm/idle-states.yaml
+[1]. Documentation/devicetree/bindings/cpu/idle-states.yaml
diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 8b77cf83a095..dd83ef278af0 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -101,7 +101,7 @@ properties:
       bindings in [1]) must specify this property.
 
       [1] Kernel documentation - ARM idle states bindings
-        Documentation/devicetree/bindings/arm/idle-states.yaml
+        Documentation/devicetree/bindings/cpu/idle-states.yaml
 
 patternProperties:
   "^power-domain-":
diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
similarity index 74%
rename from Documentation/devicetree/bindings/arm/idle-states.yaml
rename to Documentation/devicetree/bindings/cpu/idle-states.yaml
index 52bce5dbb11f..f2969d4468b4 100644
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
+        enum:
+          - arm,idle-state
+          - riscv,idle-state
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

