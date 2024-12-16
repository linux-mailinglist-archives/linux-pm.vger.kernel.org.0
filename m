Return-Path: <linux-pm+bounces-19279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A19F2AB7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E3718832FA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC131CEADD;
	Mon, 16 Dec 2024 07:08:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021140.outbound.protection.outlook.com [40.107.57.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C21CEACD;
	Mon, 16 Dec 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332917; cv=fail; b=QPVeT9uPzqZOJucymnANsnz902qDrtYks3AwDbN3AA7bofWYCP0BU6f5dgQ0UFUsP2UwIGJec32Th5lIUXY4C7OJh18L4nxuoAHOVCvtMebxhuVII5oM/cfXRhbggWN41zNvLM9FpXhfWhGHWQJmNe5N7HaSi0hD3Bj8LRRZ4XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332917; c=relaxed/simple;
	bh=2sZIu2wSK/jV0Q6WnuQbc11QqFn4dJXmYh+fs02ZJ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwSE03Kh5kyNhxnmbOBgS+K3mt5kSvJiv41IuSZNjZonTz4BM/1HxIefZfrmsmPTzgurVVl1+QmmAMjJnvffNRWtUHCPGp4KQPD1nAxM1gAwN2q8mto1mComMebz9IbAT1zpSTmukLY93413xOzbymmr5RCakfA9fPCtoinX4H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z82e1YT22AejA/P3Z0JRUUXvD2uG5YP3ysWRrwVpkIhrd4NHS46SDZXyfM6ZTGnPmFeuuD6jzR32P6BNwCiIaIwaWD0mBCFEioRKSJkWOIlzdzIRr9Shnf8lOxO05L7EBCyWsyQP8HzCDTNVeGuqF0KG1EFiLxmUxdPBcB7dzv2sr90RJQ2NYmMYxwq42C0zPb52hx6R8ADLR5KlYOJmwDrwOjDeHSbKv4cRVvI7DsaQe86YEnOWrOiLQC5P+7mzT3gEC2VGgiw07sF3fLOIWV08lvjc2+ehWwuLCF3241K63zg0SuY/2Dq6PR7rMVKyxqyt6O4a/OooZOkar/BRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm85JErofHNZMfKRIe5qRisrz1HzeP7xttjqfiZc1y4=;
 b=vbBZg4qeK+gKmygRxn8itSCoLMgB4vjvu9A8DkcWHsN6wOeBru1T6QdvJelqR0fdPskIAuMycI+XanXw+R4AcrAj9Axiwe4pIAIT5rwcxe0zO6rE6JM+1x6vbthrStf0mB7gWt7W1Iu6A2JlBpcKelZP7vrBFp7kJUuXKaQkDKjOxd3Wo1/NZephaPsStJVMp4eTN/x/GVd3y7lkGIcvelKN90Pf9qDBvnjrPPwilAf8UgsyHM8nbNOui9JFV2fDH+epP0UBFYWyknM099rCQB71M/X6JP1WlJEXaDtg5H/jCvQr43XDrdmTnkv/c0vMv/PLcN/YedigUCfXrKY6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN2P287MB1855.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:08:31 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:08:31 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Mon, 16 Dec 2024 12:34:54 +0530
Message-Id: <20241216070457.8083-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216070457.8083-1-bhavin.sharma@siliconsignals.io>
References: <20241216070457.8083-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN2P287MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: af91e019-f212-4b3d-bb72-08dd1da0726c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cX8JpSmzX9EFBmC6KPstWGYEt3GRkJeQexv60QvOu1GzozUf+pQThX12/YNb?=
 =?us-ascii?Q?dzoVE8660bUJSiGl5gpoxAzZcYDB14q15CYHeaE/r1reTWfl/XCZFrMjio1P?=
 =?us-ascii?Q?1Xgw/WeamB4vyDyiPvuphYsUU95WQMrnKhJQhUjDte+E4Fe6tI5lK1m8DISx?=
 =?us-ascii?Q?jyWD8xw+OrI8yowG+2xL9XJKxCtpUtqIvz7F5Bd7BuVb8lJTZOqjz9xLn+8I?=
 =?us-ascii?Q?0AF+ZGMdehA8rQhTDN6qI84/J4KojHf7Pt4TuhUiNbjmdnsqBFiEAjGu9OpQ?=
 =?us-ascii?Q?myF0Xd5jyZ60zeUpj037WH6zzIc1GYxW21HPH2T4CAwrj9SVRQcdKL5xgEQf?=
 =?us-ascii?Q?Ddu0cJK6nIEGqazL4O8CWqguW1lMZHPZMeSS+T+PszkvpPOT+tpX/96lgSzO?=
 =?us-ascii?Q?4sjvbJrrMWbey5mYYyzFJZQi1OhsYTw+iylrzWycagPOp4B6ZcEAsAKOFCrV?=
 =?us-ascii?Q?uTweOtJo8/B6VaOMmludkfBfDUL/0SgcaYZywp+e+wXhVsG0V88c9A1a0rRQ?=
 =?us-ascii?Q?6u17VJdb+qhCMh6s/uhjqVlPJMdKWIh+rRuuflBoeVMc8s4q6HcatYP0VDnf?=
 =?us-ascii?Q?lmP/TH7m422GnvWYKLeoCXKLFEZnRMd0AF4EKYOeJzhMpWX9r1UBapWSD1ES?=
 =?us-ascii?Q?7iJyIZKuehlXd2Ifx+2LbjBEK6GMJiH4qzmg8MCpCO9R5lUvNhz4w3JjyALO?=
 =?us-ascii?Q?KxbJezQuMx5GKYoEkkaWAKnK7duhhOMV85w1cVMLgWbGLOl4yGRiLp9rvSLt?=
 =?us-ascii?Q?+5kMgXS+GhPqXHpGgGWHxaPQ2h3kVkPg+nT3RIT82dxTyZeiXzak30rQ9z/J?=
 =?us-ascii?Q?7Qkn2a8BvofonDyIUubhNUDsoaZhBfhkpNkzsuZCNRkhTI2XWyGFJG0CEDH5?=
 =?us-ascii?Q?2JouARzTWsj3907EzptNtsKykr8q0/kfbC+Et3zJWpj/L8WCmgl+myIQH/TU?=
 =?us-ascii?Q?vKwnQs9YyDCHljxS/q6IUqcdr+YHOD5es3aVmnpJ97e9Rdu8Nh/n+iUJviL5?=
 =?us-ascii?Q?gbH0TTbV7SsQ0ANDS++7kEPS7W+7u3NHFhOzc2POqqqhHJjj42AvTVZYOre8?=
 =?us-ascii?Q?QFza6ZKeKKqauGZXNxkDhybSAvF+Cvqjc3JWsksaBKur6tKW3I7pbc/5AeJ9?=
 =?us-ascii?Q?BL3gOc12tNwyxJfZCNNRuh6YvONdxj8yCavg1MWSh49/zA9jTX5OA1r6dguI?=
 =?us-ascii?Q?ScDlv3YmGzpI2YCpXwI24TWA48noa+0jW81giZO1B04vumYq5mYMXz55cQth?=
 =?us-ascii?Q?0Ba0nzitdgtpUGMcPcWfdU5nVogpiM6n7RpRtpmCCKe4LC9ffpN2+N7r7/+i?=
 =?us-ascii?Q?0A0v/xv3MTkOi3gJW+6E3C98N04gE11z9KBcdrO6zLaBnTZZJyJv+4gRsM/e?=
 =?us-ascii?Q?CVoUI5GCYwb7kTP7ZT9XColbwACp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyUFtPjnR+aMR3LoYf5DhVRio/jAiWDPpW9MdxOOssogCz9If9fNdixK/ztW?=
 =?us-ascii?Q?MW/8X5Lv8V4seE9OktIx9Be+f15S6orhRwELWn0faSKvKbmO+VJVUMHv7KHF?=
 =?us-ascii?Q?YDw2dTA3IdYGidjHe4em7pjOJlG2cq1h2ivXBjGkqQKqEd6TT08tPuN4+dbI?=
 =?us-ascii?Q?u9I87CQGBT/X7Sxmmbne1I8Q9g7A4yp6MBcbJfo05a0m7cUvy70nLWMrkW+f?=
 =?us-ascii?Q?4FaY5YEEcbKPUeNsqhdGHrxPvK3FlQ8mMgR6+ndjlL8Hgcz0ZPXgocoCFi2G?=
 =?us-ascii?Q?ESw4xEECA8BQ33ZBXA+PeQH4f1Cf5DuKMzqmxdB/ImJCs9HdtlbZDg1JzcGW?=
 =?us-ascii?Q?CD49Ab5zSAyRlRcQCxH9MUSw2WvCATOivDXi59TRRl38IbyGCrb0gU8cIEvH?=
 =?us-ascii?Q?cLVd5ySc+hZjmuBL0+lq0CYSchfAt5WqLC3Z7SfBzmkeopklzuY+XqDH44eN?=
 =?us-ascii?Q?+ZrJ126GBFTDXBHrOik4QJNyIFbIoim8E8FX5jTG4MTP/xeHXuV4KqOgToaQ?=
 =?us-ascii?Q?/pLX3zQQ7zM7/qH71J/yFRXLvjr2WKcJHJRg9Ee/4Nsk3W5WvsDQtptCZTJv?=
 =?us-ascii?Q?NzeYbl3LTWQ+sDonpxcZQB5+hNC0n9+Pw2xQfkPzUEo7jmyx22gagObwpg6E?=
 =?us-ascii?Q?BVTe3E0+0oLejTRG54ekMYyqsAdZtTFzfG6A+lYgwHrt+cSnXtsQRie4iM9f?=
 =?us-ascii?Q?h/2bVUf2Mi8siTHhrDHMmWnu1iGHXI73BoTdxdhcRzj0zHVL90mxeOvvfLAI?=
 =?us-ascii?Q?dAkuAlelnqF9WhmegSM/+H3TaW+SUczpXchnr7Dv205lK2BuuqXDxE+Ib8ua?=
 =?us-ascii?Q?7W/0SqpBKCZW5FaUDLKiV3Zf3aE+E0IGkjIxv6zpCwYPVC9VIBYJcC+nU6It?=
 =?us-ascii?Q?6K5zMAVag6bYiVKUX/xdDTd8ykl+8tIJixyPIXFE9rQPtb42+PadOxgxLqXG?=
 =?us-ascii?Q?aRsY16vYkI4zr6+caMmlD31+C7Lq1uRO+lzvLi9WWPoF+bZIP4+1KBXqDsik?=
 =?us-ascii?Q?rFQqvVSMVpvr4AMfQt/1x59Deb31B6JC+67HAiKnkK6x53/mGCrsbBpwUSbp?=
 =?us-ascii?Q?j5eJacnFUQZrkytq46t5zYORxl+9haF1HEg/iYcb75vg33M7JelbHT51Uwx2?=
 =?us-ascii?Q?k0uczGrzhyZZT+6vZ/n73K/7Eo8CM+qCDb1Mym69kNHxsmCUiodXPA7hSqir?=
 =?us-ascii?Q?MVVGA7SQa6ohJwzKLB9RldhYavGKjokpdrKC6jrsHLElB2uTltuHKaPp06lf?=
 =?us-ascii?Q?HZHN/xk+3Eau57tlqG96+4kuWeeaGReuiar9HgHJKCAX+AxZEY7UQdiw57Yw?=
 =?us-ascii?Q?B0nFw8d4HT5sKzgCuZljlB+Xts6IyuZ8jSMmo+Q7cmPOQ9H7CYbB+2RQDbSU?=
 =?us-ascii?Q?evMJNs5WJs9vzVSRquEVGsrLffsxja5fX+h9DhzaZ6976qYTsdTfUy4pbwIS?=
 =?us-ascii?Q?DIFctn54hUeMytIkg/h+hPlGe/AeGP7Toh2zSFDVtTVHnpqGFRL4F9XFmZAw?=
 =?us-ascii?Q?hICWbwKf1KLqQXt5azmKM4yjcm7e3TmDHr+O9ALmg9XABS6fylKjJenMqaVp?=
 =?us-ascii?Q?cjgv2/cLx65yerMRgPwgvzQ8gt54qnNnaX88jDeyqWCG0/s7ufHYRbMDxD1G?=
 =?us-ascii?Q?dt7LA9NsrT7ca3ei6NSO5jU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: af91e019-f212-4b3d-bb72-08dd1da0726c
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:08:31.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKxyoRXF25cEYQqkhr48Jce3e91ymJK/xgA5GZg6K8uOJGCV8VIA4kiIVuqLkkFskeru7o7LE4gTDcMtOBdpBNtCW68wH2uKXpeFwABs8z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1855

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


