Return-Path: <linux-pm+bounces-19788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C89FD887
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F8B3A1C43
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510144206E;
	Sat, 28 Dec 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KGSpnsMn"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210C41760;
	Sat, 28 Dec 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348532; cv=fail; b=OddnEZ/r9INrw6Ypnm4b10kkut7upzFvE5mKjwyY4g162QDZ9HTA/14T8hHVapbZH4yKPMBd8LHGFXhu5zXi70pw5VkNbNdkA3NPjO5HXOCjrLTxkqU1I7kyEWcmgxI8M9y6je/yjgceqTeHh+IU90qtFO+tImBO+kdOETN4KDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348532; c=relaxed/simple;
	bh=f0XWM6xBggK2QfOcHzd3+B2023F378UQ/qXOqelOuSw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i9BTANH45oNos44PDe51aF7CucAeR3vUiYIY3CiMCFyZNXIieXYVzLiLxK3WOilN5oMH/HLuu2C5xIR28LPz/7VQWtydbb3AezsuRFCzysm733nwL43q/hZwIIz6YG7RduoI9wV9e8nbA7tZmPUu5EPh/JxgEMqkHgcXhmP21CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KGSpnsMn; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqDXq0jdL/wwgfH3YPvYabWCXmYalSsxlGH4OzWpUbk1frs0Ek3ybPi4AKE24Fvs2PLOv6lEZyoCbTOcCItF3MHLg6Ii/VGZx79zL7NM+Eqe6VjsETuoX49dQ0hvP9xt1EUmuVdoD6VsWX8iJps40kHhhHaye0XO1Cy6aDff556eSYVNvYt6DJcVBlZJONHOJ32R3SD4qERjQ/A4rjdqz660TZfZVDogEWqom6q+paMhWXtYao7vJHD23U02U2Mcd2kRngFP2OVJS4e2KUzZ8umInEtok17P8bcw8BiFdTk0SqVWbrkt/HcJ+CT8xl0FYV03YYlJLyrrMo9sMv5gaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBJXBX/BlDu3iR52lDbc09nZRQMR+H0jkQvpTPg3SOY=;
 b=vSs+X/kBp3fWnVmsTLg7S9+o9wn749zyjP57Y4E7XDh+CslRXhQHVhSZLoTFlZu0sW9luqttbB+ROLGriUKwcq3IkFbwaf6IcaPIr4D135zHw2D3rMNGRyCE+A3zkZjJxeZPm55DtQxovdbXT9jPhVN6/fbXzNMixLwLBBmYWGjZLcSF481stRB+en3wQeuiN5wh5FXfETgWAMBxWAEdnqgs/jxoVVJczUIocmYPd2nQw8CrBAVHYedvM+wM0r0ZnpEmQIPfYl2B7L+UkAOi2rTN32/KrNRN1bSs0XHUrP0re5XfIuGFTo+4GsHIRHiOADYrYYJVJb7oJu4Z2oRqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBJXBX/BlDu3iR52lDbc09nZRQMR+H0jkQvpTPg3SOY=;
 b=KGSpnsMnAzbmgAwnWh1MAH1hEuH+LCsNs7l2E9znPIarEFdJ5i1A3sSRFEclWX4hZUQsFAPuLD0+BqdU4hII/5+FU9+POI7iI4RSLsQ4055z7DnaPXIUyYh7Qk+X8f2ov2BJQalv5N5sNscUd1VNU+nryJFSxKZ+urvypz6V50BpgsybtORaghuFWOVCe9ugAf8gJTWsAR6HL3ufcrG0iILabXXaFJk6sRwW1TBEN0fx3IhVbYGtyK49gYF0i9aDkhLpl0G/wR7wE1eEhJT5ng20B9AB+FAoGBAqcbQA8sHLagUvNQfsYbRc1W580++DUL7pP4FfCfKs/EykeTEwqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:38 +0800
Subject: [PATCH 02/12] input: keyboard: ep93xx_keypad: Use
 devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-2-09cfca77cd47@nxp.com>
