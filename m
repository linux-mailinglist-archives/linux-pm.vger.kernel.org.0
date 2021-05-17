Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1E382D01
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhEQNMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:12:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48980 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbhEQNMQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621257066; x=1652793066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MeKl9jhPLjMFZAjDeIRMh39HlWEM175ktYhp3+Q4Yqc=;
  b=JA7ogTjVtPCgTxvtaq9IMaYOJBurezicBp0TIYbO3VNeB3YEP/u2xCWE
   BG5IjSWVvIetUmSjGgQXUT008R2hHUDTy/3DpBb9hzNg5h2nILw1AEndz
   BnSm/ycqazaUoNqhbTx6keIZxwvVVSaI/lawXWUH2wo+Lp+IwAqG6OJMw
   Bml69bmzrxry9DtJY6uOIaIDOmyPZlGv+qcXBuUfryIGQ2LRBzD7p+kCd
   vNmr9BoK6QcEKIjcKL2OVMUcJXUvQJf5trpzByzddlhY6n39ppfZ3v0JN
   5XPyr6ZEj344xBEd+1sI7uHuj895uBm1GPxXLVQKRsdWWl4mPMoofLT3D
   A==;
IronPort-SDR: RW4hUSwRRvyvSWpfx5lNRGJAw8VHvHJ5DYXS8kZ51UAhjpMuBRK6Pe3D7AFqQyzyo0n+fWIxqQ
 Ll2lYHO6ZRhyMgPgZVJjQdGRRsUrod6MvqrUF4QrYY7/KCU30g0jUKfnW1bxDx4eL4/FxloB3S
 Vq1Fwt235+W7CkiQd4mCfQL9N244NxX+NrRFvqCgGdCJa7jee4nzmbdUeK59SM0F5yUDeadHwd
 GcWn2RhzPJJ2OWeKRsIBaIKlt8z6PFMBZyOMgC4folMRnxpnUqrdxTolvhUUWNcF2feu0yU4eZ
 zo0=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="272394720"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:11:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD9BQ65eC8xC8/XJxdSnRO3pP64qJxt3N4wlXjfWE7Yv53c+hc5wckTEZHMcxJLri1B5lm9ue7WqST0Q2ZC+7Q2oJ0bZica612gJEcKyuPsXRqmAd4LZ7tCFuNGGZaGPwEX6Sk4BSyukr+qs+wkMfziyfWcoTQ4CPCsC7FHwM00/Jdj+3sjvE/3O5wv+NVxdyYqcVrI1McMjsiesuPmCNPvUezUWgRIJ7xQTk5PNK/FtRzKKT7lCELx9Kt8kcgFbJYn6wCEU/BZTMl65f202lvGpGZiqD/jrQDVLDa9EH1PctMzlJ8/ZMZgjHLWTnmK8Ay5LJztbRLacQiEMiGeRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdb7LYKd4zYfz891hXSsl1k21D0B8sMSIEAMlC4gzCs=;
 b=Hp1pk+vgVs+4bnf4cQcT3SXGo4yUIcfLG3GOzbu8CGdUahLCtcvjTbS0QLiLI3GIesHn8fY5CE9Nh7c8J6BRR20mBrg+/Qe4b/meubnJdLRG/Wwc4b13oOvPe0SeLbZs5mk/fAtFF5zOC08cJjBGuR16qKnyeyq6U6owF81sIZXt1BxkzwvBPpvppKXDfj+C9CCgF+f/NHhSPRE1Cj8l27gfdfK/b4/LvrE3oAt9jcebbWrlCF0YkhxjpfaSQS1ZojpzvAr9G2pdSxHQVD12AO+s2EvNjLgCrjJBmKtnqFsCljEfM77PPcCblklQO183xTx+ToJ3nVvR6fz2wt3fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdb7LYKd4zYfz891hXSsl1k21D0B8sMSIEAMlC4gzCs=;
 b=bzWu9Oup2CCOnsLEA/WYKw1de4dpojGDqgHZCy993dh8Vml2BuG+nsawqu8YzzRLABEmAPl3zMpqT71SVprngjH7/IZ0kSYai58PcEA9VAJZcLFfOxEfAO5HgOscTrozp3RvAeDAirkoJuZ4KbIZT0Stw3YbossejZ7ILD4tzR8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:10:58 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:10:58 +0000
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
Subject: [RFC PATCH v4 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Mon, 17 May 2021 18:38:22 +0530
Message-Id: <20210517130823.796963-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517130823.796963-1-anup.patel@wdc.com>
References: <20210517130823.796963-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.32.240]
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:10:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 838da732-6741-477a-eccc-08d9193535cc
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778336A9B7DB2512C6D28E88D2D9@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCqf4kZe5GBSzXTzM1+oN/8QosO6uH0mgLZMo72jvQcC+WFII03kim9elnTelqESUrCpLB4KcSNV8epndCWRsCWTqjtLPJhnrZufY0ExamCDlIJvzPMy7/KiRC060C9bZF2+tMAWrtVGkj155MnfIitjIT+Ck53MHTPoT2R7DjKu+88pc0Nm1v2ghdLTMUgh0KTdq6qyC8Mxbd2jw9MMTwnuJaOAt1KO1rUm7uqGPNblPtlMREBY9e+pdIPNuKDCwb3NEn/QhbkZ28QbX6oHZvmYD+//cHILl1mLkMVOVFjWh5a1Lb50zNrOXhiqQlCM/8y1k/yNhkg2/sFlbNM4vHv5vRUQoTLVOisgCWbQYsD0Dp1HnukIapG0988iQR4ZpkwSvVg2h3Fqjmt1IUYA51Af0nRt+uW2M4pZHRU7TdX+E9x06yHU/oOJ6q+V/bUkLaha04kI8bFXEbMMxxs0CkaisCI142cjniJ8LDzQgQkArDwdFxRKN3zGKpFYtrvZFc0HPrGdzSSYNHum/9NLGcm3kpvWoBAHKiAtw4/XNKm+BNEM8NDu3hd1Q2jVD3qLSvIvxaiXomgcg5qV2mX/7XIpQwIfz7BCMa8ZLeEd9jj+n2ekNLiftB6uIU7qg4hoUHUfTQhE4uBG/Q01eAezVZn8yj8BYVwHtdrOTmgMceFpGcjnXTZSAwIjWX6Op2jsj06I7gppksO9zAIf9lF7TeyXtiEQsZyLSa8FNr0RQs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(38100700002)(6666004)(1076003)(26005)(8886007)(66946007)(44832011)(86362001)(38350700002)(4326008)(55016002)(2616005)(956004)(30864003)(52116002)(7696005)(110136005)(54906003)(8936002)(498600001)(8676002)(186003)(7416002)(16526019)(66556008)(66476007)(2906002)(966005)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RNnQZkACo2ygtVF5FL5O9dfbq3phxhw4XnKNNuxsEMHGsaRFlxzwb844FFmN?=
 =?us-ascii?Q?tDpVAhK/UCKnxzT/uYtQSraXFUlENAd1fQT0NIww9el3QgQLlBPIsfUcO1yS?=
 =?us-ascii?Q?sdS9KirHV4WBGUH6cYPplLsvewyAzmna9/JvYRoIfcX6l6fRFVVj6fx9+llE?=
 =?us-ascii?Q?L8b61heOP9G4Ror/Xa6TqNOn3OxdD7Y6aqS9DuJTIwQVKXT3EgZ+SeKJnsiu?=
 =?us-ascii?Q?lvuw73PuzVLy8WUKfTc7d6/ah1TBsR7esWvsv9aI87Q3OatWPl6WOiBQey96?=
 =?us-ascii?Q?eYAfn0+ovcG5maA1k6FlNYGtqFpG/SdCAV6rQlxcy/S2zyPKSmIomX9AjDE0?=
 =?us-ascii?Q?/yvfT0pO4+APAhcp6GwxerQqIEsMbg2En/KWPAz5V1yqv7Ql8iocJm394w+O?=
 =?us-ascii?Q?gQ7eGXJ7/b8gfjzkRjwBHLYOByDSlazBGd5dypiqS+H1Xar5sJJrDxJmdtQJ?=
 =?us-ascii?Q?/S5LUsm17twVZ19/P95pYc0l0h90DQ6kY5ZbOl3J4EhnmdPrDGaOn8V9Ecsu?=
 =?us-ascii?Q?fELSo/GziCePrlQXovdOgs6/cDbrfktgLMa42aA+XsIOCupQgrrfYWJaIPpy?=
 =?us-ascii?Q?+OhTeGdfYsY1W3+DjPekUaMNk8wM23N8SwZox2JzzTsUUXRQyXo4Ixjb4ZPn?=
 =?us-ascii?Q?lHK8kaqRMbG0UnKqWPSlknnuhZ2Is0a//wsaLcIebNX2nJ8U6Zv9Xxft8F50?=
 =?us-ascii?Q?Ze+UGMCmo3EPyHsI+g875psR/JdJpOg+/IT5dzQ5Vzer/6wzVZ3A720NRdst?=
 =?us-ascii?Q?Qat3A28KzKhFFeL0k+fies7QHsSppsd1ZKfue92NjCVh8JBIb5i5qdfzmHND?=
 =?us-ascii?Q?R+bAoZeKqvtlLVR/0o5bxi9Qhjl66idgRsZhpmB/aKZrMajp/9gJnn8hjDvs?=
 =?us-ascii?Q?CMsjHhS9A45vZhZ9iRmNk0EV1i0qD+Y5D3XHQ3EwRZikiFJlIW9H5Es0oTBl?=
 =?us-ascii?Q?i2X5u5xYwCjJ3h/yCnRYqQjGIipSWCbiKqTMlVxZDhqQsK0qyWMdjqZWJTru?=
 =?us-ascii?Q?T9G7IisTBkRhltGj6bk9CZsfTfk4ngHL5JKDDeJoisIJX0F6xyMuraZ/5kxl?=
 =?us-ascii?Q?O64pKKQgmQ92xS4ZkW9QdnhsFiRzB4PohYhvuXBkXAfj0/s6VSnIotPjmUHB?=
 =?us-ascii?Q?vf1tH1vcBQg6WzgaB/k4H8qj2fK9dlIPrtp+5iRgh16BXUkH1bc6pXoMPZSZ?=
 =?us-ascii?Q?0o8gv+EKcyT9XJHRm+atuNS5jDDw1yf31J/qndj1XuXDAuFTqZLrD9UyHj3Y?=
 =?us-ascii?Q?voYxydO3aaH06fphxCk69IZ07eh6x63cTc5yWJ2byTb8L0Q4s8dcp/TAwy+K?=
 =?us-ascii?Q?XtQqrAVlT3sdqi3AzhnfURw9?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838da732-6741-477a-eccc-08d9193535cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:10:57.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Bg3IX+QugZzEvGt5GOMnQxIjAdN6OHItngW8+6HZYymHSjjZ8zoNP3VE42z3eSl4CtW3zLTCyBzxyBLg+ZLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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

