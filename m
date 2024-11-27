Return-Path: <linux-pm+bounces-18159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E544C9DAAAB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3970281B7E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB188200119;
	Wed, 27 Nov 2024 15:21:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021140.outbound.protection.outlook.com [40.107.51.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292E1FF7D7;
	Wed, 27 Nov 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720885; cv=fail; b=M6UirbrRI+AI/gv3LUtIxhC/HxOvFmqHbuUG/0aV8wG+FoROu5AVH8FTiCyUc4KhcV5WyjTEaZHY+KH4ByXf7UlwJL3mcEu3+hbYG84aDHqHou+Fx9jwHTC5vwnVKZaugl+uLGaHR3J6OnM4ug+CfwNTcDy7GlKv7NoXOEYJKZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720885; c=relaxed/simple;
	bh=PmEolCgnQqfE2ttSIxWVWbKbC3pdi06S5C9GDVm3SV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihjxfkE/Tl33md1lM3rHOkC7jyyCV1189+8lwws6n7LUDmag0IBDUFks9FUJ/OHgxbf0voXKVwqEeNE4MfoJu6iQ2kxTCQNML7JT+63lSv9MyZMEz2UguzAYqR0Gr591dhfMWJ2n2pya23zBw0sfD/nVzkKct0V8y46S6LXn6tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaQ+euErhNWd7i+Aoe+lHAAWOE3+pusnpADB2klN6n0PAuGSYnn+T5oeNIQLjZDNRCyJX/xQulT72UTQNJnxhKQB4RY1SEn4OoCj2UkuZDE1TXogvOxlCEsKXe5LLbSd09ClWO8boF6tYDvMaY1/usq9wrKXFTryWpFsRpvZTIF519CVyMdqLG1iUEelIbH47mn7QhJLXqBnrHL1G5js3WDABitqWaDwi6GUyNJHIUeakD5B+USZfUyzwNuR0hLouw3+DDQUlpEEUXSC1kd93OapNclsokzaC9GdOQvsbLMggn/nMMoA4fdonT/+LrUf6p1EAR9s5yJ69x1udSyHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv2TtkgQXHFE4hHrib+X9skiYIXSyvKjGnqBWI1BFuc=;
 b=Kyn+pbl77s4OLzBoBxCQHEdosxy8KD9jopJkDppE3ESaSbnD1V9JT/3XN8Yl8emeinbSkDpD3IJ3GoSynqluUGxo54PUX7UpCSe2ZqSxcdyv0bi4tyxpfADOpkUCdo1JScx+m8N556QAqbaC9twIUIZmxNj+jCMeLnuTXUfFkOhhBgT3SIFnUspKlC3dvM6UIY59x4iwvXpWxOCpiJBUKH081lhxpev1brEHbtVeBY+eUCSlCmGNTEexzFy2Z4Q67otAJeGm0Y6jm0xK417gqOUm45GPbsGN400h3PiVyrYdTBjeweAFaumKJBYdEYLlzkhWYutVTKqcl6jf5M8Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN0P287MB1989.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 15:21:21 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::c75a:632:1645:5db]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::c75a:632:1645:5db%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 15:21:21 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Wed, 27 Nov 2024 20:49:10 +0530
