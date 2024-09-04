Return-Path: <linux-pm+bounces-13584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223B96BF55
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FB51F22E3A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A951DA615;
	Wed,  4 Sep 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OKidVLr6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4531DA2F7;
	Wed,  4 Sep 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458247; cv=fail; b=En5NrlklJMYPScOia+l+vtc2+t7Ws4yVMJdN8b0f91d4PScYGIgxk9Mzy9C2fZv+8Qjh/h8taYcBv4IljNJpvxKjdSzuC3rAjOHIxvAKsUGaUX6/reMS0q4rgOUgaRFpOD8/RIqEnlIIrbzGQPlyrC3MqPIV/gQIpyhJ8N5nGmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458247; c=relaxed/simple;
	bh=fFHmtZle67q5tOBWhCZ+wxgZD0FA5KyotP+7WzNJxoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fsux5Mtj3yrRnvhUS8la4WnHzLjNROBxMnFJTBpvzJ7Uk7RAq3PAu3wAr9MFh/wnU0u7kAMpzwnuQzO2r6/f3b9ltzxssQdgAJgNUQujaO59c9WvlaJjZd+8txSJyk+TEWeBFPzlQSaGTNLkRjNcBpSEht+umcuC8S88Lg5AIw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OKidVLr6; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/NxxwxRcjT5hxheCLBSdMU2OLSR5OuOCzSeY68V8RGEARAvH+Rr9NTP1nD9E8TotpGeTgvxTWP1TUdKhm2F7KHZjfI0Mm+5WU2i5rcfQ8DKVMMHA94KBVUi94epM+vpCnXrET3OCbWjUSGdcpr7o5qDj417Kdxphf+YQWFpGNA6naGSc/y0eCPa5hJDTqJ6R/+4F9ivi5UVJOSOfPT+d7D3aSCzxPDJxxZbWFc8fJP3tlDH6Nzj8zkG/xAyNmWvnAdnO+4/S5Imrhv61POvaIlJ0Cndks8N1xqbxtg2S58ZZD7CPmFrCSaoXg+1zt3/bIRGFGHtIJdP8SRxIwtVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TipLLk915/Bwp7VrJzUDDhBWwqiH0OrylyU0qTX2Yyo=;
 b=RBNWWbRhrbz38F9U8M5FDsvP1xD13F6pDvoSPoZksqWiio92C36rEexqaQrGMY/SsFAG+7tZBNUyhVce7APF4WQ0JivNBZ3kYTa75YiOdkwPlpLT6y1ejLF9ZumeLbP1qTE86uqsU/GRZd5UELkfVZ7Zi7XwAUvqkMVcNACP2YWTd26EWI0u25EcOmCX2ShdAKDBoiPpxW6wk6oyga87O6wHk0/sZIJNXwxf9/LMlmxF/4npJQC3gSmLoHCuNqwW3XVudFYD3WMPPxYUYVk3GR6YdVzXCYEEuGTOWURpDlRmlIbZnBLvmFhb3NNXkau802aoiVyX1G8TGMafMMAHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TipLLk915/Bwp7VrJzUDDhBWwqiH0OrylyU0qTX2Yyo=;
 b=OKidVLr6NU4Y6S7seqPMs29fZgnlJVWtwcVVV3C/PftlwZ+HaPPEa0NzNEsxiNT5BP+HZAlwgKBtbd2SGjsi/zn1FSHJU9UAnkTSxrEr7wkzqCmgzRXjUThGQpp1GguOiuNPsGIl/mv6EYdu9OF1ULIKIi7Hs31HZRRUBaiM7ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:57:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:57:21 +0000
