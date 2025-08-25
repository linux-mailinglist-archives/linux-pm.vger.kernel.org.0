Return-Path: <linux-pm+bounces-33000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C9B33A55
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE3E17C08B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3D2C21FE;
	Mon, 25 Aug 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dYniLqKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991422C21F7;
	Mon, 25 Aug 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113205; cv=fail; b=ql7PFVKXxnAuzAz45J2jL7xmrLnrlrsQnvvlLhji/TZD4/5qUr+TpOMZAQg/258mHCcH/EG8Z2KQBW5HyL1WQUgBfTUJf4YVWCB/C5WWhOOPsV7mZ0dRI5nWPPn9lC6M+Jx1RMaInuYlCMnprgDz/k2483GHZZiG+/TPUIHBEIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113205; c=relaxed/simple;
	bh=BZV8Aj1vI6DyMQmOd/ftKzqOJrj9z/JWih9KxFAuMes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8FqouDSBvqVHGi98+u6sxcYTTzGAcxu3JNPvrKMyz+Qd//mdED3tjsQRzAFdbmj+Qg06AhGTqYRoRSt5y4U400PaPL4GLl2KBH3RhCWK/TkjV8THhlhDAHiOS0Ve6sskYAsYbBdJNKF6duom6Rol4AK1nJwG5b8YVQjp4WZ6aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dYniLqKS; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkrdiKr4rqzumNrVp7AvlatiloOXbNP74ln1NEVsldH88kFnA+XmzGHMtoly7oCFF8TtxCFgsePeM79zmHNFtp1uRFKz+5BsVzDPFN3T9GLwRksVOZfYYb0COWkmK6+b6ZkW503S9fvhdnsHLW0vLXua7y3CUNVU7w2LjlZz+6/EaqMMUqm6cTsQtvZXBcJiXTjIk1f0v5bFSwkhm8Y+p67F3x950eBvXt0+WB7Ls8jwISqTZSEIEHiA2OnD73sFWPxNLeJ2v6aqq0Q1xUoS0784bBcTYS3ISnskQ1OLG/ZvG7IboX7RSYcGdNFPCRZtSDUom1XDQvsfvbrl8+slaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfWeERqCIbKDz8OEMqtOnSFVdnV+IkJykDd1ndqbDCk=;
 b=juq2F8HQxx/Ilf6niUkBmyaR5acdbNtdBynOrlCiQ9NdLYq5+g11UsKzY33X+F0Q/fpyXJZa+4t4E4XY0+JpUiz3WNXUlM6Wx48oz6tbIBRIRh4nbfD6tf1J6GIl+yhDaX9HucDU74+d4uyLBy/RtEMNXDKHj910wVZIzK1NV62RtKiOPSlBCUzR24yFM0ldDEPggJNUi4Cv39tYlUWB56LDPfbM9PgPfCoh1IoXQzIygDdXYyQ/x5YkIdHPEJuC1PEfx3Hk5h/oKDsXpVNb2Y5sgsoDXC0whOp5gtn/cfJLU2/YAK0KTaNCkZB/DFfe/pXBwNgPzrqvyxwkiB5now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfWeERqCIbKDz8OEMqtOnSFVdnV+IkJykDd1ndqbDCk=;
 b=dYniLqKS5prw+zdJjunGj416L7J+EljSX7my0K8uiQVMVHqJ61pz2qAD0xWkjZ9dcWU2sChm+lFKTX/hDzNzCWidxe6AMiceqzlqB0NVifXFMEgQOAEFn8x4s2VsSiyH3RX6C4JUFb4qUX6XY94fDB9EjMlDMhydGCplw4WHPOZHkSgQ3RgPjkV45Pm5YT+pScmPmSXhNJcdFMyfxEbopSelPXJFa0jY5rDi8pRqcrz9Eb0GqptnCxlxEDY5r3HqqSw/BWSlnUHsj+d095kN5Fee26CDWMuZ9pMigR7QKRUTzuu+uwsO0Iieuju9ZPAkRIa8Ly33Job1yhJd2KDqqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB11264.eurprd04.prod.outlook.com (2603:10a6:102:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 09:13:20 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:13:19 +0000
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
Subject: [PATCH v9 1/6] arm64: dts: freescale: move aliases from imx93.dtsi to board dts
Date: Mon, 25 Aug 2025 17:12:18 +0800
Message-Id: <20250825091223.1378137-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250825091223.1378137-1-joy.zou@nxp.com>
References: <20250825091223.1378137-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB11264:EE_
X-MS-Office365-Filtering-Correlation-Id: e4668208-d1c9-4caa-0aea-08dde3b7a1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odIDuFXe+51FuxIVQu2U17ORGkiG+fn4DRFyk0WAjhpIQPMdDoKnEq303dLB?=
 =?us-ascii?Q?iVcisQQwdSml6bms1WxsZF/t8+ysrnnSfT+J97ob1Qya1MirWr2ghf9AEJ4i?=
 =?us-ascii?Q?v4PzzEdrAi9F60g//EZ0ZgaCBR/Ajr75YJqUYL77Va4rxrgAK3OfDcOf6BwU?=
 =?us-ascii?Q?56L0RC1pVKksQ8RIwI9PWKz+BHUWEizONwJCJuOXCWoGfmPK3JRf1mX45nlw?=
 =?us-ascii?Q?Fu9Hmrv3OSh+ol4F/hnfpP1zSrjSRh0/pA+GqmUZHhkdnCck8qPv5COhjXzk?=
 =?us-ascii?Q?9uwnIe5xhHBOJ3lmfOclQgNS9QyLuINOgxJVLtiJlbrxVgOcXGKxpZcT4Hzb?=
 =?us-ascii?Q?uzv++tGxa1X5FQ+PTWfiti1AtRvRIA9a+6rHYene+QezTxcjTwKhErYaSHsK?=
 =?us-ascii?Q?FkYJEd+KGpewcF9Njr07bMWU+U9ajYL8HKFSZUBbuWruo9OXS1rcT8PBDssA?=
 =?us-ascii?Q?ZdNu2dVOlqAaMG3+Y8FF0oe+hXjI4+EjliXYArFCN1dhbrJv5zzGjZowoxo8?=
 =?us-ascii?Q?lPGxeiKafGF/oaPGW10uXFHPpCh1sQn1frCft0MPO+nhJnICTAbx6NhJ14iO?=
 =?us-ascii?Q?lFkCtR7mwjoZAOifho/ugaWO0ti1xaA5/bWHkLGjFLT+dHuZPrvm2k5EeDOR?=
 =?us-ascii?Q?Qp9vA5Zy5hXwHtNvYybtqTwM7Kzak17uxdTOJUVoyGWPVU0y+ZO38nYLcMlu?=
 =?us-ascii?Q?MJ1Mg/XQysLJZ2R0I5hozHVVSnWrw/UrFPLn/JMiMyAzOnQsEUnPnpni47Ti?=
 =?us-ascii?Q?IEgdUeIwVzJaePhjKTfjxRtQyYTQPPKJLW146vDrHIEZEZ1f2rwlSA3CfIN+?=
 =?us-ascii?Q?tQamqWUKP8pq69IEjR2ZFflEKWIT6mbk9tqXAWog/IBuhvP3JQjrQmfQSHBj?=
 =?us-ascii?Q?cxT9Y6fmINl8s0x4QHKm1+iCJ8sfL5bcbfz8mVCSX1cJt+Ok7j6Euef1Bz+y?=
 =?us-ascii?Q?ZGGB+5xSUm7DPF9L7gNXouPGD9yulc7WCBBXUYIKAyGFQMbSM/YNHaG73QEg?=
 =?us-ascii?Q?wJcJx2e3o3dC9/cEmsWpG5KxLO5/g9L5T/L/pWdpZSxCaGPe34haX+su/kB2?=
 =?us-ascii?Q?ZF856s/gcgqh/E1pVYJgGij9oIo3wONUcjNALqo89q/mwNO8dL55lxZGe6RJ?=
 =?us-ascii?Q?kqFNj4plVaiHc1Py/dWPY8Zd6TpcuwhnC8MBa0EHFLwhYQ85BB55igfEQKjK?=
 =?us-ascii?Q?rgAiMrr9TdHskWjVEycc/ThmLSgRaXoi0nUFeBIe8/bDg/8QI57SkQe5BdZ6?=
 =?us-ascii?Q?OB6fSv1VrradbkNRi5r+tjVLnGnguOk3Jb4WpEb54MejibZIx6gHWh1O4Mj1?=
 =?us-ascii?Q?nflX5PHB+tZelgP3bMcdfrx2nV96bmNuq2BmXOz+EOLbHO2NGeRdhf8K6j0p?=
 =?us-ascii?Q?mGuc+dyvo6L/MlLJMFzOMLfWzIiQhHbRTvPPJunJPF5lE8czzktOiHOZBemb?=
 =?us-ascii?Q?lmmPd8xk9bicrZ+D3R0djYNm+Qvg0nKH5XwD6S1inSF0ncnDwMGQpEiH49vE?=
 =?us-ascii?Q?AXy+wMNsGVQ6/aUubbIh3YdJxm9KsZe6luBG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lzsMnmiBmAjSnVJmp6awQerLKRB4JH2UVMqCR3l4ALHLc4UMKi4o8QImWqcp?=
 =?us-ascii?Q?Te2BQ4M+1CO7ih9bQZS80+hTXFjPlf77zcDI47PPNelVqNr84jhQXWN1oSUW?=
 =?us-ascii?Q?Glrr3BKUNjKv01QlAjoP2ImxIno+njj87XZLc65sNJd0Jf2R0rS2gr8GNRc6?=
 =?us-ascii?Q?rmjohvKbstjAqPGKm+zywxRZsVifh0NnxilIjyYKCPK6OtDChEiUY84RYy39?=
 =?us-ascii?Q?tBrjg5xjoZlySd1CmKVLAxt/+xPd2N4IhhlAA/9g1nYMO8M8KTihdiSd1MoY?=
 =?us-ascii?Q?Sha+aAAxpo6lh+qmYNDEpSH2T38A+XNh6ArqtRS6ZhQ1d0bEtZFou5W9KOxD?=
 =?us-ascii?Q?zqzVAx5/pTEeE4nt1gc3c+CkPmXj6zPhT+Rs4l+g1eqWpPLdcBCfZl0BZY3h?=
 =?us-ascii?Q?SOMFQMtwFqcz5YEsf0sv8sHZcNfmVRRRhu10EZrk+kggkJvP71drYxvzwzRo?=
 =?us-ascii?Q?iJ5/lMvV8qB7UA3jajGIRouM4xSi06Rsp0ev7xhFxWBsb3Ip3VLoPfEmAfT2?=
 =?us-ascii?Q?HQYtEDTBCOcY0SYDhrUFmZhdIRQWA0PSwWAG2uSvH7wnlq9epds5oUvjNv8X?=
 =?us-ascii?Q?dZigYZQar5yK8hammq7e3qAztilp4YYfvKMrjMQZgxMVWBAyRHA9ejTCdtJB?=
 =?us-ascii?Q?oVsz7ne1CPWMTRmEEvM+DXHxeFGJfG9VIlvQHR107PZGx1YtAPyq3fGD/qaf?=
 =?us-ascii?Q?2s2lgVXlBI7W6ACTtboRh3GPnjUAQLgzTdBdXg8jsYEo7/GDkfNR2BuGAgsM?=
 =?us-ascii?Q?EvYDJYNbZ198ihpelmTFOnQl8G1PppFGcn2itWZecjj6M070HfvtweoOXS0b?=
 =?us-ascii?Q?Ux3FnFxsZi+1QG0K0ysIN+T/QrlIn+Vh/GuTL8/RSNOa+VU5sB73OZnNuned?=
 =?us-ascii?Q?9QDNeTU4it+OHbUlRPNZHSgKvhNnqBf0i7c+mkL7REPu6a83SZQZj0BB+dWx?=
 =?us-ascii?Q?UkpxwtpNCaizryXs6EoKy7o3uX9D3e6h1xWiqL6zOxB7kDI9gF3V/PB5HCQj?=
 =?us-ascii?Q?k+VKwkLfRoFpgLOVvZCmYCyC+2UxnFq92lm/JhbWNxhGDjOpAgwH2fLfMCrk?=
 =?us-ascii?Q?cr1yG7aVJyFLPZ+Ke4PEwDlL9P319D60JPhSfBTDCBWq33AgiUoPJeEQn57P?=
 =?us-ascii?Q?WVI43XFVZGFmYtPLR6e6doE1jtTmYWjWmibZUf5FnoklrMmwlJLLB7hKwM85?=
 =?us-ascii?Q?FFT30zXAFaSMW/9la6to9y0nuMEOAns62Cc+BcEcv76ALcNQGI1GYSXlJEmG?=
 =?us-ascii?Q?RcwLH73d3ANMvAJtqYrq9Az8prltsKQUng9fgONwfB2uYVcreI9ma5gIbk2Y?=
 =?us-ascii?Q?wTXibpD/y5OdL1K8k2YaCzrvW0ZW4jzYQZs02hDdmnYTgAlH/VScCwuqRA5W?=
 =?us-ascii?Q?/pVPPMeeWbXNAJLV5EfLiN4CMq0bVZY3sLxLRu1kxSLxXeHL9gmgpIJrcEuJ?=
 =?us-ascii?Q?pZAlZV1BPVfQOpys5gT5h3IF7KzkxnP5XS1QMAXh9J7EWDq9uDm2fjA4SUdA?=
 =?us-ascii?Q?swY0YJ51Iih1GbztHQMVOVxxVlZYw8lxv5HMXZ8LzV7c4zVAaayXsNc9o5bz?=
 =?us-ascii?Q?pPRXuPd4kOaImqEmE0Vzeo62CevT6I6CCHqdQrX1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4668208-d1c9-4caa-0aea-08dde3b7a1fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:13:19.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6F73Q9bP/D8j0IjJ7lJyXlyALxp8L+KuzmeP1Kp/9wU+CIAv8C+Iozv3cWaOOOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11264

The aliases is board level property rather than soc property, so move
these to each boards.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
index e24e12f04526..44566e03be65 100644
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
index c5d86b54ad33..da252b7c06cb 100644
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
index f6f8d105b737..0852067eab2c 100644
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
index 475913cf0cb9..fa5d83dee0a7 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -19,8 +19,29 @@ / {
 
 	aliases {
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
index 6f1374f5757f..802d96b19e4c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -19,8 +19,17 @@ /{
 
 	aliases {
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
index 8a7f1cd76c76..d505f9dfd8ee 100644
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


