Return-Path: <linux-pm+bounces-18321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA39DFD75
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55511624BB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79181FAC52;
	Mon,  2 Dec 2024 09:44:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021140.outbound.protection.outlook.com [40.107.57.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F101F9EBB;
	Mon,  2 Dec 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132651; cv=fail; b=tleA/UHeB45vbpgsc86Mal/Haamk1KVz1pCapv2O7oEuJuJlKLjaN0XAxPPOd+lTnVjyp2/SbCX1XeyPExgFSzx2am1D+1V3AkXpLTaBCGzHCvE726OtxYm+cfQ3aEGS1V9IJM1s4WivYSfDJA0f1eTfAy6Lnndb05yBj9uFLqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132651; c=relaxed/simple;
	bh=wNNlbiDJPH/YxJEAOo9KA9y8GFTdfg/37isifwf1WhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJTgjdQv/KY/TgEG+GCInD/Wvb+xTHvL71Tjow+YBTxHO93Br2zrlF1g+0KIae0VBeLtlZsf0oT+3FC+kNaNxYVn9VEjZUvvbCo6k10Vhd3vnhb3CZK89kH9cs8g+Wgmd3pfHsIXkeLvBas9VbotDO2/zveBqO1/RvkN38cecoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py5vWwf93DsS5y6ZpTRiIZfLyrS7zKNAj8lhT9PrveqhKl4rE2EX2WbqjZ/ixqJxxsNp7WlQcNDnBTxcgeiXASRvZRm6FPgCTbU5BglvbHyBseOWdEMi4esRSGjiDIvTOAdwmZkDVYLxL5LJC3aRGlGg8Lt9aJ1LDMyDArYdKmJMqPxzHxoftthF/Elo+w5QLb0+53RIFxGGV/t5398+83rqSJYlKuuo6VTO5hNo2flMT62l9z60EY9+jGYQQKv5h1K/SkqSTPKOD6Cj7pM2awUDDDFSlxC6XI6jIz67xGaOWMeZStY3Jl/+YUBH2cur1c1+esM7/W82zzqPoUJs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFx5A7uDlGpAC2ndH4Bk5X9Y1jlYjtHwhN8PQjtZPdY=;
 b=NVDGwHDn8jwIARnVPSHVSI1Pmb17uts9p4oPN3CJBw+O2vjW4XL/uY2PsFID/J4Ru45laIqZfQsaBp18KY8qAFzf0PN8yEqYRqhFWLVUirlNIKaozLpgv5J8dNsSYPeH8ITdVpdjdnRUw4u04P0IxAxNrfq3Oc8PcKPHTDYMjLIJkHk67bT6eVCmWUZBEcy1C1Sf0dGCaH1V6U4payb5YgvB0Ie0PF3OPkjtQZN5l1netK7rf2ltkgL8/m4Of/HcLo6RDa22cC6K+gdTr4O3aqXIp19CoWVodW6Cpci1BmaP5EnFvtX+BfJEpH0eZpnT1OVDqp84jQDmf7O88t5+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN2P287MB1028.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:44:06 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:44:06 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	christophe.jaillet@wanadoo.fr
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Mon,  2 Dec 2024 15:11:52 +0530
Message-ID: <20241202094328.14395-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
References: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN2P287MB1028:EE_
X-MS-Office365-Filtering-Correlation-Id: ece0de7a-f08b-4846-b7e9-08dd12b5dd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWXn5WOYz9n0PvDB12CUmfOeeM2XfjOJNuLcPmi+3awJdQ2hDiDoaV3mxFwp?=
 =?us-ascii?Q?Zr+EN6ia/zEMJVDlIqGx1h0vQZOT88ltE2g18fIdfmwKgOcm//6T+HHCidaZ?=
 =?us-ascii?Q?CyyfWDJPpLcXgLPDud8y0Uaz+GmiEdOHe41+VX0TvpEdtrEx58QNqvj3g+Kn?=
 =?us-ascii?Q?+P4s4IZ2N8aSVvDFoVV0lokLkbSPDYSIzElDkiSNx8DiBeFoBXCRRERO0kpQ?=
 =?us-ascii?Q?jUzoZpRiDkABtwfMFJVOjbIH8fw7ImNs9aewKkGgv5SFfVA8vbbfVLLPadKk?=
 =?us-ascii?Q?QXXAs2WdimUIraTcru++DHOGOnU5T9qsfHxKvk60dyx/2WpA2nowLLIiWAxo?=
 =?us-ascii?Q?8O5FB4HqLjFHO9A/eMcfoDOclJK9sfbIugWuuNX1ca0fMsJQXNjbjBbey0rc?=
 =?us-ascii?Q?kNIz/7qggyogP+I95/FRWTvvvj5u53wIODzfu7Ospa2S4tH+R9uVIDvmCOSE?=
 =?us-ascii?Q?y99P13DVuQ8NCiYw90nhzjwo8q1EdReOfTXLhcKdzWo6BC/q9SCg7r5jCgCq?=
 =?us-ascii?Q?g6UF+JdUckZknq7UfOMjUMFIx0phkPz+ZjUYTuJ641dwTTwwSGEummt1tDqG?=
 =?us-ascii?Q?+/l2l4retfyfi3fKry51piEHPWsKh51bhU7cyEz9NRDuuRcX3CtGKzzb9uSX?=
 =?us-ascii?Q?uTLVZ30WvXdoBdgbpn7dZkKJ7pcYTXsjWPTJMRWtgj1mvP9/U3oNjFP/lQhv?=
 =?us-ascii?Q?dgw0o9nfx1ct0iUFvjZGqxY431u5TswreTE1Oj3fWFgJTAAqTB0zzlytvDvh?=
 =?us-ascii?Q?F5oMqVZgB3uxYfXMXNLevjYf46hVDgjrX2NEemMXS2PIgldY/wKe7RrI91mL?=
 =?us-ascii?Q?6ST1CtQ65QqDwfIfgxCGFE6zlihbP2vS/ZN5fgsZEROQSzET98ilBr2Bt3US?=
 =?us-ascii?Q?njsglroY/B3nPLkKEzRfzaNq+Coac/zr01o5kYu95AwIEoEMkTMAU7xQLgTL?=
 =?us-ascii?Q?CUxc0EbJuT2M4nVe4TiVLZBnz8ck611UOgKObezJdsUrhRkJnexUVUFIaDbw?=
 =?us-ascii?Q?Oq8zZA+jmoLbNWr0Vgb01aGwl+uN+kU/tXlBrLGzR3FxRl7lX8tsDWngyGjU?=
 =?us-ascii?Q?z0DZUotv28zQjxRajyA4oESO4ZwMtzwhBqsDA0iZ4FBlG4PZW4vk08mY5K0r?=
 =?us-ascii?Q?CqUKGvYAo0u9ig9sjIDlUMzab5VtCkKuJ9OnSYCfzjsqpNnxJX1a4fgIOnBG?=
 =?us-ascii?Q?vcJP4a3K1ZLWNvLTpqr1ig00lMFpLp7/FM0+n8bskVqoFN6BtPyfi0POp45Q?=
 =?us-ascii?Q?TB4+7qn8E5B0hU4hqjJ0B7bmnQLAZ9SHDtT+BqUs/GzcK5Qgnc1/eUIj3gPh?=
 =?us-ascii?Q?q2Tln6G39k8lRYF+3MkDmhtf2yb0n33bcxRnGhCoiZv6X7EURkmxW5v/d6r+?=
 =?us-ascii?Q?XpfHM7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?briAqc9axDwv+UcrBY0kbVdM40C7pbXuGMFdjCowJzoFYjsEFye3sN11d8jX?=
 =?us-ascii?Q?R4xEl+GohEwI1zUtNCbnER7V1O5rRPl9YrOEVAlpI2y2Jq7OPauCDRcRgjrT?=
 =?us-ascii?Q?tG22fIDJuuoJ00m2PEit6+MGfJvzTCrRTWVbr5eSELSIU0AXPuqxsPm+maKB?=
 =?us-ascii?Q?96x3XZxDaCMYaqEBRPPFE+iIM2Rc/fFlgil/0upEE1+/jLoP0SenIG3IGA95?=
 =?us-ascii?Q?4CUlDNyE8pGUre8MK9ZQoZQ+7Br0H+NLY5r7VPHTrzTHEI2YTMfWi3OeQ3wX?=
 =?us-ascii?Q?ugx62xcqOTFvEbaEkExunGFwiR+YiZTN5lCP5JJsF293C4y1a08mwWk6Ctnz?=
 =?us-ascii?Q?BHDPc97BeFJr4lUty79Ipt+77/rRDU+gN4FBfDicrl4LZ307MSs8Gnqg4vzG?=
 =?us-ascii?Q?e3J8GC0Yl3AmYYdJK+LHHxP87zavoRkvs4AkZX5BQgGBpBXUmEJmeS+CB1bE?=
 =?us-ascii?Q?H9VHZchILTFXVhB88d/DQyo0e3kC6jLXmm9EWbi6YUM7t/3UPShtRevhbw+7?=
 =?us-ascii?Q?hHqdUetI/p9/7I9A5rNaMDRZKBOvJMgbR+2syHQoOzihI4d2qy0DKRHagSUm?=
 =?us-ascii?Q?3xUdNz6VbiIoD40ek6gGuC97QfxiRyP85xXXNJ0OJHQF95BJ2ErRS/yKKddK?=
 =?us-ascii?Q?9D/CyG7qsIUiGSigPB4ymRwwgwTbarUssAVXAj/6F4G+qBbxBV48OVU0XrXK?=
 =?us-ascii?Q?AYgWxXXeg0o8z36Ibm6E1JQyx1jomJw9fUA9QjN39h0O3TQKTCaTgewg0GtC?=
 =?us-ascii?Q?DszCUaHj58HITfnJrCszpgQAmW33frGCxFnYF8eICQ6dV4qBm9vYt6JKWR2Z?=
 =?us-ascii?Q?z9JyhQEtZ9yp4EPhflhtBs5yTlrSNhFv02MpuzhMQxtI3YiC9qyRhveQ4o1b?=
 =?us-ascii?Q?d2LPQc3DhIONr4orAd0jMMpyWVMQh4fsB4od/CIgAsJ/QArs6k0tVSIqwVfT?=
 =?us-ascii?Q?yoyf5XHgHLXRoZ84qgM8aN1xazmVgyxMzVQvlgJasGdNcNL+A1vss1T3Nz8I?=
 =?us-ascii?Q?6+NmITUwVnQp/K/0MI0ojS+znbwqAYDbEwgkuIjbzYz7gDu0O3L/2eFRMrvF?=
 =?us-ascii?Q?0rKbKPkzDsL4tnjZpYQMHWqwQOJmIe7phI/WO/ARioWbWKIN2s9K6poz7Ks5?=
 =?us-ascii?Q?mdvxIsCfovTrhittywNtd+p9u8X8cpRnHL2D69XiqjL/R4kjTHWaBj13xzBX?=
 =?us-ascii?Q?M6qVxaF2q/v6calMifjQZpQ7VU673/LWSTZhxJT4we22nhgpSPUidhiSulTk?=
 =?us-ascii?Q?hNf+1Qk8OWPEnXOFKwGY6JqgPW0pl+HHNktNqih7gpZH+HlegBHWCm6OwqeN?=
 =?us-ascii?Q?Ct7QqsjhUcGRvZkfMfv9SOHAy1p15mk+b1Jq3uDdFtVsUhkaMnOlpBpyGT0q?=
 =?us-ascii?Q?3Azcf4tBdClwwRKVYVP4xB88S80VQlhsaq8R3e5FvgaxjlnGnfE9zRx1wYTJ?=
 =?us-ascii?Q?XQPjEgbQv6ojSJTo5bTSDoCdnNYFzHrwWk88n5tQaxABOCmINL/eZNMSJkw9?=
 =?us-ascii?Q?dPgKm8lkEffkX0Ye2nli8oEo++HVjUuWDxb3ulGlO58hkLeVh07Wh4121Y7p?=
 =?us-ascii?Q?O0Xv5Qs3qPqKjl8vtUV/PXu5yHUHWgKhxQWvaPySNa9Wb6CXRsdsJZZZ8QbY?=
 =?us-ascii?Q?eqF54IGX9l2qzqI1DnAR1LU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: ece0de7a-f08b-4846-b7e9-08dd12b5dd2b
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:44:06.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGb6kFcdv7SbzwtNruP5fvt2yi9DwutqafNFHmRblKVMV6hEljeimOP4xJHiY/xocwGkahZYXqC2gvR1F60poJ1MWesmX05ROkkbmGMvWMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1028

The STC3117 provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/supply/st,stc3117.yaml     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
new file mode 100644
index 000000000000..8f38a6d637f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/st,stc3117.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply
+
+maintainers:
+  - Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+  - Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+
+description: |
+  The STC3117 includes the STMicroelectronics OptimGauge algorithm.
+  It provides accurate battery state-of-charge (SOC) monitoring, tracks
+  battery parameter changes with operation conditions, temperature,
+  and aging, and allows the application to get a battery state-of-health
+  (SOH) indication.
+
+  An alarm output signals low SOC or low voltage conditions and also
+  indicates fault conditions like a missing or swapped battery.
+
+  Datasheet is available at
+  https://www.st.com/resource/en/datasheet/stc3117.pdf
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,stc3117
+
+  reg:
+    maxItems: 1
+
+  monitored-battery:
+    description: |
+      The fuel gauge uses the following battery properties:
+      - charge-full-design-microamp-hours
+      - voltage-min-design-microvolt
+      - voltage-max-design-microvolt
+
+  shunt-resistor-micro-ohms:
+    description: Current sense resistor
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+  - shunt-resistor-micro-ohms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@70 {
+        compatible = "st,stc3117";
+        reg = <0x70>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+        monitored-battery = <&bat>;
+        shunt-resistor-micro-ohms = <10000>;
+      };
+    };
-- 
2.43.0


