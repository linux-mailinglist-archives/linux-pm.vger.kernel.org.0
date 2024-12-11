Return-Path: <linux-pm+bounces-19044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C0B9ED356
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49345281006
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017451FE47C;
	Wed, 11 Dec 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iVz1CYt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72D1FE479
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937907; cv=fail; b=n9Yo7ot6yE2BKvagupCaaTwTdCRVfWx0MnGHqkcAqCotDv4y9wN/8p+apwYKvLSYy2FsCx/Ac7KbwVcAZ9WCSPSQlO652fdG2ozHSGxaDcOBwtmjlFRWISE/jt30B5aT2kdV0FLY4dmingAaEpDYS1hGKPjzEp4VTsLjlnUBFnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937907; c=relaxed/simple;
	bh=xc7GO7oye4H3FZBPVyp1m16EUTO+jTb/U+i8q22MTDs=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=JXzs0cxcMS5s/4Tmd2ePaWyRf8lQEWFlSH60aUWFit7FIKFZYvAcxWfTg7kNRRJgUKCr1rzQiwQ+tABL1q9BzvB97js1UJRJ48GCHEMHMnvH7Ks3FSxVLqTDjZTdU+o3YQHsGsQv2h5DlJF7ahUdYpa2/yBbcZv2ClUylquRTLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iVz1CYt5; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQa6h40TZrNtLYusouhBeqzNcHWYPDBCijiz8WQ9rTaWcu8bOrf55ciKT+KTh48r40JqEPiVXHZ8Nr5NbCS3IbTYMtIoIgAFtjYZPKGtIBdBlKMLXNfgiujSN2qhlwPVc1pInsv/BKNEQw8SdnZgf1VaDXgS3ZPKy2s0KoCyvSTDVomKrOutGrg05i/qCIluGDE7vRoW3z6c8r7GmjKAXup8rIM8oy0WYEh4s+Rs1VWpEvYLU72g2ll7uo4nh3f09apcf/W3sRXXiCdzMAslylzTraCCbacPHYmHAAEV/TdhUkysm8s3O3yV4XxRoAJ3lXF4fSRQ9lwiCT2HS/nN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VArrvSsbWnIjLYVuO/FVc5lIJOs1wFm/E9SS6r7v5UU=;
 b=lPdc2YRAxdKDzs00RAdEHj6IpXLGV0SQr+prj9wx/gfghjCt6WBfQdve0YiFo0qQCpCikDD8hQH60hfjCcUjlUM9UQ3YGaZqflWnCvRf6XH/YMbHoUFxRA9bncQqJ9gpxjMk8sy5XX2haHzplzpeLsTF3uvSOnRe0qxxZe3Wgh7usafojbB+Xx+/6fzEaTZ4zIy7F1SqVK6FKco9+ihmosknhu5nwtoIhN9iNI4Tux49u+i/Mec5x8aavJIgv+N+8n2w9lk5DrRG2LTYvK6bAmb79xreeAWZ/fcm98N3UiDIQD9A+Aa1NObrJE9YSdasFZQXXAKRhs8tuzlvZW0kyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VArrvSsbWnIjLYVuO/FVc5lIJOs1wFm/E9SS6r7v5UU=;
 b=iVz1CYt5fR4l42gJ6NXCEyf5NwurM1tHgcoQhee+kt5naGB2SYaCjDNvR7juecX6HQG0xx5zpzpaCPT13tFfHjFlUqmHmHY2jehjURavUUQvrt8S1r7kgr7+g7JgmKKWmM+HmMTRYToiK4Ud7oNbJB1tJHfCf04dtk/fQq9RXmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 17:25:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 17:25:03 +0000
