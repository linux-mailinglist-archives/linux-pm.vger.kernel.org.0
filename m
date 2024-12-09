Return-Path: <linux-pm+bounces-18844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014569E9CC5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D023E166B64
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9745155C8A;
	Mon,  9 Dec 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kYE/O4Yb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1F1553BB;
	Mon,  9 Dec 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764557; cv=fail; b=ViQxpeCLDXk2HDBKJ/1P+SsXDRNWWEKl/bWIs87c+6zi4nqUuYS05hpxe8AuVJXmcAB0Lu6Yz448arRezjAY8VjrKtjeDiKUKf/Ip4Ry+Y/YSDYK76XnIt5NqJvTEj6oAL8pgNFI14WrXMK6OUuRvitIPGOIMESsoDYbqaqQuBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764557; c=relaxed/simple;
	bh=Y8QxjAMTb/DJfh6+BNxzsHpJ8PSWBdN3/+5BttH8Kwc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJAvFNpkE5T4zoKLBajxWSuJ75mE1Xnp/qzAp6NWjCmwEYEsoDtkBoB9ECgfQ4eF0eCWdfn1kIZNqwC7TQvNCsvApms6KkaAgZF/MM7RttZsZRYSR/KwbrAXCnZ9Mq54mkZWEx6ZyctK8vdgf8UlridtK/2gg+63AnTetj/jfWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kYE/O4Yb; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxIfMqI8eTxrtdkE772Jcf3AtKbLhRtIoj17hoQC8zZZ3+UWqPxL7loXcQ53PkxxOctjpo9APdehDl5y/P35DWv/ilzyJDAVyeqIrGlcAjPizFYEV4Sbd2mqz7+rECdPVGUoxa7UKBzsqg+twP73rQkv7IfGlXI7uGnEfC65bptn3jvU9XT01fG/OOWrXM7pjFhlfKj9dq+goJdq74GAocfU6Lcdbku0eGbTZgwKeq1yukXhYA/hnxPgo8IGadGn8xfp/bzodLUT97/0rnP33/FmIFZ50QuTFNh5ivUPX3zd0aCsI6ErufmlydxCQgIgg6uaKJ4pRRM0EmgTcmSA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b06uwZGbOQ/9uN+eB4NUwW2ctwBRfcmQ1+Y+J9bteg=;
 b=j3+SVdhTbVHc2fRSxWu9vuEeR/C33J9CY5zdQz1Ui7buJ4EAohYxCp8RppXm4YkM6Ci2zbK/dJNIJL/sPNOK5fUCAcY7HsWratD7nhR7rGk0HNpfxout232G+Ro8IZMammRG/KSVEa9AZurGjbV/LP2qgaGOqasBPz+g+cSqDvu1+wssIguIL6MFrfze5Tk6jell5W65dy63MadW2iuLDd4/iMRN0MFslQQ31OfyEIqGBm+Uu8Wk5zPiMWZtWMP4fIvxvNovL/uyGL7gQQQMn2xhPmSTn9zDLHLlH9qf345blNGDDqy5wakpQ7NeFiECFZBMSj00KERyqPsV5XFurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b06uwZGbOQ/9uN+eB4NUwW2ctwBRfcmQ1+Y+J9bteg=;
 b=kYE/O4YbRJ74iuLCFs0EHhivpFChQuMjOSCXF1fTRPwPrzwp45VYG/NDH9JNSn+hVWDhVbwxMdc0OK0UJ3ejOzN1EHzMvD8BdX/Kwa3+C8WCR0z31T+qw3/kbivIgaPtFnS2lteBReLgiGIGLCHLy3xs6hFB2euQyRGIm1BvCbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 17:15:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 17:15:51 +0000
Message-ID: <ca241dad-d11d-4145-8753-d5f18291bd65@amd.com>
Date: Mon, 9 Dec 2024 11:15:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] cpufreq/amd-pstate: Always write EPP value when
 updating perf
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-13-mario.limonciello@amd.com>
 <Z1atZRyH3dbWQYjv@BLRRASHENOY1.amd.com>
 <c9fc8ee2-db38-48e3-86ee-69a33eab1473@amd.com>
