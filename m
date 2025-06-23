Return-Path: <linux-pm+bounces-29316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294CAE40CC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96EE18887E5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE43248195;
	Mon, 23 Jun 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CNqCM2yd"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012026.outbound.protection.outlook.com [52.101.126.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E721246BCF;
	Mon, 23 Jun 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682432; cv=fail; b=X0XnNI4p6oejZrV0YxwOfwZQbydaFI8puFl5GW4E3QPKIGE3zkQRHNfyzlcuaTsvvXqm46TbQEjXfKjt08QUocpsCc5tb6Uz7Mu53Le4i1oXvEKRcLggQGF3yLLSK7JY4qFzKqWAP6W+2YwP9IEEraombyPre3qlTgDFOaZgOMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682432; c=relaxed/simple;
	bh=vBkC9/MwHKQoBltgAeciWRFifRV0a/iGrp8DKiMuTy8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n0C0UyyDbDs/8vUyw/TbfRgY4AVFnfAv7Ibl3OjwL0GTf/k4aoiBQjDpqmDYkkttTxjUcf2KD/RCWOlMELw8aV1sG+obaxP9fUKtYOoHQNRMYya326n44XC0hKQvxFHgCkVznloQ9aoD4h+L8ZdXecvCWG8CtNfh4pwcefZoQ2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CNqCM2yd; arc=fail smtp.client-ip=52.101.126.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYvSSVl5xpEbMdo2vKKVxpZGUXO/GVEJFpTcdVr5R+lyElDoOJ2UnR+rsFZSIJOz9aodaMaa5zsYarLbY5YAzWuUstywtYt/1BDGarDueLVxN0uBQeiLTbPO1ZNr1SDBHzFv2097kVjCFdGX2OVF4kT/tRw0xE0+Jt9/3Rtvw2iQZVYZZ2yLE6xixbRhOjeDFdIz9jHTyZRIsyUaRbB/Vu7x2YC4r0Svnqb2ScxVetk8sa3hUVQcwDar6aMXNpctpl9BOR29wOFaWit3JIoq1eNPpN0J5g9/VuQiDHZ7q+vCxpN67tAA8AIj6cmLDBD9toctmbjrgpRHMOdNItHPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf5xgcn70NGF48RdCUNfbkCTsJQvidMlsdWCNA2c3IA=;
 b=cKU0t4f6DPNq+VLNMP7SKWJUyP+2gURTnoIfCWcQbgFCuemr4eYThJQ0vR2ZX7QCACsNSJBdsQ6m/nVKAmh9Ha/gbj/mwYggZbdP/N0ZJR4qQV1xYGHFgBfUeVAAXZdsGVZ+EegaQRRlQVa2JjCbocKb8v2oUNCiXqbATU5hmwVXNsc3mB7l/qXI0F93MiT3Z2t3WcQe5sAlfKCmTadtfsPh4RLgCc2tYeMNjIT1WODSXyn/tRxsNmdvnpAmOrCb96IR3Qaoj/HSB8f0dnN/cwqUzhMIJT+SmOhGI91TiOKkY7pSabiR0tT+sbOpEyNOJiDic9Fbt/N+byrjPNuckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf5xgcn70NGF48RdCUNfbkCTsJQvidMlsdWCNA2c3IA=;
 b=CNqCM2ydodVNYjrsz2yLko2ffj9TO1iSZkQ6YJ0hAjenYihOnCwOrumuOVob/oxlzgoBZ7rf4Q6VLdoBEoV69uipYUKeyyEpJOo7OfWj6gmwB3N7INnH82yZkL+nvt0djI4pqtPDeWdIZuaX5erNhpvwcmRnkNfk/RoYeUvReSNR3fAeNgvTI0SXpQ01PFimrzOJiXzf3hX5OkjbyKLQzojgMx99Iq35aCICmuLYGQHFVaRR/OuXu67UbbH5ttlCid/NcjW31IAj6Xk3NAf4pUtyg4IL/KHKkYZp93Po9gYs6RwVH/rGo/fRr2w2Xudm7Ot6vJUroyGIfiWoSpiS0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:40:28 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:40:28 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 16/24] thermal/drivers/max77620: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:40:15 +0800
