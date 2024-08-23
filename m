Return-Path: <linux-pm+bounces-12837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805E95D312
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F05D28A9F9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872D18A6C0;
	Fri, 23 Aug 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f5YU8PC2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AC1865FC;
	Fri, 23 Aug 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429957; cv=fail; b=fwMErFKKCwlQRkxVzSmQtFvkNPEHUD+P+qQv1P3WwMRhmbGjWHlgZKyEk1X4uXjFwvoQypXOUMDGGeQNPlOTcCCY6PV9qWzL8X6t3U9m7On8QcDboI57IjvfOPLu4LNFYRIN37yKzlBPyhyxsPYEZliB5Oq2vmUn08OiZg0Jewk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429957; c=relaxed/simple;
	bh=hsnKJTWyBSlrX6G4iZzu0uWOzKO/4bcZzhCerxX9ihM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dxuj+gzFnwvk/p8CXGP5FsZn3zmjYaoNDIdpe6JGVfA9OhM/v3+vDA0fF+ojIL5w8bWo6qGHGAnuWN31GUsS6MtEhAgapx4lkjYSdkZEz2fCDXwCJYFe2t74UgUZWP5zkhblvn8yJ2bzS7xvWj1cAQjuLwxq5c+EYqO76mwkgI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f5YU8PC2; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiwixXGnEfvGmlC59xVtb3sEzwmnqtTgZ+f3p+p1YT2jcpuXt2LzM+8GyCaNpQfhqz3YZ6viM5wrr8rXZzwA7XQYrMvVdK1/NUX85iFKWO00hSwo8fZQdkETDho1O3HjxsNpV4fc3jTfHyeaQX6ECyv42AvLqiiKyEew6B/dZISwkVf+MLr7aNpaUgp7EDSdJWmmt4ympE4ilv/IwDgsq6gFI8sZQtzp6apjNnEvq+zZsA8scJvBjCc/77FAZW97au1MIHehruMg793pLSnysSbBunPj0iJgD4Uq2KHAaz7PT11DbgBqv2y8k8qli7MeTnkLuaAXTicK8nKzFYS19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJW2caVptZHIpGiZT2xAdL3fk2rEByp5//brtGYylUw=;
 b=GZT8bE0xf0wDVez+Tkf0EpL5RcSju0Pi5i4tloj1lRH5Vs5MyxLClfrRr5VvlhLC4ZRrHMZ5ooD9ArUZdBj+iXg3xAw6DPF23wnjcvxMYdJzPEf9gRwGfUzTgaeYo5OMFM9HEN9uHW5jA5iqW+yQmPFYFsLMmKqLwZBoxoGrQy3wVT6nuPHSD7uD2KnMyynZZM4zgM9Nw0OH1P0R3xbQJLr5qVQbHN5/TP/tN5nJJDErfTWFYmHYCBihL9AvEJq2yDDFPr5sV7FZq26uS8aEAn4B4Kx7XQFdX8xvMC10Iq28ng8HPZzhH0rT3Ve3QE/6Gln7s5L666DCbcYL43LQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJW2caVptZHIpGiZT2xAdL3fk2rEByp5//brtGYylUw=;
 b=f5YU8PC2RUkZIQO2lzrdlPXh5xXcsmgJpZJ6ZUK4zw9TncZUUApU3UihqU26/7VikgZPF1OhFbH08mqE4RSHXNUk9s5o+xtie4oKG1CnrPezrrWe8wGlZyufZS+PknghQTlklHJ2qjFB7IGjfCD9+YXZOAhxjKVVquTQj2m18ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:19:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Fri, 23 Aug 2024
 16:19:11 +0000
