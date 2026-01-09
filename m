Return-Path: <linux-pm+bounces-40564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB0ED0B948
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E7430194C8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977F3644D4;
	Fri,  9 Jan 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cd6Aazfr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cd6Aazfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404D328B6C;
	Fri,  9 Jan 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978821; cv=fail; b=BVwf+M2bSLBIuNKFZZcBtXXBCEyEKrgyxfM15P5rLlpSUnTkvyOdeBwkUMICf5pLJqL0nV1Rt4EoHHVE3HYzozaPOf0PaR14kQFz9xEjF7+5IPEdelQp9XCAfQJPyiJpVqqW1NVjRUFOWcbQvgaauo80eRKZwFEFZdT75swVoKE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978821; c=relaxed/simple;
	bh=OAXvhpbJzXH80U7RxA5sbBkxBKPsT7dd+iGibF2dJ8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lq9v5s1gIRepCIaV9A1siQltwq9KKoItP1MsZDF0wAUpuyBmAbGmukPKI9a1+RuvRHu6Hd107Rzjlf7pdHTkzhaRYzYApdGpGdExpJz0/SNbYnpZBce8L3QRlJn7MKlGdikOXUDDz8PABkvGtB/nNXwEcluq2TFjuY2LAwnuL7k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cd6Aazfr; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cd6Aazfr; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Bznzh8+rMUf8sxaC1G6sBm205BovKBHzVS0VJRfqsYqCb2/HojBNg2jGy/NDjhG2h543RorksU5VMy+lr4dOuvkTcGcV6dVRkuzw/U7of2LRsq9wqHLYG9/eFcFOXP9LIha21wvLsrCljyY2yug3bkd4PnQo2rZCdNytRNKcajh41jFHDOGqZyHdYrCdrdnkUwI3OwVWEVLf5c8/Cy3rBDZkw7XclzulsGnJ5zq1C9A/UfuyUlPto7eaHzohN91Y+wah+dyd52Bfqh0h85a0fFltclwJxHIMAOnn3Mya+5c5hCRNZBanKkUMpXTlh09Chj89TXjcCCVTkIR/p7Nz+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7nPB2fQ6BgSGqETF+tx8dCk/ONP+yO4Y8/3ZrJCWZM=;
 b=ysx6LT0A0yRvEg9q1K1LuTOkdQLPjhD1hRqG9nFOPkt+p/YsyU35RteuRUxtKy7LTd+yHQVjWM1UEpuLL+vBUNGGJOXW+ONh0w7SSxumcDu4+E58C2Rs9mQPPsZsoSziRO4XH06KCkjVf79/E85v8lU4qAp74WAgKMsRwShzAd5JxzjJhUMH0yCuMWFCAWYjyhNqCTgRYzmygFssCynBfMicM8mkXUFmiIUiz75qCVyJu6KLore4vkwd9ShQwv+nJvp8VHPwHys41BkaV5R1uNfaSuoNjob22Ojg/Z9fWpdkuORLrLsTGk8iXrLn1Mw1CycaU/uUMN/ROs13MEg65Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7nPB2fQ6BgSGqETF+tx8dCk/ONP+yO4Y8/3ZrJCWZM=;
 b=cd6Aazfr1Y6Flkol9A7JUtb/HAQ3EAPxq/iqcKyEP9CGy7gNEW6HKQ7Bap9GPgQWqlHcKaokddQgjn5reaerpK+MkOpmC74csgzCX6x4g7hTSEvPI0JtpUdm8tFXoavKPmAcQNWgB3pnSb9KqZVJn2kLgvYRgZvmPnFkZTY7TxE=
