Return-Path: <linux-pm+bounces-33666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298CB410FC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 01:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B58F4E0204
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A842EA737;
	Tue,  2 Sep 2025 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LfsdQiDo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CD274B51;
	Tue,  2 Sep 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857106; cv=fail; b=Hayh/H1oh++X680KZDvhAYQkuZWyzp8yCeFkRMBqY25C2WEecCkeedJkSP8eK2zRduMaOIlr0Ft1lw3Fu8aJFfXQLkhKpNcX/RBOrJ0osCWbmath0P8UlSlqlZVJWuxKGveO4LIRtu9TD2JyLriQw+WFZajITxjLup8J2xW+V20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857106; c=relaxed/simple;
	bh=hBdwdx+kK/RVIvwykOX7oV7rXx2Jv5ccLfRXmPPnLK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHtBrkN1qipAqY/OPOl0Pq+7jGMJ5zSCwE5u6zyGxvV/zO07gKHhUgEN2O8pxaWoD5fnPDK324iav4f+Gi+tB1a6CPBHijIlrJ2cg1cuLyQVO9RO03xRWroOblsrjFEMTGurfYpPBKPh3SkALhqkIMJSjnyqrb7HlIJNgAh8yU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LfsdQiDo; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf3dzTw2ah25+hIFC7L0FrRdj37VGDg303jgFAirpQJu4uKukCCZrgreEtI6IbPWqY9HAfOxc2T/Kp5V18ga3V4r2x05BUP4CM7+NPWPHlIlVdo+VKx9Hv29KjM834oyOEWgjQrrOdC8wc5TujckuvL2glGAmaRilN2AGntCippheQFWErX93jrtxsNbVNWvUfkJpa0zqWxp6sEma5acqkuSoZr1zRfteZjpXtjTzqnAKPCQ3/zj+35GrIGoT5QjVHHpd3X+3joWVm6x2wCC2Tmnn6dk7ArLarWKYhyAMZ6MsmBCONEm+EwgYgml+tKgbQ7VjS/ZyIwwww0V5jIkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NlhNzB1VXsdDdeWOHzAiCEeXSliKxfnceloKRZKFG0=;
 b=xct+ugyUvTEz07hrLaTfsrD744xPAS5cJgnW4SPsGe7ff+qMxLLTbLz6hBbq4kagQIY+S0Kgrj5IOxDBBMGeCVAQWK3NfmxP9RsgVyOxz8wxh/qFRMTYKPCpd7r2bpFlAC7eXRzsVzO4ZnuVU5Y51WqNPh5/mLJR5QDB3gQCo8IbcH9XlcPz/xUDQldU3vDiPnkxz7AQneCv1Zh3ueNevQ5nEHVoZeksEXhcXof4DvSYU8atc9TldqnZ2er52iHKwdysflbqmRjGfDuhwQkWbUnaYOfPR1AuI36YjQoLKcBnBzIubAn4beYyoB8N1bVP/ma2C+mhuFP0gGcJOtibxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NlhNzB1VXsdDdeWOHzAiCEeXSliKxfnceloKRZKFG0=;
 b=LfsdQiDonNISlGi0WhZR42rmGFW8QV2/htpEmi3qPFD2ugf6CDtAgteVzKzEgrYWHzcdDXx5NL+TKzXQLvw4I62aoSohfFAHqu7fRNm5m8IX54e8Ibj5tRLzDNPbV9idxO1J56/OGz5f6g/fRir0ewvxAew0+o8Lwi3bGU+NxqXMY4z+NBfUf2r5dACf5Wl7omhChxRvAQqQVyic1SiXDjzuJSXKh1uKog+iLhjkMh1BGYMul4asT0kYbOJlRei8NXK3n83stNQuGcaQl4UZyUYQ9uCyBpf9U7UVMFxY1AuUmOzm5G/FTnErFkw6dbfKcDldhrgrEIgOWzKS8PozDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 23:51:42 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 23:51:42 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>,
 webgeek1234@gmail.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
 Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH RFC 0/7] Support Tegra210 actmon for dynamic EMC scaling
