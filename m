Return-Path: <linux-pm+bounces-9627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E490F71C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671C91C21885
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB38158A3B;
	Wed, 19 Jun 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uA0oh6RX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B8156C6A;
	Wed, 19 Jun 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826065; cv=fail; b=JCwCF+3WQpg2jbfOEkKFntvpUZyv2vkAoryYvxcxZBzKCb2LbASyuyLSjGUP+C1y1Lklc0Eyxx48zXVNMuBqIhvQ2S7qDIdD3FWHqr8aPNhq2ICOtEYlQdhqEFB7vDWxVHEWG6+3pIYLPWGlw/QQ6p+mL+lNA0/l37To4WfoBJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826065; c=relaxed/simple;
	bh=1Pz4HXVJuaJ32aCupZNqtp2X0iECgxG8XSfLPyu4X8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMZ/SLQZ8NA1NbFuU493aFBtugvaVpbPMttSc5tymRocJ564ejOH1qjNHeKnHEN+0ZdWDPpVLPvPt0HVyu0R6OfUh5t9zgzjOA9KNtLs44DlvY8y29Gir5hmkF9z3Df45cjMFM428pSgP2juCzZDOLoephdV+p1XT5TdNi5BGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uA0oh6RX; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0B2muxWlpF6x6yFwluhj6qeTzUVub6M1yigzWcT434P3R+vqsJ0oKFe9EUTzqPUeZpJQ+sFMWhiwrSuQnJlOeJUHJ1Exxw/sCLlSY+7ldV33DSrAf/tbphAmn0dZGsFZ6HXtPxbhEkmzA3eEJfZoaI9cVdG8UerKadAy8ipL7fEuPPhg/M4vjuWHBHzMci9v8aTDUAn+YAr7EGhnpJ9lgFhmwLvVYp4vzawHx/iAVlTWXIjY80QqU9dut4CgNTDDjXez0Pm+GxaTpOh+MtstknJpdhoe3XCmyMxR0t2OQmSBbNeGm3a1u7v+igXLeo6aOfVlMTfOP/uTtiIANJqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK89dYM8EpB4hXBtOstWyJdzq/4W2wIiCm2kt9nEMAg=;
 b=KDNL2J4x/+BHDViBOMmSA12HBiqWipEw8aPoaVG7TFrXDusHU5CAnFcOlYtNJ6WTLdcSRYmCnd4/c5FJwvkTYxxaTmNpIRzUMga8JW28TKDFDvxGIizKyllrQgKXShyvmjhAEo9Q/CcfsBDAbPeGJN1fKqfOkW90W81ZeGyWfwazp2vqjfkEw815I14otgVdlO8IiBb02Ph4CCHroVIUN2Q7zB3OyCuEHxu1vFb5JosB9UXgtRZ4n6TErZBZetzuITVyQyXcbaV4Hm2TvPLLhU1Vp0VrxOtiAb5DL0bFwtpA+CwCFM5DX/SPWRyxCZOPgYRGRANqArqx4RCMGCtOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK89dYM8EpB4hXBtOstWyJdzq/4W2wIiCm2kt9nEMAg=;
 b=uA0oh6RXijdvz+XG5pouVNNK29ugq3iMwdAMWkovEg7p6nf2nY7RO0JPciE+qaREz/H3L2hEN8u3RtWBH+vjD80SFVqct2zvxv5TId1LVM8t5sUh1tFsoGs9F6ZL56aT0VLIEGVr6Ivj19bvsdpYztcbaiTqUtlK4UxMKwnkxDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 19:41:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 19:41:00 +0000
