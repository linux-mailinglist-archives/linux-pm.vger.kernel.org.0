Return-Path: <linux-pm+bounces-31460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70239B13589
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7FE178E69
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021EC230D08;
	Mon, 28 Jul 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EKVaAyJJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43422CBC0;
	Mon, 28 Jul 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687053; cv=fail; b=qM8Ibz/DwHl54NUhn1BAqXdfsF39+fYqSs2CgE1UNW1IXSUShNYLP++DgERzbcJmxLVWK6RKcyRApe5grd1OPsZhEm4O3CbqaxjXajlSNlc7P6GAUO4ocrMB9H8DqmMn9Be3mEBkZZnr1pXV2Bw4HIIzhz5SwX2GBVF7B4xUTyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687053; c=relaxed/simple;
	bh=/HcLOea8Z4ghBV3dMEj092FMHks5RhhJEblGs0smRq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pL2XCQEqk5SAhwXBT9th2g8rGXOY9Bub89y4Oji7lEaKxOriPEJ6TfS0hjxDIO4Hl4P3gYhQ3zarfKHrlIsJTYxSzYPql+zH+dHNMqfRTLUbHVuwL+sQZUDwob5riL+gFDdFeUj4qnX6o85ZXIdo9WEEq3Nad0n/7t91eprcQmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EKVaAyJJ; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5kxAyFIznrNBeofJsvhrWfRb4ChG5Af+jVMcIwUpZVFBORuQBOQ5MtTRbQWAIFZxvQdK+tpRcI+aNcLHPbwk4EL45oKaQomGQ63Z72uzgr55ywveRCiz+R4cie31AFgL7IwB9DHXzDIJxBmYulgRjEl8zFsazGR3LB+1hEftTKgdKbOULCniW9Rjo7+NOMW3cUiHSo2gbGHIPQ/XU6l83KqSJ7plnoWo6RYtBS7GNGfAGIt9PkptxoH4O8DI2a3yXukEa91s10meqeaaUL4OX/JG7KkZ40PHRT4P+vgqkdj07SfZGFBYqPEmpROF8otxqgbwfmGTBXgdj76IAle3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzsB8//k8W2Lnm+N+X6ydOfklMd4BCGGUbzkT6x7MU0=;
 b=xzUGh3iWWjIsXLuE5PiDcN1TaBz6O5QfV4HxbBjAXEB9Dj2dI9QNP08e0jDF4Oaa5JliuTnfuUOj5H+BimKBj7uC26DFBnUYCgTaz5zucW7V5dMuMvSUzpgE2EbEGmdDzNkjHYjsD3DXl5G3sqPvUwM7NveEMYCob2I28B70pxGUarJnfO1yNK0yB2sHRGlItqAQo0LKifNbxOdRBKob370XS0kUoEjl4kc07cytcy/J7T3swcFqAfyC1iRqce75iidg0Ubd/SgT5unRnmsGdnLdzP+F/LKkfQAjcoGxuHkyLcybhx56VEXUQ7RwlnIhhmkpV3pPzOw9Rf13P9auzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzsB8//k8W2Lnm+N+X6ydOfklMd4BCGGUbzkT6x7MU0=;
 b=EKVaAyJJi6DZymQ2PcpZ0yiSuTs46XOdhZZciIG7z2U7LmCDuYDOMQf4aZ0ueIfUMKtLd0UpR3vhvbBeNnlsaB4g20jolLzQ9xImOxMmVSOYhf8XGNrqroEJRuJV7DqV8tKjIpqIQ+g79VbaRWfzJJlRP5vQVON9AULR8vm8J6WnvuDDnwKkGs5jmVXk2GkEFE7BPPCM82+WEIzJo+c8ohZK+rLMjNDORkVb3BmbYc0q1LMBh5NellmWnWnkr6UaIedjYpVgJ6AjCwyT4qdJNgjPzmz3xZ57+TEVYhCYH5mFOnObIm7r/87lV4QNvm1bnTzm4DcFQl8pMpqH2b2QGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU6PR04MB11157.eurprd04.prod.outlook.com (2603:10a6:10:5c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:17:27 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:17:27 +0000
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
Subject: [PATCH v7 06/11] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
Date: Mon, 28 Jul 2025 15:14:33 +0800
Message-Id: <20250728071438.2332382-7-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f09b6f8-b924-4631-6cd0-08ddcda6ce8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAo3g8x+AZSTSdizI2cpjcYryg7ytKUFrZUwMPWOp4WONrx/j2IwgqvzWh39?=
 =?us-ascii?Q?VwcA7bo3YbE55ju6ns51BUo5TRo6PXdqYPxshiM9LAbDYC4OOE/jdxIpQUEM?=
 =?us-ascii?Q?YRlaJBVIVdASaWYRC1M5mfjfzYhZprVvHKomaqXvh2D7PjKWV+jwl28YIkvT?=
 =?us-ascii?Q?8Fpwwbe32rYNa3Ot1rcohXa42aeyN7XlZQzzDI11AdeeNE7DDstE/mra/1MD?=
 =?us-ascii?Q?IRav/0JyyEnU7j8S+1Gb836MB7ZEOaLg4LbN5XK9lsGNmKuRI07Xko8YotuC?=
 =?us-ascii?Q?SMJtWEVu3I037Atl8QrbTaFQtW1o0pPMJGYK+sl1RbskCyL+07RN/fVJ5d50?=
 =?us-ascii?Q?WXcWUuMGghGP1XOdVhx6QbtRn9nZX6PBWZwAuHssy2ZMcUHAIpJeyGR73xa8?=
 =?us-ascii?Q?bIWuZyeQsy0tJBOSBqdBUye1KN3aI7cMLoQ7UTios+J2r4p1RQI9sq1TvJ1y?=
 =?us-ascii?Q?E3rPB+5NH1yY6jfjECu3cx5Y075bYbauVwM21G1DjFkrGZEiE8I5gDRPpv1W?=
 =?us-ascii?Q?UTIP7NKBrebtdkQqauPEpxrxgRW0rAgUshzyiayxvntGxfEueUZOz5WJPTMS?=
 =?us-ascii?Q?i1ncN10kxRaOAO3eq8bUC86sjF8F7yBIyAjD/PLsll5zqyHF2jw9stIuZQLZ?=
 =?us-ascii?Q?coMgdUYLkxE0dKbVtEj5TvnAQr4NyAx+GVXG5by9zGcCB6NVpuF1kn/KSfND?=
 =?us-ascii?Q?Gt72wdE2CzhHtw2IfAjP/QfU8YpdFHYBxMO1v+ywbpcCyw488WicijglE178?=
 =?us-ascii?Q?28mtctpUNPJ3IwoEuYRbIargCCwZ6oMFFZWA6X3zmQk5nwzf/AmgcFqirxWG?=
 =?us-ascii?Q?mJ5yjYEX/gz8wTPMU0upSjJ8CF1QHM+sZbY8WdFkAiLhhSq1l1ndGKJPMqaq?=
 =?us-ascii?Q?KIzppOrHY86JxzjM7Rd3GqS/zFfjeCc62x5SPlb/BtAK4bLqGlxcPDBuCxwW?=
 =?us-ascii?Q?OC0nDFuADPjHVI3to0WmK+m64/Rb8azxncueYM52qWpQ4jBKjKZdPTJT8CmN?=
 =?us-ascii?Q?DogyyAW0ir3CjcBYRf07xI/JSjX6YXGYjYtMI/WM8yMZTP5Pc62sAB+Kueqj?=
 =?us-ascii?Q?ru/8JkJecuZE7iQ9gUV2IFWIS2OWZgT+0AvTV8WLSCLo0tPyko+5poIaxhip?=
 =?us-ascii?Q?OnAoV26b9FFOZy9zMD8kU2fzbHjbRinW4XLdioeL/hCnu2BUdd0PPL+K5iM0?=
 =?us-ascii?Q?gMc/Nh2ZhMu+fHfoBqi2pUzSwNF7C3XocUWXutBQ+QshfApLD8HBeE7anGzC?=
 =?us-ascii?Q?5u4OOU23qbSaaQ7GQuVJvePq9fH1xIXcd3xdnL0tf/2OhJaIyDQrMj+Ftn1R?=
 =?us-ascii?Q?7IduNcMpLuguOCeXsSeV9y9pCBLj2OVgagBYKxh+9oHpMnBywq/+HYVXOjn3?=
 =?us-ascii?Q?CZpOdFmBOH0peWKDBV1rIcMC+FvcA60xkh6oDDa1NrHMvx1YAjOkJSbiXRQJ?=
 =?us-ascii?Q?54nak23Fc1IjqXhdBqbi1/2qyPeZwlVcTnbEHH6rTCL8R6AbwcP/t4FCl4w8?=
 =?us-ascii?Q?KdnSig/CAGzMnuk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?170ILk9H5y0TmF50d6dYKUHmrocGkgeJp+/p+2CizXDZ8dqEe4sL0YJqkTGl?=
 =?us-ascii?Q?Sa86AwzgSTyNJxGvnoxWx2icOPRtpj3vMMf1AgH3nFjI44Fm2h5taVuA16q5?=
 =?us-ascii?Q?eW5v6nzRME8MwyjgoDx02ay+rlf0ve+GZG4i2RoR/PgpnvxfhS0iCKXTX/on?=
 =?us-ascii?Q?etSNHIm88xubWftxtbUv+uzWaF6QN5torn0t0dFU5v7MpTaNPFh4uiMijnl4?=
 =?us-ascii?Q?YzqTAtw0/ED9f2kF6/rvNtgX9LHdVfBGH9Lb2SRoxGzj5+zXOAvcbTS9YMor?=
 =?us-ascii?Q?HlDkmDcYK8oqrY/va11ep7sbT1KMnNFxuucj5s5hXISBKU8eqxzkWjY9im+s?=
 =?us-ascii?Q?5CGzPiXeXnU33L9eQlLboHaQWs6u53gXo6C4hg9Gq/SfZNyc10BgYSh2wLen?=
 =?us-ascii?Q?WzT8mai8qE5RVxWme9lpaqVUwqhaM2o0kuCcwKQdwJ/MccBJNCYccu8fYvEr?=
 =?us-ascii?Q?m1llL4jxuPdoDIxFs4qWlYTwfCXAtca/wyYxMWGfyevnuYF3L1jq6JEuama+?=
 =?us-ascii?Q?S8cdlkpz65MinYqAGFarBr8Mtxki87hWmx+4oja2XUuQiA9L+XZpMQmAQ1It?=
 =?us-ascii?Q?sTKxPegrPFSMvVPUWad+Qv6zfUOH1tsb8shMjlFxC77ldlE0BzT3empAaWFA?=
 =?us-ascii?Q?WJS9FRrFpzZwngB43G9tkoYsRykaPcoKlkV3m0KzbWJxGsPaUSyL3dNB9x2X?=
 =?us-ascii?Q?6jBhz0wr/0Luh//0cAgxb0OmlgE/9XZWJRcWX3o7AlahFF5HT6UeJu07GZhA?=
 =?us-ascii?Q?r9rRSmzK2cVNcTFrAQ+6o795MAgXnpstPuyYv4DtHmCzt1/VB4PqdgNJwSPc?=
 =?us-ascii?Q?wWHbgloxnb1DbOmk8cUQ1shP+c1TOBdpvaIDbY+lSFQ0LVZxgviNpquX8f6n?=
 =?us-ascii?Q?wkclqrQlXNbXWhOrsumxgXa0yIXKaKACQ6TY0nYtNSv75S8tdjl7p0uWhzqO?=
 =?us-ascii?Q?nz9nRi02SqmTYlPg8CfxYVrukt3nw8JYpLcSHRHZsNWqvhqeJU4qOxpfGBYG?=
 =?us-ascii?Q?mFXb/abI756Dx6ynncawxwpuXO+fnQcdWqV2WAGIMEt4ENT8PCLJxWbHTsLF?=
 =?us-ascii?Q?13wEbB0xCZjfJ3RFvlctnttIYT5MIHHyQOxTtcjjeC/tU9HC941cAgrw/loi?=
 =?us-ascii?Q?gkdyktCCZZE6/xlbmmNf5Y2OzfhqZWxhDpkgkso2XnNdDomH0EwcLyvCX92U?=
 =?us-ascii?Q?hIUDgkAwuWKxEp/gKzNU8tW54x8Q5wrrTc4OFypnXhJnMZGdpuz77tLe/V04?=
 =?us-ascii?Q?ThVvx4n1LQ+JrVVSNokdFGAsX+hmI0GmayrRxP4gMFL3VqLk8LmxIsdRK4Kp?=
 =?us-ascii?Q?DclDpBSfF5kUMbvF+8A904WQEAni/U6Pa5+4SoxOa2jv8wzBShqXoYHezHBp?=
 =?us-ascii?Q?gC5ieHYNMJiIHBd46c26/t6fr8BkyodiplsKlalaSP/GSNO23MHPfuq74Nye?=
 =?us-ascii?Q?zfrSMVLhWu2ve4V8gw0h9e2z15afNMbP52VXQGyCUf7Sps40Okt/fCJUIdV0?=
 =?us-ascii?Q?2gZAXVnaS4109Pd6iDJADRCrsVN9jOC1LzHdlTUMYi7RFAAu7Hf+w0qOFJdr?=
 =?us-ascii?Q?zKlPUa6XoFL8v66vntYgqDwxvHkJt5ZVoGXhLtiP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f09b6f8-b924-4631-6cd0-08ddcda6ce8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:17:27.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCR/EMLNTWB5FTQBydQbvOVNlBdEXErHkLJqCyecLfImbFLEReATEbHIgxNyRbBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11157

Add i.MX91 11x11 EVK board support.
- Enable ADC1.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable Watchdog3.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. remove this unused comments, there are not imx91-11x11-evk-i3c.dts.
2. align all pinctrl value to the same column.
3. add aliases because remove aliases from common dtsi.
4. The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) on 1G
   links as a workaround for PTP sync issues on older i.MX6 platforms.
   Remove it since the i.MX91 have not such issue.

