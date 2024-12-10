Return-Path: <linux-pm+bounces-18884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 280469EA6D4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 04:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A397167F2F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 03:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10601D7E4E;
	Tue, 10 Dec 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="medW845Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994913635E;
	Tue, 10 Dec 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733802849; cv=fail; b=Tn0kxrGh3wNl/K41d09Yp1bfAyit6N3d61Ip5c00Ih+2cjBsjTrK3f8ICdhhg3IHikHMtLvsfrK67jTNfyuxUgWOlJAjrSRDtv+TW86YTXwGuU4h5zrTUnSLmLNlRAlwf85C8OblRWEknpz6JD4Mv55j5fsl+3EK8p80icfUGh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733802849; c=relaxed/simple;
	bh=eCFI2UH4Ei4QM2KkmiN/8syHrW2YaqkDpSsjiWkZTUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g558YujluhrenybY5Ujyi/sZkNK6lmeFxdVJf9368TGYPaJsWo4ApJ7lp04U9jegkjZf/Zl9eU5q2o3fbobjYSB1by+t+UjDrrF+OpusKbNLRaX+x4VsVWMluiUvnesA2LEvH4taISF4LQNhqYoFBXlSLvU1zAVrwx1QX11RniM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=medW845Y; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+SWbyiIUg2wsJS/0o6OHPpDRg2gVrxZQQJH044dM5ZdVGnonjjOtHCIf9jtRQxFieyIbau7Iww7my+PolUkHBrjlfFvOwemwpXysPeZWCYWfw6feO7qtsFOmZz2U7zvPqG6meLxOIhHF0+tBxe759P/d58zEALy3YRiNlbSFEde2Iafgn02ggl/ddKIVPHhDeFud5j32qRv7fMDS5rsCCAAOJ/UWs/BLAeopsidawHVuiFzn3Ak1zS6gEKhSEbdoUFBvnzfWASq3UAWdUfSVM/Cjg6uKoDVqEZaSKuf6UQ4nQA5NB21eWyzRnD3QqJQWrQqiHpkRU1sMoANUx4YEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYh108nlZg3seWkGCpzqJte5pGK7CtoGAzfkP+O4zy8=;
 b=Xw+lGfDaGOX5NiqDFud/DZT0Kye+uPd4WiI01hxwdnBn9N7G0Fpvbx4sNvJTSoRXxiLOeETeFD3qBVlz4v6Lk3XvGML7Jyu+sx4ZV+7Ld057wkIoGCBRI+h7r/q988XFOvRCbVOkiifIfxg7/eQ3tpVlfH9jkghbfI5GSzPmgdUQOkvqt5k38C4zlV9RCLqav5OfBC6kV6n7q7JhRHnhgJmzPUY+v3xuqizt2GGrlGQ3qP4/T19oK6ZDE0wYWvve9o7uFz0yjimNqFxFnf4zn8+tzVQtxE4LzPhUYS6uCqO2Ib9EITIzUVKY572MLhUvvzjcSwgnIam/aMhEJr2koA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYh108nlZg3seWkGCpzqJte5pGK7CtoGAzfkP+O4zy8=;
 b=medW845YcQD6Zmo1cRUT/GZAcrCaYJsJ6uRYrfxdnNbLQqfwFu23NnjiKS8wIod3SHcfx5AuIpwdtrKozPlfGLqm5AzUFw3/4KssrQ91qxywTsa94/nTBzdCsVXWl6K0pmU2ZiK0KUdve85kxXmiM5bbGau+RSk8WumKfifh9/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 03:54:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 03:54:03 +0000
