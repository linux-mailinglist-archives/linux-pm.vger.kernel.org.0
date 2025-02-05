Return-Path: <linux-pm+bounces-21414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F09A297FB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084991881080
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5961FCD0D;
	Wed,  5 Feb 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gMJCjwkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589201FC7E4;
	Wed,  5 Feb 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777864; cv=fail; b=qov7AkLgRJydIZXQNaHmRFhrzYT+VdtyQwwjDHRQjxy2ar/FpE0R/OtLUj2GA3pbS5qL875sOQggoecaV9vl+iDtYZ44I0MO+cDK8xM7k+bocbCvzUrYqXE0R0RtS1Lqz0Hc041o2Ndd95TSDol2CbVv8h3FkkRjZRL7FQTt4I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777864; c=relaxed/simple;
	bh=bWAdva+kZ8cvJW/ibacbEC49ju20G2BDN2cs0ryLOLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XCZv3/90WYJ6kXUENgtJkWnm4P0mF1LqDNjj+d+P3HCzMff3rc1plWuz4q+VijryN19YRi/6W22uu1X7P8TgODqQRbA9q+0RDKy9/VrIXDP80/tQF+rWAh+lOAtp8gDGRsZ76YA0sw8cIACaNBKD+iMW6by4PCyJiXvxPIdNbG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gMJCjwkM; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZg9U2VCfmEq5mOKMoUXhJExIYvDlT8l3Yx3bHlwOevkLx99cilVPx0hKku1JqitSAapxKTqKwyEOnum7fD6tY2g0R0fvdt9OFBeGNDO6AO0/3CdDWdLeVQZp7ohP+VGh+7i3zFAYKF0pWFKHYkCuHtlvYFLWPLAThRP9FYhiOpFGULru6JbuN5Kugx7OvKFWHWHjclkdqvBHHz/zE3piwPAmor9xTKmlHFtPOJao+R3ofsWisoL0K+QfMM9FeeeyMLJXJtBhKLbAE8xvOoccQynnafP91AQtEOhZ16k5paoTYfEfwoctk6dok6j6b9sRwkXZCMXuSGvaLxvhUPcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PKJfCIv65+5zVbWZe3GtKjQMfWOk9mu9cxAoOXqeMA=;
 b=JCpc/XVH/ypCw891cpl5xzXfNTVvwx4NVcuE9/2uMPw00t171nsSSVNAptlR7wOhwE2B9Nw+imeRQDn+fKFz2pLCsj3AXfokKY7Z016kNyI3NQ2Hq1wEnWyKaxCljfx51FRNyS139mTf0dsr1juY18fQMSJc6pzh1+G4JM5P94gqZMKQWuf7zMHPQTfjEUs3L1LyOeQCXqDuQMJvCCIOlEL4Kl5fFbFixTCVasSQr6McG+szdufxikbUbSwrkL2SII0chke3FUeN8++NZAX/CZAGEh8JPz69vyXPi7n+cDf3BfDA14/GWmlfsc8N62VXNv/Woo7iPa8EwBR9B6MqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PKJfCIv65+5zVbWZe3GtKjQMfWOk9mu9cxAoOXqeMA=;
 b=gMJCjwkMX8+VqrbnAjWO9XzCOcup4iZcI8hVPK7uTnFzV+K3dU8S+tRpGtLZsbF0f7QY0QzKrKz0RvmbhIdmN0MlLkZ3uUc4rmaCFEZ2Jpb/FVSC3sJXHIZPv/CoR3ouOv9KqbW6RK6ZkaA7BS6RK/EgKkHckvKbOxWcaxB9Ca8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:50:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:50:58 +0000
