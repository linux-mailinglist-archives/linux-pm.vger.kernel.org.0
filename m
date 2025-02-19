Return-Path: <linux-pm+bounces-22514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B27A3CCC5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0716F1724EA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778225B693;
	Wed, 19 Feb 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="akxzYj+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BE25B673;
	Wed, 19 Feb 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005779; cv=fail; b=O7TuOd9uOEonB+QGqbIIFCnDU7SioRUJgwKp4M8foFl10mIZqqgQb+525/DaLxbF/cBy6yfmxPLu/Mgj2e1wmIx7X/8Ursov1SPHKTj5j6JEIMUigx2mIEsQVPjQ4g97M8iq8xY6ifSFgqnyUJaxH8F6rTsblohIiOdqN8gaksI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005779; c=relaxed/simple;
	bh=45NQux+NGlOr77UH0vkxjubV2s7JcYHLujX8IyzJL28=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=RAvGHrAMPljtnp1Cv38sksFXvidLdZRi5Zb75BdUnohFLcC3tu3LNHOxLuOWKZmIna+27r+LPP3Kr6cuxVUzxXe7xDrctGpZwJgVdspUf/e4XpFwpa6DZ/ufbQ6+IHEkELMWdlO7PhwATxVe6zxrq//OUhEI11nHgJdRFoHW+QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=akxzYj+a; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByJ8DDgry+AbmhdgqakgMHwZIQO6J04lIMDLLslt8k43D4gu3JeiTPP38q1q+A6YbyaSYzdd4KEsSupvxoxXsH75wD3Z71hweZslxi0PwRZskD6Sk+BB18NtmN8Zp3uP83eRfLy1AndLvR3oSeBAV9Ti0XiwWBDdvmXJGdBgahoU5s9w3JY0CZTzulswR21LjhRiAvFQwcMGXWWXrLsQzB7lCT6YPW1vAo2Pt+Y0e9A837tNPHLQ+FYipQDaJbJtrX7kJSSk7qV40SxNYeHqphq3ig0E/BCX21zwfFzDphd4yJTEeYwYMjmItDDHQXaHnbfsmBKqi+Hu3LB8AH8/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7SsYY9g2JpJPx0ETS9exk9gSAK1HanR3p4qfeE1200=;
 b=L1w4jNLMhDkiRhrJpFXSrEyLqvU1qz39qT21IFfM9azY+MGfYzzpZCkl64VF8mBdAeg+ZsFH5tAmM7HGItsp22/A4WCjV0jQPGeGpEc8RkV/OmbmkGOxv1FQiPo6ttF0KSxTHhsX+K4Ekc9CcWUXaV+4SSbMfZp1RBlL+FFSA4HPxXh7Cb7uyKHW+7UPZkgpxPUT/XZHz3FNbDZ9OtGCg4luPoAAZbojito09Tl6T7u8EnG1F/MBFHsHbpRtv+Mc6J8HYLkRCy/BBTptO3Yx4TEhmUhtTc+6a+Ckzr7iRCMY7TAPEDqcCgYFOR56kZzVwQ/Azi3nm2Pe2KKUDYoHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7SsYY9g2JpJPx0ETS9exk9gSAK1HanR3p4qfeE1200=;
 b=akxzYj+acurpRtJKvFexjGhE7moEDhT21u/hGQ0SYdStY/9sqVi/527PPJ/qJe6IPPV1QcoO+oSRrhkK/Scl5/5VgGaAuaZ4prLZk+h6FAwF3ALfBPnNpc5Byo0u55vgi+bO1tgeV+7qv3eMvdpi2wAqQ/j4G4kHYGuh5gbdxNJaisXWD5l4DK4/M17HDZgDZyYsm1UNUyoVUwAutcIIVW3UKDVliHc6xy0T8r11pTgVf9zlTbTIS+iLdQL5UCA3xfBSrdc3gqX1EpKAiMYtfRzFbeFhKiBKZkLGioi1oZJ0iB9YF6shw+y09JDgJJn/01CYyRq4Lt6EKLxAJl0aPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 22:56:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 22:56:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Date: Wed, 19 Feb 2025 17:55:51 -0500
