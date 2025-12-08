Return-Path: <linux-pm+bounces-39296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C031BCACDB5
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 11:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BA5030164D1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA52F6929;
	Mon,  8 Dec 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hQdmMvMo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hQdmMvMo"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D92F60B6;
	Mon,  8 Dec 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189576; cv=fail; b=lK4kb4PhjEGv86Yapjz4M627o9lWYazCLkqdhrzpxa8BPx6GFbEfvEr26FQC98ZAH91mWHn573eLubEkESxc1vjQCEBN3eUhV7RDIsebZNVV0tbn6V7Gr8qIWF9Evz2f5+po9i4NMY09486TcZYjBLatV1rd6cONAj2Hq6SbooE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189576; c=relaxed/simple;
	bh=z00KFYucJl2kmXKdIWOIS4+Ro7lY2l+eLJsbPFTDYrk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOTWl+2BlcIhTmXBX8lSKKpPmgNbMGTyfORyu1KoPTDmMddAeB/UXHlN5iOU/XnjGQGdsjXapnc4nAbvkZfsGunCarjYQJ9rQxsAOtgWkHd2YBF8tf2KSO11+W+9wL9fp7yAJwgdPobEgj9JaWZch/CCXGXiZsbRabgWy17y7So=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hQdmMvMo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hQdmMvMo; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pg5D8Pe+58jusq8GdlQ2Gx03b2JslO1oY4Gb+d2IKJh+qrImVMEvdeGlzCkgYymYx28Ot4kupV/2q2qwW4lC4yJZhuO0l07BgDO/hq7WbItdiIRmOCcy0ciIyZXKIlVhdzEXflfJJTBkAUp+HXQZx4HEY0TGPKumyTitUgJCHgpPxU3OupiBEPEeZZGakLOpbGY9E3luVirWojvZNgUiyRPkpdBzuv97krRT9g3cfoz7wfssGgJbAZVWHRiv3ZFZ2EJSUHpwaGPxuAxQ8xhrGqbeEj+aEwUOLlFpoynJcq8APazu1tNvaqZrCZO0WEVd6JsiYD8FhSwB09tlhM4L1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3vy+l768L2dvGVz3yWpI1gCh0bQ6JN+6CSAVgAU18M=;
 b=gNRx4a8mKHpr6rY7P7BWtICmP+0y6BFztse3eu2aSnNElq3ahFPgy0cge/xcNyzjxFEm8ewTxKukaUDXOPXxMDmbblX2e25WAyNrnhsbWKc+22Hvn5o0ep8N09L2So3NRfspG7CRKuIFH6ljV18oEAMKqCq3Da7PQKaeGxMkidhtFRQX4+rZo7YTe648TV+NTp5OwDiajPcHTBKwxhCmSmSKCDnCe/9iy1Sfa76n+IpU3/M8GN1N50sLQDJfXPafgqB3IOkun0IEDpVHty1RlYFdVcBi9EOLmNcNBkyL12gyE7rTlCKzy5m0WhCEk7obYYyTHYjVb81qz8pWAUivZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3vy+l768L2dvGVz3yWpI1gCh0bQ6JN+6CSAVgAU18M=;
 b=hQdmMvMov3HMVavjR39MQuyeOR6dF4t4R43/oslm7qCOPiSUpu2PyH6S3sbnojojdE9dvN/41PTMTWwAv9WcDfFZvYGlHtM/BoWUb9DeRR9tMCb/B9fzod5Gu759s4YiDcBKUi5pp/KTO7b8Ra/ZdPYS7wRfAiHKHubXuQodd0o=