Message-ID: <b877f79f-919c-4f2b-8368-3b2fdf1c6f6f@amd.com>
Date: Wed, 5 Feb 2025 11:40:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] cpufreq/amd-pstate: Fix max_perf updation with
 schedutil
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-3-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-3-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9745ec54-e485-436f-4f88-08dd460da5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFdYR3RXbmhPL2xSSE1TSkoybitCeVV2eXlnWUZzTXNoQ2M4TisrLzJyeXli?=
 =?utf-8?B?U2xKekVodUkyNi83RENXbWppTVBXUWFwWjArZlozdVpKNUNIL0dCb2dCNysz?=
 =?utf-8?B?SWFEb2lXY2xFNDRqVXVXM2pFL0x1eVFUSms1YzduNDBtZmtPTjdrWnBCZXpy?=
 =?utf-8?B?MWttVFBYS1dSUVA4c01ZcXRhSUZQay95NzVqU1UwejZOamtIbHlLMk5veXI3?=
 =?utf-8?B?R0NDQ3BKTmt2RDIwQ3cwZ2J5RSsrLzZ6TWJneU1ML29mSktGUVBhaWo1emF2?=
 =?utf-8?B?M1FMaDh4Q29oZkh5aFhJc2R4SFdFclJPc29rS0UwNE1iRUFxTVlNK1p6a1Bo?=
 =?utf-8?B?cC93RHZETVV0TGFuMXg5VHk3VmZ0WlgvL09QdEpTRmRkUGJ1L1hKUkYybm9l?=
 =?utf-8?B?UkV0aUhFdUpXOXVvOGs3Nmc0N2ZQTVRaOXVuVmVlSGtFSXY4S1g3Y0M2NVk5?=
 =?utf-8?B?NTFwcE1XRU41SkZWS0M3dlJmYW5ZQkhHOW8xUVRTVEJ1TWNyazBEMFUvMFNw?=
 =?utf-8?B?YktSUVhiM2tsQnRVeTMyVGtMTktrbVFMT0Z1d1ZvSnFsUzZOQW5YdmVmZnlJ?=
 =?utf-8?B?d2RlTFZFVWFvUGpCK0tDNkxzdThMUzBQUEtBQUVLKzlDY2c4OFVHbm1TOVFk?=
 =?utf-8?B?Vms4T25JMDlTYVFibUVjaWdrZ2ZFZnhsckdPblJMNXU3MEE0aHVnVHR6bHpF?=
 =?utf-8?B?WE81eThIeHVBTkgva0FPaDJpN1dPK0NzeXBtd2kyd1FFM3dtMUtuNE55L0pl?=
 =?utf-8?B?NXR1Um5pZWhOaThuRW5LTXhOeDVtYTNmbm5ERExMUnVML1dEYkZjVzAvREZ3?=
 =?utf-8?B?ekcvQW5WMHg0aFRTclNxTnRvNXVIOWRmUWwreEVUMzZFdU8rNTdJMmtLYitw?=
 =?utf-8?B?dXYwRDlLQ1NLeWsxTTJLNE16ZUxLd1pwbjl6Uk9NT1piVGFuU3I1SDk0MjBJ?=
 =?utf-8?B?RUdRa3RqZ0NSUGw4eGY4TC9OTGQ4cGhXMjBlcTFBQ09UOGJDdmUyM1BaZENk?=
 =?utf-8?B?ZG42Zk9uQVZyZG03cS95bnJhZlFvMEVmUXplUkpHVlp3Qzh4RDN5K2ZKMTVX?=
 =?utf-8?B?bDU2UU5aZ01QQ09nQllvTlRPRzFmOUJ2c1piWWdsUlExU2I1cFdzd0RKTEM1?=
 =?utf-8?B?RHZUM2VsR3F6bjFycWtxOTBUaGpENG94Ri82TUJaZnY1WUdkZ0JZMUZYU1Rx?=
 =?utf-8?B?UjNPYUY3OEM1LzVXM1haR1cyeENBOEFKcE16eGFIWERhbG5JWTRXem5NOHo0?=
 =?utf-8?B?QmFUa0hiR0w0TDJnVkwwYnNISmJDNWMyVGp2UGJEVVkxZjBPQzRBVWppbVZU?=
 =?utf-8?B?dDhabWl0Y2MxQkczbWpiV081MGNTck10RmtSNEFnVy80RDg0ZTJTRkE4WEVq?=
 =?utf-8?B?aGRPOGNqYTRPYUdCMUIwYmhXRnJ2QzlPb2ZpRjQ4bXlZeDhQaWpEMFpMZ1Bq?=
 =?utf-8?B?bGZDMkJ0Y1ZwT25sNmw4eGhsUURmVkF4dFRWeUw4UldpTXU2QnZvQ1dFZDNF?=
 =?utf-8?B?andzdHFZTHJFNDV4NXZRRys3cVlmRzB0OTFpdGZyekMxMG1jUlJweTFENk1u?=
 =?utf-8?B?c3ZQdmFiMUFWRUZCYnNjMDFNdEJsY2JiTE8xU1BmRVVGYjQ3OUE5ZUxEZDl3?=
 =?utf-8?B?NlY1K0c2aHU4WnZlcHFRMUhkOWg3SjRHZlVwa0NFc1kwRFNhdzJ1cjN1N1Az?=
 =?utf-8?B?eUxmeGRKVFFtYkdKVWJEQzRScTF2MjVJdFFoRmRCdlcyZEdkREhKbFhUQW4r?=
 =?utf-8?B?QkZpNWhtRTNGSW9CcWoydXRnUUVFYzBZT3F6N0h0UlZrdk42MUl6SXZsb0Zw?=
 =?utf-8?B?VHJhNzNPaDVJemN3cm1zOTQ3VHY4L3JDdHNBMUpIVXFJZlBSNlROQzd1RDZr?=
 =?utf-8?Q?rxwij9x9XNbYs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3IxNDY1aXF6WXVIb3VxWDRreEhYY2pseUpwYkUzUnpKc3I4RktPZlVJcTFM?=
 =?utf-8?B?VEJGaThyS2pYNk8rbTdtdmVRUk5LcFlGbHBxYXNrV1JjZ1doaCtoRXQzYkRX?=
 =?utf-8?B?VE11WGJ0bGxkMXlYUFlsOHZVcERIWVdZc3JRSVJma0s3WUREellJZ0pWSWcr?=
 =?utf-8?B?cUV0WHVlU0hwUjJSKzBFbVcyUEpaVjlpUG8rOHByZkJvTmpLNUZuTG9xeEwz?=
 =?utf-8?B?ZUloQlp2WTRVdW9UZjZtUnVnZHN6RnlQMXNGRHk4bXRlREYrTS9yWVhNdGZl?=
 =?utf-8?B?NmgxUEU2cWJRQ0cwZEpvYlIzKzc5dkF3M0s0VlVlRE15dnpyTU1zL0Y2bnk1?=
 =?utf-8?B?RjUrWHFBVXVRY0xISEg0OGNZRnczbnpMMUxVNEZRQUtmbFY5M3ROcDBQOXFM?=
 =?utf-8?B?aVZWMm9LTmUwRzd1VVlZbUYrWUQ4MTN1enU0YmRxb1J6dkhDWElKSVI0YVli?=
 =?utf-8?B?ckdoaWI1dEV2VXRuVTQ1c3FybVM0Z2RaQjlTcXhPTDU0VHc0czRMY2pXTSto?=
 =?utf-8?B?RXE0NzB6V3VpN2luWFRJZmJoZFFiZk84MFlGazQrSHQ1THVWVnBjUGl0REhU?=
 =?utf-8?B?VENJaVVEc2tnRDVJNm9xMHdPK25nWlVkOTA5L1dhNk1PVHlUekFWQmhhQXRR?=
 =?utf-8?B?enVJVkRFWnZuWmNZSWp0dEFqTHdCOTJhc2VWaTQzQzBWbWphM2J3b2hIYWpV?=
 =?utf-8?B?eFRmL0R1M3Q4RTc2WjZmZjRWd2lPckh2S0IvMlBjbjlLL0pXclZsekhUNEM3?=
 =?utf-8?B?dGpIQXlaTktpK0ZKTnBjSlFQK1R6d0lpcll3TS80bU1UaE0zN0xjR3c5Q1lX?=
 =?utf-8?B?SEEraVFGTTJ1UHVNTDV5ODVBbHJRVkhzdDRVU3R3cGhDYmNPTkU2cnoyQS8y?=
 =?utf-8?B?MnRJenJnU1RHcmJqNjU0SGhXR3YvY0hJYm1OaHd5RHBpZ3FJUldCQXBhT0xj?=
 =?utf-8?B?TE1UajRBdTN2UHRlbUJFRVQ5dnFSZ3cyelpscDJlVXVaUUhIa0lkNi9hTGQ4?=
 =?utf-8?B?VFpmaTVzYWYzdzFGQWpjeVZSc3ZyeXNMMm15NXg5ekVQc1QzSC9qUXJsYTBy?=
 =?utf-8?B?V0hUUXVHbG1hTk1Bb3JueS9JMUgrZkk1eXJ2SUs1L1BxbjhiNjJyM0xrZXNp?=
 =?utf-8?B?elJpZnA4eDhwczY1bFlMQ0NYTEk0Lzd6b3BDNGdLazRUVnZNQUhkVHR2Wk5T?=
 =?utf-8?B?S2E4NFUzU1ZqZ09SWStUVnNmeGlGaEx0Wk02YmV1R0hWQ2dNMmVEbWFtZ0pv?=
 =?utf-8?B?RG5BWGZHUFhJem5PSlB5TEYwQVptM3J4RzhkTE5TNjJ1MkN4MnVNemlrQ29W?=
 =?utf-8?B?S2ozZFI2WW5INVlaQTZEazRIOWozclhib0RmZkkrQ1BPWEJGOS9sWEFiTUcz?=
 =?utf-8?B?TS9qRnh2cVRIamJIajB1bzFsdzZnUXE3KzVUcXA1ZHNTSHZXQnhiVkhiNnpJ?=
 =?utf-8?B?TExFNUZ1SXF4cC8vYlpXUnRUY2tJTU1NaUVQbVVaanJMbjNrejVTWlRrUVF3?=
 =?utf-8?B?cjJFWElUMXNxRk1CV1B6UU5BNWU0cm0zVEtwQ3lYMUpLN0lQdjR0d0pDL0d1?=
 =?utf-8?B?MEdQTkVDazYzSkduQTBKd1VSRksraE01UGNxekg1eU1ZQ1g0M0VoaE85Zk5Q?=
 =?utf-8?B?a05aL2dGb0JLbGRya3h5UnhyNm8yZnNrcHE3cUVBY1d3dmFTWEp0SlF2ak9Z?=
 =?utf-8?B?dHdNaXh1VUF1QUk2bWpiYk1LTDcrYzczVTVvWUUvT2JUQXAxOTBDZ1lVdzRJ?=
 =?utf-8?B?OEVuL2ZhUXJ2ME8yYkxINEFqV0o3UC8yenZlOFFZdTZWeVNJSUIyQnllOXpJ?=
 =?utf-8?B?emd0UUg5RGlLRjluL0tUc0MxaWYzNE13MHZPbWZPa2dnMWF4YmVrRG9ncnZ5?=
 =?utf-8?B?R3FjZVV3MS9UUndxdjVEZmlKVEhmUGwxckxuelhBMTVlUmhKUitSQ3g0MzFl?=
 =?utf-8?B?Z0tjUy9sSTFySzBoNDZYSHJwakpyTW5OOFEzd0VSOEhNL3JETWlGa0VnUVhh?=
 =?utf-8?B?ekZpeG92UWV6YjJUNmVXZXRoU2k3RXFQMlZCUUhhdVZ5YkM1ai9HVStEcmY1?=
 =?utf-8?B?T2ovZDFqaHdNSUxFUnh4RnZwMm0vRTYwN3NSQWdiNjhmZXB6VnpLTTBtdndM?=
 =?utf-8?Q?YX+lxdrhEBtjINnfRw1znxUzd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745ec54-e485-436f-4f88-08dd460da5b2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:50:58.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VAveN5ek7jj5kuQDImWXcRf8ggt6i6DzRErerES/C2mcMUDd7985n/2nV1DNmnXT8hHfiw5cXjd0fWF6GHelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> In adjust_perf() callback, we are setting the max_perf to highest_perf,
> as opposed to the correct limit value i.e. max_limit_perf. Fix that.
> 
> Fixes: 3f7b835fa4d0 ("cpufreq/amd-pstate: Move limit updating code")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this fix for 6.14-rc.
> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b163c1699821..9dc3933bc326 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (min_perf < lowest_nonlinear_perf)
>   		min_perf = lowest_nonlinear_perf;
>   
> -	max_perf = cap_perf;
> +	max_perf = cpudata->max_limit_perf;
>   	if (max_perf < min_perf)
>   		max_perf = min_perf;
>   


