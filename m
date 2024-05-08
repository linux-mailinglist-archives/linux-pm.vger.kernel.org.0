Return-Path: <linux-pm+bounces-7675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97308C0738
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 00:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E401C2117A
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B16132C1A;
	Wed,  8 May 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qBY9PdZ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D81E89A;
	Wed,  8 May 2024 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206441; cv=fail; b=qfGrDk5KknCEgyUTUDI8z2SkW/0LwOkoiJNcOo+UUIvZGVkK1yfeIY1MFw7iwJZHtEesKsLhPCiDIZx/ikKcBGWiGxNZO6B5UK9Udjrvr7HZYnJme+t4iUgoBZikj9inrBYmTrjddPOYidk736JDefZAA3ONHhEsi6kYc4KE7Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206441; c=relaxed/simple;
	bh=0usswx2SXgbrnTFQG2PXt6OxRjx13xrZBU73RPIjp+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r//pJclVDwowxpyTaVGW8Emhp5L98osFiZbRdNPzpkBgxkdMKu8EOA2WuvH7oku2D6zYHJsWXJ+DsVoUNQuUUIGIJysNILL7KzKgmVEuVG/bM1KsSkvMZNQAOzsclIWpPOtw6X7WkspxUDFZCJ6P9D67fIm3mxPEsj0AX14wers=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qBY9PdZ0; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StwMz7xZh9qoH3rZChxApGkImZ8k9ZHG7mWqlJ7+004AC84ilbiQ3beZsirM7Zq1jNXCMMfClyB02lDL2KReZTOsOwauHAt4wm5zlJ/nKes5FuBUTEO+p088EnQf5TLkMfFy5pmfkH47u6aBas6l/7Ey/URJHs5DuNCzm+1IFjMqOiJ87f8qVFCBFSiyQ1Kzys8+tqx+gjIbQrWe/pp/jNH20qpTLd5V+9JWHBvY0j+LW9KZQraFOLPQFRL2sdi3RqmN86TCH/H2ZpKbCEV0bmVgD5L4rLGPOMYQguVBgrMrDVpmTTplcPMDDfhtyItTEv8f0PelUdRGjaZfTYaLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luCWfyFWbXVda24sgoPR3QUgmfflyHI1xSkyXrFHqK8=;
 b=Stb7gFlUwuaRBCNW3dijsO3X488WoEz6m3subFTKUb1g8rJZu81i3iX+meIBbRctdwuQhzRAJLk6FKGpNZQ7rj66KrQG6ejk1poxXidMP3EH250DBmM+ghw9nGMO0eXjXeidcpxVJUC/gpsOAbDX/J2ExHYPTTvJeKqfcF7s/gpO4yB77n1TcdzLIqZr/tDHkgvN+YT/BatuAJMH0lZAvrYJ3ACQ6auAByRJPPnzAgkl4sHQFhBkaDi9KhQFlpF4BEEuCryHYYJ9ycqnQBumQiNt2TpGsHlvN/WG67sl1VkK8KvQX6AbzShQOagJdzWbJgfpSpyUqBenGWqAK3YVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luCWfyFWbXVda24sgoPR3QUgmfflyHI1xSkyXrFHqK8=;
 b=qBY9PdZ0xI44iFqMOBX6zc1dUt9AqrMJO26UEef1NJVIuYL1J9M8PexyZpJNkY9qblfNy/sNVOBIEsR9YALqJMq/4kEZvVNaPsWkIRZ7WEsA1CX2DVjTgATf93TFXGt5nqtK9zF+QCa885CAcPwCxJZdo55Ek6gQech+GoEq+hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 22:13:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 22:13:55 +0000