Changes for v6:
1. remove unused regulators and pinctrl settings.

Changes for v5:
1. change node name codec and lsm6dsm into common name audio-codec and
   inertial-meter, and add BT compatible string.

Changes for v4:
1. remove pmic node unused newline.
2. delete the tcpc@50 status property.
3. align pad hex values.

Changes for v3:
1. format imx91-11x11-evk.dts with the dt-format tool.
2. add lpi2c1 node.
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 674 ++++++++++++++++++
 2 files changed, 675 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d120..fbedb3493c09 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -315,6 +315,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
new file mode 100644
index 000000000000..aca78768dbd4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -0,0 +1,674 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx91.dtsi"
+
+/ {
+	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
+	model = "NXP i.MX91 11X11 EVK board";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		rtc0 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vref_1v8";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "audio-pwr";
+		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&fec {
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	pinctrl-names = "default", "sleep";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	audio_codec: wm8962@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
+	inertial-meter@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio3>;
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		pinctrl-names = "default";
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2237500>;
+				regulator-min-microvolt = <650000>;
+				regulator-name = "BUCK1";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK2";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK4";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK5";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK6";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1600000>;
+				regulator-name = "LDO1";
+			};
+
+			ldo4: LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <800000>;
+				regulator-name = "LDO4";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "LDO5";
+			};
+		};
+	};
+
+	adp5585: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#pwm-cells = <3>;
+		gpio-reserved-ranges = <5 1>;
+
+		exp-sel-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+		status = "okay";
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+		status = "okay";
+	};
+};
+
+&lpuart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-0 = <&pinctrl_uart5>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	status = "okay";
+};
+
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__ENET1_MDC                           0x57e
+			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x57e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x57e
+			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x57e
+			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x57e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                  0x5fe
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x57e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                     0x57e
+			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x57e
+			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x57e
+			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x5fe
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__GPIO4_IO0                           0x31e
+			MX91_PAD_ENET1_MDIO__GPIO4_IO1                          0x31e
+			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX91_PAD_ENET1_RD1__GPIO4_IO11                          0x31e
+			MX91_PAD_ENET1_RD2__GPIO4_IO12                          0x31e
+			MX91_PAD_ENET1_RD3__GPIO4_IO13                          0x31e
+			MX91_PAD_ENET1_RXC__GPIO4_IO9                           0x31e
+			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                        0x31e
+			MX91_PAD_ENET1_TD0__GPIO4_IO5                           0x31e
+			MX91_PAD_ENET1_TD1__GPIO4_IO4                           0x31e
+			MX91_PAD_ENET1_TD2__GPIO4_IO3                           0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO2                           0x31e
+			MX91_PAD_ENET1_TXC__GPIO4_IO7                           0x31e
+			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                        0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC                           0x57e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO                         0x57e
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                     0x57e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                     0x57e
+			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                     0x57e
+			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                     0x57e
+			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                     0x5fe
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL               0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                     0x57e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                     0x57e
+			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                     0x57e
+			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                     0x57e
+			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                     0x5fe
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL               0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__GPIO4_IO14                          0x51e
+			MX91_PAD_ENET2_MDIO__GPIO4_IO15                         0x51e
+			MX91_PAD_ENET2_RD0__GPIO4_IO24                          0x51e
+			MX91_PAD_ENET2_RD1__GPIO4_IO25                          0x51e
+			MX91_PAD_ENET2_RD2__GPIO4_IO26                          0x51e
+			MX91_PAD_ENET2_RD3__GPIO4_IO27                          0x51e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23                          0x51e
+			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                       0x51e
+			MX91_PAD_ENET2_TD0__GPIO4_IO19                          0x51e
+			MX91_PAD_ENET2_TD1__GPIO4_IO18                          0x51e
+			MX91_PAD_ENET2_TD2__GPIO4_IO17                          0x51e
+			MX91_PAD_ENET2_TD3__GPIO4_IO16                          0x51e
+			MX91_PAD_ENET2_TXC__GPIO4_IO21                          0x51e
+			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                       0x51e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SCL__LPI2C1_SCL                           0x40000b9e
+			MX91_PAD_I2C1_SDA__LPI2C1_SDA                           0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL                           0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA                           0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA                          0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL                          0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO2__GPIO3_IO27                          0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7                         0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX                          0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX                          0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                   0x31e
+			MX91_PAD_DAP_TDI__LPUART5_RX                            0x31e
+			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                   0x31e
+			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                  0x31e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x158e
+			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x138e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x138e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x138e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x138e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x138e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x138e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x138e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x15fe
+			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x13fe
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x13fe
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x13fe
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x13fe
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x13fe
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x13fe
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x13fe
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x13fe
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x13fe
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x15fe
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x1582
+			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x1382
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x1382
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x1382
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x1382
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x1382
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x1382
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x1382
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x1382
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x1382
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x1582
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x138e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x138e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x15fe
+			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x13fe
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x13fe
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x13fe
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x13fe
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x13fe
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x51e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x1582
+			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x1382
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x1382
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x1382
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x1382
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__GPIO3_IO1                             0x51e
+			MX91_PAD_SD2_CMD__GPIO3_IO2                             0x51e
+			MX91_PAD_SD2_DATA0__GPIO3_IO3                           0x51e
+			MX91_PAD_SD2_DATA1__GPIO3_IO4                           0x51e
+			MX91_PAD_SD2_DATA2__GPIO3_IO5                           0x51e
+			MX91_PAD_SD2_DATA3__GPIO3_IO6                           0x51e
+			MX91_PAD_SD2_VSELECT__GPIO3_IO19                        0x51e
+		>;
+	};
+
+};
-- 
2.37.1


