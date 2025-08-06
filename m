Return-Path: <linux-pm+bounces-31998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDEB1C518
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689E03AEFA0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE528B519;
	Wed,  6 Aug 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GwhHaCG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52928AAE6;
	Wed,  6 Aug 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480569; cv=fail; b=NNQ/NvyXU1fzXHE/IupeX7Q9Qn32NLCB5PD4j9EE+d5+/g5l8hu+aKOUgGam/TILPsZQJS8rvwIucRlKZg7c5A7WrlH8Eju1/Q8xYjnw4scj1k0+JxGmT75ep2jPat5etx48YW+SoCK5MJsANWhtGUi9sHThyLbv3s1/OcZmH10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480569; c=relaxed/simple;
	bh=qj7GXLRGV33dlcn/MJxhKAdSGb1EtBIkW/GX4Ce1pzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPmjPzIpu5A/T8/V2bnM7xJ+ZMMbifbGjYbYfQAT0BUfmlymPckddf6l6bGEVNdIgHSsoxskQbvXx2JvZFW7xtKdHaz38bqmdFvoxH9vJREDVSuyQQfjFf1EQ+gWYvDHMs/83m2yhUsIQR7D4fK+EX6eTNh9nuaifa8y/vCZtYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GwhHaCG0; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6UDgvIoDkx57TBtBRSFDbz0H3vskx/BtlGWeUdCvLVkwFG7Ad9ByH6MFZ5LJ6Zb5To4LpZqlngCUjypsP8hYI5QYpPtqF2vZuO0/D2uZHkt/9ULwcNrrM0S1FnGMA08clfrvHsBuyZhpMDJxC5L5S68yt4yu/uppIIZ6i0kxPwV4EMsRuzNpx59QQp/vBuvdz71n2IENfHto0QMiHInuiqlnqSQOV8Kc0wFX5F3YQlINC1ge4DFCDW3I8Fl0OQ8tprspDKRuECnYRD5+LHRQXFZ46u8dhtVvkiyQcKhSoYd48pyJPgcajVnPXbw17wtBrc3OwOjM9tKuBMRttciRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yqrf0p0sXN5Qe8/Y8Sfdqix/awyg9xK5Uzsy4PnJ4A=;
 b=dgIVO7H/f8i4Nd3bM5w36zjy+rUkPNTqiyHOzQz7rW9lfX4bH2wGFCAbI3vsFpu4d9jHap55d3YtOleVenQ4fJrARgpZgmW+iU6gFcpmBngJ7W2n1gQBPskTNsZpZ1ufnONMnKbfNoz5m/nlEkEc256zEwR+2gT71XDnhIeDns5a70jbAcd/YUdQ9zcRtXzJAASiO8UsWlnnHPCeFQJ4SwBcyFU2ZpC8z+thOWbM3JUV9eCFj4rhxy/w1EM6HE02B8GqZVwZbmjFEUr+bh98OGTPgtvTNYdDok87HE/b9vT4pbOF7zTMyMpqBIQx8YiOMLkOm2APUl9THg4MBZ0XOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yqrf0p0sXN5Qe8/Y8Sfdqix/awyg9xK5Uzsy4PnJ4A=;
 b=GwhHaCG0WcWSj1YCLDkQzphbgjGTseD0Ch2e2X2ft3+JyzB9kymJclTSQ9xsuqM4pkRhPlc9l9MeoaLSbeDRh8Hiw7OJQ+RRUbIC4AO6z1f7x8QT0NiLjGVKEP8IPfVIn9hrkfsUKtlPpXUR6TaMrK77I13oBbrnrr8qfA8jSr47v4ggdShmLefw39ilMakQDrx1toBq6UWxrw+TFUQ0LK+HCLhNBCNF9VKTUrjmMNVN6jTuz+bA7D9ELGlHzxIGD6rDHDdoQnOm11iLp8/mgzvLYVsGGgvJ+ClMo1va864VneOBWjVRdBSbBq9Ee6O1yM/lK+7DI6Fa6/GqW6oHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 11:42:44 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:42:44 +0000
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
Subject: [PATCH v8 03/11] arm64: dts: freescale: move aliases from imx93.dtsi to board dts
Date: Wed,  6 Aug 2025 19:41:11 +0800
Message-Id: <20250806114119.1948624-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250806114119.1948624-1-joy.zou@nxp.com>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da630c7-a359-4f0e-b72f-08ddd4de5b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Exo4zFoef1tmmKdxJ3ZRdaD0tVyx+1uEeO0Tyv7lh64i/U2u0uGwGvNctDOS?=
 =?us-ascii?Q?uQcVm9Axsjb/ALDYEywuqOYW/Gqa8VHn69w1zAB2f5QB7CM9Ul3Au8NzdhkJ?=
 =?us-ascii?Q?cRGVWzhqOmBbS4WRmI83LLvms1/f6HSs6zDnnkB8+ao2+762KNOqozd2NrEe?=
 =?us-ascii?Q?Ih1JyIPVd/QdqTFUlotTMwSEgtYL1Ek/7rEGuwn57DezUA0cYsV8r3Ofni6b?=
 =?us-ascii?Q?W8mJuGp4Svva87ZTQYxXPIq5+Gsa3keKZ1+DXuFL0PxJDbRNKobmwKzJ1crr?=
 =?us-ascii?Q?hz15Z0xrgXyRohbLG5+ExKSi9frkCrKnuHN0wjQpWgyStDX08LF8WuQzIwR1?=
 =?us-ascii?Q?vefABe9MoIVyDHRzr+qcdrykbPO4iODuQpro72jqqMraexZVirumObAmNkPZ?=
 =?us-ascii?Q?T4zrTnUVA1V82zsIbjwYO0S4Q/JOxDeiBeHCFRtIeJZVmPo13H7t+3nBd5eC?=
 =?us-ascii?Q?6wYIzHRKN/c2sOPUY4HXgTsTQFWn5r+NpskVPl3kLRiEume1py3lqSmSBVak?=
 =?us-ascii?Q?zzSLkmkUBIab7mNziYqWoYFe7WfJD2WKN8GnE53vjzH2ZtYlGYTuCb1LdCRJ?=
 =?us-ascii?Q?gzc/c2gcReXL/gUlWgnduD1SxBTSy1BCvv3q5wQ4DL7AfAsxp9LSMetBbSmm?=
 =?us-ascii?Q?cn/8F28Nh4njBtQeB15yn0F82eKkfekJ5fX8/H7WJBR+oczsbgLgpbUmbKEX?=
 =?us-ascii?Q?r493eomOLMfitiZNXxij4VH9W3R3AcTmLWBn06Jsgif2zVD8AYLIx6fz3i0o?=
 =?us-ascii?Q?GZHSJUWCMzenoCqVOTZ2AgkTy+RDq0K4kyaipAarahkgAckCbsrvyua3ovPo?=
 =?us-ascii?Q?qa805BkbsGItQGTLFb93hZfeksa0WBx9Lpiy2rKsvZgrzvav4/0b5UzZv1or?=
 =?us-ascii?Q?LeOZ7Ljrce/2zE2TMg8hNOjnX7a76gtHnWhOU5ykVthDBoP61fM3vujiFpwf?=
 =?us-ascii?Q?H67nGsQ+xkpB0mQD8Rt4ut2yNFhbH9WEi7pRDC2LunGdUYuCHe+rNf1kK5hz?=
 =?us-ascii?Q?dDX2CTVwF4UMLGSC5VvTb1v07zBGG2Ts5/e6lvrhrSNjbQU/wvS3LD0JZ0Y1?=
 =?us-ascii?Q?L30nMxaOCrZGNWBGa48xEII8feNKATZxs8NDV2Tm93T1mAiugnLY3p1W2Wl/?=
 =?us-ascii?Q?v1CkJ22O8lsJ4x/iFsIB/j1oVEbhQlPk326gWx+ptMkHJ1MPQXW/JhcceGxz?=
 =?us-ascii?Q?XeGtC/t1MDcxzgwbxPlooowh56NIeUr6+hOTSGvcbHcd0L8f5T7e0swkgPeY?=
 =?us-ascii?Q?mOk0A8x4OpR2Cw3B/k8GW1INjChyqe7k/UUA3HxyPojLbF+Nu8juEM+jupKN?=
 =?us-ascii?Q?I2OTX0yvDzofic4i4awlWc9OYFUjPmCJRLOFTP17jMi8qmRk2TZOsYrcz2IJ?=
 =?us-ascii?Q?gyJfETctO55ex/+7yF6DDEpEhk9+ocelObuR2rzW4hKDy4QXTntgzd9Cgn4c?=
 =?us-ascii?Q?Dg+Ei8gCH+zein68HqOkVFAXQ2KagtdNDDWWEczY0tBpx1qGL0UTLJfhlXuE?=
 =?us-ascii?Q?dNcCI2T9QUnGWEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/OCTvM6GuIGqb0L1Xiz3k64MZMKluG87Ni8sgxbi01ptLsDbcyurnViifGhf?=
 =?us-ascii?Q?oDIkbN9yDI8vITeDhdnU1T6OXY3td2HIfc4KNPtbS1Rm4xz7aq+jWkZKGYy7?=
 =?us-ascii?Q?+++wlRZHQHpN2JJxjZxgxRnKGt07Xcuz0EKWkoDpJBBZgr6avW1tcMBgNxJq?=
 =?us-ascii?Q?HNstbalh+T69ZObw80a4+I4uNu7CiUupjiVYU7HPwHAqEmfaszsLRQ0lulgn?=
 =?us-ascii?Q?kdJUeLdq6wGjLOgcChkjhc6lietILaK9lRAatJ6Tv2Eb3Nc4MaKW+n97YnLW?=
 =?us-ascii?Q?EhnEmSoqn3UiRll+7+5z8yDzf5HyHfkFo8Oirtri8yJWtoMFrPsIGC8B21Eb?=
 =?us-ascii?Q?rUvidQ/CcxVD5Kjm3BQh6JK+aim4xuPbsklDUHr/g9eN1wpD4KkudlT5b7Ub?=
 =?us-ascii?Q?Mkgn/+q9F56wOBLKIRJGo3Tn2n9Ovh9PIxK0D+OUEi6WJ+okTA/dqBgdXzeQ?=
 =?us-ascii?Q?XEpD5kRYm0k89QXjYtbCkrhFsErZaTnKyBucz8lRt0qv6tNaliiptAxDkP//?=
 =?us-ascii?Q?N6+W5acJ6O9n4DIVjzQ1F4lth6urXnF5TufaOxqA4qNfyP7cwqrhJ5VDu05W?=
 =?us-ascii?Q?tKywsQbK6lEYZ2ss7PBV0QvVJjNxOhHv+FfZgirHY3RLVlVywZ4LWzFFbsBz?=
 =?us-ascii?Q?0sczcN2PgO2qucvJGpGfsl/pgzGpsdurGgp5Si1pAsIw+JavTl8278Vc8+6r?=
 =?us-ascii?Q?vL9bSXV5Gx/vhL9H43IcdU3NXgbxw9ycsl14vXwiUb78HuRV5W1TiwxVO+fT?=
 =?us-ascii?Q?PGnTUtkNnFykoGLCbX8hJ7CeEbOq1gwA3gdtj91Jd4Uih+u4PteMrLn2GKJR?=
 =?us-ascii?Q?cpFT2CcW/9OLCsbfNpiVZa3CtUgg0maMwmCGTzjZir11/XjrWJ2I9WL8JV8c?=
 =?us-ascii?Q?5zPLjCg+N44Oj0sFjrLvd48ZDTWrBvguYlmNKwTng8YycjXMOBz6xTOMdGO7?=
 =?us-ascii?Q?DFAq3dt5Qem8TNfXLIQROd5pnCsKR2yDDXvEp/b4yHtQDF3ecJsUin+X/XPC?=
 =?us-ascii?Q?JY4QRyiPFSxesQkG9F7dOgKhHR/m/bVjFiJ2shBNgz0TvpkhlynC34sCCaEV?=
 =?us-ascii?Q?RbSsH0EaU7SFFOrMkJYe6ZQ4F+Bt7rWmifEgJe8d8G13WExVOC8ma21IEgaj?=
 =?us-ascii?Q?ZOwfftEublEc6FbIOZbamRxJX6eJuUZwPxachM4CApG+P/N3E9q8+SJfQTlS?=
 =?us-ascii?Q?XUQGTEHeDGdOkcOXjYpaqIB/c13D5Jk2uf3C1yaMx2VbFt6vBCmmT44kEuCf?=
 =?us-ascii?Q?XWJuigiX5A9kiOoFaitV0Uh0pqkN7zUzeZhbFX2L9zuPs6VLdMG+oLcs/HK+?=
 =?us-ascii?Q?JHf0U+Llz/bEupiuezdyMUnTX+7uv2HGHJNPdfwps57viD5mSVJlj1kmK9eZ?=
 =?us-ascii?Q?NB5oHEL0zWroovvLRBZxLQI7lqhnIk3tFman7jZLWNwnrGCoWZI5hmW2L5Nl?=
 =?us-ascii?Q?P5YKedIF0/RJFa2iCcYRJJg12M/arbGnNe+Zg0+0PToukQ2NrYws1kPcNEeg?=
 =?us-ascii?Q?HIWOVptYAzo3z8TpAhtvlpHCwKe4TDPsXwmUmugQ1aQkXOr19Q9VS4z8kPNX?=
 =?us-ascii?Q?qf+wHVisr84G/+pCveJHkBjivXsRdC2UAwwop3ML?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da630c7-a359-4f0e-b72f-08ddd4de5b92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:42:44.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va2Z7U6Kgn2ZMDx4d9XKUUbALHS9lpMkxyWwLW3ucsmUGz6TprOFU3kUqyFOzamU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312

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


