Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40977398819
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhFBL0V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:26:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11682 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhFBL0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633074; x=1654169074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MeKl9jhPLjMFZAjDeIRMh39HlWEM175ktYhp3+Q4Yqc=;
  b=SYrJtkYfPBEcQeGe20yTbowaigkIp9cZuQxoUe+0G/9x8aMIOLLom9UJ
   UGbIYaqH6sODms/Ssn2vVEwJ9o/l4QJPzGiaQ40TL035vJgLZZrVZ4x+9
   tOJOvm4o6Y3IGePVLKFzQHP2HGloNHHZuO5yb3wPsWvgXAaY+uEjdTLlN
   fG4PAh8/5N/nUGQNOXh2vwsJsdXdp+is+Tf18XPiuSTRJ2XpCtZaee/Z1
   lyla3waS/zj2Nj6qLTFUkLqLAfvweojMisFqC5UVKTMO9+vq17pT43rIo
   qGJwgTaDiexf1Q7JJ+U4szdG9o8g59YqxDrLQBJkg5T7680CuW9NRkaYS
   w==;
IronPort-SDR: h4a5Z2wKXUDxJkrpF2a01HNd2j9qFHNG9fEpelVgx0uqoirB0SGa7aBYvTVGnZXAamJJqo3Sm+
 qls8rCmyxFhH6YsB9f8+j/XsupCYY0i6PgfpiUIl8sw19JYY+VFeDS6BdBTQGRF6GhqiOv8XtL
 azfzmlJPICMRy46WwQ6msZ/wpTcpCByK9LF0OkOD0QgcEuXBWBqOXm7f+oaEf9j6+kqCRsTvzt
 bHV8ihAlCsKWcUnRUAimL+zLOMLKsfzktZ/m5jW39ig9QZQy1h579CzJHaePZqDAKxo4zse2Fp
 TmA=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="170932592"
