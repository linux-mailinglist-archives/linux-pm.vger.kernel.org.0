Return-Path: <linux-pm+bounces-33065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8738B352D8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3533BEA9A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 04:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3F2E172A;
	Tue, 26 Aug 2025 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/j6O/iu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776792D3A80;
	Tue, 26 Aug 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183691; cv=fail; b=NoceJklJN2iSKfkg6+pR3P5nEqwbK1usdJjM7P8nzSxQDqL2VMCBCHzbHlG3AqP9y7xHV6Qmv5IOjORoYJlHf1CdiSDmpDmdHr1ibT4nMVEtDsuocvdTw7hxRWMqtEeKuwtKZtATa8ISXmlS7p0MyqEwqBdClJUoEx7HeoHAwp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183691; c=relaxed/simple;
	bh=3vDN3Ke1e2YKAzNnPVK8KL4nKXe10MvHxQ+zWzhpb/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJjILvwqJMz9rDI2kSmqUwZDr3hgPQgqV2Ccv9e2QOAIV1s9/FCsm3KQDvkW5cUwfOnOwPkBde3PlqQ/LDvJ3c/GCf0ZjxmWLpQCxPA9FBwgR5zSvrMrOtaITfnroiXH3t4eEIsL5Z83VT6IXbBT5htRXPxuDXiPzsD50Hmf8bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/j6O/iu; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4uBi+v7BOqLijlfcXO+zcreUe9eB8oY6/Oc82qxI7v18VtQ6Jbd8kMzHAchWEQA0YT1IawTuVsxQaaOwSV1vnRYylM4zwkxiaA10HcLIsvYUqTQHFFBmam/FEdSsP98DqniukY+SeZyfufghICdH9xIphFDghrbEtc29gkzLKAKcm6RA2+IY9LTJMa5hntpkOrfbkKAKT/m6PalYxTFoHAYyfnxIQ7WbgBebMh7WC2HIs+i/LwXu35l3Nq4F69R53bA9xmUDLdxozg9f9RJbr0lsAhmkLwwYTA6gY7QatmEZs2hnkJiWm4QvGZH+XBEAO8ercDZ40SFAx9fwrCw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6JvtKfstlfCbmy5czfPmo66Xd5J1C0AqMdwSOP+e04=;
 b=F8AQfuZhXJAwAhfSCxc0q/ibkj415qcJxhaYhQjd2Z5+4E7Q/9UUD5EojfjYpIGhpbSkcg+LduWfdRrlVUxPr96QNweioQxcbX5KAXCayLb0WoP1ePcfb4i9d3itliVxBFRLg1e+BFpyGEMl2KeJ8lAjheUDNyTTkEonBX3xQ5oBGw/eTgHcMy5lub28jgQRm0AotdaxZ2yut52q98gKpUsYNXC9Q3YdM2dNlK9nFS4tjBIOAB7XyQFF/3zZcFgrFBhLHgpdkM0Zmgcx3IV0QciZQ9AWJLHLHsTXw8yIUpznz0GKLTrqvPdcmOOQeNNMUZ8PXoQyvyaMaeAwhBDH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6JvtKfstlfCbmy5czfPmo66Xd5J1C0AqMdwSOP+e04=;
 b=t/j6O/iuFEeqyI2tLEAnclwgX7PpdLW6oBPwKR03VGW/FVK3cq2kbyPo2KS8OwsA5EZcu8DBYK83FonUkGDvUUThRkkzAMvvsqq+yhUo6ya5drc0trekCxyyGa2vi7jeyLN2YPm1DbfusDOo5ZNJ0cr6T01uLzsfmNWToyn0kLc/n5rqyFuajucpILJLYJTVgtTzzS0kBZb/hWMNnvXgcxFk8XV9aSbZsZDmiLD/6heens7dv/OwpJnGPBL2aa+OZW4FzvZWx9vsrb4O2bIi1PyVqYasaHf/HSu8QWn9PTSpZfhfLOWx9wPP/i2Md6mCVo0BXRwKDUzcxHyrMlw13A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Tue, 26 Aug 2025 04:48:05 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 04:48:05 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: webgeek1234@gmail.com, Aaron Kling <webgeek1234@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] cpufreq: tegra186: Default divider to 35 if register read fails