Content-Language: en-US
In-Reply-To: <c9fc8ee2-db38-48e3-86ee-69a33eab1473@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:d3::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f93921-9a34-4518-fa4a-08dd187521ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wi9yNVdNS0NmTmFxdm1xWmpqdW03clhPcGhzWkM2Y0d6SEZvckw4U1R6UHhN?=
 =?utf-8?B?NEtXTWRWQzNRVnRsSzByL2ZnSlZJNGhEZHg2bzhNQnZGajhnN0xDTysxeVF2?=
 =?utf-8?B?Y2VVakpaT3VOSlFWaW04NXJrSTAzQ1BMeHBpclZ3RmN5MFMvSXZITzl1STFj?=
 =?utf-8?B?NHZrSS80Z3NaUS9CUmJucUsyYnNGOG92QUtuSUwvbHZMV1ZranZSM2NLdGdQ?=
 =?utf-8?B?WFh2SExmS1BCSU9NWlFTY3NyclJkeWhiMWV5SGdVdTlpeWJjYmNxWVRFeTQ0?=
 =?utf-8?B?RkVVYmFYakFMNjFGZDZHWklwL29vbDVMMUkvVndhRzJBM3VVdWtFTmJQSnRK?=
 =?utf-8?B?V3lDYm5qTmhwbmFlVnkwRk9QTFJYRmpwb2dBQjJTR1plMGVQNTRlamwrb2xG?=
 =?utf-8?B?MDZHNkFxQTRsQ0hLb3NOckhOK2V4SFJ3VnhVYi90YVlGdWhCUXNNdGM0WWFG?=
 =?utf-8?B?bVM4WmlsQlp3SysyNXprYXppSjFtNTNubk5Da1grRUQ1L05zRndUbThiaVQz?=
 =?utf-8?B?Szg1VlQ3bkhNSnRpMkRiVk8xRjlvc2N3c2I1RzRud0hEbEpoNDROZFdMMnht?=
 =?utf-8?B?czBmTEIzbjJmOFJWaDdpanRRUUJrWW45TzJrd3FQa2FNVWJZb3Zlc1ErZzhE?=
 =?utf-8?B?bEQrNWord21keit3NXo2V1NUcGMyS1FSOXEzcnJXdHk3RDM4U3ZZemd5SXgw?=
 =?utf-8?B?L2JvVDczcEk1QWFVMjRGdTdEZzNqV2RXNmdjSHQ0SlJEUFdpbzNkMktHTkNa?=
 =?utf-8?B?bVBXQ3kvYkdJVyttZEQ2aGZIeVhlUUxhSUI0c2hRMzAraGlmZGdLM3I3K1pu?=
 =?utf-8?B?NWwxVXBuMURSdUZYNTIvRnBaYS8rMnBHWmpqRDJmeTdaUkgzS0ZES1JoWlRT?=
 =?utf-8?B?NzRkSlRVejV4cHhKd3dkWk5EWk9udVlhajdhUDhISXU3eVZNSE9yVW9Bd1Yy?=
 =?utf-8?B?L3JaSEEyV3NtWHNZN3kxT0o0RVAraG1iUUI4K1hBb21FTnJyaU4xbzk1NzhN?=
 =?utf-8?B?dGVHRlJWdDVwdC92YzBOZVBjRTdqajlKeGdWZjVZOVRvNjRYazZzZlNTaGRW?=
 =?utf-8?B?MGs4OVM0cHRSYWN2cE44b2NpdXdLNkFxeENkNlpJc0FLb3ZQKytrMHd1eEYr?=
 =?utf-8?B?bWdPbTEwblNpWThreEVYTnRFYXJNNStiMFpVeVNSUElVSmhYNm1zTlZoSStG?=
 =?utf-8?B?Q0VRUWhBSWg4K0d3S1dOcnZEdkVyQUVJaVZzemR6MHVmT21tY3ZaWkZWUjVM?=
 =?utf-8?B?eStMQ3ZUQjRwWXJ5M29FSEgxYjZIalNoWEQvZ1FhT3pYVzVZem4rRUNRNkxr?=
 =?utf-8?B?QUU0MW9qUGRmY2YvSmV1NkliY2ExUEl5b2w0VzRHcWRJcDUzMmRtdDFOOWUx?=
 =?utf-8?B?ZWZxMVp3MUFCM3RuVHVka2Fjc3NSUHpYNmVPT05hRHpqOXhHZXVHNXFqLzNv?=
 =?utf-8?B?S0YyNnlhYkdyOW84OEU5TmJhWUF3dkRTRzNFeWZzY1VwY1h3aFgwODRYWGdO?=
 =?utf-8?B?WERPMUkzY3NGcER0dzZhYUJzTE5Ga3lhWlpLZERETGQzblBoYzl2K1d3OUds?=
 =?utf-8?B?NUdKN29wTkJGYTMxc0l4ZmRWaHBzeHZsVzVCRG1vZVhKYitkcUVCL2daOHd2?=
 =?utf-8?B?UDBHKyswU3h5b2Z0MGFDY240dk9HK2tjeThSVTJlRmpDTFFqSmVnNVBxaUxJ?=
 =?utf-8?B?SlV2VlA0eEMyaS9OSURYY3VkMEpGK2FyK0dPU3BZdUJ3K1Bpa0F2c3BjZ1FP?=
 =?utf-8?B?OVZlRElETVNBalprSVIyQk5aVmlKdDRib3EyZ0lDNzFJYlpIUmgrY1ZUNWx5?=
 =?utf-8?Q?XeXBeMtKppWpcQAjKyr9LQU4hnwoatLI6MiUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBSQjhsWGMrNzZBODQ1bFd1eHRtV0NiaUd1ZDY1cHpiUmx4UEhUVFRNcW5I?=
 =?utf-8?B?TGRuZUg0WHViL0JSd0ZjaVVpRUcxU0xKUi93R3N5VllJY2xEWDNla1AzTjZ4?=
 =?utf-8?B?TkhWbWJoZmM5c2FhS21GWjlROFFQUGRQa0RPeDRUMWt3QU1mdXFvM29DV0NT?=
 =?utf-8?B?UFdBZ3ZRdDIvbEQ5OHJ5cTZJT1BWSWFLZGtOYUVBd2xGRGJHSUxBYVlEWmp2?=
 =?utf-8?B?bFYxdStHa2hIREtnNUs2aElHWEdpYU5QcktQRmV6TW9lVjk2K0FVV3BvSExn?=
 =?utf-8?B?ZCt3bWdJNzlvVVFlbDlGbUpibmFrd1BTMzljdnYvcWdmUE1ST2dSbnlFMEp6?=
 =?utf-8?B?VkhWWkRCUjErcUpKYTVOSmVkaERWem1YVmlyeTBLbWVZcHU5R0JEZ25DaVp2?=
 =?utf-8?B?VnZzZWo0ZFZwZjBVVkZ1MU1TWjRoa2I0Szl0eXR0bS9HMTVMWnQyNlVManZp?=
 =?utf-8?B?RkZFYUY0dXZaL1JDbHpSMDVmT0JaMHhpVWc2S1ZqZktDK2lhMGNwamFLNWhn?=
 =?utf-8?B?UXpqUEhmdWVlb3pjT01hREJvNkNKcWRwWWVrbGpWZi8xRTYxK1FubmlGQ0JV?=
 =?utf-8?B?ZnkyK3pFMDR1RWRLWnoxZTdPRmlaOUdwd0NsMUJ6alExaWNkQWVzN0R0c1pv?=
 =?utf-8?B?aE1NVHpQNDRJY1pRVStlVGRMMWI2UC9pWmNGbkxXWU44dU9YRWE4cEp6dDJa?=
 =?utf-8?B?WHlmellDZWNUdFRuLzN4RzVZalF2U0tMNnUxNDN6N0thVFFzVlJtd3BtbDkw?=
 =?utf-8?B?U0t5eXZhR0h3ZDVtOFJyVzZaMlA5YTZmRkJ2cVUybnEvbzRVTmZ5SVZFZW1I?=
 =?utf-8?B?Z082eE5yTnFmdVlEeU02YlZ3OW9aYUltSHRnWHljS1cyeE5MSUhvaDVhbHVC?=
 =?utf-8?B?RVVVWXYzYTdjTmEzTWtadXE3L2JDeCtQRjZ0aXovaWhuYW90dUZhWG95eTI3?=
 =?utf-8?B?UFVLbVpqZWh2bGIyUEhEQTd3ZkRMaHdtdVNjdHl1ZlAvL2ZTbEFEcUhJOHFw?=
 =?utf-8?B?ZHA3b0M1WkZCbmM0bjJBaHVMWTFWMDdoWm5FSktIKzk0QjUzbVptcWZrVTVG?=
 =?utf-8?B?OXZVL2MybVFlZ2VCbFBsTzV3MkZZMXpXWUJyVzlYOUFqTFh5dXAxVlc2SUFQ?=
 =?utf-8?B?Q1FxRUZnellENHdkbU9qMHZ1bWhJTW9oUDhlVnROR0RaSFh5NlU3UURnZmFu?=
 =?utf-8?B?U2NEelV0c0MxZHZTeVBBUjFPckoxRkhMWTIvbWQxeW5NTWQrdVdOMVgvZEFl?=
 =?utf-8?B?RGVzMjBwL0N3RDN5eEFZanVjUE9mRTB1WW5FWlU0N0gydXZlRytPV1Q5eWti?=
 =?utf-8?B?Q3l1UVc1em53czIvbDhPUWdxQXFsQmhNSjc1aWt5WkhRQzVCaEFobXB6MTZk?=
 =?utf-8?B?M0J2c29IdWEyR2l1aHVPSG1vY0dPeXowd2xBWlpoKzQ0aWpxblY3K0VIdkhv?=
 =?utf-8?B?NVllNU1uZWNhUDdxZks0R2Q1N2JidlBGbGVRaW1FUG1TZDlSMTZuSzhtNDUv?=
 =?utf-8?B?L3VwOERzMkFhVkhYSTlIVkYvanJGK3MxQnY5NDcrQkNJdjF3eE1HZ3B4UnB4?=
 =?utf-8?B?Qnc3ME5XQkVKaE5GUWpBbFRBUVA3RTMzdDJaTWVpVUZKTWg0RFZ3am1KYlRX?=
 =?utf-8?B?SEZIdHdkZ2NsU3JsTWtrc3Bia1hST3MxZFJaTTNJWUpTMzZZZXZ0bmVBYlhy?=
 =?utf-8?B?RVhuKytwMU9RRzh3Y1N4OUk3T2E0N0lqSXl1Mkp0VzQ2Ui9vQ0N0M0dZRHgy?=
 =?utf-8?B?N0RIM3lmSU5qWDFXaFJVZ1grVGI4TnBsSURObDB0aW4xa1lDYjNiS2dlNkkw?=
 =?utf-8?B?cWpIQlc0clVYdjd6MVJxREc2alpsMFRoSEMyR09wa21vN3U0andDc0hlMWNz?=
 =?utf-8?B?THpCYWgwZmxva0pOd1NibFFLclEyU0pESG5wN25HZEVJUUlUaU9Nc2RTcm54?=
 =?utf-8?B?TS9Ea0F3cWo4R1prZmVTRElCYWV5cC9jWHdjNEcyWFcwcENFZE80WVVITTdV?=
 =?utf-8?B?Nyt2bW9NTld0RTdBY3EvT3NzY0pBR3pOYXh4clh6bi82R09yVktkMkFKVWN1?=
 =?utf-8?B?Q2gwVmtTbUxETUtCbGIzSzJRYmFJZ1pFcWFwNXpKUHpCTWh4eE5XOWxiSjJn?=
 =?utf-8?Q?GZuuLh463wVHh18XP5lCiPuP8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f93921-9a34-4518-fa4a-08dd187521ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:15:51.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8uDT+LawRAYTPM3oEhlat67RBVBHENi27UO8OekhymDt7Xmb/FCOMUaCeuPjtXMgIO75upt0vYPayy4DR6RRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

