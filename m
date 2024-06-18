Return-Path: <linux-pm+bounces-9504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C119190DC4F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B641F2156B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB516133C;
	Tue, 18 Jun 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V6JElp8q"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E0160873;
	Tue, 18 Jun 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738572; cv=fail; b=Pc0LWJWrTmBd84fS8Tx8U5+Dm92JsOrY1mXvBAf7ihRbVfrm7BcCr8zEPDh+BPmVtfSvCuYexVwr+cZMx170P+17EVaOYGI/Su3iPvkcuElV3muulsaYcZyoa2DLfNlUZxzdIqDeOkChz8ZHQny9fIaBfh4PiD0XVoDKUpgwj/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738572; c=relaxed/simple;
	bh=rsd7TudQlxaiq23StijYyHUqWejbSXZJ7DRfTds9F5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O4+LIRUH3Q70aBF2zv/PFmGuf/+ov44Y3EBCn16Vn7xqN2mA5YNMQxkmeiL77xQvB8ZshuTVFEyuXl/ScZgtYFUdQoz1JhDZ0sorx6/ZL7PvDIlzy8alxuaqEcQw9xp//PaIB3628rB5SCFjrP/TYYLf5QfmnVfGG2OJQqWAvPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V6JElp8q; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvKNeHechEBMdAE/RvcvBvbFJmm8efyDwuR12a7N3c0wKw2/jQNy5mdt7I+AHdqa7U0BHQTUCmK7M7DVXlc497Figku/aWqVh1kck3IETIbFs1625G1nbnYC/hOUqG8Rvue08pNuu1ZHZsTpQapzxtySIi/neRdCBb29Y6HlJBWIJO5VKsa4xUOk8/bqZtq9f1InF91mGLUO/y8/gNx9RVuQE1W6Lc4YPitrQta6mMqy7E4cNttBSa00wfZBlIQrXxU/7c97NRtQNn2p0+WT1D3RROwsyFyjD4mQ8g55YPbPINh0l9FHMGaUEHia4PtlnT30W99V2XmROFza9AjZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ukLXR8rwJ2fWg6IYGGV+yQsiJaSc7/1zCK/0np7yt0=;
 b=g6EcNLUEsvePlxws+eHAGXYdAuQxQBaJ8TKEfTtlZUBlMfkIdd+W086pFnYp+VSB3gBj4eBOdCTXkhQeiUxnXIbLCznPqZQxQ8TffZfwokR/hzmsYtztU4/DDzWchWxOB+F/TnO3TwZ9TZIg6rHSsrynMj8BVR1Cl0DXToYDBjsinWxFPiphT7/QOiIIF5dvzeROawJnUsC4D2pTQ85k+8llsmB5iqgYq5M2arQV8G7PggrB6OBmCJlsj8BRTyIAO971hykPzY8cicwz3LN19hTHZeT0AH2235KIGaLyLjC8LSfiXzm+0/+u+TarMJKmn4mYhiYfeZGIfqmVQgrHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ukLXR8rwJ2fWg6IYGGV+yQsiJaSc7/1zCK/0np7yt0=;
 b=V6JElp8qQ9JcCA2l7+NOHYTfamG3wrPUm69NsoDIqgSAsKXd6U0NzBudhnrtE3JHvYZM18ZiegZJZqKA7JZDh2Q+mFK6c6TV8d5nPiicKhRiXjvw/MaJYhGD4nrefobcP8b3ACQWg0Q2zzgCDXXpJ9H4zR942s2b1IE5JIMY6UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:22:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:22:47 +0000