Date: Wed, 03 Sep 2025 08:51:38 +0900
Message-ID: <25477710.6Emhk5qWAg@senjougahara>
In-Reply-To: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f85a93b-dc68-408a-9934-08ddea7baa65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Und4VkpEL1hTL2JMdjNidHVzOHJDTlp0U0JyRVhRTHRQWkRyb0paZGNzTGpY?=
 =?utf-8?B?MU5hQ3Z1RWRIMlVqR1NhaG42UUJOT0p1a0dGQWVtcktqSjIyNmxzNHo5ZTRI?=
 =?utf-8?B?ZitnV1A4ZWNEdm1vTVV5OXFZdE5zYUI2Nm0rQ1U3YVF4cmJzOW85S1NCVFlD?=
 =?utf-8?B?ZWNRTjNvc01QM3A5eWZScWpqczFHTUNZU3IrMkVsR3JVWktGWW1YL1hna1di?=
 =?utf-8?B?OFdKUFJMK2RvQzNKVDNlRXZyRWVtSm1yZnhHUkFoNHExK3IyU3ZES1pvUktr?=
 =?utf-8?B?MThSYUxpdi8zRG9LVmpoYkJ3QXJkcFhaUjk0ckNkYklVZXcxMUFQM1hFSmNW?=
 =?utf-8?B?V2NmMmYzc095TXVBL3JPQ2RvZXNXbU1EVkpwUnhVczFBa1d6ZGRnb1ZQR2Vy?=
 =?utf-8?B?UkhWcmRCeG12VEVSbjFOVDRaamlCblkrdUxVdTFtRjVySGl0akwySmMwVzkz?=
 =?utf-8?B?Z3FxVGN6NHVNY0RRZ0cyR3JyNC9SNVE3UndIcnQyQ1FITDNXdG5IRzBmd0pN?=
 =?utf-8?B?Uks0VTgyb3l1dGNKU2ZtVTZuUTdhNE9xT3BFL3dpelowSzI4NDNRSTVxMWVE?=
 =?utf-8?B?dTM2L1I2UDlxOVNCYjhPbjFOcDFqYmdrUFl4OWMrUVowaEhBTzI4c1JpSGRP?=
 =?utf-8?B?QVdTV3ZUcUI4b0NkTExXL3hxZ1RRU1hJU1p0TDRmOW12dERUUTZyS09zRjNq?=
 =?utf-8?B?YjZuQU5hdjhIZ3hsOThJNVh4clNCNHpmY2VybWg3djZ5b2l0MDM3VjRrVGE2?=
 =?utf-8?B?cUtxTXYwZUhTZ05RT0FVYjUwSVYyUDZkNVQySUtCdm82WDVkNFlPU05ydVBX?=
 =?utf-8?B?M3M0a3M1WkM3MENVNW5TMWIvRVcvaFYvdVZ6bEVSa0dvcFZYNm9iWk02VFhl?=
 =?utf-8?B?WTJ0WldVcit5bWV6Q0xwQVFJRVNmQ2pZR1hCcWhXaGNURzQ3d1lUYjZaZ0oy?=
 =?utf-8?B?UDdRZGgxUDRJT0U5USt0ampDSitpdnQwTTk5MEVoWFFsZ1ZrWm1XWlJ6em1C?=
 =?utf-8?B?SEE5ZkdtSUhpVVZ5R2YxUFFXY2FoNXhyMzk3OEtFZURuVmR5NExtQTN3c2dq?=
 =?utf-8?B?ZzVVci85ZGNoWTNlMnVQa1cwUHlTWGt1WU1naXAzbG11Um1sMDMzYkVidmZV?=
 =?utf-8?B?V0lranFGQitRLzlmeUI5K0JMdGxOYkdHVzRSR1NLMkljdlB2Ri9XUW9wTmtm?=
 =?utf-8?B?NzlYTkl6TmxiaSt3NElMZ3h4RGdPMDBzRXVkUVZmNVlHM2ZIalJobkF5SXZT?=
 =?utf-8?B?K05teW5EUWxuSk5HNEJqdk1veHpHVzNEQStWWVhOOVJHMHRLMFVJUXdvWHVa?=
 =?utf-8?B?NWZkdXlhOHBadU9HdDJaajdOaHhhOXFwbUFFdUl2eS9jWFVyTm14bnRHMFRZ?=
 =?utf-8?B?NVluUmNKa2FMSm42aElSR0JrZStDbUp0Y2dBaFFvbkw1Ly90dzNtWXA1ejFo?=
 =?utf-8?B?cllyNVJmeEZMMjBqTlU2SzgzM0Y3blNQelJ5TDgxR1lGaVB6cWYwbWZCWUF2?=
 =?utf-8?B?bkkyc0JBSkVGK2pvMUNwLzY2UkxJalZuQllhK2JGbXRZb0hHRWpNaGVIaGcv?=
 =?utf-8?B?Yk9yUGpwdTJtL3RsVTFoMVcrWEJUYWMxQkZRTTlRY3BZbWxrK0poTW02U3V3?=
 =?utf-8?B?d1pNUHpGVmQvQkFsRVV0YTlMNkFZOGhtTGJ5aUpCRlFYVTIvYXJraEZxOVV5?=
 =?utf-8?B?bFZoZUZYTEhmcXN2T3BoWVd2TW1FRi9JSFI1NndjdUtpZnl3WlYyVkFoM3pm?=
 =?utf-8?B?SnErSTJvMGpQVFczQmNTNnVMejBlTVRVdjZQMW5oeFBkajFUNDlmT1BUNlZP?=
 =?utf-8?B?cENVV1BUMERaK1MxZzlDZ1Z4TDRzT2JiZlFtQUxWOG1EdjRCTG9CSEYyOUtz?=
 =?utf-8?B?MDAyUVVGYTBZWldRaUE5QytoTm5XQXNQUUlHUzQwT3Vha1d6Tm1kZ3ZYZzFi?=
 =?utf-8?B?ZlFFUTBzQWduSVUrMHBhYVFkZktxTDc3cy9OSjJUZzA1VzVrSTlXOGlwTFh5?=
 =?utf-8?B?N1lVRzBQQ0RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNXOFNpMysyNjVxTUNsaFBCRkRIV1dBT1lEUWdTTTI3QWtIQkhOenNyS09Q?=
 =?utf-8?B?bWdScHZEK0lRcUNJMWpjTGEzamV0M2laa0Fxd0RjVms5Z3VlNjA5UkxBdWNu?=
 =?utf-8?B?ZGV0RFEvUFZVZGQzS0dacXpTZUJWQkc4b2VGNllMbDdGalVYQnFDeWl3UFZH?=
 =?utf-8?B?OU1Ram5SeUJoSmdKQnFoU0ZMelkySStkY3IrKys0NEljMXYzdkR6cHQwOHpU?=
 =?utf-8?B?UEl2UzdXdC9Hd1EvSXZsM1ppT0pDZVBvaG9aUUtoZTdWSlVLMWpxRk14VFls?=
 =?utf-8?B?Mi90RzNkUEh4YldhWEVCUlNMM3E4L3lTYzVtVmVpSFJyM3U2Zit4RWNxa25R?=
 =?utf-8?B?S21aaWdRYkt0RDYzeGtVTmpYdWp0ZENRK0xKanNGbURsMEZkc3MyazRqOFJL?=
 =?utf-8?B?dldobitSWkZFaE9UcGR3YndlOTVrdVRhN2pDaHhuS3h4WHhxa3B3cHdkYnFU?=
 =?utf-8?B?MHpjZ1F5Vis4cUd1cDFGRDJNNnN2Q04rRFluaGYvUXNtNXRvb2ZNSGxQa3Rj?=
 =?utf-8?B?YWpUZVpMUUdmK0dPVFFoU3pUSVVnYmNzY25DYzJ3TzZ5SGxNNktnMnU4UllC?=
 =?utf-8?B?MEI2RkFVL3pMb2dPTWJQNThOOXlVeHU1ekE3SXJ1ZUtlRjZMU1hNS1dvSlpI?=
 =?utf-8?B?YWhiOXdnK0JGdG4wN2llV001M1pjR0lxL0dBUXlGRHE3L2Z0cWJBS010eUtC?=
 =?utf-8?B?UlBSaWhHQUt4QWVUaU1yUUp6V3o1WmlYVUdGdUI5WktId1hXUUYrdW4weXpk?=
 =?utf-8?B?d1ZQTmt1c21UL1h1cHY0SkNYMmVUdUxldTdiSmhQKzJVOW9MbDhmTERDcXBM?=
 =?utf-8?B?R3p0ZUI5a3R1bVFhbklHczJqNGxHRzlETWY3a1doQXlkVDVkN2VwOGVoWitL?=
 =?utf-8?B?N2lJYnhLS255eVNoelcxR2p3blVMa0ttb2x1S2ZYcXhMYit4U0J4U0VIUUpl?=
 =?utf-8?B?QXlsbHlqbWhJbjd4TlB3cGZuRnRnY0E4TE10Zk56QTh0STZqR3BwOTY3YTVD?=
 =?utf-8?B?bzZ3SFl1L2VFWHRhS0kyY3hLaFhqUFBJRG5qS1FiM01NWWljTkttQ1p6Q29N?=
 =?utf-8?B?SXl0YVc2a1hTZTN5VjEyMktsVExkandXcFgweU5KaER2UzRyY3RFcnAxR2dU?=
 =?utf-8?B?UU8wbHU3Z1lJV0VNd2hENWZNd0pIaitDN1A1NmNtbTBVMkhicnZyY3RzbG54?=
 =?utf-8?B?RUYrVGtxV25GR0cyNEVWbmZpcUIwVGRvc3AxR1o1c0pQbktBOTcvd1ZOYU9m?=
 =?utf-8?B?MmhLdjg3SGljZVBncTN1OHp5UEdQZ3dFVW1tUkhGTUR4YkloOWhIUXo5aWhw?=
 =?utf-8?B?cDRaVWVQeHdxdHpJelVBcm1VYy9vY1plNGNaeXN4bndjbTY4YUVMQ1BVSmRW?=
 =?utf-8?B?YkN2SHVqeUZpVXAveEFvZVBySmVtcG9PVnVnU0xNRFkvQWJxMEV1c0VweXNQ?=
 =?utf-8?B?RTZrTlU1b2hnMlMrTktzSitJU2J5QTB4ZHNQUzY1blg0RlRvaXIyWklkczJE?=
 =?utf-8?B?TXBTZmkxQlkzdmVScXRldzBBR3FxNldjU2ZJOUNEMS9PcUdVS3BHcktweCtO?=
 =?utf-8?B?TExieFlqblZQUS9sSXAxOFA0aVV1THY2NzZISTZMUEgrL3hEaCtVakpMQjVP?=
 =?utf-8?B?YzVzUVlBVDVZOFJNeUNIVGphYVNOQXBtQXRxYmlYMFZ6Zk9jQWFBTzJnN1VL?=
 =?utf-8?B?M3BiNnhnZHZDQ0dvUFYzRTIwOVlPTEl4OVQwaDVwd254YmV4Y25lT2dFMVFh?=
 =?utf-8?B?WmRNNXZjNDNNQ1hWVzE1L1hXZkxXYXYrb1ZOZEJ5Zy9zZmFoWWpkamcxNWRu?=
 =?utf-8?B?RVA1TlV5Y290OE1xUTRUbHJYZGxablMzNnBuMzdHelJYWnVYa2FoWEF4b3By?=
 =?utf-8?B?WDROOHI4V1lSVEZSZ3pwcXdPQjJYSFZwdzBwbFlrU3JXaHlmbWgxMGRObVFv?=
 =?utf-8?B?eWVUWi9rbXFSalEyU210dHJWRFlwb3IxajkrNzlpTEZTN0FNRUZSSkV2M2p5?=
 =?utf-8?B?endQdzBtT1ExREpweVpBOXZUam8xQzB1dkZZdENNOFhocjJ4enVIRWZBclB2?=
 =?utf-8?B?NG5TVGViVndoeFlHTmhCV2wvU1dyR0dSN3BuUXBoN2M1dGMzTXVWYUs3c3NE?=
 =?utf-8?B?SnN1R2FuN0FkQi9RNDVwemJtakhuUHZmZmhQRzN3Y3FwUE5hRnRta2JBUkVv?=
 =?utf-8?B?eU1FVVJaaEVWM0RnZ0hiRlpsR3BDQXo5WnpQU1lGdG1UWkw1YzBBTU84VEY5?=
 =?utf-8?B?N0dINDA5NDUvbERZWGFZNDZqUUhBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f85a93b-dc68-408a-9934-08ddea7baa65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 23:51:42.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCvyD0LUksE6/XHBbU6r1WCriVgpixZoRAZSeAFiVnOQWUpADUSG3VkCi36BVGYMH0C1XFNDxLpUyXJPrFGO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

