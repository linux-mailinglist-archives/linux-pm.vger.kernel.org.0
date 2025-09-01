Return-Path: <linux-pm+bounces-33551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5481B3E064
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268BC7A3FF2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D33126DA;
	Mon,  1 Sep 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V1LsiRUS"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7330F7FE;
	Mon,  1 Sep 2025 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723090; cv=fail; b=pdtAqaKcbzY9xbX0kAyPoM5xBK5IaIEKQRvlj3xqBcX0omsLcp4K8O+dfGrLzUHdcpHNxn2LVyW3M6W85shBwm+jcbk8Rbe/S2m0X6h4ECARHJ29BW6h+aXNpvrDnVYtH+R8NP64r/fDKKWpDYx4RhgCI1hiNiI9B+6AqEWHU3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723090; c=relaxed/simple;
	bh=R3PRH5mIr1qNBekeoqr38zjUdpYrSQ2kkVqHgDigS1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2Y7E8tulqTigY+N40JFMpoLzJFB/yHfkQcM0qZTY1JJVfkdLm5DJWz0jwNBqHj5tOCOL3WpfGN27bFMpOVciJKpEkNmuSzfrTMjHNxt2SK9keQ7QBNoMidH4eFYpVh1XoFWuN7+EXkWVM9hzhX3wObdViBmYeJuX+Br75tXcKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V1LsiRUS; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAFggZIQxYUOmi6YveP5MMqBSOeLh6w3y77UNjc/TVT+OBnZrbgiYFbrSBVcA9FnNearigp4YetVMld6WbjnwlNoB9SPzlvW/IZrq01hpEgT9cUEyZtRB+Sv2WVnxXLVYbyClqaj/9M6rSvf8RfxxYuoGFARFvZlDcPMMEb2YkHXju47UfJeswCceiIE/+19loYp05oZ4AMNqydEJ0dt/iDU2nQPvdJCgCqFP9B0rieujwhdaTMbiolvLf4Gl33Y94+Q829T7ZSLwsaenTrUscmcgNRzQs+NkT9iwTW3lNYQBCyvDZg1VJg3UstPgB7QhqRjeYkeiSAFkoNpuKEYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9v0zLp5CnY2fL2KN3iJdJzBDabECSl/R353vneQwYc=;
 b=TKwtiDKrMrVR+T5KJA3Raa6ivOnRNfRt2KvtE5Nf7LCKmMkU7aYAqcYySu0j+cau31DqwatANenQA6geWfIsEvxUp2HGrMuBzvpboI12LM5PLkBkpVmDONC1q35uGkWBTHcFkMIvAc66JgrQgIcDjUrFGmqZEvvXYqE3ihT4TH55pSOCGPSJEBSwMx10W7JI0TZHd3THoeWxwlZHClPa5dkP0J2exzjtzkdVsf8Z1U0WfYHVtXph7bkZYdJNuvv2QKYsPzEKyovy9jtmVu8jOlcQ4UmlF/pqIt57Es1HItLvqg1ubHRkB1eJTay76l3NoYJ8+1HvAASVzKeEJ1cZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9v0zLp5CnY2fL2KN3iJdJzBDabECSl/R353vneQwYc=;
 b=V1LsiRUStpWlkicwHPUcWGEXNuqiXukskLS8LQos1er+iobvTAr4iKXNFthWjvRSKPwVJ8uCpJv6W1RS4d9DMHikfu/LQBolbL7BJiejZSTtjOX73MiGM5XjZGmZ5yDX/YeV0exIZKDyaUW529d2PIssTCWhayXWRTkkXJ8rgsG3oxanIt2dHCF7hMSszxX6hUtLRcAqMRp5E4BdqvpB5I8ABRu6jqDbiK0CKcCOI8FJTd+yY/Hrnbz4QroCV3Y3d8Q/AlUriiRW9lElcvlU+cbeEaK7cNm3C/xQ3tOj+NPyyfVcdptiynq+bbxkNV5twTzV+nxYtDYEueyJ0XAF3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 10:38:04 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 10:38:04 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	richardcochran@gmail.com,
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
Subject: [PATCH v10 4/6] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
Date: Mon,  1 Sep 2025 18:36:30 +0800
Message-Id: <20250901103632.3409896-5-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250901103632.3409896-1-joy.zou@nxp.com>
References: <20250901103632.3409896-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: dc511169-b6b7-49e0-8eaa-08dde943a1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7VFnNyoAP/Xxlu+2RP6B7RZlH9dV8npQWYIayJR+8aXJ7epLXHNFtN2zaRXX?=
 =?us-ascii?Q?Iyz2bLc78ureBj7ZJozWSMnfgre2+LL/iEIoSMGEfqdtrtck6ZqjxJHSKNO7?=
 =?us-ascii?Q?VZQV3xnN3Btyk4k0H/2ur/bwnIGAFCd/gStev3XDZypc3OpD0jJR+qhmQhjX?=
 =?us-ascii?Q?h4BlSgBThHQCHLYH7M5p97P7bxbVGR5FTtqpyIieTUuLIpi0Lfla/ZML8RZp?=
 =?us-ascii?Q?h9zmolSD64A3aGgrKrZ3qtSwml4A+vY/1FKF8GhpTCpxUF6TU8vfDoQXqtF9?=
 =?us-ascii?Q?k+FcKpkhrZYuL1+B6uGfuucVYStrR+E8RZVqiKLxs6rdXeD+NPPko73eiV/t?=
 =?us-ascii?Q?8QwsvhYcB9HqTAA+ASXTIaIPf++t2PHpXNpVAh07hGCkshmL4dkVjRRTZYEu?=
 =?us-ascii?Q?2ZUJuf5acsamyvnLC7QiAZ3dD3mRyzH5u946Z5z/1gtpujkCBiOwz2zFqMaU?=
 =?us-ascii?Q?MbNOvrcuUcgHSBgZFRYGvrUkc/55+pTJDgfvi2WwKw9iFn9obwZ2gofxNHUL?=
 =?us-ascii?Q?zvIdURkWE/P6W7DDEz9Hz4MYmxQ9+7BwTKMC7+HBVJ4kD48OcOPiYgOhJvjV?=
 =?us-ascii?Q?EkfGvSUunbofHj2tcgvw3xX6/Okx9NwEWWggCOS1cGouLepokWpRy/N8n7KX?=
 =?us-ascii?Q?OtNN5rNOsMQEHrggA0rc+HBTd7MVU6Yh56qR7rOue8qtFDWrqKsbg/zEnXpv?=
 =?us-ascii?Q?MlZ/bCDVBVTWgQG5PcjltRJrtKqx5Xrnv/d13rDL5/DrICnpxPmppasUlbuy?=
 =?us-ascii?Q?ndb0cqgOGJj1l/A+03Tl+/GpA5TbHcsvUc0NqZonPBWLI7EK6ElUys9M9wLk?=
 =?us-ascii?Q?8wPNfzyrI1ElJSI3gby9c+B3SRnETh9iZ8808Z1poiv/aXV9EYxOQvp5krDM?=
 =?us-ascii?Q?zgdEbJL4YIDn98Dh5u4pfUKsYZNIyhH7pYYOJj1tOn6qzvis29k7AFUp1WfO?=
 =?us-ascii?Q?7M3ngUPCbJgqs5MJRI+2F31RmbLJZwSDsgyHBHo2PklaCo/4Avk4tEiHXRUz?=
 =?us-ascii?Q?LHrpzNsP6PsNcgqQIYa3SsH3ukGwrrwh+qaEQZEsqKU7xImWl05R2sjTswGv?=
 =?us-ascii?Q?oMbKgbCOviVejYTWkjyX2ri8WVKlr1g+oN63pafSuR8dTdtWZWY1wimGJAxm?=
 =?us-ascii?Q?PZVRYcxBsC8jq1KdAwjB4nAVfzNB5sSsgIPY43IYb1aXPb7Ni8rI0Si9rEH2?=
 =?us-ascii?Q?OmJkpOuKW9TrhfQNKfWcQXsAT7+Jo+DzdfcxnPGvQNtaI4D3PKb4e5DZqzyf?=
 =?us-ascii?Q?hF9o0jB4gfmOAS8UF5SWP5Gz9B6VVydRB5YMUN16U3VWtD+Uer0zwLHl880P?=
 =?us-ascii?Q?1tuAIj2473khnn/6iYYdxauuLAZsdXQ00qc6qBgQJ7ixmFvcO+fNOV9fc+23?=
 =?us-ascii?Q?uUfxmE4eYxFisU9E7QkPzvhBBP6sy934DXyzG5PkM4PjcmKw5ufAleGU7k6W?=
 =?us-ascii?Q?1UM1vAV/FgJ3Jgr0VdHFngvLdHNncIhveDfMQjr3d5Lw1D1xRmHohCj9TpQe?=
 =?us-ascii?Q?DEZAYOF2QGNMqIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/Y31aP9C4ILBeExfDFGHiG6/dUjbut6D8ZzhJaM7HproCPneBw2nkMkohEt?=
 =?us-ascii?Q?M2WJTF8iDz3m28w4ZenrkA0bPcT9VGVeODbmrAZcGx9rdjU96Sa6Aysi+hhW?=
 =?us-ascii?Q?gw0x7K13UiuOIFc1u3h+hw43GWb6yB021IoglYF/gTXqovO4l7xqdKMoWNvJ?=
 =?us-ascii?Q?SBKPMc4Iil/7HruTLo3zv+IDUf6+79reUw1xN1GjuDkH4byba1LATyGrMCaw?=
 =?us-ascii?Q?TACwoDwi4P03mRhLwHzUGUQsXbk4L85h4MFpWys5oaf+i86WX3NBOtCalZla?=
 =?us-ascii?Q?tc0WgYjBpNxh5/lDc/pZo+7zKMVCDVC6a0bK5Lq4hBgNBAG6sGgZTyVI0cAp?=
 =?us-ascii?Q?LkCFZn1GJOoR+qYauRh8kNUX7B+TI+Kpp51D4I2It+GdcgfrAR2wkl/j53j8?=
 =?us-ascii?Q?0rhxewFIPK5CUw3lYjinAZ/GyYPxls+Oj0G2QKjfSFjmXZuIe3kRyz9SdB4X?=
 =?us-ascii?Q?eaAykHuBiCvz28SytEI2QXTme11ZzVjWpIWB+9mIsD7pypHYOZnrHm6YWIus?=
 =?us-ascii?Q?CFZV/HZjA71FYaY9jqeyAFMWLStt2mLPaKYqo7f8FMffHrXSbrAM3i7qMYPQ?=
 =?us-ascii?Q?r6a4iT2+Uw3Kyi9cGwPzRWSoXGC+pSgQt/h1gicu9CsRi6O/qiFcsWIB937r?=
 =?us-ascii?Q?eWDCzTWhuyZr5o8nMEZJHd1XMh2G0grY/MU56BOCSCYgaQq3du05zLqJyGit?=
 =?us-ascii?Q?+CMdGaTV5qHC0KafgU7HmXr3LJDgVoBrw11mfo/ZHjeQ1cpTgOxNuEnK1EyN?=
 =?us-ascii?Q?a55Aa3t0SC/2nBJUoNY3VXdH2910amltsetNbSbrkSm+l+Dy4k2Kor7iy/Hr?=
 =?us-ascii?Q?S76OBDz1DsIu2UOr9t4RVkEe1G/orUCpy/dZtiMJ7Pp6yFTMEJbfJjN2S2kP?=
 =?us-ascii?Q?d5PAGYJzsb4/64JCnrTanZl8BvGThAZsE+pIarqee9HzfFuocbapgYCf2zn9?=
 =?us-ascii?Q?R77nxnGF6aNvfiN4UmoRrYPR49k900sigCHEL65GXAYrwNw7sGjMCOy+jOW7?=
 =?us-ascii?Q?66vKGUfhDTj9Ph0hiPOLzn4cNdGsGgKSIWRtxT3Gk0ZuuHiAEH0Eq90d7Ige?=
 =?us-ascii?Q?SaS9fhi1yYzhhTcEu6QRva058ow6ANjt8n8BRRkpXULjTurH6HPE09iLe0tE?=
 =?us-ascii?Q?jCT7He8B9XEVaYbqaZUWFPGt7Qx9+OxC7ATJ/smQX571y9wsktPNlXNaY8yj?=
 =?us-ascii?Q?V8JTbOLBPdXbzNyDnavYreOG+Usg5HG9GYGLNZMtBIt+QRgLSMjGE2cJKp42?=
 =?us-ascii?Q?1HtckThJksK3NzzaJ5t5biESvkTJiw1CnohueVRb+Ga3wfhRTHVHlRC3M1Qu?=
 =?us-ascii?Q?zDr13no9qMfyJdlSdGR1R2m51etdjwr/FcJIdkRu8wrhoTauXHiuTJsye2UQ?=
 =?us-ascii?Q?Isu+EAyZOb2uvrIYJJczu5IdN1aWvnsg+eJ9e3NTfB0Kkta6MOObunEDyIfw?=
 =?us-ascii?Q?l1fTjjNHjscDRhO8eUEvRqj/TjGOuWHeNqcN8nt3vPVo1lJFM87ptqzFhc8Y?=
 =?us-ascii?Q?VlrZf0Q3DQLWk8uTgBF2AL0AngoJIdpQaGC7HaHhig4G7YZ+b/5RPxcRBH8B?=
 =?us-ascii?Q?epHuH7dGHoFqdEi6vYWL3QPpp0jy/NTd6Lha74Ph?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc511169-b6b7-49e0-8eaa-08dde943a1c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:38:04.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i15OfDHrCHfGRgGdGTiGuESSCemTgnCzyhydQx5vSLAE7l0+QydlKvU/b9BDx7wv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

Add i.MX91 11x11 EVK board support.
- Enable ADC1.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable Watchdog3.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v8:
1. move imx91 before imx93 in Makefile.

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
index 2be724579632..947de7f125ca 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -337,6 +337,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
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


