Return-Path: <linux-pm+bounces-19317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CD9F34B6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EA018816B4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB5153BC1;
	Mon, 16 Dec 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ti6mH7IV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FA149C57;
	Mon, 16 Dec 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363593; cv=fail; b=Ovl2IRuPS81A7sRcu5ws3CrijD9Z//YIhVPuEAQCCSc3PfTuPdWVTuxzwDizL0T+8/AtjyHmv6USpaJ84X2Uk5tT+8kmYQcz7ZFOv10PGPyDGWcF7jaLh7Sb99vPVLTuW5rq/szMJ/4H529zwXr4bQPSnEK+Lbo0+NFsy9p4JHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363593; c=relaxed/simple;
	bh=syV5oiYq4AOllMf55aiUZLUmIBttiwmk7IRwkhG91I0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ku9TfVquTzA0DwyKGCIbX7iNCCGxZV6DqJH28XBP3ggZZYj334OIu3MMNjZ3krL2aAi0fgrnMr8g6gQTMmT1SOc1iKAp3LFjFvuzy/9+auV64laEtwW80rLQqWcpDripd/O+j7zzzu4whBorKGJH01BEW/PuqTaGS+SQV9XVdlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ti6mH7IV; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQXrNvZf9sEvLV5hzjx/IDcxsZcYA0No7tzYvQ+w3gMIZg9vGOFRaKNLpvVAzVM5cm1VPvPI8COv3Q0Y2xOXQiLPKE/1FB6QBUHJ9gLAKljMJFXQeBhf8wBZccANuq59cjtZ5gTbsPFWfg1aCNo2Vo0O9SteAUTH+jMB32e5NjjW0ddY3X4SCRlmIJcOE9QjuvN4OkJW8+CXqFUSdk6ee7BxmEM+91CRogF5hKBo7mt5JaCRVPbR/G6BxEkVs+AyBc0Hexb6x1lyMT/h+S8SXVOx4rGpl/8Vdc+vPhx9WpVkfg/0gTN473Eg/r4RE5aTPL2JApxYRiyletExXGfnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4E79QG+w7NZ0gptkerPq2R50VmQqTRTBFS7XPqsHcI=;
 b=aVNP0uMf7wh+40n3SGXNecVWiKTggY1/JH+2CJuBsLYkwUTa88UtkL5cghrZNRAKMMjTimHkALeGNQH8DPqud0uvnS4YkSInIat2KyMiV6FIIQbSmHXVouS8o6iMvo13E4F//Neok8vo9oIdv+zcAXjEhiGawTXlXRZwwfSsOK7liL/eyfOyxg7WHUm+0m0OY4sYyCCm+nlLTVg1WQt97xQztyAHxCX+tKoHKAYPfYrz+pifFusezRqL7RCiq8nwvs85ajG5kfQH5GfFjMwYqwi7nSY672aChOTjw5xL6ZkfsmSG6LGwVOTCRVU1X/KlbyaA6Hj+WRTo5Ec5+NumaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4E79QG+w7NZ0gptkerPq2R50VmQqTRTBFS7XPqsHcI=;
 b=Ti6mH7IVPy9oSFqi6vBnxkdpqYWxF178M+8k13eQ/je6Jb1Hi7ftNgQP0XBkf5aJY4jnwCSLvQzjoujCtJ4epgiBxk9Fu5kvoxIBV5yv0xBQYfBRsS9UtgQZjxT0Ao6FP3QaDTtagDQ5oAW+S+/TJdmm/ZwiNKKMUT6+oFVunD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 15:39:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:39:49 +0000