On Friday, August 29, 2025 1:01=E2=80=AFPM Aaron Kling via B4 Relay wrote:
> This series adds interconnect support to tegra210 MC and EMC, then
> enables actmon. This enables dynamic emc scaling.
>=20
> This series is marked RFC for two reasons:
>=20
> 1) Calculating rate from bandwidth usage results in double the expected
>    rate. I thought this might be due to the ram being 64-bit, but the
>    related CFG5 register reports 32-bit on both p2371-2180 and
>    p3450-0000. I'm using the calculation used for Tegra124 and haven't
>    seen seen anything obviously different between the ram handling on
>    these archs to cause a different result. I have considered that the
>    number of channels might affect the reporting, and factoring in that
>    variable does result in the correct rate, but I don't want to assume
>    that's correct without confirmation.

My thinking is also that this is due to the channels. L4T says

/*
 * Tegra11 has dual 32-bit memory channels, while
 * Tegra12 has single 64-bit memory channel. Tegra21
 * has either dual 32 bit channels (LP4) or a single
 * 64 bit channel (LP3).
 *
 * MC effectively operates as 64-bit bus.
 */

next to calculating bw_to_freq, and proceeds to use the same divisor for T1=
14 to T210. Regarding the CFG5_DRAM_WIDTH field, I'm guessing it gives the =
width for one channel, but I'm not sure how it would function for other mem=
ory types -- I'm not sure if any Tegra210 devices using memory other than L=
PDDR4 were ever released.