Message-ID: <20241127151953.29550-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN0P287MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2e0174-860c-418f-4ce6-08dd0ef725cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lfqKL45XyP7KZQi4GbX4+FfGPp5vobzp2zYZdZev499F7l+ZBu5u41+xfeSa?=
 =?us-ascii?Q?iqHlI6FuZxaAI0Qccq+ZbNpl9uUXAKA2Z9C7kQfV9HGSyn33gS2Oh3vwmhai?=
 =?us-ascii?Q?BPKKCiFHmmfhsANusPU4cfRkcW98hZCbn/M3jnIO20nfMNLhheXUaWGYZML8?=
 =?us-ascii?Q?3X2IaZ6IM1/Hlg3xSPwFuLb7S/VIW6WIxWutPdOZHaIV8u1lCfwXrM4DEelM?=
 =?us-ascii?Q?0BpqRgrC0G4pm1TI0pR7NeUAizyKymqYIY1jm0cniJpUjct5yBMe9o3AN9Wb?=
 =?us-ascii?Q?J4z/7PGbYe3Qb6TJJCNk9QlWnkh5tZIJ8tUoOHh6NKEcWTp38IfYEBmO5DMO?=
 =?us-ascii?Q?ByQP9rZSqmugDRSUQwr+x6Skg8XTZMzP7ApVoy663Ubwtis/i3oB76llY6e7?=
 =?us-ascii?Q?PG0Z4sIQb6Wc/cIwMLC7m7WRSc+0T57pTRFVQ3JUZxNhOYQYx5cyvZdqifDr?=
 =?us-ascii?Q?PQJMR4gD2PR+nPPGKYZtcd8/ehK5L4OaJ1rXQE7K18jJnNDq3HxL/cMh+PzN?=
 =?us-ascii?Q?/ZPWquMOV2wSyoU0bVogHruxqugGLcUHexkcAhr0OsJ68rW7M5Ss1ywW1AIQ?=
 =?us-ascii?Q?0HII1gymokYS5BQjlac8vQ32QksUL2UT/4gCBpRtUuwp4WXGQOQcdIMpsZ5Z?=
 =?us-ascii?Q?nBJ1cvQ0WGEw0ESLY23YUYqtP7fTGWCG9BlPCOl6uwyalFDPOXnltra27CPt?=
 =?us-ascii?Q?XmiGqr8ucgLRDQF90XGKopwbI824byQg1uVMV3G+pb03IWiLJ+ZoZVrxCfG3?=
 =?us-ascii?Q?Nw2jEhumbikawNIE2FFIhoofWaQvSt1rfob2Ekg8mI2ti1A+TvS984BvHTvn?=
 =?us-ascii?Q?q8Ip34/rZNBmUsHJFVKrKbFlzzobm6ZvPUTVKXZFpwiGXeoxYb+d4rMPG7uD?=
 =?us-ascii?Q?wjdz7t3956CS/yKFn/vtn5v2KL/oJAqxCPDgSel7VXAAPos9ioICAHEEE3iJ?=
 =?us-ascii?Q?0D6E2767zUhP9vsD+apA7jKWqZYQU85jrQOnjRMwc0/Z1m3AahP08XbzAJd+?=
 =?us-ascii?Q?zbSGG4doLEgLSu5icvNVhKPGablgONh3Sf++RgLtjlCQABTh178oFyIkodNz?=
 =?us-ascii?Q?Y9RxlvS8OdBjEHW3o8jUPUEkpX7NbLX+LGMNysxSkwek/jTUTGxyUGb02Je3?=
 =?us-ascii?Q?zOeWk5LgoOqIzC9gIy6P2nsOfGL+hrGB/f1/rwx54MYYM2T+leZnrAQ55FLX?=
 =?us-ascii?Q?Ea94V6XyjiPBNecNfNReqoS5G2H/FPqF/03WXb0zjwMyDR5Ey8FJ+lT2pGM3?=
 =?us-ascii?Q?Optdp4cJX5x2NhfXw8JueziKgkBVWFwkZwgqof4LUmYthcL9MFun37nHcORU?=
 =?us-ascii?Q?uSUwPh8XTYhKcXDBEGMuQSeI+nS9xLbyCgvhcDUddXGzX43bdNT0ongp81cA?=
 =?us-ascii?Q?SW13SDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KSUaEpJrhUPk0TkZux05xb7eqVhmUrY4phCKh4hxRPn77bwC1puleJkP4UHr?=
 =?us-ascii?Q?MRiEa1DuXztGRQC0xX4PBhbICjOx8ZNpd165wVQXsmhm62madgc19T4Urrh4?=
 =?us-ascii?Q?0uBZm650CA14b7xXoav4RmZj9yrX4CjCKU7/pRSm/YwjNKCipV8NKjmAoI/j?=
 =?us-ascii?Q?6r2kcA/nL0wYmVcCuiBb6Kh5wdL0YEHd5sxNJeVJucgF5AK6ea7wrnZ35dWE?=
 =?us-ascii?Q?NaLJ1blTglrRCx1YEDE3hs0LsvRiMuqL9m6Gxgg+YJQRQyjlLjJZfpcSnsYc?=
 =?us-ascii?Q?vTEkugpzdLB2kwdlfG/nlF5KoEE6pdLaS7NP+dhJgJPN97xjeKAn1bBF+3a5?=
 =?us-ascii?Q?tPHIsfOfE07Xu/PrH2CpNh1cevaRghu4sZTtNdSEInICJ2jUdJHgKm2XlS3N?=
 =?us-ascii?Q?omeItpmYCfUJsk84xjGNXiPRJ2xZK7Rks25si2K5NxaAGEKpDmC9dT1Wb0M/?=
 =?us-ascii?Q?xvvPR98byiGO5QgFMOy63FDYT2UQuL6q2VAV59in9EsSGXRShCFmK696DX7+?=
 =?us-ascii?Q?QH5ggxFmyKARoJ/XLCBfVAG5aVuK8GzGlQu2UHiuDcorCcENoS1nCNBZhtkB?=
 =?us-ascii?Q?sBChS5h4q+W1cd8Sf4Ty5vIe+engLKAr6eDhesbSSrsRnBGyILEIRI9BPWAA?=
 =?us-ascii?Q?H//QLZAC01TARyarHuhaL5Hd0IQoWrJYiM12i/PHYPrQTH57hBDQHKExvzSU?=
 =?us-ascii?Q?VD0SUcHOuQwGGUhhSg4sKX50c7IYpavRwHsTZXzmyb0GUx/fxjoocqevExqo?=
 =?us-ascii?Q?VB1wojuTaLL+qVNAFq5FKf+zuW0o3ag2oCiBvEPyzRraMLaNuG4QiGszvCsK?=
 =?us-ascii?Q?KtxgvqRb9RXSuxiZ/caa2mE1SrhErm/AQAsmbKnPlWPF5FirFy5lP0SAf+iK?=
 =?us-ascii?Q?zV/lBXSJWGsyJO7lWVOiaz0nwbqF/3PnaF/lOq0F/VOfb4O/O0icjWeaXQGg?=
 =?us-ascii?Q?WGgaAtqFeZ6o1qJkLm26CJB50iTX+VmczIH8m25tbIsERXjMzlFSgb4auYk6?=
 =?us-ascii?Q?9EoMXyYQcuDaZG6QvCw+c95rvyrvTDF2LzG+SG8Nld5zq4vdZQwhJPzDqskC?=
 =?us-ascii?Q?Kw2kDA+xMPF5O4fI61ImVSPtcvFATHs+GdM8lUn6Q15ZyIDi+vUDO2acPqzb?=
 =?us-ascii?Q?5ojiNA+uS6QfgmCwJL0J3249B9RHwdVM8f5LMTwt0whaUlIw4RpAZ0A3orPq?=
 =?us-ascii?Q?0cF5RfpBrAILzx+Ix4+STcxl0/4KOq+hcj4YEIrKr7QXfNU9ixlo9JO7AG9c?=
 =?us-ascii?Q?GafhbhgLadkyeiycLWb8SRk9AKJ7Rdjrs6CyjG5QQwY+IPm45Ob7ug0ducgn?=
 =?us-ascii?Q?+aW9bc7HN5oS2a9B/LQKgSqWGMUXI+NGRJtsTBFSrb63awCO7KxISM3seEDA?=
 =?us-ascii?Q?rOs5jntcVa+2aAtxEGKt0bky9Avxs9j+Qe/DFXzhl8sEoV/6P+xhlFl0DrjN?=
 =?us-ascii?Q?z6HeZGEbhz8BngmkCdqFuj3pq01cCYPL7SUnUNV1unUA9pBZlAABqa8rddvb?=
 =?us-ascii?Q?juI0XwfUcGQoqTzhY39SYxb2Wbpv5cTZbCwEjPg/lC8V83Y71xUbGz/iBCPw?=
 =?us-ascii?Q?7D0or275eJIqgRv1zWvskO3LR7YwW/DWuA0H2wJa/cLwl1qRqUTfhvUl3x0p?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2e0174-860c-418f-4ce6-08dd0ef725cd
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 15:21:21.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAR1iAKr+WbCHqO518jjF2k76tfiBidHVklzoL9FXnYYBgm61/R7d2JrlwPnsIsvHkGgXJbswzj2wZcE/nhoH9a4JPmjuXgU+V+Peu8MleE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1989

The STC3117 provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 .../bindings/power/supply/st,stc3117.yaml     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
new file mode 100644
index 000000000000..06e53534ad76
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/st,stc3117.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply
+
+maintainers:
+  - Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+  - Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
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
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@70 {
+        compatible = "st,stc3117";
+        reg = <0x70>;
+      };
+    };
-- 
2.43.0


