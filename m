Return-Path: <linux-pm+bounces-9100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF18907A44
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D45D281272
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012E149E01;
	Thu, 13 Jun 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abQab3NZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145A6F06A;
	Thu, 13 Jun 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301160; cv=fail; b=smG+DmjuzOm1DYVzLTpLDkoTW8m4pMYk1dBQCbPBGpfkOHgpNGNreXlUD/ub+fk43tk+bsfZ+dBm4CO815NTRXXzRoDfOnQi8QgVviT9Z6xCTB48+10C6Nn90PUflgZHMHzFfE2xVhAhvZ3gWhFULkufr1Oe6QwXrlRL6MYppCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301160; c=relaxed/simple;
	bh=cVSG1FoAGtAgk3TAo0HRSM7N12MA7kcqQVDoljAF3w4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGuShf5r/MefOUQb89pS1YdzU2kgkkswMLQ8RinZ5guQYJ+58f4pa880j+6Y2n2MOuVNiufHje7znpy+PQaxxPRVAcfeMrtsKqiYo3e5jRseutCmtRP83f058yj6V+DO/UOw5dIPFLvtNduV6Jbds3bw2LE0EXR+g7pkLEYd7xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abQab3NZ; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjRGM/dkOWZpaGC0ac6ZGTzhKnKLo+HogmJ7YvxeBfupZHEIgp2jcjTurcDwwm+nB/+0t3WOZNDNaAkYqsfiIYxfFUh11twBTf53ozu5z1Y+2xbHxb8XBQCAGkiF/oVpnUmbuZxGlMaUl24Jd5wnMjPArsHQXIFFf6nLEbpYSSgi0yV6rL8DN436rnsHKJ5SOTTsWTYFZXm+PHtW0OJZ2Cbla0f6+lm/jXcuyt70w1Fx3CzP/JMIPLjgRsnYhOGzo8Ypw20BO2dEM1cPjnco3fRATk6sIJzsiG3eTHczk3gdlkdk373+5QbpElAo3fiKGwofQchAG2tDrZDMPWrwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR66uJKagXa7XVtYLTkDiU+MZJLt42OBlS3LjngyNcw=;
 b=DMIQQlASSOO7p4TA9aOZnQ2/JXOW6VQyR9IadDVPOvdIVIadgbaUEQ7d+1w1ldxIEgw1gsJH9Q5zMfgdWcWfvYGcI5Q5JNDAhaT6jr6X1tKnCCklm54WNR1lQ/v/2tnfUlFepMZYkJ8s2hD+XLy9jz3oPaF2T+LXiK+ZUK5imvlpbdOjLFmFQhy/fXf6LXSB0vGwROoKXDhlaclV/hZfY/gvUH6szWR+g2DSgDZERzCuGjfZMpkk9ZofkYKE2M47YkePO+JxfdGY8BwnDhkMQQuoB4iwATeojNZ6lrxBxHuw/NYVxcGt/UoWHbOGxISd13TKQKc046xLjRIxdWru1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR66uJKagXa7XVtYLTkDiU+MZJLt42OBlS3LjngyNcw=;
 b=abQab3NZuyUZZ+iqpUmaul9MmI5DSjNGAwxWnCPZ85MEGq7abHFibwnMH+KOg/yLlIL09eDpoGWnVizujc2MMG0v69FbQj2Nr5oaAEuQFACr81RMsQPtecaal44y+DsZzgcJ3qjnEw34oLGsW9LvcyAI1FIT/uubaOoOYpsBY60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 17:52:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:52:35 +0000