Message-ID: <a8c6ff3f-2ad8-4926-9ac3-f0f39ceffa2c@amd.com>
Date: Mon, 16 Dec 2024 09:39:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
 <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
 <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 550f14e2-510c-4854-dd23-08dd1de7e02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXoyUTBsZGpCNU9lRFREVjcrUVRjVnRrSkt4VjNBTzR6a0NuNUhlMnRkY0tv?=
 =?utf-8?B?b2xnWUZKeGRrams0bWtjQks5TktidWUxazdrTGtKeXMyZlU1a2VLTmRaTmgw?=
 =?utf-8?B?L3dLQS85SGpoK3A4MFNxWGF5aWF6TmRiU1dUV2IwcWNDaDF2b2pWaXBJVWR5?=
 =?utf-8?B?eFhOenpJajhRTnYxeE90Z1Z5Z0g5dXdCZ2pkMHlrWS9XMFROVjBuSmx1MHNj?=
 =?utf-8?B?Nm51YnUzZ2hya1BhdWRsV05scy9MVktUWnRWc3lUbUZwckNCa3BYdmVPVTk3?=
 =?utf-8?B?UXFVOWpsUkNzUXRDc3hVWTUvM2VJU0FYOUxpTWxmSHVLMm9makZkYTJpRk9J?=
 =?utf-8?B?ZWFGRlpwR2tja21wNkxYS2wrZEhXNm0vNGxQSlIwOUVXN25YbUJITE1WUGxl?=
 =?utf-8?B?OHBIcVpkSWhGRW9yYkM5TVg4UEx6cndnNVVBWWdTMndFUzM2RXFhU053b2k0?=
 =?utf-8?B?Wm9lZUhVbFYybjJsemZJK3ZNVXlIWTI5NWczZjZXaHF3UnJWaTQrNGJlbnFW?=
 =?utf-8?B?SzNiZkxFd21PN01CM1owVGFCN1lEN1cwQ1lNMy9ycnRDVDNDSVgwdkc0Y3pn?=
 =?utf-8?B?aEk0N2hNOUVVY1lNY3JEQk44U1BlT0FEV3lzZjhiK2dhWlp0NzVlbjFDbE1Q?=
 =?utf-8?B?MlZqTDBwN1g1ZjUwV2diMzJSbTNSN0J4T3ZRNEwxeGNoNEcvbWUwVmVPRE1h?=
 =?utf-8?B?SC9MdUpYMzNpWGFWL3hCc1JVc0UzYzNZVElBaTZyWWxXSTJmbDFkdDFqQ1FP?=
 =?utf-8?B?MlBOVEFBMkc2ejZwcDFpN1VnWE15M3V5VWR4NEZpQUxWeXAyb2VMdk1jVXd1?=
 =?utf-8?B?RUVnS3BJV0kreFkzSEl2b2UvSWtzL3JnNnU1cjgvZm9HQ3h3ZEE5U3RvM3Y2?=
 =?utf-8?B?eStPZ0xmZitsRmhnQytVdzlDdUNaRVcxLzRIQ2JFem9YMGc0c21tTUc2WjJh?=
 =?utf-8?B?K3RUV0EyeVFIeE00aDNWVW1ZV1V6cVpGaXNHcE16NW9IbHV5cUVWWWs5eWlR?=
 =?utf-8?B?K0tDNnc2bGtwNzNqcWpFbXMrcnJjU0txQkthWWxBOGNQQkplV09ZbldIbGZS?=
 =?utf-8?B?eWNaYW9ramNvb2ZrMjVIQ2ZoazI4Y0gxUXFoWlU2RnJtMFVyUGd1Uk1IZi9E?=
 =?utf-8?B?a1VjMmhGUFlvZmtFRjBuR042SGZ4YVg1S2s0UVBkakRGNE01U1ZhYnJRZTda?=
 =?utf-8?B?Rmc2cGlsazg2eGkwQm03blh5MDVTd1h3YVBJK1dWL1J4dXIydTZiRUs0SHNz?=
 =?utf-8?B?SjVUT3hGWm56aHQxNmk4NnZBb2FoSVQxdnNxZU5BTFAxVFg0VFBVYXg3Rlps?=
 =?utf-8?B?cFNaLzNmZ250UjNKaGFkNlBrMTVQSmZMMExKUmY4VXhCOG9yN1N2ZmEvUGhC?=
 =?utf-8?B?VFY1by9Qc3YyQ3hyMXdCeTdXdExYeEwrTDdMVkYxa3lFM3VGd0VOQ2pmSmts?=
 =?utf-8?B?bUlGRTFzQUJsN2ZoK1RXcUt0aHQ2WkFTdzZ5TWF3WnhuTFEyNnJuaUhUQ2E3?=
 =?utf-8?B?MURNTkZiZElHemtzRmZpZFlxSG9UVktYdDhjT1V0eWpPMDFiVElnUVJ4ejRT?=
 =?utf-8?B?aTRobWw1NW96aU1TNXdBV3lxQVNpT2pKT3JRUjhWL1l1S3hHUXFYZUdLZ2lG?=
 =?utf-8?B?VE9iNTM0dnVoK1F4UExkbTVXdzBpWmw1Y0hFUklRQk1FcDRhYXVGZlFJWkw0?=
 =?utf-8?B?Nk5MVTIyZTI4bUNFQnVvNHIwR0dsM3kxb1RPc05hNlo2RWEyVWg4VFpqU2ZE?=
 =?utf-8?B?UVJQeFIxMC9FRjBlWlBaWnl4VWpqUCtjRlI1ei94TndsTlNIWHZkRVBYWWVh?=
 =?utf-8?B?R1dZelVFbW5xdlB1TmNSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXlYNVc5NmhtZ2cwU0NTSUlvOFkwOVBYSjgxREEzNms3U1ZTdG03Sjl3Zmoz?=
 =?utf-8?B?QWJlQ3g1NUZFaWE4SWdMWnhsaVZzS1VGdU93SDdUWnA2TFdBbHpvaFJ0cmZh?=
 =?utf-8?B?akJWZTdZUUZHT1dqK1JvenFBVUs2RGU5S1BHNHBsZmZVSzllekFVWUcxYWRq?=
 =?utf-8?B?cGhjcXFrOVc4MTU4T281WnVuUklHZEZPYkxSdHhMZkJTMzM3MlBnbEFCWnlh?=
 =?utf-8?B?OURTNGtlQVF5VTZwNWM4SlFib3FnSmJQSms0b05VQWhGV09rbWNmYU8yL2RU?=
 =?utf-8?B?RVdaMzNGbDNDUCtKbkxKWGhKMVNkM0V0aUhwU3Fyb1lxTlM0dmI4ZVZPd3ll?=
 =?utf-8?B?N2cxanZhMkJaRHNheTZob0tYT0pSTWl5SHVjUTViVHYyTzYwL2F1S05Fa3hv?=
 =?utf-8?B?Qy8wWUdiUDVmYUI5MUIxMWV6bUpoaXNSVVg1NjNSMmpCS09SMTUrcGpNQUJF?=
 =?utf-8?B?MmwxclEwZGlnalRUQkk5OURyalgwZFQrZGhHSnM3TmdWOUJJMzJEZXlHWWhI?=
 =?utf-8?B?WXFKV3p0NVk0QVNqVVZ6anBOSlhGTTY3L250VzE4alhkRDl5eU40cGJoc3Av?=
 =?utf-8?B?a1lsTnl2V0JWemNLcHV2K1JNNk5zcXpXdzFiUXkvYnlWQVdlOGFjUENGWHlN?=
 =?utf-8?B?VFZRVmxvSWRjV0ZmK0h2NnVDNmQ1Y25xdXlwNkVpT0d4cnAxNG9BU3AxWlBk?=
 =?utf-8?B?ek1EYUZoR1Y0Qk1EVWVUZzdZM1ZkU1paUzZmMWxCUWFRbVQwZGhINHVSUE9k?=
 =?utf-8?B?QUZqQkFDVnh1dVJENnB4TkVxUGhzcmxMV09Ib1lMcXR2V1h2VWlEd1IvdzdJ?=
 =?utf-8?B?clArbmhIRnc3clIyNXkyTlpBRXhoSVYyYk5WWVNRSk1XL1JtYm53Q1hmR1RO?=
 =?utf-8?B?aVE3TjNJQ3VhT1BMcVVycy9JejZmcTd4L2syYnJMSUl1bmg0RTBacFhWZ0ZD?=
 =?utf-8?B?d1RRQ1BzL1NjbDladXBuNFlPdEhCQ2M5cnc1MWEydlRzU1hUVFNUQmZ4VnVy?=
 =?utf-8?B?dVNuWFpQWFIwaExzNitvVkcwNmdneG5nbUdlTy9WbnRlcXpZdTFVOUtaRWha?=
 =?utf-8?B?RzMzQkxySGtUTG9uM2xxaUJqU044aGF0aThGVDIvM1A4dmRJZzZob3BBRmN1?=
 =?utf-8?B?RStYWkVmbVhpMzdMTnppM3NKM3daUVNzeGl3cjlDYkJLQ3kyQlVoT2l4TGhy?=
 =?utf-8?B?bzhKWnd3OElGSldnYi9QWS9JVjIzdS8xZW5kcE1QNVB3d3lhaE4yb2lTbGp4?=
 =?utf-8?B?a3pPRWh1bU5KWFFHZjMrb1JwVm52alV3OW56N1hETi9FeWliT2JvVTVteE4r?=
 =?utf-8?B?Z1d3NW5hWnZCMEJjUTVnTVBGQjVLeE1vMUdlc1J6bnFIRVIwOFNsN25vWWVZ?=
 =?utf-8?B?ZWZtVERMaFBqYnc0dHQwa2gwYWVsM3hOKzYwRUJoZW1NQ3QvaTJJMGxoenJS?=
 =?utf-8?B?TUJIOHRGSk9OdkRNRzdaTFRXZy9xVnA0Q1ptNldENVRtREkvZVdnMGFpb0lD?=
 =?utf-8?B?Q1pHcnVDbWNzTUQxU1pVWFV2elZ3MDBnemIvTFlndERvTG5Cd3hHbkxVeUhK?=
 =?utf-8?B?OGJycXN2bFFJSEIzT3lEcXdXbmVRME5yWGwvekN0azlHMGRQRmFEbVdwT21z?=
 =?utf-8?B?NWtqZDA2TlAveXVJWmFOTjI2aUlsNHYyZTc4SzJuU21KUnNhbGhIQlNqSlJm?=
 =?utf-8?B?U3cwdTRWeVFJSlY1TFdpYm9LL2grYWcyOFZidkNpTzdUNUpNNzAxOHlYWUZ5?=
 =?utf-8?B?MjVmUXlqeEozR3F4MDdRWWptbndVSFJVNEJxbFpxSFRjbUZObGdGVDA5K1Y3?=
 =?utf-8?B?Y1hPeGZWNXZ6KzRWUjRQcFprSHhycWhSWm1MVUtzMllIeW9vbVRpbk11cmxC?=
 =?utf-8?B?ODlCRFAvS0t5Sm53V3JqanhhL3pNWFpDQnFUb3dSQkdhOFJNN01nUTM5bERa?=
 =?utf-8?B?bHBrSitJTzBDSTJESUdBMGY5THpzZWQvOE1SN25IVFU0dU9Iekw5ckY2bjRa?=
 =?utf-8?B?ZDhhRXJDa3N4Wjd0RERDTmNIRy9DV0F3SWpuZTRvNlFzQUUyVDMraVN1NFlV?=
 =?utf-8?B?RmxBWFJrS0pHS1Jhem5HNHk1RG42cGwvL25HZHQweElWeUhJRXhaNkNaMWdt?=
 =?utf-8?Q?B2KXycJMgxg0+WmkBs8WFA5uh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550f14e2-510c-4854-dd23-08dd1de7e02b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:39:49.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmEjx283FvjtNW+AAkGkQH+dSkEyxwwluSbf5y8Sp8SLUD4TDjYnalZaT1z29nZg696F7cRZb1C+BzLoLD8hOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

