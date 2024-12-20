Return-Path: <linux-pm+bounces-19564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A9F9F8E41
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42EF16C62A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD271A83FE;
	Fri, 20 Dec 2024 08:51:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020094.outbound.protection.outlook.com [52.101.225.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888171A00DF;
	Fri, 20 Dec 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684699; cv=fail; b=rR+v/MVkz2YtxpHsRUHEpE6tq6ZaDFeFCnpt4rUVJbrs8d7q4/dcqlYw03ERjuN1n/VtgpczoTlhP0lkLMc5KZkgRMqhjUFdHACvRx3CZEIR0CS9HiK5yjexvICKG4fSA7pBIWEOkDp9J1X28X/3lGBm4teVKcnC9o0b/hAIuV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684699; c=relaxed/simple;
	bh=xxO4C7UJMAvPfzsTKdMS/AVZDN2aX32WHNE17XpIfV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VavjCV7lg67UHfHVPpXmrm7iFkJGcAr51Zs7mtZdsZymm9siSESm8gXDmkymfI4Qbuu9eEdkmcLKEGa+f+2IPTG54bq7xTsGIXXWDww2mA4SXFo8i2hderiJfjfDomVBM/6HM1WPz/GEAKv4W+3+Ee/ms/nq0Vdg12MNx3aeRpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=habeGnF9skarZJ+SUfiRY48vU55kinc17Mha5dRA/4pqpgr7uoVhGLRwDdkJwxfHEenpza4MTujP5pKr8PASzspl1PT7awV1KfqoORb0vtL2L4VUDrerRC4gigO8SBWbCci8LIuHf1zIvkSHnwcU0XpeFdu2lnTlPBoLImJ72zwMMMZ98hmqSEoWpi7Sr7YVNfa+KtQYUfMCTUmWzCmLrSWbID7IjlD8UINlgfJ9q88ygq38PHDTTTGL1o/Oxv7iu0d6/AHhixDJ4NUodgGEEpexL8+FHeahnHv4+VtrKPei9EigY09jylDU2EtNHd9T9dmZhsR3TTTpBzMjEFFP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOdcyKu+fYOMaibbUC1Q9/NKitxcTCDC/b42yokj+NQ=;
 b=eRWbBe4aCidMUmqIB/gieotQ68pf1QLghX/aRYaOSpx0pkAwvp+fJDegkpS2cOnE3Hdq2SNHchnSbXOQzVJtMtv9eWKYnIrv7+B2GQbTb12wEkuvcGPidGUlpP1N5xqeqLXfoCA9y76TimNSFbX/ywUYBOYRW5ec5684aXRYbm0ix4U2YKaJye4ozTt75MUTDOMxYUFnxKT3QlountaKsaM/JVRnwo1WM3l3irFbMRU8xwwwUFzfY1brEa9rwt2qDCv+y1wgDIxuBBswXGWC3/0En646xUIed5XHhM+OzDcDAuNvDkdCIS5deQe6qMdtCPr/2OkkCI32c2e5HzG+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN0P287MB1045.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 08:51:34 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 08:51:34 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Fri, 20 Dec 2024 14:19:54 +0530
Message-Id: <20241220084958.32367-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
References: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN0P287MB1045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c633bb3-6c28-45b9-5b87-08dd20d381bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApRnwKDjEIbMU8tt2Sugrz3GvaIOY0ev4xx6zsPshSX9o8yJGP8rbkxKoatE?=
 =?us-ascii?Q?/YNt+H0XuNgaLqqaQwUb/4MQb1V+Ydza4jU5J3QYEe5BThMl6xXmkp/eRejQ?=
 =?us-ascii?Q?fjAlsF/eRJQNgD3+FnkXDwFKD5A9p6kurkNjw6fYJ5NMhWk0R8c0pydU6bx7?=
 =?us-ascii?Q?myu0C2IR6xlNucXtphGhUAPf0uf01iAasaXPOfo77LUEkTsFyyTi6b6juA/f?=
 =?us-ascii?Q?URWKlYlsLRHT4ixQE1UY+Qin+w5lWAUZfjpnFkjKvxUHAkMVlUzOplgm8Uv7?=
 =?us-ascii?Q?eN/Mi/upFEqyMjPx4EeLuewsXXSuExMJvTUk2dXcbvA6S6dS03sWFOB/QneI?=
 =?us-ascii?Q?JUi8+frxkczf8QBxxP4aW6YtjgmRn515cfc7k1gXiqgo7ypErTlT/T00z0oS?=
 =?us-ascii?Q?gFfPug+Hx3xRJuaG0/8AA7geR10HVAEkNeChNKZThwKJ3447cNTIIvkIHJRY?=
 =?us-ascii?Q?gcT5JEqQ8Q7wwNW7LgmfiQ5QdSJcDyop3tcdSE+5XZopUvkD8ugG5TqJfyjb?=
 =?us-ascii?Q?xXzeZMzNj/P6DAg8LLcnhaH+MgyKpFuSQVcYF599MQN+EuM46PxnOFFPMIVx?=
 =?us-ascii?Q?SitD5jvFHc/eQ5Xickhszw1g21VDd42aTe2Zx2gA75ho7FTIUjTH2hJVNVg5?=
 =?us-ascii?Q?9kRsTJiqX/s2gziku87vYhzYUev9UqYlbLlmmrXE7RVABvc44hw+QWYWfHqZ?=
 =?us-ascii?Q?Tnl/R3rZz1vqtNTPyQ1QtLxdof1oz0LMjBkqXeoW5mNQLcTdczpmB+DCwZ90?=
 =?us-ascii?Q?M8eG5IzWIoxEk9+cvlupv+ExjdvKn+caBQCDfDnUmAqavwAm68vvTZPPNHVc?=
 =?us-ascii?Q?+nUPJXTwXVidyGCrB5x9ujLYQUhQQnr5eEHnc8q6S/JX9ewK8kb1mVTK0JAu?=
 =?us-ascii?Q?YfzjGB9ewBTg5BZeKpW2wljxtxR1RNt2j3t7BSlpurWES/kOWtYda4cbfSy0?=
 =?us-ascii?Q?tbbCsDnj8z0Kss8CyzOSVzu4Ax+CzrxpBlb2/+Y5c3Mh3I++i9gk7Tie1Qud?=
 =?us-ascii?Q?NKBDAFmep2NYrohnKwawT56MAeJEO5wbclu6N6nJLIcJ6V/fxA+ADh70cZV0?=
 =?us-ascii?Q?MR9m/ioCQOAY96+d9TjqIKj5G1Fn3x7yX6iyYHf0IAAzi2YWMyanH3e2xyFW?=
 =?us-ascii?Q?Joeh7DLTJ1S/Sshrn5ncuYADRMROu4DuYLoAnGmLrHlSxF+ETWzaj2WoSRNd?=
 =?us-ascii?Q?cnpG4ACiaSB9l5P+WL6rShAzpBKXnptoyERkEATVYDWvRGj0sPxd5ZtS8Dqt?=
 =?us-ascii?Q?DC6pfolA9Yn8P/Gbrvceim+wUzXKCjnQvYVxWbC+ZgLh+2N/Wgo+D2goxdGz?=
 =?us-ascii?Q?Ca48AHvMpntD9bFtwyoM4kFluTGpZ5dqu1S1gr1Mx4p1g0PAooqimS7uGLTt?=
 =?us-ascii?Q?fnV4TWEHS5X4aMt9/EpUIubye0zLbl7R6MayikXV/v9yyT5WMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFn2jU8P4F2crxb2m4xGraXi7Pi/pLPZrTRCPPql3SM6wsL6+2fxuAnf+w9y?=
 =?us-ascii?Q?q/Y3hZBwEGOBnSvcJrlDXWEvCzu9TzZE661XAzTdauMqSc9/u4UEbvGCy8PJ?=
 =?us-ascii?Q?7eHZqXICfsWoxwahY9v/HQNs8JbiTntocQlkWohgkT1GxFhkpJblTneVo7Vz?=
 =?us-ascii?Q?Nde+Ebh/baLJKGbV2XJ58EJjj8f7dYc4nsyC9DHMz4tuUSVIMto0LFR6wkG8?=
 =?us-ascii?Q?Rkzby+jCaXwPOlX4buyA3SOpiADd4vuPgu+J9pdZWOm2i3qEJU3sTVjMpnH6?=
 =?us-ascii?Q?jDhq8TmInHLzPN+9nulYWtWR+fWc6TGg8hnL2eJbif3CwTLIidhrRex5l5iH?=
 =?us-ascii?Q?sBEHgaBpXMUWIf+flXnEvtAIRR1Uj/F/MsVfFOH1mi/E5HXJ0J+GfMuH3AOa?=
 =?us-ascii?Q?SeD2p4RK7iSfFDg1TxCIl3HAQxBLOpNzwkNfx+3HXg69g0mw/0CEF49/w6Te?=
 =?us-ascii?Q?WerBMVs4yhPUK+DVsVnZxLgSsHkO9XBmS0zEe5oyVKUCEyiFAoRPZSPjq9Ij?=
 =?us-ascii?Q?864Z8E8zfMH8L2WDtiP7j5vV/qkDEC+Vg8L+u7tKC+iP40PFv6KSP3n7tQDO?=
 =?us-ascii?Q?5aMiLmPQQVQv7hcXWqP1RzQPOuehelah/7CLT/BJhDSa+eaUCfPFHAA3z5+Y?=
 =?us-ascii?Q?K9rP7GgdHzPw5B1sdaljUlKLColRSwBLXEuXYDX4yYJUb79d9zTbS5s55ps6?=
 =?us-ascii?Q?IkySGVo2yp6PuOOPCHkkFMz1OM0Dw1qGYDL7O5sZVIA6MTqkc26IVTns0IGJ?=
 =?us-ascii?Q?hWNIP/SKw4SkzPcc0GK8hbJfjRYAtUN6f2GIDk/xjHRbFdu+KPQDCkt40j2u?=
 =?us-ascii?Q?bigeTUEsBLLIJbT/4D66hyH8OkhS96/UVFOdyEtWBdQDzp/WJgJ9kLXXjWIK?=
 =?us-ascii?Q?ebfRL+7OCxmHAp2lIb7pkHsz1ZS161P+uoQPOW80lhSlNZHyP4oMUXU6P2kE?=
 =?us-ascii?Q?I5fgSDg8gHFwEm0T7cimnOx0y9LhRKIa6mp31UUZpZNPp26N8JIujCe10HY2?=
 =?us-ascii?Q?K0FHnP91gl9tLNZz88y8cmMNOmbkBdrkyACd4N5ukFGibT/oWRB+nK76XTLI?=
 =?us-ascii?Q?z8djASbAmUhmK6t02NS29M2FjKZ13EcSOREHJ2+RV7tTBpgYXgapdfIQYkqU?=
 =?us-ascii?Q?1qoXPPTce3oZCMTL9l3/tGn+BXL5Mvkmm8M4O8p1mn/krLzd5lONN4r0MMEY?=
 =?us-ascii?Q?o9yoS1Uli4Z5mVLhTRHG3iD6LwfIrFm07LXS/M6h7t1r4Axvu0pXWpiJLV/6?=
 =?us-ascii?Q?Yy79g603YJfVUNyOGEYOxUbQogfZTzNH1XA68HtJMyyaHdbgXREEHnGCF51G?=
 =?us-ascii?Q?kY1q41vDpAS8uKp7sRPswVoK3sHTZuwUeGYNkayM3mcyZpnyK46hWKGLlGK3?=
 =?us-ascii?Q?B3iXC9bPyEZTqXiwJa8T7xh0ylZIMzNC+1bLdkSw329fonU9J2RSVOz/f33m?=
 =?us-ascii?Q?opu6a4+HNWzgkZLWYWvkImwCHx2LCOp2ZZCcYOPKnmsrNjKYzV7LYCDFJvYu?=
 =?us-ascii?Q?i/oOE9wbe6SmTBikIOqTnmNzmNCs3d/hLi4Ul5uTEoRTlNbWFrQqgU/zZuj0?=
 =?us-ascii?Q?NU/ffWGowcuVu/obBI3c0G9bCDR5AYuyUSvhG/cDksZOTWosDNs59VDI/Prt?=
 =?us-ascii?Q?AMrwJyD7/i17pjwh91IG95g=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c633bb3-6c28-45b9-5b87-08dd20d381bb
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:51:34.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn0a22Y0G3YN/DtR84JRf55+IzX6WQjVhviBO08dJQp88MrLaGJSDyJiD1KgB4MfyYwUD8Jup/FHHpw/Pp81sp8Aluk039fT1GnVLarnEqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1045

From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

The STC3117 provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
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


