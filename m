Return-Path: <linux-pm+bounces-43117-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOnrD0xxnWmAQAQAu9opvQ
	(envelope-from <linux-pm+bounces-43117-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:37:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F225B184B71
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 658F3304F557
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E636D4F0;
	Tue, 24 Feb 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnB0yAWe"
X-Original-To: linux-pm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7E36D50F;
	Tue, 24 Feb 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925798; cv=fail; b=JBvpL7HI1hYulKqLCgOxgrMZa0Or12xMrqEF+4wtyB5PkDKH7O8t6qU0yVh2NuKTbQnDFjwEwtxDf4Yd7mzLuD1RVUUzAROwvVYSGPAzuQbW4qmjAfxgsyGrXnrb6BzPvH4vQY4F0mvlyAsjdVdjxmqPYRBHfycfzXmlo8j7Xac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925798; c=relaxed/simple;
	bh=UFF+Ar+ddVdDeYOgyA25e3vDDDLsYY0R2er+zmyEuSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5JdS0z5OqL4UEGrSG2N0q2TzSU7D9HG036fLLn5+ad8OWkpZ2rKH8UBFqNuUQS/GaM/fHFHOF1Btzf+C/6JZHzeNHtHxPwAjTu9enOsvN3gZZn+9azX5+wImp3YklrmXI5nzQac9IEiYwib+/WaYohkvrpm6hQPvB+wtA3WIsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnB0yAWe; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbgVRvzV6yqXMRKRQoxZm9yKzrfEzkwXTE7uOUx2mY0G4Ob7BdNG8d+Si0G4pRv6JeLoCmz2D3beyBkShM6rlfKlpD77AVUJmPrg3FYgS0V1IOtxY9Lualoi+D+kkw0GyLEHinHu2Z7zutsgbfVD7lkr4zf1z69J/5oi350R/8VCJLvvs6Yq8rVcmHNNWbeoteDF/xxSEZyZQ/EVgMnUn07Q2JUc/tMF6ApYVKnVoi5U55KLQeHngEIohAYEnRY9KZJrIo2c+XGUXiqyKwswY8+GbF1GqfgoJMA5EiD43/I1lAO6ZqqUaBZkaBIS2xHrh1OgzcJviwagc98GHDoQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5RxqzPIZRbdR1vQBi9gJb7SRx9jUuwSe2KfVpJKCPM=;
 b=t4lYaACBUSitNO9OZ7G+s/mT2ZIAu8mN5DYPGLgYsiPizv7u9GrQwmAkqiC71b1gnU1cDJpfr0yXNgkj7MHiWT2cIbWZMe/EXg9kWxPPbTZEkTQFv++CX4Aw3hmknH6hxMJ3mKDlTIKIM1xAe6fagBM4vgIUzJGxqWq//ise9GpxYaL7ywst/tzjuu3+jNW3FzFLFdR44TsbQKrYNQntRwSD5/XvENKjdDeErAgWmoB7miFfpJ+I3ZPPwABWJMHsjBX0QK41zqD31IOxYjfEKT9/vXzGiXwoRzS+2jQ0E65W5OGPbzyb4NI/tP+ymSLBOVk00r1uhBet7t3l2OXLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5RxqzPIZRbdR1vQBi9gJb7SRx9jUuwSe2KfVpJKCPM=;
 b=dnB0yAWeHuOo9loOn90P3pEIQ3vmxnQ2OiWFRBjFzwstWmXujo4cg+TAGBrEW4/WHKTwbjrsY+yjnfymoG0v9lmcgiWpA88Wn22BTgXvwxcmqmkPv2NwaFPjq4iFCpxHJJ3tWSSVCgs/5sxSRvV/WpjNpkJsK0An0hqZN8nX1YVDF7D1oG2w/yGkPIXUsuCdrNsgiQnZFOZiowLc05FOgWhyb7vFEZbqpNxNvf3TGfQ1gOXomNph7wJdFX2Rq5r8xEa5cdS1uRAJEuyr/jY+sfgsLkOSO0EfYAgVlO8AL7ZdCheFtcEUnP0nn+3ChaQBbBV8RVIsn7dmJ6J6L4gGXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:36:34 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:36:34 +0000
Message-ID: <82521edf-27ce-4f8a-b283-ea0c5943bd35@nvidia.com>
Date: Tue, 24 Feb 2026 15:06:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: topology: Fix false warning in
 counters_read_on_cpu() for same-CPU reads
To: Jie Zhan <zhanjie9@hisilicon.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, zhenglifeng1@huawei.com,
 viresh.kumar@linaro.org, rafael@kernel.org, beata.michalska@arm.com,
 pierre.gondois@arm.com, ionela.voinescu@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260127080700.3565546-1-sumitg@nvidia.com>
 <3c6d58b2-b4c9-4dc7-a705-b7626e127f33@hisilicon.com>
 <aXoJUYDrhuJgkXEr@willie-the-truck> <aZyciAy8zCvrvGB7@willie-the-truck>
 <b4c98160-e6b4-44a5-9396-0acc8334a39c@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b4c98160-e6b4-44a5-9396-0acc8334a39c@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c803258-5e2f-411f-9a8f-08de738832d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkVQb0xhL2dQSURVQkJEYXk3QXFoTnhucjVTMk1IU0VYSGQ1Z3JlR1Jzb1Fj?=
 =?utf-8?B?U2V3SUp1cmRHZVR0SEIrYkpTOEpGKzNXREdJd2RIalA2TXpkQkdXSXZGQjkx?=
 =?utf-8?B?SUJqRmNDUTFUQ0trMDN6Sy8weVZsUUxVOFAwaVlaVlFUQ0FhWHAwa1NGZUli?=
 =?utf-8?B?SlhpOWhsYkp0eFFSb2E2U2FJVjhGR1dtd3ZDRXpsWC9QU2Z0T0pad0hMMFpE?=
 =?utf-8?B?THl2RDVKMmZETWxpSnluaFdsNmJIS0ZSSVFuU2ExWVFDRWZHRENnYzFlcS9M?=
 =?utf-8?B?VWdDZ3dIeFd0Q25tYWloZ0l0RHhqeGFyeHhaU1ptbUVjSmtHTGNVcFVETWc4?=
 =?utf-8?B?dGNiSUpDcDV1VWhYcU5aNFFlUGs5Nmtvb3ZRZ1ltcU0vYnBsdHN2aGNGMEFY?=
 =?utf-8?B?QVBaQlBzZ0s4Q05NcUM0OTF2aTBPa3pLaE45OWpEWTRsMElIaDNEZFpnUnJr?=
 =?utf-8?B?NEpmYkJYSE1HSk41eFZzNDFxbThmVGYxNSs2QW91QXdOVmpZTi9oT2JBcGl6?=
 =?utf-8?B?ZnR5OVlHaUFpd2tDdmFaVUQ2bzJkZS9weDQwazNid3JhV0Q4OFMyL2ZLS1Vp?=
 =?utf-8?B?clhtU3VybnlaRnBjL0FMVWlqdGlCNW11MW1reEVlQmxtNndmZ2xrN0d3TnBC?=
 =?utf-8?B?TTJmb0d0VXEwbEhwdkxDZzFiRDF2SnJyS2V1TGR0NVptb0dueVlWVnBHV1lV?=
 =?utf-8?B?SEVacnlBTmVOUXFUb09nNGEwZkNmdHBQVldvcHhYQi9hb1RLQzVsRnM5eWgy?=
 =?utf-8?B?WVR4di9CTE1QY0Ntb3NHKzNHS2hBYWswR3lVMENXcmYwZThIY0Zhd044VDI3?=
 =?utf-8?B?SWdkdFlodlVhSWU0d3FRS0l6cFUyalZnYVp0WmIvVFMzcS9rM3ZVTjVJd0xy?=
 =?utf-8?B?dURaVk5ZMFI2Ni9DMk9PNWw4M0pHRDF2dVYxNVFJV1FIWTYzSlYrWGJ2ditj?=
 =?utf-8?B?Q1QrbDNRNnM1VW40bHlGV01lUFRpb1ZTTm5TUTlVblJIOHNQdmNrNUNUYVBU?=
 =?utf-8?B?MVd4MjdXalB0TUh0UjR6Y2hnNUdLMFF4NjlXaURDUmdwTklnM1p3QmpOaHhB?=
 =?utf-8?B?Y1MyNEVmK3RDRXExUE1ydVExeG5UcUtFbmRCUENwcEt3cFdGVEUvNXJ3Z0NB?=
 =?utf-8?B?MGxteUlvdUlHN09ybHN4NnYrK0JLelBhbitWY3FUbnlCdDlxNVJYNXpqbU53?=
 =?utf-8?B?b0grbCtGMFlET1laK1Fzc3Bqd1ZRNXNMZE1wcy9CdlFzMjBYclcrSDZ0aDVa?=
 =?utf-8?B?OTZLNWg0VDVYTTRvUVdLV0c5VSsvK0NDSHdBbE1TMWxNNllYQkR5VzlDek5Q?=
 =?utf-8?B?OTdCcFdiM3pwbzFWTzh6bWQ0S0FUdGFuVlh1ejNYc0M3YXZwY0pVME9MOHhI?=
 =?utf-8?B?ZkdocEw5M2U2SnFwVVBXd0d2eUFBbkJWc044c2pERzA0c1JNaE5Obnp2UmFD?=
 =?utf-8?B?RnB3cDR5NnN6NjEzQnFncXBsN25SRlVDUkUzQVZyMzRLMjM4ZUx2V1Nnd2Q1?=
 =?utf-8?B?WmFpUlFDOTVleUxhYUFvL2RBTzd2VWtPSW96ZWxSSmUvT1pWUjhZbXFTRmFV?=
 =?utf-8?B?R2QxdFArWm9CQzVqN0RlY2hydWs3OXoyaDVwYzV3Nlh6a2RzZFRGOWJlbldT?=
 =?utf-8?B?VjBmbjM0ZUJVcDdCVE1pdjFnOFdxUVRqSi9xM2c4d0N5R09paFFtZ3FWYWRS?=
 =?utf-8?B?WXlnTWFqQ2lXclgrZ0U2aDhLZThDWksvaC9PYTdRcENXR0Z6cytzTXZJK2VN?=
 =?utf-8?B?ODV4ZDdKdGJvUzRSTHRyVkFjMEJpTU0rZ1R6aWQ1Y2ZwazdkTmtFb3A3aWtl?=
 =?utf-8?B?Q1VGNWFCeTdsYmNGUHVUUlhZbms1VGZnUzQxTUdkN25USWxsNEZ4UTdSZzF6?=
 =?utf-8?B?MXplVU1MTmVqNjdGQVh4MXVybXFjRjIrUHpTa2czdXY3L1YxN3RmU21MVEdw?=
 =?utf-8?B?Y3oxUW5FZ1ZrUWpObUdHclVsMVlIK1BOWlgvejVkMVlDVU9aMENDYXVkckdW?=
 =?utf-8?B?RVkvYzcxQ29Wd3p0MFc2bFg0YnpxYVZ0NE1NTE5oSlJETnl0bEdJZW5MVzlO?=
 =?utf-8?B?c05Nam1UYkMweS9VWnZ2cWtNOE1tb0xYUFlhRlhXdDlac01vQUdvdUpzWFg5?=
 =?utf-8?Q?/fkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05pZnJwVGFUa0JOT0YxWE5sTmtKcFRyQVRqZzdueFdyRzVEL2M0Z2FpaFRS?=
 =?utf-8?B?dG5xbjJiWmZUWnhXbGZUSkQyRDE2bG0wTExoZXVpNGVENEtYZWpHVkZTN215?=
 =?utf-8?B?VDdRcDB5UitpNWR0ZlJYRnRweVo3elBzaUIzSnI1VnVRcWNqTzM5VlNobmtJ?=
 =?utf-8?B?Y1gvNzJuRHpGQ1NHdDNLQlFsbUlwWjNzSzZYR2JtT3VGV3NnMm5CeGk4S1lk?=
 =?utf-8?B?OXdzWm84L2VSQkppWVYwbXJaZGpyV1hmbWNCYWtZZ2JTM0hTUGVhMEZDVGZi?=
 =?utf-8?B?ZVcydnNhUDVBUEx4WnFEK2FmbklZVTArV1ZiQ2UyOW1FLzlSWVB0bGkvcnFm?=
 =?utf-8?B?bnpBdCtJS2x2VWd3RDNoZjYxbkh4amZ4QmVHekJ2b3hkM0V4YkY1V3dBMi8v?=
 =?utf-8?B?N0dUVUFRMlhISnNxaEVDQ0pwR3JhU2Rpc0JIbzFHT3gvMFVmQXI4WERoLy80?=
 =?utf-8?B?V1FCMDFjREpWMkFaa09NdEtkdm9IRG42T0ErWWVJaDM5d0VsSGxxc085eVFB?=
 =?utf-8?B?ays3ekhmYVRoSVN6VHJMMXlhdzFKeUF4UmtnTjhYaHZsWVZFQm9ydURGRjQ2?=
 =?utf-8?B?OTBYV25TeHM0dXpFZFZMQTF3eDlWRUkvamJ6QTczOHJBeGczeFY0K3FqVldo?=
 =?utf-8?B?a3B6U3RQTGJiV2ZweVhLcTdyUjBYZ1lMQ1N6YTJwNktmSTBvNzAxOCttN2ZC?=
 =?utf-8?B?ZWFtUnFnM2hJMS9JQWZTaUtTZU9pM1F2VFVRR2ExK0tTcjlBNjVVaWtmVHJL?=
 =?utf-8?B?dStVZXgwck1oRkVrR2JzRC82VlcvSkMwWGw2VWUxVnp0V1B6NjRvQ1RMYVdO?=
 =?utf-8?B?dW0rK01OVlMyUEF4TGxQcnNPekpvQXlLZXZONWNiSElzVyt2eWszRkRCa2Vu?=
 =?utf-8?B?M0VBZjJCN1B3Wk9MNTBPMlFYNWNsRWx1VnB6ZjJoUEFCOVp5Vk1MTUE5U2lo?=
 =?utf-8?B?S3NnUUJmVzI4U2RGZEluVVpUVlBYd3pZSnRyNkZxZUp6OTYvbVFvNk9mME9I?=
 =?utf-8?B?Q0M5a2JBQkx2UU40Z2dSYXR2RWRIa1NYcEdlTzNZQ200SWovZjV0WVpGbHlJ?=
 =?utf-8?B?d0svc0tTSUZXWU1IWEVZWHJvOGFuQTZodmpEZmhNaEpGWnRsZ2FYRi91TEJO?=
 =?utf-8?B?SGpBUk5uYjJWZElFd2NmWWhSd3ZwNVlXejRTZTJNUlF5dVNLRHB2S0lReTds?=
 =?utf-8?B?Q05UQnc1SElMSGI0Nkc3Mm1CL2J4Y2JxbGdMd0hUZE1EM3ppOGJGcmR4Q04w?=
 =?utf-8?B?T3Q1bGlJSjJCS2FLa1k0UXF0NmRWU3J3RWFLOHE1YXROUEFJQUZMdERHZ0Fn?=
 =?utf-8?B?V0Fwc0JvanAxcWlKdHM4bDRkaXBEWnNiWXRmYno1RVJWenBocDFNeFNSbGRV?=
 =?utf-8?B?TjZySlZLOHF0ZnhWNG42ZzErbjQva2VXQmRkRkl2WnlvVFhWaTJOL0xMT1lL?=
 =?utf-8?B?OFpaQVd2Vjg0RE5HRFB2ZFZySHovclBsekI1bjIxNDM2c2NPcS9iTVppaXE0?=
 =?utf-8?B?bFVjbGI4RzlEMStQclNCekRBRXpXb21WTEhBODdzOWk3Nm5UeEtFY25OeXlq?=
 =?utf-8?B?WlVwTmQwckRJQmpKcGZHSS9udVoyKzFrRFpLOGRLNHI2eVFhcFMxRVYyTkdE?=
 =?utf-8?B?bXBWY09WbmpRSnZMQ0owNWRHdkR4djlwQmxaZCt0R3dFS1dTM3p1WU80WXBY?=
 =?utf-8?B?dXhIM2wvWWpMWVJNbjc1UVFJTXBxZDhnUDNxNzhtRE5Xd2gzZUhJUUtIeW5G?=
 =?utf-8?B?aWZoUHhIL2lhVEVTbnlpY1RrS3oyUmhYbWcxWVlCOU12d3oxOXdHMkJIVm9R?=
 =?utf-8?B?ZDlnYVVHMDFKdFovM1lNMC95bGxYZUVLcG1DRmpYQzNWeEpaSmh1RFZSYnVN?=
 =?utf-8?B?RUw0YmsyUlJYQUZSb0Z2KzArQURQWmI4YmZlZ2lIeS9aVXlOaFFkQVJvZnVD?=
 =?utf-8?B?VmtxWmhDYUkrTExjYkpORG93dE9jaXl4VmZPNHpmdko2UVdNb29SM0NWMzZS?=
 =?utf-8?B?a3JkL2pQZnUwcnYrbzNicU9pT01YbkxFd1RuYXlxSHAvUklsc1lnWG1FQlBh?=
 =?utf-8?B?ZklkNllWelY4Vkl5RXVuV0lkK2JRcFNSR1Q3ejl6M1hoQUNMVVFMSEdOT2R6?=
 =?utf-8?B?Z1FkR0pmaUJLMGswMEF4SHlaTU83VTZJZnVPd0VwNmo2TDR5bVREWkZuWGw1?=
 =?utf-8?B?Rk5TOW9taGhzU213V1dydUF3QzVsdTFJbXl3YUZxTE5EaS9xZmRlRlJrQlND?=
 =?utf-8?B?RXZ5eitValUxLzdkNExFbmliZFhwOXg5VCttYnZVR1ZGK3ZGYVBrcnRKTUEy?=
 =?utf-8?Q?Iit2e534vt83UPRxnX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c803258-5e2f-411f-9a8f-08de738832d2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:36:34.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gwb2+3QkiFoNXshfJSsvLzoKHBLDAjqlNnw4QFJgoerv99Fo6wGpK9jIPNbzHoBqbdh6+1gyo/+j8p8T1dcvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43117-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hisilicon.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: F225B184B71
X-Rspamd-Action: no action


On 24/02/26 07:12, Jie Zhan wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/24/2026 2:29 AM, Will Deacon wrote:
>> On Wed, Jan 28, 2026 at 01:04:17PM +0000, Will Deacon wrote:
>>> On Wed, Jan 28, 2026 at 06:50:42PM +0800, Jie Zhan wrote:
>>>> On 1/27/2026 4:07 PM, Sumit Gupta wrote:
>>>>> The counters_read_on_cpu() function warns when called with IRQs disabled
>>>>> to prevent deadlock in smp_call_function_single(). However, this warning
>>>>> is spurious when reading counters on the current CPU since no IPI is
>>>>> needed for same-CPU reads.
>>>>>
>>>>> Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks
>>>>> for non-PCC regs") changed the CPPC Frequency Invariance Engine to read
>>>>> AMU counters directly from the scheduler tick for non-PCC register
>>>>> spaces (like FFH), instead of deferring to a kthread. This means
>>>>> counters_read_on_cpu() is now called with IRQs disabled from the tick
>>>>> handler, triggering the warning:
>>>>>
>>>>> | WARNING: arch/arm64/kernel/topology.c:410 at counters_read_on_cpu
>>>>> | ...
>>>>> | Call trace:
>>>>> |  counters_read_on_cpu+0x88/0xa8 (P)
>>>>> |  cpc_read_ffh+0xdc/0x148
>>>>> |  cpc_read+0x260/0x518
>>>>> |  cppc_get_perf_ctrs+0xf0/0x398
>>>>> |  __cppc_scale_freq_tick+0x4c/0x148 [cppc_cpufreq]
>>>>> |  cppc_scale_freq_tick+0x44/0x88 [cppc_cpufreq]
>>>>> |  topology_scale_freq_tick+0x34/0x58
>>>>> |  sched_tick+0x58/0x300
>>>>> |  update_process_times+0xcc/0x120
>>>>> |  tick_nohz_handler+0xa8/0x260
>>>>> |  __hrtimer_run_queues+0x154/0x360
>>>>> |  hrtimer_interrupt+0xf4/0x2b0
>>>>> |  arch_timer_handler_phys+0x4c/0x78
>>>>> |  ....
>>>>> |  CPPC Cpufreq:__cppc_scale_freq_tick: failed to read perf counters
>>>>> |  ....
>>>>>
>>>>> Fix this by calling the counter read function directly for same-CPU
>>>>> case, bypassing smp_call_function_single() entirely. Use get_cpu() to
>>>>> disable preemption as the counter read functions call this_cpu_has_cap()
>>>>> which requires a non-preemptible context.
>>>>>
>>>>> Fixes: 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
>>>>
>>>> Looks fine for me except for the minor comment wrapping.
>>>>
>>>> Thanks for spotting this.
>>>> I may have missed the warning log in the FFH test.
>>>>
>>>> This happens during the short window in cpufreq_policy_online() between
>>>> driver->init() and the CREATE_POLICY notifier that gets AMU FIE ready.
>>>> After that, CPPC FIE will be stopped.
>>>>
>>>> Ideally this can be merged together with Viresh's PR since the CPPC FIE
>>>> changes are there.
>>>> https://lore.kernel.org/all/j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p/
>>> Right, looks like this should go via Rafael but if it doesn't make the merge
>>> window then I can pick it up at -rc1 (please remind me :)
>> Looks like this fix is still needed. Please can you post a new version,
>> based on -rc1, so that I can pick it up?
>>
>> You'll also need to fix the SHA in the commit message and the Fixes: tag,
>> as 12eb8f4fff24 doesn't match the upstream change.
>>
>> Will
>>
> I believe this goes to Sumit because he's the author.
>
> Sumit, can you update this patch?
>
> Jie

Sent v2[1] with updated Fixes: tag and re-based on v7.0-rc1.

[1] https://lore.kernel.org/lkml/20260224092714.1242141-1-sumitg@nvidia.com/

Thank you,
Sumit Gupta



