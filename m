Return-Path: <linux-pm+bounces-18835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38D9E9C12
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD2282EBB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4535733A;
	Mon,  9 Dec 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RpS01W+V"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41914B95A;
	Mon,  9 Dec 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762963; cv=fail; b=uu9LxNUEpeeiFHp+WdIah8jL7DXvvpu4Chl9OeaIB6BfraOkZ2lXZDogSG+qK1vWSCmt9X4kfO7UAZUK+4+qR+8j0H8BPvYXi+Y2AYIObFg9HPkYA21THtXCDr4RHUPAnsdjr3yPOTI3TZ7mKYwXTJuv55OxElIQpZsAN12dzvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762963; c=relaxed/simple;
	bh=omUIftEP7o+HSDpUoFWR2C6XUlYLpqYpuOa+jDZd1Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAgSsbYu+l6D6uA7ZxyU8nTKaqyNsjon82pzwTnha00/OZiCXEL32GNM6cLNEDPpE7tc8IsfCaWRswaV0+pAB9NmYUMmpvnQ53l8RwpvJ8J9da3wmQLlXWW3MASdg976SzzjqUgCc2POb8T9TDs5wnC3YkZA6KUUXrUfTFR5AFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RpS01W+V; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJ3gTaO1xTE/+4sxLEHHfBiL/kKsBCwetVRBGJCWdBB1vZHjuOMiZGp4nBrvlm4JN024t8Mll6x6H8i6hsXTinsE0rMjopENM9GYRYyBghBRMSupNy2dqvW/RFU689iBr3rQEiir8aB88qCFc22VMVes2K0DSJ0BBtWvBYXCrPj4dpQuVL1zyw82avhLBLUMQIQh3O+x3wNEqm/dgO1sEQYAzW7i+lH5KsQF8qY5EwsFrFXHJ1sVPsq90LkdAUcLzJYKKUkt/MrGJMANEvarhHZyuEEpVtJB4gLFrpdUJIrBBQ2O86g4RhxjewDnsVrTP9CMOaMCQD9hcUjICwYKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGmHhO2fhYcq9dZEIXaDKnN4Ef3FSlUM6IqNGPiIur0=;
 b=XX3N5a3uT5A3oXQZDkNWB6yql6ar2SjD+eHJPB5oO1gySNjPAOWWQ5dQcellNJ6mn9JOWbcMkcxIEUecLctSy5nlnO6YIzDXUmMlQgta8MlavPJr5KE7upQxr7g9uq6cW1bPOPXBDCJzYAULlkeKELLvPdp8LahFtQdg2IS87V3Tmkb9rYOaQ+FLCaDHmdnt6EXfZDqY3dQntQx21PX0OFFzxUs2K4edh71/QVtqAw4iCmcitjcPrmS5useGAe6ZHzbM2jKG8mz+VBiy1tKHXXBdsv+urtZEotZMElql8XbJZK41WiWF5Tnb85t3YlinfmAHFu8kgtiQ1QI109tIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGmHhO2fhYcq9dZEIXaDKnN4Ef3FSlUM6IqNGPiIur0=;
 b=RpS01W+VFW2vjNQhaM+LabdePMSpxgFLmzBALjUe4G43XfUSPAXiSmD1uD81UW4oy8LcphbnJ7gY59jEjqXAR8cTB3gfCnAamBI5SjDw5PXu2b2OfDhbremqIGTdVVdf9XlFjXGjmFsDXInPkMAPQoAdUym7P/TEaymsp02JrarilcaK6xx83BPvGWymi2cBUZjitArfiunEhO7t0OOvB0azb61n8VfO9HdX5fRHhvui07utD/T5aPPU97Y72v6SAY/F1xtzx1jvz1b3JnWDUdit3B55kjKwbadlcqi1CRNnlL6nsr5dF15+NalFr1cQ/vC9RyJXA4en4FoyJKEXzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10022.eurprd04.prod.outlook.com (2603:10a6:150:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 16:49:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 16:49:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 2/2] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Mon,  9 Dec 2024 11:48:59 -0500