Message-ID: <5b4f0361-a456-4e6a-983b-7c534783c643@amd.com>
Date: Wed, 8 May 2024 17:13:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com,
 Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715152592.git.perry.yuan@amd.com>
 <6041368.lOV4Wx5bFT@natalenko.name> <2728768.mvXUDI8C0e@natalenko.name>
 <12430912.O9o76ZdvQC@natalenko.name>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12430912.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:806:f3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 726f49c9-3f2e-4f12-4a76-08dc6fac26b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnJ3M1c3aktsMmdnVDA4NmQ3REdydE5VNkVPQ2pFMWVQdXJVU1k1ekdkYVha?=
 =?utf-8?B?VzV3VTBDUlB0VUY5aTVJcjBaNCszY2RXMDlzN0I2MnlFWjJ6VGRpT2lVVjB4?=
 =?utf-8?B?elo0Q244UXpTOXpEKy9HTlI5VXZocXJianI2NVFHTE9hdC8vZzI3SnRBS1BY?=
 =?utf-8?B?QStVRVA4TEEwRnJvUWRmaFJEWm1IcXhTYWpIejZrNHNFM25yUkZETUJRMU5o?=
 =?utf-8?B?ZGx2UGVIYmpyNE9FclVDQ1kxYjVhVDA5MHc1aXhYbStCalRMbitUT3V6djVD?=
 =?utf-8?B?elRQQjJWM29EaGdQVStxaFNnS0pRTktiSnlsYU5IeWprdDNpU0hIV1JYVlZv?=
 =?utf-8?B?VDM5RUh0TGlibEx1cmFyOEhoZVVFaVB6aUpqaXRKajJ4bW9aeWFwTmExMmM5?=
 =?utf-8?B?ZDMvbEdwdXhZRVppRExRdkhaa05jTjV2VVFudzVWa0xrZ1pSZ2ltU2NMRXRZ?=
 =?utf-8?B?WDA5enRhbWtCWVg0VnpiZU5PdlFuSURBSXFFQXNtamcraEhlNjdLUC9IUVhW?=
 =?utf-8?B?djBGNlFLVHFlQkMzbUthMTg5ZnN4bUxwYmJWMlRSdjMreE9lZis2YTgvVXVw?=
 =?utf-8?B?cStFa29nVXZ3THFsOWlyRDJxME1CbTFzNnplZmNES2tMR3pLeXRpYWJSZ0p1?=
 =?utf-8?B?OVZHS0JTbmNLYi93QnBWbHAyM2xueitQczFDNjkvUm5pQ1ZpeEVSdGNGMlVx?=
 =?utf-8?B?QmRqUE4yd3VueWIwQVR4S1I2Ly8wRGY4dy83R2RqakJMZ2VxTXZOV3ZTMXlL?=
 =?utf-8?B?MXpacFZZQkRDWEN0T0lnSGNNU3JuSUVwQ2NLem91dmlMd2paMWc4MEd0V0R0?=
 =?utf-8?B?YkhyeDlENzlBeVRnQVFGVXNuYnFTRnhLQnh1clVtaVN0TmlvVWdKZzBBU0tB?=
 =?utf-8?B?ZlZCT05zaXFjQ1kzL1VBV1oxeVFSeFFHMitQMk5lZDB0MmIxNTdoMXR1ais4?=
 =?utf-8?B?VHl3NlE0Q0h4WWFWdHlGaS9TTExCVWszUnpHRUJlRDU3bDBNaTVkekcxb0dZ?=
 =?utf-8?B?Zm4vQTdTL0lqTDd4SkVSeDBTWXh6ZWsrWWJubzVMYlBGMStCYzlMb1NEc2NP?=
 =?utf-8?B?SlIzb1hRUTVXb3NnNnZmU3RUOU5FUnZBOUtMVzB1MHhYVjMzSEVySGk4K2VE?=
 =?utf-8?B?Zk15cDZHd3FsUDJzMGMxa25idU1kYjVPendSMUtKaUI3WGhSbURTeUt4aXQx?=
 =?utf-8?B?WWdQUFpDVXo1Vy90dWdzSy9UR2UvNEowWXZscldpZlhBK2VHblJ1WWNqaGgr?=
 =?utf-8?B?c2RDaThocXlNNU1QbnludkQ1cGxzYTNLU3ZtOUU3U2Y1ZnBwbERpd3J6aUdY?=
 =?utf-8?B?NmtMVXZBZDJkbU95UTdCTjg4c1N3TFVoZ3llQm10RVdiNTd2aStvVEtabFho?=
 =?utf-8?B?S2hZRWw2aVQ0VzJ3eDUyeXZRYmxYL3N5Uk9QTDF1UWhlcjFtNCtuWkxIQ2dF?=
 =?utf-8?B?K2Rtblg3UTdVZ1pJVVNUR0JMTkhiM0NIN3c1TlQ1MjlyVnFyblVrZkpXeG9m?=
 =?utf-8?B?Wk5CUWRxZElJcGRpWVNyRU5YWC83ZWo1T2VPQXlLRDlyY1o1THBib3poR1Vw?=
 =?utf-8?B?YkR3aE8vTk4yWXQyTWJ2TkNheDU1VHc1VEc3VEFiK0lybjNyS0x5SjJ5c2w1?=
 =?utf-8?Q?SyzqQnaT0P5QOzG+Fq7oppj+iEgTx9N2a3FQ7U1Ty8z4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkhSSmZKN3FUQ1pLNXFKTVZIMThvOVhpTVJYNjhybmtON0Y4dStaWTRyWGx1?=
 =?utf-8?B?SjRpcFk3K0tlazRpSTQ4Y3VWUjJHNU9MR3hHQVpKQk5tNkdhUE5IcHBkRlhq?=
 =?utf-8?B?bmNlZTJmSVkrYWwvTTRRWENzUUZGblJsNStHZUdBTkt1dHJQSlQ4VCtkanFK?=
 =?utf-8?B?NjlEaFZiVnFMNW12TkFVTG91a2UxL0d2Vm50WDU1c3czdzRPRS9EZGNmNlFx?=
 =?utf-8?B?bmI2VkE0Tk5nTWZJMUE2aGhVaXY0N0VPVHNhdGVQNGlNOGtKOTI3bjVib05u?=
 =?utf-8?B?c1lBeHZibzFlNFh5NGxoYnRFOFdtTjlPK2V2TGVlTlNxTFU0MldNbjRHMDJm?=
 =?utf-8?B?elBGempPMHZUYVdOZzVoRXEza25JN2EwYURIUjlsYytsU0dITFRVYVF5WVVZ?=
 =?utf-8?B?bTVoWll3Z0JhdnFCWENPMGg0UHZoUVphRGxkWEZJQ2l0emxEMGo3dHR3VjhL?=
 =?utf-8?B?NVo4MXJFNUhIYnJoNCt3c3YzbjFRZ3kvbGM4V1htbzhldXA4U2NtOWxWMkFO?=
 =?utf-8?B?ZDgwdzltSklFckNTT3FrdEJlWWV4dTh4MXF1NXU5WFFBRE1SZzZCOEpkeGcx?=
 =?utf-8?B?b1pEWW9FaUVUT3N5QndFdXpuUXc5WWFQUU4rdlJ6YTFqbUczMTM4bG4xcmh6?=
 =?utf-8?B?U3FyZXVjd1ZHNEVpRncwMmRBZWF4L0htQUI4RG44eGVoTExLdE5KejZIbnM1?=
 =?utf-8?B?TFBUTUhCZTNZNWluLzVWTnBMSVNUZC8rMjVBbWYwZnMzQ0xRV1JWbW0vMmNC?=
 =?utf-8?B?OEpRSlc0KzZlaHY5M2R6d09mdGJQa0Q1S2pnYW1XdzJTcUFYc3VzWFYzcHdN?=
 =?utf-8?B?UWVlTksrVE5kb1dvQlgrc1g2RlYwZXdDQTA3bFNxTXgwVmxTeSt0NTZVanZQ?=
 =?utf-8?B?YmFpYWp5TjdHdXhUK1hvdzR1SmlMbFJ4Ym15djltVlRCUjE1b1d6bm9yc1cy?=
 =?utf-8?B?ZUxxSG5rNGRRRUR4YmxSWDNyc3JLdmZhWVZpTUZjSjlNQmprNmREdUcrbXBM?=
 =?utf-8?B?Ylh2cHRsbnJUbXJmWkhtMjhRWHBwRHVhdUpEWUprOEFEd1BvZllNQVpBQTdO?=
 =?utf-8?B?S2g4ci92RUtxaVc2M0tPSzJiUkFucFdUaytzeUtISTJtTG5KZmFsMWhqM2l2?=
 =?utf-8?B?RTBDenRkYldiOHZUQm5iWkJwWDAvekhXM1ViNlllUHNoNUtHK21FV3F1SGlh?=
 =?utf-8?B?c3pWNkhZQlNPZ1ZLY2x5U3hBelJLdzgrK1JSYXdZYnBRMnlucDFOTElDRnpO?=
 =?utf-8?B?TVE3MmJHZXk5SmF0dTA0cGhhcnJhd1VPN2tyOEdxN1IySmdsa1dyNFNaSVFu?=
 =?utf-8?B?UzhhRGtLcXhvY0I2Z1Vxb3hzeFpCUEdtZGorRWtxYk0rZGVjYmZObS8rNWZQ?=
 =?utf-8?B?bDdnZkNuVk05MS9wQlZ1akR5L2J6QlJvS0REbFg0T3E0d21ZeHl4RyswaEM0?=
 =?utf-8?B?RTFnUFhIeUhXUm8wY3dDL0s4OWgxdi9VbmVDbDVLS2w0K20wNk5iRVpMTjZV?=
 =?utf-8?B?eVV3d3B1ZjNyckgvV1k2ZmErbi9sSVNhblk0MVFTWkxQTUFmdnRTNDhZNmpa?=
 =?utf-8?B?dTlFaG4rLyt6ZkxQMXEyYmVVZDVIWkhPanVnSmJ5YXpjaXMwTkE2REZ6VUdD?=
 =?utf-8?B?M2JBTDFBdFJOei8wbHRRZEpscUZOcytpZEFwUURhc0FLYlFtcC90ei95VmQv?=
 =?utf-8?B?bzNodWt3UjhjZU9IcitWNW5EU2lySFExQmwzRTFYdmltYXc0eHBiQkJIMzMy?=
 =?utf-8?B?bXZOdjV5cFNNdG1hajNlNXZ1eXFvMTAzMXE3cWN3M2pWMFpHVHY5dEVRNjNa?=
 =?utf-8?B?TVo4OW1vcWFIaXdvdHZoai9zTGliOFBtQlpEcW11TjVZOStUMTRBeU9GSHJv?=
 =?utf-8?B?M1IzNU1JejkzWXMvVnpRTHpJMHJ6ZVl2M09pNXNxUm5DNGtmby9VMDJNVTlE?=
 =?utf-8?B?ekUxcmZ2bmExNjhBcm5kcFlZS21mbFlvZ0NianFWZExOenVqeDA0VUxCOHRK?=
 =?utf-8?B?bGthbE1FMFA4eTdjS3I4bzltWUtkR3kwN2dWS3l5Zlh4cjlEdk1XSnd0OFU4?=
 =?utf-8?B?K21ScDJWb0t5STZ6Rk1UREgwSzlKUHkvcnU2anFOVmZQU2FsZGFTWTg1U3FS?=
 =?utf-8?Q?0Lnk6+iFDlQUIpF+pd50nunEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726f49c9-3f2e-4f12-4a76-08dc6fac26b6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 22:13:55.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL3zFEvIDJ6H+3jSKeNiO40rYaMjPcflVDr7PgZVokZ6wVCI+EDPVS9PoqfJpoYdp5KH6gaoXtHdUSzPmooapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

