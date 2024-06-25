Return-Path: <linux-pm+bounces-9960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695A916C9A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7AE287CA8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D54170827;
	Tue, 25 Jun 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MOMw3kF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191E16FF58;
	Tue, 25 Jun 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328198; cv=fail; b=FUece6Fh6wMQbL0uyd9MMCtkSuD4G3BykWbEyoIM/SjaCmoBOqIlPs+mOgqmT4kHpV/Ih29WfE/S+4zkMblGN12XiEi/YUiefuU7ihH3Ss5rD8VLB3bLG8htq3uKb0GxyGs3Mm/1gZH27wNwVUhRwDFbM1O+PyUPCb7cc+jqkSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328198; c=relaxed/simple;
	bh=hf5aq1qGKa7raXdDYhOEtXURVAieHeN61QsZ8W9QV90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=al4eQAkId5O4M9n9KZjQ6mcETQGmFPUr81bIEaFzjF27xZ3BL2pFYRaDYaLyt6sLjSmFf+ghnfiSqUxoIzDTor00WfVqgGhW/5JAE7KUfoKavoBG2VwIiqjeS/KuCzxthVLEO46WjrP/2Dw1VdiPUrHyrAAO7ifExszggC+/EyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MOMw3kF8; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW0sUTPVgodDelaoS34Hoc728zP9ZoZ80J5m2zu4Yxl0r3q7Dd8UyHN19yKEqnQG+gszxDebG18Ul1D40awH4EaOjplD+cnmtx7DJl/kCfb4ytFE2qa9prXxuuFNMEZYdjQftYgsHN4gwCYTgAiJt9dMdknmGC8hFmdsdmULgJmTQbxGShnNm3PJtxpR22tDq/w5eCsyNu4n3tf7HQTbGzh+dGfr8WKRXC8vfyyes4+gtbfTpLs9kUNqHFMIa/RdpKgRsQVDi1CHfbYu4FjyC2CAw/OwP+uwQfqcTztSp2NrDOAtfMpz8TTfLmxAL8qw5pUmJFusTmlLiWA9gqhdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svikje9hv4c7kYX0xTStUUcGIeDdt90zdI5eHGCkGt8=;
 b=BydGvqFwKk9hdxzEqXxEB/sPE7q2MEMsQneo3FZ90fubcoKPpc/OwXCuFrZsg17gS9OFfpCxieMLBgB8xJJEEaRCXHAamJUOQB8QmiUNW3QVWiG04k7cSbbgRaD9UiIFcUf48cfnf/T/gQqSGRWY/tlVGN1Odgkc6Pdfc+X16WBn22lPOELM5QxZ+fz/uFvsb8eG6cKs1YwYLmlJlGUQG9gdQwPvCypvvMxxC+l1xZXAnsDRcg92wMiaBV8tOuggxZPkBcQZfLNsLbK3twbyooyL+XtCzL8/IGr2R8qlqK4EUWgey63RX/OVkHdztz421bQUPj8dERv9rTdEdGH64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svikje9hv4c7kYX0xTStUUcGIeDdt90zdI5eHGCkGt8=;
 b=MOMw3kF873OM1xmXb2ggYPc3Kb8VW2VJl/llKW/ei3i3DGaYnTWm/qg6PBQ7mR0j1hxrqzf4PFuKf4vT/hq6ncXXaqxeEQBKil0o2QLcpYC9n3533LB/S0v+eym0LaNOXugMJ9oO2CrGDZuN8YNhfnxS5Gg80UJfYxOr7g4Fegs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:09:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:09:54 +0000