Message-ID: <57793af3-6388-433e-90c1-40be0b07684b@amd.com>
Date: Tue, 18 Jun 2024 14:22:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718606975.git.perry.yuan@amd.com>
 <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:805:f2::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 302137cc-bcac-4539-6b75-08dc8fcc0953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0tTTlUxL1plQXJRTHY2Z0hUUFRmSTA2OC9GTnQ5QnZPRk00NFZ6dWxXMGNr?=
 =?utf-8?B?L04yOUIvWmo5Z1lvNjRVbjdMYXRyOWsrNmhjRXFsRWlqUmt5QmUrRUNRNnlV?=
 =?utf-8?B?NTZpam1wZHYvUVF0Q1hmdWtuU2VHbGNoS2tocy9JWXkzcUpubzFvZGdnUFpC?=
 =?utf-8?B?VXBSdFZMa242dzhJbUtHTUM4cnZSU21OaWw3YlBQdlliZTVOZEkzUm1ISmZl?=
 =?utf-8?B?WGVXWTduYUtHN05rOVNiaHZJZ1RWb2RIaTU3SVpzT3hCV2M3Nk5ocktiK21V?=
 =?utf-8?B?b3hobTJCZnhTaVZwN092M0FXSkd1bloyZGJqV29SQnlvaGoydVdVallJVHVF?=
 =?utf-8?B?Ym5QbDNVMkxlS3J1bnB5WHBEY2FBWlFyU3U5elNpbVJBWDk1UFk5Smkvd3FW?=
 =?utf-8?B?VzEyeVV3ZHlPb0krWnR5M3RQN2paaDNyZkxTaXdOS1VmeDRuMXg3UUp2MXcx?=
 =?utf-8?B?Y1gyMEcyY0E4K2FFMWRrcEQ0andGT3M4SnBpY0Ridlk3dUVmU05OR0toa2x3?=
 =?utf-8?B?aUdQQ0p5OXlPUlFIbEZnQXRYSSs2OXBFMlhxWlM2UndsYVdVd1Erd1U4VHM3?=
 =?utf-8?B?a2FNNUVqNHhUQmxwRTVhWVkzMHVzYkd1VmtwNlRIN0JNVU5RT1M1OEJyYXBV?=
 =?utf-8?B?eXJxc2dCcDBtSXBiclFLVUxQU21XYXYyQ1lrTERmUndQTks2N3p0bFhBc3kx?=
 =?utf-8?B?N3prU3ZPNjFNWUtGbkYvWVpLWGRQUTNxNFpnTUhuTW1mbEhyVHkzNEY1L1Ju?=
 =?utf-8?B?bWV2S29kbzZ4bVhHUlFHUmJnUVlaOWFYL0s0WFZidno0VUVrQmtFN09nRlBa?=
 =?utf-8?B?UThrcjE5M255V0xoYzBaTkpRQlpEY29sa01JaUhZMUZVZkMycDM4bjRRMG00?=
 =?utf-8?B?YTIxVU1iSldpaHZJODNTSlV3ejJZYlJlQjlxMWRWMGZsWEJLbmpwSG5CVjcr?=
 =?utf-8?B?bkNTSFRkR29NeUR5M1F6YS9zbjZrS1U5ZTRBalViWjYxTDNXVERvUW5mRTNU?=
 =?utf-8?B?NW9qV3lMbVdUZ09JWUE5Qmgrc2FWaE9hSUg2QkM5M0RBTktYcWVqUnJyMWtV?=
 =?utf-8?B?MWJmWHhBZFlYYTZvUzNMZjgwUXZkTDNtZWpXT3ZvaE5VT2lmRnI2RW5JZE91?=
 =?utf-8?B?RG5GMTg0cDhGNXIwY0R1NVVXaEt3RWVCZmFrSXgvdmlLMU4zb28vL29Va3NK?=
 =?utf-8?B?bGZyTFFJYlNSUXkzbXZzVnMwVHgvM2NUM3ZTVFdyVlhrdEdMVXRrNUFXSlVJ?=
 =?utf-8?B?MEE4MGhZREhNY2ExYWplUFNZcDFyS2d0c1FaUzNhQk9EdVAwVGx6RHBEYko0?=
 =?utf-8?B?dlcvQ2hBNm5BczhXNUREbGxIRGovbDBLbEhnNjBmNE9OUWMyY08xdFIyem1z?=
 =?utf-8?B?UC80bGxmTkluMERBNFM5NDdlMXgvVHBGZnlTOUFsZFRSNDRvek95UjlId1Yz?=
 =?utf-8?B?UThveFB6RFpxTXhmZG5GOGZWVlJFZm5vdkxWTkN5eERkRCtkWlFzanBSWSts?=
 =?utf-8?B?cHFMaHYxWlFwaC9FRi9IbzBGYWVMUms0UjBOdG1DQkhzQU9jR2lyWkdrZXNU?=
 =?utf-8?B?dnNUQjJsUUJiY0VFdElIUTcwOEJVYU1ISXZmYXdWNW9td0UyT0MvUklhdHBL?=
 =?utf-8?B?M2Iwb2ZXWnIreDdIT0ZBbDlBR1g5eXhpV3J3TllTMHhQYTVDY1lqM1lVbzhz?=
 =?utf-8?B?U3RaV1U3ZHR3M0JiWU0vVWpZRG5BQStCS2JKYmVPVkpyZGdnU1YySHMzRmNw?=
 =?utf-8?Q?nZuS+2phZFOLvm75/0sA/yyR86TihntE4RIHjsI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVl1TWtnTUhNd3RGZWxEU3VUbEVuRzZra2JNbTg3dlhzV0VUQmdoYUNLSkFr?=
 =?utf-8?B?cVo0elVhbzArMXV2UVgrYmZqOWpsSHZvcE9PWWpjV0pDcjJyenFuSHR5dmZF?=
 =?utf-8?B?bEpwbnVSVm5sM0RxUGtFYXBycEJLVUY2S3MrK09MaFRUNklwd0hEV2ZYM0x3?=
 =?utf-8?B?bW5YUTNWR0t3eUNObG1GbG9mL3FtVURXSEVNVkhCdS9sSFA5NW1MMDhpWVB5?=
 =?utf-8?B?SnZXTlErRnNDdlVlWEt6T2JoVFRkbE5yWndKOHJrMHc1dm03TzhRL21HdjhV?=
 =?utf-8?B?Z0p6QXhGREJUL1Z4ZGlIb0pzQ1NVQ2ZndEQxLzNWRCs1T3JWbzJpdFhxZ04r?=
 =?utf-8?B?Y3hwY05xRHlMYzViN3RFMHlrdG1Pdm5GZTFHTnRRM1ZxVkZacVFmZmVUbGdy?=
 =?utf-8?B?WGNjZEZadmlRVThCb2hXalAwQXJlVVhneVg0VjZyZCtrOFJIbU5rZFROR2VS?=
 =?utf-8?B?NTRuYkhSV1BFNlRtYlY2eTFHS1B6a2xFMkprTnpDSG9Kb1ROY0tmc1haVXNk?=
 =?utf-8?B?NmNSUkFkOUphYnNHMjdWRWlFYkJjdEN1OEVESk05V0lHKzFScHBLYjE2bXA0?=
 =?utf-8?B?RUxGUWFNVXpSMFk2UEJwdWJ0UU9MNDJmOFFNZUpaYjY3bkxLbDBjd3VCa2Fk?=
 =?utf-8?B?TzJEMzNwemdRU0NGeDh1RVM4d1hvODNhaUpRa3k4RTB3UVRxa3FFR3JKYy84?=
 =?utf-8?B?WSt3cmtwVFpmMlk1T0QxZjRYUEVtK2o3OUFldkdDalN4WmlEVFhpNVhkdXgx?=
 =?utf-8?B?MG1XeXZIVnAwMWFvVVhlYlE0dDFJZDFsbkZQTXR2ak01YW4vTmRqcmhZbDNO?=
 =?utf-8?B?UmNTZjd6dTdLMGF4MEFpbGJGeDZ4UEx2cFYwY2NpWFJwMVl6L0NIckJ4WXkz?=
 =?utf-8?B?UzVmZUpMNEVmbGZDOGhPQXh2dnBDQ1Ird2tXMlpnbkgwWlkrVmIvbDc2a3pP?=
 =?utf-8?B?ck1PcVQvaHl5c0xNaG9iR1F3WjJrZjFiaHU2UGw0dkVyeHlRYnUyc1g1MVo0?=
 =?utf-8?B?NkUyQmxEZ0htd0d0T2lmOG42bGIvcUFWSGk2SU0rdEczMmUyZ2N1R0w1WDhy?=
 =?utf-8?B?MC9EWFdUUXBUbi9NOStCT2F6bi9UeG5WS3lkRTRaVjBtRFNQWEZJMWpFOTJO?=
 =?utf-8?B?VmhHNytSN084UWdORk84WTdQL2o3a3UwenU5S0pOYUlHWkZsMW9aOWNJUlNX?=
 =?utf-8?B?Z2hZOU53aGlIQUIyV3hZa2J1WDQyaWZudDdwdWlLODN2TG00bEpkNGk3R0lR?=
 =?utf-8?B?U09mK1llL1NYaWVFdXZxTWQvUzRHd0hWYnBXbUVoS0N0Rk9VL2N3eEVCejcw?=
 =?utf-8?B?U2Zta3M0L09FT0N5c0t0QWZYdHZCSGFGc3dDYW9Tc0IvbktHYitJWEttVHRn?=
 =?utf-8?B?VjBYWExnOG8xVXVwbWU0Z1F2bHdSTEM2SjJXRlhOWjJwSDd3THVrbnNYS1h5?=
 =?utf-8?B?akhGUXNPUzNTZjUxMVdkQUJRVzd0VFF6VWNzMWE4ZDZNTG81Z05xVHdoZVIw?=
 =?utf-8?B?WUliU1kyWlBpVUx5U2dINk9VYnkzeUFFR0szMzFLTk94YUd1aldqeVI0WDV6?=
 =?utf-8?B?OWpZUGViWGJVNXhHY2t4L3h0ZnlZRjZ5T3kxd0hvQTZLcjIvNjl3TTd2NWsy?=
 =?utf-8?B?azcwVGZnRGMrZVNUd0Z3RmxwZzhsUWVld1d1MUZraFNhWmdEYllCcm12bEJ4?=
 =?utf-8?B?ekQ4OGF1cTdhVFlTYm5Scmg4SHJ5alBmK25yOG9jalhpK0dRU2JhbGdZUGI1?=
 =?utf-8?B?RnlKYVd1Z21Ua1dZUkFnUTRiVXE4aHgxNEROcDQzZEEvN3NZN25GOXVIb0ZI?=
 =?utf-8?B?c1NITVRNejJqWXRMeTczVzhGbElFSHVCNVNXcHdCNjhaL0dNNkRySzdvcXZT?=
 =?utf-8?B?UUU0NjVuSkRFRkcrUDh6NGFDRWRLNHRRMDMrZXVYSEE0K2x0dHJGRHFrTWVs?=
 =?utf-8?B?a0t6bVFMWlh3WjYvRmNpNW9ncGhYd3lodVVkd1l0b3BTd3dESm5QSFJKSS90?=
 =?utf-8?B?UEJwT1JyQTlVK1ptQytyYnlJK05hZG9jSXRmdThhekdISWd3ellPWWJKN3o0?=
 =?utf-8?B?V3l6RlppbTRLRHJoSFc2eTl0SlU0MUkvZmhnb3BQMkN2KzBNL2hTSGs0WkpI?=
 =?utf-8?Q?VHw7O9gLM4qB5+BxwvMFFgW9D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302137cc-bcac-4539-6b75-08dc8fcc0953
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:22:47.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5cxn+K6sVuh1z3KyvXntNH2shPcVVpDrJpSviE4XWixcfKcT2wzyNBxzgwMXuhb7z6Nr014kNPOuYYX22t98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

