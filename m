Return-Path: <linux-pm+bounces-14370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A10797B082
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F51C2181B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132917ADFF;
	Tue, 17 Sep 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2NOILDRF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091C16B38B;
	Tue, 17 Sep 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578122; cv=fail; b=VK/DB9fa+Ia8w5grJMvTazR8ObUclxYpJfRXJiJyXEJVo7MWsXj7B2Ct3HAblgXDFLc3MkUUCeBsUaNpRus83JJojepYgC785GeNgBc1svwl1qNLVhsj5Dm2bGSxx+esp1QIprHKhJsuJqhTvUmjR0+NJRBkLzlHfMwaCMluZXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578122; c=relaxed/simple;
	bh=tYYCU8bvPKsDpdp25tnXcq+mPpkndhbggV7XVAzvPgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mz80AR/OSybVPgdN3fSYzGXZfvU/0Lql6VCAgQsfNnaXzv9ine7R6uUYz40MX0cgDMpwzWCZAUOe5inhcWEHgxdH50uomsDj5LqTKSryqM8sc/6AEwPaDr1W0FCAaTwD0n+OH/zsq1LEblc3i0JM2H5onkVjc6nA47IZQDDkwH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2NOILDRF; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBkkcf8BOwe6HJuCPOezIzmEPV4SPiwJGxDDxD30LHp7m1haZZvPiXCkkrROUxz3Y11sb+DwurRfTMOXrFt8hTDg+UGEfGDqP+GjZRF29ITIuF2wZZLc1LhUEesybvxmlr1zk++4KMvDJf2UsmDX8KNQ1pIg9YVzfroSRG+I7omXTIhG4ud4ResDMGOaYVjR4n0JKcu75KeuIDYrJ4zuY6x0ux0+IoYKQRC3+u0FS//IMsBETz2WouY6m40kkXlvyeW/boYgyw/qapsHwAN+LL8lKNLf0v/JmxY5rSL7PcvFNCObXpne3rTzRjThidEbW1ZjbrwE+pk3nT9vRQCBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSAYQenjWUuEcRUGgyxan94bJxZSPIUGUx9TEqqsLPI=;
 b=i8hLteiy0RiU5jifggTGV90nirGM3xkx9va3K4+rOA5jv7cC2lw5NuagNgFmbH3YK5X4OaQKk3FkxuwaUCf03RqdDL5SPOA9AgxtHlSAzvkBKVbKWZHOjK6lvEZ6csLqMMSHs4sdztUw02YeoPx3d41XrDRbCNBt13xK/2eaKWy3ilrGO+7Nd1PhmTLQkE7E6eRfISrh780LqucpDoFQyeRmVtHVpYbTppTdqzF5Y07G6M+vJl5+iHcC09S3sz1Lm69GOzcXsIkNNJmp/TQr5/4SUvfJJmEeRCSySw4xmyhgTFeEFetSiteboK+cL0x2JxZiazaX588heZ2YCBfkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSAYQenjWUuEcRUGgyxan94bJxZSPIUGUx9TEqqsLPI=;
 b=2NOILDRFw9LD5tbHWyOlSsvRBj8nNP5P0FIKezon/E5xTxYOJXiapWd78YYGqMaeUHNtwjTznMGo4ySip/lFCr/wVIXXOyVFMI/lX4AqjgYAkHsUX8ws+PiKjIa/ANHYNxRAtrUMnl211yEw9//GfYx0+A+MtgImocMaFHWi3e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 13:01:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 13:01:58 +0000
