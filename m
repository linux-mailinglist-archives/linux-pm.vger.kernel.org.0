Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B953A23EE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFJFZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:25:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11542 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFJFZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302615; x=1654838615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Siicc7XFOS1KX69fJqIb8VDbnwqgai2SMf1SZ8neito=;
  b=S9fuwTgdLKOD0WG2aRlO0YrxN7mWdBL63uzGnt2ZiCXH6cH6u48v7+ki
   1Gih9GcjZsdPpWU0QAsJIpTGdNWCyXQ5QufBKFDtJvf9R9DaHBZB8weXB
   0kLxtl1sfi/9o8Pi42DdLIzNETC5bzBsSBbsmbX0oAZkfdVjdoxDz8z6U
   DZnwkyDH8KRd7y5jG3RqAGw9B1wM/Ni3uCDzraWckTgktDaOcVLoDCzl3
   q8OPQcue/UUZ0WD9oMRNVBaDwk0cQcwzqrSOVjIadhytgziqvTNwp9zKJ
   JXSlLhxyTFr7WD3wEFRIZthr7tvx87at62vqNgs78lTSEku/jWgLyWD5M
   Q==;
IronPort-SDR: 5fmBbYWy6Lnx2zBvLY9QqSboai13hESVYCUUmL6x1ds+6RAhBoO0ASkX0B+5vnWYrkO7t70My8
 PxVpH+z/df3hok1kPjuuLsDJYshOnTb90krLkOHY5sywFABNoC7Ohivrd5d2G7gNxKcYiOXsNL
 2Rjnxv6fHnYApSn9QGSz57TGF5/CUf52/NYDAbhmqhWB1ajqVwT/3S3lFrXbSjfeBpooH1ANPt
 2quNo49Qbga7J0c2QQBnrMA+o6eo5JcxoCnWNiOCOyBAnBLWQwQDu/CAjkMVpYA7mdzTVYvjp/
 JMw=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211821"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:23:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM+a/6P2WvnT6atzBVtwQtH96ZSfqdYH6ZP+nmQQKPR6tkRH9CZEIebea+7KYSOJx8WjOEsLVCbjsFgiN6gnp94Zjf0SCzwgAXIP8oBOxpWlpJMuGx0A0MU9i7uvo4N72g4PWL0vbFa3KgfOd2b1NmQsZtMjqKQGw0FE7+hAXNOX/xkrHz1c9QqcjH2mghDbvnk+gzwSWwhJqxzyzzCLaveET8vxeorrH/j1jZgg8s9qmwC27n5YWau++AN93/54ADm0j3R7zdxGzEjxIE+c/bZxlw47pDNMrFHgdbEhdywNlHtFNZmzXTY6wim4/7Xg4UvcDasVuPAbZ9Pf94sHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t07KWB3DgouDnDX9SUBJZaHCvueWz2NBvwoi0csHskg=;
 b=VZoMiwlHBRm4dhi9uxHWjBqDA5ZyW0PFJKid77Ev4tjhH5QTjTlXZUNySNvnZTSwEXDykjAQdp7IVg15dXxxrsRX1cIAOGsAXWTUUDM7eBL/FzMh0/Jn0GZUFqBxwc0rpe8TY/clLHuab2Wy/LNzrbH7OqynxyWPD1LOKH4CKEIDLQ3QaAey0NRthO+O9q2PZTCctbIc1CC3K14bmSoXhPo6X4o5C4hq6mOxl84i1X3fEoAOWzWwMWdL8AsQaaj4iuQq4tx/1WktpbW7akoujuOTVXGJ+brWdeIjvL+b46O5RNzTYoo0V/VSZ3/JdFWk4T+El8w8KzYprucAJCYanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t07KWB3DgouDnDX9SUBJZaHCvueWz2NBvwoi0csHskg=;
 b=WmdV20p61z+RsTlpzxHCb+SDsLtsyg+hoQ/lPBh2S/hTKIp6wv3u1ArEZrxURoYerEqSFImnU/HzJrTTvlsJh1PpJjYHuwqyGTnPpPuZjHNuBwabWBrbOoLrBTT5/Zexinet2O0mUUbf+Mdchcsk4Foq8t4a+DAZabj0lZYHW2Q=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:23:22 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:23:22 +0000
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
Subject: [PATCH v7 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Thu, 10 Jun 2021 10:52:20 +0530
Message-Id: <20210610052221.39958-8-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610052221.39958-1-anup.patel@wdc.com>
References: <20210610052221.39958-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.172.180]
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:23:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a81fd74-5687-4b01-df4e-08d92bcfdd40
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB777823177C40B6BB450EAE0E8D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWHlU3E/QJ+RsCrPlX9ty+LC2BGhN86EZu8cDWhcgxlyZiJfOA9Wn9p96lpwIF69kXgHaN7mHSuGgvyoi+Cm6NHSMRMOenYDVcnEfNoNJRlyhHrM5u6rXx2vdmx2ErQjY9xTzvSJXJKHbJtry+AwAUcY4xG6MM4+kpURfAiYGDB1H7E/h2atoi0qh/O/5w8ihmlR0rcMVrb/8wAMCVhIg9tU68E1XkP56Lxj4ptma9+x4g5MFaduutEqPgPBQ8DopAOZFpWXAVwbkgkYAjaNIKxIJJ9+T8tVOW6pZXB1sOOlMZesAG6aSlz/EQpIuneOtfOz+gFEiwzgv2pxfcBwEw2QaUtWf46FNKJSEg4f2A82o+0P0BYnPuvFAXH+KzhkL92PLYRMkNZTMF/OvhoXIcn4qXuCLcpUW0yCNltMAFIlhLOnoUUlmL8omLGGDnb2DLLbHsbAN9ldfNPchxWGYpUxnNvv0HFOe5Yj31YKs5yVHZWbUxa3HTa0wvLrF3afcZfCLx8IhVPPukCU/BA8Gr5WKBxWuVAJbs0+dHN7c2gWbvDAuwWb3w4FPTiqgh5Ek0bYbw5AbwP6g7Ub6yjSp8bLMOKcNc9K2/TvQVNXxK3Xvyeif94FagEnIlhQCCLkt42rlW4Ymn6DBA9oxrMoEWudUqUU2TV7naI/4FsRyZSPTOyp+huuk1nyKFSVyBzKvw/9vg9hyx5oiHW/aS3fZHE6rfnHMyYumJEetQxmRj4qHuPPfpayMpoYRDbuNkKzsBEa5cLNrpo+a9SelIEQ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(30864003)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(966005)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzfwCp0M/7p7yiahGWad4Por2JiWFD4hQdiMqI/9k6I3ZLxviYN2xm9GJy/4?=
 =?us-ascii?Q?+r29bBimLiHKglMy+FSEStXXVkks+Z4r3C1R8mE6GkpKoxmaf2XR5qLOzzdB?=
 =?us-ascii?Q?onRffVR/9PlLLRsRyZEiYWFi8/bX+o1TtGtU4taYIqNMvY5WkRrsQlgUuwLn?=
 =?us-ascii?Q?L9r+7ox7tNLQbR7S84FXk/ODJVe8vN969rZaZzEcZJuilNIulyN5ZLr0j6vA?=
 =?us-ascii?Q?AVUUnsQrNGdZTEPtNoV6h8fhQG0ZCaLHvQTg5QFxk9XAE9DJyYmwvPKU8zAL?=
 =?us-ascii?Q?ATT4h/QS8eiTAki9U7ow9dEhK0RCaKPRdt0eKPdtHY+Zw2FdW5A4EZiq31zU?=
 =?us-ascii?Q?kPp9ZByWWYQfgxPyb2u+pl2Rn1dsbpktaEKJeScbFk/kw2o62cZCZ1ZBOZ3I?=
 =?us-ascii?Q?K7DPSdRRlzjG5Ldssie4wAJSQ0YjOPQhvLo1IGhTwtNZaZMZSxzLImZ5xyO0?=
 =?us-ascii?Q?DHAzlIKE24mbqsPdoG9B8jmwy9zWfOIFy3mc7wpC0T4Z9KZhdmhWb+rH1u0h?=
 =?us-ascii?Q?JlCBF7hIhLu8SJ6G/Qjrw+QR7Ao2D8VRrxWDPOKuR95VBKeAFzDvm4Sf2K2s?=
 =?us-ascii?Q?J2B/XVkeLNp3p9yTKIiamSV5R58r34g4FRyQi+RqEjqf6ZKeKGfJ+UruAkNj?=
 =?us-ascii?Q?Rdc7PNE57lvURYXpnuqp9r2stWKj7+515oOPvfonNvOnI0U44PAS3mWdATzK?=
 =?us-ascii?Q?jZzhX9pMuv66WUIN+7R+72l0Qn4kN9X75pUBizExGUPLbwt8BEEgVSkT0C+W?=
 =?us-ascii?Q?ByhU3kEAEItSj4Xn/C8Zg6l/mzqhWOGd6for78IUNIClGNyom9M1Duu1xCN5?=
 =?us-ascii?Q?zR7N40S05Q62+LIuJAnA1U4Hpn2obMuBECTtva4ek+SDTfx4CEOdaKo5qFdu?=
 =?us-ascii?Q?PnpFZGWQnTfQkKGGDRIss2bnymcSRJFZ1RHxJyoHJ3jM86hOgOto05bgApFd?=
 =?us-ascii?Q?jI1A6EPbi4vVGORUxFzBhdNAyVy6IMiZBtPcmuRaP+gdKpIaovOOFwQamdh1?=
 =?us-ascii?Q?WdSPlol03h3nHMMTlbrR/VHzv8BFVQdWO9jrluhLcHDG9qwqvRIFI5LApyvM?=
 =?us-ascii?Q?A6HBx4QmLqGeexypk1VPQojVZnSc4szDEikneKSjpBorIwo9Psk94l9EkGWB?=
 =?us-ascii?Q?gG5cPYLtSTBPLXADqbQEXp7GHd8QjnqRlpRAg8JExCbcptxXxhrxLw0Nfy96?=
 =?us-ascii?Q?qqd617LIwanuQ77BaetcHNx08xbcrvRiuqXFZTs71suoRZNHxfkazAWM7nZo?=
 =?us-ascii?Q?7VmgDQ0qhJZZsNo/iHpB5WLbV/ZPmUIMTltdAvr9MknXvJaldPw9vMZU9W5x?=
 =?us-ascii?Q?bnXQLLkCOJYIlXGdL8EgxMTF?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a81fd74-5687-4b01-df4e-08d92bcfdd40
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:23:22.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPVBZkwoqxMvSDhna3bI1OLlharae6TbgL64/Pptg7n9G4bnHA4zN6Qo8eqo5BKZB0nNdRS3+TTnqhTV+tpH/w==
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

