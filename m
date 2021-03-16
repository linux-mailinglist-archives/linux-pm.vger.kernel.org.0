Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F933D20A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhCPKnR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:43:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45292 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbhCPKm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615891378; x=1647427378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LMcvDgautBnUmp3mNjganpJagzLJYOQgPMmgvPU65iI=;
  b=RbE2GQOTYUoK0ODg5hehZtgIUvbiy1zO48KYWneP4NTPOuJ0khrC4IsQ
   VnK7OUlzXEkSj7pgj+u6Vzo7QlBg1kL7nd/fJLLuCipAoLCIXLg5ddR+3
   +kssZQC+iOCQaum4ahjJe2hg3yQ8eMowNr51NsKUIXUK+l/tuGBpuPwp8
   pYIpG/jrgVj5tI3Nm3Joo5ZqXi72f3JEdZtKDY/6k+44nhSE3aR7D1G9R
   Sra6ZMUNwPiMvLYVSMtonQaMFaaNvpo8zYarfOKBu13P2SQBvg8xZckvK
   sc2I8uuke2oktVkRMdvwWmzRnB0tPrMPq000iPsSdrqIJ5AvXSzrIokLB
   g==;
IronPort-SDR: 1VDWUXRQolIvRU4Jrf/r8ao0Du07BPHemK2fpBERDUnRzYR7Ze99ajvI+yZkeGqTGLHk/qjm9d
 X9XSKShk+P96s3CBMMZlboczW3qDlppl+Epf7gOUmkqOVrj5FOTeLp/xsJ2StNZsHCjFWxUMCy
 eHd7xse8L0kcWtsqjLszi8m9H4KwI9bWLvVG6jCfjGKZedCCxs/CG/52wVirJ2GHeSriHttMeL
 MQ2mri4vNwaUUFnL9pLcg2BoangAjmHClPu9NF4/OmoRIPS/xkzdh7SbnAMq5Y704NWgMShvRC
 kkg=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="163398522"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:42:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1w5CuHtiamMdrhLhUW7Wyxnv5deTymZsSDMVm8ZC67uiGUTQuwhvdeWouTXxDvTcQO1uu26NE/zX0nWWFHPU9NsPFUeh/xyugPXtwctGPhT4MCLbXeQsjo9EKYDXqtyZHGuuKhAASsmatp0eU4ts5z1gNsVxChoIm4Ku8g2Mj1HpszBkvXmE1gn4IdrQk1a91oUmUYt4eYqk2fP/QrJbIWmXYXzotF8yreOkqps8nuDdqZOCLjsPRwjg47Bl/o4NDT6xw+1b31DiI6w/Yu1q6zpEgeYSVFqmgrFlhqgBuwOx2nldnPKvCSi5xLxU/ohkAA6FtbtACoGWn0UNtfN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdOxqImNgiTaVYstfdyhXg8wAtLrcTlUWjS1snhcC+Q=;
 b=S/5pws5vQoRU5SFTNf9twRASNKHXGZdW4mJibUp1yqWMkyNgatZutmLR4OojE24FYIwpMmVi+ulRJkqccej+y3/8AhyeOPIcHd7aXLCa4HU0pQu/7NhJd6hdzG4M3tq7KKk94THeRoCt/PhX9V+ZZ98QT6MuWh4pbSyL2uQ/cYPavWtRyaJivGkfRuYOLV1nnih1SUhu1t4iUiC+VycYrBuIxa1eDshbrZJbzBbGcRMNHWGfeQFqkE6p1dVjWpb+E8DaHcBsEHiwEbWrYyhyTnQVbNcuvRKVFC5udRrNMRkLId88QyGu1+GnOXP4scnHihJHaFpSOTNkQrGso77mAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdOxqImNgiTaVYstfdyhXg8wAtLrcTlUWjS1snhcC+Q=;
 b=YR14lMkwCJmKv3uXSTKVqOpahWXEDHIRcuSJU9rmCQ88cxZS5ZHxzk5YuD9t2Lb3/zmqKwUCYvu2Jyrqkoa/GfYFXWWXQ89AsAxb2HJVefU2v1JK0ic8aNNNIAIKAsvjuQEXMYpHV0OPI+ND2It+tPAIM4hTIkNoLH51Gqa9VRE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6377.namprd04.prod.outlook.com (2603:10b6:5:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:52 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:52 +0000
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
Subject: [RFC PATCH v2 7/8] dt-bindings: Add bindings documentation for RISC-V idle states
Date:   Tue, 16 Mar 2021 16:11:39 +0530
Message-Id: <20210316104140.878019-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316104140.878019-1-anup.patel@wdc.com>
References: <20210316104140.878019-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.218.45]
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.218.45) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 10:42:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25073143-51f7-4a1e-f4da-08d8e8683ff9
X-MS-TrafficTypeDiagnostic: DM6PR04MB6377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6377BC73F15CBA231F49D2948D6B9@DM6PR04MB6377.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +T0uxNnC9MHg00NfaQVrqFjNN209/7hXHgsATa09FixoKI+ZS4wHGAJDtPHRs12gqW7kTetw/nVUBXxPBTvMsPEfO65WmL8cJ0SNB2anw51zCpeYR8KvEFM6K6u1itOhrSHfogtOH9jcSKcNGHjEZxTtDIVQEelBf9E0BkaCArxWGnJxf1ncv+m6RIC2EE5yO35xdXiX3J8zbAaTlLaD2sUslfdbSma+NABtV5fPDt6u1/rslCyFOIsdqDqMwS3VjPVPx6DaKjN79KEwyCcVtxTqM/ABIoif+JAA8REvyF3Q7lNVG8+YMpkXNN61wk5O2YUT6Z9Uavsq7NJBX1y6cmOyGs8N5QVcPPRWl+4UmbfWmgaXUvHEdl+iUeJxVpvqupDcSzXJeocRoWGmfIu+WWoFTuYjhSRoL5dzJgs/RMzZbvl4IVlUmTPkLsFK5Vqkg1kTg2tc5pRGCzAIj0R0TxIvS80fPEAOkx9ItQxJEZrcBbrrHxt6sbwaP7z2qjCraZeSe+qd04xQtsPFW0xSmrZzleMI+wM2dBHEHbbGsF0oCMAK1tUND3b8wQxHZDzZtecU7rtJk4hepoLU5Qakl6FiioqMz7kNrrmD7gza7vjcnoZ76cXVAAgrsmemTZvu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(44832011)(52116002)(86362001)(83380400001)(110136005)(7696005)(966005)(8936002)(66946007)(8886007)(55016002)(7416002)(186003)(66556008)(16526019)(66476007)(26005)(956004)(2906002)(2616005)(4326008)(6666004)(5660300002)(498600001)(1076003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qj9Z9ZkDBxxiRarAijunu62UHsc+Rx578Ei72MZ50QC0UxBtx2KFZcGG9om3?=
 =?us-ascii?Q?o4/WsRBJWccvNTVq9Ks9di722DIB+BYrrXnSW+hGiNExTFpsGOTqRVjJnxrA?=
 =?us-ascii?Q?aaJDsDiAA7yQX1C7lfz+8WuokmsIFDZIj6fCPDCXD51VH2cLBp5INjf1Ro2U?=
 =?us-ascii?Q?I/7Zbg5UcZWMQTCI18v+dLd88rnh0tu8rpJZ8rYCMlHLQtQwS4166MiYH41m?=
 =?us-ascii?Q?JnPwRTk7s8BtVa4L90A8xjF1iD8mCXa2aguFRKztuOcllx6Rqt/AxMTLHuRX?=
 =?us-ascii?Q?VW6EdBIkP1ZyngwY+N90+fcbTnbOj5n/mW+fJ+QvdWiKR/vRnlMI76JfxGKC?=
 =?us-ascii?Q?AoNYdnTuVxnseAuoSmpNQehNVHX48I7MLUxdZuypE3Y0cxWW7DI2NFpLy8OI?=
 =?us-ascii?Q?0l/saOEw13gyRe4TV+GgkIJX16NDWRh430ebdRrLeh73rIba5K1itQ3fciw6?=
 =?us-ascii?Q?pPnyZvAGjHbe84ygZpz5ueB8kp9ry+xRv8M+PTB8fBfQ20HlUaPe0+62r5L1?=
 =?us-ascii?Q?rfgrcLSqE0sViETKQSQ9Om51Ds8fNAtgE/vxQbt+4AZJK1apyZUN6AXovrNg?=
 =?us-ascii?Q?/Drgk68SiQ1AAg8bcuqH3371tlCHt7swxse4iX7rtUvVwIguiplmRtz/o6mr?=
 =?us-ascii?Q?Cr1w6vAgqcvu5yHL9yW37iKyWUCC2WQnwMtCH58+PKn84OCfNWXvOQJOCf15?=
 =?us-ascii?Q?t2mxLkEJVap7/SoOme15ZTOPA9wpPOM+hbJH00onlLAz5Z+U3P1ludbsvvkW?=
 =?us-ascii?Q?n65ZvHHo6LSAa2ar8FY6y/Q+/HtYNcXxaenKb2FBXdwSKdPxbPFc/B4E/rIr?=
 =?us-ascii?Q?uEeHNIZJMwqwwJCUx21ZspeYuUkkbmZIZ1pNGGP82uycLismy+2sqHe4Yyai?=
 =?us-ascii?Q?bB3zR2X9cDC/64lGeQSkUuJ/ePSGUZXk6mBqWXm8KQpKSW+OBykg2AffOib5?=
 =?us-ascii?Q?Q5MOEmgT/z2Mdj7gUVx1BiY1bVE4mRAEExhjVQ3NXCnx52U8SggQ8KkjWuV+?=
 =?us-ascii?Q?6Yp7nIukPejK9zdiRGkYTjnJbCCArtQlbxSvvA0c8DMQ0uVWALMFDYAAP4/v?=
 =?us-ascii?Q?eyqYwxp7NEiLZzGOVVSTWyW2DoIYsO+bIuwV9mkYdmWn6Pb4NFWMjVFPtHt0?=
 =?us-ascii?Q?P8iAIa7azQqig2pDb6kWS7Br+1CxeECySgtlfUjLj2v1M/rtHG0kSVZA+NNc?=
 =?us-ascii?Q?kxNuqQI7RZO+dI7PbZ3jJSn5voPrBFwYkC94FmV6QnatBO0ysJ6cASx5NHbU?=
 =?us-ascii?Q?DWyrl7Lfla6zlsPmvWeoU474meqmLrK+S77Swd4oSHrJ+mizh3FPzg6b/r3T?=
 =?us-ascii?Q?bCvXtFr/6F3DnWgCK5IyTpOo?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25073143-51f7-4a1e-f4da-08d8e8683ff9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:52.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07Xffs327Ba7kgBI4riPHkR9U/LadCSPN4MM+Jp+JH3UHSVpNHXaxeiVpzUi7re8bGIfjgWmo1vrTJ1JFE+nAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6377
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RISC-V CPU idle states will be described in DT under the
/cpus/idle-states DT node. This patch adds the bindings documentation
for riscv-idle-states DT nodes and idle state DT nodes under it.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 .../bindings/riscv/idle-states.yaml           | 256 ++++++++++++++++++
 2 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml

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
diff --git a/Documentation/devicetree/bindings/riscv/idle-states.yaml b/Documentation/devicetree/bindings/riscv/idle-states.yaml
new file mode 100644
index 000000000000..1dbf98905c8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/idle-states.yaml
@@ -0,0 +1,256 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/idle-states.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V idle states binding description
+
+maintainers:
+  - Anup Patel <anup.patel@wdc.com>
+
+description: |+
+  RISC-V systems can manage power consumption dynamically, where HARTs
+  (or CPUs) [1] can be put in different platform specific suspend (or
+  idle) states (ranging from simple WFI, power gating, etc). The RISC-V
+  SBI [2] hart state management extension provides a standard mechanism
+  for OSes to request HART state transitions.
+
+  The platform specific suspend (or idle) states of a hart can be either
+  retentive or non-rententive in nature. A retentive suspend state will
+  preserve hart register and CSR values for all privilege modes whereas
+  a non-retentive suspend state will not preserve hart register and CSR
+  values. The suspend (or idle) state entered by executing the WFI
+  instruction is considered standard on all RISC-V systems and therefore
+  must not be listed in device tree.
+
+  The device tree binding definition for RISC-V idle states described
+  in this document is quite similar to the ARM idle states [3].
+
+  References
+
+  [1] RISC-V Linux Kernel documentation - CPUs bindings
+      Documentation/devicetree/bindings/riscv/cpus.yaml
+
+  [2] RISC-V Supervisor Binary Interface (SBI)
+      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
+
+  [3] ARM idle states binding description - Idle states bindings
+      Documentation/devicetree/bindings/arm/idle-states.yaml
+
+properties:
+  $nodename:
+    const: idle-states
+
+patternProperties:
+  "^(cpu|cluster)-":
+    type: object
+    description: |
+      Each state node represents an idle state description and must be
+      defined as follows.
+
+    properties:
+      compatible:
+        const: riscv,idle-state
+
+      riscv,sbi-suspend-param:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          suspend_type parameter to pass to the SBI HSM suspend call. For
+          more details on this parameter SBI specifiation v0.3 (or higher).
+
+      local-timer-stop:
+        description:
+          If present the CPU local timer control logic is lost on state
+          entry, otherwise it is retained.
+        type: boolean
+
+      entry-latency-us:
+        description:
+          Worst case latency in microseconds required to enter the idle state.
+
+      exit-latency-us:
+        description:
+          Worst case latency in microseconds required to exit the idle state.
+          The exit-latency-us duration may be guaranteed only after
+          entry-latency-us has passed.
+
+      min-residency-us:
+        description:
+          Minimum residency duration in microseconds, inclusive of preparation
+          and entry, for this idle state to be considered worthwhile energy
+          wise (refer to section 2 of this document for a complete description).
+
+      wakeup-latency-us:
+        description: |
+          Maximum delay between the signaling of a wake-up event and the CPU
+          being able to execute normal code again. If omitted, this is assumed
+          to be equal to:
+
+            entry-latency-us + exit-latency-us
+
+          It is important to supply this value on systems where the duration
+          of PREP phase (see diagram 1, section 2) is non-neglibigle. In such
+          systems entry-latency-us + exit-latency-us will exceed
+          wakeup-latency-us by this duration.
+
+      idle-state-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A string used as a descriptive name for the idle state.
+
+    required:
+      - compatible
+      - entry-latency-us
+      - exit-latency-us
+      - min-residency-us
+
+additionalProperties: false
+
+examples:
+  - |
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
+...
-- 
2.25.1

