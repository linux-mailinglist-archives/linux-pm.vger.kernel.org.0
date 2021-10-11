Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D758242889C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhJKIXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:23:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7090 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhJKIV1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940367; x=1665476367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Siicc7XFOS1KX69fJqIb8VDbnwqgai2SMf1SZ8neito=;
  b=AV8kQDJcibczpXfyBl5jF6goHxGmatJ+ZLa5cQP6cD6K8IyUWQMuRCAE
   sWTPArGzp0jGnt7cwRXiReIaTOgjuJ04V5x5/gD3EbgY6pKJIlSa0R8N7
   nTzw8tWX3ttXKrFF9p/TbcMHdWPZZSoS6mYPWpkK5opKH4PTeHAGqJI2u
   KnPBcxktGhcHdOlBOS2/6I5L3PGHkYJR5m2Z3b3WUu/Ab60Udw+4F8EHj
   XDJ0DbimG3t3b0AOt9+NZDfcNOSPYGMW1WjxlPiHbp3z9JQ3SpnqdnEFD
   EripJPIl8x1HxMOi97C02RDo8QMqDFcLGbmJ0P3U9UHMGHL6A37iwpLsi
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286313164"
Received: from mail-mw2nam08lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK4y5sROxZe3AHH0ucn7+FDrd0Lo3mmfqb6ohh012QOWsTbZq2ayUJTMwEsXR08Z0ViiJJK3/k5kST53K5smtbNP0Pj/LS/7U5tyX4oT7lUsR//uI70So5fiVGWvOdW2O+JRl9EKAGMlCPxGy7yjIVmX7LTb9eqFG5L25yMC2e8LmYk+2xD+pRigaHd7t0SU+Kv8zt2a33zF+L9r8kZ+CxULupPUSB9HNvFm6GUsD6NAYOvpMP3fB8ymEAxoQ0b1bgltDEA247r0nK9n+24HZIZSoMGfpxUnYf4/2FN97nhez4dXAvJ/5zKO3knrFWcsG6HXyIOnF0h0FygV1IqvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t07KWB3DgouDnDX9SUBJZaHCvueWz2NBvwoi0csHskg=;
 b=ZWSzbGoGcQ9MyEwfOnJVUfGwH0MMSW5EkN8VE65RNWphzXGN3iEr3zSV3NkPdkIpbpFUP2BTASJqUtw0TlkioCP2NoA2GBvYiB+Y2oImWAaChWhurqCQ/Uk9QIYv4Tb2ybBY5f+Fg5DyJYZMQtFRzl+9JzraHBVOh1/Urf034d7mXeZd96L06NUY4MQJuJODXC1d5qAnZl8pQjfqQlBgkofufIWWSYX1QQshPtXhnkbbyXo++IY37MJRL2sJX7OepC+6mxZ7sU27KkYR3RY2Ojc5c7hEh9LTNs7YkvjSYL7hpfaa84fCRL91UQdPoA2eJMPc9xoPXF0blDjWyrDSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t07KWB3DgouDnDX9SUBJZaHCvueWz2NBvwoi0csHskg=;
 b=b1yabJNT5SUa1duZnzk1EZfS5tXxXxeJcHSgso+puuZRHuooKS+h9vM5S5CkvGOnNInXWMWAmyHvRkL2hAMPbVZ6FGt5uwxGVKhWFhO3wN1NLRMCQz2R9o/VmUNEOXUNVGi6MuslGvVFMN2OdGBmRsjgacQcNsYGqDLv+6QOU0Q=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7874.namprd04.prod.outlook.com (2603:10b6:5:35c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:19:25 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:19:25 +0000
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
Subject: [PATCH v8 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Mon, 11 Oct 2021 13:48:19 +0530
Message-Id: <20211011081820.1135261-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:19:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97c8d3ee-055a-48c1-5bb1-08d98c8fd5e3
X-MS-TrafficTypeDiagnostic: CO6PR04MB7874:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7874E240572FFA597B49DCBD8DB59@CO6PR04MB7874.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IQLkzq6UvAYDjL5SZW+XRuF+fz/9qO6/W+fg+OXlNBX/ddqkn0jE8EA5qgG0BcbtIBauYJhoo+85rB9xpp7Av7hGLThcwws/BMJLfQnhae75aMDumVDafaHLBmEHXqfiyxpJ06kLztixgYPyOik4bScjig8iaU4OAfdbOZkluSxd+aBOygDNU+U36uN2ED3IXw3y3eVZeN4r7hSt2z2r1sUBvHtBCPod2GCZFgjxo0ywMa43JtqjtS1DuuhHbx8AhQhLK0pyY62elFq+ZoExFE1+pmGt1Y/uLhQPuIE4raviq1R83FygHnAxnXT3P3U59DUAc8Ih14Z990yIT2uRoyrLeXId9lco/y6cNuLT5ntCSUfqV0aGf89Sa9+HWUajkn3S0biyV/tV0ocsA/u/NC8h9WM81dlZhiHsCQCAAdoHWXHmpiR7u6fe1pXtynoAxUKSu0KnXaNOUCND+xd3KYqv4kz/rnuY1HqIhhoeCZopkMWmE/ssJACkUHvExP7KWSi0hO+rVuvx5njXUaM4fIFRRJ4VJWrqTMeMkes19aibwaqr2Z8xD2hE3FIOkfrYV6RrxkM/PxBtLP89oEL/1Xm9W76ZNJJCijTmjRV0H1evOT97HWTxbMILtPQPlWfaX1KC1sPzmUNcrio7Y5NxmGouCyAw7aMM5/+p+cm6s9ZaTMaBAnoP7LptEO1VeNkOsMTtnWRw25T5qZD7AyAlMjb3EVs6kDSiQ1kpn4qmJoNkGfPomJFNnBdxUkVzkYxgyZAgDaffcc1jisAll4OJ1c2mfQ/xGB2AevMbfRiYVdO3OOxLyzgfnXd6K7Crz2I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8886007)(26005)(83380400001)(186003)(86362001)(44832011)(508600001)(2906002)(956004)(4326008)(7416002)(2616005)(966005)(52116002)(30864003)(38350700002)(66946007)(66556008)(316002)(54906003)(110136005)(8676002)(5660300002)(1076003)(66476007)(38100700002)(7696005)(8936002)(36756003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hI2IqGHLuciE90MhYxKgAtTh8OUkBYjMstGJ60fFWO9TI4QNeM/+CRb1VNyO?=
 =?us-ascii?Q?/Kdt44sgKWCHwpJFmVNJFQjrOHcjKtjkOXfEDvYFQbcolSl4gUOaG/D5O+43?=
 =?us-ascii?Q?CX3+glY7Em5vXo3w9cLt0UXmSJX5M+uE/WMcd2YPWLImK5Wp05tbA4xV7W2A?=
 =?us-ascii?Q?Bjj5ajU52we/qWcizrspLxvMaxx/b6WdcimKprnRE+B/EIqwooOBHD2YkAaa?=
 =?us-ascii?Q?R5ZbaqQimiJIf52kp3nXbAUD/DnCnbDA+2bGjOhxzmHXzgRHERei2cKzL4dM?=
 =?us-ascii?Q?l0cjxDt0jc3kN8XSK+sd6bCsPMohSc/6ub7nioHChZ9srtSXPUwYKriOY/9w?=
 =?us-ascii?Q?M2nqhz09aK3b8jKWz8B0q55hrjmOlj6kaPGXTv0qd3mInYVtSMVYUUlpzYdD?=
 =?us-ascii?Q?4gVV26bKsltChjtCnb9R8RM+mrkVpUSP/HzuY3ucof1LL3b8T9b8SdhbFT8I?=
 =?us-ascii?Q?qpYLQ1Fj1ZdgRw+uFNpKxVYeim4e3o1luti+oaFvJZpwwZ4X0oNsCxUXt3gl?=
 =?us-ascii?Q?t/QKEHh3VIFWUgMqqz+CYovOXOt4l0jyGfpgUvjF9Y/KDaVWnLFMih3Ulft3?=
 =?us-ascii?Q?XJ2ll4BZ7L4gYu80dpb5lwFR2+jsAHTt5y3w9aH7Q2vQZ3letjqX9/g8UDGF?=
 =?us-ascii?Q?hcg5X6feyV/6IHmhUlv9B3cGABsYSC/nkdBKqJtFsT2yYpYEMitSXmLoPYo+?=
 =?us-ascii?Q?mzNNduMtfHfUsEkBml/BcG/CEXdL0Wkd6faqG8jcpo42btbQYZe/+TaT+D61?=
 =?us-ascii?Q?ruPVc89rM3QGEkF9hgpzGvi9n+ZOG9JFVFfjq4+aO+0znMofnwLeuwsrPsGs?=
 =?us-ascii?Q?ha6kVvT23gbySht7+z7tN6mgMfiCfqx6nJ28RGSr7OVSB+xcAC9QeutDHAu+?=
 =?us-ascii?Q?bFVUCwef0Ew7lsMrEv9B/y9CvRH2R+c397mzwLko2nm9PB68jumarWGp47yQ?=
 =?us-ascii?Q?IHlMOxDvhoDgDJ2jp/tb2LVcAPWSySsG2tywAnAYY2o9qyJTxWPYATG5AFHc?=
 =?us-ascii?Q?DVzGWWVltmBARIf4BXl+nNJRd87vtfnBFzhHstEVSp82NAvIcIG5/8r47b5b?=
 =?us-ascii?Q?RWJt04v1Hx6aCuOzzMNTtiujcC2BIa5j2pQHjy10qNw8ibkvLHsa8K9IGawA?=
 =?us-ascii?Q?SJWNT0zuizIre0F/JytQtULej1DXvO4a0smrMjl89RFVeNZBdRxVMpILM+Rn?=
 =?us-ascii?Q?hEW0whUvazosCckOjh4UHoWrei6bJA2+4MAywdRfr+H0oi+NmCVoBLIBZhOx?=
 =?us-ascii?Q?PMR3qVGaDj8IzTCN+MKn2MzsT9Rnbf5tRvvaWYxuvy/quVWwr6A99qdoUL+C?=
 =?us-ascii?Q?HfW1e+7kXa3W0nKAOTL+0L7z?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c8d3ee-055a-48c1-5bb1-08d98c8fd5e3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:19:24.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlSd0r89ZVkiyiOrwkLJtD8cqTMeZdK0Y0nADlmUaBbgTAlvV1+78WQbAQNPcHLOo7+JmQZCxqot5/5Z9QPdig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7874
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

