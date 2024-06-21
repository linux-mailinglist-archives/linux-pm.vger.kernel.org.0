Return-Path: <linux-pm+bounces-9787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CF5912C70
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 19:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985281F21EF3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086415FCF6;
	Fri, 21 Jun 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uT4ZFaxp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9415D1;
	Fri, 21 Jun 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990879; cv=fail; b=gnWM47hMrE418COLNrwcoYRBjtPY6P3Ep9QIyVbEqWlLNkUVu65jVvGyHpaVr3TK/65yL4gpsMedaXTbCsnYGwfyJo3tHAmVO2rfHWdCkm8SgfvbYvS0qIRYsnIGqPfnYG0kV2lACIHQdsevaGxfr7b2qqhlUUqq/lZq5hJ6xJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990879; c=relaxed/simple;
	bh=ovs/mEC/002KZQJYWGpC8F6GANi6G514ZFVx5TDpslo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpgofrvyMR8wZwNZsjcc1Vc7Bn8Ie8gvZQP5TvlQA7h6gsH8D/IjmwvJ4l4I9xnmD9yDwyzRpspfgu85Sa0vu/mhZiUiPEDBFWavb/NHgGAv3RDiQ6+xw62r/GgMF+1xU3aPb+MGitjIOvQHJVzRHJg9oCRNQv4BypP+DkXZu9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uT4ZFaxp; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuCRSsK9WMJFt3Pn/sC+ydXtRdtcDcKiPJomPbPSAsRxnvuhmTaduMiDR/aMystwS3P50x/AwAG1km+QhpJ6Oddc+KUB2M6JYn7YrpiOZuYyoZlYvSQDn9HcXaBS5thJqjtfPXYYTxIaCdtVvNTcnoWvTOsdPq/ZQN+/M4ruPRv/LXKl/X2H6eKAByG1fp1xfxIJmk0mfNMvBOGC+6JJ05SGo4rQ3YCfg1OLfrWDMVL3EiGGbNWhxO/tT50Xd5456A3lTEukTe0GrtkKv0yJ8c8sTH5DfFqOxZY/yUFrgEuBQziJjcKLgAfbjAIQ8rQcjYGMl1MDrr0ilTcBDGhJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcTC+t4VZOGm04JX58y88U7rLCgKShoTTHMxpoQeslU=;
 b=HT1Cg49kJRfzwjOcBRAG04eVVfsd8RvPI2NAB9fGFW5TJM/x8J5nkV9/uZ82MtpIPjY0XcPoi+ENHp231YgvUUdjQSyunhqGmTyWlFK3G/QITvAPyesfyP8QPECr+O5Mqt2RMoAuJKMEc3SRsAJFoMlX2yj3r8mPodP0U8/QjQ+DxbGUoy7PAzMlOMLfxzlT30h+yZLmWX9WYFD/1OJth8fyIl2zxpZWwjQv1n4XknAWAjAw5Xx+bxDKGNFcJ4cc+og6bhdpKtqNmc0O4EqMWhau0pOr5zlUgmodc6310oQfSHk6VHcWjzFuXLxURrx3Yv59c7luIknd/zK+xHtUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcTC+t4VZOGm04JX58y88U7rLCgKShoTTHMxpoQeslU=;
 b=uT4ZFaxpf/8rrGtFLRuGVqbfwowsamttly8BlO8ZOloYb4Un/t5klDAhPDkkZsQ5mk+A9cZMym9H/p/bWoHS4pWBCzUcIvLiHgqoFLNZ8FDzZ9aCWBmMu1uuo+CdU4/qYKAYH8qw4RCj1/ZXdEMyebuWJrISEtoYqsYSaLxc0ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 17:27:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 17:27:53 +0000
