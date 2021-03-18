Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76463340660
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhCRNGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64258 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhCRNG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072788; x=1647608788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pR2wxBY+iMhZsJPkv7P7bYvnirPMPbSXsPYMbbe2YNg=;
  b=aZfWTuo+gLAfTQCUM7JimxbBWSdRskS4bwUzzKJB0SRHh6DV6bQoC9gN
   x/rb1mnvBsz9AIFl1WsLb4D761351h7I9zh2KhTSS1Eo7rThsfem0jErq
   RrwAzTvdcUDyyEJpg6JUDM08GTJ1rK/IfKVflKuE2DfjZNMHAFNfP9K7H
   nk9HdPR5Su4cqUW5ipfoVzYLgGWf7r8yHbaSp5K9wqfR0v0IxjoHiLns+
   cKwRykzhZ7VBJWyzNBsWYxh0f5esPtTgplX230td6NnBH6DPRJY4mABnG
   sLcuJNh7JRxhlWZLmgE5OUqkp1rASZlKXOsWTnAJsBIWORXxL+9pBB5qX
   w==;
IronPort-SDR: 7SXFQ5lJIpmVThZYCIiXMlCxwGB9sYakTYPbUSYGS+55vEkeH2JJQr6bkaMC3nLYsVx/p6LlfX
 4kC7b7wV3Cbrlug2mwWMWfNALA3wlkcC89MsfdIBOj7ojMgN2rr8FF0hYu814icbDOtkG7eRjy
 PFmyW7UM15PjFuz4N+SzNA4/4sobu7AeV96KQxTKeBViSyjyPZvlGmRpznPPaomH7mPC6sBRQr
 gJWA/HHM4B9mU8fDgHFO3FGHGC+2gsVOFz0QxsGX8YYNWVmkBGtwEurqoJV67+W9sjq1AAWNau
 Ofw=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="162461312"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:06:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJe3Y9rwhdBMNnTLbAf3+5lCIn6FvueYi+cx7M99iLvWC2ZzXAcYOgTMmXauWK7dSCh8Las7ZFrIep0yjTDHqPxtr5qhtdHH6KH7/7ZGPNIfD1+cRaUBjnlfca22cegJZwVSa1rtpndWQNKWfPrvvg3IUI8il5RjXdLwXfVxN1mdW6W6G7C1/EI+k2Tk0/QQSfbYsPT4ysZjrqFCmq81hTsVmNaWwDF73dYymJL7HzQIr2TXWKV5ucGVxlj1EOM5ACCNT+T1tMNEjYCXLaHPTWcrtdDeBKjl+6dhltxgQ3ffrKSB3iz6Z8jwj1AF9NtI8lEvhz3fnBVUGARKng6dtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3tQsb5V1u/7UhsC0q5xAr4kp47ttW4XxfsQ94h6ILU=;
 b=gwj9lQfCigrV2+YPxsE9At12E/GvCf3OkLpWO+pKIxzDguY/owjzuBnqu6SXEj0VVAqFgmswLpR2PpNkYYx53S8TWvE0i8wZCmE2ow2u1cFrk/FxcmRb/izd5LK8J24VUbpXIyEYcOVar8Puf3mHjjUfl8HUYfzUvYmWWDqWoT3DFo3iIkmvoReHBgPwlhGTDwmQnudAOSND7qX29JYeXwd+aSwdsgzg78yKdlXjCJMxIBJRJ0M6U38qZrmm3k4RJLXVwvRdm2YukopJ71idMb2No+ZF9n8HyRqztHAM3WAo08KAEIXcX3eZKlaFu+qPMMBWy+Cj2m+B0Kzr2RfujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3tQsb5V1u/7UhsC0q5xAr4kp47ttW4XxfsQ94h6ILU=;
 b=cwe535t5o6yijsLOVxUb67SHuLal5rsgTbQLh6F6vnBy2KvL/96s4yRHnMcx3NEVREkMgfA5X2ep/eQ8mghRBOvT10kd2aM2mrdLsov1vpsZvrt3Ugu3OqGEDsp2q49LXcbbxAircFr1zirD2ZnynMl1VzK9wSeZruvCQ5BsF2A=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:06:23 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:06:24 +0000
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
Subject: [RFC PATCH v3 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Thu, 18 Mar 2021 18:35:11 +0530
Message-Id: <20210318130512.1025416-8-anup.patel@wdc.com>
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
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:06:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42bffb8a-2254-4095-2c4e-08d8ea0ea1c4
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0826CFC579F6E109FC2295CF8D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXuvKmpyWSVTLmuF+5ZW6IreF7lYTSHSUuacp1kVtXyEjyNAfOSNaG+yJFKOvhSbEqpSst0Aoqzna6+XDSOm27zk25ePdhhln6CEj83HpPA5rPuy1dT4LdqIbAb7KLcCydyLhyd6AEyOuSPRom9OmMvBkw8iXY1oWKkJBouEk0T9RCNvotXwHtHqlTXEIbCeAKIWB4xrgWnAF0kwYbamsOs/omfGgShOz+GzUfmRQLRzdT29FPm/xHxbPjJRI522clZ2XPaYXX3EmaYQZePPcoJZyqqo/zKRIfuC/vNMj7JmjEGM7u+dAhjG8iGH3f6Mi+CWNE4F+foqqBf4Vd3n8X+WOpZGzfXtfrkdF8hu8hLrBPFitbR4X08/csZKC/y9TH2/pmUdcEQ/OKOSSQ3E+cv7DZxUJCWp0DtP4JjKHlpRaLr3d0n2vRvaUlHlHrE5oRpdCJ7Drlxmp4pb+dtbmIHDrnw7+Qrd395hNrlZsIWeIvSkdMeStqNTui18WBw7QUiCMhFRyqbgWQLvRh28fqGngHofowsJlPCY6ZURrsXQxkiGMk7DgNuga4+NrGXUjOQOlahpYI/bLIrd3cbXbNG/1QYAEFT3q0SRbfejd5j/QZs0ZAeQueBSfuMNQKz9STZhUsJVWxQscGi4/dweIc6v/8UMjGdlkIvSPtHqKDOZCpwwAc7Lx59oBfp6QmD3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(30864003)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(6666004)(66476007)(7696005)(83380400001)(52116002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j1keNqwR5nmJSDs+/uW+NO91pkBjyN1gUlLHCbFRGXrCtC8erh355P4EaQdh?=
 =?us-ascii?Q?z7Gjo5nXD7FQpU7t/e6ukwHYvb7jbm6eElmQYyp7pupp8agZSWVkWF9Yf09z?=
 =?us-ascii?Q?BxgteA0qSgnqJLi7oFutPKWNjHBgIuNrCntv4lI0kKeekt2O4nQvSBGH3fTO?=
 =?us-ascii?Q?+K9qlABedVoyyh7W4TXq2hhJzeOq8idHgKmNI1omNtNYcc2nndp4sBb54+VF?=
 =?us-ascii?Q?T4HkyP+82akUJ/YcibwOn2DM+ge11jg31x/49tdLIrEKQ7EkH2cZmwxR7103?=
 =?us-ascii?Q?h5n1H57w4oHX/8WbPvdt2oxHvag0mftuJ/R60jTcMrUzVHtysHbcPUDGfKbi?=
 =?us-ascii?Q?DrcBAvf4gN5KSabD27sgWp8KvzM/0d0r9/a7g+f0+id4fHJRvATWtXvHq/jz?=
 =?us-ascii?Q?pQJXLBW0y2B8Xj/PgAW5ownvlhyFTr3GnY01PbOXTRIVr5FkKNh95ohQmUbJ?=
 =?us-ascii?Q?KzhGNgTNjctnBU1mub/8waxApxx9B/CxQGS0hnvzTGNSBHXF6AbMCLxTRpD9?=
 =?us-ascii?Q?tTWxy7c2JA40p32CGaEL0+GgsvfBQoM2xBSOv3QFS611Wgz49N62Z+J/C45m?=
 =?us-ascii?Q?/2LbXjWjjoovAMawU//MABNDbMMsp/BeYsd/NvTq+ZgauKUxRxLEPMxWYMN3?=
 =?us-ascii?Q?IAHcTljM1Gz7M+fMwTAOtzYm0+9uoyge26xYH/iFgCqXwMkzUDydECLpRLDJ?=
 =?us-ascii?Q?C+tT0dC009TYG2CbI2ud7GThCO+J/7nOTDg38zyZyJx1sh/xKHswUVcYg+fX?=
 =?us-ascii?Q?3Fug5ohbwjIYDkuMQa9ox3Hszj6i5lGhNaWEb3nk3XjNpERy9fCQFz0r+Qla?=
 =?us-ascii?Q?yOKUQ+9YfH7cPGIrTjyy8SX2lckaUQCT8Vxe8ufxpVLZjfkFW659K4908miR?=
 =?us-ascii?Q?1+JfiXhxzT5o4r1z+KG8D9SZARPpdpEq2mWqDaRBUIMaiJIj2+I+WSjhwRRh?=
 =?us-ascii?Q?l0tfBObd/pv+3+/B7N21PHfI3jJWRkd7u4PVOSRTvc9ZtM2LhJ0gilF4PXfx?=
 =?us-ascii?Q?/Mvferxnnt0Mg0oyds3Me8bYD48Iq5w78pTJL103uf8sfBvwxu1qdM5PEYCs?=
 =?us-ascii?Q?lW1D2TS7JwCexwx6A8Ox+Umc5nTIKyqkZlvhmYKSElf12ItE5skCxNqTIBh8?=
 =?us-ascii?Q?grcEC8iCarQ14trMT2OQjoSSwg/Ragk7nE8tp32SALOsIcbtp0Hi+6HNfbS8?=
 =?us-ascii?Q?+A5Ze674Ky8z0uvjMIqxtCe+ltaU9vBsN3gdf8/uqsA4wKUB7FahYkqYy3J+?=
 =?us-ascii?Q?iWTgATygdGCOTM8TV0m/HZRspuzzgYp47ZQXA//tl9Bb6ZIgtjZQCle2uixI?=
 =?us-ascii?Q?tTIyiaykqX2HGBN+Z+wZIcAG?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bffb8a-2254-4095-2c4e-08d8ea0ea1c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:06:23.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUSIlZNeE1S/Ih0dXs9o7nkn6s3d44oTB0MmwVdbDHKf7ScnbJBHibGGOibGOYo7wtqHf2r5w7imHQdceLrzWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RISC-V CPU idle states will be described in under the
/cpus/idle-states DT node in the same way as ARM CPU idle
states.

This patch adds common bindings documentation for both ARM
and RISC-V idle states.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
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

