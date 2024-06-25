Return-Path: <linux-pm+bounces-9944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF549167E7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B51F27A74
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05ED14D45E;
	Tue, 25 Jun 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sVknUhZ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220E14831F
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318782; cv=fail; b=UHvIms/bD4ufyHOPm9gJ4D0xUAUMEF/oslSHFB3XoY06DfGCo9OBzfh/JRCgW3ufzO4x4qCgLkMnfEQbMq+2y+JSsET/FfrXzcTMKL9Y+RoADllG/ZkljC+zVJoSJjaAcb4uxBWRm78D5F9UYek/jx8TFnCPnmCVvcAskPZXW+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318782; c=relaxed/simple;
	bh=o6h7DLsBjOGXM/QCSwzMrF+IutTo9X5xbp2KFe4Hgxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQPL5fxxt9uA+sKmQdrW4Hayx4MMO4yAYjgd4vaGKHijNQeAG4fV8zKmvW1IyGwdS0JfnPc3Pz8SNNZLli/jrVZaMDUiUh4TJ3sg5OSCIqZZeJmajNQTtgPZzno2efI7bwtB6jG7Z7TW8Nh6LNqK4o3zYJ0ytPHspCM3TiDIt/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sVknUhZ5; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwNar3E/S8kyjTLc3UPGLByeCLRW0HyvoQwENYwLv+1OXuqLLhxYl/p4NGPQi2IbkRZUT8cMMv3aNrcMu/VGihsQvLjJCMUMYvVrG4A1bG9OqI34yfExFYNwsjIAYrvr0wxMQjg+SEVhoZq0HjwKN0TgRYKf7yS9YDbQYGz0uxCnf+4LUFDPVGqIiIPHgTir84hU7o0uHLd8wI+svJx0Gdus0heHTHaAu/wlChLQaob6GXhNyg0vsbLcqpfCNMOPP+FEYw6pOVXK5ImGzVXT9RnY0/vmYIGvSwXeYVij//qHZrR6wHdRu2jgvMUNPxYcZUYTqMkeuKubJ9eodeGqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7/r7AALH9iWNR/Vfa0tRVpGNkgVZwXXQoRGW4lhskc=;
 b=TV74kGTXj82PpO8NhpVXx5FFWekZ6U70nIj8h+lmP0Ls5l8EgxNCO5wpr+VYjWk2u0Jliqp441JhswYYeGWsonsEICUZ9r4cm79Zi8mCeWrMG+ucEq1eglXidzVZqf9t+ku00Pxc/3bR6LwQDMs+WmO3JN+u4tyqqG8jseo7FVddObTnRAi57k2DMOOHzKsvch2RPxlCuT7kcHCxg+zBn0HB3O5Oa4nuq8blmoQZgpiYJS4+1KZ9pUH+/s0LpGHIr3H47uxeYE6vvMFlSh8vfZTVB45Fy5GwBAsXBHQm/VfHdj0YFuYC1qmFcuEjFg8p9W2NX3djSAIthSbGdg2ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7/r7AALH9iWNR/Vfa0tRVpGNkgVZwXXQoRGW4lhskc=;
 b=sVknUhZ56ZOmROCxpiCc/QwPcShRVlJidBp4fXCE+biUHWvvvDxt7njWOBzxhpKcF5y+cFtuCtAPZY1GxrhBjG3SyzSbP3rd0s8tSVxyRAOb/Vl7DqnfMPO1GTkcjmlfSxy5uozL5iIItx6SpJxNhkoerIJXcMZjt/3bzb8N4hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 12:32:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 12:32:57 +0000
