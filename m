Return-Path: <linux-pm+bounces-21118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8FEA22A1D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 10:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E421C3A5FFA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35183187FEC;
	Thu, 30 Jan 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vvp5eVGj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EA139B;
	Thu, 30 Jan 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228572; cv=fail; b=lXan496lPJikigTYBnpzjjjVLGOZn8jplACDdy3fSejhrdx34vPSQbbeymYYW1E4Wdu3UnzZSgY9FnX3gBzY2qME4jDEUoZdHPGewMqJA/qgS3HtneiP5keDC+izA0Q2XSXVsQQQgQKfUxnHKTa2f2yE4sF0D/e4e+ilOx/GqLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228572; c=relaxed/simple;
	bh=pIacVaVVfFqHKV513VnePTMOmjr2mCMhCKFGVD4KA1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuR987rxpF0UIbqMig+wqsGYzOqgOFrth1VHudz7wDzPRxJwygL4XpmQxN3SBaMQCVCXAJ3szhGW/hE/8PWsrFHIpmPNT4jhHb9pMIp59FrCBbPEoTFXODqwfDMJ0jY9Qhcv5pJ6Z8zEO44JAJRzec16MPrNciiLDLgZPTeorq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vvp5eVGj; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/NXZ9QgRJwwkPjVONGFqI9ezBrV1nPx7bS+rPrgqe3Apvcu2b/4mLDsaBoBqKfJBIeQ/8JV6DtEtEXAcCqeuVdGXltNGUFO/0EofKG5KZjyGfSHvVB77+nPe6tN4QC1ZuiolPmUi98UH+Xh4lGB2GrscfKR/cDUqM5jKZ5YRE+FHLYj8BQedl2hBf+UNRHPQ5m5EZruOCCJAVxCNBjuKp1irQOLV/bl6nlN9mYmQaBaT1F2Tyn1P+t5PuerqcW/NVK+v2jN3PJp1KSmzR1+EnuSspPcsTk2kprzkkfDJa0rWaAJrZHPMzfIGlaibLs/rL8JMkxiApdiMa+N7+wKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvSVvIKVpI90J5nsSM3bP7zhiII11rGfmxocbgIl3z0=;
 b=d6ElrNpKkYwMcyJljmV+mgxZ+adL8inq/zMUZ9qd9sr+YSK2rZNqi4VPQQuDT3IBeD3/nKBsGFWJcIdo9fv8xBVAYVVaH+c/vsw/xGLWr7ETpp47gMait2CCZxno0c/wOAr2gD6GHRv2sXe8OT4fHfA93hUFpTPUQ5QHdzYcFZzH8TKXvPOzo4CMQtS66C9Y4B7uo8zqfUKS0eD+5PSqUBMQQzhDOD2ZNiI1fM6ZhvoE6y4Ii+ysOeFVYU9y0OFTfB/PXprBoy2aDgSNy1FnPPwWODmCSGPMq/366Udij53ldhZYMNf/rloYXrs+nWWiWG/qmolVngxa7rIwnSA++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvSVvIKVpI90J5nsSM3bP7zhiII11rGfmxocbgIl3z0=;
 b=Vvp5eVGjBtYmyT4Vh6L0d7SF2uEcZ9++WLd3EiLyxjK1DUX5j1vmCKs3bQtV3YeBmyi5QfcgZxh1HRwJBDrkzV8/s9kPWRvNrsq7ACbyeVVeaVbYRlejCfSmPRPsA4Dpq8iV8E01ZESBT8tkrU9AOq0YPootPqCETbkJvW7rMSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 09:16:07 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 09:16:07 +0000