On 6/17/2024 01:59, Perry Yuan wrote:
> Introduces an optimization to the AMD-Pstate driver by implementing
> a heterogeneous core topology for the initialization of the highest
> performance value while driver loading.
> The two core types supported are "performance" and "efficiency".
> Each core type has different highest performance and frequency values
> configured by the platform.  The `amd_pstate` driver needs to identify
> the type of core to correctly set an appropriate highest perf value.
> 
> X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
> processor support heterogeneous core type by reading CPUID leaf
> Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
> driver will check EBX 30:28 bits to get the core type.
> 
> Reference:
> See the page 119 of PPR for AMD Family 19h Model 61h B1, docID 56713
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   arch/x86/include/asm/processor.h |  2 ++
>   arch/x86/kernel/cpu/amd.c        | 19 ++++++++++++
>   drivers/cpufreq/amd-pstate.c     | 53 ++++++++++++++++++++++++++++++--
>   3 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cb4f6c513c48..223aa58e2d5c 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -694,10 +694,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>   extern u32 amd_get_highest_perf(void);
>   extern void amd_clear_divider(void);
>   extern void amd_check_microcode(void);
> +extern int amd_get_this_core_type(void);
>   #else
>   static inline u32 amd_get_highest_perf(void)		{ return 0; }
>   static inline void amd_clear_divider(void)		{ }
>   static inline void amd_check_microcode(void)		{ }
> +static inline int amd_get_this_core_type(void)		{ return -1; }
>   #endif
>   
>   extern unsigned long arch_align_stack(unsigned long sp);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 44df3f11e731..62a4ef21ef79 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1231,3 +1231,22 @@ void noinstr amd_clear_divider(void)
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


