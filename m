Return-Path: <linux-pm+bounces-38966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A3C9774A
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 14:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D9F3A14C1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04C30DD00;
	Mon,  1 Dec 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gaVSkTsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012049.outbound.protection.outlook.com [40.107.75.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C102EFD88;
	Mon,  1 Dec 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593780; cv=fail; b=YChdGlfirspMjkh292i1zO/daeqYwNCqOWA8ItIxxbR2IaLgg0fGhtAgxaurpLflZKq6LA18AkxttE8NpkxsoDL746ojvmN9Tuwz/Ariaj5TTYplZdtFRIrhebNoeNwl7xjN5c2SF11zIeXbFiiXHitHc8n6AyVQmOLUHaBJEi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593780; c=relaxed/simple;
	bh=b/NJqw3EMcySXusf2sdQx8gYqNiYnTnVYT1Th4PsxgE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nk4zrZqko/WIjQ8+JFcxaetz1W2+r4a0K8V4DtGzekCJL+SE/ok8BdSCFbXMHh8IBB2RT9fJb7enozMXDctoGCCN3tCiFcPx9zDYidlIILbwpV7+qX8pgJ5apE7FYVmIJbtwBjjawPEfRt8eLlMB1hOTAtG4HYTLVNrUg4XO60I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gaVSkTsO; arc=fail smtp.client-ip=40.107.75.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7YOsEbvfKvEpaL3OYqskBimvW0UiBzxNiz+0SOzgFVTmYEfz9r23wa98wx8MgqgrMxSxiQQKzmnw7CoHuz9QMz8Pxb3emXSIe2JSopDyG48lykK6a+AhclfRBBJG/D/DBmP2pN6ESAG7RuocYTx7RIosaUrseV2ngiDcN+kLbKMU9MJ9pKFfrFGGyOUyDceAQukL35NE9bfB5VSh7l/ylJxm7s0+FG46KgNBZaKjwojpDEJpsjUPEP/VSvvBbTUyL1BRDgeAIK1vw0mQfQu/hHhB5CEUsI/QqahkBJpPxibuIniIUkeo/o9wVDHd2WJxpXs05niLVnLHbtHsS2OcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMCMqQbT4/h/c1ymO0l3gr7E1qHFD1HMYvIIt4MeL8k=;
 b=Y6fnu/ldUPqa3QeZYtRJ6/YhbIrn33mnWoUOF57/8N4uamTh35IeqCM1XTQ3980J0hutOyuuZ8LebqgBdPLsS4D4x2DU2VVJ7nW7Z5bkjRM7w4SO8LtPGj5Gd3uU/0beMQYvWMZffe5aqud2+5QoXyfgh+d/vuvQSkIOK19P0yd2HbasXAoc0RNJY0TSQAbRb938GQ6RMMdhL4poBBvSfDRPhm3iCZuTmpVRp5UJmNN4FPjRFgAT0Im5C4+NHye0pyuH9d2+o2tq3jUO6FLiC03xMECFrwkKANVMX1x26Cy/rk1AvelRCwtjUgNbFIhvLf4UUY+YB1c7NpxS/BSVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMCMqQbT4/h/c1ymO0l3gr7E1qHFD1HMYvIIt4MeL8k=;
 b=gaVSkTsO+++/kS8MYgP6riAq9FfDMFduka/wuYKxnz6EaTrBC3zDRzIBHE05kQz8LOwGhB8X6nhsfZphZfpAuOWHOUf5iTgrxTpoj9OfHqEmodBMfuO6QxsPlGjrVZBydcWsvMKjfD3XWorGo0DVuEEFuWAaqIPdgoGyRuNGpz9dzABIU175W+qNWSPEAjND9Imowh8neWq8fV48v4ZkVWKUdBefk3fPJpvyHXxbFALNqKEIzGiAoLFzD1BmcS3EuZ7PBfOSHipCdNiLfzkBvQ2OjKx7QDsSFFFaiCv42m8tKJ2mppIaPKYsWP9nUY7v6mpo+iups4FlqYtkFOnvPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYZPR06MB6307.apcprd06.prod.outlook.com (2603:1096:400:41b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 12:56:10 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 12:56:10 +0000
Message-ID: <8fa4023f-50f2-4e25-9f9b-4e5236015e27@vivo.com>
Date: Mon, 1 Dec 2025 20:56:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
Content-Language: en-US
From: YangYang <yang.yang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki>
 <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
 <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
 <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
In-Reply-To: <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYZPR06MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: bc815c91-2ccc-41c6-20a0-08de30d90063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlJaTytJb1k2MFdpWHBYUHQzb2hxb2I3Y0o1bFUvYVVlT2xXUUZ1TnpMVEJp?=
 =?utf-8?B?ZTNKUHhQdTRnNnV4YjE0ekJQaTh1MUdUL3NQMHlpTE56YWtoY2piek4rMVgz?=
 =?utf-8?B?VnlGRkVyZ1dJcGZXOXFwcjRmRi9mdXlJaGZUTjk0bVBaUk9rNDRXVjFmSnB3?=
 =?utf-8?B?elBiZ0QxSXFEVmdxdkttUlpHNm9HTFE1NlR3aEJIdkoxV0ZsQUV1M2N4b1BD?=
 =?utf-8?B?aVhOZ282azI2U0paeWhRZVI2Sm5GMGtuS2JCZ0dLaWE0OTdYQW5IRWxlSytj?=
 =?utf-8?B?YVZsWTZkWENaMDVmaFU3L0dPMmJwOTJEN2YvQ2dSUUtFaVhwZERIWVZNWlVZ?=
 =?utf-8?B?cFNYa2hWMjhGaVdlQnhHN1NzQWRzOXBuRUlpQnZZQzVKNnMrUFE0NDREOVFj?=
 =?utf-8?B?TW5CTUF5K09pR3pwTHVBbkhDK0U4eWZVWStsKzlrenNqaFZWREZQUXpkcEo4?=
 =?utf-8?B?RVloYmdycXRDMmpPQzhSUGVscy9hNUpTcFNLMVdkMWN6V3RQbUgzT1haUC8w?=
 =?utf-8?B?UmFkV0pMZXM5cGkrUVVPRUtEVlp5aWF1VmpHY1hoOG5kQUQ4eGtOS25UUHV1?=
 =?utf-8?B?ODVMY2YyVVJST2Fyb0FZc3VYL2hZdjVFY08xRFJIaVozRXdVK3RzT25hbTVZ?=
 =?utf-8?B?SHRGNkhDNHRLTXUzQnN4TnV0RjB6d1d6cEdkcGFlWnd6aTdSenlJakJhVGJn?=
 =?utf-8?B?a1dkckdxNk5wU01YY09XMFVlRlN3QU04UmhQb0grZGJBSFFTOHFsUndhTVg4?=
 =?utf-8?B?ZXFsTGtSMXFkS3VrcnVhWFVtcXl2M05sWjUrS2dCUzlpeGV5Q0NIUEI5ZTNn?=
 =?utf-8?B?TVJwVGNqOEdWTnpxcUNvNUZLZ25qNHNLUlBsOC9WZTg2SzMxYjVkNEV6eXFO?=
 =?utf-8?B?VmN1MXNIeFBnVG13L2pqWkEwakRiRnl6VXpkWGxpVUpOWEUyUUpZdnRoTzZH?=
 =?utf-8?B?eVJ5L2EvRWhGOW04SzdzTElqVWRNL2M1QWtGeEsrcTZLWHNmNWIvd1Mxb3lY?=
 =?utf-8?B?My81a1BxYjk2Ry9ZQVVhNnBJT21EMWR3aGRaRlU1R0ZUNEl1NDRRZUVXZFU5?=
 =?utf-8?B?Vit3dE1aU1E0OWRkRklnbFhwVERIdERRL3BVTU1OYTFmcUpabkRSVDl6WjJH?=
 =?utf-8?B?TEpkN2wwQXBQaHJXTDIrYlpSQ3hoQ0UyN1lxZmtiZXJiOHJnUFQ2RGdJVGRG?=
 =?utf-8?B?NkNUQlBSMllXRUZuN2lzWGRSRE9JNXZBbTdlSDd2bWJGOXVRamNRZXArdU9D?=
 =?utf-8?B?Y0hoczEyTlFtd1EwRHRHMEtvVWZZWit3Q0NUWUw1WU1adTlVSUc4WEhJUWtD?=
 =?utf-8?B?M3I2L2gvRzlEUnJESFBjUjlVaFcreTZxNjc5UXRLaGxSNkZtclVxZWZ0dGFZ?=
 =?utf-8?B?NituUDkrbHk2L3JRVjBGYS9HLzJXNjdaRWRNQmMzTC9NWHg1QjBxQ2xXT1Zv?=
 =?utf-8?B?OURISEcrV3ZEVWhSS3RXRDVOVnRvcDNaaVppaUE4Zm9ERWVJdDJnZ05IYVAv?=
 =?utf-8?B?Tk1lMjF2ZlZ3Q3FzaUJzSzJQMFZnS1BSSVZ3clJxZW1XeHBCaTVldG1yRTdJ?=
 =?utf-8?B?TkFEYytQUmxEdTJLWmg3SkFjbXZLOHVRNU9CaFd5STk5NjdKYUllYW5pQW9k?=
 =?utf-8?B?b3Z3YUJjY2tNc0IxcWhWTnVOa0RxdVlxU3B3cm42UUJZNzc1Z2VLeTVVMW9h?=
 =?utf-8?B?NjBXM2U0N3d3dy9KTjVKWHl1emltU1VTV2IxOE42SU01QVZTamhGVDZpTTJG?=
 =?utf-8?B?M3A3bXU0M2N5Z0gva3pHaXJLZGY1YmkyUTI1aWYzZ1lFV2ZjVGxMRDcyOUNN?=
 =?utf-8?B?QkFNeHVwbU9JRnduSzhkVnYzN2R2NDNZNFhUZVkrTVVXN292aUs4SFFaR3lZ?=
 =?utf-8?B?S0xSM1RiUlFzTFdPUi9hdmVFVExodjBCQW9Kdmd2TEQ1b2loQjZwYWZPMSs4?=
 =?utf-8?Q?IEhANSsosOmaqGIQvK3dacwmtcl6JNK+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVV3S1RDTVRwQUFVbnp5VFJTZjVzRUpSRXlFYU56Q1Y5YlhWZGNGdFhXbndI?=
 =?utf-8?B?N0ZzQWtiQWZXSG5aanRwNWw1NnRkbDltam9XR2p2Q252OVh4ZlZWNkx6bHp6?=
 =?utf-8?B?aW5vRFN2SzBYTVZJSytjNnBYZksxZmlVRUVMTEs1Wm00NW9JdEEwVE1yTDRl?=
 =?utf-8?B?Wk5zbWJweWV1aFlmcEpIeGMrVnp0M3hWbGtzaGJ4N1R6a0cxZzUzaXU2bC9S?=
 =?utf-8?B?YWJMWXpCNFk0THJzY3NvVUJDenpWeWFYcTVna1BMTVdNUmJqUm1HRzZNVnVF?=
 =?utf-8?B?dkN1OURYN2FRRERLS1o3T2dtdm1DZHVqbTRrYmx5TGU2djN2UnRrSnROcGI2?=
 =?utf-8?B?NlBoUkt2N0NnVlVCbzhzOEdlQ3pNcXVjT3hyekpEa3QyK2FIVytQWWlGRU5E?=
 =?utf-8?B?NU9qT0d5RHl1M0VHUVNna0FzODJ2R21kSVhhQU9RQXcxRGhiSk56NFRnOFJa?=
 =?utf-8?B?d0lsTG85SktHY3dtK2N6WVFJekJnNVV1V1VFK0NmOHJKeXFrWGQxVzM5OWVP?=
 =?utf-8?B?NytRZmdNMXExYllKQXhwOVZ4ZFFrTGxMZlFUUlByY1ExK04yZm10Q0ZMbmdi?=
 =?utf-8?B?YmlFUnAyanBzNmRMTmljL25WMmR4c1R1VHUydDVVTmhPYkxIOWhQcGFYR0lt?=
 =?utf-8?B?b2FYQUxRLzVib0prZEQ5ZUtJaWFIeE83STRFQ3pNWllKcGZrWjZHYWZONW5q?=
 =?utf-8?B?TzZrQ1EySDhUWjI1S0pNVndnSDk2ei8rMmxjMVNwbGx1TjJEbFI4SjhUZmJs?=
 =?utf-8?B?UFZKMTZQR0RCUUYwMVJoMHdoM25Ed3V3UXZCZU43dzVPeUkwVG1XeTIxYVh2?=
 =?utf-8?B?K0gybGNHa096a2lxYjg1c2w3MmwyS0l0dW1jUDVLSzdac2xueDZGeGJKL096?=
 =?utf-8?B?RUFRT2ZSKzZQTW5vMlNtRFFFU0lKc2w2VEFqU1RXejRuNlhxMVpPenplNHVX?=
 =?utf-8?B?M3VMRUM1NTRZZmV5WFU2aWZQSExHbCtYVGpiOWJlWlRBcjJ4U2VXS3VaRU9X?=
 =?utf-8?B?c0VJTjMrWVV0Z0k0K3dYNkxXb0tHa2dRbXJMNzcxM2V6RU9mMXVwU2NYcEho?=
 =?utf-8?B?WHcyM2RxVWt1NEZRL0hsY2lXSkR5T01mNTJOdHlwUFd6Nk10dmFVREhxc3Ri?=
 =?utf-8?B?T3VOVzEwNGRhMWhOVi9jajNIKzdxMk1vZ09KOUtrN2JxWi9YbVdXcm5UTWQ1?=
 =?utf-8?B?dlQ0VzAvU04zR2RPMUMvY01hNVZpL0Q1WjhSTUdITzlMTGxydG5wbHEzTGpI?=
 =?utf-8?B?YXpiYi9yNlRZZEJFNndNMmk1ZnZhVk9sN2o1bDdUOEhDRUVpbGJOTU81czBo?=
 =?utf-8?B?a3UrUjg4QmRzbEdtZngvcUxkNFhOc3FMZ0d4ZjVSalZhNHMwMStTc0lrSXhh?=
 =?utf-8?B?Z25rcC9FSEExNUlLUnJzZmsxZ2JGaWZDQ3BiZ1dDbTlaTlJ1VVFUVEJ2OWha?=
 =?utf-8?B?cXRiYU9yUXVKZ1RJOGdiaG1uOFRUaGxQT0NuWEtFQ25LODkwMDVYTzlaNFFr?=
 =?utf-8?B?eHZpNUx1M1h1S2RpQkI4RzBGbWdoQS8wakF5Q1RGWkFyZ21vMzc0K1dTM2V5?=
 =?utf-8?B?UlpjdkRpRlJ2Y3pLUUpqT2FrMVVxbmVWK2I5YkZwQURqUnRldmVuY0cvcDlD?=
 =?utf-8?B?eHYwUVArMXI1cUh1bXJqNmQyWERjR3oxZjZzQTBxODd1V2hRM2NFVng3QjZw?=
 =?utf-8?B?Z1QxUjFWeFBGbHZMbDhUY0QyRFBTTlhwc0c0K2xWSGlINUdkNTdjRVhUUGRE?=
 =?utf-8?B?YlBEUEZzK3VPS3lqVmxTTCtHaEl5Q1FWaDNSVUt1citpN1UxNGhHMU0xVGdj?=
 =?utf-8?B?RlNlYktjZTZHaXhRZTVSVmNZbExkYXBTaGgxdVhJQlVhZnBnWGpqcGZjWEtv?=
 =?utf-8?B?TjM0NlVBNk1QdjZsT2lDdXpQTnE2cVNORXI3VHgvbmhuK3psaStBQTlMTmNP?=
 =?utf-8?B?VjJsalIyd1hnYUtnRFA3K2pkS1dSQ0NHRytsS1FuRjIxeG9helFZUlY4ZFNj?=
 =?utf-8?B?YUZvVlF2ajhjeDdnNlBxalNtWHllQ3drdFJNOFF3eFA4OEZXSzV4Y21SZ3RR?=
 =?utf-8?B?MEJnQ0ZyeThwUHdlbUFESVRueERhZklkbkRiUmhzZ3RWM1l1QzIxRnh1cjlT?=
 =?utf-8?Q?TrrY0NtruGsctzyiSndMFJXOh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc815c91-2ccc-41c6-20a0-08de30d90063
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 12:56:10.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOmW2oPq0L3gfp5jJklX1/CBOX6K3XuIrrd9sNgS6SQ6iZMx2vVQVhzZuvCsqd1HOn5+HrEczfV86UkTig1b+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6307

On 2025/12/1 17:46, YangYang wrote:
> On 2025/11/27 20:34, Rafael J. Wysocki wrote:
>> On Wed, Nov 26, 2025 at 11:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>>
>>> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
>>>> On Wed, Nov 26, 2025 at 10:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>>
>>>>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
>>>>>> --- a/block/blk-core.c
>>>>>> +++ b/block/blk-core.c
>>>>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
>>>>>>                 if (flags & BLK_MQ_REQ_NOWAIT)
>>>>>>                         return -EAGAIN;
>>>>>>
>>>>>> +             /* if necessary, resume .dev (assume success). */
>>>>>> +             blk_pm_resume_queue(pm, q);
>>>>>>                 /*
>>>>>>                  * read pair of barrier in blk_freeze_queue_start(), we need to
>>>>>>                  * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
>>>>>
>>>>> blk_queue_enter() may be called from the suspend path so I don't think
>>>>> that the above change will work.
>>>>
>>>> Why would the existing code work then?
>>>
>>> The existing code works reliably on a very large number of devices.
>>
>> Well, except that it doesn't work during system suspend and
>> hibernation when the PM workqueue is frozen.  I think that we agree
>> here.
>>
>> This needs to be addressed because it may very well cause system
>> suspend to deadlock.
>>
>> There are two possible ways to address it I can think of:
>>
>> 1. Changing blk_pm_resume_queue() and its users to carry out a
>> synchronous resume of q->dev instead of calling pm_request_resume()
>> and (effectively) waiting for the queued-up runtime resume of q->dev
>> to take effect.
>>
>> This would be my preferred option, but at this point I'm not sure if
>> it's viable.
>>
> 
> After __pm_runtime_disable() is called from device_suspend_late(), dev->power.disable_depth is set, preventing 
> rpm_resume() from making progress until the system resume completes, regardless of whether rpm_resume() is invoked 
> synchronously or asynchronously.
> Performing a synchronous resume of q->dev seems to have a similar effect to removing the following code block from 
> __pm_runtime_barrier(), which is invoked by __pm_runtime_disable():
> 
> 1428     if (dev->power.request_pending) {
> 1429         dev->power.request = RPM_REQ_NONE;
> 1430         spin_unlock_irq(&dev->power.lock);
> 1431
> 1432         cancel_work_sync(&dev->power.work);
> 1433
> 1434         spin_lock_irq(&dev->power.lock);
> 1435         dev->power.request_pending = false;
> 1436     }
> 

Since both synchronous and asynchronous resumes face similar issues,
it may be sufficient to keep using the asynchronous resume path as long as
pending work items are not canceled while the PM workqueue is frozen.
This allows the pending work to proceed normally once the PM workqueue
is unfrozen.

---
  drivers/base/power/main.c    |  2 +-
  drivers/base/power/runtime.c | 17 +++++++++++------
  include/linux/pm_runtime.h   |  6 +++---
  3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1de1cd72b616..d5c3d7a6777e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1635,7 +1635,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
  	 * Disable runtime PM for the device without checking if there is a
  	 * pending resume request for it.
  	 */
-	__pm_runtime_disable(dev, false);
+	__pm_runtime_disable(dev, false, true);

  	if (dev->power.syscore)
  		goto Skip;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1b11a3cd4acc..ff3fdfba2dc8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1421,11 +1421,16 @@ EXPORT_SYMBOL_GPL(__pm_runtime_set_status);
   *
   * Should be called under dev->power.lock with interrupts disabled.
   */
-static void __pm_runtime_barrier(struct device *dev)
+static void __pm_runtime_barrier(struct device *dev, bool frozen)
  {
  	pm_runtime_deactivate_timer(dev);

-	if (dev->power.request_pending) {
+	/*
+	 * If the PM workqueue has already been frozen, the following
+	 * operations are unnecessary. This allows any pending work to
+	 * continue execution once the PM workqueue is unfrozen.
+	 */
+	if (!frozen && dev->power.request_pending) {
  		dev->power.request = RPM_REQ_NONE;
  		spin_unlock_irq(&dev->power.lock);

@@ -1485,7 +1490,7 @@ int pm_runtime_barrier(struct device *dev)
  		retval = 1;
  	}

-	__pm_runtime_barrier(dev);
+	__pm_runtime_barrier(dev, false);

  	spin_unlock_irq(&dev->power.lock);
  	pm_runtime_put_noidle(dev);
@@ -1519,7 +1524,7 @@ void pm_runtime_unblock(struct device *dev)
  	spin_unlock_irq(&dev->power.lock);
  }

-void __pm_runtime_disable(struct device *dev, bool check_resume)
+void __pm_runtime_disable(struct device *dev, bool check_resume, bool frozen)
  {
  	spin_lock_irq(&dev->power.lock);

@@ -1550,7 +1555,7 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
  	update_pm_runtime_accounting(dev);

  	if (!dev->power.disable_depth++) {
-		__pm_runtime_barrier(dev);
+		__pm_runtime_barrier(dev, frozen);
  		dev->power.last_status = dev->power.runtime_status;
  	}

@@ -1893,7 +1898,7 @@ void pm_runtime_reinit(struct device *dev)
   */
  void pm_runtime_remove(struct device *dev)
  {
-	__pm_runtime_disable(dev, false);
+	__pm_runtime_disable(dev, false, false);
  	pm_runtime_reinit(dev);
  }

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 0b436e15f4cd..102060a9ebc7 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -80,7 +80,7 @@ extern int pm_runtime_barrier(struct device *dev);
  extern bool pm_runtime_block_if_disabled(struct device *dev);
  extern void pm_runtime_unblock(struct device *dev);
  extern void pm_runtime_enable(struct device *dev);
-extern void __pm_runtime_disable(struct device *dev, bool check_resume);
+extern void __pm_runtime_disable(struct device *dev, bool check_resume, bool frozen);
  extern void pm_runtime_allow(struct device *dev);
  extern void pm_runtime_forbid(struct device *dev);
  extern void pm_runtime_no_callbacks(struct device *dev);
@@ -288,7 +288,7 @@ static inline int pm_runtime_barrier(struct device *dev) { return 0; }
  static inline bool pm_runtime_block_if_disabled(struct device *dev) { return true; }
  static inline void pm_runtime_unblock(struct device *dev) {}
  static inline void pm_runtime_enable(struct device *dev) {}
-static inline void __pm_runtime_disable(struct device *dev, bool c) {}
+static inline void __pm_runtime_disable(struct device *dev, bool c, bool f) {}
  static inline bool pm_runtime_blocked(struct device *dev) { return true; }
  static inline void pm_runtime_allow(struct device *dev) {}
  static inline void pm_runtime_forbid(struct device *dev) {}
@@ -775,7 +775,7 @@ static inline int pm_runtime_set_suspended(struct device *dev)
   */
  static inline void pm_runtime_disable(struct device *dev)
  {
-	__pm_runtime_disable(dev, true);
+	__pm_runtime_disable(dev, true, false);
  }

  /**
-- 