Message-Id: <20250623124016.474586-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SE3PR06MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf7c47f-4766-4c96-dae0-08ddb2532222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3ZjeC9kM3h5VURHbi9xaXVGRmgxZ1loa2VNUWs2ekI2RXgvNXdkeldrUHR2?=
 =?utf-8?B?WnZVZm5sdGVGWXlrdHVTL2NKY0xZY1BwcGhNUlVoZXBqZGRROW52UVZzSWxS?=
 =?utf-8?B?cWwvamx0cTl2d1dPMml6WVdiYlg5QmIrMDZLM3lJbTcyYU83RzdVN2s0UTdO?=
 =?utf-8?B?cGozajFnYnlod0JQV0FZNFoxRjNtR1JPcFVHOE1FVGFMeFpCNTZZT05xOHBG?=
 =?utf-8?B?eG5ya3djTWhTTXptcVA4MGRqM1dyM2VTdGV5NzJsVkRzUXRMS1l4bXpHUHVJ?=
 =?utf-8?B?NGpzaU9xQ0xtK2RsRHNvSHJJcG9WOXhPYld4eVJ5c2tyVy90VUhaaHh5cjNP?=
 =?utf-8?B?UE51M2lzSnFPK0dNRmFkZTFxdkZvK1pDV2Joelk1dVNJWnp1MjEvcEVzQ1p3?=
 =?utf-8?B?ZERjWjRPUUNBUncrMG40NkUrT1lzRGo4aUkrN2JLakhzTDBQWWxhRldIaCtT?=
 =?utf-8?B?SkN4ZDJVekhESkNpNFpLMitZOW1wQ0kzVmdTa1ZrUWcyaTVmNUk1VXdDZTFF?=
 =?utf-8?B?N2YvQms1VUszY1Ruc1pjLzVTVlN6TXN0RWpmekJEUlN5QU9pRnZ3V3hVaGg3?=
 =?utf-8?B?N01FQmtJK1VpMENZL1h5Q2dzTHpwSjE0OG1jeE00SXpMU0xFZzJiRXVZYlpB?=
 =?utf-8?B?ai9hU1pSZDUxNjNFWmlXelFFTWRIWVE3WmppclNoZWhtR0tsMzFRQTFBVjdC?=
 =?utf-8?B?UmNHRzZFVm9VbURjQTFwb0NJamlUYzEveDBrNEl1S2hTVVVCYzMyZVZCSEk5?=
 =?utf-8?B?aEY2TGQ4elJkNWtoWEppeWJDUnU0K3l4dWNzZ1NOd0Y5M1BNQi9tckhENWkr?=
 =?utf-8?B?MkU4ZHIrNDFiV3k2SCticnZMRjhBMUpSR0ZmcUZBODc5czdBM1NudUg5WFd1?=
 =?utf-8?B?SjNSVWxPVEp0WGU3aURUdDZjWklTUUkramp1ZUZINklybHczNStzWmlJTXY5?=
 =?utf-8?B?VEtMSjh3TDNabDJ3Q0RobWFhcHFXdklEVWEvVU5DdjRKTHptb2VtT0o2czZT?=
 =?utf-8?B?L0xySmFFMndyVC82aTZXZWZMbXZDVGJQcVp4bU9uSElxT0xpZHNPSUlIUVA2?=
 =?utf-8?B?Y3E1blh3eStORTVvY3Zidm1JdjZWK291YnRUQTlxWnRCMVlqalpxMDg2VWlr?=
 =?utf-8?B?NjdkMzhoTHc2SktJQjdmd1hYZWo3OXFoWFI3aXNzcG4rMllraVJLbG53UXZo?=
 =?utf-8?B?K0lwNUJ3NDFzQXQzSVArRVpCMGRWVjBzSThjUEs0eWVnVnRGWWlpTlArbUZG?=
 =?utf-8?B?VE84MTlQYmlLVmkrYjBWMllGeGthbVFja3VXakFhMzl3RXpZRDdTNkt0U2dw?=
 =?utf-8?B?QisybTFCOUNheGRmR3BybVVxa2t1RUJZVHFxbTRZMGxqcnVnc3NOUDRyelRs?=
 =?utf-8?B?SWRGRHVZRlpWTmNhZmUwZGdUV25ZZDJ3YXBCNGFXT1E0NHNVMyt5NGkrL1dm?=
 =?utf-8?B?b0oxaDlkdmcxU2Q1bDZmRFhqUkdLTUgwTUM2c0dBL1lEeTA2dHcxL0dGQjZC?=
 =?utf-8?B?ODlzcVdXcWpNYzQ1Z2pTZjVEV25VQkxWRUEwbnNNZU44NUVMMVdGMDBzclJz?=
 =?utf-8?B?b0I2blZrb3hCMm0yZENvU3lINHpMRHpmQTZoYzJJMURZRzBlS2V3azM0ZWRx?=
 =?utf-8?B?K2hPNUZWdmJWQjlVMnVDaURLbjVGbURFcHhJZ0VEdjY4b1grQVpaZ2RoOUMy?=
 =?utf-8?B?K1U4SC9ZSGZnTG1Fc29BR2RjRHFtQmhsajdiRkpvajM4SExGMmNHemV4NEVS?=
 =?utf-8?B?YUd0SXZBY3RWZEVqUUxmaU91NERubVJneDR3ZWY5d3NacVVWaDlvTDBYNnAx?=
 =?utf-8?B?QkRmUG9IK0RpMm56TWl2RnBhS3cxemZUbnZnNzNXbnhoSVVWdHJDN3ZKVTNG?=
 =?utf-8?B?d3V1RW1XMklXTWNsNzhHdk9RTFA3bEZTWWg0cWdJa3JVYmtseW9zMVFKRS9W?=
 =?utf-8?B?NlY4UDByMTA1NksxUmloblA4SHhCNWF0Um1OMkFtTDJCRjRaZGFlNHRVSTh0?=
 =?utf-8?B?QVJ3K0RVSmd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnpvNit6ekhLYnRBR0E1b1dFQmhyQTczaGVrU1pLR01sRTB6QVBhZWJGamoy?=
 =?utf-8?B?MWVmdGFoZnNxRFZTL2xzb2hSekpTZXBqY0pGWStkWTRaY0loNU1RbnZuZndm?=
 =?utf-8?B?VlNEd1kybjAzOW4wN1k4YWFTTWtkUWJRVVFXOEtSWkwxelNQQ01DSWg3eEhq?=
 =?utf-8?B?aElQY2IrNkltWDRuSzFLaURMMWQ4dVIyeTgyL3o5UVpmRU9GTXk4MGFkNUZV?=
 =?utf-8?B?REt0YmZ2SjhxN3ZZNi9ic1FLRjJZYUdtZ0FXR1orb1loSFF2M3FUOUxIYTVr?=
 =?utf-8?B?YUk0RTdlSGRGQUVXcmdEUU5VRDVBWndMZmsxbWhJUkpKZEsvQ29yeENnU2Ix?=
 =?utf-8?B?Ynk0YXVQTFROSGMzNVFmbGU3dWJldVlnN1FoUEFhSU00cGx3UnJmMDJMZ0cr?=
 =?utf-8?B?M0dRWVlCckd2M3U3V2Q1ODR1VFFYZmNIdmdDYWlTczByeHliNk1XK0JSd2Rq?=
 =?utf-8?B?SStZb3RpdkFqVFV4WHIyZFFiTkZmTVlXclk4M3F0ZTI4NnJ2V2wzRUluR1Bi?=
 =?utf-8?B?aEM4a1lRVGV0MDJJaE96aVF6U2FWRlQwZ3g5QmY3cmNYREFNQTMyWFNwTnli?=
 =?utf-8?B?Mm5QTlk1b3hmdlBYMUFPbzQxM3EyZGV1ckZDbzgzOThEZFBxQW1zeGNnRmdL?=
 =?utf-8?B?QU1BVlB5anB0NklWUFRweWlPTHprNmpFUCtNaHpyeSt3b1VRWmtOZ2tmbTVQ?=
 =?utf-8?B?VUxrekhYR0ZOK2QyTitCeWxXa01Mb0xNcW54eFBCNkJVMjdkdjJsQy9hY29q?=
 =?utf-8?B?bEFyd25BZGFwVi82WFZlalJkUFRQQUFYQTFmRzBTNkdZc1FQMCtiQ2xCM21H?=
 =?utf-8?B?VW5oSGdwNlo4RVJuWVk2NXBPWHpmNEpkbnhlMlpjSDdnZXMvdjBEQUN0d0dV?=
 =?utf-8?B?aUJJOFBNOUE0UVkxZ3BOWlF2ZDlZL1Fwa3RRYms0cG9VTWw2S0tsdXZOUFZI?=
 =?utf-8?B?MGY2Tmx2RG42amFmQkduekxweDhiSnR1L05ZMEFyYXNuREZHbVB1Ri9OSGtl?=
 =?utf-8?B?TzF4bFo4ZlpKOFM1OGRqRzJRQ2xZVUZ1emg2L2JpVWZDTUZ4MDhPNGxWdStj?=
 =?utf-8?B?eFlROWcrRTRZYkJ5Z1hkNlJLZHQwTDBuR2I3UXF3K3FqRTdhRE40LzVmUGJk?=
 =?utf-8?B?RWY1TC9WcWgvbkhuUFJTZVBjTGRXQnRXck1pS1RUUUJPcW1zNmhRT1lkV1FQ?=
 =?utf-8?B?cUFndjVFSVFKU1lOQXk2ZnpEZGJwaFNNTUo5UGsybTVHOE9WdS9jM05uWFFC?=
 =?utf-8?B?SWxWZnVwOHhsRytRMzFhZnBRN041OGRQNnR4d0FpVEdtc1JJTWM4M3hwSzlT?=
 =?utf-8?B?Y0VEeU0xMWpiSmFSUlBlN29wU2EyckVja2dlcW9XRGJ4UlZtcGE2UmN4bHRl?=
 =?utf-8?B?S2N3NEQ5cEJPSUNEYklUL2hBUHpVb0FhVzBlcGFuNk1Hd1Y2aGlRcVh1L0Za?=
 =?utf-8?B?YnhmblM3WDZBZTdMOGtiYVVDNnIxbWNvT1M0WXJNR3ZIamFONmpqRVNzRGJB?=
 =?utf-8?B?Y2g1bFE4aFFEY2RWTTU2N3BuejRYc2JROXdCNVk1ZVN0VkRxL200cXBoRjE5?=
 =?utf-8?B?ODFjcjBXc2hoNUpOakJWa1N4TGtwYkZYelZuNGMwcUE4akxmTDVMaWtXWEs0?=
 =?utf-8?B?NzRoUXJMenJzVTVVKzl1RWxsZnFZV0JLM2RxSzgrbWN4WjltTC91a2VVZ1Nn?=
 =?utf-8?B?Sk50YUF3Mldib1lOWGRFWHFqdlQwRitTelJDdzlFckJMSFg2a01NNW9DQ2Q4?=
 =?utf-8?B?K2NITEh5Y1JEV2FQeVlxU3BBVmc0UHJZU0ZJa3FUQ3h5dE92bVcwY0JQTkUx?=
 =?utf-8?B?ck14MEVna1Z6MFlIZkpCVjZ0SURURjNWVFB2WmNESnpLaVhhZG1LSjZERzh0?=
 =?utf-8?B?RXhaaUxxTjBxZkVBcUhrN0MvUXBWWlYvZm1PNENZTWdWSFNlSHVuV0xvUXNk?=
 =?utf-8?B?ODNZNjZQQmtxanVkTFl1UldWUUpOZXdvRU1KSXFoWWFCeFo0T1IxSXo4UkpN?=
 =?utf-8?B?VXhQSVdkMEg0RloydWxQeVJKanpBdTJiRXd1THJIL1hCOVc3QTdobkVpUGFo?=
 =?utf-8?B?c01iZGgzQ29MVGV4U3ZOT0Y0TldIM05NWkZ3OTFjT0c3S0drZ0tZZ0NWdFlJ?=
 =?utf-8?Q?UhY9r0LAB93stD/OpfAE/Ht/b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf7c47f-4766-4c96-dae0-08ddb2532222
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:40:28.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jQiMt44yN/nt9zAFJCzR6VeOjCEoLOrWipztzmig2myzPiVcGm4o6B0H+SlBqexW8+LXIuVtiYCUVb9wZSyrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/max77620_thermal.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 85a12e98d6dc..c425be81a1e6 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -117,23 +117,19 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(mtherm->tz_device))
 		return PTR_ERR(mtherm->tz_device);
 
-	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
-					max77620_thermal_irq,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, mtherm->irq_tjalarm1, NULL,
+					      max77620_thermal_irq,
+					      IRQF_ONESHOT | IRQF_SHARED,
+					      dev_name(&pdev->dev), mtherm, "irq1");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
-					max77620_thermal_irq,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, mtherm->irq_tjalarm2, NULL,
+					      max77620_thermal_irq,
+					      IRQF_ONESHOT | IRQF_SHARED,
+					      dev_name(&pdev->dev), mtherm, "irq2");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.39.0


