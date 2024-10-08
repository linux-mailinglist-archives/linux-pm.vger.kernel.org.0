Return-Path: <linux-pm+bounces-15296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E8993F45
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B8E28342E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BEE17C7C9;
	Tue,  8 Oct 2024 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qSnOHGPF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A416132E;
	Tue,  8 Oct 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369162; cv=fail; b=X3TwwKNG1uaPUHe6eBSQ2weF3/PtxE2uyRsS5xsFiHa+fgbmp9a0LnybLJYZgHyFuoUm9zY0WUAC/7JoG84Xy6CEUM3wlFzg6wYR5yvPU8UN51xjHL5z1rMnejtGWBhxOftngVQw9X3slHjvtVYaEZLW9jFvswzxUFxIflI4sOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369162; c=relaxed/simple;
	bh=rWGErykSYVT12CVPl1ZmQ3ICMCDA+wT8gH1fyjHRpxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ArtIyHCtEDGT/SsYs6LzgSsTjQ9BhIYJPk4/tlNrRuuWFIVVeH92Dumdufd5MnIfJkmUOzM/isrbY9PEV/iLyz8QlExoUaF6YW2gDy1ueIXqRQb+HVDN1chwXVY8O+4qzhoninhq8Q2tTmtgtO0TnegE+rQbvvv2jGy8C6xbgQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qSnOHGPF; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs6fFo26lyoYKRHewh4/kAasQWSHWRSjw1P4yjeRUjTHoqGhjKAshg7xrm2yFDx36leEupMhazElFftRWfoLORTIaOTnvgu/gtkfVYYvK4zpNbQHV2ze2Cyd0ghfYucD7Skt+GtdOqb/U3WTCgxmGGWiBFRsR59L+UfbtD70XsEZBGY59NpEclxlgC3/WFurd+gHnzv5zlaI+Fb/Mjy4+pX+QOe/KquLB4KHNSKdr+E9pIjO89K0b3kDcXc7WjbDWzUMz4rc3fYYS789xKLFu+p6BuZay25D5noSyrH5hIKmacdOF+duIDQF//IFjyY3Qfn4gKP87mBi4R43cQ5+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziqG8clH3bg/4BYL+rDosis6tmOP7O2ZuQ+6ocikPS8=;
 b=RN6vl6OrPqBMsS0hQqi22Bty336uIwM/KXlwRIRVhRyGrVPIvlZYH0UemQzWIK982PU06LcTHIkMNfon4hzh8B+4RhMYsCeUjuXQCBZIinAQEiHpF72Lbu6X6737ckqDGegLbr8/VckBLlboYC6TszhU60R2ZY5ohIxe3Ckdn2TF4SJmiJAmAqTZIjad5JI73Ys3H010h1fkJtLJvdidzDXvlpIHacopnD8iyUBVRBfKr/DkXsvwCM1iqosjMdRGcRuPKY1i9obzpSCxok6UQjSvd37jG3pMueZ905crSW6n3U7Xd9DmzMFLRlgfVWaF3Q7bgdDa3KIF6HHzWpgNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziqG8clH3bg/4BYL+rDosis6tmOP7O2ZuQ+6ocikPS8=;
 b=qSnOHGPF5GIJopUS4Kc3jZdQ3darIkmOO2fjYlVXGq3NYJByui5qXnPmqRh12NRYBqnyw/yRsGdj/yp3nJBFVek9WE5FN6Est6qrF+EStFGxEcZBsDIL91ly3rJy16juGzobrRF2yaV+cN9XAJJed4GkzbPlSbfKrQQGiTPIPlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 06:32:38 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 06:32:38 +0000