Message-ID: <9613611b-9417-4d96-912c-019220afc02f@amd.com>
Date: Mon, 9 Dec 2024 21:54:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Detect preferred core support before
 driver registration
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20241210032557.754-1-kprateek.nayak@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241210032557.754-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: f31c7a34-16aa-4a8e-9e7e-08dd18ce4986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTFxZHFybXExaEZHYlVLdjljczY0cHZjSDVNZER1SnM3ckxCSjV5TCtnczd2?=
 =?utf-8?B?YnRFMW5KdlY3cUIvTmVFblF2RXo0OW0vK3dWOEJzSWxTUms3TnM2Nkl6dmdH?=
 =?utf-8?B?QXdhdFhiMXBMMzRmSk1tc054UDNsWnBCZmhWaDMvcWFtTGxQZHZTd3FzZGp6?=
 =?utf-8?B?QWF3V2h1emVZMVBVc3dGQ3RTWEExYWNobitlbFJJcy9jWmFDeENCRXdQWU9r?=
 =?utf-8?B?N1dPVC9XQm9RbzJiUUJzeWRpaGRqVDhDUTVqTW1lcDd3SU5PY3o0eHZla3dZ?=
 =?utf-8?B?bEpVYURsNXZXQyttUytjYTdIUXJoWDZDbU1JK1FWQVB1M0J1QU1CK0pON3g4?=
 =?utf-8?B?NXBSQXo1aUx4Rk8xNDBmWXVrUm02eWR1OHNUQ1djNlJrUERGS2dyaW1jMlBF?=
 =?utf-8?B?L25ZOGZZK2c5MEtUL3BzejhpY3ZaczYvVXFicjloK2JTSXdQTUdaTDVmbkg3?=
 =?utf-8?B?R29BL2RhOE1yTThDT1Q2RVdWanljTDJSVXB0VDhhaXBBUWoreUFleHpSclZC?=
 =?utf-8?B?NVdtamtDcWxtbm15dmpoajhBN3BKQVA0ZjY0ZEE4NXY4Z0tNYVlVOGF0Qm9q?=
 =?utf-8?B?WkIvYUdiRmIyaGdWRUNLS1FRbGRUN29sM1l5VlBEbmhmTVlxWllBTmZCVnNF?=
 =?utf-8?B?T053amJ2eDZjcnFtT0VlZS8xOU1RUFFTLys2dElYN3d4bDRGQmcwOTMySWJI?=
 =?utf-8?B?Z2g3ZUtkUHlaQ3lreUM0SXBOOEtjczJSejkyaG9sbGRFUm8wRnJWQWtBQ1Uw?=
 =?utf-8?B?WmJjQ2VMZ0h5YjJVTEdveTgvQnZORnhBSFZwenprUFJQNFFDcHZZM090SExW?=
 =?utf-8?B?VHRXdnVBMElucWpxanhCWFRtbFVwNHd5TlhkeGd1emMyeWhITGI3RGVsOThR?=
 =?utf-8?B?VkVvMmd5K0tEOU5IbnVjK0ptOXcxeDNRM2VJZnZLRStCWHBhQ0FlaGpEbjNK?=
 =?utf-8?B?ODJtTUkvWlpIQTNLZHJuV05CYW9ZTUUydzNIM3dOaFRoUzFhTFowQ2llWXBz?=
 =?utf-8?B?MTVkSHF3MktWb2VCTUNJOFgzM0Vld1NwUGkwZjRBUlNCRTloU0U2SGFpNk9V?=
 =?utf-8?B?cFptblVhRHd3dDVVVHJPOTZ1VHlvWER3MmVEdUlrNk9WZUtDS0hqazdpVElv?=
 =?utf-8?B?c2F0NzllU0JaVnNWcHgvcmgzQ1JXUkZhOGJUYkUvWFd5SHM4VEFva3haMytz?=
 =?utf-8?B?ZlR4SkpJb2pOSDArTytpK1Nlb1lGQ0NaRmJudld6WExPU1daM2R6dDB1L3ZP?=
 =?utf-8?B?QndBZk5rRDRHRWQ5TEowTWxScmRxNG1kd3lnN1dCcWNLMGR1Z2E3Rk5xQnFq?=
 =?utf-8?B?L0lJbFNzbkszTVBMSXFTZ2o0OHFYSzhtMk1DWElKNURXbitJcm1LTDhmdm9w?=
 =?utf-8?B?THhoSFlPRXc0dExKOTRCVXJ1bVZQZGRLdk9vTFlnejBvM1ZZbXRwN2J6a2FC?=
 =?utf-8?B?ZHVTNkRCVFV0eVMzSWU2eklEMnNOYUNSVHlKOE1DMlkrRGtuczZFdndhWEJV?=
 =?utf-8?B?U1VRSWd1Q0E0cEpNRys2cDNUdVRjSElqRTdrL0JWdXBYakpVY3RCTXN1ay9G?=
 =?utf-8?B?RVRHSjJZMmtGbU9ZSk44NHRJSldOS0RvSjBPM0puY013Y2NXRFgxMjR5YmRC?=
 =?utf-8?B?cFBOa3VObW14S0VSR2ZkZEkwZEwyRkluWHBtTEc3VFAwWmNvRjV0UzFOVWtH?=
 =?utf-8?B?S3V4OVFYU1FmNTkwc3FkejA0WktMWmNsaDdzL1BreENpNHozaU9kcStRcVBJ?=
 =?utf-8?B?amRiUWFBM0dMaWUvMEsrS3Z4UStZNk9COFl4eGxqNTN6M0FmL2hLK3pIM2M4?=
 =?utf-8?B?V2lxU2xKUk9EQ0U5a2ZhUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFoS2k2b2Rpc0w1OUU4UVJtY0NpbHdJbVJBRGs4aXpBcXl1LzZ4S2hKUmNi?=
 =?utf-8?B?UEdRdHVDZzN0NlFGK1JnQ0JDQlZRejBXT0QrdXFZZW8yQ3BBWXVFMHdyVDFw?=
 =?utf-8?B?ekcweFN5WFNKL0NCVkZHWGlvVzFpWDI3Ym5zRUt4U2EyaE0wKzRXM1NIeUVY?=
 =?utf-8?B?SU5CeWlXNmRlenUrVGxxWWVtb2l1alVaQjVzZWdZM2k2bUxtRWY1TlU3OEw4?=
 =?utf-8?B?N3F2Mkt0NE1mekNhSkIzYXJpdUlpWmZxMW5WNG1qUVU2TDZ2Vyt5NDBVVDh4?=
 =?utf-8?B?K08vNTU3Z05zQ0k2M1cxLy96dy9McERudWx2eXlFRHpodkQ0aC82N1dWdmVz?=
 =?utf-8?B?N2pCQTNkSVYzeW1vWHgyZTZ1Z3BldjVYOHEyTStoQUZVVjhXb2FpN1pmeUdG?=
 =?utf-8?B?RzdiYjVPS3E5V3J3aFhBaTJxNkk5Z0w1U25ncEFnY3JjUTRZSnZqVlorWVV2?=
 =?utf-8?B?eHhkNTRLZ2YzWGZWNnhOUWc2Q3RScHBVVXB2Y0VFQjFZQVJBS3JnQU4wMXpV?=
 =?utf-8?B?Uk92M1pwTVpVTmQwMmJlMU1mT3gva05YVDRjQWtRaUlPSzI0TUh4Vi9XTXFj?=
 =?utf-8?B?aDBrYWs1Rm1rSXVVOEtrZmFITjl2TGs1SjNTODg4empmT0ovekZoZklpZkhq?=
 =?utf-8?B?UkMrVTJIUDBNdVFSTktBY3F2OTArY0Joc0ZRc0lOa2NiUCtoeDlOWUt1K3RT?=
 =?utf-8?B?MjRIaVFLcmY1ckNzTkxRL0ZhbWFUNVM3cVRma2tTNGhBK2NvUnV0N1BjN29P?=
 =?utf-8?B?Y2ovZ3hQRHJMdFVBT2ozZ0s5blJXZ0xyVWlDczcyZ0NMVkJXa3BITEJDczRj?=
 =?utf-8?B?VXI3RHVwbVNyZ0gwNEpmU1MwYlRZTGx3N2crZHJNTTNRQ1hXc2w3MG4xUzVh?=
 =?utf-8?B?blJEcytLMW9vaGRDVnQ5RUlWbGFzWW9BaW0yL0xhbnVMSU1oVUUyL2VMdkVo?=
 =?utf-8?B?YnQzVTBKeUgyZ0FBYlhLVHN5NHpRQ2NEcm4vVjRxUlNqdDhoSFJiYllLQ0hk?=
 =?utf-8?B?U09hTDE3TUdRNGpBZ1RRalNzamNWTGRLb2JFelVEVXBPV2M2MkVtV0dxejIr?=
 =?utf-8?B?VC9zSGZ4OW5ENHhMZGxUN1A1UFB4U09aaFlITDdlVXhDWG92czIrWmVwSVVF?=
 =?utf-8?B?WWdkVTdMZnRXN3haV3hvMm56TWJjNkJJajJEcHdsQTBGT0luTEhXQ3FmL0I5?=
 =?utf-8?B?M2U5aDJFdUtpcURRVnMyYzdxWU1zK0VFOE5hdkMxeVFzWmk0U1VzSmE1aDZn?=
 =?utf-8?B?NGZpQ1B5clJ6TlpGTGF2WTE0Z1JQR2VXMG9pMDltc1YwNk5ITmMxMnlUVVVO?=
 =?utf-8?B?clpDOVVpNVgzTXlJcVV5cEkzWXZ0VE5HeCtMVno4UndIamNDOXZBYk1SZEhG?=
 =?utf-8?B?b3lvdzBjckNNREp4U2wweFFscGtTeENrbitaT2YrbzFOUDhpcUtHR3Rxa1or?=
 =?utf-8?B?YjNKSTBDK2hwTlJhY3VIREdHMUduTnpYOEVlWVlWa04rWlMrK3BLaHFYcWJN?=
 =?utf-8?B?ZWN6WDhqVGYxTHRJa2xzbnZGV3RRVW9NZjZiNGoyTkhNdXZmVm52WnBvUm90?=
 =?utf-8?B?ZmVzYUFxUlUrVWJFeWZFcEdCVlZNcUJHYWNXeXMrZWNZM25wV09vUmN5ZkFT?=
 =?utf-8?B?d3kybEU3SWJFM2xCeTNheVUyN0VZdmp6SG1kVnlUZDJEaE5TaGF3TDcxZkVt?=
 =?utf-8?B?Uk1wQ0VPamg2bDF1aUt2dnRsT2s4YUQvakhLM3hteDBqN2VjZkE4M0tINFBv?=
 =?utf-8?B?SnpZUGVNME1aZmtxMUQ2Mnlac0l2WDV1cmtRQVBjYVp3Qk13MUE5akx4WTJR?=
 =?utf-8?B?NSthVmRaeVRXNytrMGp3OWJ6UDB6Rzl1Z0w2d0RVNGFvZ2YrV3hiTnJGQjI1?=
 =?utf-8?B?ZWVxNDhqZjhEL2o1cVNObjRnSXdCWXdoY0ZyWnZPVVd0a2xHTk9lTHpmQ2NN?=
 =?utf-8?B?RVg2cHQwRUh4bEdPNExDNDc0eG53YVJrUmo4czY1anNqRExKby9GRnJpQ2Jt?=
 =?utf-8?B?NmNlNmRKSmU2d2VQamR4UDRhU0dwUGdzVFA1ZUsxcG13Sk1PckYwN1E4NEtF?=
 =?utf-8?B?cmNhdjZSVExFeXJ5dlcxUVc5a2NxVkhmaUwveHIzQ3hETEZQZ1dJYUNuYmd0?=
 =?utf-8?Q?vK8P0c2Uptno55dSWWHw6/4AT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c7a34-16aa-4a8e-9e7e-08dd18ce4986
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:54:03.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgoOmPQipgoqgdJ3EBazh9d5ff/TJ3/XS5TmJemv9m+N177a2s5hmpNsdIRFNEv1yrT7VwohS7Y1C+asxkY6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