Message-ID: <63f03935-a73c-45f2-b152-29d08cb300b5@amd.com>
Date: Wed, 11 Dec 2024 11:25:01 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: amd-pstate fixes for 6.13 (12/11/24)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: d6508062-6b8c-4452-e1ae-08dd1a08bf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFhtK09yMFIvNU9LTVpFRGJMUVc4aVNwelVNUkNobzNVZSt5TGVSMkQybTZ2?=
 =?utf-8?B?U3NmZko0QzVhZUVyTWdzL2NHVkhmQnlOeUlxdzdSRnFLNm8wQmNDSzhneE9U?=
 =?utf-8?B?RUpGL0kzbGwyS3YvTCtwTExOUU4yL0ZpeitsakpZUkhzM2oxeXlVVnY2SlFU?=
 =?utf-8?B?eXA2SWgyL0pzK1VWNW9EemNQOExyNjArTFJqQ1RWVDdXc2FVQy9kdlhlbVRv?=
 =?utf-8?B?VXYyT1dKYTJuTklwd2RXTXFqRDZ0VVUrVzNPL0hxQVhVTUJLb2pzaVB2d0Js?=
 =?utf-8?B?K1dlRjN4WFMwZW5nSjJkR05mbk1iWW1ycnRuWldHa1EvKzdpZFc1eGh5Umh1?=
 =?utf-8?B?RklRTm94ZzAxVTZWdVkrRFNjTU5tK3duWkpyMDkwNzlWWnlQd3JtWjVtOGd0?=
 =?utf-8?B?UU9QVDA0Wk1OWHZ0V01uNVFaRmk3MURrb2pFeWx0SUZTd0FoK3YxcGg5ODBX?=
 =?utf-8?B?d3lGTFF2anYvWHMwRmRDVHgwcUhwUkRZNTZWK2Q0cFNiSDg4dGZobEI4NGQ0?=
 =?utf-8?B?d3BxK1R1Z3pta1k0LzU0eEFYZVM2RFVpRVlodmpxdlpmZ2thRjRmaWJZWWcz?=
 =?utf-8?B?RzlYdG1HRStYZzlkTXFQQ0pTQTFTZXVFb3RnSVpmZG13RTl5eUZVVW9xK3Q5?=
 =?utf-8?B?SXVtTll4UytDbzdRYStubUxtMHJNa3YyNVVwR3crNlNzZlJHV0dwRTZqZVZQ?=
 =?utf-8?B?aHg4SmI3enJ4WlVNL2I3M3lwa1A2UHZRMmFKUjhZVVplRW8wdnVmbVIyV3Av?=
 =?utf-8?B?dDJJZXAySjZTOGZBcTZZak5LT1ZqZGo5VHlJMWEvM0JMQmJnUUlVTkN6K2Zm?=
 =?utf-8?B?VlJ3dG5JOXBvNmdjUU5wemNxQk50cGlxbXJWYlpLNFAzOUVTK1ZHdUJKelR6?=
 =?utf-8?B?S2dkYkVWU3p1a2NEZVRLc2hmdGlXelMvY2Izam5VOWozQkRtYkcxUjlJQlJD?=
 =?utf-8?B?Q0VhU016dy9Nb2RKNzZZeVVRTVNablZlY3pvSTkxalJSRjlqUy9FT1Q0d0ZD?=
 =?utf-8?B?Wi9ubDRQLzhGYnZsR0QwM3kwYWszQ2FqeEFZTUt2YnFDVjRTNzAzcVgxVFJD?=
 =?utf-8?B?YUpLTUk4Y2JVRUpRb1FWMDJlYityZ2JZKy90VCtoYm9yaVJiZGtuVmxtcVly?=
 =?utf-8?B?TzdNMlM1UUxrRlN2TDFXSGs4NHE2ZmJ1OVlHZnk1dXlEQXNnN3dlN2tBWVRT?=
 =?utf-8?B?WkZLU0orTmp0MExoajVwdStWL3RKRFROMEN0NDRWZDR1TFJaeHRwQW5qSllZ?=
 =?utf-8?B?SUNiRWYzcjV3ZDdFM1R6bW5BKzFMellucWVCT0tidHAxVUlvaFJ4aHJZWmp3?=
 =?utf-8?B?bTNkQU1yaHJ5WCt2cGQ0M1Nvak10VnZJc3B3OTU5MVo0eVdhODBPcmtqeG1N?=
 =?utf-8?B?d3ZkcHB6N1hlUlNGTXdUZnhZeURINkhNN3o3MEphTSs2RTFpdkxOVlVEYy9w?=
 =?utf-8?B?NEJFelBPSzREMytPQ2R5STVXaEozL3ZFbjlyamlPazVtVmV2L2RGclpnTEpz?=
 =?utf-8?B?Nis3bUZYTDNWeGFIS1pxdExGbjE0ZUU1ZWZTcjdOaWIyejdWRW9JdEtsUmd4?=
 =?utf-8?B?dklzc0pUa0xjZzEzbGd2QnMvTVh3TlRwVWNXZEZnaVUyQ1haUFlhYUZzMGVI?=
 =?utf-8?B?VGoxMDJzdHA0VzV3RlBDTEp3Q2dxSHIrdERvdy9XM3ZudHZDSm1MZVhJRmFC?=
 =?utf-8?B?OVNwOE5SNUdyRTVsOVZWaEJLSkN0QUcyMUp6dzRIdGxYTWhnSDdXaDRjakxt?=
 =?utf-8?Q?LfavGSUZLF61bXIP4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJIOEl0dFlvODlNeVEwOGtMQXFOV3NKTnBNNjJQYmYzbXg4d3FjTEV5Y3BW?=
 =?utf-8?B?SnVWbnJQK21mQzRBZTd6TTR1L09XN0J4endWc21JeCtWN1I3Q0swaUI4VHNZ?=
 =?utf-8?B?MnBsMTk5UXNaSkJZaStzNXozU3YyK2tQbWVrcXZyM1JlUklyLzl6OEF6NkZZ?=
 =?utf-8?B?TFlNVEcwd1FITTZrU0MreWZuMlRlUHIvaHppTXk1OS85dGJ3aTQ0WVh5eHVK?=
 =?utf-8?B?Tm91bStpZllJb0pBTXdkL0pXR0RpVHNPclZKSUdsazRxWU5DWmZOZldBMGd0?=
 =?utf-8?B?a0M1QzNvaFhHcFIzQm9HcjZRdmhTN3htalA4d29XODFyU1NwbUlWVVBPYUdp?=
 =?utf-8?B?UlA4OUZaZDRqTTJLNUVvS0tzTWp2dStpcEYyUXdhNy9hSjB3dTF6Q3RrNDEr?=
 =?utf-8?B?Y1BtTk5LVjJWSnlqeTFSVGdRMzU2VHhNL2NhdW9CSXB1TjgwMVM5Z2VsS3kw?=
 =?utf-8?B?ZjJKUCtMdENVNGdWeDlpcHhNTWc4eHB5a3FISmZKTzJnUUhMZWdtazBFVitm?=
 =?utf-8?B?TUJObkdleittUU9ITDgwV0Y0L2JTYWJCSStxK3J4MmIydDI3ajc2QzRXVSsx?=
 =?utf-8?B?UVh0eThuS0NBM09tUGJ5SU5SZmdCdHhjTVVHK1dSWmt0WEF1Ym5JYk5DTnVy?=
 =?utf-8?B?eVhodXh3MmpJWURLSk1ZUjY1cFRrZURZR1I0citPZ1BWL2Uralg0ejBzeHE1?=
 =?utf-8?B?VzFEL2VFMU9FMHNyckpBaktyWENXSk5xOXpkYks1cDFrdGNYcndQRHdGWEFr?=
 =?utf-8?B?dS9qWXlsOGh2TWlZQUtFRE9laWVhN210dEpLMUd5amhOeldadEtyMy9QejJo?=
 =?utf-8?B?bEdOMkoyK042bU5wK2ovZWpjUjhUaERSTk1VdWo5UHA0S2RvVjRYbGlVZStF?=
 =?utf-8?B?R3pyZ2ZvOFNZQkEwWEg5MDdkMnpnQ0RvSDlYVmtZZ3UzeDZPNndlcUYxbFZC?=
 =?utf-8?B?VmRFeFMvWHBINGd0dmJGL3VIRkFyaDFWY2tWZEdScXBoNTVFUTFyVXBsR0RD?=
 =?utf-8?B?cVBucUM2SVFjTnU2cmZYWUdYQXlNcE5jSzBrWVFHNnZRSTI0SHVpVUpiNmRD?=
 =?utf-8?B?TWZFRmw0VXM2TDAzSVBQM3RwUkxhRjI3am5KZm9hMzJOWlFjeWxDRENuUjdZ?=
 =?utf-8?B?NjU5MnZOYUZPSHdMZ0FDaVV3NzF4UC9DVGpuS051am10QnkyRlU4N0NvWUhi?=
 =?utf-8?B?QjNNQngvYkZyYWNTUjJ0Rm0wK1NVK1IwVERRRGhCRGVWK2RidUE3S0JlZ3lM?=
 =?utf-8?B?L2t1TkJzaUtZeFdvZHhpQzBaZS9hYW5QSEVGblFUa2dveXhMcUxNSm4wWHV0?=
 =?utf-8?B?VnN4WDJBRk1idUxtSlZBMXFkV0FwWGRRVDBrZFhoQm91azZ6OW1jem14WHUx?=
 =?utf-8?B?VldzRVNxWEs4OC9HcU9oRFBVQmd3NmdwV01DQ3VXbnpOS1ZkZkh1SFc5TVlE?=
 =?utf-8?B?Z3FjUThXRm4rTkZpTlRhb0I1dkhoeWlSTGp1eno2ZXJzWFRMY2tMSjFsTm9E?=
 =?utf-8?B?SEQzUjRIY3IzSEg1UG5xK1dUd1AzZ2UxZFZQWGhoMUZRVkZZYis0YnYwcFhs?=
 =?utf-8?B?czN3OVQyQ0ZDMHIyYVVTZlZBeXpoU1labjI2NWlPdzBBQXo2VTN3OFZVZ1Ix?=
 =?utf-8?B?WGNHdERSUWRlQ1lNWk1McXo2RCtUcjlzYmJmcnlqOUZBMkozcHo2dk05blhB?=
 =?utf-8?B?dWU2VFByZUVkOFkwc1ZMbVlWZDR2QkRBSDBDNTI4cHMzenJTVGlmZnAwZ3Zo?=
 =?utf-8?B?c3ZjalRnVUFoc0lBQ2ZjbStFZVpiWXB6Y0pyekxMOHQ0bGRHQ3BSNkQxMEV1?=
 =?utf-8?B?dWZvSG5vaWxJUitwd25pYlhMTWpIdjcvUU1GTXYrL3FZcVo0SDQyR1Z0Zkwy?=
 =?utf-8?B?UjNDS0FXTS9UUDZ5bVcvcXZJZWlScHRxU3N2dENCOTBjRmk2bTJneitWY2Ey?=
 =?utf-8?B?YnBtTFh4d0RqU2NLWlduQUwwZzAvWHUvZDBybldCd0VOOTBBbENBeGZrcllZ?=
 =?utf-8?B?MkkrSWlrYkxMTjFlcmRxcXN1am9aN0FVUTcxOGFiTWVBVTk5eXRSWjQrM2w2?=
 =?utf-8?B?Y2RFdjF0dVgxY3BNY2x1MmtMOENpcDdrcXROYjJLNCt1VWc0amF0YllrQVp2?=
 =?utf-8?Q?J/o0wNOcQagWcIsNpf51hfgtJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6508062-6b8c-4452-e1ae-08dd1a08bf6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:25:03.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZygWXh2bxU5Si3modr3uo1BlI2v73fpVvlVHA2dUW1MSpUPwupdmdqXQHIAGW0b2n9v3w1b2NlbJdhPoFwZfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

