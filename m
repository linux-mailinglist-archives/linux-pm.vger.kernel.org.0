Return-Path: <linux-pm+bounces-9507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4090DC57
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94D2B210E5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89F16631E;
	Tue, 18 Jun 2024 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nI7QHIEx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99C1662F1;
	Tue, 18 Jun 2024 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738721; cv=fail; b=hf7m9zENmMXu32LepzH5S++B+SV50u3RHNhc19//UdFIBrE7t8RyJvQ/Ff3sXu3+Hi9V+UdC/G4hlKU8zkmktrohyd+6yxvmY+NUqCeXaheNc4DGzpRe70NFrLkV0bA1D0rL7SbLuJPqR20ezndyQAueRk0to8crwRKYxXaregE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738721; c=relaxed/simple;
	bh=23aeKTx9IC5lrx4grMNPYox8xPdhovHvwWpQdj5vmQ4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LE0NRQq9NNBl/KpjQB5r4va3Xw3YVZ015hIfEz1YPXUz4U31iVo0syp7wkvy5ybGnIjN1tcUi74sZOjtC/pUsPx4cupeLMb17pwAKkSNZorJ8FC2W9YnqJfRm4fbdm13OjDL8mG6iuku/1uRhocqc8fKEKlwacyGIkKK4yVfZZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nI7QHIEx; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxXZBWqX4k1ukku+7NX2pTIJQxViR/xPeEjvixQZFMUFBVfOykY0Y0egw8dFgJHJmBkM5ISRDz8slVOsqz5cCFp43iPlWDRxvmBdTE5aiQsc6gDiKIaHPn2y/q2BHQwthS7mDtA6bcbMGN88mUgeH0CKBe54M7f37zASJwGLVuza7uvthHDlipzCFuIAHBASiCoD/KrzrQlFzqL36b1eu+E+Fq/DBtalKmHy3xZRByMxFC7YGbAUAbBX6vK3AYc+eyYDgyd7zVgIJWfXeaMcoh7VLO1xgxazPTFoRmFaL9FRxZvZbmz/VmL1TfYBqDWim+rBKO+O+3mlNJ4TFg7HjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp3cdEXE4Y/SPk2U54zwq3muxhFb+HemxS2C8JBV5V8=;
 b=iVdIs2tAvNSivlOrF+NXtjwyP/Opp/eNi21Hcj3PTaX57OLxNVXNGHeU+j6pY/1z/dFTd2j66aINbzrIUbozbrecADd6onOkI3aWgCi5yjH0go5ZxdaDhexJbp0jmaJJmp3/y+aiXLeUQv8iMPAWJV8G7kEIVbGO8LcuUbJ6SgqmOdzgjgbjIoMEBfMmY1SyHg/fx74kHmUV0q1mC1e58gWwerSrKwiFrxOvBCwEJjwHVVuTm2365rogPrEJf2J+9iIfbQ5SnHsrRDRSutU+eLSzV5FdxZw5jRoS1o7t52kR6v0ccAH0BDi3H5X73WLrper9m2/SWhCUqnROnLeovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp3cdEXE4Y/SPk2U54zwq3muxhFb+HemxS2C8JBV5V8=;
 b=nI7QHIExSdLAoKU7w6YJKS/dLteQdUxlYUgNXwqk9Vj+3XOLd3n4GqiGycZqtl9/yRrZWG+/ziDJeZLZLmii4FIG1iHOMiVBnUUSRaaEZhplrzS/R3pPWNa3+oIAoNjjrQR4DPfHmJbe7d8G/mrl5FJPPROdtT4SrqV5uGJAvvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 19:25:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:25:17 +0000