References: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
In-Reply-To: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1402;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lLk6bV9Q4qc+HUdwJdc/NyACnoatpwVUWdW9RwekWXs=;
 b=5OdW9htTwL8MFAvAyBNZ/2f0h1+VWymLzScDuYIdMdyOM5rQUUci7IzEeTZuelTVx/ZYACjxB
 CAm5iCzf4BsBX1SdaFUQCpoOFQWyqSIZjUtSq/FsN5iH1g7wLMYaf38
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: af5dd577-acd6-441c-2c9d-08dd26dd1ab4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzVTYW5uTUJXTEdTK1MzZE9xVHZZRllrbGd6Z1M2Q2tBUzVpN3RYa1M4MmJp?=
 =?utf-8?B?YzM0d0h5aU9qdEZIbkhIeXdaeElCNGJRM1NycWRCcDd1ZXIzeHp1K3RYc1hm?=
 =?utf-8?B?SFI3alJtbUtxRDdsSkJzT2cvUjZ1V3hwYmloNkFLQXVoRWQvTHY0ODY4b0pR?=
 =?utf-8?B?Z2x4RC9kVVRadm11Zmp4NHZMbzNHTU5oSzcvOFBIeXlQd2xQQnhNQVUvNllL?=
 =?utf-8?B?M1pwWmFNU2N3R0ZITXBzOUo2dndEWFdIWHJMNU5OUW5OaDExc3FjZGlUaDd4?=
 =?utf-8?B?bnIwTUhDM3EwOXRqUk1FYTdURmFRd2tNM0xJaW5ma21DMUk5YWtCMmRSNWlp?=
 =?utf-8?B?UG5ubWFyR09rSTVSNXFRcUxPSElRL3dYb1ZoVkxWaktHU0xwNm54K1FjSkpF?=
 =?utf-8?B?ZzNBSTlQcE1KN2tsdXZpZThEM25BNkFyOXFPTDJvQ3FaQnlhM3VjTnE4NmZK?=
 =?utf-8?B?Z3FjSVJNWkJ2OThZdWdaQ3RWcFdxSWl3a3A4ZVIwUkUzbnc5cjFnUDRXMEhZ?=
 =?utf-8?B?WWMrSVA5cWo4NWl6UmhLY1lMRnlRUC9PNnlzSDk0TGtVV0NpOWljOTI2L2NC?=
 =?utf-8?B?UVBWQmk4NFhqRHNhZXpwWFE1ZXUyNHhyZHBya1dpTDg4SktlaWNKNmhVVlo4?=
 =?utf-8?B?REpkRnR3RFoyTHFjU3R4RklBcGhuTzNiMTBFR3c3N2RCOThzM2ZTUlRwUEJn?=
 =?utf-8?B?bDZLNjFUSzJmTW1RSExoVHJycUc3cVpwR3NJMENWWHdxbTVPM1YyM2ZGVnBQ?=
 =?utf-8?B?YlV5STJOQnVXNS9NcHZORlJjZ1JVSG5iL2FHL01KWFJ4WkFGVnd4VVdYYUdK?=
 =?utf-8?B?Tzc0RmFUQmtVQWhRbkh4NjBtVmRWSFBLeGExejA3UDhLbVB6OG15QmM2RGJV?=
 =?utf-8?B?V0tFYXU1YlBNdWVRY3B0QzlCSHhrZmVrVWFKdkQwUHo1aXdwTmhKN0RWVjNy?=
 =?utf-8?B?OXlGcFFZVjlyK3lHOU1pRUxUZHBKWGpzVldTT0w5aW9oQStKM1EydnpWSUl0?=
 =?utf-8?B?czNmRE9tQ3FIWmkzbEM3bGJRbWc1U3oralZwVWFzcnhLa3NrY2pKeU9RVEpz?=
 =?utf-8?B?cm12dUc2Y1RUTS90VlJZclpIemVLa1U4TEk2WU9lTmgvNFpFVDhPTldBUEVP?=
 =?utf-8?B?b21YdXRtSS8rY05tdDJDcG5OYWg0MGJpcFo3clhxb0g0N3l0c01ZVEoyV0hD?=
 =?utf-8?B?UUdNZk5BSDZ3NVRYWWhHak9zekcyaElyL05uL2R2d2pKWTd4cytoM1pydW5w?=
 =?utf-8?B?ajgwTldOTzlBa2pDTktDaktHR3hiSU83L0VJajBwNWc2UzRwUWM0T1lXakRS?=
 =?utf-8?B?UkgxZ2dOZzYzYTlQRkZOdngyM2xSelNFTWw0RW94M3RzUXRJNlBVNk5Qcnhw?=
 =?utf-8?B?NW9vQ051aDdKd1F5TlBQbW9pMGZJUlhyaExqR2lKTmU0U0trMXZSbmVOdEJh?=
 =?utf-8?B?V1R6d0E2N3NNWXBTanRpUjdIUWRhWWNRRktjdS9SZEh4elZOcDZnMHlONXFh?=
 =?utf-8?B?MzI5UWk1d2pUMThqdHBpYkRLckJVdExTUmp2clc4aEFGblI1UFFDaElWOEpE?=
 =?utf-8?B?ZENEcVJTMGtiVG5HSXN0eHZ2aDIrbFltNVRJMERoRktkUnQ4VnUzRGExOWVM?=
 =?utf-8?B?eXV2OGhiYU5EY2VFY1EyQ0VvU3VvUXNMMW85RHFiK1pmNUpaZ21EQXFwaXQ1?=
 =?utf-8?B?RmlkMTBtMjE5Rk9JQW95bjlIeXRQeWsrQ1A3R2tqc2YwZktRSHBlWlo5L3hW?=
 =?utf-8?B?OEJTcVIxRDZZS2YrWmkxcHluNGhuUk1tV2x0VGtFNitReWc4d0ZwdDVKK05Q?=
 =?utf-8?B?eWxjZlFTb2JrMkw0aWFRWnc5Z3RIOEpvS3hxRlplVFg1Y3gremlXcWtvM3dU?=
 =?utf-8?B?MEdzck5zdlRaa3lCNE9TdDhKNE16c0pRbnVPN0FQdzdwbGxzT2JzNXlJb2c1?=
 =?utf-8?Q?BmcjofHyy1lwyOZweBg77OR43r477HFx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZoWkdYc1diQjg0VkJkQUIrVndEb0hRR2M2Z1BweHdFdlJiZEVNUUtRK29o?=
 =?utf-8?B?bEFhVnpMc0oyWjJzbThDUzd5czdBZlZlSUJsTEQwSGs4QWZMMTBRUkZ2NStx?=
 =?utf-8?B?dGRHc2tReS9oZDhDUUVYWVJjNVhHUlE2QmRGaGUxL2NCMDlPSVFGeTFzUjVm?=
 =?utf-8?B?dDdnWFBRby9FWFJnOFhzbkJiaDdkeXJnS1BOS0pkblBjVDMxeGJ6bWZEL1VC?=
 =?utf-8?B?NWI5Y2czZDRXRmNSbkpoWUcvV0pzRWwwZHo5SVF2VHlVR0Z6NDdWdnkzaU5T?=
 =?utf-8?B?cHk2Wmd5emRHQ1kyN2hENytLMC9tcXJNVGVJV3NUeVk5UzNwY2hnZXV0aVBC?=
 =?utf-8?B?dTh4L2hkTzU3RHRxcXUvR2NOS2thL3REUEk1RVpObTJxbmJwY2xBandBc2xs?=
 =?utf-8?B?bGlMajFYYUswT0ZlN0Jxc3gyaTJpQnJkeWlFbmdTRkNYSm1PTlVsZEJTU203?=
 =?utf-8?B?RWRNSzVJaFh0WTJBcitibFVGTHVqcUs2elowTGk2OVZ2VFR4cGhvREZOamlh?=
 =?utf-8?B?NzFxbHA4RnV6VUVsMFRzR296a0xhZkZPVXlwNkVLc3c4NUJJelM0Y0N1WFpE?=
 =?utf-8?B?RTQweThrczdPN3YzSWkvNi94NSswNVJKMVFYQk80VEMveUxjZUovMlVBcEFL?=
 =?utf-8?B?Yk04bFpTejBRa1pmUnE2TjBmV2RmUklXclFtY2d2Mi9Yemc2YTUyZ2duZW5h?=
 =?utf-8?B?VG91OGpmTFdGWEpHYy9hNXBqdDZaZ2tOU1p2SmFsMldIV1JmejkxdCtERFZI?=
 =?utf-8?B?SEc0a0Q5d2psUHJEUVFkTU1FT05nRjFxMzFCSklJdXA3VXRYdjFlRjRwL1N6?=
 =?utf-8?B?eUZrekdhS0tXeVI1eEpETk05elJ0aTJ3T2pZM3dmeWJ3VTcwYWR3aHphMUpU?=
 =?utf-8?B?UGI2cExIMnBpTEh1TVNVRWFQSTJkL3htekdsZHU2ZGZNZUc2SktjNGhka0hW?=
 =?utf-8?B?cTNLUFdldVZXbDA3QkF3Zm1iVGRBTzRpaGFmNHNjaldwQ2NVc2N3bytOUWVV?=
 =?utf-8?B?bVJVQUJJb0x4d3c1bWJpenlnc3hyRXg0ajJLR3psbDZLOXBNNFRCam1YSnhZ?=
 =?utf-8?B?b3hjWjBxTUN6NXN6RHplQkpSOFFxVnp6dzkrbm9FQ1NWSjlweHNVOUIrajhN?=
 =?utf-8?B?NHQ1N0I2OElIVmlPZW1QQXFuYUF2WjJkbkpKQy9mWHI4SVBRUldQc0w5TVha?=
 =?utf-8?B?RnVId05kcTNJUnVIOE1YT1F4OGtSekVjY2h5TWNvMXpPUW5iT09VanFNSVNk?=
 =?utf-8?B?VmtVY1A1OEhzRlg1RDJNb3dMNTBXSWNqWmlZMCs4TndFa1lEUkhHYjVDMWk3?=
 =?utf-8?B?eE50MGQxS3B4NElLb0hYK09XZTVkdWYyd0FEdW1MUmYrbkdXUUFVOXBuYS94?=
 =?utf-8?B?cnVoZ29WTU05MjUxV0Q4MmNpWlZLSHRsRHdORlFIZTVPa1FpanloODdOWVpp?=
 =?utf-8?B?MjdDUGlTVDJocmx2MHVSNjBYMzhJR1RkTXgwZmdDYzY1RFJCQUVkbjBEZjlj?=
 =?utf-8?B?MC9TMEpjNjBpYTZmMERYRitrQWd1VmNoUW42OGFXK24yMVFCWjlPeExpV1I2?=
 =?utf-8?B?aGF5QjUyVlVQcmJmT0xFRGoyai9ER0lUM0crd1lrUi9DbDl1ZWxkK3hYRG1M?=
 =?utf-8?B?R3FQTWxBUU5zbURrU29qb2t4OHBLMnJ4RnVXWmVlbFFkeCtWUVVKd1IvOG1L?=
 =?utf-8?B?L3E4a0pVbDBCdjc3bjg5OVQvcGdVK0wrbjh3WG5QN0hmMUxVTlFvSm9hZjRq?=
 =?utf-8?B?aGhkTVJ5amd0WlYrMlNXL1JUdGdldmgrZDVZOUNQZk9tcFAwLy8zMWwwYlJu?=
 =?utf-8?B?aXFGSmN1UEpFcUtWSnlJV1kzWkU3NjBob3hOdW9GeGlYV3BsM2E1aG5QdkF3?=
 =?utf-8?B?Z1cxQ1F4UUF1VWliRzl3VHVLMEs5RWdBWFVYUEtwcnprQWVMQmZ2L3VpVkYv?=
 =?utf-8?B?RVJNT0d6N3k1L3VvVm4vK1FnbXdpWnY3MkpnY1RacFlXNzMveFp0SUFWbm5R?=
 =?utf-8?B?WDlRODRxREh1TzBJbTZKNTN5Rnk3RTBOSms0QythZXo2ZUt0NE0yV3cyNVFh?=
 =?utf-8?B?TU5WenEzcVFTRzFiZDI2TlFLYTRNd3pKMjRXL2dDMnlEWjhhT3pUQmlPVXJu?=
 =?utf-8?Q?7PVMTdZ2qR8voBsC/wCWNDMWK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5dd577-acd6-441c-2c9d-08dd26dd1ab4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:23.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LM0zqJEORufJ8hy1wQpfzRbClrJ4fHBq4b49P5JnEm5v1slV/x3WUf8D/eWqw7T3KCpy11bpsluupP/mcawKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/keyboard/ep93xx_keypad.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 817c23438f6e5176431e1f736bb511f9919b67de..6e3cbe3ca72dbd43485c23f6042b4fba007ff5e6 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -260,18 +260,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, keypad);
 
 	device_init_wakeup(&pdev->dev, 1);
-	err = dev_pm_set_wake_irq(&pdev->dev, keypad->irq);
+	err = devm_pm_set_wake_irq(&pdev->dev, keypad->irq);
 	if (err)
 		dev_warn(&pdev->dev, "failed to set up wakeup irq: %d\n", err);
 
 	return 0;
 }
 
-static void ep93xx_keypad_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-}
-
 static const struct of_device_id ep93xx_keypad_of_ids[] = {
 	{ .compatible = "cirrus,ep9307-keypad" },
 	{ /* sentinel */ }
@@ -285,7 +280,6 @@ static struct platform_driver ep93xx_keypad_driver = {
 		.of_match_table = ep93xx_keypad_of_ids,
 	},
 	.probe		= ep93xx_keypad_probe,
-	.remove		= ep93xx_keypad_remove,
 };
 module_platform_driver(ep93xx_keypad_driver);
 

-- 
2.37.1