Message-Id: <20241209164859.3758906-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209164859.3758906-1-Frank.Li@nxp.com>
References: <20241209164859.3758906-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a8a512-42ca-4960-5b09-08dd18716c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqFJbPWaIEgPRUms/0DfUoPhHVn631Ioole7ehateJj5LMSN1MA+q0Z081hw?=
 =?us-ascii?Q?WZtH4ZqSgUDm9WqDWav3Tls6uUP6zsb1hmwG7Vfsi69uBu04Fwy51NBZiI51?=
 =?us-ascii?Q?F4ZGqw1feX/eZTPIGId5T1JKpDehxxRToSvlVQpZYVMD3mxEcbejQZREuPIh?=
 =?us-ascii?Q?k6zF+8SiAILTKUd7cKuQrQb/VZ50vR1H6c/O4xefhP+lCNC1y/hfd1UUCJ4z?=
 =?us-ascii?Q?ZqNo3gO1hY/IKzht2z9mOi/ESWHLnGfDA7yIHGbOFuo/xC/l0h6CEku3Gkn+?=
 =?us-ascii?Q?HGnirHpgNJ6dBHZqHOjGRi7og/qQ7JWGc7zx5XVC/mgr+FSRLY2O1cpLvLVj?=
 =?us-ascii?Q?wGDncoAV/Kw2acR/8z1+R+CEzLychHHOfAh54qw3o/t9Hq8qInRVRWVEU+9s?=
 =?us-ascii?Q?662B1g+T4I4H3whRVT0SBxR2RPfVThYASgfXMFx9cdbSjrQ7s/U2PlMfYqrP?=
 =?us-ascii?Q?FL89HlhhpQhekppXVCPEmGhK4j235u/SvxXLxPHh/cGhdZIXaYjmESOpk23J?=
 =?us-ascii?Q?Eg+Ovy6lTVplsqRGRLMwpSEnFfctScOqvXpsUa5JTjDnb7haVqu7d7msHO40?=
 =?us-ascii?Q?adLdDwQ6faQYgUQPofsighu+9vwKS/v4V+JOJM2zQBuETMEQ3eEK6+c0Omkv?=
 =?us-ascii?Q?AYCkiCZLkyAXxFMpZrnsHJxF2093CuEsQbGjLaKEgC3ypLbarngaijhCb4Vu?=
 =?us-ascii?Q?cUWHMWpXOZqAz1Iyjg7XIJK3H4cQWL2EwmgMQ29S30UPwPK8oqhNP92kn+Rm?=
 =?us-ascii?Q?DwSHa3Mjf9NGfU08DHDUL6pWQSagONb9XpUw4Vd9F06xZPUHMKGbfQVb9CAe?=
 =?us-ascii?Q?JVEQL/esvn7gJvrMziw0l7WVD3ioTeSX9s+DCJOeUlf5T+2+UsrARClc/n02?=
 =?us-ascii?Q?uaSen7ff0pXE2KzGVgKnkC4fRzODkvr8AR/Cad5G8ucDZSjZQbR1wrWd2o1b?=
 =?us-ascii?Q?G29bSprWQbk9gVJq1J/saD/S1Eb84nQAZuStyySLoxco4TDbZqJSzM9VM5Qs?=
 =?us-ascii?Q?mSTapB2JgiZ3+dh2sjpc/WWDf6fDJALdV3V9cU9sR7Qhuk/DGt1YaBBuFJg1?=
 =?us-ascii?Q?hfJkx1v0dcaEkAsfIFYdQX3mnu4c2iY3JbANNnhRw81QX0PHZ0GixkGXy/J0?=
 =?us-ascii?Q?alUqlmerC3dwUz7Uvl9JKUX9OBnCa16rgCtkiimFj4gR8xYhoPlB8miGmXas?=
 =?us-ascii?Q?UFZ7MVEwnIk7iFUeVg37QgOmdJpnfnBsZ/l5ksFalNGLB2cEgZ0Vbv/FrmDd?=
 =?us-ascii?Q?WiibT+iWDzyrR1Mb57+ntufPcFRTnb6x+8o11g51wOlrUB5+i2UEzBoztvPQ?=
 =?us-ascii?Q?jrTheOCuo+ub87lhwdDERAf7ZzmkbwLH9J1hrkZupnH7c2pPmcOS6tsY4LHR?=
 =?us-ascii?Q?1KQsvpBCYI3YSRswwKfBculQLtdf8isJaIeJhyNVB1mMRS0N3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EEzlCFaRX5/7eyv2lkX+mAQvOSRRYVywmXwtpqcr+YHBEGwHLli2qqi5SMgH?=
 =?us-ascii?Q?j4rhBiRrnm5la4p7UMn8Nwm1ChIiE2ehdreNT/ZjgNIu9NxqiKWVCzv7SPqL?=
 =?us-ascii?Q?/4x0hi2C6iIlXCRY3/oZ+ArpCR9BDNVxf49MlUBad1Z5TUJncnxSn8N79u1g?=
 =?us-ascii?Q?APoKUUbTFwfo6dYp8bVaetaePkPLeauosUUfMzszv8rayZXHrjRZbSDF3Vcn?=
 =?us-ascii?Q?Tnqxm1r8cGpT87Pv6BetDXhuwR7VeAZzUIAlzFAzKesDG1nGQn/wGaox/aDB?=
 =?us-ascii?Q?SR9faYmcb8H1CgXJNp6A02gija3Yx+rO6OHngUhAiCVZD0Hz6f6+0JJnLCNN?=
 =?us-ascii?Q?3Z9HbPuYppKlW77XX3s9NAESLsyrGfO8tTmrUzBYQqrXPk87xFHHuPlx4G/v?=
 =?us-ascii?Q?Nj189R420K+7McTw7bl/0jBSAHYdMddEv5sB+DlNTvxvj3xTS8kfcU8eIOlo?=
 =?us-ascii?Q?Ga6fk7IckTjGih86HVDI8oYTQV1BR+XkGN+UERzMJXlAKT5TM0YrMJ7cej9i?=
 =?us-ascii?Q?Rr+4foHfaFe/pNDRCXbpLFQ4Bx8zoGeEfCBOehToWhkgKwpw5Aapk4/1V/Hh?=
 =?us-ascii?Q?ce0VdtBddUqIEhYvoianmHHBsZEEtiOXM6oJIFRXXfGgHuX+67fos7IKHfvP?=
 =?us-ascii?Q?35L+EB1Xc/9v43Q0XueMB9H+nXyd6Uyj1JFWgGEqAIj3qrhWqhMDpCYqQLQP?=
 =?us-ascii?Q?Plzrv6p6a5+qbkGVe3afxdXr2Zv4yv0eVRA2p8cnnMk6Ef/3wB+Vje4TtkOw?=
 =?us-ascii?Q?/+c+/YecpXzqd6p/Tz3CbnXOeBQlZOm+3E+HD+OXBHhybsRgbe7jHjUQzsK+?=
 =?us-ascii?Q?7PZodUwGAw3Vw61ImHE7Ho3R1nVTHxNs2XCpU2NbTeArHrut9Vcd0YMpp/Mu?=
 =?us-ascii?Q?INKmuDw2EDVOvI+WrQFh50fAhVL0wZOBxwotSw93/LTOIwxYZYH0Htdsybae?=
 =?us-ascii?Q?jExVbjcLNAMfvPOHU6RDAmUBVrMDIAH4nojh5fuq6n0DCYLo2fr+bysudIw9?=
 =?us-ascii?Q?cznMdLd0k0cJB5TXf8E95HwifWRsx8x0P0ZJCrbqogaFIb2/13Igf4x54FK3?=
 =?us-ascii?Q?IMwV30T3sR7XzqBYt/3fpyx1/VlVUCeTm8QQhdBfpeJGlrr4Bon6F831SyQf?=
 =?us-ascii?Q?5L3BjoZHsL4SkvXpgpGledm+wCm47iQ+KGKt9ngZ42zedNHbPLyjulPNPhjs?=
 =?us-ascii?Q?dM63rOb+gb14vNwQHAfw10Q8T342klpq2/CT+3UjM+8k5QeBxrFAz7vbVX8M?=
 =?us-ascii?Q?g9IjVywrBHI7DaV375ElL1nhjjAfzMbBHGrBFGlfw1atzPQ9SV0Yvm7b45kG?=
 =?us-ascii?Q?g+hcWmB0JWwjSEat3nZgw5AK7pCl0xocNGvJiQ+mpugYvD8rF6/xoXXXPmR+?=
 =?us-ascii?Q?fG+349LP+sBAxPt4+QT839CevwtGks/ogAsHDCyDdf9JtG9IwmWJkb3p3ZMu?=
 =?us-ascii?Q?c2X1ru9EKowQM2ZMIo5uLlI0SRPncN9AX/y23+8jwURtY7EWx3IV6gGpWJlw?=
 =?us-ascii?Q?FkGXtJcBpppDX7z+dqbF9sj7SxsabOWSXf4gMqBnbczuUgce+ALsdXVfwvnz?=
 =?us-ascii?Q?l1LQbEHYn8hWNCqVoak=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a8a512-42ca-4960-5b09-08dd18716c33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:49:18.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x74o31c2O+Y3OZTqv5P5JjduuwDU6nnyTok1D2DA0BlwjJJHHBuKwTUzZ+Sw7LAKe2B9yh25p3lCnmDoGutGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10022

From: Alice Guo <alice.guo@nxp.com>

Enable power-down of TMU (Thermal Management Unit) for TMU version 2 during
system suspend to save power. Save approximately 4.3mW on VDD_ANA_1P8 on
i.MX93 platforms.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- none
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 183af15c33769..01b58be0dcc64 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -18,6 +18,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -342,6 +343,12 @@ static int qoriq_tmu_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_set_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -356,6 +363,12 @@ static int qoriq_tmu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable monitoring */
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
-- 
2.34.1


