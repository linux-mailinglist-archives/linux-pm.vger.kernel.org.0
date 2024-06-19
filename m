Return-Path: <linux-pm+bounces-9625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BCC90F718
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501A6B217D9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55340158A3A;
	Wed, 19 Jun 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V5ifpTQD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355A15886B;
	Wed, 19 Jun 2024 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825962; cv=fail; b=tE1zkDrJpIBzrsGKtHNd2S3F8gGP0T8iJxj5cos666K5WCsgf+yHbxwrSxQeGLYVw8pB9elG59FFzpN8RAxhOfSWfkh3SdjuSMIcNhenFpFW1cWMebQpYHgzWzHV9bk0WPTPrCiOldtfEn1c2+/fErBKDRLHVXpTuZLAZ64oV5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825962; c=relaxed/simple;
	bh=qHTESmxTdI9rV47tXNsAqDusaWkw7CuHR2kM5M8LmTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m1YnDwTA5eYaxXI85yK1OGExQ/vsxkxmWXZxcyxnm8UJ/i2axFGyx2fIEzUuGMLpiSBu9dtT+WgYKaouNKI8cRDhxcOkwSnHcpPcy8OQsHfDP2yQmWMzmFHg8pd5XUqLrVgBBrxP1UzXkhCT/6gfutvryUHEtij+HS48LkmXriQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V5ifpTQD; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDQuEhEWkp1UEi53kYelqlLibd8xrppNBD+LoeuU8AKN4abXwKhXeutuV+0Hg9xVadLCfsaTF+fLNOoB4KCLXaVB/txN6pDuE95oDB7ZbBpfoR9/sBAFsO7S1xleCC0cB2xk5KkVTsUysSVrEBgkn1dgs6ACfdPN6DJgmB+3lqXFUZiNzBw9hw/R5tGFaJIoDB1TyC8jwye8nrl0wXBm2MpReEekMN8BB/eGm7Up2UIkgtyRnUx7qMBSSNC2awnwSR9aUGjyjAF7IhQ2NlbW9KOuUMZshjXC2pjdTipr9BtveFUmcYCu8qfOMj0h0jNf85pLI9OeTI++Av/jtSUw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OiooOMR3Q9Z+8/hnMlSnQMKbKmt0G2jXQ18e30UWxk=;
 b=V3zi2VXg+k8JE7NnuencZdRbZ45ravxU9kx23DrkCzNaxab+2+9tIxPuOcdSlk6eJ1Da0mXJN5MFsXo2JMJuu6rlJqgNFmO7j6OxQu+Jj2fRDy6er34RpLr9finioRzotPCoAYaHWjN2zBZmo4IFYnqMKXswRVMVm2wLw7nlJ2eD/csZuH9/GizJ7jvA4ccQHFB0gE3IlvY6YBGXkqt9d15BAB2MD3nFDbh7pXVHuJyqSHgJyDQUw9SUERGK18nmnNIDyozf8Hip5VfEdvwsMfaSw/55L7ulOmOU7LpzTXj38L9I1DvbgspbmA2wpliUBfD2fe9aLIdpVwYZKr9gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OiooOMR3Q9Z+8/hnMlSnQMKbKmt0G2jXQ18e30UWxk=;
 b=V5ifpTQD1MAVth2isBA866uEbMoUCThXvrWyZmUKtXTJkXinPqgPp4frFKJAkmshUqyzuS4kLslbHUIxs/HTqqriL8uug/4PO/s6RB0CP2Xc62iH3EJ5jTpAaIG5o8mBfMkOy7hgbLJP/3aKvNESgTx01fea/clY7x9Kj9bS6+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 19:39:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 19:39:13 +0000
