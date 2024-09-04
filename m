Return-Path: <linux-pm+bounces-13633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7AA96C824
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 22:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6206F2811DF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF81E6DE7;
	Wed,  4 Sep 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XyJO9RYG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA401E6DC0
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480392; cv=fail; b=U7jHoMVHVY4gaLmhzdR2/BoMaPVJSxGyqiUge8xIpY7CVS2dZAAQlQGncnpWJ57S9nBs7C7xwHtQku4G4b3oTPkL88P3GyWxviW00FOXA0BtUlPePLFHp8as+aKvjY74qx5uZvctSCy1A8uvxRzgxxSXRyKnqzY6PNl6y+vF2+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480392; c=relaxed/simple;
	bh=eI1mNLgwZIOlq3E+9szeMiDf32WzDe0zojE2YguHS3U=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=KXRVq5h1WyJoPplSxiq9ihf9slYHb0U6YFxawG3eJUn4zXl4RRmlShSRCzHT3csY7EVGU18pD+12LBELczOdpImrau0EaseVe4/vkp9mWo8PWoOxTTOJmd/AOxUpiKHqZhikIgywWp8MV+mLDIwm64fYsgCgdJ8EW29Ki0VK7g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XyJO9RYG; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/zP/wjFfX9fwu+gGhb4KCHTotlaFUY1m44XXH1WrQ81brcLuEfaj88lf5GHMP/J6KXuAQ7+IkZ2wrF/FC9D+IvxK6NWEZKBAUYygn6h2C6UYdgLxFLot/vhoogHQaGqtVpBdUOatvkYi/NupHCQLEmWRZZBUtBKVFxHeKNAHQpu4viSm3Me3b9itXPPYeTVPqJv9F6Nk3wrMWzf3YNSXJYltHHv1wPsf1jH7VPSWN6EEeuapda9l1rWhMY/I8R+QRsj5xhIBykmv6O0X3ksijhKs128rrTGUm6itI1m3VRTNC4BMpyW9VeTvM2ODnMLTYxb39FBEG0LNH+DqQb/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krVR9mnwS5MNgtWgBJPPXz7pRbLxKn61gCUnSYqL4R8=;
 b=VXJFqWwKYK3+2k+sIlyaoMAwXsg+V+1vzxtE0BYuTGvZnS9Olp1Q/nY0q+/qn3I5S9Dfh2IjGU7zNioSIGqXfRIYtY0dAHokPcDUcv8FRdhbze9mb/rhofmsAHKT8oNofQfa3DTtbLfKeFTtcAe1dXvnBnGPpoV4thAngHKIKwl0AI1cxOcg7mos9s0dZ7FMkePhG0ZDzDFMz34VBbREypAgtN0sAX4rNN/ED5I5jlHg6riWM5wTbds4gwo002Y9+BkEVglO1ZU2wnGeWkISGJP0yw36JTgu6kd8NBFxmKvUdet0P9cx4DIbGTf3zrwkCSO77Fyog0XlalrjOG2FpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krVR9mnwS5MNgtWgBJPPXz7pRbLxKn61gCUnSYqL4R8=;
 b=XyJO9RYG7+9mEJzanVvzhLxgL4B68fJjhchyXTQ37wwytjuFOeAbICUZGYKltreUpRec4IpKouJTCT5LDxzkJevvKxO5XbL8X4aAte5lWttHNWmwQQ01lHX1vD3P6FoobMsS6ntsYTm7f9Zjj2Ei+MCfDJHvM/b3F9v4m/U4oqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Wed, 4 Sep 2024 20:06:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 20:06:26 +0000
