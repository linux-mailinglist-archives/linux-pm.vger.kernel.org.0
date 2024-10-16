Return-Path: <linux-pm+bounces-15779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA279A0D7A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489A91F23EA8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4EC20E022;
	Wed, 16 Oct 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nn87stqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E420E001;
	Wed, 16 Oct 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090650; cv=fail; b=Ar+PBymzCn5alexKGPwN9/Mq/6ea6tii+usrQXotPApoMnLBLVnW+g8SAXSgLkeraHwdxOldtc7sl6q6vmtSFTD/A9HnIrKbci/VSA6D0LuUHKTRHfVu+5O5Gdg9nnZ/NjIl0T2M+tqRAKaxwdXttfg3LaVJMFRKfhvDBpwVtK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090650; c=relaxed/simple;
	bh=FbawbJsQXMDhlrVPCNyfJQGc1KfytjkleKldmSLujxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8deTQDIjksspBDySuVS+xzHV5uru9loDYzaxqyI447rBx5ZwpiGLFmWg0SmKvKQdfWZ4ELRZZ6HwyxGFZb3kjFcWlC6FhDvvfR5/seSVKQUkGo2RJnJtifq45T4aPpFFEzNNdURQflsxjbxEwnVcbs3k+2Ds+B0gFjQv8tGgyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nn87stqO; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsgb+iLH6XU6s6/dHcuiTGzjwbmteckbfZAOqJFRD1gP6bLx/3WiTC/Mvn8YgyT57T/P7csXjeRXlIvWQLhk0sfhN1EzGJRCntmOO4IYr5/IzSL41G5podlNdjCONuSXl5SsOA9NeXcmyQBAf4U+xmYzHSWZaT8obKwBTcOg/ni//Kj4ZGRRWtZgNB15J46bOyOxnMtcjGpMn3bDvro0DqwXHmYJpABtsirWles7JSZRxCvf3UR62SDxAEbWKNOFCn9BrolJ3uvdSVXILDLpaWgyBqG1YjkdbF1Pdvs9d7nxu3etnSc6hba/g5KAfdwX8IQrCXthjLHVa6LIQyA7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VllrYeFC5BKea13voomkxvwY1O6glQfbago67pfx7fE=;
 b=vwgu7rxCur7CRrNrJyy865DxORKPmFiiMdPpl8524SN29UWB/ZuVuPAZbeq2QYCrDL0tDiCeBJ2ZtS88JAoxJwT16Y4e/RMSgRxYNkApyFDln0kwlDgkavLTs1u46I5oTdP/PFOLxTHvmMVoUPMspg13nRkw4CXasbf1yntQPZWMrUQgNFZLFmOdhNg24Nq4/q3+GdmR64H3Yu8wliRRGZ9oweITfCnW3nwRxwDbTAoCeTXuyCX9YwGJCEn27Ta8tbaomBDtms0kekeE2IE5OHCXbKWwK4ExooM4NvGwB1egQB5/PJNWBIzzpWDXBshcYpgJxM438HUZ43YR3F0I1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VllrYeFC5BKea13voomkxvwY1O6glQfbago67pfx7fE=;
 b=Nn87stqOfoNgr99RzFQpa8BtzQiY8mo1vc1mOxVTfz6YIsp37V0XKhMfzIJAlfFdeRbTwjnNuvZftUTr5XQbvA5N382qvPLNdkugj73kesq1geRzdvBPX8nwPgRRhN/sS62C9MNfAbbpopgvkKdx519cIrDi8eAJ9h3LSegImsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.30; Wed, 16 Oct
 2024 14:57:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:57:24 +0000