I also noticed that when running on LPDDR4, the DRAM clock is actually runn=
ing at 2x EMC rate. But I think this is (slightly inappropriately) papered =
over by the EMC driver, which actually deals in the DRAM clock rate even if=
 the HW EMC clock might be running at half rate.

>=20
> 2) I am seeing intermittent instability when transitioning to rates of
>    204 MHz or below on p2371-2180. I have noted that if the first
>    transition to such a state works, then it continues to work for the
>    rest of that boot cycle. But the kernel will often panic the first
>    time it tries to downclock. I suspect this is a pre-existing issue
>    only brought to light now because nothing would ever lower the clock
>    rate previously.

Not sure about this.

Cheers,
Mikko

>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Aaron Kling (7):
>       dt-bindings: memory: tegra210: Add memory client IDs
>       dt-bindings: devfreq: tegra30-actmon: Add Tegra124 fallback for Teg=
ra210
>       soc: tegra: fuse: speedo-tegra210: Add soc speedo 2
>       memory: tegra210: Support interconnect framework
>       arm64: tegra: tegra210: Add actmon
>       arm64: tegra: Add interconnect properties to Tegra210 device-tree
>       arm64: tegra: Add OPP tables on Tegra210
>=20
>  .../bindings/devfreq/nvidia,tegra30-actmon.yaml    |  13 +-
>  .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 ++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  43 ++++
>  drivers/memory/tegra/Kconfig                       |   1 +
>  drivers/memory/tegra/tegra210-emc-core.c           | 276 +++++++++++++++=
+++++-
>  drivers/memory/tegra/tegra210-emc.h                |  25 ++
>  drivers/memory/tegra/tegra210.c                    |  81 ++++++
>  drivers/soc/tegra/fuse/speedo-tegra210.c           |   1 +
>  include/dt-bindings/memory/tegra210-mc.h           |  58 +++++
>  9 files changed, 626 insertions(+), 7 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250822-t210-actmon-34904ce7ed0c
> prerequisite-change-id: 20250812-tegra210-speedo-470691e8b8cc:v1
> prerequisite-patch-id: 81859c81abbe79aed1cfbc95b4f5bcdc5637d6bd
> prerequisite-patch-id: 98bda8855bcc57c59b2231b7808d4478301afe68
> prerequisite-patch-id: 6e0b69d42ea542dc9f58b410abd5974644f75dc4
> prerequisite-patch-id: 9e3b9b2fdb8d9c2264dfa7641d1aec84fb7aedd9
> prerequisite-patch-id: ef4bcc4ddba7898b188fb3fc6e414a2662183f91
>=20
> Best regards,
>=20