Message-ID: <d112c64c-b7d6-4aa3-ba78-8031bb7d1e1a@amd.com>
Date: Fri, 23 Aug 2024 11:19:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
To: Anastasia Belova <abelova@astralinux.ru>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240603110741.24818-1-abelova@astralinux.ru>
 <ZmGHqL93i2GDHsWb@BLRRASHENOY1.amd.com>
 <69c57210-8a48-4ae2-b529-a4cd6dbd0121@astralinux.ru>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <69c57210-8a48-4ae2-b529-a4cd6dbd0121@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 035740f0-0d6a-43e5-c34d-08dcc38f52a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVJSbitpRW5TbmtaL3hBb2NsTU91UzdkeE03SzJuMjF6S3RQdG1ySWdQODFQ?=
 =?utf-8?B?VTh5Ui9LOUU3ajNtZnJWaGw1aFhpWjFTM1c5YzRXMkJEZTljMlZZdXFPb05F?=
 =?utf-8?B?bDFQaUZBRkRSQjMwTVJzbVl4N3l6enFmOUNpbnRWQjBlWVMwTXRUSW85a3Fr?=
 =?utf-8?B?N2ZPMnRNOS9CUGlLK0RZYkhkN3BiZjEzaG92UjZodngvb05NZjl1LzM3NGRs?=
 =?utf-8?B?NUZWNWtUZURWdHRxeW5BNGttTTRMWkUybkFpK1VHYlQ1OHdRNFdTZTY1OTRo?=
 =?utf-8?B?dXd3ZVVGYlVkbHlQRUJ6M2dQL0h3RTVuMi9iNmpBN3pDejVmSDkzNjUrQkVT?=
 =?utf-8?B?M3lWTlJ1bDByWGVzS1B1MUNSZFE4eStGZHF2T3dsTHBjQ1l0T3ZvR1ZWZUVy?=
 =?utf-8?B?VkF2K3FNbW94MGhHY0RvRDZFRzV5L0hpUlhoalBWbHJqRGFuaytIb05ZOVU2?=
 =?utf-8?B?Y3hHUnVCQjBRd3VKZjl0N1FmdDdyd2NMNjZhRkF2Mm5rVURtZ0VaK0pUdVFi?=
 =?utf-8?B?Uk5UNmVrVXQzSEpVd1ZqSE82VFUyUWVoK1hPNzZIaXpBV2lUb1VHdjY1MUdV?=
 =?utf-8?B?czgzcnl5cmNTTituTGw0eVB2d1dreUJwWE9IRjg3MlgxY2Frek8rK0Z0aUJN?=
 =?utf-8?B?cGcvZWM5VlZwaWNVQ0RXR0hNcjFyaFVTb0JGbStsOTViSThnMkVyVm0yZkdv?=
 =?utf-8?B?YnFsTm92KzlPQUpmWndUL1I5dC82ZUZiSnRQZEZtSEFnL1U3ZHVBSXRmeDRJ?=
 =?utf-8?B?NW13WEdWM1hrNy80bUplYXZDTnpaUzN5QThNcEY0QWtOVWdOeXFQcXhTbkVn?=
 =?utf-8?B?K0Q5UVhnZXZ6M2ZlalFuV1FmZlErSmNCMGIxN2lNQVhWNkNqRGtOMTFobnR0?=
 =?utf-8?B?aWNKalk1dUZhMGtQVVREY0NnNmFkVU1Yemc3WkhqZHAyQStNSEpxT1BBQlhz?=
 =?utf-8?B?MXU2UmdQdGVTL2t0UzQ2TWJxTVIxdnBGMTQzNWk3TDBtTTM3blNrMmE0SGY4?=
 =?utf-8?B?cHZaNEdpUmJaTWJuV1pvTWZkK2Vvb3dDN0RLUFhiTVFreG1mY1lnNzVIdmNE?=
 =?utf-8?B?dmgzM3J0cWNXbnJmS2tqY2dpcEJDSlljM1ZsdmRJakxiVS9PTUYzdzd3ZXds?=
 =?utf-8?B?WVp1eDVLbGVDczkzZGZhV29HcnNWVGY0RWFuM3R0YnVVTFRoZlN2MHlYSStm?=
 =?utf-8?B?WVBvK0RHUDdFN1VjbjJ0NEpIZWx4aDE4QjFqQU1IMjN0ZHI5RTlKNnQ3a3p1?=
 =?utf-8?B?cjR2T3ZjYzgxNUNIRVUwc1FKWEpqZmdKU05DSFpJUmdiL1J4Qnl1MHUxcUdO?=
 =?utf-8?B?QkR1bmRsOTVmR3ZmQW5xYU8ra256Z2tWbzdGVkN4TTUrOUZhd1Rmc2Y0OVdj?=
 =?utf-8?B?U2pCNkZReDl5U1U2cGhveG5VRG9mN21YMmlvOVRSYncyWnk5YWtqMlJTb2dn?=
 =?utf-8?B?c0wvQnMvS0J5Zk5lcTk2TFRna0ltM1dIZU5NRGU4ZXFzQzR3eXA2b0N3ditB?=
 =?utf-8?B?U0VvQmk4aHBGK1Q5WFdsWEloNUxiemZnd1NJVjlxZHFZY1BRaHU2SXZSUVlW?=
 =?utf-8?B?T2pCdjRxdzlEYmZkdzV0UVVCdCszM01pRStyb0J6cTB4d0dMK2JUVmVMZGlS?=
 =?utf-8?B?bU5XNWdadXZDbFNsdk9hOWxzZUdoZk52SnJXUXNuMHJDcGRvLy94WWRqYzRu?=
 =?utf-8?B?QzlTdmZyQ0M3OHpqS2d3aTVyTnpHOG9SL0M3cm5NcXRpMTRsZFU3N3FVRUN2?=
 =?utf-8?B?bG4rQzdWT0VCVHdhMW5XY3E2aHFFaXo3MElWSzRhN203RXJOL2l1N0hDOHFt?=
 =?utf-8?B?UG9TWGIvTVozbzFsTGJIQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFUxeHZ5YXA4RmZZbmNHZU01SkdsQUFFQkc1Nmhic25QVnlzcHNBOFZBODZx?=
 =?utf-8?B?cGJ1Vnp2K1ZYenR4cm9iQks5SGduM3lvMUVVa3YrODg4d0dpb05iaEswUEMy?=
 =?utf-8?B?bG1hYkR5M21WejEwN3VnNFVaTzhLSXBSYlFJZnVYODdqNU9nVDUxV1pkeUdj?=
 =?utf-8?B?RnFOaFg4WVF0b1JkTmtFY05CMm1CS0lDQjAxeng1a2F3VGdFckhidTh6eXBJ?=
 =?utf-8?B?dHZlMENyM253RlZ2WXJFNmhTUFJtN3JzZldYdUxEdVF6QXZRRkNxaVNadUt2?=
 =?utf-8?B?RTlMVlQ4UVhrOEZWZnFnemZRN2hWdmJsQ3BXYXlBenYrUFg3VGhEMWU1WTVS?=
 =?utf-8?B?UzhjWkNFTWpJUVNzZFJ2bXhYUTZOR3czdHhLbExWc3FaT2c1aU9kNEoxZVRU?=
 =?utf-8?B?TS9CRkdjdVdoZnR1L3lSenpJblhZV3dlTFdEeEdwQVcyeU9jVE1UNmJ2S1I1?=
 =?utf-8?B?anF5bXFROEYyTko1aUVBeklRaHlBRGdZcHpBVEw0NWMwVEVtWTRuT0xNMERx?=
 =?utf-8?B?RXlNMzBDMkVzTE9qa0tDY1oyWlpGM0JpS3Z1emdjYmNpV2hmeXA4TXI2QmVt?=
 =?utf-8?B?YzJoZzlBNGg0eWdXQldiVXpEVFRLOFBMV0J3a0J1ak8zYkVaeUJOeEl1UWRm?=
 =?utf-8?B?Mlc5NDZteFRjMWRjK0NtQUNvV214YlVSd0FoZGV0ZHdMQi9yQTRoTVlvWVla?=
 =?utf-8?B?UEVEUCtvenVCMm41YVoxdUIyWFNGdU5YSHBPRFFURE5ONVVEVVRxOVRyaHpL?=
 =?utf-8?B?dkppK2RyOWZZRGdvc1hWdkRKU1ZlQldxRGJ6TW1BWk1JYndiaDRDZ0tOOSsr?=
 =?utf-8?B?SFNiWkF4MjdoTXdrVjg3Q0cxT3pGend0MDZsZjRIMEY4d1ljMDBxSndRSzdL?=
 =?utf-8?B?cGtmQ2pnQzZ2KzBHa1ZVeHFla3lvTEVBay9rZEdwc25LdHpQUmp6dE5ZZWwy?=
 =?utf-8?B?KzExSEVHdW5mY2FYYW5kZkx2dm40QWtmKzlYME9vWUIvSU1Wdy9JZzluYzRI?=
 =?utf-8?B?SUlqbHlPcGJ6bGhLTElId2FESXFPeENJVmdpRU53YnN4cW5xbW82TENsTVlw?=
 =?utf-8?B?UEZzc2FLd25tVHBkeGlvcmJ0N09UWUhMcXBIQit3VWwySytJdURDRkdQbXFH?=
 =?utf-8?B?bzBhYTNXZ1ZDYjlBZ0RPb21zVDBTMjBLeVBUQWpMWXlqb0h2OEU0SVNhQU54?=
 =?utf-8?B?cFMwUHRVSlVHL0xDdU1ZcFNtZUtFS0pQMXQ2NzFObEk4WTRwcTRIaXdiSzc1?=
 =?utf-8?B?Zm9pbCtwQmcxTjF1eDhMSHJhOGxWbldqSVUwbWxvTitQSU45VC9hOG92ZWFR?=
 =?utf-8?B?SW96M01zK0E5OVdjbXVzcEcrZEZwTnJSUXNvMmtjKzRDUCtKUWYyczE0T1Bz?=
 =?utf-8?B?cFQvYXhlS216bzBhcUlyL05kTFRDeWVuamR3RHhrRzhGWXF6YWNUQzduYmxE?=
 =?utf-8?B?dnJRTDJ4ZVhTVjNUZ2dTckwrWEZVd3VHSUFTUlozK29YazM0Y3Z2dFBDUTFq?=
 =?utf-8?B?MXdUdHFzcUtzLzc4UTdTR3ZHcDlRbmkvODNVSUdVeU9zbmtxbEhURkk0NDZ4?=
 =?utf-8?B?ODNPWm9zQU1VOGdHVDdLd1d5OWZkZzNmYVZ5bHhxcFVlRjdXdTUySmVMZUph?=
 =?utf-8?B?ZVA3R05yb3hyc2NaOHVGYW5UaDZ6cXpIN1BZZlVuM1E0VzliT1dnQlBNMW9V?=
 =?utf-8?B?RHVFNVhrVW1GeXJlWHFNTG5IdHMxczVYdzB4bTNZYW5qYmw2b3JVWm8vZ2h1?=
 =?utf-8?B?QXV1ZXI3S09Gbi96RUlqR1Q5RGV1VVloMjlMMXJEQURpdnJHRS84OU1SMmtm?=
 =?utf-8?B?aHFWWVE1TlJaZnF1ZzR5Q0psekM0cmVZUkFMQnlZM3ZTVTVXRGswNGcrbTlj?=
 =?utf-8?B?d3VZMGdIUFhHb2p6eWZKSnd2Rm5TSlJrS0VTTUNQSXIrejVnaFB6T3RJWVJ6?=
 =?utf-8?B?OWRIWXNpNmQ1YmlsaWsxMTZ2WGxnWnRnWUZZZGlsYU05Sk1FVXh4cHdSZE13?=
 =?utf-8?B?dHMwNTIvajBqSjV3Z014Z3BDZXlkWE4wOG1zQ01qd0ZzNUx4VmZGWm80aDk1?=
 =?utf-8?B?dzJFY2V5dHFONWcvRTg5c05wSmdJaTFYMUZ3bndFdUNMQkxtODRqV0xWWkU2?=
 =?utf-8?Q?ZeK1AZNwKl2xxdX5m+73sHono?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035740f0-0d6a-43e5-c34d-08dcc38f52a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:19:11.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suIqhov09mcnoLQzrl4B+NUekYjJyaT45/mvzafonHGddSLRIRpAVVlKGqs4U7eCiXMkP5OyJdAS9MbQaS4k1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782