Message-ID: <4b4c4a5f-7ab2-4510-9dce-1c1407cca4f8@amd.com>
Date: Wed, 19 Jun 2024 14:39:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718787627.git.perry.yuan@amd.com>
 <a6d890f77889555c090db754c9a7b81e91053116.1718787627.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a6d890f77889555c090db754c9a7b81e91053116.1718787627.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:f2::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bca36f-63f3-4e9d-f778-08dc90977f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlcraERyU1lqalVyNkppRVJsVklWVjB6QnZrOUVxckJQQlVodWF6d3R1ZmhR?=
 =?utf-8?B?YnBEUDNUaHYwOUozY0VvV0tMK2xRcEpLMnJOV0FlcUxGR0d4Tmp3cHQwa1lG?=
 =?utf-8?B?OWRFN2E1ZXZUdU1zd25NVTNPUmZCTUY0ZkMza045bU96MThHVGlPMGpZT0dw?=
 =?utf-8?B?T2dUYzdIeG0rR3phNVBXcUVTZXZHTFhkVUp5Sjk4Tk8rNXhlVWg1Wk5HVnA5?=
 =?utf-8?B?NmlTSUVMMzJvWERUUzByc0YzS2ErYWJCc3FrQ3pBa0dwSWxiQS9wdVZCSlBH?=
 =?utf-8?B?T1FuamZPdlV1MnhhNVZybUlSdDlKN3RwT1RId21EYkJ0QjY2aWJDVkUxdXBP?=
 =?utf-8?B?aTFFSkFGczJOU3V0cmlLcFIxbnhDeEtLcWZraVZ6SitqVUZZUEtab1FNamFz?=
 =?utf-8?B?LzNqZlRubDd4TDdDRExwR1grcUV6RmNlQU03MnNjZ3p6WUJGMzRKYXBseUZX?=
 =?utf-8?B?M0lDOTlWY3J1QmZHRlpkbTk4K1JIRFZqbHFZcWhNRit0cS9jTC8xbzR5cWZy?=
 =?utf-8?B?L2dMUVdGZXJlZ3Z4VkRQUE1BZHRpUHNIYWZZaGZRMHdLZmhObFlMZmRKV3Vw?=
 =?utf-8?B?TGFacnc2c2xiem1DZG4wRk5KalZ0bTVYdC9XdE1BYUh6TWM2OTU4TUVvZ0tB?=
 =?utf-8?B?NFc4OW5DeDBkSnl6NDRNM3NmMXlnVVR2Uk9GQW9jZ1NDMzN2R0RQbXdDSG52?=
 =?utf-8?B?c3I3NmkyWkRpQ3hWSVFMTDI2azhXajVLUEV2N3VQeG9BWWdQbWk4aWFTeUlx?=
 =?utf-8?B?SCtpRDN3STUxSjAxd2FPNmV5RjZhSWExTlA5ZWh0eHRNamw0aUlqY0Q5dzI2?=
 =?utf-8?B?MmhwM1N3RDBOSXZKdmM5Mzk2UllGNlBqdVRMcmdkSHNpaUtBYmFIMXNHUmRE?=
 =?utf-8?B?WmhSOHFoQUhROUFsdUdIMzJNRzNRL0N6bEgrbVd0U3FHaWt5QU1SMjY2NUZu?=
 =?utf-8?B?ellaWm1jaTBnK3RWaTIrOFRzUXB6c1h3Sm5wZ2pNMkVjdDgzQk1yYnZQOStQ?=
 =?utf-8?B?ZHNyM0NMUENrOWI0UTBrREl3aXpnaGs0S20vZVhVV1k0MndFZytPVVd5NnIx?=
 =?utf-8?B?SklwMWhHWFFlUmJvdmRwbFZtc3VNNmZLWkY3ZGFGUmw0SUVMK2pIeW1LQjAw?=
 =?utf-8?B?THBBSEI0YkJ2QkIrYmV1NjNUM1FjTW10T3pYQ2hqUDljaVh4aktOb2hCK1JS?=
 =?utf-8?B?cWZXaVZGRTUyT1JtbS92ZUZIMDJEM2VYK2l1R2lNV0NNbWJIZVlXKzBHRHo2?=
 =?utf-8?B?cGtQNU1iNkt5SFpRa0NnWXN2WUh2VlN2ZnA2enhJSHdYUGRmNkRsclUyU2t5?=
 =?utf-8?B?MGJnRU9TZWxFZ2orMjRzQUNMbEU0eFIySzJvUUtSNC9BVG11dVNxNGRqcVhG?=
 =?utf-8?B?K29mVlBVVVpTV3A5S3FXUUZCckROTXladCtWeDdyN0xPak03OUlpNXYraWRt?=
 =?utf-8?B?OEt3ZURMZDVURDdGS2xUcFVwcFlsNzRXQjBTdlJqeDFCQzBKdzRHdGRYYTVD?=
 =?utf-8?B?OUx2Y2JhajhaaHoxaVhVQ21BT24xT3MwU1E2YmdmdEY1VDJDSXhNTHdpWjFY?=
 =?utf-8?B?ajVXSm9pVmtrcmsreWhXVG9nQU16R2ZsMDVxamhISU5QQlE1M1BxbkpFTlhi?=
 =?utf-8?B?b1hOUWdnZlBUR2xVTUlHTERFMFQ4OVBHVDZWK01qQ05FcjlBWWhMY0ZDaUZw?=
 =?utf-8?B?Y1EwNCt6MlMzVERtRFhzVFA2cUUvejZZaVZBVGRYWVRtcnNIYkw1YUp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUlvOGRHMUFhVUlqR2FkVk52YXZaeDRadldHZm9vZHNBeDBKWVozR3p6cGVR?=
 =?utf-8?B?U2txb0NSUFNjQmhXQnhJTG9YVjF3UnliVGEzOFZudmtxZmdaVUR3RUp2S3pE?=
 =?utf-8?B?T2pBbXVlKzdrU2dCMTVodVVFNmJ3OHd1YzBXRnZjeGxVOTVraEYzTjZzT0lZ?=
 =?utf-8?B?bDlhQmdaL3ZqdzZuUFBTRHVmb2R5SEhDT3R4MUNaYVgxTFNDd3EvdDFPRzJy?=
 =?utf-8?B?MVNDVWFhQXNzTFdNVU82RVdqdk1OMmFWMGgvcFZzYjlGeDM5MVNzY00wMEZL?=
 =?utf-8?B?V09YVjJmTmVzWDZaaTBCM1lwV2RFRnBoa0JLUE1iRzhLRnpRRlQwQVhJQm11?=
 =?utf-8?B?WVFFK3RzNmxpRnJqUUV0UmYxdmZpdTlFaFordFAxSHRQclUvWVhaYklFakU3?=
 =?utf-8?B?VGIxbnU5YVc2MlpSbDhPemM4cVV4S21mTGdoUStXRHFyWFBSRWFBWVlMNExj?=
 =?utf-8?B?S3JSWTAxTzBjMkEwNXIraEMraUVlVFdmTUF1Uml6YjJLQkMxV3FKSE8wM1hK?=
 =?utf-8?B?ekpDM3FKSytBZDRXdHNwMHRzWEZYc1JrbjNCVDJ4MWloTTBhR0tNTlRwN3lk?=
 =?utf-8?B?Vkp6MDZ4MjJ2bVIxeGRWT0ltbmhLRjU3SXo1Wm1pS2F6UUNoK0d3WFlEeWZJ?=
 =?utf-8?B?emxuN3ZpTXAvZk5wcW9sbUZkd1dhQkxEeThKVVpaMUk3Wm1CVkxOYmxkMDN1?=
 =?utf-8?B?bzgvQXNnYXRNVFNmcXNaU2N5cUxpdXRuNk1Mc2RpZkV4bGhDU1AvMlpsajBY?=
 =?utf-8?B?WUgvTUhMSEs5YWt4SzVuVDU3T2dmdnVWR2l5NS9PWWdhckZiWnAyaGVuUlQ0?=
 =?utf-8?B?ZDF4ZW9YeE56cHVwV2pTbmU4bi84QUxWOG5xRWhaYkRYaEY0R0tQY2ttZDVN?=
 =?utf-8?B?cWh0Z1JZdDkrSENxM296SnZTRzZHOWJZcTZXNWhZRW9uMkpVYXRtTUliMTEv?=
 =?utf-8?B?MG5qSVhRWHJLb3ZTWjNEbHFabkVOVm0rclFkZ2ZYa2E4aEFSUGNrWVJqU2pa?=
 =?utf-8?B?eG9sczVqeksvY2lPVVBPZzhHSUNiUlN4T25JcUpleVpiSXBCR1A0KzRnY3Bi?=
 =?utf-8?B?NTFvdFNieG5KWG9EdHlNOFdxYzM4TjNZbDhqNkxZbnlxLzQrQ2RudVlkZHFM?=
 =?utf-8?B?d0tma3FYQXNYY1dxNHRyakxONjhYTWlLaGdDd0phT1lMS0FSSURNcUhvSkVx?=
 =?utf-8?B?dlhGL1J2QkR3QUpac0VSZ2F0bXYzczY2ZHRZa0NYY2Voc2xpR0ZJcGk5VDlh?=
 =?utf-8?B?K0lobkFiR0FBeUJ3VVBBVGNzZjRaaVd4ZXJSMWtVTmhvdkFtUVlUQm1JdEwy?=
 =?utf-8?B?bFplRC9YVnpHUDRxSHRCNmNzVmNqMU9pQzJFYTd0d3Vod2NLeDcyODJVM3hN?=
 =?utf-8?B?Wkt2UVpGcVQ3aEFRTkFhc2dPK3ZnSWZ3UUN1MC9PVjRPR2F0ZTUvM3NqZ0Y5?=
 =?utf-8?B?K1ZUK3p2NHdkZzU0S3Q4dDBsRDcxdWsrRG5idW1FMGhLdG5rUkVKTXc2T2VV?=
 =?utf-8?B?U3NFTm0zMWswREJpMTh4YllPQ1IwZnRxTWVkVlRiRUhOWlo0NDBjZlZZa0Uy?=
 =?utf-8?B?SVpaNUdtRmZHMHhTRHErbHgxSUJGZW1KdWh6NzVqakk4b3J1alBBcjVUT2dk?=
 =?utf-8?B?L2E3cjBkWEluWXJlZHI4TExDbDRkcm9sOExoWVRwbDJ0ZkpTVHdoQUEwM2VK?=
 =?utf-8?B?dDl1NXNtSlJEM09vUmM2V2JWNTFUazRQcEg0WjV6ZkFjdzk4aFBRMEhnTy9z?=
 =?utf-8?B?aHRXSUIyZVBXOGhwS1BrZU9nSWpPdEI3Z3l4aUxERnVZWkJHdWdCTnNvMEVE?=
 =?utf-8?B?YkFRRk1KbHFmTlRZWkJJNFBVTTlpRDZ2cDg2WC9mcGRNUHBQSTV5MFBWSGo0?=
 =?utf-8?B?MStnbmxRWnNzWE9rbnlUM0w4QWJ6cHFjWFQ3bVNnV094Z3J2OXI5SkY0amtM?=
 =?utf-8?B?eis5c2x2cVFlVDJTMEhjcnd5dlRaNVdyamFFVWVBaERKbTlyNkhxZlJqalpR?=
 =?utf-8?B?NDl3dllGU05YWkhGRFp1aTB2cnpnWWM5RnZaaDE0NU9qbkpLdUJmUWhoMWlK?=
 =?utf-8?B?SFdQdEFRV2t0RDBxVXIzUWRWT0tOdHVDbitkRUlrWkJsWUV3ajNkTVpvR3dM?=
 =?utf-8?Q?d2gRdrZ5WUCQQzs52XNIBAbbR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bca36f-63f3-4e9d-f778-08dc90977f91
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:39:13.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciQuM7cTUUl7JD6jbQOe/3epxSeiBen2dbP8g4wMgcl2m+K3hz6iqlv4Pd4eCZNXtmn27U+W29bJTOoTcz6fJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