On 12/9/2024 21:25, K Prateek Nayak wrote:
> Booting with amd-pstate on 3rd Generation EPYC system incorrectly
> enabled ITMT support despite the system not supporting Preferred Core
> ranking. amd_pstate_init_prefcore() called during amd_pstate*_cpu_init()
> requires "amd_pstate_prefcore" to be set correctly however the preferred
> core support is detected only after driver registration which is too
> late.
> 
> Swap the function calls around to detect preferred core support before
> registring the driver via amd_pstate_register_driver(). This ensures
> amd_pstate*_cpu_init() sees the correct value of "amd_pstate_prefcore"
> considering the platform support.
> 
> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
> Fixes: ff2653ded4d9 ("cpufreq/amd-pstate: Move registration after static function call update")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks for the fix.  I'll apply this to my fixes branch, do some further 
testing and will include this in a future 6.13-fixes PR.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> This patch is based on the latest superm1/linux:bleeding-edge and was
> also tested on v6.13-rc2 upstream release. Following is the behavior on
> a 3rd Generation EPYC system with and without this fix:
> 
> o v6.13-rc2
> 
>      # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>      amd-pstate
> 
>      # cat /proc/sys/kernel/sched_itmt_enabled
>      1
> 
>      # echo Y > /sys/kernel/debug/sched/verbose
>      # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
>      ...
> 
> o v6.13-rc2 + this patch
> 
>      # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>      amd-pstate
> 
>      # cat /proc/sys/kernel/sched_itmt_enabled
>      cat: /proc/sys/kernel/sched_itmt_enabled: No such file or directory
> 
>      root@yamuna:/home/amd# echo Y > /sys/kernel/debug/sched/verbose
>      root@yamuna:/home/amd# cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
>      ...
> 
> System was booted with "amd_pstate=passive" cmdline.
> ---
>   drivers/cpufreq/amd-pstate.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66fb7aee95d2..cb03f7d6575c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1862,18 +1862,18 @@ static int __init amd_pstate_init(void)
>   		static_call_update(amd_pstate_set_epp, shmem_set_epp);
>   	}
>   
> -	ret = amd_pstate_register_driver(cppc_state);
> -	if (ret) {
> -		pr_err("failed to register with return %d\n", ret);
> -		return ret;
> -	}
> -
>   	if (amd_pstate_prefcore) {
>   		ret = amd_detect_prefcore(&amd_pstate_prefcore);
>   		if (ret)
>   			return ret;
>   	}
>   
> +	ret = amd_pstate_register_driver(cppc_state);
> +	if (ret) {
> +		pr_err("failed to register with return %d\n", ret);
> +		return ret;
> +	}
> +
>   	dev_root = bus_get_dev_root(&cpu_subsys);
>   	if (dev_root) {
>   		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
> 
> base-commit: 1f2f221668b210107f1277901bb757f1d77de842


