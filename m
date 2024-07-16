Return-Path: <linux-pm+bounces-11138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DF932316
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E6B233A4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7536197543;
	Tue, 16 Jul 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CKSzvqjZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2030.outbound.protection.outlook.com [40.92.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1929CF7;
	Tue, 16 Jul 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122980; cv=fail; b=F0wHRkdt0qO7ohcgd06kiake+THg6Ydo/74+lLbKebQ34Nz9VEi7V9BUsnOcvyCfk7UOXdtlGgfFO55DTE/HnE6c7E4LhbpbQYDfBOipL+cJ6z7ISV7iIMtg2va+rsA2H+76KoQYYwCG0oxOHSJvC0RZW1y4CtV0mrmMRTBNZUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122980; c=relaxed/simple;
	bh=8LbFi7mRLScEKFhX+mQBoBWZd3pdSQRX/c7QqeRVBeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9jvC3SoPR8d5CXqv9d4fhLKibl7scqA+ybExnNz5IsZjQSFBNqogiB7Zm1lbKrDhnWpwAvvmcqFtzsXXJXo5EnMDPzvIUrabMZdTMVndwP9katkI0afdIAxtOJaay66I+OF05v0OVH54Qgbi8PktLAU9BGgp55fNQKG2ofeOhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CKSzvqjZ; arc=fail smtp.client-ip=40.92.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmfHeKVT9rd0cmopCHj6eXGs8zC6E4D3PWZUZ21kJqEwERszFDDeeLI9flAunEOkkVU2ed1+KzxjXyUJ4Z5hWurXnuNoykiLM1stvxBYXy8lRC7YhEMHOWkvqC08v5njkQMmT8iiwx+swvOGxSWf83ozPue4YxlMewLYM+Uu6V5h8//Z5LJvJxd0IXYCmA1KqPdkqTki9xnHaUJmwJ0E0XYsok4s4M19VC1krJGGH5T1iH7rv7exDJjJjX2NBgskUxwTnX9XIfvq5vCtSj8V97zRZL2RNPRhRPUP/xK/AUTTJ+Vb5j10uXDMPHik62Fs6V9BYUc+nQf1ksoL0z8MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbxh3994dy47RBIvBkHXTKHUnWsOTKtRuj1dxcRmpoo=;
 b=sgGVnwRPsukO1LXQWVZVIJsY20Gw5V0LxF+VWM6rASzA8lIlIpjBww0Mktab4UlEGtdqAZ/PR2omiTLZWvSy6FkhykjZlLrMO/SoV5VInD5XRJHqtj8c8/TuRtViZMJEOIlDnaK/I2Q5U8cQRO152dtal+S3LnbFX7TS/TVmeF2CbnzLTNOZuiA2qvxaY22fp12Gm8jtY4TF9DbODAe0aRZQBG/cY8JaP448+sWnBSwtj1Ro5tIcnP2w0cF40VxHcQPxzV5bnRX+wWVc+Lk+ceHikKA8WZNjtujIrH8zaj1FQnRmyaRE6pFezbWXizyB1rq7EaPgoBx1quBQvF+d1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbxh3994dy47RBIvBkHXTKHUnWsOTKtRuj1dxcRmpoo=;
 b=CKSzvqjZTYToaibFPfKrL3rrW5DbsTmmlHBI0chDPLmYqj8w2Gpvgxm7gq+NZAg1vGtUcPySKlUijTPfP5s2LJrwQ09UdQQLwyjiTXJKlerAcvYyBwpy/hy7UBLf+6bJ8wbtvYnlt0jjGDEIbZhbt6McVuWvsOKgl7hyQOl5w4WMmEq4f0A+IKeSFCCo3JAFsaeZuKl6rCUfoGKOoxpC/JF6x1RupYqsL2Z/F4aQ6KuNK57/MN9DaCk8TtdnBmknSy/EhGy41y7mS5NVEIaRoeG1EefppNfhaVG1phin5KAlKCVetHChG6Zir5JjoE53BuhRB/MLsv3ZOc/wU9UP3w==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4895.apcprd01.prod.exchangelabs.com
 (2603:1096:400:281::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:42:53 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:42:53 +0000
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
Subject: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add Sophgo CV1800 thermal
Date: Tue, 16 Jul 2024 09:42:33 +0000
Message-ID:
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1Qn/yyu0Ed40mCrve2gGJ9XcE7GsJTCu]
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240716094235.51679-1-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2c4cc3-c0ca-43f0-5e72-08dca57baa1c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|1602099012|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	V7lr/FDHl8Ec1JTwZZS0PGzY1urQpM3EcR3NmY1uiH9un4Tb9wUalv1xT2EkjUe2L3jBjQAaBl6/Brk8ZQmuyGdmSo6cPf/8vy5LfGsGJahcf0qdSM/ctdvi8IF6WbehMpoQ2X8VFnYGvqKrhNN7GcENijDLQSrpyhfo++5XCiMTpFuX2vvRnZKgy4boorNgiqXfQrHBGOWOMi3jkCXDsxeLZclwvnDr/xV00v50wS8oykMAtFX5gfJdBfKGH5SE1DZ08R5FAPB6K3E5FMw2mEMhcwqxN2g62zZRjS0Wo+cc0bGnYNi1tGF/XDeocbYejua0wnH8r30EQPOqSJukMR70iGDa8fWGi4q4qGgvY83zLsH6TjjpmN76Xzgi+b84PPk2rYa1SQKz8sRsiJe05Yoaynqisok/4H99cUOCUYCHaPG93jMO3YcVjLUmz8pS9XLewXKl2mZ6hncdtIn8pkMnsDLWJmoExqbUbdSdQZMSvqjAuJWuhBd1j6ecqxuLEf3F6zOgj0a89/k+BgEhaeZRu2PryyvaMUXDUM/nNcXhiugyfkYdqUyI5viPUzavKX2Uojrrv+mk52bMSuOxsBMzaX12wnL7u/rnX0oJ2iXieAvcZ83lhc+JYYkG2sRNWgWo9bm7CdYQLMJmHeT/b2uPcuGjmJIaojoZdjaCDKtPzZC3f76LdsJzye5T/mozJJfkujdcrPGF8sa3gTh6Ta2wzaAhtcdcIAcwLD+m1XYvjjQPIe9jNIYX1Jg7dRvyS3b4S3El0Q+pAdCugH/gaWY99pq2F4Dsi54pJnmNbQs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xb+L6Y+pYmarK38hVl2dajbNKM5kwKT6yYPBlF7KEtAdwXj4QBAhgBsxh3OL?=
 =?us-ascii?Q?oNrinW+vFxrAGMv00ff53Muo9bXVaCG+h2ulzcdX5YvFdokoAy5CnLKejXot?=
 =?us-ascii?Q?AB2uCB96SZkjs5WYWLL57EuketinvIAqz0vBAQyFp+y9r/L4uJt0gIsnx+6s?=
 =?us-ascii?Q?0qHHDBShXhfQSuxS42vJFSrNdS330dTbVoU8xR3oD/Z4Q38QaKksVUvuKv5d?=
 =?us-ascii?Q?i5YLx8Zu7MIJCd+C3+XCpnoh1o4UU2NrRcd8c7obEVLxxVoxg51/rSI+XudK?=
 =?us-ascii?Q?bNWX3heypDIw//xfXmX65ej9QdnmraHZ/iCSGvaeSfOg8Z/lp5p6MuqFOUMO?=
 =?us-ascii?Q?NTKN4e7+wvwBfRJIU8Uj0oRwWnDnuCNkmL7iiiqI9WaWByUSw8HFTewsC9mp?=
 =?us-ascii?Q?WNt7/ffRnHC+raJrhRWRpoVwhzOaO76F+Nb+M0Iu5tkS0XFLlyaPLAjNeVpL?=
 =?us-ascii?Q?ONcPR4jMF+J4Ml1yOpfkClsNZyvLJuZLo8ZMf6kGpBxEJByGixtUcdG/ythj?=
 =?us-ascii?Q?YZIgnHKTrO2K9eu9602V159CkP9rVAosT9zVkbQ4zMbWpTYB6mFG6WcDVkjt?=
 =?us-ascii?Q?H6nZkKPVcZDR7gGbyqMdp+QQ/mnjfq2phZzHPlgK0QY1IQR8QHgs7nbm8stM?=
 =?us-ascii?Q?ZxYnCbRgdHLR8WpIlTGOw/ds9HuBUeSuhkZtNfRjKcP8LYleLGL7r0hX9jN5?=
 =?us-ascii?Q?5AcYETdJ/mLycOrz3wtRr/HCJfMQcpOYdnbrf8EoZu2TZxQHtilnA9MJMPMT?=
 =?us-ascii?Q?mKvIk+YNSr2d6p8ftku7IZvO1XGmmsCVUsKWg9FMZSrFm+P+EKGSEgT3fL8I?=
 =?us-ascii?Q?PiuxYHrnqrURa+sZUgtMN75kiReF9v0ACZWdIRBtaTvm8vLyMrzEyco72O6x?=
 =?us-ascii?Q?rvqZ4XnzKvVWwW5fQruRYKVr80255hRA9HQShb7EnRVS/JM2mKSgRaeiTgiV?=
 =?us-ascii?Q?GfdRVatpAM70pY/Q8yIXf2OQQsSrR0ZBxXOQnO+fDyLYs5NVuPbIP+9krRZT?=
 =?us-ascii?Q?GkIVbeh9ruZxj8rzeu6cgMo+oW5WyYQKgCCaLrVmt+w2xqlQwuHtlP7SP/9X?=
 =?us-ascii?Q?SvMrwCxxg+dJ8Qjaq2ETPoszVZRwEjD3WinFYDYu6THl3V4RDwgLhGzIcUWT?=
 =?us-ascii?Q?BXiOberBm9+lnoK0o8vgnD/VOG9gN3BcNKMWmC+I5YRgTs60P7B95/IfF14e?=
 =?us-ascii?Q?ZQGjkOunkDJydB6uBQI7FHibaqXZ9y9Xv8i0cfeh4B5JLujrCa0vN9UIdNc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2c4cc3-c0ca-43f0-5e72-08dca57baa1c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:42:53.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4895

Add devicetree binding documentation for thermal sensors integrated in
Sophgo CV180X SoCs.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 .../thermal/sophgo,cv1800-thermal.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
new file mode 100644
index 000000000000..58bd4432cd10
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
@@ -0,0 +1,55 @@
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
+description: Sophgo CV1800 on-SoC thermal sensor
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
+  sample-rate-hz:
+    minimum: 1
+    maximum: 1908
+    default: 1
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