Message-ID: <1a78eeaa-fadd-4734-aaeb-2fe11e96e198@amd.com>
Date: Fri, 21 Jun 2024 12:27:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/9] AMD Pstate Driver Core Performance Boost
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718988436.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:6e::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 332a34e2-f47e-424b-8ac5-08dc92177b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0RwVGcvWkZpWVJHVHU3U1p2dGs2ZkZzNXFXMis3eVFGTzRhdnpXQjZtSlZp?=
 =?utf-8?B?OHhSbk9sWW1ueWtISEJIY01aaldhUE90eEVQWlNCUGdOeEhJVW5PZldhbWp6?=
 =?utf-8?B?WGplc1ZmbVE0eDFyS3ljQTBGNXdlTEx5Q2ptaG1tcXIvS1Z3U0VZbnV4Qlh4?=
 =?utf-8?B?QTJRaG94eCtKNkZxRFl5ZUZhQlVDSHVSdXM1ZEtCa0JIRkFaRW80dXV6dVI4?=
 =?utf-8?B?MStRcE9rY2dtWCs3TUpTUzVhY0dIRkhJRWZ5QSt3NjlTb05Ud3lpdFM5ejNk?=
 =?utf-8?B?QzV5WlE2b1VveVZEdXB1VTM1ajlaSmxscHNNRHkrdjN3THVTTVRRQm84RkxX?=
 =?utf-8?B?dzM5QllKakZ0RDN3K0h1dVVXR29NWk8zVUs2cnlnRlM4ZWt3L1ZVcjVBa2o0?=
 =?utf-8?B?Tm9IVUptR0tmSFhQaGUyTmNFVEUwb2RjckV2WFVwczc5eXl5VUJLZ3BtdXBV?=
 =?utf-8?B?REpIcFN5bTE2SzE1ZUd3dE1TRmgwRHVnRUltRk1BNUgyWDEveU03VTB1dzZu?=
 =?utf-8?B?VHZIVHBvbWYwbkphK291KzFDMlVXVmhUOTM3cEhGQTYxWmpoT3V2N1NUMWZX?=
 =?utf-8?B?UXpOakM2cVNQdGhCSExlTjdBdWQ1VHBoNFlVNHp0UVlBa0Exa2ppNTJTYjdy?=
 =?utf-8?B?MGlTTTFHcVJ3OUdBcC9ReFFkdmFITUdnZmJXT0JWYVl3WGZvOXJpSjRKZFZh?=
 =?utf-8?B?bUk5VGtmMUh5YlN5QmZwaG1tVzk4Z1M2Qk95QTFHRDdNTVlIb1lhOWdIck1t?=
 =?utf-8?B?Tk9KMWwyTUYrcnlFYi8xdzVwMHRHTFptYlpDSUZmWnhRYmE5c041WUcwVXJq?=
 =?utf-8?B?eC9RUzlLQ2RablBhYlZVck9TemswTXF4WlF1VzdHMzBSMkhaOVNKaFkrcWJv?=
 =?utf-8?B?Y1VRTjJrbmptQVF4a0xudDI2NExLQzZIMGV4ek5xR0Zacmw2YWo1WWpSNkEw?=
 =?utf-8?B?Sk5LeTJnRElqSDFPTW00a1hmZ1dvbnJFZXdCL1E0SEJjZDZlYndDZ2puOEN4?=
 =?utf-8?B?SFhqSHNmNytJUjhSNmU1c0FXckR2RUVwZFBnTHRlVmFzZUx4alorZjcvY1pj?=
 =?utf-8?B?S2FQS1FIdS9Zd1NGR01LSUZWOUREd0FNN0lwVTA1YVhCVDN3ZXIyajBmZG00?=
 =?utf-8?B?bGt1QjNpWjRNOWRBTUpJYjUwdDZsK2tFVW1SbVZHaTJBUmJQNG4wa3pxcHM3?=
 =?utf-8?B?OFNSV1VEbkw1QzdnQzRPYlU4YkVDck1sa3YzZXZBUUlpcDBmbVJ0QlZPMlc5?=
 =?utf-8?B?U2paR0tISkN1RGcrZUtzS1FLdnlmcktGOUxCTXorOUVaTkNaM0FnSEU1RlV5?=
 =?utf-8?B?YjJmZkkwMC80VWR6ak40elo4c3VkVWdCZ2lXZnQrOXdSOWhURXVJRGIzcFBp?=
 =?utf-8?B?VDNpSDgwSDZ3aWg5WUIrU0owUUJoYzhGVWxUYlpwekpRMEdFRGFrSjZta3NW?=
 =?utf-8?B?Q1A3SmRpdmluY3ZNcEdpc3dlaXdBcEJ5Y3lYTFJleWdsbEpxNlUyVWJjUkxW?=
 =?utf-8?B?MElxcUFNNjZWWWtXSHRnMm13YzkvRWkzeVJCNzQ2WmZHK1RqSEd3Zy8xTmkx?=
 =?utf-8?B?ZHhhTFJkYW1RbHhadXlSZTZDZGlUL1RGYy9qY3p2SkQ1WWh2ZTVMaSs5TWd2?=
 =?utf-8?B?UnVXWFp5WXpSb1JUUkRzejJtOE9Kd1hNbEp2aFM4WDR6czE4N3VwUndOMjdr?=
 =?utf-8?B?aksvcm14WmtHRXpRYkg3aFRJTFUxN3VtbVFFejdYZkI1Y01YK0hhZTRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJKaXFlaUVNYTh5TmdqejNTKy90dUNrTklTYnUxdXZNOUZySmpzRkRIZzJQ?=
 =?utf-8?B?dU5kcTBBNVNjejA4NXo2REJlSXQ1RERTYjc4Sm00NFpobitLVUM4S05SSVdQ?=
 =?utf-8?B?ck51MlNKdDBIUzJTbG4zNkFvMkkyUGRMWVNxR3QzTDVGZ2xmb2NKQjMxUjV3?=
 =?utf-8?B?SzBPak9STUQvbGdvMnFTUEFyZWRoc1REcWsrazNNMFIrSlM5SkNUdjFObVFt?=
 =?utf-8?B?YjNpYjZlT0NCSkNwLzFua2xCcmxZR0ZaR0xHNVMvd0s1bGh3VDFISW14TVFz?=
 =?utf-8?B?dGZmN1NIMWFsUm1GNDFiT3FZZHdvd1ZzR2NucGhoaFlaZ2JHVkZPdFVIVlZO?=
 =?utf-8?B?TnVRS3ZRMFhaN2NqQkpCV2ZRb0h0YmxwNDRyMTNXbUFBSHZiczJBWm5kSTh5?=
 =?utf-8?B?VGNNTHBVdlhBaVZEc2pmeHZSRE9xc1FyVWV4RjdzaDc1Ulh3TzZBUlNaTUJE?=
 =?utf-8?B?ekxBVTNINElUNVA4QXhCdjlyYlE5U0gvdzM5V0NBWVRXZ3dJWDdUSlkxc2Rl?=
 =?utf-8?B?amIxaTVKNlVnSFZIaG1ENkMySHZnakFwNk8xajJhVzVaMXhKYWYzanViR1l3?=
 =?utf-8?B?QkkvRTMrSGY4YmQvTW02bzVwbWtZZnFibGZTeUpnN0Q1VGdNcDlEdnhkYzFE?=
 =?utf-8?B?cFB5S2JlK3Q2UG5OZWZOemRqZDV6WDdDbGFNbEUzV3ZwVXdoOGhnV1hRNTBG?=
 =?utf-8?B?c1ZzNW9qNWZwMkxtd2JyZVZXWVRIT2ZLd3MzdDJEamsvYytSUnFaeFBZb2xC?=
 =?utf-8?B?N2JxcVRmanZwQmo0cVY0SXl2bXZSY01wSTJoQlFhNktJbjBJYTZQRzJ5YXZK?=
 =?utf-8?B?bUJuTzUvK2wyemlxdGJwei9vVi9tamVqUlEyRnVKN0JYWER3b0V1bWJTVGJ1?=
 =?utf-8?B?cGp1V040QWNRUTI0T3Q1bjBPODFWNGdrRUE2d0xaOXVqbVFrNU43cVpncFpC?=
 =?utf-8?B?QzRWWkhoblVTUDVUSlZYV0dseUV1ckUrTFpaMloxRzVtbEFIRUQ0QVR0UVVS?=
 =?utf-8?B?ZTAwY2I3Q1IyMVEwb253TDljQXlmRWpkTGJrUU5kNUZJTzY5NnpBUlE3YTYr?=
 =?utf-8?B?YUJrLy9FU3ZyQVFBUVN4RjF2UFVCaWgvY2dYRFo2TDVJK3FaZ2wzdG5KYjNF?=
 =?utf-8?B?ZFNEZ1dUbWFvYVZtT1lsOHZORVBSQ05zZVZpN1VzcElMY29TTFRHR2dUNE5L?=
 =?utf-8?B?bzR2SFdad0FMbklNRGlDVVJPck1meUVvUDgwUEpPaFJuN1d4cnRNOEtnZWt3?=
 =?utf-8?B?bURlek14Yk5MUTNmMHhTS3E2aUZpejZxb3pJUlBxN0ZzdEtYbnJkcjUwb3Mz?=
 =?utf-8?B?aUNsbVp5TlFYOVZ4NzRrdmpPbXVtUU1XbTNkWjltdzRnRDhDS0NyOXJWL1Mv?=
 =?utf-8?B?Z2dhZ3NTUXAxUTZUd2JacysxcGFwcDhzSU9SVGRNdE9ndTVOZTkyZUwxc1dY?=
 =?utf-8?B?L0NreG9Oc2RsSjBkbWFRd2MvWXRXMllWd0xncUNOMEV3dUx1MVM4MWg1aHEv?=
 =?utf-8?B?eFVxQWxnQmNsNlR1RWZaRzZTektQaDhxWHFHd0NtREt6RkYwUitLcHVMNzlt?=
 =?utf-8?B?NU14YVRpZVFPZzMwVU1tL2MxRGJRUXlsaWI0Q1lkbEdmREQyZXdGczY5bFQr?=
 =?utf-8?B?OUp3ZGZpSXVzWHlPajJrTFJaUDRhN09RWGdPdklLSFErVnp2NHYxYnAwNWdt?=
 =?utf-8?B?c1dGY0h4WmpRUWVOR05RQWZxZzhCNGNsQXVDNTNvc0g3YmhvamVDRk9VN044?=
 =?utf-8?B?VnlIZU9Yc1U2OHMxdEZuYXpuM3JuOE1zZ2I4bnVLc29OZkh4ekg2Ky9jTUFt?=
 =?utf-8?B?ejhLUERrRml6S2I5N0hoQVMwYStNeVpNTi9mamxoeDZNVXB2TmQ1MnR4aHAx?=
 =?utf-8?B?UFdXZFlsL0hiNDhhbjBtbDl0MFQrWHpTZU01ZzRHMGFMR2ladGN6STR4Nk1D?=
 =?utf-8?B?Q0dMYU8wV3NadytjdzRhcjJsNnFRaWp1LzR2OGJJNk9TcTkwWXFHRXppSkI0?=
 =?utf-8?B?dytKNUh6VnF2ZlhMTlA3RzlCYVNGMCtCekw4WVV3eGNkQWdHeHo3UnNPYzNX?=
 =?utf-8?B?Q0FQb0NRaXlDVFlpaUxIZkNrOWZqZ3hzUEdUQnBCV2pHUTUrRXdlT0ZwWHlG?=
 =?utf-8?Q?Mv7kxCOysRKVyHetphHTU7S4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332a34e2-f47e-424b-8ac5-08dc92177b4c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:27:53.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybPoiFhnCCoFXmDJxvI3EaDPTepT/l1PSzfgdAKTj0BYTiT6vdVU0CDTM2jQi9/Hp5vcQaSGAmYyhlxVauj5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066