Did you miss my feedback from v3?  I don't see changes for the return 
type or for returning CPU_CORE_TYPE_NO_HETERO_SUP instead of -1.


> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return -1;
> +
> +	return cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_this_core_type);
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cb750ef305fe..cf68343219d1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -52,8 +52,10 @@
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
>   #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> -#define CPPC_HIGHEST_PERF_DEFAULT	166
> +
> +#define CPPC_HIGHEST_PERF_EFFICIENT		132
> +#define CPPC_HIGHEST_PERF_PERFORMANCE		196
> +#define CPPC_HIGHEST_PERF_DEFAULT		166
>   
>   #define AMD_CPPC_EPP_PERFORMANCE		0x00
>   #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> @@ -86,6 +88,14 @@ struct quirk_entry {
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
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
>    * with community together.
> @@ -358,9 +368,27 @@ static inline int amd_pstate_enable(bool enable)
>   	return static_call(amd_pstate_enable)(enable);
>   }
>   
> +static void get_this_core_type(void *data)
> +{
> +	enum amd_core_type *cpu_type = data;
> +
> +	*cpu_type = amd_get_this_core_type();
> +}
> +
> +static enum amd_core_type  amd_pstate_get_cpu_type(int cpu)
> +{
> +	enum amd_core_type cpu_type;
> +
> +	smp_call_function_single(cpu, get_this_core_type, &cpu_type, 1);
> +
> +	return cpu_type;
> +}
> +
>   static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>   {
>   	struct cpuinfo_x86 *c = &cpu_data(0);
> +	u32 highest_perf;
> +	enum amd_core_type core_type;
>   
>   	/*
>   	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> @@ -370,7 +398,26 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>   	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
>   		return CPPC_HIGHEST_PERF_PERFORMANCE;
>   
> -	return CPPC_HIGHEST_PERF_DEFAULT;
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
>   }
>   
>   static int pstate_init_perf(struct amd_cpudata *cpudata)