Date: Tue, 26 Aug 2025 13:48:01 +0900
Message-ID: <2325429.iZASKD2KPV@senjougahara>
In-Reply-To:
 <CALHNRZ8oaGaAhMVVzfeNf+M+-OvMnCnMd-fRdffmOSTBZiEXCQ@mail.gmail.com>
References:
 <20250825-tegra186-cpufreq-ndiv-v1-1-4669bf8f2992@gmail.com>
 <CALHNRZ8oaGaAhMVVzfeNf+M+-OvMnCnMd-fRdffmOSTBZiEXCQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0231.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::9) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ef34bf-c15a-4b60-b89b-08dde45bbf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjRjREZNM21vVDdadE9xRWtQQXhTa25zaXhvSVZRZExNSXNNbHFXSG5vQk8v?=
 =?utf-8?B?Z25zellQK0VLdlZVTGVjcGhkaUt6b0MydjY2bHFpUkZUSGJFK2RPdllLbEtK?=
 =?utf-8?B?SkJaSGlJeno1ZUJ0ZGlrK0xSbXFqcURKK3poeXdFWWZMWkdQMWxBeEg5SkZV?=
 =?utf-8?B?VUJjTDl4UVkwMVBYTjhtTmJmK252QmRESllJaXNkSjZSeCtKNkY3c2J2ZnNF?=
 =?utf-8?B?TjRIeHZ5cEg2MHAvRWtJK2hoSk5kQXJ2WUNMd3Z4RHJwSUl2ZjJRbDhWaTQr?=
 =?utf-8?B?c2d1NGpkNUNIUDc2dFc1K3FKbGJWVnEzQkkzUEt3bm1mMjhyME1PbW1acXR0?=
 =?utf-8?B?U0YrZ2h5Z3FZaXpvV21LWmU4K1hyQmZsUGIwR2xxV0dNMTFUZkduMk9wVjNP?=
 =?utf-8?B?VnNmdCtCYjhpdm1pTHM2QXZyNFlGV3FlZ0gvMWI0emVHdHRiQzNBU1NUalVY?=
 =?utf-8?B?a0FsY0Y2YkliMitSeDFCRFhhM1VIQWlET00zak1QL1RPdGlBTTdNcFpNUUhY?=
 =?utf-8?B?dlF6Wm1HaUdac1A5cnBKYnYyVmFWRHdJdmpSbXQrTjJHWFoycnVuVTMwWHpx?=
 =?utf-8?B?Tm5uZEwvbEloN1VCVHVVTEFrQkdncHhzekNTcW1yOUt5UVlxZ0M4TTU2ZWNI?=
 =?utf-8?B?RnpPVDBmQy9CL29FVitxRkhWaXU5SHBiS3FwVzNqK3ZHaitQaTRTaEpkZFk2?=
 =?utf-8?B?Q2FSWmZONS8ydm5JdW9jSm52WDZ3cENvRE5KN0tOV0IydnNuYjVXc2h0SGg1?=
 =?utf-8?B?bVRxYWFvSGE1NExHbXFSUEpkeHo5MzQ4WjM4Y0grcndQUzhKSjdGbURpNUZM?=
 =?utf-8?B?NmhOR04rdHRBWTNON2FuYWVBTDYxRHdFVjhTSlJ3azd5a3oxeHBmckpOQnl4?=
 =?utf-8?B?bXMraEZBMmxvR0lETUVyTmZCMHNrUUJxaXpiY2tLUENzbFN4ajhmNEtTeldw?=
 =?utf-8?B?d3NSeUQyeG5LQjNDR3poajlsNFpKR3ZhdEdDenZkMmJuUlNsNDhKemtkL2dL?=
 =?utf-8?B?SVlKaUQ4ZjhBdW1KNVk3UEFTRFFjSEZoWHIxcm5WSCtzU2FOYW9HYU9ndjF3?=
 =?utf-8?B?ZExnMi8xL0gydm16ZUFhSFI2TmFhcHViUERJQktCempxQ2ZjYW9iTHhWN0Q4?=
 =?utf-8?B?c2t5UmIxSXZKWDQvYitIcU8zNFlCL3FTRVdocGQxMnFyT1NrbzV0YU13U2VR?=
 =?utf-8?B?TUx4SnR4Slo5cUZON3FqNndTSHphMDVseXdIUDNYU1pkWVZlRkw5U3ZVcENh?=
 =?utf-8?B?WW9ITjlpcDJnT2tSSnpmUW5naXVqN1RSQU1TRzBGcnNGQnZmaGQ5d054ZUhD?=
 =?utf-8?B?cW1RVHdvWTgySkJJcVBMdWFLRUY3dWpJVlFhRndpdnVGb2laM25nWkJ3QWlo?=
 =?utf-8?B?OFhLTExJUzAyR1RXKzVYeXFGZ0duL1FFeDU4MEc0RjNjZUo5a1BNNnJCQVNt?=
 =?utf-8?B?Ny9NdmxHNThCOE9DU3lBdGp1K0Zudk9WY2JBMkg1RE9vSTBmQXFDL2h3QTlo?=
 =?utf-8?B?UHJBd1F0Um9wZUVTSmZwN2NZOFlFTjB1bld6VWFVckN6QjBlN1dldWtjMk1U?=
 =?utf-8?B?SjgycEc4Wk9NWHpmZUlxQ3YvbDJpY2s5V25hZzhnTFRiOWo3YlMwTVBoUmk4?=
 =?utf-8?B?S2UxTXQrcHV6SjU5Y25QbTlQSTd6STB6YklDRUhUR2FTWnZINERycG5hb3B5?=
 =?utf-8?B?YVFpN2hGZ2RxVUVDQklUbjkyZHpma3MvL2taQk1sU1dSM29PcnJGYkFsSWZP?=
 =?utf-8?B?emhmaTJBeVl5blowb0ljcWZ6SFk2TzdWTzdpTFhmUFdHK3lkNU9qK0w4YkN3?=
 =?utf-8?B?Y2dzMG96OGpkSWw5aEN1dklWVlp5Wmtpc1ZiWmMrbVcwZVYwRjl2dm5yb2wr?=
 =?utf-8?B?bkY4YmNqWEZBam5nMzMzZXlGM0pXYWFPNHJNNHF2VStzbTBzbTd6d3c0aGZz?=
 =?utf-8?Q?DzXXr5WT0Eg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnN6YmduTDIweFhoUUp5S2FveWt3cHhtcE1jckY2eXRTL3A4Q2lmcmszN2s2?=
 =?utf-8?B?SXBnbWo5YnJyYUptTk9BTnpGRng1eWNJY3hFT0RWbTgwQWk3UXRWUzg4ekdR?=
 =?utf-8?B?cGNxVytiK1lmcHlrdkR1MmdKUXF5enhqVFc1RlRETnJzaXFOZ3Jzc1RkcGs4?=
 =?utf-8?B?UEN3Ty93UmxTUE9rWEtvN1p6cCtsdEpVcEJiMWovSTVPY2c1cUpQMUFiMlc5?=
 =?utf-8?B?SjkwdEk3aU1Qb2tZbFJYMCtJR0syN1JhbEwyNytFSndZdG42RDNZRUxscStI?=
 =?utf-8?B?YnZUWVQ1dEV2OGswSi9jMzZFcWlDUjBCSXFNdWZlYnF4REV5WlBpbmdqOEtM?=
 =?utf-8?B?Umd3RkFTQk9rVG1qcUo2N2Z2OVMwd2FpK3pndDErQllRTUVyVHo4SjFFS0dy?=
 =?utf-8?B?SlFUMGVibTVvTEI3MzFweWhQZCtHcklmS2Z3NFpQeW8xMW54TURnVXpFbDVv?=
 =?utf-8?B?c0lZRGtuMFZOMHJFSng5TEJJeExLZzh4Nm83UnM4VFJiQmpKVHl0N050VU1u?=
 =?utf-8?B?QmV5eGVQT2lVc090bExTYW9yb3htdysrNmQ0MGNBN0s2QUlTd1VrK2loVEhF?=
 =?utf-8?B?UDhjbk1zQkM4aTJtMWRyb2hJbkxyNHlYVEw0RTB0T3JTMlRqOFB2R0luOUlY?=
 =?utf-8?B?czY3UmRaZFpIS1phdnUxRnpGejlVdmN1TGg3UmlqOVVpZzY0OE43QVZ5dnRx?=
 =?utf-8?B?ZkE5eDRxSytMZjl3b2tWNkYxV2MvL3RzTWJlL1RKRkpsU1hUUFdSWnZBcW1K?=
 =?utf-8?B?bk9DWVpOdXozb1BTcFg5VGltbTNMbzJkUW5FcXJEaEVpbDNKRzNYYlpIYkxR?=
 =?utf-8?B?cEkwOE1MMHBhcUp2dFRoM3luZ2Q4cmNwdjZoN1BrU1A2N2wvelFEdE5IdTJO?=
 =?utf-8?B?R0RMdW40Um5LdUdOWC9LZy9PYndueUpXOE15Zjk4U2MwdStJZmh1VWc1eUMy?=
 =?utf-8?B?bDZIczVQVVFqUEkvZjg0a0hXMEZxREFPMktTUVhNTGp0V3hCQ0NlSi9pQi9u?=
 =?utf-8?B?MWcwUUVZZFRTMUM0QTByWGhzRU1sS3kyV2tUL1RWQXNhSmt1YjFDaVNmY0Jx?=
 =?utf-8?B?S0d1MTVTMFdNUHNuUDRoWWdOMG02Ny9aQk9ldjhJQU40a203VWJQWkJGQzha?=
 =?utf-8?B?bjJMaGdNN3pPdllLS1VJVzE3bGczZloyaEQ4SFBHRzJuU3FwNXZCdGRxdkgr?=
 =?utf-8?B?YUIyR2N1MGxQTi91ZzZ6dUY2MkhMd1M3QVllaDY0U3dHSHJhbmtvRjdYMnVC?=
 =?utf-8?B?aTF5R21laVJSL2hnak1adVpPOVJRT3h6eGRNa2J6ajNpVVRqYndSSXBFU2Jy?=
 =?utf-8?B?b3I5SktOSlpFNVVwMVZBNit2U3I5REY1eVd1cjQyL2FvZzNzMUFENHZ1eWNF?=
 =?utf-8?B?SEhFdmtKcURxTU5CaGxRdkhER0NRK3laMFV5eVV1TUhtRVlsTzc3OGZNbjVQ?=
 =?utf-8?B?MjFaRXZpWkd0NWMvdUllMXZ1cldsLzlhK2tRNjlWenlMS2hkMGxXWlhDM1NJ?=
 =?utf-8?B?M1Z5MGVIbmtFcmZpaElrMEtDdWxFN2VzMUUzSVlqOU9OaWduOTRqQTZ4TGhX?=
 =?utf-8?B?cUhwUVMrdnBQZ0JKYkY2QnZvU3k4dGlhakFNWXpkT1lOS1RYMWkrdlFpcWl4?=
 =?utf-8?B?UjJ2K25Wbmdpb0lzZldDcVd3dHd1KytpUmRjKzdBdEpveGV0VFc4KzEzbUIw?=
 =?utf-8?B?NHhRTVJnQitDaVE4TUlJWlNaejRvem5yUlJhVDh5VGVWaVNka09xNHp3VW11?=
 =?utf-8?B?TjNXTTcxMXp2UDdOM0lBWDdKaHJZVzIxaTdNd1NpUzhOUkJzbVBwOTRMMmcy?=
 =?utf-8?B?WDJEZVg1cU9jZWc0ZkN6cEJkNEYwLzhYT1MvbzNIL1BBQWRhZlUvakkvK2Fh?=
 =?utf-8?B?VkxrMTMySCthb0h3ejJrR1lneUdYT3NINkFySlVGMXFXRGdDZ3ZXLzN2TWdH?=
 =?utf-8?B?U1oxZ1YwcFhlcEI4RkhpbjE2M1RJQnczRWxiNU9FbTB5L3RiTngveUxhMmV3?=
 =?utf-8?B?VTdyckExdWI3c0lSamdmV1cvSmNyc055QjhzNVEzQVBJenV0bXhFME5Ybmlk?=
 =?utf-8?B?bnBpWDVnaCtaWmErQ04ybUFoVlpmcEFuY3FHZUovNnlTR29kbncyMkk0cFV5?=
 =?utf-8?B?Vk5uN040L09HYVhHSjNPYmZienMwbzMydnVkaE1tUE1Ec1hsRjRTdlJ1c01W?=
 =?utf-8?B?SGVJUmVMNUJFNzdJOTl1TGFneFFxQVJvdTZ3MHA0OEpwVGVyWUcwdTVJSTd4?=
 =?utf-8?B?TGVQT2g1TStydVhDNmVNek1JazNRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef34bf-c15a-4b60-b89b-08dde45bbf07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 04:48:05.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqzkHN2m7ABWiu+QY9sk8mCnMmyFVOkrJ5PJ+WKC6aHOlvt8CKVE2z1Bwbz+DamhysmuuvkqatvbCFJWOGa4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

