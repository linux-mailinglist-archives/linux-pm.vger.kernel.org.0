Return-Path: <linux-pm+bounces-7596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C78BE746
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48530B244E2
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97861635BB;
	Tue,  7 May 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NOb4kTSs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF114EC79;
	Tue,  7 May 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095160; cv=fail; b=LTvHx9w5//2+0vN7rSmm840p6n0LsgCZ6OMQ80hTi2Pfm3fYwBoBen2HMpXyfdrCrsN+rErWcf6/BDPBF7aZjy+TZ2JPHn1YusQ6kFgnyP6rw92KOINr4QfaX8R++72u+/Jlk8ZTV82aPBS4Ib+5KyhYd5i7svCAYhmhfx/0bo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095160; c=relaxed/simple;
	bh=u89kX0APHraMUmQ/bTZBM3UsNDt/nitNfMAib7ad0zQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iml5fGA1mrZ8KmKbLQGn2en5hRsb+HlCbjKGefGqjEV8tbvLxnd+KczA8WYHCi3LS01//5dGP7mzK63RSNYdk2oaWDvodXC10E5+PxFQdj/ZbLTBv4CzflM+uARswX5MYU/UEnl7vlDizomUnqCufw7JfqToabITLgCBrIlA6io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NOb4kTSs; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUggjU3mv90sKFAck2PWXFaPWsoFbIOs0rwqKn+CGkAXIbvMblNtKspKGBL6VIkDUSwKbaVPePuoNvvUxroEhNMh4xHkNh/UPRojOFomieJeY3KOd4HMT6enIadc8oQTSszGXWstDNiZ10gJ22WMehKwh8yR4WbPB/c8H0zImZ81qMlsHzukZmazYRozurFyJnMeYg0toMI1M2vrAnH5WyRdOdl4qaOGyTLOMIuPYqbXyy5CKu/NLtkM9hh8LkwQ+iWg51hm6zCu7S4eZKR+ywTOajU7Fh0WMcLEDBlCdM+bzzkZWuVTXhzWiLOyucYtY4ykgnwm+62fjmjkEiZ/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtfdknvAstYCUy1HN20wjx4jMwsjn4EVE40karBupek=;
 b=Ucq/WscIys4v6OxzEGdXbfNC3VOMTGS8HRE1P8JeVl7eLtPgF01NEqkgo1rfG3+mhN1vv0XqXl88MgrVdzHRoQ3DgrqesBrJJdpMonfEbmc59k7bBdjjk2br/GaJSEm5uaGOZjntqTP4OaVRBf4a1bjESJTClVSp2NloD4EHRdfdzhYsyypFQAr79V6vdxVrDoTiCxK6QsPJQbmIaioX9iRWmVtpTIjc0fF0ej9AuLMvCJNEIJIyPVo11zele8e0wqVdBfVT8O1gaVTBoMDQ7xBp/UyKC/CUiTJybgeM92OVwkBIxg9axvC04prhAgOw5itERfpFe64/LEyAPqMUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtfdknvAstYCUy1HN20wjx4jMwsjn4EVE40karBupek=;
 b=NOb4kTSsaWqrBZs0urxwn5Dvvix71cF/Uk4e+23LOzPdEFpwMTUg0ECA7Ku6lTyAF5jGq1fvm3KxcwkmmBNh5K65+a3VRE9wjxHLsRkvBYmevVDiPK0rFW/Z3PDD49USMgzLvNKy8IRxbu3y6/1IkHw0xH0lMemAi58NgfesXHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:19:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:19:12 +0000
