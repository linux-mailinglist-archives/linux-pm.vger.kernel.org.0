Return-Path: <linux-pm+bounces-11740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3C942955
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BED1C216C2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0B1AB524;
	Wed, 31 Jul 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kN7cA4xd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544A1AB50D;
	Wed, 31 Jul 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415147; cv=fail; b=HJJc5PZwv223jHP4mrmwGtSS2530a6DUxrvF4l1ZQPLupGfY1x3boY/iBkvj2Cj8gPGsLZvQRw+rx/fuY0w/tWtQYIAYpx5FfKg7261nbIMg9QSSOKupdfNhlHgRKy/rBmDLDD1iiOfSici1pVBAaZUv96viJHx+NUoAeiws0Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415147; c=relaxed/simple;
	bh=nQRenzSHohVRxyNKRAXVue8tX/FZzE3yOdUxWzyzIBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RCHfo3ap6x2QBPJS8FSyP5qyR5BGlEtnL4TNxFCDtB7D755DC/6TbxRz8RT38ivvsNVgoHlb9bCHVTQxFRuAWe1szwlIcXYYsS9nrKOjkedxjybzE8JhHBRZrxdq4sh6y3V7IMkKoDMQ9uoeZtkEzWZk+MFL7q+45z/KP6IDLSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kN7cA4xd; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOzUImgNllbxdUGFEwVhSk0tzxIA0w2a8XXn3b3IPw67GF9VdsUYF7f0ynUPzxy8UOq2r5yainBYeNsEs/QFiMKdCFRKeuN4QHw6VxBWvcQ87rG0k0TyC7C13vIwXzqBdrsKoU/RgELYxvncRohoV1XhBcOPZmDWRkq1rmtZssIsygU25qFgfLx28LhYNSFiD4v4Qvt9KM7HjIS+V3jkaCPkPwLc0RLjmtDoRfZk1YHDAChg65NMo/XhxXuH+n3UpOcLWjJZsIyAEAez+X+1/KsAnl++6Ei3dLo3sqyM28kgE6AnWlglEEUdwYYKVyDN7vRyco4nJ+K+joeZxrjYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ8P4sQ1PDKg0zgW38UUiemiWHNDQ95dUoillN0ZdvQ=;
 b=s/atqoUpbtOrwajbhApQlh3ipYL+XWZt0msnlqmx64MAVBvZuhMtyRS09H+qf7BUeCmKDf7hRplYnEJs3BQdOpmKVmexjMpTtCzyaPN9A1OJSAiRd6O57gXUrNtzbhs8IZ22zTBtaFv4awvQb7BK9+aIxePHUUoGNprqC4JC8gcuaXi9oDJmtbxO3eiOQKkO0zxajE8szEVHbPuuNvqGOHYv4O41kjf39aNhNJC44+kgTTnU920u4qc6zvLqyF0M76lLKlN3eOZ3SYi2RQ11cg397mAhxVG5vxESAek6BucOX3jZPZ462WM2YGp/RNgX6bmlLa82UyKM1AWaEBtisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ8P4sQ1PDKg0zgW38UUiemiWHNDQ95dUoillN0ZdvQ=;
 b=kN7cA4xdNTOmvZ2Gty9ZVX6XeHCgiG/24EJO8fxHIwY9+NOU22yVKZ5ceU2OKlOHaVh5NdhOmixj3Qx3BkHUV8Dlk3YlVxDJj279ol6EYRqv3qtHwY0ZR4pBmn/VX33glE6F636Eh6ceHAnUXh+gFwbsCGOIplB6rjBh/EjIkbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:39:01 +0000
