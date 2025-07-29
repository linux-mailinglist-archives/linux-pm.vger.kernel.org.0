Return-Path: <linux-pm+bounces-31525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD6B14653
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2496D18973EC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39520FAB2;
	Tue, 29 Jul 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/G0t5Eq"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268C207DF3;
	Tue, 29 Jul 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756676; cv=fail; b=OGdJI0nWS613pNavA++MYNv8u5T3uNnPhyx/DiFIQt1KvgVG0xPn03xeVpbF8+Ub9gsryFw+wt5LcdqwaXWs3RK1VYQOW71lbtdJuxCFgKlwOxE0tR0hn0zfO2TzO2VQyGCZdUoaHFpkR6Q+zeWPVbAPsV14oh+mSfFP0Zvjmuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756676; c=relaxed/simple;
	bh=Q/F+0vy5TIp1l6Wzl1xYYAA+0CWh59m6U0Xpn6LRfk4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=riI/CqII+Y9P1KO8CBu47rGS7gNaU0okx740Tcvp1rDKL+MrstvmGARAN015iKePDwx3+wUz5zMRWy0GJR7e2+CnpaR8l7RXO72O668mUt2uR28mrRFtV+HQ5s4Nue1kkbi0OW1Ev3hyHhx2yvNp/6DdvUhu4hO72jFk6yHPlGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R/G0t5Eq; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAkRUEvmYh2CG9Q0BW3I4hytoICZoYLLQ4kL6meD6knAOF46M3t1H4P31IXEsofx96HaAh0uUZGwUmcL9VgYfAp2vMf06edHi8YI29myWf5HYWtAb52Fo4DYyWDJ40IA0cu/90NxiXmpSm/oYor9/OlSZA/PZr5EeYHcNzRQkGTqgyzx10qJEfIVVbxL+qpW32JR1OT5wCyya+d99cYqriGhnS7lcmIRM8wb+ehyP97Lsqngij0zR1Ox5ITD2OpOvYG6nxsb3gdjvOkzM2VyBHFHUxyvusUsjcsv89SoRwcJdZ2rihtZSbsKiDXuNlCsYapR6g5BiDQz1LXCxJ29jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJkwnbspuN9SEeWotqrkCQ23qMxQXdWKdV9B4Bt6+A4=;
 b=CvyBUkZvRPa1r1MJeyZ0sy+2QzPKtKNNOlQNiSOvRMW7z2mfSefd2uH8/kSzm2Jgsf8c8R3sTRzjyArhs/BDIRdkx/VJ7vIyraXr+cisKVfKaGmm2cRTYC8NSvwUVZb0SrrtY1r+19iNfb599TsF4tgVIV8uv/hBpXFKgX2c0TvhUpGrcVR8i8tXcVUFzWazFH5vrIv7JsR3PjEX9ft09jyAfYyV5MEfZESaLFodLZy6mH9PEiNT/ZaWLLIxTipKiS0YTAQxQwLYOd+oUr16D+dZfXBcmaLiMueMPxA8/KANq0lDXH38nHAIjA6WJb9f03RoeuurIc1dy6NKEgyGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJkwnbspuN9SEeWotqrkCQ23qMxQXdWKdV9B4Bt6+A4=;
 b=R/G0t5Eq0wnnUmv+tlfcwRkVuYT5C92z+orV9wMiALrD/p1dxFzAH0a6w+D5HmRQWOTUFIHLEZw75U26AeOtbmRSS8bGutj32ri0EVkWrHZ4iPFGh/Up+cmpIw8T4hkn7TpoPPuJNBrhqd2uuuJpVZf/V3LA47UNFQr5dObfQjaeewzc/vOW6OVNdmUEBk9xb7WNIGDjKFkJBQEy2rYCm2vGfNuO/TCLCc2LHAiUQN/SCcHkJQBIucfp+z7/sgiZAntGsWAMAshQQfTjlha5andpr/4O/lbDPk+daMwpoe1tMTIRiuuNgIeM9oraHNqO4vt37qQRIeeFSMXQUVL4Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB10732.eurprd04.prod.outlook.com (2603:10a6:150:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 02:37:50 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 02:37:48 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH 1/4] dt-bindings: thermal: qoriq: Update compatible string for imx93