Message-ID: <9255af0c-4574-49fe-922f-56885ae2d55b@amd.com>
Date: Tue, 7 May 2024 10:19:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] cpufreq: amd-pstate: implement heterogeneous core
 topology for highest performance initialization
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715065568.git.perry.yuan@amd.com>
 <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:8:2a::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 572ed7d4-23be-4e66-1f82-08dc6ea90cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enAvaHpQbDlSZ01JTkQwQ043eHZqck5qZzc4aXM3L1pmYjVOck1wZmU3dUx2?=
 =?utf-8?B?N1lRSnZVVXFUeE4xWnRiZUlsc0QvWXROcVFJSUNKSTE1cVprOEtGSzg3VEVX?=
 =?utf-8?B?a0JQL04zVnl4QklhM3JXQ0wvZkJudlpMY3dWN1lEOWU4bEhXdmtRdXdhSnhp?=
 =?utf-8?B?N21nYjBxRnRNcGNXRHBJTEtYWjhHQ1Z1V05PWFRxWUh4YWVmdDBNSE82eExT?=
 =?utf-8?B?ZmhhRjMxL1l6Mk4wRlg0dlJEYXl2aHh5OW5UZnpVazBzYWpvT0VrWkNXL0FU?=
 =?utf-8?B?TkdQRGRxemhPeXNGWGd2bmxISjFTYjhaQkFZalR4TC9HelZlU1pEbXFnVVNu?=
 =?utf-8?B?OU4weXZ5N3pBaHQvNVg0elNEc01RblZMMFNGWTlMVDVKblpseXdIckhDbUs2?=
 =?utf-8?B?Y3d2cmkvekZMeldJL1dBWW9QYkFPTys1a3Q0NitqU3A1bHQ5RERISGcrS0NH?=
 =?utf-8?B?b3RHbmlpNjFkMnpxeVN4WWhuSUxTY3ZadURpWWw2akliQXo5U2dqRTVUNnNW?=
 =?utf-8?B?UWhuaDhSbmxVVDNoZmVPSDhCekc2M3JqbkFHeXlXOCtsd1A0T0pTSUFGYUF1?=
 =?utf-8?B?Qm1ud0JuNyt5eWlKNFM0OG5ZYkUxTkRwZHAvc1NYTjFpL2FoRmNuYk4ydDVI?=
 =?utf-8?B?SE5zcnp3TFI2QkJWSy9UNkwwRGhyUGhRL3JlckRBaUlkVnIyeUV1aVF0TThK?=
 =?utf-8?B?S3VUV0hveW5NTUVKMWJhOU1acFJvRytlR3U0aEVZSTFXdUZaR1RPMUdSRXpx?=
 =?utf-8?B?dnFiWjRrdnpOUjA1N2FsRXp2RXU4OFpZZTFROFNDbGJ5WFBRRjRpbUcxK2hU?=
 =?utf-8?B?ZVJkR0RlMTlUMWhwS05sQ0grU1JSelpzU1FEUXEvdGZweGJ4bmI5MWl0RGVZ?=
 =?utf-8?B?YmlXODNiQnZCRmNuM0lpU1ZDZVhnN0hiZDNUaVR2ZmxRcUVTRS9TUm8xeHRl?=
 =?utf-8?B?OFQrdE5GNzJUY3I2RGVRN09RcDh6Z3R4VWZpdnVrMGs4OGc4Z210eS9WQWta?=
 =?utf-8?B?NFQ4ZUErYzFmVHNPQks5WTFYMDNFTWVzZ0pCRkVZMmt4ZlBBQlh2NXQ3andN?=
 =?utf-8?B?ZE5iRzFUWCsrWGRXc2phVE1LSEZHYlpiQXFsR0I4SUk2UDZLbGxIUWx4TlA5?=
 =?utf-8?B?Ylc5NXZRblFyUU1yKzdrMEtyZnRGVlpxTDRMeUJYWGNmeDUrUHR3dFpXbXFL?=
 =?utf-8?B?M1NUbWZ5b0VUb1A0Yjh1Nk9LdktnWE93M0FwdERIcjJQQ1Jsa3hxYjVsUmtz?=
 =?utf-8?B?QW5UMUxxa0J6MDdENmNOaHVlaEM3TjRydUhKM1BzWXhRK0tzV3kycUd5QTVt?=
 =?utf-8?B?dXZtVmMyak40VTBjdVNYTHhSY2JiU09CYTRCUWNNUndyUnhTZjhTUk9RT1cw?=
 =?utf-8?B?WXJrSkhDQWxFV0lNWlEzZWdacVQzcEIzcDFwUDR3L2d1THlZcDJSYkZJRDJa?=
 =?utf-8?B?MzNJcDFHYUNra2xZOEVJN1ppbTNJMllvQ3k3NFR1REZPRGpSK1NzN2RERHZB?=
 =?utf-8?B?dlZHdXlqbjN2N29hd1pPSkxVZVIzcHV3U1Y0M2ZVM0tjRjhIU0xiSTZmb1Iy?=
 =?utf-8?B?VnZ2elFXa0ZmRjdXbFFLNzdvVm53dERFRld4MlhnSmlHZkN3VmpGaWpCMkhW?=
 =?utf-8?B?T0cxWERIeWQ4Y2xuRmh5d3drMW1SODBCNTMyd0lqbkF6cm1FdGlXZXJvSDkx?=
 =?utf-8?B?VlBueGVXNnRNVzNMcitQL04vTFZndVNyclBMcnBQUytIMGxMempLKzd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1hoZlJGWUI1clQ3RWpkRlp5RW16VFdtSTVLVEtuOTB4V0w5Zmc5S2VIOUVQ?=
 =?utf-8?B?ck9lWFgvTWExNXFGZnFPc3VGcnNtOThaVWpERVhVVjdLV1puOW9RalNwWVZs?=
 =?utf-8?B?a3F6OFJsdEEvckhBYmhoWmRrUXpIR3hldlJPdDBacEI2U1pjZmdweEJvUlN6?=
 =?utf-8?B?WVh5TUlyV0xYeTNTQnVrZng4Z0pXMm9JdFZjUnRucVk0K3E5c2JvVGFSb0hp?=
 =?utf-8?B?dXFsYVllQjJqdVdOeEI3bng3b2Y0T1cwanRFaG85Vk14SThWcUJGTkVBY3Mw?=
 =?utf-8?B?TkZIcTM2cE11WEpQMmMxM1VEMldFZmxGOVBxUEVxK2p5RG1xcXNDcUFPcFBQ?=
 =?utf-8?B?cXdxWTVnaGY0alNhZUptMGswclU0VVROdUI3clFGT3h5VElpVGtRdFkzZ3ZH?=
 =?utf-8?B?Rzk3SWRaUGpNcDNGOHlMbzI5Y1NSSTNEUVJpZitKWUtDVHZ3dXZ4M3FHdktS?=
 =?utf-8?B?a1JDK0poUWxhUStDVlVHWlV5WFpuNHVaZjNHY0R5TThWTW53dUtMb21ralZp?=
 =?utf-8?B?NDEvK015VU5aRDU1YzFhaXUwZVh0ZWdCcktBWmcyMURnRlB6YjdqcTFQeTJl?=
 =?utf-8?B?R0VwZlgySm5hMVJEMVNBQVVMK0lYRTcxNHRieFhBcC9jMG45TXpPRVlqOENP?=
 =?utf-8?B?RDN0cFE0bTFnZ0pOOEpScjZxNzdzNzA1RGtrVlRPWU1vaGwrcGhxSk1udUcr?=
 =?utf-8?B?eko1dXZBcUVUK3YvdllXSm5iNFRmdjN1dURxRkV2MFRqWTQ3NHA4VVJEYnYw?=
 =?utf-8?B?WkRhUjlmVnVYSnhjY092OFhML2lXeTh6RmZTNHIvQnc2THI3cHlwOVczNEhn?=
 =?utf-8?B?WXhnR2Y4RDNYdTJCRmMvK2RZQ3VITVlGSjBMTUdnYlpMOStPbjBRTzlrVWJo?=
 =?utf-8?B?bUZVbXF3RmErckhuR1Ezai9jYjJJZ2ZXb0EybHRoTU1QN0UzVkxDQStzd2lS?=
 =?utf-8?B?dVFKWkJBT3VacUt4TzY4QjVJa1U3dTlLUW1QeTM3K1NpZ2VsS2t1TnhxN1g4?=
 =?utf-8?B?TWFEM2FzdTJoYmFtKzhOZjhIU25OWmp1SkFBZ3pqSFlIK1FFc1kxTVVxb0NW?=
 =?utf-8?B?Z3NjWWFJN0ppa1ZyMGNiOUNyOVRhNDF2aEFrKzFRMUh2Z1lINkFFWWlwSE4x?=
 =?utf-8?B?RGU2N3orUWlIREl2RmxpTDQ2S2lFcFZRM1RYb3E3b1o2cU9mUzhNQ2ZDQnZV?=
 =?utf-8?B?TVhudUhxSzM0WEk3Wmx5N2pUOFQzZkZWL3JOelpJZFJBYTIvdUpRMnByMmJX?=
 =?utf-8?B?b0MrS2ZNLzk5bjRucUNwYjdlQUVsdm1DNlpsOTVKblZYSWVRM09LOGhMTjBV?=
 =?utf-8?B?ZzBDd1M0Ly9tUUZoVnFZd3FvS09SSjVUU3M5c3htcmxhN29oK1R4UnhHSXFw?=
 =?utf-8?B?dlFiU3E0R2JweWI5dnRxUnBENy9SdUFGQUZtM3NOMGtyYWZrK0VYaEhqbnZy?=
 =?utf-8?B?VDFlWDlxZEhSalpyMjVuMWNTT1VtNFFnZFVKR1dUcmVqeHFjdm5GVFg5RFpZ?=
 =?utf-8?B?WkFyb1RDeStQcS8wSWFScTRRODNaVUJzQmR5ZHVrcnRhN2dweG1iYmNhb0ha?=
 =?utf-8?B?cUovWm9FN0FSb0FFUXVqR29JWC9GSzMyTXJNTldtN1pDclc2bzFCVzdRVDgx?=
 =?utf-8?B?WlE0Q1dFUWVGZjlSQ0Y0NVFpVDkxcHdLNGNwR0ZLd2ZkSmpmQnJsdWpJa3ZQ?=
 =?utf-8?B?WFovZTRxWVpXNmtXQUk2UEY1S1FuVEFSUWgvTHpBY2l0QWp1NGt3WDE3dTMx?=
 =?utf-8?B?RnJrZXZMRGsvU3FISVRUM3VwZjQ1UXdpTTY0WW15NmNlT2VvWEFRKzhPZSta?=
 =?utf-8?B?b0V5aFdvUXpBRWlTbmE5SGdxYndjREhDS2kyUWFzUXJPbjJFckhzRlloUklN?=
 =?utf-8?B?OC9zYmdUbzl4dXRLMDEzR1FSaWh6bWJua2x0RmphMlZFU09KSnpONkxXb0NV?=
 =?utf-8?B?ejJyQ2s4VWZKMURFWEtHZ1hWZDZBbGVIcnNDSXdxNnNYaXZKaVd4UG1Pd2ZP?=
 =?utf-8?B?cWsyZGZRTmh6bXZIencvd1NEVkxkYmVRa1BMWEVXbE9sSGtrRnRHbEJDU3Z4?=
 =?utf-8?B?Rk9DWjY5RldVanRiWHNDaURsZnpQakFpUW5jeTNPWXZFRHhuYWVqSjNyOGo0?=
 =?utf-8?Q?yHOj2DYWhOpM91HinfUX1WjAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572ed7d4-23be-4e66-1f82-08dc6ea90cf2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:19:12.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVq5KQUjS0Mpn2VwGRx3ADZw3BYLt3KUMObcVEEqjZs/1dzfbpjKogQmzl9/lYTjI3RCwpTQRXcYS5J00yHC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668