Message-ID: <3bb85852-0647-407e-a77e-0d3a8b47b488@amd.com>
Date: Tue, 17 Sep 2024 08:01:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: cpufreq/amd-pstate: Rename MSR and shared memory specific
 functions
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@amd.com, perry.yuan@amd.com, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
References: <20240917091434.10685-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240917091434.10685-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: c36ce8cb-0ec1-4945-bd24-08dcd718e9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWxWTzd2OEsyOWg5WlNEZzd0UHpmVGhveXp2VHR2N240ejB1dVFzWkRzU0xi?=
 =?utf-8?B?ekdZS2JPT1hFazQwY2x4ZzdyT0RvMjRQUkF4QW4vY2xJZUFBKzZXNGdrME9X?=
 =?utf-8?B?V3F5YWsrTTZ6RFdteU5rNTVEUUtPNTBsRS9JTHdSZVA0L2VxWUgzc3g0VklL?=
 =?utf-8?B?RVVVT1JMeHIrcmwvYjBXbVR6anE2UHJQM0xaMHBPWXdsb3BIRnhWc3cxSDVO?=
 =?utf-8?B?TEFDZ3RlNzBlNUZ3U05FYnJrR1o1U2syb0doblYwRXUxdlMwZi8vaW13a01L?=
 =?utf-8?B?MDd6NmdIM3dDY09CSlFlbG9qN3FEOXdvWXE5MHRXdk8yT2FxUFpqdmdrNWFm?=
 =?utf-8?B?MnAxV05kVjNpTGJXakcwclA4VTNieCtkSDVYRjlHNno3QlJZamM4cW14Y2Z4?=
 =?utf-8?B?MEYwWHRlaElGV3ZUL25XQkpLQU5jMW51YmREL0ZVNk9MR093RDA4U21JL2Vr?=
 =?utf-8?B?TEdXQzM4aDRhVXArVE44dHRqSmRvRjF6NDZmT3ZLUnFXM3g1eC9COVdvU2V2?=
 =?utf-8?B?QTZlNUJLV2VMbjkwTkUzbWU3S1ptT2thMWtGU0hnYkpKUVJzN0xVaVBtRUF6?=
 =?utf-8?B?TnMyUkk0RGxVTUR4SWozYTB6TXU1anppb3Y3M3hEWUFxSWp6R0ZYRElrY1d2?=
 =?utf-8?B?WDh3MVZjK3ZkSlloR3RHVXIyYWRHU2lsWjI1MUFTWHAvZ3MwYmdIWUxMcGdy?=
 =?utf-8?B?NlVqc0pRRUZrRWhmbno1MWVycFQzQ0Y1RGxpdjVaajU0M3Q0Q1BUamVNdGMy?=
 =?utf-8?B?UFREOHVFT1IzNjhmOGEzWDVsNnNYVVJXTDhKUFJjTlIyV3ArLzl3OGs2ZE5w?=
 =?utf-8?B?VmdhQ2ttVVVobWRjbzd5djJtWHVEeSsvcTdoaGVHeDdRcGZrRFhBN05EbzFT?=
 =?utf-8?B?dXRoS1c0RkJySURGYTZNeFFqQ1ZrSjJmcGFmVDc2ZkpOdTF3K3c5cmF1Vys2?=
 =?utf-8?B?aDQ5dmtYekZCbWNyb1NNWjByN01pbStsTWZ4REIxc0RBSE8yWkppUjFzRVdN?=
 =?utf-8?B?VEU1bHMrZnM1blhJQ2IramhWb0pHV3lieW5xU0hackd4WlhqVnFKcmhxekY1?=
 =?utf-8?B?TEV6WkVGVFMwMmQrZGRNNE52TUs5S1NxbXJZbEh3Y2YyRER0aENGb1dFUmxE?=
 =?utf-8?B?QThWWGFXZ2hIVjBEcjZuM2ZTTllCSlpyMklLbStuTW8rd3RHOUErN0dmWWJk?=
 =?utf-8?B?c3dDa3dRdno4dld3T1NTenhCS20xMzBSWnEwd2lSamt5TlBCN04zelNNQlN2?=
 =?utf-8?B?VWVSTkpESGtoajliQjNOV3NvSDMwSFgrM0ZQTzZ4SUdzNUhLYU4yWkVzV2xG?=
 =?utf-8?B?dzlMRkZwZzRoN0tlM044YmZtWGR4TkVOTXFEbllQSHMxb2VPTzBLdkUrZkov?=
 =?utf-8?B?NXpTNFRtZHRGVjllVmZtV1d5QWtvY3hSNkZwU3ZzU3o1cHdRVHZyNXJjSmxC?=
 =?utf-8?B?VDIzWUNVeVJKVVBGWnE5VVc4NHE5NDFHUHZaRXhMVFljZ3BLWVZOVkJwWVRJ?=
 =?utf-8?B?VHhZUXVicWtmWW9HWG5MWDRVWXIwb0U1SE5oREFCcDJEaG1yTTBNZFFnYzkx?=
 =?utf-8?B?Mjk3Wks2MGN3amxlc0xjNHN0UjBEMUpSZ05XK0M3bm1Hakd5RUhWK2VBYm85?=
 =?utf-8?B?bVJkRnZoOHd0ME80WWFXNStIRGdyVkJ3SXpiV0lQdFhQSnh0clRZTkFnR1dT?=
 =?utf-8?B?dkNGdWJZQzNxZDRLcGhvNnJBbFliWlBZUXJSK2JzYXl6NkZrc24rUzg5ZmpE?=
 =?utf-8?B?UVNOSlRqNm4yUjdLbXdrVU1VNkR1cWhHN2RvUXZQeHp5cnNCRTRteVBpdHY5?=
 =?utf-8?Q?bApGzd82i3qDhv9txo7QKRSBjjA8avG0I7Ezg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NjOEM2aVVOUFJTSGRKQW11T2hEV1VraHZPTjdIRktlNmVPQjFyN2dHY3Ar?=
 =?utf-8?B?UVk1NVhXbmlIZkFpUHMrdmhvY3ExVnhWWEVJazJEQ2IzZDdjVWtjUUZIQ1hT?=
 =?utf-8?B?eGR3cGdwUGk0RHU0SVZHVmE4K2Vrd0J3UVdzR2hDKzhqNktKT2x4UXRXa0hv?=
 =?utf-8?B?U0NHa2dyb28waVBSZGVoZnRoY3E0bVBoT3QvZzQrRTZIZ2lQaHJ3dmtrQ2Yw?=
 =?utf-8?B?QVZJWnNvODRDM0xVbHBGWkJDL0ZaMEo4TEd1OXArRnVpdVo5UmE3dlJDaHQw?=
 =?utf-8?B?dVdabFRUVi9rclU1SGg1TWpCMDhMRFZuay9BKzFPK1pwUER6YVBTV3lRNllr?=
 =?utf-8?B?YVdGZ3Uzc0J1bFBCZG1aRllKT1lIMmFVY0NWYUlRZ0NSQjVNVFNWR00zZ3li?=
 =?utf-8?B?UHIzTldIM2JNUGdjcjMwQ1BoSm0zeTZzdVRlbjlFWGxTU1owblRXQnlSc3Vz?=
 =?utf-8?B?OXV3S1BYVUkwSGNuaVJGWGFMVUJvUUxqN0VnM2k0NG9oQ0lxT3pIZ3VHUndU?=
 =?utf-8?B?ditkUXp0d1poM3UrRmtYUG9ZcWJwamxVeEtNUFF5ZVc2ZmpGL1BwbXlNUW5J?=
 =?utf-8?B?TWl1RWI1VnllY1ZVU0piZExuQWsreU45bGROeEhnZnRuc1BnczBqanRnOTZa?=
 =?utf-8?B?dS90QlYxNVRlZXF0ZktUNnNoVWdlOGp1MzJUNFJkQmlnbldJK1o0WncwT3Q4?=
 =?utf-8?B?MUVKU01wTjFuRXE4S3NabzZwM3Q3UVBib2YrSzNLMXFwYlhXc1VKRXpOL2hB?=
 =?utf-8?B?ajJacXM2UWhYZ2JhaDZGU25DcFlOSWVUWnd5emVsUGh5ZCtpOFF5VW4wMXJh?=
 =?utf-8?B?My9RUXRQTld4UzIyL1FkNHplSUVoM1FMSjQrRDF5NGRjajUwZ1ZKWXQ3eEw2?=
 =?utf-8?B?d3RYL3ZOK0JjeCtjSW5mdlh2NHBxODYxQ0xrK2xwTVMwcE1vZWkyYW5vTTFv?=
 =?utf-8?B?VTcxM2lTc0VMMHlVNHR5Q1JWclBFWWM2RDlhMWtVTWI1SjFPMThMQmdvaGJP?=
 =?utf-8?B?WmJyV0xVV1YvTWFBUDkyWTBxN3NCYmdkWGhZeXIyZ3BSTVdOdVJGSGhqZHdw?=
 =?utf-8?B?bW8vWVIxQ1lwTGRQYzZFM3F2dUt6YWFrMmxodWx3SkhpNVVXQmdGZ0VYU0tP?=
 =?utf-8?B?ak8yZHBEOXhvcEF0VVM4d0JwaGlsa0V5NmRlZ3UwVkViWXFPc1k1bDlyOVBa?=
 =?utf-8?B?UEJBcEtEeXVkMkpVOUw2UHQ1L2M0bXJxVUk4NlRXU3lGL25oN1ljQVFJSFcz?=
 =?utf-8?B?V2FBYU10VitGWmQ0VzUwa2JING5VV2kvNk91Wm4xRmJHZlphNFFDaitYd05j?=
 =?utf-8?B?M2lHTGRYRkVRVjFVbWlqTmNXQ2kyT1JKRnNBdVFSbVRpakVmd2RQSmdzTU83?=
 =?utf-8?B?Zy9VWTdvZ1FWMk9nbHdRQVRRMTN1ZVlUajFPNTRQbWFrV0hlaWxvd2Z0RHdq?=
 =?utf-8?B?Q3dYZW9keVlMbGowcFdBeFBIK21WVTcxUGJJMDNIdmI4UkhVWXp1YTkxSlFQ?=
 =?utf-8?B?dmV1cDk1ZUxzc0xEMHVpS3pkNEk0RVF2T2RKc2xNN2ltYWJ6MGdvYXFZVG91?=
 =?utf-8?B?MVVpdkJjSk1ualpPMkpHWDZaZDFGOEtFN0FNY1d2NDNnWEUybWVTc1B5NzA5?=
 =?utf-8?B?WHlwTGFVaSthRGRKZ3BPTVdIN21WVjBhQmpCODVmKy9TQjc3TlJQcTFodXVm?=
 =?utf-8?B?R2VBVmNNcXJaekpQNExKUzQ2aW93Unh4amlNRjBqc0VlMXA3c3ByMGdWVDhj?=
 =?utf-8?B?U1YvT3Ntc2dXV1VRZjdzT040em44WUZFTENaV2FSQnNsMnp6eDJWemdoNGJr?=
 =?utf-8?B?K2IyYUVYWG12aTRsdEtNSndTNVZuS2M1Y0RNV3pTU21WcllibGVQUmtsaVJF?=
 =?utf-8?B?RGVzd2JYL0pmTThSZU1mSHRRL0RCN040Rk1YM3FLelFRYU54MDRreGkrZVMz?=
 =?utf-8?B?dlhreGt5SmZQVjJaNzdKdlhrcWFFeWtsTjBlSHJkcFNxK0NwZ2pidzdnMlpM?=
 =?utf-8?B?REVMMDhoUGZqYzNhQ2U4MnJvakNobEFHV0VZUy92RHF5ZzROK0hkRDBRVEFT?=
 =?utf-8?B?NHd3ZlkzMkhJc0FzQmhNVE4waUNTc0JKKzNoTjBDTlB1L3J6M0FBSFFmamxL?=
 =?utf-8?Q?UpgIzDOH1lU/fJF8dp23CIM+R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36ce8cb-0ec1-4945-bd24-08dcd718e9d0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 13:01:58.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYDycV1t7TnAmtizrvC4aNYnqBqBMbRS5otZdQEGbItLQy7kFX3bbDuIy31057I6W00h099N2/eLQOx8pbjdNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On 9/17/2024 04:14, Dhananjay Ugwekar wrote:
