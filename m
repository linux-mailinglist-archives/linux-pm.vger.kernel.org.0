Return-Path: <linux-pm+bounces-19172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580F9F04E8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 07:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252DF282BF8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 06:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA6718CC10;
	Fri, 13 Dec 2024 06:39:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021101.outbound.protection.outlook.com [40.107.57.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2118C337;
	Fri, 13 Dec 2024 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071971; cv=fail; b=nKL0kqiR62c3jc+v2Q77YTTwLzqZPVKKxuAqc20YS1KeFvUCcCpSCYLqogdLU96vbfxToOkGZVADoPN79P4XvZc7l6McprZQtSpSeofPwHODttw8QT4kZsDUV9wP8dE+rkNBLAVaM9UyUtX7rlqaUB7WfGOFTPxyiSqFX1NlAbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071971; c=relaxed/simple;
	bh=2sZIu2wSK/jV0Q6WnuQbc11QqFn4dJXmYh+fs02ZJ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+MVpflX5IFG0hfu51wZ9UJShKj/+9ecW7DQZv2fWv7BaNsN05rdfEJUsW7WKmua2BtqAuGUKIm+bgki/hoPNKi/bBCne20Du8MjhbL6Uck/fnSIcfbkQvxg7XXXKAURCfI6Bey4wts3h3MI2PruWhIpLY6+iDq06kDtva5kyl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiJsLEhYA8I21FEAEfN9yE4EAucG8/3q7isJCb7Z2Zyef5eqSdVHwkxC0r9Mxg9XNMNPV2YCfv76MIU1JwTT3zcAL9w3RD13dC7FGbD2YNthfmlmiPb+4jO/96sY441NWXHmb4fUWmFBYA7kj+DVTeLPMqS4L5Lo0FB5LxpYsgkGVH6UfP2tfOrmkT2JwpdN++JEhsBcHi2PIM0m5GtejYu3OVOOfqigYzU8Oa+7EwAQaGjqdoPmF+hdTu0mppiN06OTDLGmdpOwEI4M+s9+Bm4mIzqoxAidnd0M/Dv6BVjrlmbtQSRLWK96GBbO1Wtj5QwkMVcgEkb/pyQ83OILZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm85JErofHNZMfKRIe5qRisrz1HzeP7xttjqfiZc1y4=;
 b=fUA3+Cp26HEVxor/NX0hWKoq2H2/eLP5hmzYSU8C9XtZHlsw6TOuIut2+QfGbA/9EUthnuI3FttbH8K8qjRw494IlDosVa8uCb2eCV+qqb/YAzvGafnO2qjz1+v2mfnbWNlzoX3n/U8wK8DVFYqw/BWK0QVV9lT2gB0HmJsKlBz6AdtdO1Q64kiE0481GOF51ukj+FwtNFnSpqi+2GxSSlqoA5KUP0Blpa8Kf7pf2bmFGk5I7HhgsjXZYADAfNDLNTQErK+LAVdKBjbvjHWx6W/Dss5wG1yyNQgX84Gpo2gtXN3VrIb5rLc86FsooiHBjsRxOdAyuiufBdaVirNy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MAZP287MB0053.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 06:39:26 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 06:39:26 +0000
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
Subject: [PATCH v9 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Fri, 13 Dec 2024 12:08:08 +0530
Message-Id: <20241213063813.32371-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213063813.32371-1-bhavin.sharma@siliconsignals.io>
References: <20241213063813.32371-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|MAZP287MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: e05d8767-ec01-4a8f-b88c-08dd1b40e345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbTBLrtr8pM9UKfBtHjvRpmPdNynAOes4zB5x9jpLO3AThxhoAWs3oAJvGKK?=
 =?us-ascii?Q?m4KrASaErePrLyomuO0G/oSPcKRqgzZzNfrm29MtVSxu80pCkfJE0oetFdoG?=
 =?us-ascii?Q?9FMmv0fEfXTjABvsQvUmkmjeWpRwhqUGt3BA060lcVxnwpAICy5UzRQhYJ6i?=
 =?us-ascii?Q?1STUZ7xTWTE6svfAyPB4r8WnaKnTNs+5poDsnWXG1/M/nUpe28oeP+/QQyzG?=
 =?us-ascii?Q?SY3FFESEnZgfTnTwxXA67ZuL8xfAQ9nsUwM1mwA70niIlIYGB9vZX2qp465R?=
 =?us-ascii?Q?w5HO7iD072HRPqaDjBqCVKtuNlK1M0C3YwkQb3J4brPdpplA9bEdgBOGhbkQ?=
 =?us-ascii?Q?qAqfcfjBmaquxZC8ERUQw9YvMKJBE3HTMqraS6dDpLqbzqBlhMayaEBhKjz+?=
 =?us-ascii?Q?oTb9UNWJCYxz6Ws6x99acfy6+noLUl4714lqsnv8PFKmKxqGSju0DI+Fbj54?=
 =?us-ascii?Q?5TovbG8ibaEi+P90DZr0GZ3utYuGce8+Xvg69PHHrm6GuGKZ/34uC+FYKAFO?=
 =?us-ascii?Q?85ahVrehz+hm2hDBL2tIedX79XwU02/6+mSOkyVU4SwBe5gerlryCzcN03iT?=
 =?us-ascii?Q?HaskxT/8kfIRkAZgnvNAoGTUdOCOPT4BtudEtIR9zXCc/wwX8HQNrJnGpwxb?=
 =?us-ascii?Q?177f4d2E6Re4NpN9xzyOWmMrWuUX8y7R2p7zDK1wzJP23n++et/29pAuzVec?=
 =?us-ascii?Q?lSRs23NsVXirKND8kalIIcTD0z/pHIk1kR5OAoHgh8GBCTNOuih75PuMNow+?=
 =?us-ascii?Q?FBXnjL2HpFGZmgMVG8meA9XwEmLt5++ivx7idTaVaZJM+7fbJzvEGfWRzAFu?=
 =?us-ascii?Q?RLdnAKA1Bl/pE/FFcyBZYhbmh6ZL/lO6U9MKONSHi32Hxj2v3/bV4nGhH76f?=
 =?us-ascii?Q?oks2xxgL6uwba2k2EtixeD/aikri7QxxtS/yM/kVZ7a4Z0sKfvn5aoxI34fT?=
 =?us-ascii?Q?Ei4KTX7fbnQFw/mqUt+f9SAvDbGjbTs+Qg/galDVLgekFuqgCt2h34nLvi7U?=
 =?us-ascii?Q?1wDWVsajn3fCMXWVix7WwO0bGZ5mFoFfOoDr+qln/oUGBTAh5CzQPDWRlcT9?=
 =?us-ascii?Q?9x122+mQwwVAAb17GxqLhw2PCzgx5q7RwaYvLzC6oFFOf2/CBvkcSuAJENM7?=
 =?us-ascii?Q?wf/0k+qqUaHEYEEHtKTHkYW6dqVOKHPf04ajp32fu+y9HtnBIOULanRBPMSZ?=
 =?us-ascii?Q?v7900brcFHkgRPzku+Xb8Dh4uZ9vN7BlPWnl4+wf/Cto1UgVtvOhreEnkKNJ?=
 =?us-ascii?Q?XCjoaFBG7/LiMFVTR1qVwgH8TXgcLrf7O8enM6FH9wr9ymcZd3fCCH2bCwie?=
 =?us-ascii?Q?k6xFwtoRBnMf8mK74xsBkfOtw1BXWoLfHucpO510gpS+6pjNcJdepxPPwcuZ?=
 =?us-ascii?Q?M48nK8Ydguw1etlrK3Yf69+OZqC4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQMWo/Q01+CnPdPnhS8XXu/sISHluhtuq7MDORtG3zXjOWMh/piUOAgmT+gu?=
 =?us-ascii?Q?94CgC0NFHGkeH0OtEVPZwxo2qLrgOw6ryOgBKddcG+62n8OpJdzWUEUXsUmU?=
 =?us-ascii?Q?oSmMxMKuhGHczEZDoFfYzlTC0EFtStc3QtugmHnX7vB5l8L1AO2swMxTh8Pm?=
 =?us-ascii?Q?B1fT4h3+XqLjzAI/XfmeathMS8rByCJiS3C3VHWZZCgJlE6YNa4YRWB5Ph+j?=
 =?us-ascii?Q?VbWIBwKSbyku278m3aAPKP4dsB63Dj95etaIRrNqFFfRK38/7lglMLE7XxAR?=
 =?us-ascii?Q?oo4RoroCFToJTGVPJyDsYpYbMQcSykXW/AK1bCNqk8x7KzHRVHeb7VMIA26U?=
 =?us-ascii?Q?bIEkxMlXgwG8CX9o6S7TRHfIlYf/uYhJXJaP6Ax7anxfvxtX0QSoGZjBX6n8?=
 =?us-ascii?Q?DqsrEH3VALmOzWTgUZmZHjY6JCy1oMHv2YFXP3wmRcLyskXC4hUM972BAFaT?=
 =?us-ascii?Q?706eMUqCVjbw06jmfo4N6DDqpQ8MnGNHQJpEZaJN9StdEIhSGsLyg42xePCA?=
 =?us-ascii?Q?EGYWFCL4L6drsl3wMne8i3K2kLYCYWFSLLmkUHHLtGm2G3MQjqQuBaRW9NWN?=
 =?us-ascii?Q?L4zHj2bop2W6jCtOkM87D6RJsoxmJ9GDruorrHi58lRS6an10M2U1jORfZJg?=
 =?us-ascii?Q?gO58wonpkxhYcl33pQl1AR+j2aFI3qzdx3db1CPWAee/CAYCWLvGoilOeVVz?=
 =?us-ascii?Q?RP0mxEanJi4GR8R3UtZ6XXMMyvV+cq5LikUTnGH7Y08PkgE94Tnva5q0U8hi?=
 =?us-ascii?Q?MOwjSwdlVNJ7wwrYvY+H9QvfcFbNwW8uZlxixIGtPg4DyH+uYraFzt5hJY6z?=
 =?us-ascii?Q?sXLzZ6TFAW9WuMuSeSu3FgNfIuFSN7/qhgywT38SGH0Byttcuy0KrNbhNgPs?=
 =?us-ascii?Q?k3huYR7/7z5AizGekqGYWx9fx029tErD1bcciDPCIGsa0NI0CzEdV+lg2v/r?=
 =?us-ascii?Q?5eeR3Ywo75QDS+iKlIsxS6ndZb8Ft29hyfefTGihINkYlEAmVQyeLRVrxnNJ?=
 =?us-ascii?Q?hT50BtoQ77rFGNCT9grsfmoXd90foZqF8wRhHdmMJ4ZaqbA3E+OatbLgDf83?=
 =?us-ascii?Q?cxQIld7vEGOAlgoCG0icXlVKFLdPqMoLdTujSQsWZoq/7HbWQDinEuog1eag?=
 =?us-ascii?Q?8a0z1nrQUkS+5CpTJ2H41FS/K/KTtqfVwQ9TzRAiZc8NlOsTc9cxYG8EQXC6?=
 =?us-ascii?Q?5qu3UUo04IkSQjSQ89AZiVTBKh8xNAY3EDCAuRcNU71bH7kwJik37TT82Q59?=
 =?us-ascii?Q?/EM55y1lE3brIPGUXgDM7vwIh/A80PLjPT2MtGBFfe0tz0b4x9M8X5Lxthbt?=
 =?us-ascii?Q?A7gfgYxojCpJWqvi0b4IC9rDPj6/u8ZqhihUB2ewGKm3f1QD80KGOdpdTtfo?=
 =?us-ascii?Q?Va9Cqd78CxQvMpZSQw9LyzB92nhkJvOsjpYNj7Vf9Z4GGUtFtAA+53foKv08?=
 =?us-ascii?Q?SzWOYD4fkqvSsGdj6la6y6Ber1IEcQafMGj16gNwhYkOklBv4XaMEMtPGKuw?=
 =?us-ascii?Q?FvNWTbWtbbmADEwEFE+n+09ttucoyQloZ8pCIRO9ei/gGnxh6GkvQsvlqHZ8?=
 =?us-ascii?Q?aR7YM8lx1X6+z9K56WZaCvI8dfG+48v/p57ZuWCdgRFu72f7zgL8c5z3rMj3?=
 =?us-ascii?Q?kx75wxsP1zHEoV6/yN0PQ+U=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e05d8767-ec01-4a8f-b88c-08dd1b40e345
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:39:26.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p6tzxpM0ifSZAE0XAzVHTLzbEf0oXO8vwY7X82KuL0ZN6naatf1NqKzn7TgteqeaDS+J40Zmqzpj/kbogPbM75XprT+ORoQ2BAiNlTPf2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0053

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
index 000000000000..e486131a27a9
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
2.34.1