On 12/9/2024 10:49, Mario Limonciello wrote:
> On 12/9/2024 02:42, Gautham R. Shenoy wrote:
>> Hello Mario,
>>
>> On Sun, Dec 08, 2024 at 12:30:27AM -0600, Mario Limonciello wrote:
>>> For MSR systems the EPP value is in the same register as perf targets
>>> and so divding them into two separate MSR writes is wasteful.
>>>
>>> In msr_update_perf(), update both EPP and perf values in one write to
>>> MSR_AMD_CPPC_REQ, and cache them if successful.
>>>
>>> To accomplish this plumb the EPP value into the update_perf call and 
>>> modify
>>> all its callers to check the return value.
>>>
>>> Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++--------------
>>>   1 file changed, 43 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index d21acd961edcd..dd11ba6c00cc3 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -222,25 +222,36 @@ static s16 shmem_get_epp(struct amd_cpudata 
>>> *cpudata)
>>>   }
>>>   static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>>> -                   u32 des_perf, u32 max_perf, bool fast_switch)
>>> +               u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>>>   {
>>> +    u64 value;
>>> +
>>> +    value = READ_ONCE(cpudata->cppc_req_cached);
>>
>>
>> There seems to be a mismatch here between what the API is passing and
>> parameters and how this function is *not* using them, and instead
>> using cpudata->cppc_req_cached.
>>
>> The expectation seems to be that the max_perf, min_perf, des_perf and
>> epp fields in cpudata->cppc_req_cached would be the same as @des_perf,
>> @max_perf, @min_perf and @ep, no ?
>>
>> Or is it that for the MSR update, the value in
>> cpudata->cppc_req_cached take precedence over the arguments passed ?
>>
>> Ideally, the "value" should be recomputed here using (@min_perf |
>> @max_perf | @des_perf | @epp) and that value should be cached as you
>> are doing below.
>>
> 
> Yeah - that's what the next patch does (which I think you probably saw 
> after you reviewed it).
> 
> Do you think maybe I should just squash the two?  Or would you be 
> happier if I re-ordered the two?

