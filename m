Return-Path: <linux-pm+bounces-19273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB089F2A32
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B90163611
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1B1CEAB2;
	Mon, 16 Dec 2024 06:31:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020136.outbound.protection.outlook.com [52.101.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D81CDFCE;
	Mon, 16 Dec 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330697; cv=fail; b=J1hY+DDJxlaF/ljteGxn2vDQes/QSgf4RbxwdhWItXrGXRJMJrlegHNUMKyA1RbsWz2uJ9aiue/rxmHx54eCHDDLc6zcsEZXJwzpf43ZRuETwin3D9c2OLHzn/v/qIwCxQT63VbOIywjJTzTSoApQmCdPQf7Hx3w6m6YWQ18QDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330697; c=relaxed/simple;
	bh=2sZIu2wSK/jV0Q6WnuQbc11QqFn4dJXmYh+fs02ZJ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqtDZFS4prZfZdaQJQNE0/w9tOOsQWIblCsuzUj3l8yL5WJ2eR6OPg5mO55G87veHUU070LBzMe4qrpXLfTz4PnSbjBTqJX6ig3ngVCfQeA+sKEoNUa6Uj9HAcd8xCjedIbTfgmpSt90MEagq4y2MyzyFGqA9dv03VsOzrfipMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzzzm0hFScD1rQs53o96LK3nkgihvWC+CEROwZpa7Y8Ai4n1Fr0uNue/8BonE7MDhJABuFh9kmEBOLnYBAwL16l9xXQrvJfM/oZoMbjBvI/X66PfKpE6AWD339kzMKpNbD+vZZNmYePESJdfr8+gpsP3r7oONEIqEUQxaH/C04XBhpGwxgUYMHHWhlA4pDej+qHS4prYGSIVfyP4vzs8U9PtUNugVxjjlY/SB11XI3bIrz6E4MANg/ayW8AiNEhoaVc5QpwdixV835Bk3LrFKk6ImRHEZFSIBZfN3IBBddHkkkHmnixfERRH8jrn/WCIeYgLUDsn8gU0v8TZaL12QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm85JErofHNZMfKRIe5qRisrz1HzeP7xttjqfiZc1y4=;
 b=am5DkWWKwl3OCaKihyy4htwClip1ueQrq9UXYYEEyNIrkUJYCLr9wIArRGzozWpZ+ww9tVErT/2t7OCQH1HDMGJz6+Wud+IJ6DVDv2dS/q5CpwjoFD0aZGf5pTh9V0uSytKS9fDv2WMWPSHoQZFIHad9yx9ITJXhclsNLZLNk91/q90LbVMOjePtxkpyg3qzxgi2phuxzEqcwDq7a9xUdkpQA0TyAVkC05YPmwb/+m6z18iCh9CzjnZ/YvGviWnWtNTB0VVdm1OMslEo+euHZfN7yOTii28D+/JaBPHEBLEaDe95Tq75b0t6nRQ+hN/2u95EmNleNlxObllHWXtVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN3P287MB2154.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:31:31 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:31:31 +0000
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
Subject: [PATCH v10 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Mon, 16 Dec 2024 11:59:16 +0530
Message-Id: <20241216062920.7228-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
References: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN3P287MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: 9383c74f-30eb-4b89-b3d4-08dd1d9b476e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/wK1dZLkmLnvaZejqCvdNRiLAPSKTfdkc6uzM54+FeTqh/Col+YnYFKMcKnK?=
 =?us-ascii?Q?wtL97PwQA22rFbRoVn0RCfxEGDd7sWlFOL/RH/2yqCnuNrkfbzYGmg4HpxxK?=
 =?us-ascii?Q?JslsjRHvMcW6bmIWrAzkOUXzEtwwZlfjjQ7fqtjzFnJFj4RxUidAIJI+6Rwr?=
 =?us-ascii?Q?laiDkLyIHOuH6eYvf/+HtFdAX2xa0+1DRD6DGyEXZzBYqvkX+RG5nxR3pi+j?=
 =?us-ascii?Q?2HuTRqfEynLRQYLiQFzU3Fh8qIci5Us30+f7g37xCtsp7WffnYJuE81UDzTT?=
 =?us-ascii?Q?5/Kuih3SZ680pe682XxQeJf4YCACHTQM1ZhEFbGk3KLkqFzNqFZKlGcNJOVe?=
 =?us-ascii?Q?V9qv5JQFFeVqyNihywDlB794DyVdRi5n5Y51cck3TSa6A2OVJQiUpGpvqcZH?=
 =?us-ascii?Q?fhBj1cziHOfjw1U6XSW3T8uSKtqGYYVfG5YfuQb0l5oJGfnuYBoI5EjXbC9t?=
 =?us-ascii?Q?3Cs7yEl2lWk10mnydL854xpZ8FWJaPRpqEhBRfwG+smi9ShoWo8FVSi/+MLd?=
 =?us-ascii?Q?dTfXA3NneX8KbPD4ao/jOEq7aVCofBC8mhY38i418nGeRLomcjn6fzsl5Ghc?=
 =?us-ascii?Q?NkeMbWqVVudxmfW5VIYYQ/OQZdPGB4Ibb8XEt7unUXhdQcUrOUyY7sGuuOUM?=
 =?us-ascii?Q?23QZx5BISt0X7OiAC7lgYTApvWGf8hpO7lc2VTGxUq8ZDeToOsmvs8VYqKC6?=
 =?us-ascii?Q?V7nzTnlo38wKP5CZxxmEkbOwRqIzOgdQ61T86MJFQOF0PG3OSw538fg9FXYw?=
 =?us-ascii?Q?cJumwxvFPLQ1kQbhzGmC9IeaouY9oSIqRpkSp0SQYMymABopZL0sOxKpu36z?=
 =?us-ascii?Q?MX39c1FiM+prxB3649cti57QNnSXh/GW1kam3Fxopzlx1yJEBCPU9xfnwk9w?=
 =?us-ascii?Q?F47Qt5VayzJG77znkJARveTAxPCDMqn4QSU3vFd4jMKNSSJ/7KChlGf9FtGd?=
 =?us-ascii?Q?Amo7WmciiMM8Gxs3CGXiEXM1aIfHT6ZRj+uLVD2Yef5VLxIbYm/opft75Vxl?=
 =?us-ascii?Q?Gkw6WH5JIUtj8JTsirCeUfs46OWCav5OguOBG18HossJsvUMEpqm6+t2/slJ?=
 =?us-ascii?Q?Rzir4BosGWZg4k8tPhZp555Vv4hkLP+qDyXga30FuDXxcC20JMwhWhinSnCm?=
 =?us-ascii?Q?Lix/hdna1R5PGeuDsSaOCuhhNgCHpNT1bFdoKTZGvaZDXtr3nQU8rXLr+OKD?=
 =?us-ascii?Q?YBG9ljX7ZKp5fTJ+btjRdqpBrp+XUJBfqkBGWhJMqYJVCcdWO23zeO1HwZNN?=
 =?us-ascii?Q?kNBD51CBxwoZAtA7Hup90FFg2N12OtpBaGJKWTePA7lpCS2mqgvQ+53+nD/M?=
 =?us-ascii?Q?zspfG842rzb1URJzUYNcldjVHbiWvDeZgoZTnCLJEB/b4OMJVn3e4DAREA3c?=
 =?us-ascii?Q?ZWlr43Smh8J0NPSsRh+Phsu2ZfRP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kp3ZrNkuCkGVdP4LiLMYYObnZgEir8BznTaGH5HnYQ5d24ZLmBvr3rGU986A?=
 =?us-ascii?Q?bXYRbIGz3Pf4qTGqX0SExv2hwc1LJhJqXdzrRXiPmxHM9mOv0WXf4dc3ZWPm?=
 =?us-ascii?Q?mKouVYeC1LE162om2fGGIRVaAvNcK8rBr9iySIO/7V9hRlBEdbCFp7Sb/Wkw?=
 =?us-ascii?Q?0CS2CD7OLU6k3RPiaONtkZpl/mzCWLwSFLrMJj/OqZamN59+5R6sU4IszsHE?=
 =?us-ascii?Q?FCaZcq3NH6ZqVgWrM2t40VM/HpJGh/BKdrtJiFss0lolWfzHjUUZx3JVnO9c?=
 =?us-ascii?Q?dV1jpuevFiFqPzeaxZ3Vz3m47oyyOjT1SwbzfB8KjO1GsBY6MdHyACwIhfMJ?=
 =?us-ascii?Q?NJ0R4krOYK1QrbPsUbXM3FV5cjRZ1hmhSkT3I+QvNmrJUA1kSQT8Cc5yZ0d2?=
 =?us-ascii?Q?cew9OaP/K4iFSR5X8QWR9n8qHQLYcTYakyyCsiH3TtfrHeIE95U4t3OcUUze?=
 =?us-ascii?Q?7hWNplYsRn49KgzUOx80FGx8tv9AiYddXtxHnkedZ2L+UTWMe2/WqH02PDzP?=
 =?us-ascii?Q?svCdvyj4VTAwHYNsIjr4jI/f0qsXdMDg05ZIzf8Dx0HmRISnpmcsO9adjp+X?=
 =?us-ascii?Q?01NrXCkdDaRBBYml+ZR20efb4bbJzIM9+iqC2xEzmKa5KBmETiwuIiBeV0Tg?=
 =?us-ascii?Q?wY96G2IAqMjPyABY9/Fj9m4mYzyfcZZgQCcGl7zW+tk6h/mvx7RKxywR3Bcj?=
 =?us-ascii?Q?HuIHT1szPXAKJIassP9ffAGzKkHtMYQIbZ88ysFxOnZpDeGBV5pJ3ZsZ5PVX?=
 =?us-ascii?Q?mwjRi1y3FgokjYn7wo54cZwsBKikIgu95ijcTfHz/ymq5Ci9604km2FRvDbe?=
 =?us-ascii?Q?aELhAjxW6naE/O85haPHDAEuIiwfzeZYi5DvEuaJ+GWmmtDkYsTqepvlNwwf?=
 =?us-ascii?Q?s6Pmb0FXqRXJrJkaMvDroUbkXYpYPU+5V18FicuXft+IBfFg1NigypFB8qA6?=
 =?us-ascii?Q?6birabukPZABinme4gSh8EXMh4QbCZIpFVp3VhyR3ANLvJ7AFs+Ah/eTo0BF?=
 =?us-ascii?Q?uhWLa/oEantIp2P73GcLSSUdlIeubFFaj1Wrln7uoIwJa3wVbHHSFgUECm80?=
 =?us-ascii?Q?Bl3cNTDG9zVBoc8pdX3Pw06JvYhhxcmgovswByPb9nGXgLuLiknit5GmNrgm?=
 =?us-ascii?Q?2c6uFi11l7jjrNBklhOFEhs6OkhnhdrqsjJA4E4YEr5yuk2f8L6K/YW0mNpw?=
 =?us-ascii?Q?x0pZyr+wzQZ+OdmvNdnWQJ8zdKhUDOel2/qZtjTirxUiYGzBZBvXY18972EV?=
 =?us-ascii?Q?ODxsbMrCLBYAf4V7sVXqokdoW1lWeVb/Buni2dOuoP96YPbNx/L3Wq1MUI/n?=
 =?us-ascii?Q?qy2OuI9lAh9yjg9R4HGSb2Jy/mrVkDHJhER3zIi0/LuLgqbrpjG70aZCePft?=
 =?us-ascii?Q?8zvG+N6Ruios7Uza/UIFih3OcqatXEn/ZhwbEFaVhG5BrrllvPHjSirsBqoz?=
 =?us-ascii?Q?xzSkJ68jl3KslilzYGEl85BF8GgRGbtNbAzILOf2uMCSepxAIzkIf3Fr2Szu?=
 =?us-ascii?Q?uRJmeYsD3pa7GIabic1s8F/tYm4MA0Y+BMaA3iRu9N3WmeotDJWTz3wqa6Oj?=
 =?us-ascii?Q?491Tq+dufjEjuE561I4LxAcnIMJB0Ivc5utmBYfA7KQzsBdFoNwM20pIeM7j?=
 =?us-ascii?Q?bYJRA5B2ZlMc/r3VJKao8y4=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9383c74f-30eb-4b89-b3d4-08dd1d9b476e
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 06:31:31.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b89WtSuWG2ljuHBOpOu3+qipq5RyX3yD3Y9NvDBZlpuvfbUcEshmLl+ldhONMUD0wIovQ1O95HmYiPbWgSnHmQqbtWUm6Ke0f1m+6jSdTC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2154

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