Thanks Perry.

I'm happy with this series now, but it needs an Ack by Rafael and/or 
Viresh on patch 3/9.

My plan is to apply it to my bleeding-edge branch to let robots do some 
test builds over the weekend and I'll do some manual testing as well.

Once I have a tag from Rafael and/or Viresh for that patch and I'm happy 
with the testing results I'll queue it up in my next branch.

On 6/21/2024 11:50, Perry Yuan wrote:
> Hi all,
> 
> This patch series implements the Core Performance Boost (CPB) feature for
> the AMD pstate driver, including support for passive, guided, and active modes.
> 
> Users can change the global core frequency boost control with a new sysfs entry:
> 
> /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> It also supports updating the individual CPU boost state in the sysfs boost file:
> 
> /sys/devices/system/cpu/cpuX/cpufreq/boost
> 
> By default, the global control will override the individual CPU boost state.
> 
> 1) disable core boost globally:
> $ sudo bash -c "echo "disabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> disabled
> 
> $ lscpu -ae
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
>    0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
>    1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
>    2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
>    3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
>    4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
> 
> 2) enable core boost globally:
> $ sudo bash -c "echo "enabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> enabled
> $ lscpu -ae
>     0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
>    1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
>    2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
>    3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
>    4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
> 
> 
> ============================================================================
> The V9 patches add per CPU boost control, user can enable/disable CPUs boost
> as the below command tested on a laptop system.
> # before
>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
>    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
>    2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
>    3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> $ sudo rdmsr 0xc00102b3 -p 0
> 10a6
> 
> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> # after
>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>      0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0000
>      1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0690
>      2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4541
>      3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> $ sudo rdmsr 0xc00102b3 -p 0
> 108a
> 
> rebasd to keep syncing to Mario kernel tree: bleeding-edge
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> 
> Tested result:
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
>    3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 3110.0000
>    4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2732.3569
>    5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 2312.2109
>    9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2310.1011
>   11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140
> 
> sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu11/cpufreq/boost"
> sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu10/cpufreq/boost"
> sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu9/cpufreq/boost"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1242.7240
>    1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2754.5710
>    3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2659.8159
>    4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2308.9929
>    5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>    9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140
>   11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140
> 
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1233.8630
>    1    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2714.4851
>    3    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2732.3569
>    4    0      0    2 2:2:2:0          yes 2801.0000 400.0000 2564.2639
>    5    0      0    2 2:2:2:0          yes 2801.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 2801.0000 400.0000 2732.3569
>    7    0      0    3 3:3:3:0          yes 2801.0000 400.0000 1110.7140
>    8    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1233.8660
>    9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.6630
>   11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.5050
> 
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1234.0200
>    1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
>    3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
>    4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2278.8491
>    7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2732.3569
>    8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>    9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2353.0449
>   11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140
> 
> 
> Perry.
> 
> Changes from v12:
>   * fix the braces for patch #3(Mario)
>   * fix the return value for patch #4(Mario)
>   * use enabled and disabled for cpb_boost (Mario)
>   * pick RB flags and Ack flags from Mario and Gautham
>   * update commit log for patch #7 (Gautham)
>   * add more details to doc for the patch #8(Mario)
>   * address feedback from Gautham
>   * rebaed to Mario kernel branch
>   * fix the commit typos for patches #5(Mario)
>   * update cover letter for cpb_boost state change.
>   * tested on shared memory system for cpb_boost control(no regression found)
> 
> Changes from v11:
>   * add “goto out_free_policy" for error handling and update error
>     mesasge for init_boost in cpufreq.c (Mario)
>   * drop dead code policy check in amd_pstate_cpu_boost_update (Mario)
>   * pick RB flags and Ack flags from Mario
>   * rebased to Mario bleeding edge kerne branch
> 
> Changes from v10:
>   * rework the boost interface with cpufreq core boost control, align the sysfs file
>    created from cpufreq.c and allow indivial CPU boost control (Mario)
>   * fix the pr_warn code format with %zd (Oleksandr Natalenko)
>   * replace sscanf with kstrtobool for cpufreq.c (new)
>   * drop the boost sysfs file creation from amd pstate patch #6
>   * add init_boost for cpufreq.c to unify the boost file creation(Mario)
>   * add set_boost callback for EPP driver mode
>   * fix syncronization issue for indivial boost control and global CPB control, now the
>     two control way will keep syncronization after anyone CPU boost state changed.
>   * rebased to Mario kernel tree: bleeding-edge
>   * run testing on local system, no regression issue found so far.
> 
> Changes from v9:
>   * change per CPU boost sysfs file name to `boost` (Mario)
>   * rebased to latest linux-pm/bleeding-edge
> 
> Changes from v8:
>   * pick RB flag for patch 4 (Mario)
>   * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
>   * merge patch 6 into patch 3 (Mario)
>   * add two patch for per CPU boost control patch 6 & 7(Mario)
>   * rebased to latest linux-pm/bleeding-edge
> 
> Changes from v7:
>   * fix the mutext locking issue in the sysfs file update(Ray, Mario)
>   * pick ack flag from Ray
>   * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
>   * rerun the testing to check function works well
>   * rebased to linux-pm/bleeding-edge latest
> 
> Changes from v6:
>   * reword patch 2 commit log (Gautham)
>   * update cover letter description(Gautham)
>   * rebase to kernel v6.9-rc5
> 
> Changes from v4:
>   * drop the legacy boost remove patch, let us keep the legacy interface
>     in case some applications break.
>   * rebase to linux-pm/bleeding-edge branch
>   * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
>     Enhancements which has some intial work done there.
> 
> Changes from v4:
>   * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>   * pick RB flag from Gautham R. Shenoy
>   * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
>   * rebase to latest linux-pm/bleeding-edge branch
>   * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
>   * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
> 
> Changes from v3:
>   * rebased to linux-pm/bleeding-edge v6.8
>   * rename global to amd_pstate_global_params(Oleksandr Natalenko)
>   * remove comments for boot_supported in amd_pstate.h
>   * fix the compiler warning for amd-pstate-ut.ko
>   * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>     error during testing
>   * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)
> 
> Changes from v2:
>   * move global struct to amd-pstate.h
>   * fix the amd-pstate-ut with new cpb control interface
> 
> Changes from v1:
>   * drop suspend/resume fix patch 6/7 because of the fix should be in
>     another fix series instead of CPB feature
>   * move the set_boost remove patch to the last(Mario)
>   * Fix commit info with "Closes:" (Mario)
>   * simplified global.cpb_supported initialization(Mario)
>   * Add guide mode support for CPB control
>   * Fixed some Doc typos and add guide mode info to Doc as well.
> 
> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.com/
> v10: https://lore.kernel.org/lkml/cover.1715152592.git.perry.yuan@amd.com/
> v11: https://lore.kernel.org/lkml/cover.1718262992.git.perry.yuan@amd.com/
> v12: https://lore.kernel.org/lkml/cover.1718787627.git.perry.yuan@amd.com/
> 
> Perry Yuan (9):
>    cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>    cpufreq: simplify boolean parsing with kstrtobool in store function
>    cpufreq: introduce init_boost callback to initialize boost state for
>      pstate drivers
>    cpufreq: amd-pstate: initialize new core precision boost state
>    cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>    cpufreq: amd-pstate: Add set_boost callback for active mode
>    cpufreq:amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is
>      off
>    Documentation: cpufreq: amd-pstate: introduce the new cpu boost
>      control method
>    Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
>      control method
> 
>   Documentation/admin-guide/pm/amd-pstate.rst |  38 ++++
>   arch/x86/include/asm/msr-index.h            |   2 +
>   drivers/cpufreq/acpi-cpufreq.c              |   2 -
>   drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>   drivers/cpufreq/amd-pstate.c                | 215 +++++++++++++++++---
>   drivers/cpufreq/amd-pstate.h                |  14 ++
>   drivers/cpufreq/cpufreq.c                   |  25 ++-
>   include/linux/cpufreq.h                     |   2 +
>   8 files changed, 265 insertions(+), 35 deletions(-)
> 


