Return-Path: <linux-pm+bounces-18893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4B9EAA55
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 09:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BF161C78
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79EE22F3A7;
	Tue, 10 Dec 2024 08:11:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021134.outbound.protection.outlook.com [40.107.51.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1722E415;
	Tue, 10 Dec 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818280; cv=fail; b=sfaSjPDAUSQH+ZdyLW77OdVE0yi9Vtm/xQ8lVg/6R2jvy7ZC0MiXXDRWby9IExXGa/A5R5qX6WDyLBenT1EHJUWHewYgmwYgev6kniBZx1CJV1o9Jimef0G1PSM2w/otekgjnwbyZ1phVqvLixd0XKDpnwVCcyvY/f6ENh6/Fwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818280; c=relaxed/simple;
	bh=dX5WkEvXSIN36FLRgNZ3Wxl5R+epKpmTriNlHwp6jKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KobOGiylAc3f3Egocmsqxhh2Z3SJML5IGQfh8xion9xy4/sPnhJ1L4sdAko9QqlknaGbGYvScC02/rK1FQOZOElqUrQFSoDW0OUH8ArUGwwMgV5BBx2J6ptDtwiDbrZqerEFrK/1h42erDFDn7lfZQicOS3AYNdg0ULxkL5mSzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TojSskDlAYRh9yfSejqei3rMxQRZDJ2rRnZoeRVHO1OeCBfJV2FouFDugqwcDfcWQSd2dnWP4C1ulQnKFxEimpv9kZOi0ezZYjucgCdAxRoNP1pLs4SsGzykp2EH0e8Uj4QUzKsjA/UExLkWobjK/1Kxt4BQQ8IpqkNfrtxY6tffm335jYoC++/Hsz6raoh7wlbj1ectO9VWsSTpy8Tin0S64026Q9O1O4jJwaddfE825nkMoGnTDVkrYZXo0gvAefc+VtZxRJyxjZkwZuUI524Onv9tKnVUqhabJpr1LOdewiA0att9wQsW4h17mW37hQR2P/mJT7qznEm4Oby6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Du5Lg+xDHBDPTRzP+Rk1AqsAKH5YFlxgFVINXqjDQA=;
 b=hKuPSgHpseEe5Fvd+GdTaQkeJeWaiPgz+I64T3a4+CEB0i41IcJgt1o8LXr1kYIGoSmDIXPNRso0lHaIh8eUX6Njz+TxBrMDp3uXSZ3nkX8m3k8Lx05JkX52LOqtI9fwKGypkRBa5J8q2ZUGrM87+7dKu7oxy8RO/opceqfXNpke65mnsKDzbJ4g3J6jxqT0O4FkL7tOTNDmEoM8dJU2+to6v0GxzLKwbJ42KE4Yu77kcgV0g03UtXVGTYhsf+AkaIWV14O/VSXo6W5j6SlPVlFcsrmN9Kbe+oQn39eaJGdxzEIUpRKihilWxTl2rEXmv4I/9fi0O4G32pGf9wNyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MA0P287MB1195.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 08:11:15 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 08:11:15 +0000
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
Subject: [PATCH v8 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Tue, 10 Dec 2024 13:39:45 +0530
Message-Id: <20241210080954.5067-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210080954.5067-1-bhavin.sharma@siliconsignals.io>
References: <20241210080954.5067-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|MA0P287MB1195:EE_
X-MS-Office365-Filtering-Correlation-Id: c6885903-8002-4640-5e2c-08dd18f23808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9IMgDPysM04w/SGcdkRGEnVZXnf6LPrHkqCQXRJA3YGsWwn3sVlM2PaUH8Gy?=
 =?us-ascii?Q?B6N4XOFRciGI3WG1WezQ/2QxgF8x0n4NeMs9jl5/aapd6XmbqCOVJUMRaGsm?=
 =?us-ascii?Q?7+YDfAic44pLBn/pDoBC4fbXJLtnOvpSODdm1ZnfirM5Q+3sxXUU90zYRXH4?=
 =?us-ascii?Q?zeVsR92BMn3AvZKLiHEsotE6Be3Xv6eu/YA3QNc9zC8YyHoPHd7uiyw67atV?=
 =?us-ascii?Q?H8iK22PiQ9n655XNpOeSVdcTnk7MuQHbK/tnkkpr3cXdALWXGccnzZUlRPWt?=
 =?us-ascii?Q?GnTyB4qcWUlXPU1Y7wuZ1x56aIU33C7E6NeGarPC+SxmcG3+ueCXAV6ZIKhX?=
 =?us-ascii?Q?RJuh3uAynh0OUXHlQvb2gs5Pkiaal2OuKOsvuMIf8cHDQlnYYOfAOjKV29Wu?=
 =?us-ascii?Q?OWfd+4cC0bS7Eo2NWiHKKcIOAhcDlb2mFM5FE9jETv/e+m+KQdV3Bs9zcGBv?=
 =?us-ascii?Q?8CUypO966lhZlLN3MszzZznWKenQfeH7lRRs0Wdq/vdAPKIkCyhbhA7HAnv1?=
 =?us-ascii?Q?XEu12nvYfZ3gPnVx5Bi2TzH/ZS3Jpc6jDuu9KJloNlD9FqJEZCTE1sVhtnBH?=
 =?us-ascii?Q?TqQNqqY5b7vSl6X5XGJE13JxSGeLmstOTox4yeL9mlrNxwQyA8qK2AwW0QO1?=
 =?us-ascii?Q?/fZWp1U8FBqy50ZV+yitD8bevkTVsu8HeP2zfg6gKX8Bs3cwBa/wr8ySmeYL?=
 =?us-ascii?Q?uEO0owy+HLN1MPYeglC9opS30TWW97CHDfeymlg84qNY06OhB/Fo6G38tu77?=
 =?us-ascii?Q?oeHFbhk3cGTE/w/QF18oPS0Pa1tZvSd1+RIrqNo98uLfQ4ElpSVQuyh0ciNR?=
 =?us-ascii?Q?66eEHUROJ3mIzHgcKnI2Tws9h6YHwXyleklPjCVbPaKV2YX8H0FNEFDGNz1D?=
 =?us-ascii?Q?fSbYfLYG6Sj1+FLh/irwI9cNwx0mb8D+tpIxn6xBWNarBWpNbpmjWmFkbtT5?=
 =?us-ascii?Q?OM6H5PTAagiN3cZQrl3jZcUXo3ixPuVIjHsIlO62EUgyU69mBUPDAeKmigY0?=
 =?us-ascii?Q?65zicVZlDAE46qXssgFZjN6X/YthrtivaNzcbDvSpp33li1jwuFRn+72Ct0v?=
 =?us-ascii?Q?HB/3KdpxHAfaJ4zBQrvhfrl3yRMy/+a4xYV6DZ5EnKfKao5RU+WtZ/08AxSj?=
 =?us-ascii?Q?yVYR3OIp3aYoju0cJFn4MvGDp2gvMYTbAHhQM6CzjEuXZIT4dq7qyw3v/0Pp?=
 =?us-ascii?Q?hu3PO9Mk91bGhBGdohtbqjNivctXUhCAR+YCaGQ8uQ4EugYKhPereuw8V0Aw?=
 =?us-ascii?Q?5X2DynkNtM82nWpk6PMF1iFhZtL/x1nhXuOMKktizYRc2bcpsF7/pQ6L9uL9?=
 =?us-ascii?Q?fyEVjt+0C2NoSU7bKE9iv4PH3frwxm2pnEOep0AdV8zuKRH+wO/NR+4RG5hp?=
 =?us-ascii?Q?WI2PIdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKGTrwuUiwxMA0tl2V4+WDpMLqF+kVkDacZpDQrkeX+7p88K9uLlLeogDSfz?=
 =?us-ascii?Q?n5Tw38hIwBzehMyeClZ8I/BHSKvs/fxplGOn/9vI+9vN9CRZRrpyg4zJTHo7?=
 =?us-ascii?Q?1uww2FaClGtts/MmwDmFC4qpgtwhnpVmxBqS8H7g+QLVSKtq6IQGFtfLkoJQ?=
 =?us-ascii?Q?A9d58x6EqekK4I6z0Wbr9fzkiT49eFHH50WsN78D6bwUaouuZQhoTVyuVADb?=
 =?us-ascii?Q?uaoeev4sRW/3tzYHHnkp32bN7TuBgShxFWrl7F6yDAC8Z7hHOBHw4N8cgo97?=
 =?us-ascii?Q?YbKsghUNIOzsfDFy4/qowD/DprX8EwpJrfLgUpAKHJ4sBv+vIqKz2Ryt0H+E?=
 =?us-ascii?Q?75C3GTW5j99oRwlYARHdMmKe53PpsAM3n7q5bkUVbEFbp56v2pST+vWDflSe?=
 =?us-ascii?Q?qW8zFdrlu6jylGqsNDX4AjfIWYICAeevT/XAVINGTGszm2PcsshikBao12lt?=
 =?us-ascii?Q?ecYj5jm5WpnHcMNsFKT3qAtLRwvVWZP0Ya65Vhj5H0Z5kekSx2Gpqlo4zzTz?=
 =?us-ascii?Q?AZ7KtuvRVn+LZKO0IQVJsU/DEaEvgeDQtdCHPdFRHo5ApSaiLA/1bQQXOe9g?=
 =?us-ascii?Q?aoJnizdMH8DbRWdguLmWET+HY3dkDv6eeuOTac/b9K36zva5xlnEDrsWb0Sv?=
 =?us-ascii?Q?RevnFXP+mTpRXpfvVpv+DwFJzFk/RojZYfxxSWSu2O8F/RXf6B+/8+SBnLmr?=
 =?us-ascii?Q?o1TCQBt6OwyLA1t5RcaoCSqru1vV69k4j0/rQTsG+Ri18Bm9lZpc6BoB6wmR?=
 =?us-ascii?Q?ZdxBBmObRMuE92lsdyweaM2AxmCvnUm2wu/Jt8DhXz5GiZTYlWg+HuMhcQ1K?=
 =?us-ascii?Q?H/4C8K6ZNQvTBgR073BwBcTgIKQ5tkY1lgscXZbvB2Q2xz9o3CqZdv3GHAXb?=
 =?us-ascii?Q?1Tgws/+IV2qM1+qApkZJJOFexmE+binPm+j3WEz+CAnIDQ1Durgk6xb1l0Q2?=
 =?us-ascii?Q?p4ecerINcc+FA8kXClA9wuWzlZWoWHT+kAnIXqSIJEeyxt6O4gXXwIC2E8fx?=
 =?us-ascii?Q?UGE57dDzmvTWEctb6gS7vBXWCZpFDC+4PXQ84yyi4E905JCxG9RqcWdDdKi/?=
 =?us-ascii?Q?gnw0oriIU9AfR5lacyGkJEabEAPw6FxT45azXe9aQv2OoeCl1ZwXW62lxSi6?=
 =?us-ascii?Q?vM066jvIGoUUTSFVUSKGy+CDWibX8WrZ2AwFon74Q8mK3HzMsBlTbfmyVETr?=
 =?us-ascii?Q?ijd5R/ecdkkXDVTjeu/IrzAnaG6w17Omu7/HJqGKRRDzPY2w6yxPL9RHnZ8H?=
 =?us-ascii?Q?qvOTjevYk4SqUNHWKrUXEE3JCt71a3heRO+I2Th6MmgR2lertCW+JSbNF2oO?=
 =?us-ascii?Q?2KYzCgtVdqRsKoJZVj93LV0kW6IvHBaZF7vVBAObM4QzrnJ5ANZiuPMkcNd6?=
 =?us-ascii?Q?WfaRbYfmq4dYq724djRjZHvtiMf11bNmZQa7VJkMq87GwVzCxAULu2JkoQOI?=
 =?us-ascii?Q?zHPQYgLq6jsHN4p140qUS+jp3VytV9L7eAIy3wtSFpUqx7tat9J+B0XOrL6w?=
 =?us-ascii?Q?4jR5mbEq6Ry89YAtVjNz/0TIUDN9MtOBYp4TWCro0Z36JFPadBSNrCWfksMq?=
 =?us-ascii?Q?ON5aIrwHcFSsf9pq5ZYFEr9sUp+8ekApednLvRsOre4eD0XKTuO4eKgJCX5U?=
 =?us-ascii?Q?96kba+FFVEkQq7huPcCDG2A=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c6885903-8002-4640-5e2c-08dd18f23808
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:11:15.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA8FovVNuk1iujwvfMUu1oVnQ8gzF78ZHpLVCl72OKsQ4V3n1RkQTlV1EBjDRCo+MBhVe+d9Ik3oumxuc7NF/PrYtNeEvtoUKj2uIJAl7Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1195

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
2.34.1