Received: from DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) by DB9PR08MB11401.eurprd08.prod.outlook.com
 (2603:10a6:10:60e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:26:09 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::52) by DUZPR01CA0302.outlook.office365.com
 (2603:10a6:10:4b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 10:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 8 Dec 2025 10:26:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xObbBOGLPzIhLwh7BlUIavVLNIJM7WtQu11NjIkF7Fa8yUfLPVEH6UgLwliTkjPJC90MDKpdv1D2v9PSOc4o5q63q69ckmsHwrEHj9fuAAfcei9ijEIdJR1k/bbEPdR4LyOWUxD5qFDjBLTbozcuTadTcJSAXJaUGgKZsdGkSMk4t6FS1q8wi+/P4Q/sfZDMOx5ZFVZZhTEiBSGYJO9cu7mYtcaX87ikm2F7YBzZCnZMbyHYPqYo0YVbSZcEtz4IpU7AvE3hPFXSeak5zqCiKBV3vqniKm8LkQI8E1h2cnjNzdJNybN9jmHm3CV2Q/WGAT+7IbPQNTx7nQiGyRGZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3vy+l768L2dvGVz3yWpI1gCh0bQ6JN+6CSAVgAU18M=;
 b=yLzKaueUpd3vkXvTSGYLltEnkiP1QxikeaiIcUddMAF3MGiKarzEJHAWiIGM3AvQGYWSNalGaYCIvWXd9xUzIi38XMHHyYQcd+NgQ9ihTMBAwAIvrAyjJLeOVF2fbGwh5byO6gudLIIPQLldjTN58XuzDQt5aUYzUNyn6OPhkwCRYw/p629LHgmauAniemAKMZnef2RWooYcFXnvYh9z1kHuC0cNJPP0lRKYByZ474UxR9mP+DGkFD01YfBFFAvfZ77ReS2TaKkEWlcC+4/rGHWk7DPM28/NYHjCVweGa0Lf80x65rheav8vtsWf9y2/2r6yFfmFC2uHfr1/AxR7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3vy+l768L2dvGVz3yWpI1gCh0bQ6JN+6CSAVgAU18M=;
 b=hQdmMvMov3HMVavjR39MQuyeOR6dF4t4R43/oslm7qCOPiSUpu2PyH6S3sbnojojdE9dvN/41PTMTWwAv9WcDfFZvYGlHtM/BoWUb9DeRR9tMCb/B9fzod5Gu759s4YiDcBKUi5pp/KTO7b8Ra/ZdPYS7wRfAiHKHubXuQodd0o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI0PR08MB11688.eurprd08.prod.outlook.com (2603:10a6:800:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:25:07 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 10:25:07 +0000
Message-ID: <41ad3fe6-59e3-43b7-b346-3ba3cc460826@arm.com>
Date: Mon, 8 Dec 2025 11:25:05 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 2/4] cpufreq: Add boost_freq_req QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20251204101344.192678-1-pierre.gondois@arm.com>
 <20251204101344.192678-3-pierre.gondois@arm.com>
 <080d40e0-f004-42dc-aecc-3c3af291d374@huawei.com>
Content-Language: en-US
In-Reply-To: <080d40e0-f004-42dc-aecc-3c3af291d374@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0159.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::23) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI0PR08MB11688:EE_|DB1PEPF000509F7:EE_|DB9PR08MB11401:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d0fb37-76c8-408c-a32d-08de3644344e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Vk9xeXE3dytqenVGN2NCRFZYb3NJRmgxd2YrZ0VZY0NFOHZXNWttNkNXTkV5?=
 =?utf-8?B?UGR5eE8rdTZpb2NRVlBMU1A5SURSQlZUcWMzNWVqYlB0N1RFR09vVjhhUXFR?=
 =?utf-8?B?YUUvc2tXNlo3cVZOc3dKZ0FQNnlodHlWVXJnS09uQ0hkcVE1QnZqdzF0SDZh?=
 =?utf-8?B?KzdZZnZFNENuSEFPSEkvUmxWL2NidkVKcmxrQTc4SFZGRW50RnN4UnFadmxx?=
 =?utf-8?B?QVNCMG90TnphNktOR09vbWNla2hsQkN5bFVZRWx3dVV3eTcyTEtoak5FcnVo?=
 =?utf-8?B?Skpua1BHdmVtTGlLM3U3cEVlSUdoUmhTeUwrNW9kbkd3V0NiV1d0OXY0NVpL?=
 =?utf-8?B?WFJLU1JkSjBCYXIzUDBQUXVNV1hlUVNWV0ZQNUErbnlXeXZvU29YTUpPWC9E?=
 =?utf-8?B?V1JRV2h5c2YxOFBMaFpKNnJrUUlpc0prcjAzeHV5L2xaTEZBTTB5WlkwTDRk?=
 =?utf-8?B?SXRFbHVOOFRFK2MzM1NHc2MyOWF3M1RxRTlvWWtXTGRJbnhRU2xQdjZjdzBC?=
 =?utf-8?B?MWtuQjdydW1TRUlWWUZ1eHNTOTkyejQxOVJOTVVCNElGekI4Z2hnVnRiamhM?=
 =?utf-8?B?Y1BrYlRHSUZuaGtvZHBFQnNvMytQcDNjb2loL0NMQWRzQ29rSlpnbmFYQzdx?=
 =?utf-8?B?Y1E3WnJEU2hyNUtkdW15bWxmMXVkQ1NxN1dFR29DUi8yOGRXSTl4NWo5Mmlw?=
 =?utf-8?B?UzdCd0VNNk5oaGRkczdmMkZwVlRQem9BR3V5NVZ2Sk1PS0RVUms2VVcyMkRD?=
 =?utf-8?B?eVdhREN6YklMaFNoRnBEczFneHMzRHg3NEpoMzZuUEFqT1JuUytlNUNiNm04?=
 =?utf-8?B?ZkJlR2RzaE1wL09wOGg5UGU3ZUg2R2MwNWVnOFZwNm81WVVFdXhVMWJPTkpo?=
 =?utf-8?B?a3AzeWduU1hZL1BaSmJJbXhpNHRteTRMbXVvZS9CNktzN3pncHdiTjFrSDR3?=
 =?utf-8?B?M29jcUVaYWpqU1duSVBZcnloMkdYYnM1NU44Y1JVeXc1SkZNK1NhWTFYcXpq?=
 =?utf-8?B?TEFOUzIwTXBVdUJoWklSKytFUVNycFk1amtJK2dXQlBWdUpadTZSUG94Wmgv?=
 =?utf-8?B?RjJGTmdFWTVWUUxrbjJLemowVkFtRk14dmtZekdIcjlSbDFnVTlEVmlKWWFD?=
 =?utf-8?B?a2prQXdsOFBmVVd2R0NmT0ZaZUp6MTBkK09KQ1UzbnJ6bVFSVXlyTG5OU1hr?=
 =?utf-8?B?V3FLamNYdmlZR1l1M1lpK2o2THp1V0h0Rkh3TCswdThzVEJKa2ppMHFMSGg4?=
 =?utf-8?B?Y2ZqWTZOdzR2Q0lWYSt2cldRRC8rZG5GcWlLajNSNElXZUFqRGN6ckpZRmI1?=
 =?utf-8?B?cVAxenhiSGhoKzlxU09EalYrUUhoVCtWWGtXSVhLWFA2MElWblNyYWgwUVZI?=
 =?utf-8?B?d2FHRHNFNGxocnRnRldnUW5qV0VpZEhSOFpLOWx2RDlsS2hqQ0RYTVQwUWFo?=
 =?utf-8?B?RHRqTXBTeVl1K0gzUzE5aStRVERSM29NUHkrUXBuWWlhdldET3FvbVdpSW1B?=
 =?utf-8?B?RzJGd3RFcHhydmhUUjNUZkxNTmVPT2VBM04xTmhRVStkU2xEVnFyeVZqaTla?=
 =?utf-8?B?eDNUUElocmRXeVhzVFAvcGRiL1A2ZWRDVDR6RkF5ejBYKzFQYnlPbWllK3k0?=
 =?utf-8?B?TUZJYi83MER0OFhvbVl5dENQZVhlcFk5cEs2MGRtQVBLSXh3cW1rb2dXNTBM?=
 =?utf-8?B?OUNMeUEwM0plaENqV3dBOW1oT2pSSXpqSGpCUXJWNkYyWCsxNkdjV29ic3Fh?=
 =?utf-8?B?NGFISE9mNngrWlZ5NkhBMHluK0c1ZU4ybVlMNysvNzNZYnNKbTF1VzVrM0xI?=
 =?utf-8?B?WjVwcGJQQ2xlOS9vZ1hFeDdabjRFcUp1ZjA5Zk5GM3ZXRG85NUZtSWZZcGlk?=
 =?utf-8?B?ZW1lcnV0aVFKSVN1ZERYbnlLSGx0OWpjczg1ZVRGMzNzR0x4UTd3d2RpV2dB?=
 =?utf-8?Q?uaWjii9VrkCQVRXnzqL2NXQp0D58Wrjz?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11688
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a347dcb1-e355-43af-3ed3-08de36440ea7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTFSUEJacHB0bC9jSENhY0JzaWFDdXNUOGR0eWRudWJDc3FXR28xMmlvekE2?=
 =?utf-8?B?bWdOK1ZId0w0bHdxYTRkS29vcFBVbXFKenZyU2VCRElBb1hIeUJCVTA4V0JK?=
 =?utf-8?B?U0JSMXhPNzBWcXZobzdVOFZNNHFHcTlIRUYxTkxoWnEzRTJKVm93SW1jcWtp?=
 =?utf-8?B?Y3B4OG9adExaTCtKYkZiWkFuR0JoNDRBWWFXdkhLQzlyU0RvMzJwVDlITTd5?=
 =?utf-8?B?cDVwRDdqME5mWEZKOWhFaWs1QjUzcU1aTmlMaWMzZithdWVOVHZGalVLTG9r?=
 =?utf-8?B?czJuUmUzUkJjUUlSVzErVVFWWjhrMnJneGtyMUJaRUgzbTBLcDczUW5tNm9Q?=
 =?utf-8?B?aHBGdTk5MzlVYXh6czNZYWpHN1VpWkRRWXdVLzUzSCtLb2xDYzIvNjVHTEdP?=
 =?utf-8?B?Q2VOOHpLeWR2TUhzS2IvdHlFMDE3SThVL3ZVZXZRZHJHSGJMZTJxeXFFaVgx?=
 =?utf-8?B?c0ZuQXBNVTBsVGROU3NOOW9ma0dTdkVLZW9vbXpPVkR6K0VBK0hNc0k0TDVI?=
 =?utf-8?B?K25FMnA3WXdWZjI1enRKMDhkZ3M3a3kyRytmdVAyd2h2OWtHaVlVMHg5TGZG?=
 =?utf-8?B?bS8xVUF1TWJUZ2VnMUxhSmIrU0duMFl3R2RhTVNDU1dGS3NnVzBabmowSjdG?=
 =?utf-8?B?Wkxjc2t5eHNDOVZpaGpQNENEVEM4b0Q1WE9Kamh5WEVvRGtTNGFZcTltL0F2?=
 =?utf-8?B?T0p5d0wxUXdXemtsZzIzd2NJYWtLL1hRN2R4SkpqZXhjM3MzeDE1cmxmdVFv?=
 =?utf-8?B?cElFdW14RFNqUHhIUkQ0TGN6U2JpTnBkTWplQklCbVB0TjhieE55Z0kxRStT?=
 =?utf-8?B?Vjl1MWVRY1lKSlF1eXU3NkF4eGtoNExna3psZ1l0S0xGdmFDblBxZ1N3K0M5?=
 =?utf-8?B?d24xSVRyTmgrdG40TE5JTDlCSk9lWVZwQnh2L3Q3d3JJUVNaK0NYZnFzbjl6?=
 =?utf-8?B?Qmdkc2xCK3ZmSlBJVUJpOUdsN0h0cWd4K1Y5R3E5OFdoK2lPWEk4eExWTzBO?=
 =?utf-8?B?bXZDL0FrVjMxWlFBbFhOVElxeXNrZlhDa1cxbjFkU25RdzkrMVpQUVl6VFdC?=
 =?utf-8?B?ZjA3d1Iwa25EUHByY3VPdkp4SkJla2Qwckt6eW1sbE5aT1Jrb2NoM091Z0JX?=
 =?utf-8?B?WkZWVDRuOENsa1F2NGdKd3BxdmREaGxOYXVDYjZLY0owSTBGUithWEZ6QUw1?=
 =?utf-8?B?akJobXBvMUFTUXdScEx5b3dlZ1dPbHdsNmhrelZwQ3daOTY2dW9tcFZpRm9s?=
 =?utf-8?B?aWxka2l0SzVOOEJaSDFyaUJFK01jcUVaQzFyUENGMEEyOVpVS3JCZVZvSGlC?=
 =?utf-8?B?VjR2UENZejZpa25HWUF6Zk9jM2JyRE9yUHZWSEZoTVdWbVU4L3dxOWQzMjhB?=
 =?utf-8?B?QnBsVHlnUHNBZ3JHaWFCOHNIQkFaMXpibFVwZHJzMUIzcmlRWGFHbGNhSzRr?=
 =?utf-8?B?S3F3ZmFpR1l4dkZOTWFVTmRwQ3o5bk9rb0wwc1BwK2lrVHRGZk5pQ1BUTmtF?=
 =?utf-8?B?VFJUMXorZ2lBMUpZM3FLK2JZNmNkZmtQWHJnTGNwOUc5UDVHQzdadGppUkc4?=
 =?utf-8?B?SDBsV3JQeXNucUEyYk45OUhCVzhOWGgvMzUwdUxxcFNoWDVUTkEyRVZ6a0NJ?=
 =?utf-8?B?bitTaTVPOWM2bmxkM0VSdWlVQ1lhZm4xRXdnRnc2ZlNLL3E0OWJJbjlJOVo1?=
 =?utf-8?B?L1Q3RGlPYzR2dmdVYUltRktwVzVVTzVJemJRdk4vN3M3dUVUUFNOMENIT3hX?=
 =?utf-8?B?N2VaR0ptcE5iRTVBZlQ5cnp4WEN5TzZuWVJILzA3TngzYzBQc29uUkNaZFB6?=
 =?utf-8?B?Z0ZDN2tVWHpDRG9CaDZ6b1ZMUy95YVZzVkJhdTk0NWk2SDd3UFZ4L29VOU9m?=
 =?utf-8?B?TG9UM3pyUnAvbFFzd1dEUTZXdFFYVCtVbWM3SGNDZ2hSYnZLNjBibXlnQjVW?=
 =?utf-8?B?L3JXaVpVSC81cTFQSXdhSWVrWFJZUzNNcElHeTVzV3FFc1BWNmV5amtINVF4?=
 =?utf-8?B?ZDZKQ3FrYjlHd1pWL3VvSDI5R0RTd1NhaUtrVm0xb2owdzYxbStZMktQbnh5?=
 =?utf-8?B?am0rcm9kQnV0a0V4VkJCd1ZSYnhmd3p0VTJQUFpYVkxwTVFOcEtPYXM1azQ3?=
 =?utf-8?Q?EccY=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:26:09.5346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d0fb37-76c8-408c-a32d-08de3644344e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11401