On 8/8/2024 08:07, Anastasia Belova wrote:
> Hello,
> 
> 06/06/24 12:55, Gautham R. Shenoy пишет:
>> Hello,
>>
>> On Mon, Jun 03, 2024 at 02:07:41PM +0300, Anastasia Belova wrote:
>>> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
>>> and return in case of error.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> Thank you for the patch. Indeed we should be checking if the policy is
>> valid before dereferencing it.
>>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 1b7e82a0ad2e..672cb6c280a4 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -621,6 +621,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>>       unsigned long max_perf, min_perf, des_perf,
>>>                 cap_perf, lowest_nonlinear_perf, max_freq;
>>>       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>> +    if (!policy)
>>> +        return;
>> This patch mixes code and declarations. While I personally don't
>> prefer that, since we have moved to using C99, the compiler does
>> not complain, nor does checkpatch complain.
>>
>> So is this ok for cpufreq, Rafael?
> 
> Should I form the second version without mixing code and declarations?
> Or it is better to wait for Rafael's answer?

FWIW, I don't really like it either.  As it's amd-pstate code I'd say 
Gautham and I should make the call.

Can you please change it to avoid mixing code and declarations?

> 
>>
>> Or would you prefer something like:
>>
>>     unsigned long cap_perf, lowest_nonlinear_perf;
>>     unsigned long max_perf, min_perf, des_perf;
>>     struct cpufreq_policy *policy;
>>     struct amd_cpudata *cpudata;
>>     unsigned int target_freq;
>>     unsigned long max_freq;
>>
>>     policy = cpufreq_cpu_get(cpu);
>>     if (!policy)
>>         return;
>>
>>     cpudata = policy->driver_data;
>>
>>
>>
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>       unsigned int target_freq;
>>> @@ -777,6 +779,8 @@ static void amd_pstate_init_prefcore(struct 
>>> amd_cpudata *cpudata)
>>>   static void amd_pstate_update_limits(unsigned int cpu)
>>>   {
>>>       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>> +    if (!policy)
>>> +        return;
>> Ditto.
>>
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>       u32 prev_high = 0, cur_high = 0;
>>>       int ret;
>>> -- 
>>> 2.30.2
>>>
>> -- 
>> Thanks and Regards
>> gautham.
> 
> Thanks,
> Anastasia Belova