Message-Id: <20250219-imx91tmu-v6-0-7af2281bcada@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdhtmcC/23OQW7DIBCF4atErEsFAwPjrHqPqAsM44aF7chOL
 UeR714cqSqWunwjvl88xcxT5lmcT08x8ZLnPA5luLeTiNcwfLHMqWwBCqwG1cjcr42+998ydBB
 8VBYSJVGe3ybu8vpKXT7Lvub5Pk6PV3nR+/WfyKKlkp6wiWjId0Z/DOvtPY692BMLVEyrikFhq
 AyEkGwi4iMzNYOKmcII2aNrobHGH5mtmauY3T+JMXDnLemWjgx/GSrQVDHcmYuqBe+8YffHtm3
 7AXYSAYh6AQAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740005766; l=2449;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=45NQux+NGlOr77UH0vkxjubV2s7JcYHLujX8IyzJL28=;
 b=oBSOKAVVFzyo6gxguqXDiZBYqTjBBB/kH+6N0VLj83+BDYBa76VdBsN6OLM7qzV5jyT85lahX
 55bDae2x/M4D5JeU62R66gYeo4lwrbnNqS4dsjjAd3JLDU/gWEv0eD9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: ae493797-b34b-478c-7a27-08dd51389b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVFEeXIvZEpOVTNUcittN2tYWjJEQzB3K29kZVJuWTBQQkNxRXBGZk9GUmRF?=
 =?utf-8?B?OTlBUHRnSlh4OHN3RVl6V1hNN3ZVaTJJYStadUhXVm5CUUVzZEl2R2w5R3RD?=
 =?utf-8?B?TWoxaXZqd1FWRjdGNlJQU01OZEhJSlA3MFEzam9MNWpqT1E5dkZrUnNyaXdR?=
 =?utf-8?B?Vk0zZ0FpdkZxZWFOcTF1RkI4UkYwUW5sa09lWGxhUlZlUVZ5QnNrM0U2Kysz?=
 =?utf-8?B?TlYxRnN4bjdjZkRrakcybHJMSVNyaktKS1d6azdTM05VNW5tMEtUK1hodE5v?=
 =?utf-8?B?NmNUenpna2s1RmxtYmFCTHBqSERkR1VIRlg1cEdFNkNiVDZNMnJiaE9ZT3kv?=
 =?utf-8?B?MjdnbGlGOGJabkMrMnJsaDlma0l0Tm90cHVoTnZ5bzBmbDRQTXVrV3pyVHFN?=
 =?utf-8?B?RGphOU41MnhicTl0UnE2eUVjOVdBYzBQYlRzdG9LL2VUOC9CVWd3eFRpcVkr?=
 =?utf-8?B?SzlmdHlNRm1vYnJNdmtwOUhrVUNXR1V3K3VGbmhNWXFPZHJqOUpIWVNCVFB0?=
 =?utf-8?B?RzllRWJVbkJ5Z2RuVWZMN1M0eTY5OXlwWWJmQzk5WWFaeUhLRVJySkVjUVpt?=
 =?utf-8?B?cFhDdE1ZLzg2SUd4MjgybzRyZHdMWTN3cjltSTRFWERwWGNCREZ2bjJFL3h3?=
 =?utf-8?B?TG1XOE5XQjhQYzNDRkczQUJZb2lXWG8vUEVDWDNrUDJjOFRLSGIrOCs5dmNP?=
 =?utf-8?B?YnB2NWgyK1lUaUlkNUtEQ2w3YUZYRXcxakVHZWErbFVXSXhhVW9iYnhOV080?=
 =?utf-8?B?RzhLSm15NVJrUjRsbjUyWDRsTmE0NUtuM2FKb05jaDVyYmpQY0JOQnNIZSs1?=
 =?utf-8?B?SHBaRXZFSnIyL1dHQUZ0TyttNVJ1QVRWMG5iRERKQWVkMGcxM0RBU2lnVFZV?=
 =?utf-8?B?SnVBSWJPSWtXR1Vjcm1DOXJhOC8reUpSODhCbTY3NzYzVGhEZEV2amdld2d5?=
 =?utf-8?B?cUpDVUQ1bWJ1dVdxdDZ4MnpuWm9vNlRMV0VudFFPZSt5MlNGbWZtdVVDNU5J?=
 =?utf-8?B?L1o0L1NEYUtScHBjVEsyY3lMMXFNa3I4OVZGcHlEQTZuRWtOUFRuNUN1VWdV?=
 =?utf-8?B?akZaYksrREZlNk4zZU5mNVhnRnA0RzRUc3B2VHBpbTQxcTdLV1QrMVhXdjZP?=
 =?utf-8?B?YWJLQTFhakRrcXptWXZTV05HRmcwUjlCKzRJK0o5ekxSdFZmS0VpMVZETkh5?=
 =?utf-8?B?eGlPSEtNSDdkMVZOSmFZaUZzaG1BdDFIeHZZYjRYall3Zml3NVlNcERacFkx?=
 =?utf-8?B?UUVWUjZNMjNMMzd2WkVqMldIN29NMnlFc0QyaHVSRndROHdkQVAycy8rNUxX?=
 =?utf-8?B?dHRnK1BpQnAvUWJ0T25pU3ZQZkdVc2twYVFDRC82Wk4vQW84TExNLzNwTWJm?=
 =?utf-8?B?a0p0UVlWQjYwbU4zVktiOFhkN2JvVnhQbmJPeFMydEdRTkJQUkI3bG5Gbldr?=
 =?utf-8?B?azZteWtQNERlR0xhZmFmaFJjTTBKSm5xUldGODFCYVN2dndFS2p6MDNMb0NN?=
 =?utf-8?B?RU5RYTVUVVZOU2Y1bnBYeTVIbDFMbEVzNytybk05UmVNL3hLUzRNZXRXUlpZ?=
 =?utf-8?B?Q0ErU2ErUjFOU1lsYTltZTdkTmlyejRnMU9NdC9lZGxWeXdRallkSjNkQnlM?=
 =?utf-8?B?QkQyRksyQzlJQnNrOTluRUZuNnRiMWJlVDRMZDl3dDdFaEtxbFE3QllCWVZE?=
 =?utf-8?B?dk5KNmZsM0pEU2lwYS9BQ2k5QmZRTk5mMWhieGV0QXkyMndVOEhJUi9xRHF6?=
 =?utf-8?B?R0dTcENISHBXVkt5V2xlWCtyL29sZHRBREttS2ppQlYxZDB2ZDNCM2hHdzVu?=
 =?utf-8?B?cDZKQlFtNnhWalZGdkpVc0RoK2ZNc0pPOU1ES1RBcy9sYWR5QWhKNkRCekxu?=
 =?utf-8?B?ZWZjVFJIcllkRHR3YnFTdU1tREt6OUgyVGhQSURyUHVsOVRxNkJCZWo0cXlU?=
 =?utf-8?B?UFpod0NxL0JwM2FXT3d0RnBTUkpaVlByN0pvOGxkelJZSTZ4N2d3UEVlZVNy?=
 =?utf-8?B?Y3YzZjVuMG5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXF1VVVGOUh1Sjhybjk3R3FnODdlRHdkZWw2SGxZMXJZdVB4NStLOXNFcEJi?=
 =?utf-8?B?Z095Nk16Yk5QbG81Vmpya05jM2lwbU8xL1ovN2ZqK2ZBcXFyRTFTTTdyV1FU?=
 =?utf-8?B?aWRKUm5pSDlzL1gwTHUwcjQ5azh5R2lqQ0VURWdkcWRtY1RCMHFZSFZFZDZH?=
 =?utf-8?B?VnN4eCtoNmQ0cnJvcHZGRURmcjZmTkFzYjVyMU9wa0ZFb01EcFErdFFDTzNK?=
 =?utf-8?B?YUg4QW9RUGJIWVI5cG96Y3l3aUIveG1jek4zN3ArMUxRYXVMVGE4KzNUT1JU?=
 =?utf-8?B?cnJuN1RnSG9tV3p5bEQwazA3Si9jeWZnTEl2N3dWWFBwVTBSaDI0Nm5mQlE5?=
 =?utf-8?B?a01rVE11SXExbGxTdXRIR2gvTnFRVWVNT3FJQWlLRExNTGxaTnhkZFRsaVJm?=
 =?utf-8?B?RThTZ0Zlc1ZyOVk4MHJRT3l2dStWWUlZYzJZMWlkNUR4WEVXekZBbUFCcnVS?=
 =?utf-8?B?c1B2SUsxdnB6dTF5SVZDS3FmL1IrSWU0RFd6Z3Jhb29WdjlMZTNuVytXL2xR?=
 =?utf-8?B?ekdsbkdsK2YwRjFRcXBkOWNGazc3VExXZ1d6RlB5cm8yM1BOQmlZMElsUjhQ?=
 =?utf-8?B?VnBTaXFFb1I4dFJvUFBDT0xCWEh1SU9IWDRjTkx6ODFGVXFkVUNHTkVxSGxU?=
 =?utf-8?B?K01LZFFHeVhyZ0R4d1BhNFlrc1k0WHdKNFN6dnF2QVVlL1NRb2ZSdGE2T0tR?=
 =?utf-8?B?bjBDMXROcUxvTEFkUW55SUhFL2YzbENWdTVQanRzRDdqcjNtUjZncXR5VFVL?=
 =?utf-8?B?OXRiQS9lb0JWVGRvZVI3RTFxTlBialMzcG9yQ2htaTlKTTE3NXdWdWo0WUZY?=
 =?utf-8?B?ZDdZWTdaeE1KWnViVFo2d2hNWE1PaDZ0TUpjaCs2eE1RUi95V2Nra0grc3Ns?=
 =?utf-8?B?S2dlZC9RNGkxNEFUaHUrbVEvNUd6VlFPK3BoVU40aEVlMncza0VVNDM5RVQz?=
 =?utf-8?B?TGVkZEdHZm5Eb0JVaG9UY01mYnllcmd1RVpkbGQxTTcxeGc1N0o2QTc1OFdt?=
 =?utf-8?B?Qi9tTEtmWFA3WjF4b2cvQ0lhYVBRM3djNGJ4ejVwYWJLVEdhSzU5T3lqN0N0?=
 =?utf-8?B?UnE2Vm8yN2xVOWJyMlpxd0V6Q05saXNPcjkreWFFR3FtaVEvRHJLVndpVXFl?=
 =?utf-8?B?UlBTdWhIYkFoS3ozbDhWMzJIaWVSR3pPV2ZIa1haK3dkbGdIcXRqeUpuSGJh?=
 =?utf-8?B?TTcxdUdINGdSNGZIUkZFdjBIQXZxdWhITFRaa2dOR3FOa05TWEFjWEVsTlI3?=
 =?utf-8?B?MUlGTkxadlVGWUZpaHhQMEJBRW85a2ZrZ080eG1KNkZ4UVZuWlNZVTFSbEhW?=
 =?utf-8?B?N1lFTTlBTW9SdWZWS3Q2Mlg2TkZjZ1RyVDIrVEZzbUwxZkpLMXNVNnp6bkxs?=
 =?utf-8?B?VE1hT0RYWFZQQnk0Qm9IM25ucXVpSkphR1FrQnBYZ1IxYnJqOW1vdU5Gd2xE?=
 =?utf-8?B?cm9EaTJFTkpSUEorMEMxalhuLzlWS3FSMlZ2b3NyNVIrdlh6WTY2Y2FoYW9i?=
 =?utf-8?B?Sk1LRWhkME56bW9LRWxYSkpPOE5xelF6SDRSWXV2aHZkT3ZtbHBoOWo0cUwr?=
 =?utf-8?B?V3MwbHdDekdJV25jRWxoK0svMnU1Q2NianFZR2FZbGFSeWFXQW9TY2V1VVJI?=
 =?utf-8?B?dXhCTE43QnJ3MDVxeTRBY3NndlRYZUtHMUdkR1MrM2swVFJXUXVkTVF1WUlh?=
 =?utf-8?B?bTFOSHhrcHFXN0hjbXY0WEI4TUJGUlBWTFVIYTZIUW5hWjRwT2c5WkpIOWFP?=
 =?utf-8?B?Yzhzb2tYVitnMWkybW15Tkl2MlBia0dyQjhGcU9WcUhxdlJyTEFaY3pVaG5Q?=
 =?utf-8?B?RHcvaWY3dGZXbThzUERLd1Nia25kOW5qRVltSlZmR2xvUmFXMVlrNE5vUU1a?=
 =?utf-8?B?NERheUxxaitQNk1WTEdJN2srU3pKS2NsSWxMM1VnaXRpOFE5c0hGVlhuQWQz?=
 =?utf-8?B?RXVxQW00bVFvVU1aOHYzeWRDbHVFeE10R0tTeGhxck5lV0h0VkRzbXlRaEdX?=
 =?utf-8?B?YzMwTmZRRXp0c3lERHBEZVB3UlMxdkxYVTZ4YURQS294V1NvUnNFUzcwMHpx?=
 =?utf-8?B?NEtKUmhyL24yaU1GcDFMMis2a205eWduZHg1TVhuTWM0bkEyQUFEM2VBeGUz?=
 =?utf-8?Q?PdIw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae493797-b34b-478c-7a27-08dd51389b11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:56:11.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eliDKnQiyiFe7tClCfxIeJAeEg0WHGdtNMe/ME6KxMZqq5ytxA+sEp6K63uWOAdjqs7k54ma9BkhfY8jO6DdhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251

- Add binding doc
- Add imx91 thermal driver
- dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
merged, so not in this serial.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- use set_trips
- remove mutex
- Link to v5: https://lore.kernel.org/r/20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com

Changes in v5:
- Add irq support.
- change to period mode.
- Link to v4: https://lore.kernel.org/r/20241216-imx91tmu-v4-0-75caef7481b8@nxp.com

Changes in v4:
- Add Kryz's review tag for binding
- Add Marco's review tag for driver
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()
- Link to v3: https://lore.kernel.org/r/20241212-imx91tmu-v3-0-85e756b29437@nxp.com

Changes in v3:
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties

- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
  uboot may change and enable tmu.

- Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com

Changes in v2:
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
- Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com

---
Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  87 +++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 398 +++++++++++++++++++++
 4 files changed, 496 insertions(+)
---
base-commit: f50e59ef812d87066a5ab07c7bafc54aef378c20
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