On 12/4/25 12:50, zhenglifeng (A) wrote:
> On 2025/12/4 18:13, Pierre Gondois wrote:
>> The Power Management Quality of Service (PM QoS) allows to
>> aggregate constraints from multiple entities. It is currently
>> used to manage the min/max frequency of a given policy.
>>
>> Frequency constraints can come for instance from:
>> - Thermal framework: acpi_thermal_cpufreq_init()
>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>> - User: by setting policyX/scaling_[min|max]_freq
>> The minimum of the max frequency constraints is used to compute
>> the resulting maximum allowed frequency.
>>
>> When enabling boost frequencies, the same frequency request object
>> (policy->max_freq_req) as to handle requests from users is used.
>> As a result, when setting:
>> - scaling_max_freq
>> - boost
>> The last sysfs file used overwrites the request from the other
>> sysfs file.
>>
>> To avoid this, create a per-policy boost_freq_req to save the boost
>> constraints instead of overwriting the last scaling_max_freq
>> constraint.
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
>>   include/linux/cpufreq.h   |  1 +
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 11b29c7dbea9e..23f64346b80f8 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1370,6 +1370,18 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   		freq_qos_remove_request(policy->max_freq_req);
>>   	}
>>   
>> +	if (policy->boost_freq_req) {
>> +		/*
>> +		 * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
>> +		 * notification, since CPUFREQ_CREATE_POLICY notification was
>> +		 * sent after adding boost_freq_req earlier.
>> +		 */
>> +		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>> +					     CPUFREQ_REMOVE_POLICY, policy);
> The CPUFREQ_REMOVE_POLICY notification is sent before removing
> max_freq_req, I don't think it should be sent again here.
Yes indeed
>> +		freq_qos_remove_request(policy->boost_freq_req);
>> +		kfree(policy->boost_freq_req);
>> +	}
>> +
> I think boost_freq_req should be removed before removing max_freq_req,
> since it was added after adding max_freq_req as shown below.

