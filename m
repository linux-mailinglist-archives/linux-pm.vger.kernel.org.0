Return-Path: <linux-pm+bounces-10326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE4923A19
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4387281AC8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6915530C;
	Tue,  2 Jul 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t+IBEey6"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2045.outbound.protection.outlook.com [40.92.107.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991215250C;
	Tue,  2 Jul 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912671; cv=fail; b=j/8UHSWxdj3s/RksC8/qn+ACV3oh+UgM1dy5OQQd14y/zZDoLCrtn9SUbxZwNoQewkiMiaQSSr2UBhVCyVW8i74zO6JOQIj3XILIa2BGdMrMWHK9Pl8NkOHM5gV2Xm53NCrNVuhnbitRZNpf9rZnZCpnT4EQq1h6Hxo6NeOE1j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912671; c=relaxed/simple;
	bh=6OPz8fRAL/9aKdt1yqlxOIMb3ox6wMg0b98ZsP7keeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOjp7i4iplHnTSRtbeF+DuwJrGU7bJjlMl5uNeuxMUMIzAb0psDkRoZ03hx1Q87HLTEIqH+R8+HseDYIt0RJWQGddLBSIMQGtg/0rW67UfV68NKbABRXSnsProqb2nAcEDbTZJY1bawAQeHR1dbtfVogmhQNoFOe2CUPtkG1AYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t+IBEey6; arc=fail smtp.client-ip=40.92.107.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSwluto4wJGh610DovNmUVoPUdiy8byZoWcGon2jGe/dsZpadOLRq25o1Xvvm4N2lP33kXVtSqaR104blLFy3m4lH2wx68QdCOvRAeGjDB2bsIIcnhI7mj8iLg53+KQD9WY+gSa+oc620wpKiqk4S7HzxwLjBeHPo6g1OX74XM+JvXHpd+LkA1WHT+Leb5Y7pM0zaGx3/UwrxBwb15DckEFGbsjMBX17O8f4HPWKU0NSPSdK717OTBO4a6KXydXi4on/DsFdUwwy0x8IodywJBUFIWc8LUL/HeKkreZUcc5rTPDZJXGReWvkxZT52swQTV3l58/iZJMVTizTGgVmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HdbQjWM+VEKKI2HTVCOdOkUXCd9mQc9QGFddL4pYnU=;
 b=gjDqBRrU54AQkGrc8+ySd9ug6Gk6TiNBoCXB7aYAoAvJjblLG6HiwuZjvVT9VLyj33QcPWPJMyK9+u+KphK5miIA/oXtldhh+Z7oq5LFwjLSEtl61R2Z0nYK8z0d8TFXITKNrWstG/pIKfO9Vxvh+x4RDeOQ511au87sjsby6vltCQNpyKs7WQqv4I/9mK8yVqHD0bTFhDWTRYV3qSRnID4h9zW5yPzFGchoHacBmKVxkCGm6DfFY3x5bjrR3l3jyU/87dP2FBZ+/gKduGywb27ZZUkzfyKCdoCRiFB65/7ad3Sl1+vi8ogZp2ZD/z3sVCqlHMzoiCH8NXlIYsoD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HdbQjWM+VEKKI2HTVCOdOkUXCd9mQc9QGFddL4pYnU=;
 b=t+IBEey6xbh6JUQdzp/jvqtK1+ba5ClmAXAdiwUg6lcW0WdfwxSJ628ClbTYdtO+6qqDlCtSgbVMUIDixvcqZ1Wi/cJOn25tkrBhIVph4AfyIMOm93t9/I+y84m3HUfkrlYYgxbxjgCIm0AK7pHMA3dmJarHUieO5Xu9t6PoHqZg1W5ten3SaOIIw3gJ4qEvX3bfVOhm42g/xiJl3iNYV3XtiRAhI6PrC6JD+6EQEptcVmzhXNYTWvZRMmhXFamQVb6SqeunS7GHK47imENQVVvY8G0dVkxDmPvNsJnp9NHL9Sg6wQip58GSq6XROQrlQJb1FsWns9iHV2X8zujxfg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4613.apcprd01.prod.exchangelabs.com
 (2603:1096:101:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 09:31:02 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:31:02 +0000
From: Haylen Chu <heylenay@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH v3 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add Sophgo CV1800 thermal
Date: Tue,  2 Jul 2024 09:30:24 +0000
Message-ID:
 <SEYPR01MB42217228213F5F2C739088DED7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [17i62xjFeVM3yHP1oYezK0i5S0kz8QCo]
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240702093025.449-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 57056f5a-ae6a-4841-7d52-08dc9a79b0a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|4302099013|3412199025|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	rBHyE6Q+GmxLwaomWEYcX3NmnZk5Gg7HtR2pDGPc2rAmyCcZPyD1OErFUYyMLMkZHqRvkcXIjrNoEf684G/cZwSTUDZideskKiYR17s/LV2Q0pW/y5jIv9vDnrEk6bsa7ClU++cDP/rziKZyJ44tztQvKhNkwIHFUntJ/eNgi8b8PuPnPxSgVfIn8xz9Cu4SdKT3+wnnn9GGOQ2T/RhrtXIc49Oq+H5UUVmIgq5DP9oIlI2c/O2ydoJFnfEhSUm7cP4jn/9CqdFuFQckz4BpHKxd9Xgt9uhDiksAEnmvvgBS7vv75Ys4Ln9wzepY6xPLFBRcYNCcRcXVqx8SXL3ZRS+q8YgMBuFNeb4aH0kXDK8335E/Q7pTl1q5lqSLnQGpOv1251duL2nBhzElAcwsMp09NIPdO07CtUywAmGMebh9GDBU5g18P2JQkbzjukGxcozDbLuUSRU9zkvYSrUUDzmZLCRNwqB1L/Db34qjjehfqweAlup9zr8/8tuKYaM9DIlmEgdz2mAMjgQNNmMLB6lY3AgCvie4JQriOpe3A21uqUTAzjjaSCb3PWGohffKHUiyRpmbnmhnrtdivAKTuE+/hjSY4wfF/KvbZ+fWuTOnU/XFCtoeqgPw3B2zPDrDWQKjy4Ha/KVORLlCD0y1OBqQvAF029tRHT3UWt1rDJCW6r1auvUJLz4uSXstfwRgWHwnXL4JC5d2OluU6JOnzAQheKIsUyTftW3MTb4PKxRsjHHtpGDk7pqeVaXpXmhGs/Xv97nlw9dh9ePYPxZTFg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0zMDZw7RkYbA48QmWYz1waLUtvaHwzbXFkczUhn+SMKf+C/JJUlhq+kXyPc?=
 =?us-ascii?Q?QaQNEN5tJKpgnC4SbETt4O9xg6TteOOswN1WGr+CQN2URnT2PYuRN7y33T5C?=
 =?us-ascii?Q?SosMBNMzUxActEicAgnMG0XknXc6rw4dUOtqYJf/4QMKIb3aNl4GT4BAZtoI?=
 =?us-ascii?Q?rISxZKEr8aVF8CpOGgpAB8dL9vXdNlv2fMGHYPjdVvS1ZUI9Q2e7e4K4HppI?=
 =?us-ascii?Q?LzFP38v2jVX9ouHe98bgh3PuoP2UO6kkyo5trTLnvys6KnSheCeqrxSUkUy7?=
 =?us-ascii?Q?LkKqaTqJF/7iNH3TOHNqhVx+Ur4p80uEiXNyicQVXUtnn8ULKHxfZqlpNBB0?=
 =?us-ascii?Q?UAsro5kgCYEsSauUNwm8Yz04k+KgiXdkeb2EM7dFwESJBSFIO6lvcwzieqCC?=
 =?us-ascii?Q?zWTg6NdBaR38qOagbz17RG8YHqxqBXa26ZPkXD5IsM7pa1ztbHqXpcFe/oPQ?=
 =?us-ascii?Q?w8G+obMMVjXpucJ/JVetVrZvCsoFe94NhRasSDluPh0rXZ0m78vzdOEP5yA/?=
 =?us-ascii?Q?U7EOEPY51BAFrk2OfztJJc5p9eigEqQlVqcJ2oEmydBJVa6q9KF8H2toF5Ug?=
 =?us-ascii?Q?GxeoIyjOeesZzwda0LRXIL7LxCWy7myVfdbi2nDAaZlry+y7XtCj/FwxNRmF?=
 =?us-ascii?Q?6rEScg2Ln7kAOtmiaKn/0srpxkG3koatqbQvpVT8/FZ/FIlKnxwk4leUcwon?=
 =?us-ascii?Q?f4M4M37bA2iwpTYmk+lSbyrL13YEBd63XioRzj9YW7HXIpZ09rcNlcuJ3l7V?=
 =?us-ascii?Q?k6IPLo0rNrMy2MVZFckv/QZWq97Hz59oXdfjpUEDHKATNPhSghBqGlQonOF2?=
 =?us-ascii?Q?hoCnYK8gohDuv9Vwbx4/lX5+mXju9mbAwNsof2Wqdt8kx/XWXZg2e1bk0lP0?=
 =?us-ascii?Q?QEi2p2m9ntQbj+FQO+gzY3J+BER044M8tCyZQWWboteDiKhjj22k1QqcBt1c?=
 =?us-ascii?Q?TsAuLrqsmKaleUdS+HMEZttQ/JZ8JobYxQVdgz3G1d35byF34VQB1uxWRYvV?=
 =?us-ascii?Q?t6c5vOfeku28ZIft89ZlsI5ZtBaF5A+Pm1dUNrWvqnMQ/r0jTanVRHfqowuX?=
 =?us-ascii?Q?zAjNsyE3PJ2Ct4xvqAWXBw6DGldEHKreJM+ndpN7VZuHrPCLcaiP39NkQ/9M?=
 =?us-ascii?Q?Isb1WYqZ/a+a6sXkwKA32OJ+Xh761rDSoW/TgOK3TeuDASQxQ3hIkRCWaG+0?=
 =?us-ascii?Q?ACG/EDRUYNtmXc4r+8TL4IGbDK5Jv6qP533rityql3fNi7QHxLOFqHPfbUQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57056f5a-ae6a-4841-7d52-08dc9a79b0a6
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:31:02.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4613

Add devicetree binding documentation for thermal sensors integrated in
Sophgo CV180X SoCs.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 .../thermal/sophgo,cv1800-thermal.yaml        | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
new file mode 100644
index 000000000000..016299822c16
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 on-SoC Thermal Sensor
+
+maintainers:
+  - Haylen Chu <heylenay@outlook.com>
+
+description: Binding for Sophgo CV1800 on-SoC thermal sensor
+
+properties:
+  compatible:
+    enum:
+      - sophgo,cv1800-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: The thermal sensor clock
+
+  interrupts:
+    maxItems: 1
+
+  accumulation-period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Accumulation period for a sample
+    enum:
+      - 512
+      - 1024
+      - 2048
+      - 4096
+    default: 2048
+
+  chop-period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: ADC chop period
+    enum:
+      - 128
+      - 256
+      - 512
+      - 1024
+    default: 1024
+
+  sample-cycle-us:
+    description: Period between samples. Should be greater than 524us.
+    default: 1000000
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/clock/sophgo,cv1800.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        thermal-sensor@30e0000 {
+            compatible = "sophgo,cv1800-thermal";
+            reg = <0x30e0000 0x100>;
+            clocks = <&clk CLK_TEMPSEN>;
+            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+            #thermal-sensor-cells = <0>;
+        };
+...
-- 
2.45.2


