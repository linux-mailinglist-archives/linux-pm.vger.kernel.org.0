Return-Path: <linux-pm+bounces-31455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EAB1356B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598D03B6153
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B89223301;
	Mon, 28 Jul 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U5b2qmYu"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1D1B3923;
	Mon, 28 Jul 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686962; cv=fail; b=ahacrlkvRizm6dSv7TR77Q8zbfjzcW4c50plaGbym4d4HiLaHOxGgowz7GbvjHwWKWpiuGhpvxWpvia1tVRY4tVPpk21AOgDuiu38ZXWiAOgaPHpIPaDysdd+fbyMxfVVTiMczTEG8DCGM55Xg8ov3H9kMUnGdrqr7NeW6I55OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686962; c=relaxed/simple;
	bh=gy4PIVa7pF9d3Fqp3KPG//DHaHh1XzzdWyljJ8K4K04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5M3Ab10z0eOsNj1s81RryhIBJk4EkghVtNVk1KwTVHBp/ouCppga/PHW9rJDt6OPf9fGQguyWE+NFoFDqfd+jvgvn7wL2YJR99UtqnTtFmm5kB7h/SSAT83dOEnTTgR+KltVDOy6bBq5+6WDfYqJeID1tH2sjijCluKWtmQOv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U5b2qmYu; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9QOMDG7lAISrgwsy/OQkZ4tNSUuAwTZfYKd464PkRv7xnH4nq+PcCRl1kc6GQEfZzcm1ex2vXBoTttPall8uj+q+ZAx/OqQIZR0Bprt19eAHtokWuoZJbPWfaZQfDBI8d6RThTj2ZcxT5r3+XevruQ2ZowEQM3P9CsaP6UEJ4ePeZ1nP554f/99EAZahLedFAbav2eGqp7ZOR9oHSupEJ7HPVtoR67ZANDHSoIwSnFKBofuwxYz4RlvgJkHJjh97FSTFu1T8dqPIYTHDtdMq2BXOFvE+t2oT0eu4zsWuNwfxKQBGhptEU8Dkm+dDZTeoVautxspHFTd5MPLHjC2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbE+66LFmQJo5J/dMPCr9Rnd6W1EQB/Bi7cKlFllcso=;
 b=iPyaZ8nqLAsLXxQtSRbECYOYTvc+aFEGhDOMBqoJjNGubIRjWaiuPfUGiUKSznHURLvBHg877t02wAVjoNg4oW9muGoc85btPDKmbPG/9eCJK3j0K78tWAKN90HVOMU3Fiz89HbLsY76aELeAJsBcX9c2DuEbTfpWy2KvgPVmhBy6kLlDtelbN/ZUcJZAVjuKEON2RnHF6gLBGEpM7he3BCQhXaawfD7SLonmqp+7ZodyLRoxCFJShKF2/khtHOP7PiZv0jO8mVp7AqPfSxtbl2VgolUJxytm9a94jQrn1YXwZpKB+HaDMGelOFpueoXGKZOKf2mELoCowLE51iyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbE+66LFmQJo5J/dMPCr9Rnd6W1EQB/Bi7cKlFllcso=;
 b=U5b2qmYu0B47C9uabEh2nNg6+ViyfKizoKPjgb5dZKyI5rZwPbtmP3VDN0X0LdK6AVPKCgakEdhoiUuyA/K7pjiCUvRZ2a7WlIbKYqz2oqcB+Gnh0m5e+6Zoi0LpxvX/hcziCHE2eatbowvsk2JaURo/PSzAdDhrjxO5SnrVOrRcMib/jEWAimuH4+f4rRWRGqXsV3onwrb/pMLrWuI6UMEHw9ECXkwrSGlRA4u6Pt+aYO+vAT3LuwdnTaWCNMZr3akyq06sgpEV2x9GshgpvTgmEm+72hscATLYd1flygCCrdZ71vYQHfrTftKx499JG7UESMhvBIlIpbZbdWxvFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by MRWPR04MB11489.eurprd04.prod.outlook.com (2603:10a6:501:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:15:57 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:15:57 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	richardcochran@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	frieder.schrempf@kontron.de,
	primoz.fiser@norik.com,
	othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: [PATCH v7 01/11] dt-bindings: arm: fsl: add i.MX91 11x11 evk board
Date: Mon, 28 Jul 2025 15:14:28 +0800
Message-Id: <20250728071438.2332382-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250728071438.2332382-1-joy.zou@nxp.com>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|MRWPR04MB11489:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0496d3-bf5a-46d4-ed94-08ddcda698c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yixHe1MFd923jXCyw/17ygu/0Nz11HwNm6lOmwdsytwwUj2P7QUzoGn0pAd0?=
 =?us-ascii?Q?wzoDx75pizFfHSdRySXGkgf74YZ4s1DVkPX9Ar27U5AgQS+kv7TQDZRml7PE?=
 =?us-ascii?Q?7R10j6/HrO01dnihvPy+t3nABNnOl9YNMhEV/elfr8juCU+Aw425gg4SPbHu?=
 =?us-ascii?Q?dwoFHHL7zzTp3OK4LDY59ScJVHNDYavgKwe8Qpth0Wp+H4aAJy3WIQwrElwp?=
 =?us-ascii?Q?L7G3ySbdKm3KDm2qRN13Dewf3ZHxoMlpDWdrI5QOCkiqGNdNXly/DHgzs10Q?=
 =?us-ascii?Q?oDgL9bhOWdV/0gfFjIGvYZTAQRsdeHY7V5LuoQ+6VNVwDWrFAxWqp5s+o/Ax?=
 =?us-ascii?Q?hNoAEz8yjDxZxmuC5HgHwMhGJhtz47HUc2WnHD8QCxCuChB/rxbK24+iqE7E?=
 =?us-ascii?Q?DlpB2kAUMR8u0Vtro5W5iMSJUjrREz1RKOkZKBTw2vFND7vdp5voj6TUjQJF?=
 =?us-ascii?Q?LxJBR47p5pnyMhJio3OO9ERvCmuJNOhijAvGn0ktVx+Atd9j8Rnilj24DyZF?=
 =?us-ascii?Q?OoRoM9fpou5s+ibDsL4SwRVOara/mli97+21hextXOnhVDrSLAdgwCEQcBgD?=
 =?us-ascii?Q?UZhmhoSKKLNJuXjFnY9w4JhBYhjGhDqC5MTZ+lYFrVV7e/Xu0ZB/heXeVxEG?=
 =?us-ascii?Q?v412EMn+VKo8yfEIIFHP9mSDq9d06E/047siIooWs6cO9oN8NKb4eKsjmYMU?=
 =?us-ascii?Q?NQyxfOLpI1czkXiqpnXDuqxc39EzQsYj+ffQEJx2J7jv6IwWZBs/oLx5Hd3V?=
 =?us-ascii?Q?bNs8CH00rtRM/qBDVZg8rqWKS+0Dsnl1yslXcmiwnF8JxZP0hfyiyN9FseHU?=
 =?us-ascii?Q?P+jNkqRh2UdFmuH98gIpRSSTRnHkiP1KIm2bxOqGHNM/7MEqwQD/A/44qbmc?=
 =?us-ascii?Q?wR98EN2Iq3sJeAl4nZhNPk0ON8hNAhjHG5GWeqI2mPPtvj8wY1kYHYJ51DA6?=
 =?us-ascii?Q?FVR0I7PKckw3q6IrhUTtw5Q4e6A17mDUJbHOZIQBWh1lQVHdoEu5xOl16x9L?=
 =?us-ascii?Q?/6WmjKy3TCJMn8y1S1e+qpDvJwiVY28xsNHggLkTWjc52g6++ftmNxTukqxO?=
 =?us-ascii?Q?dhzduSXsWt5Z2vbX6Z0lsLYP19UGwtxuQBhVAufcebjjcdwH3iAC1Nu8/OWU?=
 =?us-ascii?Q?E/Myf1AG+vmCUpX6B2j2mmX+DtjfY4DRoOSIdv6ZyiiY4SZy0EoyqZNWxwEK?=
 =?us-ascii?Q?WOpinvkbkg+AsdmHnRTsW99zws+UCFhXKD+JhgZAzbFd3+GhbWhnzRTlg6of?=
 =?us-ascii?Q?z+bMhW3dAMxKq+zxeh1pwKdAx9WASDI0Wq1wON4qvkmBhK5urR9BfYV5obcz?=
 =?us-ascii?Q?mYHV4dapi/HgEwWu2davlktrmYeG+N0ZsfSnaSN3eLUpbefvwJyhYWvpI4+Z?=
 =?us-ascii?Q?gc1PkvUShKZok5IbGvYq1FYktzpKkkw0eDpUPwzaOH+HeYGlYV055+pDZFDp?=
 =?us-ascii?Q?6R78wi6Ab4g5WHBmy6TOXyaz9v7fO7mgkhveto3HICbsp4eJIX6nNIwW9UlF?=
 =?us-ascii?Q?O2j6HGk4X/CKdE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0nhRlwIYVOsFIxHF63nrTzBFLDSZH0ZvLzZM/AnBxFzpcqOo0a8Tcq/h447+?=
 =?us-ascii?Q?4Zuz3h8U/vIwi36EdTy86zhIzVRn0XDSv5vcTIL3YnFHFXilXyFV5UOcPIqG?=
 =?us-ascii?Q?dLVgWxwEf7TDsYB9xM+0YMkiDnH3tEZ3KVXk8f/qEja+Zx3g4jASTnXddNLS?=
 =?us-ascii?Q?ABKsuRNvoXrgSF+c/qqfwsuaVr8aKPujkzq7jQc8WrHrelpyxeVkPeu/Be/o?=
 =?us-ascii?Q?Ppra2qosIOxvieeC54foKfov1wQC08NAvtqQGfpMHyuKmCP/FLVxaQ7Y1Dgl?=
 =?us-ascii?Q?Os+gONWWZqeLryjEPUxxZXG0c6enBFnTFp5Ef7bZj3hbKPHzl04W3rsLFa7D?=
 =?us-ascii?Q?tq1O6IrNcFokcz+I4fC2Z6EvOY30eMv/wRsnlYQoSw/Mtot4sLZKgL2pdPk5?=
 =?us-ascii?Q?EkVtYFHIU272Q764Joiiuwhi+FVwHnTGmsN92dDW/7v6f/nyYdEOXDWkwPfp?=
 =?us-ascii?Q?Hb0tYmcDcTHRI7Ft7xKZHPegkJS+uwL+wKr0zxhnq6axettLyNVNWaQRFB8c?=
 =?us-ascii?Q?hrfJDSquqlk8LV/2S/gjDU1/Yh+autrhuWWXqXfmnq71pRSxHwEOHhWw2SA/?=
 =?us-ascii?Q?cjQa+i45DoVKObNGQZzkSeE6QsW57AdFItj5Ckq9iwQd87t+locp7gpLEQej?=
 =?us-ascii?Q?qDScPu4u5pUFAsUiUcEps/hmZf6IrcweQBQjmadd3s1LK+6c1JhQ/gxF1PjW?=
 =?us-ascii?Q?gI/o/HCyvs9JoNJYOp2V4nB8Lfhm9dNVR0mqdBY7hEPxorWkufzRZ23hNSXQ?=
 =?us-ascii?Q?6JqmLujRim+bE/3tX0NAV5REmOIQ1kSKoij4jO1ZHIXQ4QaJFQh1fzLCjRtH?=
 =?us-ascii?Q?CS7q6PP4LjW6T8qWsX3vWdLFlFQhkEsQ2DAq+6fv7dzWPFBz6cf4k14FHTCw?=
 =?us-ascii?Q?p0HzgE1MBCoLIuhVz9pmvEKGTGSCtLcTt1vFCUHQy+2FWVawk7v2V6B1+jZA?=
 =?us-ascii?Q?h07vt4CgBeLWf8KeDorPDW31rYDr1TQM+1G1pzWZ2tKi/BFXbfcHz0NXgLKq?=
 =?us-ascii?Q?FQ1LuLygUode+ej4ANPSXqKa1UMhlKlM0uRNewLBGjAFasQ2vrvbvOkRQvUE?=
 =?us-ascii?Q?y4HEgLylpIV7zpeEL3yM50KBvhM5i6utwmFJXCROPaYOuTal7rfAehMYdxHx?=
 =?us-ascii?Q?b45Dcx7AuYVyeFKkrsVBYJQH4o2hhWVCA8fmyccSecJsAjuKC+ZsRtPQEY1F?=
 =?us-ascii?Q?FRBudHOquCdlCR+YwRT8RhCWwWbCFZbigCD+6B51Vn+TMn2DPCrOy/MSqil+?=
 =?us-ascii?Q?C8WrrotwVuafJUYassQG7VbcWB0NU5yOe1PdO5qsAjk7O5gTXWflWoNyEY8J?=
 =?us-ascii?Q?yZ84jqiCKJ3ZAe0uzuG1C2zMhcxVg/6ajJLiSun1rzgFpjwBMC8aP+QJsnk6?=
 =?us-ascii?Q?rU1xHSZnnTLyM2eceBaHM2nf4ZsTs4qRRCYZi1SFQ2cz0KIx5hLJBgiZ2BOh?=
 =?us-ascii?Q?ED72DHSYClEt7e+5wi6LP9gKZKkJ1CQVWSkQbN91BR/Z34r66x2/0QbT+qy3?=
 =?us-ascii?Q?fWwOG3VnMTao+hddC4qbSImXfpDL1/fOjInyRhRdviaDXzCEcxygqxOhhYby?=
 =?us-ascii?Q?G8UJABOEImKmkJDEEW0Hl/7A/fBmm2qmuXmf9I3S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0496d3-bf5a-46d4-ed94-08ddcda698c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:15:57.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByTLN8WiUgdrV+tOdOKR+nC5QffM1IPDJjoU+Vy0tZanuntq7S7QiVB3euen+NIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11489

From: Pengfei Li <pengfei.li_1@nxp.com>

Add the board imx91-11x11-evk in the binding document.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes for v6:
1. correct the commit message spell.

Changes for v3:
1. add Acked-by tag.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d3b5e6923e41..a778666b1d42 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1374,6 +1374,12 @@ properties:
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
+      - description: i.MX91 based Boards
+        items:
+          - enum:
+              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
+          - const: fsl,imx91
+
       - description: i.MX93 based Boards
         items:
           - enum:
-- 
2.37.1