Ok right

>>   	freq_qos_remove_request(policy->min_freq_req);
>>   	kfree(policy->min_freq_req);
>>   
>> @@ -1476,6 +1488,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   			goto out_destroy_policy;
>>   		}
>>   
>> +		if (policy->boost_supported) {
>> +			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
>> +				GFP_KERNEL);
>> +			if (!policy->boost_freq_req) {
>> +				ret = -ENOMEM;
>> +				goto out_destroy_policy;
>> +			}
>> +
>> +			ret = freq_qos_add_request(&policy->constraints,
>> +						   policy->boost_freq_req,
>> +						   FREQ_QOS_MAX,
>> +						   FREQ_QOS_MAX_DEFAULT_VALUE);
>> +			if (ret < 0) {
>> +				/*
>> +				 * So we don't call freq_qos_remove_request() for an
>> +				 * uninitialized request.
>> +				 */
>> +				kfree(policy->boost_freq_req);
>> +				policy->boost_freq_req = NULL;
>> +				goto out_destroy_policy;
>> +			}
>> +		}
>> +
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>>   	}
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 0465d1e6f72ac..c292a6a19e4f5 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>>   	struct freq_constraints	constraints;
>>   	struct freq_qos_request	*min_freq_req;
>>   	struct freq_qos_request	*max_freq_req;
>> +	struct freq_qos_request *boost_freq_req;
>>   
>>   	struct cpufreq_frequency_table	*freq_table;
>>   	enum cpufreq_table_sorting freq_table_sorted;