Message-ID: <a1389e59-e1e9-4280-a4a2-fd2f8050dab8@amd.com>
Date: Wed, 19 Jun 2024 14:40:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 8/9] Documentation: cpufreq: amd-pstate: introduce the
 new cpu boost control method
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718787627.git.perry.yuan@amd.com>
 <933b90997624cf7dd788ea770e5529b77ba7be0c.1718787627.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <933b90997624cf7dd788ea770e5529b77ba7be0c.1718787627.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:806:d0::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: e53e21c0-2690-4485-e224-08dc9097bf4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3NmTWJYazZNVnFCZGhvbFpWc2QvY1UraCsxbWdkcGo3Vm1FRExaSVN6Q3ox?=
 =?utf-8?B?bkk3TTZxRVMwR3lOdXMvSmcxSjVkNUhIYXp1TDFmbFZ3MVo1dUhIcS9RLzl3?=
 =?utf-8?B?QmpxMWFwN3V5Zm1jUGpTeTJtOVRyQ01wUHVIeGZGZHhWWHg0cFZKNTUvdTdD?=
 =?utf-8?B?RVV0dDlOTnJ4bmN2Y3ZhY1BmYlpZWmFYM2JHZGpRQVpXRElhM1NLSDBtUlFy?=
 =?utf-8?B?NEhDcDIwdFJGdmlDbkhtZjg1aFFNblBLclpaanBLdXZlemt1c2oxeHUvbGpP?=
 =?utf-8?B?SDQxb09NdWdxL294NjZtRGpZdDd2Smg4Ym90VXJ1cXN0QTlPcENKdVI2ZEVH?=
 =?utf-8?B?cWcxQ2tBNWw3SFFGNEJKMUFQV284V29OVFYxNHV2aUhsTlJHMm1CbzdUR1hR?=
 =?utf-8?B?NDZoYzAvdUREOWp4ZjdrQXFkK2l4K2JsSWJUYTdleGJjalNJQ2h2VE05SWl1?=
 =?utf-8?B?cmIrUXcxWTZrdGN2Wlp1VUZOTXhtWDFHbXBKQWJ5OUpHdGluSEpDc3Z5NFZl?=
 =?utf-8?B?SmpzVzlzZ3MvRU0zcGVTdytUdktGYzJDMi9xZkxiZS9vNnRhamhTU1ppZ1Nz?=
 =?utf-8?B?Y2lqZXVjZEs1VXMrQkprVnJIeDRjbnlCampIWDVYS1U4eG91NHpNT2ZEZjcx?=
 =?utf-8?B?LzlwbzJRemNUb0pHSEw1eklCalRMaGpkSlBQY3VnVXorbXpFd0VBUVY1UDhE?=
 =?utf-8?B?RGFJN2w4YmtTVC9tYzVMS1pOcG92OGlkYWliazBTaUNncitwdDdGT0dNWUtj?=
 =?utf-8?B?eXlMaDlUVzhjSDZEMjJWVVQwQWRLZTQxUVU2V1grQXo3cWpOMjB0dDFDbUVM?=
 =?utf-8?B?dGNaYllvMFlRK292L0xQR1NRSjN4MFJNWUtLdHBXOHNXL1Jxb3B3UXpLdlF5?=
 =?utf-8?B?WGRQOGJwZkVIWVBUTmF3SW9sMEl2QWdrV1FnbS9RcVMzcVBkVEJtUzVReXcv?=
 =?utf-8?B?NDhwZGZITFliUlAybXdqU1F3NnRVQVhQZXhjbXQyZWRBVnNJamxZeVRKR3pW?=
 =?utf-8?B?Z1JRdU1DeTRPOHVOZGJqNG1ibWVKVWpKS3dMK1d1MmVEd0cvb1JzRmlhQzRs?=
 =?utf-8?B?djJEVmlTNFRDdzU0WFF5eSs1eVVyNDVBdm1Qb3ZXa2RhVEh5SFVKV213bG5Q?=
 =?utf-8?B?NlBYR1BWOUQrdDlDSHBpMGRNOEtnS1BHODVNd1FIN1FhYitOTnhjRUtYNFhE?=
 =?utf-8?B?SmtLMkVvanYvWW13blBLUGZ5b2xEOHNBNHErY0xEQVl0VlBFSWdCUFhNMXls?=
 =?utf-8?B?SkN0eTZnZVdyRTJSMTZnVTVqYTBVaEQxdWZXM2hGWSsvdEJTNVFEejBhMm9o?=
 =?utf-8?B?R3llR1VnNUJlYm8zUFFnQ3UwZVJML09UMFRoc2VmWjFtY051NTQ2VlIwMTd0?=
 =?utf-8?B?TjZac1IwQlVIcXFqV2l6QVlmaXFLWDZBZXBVNDQvOTM4ZWg0eisvWWhGajU4?=
 =?utf-8?B?cmR4eTJWZnNOL2hhdTFPMEJxSnQ5TjZBL1UxSjE3MzJKZzUwdkhsZDhnWjZ5?=
 =?utf-8?B?ZkdIMkZlaHVsNW5pMythRVlNaWgzWm9Bb0RrWXVDa1NueUhxV09nVFdPQVlR?=
 =?utf-8?B?VlFxWjRxalBYUkNIeXNneHo0b0djMFdXa1dHY2VGKzREUzdFMFNza0dzZWVG?=
 =?utf-8?B?enR1WTkyYy96dmFVNDJ6Y3dnV005RjVaSkoyMWEyUTZHWVFSblhpTWdYVHBP?=
 =?utf-8?B?M3lmYmdYSWVVZVBnelp3OW5maXA1bnI5WkFBNjNEK3FpUzRiejhka3VJNTA0?=
 =?utf-8?Q?Udovd9MmcXPqpQe+s6ztZpuJizdNjVcb+8wjhvA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXRSMTJNdGZZUTF3YmhOSXE4ZVQyays0cldxcCtRbm42cUlrZVJCaS9QSzNF?=
 =?utf-8?B?S05PdC9KTklMNTRWYUsxbXpvZEIyTUIzVklvVVcxSGlqeW1RTGhYL3Jsd1NZ?=
 =?utf-8?B?MEM0WWE0Z25oTVBrOStFcWt5MnpQb1ZwQlhhR1hvRWJDcllWaFN6N0RaVUhw?=
 =?utf-8?B?aGZVemtzdGFPL08vNkZYSEtSQmlUWHJiSlFBRWJVM2kxcDRybklKcFErM054?=
 =?utf-8?B?RGhsVTZlV0h3ZDhlaDlmOUZZT3RPL3B1UGJmRVF2K2pzUWJDSjVOcnlxdDh1?=
 =?utf-8?B?bndwVWZJcjNUajN0MjZOV1NQRUhWWmptL2w2S2xRWlNBWTIxMDJOMEQyTW8v?=
 =?utf-8?B?WkZBTUZyWjBkdDlSalRVL1FsamlFNmdiYWR4azlGZ0Zvb3dXc0haTmVESXQ1?=
 =?utf-8?B?L0JsemFoM1Jnd0t4T3dLRllYQnJxbXZ1WGdvRFA4Q3p2eEhGNUJnUE9KMkVj?=
 =?utf-8?B?VkN2NHZyTHFlQnZ0bitKZkZtNk9tdTNEbGNNN3kzSWRCWVNTNHZmMlF1RE5D?=
 =?utf-8?B?QzN1M2sxakhVVkRZUHhlTlREcVF6MWJGTFFTcGxyV1MxaW1XeWQ2RlkxUzM2?=
 =?utf-8?B?NmphV1l5dHRraVdreTJZV0xXcmtWK0hSQjdmckFJL3ZCSjBpYmx3SkExZGZs?=
 =?utf-8?B?USsrUDdRYk1CNkRsUk51SHJPVUVoak1BOFJacHY2cmVMOWo4RElubkdzTmtt?=
 =?utf-8?B?S0JHT1V3VGJrSmhWQ2phL0F2K0JtcGUxZHE4bUhCQTAzZnBWL3BYWlpJZFVE?=
 =?utf-8?B?Ykp5cVU2M0FmMkJLeXAyQU4yYTd1V0pQdUdXNTNhQ0JueWlULzhwdW00TFVi?=
 =?utf-8?B?cUdsbFpGZEdlNitvZTVoS1dtS2J0N3RhTHhFck1Cd3ZuMWhBb2lsMU8wMEZW?=
 =?utf-8?B?eWhJK1dmcnFGTnA1Vm9rUHB0QmRiYjFQL056T0dkWXpTL253MlBGSnJEQzdW?=
 =?utf-8?B?dmtvT01lNXBRZk5mR3FHNUZzZndVSW9ERlJuTStLdDZNR29xR2FnK1A0bEFD?=
 =?utf-8?B?NHZFSFg2NWl0OEsySXJ3K0lDN0NvMFBmbjIweFlsZ2JzdlhmWDZGMEFacDZX?=
 =?utf-8?B?ZnhwS1N0cjJjSGlnVVNFNFkyTWlPdllvSWM4dnc0NE5raTRhN0ZwMHl5V1dM?=
 =?utf-8?B?R0t1MmZRa1UyNlZIVG5CaTRqbVc2aTU1bkNTbXBRRmcvTVFmeElybUZoa3Bo?=
 =?utf-8?B?WkRuZWs4VUpUSG5pUGdIR0tSOHNxaHJ5RkRTeUkzb1JLRnRyL2FYTGh3WkRm?=
 =?utf-8?B?L0pLZ2pqbUFZS085dlJMOFZ6Qm1CQ1Z6MVozYTd1UnNPVkZGR2FWdjF0NUlR?=
 =?utf-8?B?QWFsNlRDbm5qRjJKY1lYbW5TdnlOdE9uTlNEd0ppSyt3WmN1bEY1NlBtZ21k?=
 =?utf-8?B?Q1JXcTNFZ0JxWG5KNzhwUDFZdGZzMm1xdVdkMHhpUzB2Y25tSEZ4UjBaWVIy?=
 =?utf-8?B?cFNNcXh4ektYcElTSW5IZmZxK0hFdlRGbnp3bTZWM1ZLbVZhQTIwSytYS1V3?=
 =?utf-8?B?UDBvcklEaFVZVUtZVnMwbks5YkdsNEtIMkJKeDNtbDJuZmRpT3VEbml5UkNt?=
 =?utf-8?B?Tzd2blJzTlFnaEpkUmlzMk50ZTJwZ1lCNnlNQ1dlTGR3SVFWRzZTTU8vR3ZR?=
 =?utf-8?B?YXcyMlUvNjBabWx1NVdDellhYWZKNzliRnprdS9KYWg0VzZVeVBMdVdwWVNx?=
 =?utf-8?B?ZzVIbmJDWGdJazFKVDlCUWxYdFlCVTUyZVpWTFYvWGpOOGZmdklCQ0RxbExN?=
 =?utf-8?B?bU5oRWhNUW53ZWptQ3dSaHg5MG56cHVDYTV1K0dMWGsrSmR2cGNnTzlNSTVK?=
 =?utf-8?B?OXZxLzhkVmNSWi9FaFhLeVFOM0xpNS9xUEwzSE5MbTViVXJSejdPSzlDQ0lj?=
 =?utf-8?B?QWR0QTZkZ1VnNXlWN201WlBZYnFBa1pkckxuUzFBaGorcEZYYThUT216MmNU?=
 =?utf-8?B?RnkzZUR3YngwamI2MXZRTXdyY0pDbitBZzg1K1hRWDZzZGF5ZVI2WWRmZTJ3?=
 =?utf-8?B?R2x0VTFqOTM2WEtzd1IyQzR5SmsvSTRLeUlsMVJ0WGx2S3BFV1VDbUFOaFc5?=
 =?utf-8?B?T2o0VVk5NFRCV2FWdFBEK1lNa241eUxOTEFOQkJNM0thaXg3enlKdHozU01G?=
 =?utf-8?Q?su/GSJdXQco9Xmm0YauqzmJKe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53e21c0-2690-4485-e224-08dc9097bf4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:41:00.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4SfCO1xYruzbEEOZJLZEjKypIJ6jLOJ2NYKuaOn3M2yD9tMHXpfNTRodWPa9W8nUbIXJjxncHfoIR1qofBWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

On 6/19/2024 04:16, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce AMD CPU frequency boosting control sysfs entry which used for
> switching boost on and boost off.
> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core automatically transitions to the highest performance non-boosted P-state
> The highest perf and frequency will be limited by the setting value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1e0d101b020a..bcc0d9404c18 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -440,6 +440,16 @@ control its functionality at the system level.  They are located in the
>           This attribute is read-only to check the state of preferred core set
>           by the kernel parameter.
>   
> +``cpb_boost``
> +        Specifies whether core performance boost is requested to be enabled or disabled
> +        If core performance boost is disabled while a core is in a boosted P-state, the
> +        core automatically transitions to the highest performance non-boosted P-state.
> +        AMD Core Performance Boost(CPB) is controlled by this attribute file which allows
> +        user to change all cores frequency boosting state. It supports all amd-pstate modes.
> +
> +        "0" Disable Core Performance Boosting
> +        "1" Enable  Core Performance Boosting
> +

Please switch to disabled/enabled as suggested in patch 5.

>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   