Date: Tue, 29 Jul 2025 10:40:36 +0800
Message-Id: <20250729024039.1223771-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB10732:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8805ed-d707-4ab3-56bd-08ddce48e7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NL+z9O1+z3h/uhDpQza2cdI7hXxavog/AH5f+QLKhiR6yRKLZuniWT5INvu?=
 =?us-ascii?Q?jfvabTfdLj2Q2X0klbh0Vy+fgMPCBkcR8vdHH+/av7jaQ+j2VEGfD8ItVaXh?=
 =?us-ascii?Q?k5aR6XpKMSDlC3Efrr1Y/YD6QYuJBySoZ11axM92DDH9gtXedGs2KTnGFrrA?=
 =?us-ascii?Q?IdAtwoD4Pazu2qIhEsgKf3Ph+YH6TiZuLSZtVm1Ncr+ISG7nXmd+HfWTJSyj?=
 =?us-ascii?Q?+YCBmui/gaYdvWrEN5apGZCTBnKQEZs5UitvDrDTfYnK5BT3fbwoCbKyDWlH?=
 =?us-ascii?Q?YEXuxIrdPiPGmq6n6x7Oo3ixiYdEAD4bBhgoB/MdKKcD9WFW+dkivSnSAQlf?=
 =?us-ascii?Q?srppBA8jaYWJTyUz76YHKE7p+55zmpfB4Su+LfcyGT+6Jw/P7RVNQ15MgsOR?=
 =?us-ascii?Q?i+d2my8s/Wz2VHN8rSk8TZnh2hW9pa51DnlERm6wW0gLn7pvoTKCXLjKyvh4?=
 =?us-ascii?Q?4/1dcI9q0gmImDjpS2Fb8g8+YZ65hmu8FrnzL+hPzViSkIkMofJb34eIMvNu?=
 =?us-ascii?Q?i1CZZy0qqni63F0Gc8Fv6r2c5yc/nf+SnozWNF8fOnU/uCP+TzEk0/pRFVBI?=
 =?us-ascii?Q?F851WLS684w/QOmRkpPPKjuKVis1tHWJ9KM/v2+HL6e/oOIzzBGf1WmaHsBm?=
 =?us-ascii?Q?YBwFuiGpM7aNz1RDt9PldJzPlbQpaDCWaNozuOGINjL0IhkLkODC0kNsCjG7?=
 =?us-ascii?Q?1kkXJEUrvT+rdEN+oe7LvjZYndxnplZCeiUmCsgBu3w2p+9cIeIEieY0S3Cs?=
 =?us-ascii?Q?KkB1grzL8Ffk+qVkypVcrPQDY8qg9eMlhZkRR5DRZ4nhVSTNDg0MzjFD1W4H?=
 =?us-ascii?Q?5C462oiruKCWpEnlKiuejUSruqIm5FJHJAM8w85LJVT/4guc0ghenV6qfH6X?=
 =?us-ascii?Q?rWXLkZFQXmV5pfhnOXiEAbnbI9ZLtXBeBviaH/lBAPRX8SdauMEse3P8uneR?=
 =?us-ascii?Q?scXbf4bNA5ipDasjtpvlrie0+Zy0Eb9YnIiQQkcjHq9sFn6lBCl/XDFAoTHt?=
 =?us-ascii?Q?2nLdWWgPmbwqkxNO9moOhqvRtzBoK9Txb9F8yqEyG8isCnMzdqoXC1tLdrn8?=
 =?us-ascii?Q?2TtOhqTeSt73usqWhXS2RGaVweDSJKOhlt8pw15p02BJdb8NTD1qubsxL+d2?=
 =?us-ascii?Q?XwTE7EropF2qf5LXsVUAcBICr2qSIj79t5Yh9Re131J5pJlHdNXvt4mjSHkw?=
 =?us-ascii?Q?+iESbmR/1l3x6odJtc2jhEaJ311ksJJNcZ4oPRsnqFF2CggytKbc4XeBTEwj?=
 =?us-ascii?Q?tUZnEWDy2k55CoVFP3VmFoP7oK+jKiRN1yRXqdEuQU+oJLO/D8wHOYSR8PQL?=
 =?us-ascii?Q?r/E30vGvHtq+oIGyDmhmkbsQiqoTRpnLZz6+Jc+nKBvibEptXw7NIFbWSk7o?=
 =?us-ascii?Q?ws+csWEk3M6xoThOfhb+5IFAxLdALMFr3CI9rS425UXHJ2mKeEDHo4CqbJ9z?=
 =?us-ascii?Q?4+uO5FuqU8E89kCNzLWWq3SstpCcNS51qnua2Uwe14a8PRU95gGPAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCiBSx9dxk5dzyXQAWwF20O/O2qFRl2lsDKmqduS3zVmjJ9CnsGYXiIS/isB?=
 =?us-ascii?Q?FIJiV/K/jjmNiyrQ2KsAK20UHmQFRELvoEb3FnN3kzf1CZ/xseyl0A3uuRpj?=
 =?us-ascii?Q?raln8UoKUEcD6e9IQsjNukrT2ktt8gYCO4E+CEt6MbG2La/DWTF69ZjOZxDL?=
 =?us-ascii?Q?W8pYGqFPv4Dj6RF/X3UiJEv12c9lhJ/LZkxEOQLSNdVeyO2pFmjtp6Rs/j/P?=
 =?us-ascii?Q?jblc8V5vXkOiWxasZBkZzzPh65TZtxRP80wucZZqlmoePrgY3hzsbSXjxxVi?=
 =?us-ascii?Q?Rc6C9AXXG/NnBzWIjYBtpjpy9DkbC9wv21K6ip2fUy2jUfTivD+6m+ph2myi?=
 =?us-ascii?Q?XwCDAP93MqBw6be74hKUWEbqn5qBaggFmnzy1+bIxPxcIiixK1bn4rWTlfUe?=
 =?us-ascii?Q?hrtvo54h3Es1GjsCJg60TiCFxVRLzp42mGgfpI0MUBbEfJRjBXYkfnnXzvuR?=
 =?us-ascii?Q?hWabCt2QMABR5vn7zZEnL7rwknZ4CaBlUCv0DLv3gQe1VU217pvP6RE/LWUw?=
 =?us-ascii?Q?5jBMNHXawXCUqOF0v4Q/PRT6900dNh6d8dYXws1yyeMTthw4UFOxhu93SI+q?=
 =?us-ascii?Q?E83KXLplCIb6GSPyfnitamdlCsNheeW+7YTIbNxP8b3estmyGi7kGn8uho1Y?=
 =?us-ascii?Q?Hbe0liUssFR2fzEOOlKMx0D2RSgavYSdUgNCpByBYUypVO6wonakk4SNaB9Z?=
 =?us-ascii?Q?uEOz1+0ncoa32ccfrZnVTGLBjsfZBqy4dnUNo4oOvVCQI/f0TfdXxM/BO5uH?=
 =?us-ascii?Q?QNS5McbhrOkXGQXK+j5PfBbYXb+qFM9EyJ84EeoxfYBmsRuMAiT7DWlD4Vr9?=
 =?us-ascii?Q?bbRr+TMzSCWSyaCqJA5F++9PsRVQ5TrcX6djD47Si+fGyLUZoLPsshvimEOb?=
 =?us-ascii?Q?WwJyJiICLMZbzPCuyUyUA/TF+CW46g2m9nIsx/vMvXbf3Az/vT2AXCooTgZd?=
 =?us-ascii?Q?EnSuJM7BpE0bQlhKDVfdNIU4ZyHK09z+jj+26ZCiRqzZWmmwld+LHOjatUIM?=
 =?us-ascii?Q?mHhvxJgTRQBjzPLhVqq0j7h9avyUZ4+hqt/0lEiaTuvDRW77LMCvAaAsaF/T?=
 =?us-ascii?Q?Ay1qSy70HlwK3/qcvDsrgUHSMIyVjEgnZ9rAPdLLcNwsMOeV4Pj+F9q4P0Mv?=
 =?us-ascii?Q?C9ZkZdp3SNReDEQdanTImgOoej+tuurQ6WoUA60lGo4ROybCoRy0AYsBq/qU?=
 =?us-ascii?Q?SLAv3QSvWY5We7lqbTYzci0ks7q2CP7Anhc82Ka+qUbrwEb/Mxk6LD/Sle9t?=
 =?us-ascii?Q?JOjjtDx20h9GrfPzFdtPU6Rp+8uzhp0YMepWjoKuxS6/ZS11IdwrjQEQYGjA?=
 =?us-ascii?Q?jzXMv/MYiY+G/AfIbHIVm3ZjYn4u+Dxv1r9a+nj3JwlA62IqLoE6ACOgU7Cj?=
 =?us-ascii?Q?CnVuin6M3BmtPMKXvezlHLcSz9pFGvb5NiBnx1Q9FsdQmNLxhK2tgH6v+zpd?=
 =?us-ascii?Q?8yu4iOrH9tn+/40XzoBz2Io71PR1zGkrC3NXxeuBobboUD3FiILcebTE3udT?=
 =?us-ascii?Q?yYwWvMqwIwIBGK005rjny8rO4+HQdkgK5OYIlzZ6TicyFFxBnxHxojoX9fjT?=
 =?us-ascii?Q?phApycfDoWqW2VYT44zZ+qBYqIYPf+8s/l5WaDW6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8805ed-d707-4ab3-56bd-08ddce48e7cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 02:37:48.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXEjy88Iibf2aQwL0sanz05j3mt98kmcXY1oQjpi/ip5JDGeGbPZ5nRwGlj+nxU7QUXJB5u/f+xVLOY/4jg2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10732

The TMU used on i.MX93 has some slight differances and bugs compared to
the one used on qoriq platform even the basic function is the same. Add
imx93 specific compatible string and keep the fallback ability.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 .../devicetree/bindings/thermal/qoriq-thermal.yaml       | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index aa756dae512a..cc65e210e26b 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -22,9 +22,12 @@ properties:
             Value           Device
             ----------      -----
             0x01900102      T1040
-    enum:
-      - fsl,qoriq-tmu
-      - fsl,imx8mq-tmu
+    oneOf:
+      - const: fsl,qoriq-tmu
+      - const: fsl,imx8mq-tmu
+      - items:
+          - const: fsl,imx93-tmu
+          - const: fsl,qoriq-tmu
 
   reg:
     maxItems: 1
-- 
2.34.1