Received: from SA3PR12MB9198.namprd12.prod.outlook.com
 ([fe80::bb2c:e2b3:89d1:9f99]) by SA3PR12MB9198.namprd12.prod.outlook.com
 ([fe80::bb2c:e2b3:89d1:9f99%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:39:01 +0000
Message-ID: <cda28ad6-43a7-49f8-bf40-980486d9e17e@amd.com>
Date: Wed, 31 Jul 2024 14:08:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
To: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731083200.169985-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240731083200.169985-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To SA3PR12MB9198.namprd12.prod.outlook.com
 (2603:10b6:806:39f::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB9198:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 6775def0-e516-437e-52e8-08dcb13c3a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTZuUWY5SmV1dU8xaEw4WEdTUVcwakhwOWRHMnFXSTBSc3RvSkM1bjg5SHQr?=
 =?utf-8?B?VWV3cXpXdm5nU0lNbG44OFdFZmZBazFYRlAwOUNlQzNkajA1T3kydDloWS9F?=
 =?utf-8?B?c0VUL0VydHlmOElpdGhLbXhQb0tFaUZKa1c1bVBDQ3Y5QjdPczUyNEtBczI3?=
 =?utf-8?B?RWZFRWQ2SUVFd1g3NWloRkZqaDQ3cWRUTGdkU1hoQk5qR1FxY3FDZUd5M3Fh?=
 =?utf-8?B?T0V0UW11N1ZJZElHME1mYUZ5czNoeklTdkpjRG55OVVtVGRMclJxRTkvSUJM?=
 =?utf-8?B?WU5rRlBQMUNvUWZIajU3SGNEWlVUTm15MU5Dcm1OaGtaTEVRYzdmRDA0YVhH?=
 =?utf-8?B?WUFKRzYvTnlsRDE4UGp2QXBSVDVQVkl3K3JMcS8vc0dya3NyQ2VzU09McFhz?=
 =?utf-8?B?NzVqRURrVTR1Q1pXZWg2ZUF5QXpOTVR0dWFYUU1OekJqWVpkc3g0eURtdlRu?=
 =?utf-8?B?ZkJrV0UxMzhvU1l4bFdoVXRBT0c4L2EvQ2plV3pmQm5hbWFxWnJPYmo1ZVps?=
 =?utf-8?B?b2xXeTQxRlRjVzRkVW9LZlQ2ZCtOWGJEK2dTa0pZaDZIYVlCR2lzcWpadFlV?=
 =?utf-8?B?RVVZeVZUbkllbW5XYnRFM2hIV1c0SnNWZWVLNW1JbFBzSVc5d3ZSWWU2Y1Nh?=
 =?utf-8?B?MXBDY2FmbUdOTzQwelY1RzF2V2ZOUlhKZ2h5MWtUWXdEMHIrTVBLSTNtWHNr?=
 =?utf-8?B?VndwVHk2MHQ0NjVYelEzU3lNMGpNTm1UM05JektCRDZxTmg2QzVJS1lDQzRE?=
 =?utf-8?B?bW9Kckp2QWY2OU5IZnpMUm1RVjZtM2xxOE5HK2dEVi9PaVlpOEV4MDhuSTBP?=
 =?utf-8?B?TTRjTUloaFZ4NzlVWkpDNlJOZitnZktDOFp6MjZoZ3BRT1NSTjRJSUtUZGZW?=
 =?utf-8?B?NXZHWThzMU5kdHlZb0RPU1lRSUxrL3NXVit5b0RBekF5VGVVMnUvaUp6amw4?=
 =?utf-8?B?a2RmVzVta2JDUThLMjZ1dmJYWFVWQUEwMmNiVU94ZEFTTmxJRVN1QjkxMDlG?=
 =?utf-8?B?K1M5SEZIVHJBSm45Q0RnZ3l6cGxSOHNNSVlia1dMU0krUzc4Zjg4U09uSzRs?=
 =?utf-8?B?dHFSMnFFU1U4ZGdhRmZWbFNkUXFBRFFheDRhMEhKeUtWU2VqN0RpU0lFU2ZD?=
 =?utf-8?B?ejR1RTBHaXpDa3R1VEZZcndVWE83N2x6NDMrKzJHcGR4SlljcGMyaHVzRmpY?=
 =?utf-8?B?T1pFY1plQTRES0JTSng3WkZna2VsTU1jU1pETjFhUU12VWV2Qm1WRjdQR3lE?=
 =?utf-8?B?c3JLRWsrRTFVOXpSYWpLY3RFeHpUL3pueEI3dUlkcXUvUVlPUXd1ckx0K3NX?=
 =?utf-8?B?RFJwUklPZUxqUm9PZkZXS0ttWjR6VmhGdVlEd3pMWFNRVkJqT1gzTzdMclJ1?=
 =?utf-8?B?b2s4Q1lDWW9iYTdxSURqNEpQWXhHTWhaQ2ExaHZUWGJNWFBBNC85Z3A5QW1I?=
 =?utf-8?B?bFBtYkNxQ3BnZGVTSTJpZG1FMmhwaVVscGJhaHZZZTNKRTlHeUJJZTVyKzBG?=
 =?utf-8?B?cWswUXp5U2pJc1R4N0ZTKzJEejJ1ZmExY21xZlIxK2gwRFkvVm04Y2tzMWNC?=
 =?utf-8?B?aEtLY3VCbWZtdm13VWRPSk1LK0J4YVZPYkJIVXgwZjE3WENJRERjZ1p2bkxI?=
 =?utf-8?B?R0grN01JU0tGdnhWM3V1UncySXZTb04wSExUWkVTcy9ERzhySyt5UEF6NXUw?=
 =?utf-8?B?MUtHdFZzYWVTRzR3dzI3THd6aDQraHd0UWVLUExEUkdidHhSejJkcTZFSWlh?=
 =?utf-8?B?V0FzYnFqMFJ2ZURES3k3YmFXZHNRU05jWW11UDFUTlFkQUlMR0dqdytJbVZj?=
 =?utf-8?B?WE5YVnJrL3NDOG9reXZzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB9198.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHd5OGlHVjlKYmRieXh5RStra0gyYjBvdUEzQ1g1OTFLZFJOSzBpZGZjNzJh?=
 =?utf-8?B?SU5GU3Fncy9EeEdWSU5ibkYvSmIwQm1pZmVNeUx4ZnNjVEdQTkk5dFA0RDBX?=
 =?utf-8?B?QTZ5MGlTUDNOMjRoZWxTa3NsOFA5UU0zZ0dVT1cvVzE0ODhnNVdBcXNZZjFm?=
 =?utf-8?B?bXJWWkRPK3VBbVdOY3BYZDk0QzhabG9KSVZTMGp4elNzRksrK2l2NVdpaVhw?=
 =?utf-8?B?SC9zNVJpNklnL28zUTZseWpDWFVJNTJtVTlFSWJxTXZ3OUczMnNvQmNuTHZB?=
 =?utf-8?B?K1VlSENacUFGS1lwM0s0aXQ3cjRqWTZuRHNCc20reWtFOEpKL25EdnhLWnh4?=
 =?utf-8?B?UERldkl3YTM4eW9EeFFmMnVQbExmUXR1OSsvaWVocXJGWTIvUFMwaVVoY1Ju?=
 =?utf-8?B?SjEzaml1Z21Ka0ZmL2Jtc1pXUDcwSENBaU1ZK2Y1UVZXRFJxT3kzTS9oQ3d2?=
 =?utf-8?B?Umo4UUk4SHNEQ0U2REtnN29WWkt6ZkswemxsbG1wdDlrelR4NnRIeitsUXBY?=
 =?utf-8?B?a0NRSW1Cc1hjMUVwT0ZjR0VEM2xzUXJnaVM1RWE2b2VYVGMzZDhKeUs3TFh4?=
 =?utf-8?B?T1BqTmllaGZIQnJjcURQekNKTlZrYTZlU1RpYnNMR2x2VzJFMmptOU9waGNH?=
 =?utf-8?B?bll5Mmd6dWlCZG1IQVhnbG5oY0xnVFc2dWR1aVF6bnk5cXpwT2RRaEgxaGtE?=
 =?utf-8?B?Wm1QUlVBSUNVSlRiczRVMTQ0T1llc3IzenhOZ1dXOGp2NVpWaVNTOUhyZThJ?=
 =?utf-8?B?ZE5IbXdsSzlPUkp1N3ZDdDlxMUUvTDN3Y25CWkVlTzgyenJEcUNqQ0pCSGhB?=
 =?utf-8?B?ck04K0RkN0c1bXh2NFFwYkVoODZrOUhYeGtxSVNSTlM1WEFzTFpzRHh4YnRK?=
 =?utf-8?B?SGU2aUhIN3F2cmJTWnkybFRaNGo0NDFkS2RuRnpHaGpTSU50SUFKZitmZWFG?=
 =?utf-8?B?NVIrU1BndUhLTDA0N2txbDUxQVI2QXpVVmRLTkRMODU3WEZQcm51TjZpS0dI?=
 =?utf-8?B?RkFaNzlLaVcydU9Vc3NDU0piampob2JoV1RKNXRPQlVLQVRJK0NDdEFITHl3?=
 =?utf-8?B?U0RJZ1NjbG13N3RQUWJDeUF0RENxMEc0NnFCL0lKT283NDNxbStDeGpsblB5?=
 =?utf-8?B?L0FablVTRVpOY3BUdHN4QVA2Q1JtcjBWWmF3emtqZUtrNEJvZ0ZERDMzSGVM?=
 =?utf-8?B?RzJJSnFwc3cyVVFTb25hdHhCb3lVMURldm0xaVM2RlIwTFg0aXNMQldrSUI1?=
 =?utf-8?B?ZU1MSk84K3FHOVJvUWVVajIvTk1ka0ZjRkFSbnRWQUtvc3k5MGs3TUdGb3FP?=
 =?utf-8?B?RGw2cWJhaGpoallHam82U3cyNFB5Syt0blNaNjVxMGgzU0RadTJkYzViMWtn?=
 =?utf-8?B?Q1RUT0U3dTJYN0dvSmJIWFg1WVFOUjBCSTgrbjFXaU1ublJxT0Y0bnZqS1Ir?=
 =?utf-8?B?RmZ3YnB2N3hIMGFKMHR6UklFNnBRYzAwbnl4UThsRm9VVFhkeGthS1hlSENO?=
 =?utf-8?B?V2E0ZDEvOXREUGo4WjYxQkU4UWc5WTN0NWhxaVg1TlcwcDJSNW9Icm5Tcm1V?=
 =?utf-8?B?cjY3WFdTVTluQlovMGNhdStwejE1a0k4UEl2MUxmdnlaaGdIT2J2MWJlRzR3?=
 =?utf-8?B?SmdsRnBSck45WUhONjNUT3haUk1PMFp6cXpNTzFrYUgrWUg4OGxnYUxOSlJP?=
 =?utf-8?B?U0c2NWJRQ2VaNndKaThGK3QvS0Npb1pzWXlFUHN4dU1HRy9FaU85RlA2NFdi?=
 =?utf-8?B?azJRZS9sOVl6RWxLUGV2UDlOWm1QVEZRdHBKeGFtOW9Kd0U4bURNOWRNTEpW?=
 =?utf-8?B?cmlhRWxRSHozcy9VQ0hiQXJDWmNKR2R4VkJ2Z0JYdllLcWRFaldCQzJudVNQ?=
 =?utf-8?B?elBvUnYwamRzR2VxdzlyYVFDUVdNRjJUVG5ua09mU242dGFnRzRRdzMzUkQw?=
 =?utf-8?B?cmhDQmFsbDIwMzBGYnN3cllNYzFVajF1YUs5UnJRc2ZNWnBwb3FaWktLVlYv?=
 =?utf-8?B?cGZjOGxWUktKWGIzbWFDT3ppSGpvTEhmbmhJTFNocU91NWtzRXZrTWY4Nlg1?=
 =?utf-8?B?aFpLUkFEdm05eHZsTmx2TzRRMTNia2ZHaUtqNHFWazNsYUJ6b1IvamtFTklx?=
 =?utf-8?Q?29igwoP/wBM6xSY4HUcgWWoSY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6775def0-e516-437e-52e8-08dcb13c3a49
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB9198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:39:01.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+DNR6oh+WQaIdH6vdQ4kSESYUnGG0Dd4N28uwLv49akST7oAzfyuoy8svZ8eEdx2t1ittqtQ/rPuAcAbh4rRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

Forgot the fixes tag,

On 7/31/2024 2:02 PM, Dhananjay Ugwekar wrote:
> Fix the reference counting of cpufreq_policy object in amd_pstate_update()
> function by adding the missing cpufreq_cpu_put().
>

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")

Thanks,
Dhananjay
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 804fab4ebb26..36edae40db1a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -560,6 +560,8 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>  			       max_perf, fast_switch);
> +
> +	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy)

