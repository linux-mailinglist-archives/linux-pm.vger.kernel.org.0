Return-Path: <linux-pm+bounces-36505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05DBF3168
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C307404AA2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AB2D7DDB;
	Mon, 20 Oct 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SY1/nxaC"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE42D59FA;
	Mon, 20 Oct 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986873; cv=fail; b=sVWpzcxkYv4mcykDhPpx5lb72lFJT1gEGEjRgU2S0CPli9uEkQJsvB2J4XzbEY/Dujn/djNt09lgCaxMkBmzPbnjzZmv1BuKBVrHleIgIYj7IQaStEOWLpjO57umPXiH2Hv8gUvHKyJp324Qj8bOYv2KEnUVCHAEQWKVWna8EIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986873; c=relaxed/simple;
	bh=5zUb/SYbBXcuSWWKplUlxSq5IJ177RFgecGX8S0CMn4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P8cToOWBOw9DERpjpxSNZ39XpkcmgiU7hphrUMb1IaxclabWr36Iw6o+df+jraUBeDrZcbihbLlfJTvyKicJy3SmWqZOJSXk79g5W1mjhgB6u6d3ndehC4uniVNdp0mLex+B7W4tkDBFkciF/bro1zW3oqzUE9JE8lc63fP03fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SY1/nxaC; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fufyp2sX+NCi2YBtbINvPiLuQJBQuQdIbMbd5bDJw1qIa6yydUUSBcaX7UHiGXRAuexzYvAyIJNmGZzDakfisBnZ7yfsT7wmOAeuuXNKL75FZ/yzF9La5sfOMhEcU0KzQrtPWOheRkY3eTcwpbD/FQ4q/f/t2z8fiAdKrqj8Z01GAX0XPeTGtbqvzN2qY2i7b9njtiTsHaomdChbng3cCYePwiBKrABRr0tCLPMXtn57/lZ4RL5PBehfc4YLhoUFaVFdKO86IpLaxnBjU+RhvY/Bj1NpedD63IKyZLtNNSLRsL/+gQJ5BVDfjgKa1uzJTuuSxniq+PCY2/5JbZuD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7jDQ00ymeJnW31fdlFRRMtvWWWAWWpMY5KvctDGoV8=;
 b=PnicPz5eCPGWBCp64jYMI2bv2wd/4RKV3vvFbHOrOHMH1N+SY27xsfHk4tNbN3d9nMbetHUQw9fIDDf1DsuUuxFHxzPHQtfHZlpfqq6l+ThOgbB6AB7BaTCDVJrzHR8aEMi9/gA9GXOjC9lTgBU8Cjno5Vtd3caSe4suy30YmFjwBXC1vHBJ/cHIw4LelqsA1sYuVevGpzVW8YZc8feEXQ5Y3Xzb7CebqgMStUotyKrVxP+/Aeyo/47+NtxeHt0VrFrltkHT8JQWDmg/8MnEvNYBNdleFAzK8wofzH7ptLeBM5jQzLpCVNjkYk/odLlYrIXwKVw+XUVtyo/G6mIwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7jDQ00ymeJnW31fdlFRRMtvWWWAWWpMY5KvctDGoV8=;
 b=SY1/nxaCztbimK48jz4xHVZ7fh+A5qZGpaTpwbDHVvQRt4kdvJTPkxYdA8AAvqxoHMmEG4YQEDSEjK3U/wKFfjs1DvFP6FLiiTI1YyP5wOWJkhbXie4icdrA5AV3PvGPGJkZgwI1kzEP5vK6lxvtLM3MB5J7qMhHl5iJ96I1NX+IiKpdA2j93tgFrAXatcvxQTMMebwviKwNXnc2bE85/K5kbId5kWsBxaJpvHPyvAOI7695PbFiniVkRxtdhyPw6JEY5aUTtRpDeqw+4vyvgToe2Uc4lbmfzFeaGItdsSrwMXRYAeRIQ8iXubPfKN0sHTg/2YkROfWWJwNjkr4m4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by MRWPR04MB11288.eurprd04.prod.outlook.com (2603:10a6:501:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:01:06 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:01:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 15:00:40 -0400
Subject: [PATCH v7 1/3] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx91tmu-v7-1-48d7d9f25055@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760986854; l=3332;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wuz1t7+WlCygdcUbY1pMGQYWfQN6CvkP1VbxncsFup0=;
 b=iYepmAPLNkJal8af4I8/7fitZ8lhhYuvG0ij5/6ExCSqRY1Y7s7cLzxxETXlbgMDkftjNPs4t
 CCxu/dxD+EzAdANoRtOPQdmPKRpX9fm567UxlqjjVm0pQX0CFAVQmY6
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
X-MS-Office365-Filtering-Correlation-Id: 5983d52c-93f2-4cba-5435-08de100b05b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2JIN3E3cVFkUkNodmtvdThpM1lweFF1Sm1JTlpGNDArVXh3NlhhUDR1WlRF?=
 =?utf-8?B?WUx1ZDlKOUpRaUFIenBUb3IzWVpnaUJWK2hmSExNa3Z4SDJDT2wwQ2pDVExW?=
 =?utf-8?B?VFE4Z1E0K0Z5YWkyQm9RbE5VUWc4RUhmVkRIdGJPbWFNNDh0QjlUU213aHJ2?=
 =?utf-8?B?UmlreFByNUJCZXFxK29NL1pTY0NRTkJlQndsaGRCWlo3d1BOTCs2aS9DbGxG?=
 =?utf-8?B?ZkZxTnkyRUtIY1dUN2FVUVNqOG52V2ZaM1IzQXdxdVIyaExWUTJKdkdQaDBK?=
 =?utf-8?B?c3QxMUkvT1BDNGdvektibk8xV3NEVUI0am5GajZsd0xpbXZiUHVjSEFYMG5H?=
 =?utf-8?B?dW9TbDJwUklmaE1aaEJEWHovZ3VJeU5CZmhUY3VRWjNVOUpodEp3eC9WZzNq?=
 =?utf-8?B?Q3puQWtheE5KRktua2krL1liN2orVS9RRXJCb2dzbWZNc2Z1L2dTNy9oK08x?=
 =?utf-8?B?K0Y5azZ6dTdtWlUybmZZRSt1MUlDdlZYUURnRVJOQXJiaWRRL0lhR2MrTHA4?=
 =?utf-8?B?RWNkdWFORXE1TTE0bFh4cVNJdWNPNUY1c2o5eGs4UWhuUE1WSmZMK0NaNml3?=
 =?utf-8?B?T0xPYmI1cnl2bElHRUxDY2ZqbmhKMkVoYnBRZFFqR2t1dUhZcjJJU1BSNHRs?=
 =?utf-8?B?aTZzNEtpTEdVOHpUenplbDdjaUNLd0lBQ3NVQkdwLzBuSFV4Zms1STh6U3ZX?=
 =?utf-8?B?TWhrL1FGRGxML3F5ZFJ1WGE4bks5UlZnZjQ0dW5qRW1iZWJMVnJFcTYreHRM?=
 =?utf-8?B?TUhoSUpKa042TkxrUU1rcGpSRytyMmt3L0RPRG9wTjlLVGlrbCtndENkNFph?=
 =?utf-8?B?Z2Mxa2Z3K1o4MHIrVnBpbTJpVTJTL09FUStPUHRDUmtvd0s4NGpBWHpjSXZt?=
 =?utf-8?B?WHU0bjI2b2xqR1NES1paYlZYTU5GUnUwT0JBRnV4RjZDSTRkWmNBSVk3RmRW?=
 =?utf-8?B?UG1TR2lOWmRDYUlLL1lqeTAydWU3bSs4c1U2M3dkU1VKQmVyM0FXRnJpVlN2?=
 =?utf-8?B?L29lcUNsN3poRFB6U3V0WUpicWFiVHlIeVB6WmVIRXplVHJGWXdLbjBCamxR?=
 =?utf-8?B?ZDdmaHJ2V0xuQk1kMWJRdENRK2ZaSVdnajVaZFNreUJoUnBYUG9KVVNlY2th?=
 =?utf-8?B?cUprQlpnRzlaYStQbVY2b3NEMFgxNWwwTkF2aEI1TTQ1UEd3MWxVVXcyQ0cx?=
 =?utf-8?B?TVJVMU5EUzg4UlJsNkRoL0xNM1RkbGVJQkE4MytZZ01YdHpXdmJqMW9vN1hW?=
 =?utf-8?B?RlRpYnZ5RkZWamlqSmNQbjlHVlUvR2pwYTE0N2NUVU56SG5rNU8zVW5hOFN4?=
 =?utf-8?B?RGRNV2JZaFFVbWE1alVRQ2ltMnllNUdDcG0wRUorVkdIWk5mV0ZFcGhqQnpF?=
 =?utf-8?B?dktUUDAwaVpxNVlaeGY0Y1ZDZ3E0Y2FqclZ0SUp6ZkhQcHNSUXVIcytzK0xk?=
 =?utf-8?B?YklkdTIrR0RKeWk2OTVuOURwTTNDMVpoOUgyNndyMzI0N0J3c2paSWFpLzRr?=
 =?utf-8?B?ZXpVL2UxQWNhZmd6WGh5MlhVbXl0cGh1eklwSUljVzhRTGFubnpkalB1c0N2?=
 =?utf-8?B?NnNFanRIOU9vU0NsZ2x4dUozVUJCMmJPbUpubVYyUWtkcUJjczhSd0tNQzNa?=
 =?utf-8?B?aExtVjZoZGxkRmRnUnBWb2hJdkVNbkwybFR2dUx2eGRZeWo4aU5pd0pLMVlp?=
 =?utf-8?B?WEY0akZEMFlSdmx3S2lGZnVMNmNHalM2VUhCMk9zYzMrSFlxejdIRjlERE5v?=
 =?utf-8?B?bHpEUzl3QStNUVhzMUoxTXlPbjUwcGh1UlcyWEw1cGkwU2piVm9ucXV1azh5?=
 =?utf-8?B?RElzU0ZtQ0JhQXRDNG44MnRGcmtxT0dVSnRFRmxjWjArNkczRldHaHVPS2pW?=
 =?utf-8?B?T0o2ZjkySExZTWFXcTYwWW5nMTlReVppK0FKbzF1dUdHK01pRS8yMU5BY25B?=
 =?utf-8?B?eVRjc3pmOUxEUUJzbkRQOTdRR293cy9MMUZzVnZCYlFCUGxsRFc4UGJLSG9V?=
 =?utf-8?Q?oTJqx3Mlk1y6XQeLt8p35pWXrxaxdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXJ6Qkt3azN6ZkswMk43WXJpWHlIU1ZZaHpibEN3RE5xZmUrcHVZTUNYYmxt?=
 =?utf-8?B?djY3eUkvTjdlcW9EeTc4SzdjUmNVVVk3T0wyNk13cklCME1wVnp6djErT2dz?=
 =?utf-8?B?bndCMUdQN2tSS1ZWWkNMUXQ2ZUU4WlB5akdoczZjRkk1V3N6SnVZbjl1a1lU?=
 =?utf-8?B?bzJPc0NpN0JMT2oyUDlmNGc1YU5TT1Y3NUtMUjNJQzU1NENBc2FETHlFbWsr?=
 =?utf-8?B?RGdlbWlqVWRQSU5BaG4zSSs1U3VOWTREdkdhZUxDMWFrN2JjN1VqUTZnanNB?=
 =?utf-8?B?c0xpMU9WOGkyejkycFlYNWVoWDZuQmdrY1IyYi91WFBXamhjVDhnVEtpeElu?=
 =?utf-8?B?OVNDdXBSOGpHRkFsOUZNVW8vNjF2YzJITHJLUzVjdlIyN1hWUXZLYUpxWUxt?=
 =?utf-8?B?WStDckhGZEh2WnpYKzdBbWZUUTFNTk5BN216Y1ZycnhDQlpySS9ucFA3eC9t?=
 =?utf-8?B?K2liMHo1RW1sdElkOCtPMzVJNTJsMmlQcnM5Wmd2RTZ4aXJRWWpqN1BIbk9a?=
 =?utf-8?B?a2FRdXc2UmhueTk1djgwdkh4azQvTTJMUkVZcUlnMnk0ZExpMDd4TWphdU1Z?=
 =?utf-8?B?QkZpSno3ZitZKytFTjYyWVc1SnlSVG9JOHlxaHZWUms2T3pRa3diaFNVMEN3?=
 =?utf-8?B?RnA5T0hLZ1RVaGZmL1k1Z0JtaWR2dTNrcklKazV3eCtTUXkvcklKNS84UC9C?=
 =?utf-8?B?TlhZN3lNYmxqM0NmaWdGME8zdkpaOWlKR2ZObjNuQ0hZblF4a1g0aG5yaWZJ?=
 =?utf-8?B?NXFxaE56eHREQlI1Tm11YW8yRGQ3SFpMWDJNVDV5K0FRTGhadWcwcU44bjFY?=
 =?utf-8?B?TmVNWGplbzluQ3hOWWpObGJlbmh2SWhYOXlQV2p5S2V2elMvelhjZlhMNGE0?=
 =?utf-8?B?TEk2bE5ydWFiNlZpSXo3aVZROVUyQ0dRWTc1OU5FUWdtODRoVW1JNDl2bGZl?=
 =?utf-8?B?d0xORDY4bDJBYkNXaDNRb1Vxd0VLV1Zxc2NEQTExeHIzS3RiSE5oaHY4NndY?=
 =?utf-8?B?WjhXbUkyODZJYUJDcUdIeHU5enN3cnYxNzMrcDdmOVFvdnBaaEgyb1JKc21J?=
 =?utf-8?B?b1RabnVVa2NscjJ2ZXFqNjY1MElzSXZGTHNmZ1JBT0kwRE5OMlJUdFlVTG5I?=
 =?utf-8?B?ZGNkVkI0bWkwZSt4ek40bjdhSStnV1RHS1k5VUZPbHEwMDZaSDhLOUNIaGhw?=
 =?utf-8?B?ZG9JRmdYY2Njd3BYbmtWQUs0UWJEQnUyOEJiMWNLTDZxTndJQ2JvVHBUVllC?=
 =?utf-8?B?K1l1RXFFLzR5bnVzeVVvMVdxTlFZNEdhT01lY3laaVRBdWRHUUNHaHkrMWFy?=
 =?utf-8?B?Tjhjam9LL0VTZmY1dTQ4TDBNSUc0bk5Ma3pWc21hQ3JiQXRzVjBINmxBUjlv?=
 =?utf-8?B?Tmp6QSs1alhuZXFLdzI3M2pxN0lqa01mZS9QL3ZGbW9FdEFLWUJad3AvNTJi?=
 =?utf-8?B?WTlSY1gvOXM4djRIdE9vY3hZaEJMN1hoSWp6MWEvOGpOK0F6RFFnUWpYQzJx?=
 =?utf-8?B?eGoyM0ErR3hTdmdnSndqYmw3cHV4Q0ZhZzQ4dDB2RU5FTklTQWNyenFzY1hR?=
 =?utf-8?B?aXFrcjdDc0cwZzFsU2ZMSjlHMGU4STRSMUo2VmM3Wmp0di9JNnJxUXNHUS9w?=
 =?utf-8?B?MWZBTldHNEZzTFJlT2syNWN2ZDhDS1l2QUNYSTdyeThhVktnK3l4RE1ERVBV?=
 =?utf-8?B?OEs4YVpsN0plVW9IZXROWFJZaWdHVHVwRTF0TTlOeEJlQ0ljNWdsT1dmenZ3?=
 =?utf-8?B?dy9aQzBRbXFSU255ZEZTd0ZJZW5JcnJvczVCVnlHZ01UblhuamlrRjdoNE8v?=
 =?utf-8?B?TThoTStjSmxqdzRmUGFYWnJ0TzFXZG5LckpsSlhqQWNPNExDOFNueWhzYWs3?=
 =?utf-8?B?WSszSUxRRmpqdFRxVzF5RE44SitNV2dlZHZKMy9RWm1GaW5OdEJMazhwVlIw?=
 =?utf-8?B?M0RjVGNVdlp2MlVDbUxRdExYLzJvclBtU2h0TGpNK3V2Uk1yMlQvN3YzL2FM?=
 =?utf-8?B?OVhRbktYN0xnc0RLNVd4OHJZMWhta2RQTEdXRVE4SVFQRkFxWTRGcXgxQmcv?=
 =?utf-8?B?VG1Pb1pRT0tIRkNzcnd3cUhNK1l2cGJUcDFMa2dxMGhnRFF6MWhXcGFKdGdx?=
 =?utf-8?Q?F7Sqks+CJDxIsqKgC0MQ3fjA/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5983d52c-93f2-4cba-5435-08de100b05b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:01:06.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp2gtnFIwMES90oni2UFGJOfXh4hzVsNl8HMlgGVzEikbn6a+5LU7Q5vCfr8VniSPa5fMrozlMzjqOVX+bTe0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11288

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- add interrupt-names

Krzysztof Kozlowski: Compared with acked version, add interrupts and
interrupt-names property. If need drop review tag, let me know.

change from v3 to v4
- add interrupts propperty

Change from v2 to v3
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7fd1a86d728702d1274dd8a73109689dd11f61b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Comparator 1 irq
+      - description: Comparator 2 irq
+      - description: Data ready irq
+
+  interrupt-names:
+    items:
+      - const: thr1
+      - const: thr2
+      - const: ready
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "thr1", "thr2", "ready";
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


