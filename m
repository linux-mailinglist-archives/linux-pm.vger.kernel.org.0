Return-Path: <linux-pm+bounces-20252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A27A0966C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83AE164F84
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581962116F0;
	Fri, 10 Jan 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+O7OvLs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408920E715;
	Fri, 10 Jan 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524321; cv=fail; b=pn1KFBB7lgWHz64HrT/ReYtANRRGFO9d29BMRWMJge0L/vbVIIqRETmAAvcUh1rGOL4WP3vvzsxbSN77JZAKDujT2xXFEh+i8JnMrlnn7J0LLMcK0Mg4D6gVa724ls6rhVrguWHHoSf/BFjG7OwrurUOdVS2KRobVzr9BI2DhQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524321; c=relaxed/simple;
	bh=0UL/ZRcyqZ+WSsgs9kttBe5llh/dP+LUXbJH57vYVWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYFetu3S4pbkxM1O/qwPWzdv1CMVpMckY66PenC1vzg+haEdEgLkUMFMXXPFoLzFZu31Ly2KBhisk0diJd3PKo+ZcXJdpTgKkJ94tVEP7amiIsUrMu5Vka8cwIlTpMXv+69JItdXE6vzxKN3yyJAKBGP9YNZfYePrSNhDhdxqMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l+O7OvLs; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPsFtk3AUpzx/y4/mrNtXuxUdZRCpCq6Qsp+EsUYHzu3rslvy6i33cewq73dsobgD1G2o/5e4aF8/ZDy0JnPFoGmRyBbCM8dba7KltCyfciZrDkrATT7IUoq8SS+fIW2M6kMpWzFMTiZjRK1+akoi7+fnIg788Su3cEc2hS5ouf/5v5lqSw5/r31k7iHzbmAe2weqhnw/8idnLmM5nzso5IRLtXf3d94Ca63CmS46RGP5Pf2KML42Ld7C7oG5K6MGau/OAiGvoQ9h1W1zMJVKGXUI1fz30bRN2YqWj6YOAMOYn/8x1BpftQggiXdZyHbs+gYL+BhxfTbLgJVJmxgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfInDn+6ygk7Fp1cbLNBaO62B7GCeWClyLFvFU04SK0=;
 b=vA/fN7FZMb35PJ4X4Z7zKeqmhhz5sqkdv+PVzv09bfPUW0lQ4uAvB6xlXiUIAOWg84DPL2lJ2S+gtdIpzEbJXMKofz6fFXYDnPESAsV7/vmU+PNeG9wXKTCAr0yTNYkQpVWeTaDEdaJc6vgCKiaj83uAyvftSgvn8S5ktxmr0sKrHpj9vc47FRHvd8d5DbHsoTBIDDoCuk/K6ReKYW1nTpoFXi6r4xdzEqM0DdKgbQ7ZuhBEqxeZazoqKCltOnbptjCZQQnkBqZiYoXf9xWQvUdMFoY/lssfAC4JNs+Kvu1z500RWv3ZrOLXiteFUuqmdnAWv2RR6t5gvg/2/Er2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfInDn+6ygk7Fp1cbLNBaO62B7GCeWClyLFvFU04SK0=;
 b=l+O7OvLsjdIkaxa57H2XsODU95gIjfaDqDpjIOiqo3Et8Y9UKP8sarLRYLr/cQu6wwp5WyOYIXmdVpneek1ZJgm7k1A8XdDruy6Yp7ZxIxq6Yhr20SSpI5QwrSOEKGGnPw+QZgJTxDa041+oHWIucQUwxsRjv4Oz8V8uk801w7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 15:51:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:51:57 +0000
Message-ID: <ca98621c-bf1a-4cf0-abbc-81cf4dabc63f@amd.com>
Date: Fri, 10 Jan 2025 09:51:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Fix per-policy boost flag
 incorrect when fail
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, perry.yuan@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
 lihuisong@huawei.com, fanghao11@huawei.com