Message-ID: <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
Date: Wed, 4 Sep 2024 08:57:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
To: "Jones, Morgan" <Morgan.Jones@viasat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d6477bd059df414d85cd825ac8a5350d@viasat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 878ca827-2237-452b-998f-08dccce97f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZmL2RNRFY3TlRpM1FGQmc2REVQcm1EQThmRVFmMjRTYkN0MXBObm44cWww?=
 =?utf-8?B?ZUVlNFFjNmdTaDRlZXRBV1pvdmUxamQ3SGRPNGRxSG1EaFVyc3hzSGNIVXQv?=
 =?utf-8?B?T1F5VktkUHV3dHR5T2J6WmVrUVZlQ3hqRzZaTjA3UDVvd1BYQnlJMitXb3NW?=
 =?utf-8?B?NCtFeDZ6bDhpOUw1WllNZUo5Z21maUNaT1BXUnZDTGtFaHNIdmNqa3ZBbnJV?=
 =?utf-8?B?K3Q3VzBQT3NTZHpaaWM5M3lzMXZqM0VOVjRCci9YcDhsS2xwdzNsZHBrUkR5?=
 =?utf-8?B?Mkp3WVBXNDJESlJxdVhrM0ZGVVV5SkZ2dmJLWWdvRE5iT1dGeXcxZVh5bHpH?=
 =?utf-8?B?T0ozMHlnWVI0eWV1Q0t1TVRjbkhJQWN2eHdZSVpVWUcyRW9hM1UzaldFNHlv?=
 =?utf-8?B?SXk1T2tSSGNsWEVHV0M1SWMrNFhpNGhNcS9CbWxxR0xBN3pNcXlUSkVNZDQz?=
 =?utf-8?B?WVhuZW1LRW9XcWxPYkYwUjg3QmZ6SFZ6TWZjY1h3UEp2bndGankyRGJmT0Qz?=
 =?utf-8?B?bU84NXFRRDlrTzJ1N1VlVFl1S2kwVWlrVi9VUUFPQS9mYkI3OFRnbCtlSGtl?=
 =?utf-8?B?dUZGc0J5R3QxT0F2MCs5VTlRNTBKYmxWU3huM0FkNzVMeUFscEJLdDlBMUpI?=
 =?utf-8?B?TTFYTzdOZWtlSnpDYVA5TUlGb25Ba2Rnb0pxUDRoeER4Y2tIb3NEakwvS0JO?=
 =?utf-8?B?dkRCeWlLbWdtNlNzWmRZZE0vb0xzbUoxemduajlwYlVHWTlNNHA0dWhIa3lQ?=
 =?utf-8?B?dGoyT2hrbnREdVYxcG12dmRBb1BZNzdVbVRpb21oUHJ2SFR5YkFLUmN6MDBS?=
 =?utf-8?B?Zzh2TkRZUTZBbGt1TmViVXp0aHZMWkN4b2JKQWkwOTA0TTVmRTRRbFZMekps?=
 =?utf-8?B?VEpSaEhlS3BDbzh3ZDRmcmxRcTdUQjdXREJWSk5JTlh5b3ZPTU83L2VMUlJq?=
 =?utf-8?B?WWJ6MUdrZkxSNE1IWEtJOGIvckhTNmY2Q2UxRUx0a1NYd3d1UUprQTJGSS9S?=
 =?utf-8?B?cStmVUhNaDRhUjQyZmY4UXpXQ0RoM0ljR1hLY3NSNTF2NXgrQXVPVm1LNXBj?=
 =?utf-8?B?OGFCMzU1bGFjRXpXNWhETWN5MUhxdEtDS1Bsb2MwbDRHemNNLy9LemNUdnBw?=
 =?utf-8?B?OHZhQkR6RW5NOFNLQld3NHlMWE5CTGZwbUI2WDU1OFNuUVVWSHdOL2VTK09u?=
 =?utf-8?B?OEJ4UkFKUkw4Qzc5MHgxenhFYnU2NHJGNXRxUTdJRUdKWkpmdUhJQ3V4QVJx?=
 =?utf-8?B?ZlhURERLTDNkMWd0WGNVeXRwa3VPck9VYmZza2VDeU9INityZVVlWUdXN1JS?=
 =?utf-8?B?WU1LMVJDS3Z2ckcyUG90d0xJemF2TTZocGRKaVY3K2Q0YWR2elhML084Rjc1?=
 =?utf-8?B?RzNKWUNncE9lQVJYYlJ0VnhBdnhuVDBqSU1rZS84dkRuL2w4cjZncjNIb1Nv?=
 =?utf-8?B?UkNVWG9idWJWdUY3QUZ5MTFMeDV4VFRHTm1UVU1qeDZPUkE2UExHZmNGNEMz?=
 =?utf-8?B?WjBoUGh4bWlnYVd2NkZ1QldnQzZpQytoaW51emRqcVBNUDlzZDU2Lzk3T3BG?=
 =?utf-8?B?Y3VYMnFKRzlIbnBPZSsyWFNmKytJWExFMmhwWStVcjl5WUVkRHdHWVBudW5H?=
 =?utf-8?B?NmQ4OExoT3VkOUFqY3NOSUlwS01wVjNhcmpBVGVMTERSMXMzRUFIMTBUK3Yr?=
 =?utf-8?B?MlJDTEhjWEJoODd5ZnlJSjJnMVFLL1JlY0l4d1ZKK2laQUtFZ0Q0SjErQ3lk?=
 =?utf-8?B?QjRzRUNWOWwzK0w3MnpQTGR0SWI1cDN3dnh1OUdBaU94RUlJSlJtOHZiQmd5?=
 =?utf-8?B?Snd0dVhac2hDd2tWYjg2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHIvazRZQVdJT0RkUnE4SEtqZjJMeEpxdGZyMjRZcms0NW9OWEQvTUZVMElu?=
 =?utf-8?B?Y29CYnBWajZyd0I3cG44Y21KUFlva2dPam9uSWZjSUd6MndUbEloRVYwQkpN?=
 =?utf-8?B?bUZScWVQdkZURGt5a2dkTGszZ3BMUXR3R2d3U0lLbFI5eDRGN3RKanVHZ1Bu?=
 =?utf-8?B?TUMzSHdzeWJzNUR3MTM3V0xFNkN0SWZHTVZjVkcvaFBTM3JmaEVvSW43SFJL?=
 =?utf-8?B?SzE1Ymt2YVFCUHAyOHpVVk40aVFLdVhOcENmYVJrVjltczZ2UmUycnhXb00z?=
 =?utf-8?B?SThjNFpwTlpWb0EyVzk5SFFyMmprRTZxZFI2V2FvaElBZ3Mzd2lLejhmcHNN?=
 =?utf-8?B?c3VWelVZNGltT1liSGpoNWFseVVyN1BNV3poYjJTRXhDMXB4d0Z2czVhU1dO?=
 =?utf-8?B?d1dvZ0VVbVJnaVJabllVdnpaY1JkNnlFcHY2bjlyUVJtYzhlWmkwN1Q0WEdo?=
 =?utf-8?B?UTVJRGtVcFNsaUVmNmpRaXNTUnZMd0Ywcko0c2pSbDJRL3dNWm1xZGl0VU95?=
 =?utf-8?B?UGRVcnJtQjVqb25aR3dVYnh3NTdEN0d3ajRpemJmc1pqSHpjcC9aRXFsbGIw?=
 =?utf-8?B?Q2dHaG5KcmFZcm5ndDNOR0RTeTQvODBLcU9ocXhuMGtwcVgxU3UzekJQY2hr?=
 =?utf-8?B?emQ4SFdwUXRkN2tEbW1XdU9RMjZyMWdvTVB0bm9BWlltUzBrRUFBcVhueVhN?=
 =?utf-8?B?UTBsc1hjbGFJTDVvZFdCa0JyeVJ3cWpYNTZvNE1wNHpXRHVUM0kvTW5jb2xx?=
 =?utf-8?B?a0sxRklsNmdta0Z3S2QyeVR0TUhQTlJZQWRvRy9DUFYxQnphV0dLSXBrcktP?=
 =?utf-8?B?SXAyZ1IvT0M5MG8zR2ZrLzkvc2R2MWFmZ0MzWis3eHIvRFBNeDhQdEZSUGQy?=
 =?utf-8?B?NWp4eWpvaGZTVDBuRWRBSXdqTlNXVWhURWdXcnJuYnBIc0VBelRhNE94Mk5x?=
 =?utf-8?B?OENSSjdIQi8vTC9MTW1PcnZ2UDhiZU1rdFFRTjZZSUZXaHpFV0JLNW8yUHVt?=
 =?utf-8?B?SjZhRTJ3U0hFdmhQVEhrdW1wMi96bllYRG9vZ0wxTG8yMGQ2cjdqZ2w2ZENT?=
 =?utf-8?B?Zk80U0N2ekpFaWh5WGViN1d0ODgyL1RIalRxREhNNnFDT3d0OG5idWhpY0Ji?=
 =?utf-8?B?cEd6OVN4cXhqRnp4KzNTdlVXOVBDRWpUb3I0clNOMGYyYlpqZjg4Tk03bnhV?=
 =?utf-8?B?cU5sYitGaVZZb3U4dlpQTnJlQnZJblkzdGNNdWZiaGl2SG9TT2J4TjI5QnJq?=
 =?utf-8?B?QTc4dFJreTFrNXZOS2FPRDYvQ2dDZXZJZWxFdzBpcXczODB1VXQ1ZlNmZE1N?=
 =?utf-8?B?UVN2S2VpWnYzMkNEMjlmYUhNT1lRdFFLOW1SR09teG52eXIxbG8wSk5VN3pL?=
 =?utf-8?B?NytVU3FDS1RsRkZTYXNEOGJuSnYra2RxUjEwMTBuOU5BdW5RUVNrOE9BQXpB?=
 =?utf-8?B?dC9Vek54ZlhVM2lvVGtYWEduZ3lENFo2VVNYZG9adVRRdm1BRWdsbGU2NXdt?=
 =?utf-8?B?ZXdReTFKalljaU1ycCtkTkRRU0gwL0JqU0hrWDFTK0k0a2FqK0NOMHJZdFZ2?=
 =?utf-8?B?SVJZOEVHdEhaekR1anZVQ2FtS2NZaWJhcmNCTXRiOXNsMHFrZnY1aTlWTXIy?=
 =?utf-8?B?NGM2R1FHRHdMUDRYNHQydmVQaHRhTXpGcU4rTHB3ZFpSTk5DcjdqYlNYb21M?=
 =?utf-8?B?cUJPVWRwTEdHYWs5b3llNU4rKzIvZDdoRHdLUFU2akg2cmVJcGNRaGtXMVJ1?=
 =?utf-8?B?VkxtWElXOC9UVDZZdGhuZE05SVNqdGVsVThodDhlTTY1WnFIYmNIdXlYUzh4?=
 =?utf-8?B?Ym44OHdnTWNYTWZvaDh0bForNnJRckNoMm53KzZ4ZjljbGo2NFZuQmNaOGdJ?=
 =?utf-8?B?YXFvZlBKWWo3eExwWW9qMlBGN3ZDU1AyYXQwLzRrVVJlbnlGY0hjdEFyY24v?=
 =?utf-8?B?M25GczFycFhKOGd4Q1BpWEoxYkp5VVprSnk3TzBUeVI2a2M2bG53UElpZTkv?=
 =?utf-8?B?QU8rWlp5UXZTM3NQODhNVnhCTGtqb3lnSzhnTllvU2tVbktwVEI1UFk2MTY0?=
 =?utf-8?B?em9NNnR6TUdaU2VRSTZmUUR1c1o4SVNtdDZTUm5icXdOREgwUGo3d05UaEQ0?=
 =?utf-8?Q?8g2m+c+0B/3Ng2DprSKJilZ8P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878ca827-2237-452b-998f-08dccce97f57
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:57:21.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ5swO8GrsCxnVlRfd0xvuRUQfOtPeCrakHWsqHT/gd/gTnGT8rVxmaNAg9xR2pS9o7+gCVqKEkcn1ecvSVzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