Message-ID: <4e84249b-2fa1-4d47-aa08-e8c429003714@amd.com>
Date: Tue, 18 Jun 2024 14:25:16 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 11/11] cpufreq: amd-pstate: enable shared memory type
 CPPC by default
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718606975.git.perry.yuan@amd.com>
 <0700459b88b496963dd5914631eee753bcf0a560.1718606975.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <0700459b88b496963dd5914631eee753bcf0a560.1718606975.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ba7156-e62f-4b34-b8a3-08dc8fcc62c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0hIcXc0SE5nZXdOMUtlTDc1VXlzUkNGZklHbUoyT3BVVDEwMjZUZ2JjMnI1?=
 =?utf-8?B?M0lyTGU5bWRWTXRPQ2xsVUY3dm1uS01ycWo2MEZYVGlLbC9VVFRoUTVyRlY1?=
 =?utf-8?B?Y0c4eHpDSEl2TjMrOTlpV1ZRMkxkWWtMd3Y5Wk1SNWhiTFJWZ2gwMWtqaG1O?=
 =?utf-8?B?V0pPelltaEp0Y2VBVjB5anl4YldhdVhHbDR2T2Z3Q3ByenhrK0F3SFVKbUNG?=
 =?utf-8?B?d254RUo0NTZDRjMxV2xZc3FBR0lEU2JLVTZxaXB0aVdGSld0Y2hBUjlGMHIw?=
 =?utf-8?B?czlEMmRHYUhtdjloMkFJTWdyU2l1QVZTd2RyUVI4VUROUXF2N1krSzRUK3Bs?=
 =?utf-8?B?cXlpT2ZCa0F5Qm1VTzNPVEV6TVBJSWlVaHIvZzdvSFRPSkNwbURqMFpWSk04?=
 =?utf-8?B?bU9mNWp5NHpsU3VWU2NIdEkwN2JkYlhFTWxGNW04L0ptczNvTUZMNUxHcFVv?=
 =?utf-8?B?a3h5ZGRVVTRsUThCRi9tWFpRbDhpYjRQVW1rUXpKRWlYQ2lKZVBlK2JlcmV1?=
 =?utf-8?B?RTRnVUkvcDByazk1NEFlZ0JNSllaZFJ0ckV6N1BYelFqdlpxdFdVaCsvM1dt?=
 =?utf-8?B?Qk5MRnVrMmtGR1VXZ3AvOFJaUW91Q3RHTnV2eTl6K1ZycXlWdWhIbTVUbjdl?=
 =?utf-8?B?TnBRcGVnSGg5US85Z3k5bFF3bm1QMktnczRwV21Wd0xHbEEwODhnZFZsakVR?=
 =?utf-8?B?UkFHOW5XSnFwdERpRVZsaVVLWE9YdXYzdTdCbi8wNnYwaEZkTkxyQUsrTWdJ?=
 =?utf-8?B?VjFrU2ZnS05USEhKVVVCSXVIYVJocUkvY0NGbjZkVjJnSkx5bElDcnhiM1R5?=
 =?utf-8?B?SDZKaDMvbTN2SzBCSlNHeDJ3MXFnVTZxSkV3NmlSSHpSUHFWeGwyTEJtaW1H?=
 =?utf-8?B?dmRvdDljeDNwU0N0SThDSVhCTWFZQXBRL1dDbVB2U0huODE5N0d5NEZYQ3FI?=
 =?utf-8?B?N083VXhyWTNNaGVoV0hxdTQzZ0FxdWMrOTdYTGp5d1VqUm54a3g3enNHSDJV?=
 =?utf-8?B?R2lTdCsralZ5TWlqWUs4TVR3N2dqYWVNdlZzSElnT0FMaVhFTE9TVFQ1eTR1?=
 =?utf-8?B?ek1RbDRhV2hJQVNvdlNycnNSRXRBcDBkRk4vSjdvWW5GYUdCcldCOE1JT0RV?=
 =?utf-8?B?NEp1N29CT2VFNk5yMWdyK1hPV3U5THlLbytSOGRlRjJNYkVVOGR3anRicVNx?=
 =?utf-8?B?ZUZjZmxEd0ZVSm9wNkl3RERKMmJHZHZzRGtQcktBeGdTNWx0TC9Dc0poUkR6?=
 =?utf-8?B?YklCbFBRcXh5N1VpaDlJU3JaMFkvMkVXcGtKc21nbEFGN1JOKys5clRwMVVa?=
 =?utf-8?B?bWVnZzF5WW8xQVUvVThGMFdZaE9xWS8yaGNxckg2ODZER09BclJGamIyYmV3?=
 =?utf-8?B?YkUzOGpFN3R6RFh0UG9GOVAveTMzczl1dlFiaW1IVExpcGhHUU5JSkt5TFZv?=
 =?utf-8?B?dDEya0JtTUlFcU1RMW42OE8vYXZuUXEzblVpMkFxdDh1aTMyMmxFUCtzOHZU?=
 =?utf-8?B?NjFFK2U5U2tPbEVaaGNRLzZQdmVxUHJzOVhMeFIvR0ZDMFAxN0xYUmVuOXFF?=
 =?utf-8?B?OG1INTRGMGlaNXRlMEpOMlhGdVF2ZzdHM3VHSHY0aVdkZ3d2Q1FUMTFoWmIx?=
 =?utf-8?B?dWtEYnF1QVdtcTQwTGQ4M3hJbUVPVXlCSDF0OTF4WkVoSXZ1UDhxSkcyRFZV?=
 =?utf-8?B?TVc5RXl2Q2VhNGVpaXE5Y094VTArVExWbU5sSHFka2piRFE5TU5jRG1UZWJD?=
 =?utf-8?Q?YKsOFTP/7YDBaqWPM2dgvVtMtMU1sTKa2MDtXsh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJweFRqMlZBa1FZSmxXdUhJMmUyMC92TXNUSXZNRVJUcXBDZHdZbTRJU0JJ?=
 =?utf-8?B?WEh6bnBxUmNlZ25vWFNsMGtyWm9xMDh5Zm04SS8vbkZ1V0s3Z0ppWXRrUmQ0?=
 =?utf-8?B?M1hDME9NK0VsUEZvY0xacjJHZm01RDNVMDhvZHBUb3FMTnVEdEVMa052S2FD?=
 =?utf-8?B?dVJCN0M1Uk00UUd2L215TWF4bUdrQUJkUWVLcXNrYjBaS2d4RlIwY1d6THUr?=
 =?utf-8?B?M0hMczhvVUZPMEJlRmpvcHEraks2aDVDUVNDYWxJSUVRQzNhV0xUamd1MlJ3?=
 =?utf-8?B?b3Bwa3pxN3Z0Z3BiVG96QjU4RWZEY3hRZFlxL0pydTNKdFFaR05sejIyNGw3?=
 =?utf-8?B?Y2pTKzRPT1FoTjh2SytUbkZzVXZWa2lIZXpqWnpSdWJZdTVxRkxkMlVjRGpK?=
 =?utf-8?B?eHorNUhuSnRtalQranJ3SFYvUXRaajJDMnZUOE1JUUtwejM5enRnTDVwRHN4?=
 =?utf-8?B?bWp0bFZ3Y0E1c29OM2grbXkyUGdpSzVKcVVpNFYwVTlVck5SUUJkeWI1SG1j?=
 =?utf-8?B?KzE1ZWlQa1BoWkRTU1U0L0J4bkE4UWt2Yk5CSW9UT3YvNlFjVit6WVdmMnhS?=
 =?utf-8?B?QTBXL29lK2RMeTlLR01SRU5KRHFvekIrN0dOK21Ibk9NbStQQkdIRGpFcXFv?=
 =?utf-8?B?ZkJ4czBvVFZNd0ZJRVE5TEJhNmNubzFWcXVDT01jMXZoQVpBMUhhcmNWd1Bz?=
 =?utf-8?B?Q0l4K0w4ZHB3cGlMaEpaUXRCaTl2Q3cxV2VsbS9qcUxQSU1MTXo5QmN2enFa?=
 =?utf-8?B?UjZ6aTU1VkwwU0xzbnpCQSs4elMrT1ArWjZ3UWRxQ3ZjTU1ldGJFZWxUcUZY?=
 =?utf-8?B?WUdCeHlzaVFxYzZyRHRWekZuTWVZdnkvVmVja3FGTHRuVTJURGVPK3dkYW1Q?=
 =?utf-8?B?WWJFSjYzTFZSUGlTK0RZVlQwdU5mVDRsT2hqN0thb20wR3pETDh0UWRBenVH?=
 =?utf-8?B?Yll3RlVwbWhvK3lpZUdvUWg0b1hUK2hMemdLclBabGN4RTNoY2Nrb0ZINWtn?=
 =?utf-8?B?cE1CNEdVY0ZwS2xJWk9OT0JmVHduM2FNV3NuQmlEc21LMzQwZEVvQ2tJM0Z3?=
 =?utf-8?B?RlBuTEY3WmlCWHIybGo2alRJeE1HeVZ5cks1TDh1eklhd1JSRmU0bW14eGFn?=
 =?utf-8?B?YmpJd3BsUXpEc0x3V09wcFF0bnZXaFlsczVrR0ZxVW9Icm9wUkNlcS9pZ0Fi?=
 =?utf-8?B?bEdlMnNoU0xKUFBPUC8xd2U0RlFIYmFkZ3VLK0ptRW4xUHJXNU93b0crclYy?=
 =?utf-8?B?Vzdqb0hRZWVRUHplU1BRb1ZCcFlWdktHS0F3NmxkRk5QYW9XL25WazdVbDRz?=
 =?utf-8?B?ejdpUU85VG05Vlh1bUF1a2FpL1VKUlRTNlFUUE1iTnlvYmNYQ012dW1McEx1?=
 =?utf-8?B?eHNhS053eGJvNUJzTU5yVFo4UkVKMWNNTjArMzEvaHR6TFFVY3RHbFdBZkVM?=
 =?utf-8?B?SW5EQ05GV2tJTHpxNjdPRDdsbTBSS1lMaXZKYzI3emdiQjQ0OWR4eWYzRHZU?=
 =?utf-8?B?b1pMbHZXRWVoekxTcU1vY0RiNkhFTkVvVU1OVmJqVGI1dlhsU1ZJWFBiNDNS?=
 =?utf-8?B?dlkrMmoxN1NTRjdicW5zdnFZRm00dUlpL01wK2lBUXg1Z0tqdWhrbkNub05u?=
 =?utf-8?B?R2FFTkd4SU83Nkg1MDM5WE1BbHdCUmoyaG1PZ0ZBWDJlMkxLb2tpRHNIZ21r?=
 =?utf-8?B?NjZyTm1Ca1VYcDRmekE2bExPSXdCTjNzZDVZUmx1TkcwRlU3aUlLV201TmJr?=
 =?utf-8?B?WEtRdWxvYUxvaVdRR1FJR2taR2VNendQSUVtNjYyWWN5OFRVTW5YaUlnYU5x?=
 =?utf-8?B?T3QxS1Vwdnd3bnpXcjUrYnZUVVdVYk9HVlU1SHJVTUR4TzhiV0p1aytjREd3?=
 =?utf-8?B?Z1hldmtNWFNUdHRqcng4KzFrZjV4aXJDTVBQeUVnb2pPK0Q5QUZQVzVtV2pK?=
 =?utf-8?B?bXhObDc5M3JQWldlYVQxSmNZbHdzUkdLUVZ6SEpFcm9HNERObGFBc012cHB0?=
 =?utf-8?B?NWpXc1dOWThzKzF1Y2hEd2w1MXJpNWllMjQ0c21pamtBb1NYWUNNZjJielEr?=
 =?utf-8?B?ZktkRFo1QXRuYmNKOWs2SlRLN0JIMjQ1VUNrT0ZHeW0zRldENVVFa25IY2oy?=
 =?utf-8?Q?OcIL349xxhq576hSEl6OUbDDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ba7156-e62f-4b34-b8a3-08dc8fcc62c7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:25:17.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxwA2WYr9278iq9/KV5mu6i/krla7VNMkTQDakPjaJ2/mBZ6RJiPOGcwgluHkpOZUZg37Tv18OLlByN4x+oMWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

