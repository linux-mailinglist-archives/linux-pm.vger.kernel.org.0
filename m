Return-Path: <linux-pm+bounces-19511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3A9F78E3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B41F1893F3F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31C1222580;
	Thu, 19 Dec 2024 09:49:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020089.outbound.protection.outlook.com [52.101.225.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A070221D86;
	Thu, 19 Dec 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601782; cv=fail; b=cXF29RmcmNa0AVjizRt6bFwFVPYwTbA6n9FMbBD0j2FHSuv3iJxbLfoTnwA7Pdpgu0iHjj49l5yGF/I9acTTnJ1FYpuGNel75x9DNPzkDpNyOhIbbOG0CaslHQaQbsZwxBGyCjzGbejBHR6wvQSgNTF5j1EpCofGhszIIIweJDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601782; c=relaxed/simple;
	bh=DRWGgBTQhmElipPaBAZu6qa58ut42e7kPONlbpnjIiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UD/bDmXUpUXAG0wRkKRPFyUZ/WoGuzGT56p2KXOvXnjRD8jMe2JkGXG4cm3OvZENcrJH7u+5tjBO66dbRadci686W8v/cU7G6pBkCP/N1390EYWDiJE0GCp2p6Zzzhas8KrQxNyV7ogdoptdLjUzwTNTkNaFYprqCQULMDPfV4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU5ewIeo/YMAtiHW1nYWoJmZC70/zfsv9KXu03Cs6WyVdCuMLBe1ZNsrDdl0qDk4GUTMDV3NQ+Un/0JXqBNqqwPxH9X6w7L3tiv0vpXHFQ9bULEMvaft7cHnmIPyya6aCTowje/YFQTuVnmWA6OsUEcqCvZzf7p1YWB3TX1ZjXV3W9PO7PzTf8qp0F3OLtPExH+7IAuHUlq4tPeLYmNzEXvPJEY6WOcCHfHPwV8QqB+FyG/rp0z2Sz/gkRWVrNOYusU3OxeCmlalt5f/tZeeoF7RqpC5ZTTmpJdYNs+ZxbttW5E5QAZwjrVxC9NsNyKPZP/vPeRxcEx+wGNHCoOLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCm7ItCw4wPMTrI2v9hR0Md+/nl27Vc+gRCSKPCrad0=;
 b=hTRU4a0HFdJHW9SaKw37DxOb6V6Wg5x7MfW9KLvSh/BrRDxnM44hDfuwisaqel/I6pWBAF8YiDgdx3EQbGoOIL8ga8qG4rbqsn1aaCHCAy4PT4aIljMd69LD8iQG7M168L+7Xj2dtcZJVvR2uSy+pYKKkkAPmSbrGCbYcgUyTxk5CWwIYG0ZPvF1nvYv+i4dC3gq2yNqAMpjS1mzBEd4DD2J9OkvNe4/Q70JpsQRnb0Bz1sejZzkFMpOpxUFZhNwEq+FKkCTx9mnVj/AW9fpqZ53/31MQzvFNn2aMpiWtXWyj3md7KSZpehZ1I6RQyqsJeSct1SKan5T2N86KCpkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN0P287MB1187.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:18d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 19 Dec
 2024 09:49:39 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:49:39 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Thu, 19 Dec 2024 15:19:11 +0530
Message-Id: <20241219094915.19059-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219094915.19059-1-bhavin.sharma@siliconsignals.io>
References: <20241219094915.19059-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::23) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN0P287MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d10263-7960-4bf2-62b5-08dd201274a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JthqiVPGHE9cAwvviKkTt+sKsMvFadNMLZQf7SJtxhldUmNe8THIEZPevDwR?=
 =?us-ascii?Q?FSKfc5QXV93QboHXO1lr9epCIsSnbV9ZTiVwg3oIve+10A8jjH6cMzK1+C9d?=
 =?us-ascii?Q?Vr1NEZnjpe26oNcem+2klVmPiP2j+DtdWN/yr9Mc0Bq9yvWMNgeI3UoxdCRp?=
 =?us-ascii?Q?9dsCGvRACw6bAaiYDYjD5MyFzcAqaLUbg6BG3dxJQVkcS6+VIonDOWHvNDZ5?=
 =?us-ascii?Q?SvdoJRISllgNf37Aam2ulL2J/TaoboTbMKjtUGQ3BJX2OoyIvoo/PZDr5DJ2?=
 =?us-ascii?Q?bmWYSYXfiuOoVAFv0FtJfGebpxatffiDEI2+3I8NrV4U90o31gJ0X6R2bUu5?=
 =?us-ascii?Q?BHM8xNp8eUW9fmiouoWK89GhTj9npODGFcWffrZIG3w3hafUYz7J6xnhjhAg?=
 =?us-ascii?Q?SIa3vOgzD5ujpJ0gXhdMi4w/FRZcWQb2IKUfQ1yaqiYo5Lnn4OOp9ELGFWnx?=
 =?us-ascii?Q?JZqJNxE5OL0oQGQwx9XHBIjaypzR84Ql+VyQyfDz26ROJS/y8TKD7hRNhkD6?=
 =?us-ascii?Q?vsRWcREuaZWjsoj38+Xd8WL2G2ILAMBQ1DLb6Ac9a2rbJkpUZAObvydSIM0q?=
 =?us-ascii?Q?eK4+yPN/csjm5sQVdzoKH19/AcHdG2jyj0WCp20fX54kp8NOhgjX93+N3RUE?=
 =?us-ascii?Q?VmIw/uZXAgEmShXM2a6oGUm48IUW0a2IoxGQDkm8F6JaSDP6Xa2mejeT+WfL?=
 =?us-ascii?Q?22cdZOmvfY2mzLU7aKZmgUaXIU7APY0gJSI5+LUHtCVOuJoghNCYMJMpqcjs?=
 =?us-ascii?Q?CeT0fpOu3c96Uma9043sPfixfUwqaMnxD17hvBTM1VdARjYS9iGO9BJAgfdj?=
 =?us-ascii?Q?RRGHqPxdvTZebxeLBq7ctmnPFi/s7KDs0lTZNp9CcZ3Bt2D2P1EuvbgSnqwA?=
 =?us-ascii?Q?bFVkPQ8PTcinrV749TaKGCwWvg2l09c7Hl1OM+kEgazpy/DTl9Fpb8BtqRla?=
 =?us-ascii?Q?xXulBraShRtPoToHeFViqy68AnXRtHT9nJgxJrNXxNyQ7M9XfCU/hmGK4dvK?=
 =?us-ascii?Q?JIGIvPcEQ88C3lW1fZyD24AAYd2ZbvNWGJbjufnIJT08Sj9XskA91lB8mgTb?=
 =?us-ascii?Q?FRwkUPWmWrJSbc9PFdBdx1OxWmIkL05tEypBc/zGvp2iNWYkVAPFuuWUHlbp?=
 =?us-ascii?Q?v/GoyNHiVrBptq9yQz+G248v14fLJYaqAZs8lTelBulHwX1soABmcfDX7oTe?=
 =?us-ascii?Q?4IkBUH8m+PTBaDRknVLIRcnu85BZgMFvvL3+KZglp2fCHeFhlRJLlmU4sM6/?=
 =?us-ascii?Q?uRFwWjFLOZwMoZKDHTf3gj8JLkOle9ZJynu2tJ9eGwkueMFx4RCyUbX/nkhg?=
 =?us-ascii?Q?0epMbQwRgJ79LEq4Gm7NJtveDVG43TXtNpOdQQkIXZA/sLVyVs9VpLdWoGw7?=
 =?us-ascii?Q?afQ4mGGxnPpsmuMq0JaBu99FCuRCkb5wZxVSRVQPBKk/MA71WQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OzENtH5u44HD7QDKD/kbxjUm9KvBM9xSYlh6kq0zcCA5qYunpYhf0TzM7sQZ?=
 =?us-ascii?Q?Kor11QoQnSKDYo7q/h7eVhiOIN77sstvKe6G/OC1uhDgV532CQgkC5bhzgkU?=
 =?us-ascii?Q?HPHgdfbQVj3NGex1aNc3SsIULzbsdQ4LNCDM627Ujh14HBd3Z6KEAEdju9d/?=
 =?us-ascii?Q?rfqQP86g/+ZBNC4ui7TzAXP9AXJWAtvcU5Rj7JHIDHfUjz7adeSqCdobX8jI?=
 =?us-ascii?Q?zsYcfNmnf+h96ikyshEB2XYzIPBra2GWWKfQtUN8dyvcq4vKLTbPbH4fvdsA?=
 =?us-ascii?Q?rqanqPCvqp9MvFjaTCAjWnmR0K1nSVxzCGrSabUGwCOGzSjxlDDlgNgWe6oK?=
 =?us-ascii?Q?saeWIdq+zcX0GTXIIUP1WdiH4Na+FPguJUwBzDvDEzL9rJw6b8755diUNQXh?=
 =?us-ascii?Q?x0L7Xee0sJnByv36l8HCaPJAT+k9/vlL2WimzLbqmn2l9y7gb+1h3M47DNgv?=
 =?us-ascii?Q?Oa+hESPSQR2sda9GHUfRml5b2ahpr0zAVkANcynz4+uOMeJjvCdk37CMGpWA?=
 =?us-ascii?Q?PmmBR7Ss6Ys46nBZ0pUrarSzn7NF8vs86UU8+QzhMm1J7jcQ/OhJyb5co+AI?=
 =?us-ascii?Q?EFTw1FgbF9Q5joyWKDWLo/bQu5/SmDjREm2w3shiPKu2Q9HrpVeQe2FQhyec?=
 =?us-ascii?Q?TsedV4qu5tS0pXMMFoEolfIjKVEQapjvHN4HEiRblhJ6BBj0bwKQBTIi3Tna?=
 =?us-ascii?Q?ATPQUEhJFurz8s6NElEmf/uWpZZAP5+HxkP9L7x4wSvUGDVRrMsqTBOFXvq4?=
 =?us-ascii?Q?q7BMXyfVJlGKRTDgkB0LiCbSAcDJpExaLjzsyVD8OolFRpn8w/jDZInI0kn8?=
 =?us-ascii?Q?6CnT+N6aYDSqV4kvf5BBWxU6WjOC2VKbRcjSoABD05cfpD3cAcFkfEpz1rUm?=
 =?us-ascii?Q?V30sUQO8jTi/YrxD2QabvEwsTWQskQF8zoIua/N51k/gtVfkpH1u0UV6CKJX?=
 =?us-ascii?Q?mVEVRM6nqV6J4MYeVmnkVZ+RaKAXzUoW0KlUkJTGtYt5ka9+45JAVDAJA0o7?=
 =?us-ascii?Q?jChd7561GbX7t8OXQT34Iakn+tdfR7L8a+Xxptp2TpGuKS54h4VuT/qR4kMo?=
 =?us-ascii?Q?YSwOwSX13XTQcHVqt8BM52hYinzDTa4Ouu83Nam3SotmUpxEIlDq9o1WWFW3?=
 =?us-ascii?Q?w+FYXFmZpqdrlSBNuYvhKg8oDN8ypUma+6SHgNZk3KRj+gInQK9x9EBc8jvz?=
 =?us-ascii?Q?mDH3gVGjHm/BOVZkoleQkbyE83Yunabti+O/hbrpfjh4HvxMWzkQMintaAkk?=
 =?us-ascii?Q?w8UfuGIN6BANX1VUaIYn1pcM9iqzPcR3nSQvBeBwYr5wiUOiyp6NeQHPgAs9?=
 =?us-ascii?Q?67y24UPzfutlhsFvq1mnVLQH+pJf3RcQJcohy3eLH9Heiq8K81jK+JvGmYlu?=
 =?us-ascii?Q?fhyZhPdRMebYStMQNY/HHQ/DZjLeozNWYNe4cGImpWSVsZUO0KW5UHXCTLWb?=
 =?us-ascii?Q?bl5eTa3pvrN2KyHnexDIcGcPHzFcnN7WTHCd6M8dO7znwjZ6ircVodgnK945?=
 =?us-ascii?Q?aMxSF9QdDutnP8s2yns4UJItSvEAuHkKvNbOPZ9htFOC9q+RbY+/+osGxyH8?=
 =?us-ascii?Q?62HNOzpsjUj0AwA3kNUgMWTGg+l0eechq1KilBxpePJ9P5J2lLVHygy/BpKJ?=
 =?us-ascii?Q?BmWw2qM/RcJQR6ntclpfTu8=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d10263-7960-4bf2-62b5-08dd201274a0
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:49:39.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHuKQv8/FeNG0ftDuW08BlCB0GlvS0kJcQjAhQhEohqhZMvFM9EyxGDEiS9idXlejDLmsujOTWL305DBJKrQwMgvy1VrSavjEXQML2D1xyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1187

From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

The STC3117 provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
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