On 5/7/2024 02:15, Perry Yuan wrote:
> Introduces an optimization to the AMD-Pstate driver by implementing
> a heterogeneous core topology for the initialization of the highest
> performance value while driver loading.
> There are two type cores designed including performance core and
> efficiency Core. each core type has different highest performance value

Capitalize the "E" in each.

> and highest frequency initialized by power firmware, `amd_pstate` driver

Three things:

1. Rather than "power firmware" you should just say "platform".
2. I would use "configured" instead of "initialized"
3. This is a run on sentence.

Here's my proposed change.

Each core type has different highest performance and frequency values 
configured by the platform.  The `amd_pstate` driver needs to identify
the type of core to correctly set an appropriate highest perf value.

> need to identify the core types and set correct highest perf value.
> 
> X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
> processor support heterogeneous core type by reading CPUID leaf
> Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
> driver will check EBX 30:28 bits to get the core type.
> 
> Value Description:
> 0h Performance Core.
> 1h Efficiency Core.
> 
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Use the word "Link:" to prefix this link.

> PDF p274
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   arch/x86/include/asm/processor.h |  2 ++
>   arch/x86/kernel/cpu/amd.c        | 19 ++++++++++
>   drivers/cpufreq/amd-pstate.c     | 62 ++++++++++++++++++++++++--------
>   include/linux/amd-pstate.h       |  8 +++++
>   4 files changed, 77 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 811548f131f4..30d1900bb7e0 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -683,10 +683,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>   extern u32 amd_get_highest_perf(void);
>   extern void amd_clear_divider(void);
>   extern void amd_check_microcode(void);
> +extern int amd_get_this_core_type(void);
>   #else
>   static inline u32 amd_get_highest_perf(void)		{ return 0; }
>   static inline void amd_clear_divider(void)		{ }
>   static inline void amd_check_microcode(void)		{ }
> +static inline int amd_get_this_core_type(void)		{ }
>   #endif
>   
>   extern unsigned long arch_align_stack(unsigned long sp);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 307302af0aee..67966bdcde65 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1219,3 +1219,22 @@ void noinstr amd_clear_divider(void)
>   		     :: "a" (0), "d" (0), "r" (1));
>   }
>   EXPORT_SYMBOL_GPL(amd_clear_divider);
> +
> +#define X86_CPU_TYPE_ID_SHIFT	28
> +
> +/**
> + * amd_get_this_core_type - Get the type of this heterogeneous CPU
> + *
> + * Returns the CPU type [31:28] (i.e., performance or efficient) of
> + * a CPU in the processor.
> + * If the processor has no core type support, returns -1.
> + */
> +
> +int amd_get_this_core_type(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return -1;
> +
> +	return cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_this_core_type);
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7145248b38ec..7fe8a8fc6227 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,9 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define CPPC_HIGHEST_PERF_EFFICIENT		132
> +#define CPPC_HIGHEST_PERF_PERFORMANCE		196
> +#define CPPC_HIGHEST_PERF_DEFAULT		166
>   
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
> @@ -326,6 +328,49 @@ static inline int amd_pstate_enable(bool enable)
>   	return static_call(amd_pstate_enable)(enable);
>   }
>   
> +static void get_this_core_type(void *data)
> +{
> +	int *cpu_type = data;
> +
> +	*cpu_type = amd_get_this_core_type();
> +}

