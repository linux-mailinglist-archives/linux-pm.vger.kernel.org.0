Return-Path: <linux-pm+bounces-17570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A529C90C0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1071F23B69
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6D189F39;
	Thu, 14 Nov 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGZf7D0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442B188735;
	Thu, 14 Nov 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605069; cv=fail; b=Zc8WsLtF7kj8Q49M7bv0cyrUoTPFMj1D3YDMQK6tAIPy8zSt5ZYobrpgx9xlMEmXtH/PvJiGPz96HB01Ze60X0LP+bsYaP8wtWPA/iGt9scp7Hl1dxNfhdzhFjgoGCQwfEpzHTQta1HG2SNSHUqBaYt4sNL3hbQKM6RQ9J16sUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605069; c=relaxed/simple;
	bh=N/F1eQ2mS8oBjjuNA6/HUzb0l8BhKM5tw/K4Uea/NIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cYrTNEK4DXDiOlFjyp+3bwR6yFjbKwuF0hmvkdcInLd4fxzKiDK2AX/KaOj8qVG4l+zWYX6xGzRImoMr7bNS1JRDZlSMLJHDa5KZH+nqfrDoyTYuGDR4BgE9SuGRPIQ56yTUMKkHR9FBT5IH+tfVSdiJnp2g+HmSyybA1HZB6n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGZf7D0K; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4FrFW7r0dNa6a++Ofz3izxRr7qitY1kER3aXBRqv5rTNboJnkTyLNOjZZ8ZJGW9/tv9Av+0Hi0Pr4sYkxtVT8x0XbpAPE5ZHqWGMfP3p/ZC3sbdMylCEKtxHBFJgPqwhJUglc+8XvpXa1ztyPU9JCYuQeRQytyE4XCB7CbmMcoP5bKJZsLUNSf0vtjZZsf8vbShVFpJyVo2PNpJ4dVnGDUWRbHLXnjC8X8FDu0a2L9ZZG+Y832V+wPv4EztYobSW/S/s7cUdhTyTCqhxgki4MHVqlCJ5DvSBgiq/5Zc82tRh2j87zNHtwMUk+C5TSkiKo4KVpsujxw0RU3WGIB0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7hyiWSoQ69FcQvgpMFaxRFsaTS9A62QW7Xe+6RXrU4=;
 b=teiKFJmeg1tYUAwfYUx9TEobhnD10pu57HvUpSEQ3WAXFIiQvxaZQ35PrdlTL312Mb+bqrH1dxO8SPBZaxN+wqjWIcXgelZOyd/K1Asf8DgrJp41H64npOgX23izZjh3vISh/fjoRrOOf4vXPwEa1S+yFf8AGKQ6X9EP3RHHEUSIpOQsq0hImMRmGtHQ5+ZGv9a679IU4hPoT42jggFk5hjIlYX3H/mxWIZINjTxNRlpmge1awz171m4ZCctigBHkjO/HU+swkvIx84y8ITIm4SZOKSKkV9jEtyHpBRewrylEo29ygbA+2tjJhLMtdCXU/Ke4nq3w/vP9Rgfw7Prnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7hyiWSoQ69FcQvgpMFaxRFsaTS9A62QW7Xe+6RXrU4=;
 b=iGZf7D0KwNGjBj3o+WAEetDl78gKd0DEF0QCxXfdT/u+k0EcjFNP+8bV/cdptAj4yfyO61GQwA/PY7jiJNHvlB53/LjW6OfodT2nDpqvO+REeNbt1aKATS42fmPW3srq3TSUmKprLYVVui8S1Y2PfoghHb/VBNEzwVrNCmciX8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 17:24:24 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 17:24:24 +0000