On 12/16/2024 08:45, Dhananjay Ugwekar wrote:
> On 12/16/2024 7:51 PM, Mario Limonciello wrote:
>> On 12/16/2024 08:16, Dhananjay Ugwekar wrote:
>>> Hello Mario,
>>>
>>> On 12/10/2024 12:22 AM, Mario Limonciello wrote:
>>>> The limit updating code in amd_pstate_epp_update_limit() should not
>>>> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
>>>> so other callers can benefit as well.
>>>>
>>>> With this move it's not necessary to have clamp_t calls anymore because
>>>> the verify callback is called when setting limits.
>>>
>>> While testing this series, I observed that with amd_pstate=passive + schedutil governor,
>>> the scaling_max_freq limits were not being honored and I bisected the issue down to this
>>> patch.
>>>
>>> I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf
>>> field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is
>>> equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed
>>> cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq.
>>>
>>> I think as we removed the redundant clamping code, this pre-existing issue got exposed.
>>> The below diff fixes the issue for me.
>>>
>>> Please let me know your thoughts on this.
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index d7b1de97727a..1ac34e3f1fc5 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>>           if (min_perf < lowest_nonlinear_perf)
>>>                   min_perf = lowest_nonlinear_perf;
> here^^^
>>>
>>> -       max_perf = cap_perf;
>>> +       max_perf = cpudata->max_limit_perf;
>>>           if (max_perf < min_perf)
>>>                   max_perf = min_perf;
>>
>> With this change I think you can also drop the comparison afterwards, as an optimization right?
> 
> Umm I think it is possible that scaling_max_freq is set to a value lower than
> lowest_nonlinear_freq in that case this if condition would be needed (as min_perf
> is being lower bounded at lowest_nonlinear_freq at the location highlighted above).
> I would be okay with keeping this check in.