Message-ID: <a5980dad-c409-40ea-8442-3584c0441018@amd.com>
Date: Wed, 4 Sep 2024 15:06:24 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: amd-pstate changes for 6.11-rc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e92b432-1a43-4138-a3e9-08dccd1d0e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2VuZ0FCczI1RGRwbWJ4WjV5Y1FNSnAyUzNzN2lQVFBFdzZBVUZTUGdQRUpD?=
 =?utf-8?B?NlQ0dU8zUWVQZG1ISW5BY1owd3FwSGJPUjYydUVJWUU1Yk9nVysybEFNaE5a?=
 =?utf-8?B?bUVvRDI4SGJTZjNJK0tKcDk5ME93dGFiQWcyK05QWDFFblRkYXBBbkR2RWlw?=
 =?utf-8?B?ZHU0K2s0VjlMRGxlYVZtY01NSFJCQy9uRFhRU1pqMkhLRmF4eUg0S0QwVFpT?=
 =?utf-8?B?MGVaaEFTN3J4RGZJenhsQ1krWjZwSXg4ZG4yL0puR2MzczQydk9UZ3VZc1dM?=
 =?utf-8?B?YWdBMGJ5YW05U2xoRk8ySy9IcGloWVZ0YXlCOW5tNG5kdWZzdzgrVjJ4elB3?=
 =?utf-8?B?bmw0YVdxSmRQN0NZV1RIcEc0bE0ra2RCeS9xdXBvSDFGdkVNcUphSFNLZS9Y?=
 =?utf-8?B?VVJkQWZoZmppWms5UDhTWXloL0ZGL1hFWFUyTHRTeVQxNU9aaFozYjhrVkw5?=
 =?utf-8?B?NGw3UmwySWV2Q2t4NEt1ZG1DcWFpSUtUQWlqbWU4SFJzTHB0dW1taVpONlpZ?=
 =?utf-8?B?WGVxOVhVQkd1QTB4V2h2VU5NTW5kZlc5N2VGMGlGdlR4TVpKbWRYRzFFcVNN?=
 =?utf-8?B?anhHcmN0ODRYUnc4TEhlT01Xb2c1RDNjTnoraVIxVzlOWmVCSWRyZE9uWEVi?=
 =?utf-8?B?T3pNVmJLTC95eU1iSGRZaU5WalUxTmxTQ0w3anVxODBpVzNUQnAzS20wcUdE?=
 =?utf-8?B?M3ZFQ1ZXV2NFREI5RHFncVc2WEVkeEdkWXR0SVNMYTkvOXRDVi9DL0Z4Rjh2?=
 =?utf-8?B?UmdjL2dUcWR0elk3OStxQ3JlYmc5QXJWM3h2YUpJRXZJV0NlTHBCNG1YaWVT?=
 =?utf-8?B?cU5sOWpXcTVzek8zMFI1U1p1cTJISjRGb1FwTjk3Tnk0MSs3NWZCYks3K2hn?=
 =?utf-8?B?QWN6KzM5TU1aT0pnNHRMY004MmwyMXpHUTE5QXpSUWhYbnVPalJBZkROb3Vn?=
 =?utf-8?B?bnVVTGdhQkZYamhabDRoRTE4clh3ZHh6eFlnR0hCenZ4ZDAwM2dkaUhXTldu?=
 =?utf-8?B?NTBxWTVKaWV3cFR5WjNVVlJPQzVDeVpvQnBySTM5QmZhdDJZYXlMNm1vd2tT?=
 =?utf-8?B?TmYvbDM2dHZuYlNVZHNiWUpyWnV1d2djMWNkWFowTW5QRm4vZTBsaWJtSTdJ?=
 =?utf-8?B?bGZta01tTmhXQUE1YVpCWmxuT2FIemZYTWl5amRJWm1UdENBeVlOeUg2SDV2?=
 =?utf-8?B?R0c4N25yWUNYQzZ1OUpkSVJ5S0ZHUlNPVllKNmJkbTFUZEkydTJuZHBZeGdP?=
 =?utf-8?B?d1RPTXVyMitpN2JTTlIzUmc1WFIxZGw4ejB3SHQ0b2NCU3VJbzVvUTVJRCtG?=
 =?utf-8?B?cDRNMXdhOTN0YXJvcjRaSFdaQkNqZlVwaE13ZmhJMnpHYlhwVDdIUHdaOWhw?=
 =?utf-8?B?TFpXdG5HMGpsd0dQZjdNVDV2UUlYV2doVlZBSTdyYzNrYXVhL3ZjK1Rtd2JY?=
 =?utf-8?B?R1JPQTdVWVpDdHpWYTNmaGQvd2FZSUFySGFFSnAyakZKR25mSCt0aWF0YVZH?=
 =?utf-8?B?bmZNdjVxU25jMTRhZ2xWOTdSNkdLVk85ajNZRituNFZtTHFVeFdadStiK05X?=
 =?utf-8?B?UU9Ob0dmMzgzbG5KVEV6Y1Z4YnV0V2luRTVrRzkvT00wK290eVRaRGpOa0ZP?=
 =?utf-8?B?djUrMytRQmpQbTlLNnJ2SU5TbjFVeVE4dWxQRVhPRzYxdjhZaDRuSzFvekUz?=
 =?utf-8?B?SWMwNGc3ajQzcHdWTDBTUzdKUm1nM3NRRllrQVc2cnZDRnBBQ3NkMVRDcGxD?=
 =?utf-8?B?ZmZHNm5pZFRYLy9IY2F6NTFqWGtwSkhTOVg3UGRLK2RhVnZydkViOXQ3Wmtl?=
 =?utf-8?B?eDdEazJ5aVVRaFlXWTVNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1hjT3h0ME9nREllZTBiNlYxZk82ZThjNjNCV2pFekM5Znd5YTRoK3VZbVh3?=
 =?utf-8?B?azlOaCsyOFltZUJkeDUvc3VZcktHL05MdTZEMXF0SVBLZzRLaW9OSlhtd0t0?=
 =?utf-8?B?UjROT0F4SVVncmthT2M4ZitNU21ZbnZjQ0RCN2drK2w0NGZNcVZRTFlpRzEx?=
 =?utf-8?B?cTVmSFhycjM4OGRxczBTKzA0RGRZL2tsdlYxTHpBbVVDQ0xDeExiclUyb1VO?=
 =?utf-8?B?NWlQQThPdnQ5VU1XN3VOcWcybFNFd1I5UThiQWo5SVZCcWVVY2l5dHQ3dGV0?=
 =?utf-8?B?anZyN1dvbVd4YXNGUzhQZUMxQUFGVFd4aytod09jN2ZDZk95QnNDTUFrK0dV?=
 =?utf-8?B?ODcxcEZyN2Rha3VzQ2hmK0dlamxXSXdwenF3S2plNGRwNUMydEprVGxpTnA2?=
 =?utf-8?B?a1BYNXRTaEFIVW1WOEk4YnhOc0dJakhjTjNCNFpxeXR3Tkc4cXlydFFUbkpX?=
 =?utf-8?B?aEdZNm9ycGRmeHlJMTFNaDdkTVczNG5qN0Nld3BobnFZZWViS3lLSWxhRURR?=
 =?utf-8?B?Wk0vbC8xRDIzY2N3cVpkWkxXSHRqaTAwMU03NVloYVZKM21MRnQyaGZlQzJ4?=
 =?utf-8?B?VGxiNWxiajdxeFRUK1pHZ280c0tYTHFML1Nyd3kzV3laWWVuOFhpOU1MOG1V?=
 =?utf-8?B?WWN2OFdhZk9CazZYODVyYjNxUGlDeFZmNUJMdjZiRytFcFNxYitLYXRxSTN5?=
 =?utf-8?B?NXdRN05KZjBlMC9nZjdtL0dRdmZvdXp6NW5XMEJEN0J1OEEvcHhZaFU4cTlB?=
 =?utf-8?B?bDdQYWhZN1A5djRyWm42RThsSjFqMEhTZUtnMm94dHJxOUxZL2NhWFZpR29S?=
 =?utf-8?B?b2psdnRVQTM5ckRncVJrd0owMEpqYUgzdHV2VncwSU9yYXFWTTNEaEdLdSt1?=
 =?utf-8?B?UXAxcE1zaVQveU5MUDlpNHZ4azY2ZllIeml4ZUIzeDVPdi8vbm1JZDFucGRm?=
 =?utf-8?B?UWZUY21kOTJadGpHem1OU1VWQVJLNnhsSHFyRTZyMHNNUytjcExjMnhnemU3?=
 =?utf-8?B?NmdrWURHWkxxMXJGbXIvTis3clhQRXBEUTNPRURrek1QYmsyYkxNRHZiU2hM?=
 =?utf-8?B?anpXa3Z0OXZLVko3TFc0UTJNZ1ZFcW45Qm0wNkw0ZXFBMG1XZk1QM0gyQmdr?=
 =?utf-8?B?UnBxY2ppa1drNVpWNXRSSTZPV2syTEpVRkVLcDlXZVlyZjcvQnR4NkM1dEwy?=
 =?utf-8?B?b2ZFSHRYSlhBV1VzWStSNDZCWTQzWkZUUXcrQ1RnemgvWktJcDBqcU4xWVdt?=
 =?utf-8?B?NUtEK0U0aUNGNXRFN3Q1UnVmOFlmc1lOeUE0cEtkTlR3ZSt4NElHcVhMZnZ0?=
 =?utf-8?B?bjRrelZGOXFlTTRqdTI4SHhsdzdFQWhZOXVRbVl1SCtJdmFIUWlWb0s5VE9l?=
 =?utf-8?B?clM1N2htVEpsUWFKUmM0aWRKNjhoNXk0MlplVFg5Nm50U1F1RGJUb0RaUlUv?=
 =?utf-8?B?V1RXR2RaSGJWUzVaZWhOZVdHVzlMaGtrcC9WYnZwUEUxYi9nVXVzblVZNFg2?=
 =?utf-8?B?Y3VmNGNvMkRtM2x0R0MxSEV5a0dZWXp4bGlkSEpYMVlZekpHRHI4SHRiQWVs?=
 =?utf-8?B?Qm1SY0VsQ3hCS2xOYy9LT1N1L2JhL0UyWTl2cnJKQ1dJL3BGdHF4VHphM0do?=
 =?utf-8?B?Qkt3a201TWJBUzVDbWEzTE54VkhvL3UyMGRBd1RKNlRjVlR5MkxZTVU5dmJn?=
 =?utf-8?B?MzRnWEFydnV3dzdFaklqK1ZHajZYTzVQVEQ5eGt4UEpQbHg4U1dMdzR6dkdP?=
 =?utf-8?B?KzNWR01Ed0dIVWJKRFVlNWhka0VDelcyREtTMjlmWFZvM01KR05UR21DMThj?=
 =?utf-8?B?bHhHSTJ1U0VTbFBvWWg0MlZmVmx6eFNvRDllRmp5NzBScDVwWmV5ZCtQM3Q4?=
 =?utf-8?B?TEQyaHhVSWxFR1dwa0F0NlloS1RZeDJWQzA3NEliSE0vRmZvN0lwSTJtQXJH?=
 =?utf-8?B?b09FODhiY2NYS0J1Nis2ekU1ZURqMHorUXJCNSs2UWk5YmloQkwxM0xKTW5E?=
 =?utf-8?B?SUEyaGFONVozQkxnMVRDREhEei92dHArRjFrMXhEVU5jcW1yWWdjMHQyYytU?=
 =?utf-8?B?T3kyRnRGQjg3MDdQalF6V0RFcGdyZW9YbDcxVmtFbVhuMEllbHFrRTFuK21y?=
 =?utf-8?Q?kUE7RbHywmU/InNy/jw8Gg06m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92b432-1a43-4138-a3e9-08dccd1d0e94
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 20:06:26.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWVYmsNB5ZXlWa1H2VgiIy4by9D1NT0MZppCsP1vuTu51zXuyLVABBPDjb1s5E6C5uxeRLO/7906J6T0vbXkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

The following changes since commit 9983a9cd4d429dc9ca01770083c4c1f366214b65:

   cpufreq/amd-pstate-ut: Don't check for highest perf matching on 
prefcore (2024-08-23 11:07:58 -0500)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.11-2024-09-04

for you to fetch changes up to 9c68a3b03e8109f3917fd35f39043499897d4a79:

   cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on certain 
Zen models (2024-08-28 10:15:00 -0500)

----------------------------------------------------------------
second round of amd-pstate fixes for 6.11:

* Fix an incorrect warning emitted on processors that don't
   support X86_FEATURE_CPPC.

----------------------------------------------------------------
Gautham R. Shenoy (1):
       cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on 
certain Zen models

  drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++----------
  1 file changed, 24 insertions(+), 10 deletions(-)