Date: Thu, 14 Nov 2024 22:54:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <ZzYyPzT4AwSkbRpH@BLRRASHENOY1.amd.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241114115831.GQ6497@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114115831.GQ6497@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: PNYP287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdc120e-0ebf-46cf-e05e-08dd04d12f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSd3HXYte9S6fnqWpOlHiuFdoDMFo/61obXRb1dE46f0ZhA2JVdIvJ8uEqn9?=
 =?us-ascii?Q?1A70VoZIAroem1C6PavkKlQ0SnTROoxdhgc6/2tdZkVr4iA6+96P8jmDwXn9?=
 =?us-ascii?Q?BlIy8rOB8IbyAfEVpuf8nwvkBZd6NigK6ImpcypPoRUuK9CL/ZYpHasQcPSf?=
 =?us-ascii?Q?h49OxgBIqdctppK6PdQ9mPcpx31IEy2Q3NtCdLl5RF2v6Wf7SJ3QOJMNSeaJ?=
 =?us-ascii?Q?PmIhpuzk3L8m9TeuT4KREoXyy32UXTskswj0SDTX5vHyEcQ9BY5XNuNEmNq5?=
 =?us-ascii?Q?OC6kFfBgvZ4RX1oNK0Gt48Johi1kYwd1pGNdfQa+Y0RrtiOJDMXe5XksnzXd?=
 =?us-ascii?Q?kHpvahTnkkNjlOFcY3n5C3blgYDglaw3m2sdBwMg7aLV5NH4Bc0KowRIh0wG?=
 =?us-ascii?Q?WIqTy/TuCESxnhXH3IBaBgQrV9uUQELMxw6D6mredka5bgapxxsOBtUgfzSj?=
 =?us-ascii?Q?oT09D73wNSjZqCoPcPVrE4d3SFkLRFlXXdWYOenXO4W8mLFrWSIVChZAqZTD?=
 =?us-ascii?Q?u2inNv5n4tFpMAydMyECo+Kp6XS/Q+J9N2qV3TN7n+puz1JmYs0y5C1Exyha?=
 =?us-ascii?Q?1hkv5AtU5lNl2duBgFBMNirNuLHyXZ7delMVzOo8dr3T1IkWGRoTp8clW+qh?=
 =?us-ascii?Q?HA9ezMITuuefNbeAJV4Rl6WzeDU6vjCvlJ7XZESpmn6SqOuObggFNAUT0hr7?=
 =?us-ascii?Q?DCprGtERaPgpv9qvuUMCnxY4p+ugXMydVGjPAQ+HbOXJx+D3vP2ZWCP7K8A+?=
 =?us-ascii?Q?Fz0wARxbbF1O7L5sNPpANfKxeHQlm6i4iSsQPy4/OICuxo0st/8by2WtDz0H?=
 =?us-ascii?Q?aZRXqeOaPqCB8tTzCIhrZoxzJajByn04UaqMR/zYeQYdMKKT7I1KZ0R8mv4E?=
 =?us-ascii?Q?MGz8izUxqIzH6Kdktc7dtDr/g5j10uKEPujaFWhP0xC3imrKRSYyPQzkrump?=
 =?us-ascii?Q?94aDP8BQaRnXPNCRKIUe9hgSWj+/IL6iABgddRYb3OsabnuR/CwIXcsxO+Uc?=
 =?us-ascii?Q?VLFKtf1LQXng+dV5xNTAEJH34q7Dp3mb7sbHxXogdCCyJyczSmxCklDA7pT0?=
 =?us-ascii?Q?OjYQ7AKPJpQcoGWOTijiwjIJJbh8GenP41VACJVWNscGkbEsoUBRot9ARz0o?=
 =?us-ascii?Q?uGU4a5sfwfr7YawxligHjuF9PhuQqVlymaCWP7UX2k2NByjNg/rmUJaYvHVB?=
 =?us-ascii?Q?deujGmkIw8jfiluq4+HK8wgAUamL+LOi97bB3TnzQ9YAJR6dAg2MV6KAMyw5?=
 =?us-ascii?Q?b/w7W3v7Pxa26J3xllrk+XbjKl7fHxIKV0wt1NZnUY5ofwUbiYVQOB1ctVd0?=
 =?us-ascii?Q?FkplAx4qZCH+kmkkyjIv7nxD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1d4sPOYv+jC6yOOCt9aq4oFdZlzZ7vSRMjS7k7Ky8V88E5ayuJsfWo+fWJqc?=
 =?us-ascii?Q?vcGdG4SKSOGL300mfwJcqp77EHWwZTlyXNiSKYKgozitUfjhPM4yFwsUgsH/?=
 =?us-ascii?Q?o/WI1jLnyoIJxQ42/Do2/TELu3aO9CpwXJ3fyKrw6+vJsQtMKk+owHSb56EN?=
 =?us-ascii?Q?086zuyvtn+D6RKd3M/8eO5TEMilRwUymc496sEjMDmsjiy7SiY+lblBaIEHU?=
 =?us-ascii?Q?72cMo7fvDicI3At9k3j2A3p7a2dbh9eu8vvgAMvIFcb7tRgd31p3g9Ur786d?=
 =?us-ascii?Q?ttpRRzlzYWaD9HsHfehb3dTWYFUESazjGZ07wvCBzT711F2f41O5tZzfDds0?=
 =?us-ascii?Q?UDWSxW3Uv44G2QHw7Fdk5ztIkkUpcO77y95aHcal9y7nB5woZQdq471I6bkJ?=
 =?us-ascii?Q?Nvqn3zzolkLebrdnm4zSJvYNFIRmQPFd5m3SkJ5L2P7T/lFrRt139F2+Tba1?=
 =?us-ascii?Q?gvfY5T52MaQ3g4oN9gdK1n4jSjZzT1o/zhZGfC7CQVN9ZBM8DUODBgqCohhA?=
 =?us-ascii?Q?LrAqWkxm6Uq12J3/8JfSyjCn3ty254N9JHkr3Mb4fCnknCBUXgMjeI5hidA7?=
 =?us-ascii?Q?0WIPjjTHhYwQl6dUehmiMhsbe8823pJxKMUh/HN9dO1TJw4Z6Meo6mZa4D7a?=
 =?us-ascii?Q?5vBhmh1WcQClO47KKocqaGf2g4lDmVKtrsEESXyPtu1v6E6WKT/RFyujXQ1j?=
 =?us-ascii?Q?AcokhvOXEJWpOyChsVc1v5h1D1Goud6G6MwQ+EOzzNDXyCbaZlS22ozrjg3R?=
 =?us-ascii?Q?ayqDZWPrrVRahsYdw/aKHh7Q5lxTOdUV8jQpDSlAXvuui7CaERheneom47Na?=
 =?us-ascii?Q?HfQtmtecMvRNaupk+5OF9NImMSOdWq62JEwfdL+BhE0aGBLYajw/gHJIA7zt?=
 =?us-ascii?Q?f0KrgP0ktIQTRsHZiWZIrh2SUC2fdeyskzEKiSgDu933dd5LzTkL/TiK2KZx?=
 =?us-ascii?Q?8tNBAK/ptloC/0uFUl2Zf1mCXb8Nrap5N9+anby97uF0N0BAlECO9k+t1xjj?=
 =?us-ascii?Q?udivcsLsnmWLyd59HoWXHMI+K4VwBfzB2Gw1dax2lfozBzBsLeb+3H28SCdo?=
 =?us-ascii?Q?ktn0HS4CL1j8zNYjjhTVHrLJBo7ue1Tmub55EFprbhrneEhA+uVBtEao+Jxa?=
 =?us-ascii?Q?8jhbFXmXj1XA/3KcBb6Bq4CTOpbweH89TxLNG8XTmbtfGV1+aEuhV3CyvI68?=
 =?us-ascii?Q?KhYczkP5L+znoeA4Mll7xiube5R2XR7cH79qTYBYM9izlYDnItTxAjLq1nVp?=
 =?us-ascii?Q?cfndqcjGUoC+bNUVxY503b7VKzOdCEsgHtRkPXtC5lA2NZ4TR8zrDZBv12Fz?=
 =?us-ascii?Q?CHlMglybNmmaEURCB7Fvlw+ZM74jcRlv4+Bpq07I8hcJ0zjvgpYXosrMQ/sH?=
 =?us-ascii?Q?scn41+H/nUcaMFPTs9/OuUPaHovtRbFc9smddSBcPEZI+wTfnE/FRbveFDJz?=
 =?us-ascii?Q?dYIuLj6HJuN5UtIEd8rK8AzNL19fmf/sRVXk/APi2DTinwnJMPY62C6T7y1r?=
 =?us-ascii?Q?NOQDdTnN0HGV8+k5KyUPBQBsBfRk4vfa7oH7Az95ksWZQLED+2T060FqYuWe?=
 =?us-ascii?Q?744BDAI7/yQBFx6ORIg4Be5d8RicyK/+NvVtU58T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdc120e-0ebf-46cf-e05e-08dd04d12f1f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:24:24.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tVFIxhzQVv7/epXxLqgCjNaFuD8uFz84dYBsQbw2Lk+PQOyN2Tn+Y1ll08g4KI97Q9POmiaiQMU8HgR1nzdCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

Hello Peter,

On Thu, Nov 14, 2024 at 12:58:31PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
> 
> > AMD platforms won't be using FFH based states for offlined CPUs. We
> > prefer IO based states when available, and HLT otherwise.
> > 
> > > 
> > > Robustly we'd teach the ACPI driver about FFh and set enter_dead on
> > > every state -- but we'd have to double check that with AMD.
> > 
> > Works for us as long as those FFh states aren't used for play_dead on
> > AMD platforms.
> 
> AFAIU AMD doesn't want to use MWAIT -- ever, not only for offline.
> Confirm?
> 

AMD wants to use MWAIT for cpuidle and it does use MWAIT based C1
state on both client and server parts.

Eg: On my server box

$ cpupower idle-info  | grep "FFH" -B1 -A3
C1:
Flags/Description: ACPI FFH MWAIT 0x0
Latency: 1
Usage: 6591
Duration: 1482606

> But if it were to use MWAIT for regular idle, then surely it's OK for
> offline too, right?

I tried this out today and there is no functional issue.

However, I would like to run some experiments on whether HLT provides
better power savings than MWAIT C1 with CPUs offlined. I will get back
with this information tomorrow.

--
Thanks and Regards
gautham.