Message-ID: <be834b5a-508e-49d1-b608-62192cd7bdda@amd.com>
Date: Tue, 25 Jun 2024 10:09:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Fix the scaling_min/max_freq
 setting on shared memory CPPC systems
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Meng Li <li.meng@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0094.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4fa079-cac9-4133-eefd-08dc9528de66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmhFbER5VEVaLzRWT241aW5sRU4wZkFXTXMrNFJpN081SExDMlozWk9ac2dz?=
 =?utf-8?B?OXBnQzliUFBmZVdYSmhNREswK0RzNzk3YUhHTTAyeDlHc3VsTk5yb2h4VDZj?=
 =?utf-8?B?WTd3Y2VIeXA3WFVWMVhPOXhnV1FId2ZRbEFyaFVvbjRuOStGZHRrYUNNQXJn?=
 =?utf-8?B?ekFyUzZxUjZGWWtlVXNhRFdwVXhYUVhHOXFXeVFCdTdsUFhRLzBOekE0ajBq?=
 =?utf-8?B?UkpMd3pWRDh4UkJQNWtubU5uSUxxMTlCbGtrMmpHT3NLWEd3U3dWYkZvdG5i?=
 =?utf-8?B?c0lDb3M4d0Z1anljZzRldjQ2dHhJMGQ1UEVVQWFKK1k5eDNEK1FzWHBTOU4x?=
 =?utf-8?B?WjJsS1FOSlE5NVJ2SzZrdGVCUEtWWmdaNmVhbnVsUUpoQXMxbGhMUlpqOFVx?=
 =?utf-8?B?WWk2aDZheWZjVkp0YkU5bk9QQjUweW5oMFNZVzdqbGVZYm5oQUxpSm5NYXFS?=
 =?utf-8?B?Wmk3ZnFTMG0wSENZWG5TM0ZsZFYyMDBhZGd5YVBhdDZMRUlxWFRxVEhZblhp?=
 =?utf-8?B?OU4xMmJqd0Y1VzhCMVlBMFB0YitNclZNUER6V3E0UGVtRFZyV3JwdzBwQlc5?=
 =?utf-8?B?cjV5S1BWa0RQL2NBREtyU3E5K0N6a05BVjVlR3gzWVJ2bjFZOTRYelhpVWZO?=
 =?utf-8?B?M3Ric3Y4U1U2OFE0ZFBQZk92Sk9iZWg4TWlRVEpZUkV3RWV6cTJFSmVFb09z?=
 =?utf-8?B?WGRYaTUzZi90S2ZYNjBWWllGWm9hVmVONmNNekdFcnN3NzUwcVFDcUdnL3dF?=
 =?utf-8?B?UGFXeVlLMG8zVDlPckF5ZW5wcXkvVWhwclB5aElNbmVPUUVxUjNEKytVNjlL?=
 =?utf-8?B?N3EyYUdjZGF1NzdTRjRFSmxpMDVVUG1HNllid2FzTVpoWjlYOUpVb3VXNUFK?=
 =?utf-8?B?ekMrM3pGa2ltaVlTTzVOa25SODRWdUNNVUlMTzJubFRrT2VNbXRGbjFIaFlH?=
 =?utf-8?B?akhWMEFWcGRUVkhTcUR5b0NtdTIxY21tejc3cGl1bUNGNUdSRzZ1VnVmSnps?=
 =?utf-8?B?T0MrajBaZ3d1dnJjODNHRGlTOTV0NldGeW5sTDFVUHhHS09vWlZ5Z0hCU2dw?=
 =?utf-8?B?WWJzZVNsbk1DcHlCbFltZFFFYVlzU0RpT1JVQTFRMk1OM3JVM3Z3dHdWWWFY?=
 =?utf-8?B?eXhSNjF6TGhxZVRZc1MrNy9iTjZCdjhqTEFKRDQvRlpxRGI1SmVPUHRzenkx?=
 =?utf-8?B?dWVQNDhNWVRDZC9uVWxRa1g1WFpVa3dHbTEwRlhZY0pDTUpMaUhiek91ZlhL?=
 =?utf-8?B?OVZva0tnSmVXR2lYZG9SalVQSUVnOHpDWjVBMDRZQnBxd2hLclRMbE9EZXVh?=
 =?utf-8?B?SWp0SUwveHdiN1ZiYkpaMVpaUE4reURUb29qekVsaWZxR28rd293ZkovQzZN?=
 =?utf-8?B?b2lIQldBbVBRVkN3c3htd3Jybi9icnlOakxWMkg5MzVEdDhTNWZBWDNKbkxG?=
 =?utf-8?B?QXNKVks3ZjhoNzR3ajdQNzc1eVBneTJYaUw5ek15a29PVmhodWNiNVpsWUJu?=
 =?utf-8?B?SHoyODEyWU90N242M204QlJhMU9nU2JEUzk2Nk5XQVNqZVJtV0o5OURGR2Fl?=
 =?utf-8?B?NVBDc3g5ZUcvYnViZk1IaU1IQ0h4M2Z3WVI4NmczQnZFWnU1NlpwWERsZTFx?=
 =?utf-8?B?YWQ2WTlzT3doMzUrSXgzUFhETWdTc3pjVDB3dmkvdjAzM3hPdEpiUzFjbTIv?=
 =?utf-8?B?TmlISWUvZ08vd2xEdEU1UzJEV0lqQVZEWWwzOVlPSFhzclgrakJtTURrT0lT?=
 =?utf-8?Q?1dYo0BxO9FOFfDpvfX3yTn+oN63tZSBoP/1IbhZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WncwVnFLejlBTnlVcmg4U2xBeCt0Y2NxSitaYk40cXRTR3FXTDR0YjBhRHhK?=
 =?utf-8?B?NUVjU2M1dTMveWZISE5hRWJCRkphRFlSUTJlOVhwR2N6Tk5UdndmNmlkUUdh?=
 =?utf-8?B?ai9RdERWSTRRR2ZmUDZxcHBsMnkyQ0RKU09rdmdLREJGSkdsWE00RDFKNEFz?=
 =?utf-8?B?eTlFcW1Rak16eVY4RFU5TkdNMTE4VlN3eVZiSVFSOGtjOE1LMGgvN2Z1b1g2?=
 =?utf-8?B?S09hT0ZiUkZUWHZyMURIcm9KNEZ1bHhTNWZ5ZTNJVHBXTlJZY3NxUGNwa0k2?=
 =?utf-8?B?VXhncE83dFNSaUxoMHhrUG9UY3FvVDJSa0xqOTZQQkRlYk8yTXFOK3h6UnRM?=
 =?utf-8?B?cHl4L2VGeXhxQmxwZUQyZnFjdFVHY21GZUxta0hHMENqV0RuNFY0VzNua1BM?=
 =?utf-8?B?aHRqR3lCeVVRU1ZwcjRWSDUxV2FoaFZMWFdTS3ZMVGl4dGhtdE5nakpDdVov?=
 =?utf-8?B?QVY4NWNNb091Mm9GZ1JoYW1BTDNOZDdDQmdGc0VTZ29uUjk5RFdLZDNFeDlh?=
 =?utf-8?B?Sy9OUVlTY2RmeHdVdXJnemtoWTJlelc4ajA5elJ5dENKcUhBVjMreE9tREFR?=
 =?utf-8?B?YTJSVkV0QVpIRGFSclV0dFIvN0hxbWI2YlZoNzhTUzdRa1o0QXdBQ2lIMndE?=
 =?utf-8?B?S09DelY2bmpCTjlZZ0NhL3RtOU9tVFBWUWpFODF2RjBpdDhSMURZY2w5Z1VL?=
 =?utf-8?B?NFBCeFhzNVFLd1ZTdHI5RHlsRHlEWHg5NWZ3MzVPZlFvREVlS2xYZ1VBM2hO?=
 =?utf-8?B?cWhVaXRwQjhBMjErNjJEUnd6NTZXZEMzQUZsdnV3M2lWeG9zOElMYVhMb045?=
 =?utf-8?B?Qms0RVJPRU1SMmxxOUFVQ3pEenRBOHEwV012SDVSWlQ1eGVkVzFmSEQ2UmhO?=
 =?utf-8?B?R1RFVGNJdHI4Y1BtZWx6YVhsU2xsQmNtWGM3SXJVY21SelE0WENoZ0lJcWZo?=
 =?utf-8?B?UjFXaVBvZ3FCT3k2ck5VbXVSSVVScGlPMGY3clpvZFRaMXJLYmZrOHp5Z21i?=
 =?utf-8?B?WXd2WE1uVzQ2cFJRcVIrOTFxQ21YRGpCeFVXeUdTK1dwZ2pXYTNERUlzTjNp?=
 =?utf-8?B?QmJqM1IvNCtxQ2ZhUWE1SXdlbXFNWXl2bllBSjlBMU5qWEZNcWtmM0Z5WDNX?=
 =?utf-8?B?S256YjlPNmxPeHgrZW9uSzVCc3RKQmJFbmlMMGZ3MGxRbEFuK0ZsNG5tM25q?=
 =?utf-8?B?bHBsWWxjS1kwVktkTVo2TjRLVTJDUSsxZ0FmMmN4d2lJeExOTjNBVGNIN1Vo?=
 =?utf-8?B?RDZqeml2UjFZZkFualcyL29uOU5rVWh5ekRYVlExUzVIV2ZWSzliQWJXb3o1?=
 =?utf-8?B?MDN6SU1VbEtwTFdmc3dhbFROT01JRWRCcTR5WWsvbHg1c2ZOL2twaTc0M0Zu?=
 =?utf-8?B?dGlKZ3UwUkZydWl5SUFrYjUyM09PaVd3MXZWVUdYbGRRMGxqenlkSE1Va0xa?=
 =?utf-8?B?ZlN6Tm0wQjkvQ2h0ZGVxWXlHa3J6NDErMjZnVEJhNGtNb3pqa1hZS21qUFJW?=
 =?utf-8?B?YXJoRXhzblUzdjdSYlh0UGhDaC9YcTBRSE1pdDFDd21PUjJucU56MVZxYmY0?=
 =?utf-8?B?T3hKUzlNQzNESWEzenRUM2g4T1E1WWpaaC82SFdCdUcrSFp4emlPTWd3WGlr?=
 =?utf-8?B?ZjRhRmhqWmlZL0o2QzVrejJ0RUtvdHFVRTMyWVA3TkVRNWZUcmN5WndQZWtR?=
 =?utf-8?B?dCsrbktxaU9PRXVMYytkZWg0OTBkSVR0MzkzR05QNWJpbUVib0dIT0Z0SWNG?=
 =?utf-8?B?RTdqd253eXZObFZveG45MXRKZHF1TVp6ZTMwL0dNYkpwa3I3NGRzbXg0aTRK?=
 =?utf-8?B?KzRkbGp0alpnUStuYVYzNVNtTS9pLy9mZjBhN1NhdlN3a0lDSXpNRVczMEth?=
 =?utf-8?B?UWtpY055dkxPNHlvTE52eElQS1JNNyt3Q2NjZUNoaThiaGNJTEdvRlJPNFVY?=
 =?utf-8?B?REs3WlRJS09kYnN0YXBET2FKL3dnN1FhVFByTkpWRXROemJBWHRkTVluejJz?=
 =?utf-8?B?L0h2QmhBNXNaSEJ1ZkpxOG1GRHFSbmVXUnhnaENpQXoyampDT2psbndQT2tQ?=
 =?utf-8?B?UEZEQW5Gb2tqOVpkWlZwSEtxZjF3WCtPamFPK2hZR1N0Vk8rZWxXYmpVNVEw?=
 =?utf-8?Q?NlSFW+apwhJNtPowHJubZjEj5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4fa079-cac9-4133-eefd-08dc9528de66
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:09:54.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6ldjpmXOXGYOpTwsQqJRAHMQLwkng8bF2tJeuQ8HIy7sXd/82qoIQfraqtoPFtyQ5TmYXQrmucyUNTVlQvuRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

