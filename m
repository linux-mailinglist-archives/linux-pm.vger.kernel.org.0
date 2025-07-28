Return-Path: <linux-pm+bounces-31457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90EB1357C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5230A189907F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A85226CFC;
	Mon, 28 Jul 2025 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PaQ2ADC+"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6C27455;
	Mon, 28 Jul 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686999; cv=fail; b=TCGbWAyanjyG8s/CrAg65Mz53D3j++3wHdUMvpW502RRBeCAlvnhctd2SSrvz14T1/kQYB+wHh6gyg/C1XHOOTFlpDhyNnLIRcg8SA3prqAp+0OLp6Yn5qkApXaF6xvO0am+ccnCRDClRBX/Cu51L8Bzvc2EnHvUN+i4mq+4FkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686999; c=relaxed/simple;
	bh=lxGFeP6bobBFIFuEGsIYrKRQlvfV35YJE1jhwiymg/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owXzYZk2UViI6YaPBMndPc9ndaq3kH9JBWHgriLUmqNXVAgUd8gi1j+O+Ci/5VsXINiGhFTeKseJacMGEln8zt6HVcgFFPk9H5qeuYpsDxJTw2HP8VxCWkAHUX4W6m9iI1pc9lUeNBa3SQN0XNhKLhxBwiDJC+ler/vD2JgbVXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PaQ2ADC+; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Itsv8pzqDabvNMaj3FCSKsTL2wJFV6VKMalMClBKBC0zi01/plCDtmyaUWT3lGnmjXyTSi0ScSub1FBQRi9pUvdvJcMPrVFO+2e8BalatkaRjnjDbWMDDZwfnIe5GEC7T0xPpRuCwtmz5I53qdznjiZmelm4FqwdSLeb7HXfzi6v0WOoBcq/CgM4058444oxvhCeEl7OPX6Cr+TazsH2haSahV2Slxk5QtlqGx4clEzQ+8pd5vgoTrWQTWIzQ7O8Lj7F4bAJzcXHmbX/UGB8uCJaqTXZT9MagpXXO1S0Vhb1Rv8WuH5lMWCGPzNdLEsv1bdmzW0WzO3hRf10rZPqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCEpBZxA/phcUL3RyosRYGQ+Gdxgx2YqamOCug5VJM8=;
 b=rKZy97mQUoe0jV8ZmAaXgzmOmoAapQE29xp5oWfzSrB8ajWgXy86XYgbjOznPQ15u3+FRTxKN9LmDAZoLWiiCUsJUALpSmi1bFe/ogz4CfGiPjPfgNb0E7pB6K964wymjaF1ktG18xMEgc+RS9P6cTErFtHUnyAsq46uBI9CeMA8wszZzcfSgyXCtg3vreIyF9HVp2wslwJbnATCY0VMmBRf37j1Hr+rBHc61D02N4kyokR46f6u+tiIHVq000d6hch7mhjCZhdDd+JXCx+MCe0eWy935Bv8XMiExTWeerJCmN4ovUOkEeYa9YL4MeZG1XVWEd9vdCPLkRRWPu5L0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCEpBZxA/phcUL3RyosRYGQ+Gdxgx2YqamOCug5VJM8=;
 b=PaQ2ADC+1IcCVbl4jEHLIyDe/IpcLPV6bE+mhigWARo6pPyTkyqom0xULINOOtvscO2/2JTeSq7v6RB9Dt8LedOOEJbEocWFaRVllAwW5soZNYvBCShlKfhsGnRV+uhYSLvYifCm5/NaPDbF2JRiTI0LDGqA7zp9YsFFwtN146hfrZG779TxO9c6I0AD83h4tl8dSX88vTcxMGPR97Kr/V//1U4XeGUlm+xWU2MiahmtrkLDWC8jAQPrVy1doUKQXTyZH9wn6rm+v5ZTfrhK/xuJ0AFcs3mejFKHOkP+4Gd9VPJcN5efLBcjQGu5sIAhJ9ZMjZW6xWYb92y1KX6+wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by MRWPR04MB11489.eurprd04.prod.outlook.com (2603:10a6:501:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:16:33 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:16:33 +0000
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
Subject: [PATCH v7 03/11] arm64: dts: freescale: move aliases from imx93.dtsi to board dts
Date: Mon, 28 Jul 2025 15:14:30 +0800
Message-Id: <20250728071438.2332382-4-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b66b9a7-825e-44ce-596a-08ddcda6ade7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t2EqsGYIQPgWRBGG0MjgFm6mwFoMhvMppyUfe2e+rtSs8YWMrzxGXXfqL7O6?=
 =?us-ascii?Q?F9bIjICQ2mUpnTFMArVVxmKjAqXCricgdI2Q9KyRnuqeTMGNalFSOWfJX/jW?=
 =?us-ascii?Q?HNCeaDwSh7jnpYavD5Myj6N1C2Yjf0FxhMqVEajr8HvsU8BLsltk2trC097b?=
 =?us-ascii?Q?7/XuZXQpqCC8iKTvtBZK0ib5iGNu7OcO7SCfC8IrMywFTfTg2PNtCABx87pn?=
 =?us-ascii?Q?T2EkabT2GGwzg+Xx9hG4z1/poo+Ujd35084G6TrZ++VJwht31Xdstqobe6Qj?=
 =?us-ascii?Q?WVr1qQGVU0T3nKmieYYP96/rUJLAP/7f49yZQfUakA8pLoHJWcN3K8UzluDW?=
 =?us-ascii?Q?6nerNZjKN/eLmI5viGlAGKTrT1G8SEeMEsLLjf7Bswp2DN4qXWQmtAU8QJ6S?=
 =?us-ascii?Q?9DPjPFCRSLy5cCMKvUy9BVJucQX0MwmQzX4dbvAXln8S9BOUGQ7JFZ3cceAc?=
 =?us-ascii?Q?wntbdhgd9Pe64rXgryv/aFNmSiacYr3ItZC80dLA3x4adIpFzFwta6a7rDqi?=
 =?us-ascii?Q?AaA2pC+PGEpiBlDE78yZNSqmXp6XvjLFQmp65LrUc6hUBDdJdeqn/ims/WXI?=
 =?us-ascii?Q?MJQIGneFCLqXUFrVbj4lsFJ1b87Ju9GOL/y087CiXZsQhG4ho0nIjw0wGAY9?=
 =?us-ascii?Q?EwiATdSX0iQjIjYknk5IGQp/vWaaEPYliTNbvt0a7A/uUCFwwojCbjwr3/YG?=
 =?us-ascii?Q?Gn57vk5d3qObLfmgFm714Fqbtj+uRvCA6Zi/Jstlvk4yqPp1AfZq3iygX5FK?=
 =?us-ascii?Q?uxKiBa7WxbGUfZKGvy0zw1uZSK5UdplZIoYiL6gMNJT2UZBlH3XPFVQ90udh?=
 =?us-ascii?Q?RQ64B1PFjjBVjXDzf3r7i2Mj0yu4cenStfC68LDT0IAGRilcaSOr+jh9hCcc?=
 =?us-ascii?Q?e50sF0taDGtAz8xoq8FNpL/a58xOVJD0By4LKmyGfcNuCwCWm7XJeM/7KI5M?=
 =?us-ascii?Q?sBVBSGaQIKRGPCCltUMxb8cTVdAQuUgxYtYa06vh2h+p0JQsqDCFIPt6S1u6?=
 =?us-ascii?Q?qSVwvrRAItH71Z/fcjfg8R/G3JFTIbiNndqbSkPw3mTFFwKL90ymN18a68qO?=
 =?us-ascii?Q?ljFmsLElcLXcKDcZdLVh1WSOXZaH4fcONW2LOoAhgCcvF45kM+kZnnf5IBzC?=
 =?us-ascii?Q?fXNkef8hbAePUPRI5mOZ/5J6HmIfMm9qKeejCn+uPy/IlwnbjWpWaA/9TqdR?=
 =?us-ascii?Q?W450qe/M5fHYkTO9GSDdWo0twGanIncMH7n2/AECQ5ZH73MI0KhElPD3B8eX?=
 =?us-ascii?Q?nxVea0WYwjun+IFIsr/rG/zhkhhs/AJkg7Z8BiLEJBbQL63rVeR448yMgvKu?=
 =?us-ascii?Q?8kX/670iy8O7ReBqIvrOvq8yzPmmrQZ5tmMmahyqLlvyv58UT/w+wHWytGyE?=
 =?us-ascii?Q?5ycgNVq3zzaniBO4NOMy+ygsJ3xXXtGq1ncF1nUaMdzus3zarv7RoB0P6JJ9?=
 =?us-ascii?Q?tsfhBLLkd3z6p7QE/Z3+o4h2wi8Uqg2u2OZ4QKfNZDaI7/TWp1Ws5frtcHPv?=
 =?us-ascii?Q?rMGhVcVVIyfqEJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fw6w+o2E3SDodmKJpjMNLD9mt2ptiXkfbmegXf44LJxypKHVIDaaK1udixGL?=
 =?us-ascii?Q?rAKvAASUvcD2HJSJEIAroTLajJhR79h9719M+PYvETfvRcS/S2xswU596iiQ?=
 =?us-ascii?Q?+tNgPfmGzAa2qnryrcszjuiljUKY9pEMDY6QOrpu4VzSLhdGwOd7hWaa5CKo?=
 =?us-ascii?Q?JV3IGrdI3VhjtUmiFbtGd0Z4XfipEDjor0zgTplLgY7wOeyJpULmUSZVBm8F?=
 =?us-ascii?Q?wNlPBKMxeky/Y41xL0bk70c7x8Z57bYQhD3/5c1q0MidFlXQ3PbExQXr0KaZ?=
 =?us-ascii?Q?RU9yt+28w1gx6X3o+4L0odrPbOG3dY6iQlLluqT1YTqWQsQyacNTsCENfWOU?=
 =?us-ascii?Q?DnrrsbIyElLSYVqFL0rrgtvfpdtPWExPLv/mPHlmBHR0WoLcleMaqqH8e8/K?=
 =?us-ascii?Q?XilHTfBLCAnzfH3cZYNQJqanZwSvsamirFqu/BhBnt4+2nbYPKrKHWj26C9t?=
 =?us-ascii?Q?zXvPBwCrhLV95S4IFl8Jka7jOTpx2LVKE+xVHOgnkiWeOa1aMQ4uANScLhAs?=
 =?us-ascii?Q?TGvL5Rd9E2ot5Z5fk+A2PgPbKMRkBZPId8MFOY4WvbGRbreDLqc8Cx6jiRsE?=
 =?us-ascii?Q?iidL+mfIyuTJXhXeBQKpD/ZGq3kExfoZ0gLdXeOUL0s0lW4fSZuYWPCmLW8/?=
 =?us-ascii?Q?NniutKdoEd/r7eMOs1fQQAe17cdgsRHtlCdkofpF1QrbuVEzhyNj78jXJ0sh?=
 =?us-ascii?Q?7cbrMCh6qzbKgBiwPKaNQFeCIaIiAasb7ELW7cxAL++6Z/h7WpzFqRrRgFV2?=
 =?us-ascii?Q?+W1tntef/Dnfnn5fq5Yr/0XmAXnHcllnYYenX/uMlaDoAzrVW6lPAFw/hWbh?=
 =?us-ascii?Q?LP6hd92i0/bcfQMPcPCOLuS6Yn9OlLBwptQbRZMHc6OvZYIFK0YSFY4isWMY?=
 =?us-ascii?Q?8fga+IJdDJ1hPEdafHetUfC58l8yz9DdVlTX2+06SSP/Uy3shNkJ3A5CzHlj?=
 =?us-ascii?Q?Fov4dwuBOVQKw8rzyXO6ep8Ywti2kp6frftLo93jVxn3ZKOtpBaYeJ/E11+m?=
 =?us-ascii?Q?RpFFYHNx/4V+aPFXPCHGAgtkGSRuLUu26HXnQS1jJRS48eKZy5fcjn1mPn31?=
 =?us-ascii?Q?+hRfQJ4PJWZb4hDeHqp7ytVCJwqkwD8JggFB4dLbG8/9/AZI4nKqx0rQFEZV?=
 =?us-ascii?Q?QG8oMlvAXtGsSOMW9prNTF8aPhYC/vo/iwzdbZWAfHzOdaXC3Dmeu1NUSghc?=
 =?us-ascii?Q?JtJrZmR8PjZDwVmSDtdMhoion8kH5BQmWPGtsuJZiqU+aP+FkvJeYv2JtjGV?=
 =?us-ascii?Q?01cngqJbcBGU/CNHqMTNLblmW1Gsfwwfd8mDQqtY373yF+YUtkZuNZc1pXz5?=
 =?us-ascii?Q?k/QuxHBlEOPhT9eEegAGaZUktgY10bN37lTvJRUjwTJKgU5wk5JtZ5uRjgAx?=
 =?us-ascii?Q?WsnpfCGCBgA654Af8NGWwkuqbEL0W+HS+JvMNe1IB3erGx0nfaslaldfwTe6?=
 =?us-ascii?Q?HWnBeHFioXh2+lLLlPNa8mZcozogRYv15XZXtdClxWCdJv9dNUQg7S8i4jL9?=
 =?us-ascii?Q?n8UMZO71REdvTOUDuqUnd+iDurgfAL55HpTU67OK/B9c9e41PNWqORtufIqx?=
 =?us-ascii?Q?GmlIzYZTnhlojq/VoAAlmJAu66my63mDcv6Pb/kv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b66b9a7-825e-44ce-596a-08ddcda6ade7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:16:33.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf++m/b4qzI3yRYc1uW9LsVvqQI8fcOA2BBgN1tmddivnO7pRaM8Tz8oBGOfZZ5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11489