Received: from CWLP123CA0206.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19d::8)
 by AM0PR08MB11257.eurprd08.prod.outlook.com (2603:10a6:20b:6fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 17:13:36 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:400:19d:cafe::b3) by CWLP123CA0206.outlook.office365.com
 (2603:10a6:400:19d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 17:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Fri, 9 Jan 2026 17:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwQql8Gvhbz1QtwvNiptF831OkW2NRsWQvxj3/nSu2q5SqMYkxsD7HffXhRpVs/an7d/NToFAROnOnyZ6HeeYJR5UjfP6QokbMd2KEGexLYic7aoTbYLXaOLaFk5C4deSNZDBc4RpC15U3uK510m6aZzPbHoEIOsUQYsu3CfEvWKSUduaJCZj97doDkkNnEn43rFKc/0LqHN31aWBJhdX1dD/yhBKoJEkmL6Cit8VmhwkFy1ekCWT9aUDnuXK7CFIv8EBmAn4ntQl2jGtQHHvalxUUxMx1v1DDz27fCVAnxugCAQSUdjdCJOq5OA0/6V25/qIpUo9srlAHV7lDgSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7nPB2fQ6BgSGqETF+tx8dCk/ONP+yO4Y8/3ZrJCWZM=;
 b=SNzAxS0lVUVTknqZ0noj7uzP7UVlcm/lsvWdFHLppp9MoaAWZttSN9mmr6XYZ2dv7rIQox/EHzS97+J8LRLhu6Cy7yiBsaAZnoWSiLl3wvZHhgXedDYNlqqu/uf0aYC5gvf+P0Ak42DxtxLS2scog4bxmLE/NbB9e4bI87APLKHV7MHey4/ygoGm6a5b4ixQx9LrYuzhwy+kVG3fGdUbAQ2LeSVyt82Bo/4DDOzR7tVTINRIAxMPv8WT1aga4uzqEl6FXQ6sD2Zy6VtKgt7pTi54aY1zSTOjNyFDRdjZj6PimNoTgacmhRp5HQfspq01Olrwg6j6zUPfKmglpxrJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7nPB2fQ6BgSGqETF+tx8dCk/ONP+yO4Y8/3ZrJCWZM=;
 b=cd6Aazfr1Y6Flkol9A7JUtb/HAQ3EAPxq/iqcKyEP9CGy7gNEW6HKQ7Bap9GPgQWqlHcKaokddQgjn5reaerpK+MkOpmC74csgzCX6x4g7hTSEvPI0JtpUdm8tFXoavKPmAcQNWgB3pnSb9KqZVJn2kLgvYRgZvmPnFkZTY7TxE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 17:12:33 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 17:12:33 +0000
Message-ID: <c0b70897-c040-4562-8d05-08224005b938@arm.com>
Date: Fri, 9 Jan 2026 18:12:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: Ignore OU for lone task on max-cap CPU
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com
Cc: rafael@kernel.org, qyousef@layalina.io, peterz@infradead.org,
 qperret@google.com, sven@svenpeter.dev
References: <20251230093037.427141-1-christian.loehle@arm.com>
 <20251230093037.427141-2-christian.loehle@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20251230093037.427141-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB6646:EE_|AMS1EPF00000044:EE_|AM0PR08MB11257:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdc72ec-30e7-4108-af82-08de4fa26c76
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZGZ5UEJ4cVVhUTl6aERnd0VXeCtvWEFrK3EvRVhUY2FLWXpQSU9KVG1UdTQx?=
 =?utf-8?B?endVMFRrSEFJUlpHcDNUSUtFQW9VYkpDZS9xSys5ejMrRFpxZzNrc1V5MjlS?=
 =?utf-8?B?cXhtUWpiY0hjVDNDZTYyY3kydnZvNlZ6dFdUa3RzUXF1dk8yR1h1YmU1M2tt?=
 =?utf-8?B?Q1ErWG91UTZWaTB4b3d5NURNS2hoamFZSWlZbERuYjZWbWQvSE1MQjBhcXBO?=
 =?utf-8?B?aUMzTXRlK2RqK0I3eDgyWll0VU93ZmorRFlEMm5HeXZ5ZlFXaVNzWTlvUFov?=
 =?utf-8?B?VGtIRWZ2SzVJQzUxWVVwUE96ZlFwcUtMeWlCWWc1OTYraC9nN0pTZzhINkxu?=
 =?utf-8?B?ajA4VVIrWWVJSWFyVXY1Q2ppR3ZHcWhyS09SeklRSmFtK1R0VTVwVTFKamxa?=
 =?utf-8?B?WUQrdk11a0tjTDhoWjJrajhMYlgrZTBFaEJrMURMN2pKV3hCZlVnam4zVVF6?=
 =?utf-8?B?andLbnIzWVcwUklKQ0l2RFFjUUFOT1ZPNWV0aXlMUG92RWVvQ2E5YzJjb2Fi?=
 =?utf-8?B?Q0VMNm54NXZSeDAvNDZLekxMRmNuNTFnYXlTLzhtcklIWmlKc1JOWldFR1Jl?=
 =?utf-8?B?N0NCc3Vtc2JSbHFzU0RBTEpkdVBKa2hxODhnbFJLTnl5NFR5OGVLL0hsSDBC?=
 =?utf-8?B?SWFib2h1czdPdXJOUktaN3FWMHVnSndpOUo5RmJyQTMvUUxpQnZ0U0ZIVlBP?=
 =?utf-8?B?bWQ2T2JRbmRIUVZFYXF3UTJ2clZIOXY0cWxnQVhiTkozR1BkZXB4Wnp3eUI2?=
 =?utf-8?B?d0MycWVmS1o1ODFjVkVSZVUxM3UrRnVJSjdaTkFXbGNNYXpqQzBybVJ2cHI5?=
 =?utf-8?B?TVVHK1pnTU9Fb05ubi9WdmZCN1RzeHZjM3Y0ZzlkVmQwSzZZUFEzQzJEYnFX?=
 =?utf-8?B?QkpROWtLNlBaNWQxYXB6N2F2QjhnVW9uUW56NGswN3BGclpMbzlrSUVRcFlY?=
 =?utf-8?B?SmRTVURYRE9ENGZlejJIcUZlbWFNbTd4SkIzN3FXaktjcDVUUXR5MzRtbWly?=
 =?utf-8?B?VDZkTWg0SmxQTk83Qy8ydCtIcGpZTmMxV2pNYktFaC9uUzZONnBxdTh6RzdN?=
 =?utf-8?B?OTBMbFFDYTU4VXY4cWp3SEUxanpEbDcrZC9GRDJ5cGFabWFGazd1ckdsM2ZX?=
 =?utf-8?B?ZUlJYWZ6YTZLUGpoTnJQemxlUmVvRnI2RDhhVUFZdTZreWhLOFp0NEt2QTE3?=
 =?utf-8?B?UGJrbk9lTlM5YWtWaUNQalJVQStjd0U4bDFMTEh2bW0rTGNPVXJHRXBRYWpD?=
 =?utf-8?B?dUNBbklsSnR2WEQ0a2RqMDlGbUVxcHIydzdBeWhndCtEcEF4MEZKM09YdkpX?=
 =?utf-8?B?OGJBdGNYUG53OFZHelRvOXJ6WXNveEloRFJPbjJPTVpqUEJWWFNFa3JWUlRi?=
 =?utf-8?B?TGF4cHVkSGNiVmNya1M2Tys3WEVydXN1TTZuT3M4d2ZFM0pWUzZzblZRbDRh?=
 =?utf-8?B?clBkR1hGdjlwcm5XbXhnRHN4QXVOV0FwY2F2TjViSzBtbTNxTjc2b2YvT052?=
 =?utf-8?B?OTFPZ1RoZGpqU2gwVm4zZVdZN09NdS9BTkpyYXQ0NlBrajdoU1VPdGxTWDRt?=
 =?utf-8?B?TXp2bVBIY0w0ZWkvQkNPNVV4L0NHL1NCQW1reDdWK1RSUU5jL0N5TitieVRs?=
 =?utf-8?B?VDd4MWU1bUhaTGcvZE5FNGFXMy9vME15Um45Zm5NNmMyelFtdm1hdExyNkt0?=
 =?utf-8?B?ZXorTFNhRThDbUxBRE9ZcVFxbm1WOU1Bc1FyM0hYbHhQN1B2ZEh6cVRLMzhD?=
 =?utf-8?B?UThuQVdXU0grMGI0anB4MmJNUm53ZWdJRUV5ZnRqMWxFR2RSTUowc0twUlo2?=
 =?utf-8?B?Zjk4OHZ3UFlQcVVRVUtwT3NOaSsvdEQ1V0F4TUozemwzZGY5Y2JEbDhqZ2Zx?=
 =?utf-8?B?NHc1enNYd1BsZzFOQm1Ybk1iN2UyOEVwYTFEK0JkY0E2US9IN3Ezd0Q0cTNE?=
 =?utf-8?Q?U4NNtj0yUsDkcaYts6dsUlUiOAcNqV1D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6646
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96985dd0-dad6-4e31-d0d7-08de4fa2477b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|14060799003|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJuMEN4RHliTWdqV0twSE5LTVV0RlpWNE9WdXdsbmlXemhRWGFxdjhSVGRa?=
 =?utf-8?B?WTQ5VDVPc0hsQXA1aFg1WWZFZmxMYUEyMXM0UmpSRXdMSWdiMHlxNkNzclF3?=
 =?utf-8?B?MnJGbTJLcDRaT2JQMjRVQU9YYVQyYngrOFZIVmMyT3JLQThkWFVVamFTMDZR?=
 =?utf-8?B?M0NQWjdUR2VUanlNcDJQbFRFSTExQkJXdUhZOEFhejF1YjZ5QVNLZk5zalhU?=
 =?utf-8?B?WEVPT3hvYlF1QVZlRmpybk14cGFZcDl2MjFSdS9sSjY0OEhGQUxBengvejhu?=
 =?utf-8?B?d2J1SG1LNm1iRXFxcno1TWk0VXdZb0d6WDF1K0xhWmI3bk9vV2o4djVJR1JE?=
 =?utf-8?B?Y0JiRlh0Uk1kSlpYeURmVGVwdXduejFPc1BhMWlhTHd6L1VncmVvU1krOG5D?=
 =?utf-8?B?Q25Jc1V1L05qek1PaW9Db0NnRDd3MThBNnpxMHRUNEErNFlXRjRjWFU4U0U1?=
 =?utf-8?B?aW1JcXpyK1dYWmNaMEtobkExQjZHa3NkNzVmbzgxcEtPWlkyNHFSOTFUK3FN?=
 =?utf-8?B?R3ZXVk5ucmtlRm1kOXIyZ29XdlhyREJRcXFGTFM3UTBBQ2xsMnIwbzZ2cVdp?=
 =?utf-8?B?Vi9UZVJtL041MlZ6SWZ2L2Y5N2xPRU1mbWNDNHZaUVovQkRNZmVtVWo1eFMz?=
 =?utf-8?B?N0hlZTQvL1JVYUJCZzZDODAzcURIZVNnemVvQlIvYTVpeWdZWVVrSkJ5YWg0?=
 =?utf-8?B?Y3B1UXB4NEVTbjhTaGY4MWpGemRIbXRQcVR4WmwxY0R5cTVacmN6aWl2WktN?=
 =?utf-8?B?RE9vQ3NtcWtLNnZjOHE1YmRBbUNWRXdoTUw4RldrZWY3ZXk3eVVyczVzQjg2?=
 =?utf-8?B?R0dsODhoYlk0TmRsMEZCWnArekZ4Y2JCYVhTZWRkNEphN1ZCRUtvKzd2bk1K?=
 =?utf-8?B?Vld2VXFzQnFvcE0rTUhDQTVLUFNQNjBwWnNBR3N6U3JGSzJ4TnhLSFFSL0gy?=
 =?utf-8?B?NmRtZmQ2aEw4elVVSlhFVnlTWjU3RXkydlY3YThmY3o5VlNxakxqUkpqUHkx?=
 =?utf-8?B?S3lSZHJUN2pLUEkyMEVjUi85bGs0Z21kK2VyTXVKbk1jejhYL2ZrMElVdXJZ?=
 =?utf-8?B?U2M0b0JNcHVCMnJkb3F5U0hseDNUL3VaNGp3R1o5SjUxN3VOSWdtYWRqZm5S?=
 =?utf-8?B?UDhIMWhVdkpJQWlUSzgzenhIbWJjMHJVN0JVTzNYeWF5NFFwWldyUVhRaE5B?=
 =?utf-8?B?TzZjNmtNL1AyQ3JmMGUxb05HRjc2REtndStucm9uRG5nRktublV0Mm5FUFJK?=
 =?utf-8?B?eXZvMUtzdUFadkpHVXVNT0QyUThQK293MFlZY0lJSXhqT2hlakVMNTZvdzZV?=
 =?utf-8?B?YVVuN2ZUVlUxem12dWgxajd3SXlxb3NWY3ZZUExTVzNuNUVUNm1RNnVkT09F?=
 =?utf-8?B?TytrU1Z3YkYyNEdpTnMybjJENEdRRXNod3lrYS92Z00wTDB6K0JVbnFJSzlE?=
 =?utf-8?B?emQ2ZUZqWEJwSngra3R4K0pyMjNkSlIwZTBBTnV0TUpaTERNcWpQS0dpWXhF?=
 =?utf-8?B?dTA0aVZxZ0ExVDJMNkVRV1ZvZWZsZnBLNytYZDUzODE0OHZNaElHc3ZmeWQ2?=
 =?utf-8?B?MXZPYXJsbW9Pb3loQUpwQ3dGOHhPbllsci9ZQ1JKNFZZZDRRaCtaSUVjeWJ6?=
 =?utf-8?B?ampCVGdtbTdNTUZlMGcwMmFlelJ6TWtaL3YzMDlYTU9zWVJKM3N2SDRuaFdB?=
 =?utf-8?B?TzZqQk00VUd6SEJwejFEYTU1aS9LL1djSEY1Q0h0eU1FVm1aMjFCQ0JmQ0pS?=
 =?utf-8?B?VGFqeWNNenBjMFE0RDZaSHdtejFHU1F3ZjB1WFBVZzhhT2VYcXZxZFJXMzRU?=
 =?utf-8?B?QkZZWmJBYSttKzNpcGpSeEI3ODJxdDBLRGVQUW5FNEpqRHhyc2VQbVVlbGd4?=
 =?utf-8?B?MkRhTDBuekkyVTc2ZTJ3RjlCWURCZW9DaEFCREhSZWdlRWF4cGJlajJxU1ZK?=
 =?utf-8?B?ZXZDTlpIQ0Z2aDhBZnUraHIweDVFcEptV05SeWtaanJaRGpWLzFtdTRLeHBR?=
 =?utf-8?B?dGVHTVNnT1QyRDhRMTREbkQ5UXpFazdKK3VSR2lhU0JaL1JzWVoyMEJXeENP?=
 =?utf-8?B?QnU4N2Z0VUVNditLdzBxQmhQZmxsd1piS2p3ajRxdkI5MzdEUVVzaHVia2pW?=
 =?utf-8?Q?SokI=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(14060799003)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 17:13:35.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdc72ec-30e7-4108-af82-08de4fa26c76
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11257

Hello Christian,

On 12/30/25 10:30, Christian Loehle wrote:
> Tasks that have an utilization high enough to trigger misfit or

NIT: an -> a

also I don't think it's possible to be misfit on a big CPU

> overutilized on a max-cap CPU don't have any better CPU to be placed
> on, as long as this CPU isn't under significant thermal or system
> pressure. There's no reason to let it trigger the global
> overutilized state then.
> Treat maximum capacity CPUs with just a single task as !overutilized
> to let EAS decide placements on the remaining tasks and CPUs, it will
> already avoid placing additional tasks on these CPUs as they don't have
> any spare capacity.
>
> Overutilized state is global to 1) ensure maximum throughput and 2)
> prevent running find_energy_efficient_cpu() with unreliable PELT values
> when compute capacity isn't provided to tasks.
> 1) remains trivially true as for CAS the same 1024-capacity CPU would
> have been a correct choice for a lone task, too.
> 2) is guaranteed by limiting it to nr_running <= 1, the task itself
> then has accurate PELT values as maximum compute capacity can be provided
> (also ensured by subtracting system and thermal pressure from the CPU).
> EAS will naturally not place additional tasks on the CPU as
> find_energy_efficient_cpu() requires the task's utilization to fit onto
> the spare-cap (util_fits_cpu()), of which there is none in the scenario
> we are concerned with.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   kernel/sched/fair.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da46c3164537..d885b2a0fcd3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6790,6 +6790,12 @@ static inline bool cpu_overutilized(int cpu)
>   	if (!sched_energy_enabled())
>   		return false;
>   
> +	/* Single task on max-cap CPU isn't misfit so no reason to trigger OU */
> +	if (arch_scale_cpu_capacity(cpu) == SCHED_CAPACITY_SCALE &&
> +	    cpu_rq(cpu)->nr_running <= 1 &&
> +	    !capacity_greater(SCHED_CAPACITY_SCALE, capacity_of(cpu)))
> +		return false;
> +

(Just to discuss)
1.
capacity_of() takes into account the cpufreq pressure through
get_actual_cpu_capacity(). This means that on a platform with boost
frequencies (or where the max freq. is lower than the max),
the overutilized state will be triggered.
So enabling boosting will actually lead to better energy placement.

IMO this is the right thing to do as there might be multiple
clusters of big CPUs and some of them might be capped while other not.

Sorting the different cases seems complicated, so your solution might
be the simplest/best.

2.
Tasks have a p->max_allowed_capacity property. But similarly as for 1.,
the cpufreq pressure is not taken into account, so it is not possible
to use it.

3.
UCLAMP_MAX tasks already don't trigger the OU state.
UCLAMP_MIN tasks don't trigger it (if we are only looking at the
UCLAMP_MIN property, not the actual task utilization).
So the UCLAMP_* cases should be ok aswell.

------

So in the end I think it would be nice to have your patch.