> Existing function names "cppc_*" and "pstate_*" for shared memory and
> MSR based systems are not intuitive enough, replace them with "shmem_*" and
> "msr_*" respectively.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, I've applied this to 
https://git.kernel.org/superm1/h/bleeding-edge for now, and after 
6.12-rc1 tags will move it over to linux-next for targeting 6.13-rc1.

> ---
>   drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 15e201d5e911..b7a17a3ef122 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -233,7 +233,7 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>   	return index;
>   }
>   
> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +static void msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>   			       u32 des_perf, u32 max_perf, bool fast_switch)
>   {
>   	if (fast_switch)
> @@ -243,7 +243,7 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>   			      READ_ONCE(cpudata->cppc_req_cached));
>   }
>   
> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> +DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>   
>   static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>   					  u32 min_perf, u32 des_perf,
> @@ -306,7 +306,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>   	return ret;
>   }
>   
> -static inline int pstate_enable(bool enable)
> +static inline int msr_enable(bool enable)
>   {
>   	int ret, cpu;
>   	unsigned long logical_proc_id_mask = 0;
> @@ -332,7 +332,7 @@ static inline int pstate_enable(bool enable)
>   	return 0;
>   }
>   
> -static int cppc_enable(bool enable)
> +static int shmem_enable(bool enable)
>   {
>   	int cpu, ret = 0;
>   	struct cppc_perf_ctrls perf_ctrls;
> @@ -359,14 +359,14 @@ static int cppc_enable(bool enable)
>   	return ret;
>   }
>   
> -DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> +DEFINE_STATIC_CALL(amd_pstate_enable, msr_enable);
>   
>   static inline int amd_pstate_enable(bool enable)
>   {
>   	return static_call(amd_pstate_enable)(enable);
>   }
>   
> -static int pstate_init_perf(struct amd_cpudata *cpudata)
> +static int msr_init_perf(struct amd_cpudata *cpudata)
>   {
>   	u64 cap1;
>   
> @@ -385,7 +385,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   	return 0;
>   }
>   
> -static int cppc_init_perf(struct amd_cpudata *cpudata)
> +static int shmem_init_perf(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
>   
> @@ -420,14 +420,14 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   	return ret;
>   }
>   
> -DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> +DEFINE_STATIC_CALL(amd_pstate_init_perf, msr_init_perf);
>   
>   static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>   {
>   	return static_call(amd_pstate_init_perf)(cpudata);
>   }
>   
> -static void cppc_update_perf(struct amd_cpudata *cpudata,
> +static void shmem_update_perf(struct amd_cpudata *cpudata,
>   			     u32 min_perf, u32 des_perf,
>   			     u32 max_perf, bool fast_switch)
>   {
> @@ -1879,9 +1879,9 @@ static int __init amd_pstate_init(void)
>   			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
> -		static_call_update(amd_pstate_enable, cppc_enable);
> -		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> -		static_call_update(amd_pstate_update_perf, cppc_update_perf);
> +		static_call_update(amd_pstate_enable, shmem_enable);
> +		static_call_update(amd_pstate_init_perf, shmem_init_perf);
> +		static_call_update(amd_pstate_update_perf, shmem_update_perf);
>   	}
>   
>   	if (amd_pstate_prefcore) {