On Monday, August 25, 2025 2:08=E2=80=AFPM Aaron Kling wrote:
> On Mon, Aug 25, 2025 at 12:03=E2=80=AFAM Aaron Kling via B4 Relay
>=20
> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >=20
> > Several of the cores fail to read any registers and thus fail to
> > initialize cpufreq. With shared policies, this only affects the Denver

By failing to read any registers, do you just mean that they read as 0?

I suspect the issue may be that the EDVD_COREx_VOLT_FREQ registers are just=
=20
used to request VF transitions. If no one has requested anything, the regis=
ter=20
will be at its reset value, zero.

AIUI, in downstream, the driver retrieves the CPU clock rate by measuring i=
t=20
instead of calculating it from an NDIV value, hence it would not run into t=
his=20
issue. I think the conclusion would be that if the register reads as zero, =
we=20
cannot assume any clock rate. Is it possible to tell the cpufreq framework=
=20
that we don't know the rate and it should ask us to set the rate to somethi=
ng?=20
Or otherwise at probe time do this by ourselves.

Thanks,
Mikko

> > cluster, but one of the A57 cores also exhibits this behaviour. If the
> > value is initialized to match what is read by the downstream vendor
> > kernel, scaling works as expected. I have never seen this value be
> > anything other than 35, so it should be a relatively safe assumption.
> >=20
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >=20
> >  drivers/cpufreq/tegra186-cpufreq.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/tegra186-cpufreq.c
> > b/drivers/cpufreq/tegra186-cpufreq.c index
> > cbabb726c6645d2e5f1857a47e5643c8552d1933..f017f903c6843f1881e8311753f62=
69
> > 637c6bc69 100644 --- a/drivers/cpufreq/tegra186-cpufreq.c
> > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > @@ -115,6 +115,11 @@ static unsigned int tegra186_cpufreq_get(unsigned =
int
> > cpu)>=20
> >         edvd_offset =3D data->cpus[policy->cpu].edvd_offset;
> >         ndiv =3D readl(data->regs + edvd_offset) &
> >         EDVD_CORE_VOLT_FREQ_F_MASK;
> >=20
> > +       if (ndiv =3D=3D 0) {
> > +               dev_warn_once(get_cpu_device(policy->cpu),
> > +                        "Scaling registers invalid, using expected
> > values"); +               ndiv =3D 35;
> > +       }
> >=20
> >         cluster_id =3D data->cpus[policy->cpu].bpmp_cluster_id;
> >         cluster =3D &data->clusters[cluster_id];
> >         cpufreq_cpu_put(policy);
> >=20
> > ---
> > base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> > change-id: 20250824-tegra186-cpufreq-ndiv-bc97a22814a9
> >=20
> > Best regards,
> > --
> > Aaron Kling <webgeek1234@gmail.com>
>=20
> I tried to open a discussion about this issue on the mailing list [0],
> but well over two months later, no responses have been given. I know
> this isn't an ideal solution, but in lieu of better knowledge of
> what's happening, this is the best I have. And this unblocks scaling
> the denver cores on tegra186.
>=20
> Aaron
>=20
> [0]
> https://lore.kernel.org/linux-tegra/CALHNRZ98_gh5dKw_GoayG4ieU3TWYAFFt29=
=3D49
> 5g4+dNLzwjbg@mail.gmail.com/