Hi,

The following changes since commit 
fac04efc5c793dccbd07e2d59af9f90b7fc0dca4: 
  
  

  
  
  

   Linux 6.13-rc2 (2024-12-08 14:03:39 -0800) 
  
  

  
  
  

are available in the Git repository at: 
  
  

  
  
  

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.13-2024-12-11 
  

  
  
  

for you to fetch changes up to 2993b29b2a98f2bc9d55dfd37ef39f56a2908748: 
  
  

  
  
  

   cpufreq/amd-pstate: Use boost numerator for upper bound of 
frequencies (2024-12-10 10:17:43 -0600) 
  
  

  
  
  

---------------------------------------------------------------- 
  
  

Fix a problem where systems without preferred cores were 
  
  

misdetecting preferred cores. 
  
  

  
  
  

Fix issues with with boost numerator handling leading to 
  
  

inconsistently programmed CPPC max performance values. 
  
  

  
  
  

---------------------------------------------------------------- 
  
  

K Prateek Nayak (1): 
  
  

       cpufreq/amd-pstate: Detect preferred core support before driver 
registration 
  

  
  
  

Mario Limonciello (2): 
  
  

       cpufreq/amd-pstate: Store the boost numerator as highest perf 
again 
  

       cpufreq/amd-pstate: Use boost numerator for upper bound of 
frequencies 
  

  
  
  

  Documentation/admin-guide/pm/amd-pstate.rst |  4 +--- 
  
  

  drivers/cpufreq/amd-pstate.c                | 50 
++++++++++++++++++++++++++------------------------ 
  
  

  2 files changed, 27 insertions(+), 27 deletions(-) 
  
  