On 6/17/2024 01:59, Perry Yuan wrote:
> The amd-pstate-epp driver has been implemented and resolves the
> performance drop issue seen in passive mode. Users who enable the
> active mode driver will not experience a performance drop compared
> to the passive mode driver. Therefore, the EPP driver should be
> loaded by default at system boot.

I think this commit message should specifically reference that it's 
being enabled by default on shared memory designs as that's the net new.

The code change looks good, go ahead and add

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

on the next version as long as you've added a sentence about shared 
memory designs to commit message.

> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b48fd60cbc6d..eca2f7dcf7ce 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -96,15 +96,6 @@ enum amd_core_type {
>   	CPU_CORE_TYPE_UNDEFINED = 2,
>   };
>   
> -/*
> - * TODO: We need more time to fine tune processors with shared memory solution
> - * with community together.
> - *
> - * There are some performance drops on the CPU benchmarks which reports from
> - * Suse. We are co-working with them to fine tune the shared memory solution. So
> - * we disable it by default to go acpi-cpufreq on these processors and add a
> - * module parameter to be able to enable it manually for debugging.
> - */
>   static struct cpufreq_driver *current_pstate_driver;
>   static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
> @@ -1867,11 +1858,9 @@ static int __init amd_pstate_init(void)
>   		/* Disable on the following configs by default:
>   		 * 1. Undefined platforms
>   		 * 2. Server platforms
> -		 * 3. Shared memory designs
>   		 */
>   		if (amd_pstate_acpi_pm_profile_undefined() ||
> -		    amd_pstate_acpi_pm_profile_server() ||
> -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		    amd_pstate_acpi_pm_profile_server()) {
>   			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   			return -ENODEV;
>   		}