On 6/19/2024 04:16, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.

s/changing/changes/

> 
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate-ut.c |   2 +-
>   drivers/cpufreq/amd-pstate.c    | 112 +++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.h    |   1 +
>   3 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index fc275d41d51e..b528f198f4c3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -227,7 +227,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>   			goto skip_test;
>   		}
>   
> -		if (cpudata->boost_supported) {
> +		if (amd_pstate_global_params.cpb_boost) {
>   			if ((policy->max == cpudata->max_freq) ||
>   					(policy->max == cpudata->nominal_freq))
>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0c50b8ba16b6..1c2320808ae1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -104,6 +104,7 @@ static bool amd_pstate_prefcore = true;
>   static struct quirk_entry *quirks;
>   struct amd_pstate_global_params amd_pstate_global_params;
>   EXPORT_SYMBOL_GPL(amd_pstate_global_params);
> +static int amd_pstate_cpu_boost(int cpu, bool state);
>   
>   /*
>    * AMD Energy Preference Performance (EPP)
> @@ -736,6 +737,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
>   	if (amd_pstate_global_params.cpb_supported) {
>   		current_pstate_driver->boost_enabled = true;
>   		WRITE_ONCE(cpudata->boost_supported, true);
> +		WRITE_ONCE(cpudata->boost_state, true);
>   	}
>   
>   	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
> @@ -743,6 +745,7 @@ static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
>   
>   exit_err:
>   	WRITE_ONCE(cpudata->boost_supported, false);
> +	WRITE_ONCE(cpudata->boost_state, false);
>   	current_pstate_driver->boost_enabled = false;
>   	amd_pstate_global_params.cpb_boost = false;
>   	return ret;
> @@ -1346,6 +1349,111 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> +static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +	int ret;
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			cpufreq_cpu_release(policy);
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else
> +		policy->cpuinfo.max_freq = nominal_freq * 1000;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
> +		if (ret < 0)
> +			pr_debug("Failed to update freq constraint: CPU%d\n", cpudata->cpu);
> +	}
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int amd_pstate_cpu_boost(int cpu, bool state)
> +{
> +	int ret;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy) {
> +		pr_err("policy is NULL\n");
> +		ret = -ENODATA;
> +		goto err_exit;
> +	}
> +
> +	ret = amd_pstate_cpu_boost_update(policy, state);
> +	refresh_frequency_limits(policy);
> +	WRITE_ONCE(cpudata->boost_state, state);
> +	policy->boost_enabled = state;
> +
> +err_exit:
> +	cpufreq_cpu_put(policy);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}

It is incongruent that this returns a 0/1 but prefcore returns 
enabled/disabled using str_enabled_disabled().

Can we make this consistent and alos use str_enabled_disabled() please?

> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	for_each_present_cpu(cpu) {
> +		ret = amd_pstate_cpu_boost(cpu, new_state);
> +		if (ret < 0) {
> +			pr_warn("failed to update cpu boost for CPU%d (%zd)\n", cpu, ret);
> +			goto err_exit;
> +		}
> +	}
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1356,6 +1464,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1380,6 +1489,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>   	NULL
>   };
>   
> @@ -1418,7 +1528,7 @@ static int amd_pstate_init_boost(struct cpufreq_policy *policy)
>   	if (ret)
>   		return ret;
>   
> -	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +	policy->boost_enabled = READ_ONCE(cpudata->boost_state);
>   
>   	return 0;
>   }
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 133042370a8f..fb240a870289 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -100,6 +100,7 @@ struct amd_cpudata {
>   	u64	cppc_cap1_cached;
>   	bool	suspended;
>   	s16	epp_default;
> +	bool	boost_state;
>   };
>   
>   /**