Message-ID: <b4758500-9169-41fd-8dc4-9b61d00f2fb6@amd.com>
Date: Tue, 8 Oct 2024 12:02:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 ray.huang@amd.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
 <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
 <ac6aab6d-51d8-47e8-8508-8cc52aba227b@amd.com>
 <CAJZ5v0iKOQkAUuZaHf1Zcm5sO6xD-dYkeTg8nyC3EuMmY0qDqQ@mail.gmail.com>
 <CAJZ5v0j46anSdQBnsqojcyn2RGKG259ahd92n380wUSAtRFDxg@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAJZ5v0j46anSdQBnsqojcyn2RGKG259ahd92n380wUSAtRFDxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::14) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 981c21ef-9153-4752-f0a9-08dce763008e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajNVOXBkT1pYZzNWU2pPZU5Cdml0MWp5RDUvQUVTR3ZzTmMraFU4R05ZSDNs?=
 =?utf-8?B?NzBUakNBdlFGemxCMFVkWUlwV2ZIdUpmL091TjZvUUM1ZXc1dE9lL2lyNDZa?=
 =?utf-8?B?bG5CMnJEdXhxRnF2S3UvendZZVRXUmRleWowcGsyY0MwNUp1RVoyalQzL0t4?=
 =?utf-8?B?RS8rTit1N1JOMnV2N0NtdlgwaFMvS0YxWktERlBkcytXZElxQ0VnaXVDOURK?=
 =?utf-8?B?MmhIbWNoTnhOOXdmNm85L1lOUytNUDUrT1lWOUVYZjgrRjVRT3A4MzFoSnRW?=
 =?utf-8?B?TTBYcDhyeTkvN1JHcHBnSWphdlZ0QWxlaWFoQ1hUOVNvNngrajBXMVg5REZ0?=
 =?utf-8?B?RzV0djhVK2lPTGJ2aXV3dmV3aVRTT3kvLzE3R3YwUThENHIvU2F6MW5IYysw?=
 =?utf-8?B?RlFnU3dGWnNYdHlocklzOVN4dFZqRWg5b1ZkcWRGSlVTb1NwMmdYWit6QzNu?=
 =?utf-8?B?K09nellHUFcyT2NJbVA4Q3QvQjA1dm4zbGVEL3FWaE5IYSt3Y1NIM29xN1Ev?=
 =?utf-8?B?WGN4K3krWk5PNW9NenhRdDNEa2N3ZGFVZk9pUnVSb0hzUkhRbm84WVU0ZVFy?=
 =?utf-8?B?bkpPekt2RUlBQ05rcXlrOUNYQVVSQ0x5ZmdlbFdGbkZDbVVRTC9DK1hjWVVC?=
 =?utf-8?B?bFpVUHJ5Y2pXM2NFQW1qVG83bmxuZzA0YTVoVlBVSmtHNmxLdS8vZFN3K3BY?=
 =?utf-8?B?WnJqMXB2a0xmdW8xb3JaaEpMOHozeFM1OE10dUFrK1NYS25ocVNqRXp3VHdr?=
 =?utf-8?B?MEI2RDc5WHBtUkFmUXM5bTYwMkdSb1lncmMwT2V1OUM2QzJWMkN4bDdyU0hD?=
 =?utf-8?B?NVExaXJRQ1FsYmNnZWM4TS9HcCtDOU5STHBQNDFJNGlRb09TTWdpdTFDb0NI?=
 =?utf-8?B?UFNiRDBhWGFmWkJqWStnbzAwUW0rN3VzaTkyR0o5Yk93bGFMS05vdHRrYWw5?=
 =?utf-8?B?dGt4ODFuNUcwdFg3Titscm1YeW0vRDVTeStCUGE5QXlPaHZSdk0xZG9zVnB2?=
 =?utf-8?B?MVV6NFozNEtNdTBKUU9KQVl4cWpIOU1jRzFNd2dMaDFxbkNpbVlua2F6eXEw?=
 =?utf-8?B?aHUzaFd2dWVhSU50bG5RSkFBaUltQU9zS214SEZWbU8xY2lVTWtZRk1OWGpw?=
 =?utf-8?B?TGNYdjY4Y0d3TnNYcGpaTUJVbEYreVM4NURwSmtTbXhZTXBhLzBYd0xGVzh4?=
 =?utf-8?B?OTljd0t3NVhnWXRmMkxGOXR4TitZT0dVU2NSZzVkaEIxcTNaY0RwQVhVM3J2?=
 =?utf-8?B?dzR1UWpDazE3aXlzYXdyVGNDcmhIUG80U1lTR0F1ZG0vaEIrRDNYUS9RbE82?=
 =?utf-8?B?ajBLa3E5UHJOckJyWHphbXFzUUgxRzl4YStCRGlpZi83eGhXeHN2WVRJT3R6?=
 =?utf-8?B?VnMveTl5Q3hEM0FNVTJCVmF1TFBCY1hEMzBzZ3Bzc3RzeGpzZU1KSnRKbmE1?=
 =?utf-8?B?MGVEWXhsOGJNUnlKYnBETmNKbUJhNnduZGdFQ0Z6ZmR3aTIyTCtvMVNrdTdl?=
 =?utf-8?B?WDh1SXF0SFo4N1loV0c4Qk5hSktraHJYNEpDMUtnR0tSa2lnVnNVUHc2azZo?=
 =?utf-8?B?bkRDQkJoS3pZYk95MWZPL2ZmZ1M1enFLclVKVEd3anphV0FqazUxeE5KVDY5?=
 =?utf-8?B?VTlMMnZNTFB6SmczR3ErcjlkaVo3Z0FFZUF0ZDloR1lRc2Foc1JmcUlPbmNz?=
 =?utf-8?B?dXBna1Y0L1lSYnI0blVMbTkvYmVTc295SXJmdlYzTXVnNmVQV2doOUxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2F0ODYrMFNZTnMwV1hxRUxBZU92MXo2c09LS3NYSG5xNjkxUFJqRmlpWUo0?=
 =?utf-8?B?eFF4SXEzcklMZDhIMTVLTjlrZjh0dmNhd0E4NnI0V3pLdUppYU1ZNHcrcWRM?=
 =?utf-8?B?QWw2Q2p1NnJOVTdZbWw0NHpmczVkdHBBZE1halRQeGJWYzFTS2pCdTZzYnUz?=
 =?utf-8?B?UFlkWko3S2VQY0c1M2xEWjBsdWhleXkvbzZwUU16SkNEaEVDSTFaZ0ZaMmFK?=
 =?utf-8?B?RmZadWJSeFEwS25HVzI1Yk5oTEJkSFJuZllVNko3dEJXVDNxVnVEYzgzSjJJ?=
 =?utf-8?B?WkRzTjg2WWxUcUVZT1o4TVZVQVZwTHRDRjRkTWJzQjBQY0dySVZza0EyR1Nh?=
 =?utf-8?B?aC9yTVpIb1AwSlMrRXVsOE92S2lXek5hWTBKNUplajM5S25XNjMybWRXRDVo?=
 =?utf-8?B?WlhnOUlHNUx5Q1NHZm4wOFRsektndlNNSnlac1JlRmM4bjhHNmJvdjBzaXM2?=
 =?utf-8?B?MGZIc1AxbDdqMWxxUGNod3lXRFNNQ2JDTHdBazRhNG4wSCtwTTIxNVdOSkpP?=
 =?utf-8?B?UFJEcXkvdXdlcFRkOTJyY3Z2cHd2dGhjN2FkNTRYbU9iRzQ4OWR6MElmOHl4?=
 =?utf-8?B?QnRCSGh1VjBvSFA5bnRQTHljd1Q1ekdjaEVnUXZHQlVmdm5qTGhxWm04bmxM?=
 =?utf-8?B?UFdqakUrUklsZXZwSWVIclJCQy9xblFXWW90ejk4eHoxVzMydHo0bnRwdlRi?=
 =?utf-8?B?b2ptM2RQR2cxazR2RDM3SFlSbHRGSXZoNyszbG5BRGp5a3d3eDlmNmlrR2Fz?=
 =?utf-8?B?cUhCN0tPY3F5K1Rlc3cvOHFUT0JYWjRuSDhNTkc0bDlUc1JNOXh1dHNhRWJJ?=
 =?utf-8?B?SEdBWmI2clhndkxCRWFDZlpldTUzUzJiZXpLbTB2MEJvUGxNWUVSeERVeXVB?=
 =?utf-8?B?TUdXNnN4WDlUbjNhSTZVdm9VZjZySktYMVJ2SnY0QUpWVTN5UXpuQlU0M3dp?=
 =?utf-8?B?QWQ0c0k2cUtLV3VhdHhEVUJtVU0zK2hOMXF1UkVNdzlabWM1Lzg2cFVjVDU2?=
 =?utf-8?B?elRZY01MUlpPTTEraTNrN2pzTi9QdG0vS28zZkkzZktZS3VPem1zOTRuTDZH?=
 =?utf-8?B?akx6aUQ2UnNVNFpPdlVoVVA0cDc1dzJ2eXFRWEJrUzNjNGJGTXMzZlE5UzVp?=
 =?utf-8?B?VnpjRDE2Y01SWW9GTm1lOG1ReVNDamZLN2JzR3JzNUJqbmxSVEkzbldHaUZ5?=
 =?utf-8?B?R2F3dmN0UEVmMVhDZUtGTzRqUGtpUmpnbmIxc2J6ZCtodEFQSTRmREIrclho?=
 =?utf-8?B?YWxVRGVMSWN3Z0NFU1JQbHU0ZXdQUVBJejc4MjNvVC9hYjcyZlBXQ2lLMEwy?=
 =?utf-8?B?cCs5SElLZXVHUHROMDM0Y3FWUXFtSXdSRWhZRHd3NHBpR3diTG14OHF0NzUz?=
 =?utf-8?B?bm1Cc0dVaE9ZeFZJT20xNjBMT3FIYThJN2ZQeHQxL0w2UG9wSk52b1c4eFNV?=
 =?utf-8?B?UTkvbkpsS2Q4OCtJdEVGMmhBd2JHK0JYUHZ1RlppQm9SNHR2aFNCTmVaU1pY?=
 =?utf-8?B?RkRrdE1pUnpFWnY5ak90TUdwUlpZcFQxa2dWRFpib3pvSjZKNkxQRzNQYjVO?=
 =?utf-8?B?bW8yclREQUNycHcxWXA5UGlsa1NZRVRHNHRmUG44NVFrVk5pcWQ5VjQwRjJS?=
 =?utf-8?B?WkM3K2dBdzg4eXZONzFHMXRtMkxHbTNMaHZCNE1wZVVnZ25Tekx1M0hodWd0?=
 =?utf-8?B?aTl1VnVYNkhGMWdPZjRmMnU2TGR2ZWc5VDhoN3V3Wk9NUzNUcjc4dDJXeDhJ?=
 =?utf-8?B?RkdIRncrUUt0MkVPZHVCUlVEbGkrV1d4K3hHSDAydUxCejVpcnA1VTJsR3ND?=
 =?utf-8?B?NnNLdnNYZ1lOTkRhRnJ1QVY5TGM1d1hOUW00eUpTOXM1VkdpekU1M2FFcWZI?=
 =?utf-8?B?ZnVINGZ0T25TZ2loSEZ6NWdaajQ0QlJMbDdTRnJrRVRpT0pPaEh0YTQ3bnV1?=
 =?utf-8?B?MUtzaHFSV0UrR2lIMzFDU016Z3FXT25Xblc3MW1UQ2JGTElWRHd5VEFYQWhn?=
 =?utf-8?B?Wit3ZGQxY3Q3RDVyclc0b1lUekNOQzlmdHJ2S2xEcnlKRklLWVFEUWNQVnpr?=
 =?utf-8?B?TmRBdGpwT1hkQnJGc09BQXhkNGd6c3huTU5lVUpBM0lzZE1MYTZlUVNlaFhW?=
 =?utf-8?Q?fZ92GusL9NZ3hUHsIydw5xBbA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981c21ef-9153-4752-f0a9-08dce763008e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 06:32:37.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TiuqFJD1Ml1XY4OhMjBkEh+Wl5s/KijEPGgmJE0luAaIgu8LKPatPyni/p/Y4nNweYeP7DBLr+n+Lr/t9TIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