References: <20250110091949.3610770-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250110091949.3610770-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:805:f2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaf16b8-78ee-44af-6400-08dd318eb646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWJDN3llOXM1SFJUbjRqNllTcUQxQ1RWTElDamhuWGFCazBRYStGTE5YaHU5?=
 =?utf-8?B?VTV3S1RWUmJ4NEVXMTlMMnlLODJ4cTI1UHJXMVNLelVMZTBBb1dKTDR2eGJL?=
 =?utf-8?B?Q2Qvc3M2c0EyK0QreGs0eUNQYmdJS2pkK01qZktRRXZlVWZxSzM3eGdkdzlu?=
 =?utf-8?B?SEFGMS96ZklEM2F5MHdZU3pnenRnMmV1YU1WL2s1TWQzbjR4WEVBY3FHNjJy?=
 =?utf-8?B?YTR2MHFIc0F1NWxtZU0xekRMckM5NHJHcU5KNTl5Zk52V0ExOGdySmxyUHdm?=
 =?utf-8?B?RlA2UGVBNk9HbDVqc1RPNVNCT0dUWlhJamZpM3luKzZHTk5RTUZMVUpCcy9D?=
 =?utf-8?B?dHQrUVhaTk15WkxRbXRKUGxBbEdodzZsN0w5K0NpZnV6T2dOa0lmcnZjUmh2?=
 =?utf-8?B?ek5lWEhaUTc5dUtWQWJuY0tWWDZEU3BCcllxN3lkc044VGIvQ2lLZEtyMCti?=
 =?utf-8?B?MjRsUUlPZWlmSDRRdEVzT3FzdzlxVFpsa1BQTE5lNm56NHZOUTRXTkV3QjB4?=
 =?utf-8?B?ZFk5UkVwK056NzZuZ2pYLzU3OVZXaEZsNFRuT3l1MFUzb1pRaGxEaHdNRkRW?=
 =?utf-8?B?ejdacFV3N0hNeUhpTHpaTXZWWlVVVHV5dlVQZ000dk5rVzI0R0NCYmZncTdW?=
 =?utf-8?B?cmN5WjlJYW9iQkRTNWJjdisyN2VVQUErLzJLT1FLSE5RZjRFWklYUlhCeGxC?=
 =?utf-8?B?V0RsTTVwVmVJNE1IZlEyVFp4eFNDZ3VZaER5bXBHNDB4V0FEWGsya2kvNndp?=
 =?utf-8?B?dmRpZllSVDBKVElzVkFGR1h2YUpHRTBQNWNHQXpuOE1vcDFPQWlXZFp5NlNW?=
 =?utf-8?B?YUpNcURJejlUWmlxOVFCaUxIS1BIMmVObm5YYmU1blhTaCtWZEhCSE9EREpQ?=
 =?utf-8?B?OGJ5UFNWc3A2VjVUL2d1Z1RHUU5BOFhJalBBdStqcElVTG1yTkUzOVpjQUVB?=
 =?utf-8?B?ZGZ2MmVhQ0RNUjRORVRCcVEwaWgvcmtXVXBYVTluSHk5Vjh4czloYUwvUk02?=
 =?utf-8?B?NUVsRjcwVmxpdlVMdFdpSStVRlFyVU9ZLzRuOGp2bmxxL2IyQlFzUUVremZL?=
 =?utf-8?B?ZDBhV05XYWo2eWNzczNNNkgwL29CcVQzK1pJZ2VZWk43SERXQmIvcUhmUEtD?=
 =?utf-8?B?ZkJyVWJpRXB1eTlVRVp4bUVxNlVmOUdub21hcDd1MWFLZDJ1YnIxa1QzdVdT?=
 =?utf-8?B?L3k0K2hJTU9LdDd1MGFpbVNTbWJYOWtYeEJ4OCtvejBQbXJ1czJ6ZW1RTHIz?=
 =?utf-8?B?MVZsR3c3a2xWNXgwZkpRWSt3bUlzRmVWZHNVbnVxS0IyUWZqYzVyazdsMUdj?=
 =?utf-8?B?NXgwSTJYaHJXZVNPZGI4T04zRzU0OGhaZEJzSk15V0l5S1lNREhaeGk3a1Zr?=
 =?utf-8?B?VXg0TW1HTEYxcm1hV3R4YmovbER2ZWhGUXdPTFc0Z0JJa1YwRlpNKzFUeFVv?=
 =?utf-8?B?VkpKakNXNDU2TUM2ZDQ3bUdjekt3Mm5hRmpselRrN1RFSDNURUFQaEJWSCtU?=
 =?utf-8?B?UEpvditiMmVnbkN3dkdWTm1QZHYvTmxxVi81bDZDRlFFUWJHcVZ0Vmx6WjZl?=
 =?utf-8?B?U0FBVzBNd09qdG5HQ245aG9iNWxLc0R0UFluYWtUbkkxRUlxWjJKaWg0c3ky?=
 =?utf-8?B?eW5uL0NqeS9Wcld5TmxmRmpMdExEZFZnWW52V2VxWDBtOEFYTElqaEV4dVdO?=
 =?utf-8?B?Y1Y2Vk9XaW1WZzV3TTY1ejhUOU9XSkxxVFkwNkd3ODVOUlJ0QlNPbmNuVE42?=
 =?utf-8?B?WVFnUWlVUHkreVZqaHVUYmZxbkdCUGU0Ym9GckM3QnZSeXprZ3d4RVJpNG9s?=
 =?utf-8?B?S1J2VlNyTU54NDBwWkRkNGRzQnZLaTVWdWpGaGlWakxMK3Z5MGFCZEc4Nnps?=
 =?utf-8?Q?km66Hflt41RzN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjVIMGhsUitoUUVVdFBUNklJZWtscmxKb1E5WXFhU2tlSytzaXZCSVZSSEtL?=
 =?utf-8?B?Ri9WNTVNRkZOVjRiV2s5KytOVnhBbDBZSTR3aVdLZC9Ja1g1SWZ6ampZZ1pF?=
 =?utf-8?B?eVJTd0YxQ0w0SFZyQUpNUHF1dDc3TE8wbkgydHFwNjZtMzR2RVVsNG1vQ1ZP?=
 =?utf-8?B?bDJKMFR0R01VVmlsZzByWFl4VUVTczdVWUtnc0JRLzg5alNYSDJ6SldrbUN6?=
 =?utf-8?B?NnRLd2o0MVhDOCtTekRyZ3kzUUpPbzRWT2x6WWNPMGdPOGxqSkQzZzZoOGlB?=
 =?utf-8?B?TWt3MkJCZ1RKQ1FxK05mdk9zZjRNY3BjbWdQRThlUURGRnIyNWFzcDExT21D?=
 =?utf-8?B?YUU0TjFZUnBaNjJDVEZLeUlZZDMwRy8rYVRKNjRDWjU1VThxOG4zbFBsL2hR?=
 =?utf-8?B?eFdDczJ0UHlMV0J2dzJqMFdKeHhxaGpYWEp5OEpRaWF3MEpzOVR2YWJRa2l1?=
 =?utf-8?B?akk3Y0pWSDM2STQ2NHBLNGFMM2hESUE0bDN6UGdKUksrbTYrZGJ4dkk1Z1V4?=
 =?utf-8?B?TTR5b2M1M0NKdTJrck5MaENmVVJ0aFhTWGhNa05kNTNieDcrNCswd1JLRXhm?=
 =?utf-8?B?YngzZkUzR0ZXUithVFNTRU92MDRFSElmZ2Y1QjdwUVdZZmpWeGxMS1ZxSzRs?=
 =?utf-8?B?b1JJUkVxRHFmSklnOWl2MFNHS095QmZVUDJVR2Q4aC9XRnlqekRGeDVqTGEy?=
 =?utf-8?B?L2wzdWFPbmtkNDFEQlR3TDFsWk9vOWhlZXNia3RsUWIvWk41SkdvL3MvZERn?=
 =?utf-8?B?OWM2U1AzZ2tacGdaUWFaaGtZQm9oTjl0YWZRRWdBOUM1ekpSV2RQL0g0Ykx6?=
 =?utf-8?B?S053RS8rRVQ3VG9menhqWVhpSzFZVnlSNE94QlRtQUhETkh4WEc5b3RNWVl6?=
 =?utf-8?B?NXFRbC9zVHhFVW5US3R5ZTdKSCt1QlpzZDFFcGFSWTFFVkxQZ0RxU2hic3kx?=
 =?utf-8?B?ZWtPRlRYL1lEUkh1QUl6aUpNbmhMeE9jaStzQkwxcjBHamwzQkhmK3VJWm9C?=
 =?utf-8?B?dGNpWUtPOTJMb0Fnek0yMWE3L0NxZ2d5LzByRERvbnR3aWZrTFQzWG1vM2s4?=
 =?utf-8?B?SXNneUlLWmQ4bmhybEVRMzhQS2hoYmg5UU9oTE00M3MrK28vd29yaGRWTWRP?=
 =?utf-8?B?UEh5aERZcFpsdjNxY0hHRCtqbUFmL0JTS2tyWUllRFlSUWM0N3NXdE9SM0dn?=
 =?utf-8?B?NndnQlQzQzNzRlBNbThhL0w5dTB6VitYUEZiSEJNWjZKSjNzWWN4eUFEVUlE?=
 =?utf-8?B?anRDa1RkZlFQZG1YNFI3K0Q1Y3QwTWZvQUNaemtaelg3Q2Y3QjNxNjl6K01R?=
 =?utf-8?B?T0hBZ0NQMitsZEdVbGZFdzJyQmNxZWlzUS90U2NrbDBlR1gwQkFSQU1aYmVF?=
 =?utf-8?B?RHdLbHBYNHlGMzR5STRlekRXOTdPY29BQVgveW5Hb3pxMFMvTGFhbk5ncGds?=
 =?utf-8?B?M09qTHRXQWE4MkExSjZKYm1mUzBiOHRaUDZiWDhjWndmdUVsVmg1ZjBwSEVH?=
 =?utf-8?B?YStNRDh1eXZvbGplQWVOblFyOWF6VGtuK3V1ak9mT0dCVGxJNUZqZEV6ODhZ?=
 =?utf-8?B?MkxnRis1N0JrMWFQTEZMMEJuazFmVGVObWRiMUpKRW16VDROdnBmLy9ZeEhr?=
 =?utf-8?B?REdINUVnK1h5Ym9KR0tuZVVBWFZiUnNOci9hUzU4V3JiOVljTTh6M0xianpS?=
 =?utf-8?B?ZUh4VTRjZHZIQmozSTUzaFRoT2w2Q0F5bHQrTSs3aWZ5YjdWanBoWUQwRVVW?=
 =?utf-8?B?YlpRbVBwUE5NUFlsUnZIeGxmZitaYkpCdVdGUU9GK3FDalpZclF3MUVFQlVk?=
 =?utf-8?B?TVp5SWRISndrYU5ZZEgwdnJBdTFjQmNUWE9qZ2MxdlBVZ3VrSG40TFh1M1ly?=
 =?utf-8?B?YWM4UCtYT3lHWUp1amxLcVFZbHFBUHFtRjRoUDAvU3dHWUgyREFwQ3dKaURv?=
 =?utf-8?B?YjM3NHA1UFBFeldkNU5nVjJNR2hIOGNKQXRzNDE1Y3VxMDNzcVRsSEJTVVVK?=
 =?utf-8?B?SnA2MkJZOXN4bkVlWC84NW5KTjJSTEtmcUNiWFJhOVRKaUpsSDRKakxjMzha?=
 =?utf-8?B?VHFTZEpIa0dJUWJNNEdtTGF4MHpDSnhWQTNNa2l6Wi95ci92aGU3ZXhERC9m?=
 =?utf-8?Q?EGi3+Cm2kKP+99B0qhV//ovmH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaf16b8-78ee-44af-6400-08dd318eb646
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:51:57.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdsnxhUrcqVXtLfLDC2HCVsmiAWyM8m54/aMxDW0vKZP18sFrs0FLi26jJU2NwE+BVOHknEByjdcScxqQ6ZsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

On 1/10/2025 03:19, Lifeng Zheng wrote:
> Commit c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision
> boost state") sets per-policy boost flag to false when boost fail.
> However, this boost flag will be set to reverse value in
> store_local_boost() and cpufreq_boost_trigger_state() in cpufreq.c. This
> will cause the per-policy boost flag set to true when fail to set boost.
> Remove the extra assignment in amd_pstate_set_boost() and keep all
> operations on per-policy boost flag outside of set_boost() to fix this
> problem.
> 
> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Thanks, looks good to me.  I've queued this up on my bleeding-edge 
branch for testing.  I'll include this in one of the future 6.14-rc pull 
requests with other fixes.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7b1de97727a..a2573393ce30 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -747,7 +747,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   	guard(mutex)(&amd_pstate_driver_lock);
>   
>   	ret = amd_pstate_cpu_boost_update(policy, state);
> -	policy->boost_enabled = !ret ? state : false;
>   	refresh_frequency_limits(policy);
>   
>   	return ret;