Message-ID: <f54901f7-fdf9-409a-bbd6-6b08db00e125@amd.com>
Date: Wed, 16 Oct 2024 09:57:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Set the initial min_freq to
 lowest_nonlinear_freq
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
 <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0150.namprd11.prod.outlook.com
 (2603:10b6:806:131::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 547ae9eb-50cf-4d0e-8f80-08dcedf2d7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTlBSVFvMGNlcmJnMlhmd0NYUGp0bHFqM04zbHNhRzh3Skx0Vm1HWGhkbmFJ?=
 =?utf-8?B?NDN3OXpNMzkvTTZJeEpkOVpYWU5sQmZ1ZHpYR3E3MnFoOHp4dVFkTFRFQ3RR?=
 =?utf-8?B?WThCL0xSS0QzWGsvc1A2Mmhpdkp5b0lvUEU4N2VmNkNQU2o2dVBaVUZEZzda?=
 =?utf-8?B?RzhuT1pQVjZlaUFSc3VpdE5FMk1oTVJFMVRrYWdCZjJ3STk3N1pwaEhVOGJI?=
 =?utf-8?B?R1hmcmREajZoMmtoNVNycmhPMWRJVFovS1JndGxORTNvS0VFSmlla3NMWDdw?=
 =?utf-8?B?Yytsd21DRkp5Z2VjNWJRS2Jmc0IwaGZTWTdjRS9Rc09CNnlmK2Jmb0dnSDZD?=
 =?utf-8?B?aVdZSDNuTVczZUp0UDQ5aFNQbDAzTkxRc25mMElXNTN6d1NQMTlCRU1ldjQz?=
 =?utf-8?B?aEZOSDNXTkxTb0VCdUlPUUNxYUtJYktycHZEYkNJU1ptTnZ6QkwyWmZDRjdp?=
 =?utf-8?B?eUk3cmQvUGdRTHl1bkp6UUtJaE1Odll0ZjNHbnJoUEZLYmltaytQVHZkVlFD?=
 =?utf-8?B?WksyU1RnS0dhZmF5NG5WUUZleVhaSUl4blRRMHdvZ1l3bldpcnVRYlhpWGtm?=
 =?utf-8?B?c2k3YnhEUkVKa2FTazB1MHRWNmhvSkJBMFgrR1lwMWR5MllwUkcxSkpSUHVo?=
 =?utf-8?B?b1pLeHI1YVRyV2Q4cEt1amJlY1Y3SVpsWERJUndETzF0WVdpeUJpZWVWVXNP?=
 =?utf-8?B?YThZdXV0ZHZRSHFCZW9GOWxPRURYWUZ3S3lsWlpUUTgrWmN3SzdBdzI0MFJs?=
 =?utf-8?B?aTVuZHB2eFlnTk11U3M2MU9yV1JQNHUzK3gydk82cXBxV05ES3huTHNqOHhp?=
 =?utf-8?B?QmE4WHo3SlZjNUprbjU0S2g2dUdycGI5ajBVS3V4SFJacnBDMlA3YVFNRVdj?=
 =?utf-8?B?MVdLRm5kOCtNWW1kTC83b3NYK2JxZEEyLytJMHBZZ0FoZDY1MDFvTTJseWhy?=
 =?utf-8?B?eTdkWU01dTVlVGNhMDRYZGZVOUkzYVAzTU9sY2tON0Z5OGRTQ0luZXBUNi9h?=
 =?utf-8?B?bGFITU8rMlMvWTExQ08vRk5BWkgxbFpNZ0VrU0Y2alRtSHU4S0daeGFLYmp2?=
 =?utf-8?B?cTBCWmk4L2ZITzhEajBxWitTaHN2QmFCUFJHVmRYc0JuVjJGQk11WFVwcGl0?=
 =?utf-8?B?QURLUGxkZ1c1Z3YyY0ZBdlFIUGtrNVNGNUZwLzV2SFk2RVZOa0hRQWdWRE9t?=
 =?utf-8?B?c3RpUUQ0RWNRcEp1Z09oeXR5NUpPdWVzYzNVVmpteDhvSkIxaW14N3VJdmR3?=
 =?utf-8?B?RTZURDExTTFPa1Z3Q1p6dEF0TDcyeU1vdXVvY2ljOWlNN3l6ZXV4Y01xcVAr?=
 =?utf-8?B?ZE1rak02VG5BL3lDSjFVUGg1MWlQYXlzNmFoa0VNNmI1dWtJSGJiWTlWVjYz?=
 =?utf-8?B?RjBHcXJIZUQ2NXJQb1UxVmttOE5iYkFld0llVkN5dHlTMXdXcE4wU2w1M0c0?=
 =?utf-8?B?YVprMEZhaG4wb3lyRXdMVVltUWNlRFdFMXhqMTZ0YzhqYWhNMUNrRmRKeEFO?=
 =?utf-8?B?Qm1vNzluU01yRGJjVTJ6c0tpMDFpQ3RacnJyS01FVEtkL1RLOUpiNmdVa0tr?=
 =?utf-8?B?akc0ZzZjdFdMM2ZXcFdaZ0RETnpxcW5iaFpUMlZXZkloUys4alRxOE14L2w2?=
 =?utf-8?B?SFhRMmNQV0ppRWZpSGRKZ0ZxVGNLcXZXYUFqb1VmVVdwem1BVWlmWGNxVUw0?=
 =?utf-8?B?UER3ekVYbFVRb0RDUlpPcE12b3VsRHdEbHFORm5LZjBNMm5ldVp4UGd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1F0QlBiaE5HMDZ3UFJnK2dDRjNMSklpT1BaV2ZSeEpacS9tUllMTWxNUUZV?=
 =?utf-8?B?a1NUZmJ1a091eEFWUngrdEM5M2oyaGdiRFF2ZFRPT3JDODg5Q3VPTTR0TWFY?=
 =?utf-8?B?SU04b3dXcnBVQVA4SGRueDJWLzV4cWI5UkJMMjRLSU9uNzdqTlF4TTJBT3dQ?=
 =?utf-8?B?YXdiYmtqT3VNdVhKd1Z4eEc3WGRERzI1RmZ5M1hWN1dVZkcwM0lIUnRRZjMw?=
 =?utf-8?B?NThlRHRUZ2hXdGVsdVpTaU43NmR2cDRhSFZSNjE3VHZ3R2pQNFZjY25kVlZG?=
 =?utf-8?B?Szkzc0VEbTcxOE1zU015Z1c4THVaZlliV3ROVUt3WDllaFJnbWlUZ0Uzeitz?=
 =?utf-8?B?SzZESTk4UzFxYmVRTWZYN2szL0I4OE9RRFRuRUZxbkV5UUgyWUJMTEg0RThr?=
 =?utf-8?B?UHBFc2ZzTDRpQ2RwajQ4QjFXVkV5Z2tHQ1FJZ09aeTlCa2ZGMEx4b2x5NkJw?=
 =?utf-8?B?a0M5RnIvMXBwLzZVaXQzQjR3aHhoRmZWRWtvS3RkQ3B1SHk3amtWdTkyQVNG?=
 =?utf-8?B?aC9rcXlMS0QyM0xHamgrdUpjRURZNkcrT00rN0ZhOUVFQnVIS1BCVnh1NWkx?=
 =?utf-8?B?c2NmNDdHbTdHdjJGeVRxcHVEdm5RMW0zZ3laM0FBd0x0bXhMYWN3OG13bVp0?=
 =?utf-8?B?QjJuZlRudTZuRE9nc2toOEhldjRGVGxaVkY3eFVVYTZrK0NKZnZ3RnJVaTN4?=
 =?utf-8?B?Wk5TVDRheWxjZXg4bFV4MDNSc0JKb0tZSHlma1FNSFlJbmtWaEZuYUdiZW12?=
 =?utf-8?B?eFdUTWNqNXJ2WEpNaEFmbXVxTFJHTVdEUzBPZ3dFQzNCZGc1S0tjVEtkRmVG?=
 =?utf-8?B?K1dzZGJ3Z2hCY3FOblM2R3RBVWJuZ3NMaWpxU0pPbDAvOWtjeUs5N3dsY0R2?=
 =?utf-8?B?RU1YSjR6UmJBaEFjbHhhVGJjSXJ1cW1HSzRrdlNyTWZha3JTRmJRcjdFd25V?=
 =?utf-8?B?ck14MWEwems4RXU0c2pNOUlocS9HQ2w5dUNaQit5UDIwQjI5R2o5QXdNbTFa?=
 =?utf-8?B?ZExNZGp1YzQxclNRK3JRNWYwSVFBR0hUT2Y0d2xSeG5vcVZxREFiQWFmbnU4?=
 =?utf-8?B?SktNV3V1OFMycXdJMFlza2pCUXNXdUxOZE9BdGhLSDdDTUU2SklibjcvMnRR?=
 =?utf-8?B?V241ZFlHQTlXZ2EvaDM5Y0k0TDEzemVGR0t3QVIyZWR0Rk11dmxkYklUNEtn?=
 =?utf-8?B?MDVraFI1MG9TdUN4RDNZclhiNWxUWkZRSFExb0VObmVmMm0yVUdhYU4wZ0RF?=
 =?utf-8?B?Q0pYVm1LOXN2bFlGQ1lVdDdkMjR1THBLWGEzTjlKYmxRSUpHZ2t0dGFpU3p0?=
 =?utf-8?B?WXBjaURvZStuQlhUdzVNK0N1dGxiL2F4dTIvVFVwYjdveGszcGdMNjNxcHJC?=
 =?utf-8?B?THdYV002RG5Fd2FVSURuUnYvVHVTL2lOWDRIUEYvd3dUMDBrekh4eU1BVVlv?=
 =?utf-8?B?U0JlanNKK2lvUUlEM010TldOczFsVS9CVlM1OWxuRGJFR0Yrck03aDdFN2pj?=
 =?utf-8?B?Y1BiWFdzaWY5VFQ2WGdZOXowVnZGV2h6S251MTVhRXdMNHJhenJqUkJTUVFD?=
 =?utf-8?B?RHR3NXMwVjRVTFpWY0VvSmpxNjluOTJuYmJCYWpzNk9FMGpqN2xhZDFFTDh0?=
 =?utf-8?B?c2NabnpXUHNlZ2Z6d2toclgyNGZHa3EveE01QldqQnU3S0VmbjlqK3RObjdu?=
 =?utf-8?B?NmNnYVpsWGtHcmVVUVNMZkMrcFppaGNJTXIrQUlJVDE5K0h3RXlyaGc0NCs1?=
 =?utf-8?B?Vm5YbmJXTmNXSzNwYlhxQlV6RndkbGFEaENYY2lVKzcrcXgwNWZrZnlmVzgv?=
 =?utf-8?B?MWE3V1MreTZMeWYxclNHVHdXRTNNTko5Zlgwd1NXK1BEWWdrdXp0cENYQkhu?=
 =?utf-8?B?Ni9IcHZZYllvdnJONTVtS0E2blVtMURxaGROMDk1SjU2bDJZdnpiMjV3bmZ4?=
 =?utf-8?B?ZXlLb2hxbEdxbU1uQ0F6QVBGdlkyS01lWlp2RExtZTkrT09WMGFVUVJGa004?=
 =?utf-8?B?ZnRISEtuVkVRWDNDVnVnS2hCREt5Q2xlSHlqbS9CTDdLckU0ckQxdGRaREVo?=
 =?utf-8?B?a3NnUnA0U3FVRkVMQmY2eDJCYzRycUNHbFJ4QmY5WEYzNkFhSWxYZUpVWlVq?=
 =?utf-8?Q?jUExdd/nf26hiiK2n3oPnDsFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547ae9eb-50cf-4d0e-8f80-08dcedf2d7dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:57:24.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 834cCbmEh2+31VjbnYcXE244RG+xLdQEzNEeVjoDahTQlPVEcqu0H1xSGO6Jfz+1mcTboJCc+bvvcTlSNylQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332

On 10/16/2024 09:46, Dhananjay Ugwekar wrote:
> According to the AMD architectural programmer's manual volume 2 [1], in
> section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
> as "Reports the most energy efficient performance level (in terms of
> performance per watt). Above this threshold, lower performance levels
> generally result in increased energy efficiency. Reducing performance
> below this threshold does not result in total energy savings for a given
> computation, although it reduces instantaneous power consumption". So
> lowest_nonlinear_perf is the most power efficient performance level, and
> going below that would lead to a worse performance/watt.
> 
> Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
> lowest_freq) allows the CPU to idle at a higher frequency which leads
> to more time being spent in a deeper idle state (as trivial idle tasks
> are completed sooner). This has shown a power benefit in some systems,
> in other systems, power consumption has increased but so has the
> throughput/watt.
> 
> Modify the initial policy_data->min passed by cpufreq core to
> lowest_nonlinear_freq, in the ->verify() callback. Also set the
> qos_request cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0),
> so that it also gets overridden by the check in verify function.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fa16d72d6058..117ad5988e8e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -529,8 +529,20 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>   
>   static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   {
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;

This /could/ be a NULL pointer de-reference.  It should have been 
initialized after the "if (!policy)" check.

It's a one line change though to initialize at the right place so I'll 
do some testing on the series though with that manually fixed up and if 
there are no other problems I'll take it.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> +
> +	if (!policy)
> +		return -EINVAL;
> +
> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE)
> +		policy_data->min = cpudata->lowest_nonlinear_freq;
> +
>   	cpufreq_verify_within_cpu_limits(policy_data);
>   	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
> +
> +	cpufreq_cpu_put(policy);
> +
>   	return 0;
>   }
>   
> @@ -996,7 +1008,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   		policy->fast_switch_possible = true;
>   
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> -				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> +				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
>   		goto free_cpudata1;