Message-ID: <ebd0ad3c-7f91-4a59-b32a-1de98341ad13@amd.com>
Date: Thu, 30 Jan 2025 14:45:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] cpufreq: amd: Set policy->boost_supported
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
References: <cover.1737707712.git.viresh.kumar@linaro.org>
 <e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: c9241d96-7e47-4ce9-b0ae-08dd410eba41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWlwUzMyQ2ZWeDdVQU5OZUdWbUQwUDFTNWpxM1FJVVY0TVFFOE1odUh0cmFz?=
 =?utf-8?B?UVk1QXdCYXF1M3ovMVMrRXhHRDZWajh1NzB3L2dHOTREd1pjdU1JVVF3aXdK?=
 =?utf-8?B?Mm5DZEpyamc0MjFwaGxCSnBYU3JFUE41VEorVjBRbFVsMFc4Vlo1Y0ZkYk51?=
 =?utf-8?B?V29DQVRqWjZIcTNZek9ndEtZd1k0MXZYcVBFb2pON25Sd1lOQTBVZ2dMVG1h?=
 =?utf-8?B?MmFDSFYrL0xxVHh6bW0rVnBLUlBNTGk0eGFOTUNqQXptOWFZazlubU1vVVpS?=
 =?utf-8?B?TGNXd2s1Mk5IaUhmWjlnSjg0MGVQanNnSFhVZ0FTcm9qOWtFb0Qrci9JVFdP?=
 =?utf-8?B?NXJjSVdoR1hNbE9WUW0rY00rSDkxMG5nSDhPbW5rNEJQUjd0eU1BMk81VTZ4?=
 =?utf-8?B?TjcxODNVWHVYdkR5K3FIcDRxQ1FaWW5YTTd6RWhialFEUE12bVNNNThqZlJM?=
 =?utf-8?B?MjZ6WTFmazgyNzAyYnpWQm1ZUjg2a25OU2dPejFLSlpJQnZ0U1JYNU54VS9w?=
 =?utf-8?B?TUpkMFhFS2sxZDd2L0MyUHkwTm52QzNBK3pvRFBvcUNpdDFmaDRrM1Z2cC9U?=
 =?utf-8?B?MGtidWxiQlRtcGx0eHJCS2xpaEF3RkZUR0twYm52bXFFa24zaFBKelhpa2J3?=
 =?utf-8?B?MGl0WmJvNEFnK1ArRkFWYnNkcmNPWTg5cVBQZGY1UDlqaFhJTm1nRWtnd3Fy?=
 =?utf-8?B?a1FsL0h0ZlppeE5QUlFISlZPR215QTNtTEZ3dHgrMlNJMGlsWEhTNEVxNU9T?=
 =?utf-8?B?U1JScm1yL0NrNjgzSDBWSHV1MHdZREhVWkUxL2xuUis4clptaDVKZnZWczIw?=
 =?utf-8?B?NHpiKzhDTFlFMkVCYVYyWnZBZXZJYlpHOElvUEtxUGx5SmFVK2FBSndhV3Ux?=
 =?utf-8?B?WlR6MGc5bG8xUzZKdVpVZkljSlBHMkZZaW41d1VPYng1UGZNdTAxaTEwSTFH?=
 =?utf-8?B?SlVadUt2R2x2RDRlY0VSOEt4VUFMc2Zjd01yN0RxOHV0NG04dEZIN3JuaEda?=
 =?utf-8?B?MTlRdndWRGc5eFNRdWFaWTJ4SmlYaVdTNmtUZnQzUjZ6N21aN1VlV1AxL3p2?=
 =?utf-8?B?cGYyOHhGblN1a3Y3bzVEN1U4VjRLVm0zK3NzMWdjK3NoRkNjNFEvVXJ0UTdm?=
 =?utf-8?B?VklZNFRPVDJvYUtjZG91cERwb0NSejNUeGVjeWU0b0J6c2NaL2xtdDE3THJD?=
 =?utf-8?B?WXphZ0dJb0UzdjZkRTdPRjZDTkFQdmtMb1BuMXdBNXZTVWNmWTkrUkpRd1J5?=
 =?utf-8?B?SzVvNDB0NlFFNCt6MUxHVURaRUFiWlZMeHVJNEh1cjdVeWhEUFU3dkFMZS9H?=
 =?utf-8?B?TS9jU3JPZ05YbzhySHRwN2xESSs3Tm1hRUFmUDVQNTdQc0tvd3BGbmZueGpw?=
 =?utf-8?B?b0c1cEc0YmlZMWduVkpZWHUrQkVZMFpMQ2NYMEJXUUF3NWVlK3I4Wm1OaHRq?=
 =?utf-8?B?RHFSbG9zdlE1VXpYZi9jVlBwcmRzYXdwTlp0dVlyZDh1cGh6RWU5NnVBaGM4?=
 =?utf-8?B?c1IwVld4VzVPbGRwaTNseUQ1U0dpbjdlZm5jc2YwM3RMUjZuU2dTTXdzeGU1?=
 =?utf-8?B?ekd2VDFIcFI2aFppM2FOa0lZMjQya3ZyUzlQZUV4cjBCWHZNUlVoeHNDb3Fs?=
 =?utf-8?B?MlVwdFdtdGhkQ1FQeXBwenR4WWdIMFhjUi9oTTBJVVovUlArNDJPdWRETEMw?=
 =?utf-8?B?cnRxVlpuTjRybjcyRTBjV3E3cXd0cVJYQ3N0WHpkMytuamJXWm56THRGWEhu?=
 =?utf-8?B?c2ZFcENNNHlrdWdQdEJRbmh3T0dqRjNNaWpBRFlCTldacjhybU13S21xM29M?=
 =?utf-8?B?YnBQU0ZSL09GbnE1ZGQydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjBzQzNERUJ5RDBQckFlVmwzRmQ0SGVpTXIxdGhtS1czcDVQYjB0WjNZUzZM?=
 =?utf-8?B?ZncwQjVUY2tmZ0l0N3l0RXVCZ0pTQ1VuTDBTd3dPd1ovTlZSOFByTjVwYnlK?=
 =?utf-8?B?bnlvYlhqd2sxM3ZRWjN0eUxSUUZwMFRacE0raTE1WmlOQ2RtUnF6dThFLzY3?=
 =?utf-8?B?QkFodGkwVng5eTJJaXp2S3RJZ0VmWDlKSmQvdXF2UTY4Q3hmdDIxdUgyVUhS?=
 =?utf-8?B?QitBdG4wQnVxQTdEWjFUME1QNTFVbXkrM3BRRjRhbG4rbXU3dUR4RmxGL3ZW?=
 =?utf-8?B?a0JUZEJQSGttNVRNdUM2am9mcHhFbGUydlFCWHZpK1BwdCtLTmNGZ2dpQjNW?=
 =?utf-8?B?REo1MlE4ZDVJejVGZEJGU2trRFRUT240WC9jQi9CN2NPM3NwK2diSG5Mb1hm?=
 =?utf-8?B?QzcrcXNYZFB1bE1qNFg2enFsbjRMWGNqMjFUR1RnUzhpMklsMUJEckMweVh5?=
 =?utf-8?B?RFRRUUpmeWZGMVJ6MVhxZmRGVE5PTThidUxqVjBVeTZMdEU2ZVZxdGhzZXh6?=
 =?utf-8?B?OXRWRDBiY1NURFhGVjF0VWdPdHhPRzZzZVdXZ3NCbUQ0Z2poWnNwbzFMdmQv?=
 =?utf-8?B?a1dPOW5tZTlMa2c0Wm5sei9SR2NRSS9TbnNFY01jNnN5Tk10alRTTFpMM0JF?=
 =?utf-8?B?REgwME9qb0J0ZHhGQzBhdGY1U21pNHlqZFRlNTg2a1lseEJUZ2FObnNoaVdR?=
 =?utf-8?B?T3lvSmdxbWR5SkZ2MXF5bC9LZFBOcnhSRFZKMTZJeUJEVzFxRjE0c3pFT0RZ?=
 =?utf-8?B?b0NaRmhqYTdqVUtuOWZZSkhNQTVKUDJaeUEzTzdSYzJ5ZUJoV1lFbVpNTXJt?=
 =?utf-8?B?VzFIVllJeEVBRE1kUm13eS9wL1ZKalpCZHNRRkVOS1hTWG94QXRNcHpEUmFv?=
 =?utf-8?B?bjMzSTJNdXB3WS9NcWM5ZmlESzBsRFF0MHNqR3VFd0VxNDZmZ0FuMjAzN2xa?=
 =?utf-8?B?N2VEandmZVlWbFdVMkFFbWM3RHV1QmNEQlNodTVDRW9tMTJseHl1QzFrUVRL?=
 =?utf-8?B?NFNta0ZaMmVBRE1iZXN4bEpESUFKT2h5WlFRblJ3ZGpHWWdTY3ZKejhvNnd2?=
 =?utf-8?B?SytDWWJrY2FlTUJaaWFVZksvWnBQeGdnYzNkbUwxOVNiTE5SWk44TEtNMm9Y?=
 =?utf-8?B?YW13RTVwcTJSeWduaWR0Uk5UYTlRcUhnOXU4azhZT0NiY2h5T1g4U0NKclg1?=
 =?utf-8?B?U1FJaUV1dXc1MlppTlFKdkg4U25POSttV3ZWVnhCVFBGTjdub05uVUZ5VlJD?=
 =?utf-8?B?KytaTWJQTzNZSjBPSTE0RkpSOXpKWGVMQzNnMll2RmRNZWs4L05tUWd6UFFh?=
 =?utf-8?B?elBERUlaLzVlVUhwdm42MnhhTW9KZjZEY0xtL3l1MlRic21BelZJQWRMcTRl?=
 =?utf-8?B?ZW9oRHJGOE00d0xYaERLQzRRbDhyd2NBbXVaZDlabkpsekNYeW9KaWhXaCtR?=
 =?utf-8?B?TkpyZk4vK0xIOXBibE16bWpOak12cy96MXJqdktQL1FxdVBwQXVHV3dKTkhu?=
 =?utf-8?B?YUs2QVNMbThlczlnNVZ2citZYjJtUWZyZ2tsMHh0d08xcnlsUEpmR3d0ckdX?=
 =?utf-8?B?c2hrVDNOSGY0U1JBWkJ1cUw0R0tKeVN0cm5QVE9GVnFGU0lvUDVFVHI2Qngy?=
 =?utf-8?B?R3FqNUZWNXV4d0hmb3IwczBwbndHN1NjRXdLUTVkWG1Bek1pSC8wTjlFYStN?=
 =?utf-8?B?TUVoMzhzZ1hxelVMamdJMHA3YUpweTdDaVpNL293bmF1OEFmOFQrZWlKUGhT?=
 =?utf-8?B?WitiR1dURVpGU0VDdk15OXhtVTFZbnRBN2Y3OW1MZWNuL0tYRXJFWnJlSjVt?=
 =?utf-8?B?OFVvdW4rbi91cUxRamJHOWpleVlIK0ZFc1lPV2FySkpPK3lweXpUM0x0ZnQ4?=
 =?utf-8?B?b25ENnVOOHNiM0NKb0RDOWFkZUdFKytRcjRSY1phVFNEbUhrOFQrSlhuYm05?=
 =?utf-8?B?Vnh2bnF1VDBxd29QRUpuZzBRZ1gwUGZid1RraWVNQWU3NTRHY1l6ZUxRWUs5?=
 =?utf-8?B?OVNWb251NDZXRmdZcEh4dnBlYTY5K0xFWjYrVVFnejYvalVCSWZBbjVQUzcy?=
 =?utf-8?B?S1ZqODhSeVA1d01FbXBReXRRTW5kNHdoTXNObGJQY3FoR0FxR0lsR2F0ZVly?=
 =?utf-8?Q?niL+pI8es5y2v8V3IdyjTn0Bb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9241d96-7e47-4ce9-b0ae-08dd410eba41
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:16:07.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DqXbemdtbm+WnHbvZDtruh4v4pujdZGSyVduhJM6moJ3B+rZtsU+Bxc3tzN6JqOFBhR2LE3xRsQh0+QwSKZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