The aliases is board level property rather than soc property, so move
these to each boards.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. Add new patch that move aliases from imx93.dtsi to board dts.
2. The aliases is board level property rather than soc property.
   These changes come from comments:
   https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
3. Only add aliases using to imx93 board dts.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++
 .../boot/dts/freescale/imx93-14x14-evk.dts    | 15 ++++++++
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 18 ++++++++++
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 21 ++++++++++++
 .../dts/freescale/imx93-phyboard-nash.dts     | 21 ++++++++++++
 .../dts/freescale/imx93-phyboard-segin.dts    |  9 +++++
 .../freescale/imx93-tqma9352-mba91xxca.dts    | 11 ++++++
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 25 ++++++++++++++
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 25 ++++++++++++++
 .../dts/freescale/imx93-var-som-symphony.dts  | 17 ++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 34 -------------------
 11 files changed, 181 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 8491eb53120e..674b2be900e6 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -12,6 +12,25 @@ / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
 
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
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
index f556b6569a68..2f227110606b 100644
--- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
@@ -12,6 +12,21 @@ / {
 	model = "NXP i.MX93 14X14 EVK board";
 	compatible = "fsl,imx93-14x14-evk", "fsl,imx93";
 
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
+	};
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 75e67115d52f..4aa62e849772 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -17,6 +17,24 @@ bt_sco_codec: bt-sco-codec {
 		compatible = "linux,bt-sco";
 	};
 
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
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
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
index 89e97c604bd3..11dd23044722 100644
--- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
@@ -14,6 +14,27 @@ / {
 	aliases {
 		ethernet0 = &fec;
 		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
+		spi6 = &lpspi7;
+		spi7 = &lpspi8;
 	};
 
 	leds {
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
index 7e9d031a2f0e..adceeb2fbd20 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -20,8 +20,29 @@ / {
 	aliases {
 		ethernet0 = &fec;
 		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &i2c_rtc;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
index 0c55b749c834..9e516336aa14 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -18,8 +18,17 @@ /{
 		     "fsl,imx93";
 
 	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &i2c_rtc;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
index 9dbf41cf394b..2673d9dccbf4 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
@@ -27,8 +27,19 @@ aliases {
 		eeprom0 = &eeprom0;
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
 	};
 
 	backlight: backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 137b8ed242a2..4760d07ea24b 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -28,8 +28,33 @@ aliases {
 		eeprom0 = &eeprom0;
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
 	};
 
 	backlight_lvds: backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 219f49a4f87f..8a88c98ac05a 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -28,8 +28,33 @@ aliases {
 		eeprom0 = &eeprom0;
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
 	};
 
 	backlight_lvds: backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
index 576d6982a4a0..c789c1f24bdc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
@@ -17,8 +17,25 @@ /{
 	aliases {
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
 	};
 
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 64cd0776b43d..97ba4bf9bc7d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -18,40 +18,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		i2c0 = &lpi2c1;
-		i2c1 = &lpi2c2;
-		i2c2 = &lpi2c3;
-		i2c3 = &lpi2c4;
-		i2c4 = &lpi2c5;
-		i2c5 = &lpi2c6;
-		i2c6 = &lpi2c7;
-		i2c7 = &lpi2c8;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		mmc2 = &usdhc3;
-		serial0 = &lpuart1;
-		serial1 = &lpuart2;
-		serial2 = &lpuart3;
-		serial3 = &lpuart4;
-		serial4 = &lpuart5;
-		serial5 = &lpuart6;
-		serial6 = &lpuart7;
-		serial7 = &lpuart8;
-		spi0 = &lpspi1;
-		spi1 = &lpspi2;
-		spi2 = &lpspi3;
-		spi3 = &lpspi4;
-		spi4 = &lpspi5;
-		spi5 = &lpspi6;
-		spi6 = &lpspi7;
-		spi7 = &lpspi8;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.37.1


