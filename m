Return-Path: <linux-pm+bounces-31462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E61B13593
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC837A14BE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C513822FDFA;
	Mon, 28 Jul 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FuTaCoxh"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E122E40F;
	Mon, 28 Jul 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687088; cv=fail; b=GB5Fgj4PTSzZ5uAzFMGWoKxK3mMJLHl2CYUXJYjlp0E3TizI4Fgn3lY364iwxXJHE1JR0/7UP/A5X+VwFP9wBECf0jD/etG24VV1NI8rlOdkwnEyuVq51QNiiJ2i70tMFizgaf3O7a144ZcJMIwkLt3rd976F3LQbjI+RAtt3/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687088; c=relaxed/simple;
	bh=e8Wjr2j49MOI2rnVaXtcUKzeDDA57nfRWX5ausQdEtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zlh5lgT7DwLbnlY4JDAEfPcxHNRpNFVsPyEQqUb50uAdl+Tgh3kAq0Q3xB7gzCMx/PYnhTqrWTV+HSTz6kuEFS23jIfEdsVxt6TL0QvqTeuTWLHJBPpCLENUJ8G1bo90LcMaoEXqK+RrZ3U3a+8+Vk+MFUgFmQmwEwRYtomhpdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FuTaCoxh; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuA1fZu6cweiGHNOkeGoQ7jGVelRJq5y0XLp27ZD1az1vZR7d+WzhIG+wpIrg6Ve8qC0lgIJ0GbZaBG5TbIyDmuhoDKEe5Vhf6vtXAUsNe8eoqKMForUQrrunmmi9ygpZw/FLTjGT8K4Y8tW1lLdd3lR4uPQoVCHRAssZurDDjdLg+YAnPQVYb7RUnYHrhsJ49Hq0t6tWxqW6rOPYi4o4U8t1iRP78MNH1jH6CUl+uq9vXF+G6p2A4KWfewG/SaLPsMUZzMKzzjQOvb/NTOLCUHg7EtETQL5PQl6uA8fnTnLapU1QKcqc2TQMVe3q2y3BS2lBbIuIYsi0vqpsJlxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqB4wUHixpCre8wzmEniBIBtzGuAS2riaOkSF5iFvtI=;
 b=gd6w1oKq3kyFLjIYl0ss5PqceD97JfF1mJJ11MrIe6k5SMU1utTK6OUcm5e/j3PWEwNA8+SF+1b+o6smdGXT6UzOjFqB3ARx+yqfpmYSU2kTZX5OyCTV7X0aBF8FSae9ApoMAJCorrS/zGaL3h9yk5y/ML+Soq5uQTvagq7vg89EUJOnil+GLqR8WY21m/ZgUfLUmpo2MOnLGOICGVJqVe2B3fvRPfI0vvC6cqvRAstJQ4uS5fOOqY/p0bPKUwNBK/afVTrZZ18JLc4zlrly+QBrf9dGVnyDAoc0n/foUvcHW2u1toouKb3seruErUkERNtl/ZJDlTTy0sZ88yGYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqB4wUHixpCre8wzmEniBIBtzGuAS2riaOkSF5iFvtI=;
 b=FuTaCoxhto26Mfv5tOw+fqPzVFcBoyz++gJEHeq3bvcMpdoojkQiYe8idq5uCGl0njbuknkS8iokvrWPpT2O5MUUYLW7wO6nxqnnttGO3CUwBh6YeMeaBlEQPHAvANStCuW+NSS92yywmt2NGzYOVXNoHM1SWQMGD6xirq56RkKZoBlmxaIf1Z235IzIbcymgv1FJTePaHAXtYjYo4pzyJ4BcMCvKT9sSEcozC6dyoKHgy3AQkzWYUzGkzguUjrh/g07P5NNYr6AbrBt5IhM9qrisEW/Ie8W5j/9A1fjXOZviCZGp5Pyx7mbhhaWRgaZcwwNrvita1hVsOLjTbz2pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU6PR04MB11157.eurprd04.prod.outlook.com (2603:10a6:10:5c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:18:03 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:18:02 +0000
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
Subject: [PATCH v7 08/11] arm64: defconfig: enable i.MX91 pinctrl
Date: Mon, 28 Jul 2025 15:14:35 +0800
Message-Id: <20250728071438.2332382-9-joy.zou@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU6PR04MB11157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a84287d-0117-402b-bec3-08ddcda6e379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odWmGCZWIDCiABowfGbJvFu+B2agBuo8TzpsGArpSNqpvNR1+4/uqH8XqaJl?=
 =?us-ascii?Q?oaaDy1zSdNg1/a0RLD+Junn4s2Xw7gii7szjmjg6EEZ4yjT06TrxGHCbeA+E?=
 =?us-ascii?Q?EWLjvdykxJei0m/8d4I/sGbfa0xc0deOilMXRwO5mBV541onXcC984Gwwouf?=
 =?us-ascii?Q?YO1CixCxpTSWNTfEB6eMP9REJeH5rq4JvwLSWlDnYn6q3Ksum1cQIFZI9gO7?=
 =?us-ascii?Q?A880shD2fHdOym+2lE/TYUjIQ8q3tRrMzIcyYbRdKHoPw9p8hUiQVppMfsHO?=
 =?us-ascii?Q?eGmXm/DsDyuxnJIW1aSHjuO4X6+7qGkrwEeeHQKJoWn8WwdgznOCitK+drY1?=
 =?us-ascii?Q?EqFG0oDwbBQ0PVmpzijoidLYor/F568EXjIgvBF830nBKZ30h1ga+/j7EPye?=
 =?us-ascii?Q?5LrYbbRmA1BpJAy7me5Qp/CBdKwFW2839x2z4RD7tmShoGGKm4lUHokUxDlJ?=
 =?us-ascii?Q?sAkHzh0mAk0UXMJK09XcyIR0lABTZn9kIR/5eaowmeCM28XR+3L0koMr9u1I?=
 =?us-ascii?Q?Z/FdgVVYHxMe3QtYuUjYIKpMHhbY8dZ2KkwVnvV2O2eDrCNSnNTgTF5WHh3B?=
 =?us-ascii?Q?8yLZbLl30ufzIcHVaoKWO9Dn3lCE74Z1kvh+djV4U4+ltl0uTpheWeEcxI/Q?=
 =?us-ascii?Q?y6W/lV531Jtmyaebj5susXJzOMUYdWFbFdeVa3SOOoikMC+RQTS35acg3adc?=
 =?us-ascii?Q?ZtRzQc+D1mDoVeMu199mci4KPAU32ffYi7heRKsXUqGVMpnhB95hzHrv4xqC?=
 =?us-ascii?Q?mm+QX6R7SDfQAiPXFxu+LDMkGpB8/EziIyTduU3thaDWUEQTbWIfA47Fk+O4?=
 =?us-ascii?Q?OfA1GTVDvIq45I92KGMKKlIYanhL6bhqaAEzZb13SBxOzJmk6uJxbCP99Qxw?=
 =?us-ascii?Q?xH348QP+4XoHhxRc/rD9ef9JeqWLGHx6A9Z0ZNAAhCYj5nodgHgD1AhRNsZv?=
 =?us-ascii?Q?0f1agRdwW5OWwzcCPflBACNC9sKKguHQ8BS3nzogMfUU9L1B7I4+Dd4Jl8kq?=
 =?us-ascii?Q?49wOMQ41LOwJPro4Ie6OuEfU9wBNX7mH4r6OAuSIG3kbHCpR+kwgZFVMXoKj?=
 =?us-ascii?Q?UdpfOvkqV88w/HnoWIrMkhJ1v+vOiFYvy5FDQESlCYujLp5epGoJPxj8h6aV?=
 =?us-ascii?Q?8Q8dJzQZD15g7wdOO7JTpyutpRMdy+Mon60Np+HGUD9v/k9fHkkPuJvQPDy2?=
 =?us-ascii?Q?ij4MnH8Sud4ZJurfPZvq09mLipK3b04u5FSXhK9Y2HdCrSECqMEyYMFYdtBt?=
 =?us-ascii?Q?qcVTTP3P+1It57oh+4iapIn/Q8TvOrBVVr6DAhg8/pN3/BdZ5zLrTGXkI2KD?=
 =?us-ascii?Q?RI2nY5XGPOeSvRlvyc+TSoSKDmggkTlYFhaVSm+5HNIQui7ttZIZc/NUgZrZ?=
 =?us-ascii?Q?fRtUYK5UrRloYLamUTPj2GPrUXPiSaAhj09fcwKFRrQyKlt1V7GLcXl9Ot2H?=
 =?us-ascii?Q?KtkK5KqJuTuq9mHKTwi6WG0IbCjXO3xXea3yJrvrBg5uD94As4h6zIT71v04?=
 =?us-ascii?Q?6NoPFuUpP58e++M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KsTEv9Fdiz7hGu4LMgezYI2JcJW2qm1i+jBxz0fKGQ1UW5pNxBEe9Mj1lAO2?=
 =?us-ascii?Q?N3WTs+fdFz25YZfjDC4ZafJKmdgxtuU7LltN7V5TMHSu4C7KuBehxSPsioMm?=
 =?us-ascii?Q?n70UYbfddjlwRiV32+GVpqvm43OZ1P24PrDXNG01we8cKUnu11W8LaGD9Vs3?=
 =?us-ascii?Q?SBzadhGyV2lR60vtyHxSXXjx3iLbLSzHdr8hEYzAhL6J4pnGksRzjz1Uh63C?=
 =?us-ascii?Q?Te4SAb9DPYP7Ixc3a/xEx5NRdk1RNARW8aHqjzL9EH+rPYKyYgS7yGwYwbUR?=
 =?us-ascii?Q?vpsLI9o7W3dMmLd03T3goDlFB4+XpMDFd/O+qSr3TOCbLlisxMVdNm3/8rwp?=
 =?us-ascii?Q?Lx6Bor9okfRHKG2ovxqJ4JVEr8CMbclc/MJqTQ4Gq+5NYK90LjlzYsuIEpdY?=
 =?us-ascii?Q?hzrTyY9/99bM3JiP/hiCOW/clT4K/QoXfQzL3I5GuOnWBXa4FWNUMm7cA8qs?=
 =?us-ascii?Q?yH6OWinp4U8E7YeGNFqoY5n62i//XYX5sjhzT64uxI2G118iz9bhnGhBRlWA?=
 =?us-ascii?Q?jxRB2+Nhw4+Qf3sZFoX9Y1qom2kwb5VIX4H9trN7ai7dZ5H/YqPapPCZ7Sey?=
 =?us-ascii?Q?iZXukZYZ7UAy8Goj2UjLgOCdlg58zRdZ9rcRFH2byqbBNrVHbJpkrshXFOy3?=
 =?us-ascii?Q?omhS7b7V65sJxR0jAATt/2Q7M3VM8v6TMmz70rkznU+ep2WplBzu9vJdEPJn?=
 =?us-ascii?Q?1Qdsrh9JqdDHiRNoiqEptywav8kto560kyJbdOWUtaNtoyPtZavhAyB+Csix?=
 =?us-ascii?Q?55JfzG5Lr4rwurgXO4LypQuElHtdX7k84g40ez1c9yw3IACF1XkbvlgfWq25?=
 =?us-ascii?Q?PUAdCIQacLXext6KCp49UGANwwSq13LmBrACM++25ghxuyRgqhnAJPnmVZd0?=
 =?us-ascii?Q?k2o6NXJwpd4OhF4FUZkUU/iWIlqOMrVwtRDFpVZbS7U4Ld7ILZbHGp6ZzJzO?=
 =?us-ascii?Q?GJlZyD1kGIsM6L+efF2NV4jXzmF6aoeuObG+G6FNYRKml0AUpQhaKAEqZ0rb?=
 =?us-ascii?Q?QN04mnbbaiGccyY4EWNl1APQ0OcnEFw1rPfKNpIqXWvQJohFFY2mcTF8vXaw?=
 =?us-ascii?Q?2mfpjYaKF3JH1KMKJVLDcKISHM7L1SmyDZcdJmgc+upRvwZb/qPZiVBAsU73?=
 =?us-ascii?Q?XLD4VBOlSaar3XXxncpJbt3fs/KBPIiKy+FN+TYPbRL9FFdEgwkBLuzv/pYj?=
 =?us-ascii?Q?7/RlhkMzkZeFbKMo44FFRyCQsiZmqeW9FWgF/v7xFTZHAJAHEvwSaFpnshVP?=
 =?us-ascii?Q?6pVYvPbjD+iyH+d44x/hoku6QUhNhmx0+QJeXQAkS1CUk08om3X+JrZL8aIj?=
 =?us-ascii?Q?Ax1iylo2vYpde45t5yROV9dP6HRJC6yeqD+18I3qmj1MS4MSPBYfXrrvIVNK?=
 =?us-ascii?Q?6KlfcSDq1hGK9QY2PaBH+nBrbbGDZofhmBs+73AdNke8NYxScwHuNH9Y84C/?=
 =?us-ascii?Q?jt26L7asJ9/yhDPXJlOcYfH0ONvOeQ6R5XEkpaQoGFguE5rHWPZodtDcULC9?=
 =?us-ascii?Q?oVLl3hQ2H0SCh/R3tkeJnG2siLVagI61zfFvvHj9szhqiztsrmyaXnebWaPJ?=
 =?us-ascii?Q?pJeudqSAPe/clLY5xKEmttbGDk2j6TfT4yp96EXy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a84287d-0117-402b-bec3-08ddcda6e379
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:18:02.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/76+gu35BF8SUXFDrKH2sP3TYzKT+HwRbOlA8DGaKW/tgZuK/4GtdiyVjW8sN1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11157

Enable i.MX91 pinctrl driver for booting the system.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1052af7c9860..2ae60f66ceb3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -602,6 +602,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
-- 
2.37.1