On 6/25/2024 08:41, Dhananjay Ugwekar wrote:
> On shared memory CPPC systems, with amd_pstate=active mode, the change
> in scaling_min/max_freq doesn't get written to the shared memory
> region. Due to this, the writes to the scaling_min/max_freq sysfs file
> don't take effect. Fix this by propagating the scaling_min/max_freq
> changes to the shared memory region.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ad62dbe8bfb..7c1c96abe5bd 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -264,6 +264,15 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>   			cpudata->epp_cached = epp;
>   	} else {
>   		perf_ctrls.energy_perf = epp;
> +		perf_ctrls.max_perf = cpudata->max_limit_perf;
> +		perf_ctrls.min_perf = cpudata->min_limit_perf;
> +		perf_ctrls.desired_perf = 0U;
> +
> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +		if (ret) {
> +			pr_debug("failed to set min max limits (%d)\n", ret);
> +			return ret;
> +		}

This feels like a handgrown implementation of amd_pstate_update_perf() 
(IE static call updated to cppc_update_perf).

Can you just call that instead?

>   		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>   		if (ret) {
>   			pr_debug("failed to set energy perf value (%d)\n", ret);
> @@ -1547,6 +1556,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>   	}
>   
>   	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +

Spurious newline added here not relevant to this patch.

>   	amd_pstate_set_epp(cpudata, epp);
>   }
>   