Hello Rafael,

On 10/7/2024 9:18 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 7, 2024 at 5:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi,
>>
>> On Mon, Oct 7, 2024 at 6:40 AM Dhananjay Ugwekar
>> <Dhananjay.Ugwekar@amd.com> wrote:
>>>
>>> Hello Rafael,
>>>
>>> On 10/4/2024 11:47 PM, Rafael J. Wysocki wrote:
>>>> On Thu, Oct 3, 2024 at 10:44 AM Dhananjay Ugwekar
>>>> <Dhananjay.Ugwekar@amd.com> wrote:
>>>>>
>>>>> Currently, there is no proper way to update the initial lower frequency
>>>>> limit from cpufreq drivers.
>>>>
>>>> Why do you want to do it?
>>>
>>> We want to set the initial lower frequency limit at a more efficient level
>>> (lowest_nonlinear_freq) than the lowest frequency, which helps save power in
>>> some idle scenarios, and also improves benchmark results in some scenarios.
>>> At the same time, we want to allow the user to set the lower limit back to
>>> the inefficient lowest frequency.
>>
>> So you want the default value of scaling_min_freq to be greater than
>> the total floor.

Yes, we want to set the default min value to what we think is best for the platform.

>>
>> I have to say that I'm not particularly fond of this approach because
>> it is adding a new meaning to scaling_min_freq: Setting it below the
>> default would not cause the driver to use inefficient frequencies
> 
> s/not/now/ (sorry)

I believe we are not changing the meaning of the scaling_min_freq just setting it 
to the best value at boot and then allowing the user to have access to the entire 
frequency range for the platform. Also, we have cpuinfo_min_freq/max_freq to 
indicate to the user as to what the entire frequency range is for the platform 
(depending on boost enabled/disabled).

> 
> I should have double checked this before sending.
> 
>> which user space may not be aware of.

I guess, this part we can fix by documenting correctly ?

>> Moreover, it would tell the
>> driver how far it could go with that.

Sorry, I didnt understand this part.

>>
>> IMV it would be bettwr to have a separate interface for this kind of tuning.

I feel like we can incorporate this change cleanly enough into scaling_min_freq, 
without adding a new interface which might further confuse the user. But please 
let me know your concerns and thoughts.

Thanks,
Dhananjay