Message-ID: <aa2f473c-38e3-44a6-a039-99b42d9a51d0@amd.com>
Date: Thu, 13 Jun 2024 12:52:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <c46eb6d79bd8e7068955cf993ffc6b726d86eb92.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c46eb6d79bd8e7068955cf993ffc6b726d86eb92.1718262992.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:5:74::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 395a43b4-7a77-4575-0437-08dc8bd19b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk5BMlpWc3VWZlNQKzArYlpzRlkyeGJ2SElzYmN4OFFMSjdRU0pQMy9uOXFM?=
 =?utf-8?B?Sm5zd044RVRuVFZRNHlEVndZaWRJbm03QXVUakhZWGg4WHFCQm96RTVYMkcr?=
 =?utf-8?B?TjRQRmhmalJJWlAxZ0xkRmdybXc1djRDbHY1YWx2MEJnbCtsekN6L2FIZzdv?=
 =?utf-8?B?RXVVZ05MNlUxQ0tzemhHaitONkE5RjNVc20yRXZmVG54bVdjeVZDalNpMlVz?=
 =?utf-8?B?QW9ielZMVVJSMGRxTEE0Z1BnYmNwUG8xUGxnZGZZZm9OZW50QVFZQVhvd2lv?=
 =?utf-8?B?c09zZEFUOXhTdzd2TE5KaHdNMnFaa0NxZTJyNW1ScU9JNG9hMlVTVGJ3dUdL?=
 =?utf-8?B?NU5rdU1LWENnclVKVjhkR2dYMERKKzR5T2hMMkhKUFAwc2FtaUdhQjR3TmZX?=
 =?utf-8?B?VmphMWtSelhGOTZWK2QrRGR6TWx2MjE0SXRKa0VPT1ozb1ZsTEJrbWRJQzVv?=
 =?utf-8?B?eCt0dmlzWllZbGlLT1F0eUpEUkFMZER3WVF3Qk9CT01KN1pGazU1R2lVY1Rl?=
 =?utf-8?B?K1hIQkgxdzJOZnRZTnNFNU9ORll3SG4waE9XeitZSHlsVURSdTVDWXFrQTZ2?=
 =?utf-8?B?T2FXaHV2YU9mbnFzajE1V0d0L3N6VjNDUFY5S2orN2dTcjdNYm5xVHFXTmdp?=
 =?utf-8?B?eXZQVnNJd3pDeWxweXdFRUpNa25teHEybkY4VkZPcXkyK3VEOGpEYWF1Yjdx?=
 =?utf-8?B?OVp3M3JJNGtBWGxzaCtjOCtReXgwL3ZYREd6U1dYUlI4anNQVWVGeERtYjlw?=
 =?utf-8?B?MkY5dmtvUExZUTBEMEh3ZVVKQ3RHZ2I4ZmIzUURtMlg5WTVIU3ltUmVqTkZw?=
 =?utf-8?B?WW5wYzBNVkJ6amcyY3BYSmFWMXN0VGxsd2tQTmhqR0I1STA0aGFXKzI2anU0?=
 =?utf-8?B?V2tqN3ZlUGkyNElhNk9wRmt3c1JvcjVjY0EwWXpHTzZkR0I0QlFCL0F5Y0E0?=
 =?utf-8?B?MUhJLzAzYVM3QVM0OWkxWE5LVmJTOXlqZ3JxWEJmUDNPTW13TWJWMjQyUk02?=
 =?utf-8?B?OWI2RGZoTmNNZUpEU1ZGb1FrV0lYa3NKUFhUSk4zbHZwSldTbmtUdFgrNmZO?=
 =?utf-8?B?L09aaHRrTGduZ01YT1R0UTI1UTI0dC93RGlVZGtNQmVBYVV3T2RQWUdLeWxT?=
 =?utf-8?B?OHJucyt5Z2hCRm44U3VxSnQzemhnR3orTFFVTm1ZVVhKR01RS2huUlplY2Mx?=
 =?utf-8?B?WXhvaXFkNUlacmJ4M1c2TlA4Ylltdm43RW5QV250VlRoaFM3NFR1WWtSZUFC?=
 =?utf-8?B?SmF1OXhEODk5bWQwWWVjRThNcG9RODUzYVpPT0t6VWcwRVN1azJlcnVFdlQ5?=
 =?utf-8?B?ZGxmMHl4WEljcWV5cmhzYlZtN0JKejlNWFY0a2F2UVVsSzM1b0M2VjZRMTFX?=
 =?utf-8?B?WnVoYlpwbzhYQUYva2I4RDRhQnd4YVJHLy9RV0FNVCtKbmwwaGJDM2lVaHJp?=
 =?utf-8?B?bm55Tk5zdWdPaGNsK2tMUG9LMU53RkQ1Kzd4NXZmd3NCNzNoTGVtY25ZQ3Zw?=
 =?utf-8?B?TnF5THE5dEU2aWpzeEE5dW13NFcwYlJ5UlYrN3FpdXdHR1pDc05hUkxnT3ZV?=
 =?utf-8?B?VU5YWEdlYk5rV1d4MkhtU1I5Yi9MZE1tT3VmL0g4bVBGWDRuNWw3UXVBbFhZ?=
 =?utf-8?B?emg5VnA2Yzl4enc2R0QrYm8vVFJTb0JaWU4xZzVHQ2t1TDBxeHQyaXhWdGNo?=
 =?utf-8?B?cnlnNTgvNGVqdXZRcmZWY3N3MEtmUXNnTTF0TUZZd3FNV3gweUNuak9jaUE1?=
 =?utf-8?Q?mZ+9voF7vk/aog3nF4C0Ej1JhJF5pwaDuI884/p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTgwWFNvL1hGYmpmeE5jcDF3UklqK0V3eGM3WUJvb3BlNnFyVmxpdXdPbWVH?=
 =?utf-8?B?Uk1KaUxtM1hYbmZrVEtjYk9GNmhmaEZqVkJENmRTcE1WSU93MXdubGxVYWxt?=
 =?utf-8?B?eDNNQUJ1RE9uNDIvSnBRWmViMFhTOUlsK1FJTzdzZW0wR2tXOFZFdTR1RjNX?=
 =?utf-8?B?ZlJEZEUvTEtIbmlsUTdrWWpUK2Ntek4xMnFJbWR4TkNuczRETXhyZDUybDd4?=
 =?utf-8?B?ODVmZmtlR2pzcjhPUlZwRnI1a3ZDSFNidUJPeUp2QlR5Yi8xazN1ZmdNZU81?=
 =?utf-8?B?dXBDRVhCbUMzSkFMT3g2Q1ptLzhwd0RZZC9NdVQ4QldPVmt5QldKc2diMmwr?=
 =?utf-8?B?TDFVNlg3TzJOaVViazFmcEFKNzRiT3NUeVFEN09ySytwNk1NdkFUZVZmdTNG?=
 =?utf-8?B?VVozK0E3ZUw1ZWZJNWVXTExscFpvQzNJQUtmUVh3Yk1JUGtrdHozMUdSUDhh?=
 =?utf-8?B?VWplbTF6Wk9EOWF1TmQxVi9FSnJ1UjMxQ2ZLSHhNZkl0Nmw3Y0tjbGozNDNy?=
 =?utf-8?B?R3NYd3RQcFQrSG9kYkNKYU1UMDJDdVdaNHRqMm8wVHc1UkxUNVF6aU9LV3R4?=
 =?utf-8?B?bEFzdk1GNGZUNExBK0k5ODRraVBuaVREK1BxUk1nYXZSR0NRZ3lJaWx0NmM0?=
 =?utf-8?B?c2MrS3M5SW8rTk5rb01ta2s1cWFHbHA2cnV2ZTY5K1BrRkVQcXlNVXVqN0ZD?=
 =?utf-8?B?NUxkWVdrUHdWWlRyTkU5WXRCUGJTbjZ0amVXQjZDQWFYZEZkZnlGb3h5azhz?=
 =?utf-8?B?UFFURlFCc0Y1YkoxeVVEb2hFRUhpOGRMMmswbm9acVhRRUZLUkQxTkxyVk5o?=
 =?utf-8?B?R1dXdHdlOWdlcUp0VFBWQ1VxRVN0OXBqVEFZUnNsRkdvKys2VVltSnFVWllP?=
 =?utf-8?B?TjUyQlp2UVZjeWczbDVsczJRZ0Rla20yNWs5OGMvblBlVHFZdktISVJWQk5k?=
 =?utf-8?B?aGRwbVp4K0dQZ21mbXNlU2hOUERMVDVjY0dIMWJZZVJpdkQ1MjFsQ29Wd1cy?=
 =?utf-8?B?V0xTQTJZR1BSL2RRUnpqWTEycUZtSDQ0SjJ2aExCVjVvWmw4anRUcUFtY0dT?=
 =?utf-8?B?UUJ5bmMvb2ZwRkdQNUNJbmhYYVFsYi9Ca2NXb0xOcTBOdkZmUnJkYWt1eGdO?=
 =?utf-8?B?MFBkSGVWRUlrQnFkUTF6S2JrcW1VU3JFMHJvZ3RYUERjM0NSaDdJZUl6Lzd1?=
 =?utf-8?B?bmFCRnhxUW1HYVdQM2lIMEE3Rnp0RGVFek8xbk5wZFZIS2szbE8yRERGOHFO?=
 =?utf-8?B?djIwR2Z1a3NwWXZEUnp5L3lIaHIyZmR2Ym51YUhPNHM1SlpRTjZxa25jYy9E?=
 =?utf-8?B?OXNFa2dFV2lFNDRmM3VicDA1RzI5OU92dUhvaXBUVG1Ed3dPdXZBdUdHRlpr?=
 =?utf-8?B?bmc2YzFtQnFTeWdvNUd4WGhkaHkvUVV5bVdsaitmOGVwN0NoZHo4dG9DemJi?=
 =?utf-8?B?cFNJNHk2M1dqZDl5QkZqcml1SlBpdktYOWU1VCtJTEwwSmEyY0RiUEY4bGkr?=
 =?utf-8?B?WGhoaXdqUmVGbVVVQ3hSdkE2Mm5HTmdNSWFTKzRNRm1QM0tMRVdiZStwQjNk?=
 =?utf-8?B?YUF2cHJjTDJpc25WeitycnRhMUM0c0xEd0xpWEoxbEx0Q2ZrUXh5eXFpSnRw?=
 =?utf-8?B?eDNSd0Zoc3RVUllBcEpmbEduQmhEVDhwcG5aK3JzN3UxOWk4S01QdlR4MHRo?=
 =?utf-8?B?YlZjd2xlZWgrRDYwQk5hTHozd0l0d0x6NzE5dUR6ZzJZd0ZNZVJxWVJLOU9Z?=
 =?utf-8?B?VjhGTjNkSm41SmVHQTVwaHJteHNnRFNzOGpBRWFmZlN6QnFPRURDYkZUUmJZ?=
 =?utf-8?B?OTJpckRid3RZODRpQkthejNBYXJ6aVNTK3NUdERYNThjUjhWRUxPV0c3YnpI?=
 =?utf-8?B?Q0tqMkZ1OVJ0NmxxVWo4cXJwR1dGU0ZtcGovUjBSTHRJSnJ6VHJjWWRsOWdN?=
 =?utf-8?B?WkJuZ1U5K1B3YTdrZEFQS3RteW1uS0ZNQzZrQmc1NTFiMjBPWmt4N0xGNEJB?=
 =?utf-8?B?SlNzTXZMUXFETEpPVTVjdjRxb2lwSVFvVWkwTEtab1BQNjVDTGdndzhmZEJt?=
 =?utf-8?B?VHJrbjlLblhSeHVPbGF1Rjlia2ozK25Ld05IenlqL2g4QXB1NGh0SHFuSEpH?=
 =?utf-8?Q?zRMtguX6qoIS4o3pQ8nU9qtuO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395a43b4-7a77-4575-0437-08dc8bd19b67
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:52:35.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO7kQae8J2PBIjT9BrAtKQd1q7Gq90tUoj1I4qQLP9y6tZmsJwMbh/XG0pOefX1JkVUp7gh/rbXa5Io0Y/8qsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