On 5/8/2024 16:31, Oleksandr Natalenko wrote:
> On středa 8. května 2024 21:21:39, SELČ Oleksandr Natalenko wrote:
>> On středa 8. května 2024 21:13:40, SELČ Oleksandr Natalenko wrote:
>>> On středa 8. května 2024 17:11:42, SELČ Oleksandr Natalenko wrote:
>>>> Hello.
>>>>
>>>> On středa 8. května 2024 9:21:05, SELČ Perry Yuan wrote:
>>>>> Hi all,
>>>>> The patchset series add core performance boost feature for AMD pstate
>>>>> driver including passisve ,guide and active mode support.
>>>>>
>>>>> User can change core frequency boost control with a new sysfs entry:
>>>>>
>>>>> "/sys/devices/system/cpu/amd_pstate/cpb_boost"
>>>>>
>>>>>
>>>>> 1) globally disable core boost:
>>>>> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>>>>> $ lscpu -ae
>>>>> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
>>>>>    0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
>>>>>    1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
>>>>>    2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
>>>>>    3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
>>>>>    4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
>>>>>
>>>>> 2) globally enable core boost:
>>>>> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>>>>> $ lscpu -ae
>>>>>     0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
>>>>>    1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
>>>>>    2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
>>>>>    3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
>>>>>    4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
>>>>>
>>>>>
>>>>> ============================================================================
>>>>> The V9 patches add per CPU boost control, user can enable/disable CPUs boost
>>>>> as the below command tested on a laptop system.
>>>>> # before
>>>>>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>>>>>    0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
>>>>>    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
>>>>>    2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
>>>>>    3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
>>>>> $ sudo rdmsr 0xc00102b3 -p 0
>>>>> 10a6
>>>>>
>>>>> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
>>>>> # after
>>>>>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>>>>>      0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0000
>>>>>      1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0690
>>>>>      2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4541
>>>>>      3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
>>>>> $ sudo rdmsr 0xc00102b3 -p 0
>>>>> 108a
>>>>>
>>>>>
>>>>> The patches have been tested with the AMD 7950X processor and many users
>>>>> would like to get core boost control enabled for power saving.
>>>>>
>>>>> Perry.
>>>>>
>>>>>
>>>>> Changes from v9:
>>>>>   * change per CPU boost sysfs file name to `boost` (Mario)
>>>>>   * rebased to latest linux-pm/bleeding-edge
>>>>>
>>>>> Changes from v8:
>>>>>   * pick RB flag for patch 4 (Mario)
>>>>>   * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
>>>>>   * merge patch 6 into patch 3 (Mario)
>>>>>   * add two patch for per CPU boost control patch 6 & 7(Mario)
>>>>>   * rebased to latest linux-pm/bleeding-edge
>>>>>
>>>>> Changes from v7:
>>>>>   * fix the mutext locking issue in the sysfs file update(Ray, Mario)
>>>>>   * pick ack flag from Ray
>>>>>   * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
>>>>>   * rerun the testing to check function works well
>>>>>   * rebased to linux-pm/bleeding-edge latest
>>>>>
>>>>> Changes from v6:
>>>>>   * reword patch 2 commit log (Gautham)
>>>>>   * update cover letter description(Gautham)
>>>>>   * rebase to kernel v6.9-rc5
>>>>>
>>>>> Changes from v4:
>>>>>   * drop the legacy boost remove patch, let us keep the legacy interface
>>>>>     in case some applications break.
>>>>>   * rebase to linux-pm/bleeding-edge branch
>>>>>   * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
>>>>>     Enhancements which has some intial work done there.
>>>>>
>>>>> Changes from v4:
>>>>>   * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>>>>>   * pick RB flag from Gautham R. Shenoy
>>>>>   * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
>>>>>   * rebase to latest linux-pm/bleeding-edge branch
>>>>>   * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
>>>>>   * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
>>>>>
>>>>> Changes from v3:
>>>>>   * rebased to linux-pm/bleeding-edge v6.8
>>>>>   * rename global to amd_pstate_global_params(Oleksandr Natalenko)
>>>>>   * remove comments for boot_supported in amd_pstate.h
>>>>>   * fix the compiler warning for amd-pstate-ut.ko
>>>>>   * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>>>>>     error during testing
>>>>>   * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)
>>>>>
>>>>> Changes from v2:
>>>>>   * move global struct to amd-pstate.h
>>>>>   * fix the amd-pstate-ut with new cpb control interface
>>>>>
>>>>> Changes from v1:
>>>>>   * drop suspend/resume fix patch 6/7 because of the fix should be in
>>>>>     another fix series instead of CPB feature
>>>>>   * move the set_boost remove patch to the last(Mario)
>>>>>   * Fix commit info with "Closes:" (Mario)
>>>>>   * simplified global.cpb_supported initialization(Mario)
>>>>>   * Add guide mode support for CPB control
>>>>>   * Fixed some Doc typos and add guide mode info to Doc as well.
>>>>>
>>>>> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
>>>>> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
>>>>> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
>>>>> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
>>>>> v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
>>>>> v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/
>>>>> v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/
>>>>> v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/
>>>>> v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.com/
>>>>>
>>>>> Perry Yuan (7):
>>>>>    cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>>>>>    cpufreq: amd-pstate: initialize new core precision boost state
>>>>>    cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>>>>>    cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
>>>>>      while cpb boost off
>>>>>    Documentation: cpufreq: amd-pstate: introduce the new cpu boost
>>>>>      control method
>>>>>    cpufreq: amd-pstate: introduce per CPU frequency boost control
>>>>>    Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
>>>>>      control method
>>>>>
>>>>>   Documentation/admin-guide/pm/amd-pstate.rst |  30 ++++
>>>>>   arch/x86/include/asm/msr-index.h            |   2 +
>>>>>   drivers/cpufreq/acpi-cpufreq.c              |   2 -
>>>>>   drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>>>>>   drivers/cpufreq/amd-pstate.c                | 189 ++++++++++++++++++--
>>>>>   include/linux/amd-pstate.h                  |  14 ++
>>>>>   6 files changed, 225 insertions(+), 14 deletions(-)
>>>>
>>>> I've applied this series along with fixes and improvements [1], and I cannot get guided mode to work with my CPU any more.
>>>>
>>>> The CPU is:
>>>>
>>>> ```
>>>> Vendor ID:                AuthenticAMD
>>>>    Model name:             AMD Ryzen 9 5950X 16-Core Processor
>>>>      CPU family:           25
>>>>      Model:                33
>>>>      Thread(s) per core:   2
>>>>      Core(s) per socket:   16
>>>>      Socket(s):            1
>>>>      Stepping:             2
>>>> ```
>>>>
>>>> I've got `amd_pstate=guided` set in the kernel cmdline, but `amd-pstate-epp` gets loaded anyway.
>>>
>>> OK, this part is solved like below:
>>>
>>> ```
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index aafa4466e5ced..5aee7d2b8cfd7 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -66,7 +66,7 @@
>>>   static struct cpufreq_driver *current_pstate_driver;
>>>   static struct cpufreq_driver amd_pstate_driver;
>>>   static struct cpufreq_driver amd_pstate_epp_driver;
>>> -static int cppc_state;
>>> +static int cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
>>>   static bool cppc_enabled;
>>>   static bool amd_pstate_prefcore = true;
>>>   static struct quirk_entry *quirks;
>>> @@ -1958,10 +1958,6 @@ static int __init amd_pstate_init(void)
>>>   	/* check if this machine need CPPC quirks */
>>>   	dmi_check_system(amd_pstate_quirks_table);
>>>   
>>> -	/* get default driver mode for loading*/
>>> -	cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
>>> -	pr_debug("cppc working state set to mode:%d\n", cppc_state);
>>> -
>>>   	switch (cppc_state) {
>>>   	case AMD_PSTATE_DISABLE:
>>>   		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>>> ```
>>>
>>> as we have discussed here [1].
>>>
>>> [1] https://lore.kernel.org/lkml/CYYPR12MB865554562BE018D46FF0108C9CE52@CYYPR12MB8655.namprd12.prod.outlook.com/
>>
>> Ah no, scratch it, it's not solved. With `amd_pstate=guided` the driver fails to register during the boottime with the same `sysfs` error:
>>
>> ```
>> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpufreq/policy0/boost'
>> kernel: Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 4805 03/18/2024
>> kernel: Call Trace:
>> kernel:  <TASK>
>> kernel:  dump_stack_lvl+0x47/0x60
>> kernel:  sysfs_warn_dup+0x5a/0x70
>> kernel:  sysfs_create_file_ns+0x196/0x1b0
>> kernel:  cpufreq_online+0x244/0xde0
>> kernel:  cpufreq_add_dev+0x7b/0x90
>> kernel:  subsys_interface_register+0x19e/0x1d0
>> kernel:  cpufreq_register_driver+0x177/0x2f0
>> kernel:  amd_pstate_init+0x1b8/0x2c0
>> kernel:  do_one_initcall+0x5b/0x320
>> kernel:  kernel_init_freeable+0x1dc/0x380
>> kernel:  kernel_init+0x1a/0x1c0
>> kernel:  ret_from_fork+0x34/0x50
>> kernel:  ret_from_fork_asm+0x1b/0x30
>> kernel:  </TASK>
>> ```
>>
>> and things revert to `acpi_cpufreq` instead.
>>
>> What's wrong?
> 
> This happens with both `amd_pstate=guided` and `amd_pstate=passive`, while with `amd_pstate=active` it works. Also note I've got:
> 
> ```
> CONFIG_X86_AMD_PSTATE=y
> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
> ```
> 
> aka "active" by default.
> 
> It seems I miss to understand something in the init sequence.
> 

