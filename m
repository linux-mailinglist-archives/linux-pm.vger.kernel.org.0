Return-Path: <linux-pm+bounces-18234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3F9DC301
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50101163767
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01753199FB2;
	Fri, 29 Nov 2024 11:43:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020092.outbound.protection.outlook.com [52.101.225.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4B17ADF7;
	Fri, 29 Nov 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880587; cv=fail; b=t6LZ8L3KAIbHTY+0iVn63+0BYx/lf7hPUgQd0ArLNtltGauKH3DZJW0fdxJlRlLpcbNSOr43WvhGSZgQ0IcAn1Fk0FNdQqHetgAotvKyWRnQT3M+EoQ+jVLVkkM8T6em0sK4MbZtXEDoT09xB5yJKGG/eIPgvO+GDW+ZaPjqix0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880587; c=relaxed/simple;
	bh=6X3Dnj6OjIAyvdJzCrwvNKPWcoZ/syWnsPRkA4Zw3Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSCpX2JkzHCTYTF7tQqDvEiFaCoBWXo3ur/k8OpMt5MMDHnd0G2YagFn0uKHhpaDBJP9rEJAS6M1gHm6cMyYb7Plus9sjD2KARtQAAtpm05MggOM9IqUKL7B9vwMHeartXHpTM9ZmjrGVMP2KeGE6Qfi6ZrXE0xrwoDqFMai2k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9fbSfCulyCsK/GyBU+LMKkj5aCldhGN00QQXu9dTnpZLc44ZZ6j2VgLN7RQvcJLq3LEC31wtJ3fpazUOqZbzuN189aS2OKXnUdioO6RZA1oEte+CGKfoyTmL3OE2HYxX/ADNOI1LKobS/VPntKjl/djnTgBlgWBhaia1hIoN+I2ZPYhI/e8X9R+x2/4BWNjolHRjC5VFm++qZjQ4ZyInMaQjnRjZ2Zh6UyfdFkpWmePA4/R0Ud20jVeFuNxuZ1oNIvEy+TcRvWmoVrOTKxs1O3f4G3ZfSRIXC3zmpKj2WjdekKeF2U4IuDsVGx7J/to6CMyjAD/w/h0eO1SwDBwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUbh4EZvl+66eGcbw+s+LGpb0O+CLLHFZURb+SZDcc4=;
 b=Sq4+WCsML2BcIfOqroqfurgYMu4VmVJpPXj4uz8TSuQ/IDE0kMoBQxlYBnihL58KyigDPmo1Y6xeSAX6GvhpylQnGSKwWXxEYzqyWxQQs43mJjMHX83sPn6zhhcQS9N60a+lHKDVJOZDdj3Rk8kdtRly25xca4kZDMHVZT2sRLRBgl3J++ySToHlslNH6/wIrubanHve6M5dQXdKF0Sef/qqiqshnsPhSN1Q7hMpkwUXK2IBXNEbvTGKzBC3VnMlxEiwS6GgQRCG+2ZzFMkWyumIFDzwI53m/8n7Myox9USqAMTmgfr31fBnOlvKS8dHQw1VY7cyEkwyHdfk2yplhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN2P287MB0599.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:15e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.15; Fri, 29 Nov 2024 11:43:02 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 11:43:02 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	krzk+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Fri, 29 Nov 2024 17:10:45 +0530
Message-ID: <20241129114200.13351-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
References: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:fc::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB1178:EE_|PN2P287MB0599:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1bd618-8fae-42b0-75c0-08dd106afb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6DSYohEo5qGmNCFR5EIqmuhU9aB6YKk605YRpyBVGhiRnaNxm1xi7ru4ra9?=
 =?us-ascii?Q?nAVx1vn1saOifA+/IFN/UM81UoZ901wdrj9nbLggibCDWlh0yI4q/pn4ZVtb?=
 =?us-ascii?Q?NcW9vbVnFWKMq2OH6+lDeSOJIlMGLVXa56ZHO1HkKpixuu36EbGoqJUsCkxB?=
 =?us-ascii?Q?0CMm4Pkzhblgo6wdgmHt2zJ9GrwikWp0VAtj7v/lszRQDhn8B36hiOk56fZ+?=
 =?us-ascii?Q?+jp7asUMGflFCZZYPOP1LccE0Nk8wlwDGxNudLPKKdIP4kJHhZ/GDPZvvziw?=
 =?us-ascii?Q?o+U6ZM8tIS9QFudmUS2X9NUeIQwSZAsbqgNrq+1boUsbnapVOWbto2rhppm5?=
 =?us-ascii?Q?LLBxMcO+uVpvZ8B9vbPvZeGXWr2YgHMNcGaIbua0Fh2EwFhaYYCIF7RQ+Kne?=
 =?us-ascii?Q?jYwJBRLm9kAiluJAcV9x4iqoL9rSXST/Ft+17H8ysHEQjQgAtMDWkGR1kY6j?=
 =?us-ascii?Q?xqwvPgdT5ZjEEZwP3P5ssuuaMumfEePEfYLsG1hmvXR8SbbAhtwQukSeaE5V?=
 =?us-ascii?Q?LERI9833QYWHI7goPO2EkGvT3+LAF8llQjUjo1EMWNjkSgrM7xtRmg5x/u+M?=
 =?us-ascii?Q?ZBiWjzdQicaz9Z4HkTjGkfB02HHSux6LFOtGBFR+ZaSjIC7/vy3j46zust5g?=
 =?us-ascii?Q?BbPFIINnp0i+4fr4fpxjnWKGwylHuwkSlzzXpX6vt7749yBOjAshBFGVPxd+?=
 =?us-ascii?Q?cOKmc5/H66NGS3IVJJkrmsxUzldj0wCZVdMfrcdoI2N/7RpYaDVMKyolgEfR?=
 =?us-ascii?Q?tYIt38PIUmIZZRFXCiJmP7S+ojcHcR9Cp9RhW81j8zgMAW/e8fEUdZYLFmpG?=
 =?us-ascii?Q?VvWA78+Ll5q4Qi4xJIv5RHuQMrDbElbKbtygPge+pRIe6nMuuTWeVUzD8aac?=
 =?us-ascii?Q?x3otlTAYgdvy+dea5SQtObD/5jUMi1VYbj7bjMYXbp9kQ6Z7f4o+sgCmUbSP?=
 =?us-ascii?Q?GYfS3jBZjU64R6HxRlUe3rDz8JAWAMyGzsq0JqO2n1r5qx2mDHSEYJga852G?=
 =?us-ascii?Q?bA8a1+d1X43m0wS0vkK0/G5O0MET1q3QRgy8YTc5XQ2/BMrc9AaBSde6cHuA?=
 =?us-ascii?Q?JrgAWiwfxZRKV9qZin6/QrsnRUcz5O6iumYx3WGZ33HaqxK+iUgGTl1dJzkK?=
 =?us-ascii?Q?JrBFvGTp5fSMA7oAeBo/etlHUrpCbAcGjrUa+sZtXbmr9ZzHknAKBMR20Rod?=
 =?us-ascii?Q?W4T8YXXfB0sXw2iPKz+2X31tukTA4cpO0LV4Jiyl/PjZQ9RRDvtn7lUcdo9K?=
 =?us-ascii?Q?kDZka1Ak5mIEkrNQYCEbaSWqpzvm9ynBtJkd4MybdVbOLqNo+1ICWULYy7Xo?=
 =?us-ascii?Q?XPv5lUg4no2NCJVBY1xm6HzAvALCTtLHbj7Cfsd7qcr/9NWq/lnUHU57e2UN?=
 =?us-ascii?Q?G4CFYxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fq5koiwXfj7m13k/jiQ0DEikTl+s3tUX8hl5h4xkVchonWZTws8FfsmIn4Om?=
 =?us-ascii?Q?d9Zwlg81jwmpnH96MIEaHDp5Pg9kxWbbP5LzA+D42bBVgy6F081h2M/TbAja?=
 =?us-ascii?Q?PcRmOvV/JvB2EDJH8xHy5GaU7/xq+iUsm72s8zIdsgItWgpWwfxG6rRYmsH3?=
 =?us-ascii?Q?QZyHKPCYRmDC75BrCncYBbBWHBGrE2OhSFKFIfv40OAJuvYDxNBVPo6jH109?=
 =?us-ascii?Q?IPuCdgl1kz7tCM/sOlNf/6pUQVf+1b15Cwh+SbBXLd9a1byBvDkAdABWk7wI?=
 =?us-ascii?Q?QoOPQKR6wioyMmGTexk2igWdNljP2Idjg8o9eq03T8FufIwQPhvO45pGFiLD?=
 =?us-ascii?Q?mL96P1FUf//iEfBQ0xwCXTl29TVHM7JwshQ6Q2TcdzvyTbwgU9uWzJQDilFe?=
 =?us-ascii?Q?k7EX6IFZfsbvUMpEBQZyfHhBCqvPNeTDNbOISuWZfIzhWSwAdicngo/mPbz3?=
 =?us-ascii?Q?HX2z/ykSU2CVg5URFzvhgemtEtpgB2ez3dTPQA9IiXl2TYXkp4/p2UP5BZdz?=
 =?us-ascii?Q?L6vFiSbcs5R0hQY+JR8dSpQSJjyacNSdID8ECSMsuA8dczMQdAbrFU5ER9T0?=
 =?us-ascii?Q?G2krln9OcLi/45EsSc0tyr0spe+QaQUDRCnprv8ESak/Dq/xK6fDcAsZTVHD?=
 =?us-ascii?Q?moB2Hv3vsmTECEA2p/VORPSrEt5bgPL1wokufFjK/yAnxZbNkHw4M97toEsv?=
 =?us-ascii?Q?jnxvcISMTVdYseyIpkiQPgByjZAE7Yup9dwacTQAHqkSYxur/LgY0QNqFA+4?=
 =?us-ascii?Q?yViDEqzyYM/t8tC0SG37dVkawgDOmLgf8vpFaQa2qMPTIpl3Q2dVLWUPdC8U?=
 =?us-ascii?Q?2zYd+iBB+nWy79wXCrxp2PMXc4FJxsYkROLWmNUXmgMI6rLOaYA3ziRIr3Ld?=
 =?us-ascii?Q?JLVB4zVmfoHyggnfNURI+s4EX/vjePKCwi7om3mVEJPSNc/k3OdEkU/AQLB3?=
 =?us-ascii?Q?vNoeYxVznvYvOWQtGjskrCCEJ+ZkNXC8KqhzPQsszrR3p7OZdNko/GCbc0c3?=
 =?us-ascii?Q?i1OeutR1B623TpxsW9aTsg+137zulmkGtsvvG4+ybijq+hBLbPoFuRPRbEoC?=
 =?us-ascii?Q?mCG+srWy0hPiule/bS6xFHnoQuhydj2ZzcH+UwPPNODpiI7gtG0v+ctVbjcI?=
 =?us-ascii?Q?NtxbQVF0JaeFSsFOYvy6VlVjUVxI65G1bCCiL2QWDK0hDlS6DQJqQ167KV+K?=
 =?us-ascii?Q?RlBEG3aX57StZEWpr6UKGKTmcvLhdNPSFF4PaZDBI/4r5c9Ugd0OJCLCADd4?=
 =?us-ascii?Q?AqGZUBMMQ72m9K4DL5aPWjaGiqllfkgyC298OSGkFqkipxDSTLyzGc+eh3C6?=
 =?us-ascii?Q?G3e71AG1UPy5PJqYetFB8haFHG63BMSme0RO0Evy9Hr+gb48kuwbW1fopXec?=
 =?us-ascii?Q?4NTex3jIQoRJ7SFK5obd0M6oKiipFkKln/VDZx2zyUdb3xmhMJYZuN+QpJTY?=
 =?us-ascii?Q?O9CTLOBWOgLX6wprEBSE7KT+8QqT4AJLQhkApEFXNHbMTBtN1bSR6dG1/0vr?=
 =?us-ascii?Q?FN9giNMvVH0LB+fNRUHqA33PMq2tzUrHgPCNqVaRvNnftBpwMsgHK0jO10cI?=
 =?us-ascii?Q?qCyd1C/2qG131YW9fdjNyPtDAHHAVGnNzL3PIbCiX9SjjRAh/JLOmw/DOY7n?=
 =?us-ascii?Q?hqtL5PMIEQVh2b0GMW2OlZo=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1bd618-8fae-42b0-75c0-08dd106afb3a
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:43:02.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jEUpQyKo2sJXS7hoEZFbAgGOnW0P9jIMtVQQYiftSt3GuIdfQMj1A7gFhzararWx6Rgakdza4+1rSEjQUoBWAqeYO7zRxDSKqczRJojbrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0599

The STC3117 provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 .../bindings/power/supply/st,stc3117.yaml     | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
new file mode 100644
index 000000000000..274e57be4bc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
@@ -0,0 +1,81 @@
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
+  sense-resistor:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Current sense resistor in milliohms
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+  - sense-resistor
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bat: battery {
+        compatible = "simple-battery";
+        charge-full-design-microamp-hours = <2600000>;
+        voltage-min-design-microvolt = <3300000>;
+        voltage-max-design-microvolt = <4250000>;
+      };
+
+      battery@70 {
+        compatible = "st,stc3117";
+        reg = <0x70>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+        monitored-battery = <&bat>;
+        sense-resistor = <10>;
+      };
+    };
-- 
2.43.0