FYI - I looked into re-ordering and it's not feasible because you need 
EPP plumbed in order to validate the result.

So I'm going to squash the two patches, and I'll do another one that 
adjusts tracing locations for your other feedback.

> 
>>
>>>       if (fast_switch) {
>>>           wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>>>           return 0;
>>> +    } else {
>>> +        int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>> +                    READ_ONCE(cpudata->cppc_req_cached));
>>> +        if (ret)
>>> +            return ret;
>>>       }
>>> -    return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>> -                 READ_ONCE(cpudata->cppc_req_cached));
>>> +    WRITE_ONCE(cpudata->cppc_req_cached, value);
>>
>> Since cppc_req_cached is not changed, why write it again ?
> 
> Because of the next patch.  It will look at cpudata->cppc_req_cached and 
> determine if anything changed in it - including EPP.
> 
> 
>>
>>> +    WRITE_ONCE(cpudata->epp_cached, epp);
>>> +
>>> +    return 0;
>>>   }
>>>   DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>>>   static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
>>>                         u32 min_perf, u32 des_perf,
>>> -                      u32 max_perf, bool fast_switch)
>>> +                      u32 max_perf, u32 epp,
>>> +                      bool fast_switch)
>>>   {
>>>       return static_call(amd_pstate_update_perf)(cpudata, min_perf, 
>>> des_perf,
>>> -                           max_perf, fast_switch);
>>> +                           max_perf, epp, fast_switch);
>>>   }
>>>   static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>> @@ -459,12 +470,19 @@ static inline int amd_pstate_init_perf(struct 
>>> amd_cpudata *cpudata)
>>>       return static_call(amd_pstate_init_perf)(cpudata);
>>>   }
>>> -static int shmem_update_perf(struct amd_cpudata *cpudata,
>>> -                 u32 min_perf, u32 des_perf,
>>> -                 u32 max_perf, bool fast_switch)
>>> +static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>>> +                 u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>>>   {
>>>       struct cppc_perf_ctrls perf_ctrls;
>>> +    if (cppc_state == AMD_PSTATE_ACTIVE) {
>>> +        int ret = shmem_set_epp(cpudata, epp);
>>> +
>>> +        if (ret)
>>> +            return ret;
>>> +        WRITE_ONCE(cpudata->epp_cached, epp);
>>> +    }
>>> +
>>>       perf_ctrls.max_perf = max_perf;
>>>       perf_ctrls.min_perf = min_perf;
>>>       perf_ctrls.desired_perf = des_perf;
>>> @@ -545,10 +563,10 @@ static void amd_pstate_update(struct 
>>> amd_cpudata *cpudata, u32 min_perf,
>>>       WRITE_ONCE(cpudata->cppc_req_cached, value);
>>> -    amd_pstate_update_perf(cpudata, min_perf, des_perf,
>>> -                   max_perf, fast_switch);
>>> +    amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, 
>>> fast_switch);
>>>   cpufreq_policy_put:
>>> +
>>>       cpufreq_cpu_put(policy);
>>>   }
>>> @@ -1545,6 +1563,7 @@ static int amd_pstate_epp_update_limit(struct 
>>> cpufreq_policy *policy)
>>>   {
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>       u64 value;
>>> +    u32 epp;
>>>       amd_pstate_update_min_max_limit(policy);
>>> @@ -1557,23 +1576,19 @@ static int amd_pstate_epp_update_limit(struct 
>>> cpufreq_policy *policy)
>>>       value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata- 
>>> >min_limit_perf);
>>>       if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> -        WRITE_ONCE(cpudata->epp_cached, 0);
>>> -    value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
>>> -
>>> -    WRITE_ONCE(cpudata->cppc_req_cached, value);
>>> +        epp = 0;
>>> +    else
>>> +        epp = READ_ONCE(cpudata->epp_cached);
>>>       if (trace_amd_pstate_epp_perf_enabled()) {
>>> -        trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
>>> -                      cpudata->epp_cached,
>>> +        trace_amd_pstate_epp_perf(cpudata->cpu, cpudata- 
>>> >highest_perf, epp,
>>>                         cpudata->min_limit_perf,
>>>                         cpudata->max_limit_perf,
>>>                         policy->boost_enabled);
>>>       }
>>> -    amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>>> -                   cpudata->max_limit_perf, false);
>>> -
>>> -    return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
>>> +    return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>>> +                      cpudata->max_limit_perf, epp, false);
>>>   }
>>>   static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>> @@ -1602,7 +1617,7 @@ static int amd_pstate_epp_set_policy(struct 
>>> cpufreq_policy *policy)
>>>       return 0;
>>>   }
>>> -static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>>> +static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>>>   {
>>>       u64 max_perf;
>>>       int ret;
>>> @@ -1620,17 +1635,19 @@ static void amd_pstate_epp_reenable(struct 
>>> amd_cpudata *cpudata)
>>>                         max_perf, cpudata->boost_state);
>>>       }
>>> -    amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
>>> -    amd_pstate_set_epp(cpudata, cpudata->epp_cached);
>>> +    return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata- 
>>> >epp_cached, false);
>>                                                 
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> On an MSR based system, none of the values passed here will be used,
>> and instead the value in cpudata->cppc_req_cached will be used, no?
> 
> Currently; yes.  After the next patch that changes.
> 
>>
>>>   }
>>>   static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>>>   {
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>> +    int ret;
>>>       pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>>> -    amd_pstate_epp_reenable(cpudata);
>>> +    ret = amd_pstate_epp_reenable(cpudata);
>>> +    if (ret)
>>> +        return ret;
>>>       cpudata->suspended = false;
>>>       return 0;
>>> @@ -1654,10 +1671,8 @@ static int amd_pstate_epp_cpu_offline(struct 
>>> cpufreq_policy *policy)
>>>                         min_perf, min_perf, policy->boost_enabled);
>>>       }
>>> -    amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
>>> -    amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
>>> -
>>> -    return 0;
>>> +    return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
>>> +                      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>>>   }
>>>   static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>>> -- 
>>> 2.43.0
>>>
>>
>> -- 
>> Thanks and Regards
>> gautham.
> 