Well this feels like a bigger problem actually - why is it forcefully 
bounded at lowest nonlinear freq?  Performance is going to be awful at 
that level (hence why commit 5d9a354cf839a ("cpufreq/amd-pstate: Set the 
initial min_freq to lowest_nonlinear_freq") was done),

but shouldn't we "let" people go below that in passive and guided?  We 
do for active.

> 
> Also, what is the behavior if max_perf is set to a value lower than min_perf in
> the CPPC_REQ MSR? I guess platform FW would also be smart enough to handle this
> implicitly, but cant say for sure.
> 

I would hope so too; but yeah you're right we don't know for sure.

>>
>> As this is already in superm1.git/linux-next after testing can you please send a patch relative to superm1.git/linux-next branch?
> 
> Sure, I'll send out the patch once we finalize on the above if condition.
> 
> Regards,
> Dhananjay
> 
>>
>> Thanks!
>>
>>>
>>> Thanks,
>>> Dhananjay
>>>
>>>>
>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v2:
>>>>    * Drop lowest_perf variable
>>>> ---
>>>>    drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
>>>>    1 file changed, 5 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index 3a3df67c096d5..dc3c45b6f5103 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>>>        u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>>>        u64 value = prev;
>>>>    -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>>> -            cpudata->max_limit_perf);
>>>> -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>>> -            cpudata->max_limit_perf);
>>>>        des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>>>>          max_freq = READ_ONCE(cpudata->max_limit_freq);
>>>> @@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>>>      static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>>    {
>>>> -    u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
>>>> +    u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>>          max_perf = READ_ONCE(cpudata->highest_perf);
>>>> @@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>>        max_limit_perf = div_u64(policy->max * max_perf, max_freq);
>>>>        min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>>>>    -    lowest_perf = READ_ONCE(cpudata->lowest_perf);
>>>> -    if (min_limit_perf < lowest_perf)
>>>> -        min_limit_perf = lowest_perf;
>>>> -
>>>> -    if (max_limit_perf < min_limit_perf)
>>>> -        max_limit_perf = min_limit_perf;
>>>> +    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>> +        min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>>>>          WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>>>>        WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>>>> @@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>>>    static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>>    {
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>> -    u32 max_perf, min_perf;
>>>>        u64 value;
>>>>        s16 epp;
>>>>    -    max_perf = READ_ONCE(cpudata->highest_perf);
>>>> -    min_perf = READ_ONCE(cpudata->lowest_perf);
>>>>        amd_pstate_update_min_max_limit(policy);
>>>>    -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>>> -            cpudata->max_limit_perf);
>>>> -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>>> -            cpudata->max_limit_perf);
>>>>        value = READ_ONCE(cpudata->cppc_req_cached);
>>>>    -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>> -        min_perf = min(cpudata->nominal_perf, max_perf);
>>>> -
>>>>        value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>>>>               AMD_CPPC_DES_PERF_MASK);
>>>> -    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>>>> +    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>>>>        value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
>>>> -    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>>>> +    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>>>>          /* Get BIOS pre-defined epp value */
>>>>        epp = amd_pstate_get_epp(cpudata, value);
>>>
>>
> 