Message-ID: <6e64e0fe-5f20-4f5c-9c89-e0af2706c552@amd.com>
Date: Tue, 25 Jun 2024 07:32:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>, perry.yuan@amd.com
Cc: Linux PM <linux-pm@vger.kernel.org>, Sibi Sankar
 <quic_sibis@quicinc.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <877ced2q5i.fsf@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <877ced2q5i.fsf@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 84243541-7e13-42c8-951c-08dc9512f1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVYzNEgzSmhLYTQ1S1ppalRJbVdYeFJmcmd5dGRjOS9WR3kzZ0ttcVJwM1pi?=
 =?utf-8?B?ZERDSzFPNkl0UFFxY1puSkErZDgvVThBKzQvY3NKYkNsRWE3MlN4WXMvYmhs?=
 =?utf-8?B?STk4MFJmaDRRTHVWRk5hcFIvd3FEdCsydGRycUZoOTY1RFhSN3FROC9GOGZa?=
 =?utf-8?B?MWR5RXUwdnFyZWhENmJ6QkpMdGNWK3JBd1lVMlBKNmNSZmxZU2EzczdZeXFu?=
 =?utf-8?B?a3EwdHRINFdxM2RmOG1DUlJmQjU2NTlkTUtGcnJiR3NzZkIyeDZjZFAwQkhq?=
 =?utf-8?B?bzJ6YUZIRmlyL200aWZ1YStXM2JlcjZZTXVYRXdnZEdKVlNXeUZwclRCZ2NT?=
 =?utf-8?B?L1J1RTVmRWRSeldCZkdvZHJsSEJQUUVwVUl0YThFYTVCTnRRR0JWUThkV2F3?=
 =?utf-8?B?UjBVaVkxbktVOWROWXZMQlpOSlVZclZFdTYyUm5VamlHci82MTM1YzlRMGhB?=
 =?utf-8?B?Q2tlWVJOWjVhY2UzS09hTXZ4Um9RV2dFZWJjbnB4ajlBRkJXU1Jha0JPZFgz?=
 =?utf-8?B?dmsyNVZ6Ymo0bE1IK1d2NDRvQm9lVlpLN2dHZTVFak5lU0V3MStUK2ZWVG8z?=
 =?utf-8?B?cjZvYXQ4T2ZkUVVobVgwdXA2eHJvTklmYklscGRjUnV0MGwwZTBRSlJaSTVK?=
 =?utf-8?B?RnNObTh0eCszVThrLzhadlh6Wk0vWG9zWUcrS3ZVWFJwZGRteW5RNmY3ZEEv?=
 =?utf-8?B?WGU3ZHo1QkgyRVZZM2NrRi9sTGt5WmFhOHJ2V2J5cFZ4QVdmT1ZwajE2d2xt?=
 =?utf-8?B?aFZ1REhTamNZTklDOE1ManhURm5PRy9lMkh0RjFkNVlYZ0dEekJNRFpVY3Rk?=
 =?utf-8?B?T1dpNmc0WTlKNkRZS2VLSjZYRzNkQlFVeDFLcE1BZWswTnA1U244ZkdjZzlo?=
 =?utf-8?B?S0k1S25NRi9qK0RidkErS3Z0OVhsNWVCYjZQNG50M0ZzOGxGWWRkdGdwQ3NB?=
 =?utf-8?B?RGxJQUFJRHV1NklIN3huNmlIbkNqdVd5RWNXbGQxV2ZGdDlXZEs5NFdSRld5?=
 =?utf-8?B?V0QzY29qclk3dVRPSlhnWFRrUHlDbXhhKzg5QldDRnByRjFtelh6dWVlRWZt?=
 =?utf-8?B?NnB0anh1VWZHV0hSanpNamMrK2lWL01CQjk4eXdxVzhCZk1NOWFFT1cxUXM5?=
 =?utf-8?B?Y1p0c3ZkamxXVW9GSWNxc3M3VmYyTnNUeXpmcWN0aTFWeHMyWXZIVnkrbWJs?=
 =?utf-8?B?NXZqMVV0K0I0K09kbzVpODhoV0JYWFpZMXpyVXZ2RnNncmo2alNMZmh4d3B6?=
 =?utf-8?B?SXFSUlU4ZjZCVlV1YXR5enQ0c2NycllRUk1oUXJRdEhOTUNocS9tZ1FqU1FP?=
 =?utf-8?B?VE9CcCs5N1RtaW1nRmxXWVVXZURIRUtmSDRVYzQ2cjlTbloxRm9UQVZhQ3Uz?=
 =?utf-8?B?SkNvc250OEowUUVVVmI3b0tIWC9lSVdJdWUvcWhPOFRwNlFpZnV6aVpiK0xa?=
 =?utf-8?B?ekg5QWRZMUhzQ1gwOWw4WHM3V09GK0lRQjVreTlEWHFjSnAySlFwQ1p3Mldx?=
 =?utf-8?B?aWkxdytadFZqT3pUcU9CSkFqL1lBWVY0OVRwZUJpU2d3UnE0UVJlb01VK2R0?=
 =?utf-8?B?aURBQnExbnQ3MDlkaUx2UGRxOVNid3BBUzNsRW40NmtRbGE0eXVxMHMycUEy?=
 =?utf-8?B?RWxOakd2U3ZTWk94cnZzUXM1MUNPQTR2L0ZSNkY3RklRbUI4ZzludFp6UklX?=
 =?utf-8?B?a1BvK1BEMXZ1R21yWFlDeEhzYisxMHcwbDV4YlJuZ2wwdlJZNHVCVmVGMGtF?=
 =?utf-8?Q?SbSKnYHmLRPa4xhg2Qb7n4p1NFxUi6yJPangDsT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2E3YlJqbWdSYVh6a2U1YUFrdXpQci91UnhMU0NlODFTcWFiZ2J0OC9vRkJ3?=
 =?utf-8?B?TzJXUUtIMlpmWXRnM05oOEhTZG0vRWszVUV0a1B6KzI1UkJOTHN6ZUMzNzJw?=
 =?utf-8?B?NXhaOCs0NXBTYmxOV0tESXZ2a2doVlcycit0TDhQMkFJTUt2VzZEZ3MvdUtl?=
 =?utf-8?B?MUFNeFFleVBiT1pONENzdWp1eEc1UkFWSkgrQXYrYmV2enl3U2xFMW5RcUtI?=
 =?utf-8?B?czJsUUdFMGh5L2tlNEEydU45RXJ6OTFnMlR1cGhPS211Unlnc2wyS1IrbUVW?=
 =?utf-8?B?RlJUVXFLajZPOXZBSnZsdDdVOWJ5a0xvdzNBZCtXTnVjS3lZMXhiczhIV0xs?=
 =?utf-8?B?Mi8rdFJnbzRsWDh3K1BzWkgveU9lakcydHo3cVppZllNcjExNzQ3Y0Qwcy93?=
 =?utf-8?B?MGZxbld6VTlPcjdpUVJiVHQ3ZFF4QlNnTlpWemQzMGR6eHBRVVNwdCsvaHE5?=
 =?utf-8?B?VjFmTDBYYzI1bi9iQTNjODQvdm96ajRQNnNSaEhrV2NTQ04wZURwL2N6RGdT?=
 =?utf-8?B?VmhiRkFpYTJOYWNseEJPM3ZkNjlnazE1ckMzUUQxSDlSWUdvNldxYUI4c2Vm?=
 =?utf-8?B?Q0Q4TGQvcTRlTklZSUJQeE43OGNrSFFUSlNiUVlZQlZJRGc0TXN2V0hIWUdS?=
 =?utf-8?B?bjV6RVBnMVpnaHRUaXlzdlkyYXRaVjY2LzZRN01Yd1h5N3hqaFFhREFzdW5J?=
 =?utf-8?B?ak9XclR1M2wxNTNacE0yV1BuZThhcGNtUnRCZWtQcnp4WlBZVjhTcmdtTTN5?=
 =?utf-8?B?UkdiZkY2TEpsZ2Z5NTJLencwUXE3YmJKNWw1MCtVUFlLNTdQOWREUVIxTEtv?=
 =?utf-8?B?VHZiUWhma1FKdEd1T2JHeUFoWllROFUrcHd5WTAySitHY3pHWmlOSm1HdTFS?=
 =?utf-8?B?UXpNeG9QdmpZWDRDdUE1MTArMUI0VEdOUG45ODJXU1pmbVA1enNROTMzam9K?=
 =?utf-8?B?SXQrTktQVFAxN0Nsb0thZDJLSjFGb0RiUTFiVWszSmQ5Q0hlenVkaFVIRXpY?=
 =?utf-8?B?Y0pUcEZwd055V09YTmVGZ2c4cFluVzRkZEhCSFVrOHp1Mys2b2hYQ2prNm1Z?=
 =?utf-8?B?UytsV0c1NjJlZ3lmcWZSY3cxNXNoSENoRDFqcmxWdjRYa2lxZWRnSDZJQmsr?=
 =?utf-8?B?azBxZFczT1JpUCtKcnJNOTN1d05Hakl3enRDdUFzSVJGOXltVkJZMXY2VU42?=
 =?utf-8?B?U2NoYXlIbllEd2ZPSU1WZjdSWjlhK04yRWFEV01FWWh1bEdKUGdvVk91WW9o?=
 =?utf-8?B?c0tsU2ZyejF6ZVdUcW9aTnAxYklqckRaNVJBM2MxSVVFMFgwcDVyYkIzNVNQ?=
 =?utf-8?B?YUpPN1dwZHNJYUVZRUVrb0tYVCtpK2Q1L2ZiNjJUajlqUTM1OXNxSDdiVFBC?=
 =?utf-8?B?aGdoY2U3TXFvbGticjFUb3QzUnZhVjlaUVQ4OVZ1UkpzaUlwdUVaVUZLdzE1?=
 =?utf-8?B?YUlmSzhMc1gzOFRVVUVMMThWaC9vUnkxZFJLa292RWRiQmtYUlVEM1BJblhR?=
 =?utf-8?B?QXlxOEdoR3ZTVXVHMkV5QlBlNGdPalk5ZDhSbXZKelNoVVFDQm5jd0FnWjJq?=
 =?utf-8?B?Qm03TXQrcSthQmpuVlBkUHBPanRocU9jOHl1azVRUWk1d1prSnAvck5pVjUx?=
 =?utf-8?B?SnJjUmNIQjg1cmk3MU92d2c5b0wySTU4Q0hPRkFZTG84L1IzM05IVVUwNFgy?=
 =?utf-8?B?YW0zMzk5Q2g0OTJmVFNIM2JPQis0cE54K28vVGJYS0FLRXRnQndsTTFDMUg0?=
 =?utf-8?B?ZzU2QUhVdzZsYUFnTFNmRWgwOVAwYmNVS0RaODZpRFhoR2NrWWt3MzA1VnE4?=
 =?utf-8?B?MWNXdEFNZVRablRpK2U5VmVpMk5yMDM3U1MyYlJVYnF6OUZJTnFwV05KUVZz?=
 =?utf-8?B?Vmt0L0psWWRWTUMzeXlUS0JhT2cxS1JDMXBBM0M0Z1JLelF4dlFTcHZXcnZr?=
 =?utf-8?B?ZXQ2MGNubFpIMHdUL2VGSWtiSHM0VjJGdFN0RDBuNGlSZnFWRm9kcVFsKzRv?=
 =?utf-8?B?TjdtK3NkSUxDUFErRUI1dlNTZ0xUOStjR25NSFY1M2FDcld1Z1UwcnVKYVBi?=
 =?utf-8?B?MmFJcW5jRFVUcTVmY29SdW1zMjJCWENNdzA1SS94QVMwL2tvV1JLeXJGSXFW?=
 =?utf-8?Q?gzW0k2aWfEDN/hiLN7oJT9eaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84243541-7e13-42c8-951c-08dc9512f1ac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:32:57.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxhV93yUh+PmOyvctyUcHla7JLD4vLvCvdLGZKxknSRRFeudvglV8qRASCQTiH+cNJS4mESgzD44dkTS50W/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