Does this really need a static function calling a static function just 
to set a variable?

I would think that you can simplify it something like this:

int amd_get_core_type(void *data)
{
	int *type = data;

	if (!type)
		return -EINVAL;
	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY)) {
		*type = -1;
		return -ENODEV;
	}
	*type = cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT;
}

And then amd_pstate_get_cpu_type() can call:

smp_call_function_single(cpu, amd_get_core_type, &cpu_type, 1);

> +
> +static int amd_pstate_get_cpu_type(int cpu)
> +{
> +	int cpu_type = 0;
> +
> +	smp_call_function_single(cpu, get_this_core_type, &cpu_type, 1);
> +
> +	return cpu_type;
> +}
> +
> +static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
> +{
> +	u32 highest_perf;
> +	int core_type;
> +
> +	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
> +	pr_debug("core_type %d found\n", core_type);
> +
> +	switch (core_type) {
> +	case CPU_CORE_TYPE_NO_HETERO_SUP:
> +		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		break;
> +	case CPU_CORE_TYPE_PERFORMANCE:
> +		highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;
> +		break;
> +	case CPU_CORE_TYPE_EFFICIENCY:
> +		highest_perf = CPPC_HIGHEST_PERF_EFFICIENT;
> +		break;
> +	default:
> +		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		WARN_ONCE(true, "WARNING: Undefined core type found");
> +		break;
> +	}
> +
> +    return highest_perf;
> +}
> +
>   static int pstate_init_perf(struct amd_cpudata *cpudata)
>   {
>   	u64 cap1;
> @@ -336,15 +381,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	/* For platforms that do not support the preferred core feature, the
> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> -	 * the default max perf.
> -	 */
> -	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> -	else
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +	highest_perf = amd_pstate_highest_perf_set(cpudata);

I think it would be a good idea to follow up later on validate the 
selections of this logic from amd-pstate-ut.c.

>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>   	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> @@ -365,10 +402,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> -	else
> -		highest_perf = cppc_perf.highest_perf;
> +	highest_perf = amd_pstate_highest_perf_set(cpudata);
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>   	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d58fc022ec46..869d916003f1 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -134,4 +134,12 @@ struct quirk_entry {
>   	u32 lowest_freq;
>   };
>   
> +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
> +enum amd_core_type {
> +	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
> +	CPU_CORE_TYPE_PERFORMANCE = 0,
> +	CPU_CORE_TYPE_EFFICIENCY = 1,
> +	CPU_CORE_TYPE_UNDEFINED = 2,
> +};
> +
>   #endif /* _LINUX_AMD_PSTATE_H */