Morgan,

I was referring specfiically to the version that landed in Linus' tree:
https://git.kernel.org/torvalds/c/8164f7433264

But yeah it's effectively the same thing.  In any case, it's not the 
solution.

We had some internal discussion and suspect this is due to missing 
prefcore patches in 6.6 as that feature landed in 6.9.  We'll try to 
reproduce this on a Rome system and come back with our findings and 
suggestions what to do.

Thanks,

On 9/3/2024 17:24, Jones, Morgan wrote:
> Just to verify, this was the patch in question, correct? I had some trouble finding it on patchwork.
> 
> https://patches.linaro.org/project/linux-acpi/patch/20240227073924.3573398-1-li.meng@amd.com/
> 
> -----Original Message-----
> From: Mario Limonciello <mario.limonciello@amd.com>
> Sent: Tuesday, September 3, 2024 1:52 PM
> To: Jones, Morgan <Morgan.Jones@viasat.com>; Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com; skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David Arcari <darcari@redhat.com>
> Subject: Re: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
> 
> Morgan,
> 
> This does remind me of a clamping issue that touches some of the same variables.  Can you please see if backporting
> 
> commit 8164f7433264 ("cpufreq: amd-pstate: adjust min/max limit perf")
> 
> to 6.6.y helps for you?
> 
> Thanks,
> 
> On 9/3/2024 15:09, Mario Limonciello wrote:
>> Morgan,
>>
>> OK that's great news that it's just a backport effort.  That same
>> commit also backported to 6.10.3.  Can you see if 6.10.y is affected?
>>
>> Ugwekar,
>>
>> Any thoughts on what else needs to come back to 6.6.y off hand?
>>
>> Thanks,
>>
>> On 9/3/2024 15:07, Jones, Morgan wrote:
>>> Hey Mario,
>>>
>>> Smoking gun here, the max frequency is incorrect on 6.6.44+ but is
>>> correct on 6.11.0-rc6.
>>>
>>> Linux redact 6.11.0-rc6 #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1
>>> 00:00:00 UTC 1980 x86_64 GNU/Linux
>>>
>>> analyzing CPU 12:
>>>     driver: amd-pstate-epp
>>>     CPUs which run at the same hardware frequency: 12
>>>     CPUs which need to have their frequency coordinated by software:
>>> 12
>>>     maximum transition latency:  Cannot determine or is not supported.
>>>     hardware limits: 400 MHz - 3.35 GHz
>>>     available cpufreq governors: performance powersave
>>>     current policy: frequency should be within 400 MHz and 3.35 GHz.
>>>                     The governor "performance" may decide which speed
>>> to use
>>>                     within this range.
>>>     current CPU frequency: Unable to call hardware
>>>     current CPU frequency: 3.34 GHz (asserted by call to kernel)
>>>     boost state support:
>>>       Supported: yes
>>>       Active: yes
>>>       AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.35 GHz.
>>>       AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>>>       AMD PSTATE Lowest Non-linear Performance: 115. Lowest Non-linear
>>> Frequency: 1.51 GHz.
>>>       AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
>>>
>>> We're running amd_pstate=active and amd_pstate.shared_mem=1, and our
>>> workloads are back to normal performance on 6.11.0-rc6.
>>>
>>> Morgan
>>>
>>> -----Original Message-----
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>> Sent: Tuesday, September 3, 2024 10:55 AM
>>> To: Jones, Morgan <Morgan.Jones@viasat.com>; Dhananjay Ugwekar
>>> <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org;
>>> viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com;
>>> skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
>>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David
>>> Arcari <darcari@redhat.com>
>>> Subject: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
>>> scaling_max_freq setting on shared memory CPPC systems
>>>
>>> Hi Morgan,
>>>
>>> Can you please cross reference 6.11-rc6 to see if you're still having
>>> a problem?  I would like to understand if we're missing a backport to
>>> stable or this is still an upstream problem.
>>>
>>> Thanks,
>>>
>>> On 9/3/2024 12:51, Jones, Morgan wrote:
>>>> Hi there,
>>>>
>>>> We are experiencing a ~35% performance regression on an AMD EPYC
>>>> 7702
>>>> 64 core machine after applying this patch. We observed Linux 6.6.44
>>>> starting to cause the issue, and performed a bisect involving
>>>> rebooting the machine over 15 times. (Note that kexec didn't
>>>> successfully identify the problem, since the PM memory mailbox is
>>>> never reset).
>>>>
>>>> It appears that we are getting a max of 2.18 GHz when this CPU can
>>>> boost to 3.35 GHz, explaining the slowdown. Blacklisting amd-pstate
>>>> solves the issue at the expense of the performance increase we used
>>>> to get by using it.
>>>>
>>>> Is it possible that the upper limits were implicitly at the max CPU
>>>> power before, and setting the upper limit to something other than
>>>> the boost frequency can reduce performance now?
>>>>
>>>> # bad: [7213910600667c51c978e577bf5454d3f7b313b7] Linux 6.6.44 # good:
>>>> [58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9] Linux 6.6.43 git bisect
>>>> start '7213910600667c51c978e577bf5454d3f7b313b7'
>>>> '58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9'
>>>> # good: [72ff9d26964a3a80f7650df719df139f5c1f965d] arm64: dts: qcom:
>>>> sm6350: Add missing qcom,non-secure-domain property git bisect good
>>>> 72ff9d26964a3a80f7650df719df139f5c1f965d
>>>> # good: [0fffc2e1bf40a2220ef5a38f834ea063dba832d3] ARM: dts: sunxi:
>>>> remove duplicated entries in makefile git bisect good
>>>> 0fffc2e1bf40a2220ef5a38f834ea063dba832d3
>>>> # bad: [8cdbe6ebfd1763a5c41a2a3058497c0a9163311c] pinctrl: renesas:
>>>> r8a779g0: Fix CANFD5 suffix git bisect bad
>>>> 8cdbe6ebfd1763a5c41a2a3058497c0a9163311c
>>>> # bad: [5dbb98e7fa42bebc1325899193d8f13f0705a148] drm/mediatek: Turn
>>>> off the layers with zero width or height git bisect bad
>>>> 5dbb98e7fa42bebc1325899193d8f13f0705a148
>>>> # bad: [691ec7043122c9c8c46d84f6e6cd85d13d50cd93] selftests/bpf:
>>>> Null checks for links in bpf_tcp_ca git bisect bad
>>>> 691ec7043122c9c8c46d84f6e6cd85d13d50cd93
>>>> # bad: [a1359e085d75d7393a250054e66c0a7bc6c3dbfa] perf/x86:
>>>> Serialize
>>>> set_attr_rdpmc() git bisect bad
>>>> a1359e085d75d7393a250054e66c0a7bc6c3dbfa
>>>> # bad: [e99d9b16ff153de9540073239d24adc3b0a3a997] wifi: ath12k:
>>>> change DMA direction while mapping reinjected packets git bisect bad
>>>> e99d9b16ff153de9540073239d24adc3b0a3a997
>>>> # bad: [d027ac4a08541beb2a89563d3e034da7085050ba] firmware:
>>>> turris-mox-rwtm: Initialize completion before mailbox git bisect bad
>>>> d027ac4a08541beb2a89563d3e034da7085050ba
>>>> # bad: [e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1] ARM: spitz: fix
>>>> GPIO assignment for backlight git bisect bad
>>>> e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1
>>>> # bad: [b8cdefdaa555bbfc269c2198803f8791a8923960] m68k: cmpxchg: Fix
>>>> return value for default case in __arch_xchg() git bisect bad
>>>> b8cdefdaa555bbfc269c2198803f8791a8923960
>>>> # bad: [13a71384ae6a8779da809b00c6f378dcead10427] cpufreq/amd-pstate:
>>>> Fix the scaling_max_freq setting on shared memory CPPC systems git
>>>> bisect bad 13a71384ae6a8779da809b00c6f378dcead10427
>>>> # first bad commit: [13a71384ae6a8779da809b00c6f378dcead10427]
>>>> cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared
>>>> memory CPPC systems
>>>>
>>>> cpupower output:
>>>>
>>>> analyzing CPU 47:
>>>>      driver: amd-pstate-epp
>>>>      CPUs which run at the same hardware frequency: 47
>>>>      CPUs which need to have their frequency coordinated by software:
>>>> 47
>>>>      maximum transition latency:  Cannot determine or is not supported.
>>>>      hardware limits: 400 MHz - 2.18 GHz
>>>>      available cpufreq governors: performance powersave
>>>>      current policy: frequency should be within 400 MHz and 2.18 GHz.
>>>>                      The governor "performance" may decide which
>>>> speed to use
>>>>                      within this range.
>>>>      current CPU frequency: Unable to call hardware
>>>>      current CPU frequency: 2.17 GHz (asserted by call to kernel)
>>>>      boost state support:
>>>>        Supported: yes
>>>>        Active: yes
>>>>        AMD PSTATE Highest Performance: 166. Maximum Frequency: 2.18 GHz.
>>>>        AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>>>>        AMD PSTATE Lowest Non-linear Performance: 115. Lowest
>>>> Non-linear Frequency: 1.51 GHz.
>>>>        AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
>>>>
>>>> Thanks,
>>>> Morgan
>>>>
>>>> -----Original Message-----
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>> Sent: Tuesday, July 2, 2024 10:49 AM
>>>> To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>;
>>>> rafael@kernel.org; viresh.kumar@linaro.org; gautham.shenoy@amd.com;
>>>> perry.yuan@amd.com; skhan@linuxfoundation.org; li.meng@amd.com;
>>>> ray.huang@amd.com
>>>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David
>>>> Arcari <darcari@redhat.com>
>>>> Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
>>>> scaling_max_freq setting on shared memory CPPC systems
>>>>
>>>> On 7/2/2024 3:14, Dhananjay Ugwekar wrote:
>>>>> On shared memory CPPC systems, with amd_pstate=active mode, the
>>>>> change in scaling_max_freq doesn't get written to the shared memory
>>>>> region.
>>>>> Due to this, the writes to the scaling_max_freq sysfs file don't
>>>>> take effect. Fix this by propagating the scaling_max_freq changes
>>>>> to the shared memory region.
>>>>>
>>>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP
>>>>> support for the AMD processors")
>>>>> Reported-by: David Arcari <darcari@redhat.com>
>>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>      drivers/cpufreq/amd-pstate.c | 43
>>>>> +++++++++++++++++++-----------------
>>>>>      1 file changed, 23 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>>>> b/drivers/cpufreq/amd-pstate.c index 9ad62dbe8bfb..a092b13ffbc2
>>>>> 100644
>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>> @@ -247,6 +247,26 @@ static int
>>>>> amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>>>>>          return index;
>>>>>      }
>>>>> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32
>>>>> min_perf,
>>>>> +                   u32 des_perf, u32 max_perf, bool fast_switch) {
>>>>> +    if (fast_switch)
>>>>> +        wrmsrl(MSR_AMD_CPPC_REQ,
>>>>> +READ_ONCE(cpudata->cppc_req_cached));
>>>>> +    else
>>>>> +        wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>>>> +                  READ_ONCE(cpudata->cppc_req_cached));
>>>>> +}
>>>>> +
>>>>> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>>>>> +
>>>>> +static inline void amd_pstate_update_perf(struct amd_cpudata
>>>>> +*cpudata,
>>>>> +                      u32 min_perf, u32 des_perf,
>>>>> +                      u32 max_perf, bool fast_switch) {
>>>>> +    static_call(amd_pstate_update_perf)(cpudata, min_perf,
>>>>> +des_perf,
>>>>> +                        max_perf, fast_switch); }
>>>>> +
>>>>>      static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32
>>>>> epp)
>>>>>      {
>>>>>          int ret;
>>>>> @@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct
>>>>> amd_cpudata *cpudata, u32 epp)
>>>>>              if (!ret)
>>>>>                  cpudata->epp_cached = epp;
>>>>>          } else {
>>>>> +        amd_pstate_update_perf(cpudata, cpudata->min_limit_perf,
>>>>> +0U,
>>>>> +                         cpudata->max_limit_perf, false);
>>>>> +
>>>>>              perf_ctrls.energy_perf = epp;
>>>>>              ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>>>>>              if (ret) {
>>>>> @@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct
>>>>> amd_cpudata *cpudata)
>>>>>          return static_call(amd_pstate_init_perf)(cpudata);
>>>>>      }
>>>>> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32
>>>>> min_perf,
>>>>> -                   u32 des_perf, u32 max_perf, bool fast_switch)
>>>>> -{
>>>>> -    if (fast_switch)
>>>>> -        wrmsrl(MSR_AMD_CPPC_REQ,
>>>>> READ_ONCE(cpudata->cppc_req_cached));
>>>>> -    else
>>>>> -        wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>>>> -                  READ_ONCE(cpudata->cppc_req_cached));
>>>>> -}
>>>>> -
>>>>>      static void cppc_update_perf(struct amd_cpudata *cpudata,
>>>>>                       u32 min_perf, u32 des_perf,
>>>>>                       u32 max_perf, bool fast_switch) @@ -475,16
>>>>> +488,6 @@
>>>>> static void cppc_update_perf(struct amd_cpudata *cpudata,
>>>>>          cppc_set_perf(cpudata->cpu, &perf_ctrls);
>>>>>      }
>>>>> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>>>>> -
>>>>> -static inline void amd_pstate_update_perf(struct amd_cpudata
>>>>> *cpudata,
>>>>> -                      u32 min_perf, u32 des_perf,
>>>>> -                      u32 max_perf, bool fast_switch) -{
>>>>> -    static_call(amd_pstate_update_perf)(cpudata, min_perf,
>>>>> des_perf,
>>>>> -                        max_perf, fast_switch); -}
>>>>> -
>>>>>      static inline bool amd_pstate_sample(struct amd_cpudata
>>>>> *cpudata)
>>>>>      {
>>>>>          u64 aperf, mperf, tsc;
>>>>
>>>>
>>>
>>
> 