On 6/13/2024 02:25, Perry Yuan wrote:
> Add support for the set_boost callback in the active mode driver to
> enable boost control via the cpufreq core. This ensures a consistent
> boost control interface across all pstate modes, including passive
> mode, guided mode, and active mode.
> 
> With this addition, all three pstate modes can support the same boost
> control interface with unique interface and global CPB control. Each
> CPU also supports individual boost control, allowing global CPB to
> change all cores' boost states simultaneously. Specific CPUs can
> update their boost states separately, ensuring all cores' boost
> states are synchronized.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fe7c9d3562c5..d07f09dd7eab 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -701,20 +701,11 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>   		return -ENOTSUPP;
>   	}
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_cpu_boost(policy->cpu, state);
> +	mutex_unlock(&amd_pstate_driver_lock);
>   
> -	if (state)
> -		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> -
> -	policy->max = policy->cpuinfo.max_freq;
> -
> -	ret = freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ret < 0 ? ret : 0;

What's wrong with just doing this instead:

return ret;

>   }
>   
>   static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
> @@ -1875,6 +1866,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.resume		= amd_pstate_epp_resume,
>   	.update_limits	= amd_pstate_update_limits,
>   	.init_boost	= amd_pstate_init_boost,
> +	.set_boost	= amd_pstate_set_boost,
>   	.name		= "amd-pstate-epp",
>   	.attr		= amd_pstate_epp_attr,
>   };