Hello Viresh,

On 1/24/2025 2:28 PM, Viresh Kumar wrote:
> With a later commit, the cpufreq core will call the ->set_boost()
> callback only if the policy supports boost frequency. The
> boost_supported flag is set by the cpufreq core if policy->freq_table is
> set and one or more boost frequencies are present.
> 
> For other drivers, the flag must be set explicitly.
> 
> The policy->boost_enabled flag is set by the cpufreq core once the
> policy is initialized, don't set it anymore.

This patch uncovers a bug in the amd_pstate mode switch path (e.g when 
we do "echo passive > /sys/devices/system/cpu/amd_pstate/status"). 
I have posted a fix for it at 
https://lore.kernel.org/all/20250130085251.155146-1-dhananjay.ugwekar@amd.com/T/#u

Can we try to merge this fix before your patch?, so we fix the bug 
before it is uncovered. Currently, the fix is based on top of superm1/bleeding-edge 
(amd-pstate maintainer's dev tree). It wont apply cleanly on your tree i.e. 
vireshk/pm/cpufreq/boost. I can rebase it on your tree and repost, if needed.

Thanks,
Dhananjay

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7630bab2516..8d3cc494c92c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -995,7 +995,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.min_freq = min_freq;
>  	policy->cpuinfo.max_freq = max_freq;
>  
> -	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
>  
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
> @@ -1480,7 +1480,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->min = policy->cpuinfo.min_freq;
>  	policy->max = policy->cpuinfo.max_freq;
>  
> -	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
>  
>  	/*
>  	 * Set the policy to provide a valid fallback value in case