I think what's going on is that by reusing the same name as acpi_cppc 
does for sysfs when amd pstate is changing modes the sysfs file from 
amd-pstate isn't cleared and so acpi_cppc tries to make it.

Don't get me wrong - I do think that we should keep the same sysfs name 
for both, it's easier for users.

But if we're going to keep mode switching from amd-pstate at runtime we 
really need to make sure that amd-pstate-ut explicitly tests all these 
combinations to catch these types of problems.

>>
>>>
>>> But this part:
>>>
>>>> When I try to set `guided` manually via `echo guided | sudo tee /sys/devices/system/cpu/amd_pstate/status`, the status gets dropped to `disable`, `tee` errors out with `-ENODEV`, and there's this in the kernel log:
>>>>
>>>> ```
>>>> $ jctl -kb | grep sysfs: | cut -d ' ' -f 5-
>>>> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpufreq/policy0/boost'
>>>> …
>>>> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpufreq/policy31/boost'
>>>> ```
>>>
>>> is not. I've successfully booted with `amd_pstate=guided`, then did this:
>>>
>>> ```
>>> $ echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
>>> ```
>>>
>>> just for the sake of test, and got this:
>>>
>>> ```
>>> tee: /sys/devices/system/cpu/amd_pstate/status: File exists
>>> ```
>>>
>>> and this:
>>>
>>> ```
>>> kernel: WARNING: CPU: 9 PID: 8528 at drivers/cpufreq/cpufreq.c:2961 cpufreq_unregister_driver+0x1a/0xc0
>>> ```
>>>
>>> which corresponds to:
>>>
>>> ```
>>> 2957 void cpufreq_unregister_driver(struct cpufreq_driver *driver)
>>> 2958 {
>>> 2959         unsigned long flags;
>>> 2960
>>> 2961         if (WARN_ON(!cpufreq_driver || (driver != cpufreq_driver)))
>>> 2962                 return;
>>> ```
>>>
>>> I haven't conducted this test before, so I don't know whether this behaviour is new, or it was present in older iterations. I also don't know if this belongs to the "boost" series or the "fixes", and just letting you know so that you can test the runtime switching yourself and see if it is reproducible in your environment as well or not.
>>>
>>>> The following is applied on top of v6.9-rc7:
>>>>
>>>> ```
>>>> cpufreq: amd-pstate: automatically load pstate driver by default
>>>> cpufreq: amd-pstate: fix the highest frequency issue which limit performance
>>>> cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
>>>> x86/cpufeatures: Add feature bits for AMD heterogeneous processor
>>>> cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
>>>> Documentation: PM: amd-pstate: add guide mode to the Operation mode
>>>> Documentation: PM: amd-pstate: add debugging section for driver loading failure
>>>> Documentation: PM: amd-pstate: introducing recommended reboot requirement during driver switch
>>>> cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
>>>> cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
>>>> cpufreq: amd-pstate: optimiza the initial frequency values verification
>>>> Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
>>>> cpufreq: amd-pstate: introduce per CPU frequency boost control
>>>> Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
>>>> cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
>>>> cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>>>> cpufreq: amd-pstate: initialize new core precision boost state
>>>> cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>>>> cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
>>>> cpufreq: amd-pstate: fix code format problems
>>>> cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
>>>> cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
>>>> cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
>>>> cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq()
>>>> cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
>>>> cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
>>>> cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
>>>> ```
>>>>
>>>> Previously, with your submissions, it was possible to use `guided` mode with my Zen 3.
>>>>
>>>> [1] https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.com/
>>>>
>>>>
>>>
>>>
>>>
>>
>>
>>
> 
> 