On 6/25/2024 06:55, Gautham R.Shenoy wrote:
> 
> Hello Mario,
> 
> Mario Limonciello <mario.limonciello@amd.com> writes:
> 
>> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
>> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
>> policy incorrectly when boost has been enabled by the platform firmware
>> initially even if a driver sets the policy up.
>>
>> This is because there are no discrete entries in the frequency table.
>> Update that code to only run when a frequency table is present.
> 
> Thanks for this fix.
> 
> 
> There are also drivers such as acpi-cpufreq which have a frequency
> table, but the boost Pstates are not advertised. Thus none of the table
> entries have CPUFREQ_BOOST_FREQ set.
> 
> 
>>
>> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: Sibi Sankar <quic_sibis@quicinc.com>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Dhruva Gole <d-gole@ti.com>
>> Cc: Yipeng Zou <zouyipeng@huawei.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>   drivers/cpufreq/cpufreq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1fdabb660231..32c119614710 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>>   		}
>>   
>>   		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
>> +		if (policy->freq_table)
>> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
>>   
>>   		/*
>>   		 * The initialization has succeeded and the policy is
>>   		online.
> 
> 
> How about something like the following:
> 
> ---
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 37f1cdf46d29..be5f4d3e9c1d 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -140,6 +140,7 @@ static int set_boost(struct cpufreq_policy *policy, int val)
>          pr_debug("CPU %*pbl: Core Boosting %s.\n",
>                   cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
>   
> +       policy->boost_enabled = val;
>          return 0;
>   }
>   
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 10e80d912b8d..f604389b9cd6 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -18,6 +18,10 @@ bool policy_has_boost_freq(struct cpufreq_policy *policy)
>   {
>          struct cpufreq_frequency_table *pos, *table = policy->freq_table;
>   
> +       /* The driver has explicitly advertised the boost-capabilities */
> +       if (policy->boost_enabled)
> +               return true;
> +
>          if (!table)
>                  return false;
>   
> 
> 
> 
>> -- 
>> 2.43.0

Yeah I think this works too.  Let's see see what Viresh thinks.



