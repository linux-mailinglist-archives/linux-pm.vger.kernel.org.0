Return-Path: <linux-pm+bounces-36506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10CBF3162
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3444C188ECAC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916B2D47F1;
	Mon, 20 Oct 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVkXSzk8"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BD2D061E;
	Mon, 20 Oct 2025 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986880; cv=fail; b=C8C+jtmeDbR5uv6GQnYYIl66rnZtTMFYB7kpMpJK1stGNLzW3CFvTEi3y3qzm/kdTjt2hT+K92pZPhXNpDiWRX0PQ99f6FwuRSwJoqdmp4MSatEhWVvlJ8IaxgawBRpOYE01FLNRjzwm8YOcp6rOi+6FwsQ9LK3wgLzMEvjCXS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986880; c=relaxed/simple;
	bh=kGLa/9dUgWUe54P6xWl212xG5s4ZCFSzBdjROqhrhZk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TZt3FvSn+Bipa6Y4qmAeg2G/ufo/XU/pV8E4BnNoad/9ky9231+HvAm+3B9bO+JjEOt1Y50RCZCFr9Eaqa990f9kSI5U2a2js2QzTuHM0xTNhRzxOJh/4C2a7m/vOjTXm7dxpYsGOfK0FdwWV7xf56XTTqH3qTMqzinzeYdDUWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KVkXSzk8; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElLJBSDRi0dB+rMzTu6rJYm6/Pnb0NFC0396NXu+lYvkWspW9X3gOAQW7on13bc68sRC76Pq0BkPWthkDRLdr4MPqEFCC/2JkjiIMkHyTbGWifB6nMjODeNsMsCj0bCdnHArtHlqUcGbeRt4Ukg7MCsVDup29Pi04faz9avWtjx3wHtQG4ORfO2J9KhtGz5X5LQvEe8zN/GMxPAHNo5yYD/L6Xm1eWCsoFx5rg7+Dp6q1EGI6h5OMCtsuEomvC2dGM/MGdCt+uGjRzm+94miyU0xNb+op1erLRb4Nd1KX0SRuTfsEpHOrUUGl+Ta5vXN02H+G9P6X+1PCrDywNcelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvHLKDr2dwHLhMKnRNaMKw/ZUogKmcIyzi2755aexUU=;
 b=R1kt6pn8LpfrJJT74e65wvBqU1vs+M2extsxGVjBzf5abNbjy9bg3ivFLENVQxyAGgBLp6mramwOvBUAjB6ba2bN0zoO90hfBnepaSAoJXfVBDQp+v0YhMFEkLHhpRTWFvKiqQ6/e4uRqug6vmgTVlLKhQ/kSnh1rDpwIceu7kvvBOAmZ+NiQGLAxciFQVPRgu6ARXshuAf7DA87uXzZwI0mbwGnRwu4CvPu7FyFwf/0k8t39Lgl4bQmarAxNf9WwzloEjd4ES2IeF6gdSyeWRZzrmpwbaG88GnC8lz2HYP8QekRdfceJSRXAfjYBReJuM8fLquGAHaUkxWBa4Z9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvHLKDr2dwHLhMKnRNaMKw/ZUogKmcIyzi2755aexUU=;
 b=KVkXSzk8upu0XJStZQdfq5u9gjfMugHchHXf1Tr9031sphxghpfsk086WQpwlSUpL8AzrVHx8+f3jLRM6ErS+CWi+ZxdU/tmJ0gFQRXxpOolGcEzW0yAYYiQbB2iZxt/Z74U6iBWo+tDbWEWraGeG5oSycLKHvXNGfxXm34e++OMUL6y+SDOXt/fI/oF1U+F0D1JB2b5LrnesiDX0P1BrewDNKftKkidXMxsOz4Xj8bIYkqQoj83tUzay1GAoSuchLyj7JBnirQu46PWGwR2KOElPP+LRIeGFm7ZkyI40LSZ5yg7WyMLoSiQsFg50zg94RySetzEekkzj44t/tObpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by MRWPR04MB11288.eurprd04.prod.outlook.com (2603:10a6:501:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:01:12 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:01:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 15:00:41 -0400
Subject: [PATCH v7 2/3] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251020-imx91tmu-v7-2-48d7d9f25055@nxp.com>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
In-Reply-To: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760986854; l=15299;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MeiWuls+UTtYHGc2Ozw2bNA4by8WV+C8zMDFyDNGa9U=;
 b=MKfCQc1pefymBh/rTyWCrvmLsjirvwdrNzgqz4To0xmI8PpWfyI5+OZLDE1ekRj2rFsg4j79K
 goVX6JFX/3QAC0IPB59rdXi5XlufVju/wRVe9NfRJEracTFJRQtTcid
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|MRWPR04MB11288:EE_
X-MS-Office365-Filtering-Correlation-Id: c13b3468-e07a-4421-7882-08de100b08fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjM2N3dmVy91a1dLWVhCbWJkSWlZOFRnTGVETmJQd2h3bWJJZ0ZodmlxWXQ4?=
 =?utf-8?B?TTAvNnJmNGVGeCtUMFQ3T05ra2F6UmcvRkVzQjlqU1RrZVRQWU1KeHRWbzlx?=
 =?utf-8?B?eGw5UDRSSlBkOUxORXNaSGs4UjlwSzlja0oyeU1SbWVBTFMwWGNtS2YzQm5N?=
 =?utf-8?B?UU54dHc0czB0OGNnTkF0VDlMOTRRc1oxcHR6b1FYUmtwNWdyV1daUE5YMlJ4?=
 =?utf-8?B?NnZtZStoQkpjT2l1ZTRxTVVhbnEvck5GQU1uazNJNlVCd3QwaGo3eUJtRTEx?=
 =?utf-8?B?V0RmeHBScHRNVlF0bFBVaG5WeEV1SEluQnJJeExoTzltc0owQ1hKSGRGcjRs?=
 =?utf-8?B?djlmUk0xWkZaQXlJZGs2M0JDNjZiSXd5d2hXZWdub3hjMWhtVWk2TmpLZWl1?=
 =?utf-8?B?ejR0L3NFN21rakM3d25tU1BCd25NdW1vU29FaHVXVi82cUt3d1l6Tk5vczlL?=
 =?utf-8?B?VG5odTN4OFVqSHlNRXFkRnZCVEg2TmFXR251YkZuV3VhdFFSYzkwNXZWUzB4?=
 =?utf-8?B?Ykw3U25QeDNFcnNLNDlvUEw2b09XNnczUHI4a0lZVTNySldzb052czhUa1Jn?=
 =?utf-8?B?ZkxQZlFiam9kMi8rdThXcDcvaUhQWGpaVXBtOWNiOWoxSlorKzhkMGppU2ta?=
 =?utf-8?B?UjJsd0FTSnVnK2RTcFVZWkNiOEI0SDVxdGx5OXJmOHJlUHlHdHVtVGRoZHJw?=
 =?utf-8?B?RnFiT0UrT0J0WlZObHFnZ0E1aklIa2NYWTNCK0JXRDJzSzVqT3laRFF1Snc4?=
 =?utf-8?B?Q202Si84MHFBTm8xNm1YVkxwMkNkSUZyZkNiM0cyZEllVGhOd2JjcW0ycXha?=
 =?utf-8?B?UERVeS9rTUVKUllIMTMyMFVNcFJtYTI4d0Z6ZDI0bnB3bTZsNDVyU3JyeDAz?=
 =?utf-8?B?V2hMM2NPM3hZcjJHaXRsN1daZU1PbU52UGF2N2ZndkdIRGxSTXZySklNSzlz?=
 =?utf-8?B?bDFPbXR4MVRFU2UwNUJpWG82bllXd0hiVy9EallFUVVQam9BREFiMFNUTVRO?=
 =?utf-8?B?cXZ5OWZoaURhMDR0ZzJTMGNRVGVLT1ovNytnQzNVbEszTDdCaFUxK3JOUkps?=
 =?utf-8?B?YWZkVzJrbHY4YURGeDBNd0dGdHNGb0ZZdzVuZm5TRzFjY1dCM1kvSlM4SThv?=
 =?utf-8?B?K3p0M3dNZElLMnNVU0lhcW1leDQ5QmI4cHNIYk9vdE5qYWVOd3NqdFluaE5R?=
 =?utf-8?B?VzlGcnkwYnJuMXlaSmIzeWc5Nkk5YnpiaEFEZ3hGbmVOR3hrKzVrdE1zTit5?=
 =?utf-8?B?WUZzb29QZTE3YjBZTlVlMG5JUzloRXp4MGwvZysraEgxSlpoRy9hVFU3WU92?=
 =?utf-8?B?TWFSWjJPSXJjdUZHMTZ6VHQ5UHFSbXc1MlpVckpNVjdRM1FYK3MzVEMzQnVP?=
 =?utf-8?B?U0c1eU92RHVBK2cxdFo3SElkcVgyTjlpUzBRMW1TN1UwaWJIdGdIOUxtQW91?=
 =?utf-8?B?aHEzMDdsZEhlV1dVK1o5MXh6bklSYVRiU2drbEI5eHAwMXZrN1R3dHVvaHFM?=
 =?utf-8?B?MGtlRFQwb0VYWWtPbVUvZVJMdzJYZGJYUWFlZ1FqekN2U1JzZ25TWk9ORjJI?=
 =?utf-8?B?QXNiV2VPalBuUmhOL3pjaHRHRlNvbDRjaStsbmYzL3ZtSkxEYzRTWjRyaE93?=
 =?utf-8?B?RTJoVTdCc25RS3Q1Qk9JNTc5M2pOeXNSZjVFWnBRTUpZMkk4UnR2SUVSTXNB?=
 =?utf-8?B?ai9KMVlubVFURlVUYXgvSTZhK09NamhZNXpjT0htRllSQzZEMTltMURoU3NY?=
 =?utf-8?B?RzZuV0M0Z2NUSDVRTG9zUDdxUktrRlhnaHptbWxlQThxazBNMXFNcUc1TmZx?=
 =?utf-8?B?M0hmUmZ6eEpMUW1TdDdHb2ZsMDNYdmFoMUFMNzduUUVoUUIxU3BkTTg3dlVX?=
 =?utf-8?B?cGVMa21laGxvUlpqazRyOW9nMFh4Y3pyaVBEaDVRRUVIbDBxWVBLSklITVM4?=
 =?utf-8?B?QWpXTTJMK3V6NDVFSjFIT29zRk5CSW1lZjF1amhIeWxJMW5CUzNuVEJFclVr?=
 =?utf-8?B?K2dVVE5pZ1RZVkU2K1JaTHZTUndIZHpzVlliUGhXTDVPVGxsYzJmaHFLblU4?=
 =?utf-8?B?NEowMzZsb0J0Q0VNUEY4aTIxYWJiTmtiaDJ2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkt3TXQ2Sm9KaVVrTGxqWEZXaFVFazR4M24wek1nRzZVSVR4bXlwTnExNjNH?=
 =?utf-8?B?UTkvdGNqVTVRNURBaW9WbGpRamFGdGZUSHZPUVVWSnI3K2Y5SksxalFqTXQy?=
 =?utf-8?B?Uk81MUxGZjdKZkRsK1ZnVDc3N1FUMlExL202YmtyOHl1eFBnM2RxRTdqelNi?=
 =?utf-8?B?MjUzd1NCL0t5VkczTTBXbWxxK0M1SmQzZXM1U1pxUTl4Z2hSZ1JycWtvN3dH?=
 =?utf-8?B?WDFiN2dmd3lxZHo1SVFFSk9oeGJQOCtvNmtvVGlMVE13OXAvSDl0RXk2WVBt?=
 =?utf-8?B?YldSSVFKcHFkQzBCZlorMDcrd0RGNEZFRGQyMUJ0Q0hXYWNyUHZXNG5EME5B?=
 =?utf-8?B?aVZKR2ZsdU16aTEzcldEL1duQ2N1NkhETXJHb21YYjcyZEhEc2J4ZmRVVkVP?=
 =?utf-8?B?OXFCYWNqTGJLdXFnRlpLeU9KWE5iY2VkV3Q4OUYwZXRsWkpRWnd0b3BGY1RH?=
 =?utf-8?B?MkUrS3JoWDdYUldVRjIrT2NZSTNQSitlSkpObUtiNDd0TUdGVmJuRVd1bU1I?=
 =?utf-8?B?MWtFa0Y3ekVWdVZXaWtwSTI4ZmM3dHRLaGhFZGowN1pSdXh3cElXRkhvUEJR?=
 =?utf-8?B?Nk9QamZmK3NuWlBnNmgyN3cvRDY5NVRCaGFNcTNSS0tCVDNsVGZFRmp1Ymto?=
 =?utf-8?B?VWJXUG41VXNPMTBEV0E1ZE9KOU56ajlZOE9oWlFlZTN2NE9NUGFIL0N6cXg3?=
 =?utf-8?B?eTJBb3hISytwaThEczJnK0k0Y3BvN2xrMDFIaVlEbFNOMHRHc3NnSjJjQXJS?=
 =?utf-8?B?dUdlYUNJenlQVVNVaEh6NER5UDlSUE9nNHBFbU5oaERITkVJZzMrb201dGVI?=
 =?utf-8?B?U09zZDd3QVJ4OXI2aVpSVFJ4TWMvNUpCRWllUS9MZTNqMmNjMUNWNUlvZmJp?=
 =?utf-8?B?MUh1OGlGUFVVVFJUcEpCaVVIeHNEcmRxVVJsTkdzSXNZdUtmMytLWXRJeEhx?=
 =?utf-8?B?LzNUa09PVUg2QnJtSGFJenYxTi9Lc0lvdUFSc2hXV3BHeHExMjBZc2tjaDZ1?=
 =?utf-8?B?bEhRSGJlU01yK1U0T3liVm9PSzFnblBqMyt5eGErU3RGUWFNSy9xR1VpeGkz?=
 =?utf-8?B?MzlqbXJhUWpYYXIwZXBmTS9kZXpwUHpDdVpDL3BLbzVzTG1jczlFMGRaL1Nn?=
 =?utf-8?B?bndjVjdHS2dpRlhHTVNNanpBOXl3N09qNGtTQ2prSFJjRUhUZ3p6NFhiS3N6?=
 =?utf-8?B?SEpjcWNRVmxlUFJmL1hERTlUSHlPY2FaUGszUCtXci9zeXp1MEo1SG9BTTlw?=
 =?utf-8?B?T244ZVpDSG1lUi90Y1NMVjgxTXIwRzRmVVV4ZlNJSG5xRDVheGxGeWxnVVhw?=
 =?utf-8?B?eDZlckJLcWNIdUN5NHVKVnNFbi9uUjg2V3FDRHI4Q1o3YkFHa0plUlNMa0Jo?=
 =?utf-8?B?eUlES3hzU2hDRWk1YUdMdk4rbHhvTmJZdmxPdHVqSUFBS2ZiRll1SVJXVmRj?=
 =?utf-8?B?K1JhZzNyd0RndEI5dGhObVRkelBabGRidTVqTnBXaDJxUEtVNGFDRHZ4VXpJ?=
 =?utf-8?B?K0RBTlZEVVl1N0xoNUIwY2h1S3BUdW9sY1N6UVhqd1RjZGFVVkE2NzNkeXJl?=
 =?utf-8?B?MFhQaDRKcXAzNHoyNHNCR2lMSldPcGxQME1WVkNOdU9zZk11bDVzZ1hZcm0v?=
 =?utf-8?B?Sk1QWHZXRytmdERxeWtOSGwwY3YzVkxsM0x1Q1lPYTljMWRQTUVzQnZsbGZS?=
 =?utf-8?B?OXpiVEo0amo3TklvbWlENHljVlNnZklQazN6eEY2ekVQMGx5cHhYekZMR0dZ?=
 =?utf-8?B?V1RjeXpRVE8waUVCOTZsajdmNEEycmRWWG5ZTzFBTEVQS3NkRFhKdkRVSU5O?=
 =?utf-8?B?UGhhdk1UZ0FmQXZaWFRxSXBzUnFFTFRhbkpCeG11cWVlKy9KNkJ3bTRUT01C?=
 =?utf-8?B?U3IrUzY4YS9nalRDS3A3Nk5WZ3hpQzRRQzdCTkF4RHZ3cG1iSFJVcG9JT0N5?=
 =?utf-8?B?WFR5Uy9wVDJnQkhVZU1pS1ppOWkwQ2VYWVE2ZU15YWFzaTNkdjBUVktvVHk2?=
 =?utf-8?B?Yit4NVhHbWMzM1Y3Z0E4UnlPMWF3UjQ4VkVadjBldGowMHpiR2xRR1ZuRHZm?=
 =?utf-8?B?cGVCWkFEamkyTmVNQXRQRXZQd29SRFdqWDZrQ2pPSXh1dDVlRDNIVjgwSzNx?=
 =?utf-8?Q?ZZZ8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13b3468-e07a-4421-7882-08de100b08fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:01:11.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe0yQ0JtmiB6v/8BhGqe4Qa/O0U4ew1nnfx5PnQk5aKHeAlP7gjb+EOKjdd6qLVTn+oJqeXqW8euuWvvAUN/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11288

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
accuracy, refer to the datasheet, as it varies depending on the chip grade.
Provide an interrupt for end of measurement and threshold violation and
Contain temperature threshold comparators, in normal and secure address
space, with direction and threshold programmability.

Datasheet Link: https://www.nxp.com/docs/en/data-sheet/IMX91CEC.pdf

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v7
- remove enable field because framework already check mode before call
get_temp();
- only call runtime_pm_get(put) in set_mode function
- remove enable irq at get_temp.
- Enable GE compare irq at set_trip() call back
- Config GE irq at set_mode() when start measure to avoid issue unnecessary
irq when clear Compare mask (generate one LE irq).

Change from v5 to v6
- remove Macro's review tag
- remove mutex lock
- use set_trips callback

Change from v4 to v5
- add irq support
- use period mode
- Marco, if need drop review tag, let me know

Change from v3 to v4
- Add Macro's review tag
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()

change from v2 to v3
- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
uboot may change and enable tmu.

change from v1 to v2
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
---
 drivers/thermal/Kconfig         |  10 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 384 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a09c188b9ad11377afe232d89c60504eb7000417..b10080d618604ddd90295bff973e337ae0509059 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -296,6 +296,16 @@ config IMX8MM_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the passive
 	  trip is crossed.
 
+config IMX91_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX91 SoC"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Include one sensor and six comparators. Each of them compares the
+	  temperature value (from the sensor) against the programmable
+	  threshold values. The direction of the comparison is configurable
+	  (greater / lesser than).
+
 config K3_THERMAL
 	tristate "Texas Instruments K3 thermal support"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d7718978db245faffba98ff95a07c7bcbc776fd2..bb21e7ea7fc6b70aa84e5fed7cfdc7096e3fb1f7 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
new file mode 100644
index 0000000000000000000000000000000000000000..9b20be03d6dec18553967548d0ca31d1c1fb387c
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#define REG_SET					0x4
+#define REG_CLR					0x8
+#define REG_TOG					0xc
+
+#define IMX91_TMU_CTRL0				0x0
+#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
+#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
+#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
+
+#define IMX91_TMU_THR_MODE_LE			0
+#define IMX91_TMU_THR_MODE_GE			1
+
+#define IMX91_TMU_STAT0				0x10
+#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
+#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
+#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
+
+#define IMX91_TMU_DATA0				0x20
+
+#define IMX91_TMU_CTRL1				0x200
+#define IMX91_TMU_CTRL1_EN			BIT(31)
+#define IMX91_TMU_CTRL1_START			BIT(30)
+#define IMX91_TMU_CTRL1_STOP			BIT(29)
+#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
+#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
+#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
+#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
+#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
+
+#define IMX91_TMU_THR_CTRL01			0x30
+#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
+
+#define IMX91_TMU_REF_DIV			0x280
+#define IMX91_TMU_DIV_EN			BIT(31)
+#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
+#define IMX91_TMU_DIV_MAX			255
+
+#define IMX91_TMU_PUD_ST_CTRL			0x2b0
+#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
+
+#define IMX91_TMU_TRIM1				0x2e0
+#define IMX91_TMU_TRIM2				0x2f0
+
+#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
+#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
+
+#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
+#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
+
+#define IMX91_TMU_PERIOD_CTRL			0x270
+#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
+
+#define IMX91_TMP_FRAC				64
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
+
+	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	u32 reg = IMX91_TMU_CTRL1;
+
+	reg += enable ? REG_SET : REG_CLR;
+
+	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
+}
+
+static int imx91_tmu_to_mcelsius(int x)
+{
+	return x * MILLIDEGREE_PER_DEGREE / IMX91_TMP_FRAC;
+}
+
+static int imx91_tmu_from_mcelsius(int x)
+{
+	return x * IMX91_TMP_FRAC / MILLIDEGREE_PER_DEGREE;
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	s16 data;
+
+	/* DATA0 is 16bit signed number */
+	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
+	*temp = imx91_tmu_to_mcelsius(data);
+
+	return 0;
+}
+
+static int imx91_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	int val;
+
+	if (high >= IMX91_TMU_TEMP_HIGH_LIMIT)
+		return -EINVAL;
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+	/* Comparator1 for temperature threshold */
+	writel_relaxed(IMX91_TMU_THR_CTRL01_THR1_MASK, tmu->base + IMX91_TMU_THR_CTRL01 + REG_CLR);
+	val = FIELD_PREP(IMX91_TMU_THR_CTRL01_THR1_MASK, imx91_tmu_from_mcelsius(high));
+
+	writel_relaxed(val, tmu->base + IMX91_TMU_THR_CTRL01 + REG_SET);
+
+	writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+
+	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+
+	return 0;
+}
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	u32 trim1, trim2;
+	int ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
+	if (ret)
+		return ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
+	if (ret)
+		return ret;
+
+	if (trim1 == 0 || trim2 == 0)
+		return -EINVAL;
+
+	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
+	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
+
+	return 0;
+}
+
+static void imx91_tmu_action_remove(void *data)
+{
+	struct imx91_tmu *tmu = data;
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+}
+
+static irqreturn_t imx91_tmu_alarm_irq(int irq, void *data)
+{
+	struct imx91_tmu *tmu = data;
+	u32 val;
+
+	val = readl_relaxed(tmu->base + IMX91_TMU_STAT0);
+
+	/* Check if comparison interrupt occurred */
+	if (val & IMX91_TMU_STAT0_THR1_IF) {
+		/* Clear irq flag and disable interrupt until reconfigured */
+		writel(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t imx91_tmu_alarm_irq_thread(int irq, void *data)
+{
+	struct imx91_tmu *tmu = data;
+
+	thermal_zone_device_update(tmu->tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	return IRQ_HANDLED;
+}
+
+static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_device_mode mode)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	int ret;
+
+	if (mode == THERMAL_DEVICE_ENABLED) {
+		ret = pm_runtime_get(tmu->dev);
+		if (ret < 0)
+			return ret;
+
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE | IMX91_TMU_CTRL0_THR1_MASK,
+			       tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+
+		writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL0_THR1_MASK, IMX91_TMU_THR_MODE_GE),
+			       tmu->base + IMX91_TMU_CTRL0 + REG_SET);
+		imx91_tmu_start(tmu, true);
+	} else {
+		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
+		imx91_tmu_start(tmu, false);
+		pm_runtime_put(tmu->dev);
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+	.change_mode = imx91_tmu_change_mode,
+	.set_trips = imx91_tmu_set_trips,
+};
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	int irq, ret;
+	u32 div;
+
+	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
+
+	tmu->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		dev_warn(dev, "can't get trim value, use default settings\n");
+
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / (4 * HZ_PER_MHZ)) - 1;
+	if (div > IMX91_TMU_DIV_MAX)
+		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
+
+	/* Set divider value and enable divider */
+	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
+		       tmu->base + IMX91_TMU_REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+
+	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK,
+				  IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC),
+		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
+
+	/*
+	 * Set Periodic Measurement Frequency to 25Hz:
+	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PERIOD_CTRL_MEAS_MASK, 4 * HZ_PER_MHZ / 25),
+		       tmu->base + IMX91_TMU_PERIOD_CTRL);
+
+	imx91_tmu_enable(tmu, true);
+	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
+
+	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd))
+		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
+				     "failed to register thermal zone sensor\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, imx91_tmu_alarm_irq,
+					imx91_tmu_alarm_irq_thread,
+					IRQF_ONESHOT, "imx91_thermal", tmu);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
+				 imx91_tmu_runtime_resume, NULL);
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "imx91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