Received: from mail-bn8nam08lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA6U0XMBzhu1UCst75u9xLF3O7ewXLOgPSqc5H1YuZ2TZJ93L4Wt4vEZP9aeXEwZZe1ZXaPXi29DYt+C2TlO5DMTu+RvIkhYNMS8oKGSx3JU5DE0vWgzD6D+aaTw9z3biyULxCTKKQ7buvjvPHmKO9bvpD238uBxw+i5mmbzQtQDueMUmjwbW5totJaVsjLdObhFx3sSAlqT6ydi8tqXDpS6HZK16B2FAV+sNUNhV5Bkh5H2aPY8wSBWh+kTPmje2HmGAyKBjpQ6uH4MnHMkRfKda7+/UbCER6SnM7JAoSLfrEuhBTR0hU1oa4BXFd9F+LHq4YzTk8b8pM2wDzck0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdb7LYKd4zYfz891hXSsl1k21D0B8sMSIEAMlC4gzCs=;
 b=fVdDRrMQNDdpt+q/x1Q2st9TD7tFZM9OM8UxHYxDYBM76qCY0uhgL/vcnucgDi2cTLBYsdMH5g1eX6VZedp3CDsNr3AppsmIKNLWPE3aOQOyRxE0a5MXxP0vFcFAszb9rL+30EfAbRnepeB/eYF74FToIRZiz5+fO1dUl56A8R6Y4mk3JFTf8jujwjPqZUdAx4oXklCgHYqoGxVo6JuUz4K07UenkQ/ihsH6taQXQ7uY2k+IYMyFSfFly4wJ3NSqoQUgw+bIY3vHI5EfhjwL8CFZGvlydNKPi3jmmyrwcjG2LoP/3quXD5Ha/5klqR4lUNjhXb3ZG7frQZF7mqH4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdb7LYKd4zYfz891hXSsl1k21D0B8sMSIEAMlC4gzCs=;
 b=HyNaPuPt5kQGKKN7pebj2hmF/7UvQpJzELg5snwOxbvP0uo6bypBU6fUElY3WM7DnEbtDcN/eEaIdtJjBLATVd1qRdWmumHtmKG5H4v7bYLxG6ZpwLGna16WUel4SsPDs8VwLhhPI93iTCIMxGtgVKc/U4DbMOVVIbkZYVcgIfw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 11:24:28 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:24:28 +0000
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
Subject: [PATCH v5 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Wed,  2 Jun 2021 16:53:20 +0530
Message-Id: <20210602112321.2241566-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602112321.2241566-1-anup.patel@wdc.com>
References: <20210602112321.2241566-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.70.115]
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1783bc-a532-4a4e-1407-08d925b8fbae
X-MS-TrafficTypeDiagnostic: CO6PR04MB7747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7747754D8A9E2C0B3652A1678D3D9@CO6PR04MB7747.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puUJoU1FwlWeStwyNv/D71EM5G5wtqdSxEenuVtdRyb1r6lpWhayullWicHDbq2BeYDiqg3ZFcCfWpTeNS8EuBpdXRM3DtSTBd1uSbwxwp+8LZQjSEuPg7LxY0bXcYk/oIOyx2GPOw20UMf9gueTWEcpeKnoBixcnnnnepOSyP+DNiVUvZKSdpz+uuDGqsyxsOFR81SpGs69DAfYmOqOy9VoHgh3H1/7otpHmyVqERMtut/BS6gFjcYtnZ2dzmbal8hKXuEwUHidVh0B9hyy2DnOFSybw6P7yGrCbxa4V/MzMp22Xr3dNwAV48O72OCu+1J1LhXwXHydCLRyTH+Rr5eTo8A00M7s5mfxAjZQ0bwNVeE3r6xATNbcd6YxhJGTud9N0Mf0GRzTj+HGYDi5wsmTngr9Ht9jyuqM6jDWmPMqldgYOScmYoezkQ/F9u4IKn4V63v38C87HT5PXW9h8j+j7cfybcf21kbo4enS5xU62Mdr0Mqsnh+zAN+/ThmOM38n9pReDyCz75zOM16wbAtCBK4zMWpzEBE9dPsAPcj2iCywt3/hBTjzq4RHTAwTPh/TXOo7EhItZouYzsUuxWgd8wSTBbI9UywkIRPWGFKuYK7x6ndn28g4Ru1o/6snY4TASQFuF7avOIQj9QJ/wm0W/CmtMnEXKPQObIDb4S7M2pTeY+1pfLdvDiHGlE4Q3zYOhDL7L92afJop79g4Vq5ZCjtOjeJcN4u4hfkHMKydpzL/UMVjOWYoVOFwXDn6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(52116002)(7696005)(36756003)(8936002)(86362001)(38100700002)(83380400001)(66476007)(30864003)(55016002)(110136005)(316002)(54906003)(26005)(4326008)(966005)(956004)(44832011)(1076003)(2616005)(8886007)(478600001)(186003)(16526019)(7416002)(66946007)(5660300002)(8676002)(38350700002)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q3FHC+VfWCGuKltUqJF3mmzt8wYLnrS2hLJcxpnFgF65CrsqJCyUd9UdF8uk?=
 =?us-ascii?Q?a1aCy4nHb0cEfUqOLt+hoOZ5ude9WxfIY2ZZ39DGd7UUOi4UTaa3vZXkHqEe?=
 =?us-ascii?Q?K3QzygBeIY6baPDPiM1v7X/MGMkgWe2bCbo5Ix4Q2uWYtly/qgUWv/Jdk/pO?=
 =?us-ascii?Q?2tdk8LgngZAtNrs4AARJJ8y2Nd8oX0M3fAL17hxneYsPY2r4qqTQFfEMB8bV?=
 =?us-ascii?Q?FpV3Ss4z9m2edp48YZ6+bv97yTChDhVXSc7thxl8ygUXS7geM1h4XfHaf336?=
 =?us-ascii?Q?PQ06KJ6vCJv0Mfbai/dBGP/b/4ATOG/Hg0u+lLjHjW56k4DTp57Ixcn0rmlC?=
 =?us-ascii?Q?pqIVSc7G/IrRaYf0Q/w3T2V8jlkQHBrk4BDze60n5N0FXcth/wELPLPeTzAK?=
 =?us-ascii?Q?ex28TE2rLfGXWeSSQ2TYQicUxQaQuVM3LH+3etXf3a0JehzXmVkMhUrAJyv2?=
 =?us-ascii?Q?j8tmXzOHyA9fCG1LPIrnrGdt5R5NbPn6AdlWJ6+/QYcmUi7dm/79+B+eZkw5?=
 =?us-ascii?Q?ztThgVcjcr6NOO5H4x77awT7HbGI0VZjRtJMMRMP3XHZ0hikE9tduGLUvIPl?=
 =?us-ascii?Q?uuCuxH/YQZJ4myqiPZS7Ctl6UUS+ZX/tcgyRH4YjBv4RdYrI5bjzCe4asu6Y?=
 =?us-ascii?Q?ZJOfHalTkp3wcoF+vrsWPFBiKJTG4ulCjiRlai6USrEAN+PsbdxQrlVBIU8e?=
 =?us-ascii?Q?RbXgIgYkAu7ncMqOMGYziiTWIF5x9zebRbQP1jON37cihayj1/+JosYI+clJ?=
 =?us-ascii?Q?3EwQJuYd1AeTJ1L11lrAxoKEQX8xFP1bZSSbyCY++nZsb5J2M1lXQe78mZXi?=
 =?us-ascii?Q?NWpxrVMqCNfSVk9/2d+90WK+MdTSCH7187MlfSQkO+80DfiqmpHirUgN/kbu?=
 =?us-ascii?Q?+NrMiIo9PzM6lp+8XrFRZZ69WUPMEK3/86to0MuYBBj9ZIc9WWp3myBMjxpG?=
 =?us-ascii?Q?+qR4G+LDjJlTt6Ubgw/mNjZTpetxBpfwCXo+fZ5NAk5HotqJKhafOXj7AXCl?=
 =?us-ascii?Q?54lk55yTvoK6vk47TkGa+teziFBnmKG1YCsPKClNn2OVP8xmc3GSS37W587O?=
 =?us-ascii?Q?wlKeC2+yfKeDlq6Nmdnfg5ZI+OIIqnPbGHreWqC5ptJxnZf09RTwvLcM4v/I?=
 =?us-ascii?Q?LqwEa+wX/XKMHR6fpekzAlxQpTTUq9EyQ29tIQFg8fboEiSMpKXwu7WTQALq?=
 =?us-ascii?Q?oSjEjLUtGnN7DjDhaoAwyfv572x196/iKgmTNPB2lXIEIL3Y+NCwcN2NhvRO?=
 =?us-ascii?Q?pMjy4YehBypO1UjY/065lNUjHSuBjJIQWT8oHShhH2eNAOlKY2+IJmiIssFr?=
 =?us-ascii?Q?hrjbdoiLXAdszTe8gs5SZgBF?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1783bc-a532-4a4e-1407-08d925b8fbae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:24:27.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTW/KyGGhZU73MpQDj2VE6uSouDkBV2RCf6G0+DTDbKF4Peepp0NnvajfCJMgHFrwTdtWYJ0LuHFpLkT5iMJdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
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

