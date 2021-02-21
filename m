Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5CA320971
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBUJkZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:40:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55621 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhBUJkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900422; x=1645436422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k/cO0iEyh7I4iX+p9B2vfPafNS1lDlXAuiIz0Z62R7Y=;
  b=epjgKvF22Wr9LIzN+smZW9O89CWl3aCm9LyIT6Mfjuvm5oORnP21H9Cw
   A2BaWJ0jeepH0MLBK568Df1xi/crn8lmPdFiP+xIkceBjwX6DxzO1yzrZ
   4pAQHqucVoIWaInl8kKxE153Vf2OiExorHZW2Bmmu7+5INgAoNQvrWbha
   ZEg8iBslqEcp0s0JYYUDhqMkj0CDjwwtydUfc6n6wCNukq41lpVH7tnmf
   +A8w3l3wvOvXbuuPTF++jjUNxDXIKaI9zhYWoLu5QOJP76nN6VxfuWNaK
   muIx09ZpAvS+4sRfE0lp8J5BMpgSpilmCcaiyZiWLP9sYUlkLnDJZrqs6
   g==;
IronPort-SDR: PSxBnzkTsWVu80u+0DaWRFZ8p5Igg/Fdm+veUka6bxyD5B1YUf8Fh+LkoR4CBK6fr+hz9+eXLM
 3P/qOBuvlEltxt8946Z6hHr2iu8eoUNcYmZX4dIv8G8j6waHXP98cnv3ELyid1JZIJcXiKUnSW
 97d3zya55TLiOtcCjCQTLUQAM78eeNH/iZb2xuysQdbbnJdXkWIoePEm+YpSGNAtEhaNBt8IGz
 EvxKznIOVukZEbmefgiyT5Bs4nTk6wfolsP+NyBrGnHIPQ4ySpfbdqkvr4upRNpkzOuOq7hucx
 Zv0=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="160448198"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:39:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHmkpAP59JurNa4VtcZlq2q5jipk+FKODgQpXbKzQUPKXsu3H+fjNYJZhnNHY9fhGtKT9U5N+psMw0L6It/eoEqcwO5EIORSQacKrf736uGYjgi1LZWyQ6bjRIwaxHxYv+N4AInXJdwhVV4mj2UedTC4UkY7RPnpBBEQm4KQrHn+SKBpc1GEByxgTyBZ/mnQtYPjJ6KqSa8d3pW//y76vt12QWuaaBCr0Qv3ZPoc6QWUXgECkZEAYPCMVshqWMOBXH5MzTUmt5p9+yPBODnK99cOP1ocqZrPIt2hBv79OGSqeHixr0cixflTQapUJF4112vhjRCbeHHRz5oTlu0xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxTOW4blC+Teedi8HxIWsAGjAFDkJQSf44pZ3zfmJEg=;
 b=GGdCF83gixwkm3oQhVHWhzkqMH34YhIxpLnDSbhkBPeWO79LewE6HCwWbD7YOvqT3SgrK2q73alL/A0wvCbV4cB44D9RkdtFx+qIre3Ah8N7MYrUbuLDP8D1n7OjlOxxsP6P/+6luJM7OE2spekzaUA01s/jJH8W4Q6w8VpfJ4n0LAkLrSskGVcecbzA1N6ycYvtrI4xiDTIOqLH5dcId/xXfNcB2Rw+SQLYfuyB7piH8MU5nABD+NguW3sklKU4gsWEqhwvG29fNSmQ8WeVDDoHV/H58y4vHB7qXdJtt3AqVD57LMBYfYA8nvyeEUOTTgpUeAR5Aywj9ScKIottEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxTOW4blC+Teedi8HxIWsAGjAFDkJQSf44pZ3zfmJEg=;
 b=QI2OVwpV5qbGNZDiiiUtu0GnWyePY79OrZgG/JSNrnZBGbrQIzUg/0q0Kaqo9w7G/3Ydl5343esQEF4NTUJVmbIMvNfSO4UVL+KNjL3rZZExX//G26fkm7iigmdhDpGWd8rPfqVtroTBxfLaqNnpvIIlesFc5id0kYGf3iJ7a/s=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:39:12 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:39:12 +0000
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
Subject: [RFC PATCH 7/8] dt-bindings: Add bindings documentation for RISC-V idle states
Date:   Sun, 21 Feb 2021 15:07:57 +0530
Message-Id: <20210221093758.210981-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221093758.210981-1-anup.patel@wdc.com>
References: <20210221093758.210981-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.171.12]
X-ClientProxiedBy: MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:39:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a003a7d3-3049-43ee-a06d-08d8d64c8baf
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB04597BC8C7287132ED8FC4BF8D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqvOyqEceHG8HPxvjhTFNgStTIHAsy11LT7jo35kmNFNx64EW/gy0ZtEqio3g4c9Iv97xmiNMWDdyTwLvlgtDwlEFGKABrVkSEecnEZsmjUjDHfkUtacO+KMFMcGtqm6q60eFGiAYMdkUMGyPVEP37uN1/uqCge4BQM+zCb7QyORIS+qpAuF11ajFsY+X14DX/fz9vaUkp3uw23jJCgU+yQrOPd7un0nzbe9YD+q1Z7tRXiDa0KbQPcbTwu/SH2WrLPogr1EYBB4Izy4kES3DUbjka5A6wA7JU9wlSzP0ox1VUEB3D5WTgHfL4QB8+NL8Od8RbtYmby1/QC6tU7Lov0F7DtrHJig7Z1kt/rmQD0+WxKWo+gmrddnNNGMHgDEfvIJO6rgCcyVQa/n5IwdmoKfWtL0yaBM7dPZi9zNbR49UHSe+AVs3WslY+SKrAAKb6V0ddwNS2jxWrOBzULulhCwKCX3IpIao5sAz5edvfBljzAYbqf6Sb76mPNehOlcgUZ8mH7CgOxn5I92RIWkI5LqL9HKy7iKOmAquPObEDXuqcYoa17ZlenaUlCma1D8PpLGp6vwosL7r0wmJn31Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(5660300002)(54906003)(110136005)(966005)(4326008)(66476007)(36756003)(83380400001)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jGL5RoVvYa7mAQxgtWh7QjiUUB8cPVAbCv+ykOUukIvzOdNFBa6+rUrP//De?=
 =?us-ascii?Q?VkxMqsHp6NRchZPJgSWc8g0V3n8xlzHNUeFRHA0Y7yPgUVmhSzl3xOdqn5iy?=
 =?us-ascii?Q?aGY+WGwpctDpsMZHfn8vLUbPr9K/xN6u3LuUImQ9YIVW9yX5YJnRYlIY/QlH?=
 =?us-ascii?Q?JQa6+57s548z260coYBG7o3D4yhEPIHZgMwTQtEVYU8vgexLd90PNqFIYsXd?=
 =?us-ascii?Q?tllWI7Dqn/5U0r5+W2jLAUJ4CERgSpUU8gzZYLdCkTrp9ujBlVzMxm2WCu6b?=
 =?us-ascii?Q?Jhrqk4ySlbnRhuvX7PkJYNOlUY5wtz6mJGXec8HzYHTnRqtnXosuC09O7tH7?=
 =?us-ascii?Q?dZSonEFQKVDsoEjrLN+OAi9Hx63i7+Ravsd3XhIvtxoq5Wdt41OrtvkNdHhf?=
 =?us-ascii?Q?SNUZVYg2O4XwNr/7CSbK1cHaCbLVoDGxyECwJojC/0Nz+l8PHaE6f1tExqNF?=
 =?us-ascii?Q?IiGuKuHJEdI5nwBWul0ehYFRlCR9Ykg/F6t3IYrUjCjk83qumLjy0WQyQKPx?=
 =?us-ascii?Q?y+Ton6TwuS4+sueP9WbOvDY1NWxIqszuJpBt7fHCh4U98vJNjajT2wIoEiQ7?=
 =?us-ascii?Q?2n+r7bwDYZlsWbZsAoe9Jwkr0YHGwAi+Vs2yiSlzIsN+2dr5bJK2ZS/M3rzq?=
 =?us-ascii?Q?AJ+TeEIrvnq2+FFRojfonIzMy7RLXrRZ6QDsz8F1rgQekf4Euqo/zX3DRgle?=
 =?us-ascii?Q?eV2PyLRdFi9omjUugMdbvdGKrTz79XSsyDSrfkPf2KOPl/pTyTe4UKjAfubl?=
 =?us-ascii?Q?4kwVQ54cwFxd4Q2xxdpcuaO8sCOwiyjvVRwzv2NCnGeWBfVG5QzCpaPrEEaE?=
 =?us-ascii?Q?Fm7KVjaKqUyvA3r6AwmJM6QsR+CjQWEWS7yaFe4H/sCcl/7qP/eAk1C6FwSm?=
 =?us-ascii?Q?xUdpI6xRtlFE3GNX2DggikOFU+NauOyJVZiLvISxEsaA21nwGX25mkKewo5R?=
 =?us-ascii?Q?dBUo3iq+nGQ9lL9HkUQPppIlABXkNUkntFjZWlC7QmeHuiwDR0XNaN1hAnOa?=
 =?us-ascii?Q?zMACRR3lq6mB+czEg+yxacrvHOhvLktB+jCywMjyg9zKfG7OW6izZu0M1+hM?=
 =?us-ascii?Q?jhaODQx4fQ58J7oDkMei4qPlA8uNEiHgo6mqmS01+ygZE9CLVWz3He+JRsEL?=
 =?us-ascii?Q?8ElJHjomNuqWSSIRE6DDcVGTcKoKjv+Ck1kHdn+PQimhwKywIz1a4BC92T9F?=
 =?us-ascii?Q?PXaYA9VZ0AWzne2cUMyGEp8f2q9FCVFbj5Mbg0P22VwelYQ6/1dFWLSsTWyM?=
 =?us-ascii?Q?tMTEk87MBGaIyFahTVuDg/ux14uMf7uBbBVXgQkGbny1gnAA96Sik0BeZ6C5?=
 =?us-ascii?Q?w5tSSWwEM2pCaf9oNlDG69P/?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a003a7d3-3049-43ee-a06d-08d8d64c8baf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:39:12.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcP1tl2zSRJTiqHvl/lbE6IEIHh0fyZVVXnnJyBGXMFTbIxDbLXuqii4iL+baYGrJMBTfl2M/mCqAHhxkbI3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RISC-V CPU idle states will be described in DT under the
/cpus/riscv-idle-states DT node. This patch adds the bindings
documentation for riscv-idle-states DT nodes and idle state DT
nodes under it.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 .../bindings/riscv/idle-states.yaml           | 250 ++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/idle-states.yaml

diff --git a/Documentation/devicetree/bindings/riscv/idle-states.yaml b/Documentation/devicetree/bindings/riscv/idle-states.yaml
new file mode 100644
index 000000000000..3eff763fed23
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/idle-states.yaml
@@ -0,0 +1,250 @@
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
+    const: riscv-idle-states
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
+        riscv-idle-states {
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

