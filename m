Return-Path: <linux-pm+bounces-7791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3098C4BCB
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 06:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24591C23030
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 04:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F85171A5;
	Tue, 14 May 2024 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aaSzbB67"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05114A96;
	Tue, 14 May 2024 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662270; cv=fail; b=FV5BXrgpADheGIJQddVVdlQd04atEFDq4x3BJAIjR7jGsYSV2quxTbSwsrISfnrFbkk/mEkCdD0Zm7sRpXjTIkVWBTD1kAfZ2vl3WHuZOwD4cpu8Amm3ay5hGaHXty5ArU3NJeBX8vgOEFID7JSZF/PmcVC7vs460Q7no1Ne8t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662270; c=relaxed/simple;
	bh=ER0Mc+NOt22QbTe2QJUj85fR5w5Bqij76lEITNnWHQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XvgCQENaWRJOkUzsJzElVYInXWAirxpgrjRjDEkMJTmtYNgHQe7qAe4Ix6UdrKwNSSuDl21itm+ext2SCmbcb2U7Rk14ogL44wuR8lEBsvCqAB8zJy9cgrG58GbrKasMODJRS+xURtMHDBoAIEWAUPvh1vCgoCr6BGBqhDib0qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aaSzbB67; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/KDsQsjpdsaYq9ZnZAXnwY4EJYVvolFOyNAJJmuKG7a87lcxmqR9YIgvXrJWq37JsW64IlziO5g+KlwrH3pJiwny59JE7USwihMneuIbmnoMQrgMvquSeUaRqSAFrLYM1ZutBNBT2Iaxu3MmPJ5/vYNp7NlS+ou1Eioi00sYTQEHdGlkXuhkOgRxnexfQet+lFQ5v4QiCDLeRvyjBg6cLPGVEInS1y6vFmtM+dRIrPN+lulC6zQcoSJ2xDBTtqnhZWFDNfwG7vYlfdzhrTImjvQY7QOF9aEoLO2oUaSzolWRN2Ctg+lTetruUzB/+jbO+IYRcOTLB/QSHP6NtQc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNx01ljHD9NkfEfBFljSsYD0Pyg5Njr1zEXj7Ukjua0=;
 b=CQ39CAGYBcOf2axGJAsZDYwFsVNb0FnOIrpSMpvyjG8Ne6/Gz0WTRiMzI1WtI84ujM4MrEBkVkPPpRM8zb6VhdNuJvA8wfk69ETR6yCmoQahhECDBa/GjpWqOHd9YpOU+XhK6Ry7mB1EtQBef8p9eEcQrhjE5zCXmY/IuqgcLNc46KtORPt6B7YgfISM1LzMd+LjD2JqdAWnBy29EzuU7GUtyCfla8JZOn2b+sBRFvMw4NvJm946hEp8byV8uG8PUNwcwlpCexn+LtHVQFT7vqqP4WdmqdtJmEkvITF71ZzC4yfAdDQitSkQ0cUTnFtPpNGYsd5A/2TehS4Z6ywU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNx01ljHD9NkfEfBFljSsYD0Pyg5Njr1zEXj7Ukjua0=;
 b=aaSzbB67HL6csk5o8UBJNyoMi76vsRRwVKwdimsC4SUW2dPQSaMDwBlKic+D+Inft/KsjTx9Wc3RpwA1FPVxNA9emKjY9CNdmOyB9A9wzgna9IwHpM8JfvPkqCqPPXWFnGPmVoKeegpNMO7/Z97lB1gAgN+aD3rhIDTA/3h30s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:51:04 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 04:51:04 +0000
Message-ID: <85302e25-0eca-42d2-bee3-733b608bb33f@amd.com>
Date: Tue, 14 May 2024 10:20:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] cpufreq: amd-pstate: optimize the initial
 frequency values verification
To: Perry Yuan <perry.yuan@amd.com>, Mario.Limonciello@amd.com,
 gautham.shenoy@amd.com, Ray.Huang@amd.com, Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, Alexander.Deucher@amd.com,
 Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715356532.git.perry.yuan@amd.com>
 <c7bce101b2d7d107ba3c89779fe6800060e8edc4.1715356532.git.perry.yuan@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <c7bce101b2d7d107ba3c89779fe6800060e8edc4.1715356532.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: b531636c-e2e8-4c5c-fb9d-08dc73d1759f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzg5dHh0aFJOMVBRcEY1aE9UUUFTejVzemFkMUV5K0hVc0NuNWYxV1FlTjZL?=
 =?utf-8?B?eWhKN3JudXROMzhFbkxDUGFhTmtQVjNPa1kvaCtmU0E5dFVMYnNWdHRnZldu?=
 =?utf-8?B?VHlnYm1sZUJOOWI3TzhTT1lrRGZtOVBtM3hNckEyQ2VvMEErRTNqcjRoUUd0?=
 =?utf-8?B?QkVIV2VEUldiRGFPMEx3a2dlc0hCQ1p3ZUcwUTB2VTZWK2ZqUWFja01XUTEw?=
 =?utf-8?B?Y0M1TEFhZXhLMkNiRzNYNEtTTHpZWFYwUERBMU1JaDNMYzc4Z00zZzlacVdr?=
 =?utf-8?B?cTNxdi9BWHd3eXpBNnBpckVTVmd0dzlVVE52SEpnRUUxcUVEclBHSi9ZSlhl?=
 =?utf-8?B?WEJ0RGRXcWVIbkJqSSs2K1NPMkg0YkVKakU5QXNnOGxjVThQYjlaNVc2eEJk?=
 =?utf-8?B?REUwRFZSckZMb0FYdktTUzFDbkhiWEdxSkorU3ZEZG1HYzZqMmRJV2dreUc0?=
 =?utf-8?B?SStWMjkwc1JlcTRyNDRYblJKL01yd0pGaGY0MkxUbkZhOVFuaVFyUW5Manc2?=
 =?utf-8?B?QzlLWFNxcmpkaGFqZmVpb04vRUZob0hUZ201a0FmUTBHWjM5MFJNZ1FncUYv?=
 =?utf-8?B?WEZLeGNXcGV1MXczR3Btc2hyc3FRTXNTQS9qZlJIQnlHRDRYQjBiUWtzUERB?=
 =?utf-8?B?RmZHd2JyVEhIWVJyVmVKLzZucnBSRndTaVhHZXNqc1d0VTMrdVpLeEdYSDU3?=
 =?utf-8?B?SE9CcHJyZUFKMjVVSkZDZDJZUUlOQXVsOFY5dWttdHBtS0RtY3huRjZKM083?=
 =?utf-8?B?bzVpUzUxdzAvTmVhMmhFTjNIc1RTY3ZvK2dvY3pjWkg4aXZNTTI3dXFoRWZh?=
 =?utf-8?B?VzNUcGxEM0lLQWhqS2tBK3VrRFIzcWNwVDNQRnBYekk4L256OWovUUppWHNV?=
 =?utf-8?B?WGEwek1tL0JKTnRVNnFSaTNtSjIxZjlaaUJxanFqRUZxeWtnRVo3UWYyVUlS?=
 =?utf-8?B?OFk3cDR5cjIvQzJFaXA4bDY1bVpUSHhvdnVCOWt6R2JLVHNyQ3JLT3orZEtW?=
 =?utf-8?B?R3FoVnJ6bCsrTmptdCszYnUvd2hEM1YxOHl6elBmQUtwWkRTWEhoODZtSkJW?=
 =?utf-8?B?L0NBeENTS3dJOE5JcTk3Z2U5SWtBSjQwNkdQQ0FhMVNGRXBBeEM1R3BXUi9o?=
 =?utf-8?B?aG9DaUx3RzJvWUlBTTFPUW1yejRIczdDcXdSbFJuZHNRK1lLQkxTYXh4UmQ3?=
 =?utf-8?B?KysxcHZvaTZReXFtM3FVN1J3OW1nZkxXQTFNeE5WNVUwWW1GZDU1LzFDaVdx?=
 =?utf-8?B?U1hXLzRxTjZjaG9uN1kwbHFVRUQvT0FGSllENGxUUUpsQ1BORmZqaENoeW5w?=
 =?utf-8?B?UEY1VnNmeWdEOTMwWHVraEhKNUZ6dkU3alN1TVlMQ2VhdjBIUWNFMURPU0Nj?=
 =?utf-8?B?cGpzNVA4TUt4dGV3bDF3ODBKK25CQnUxY3hTc1htcm1qb280S2hpNXdWemor?=
 =?utf-8?B?RXgrVEZyT2Vod2pObzUvVFh5NjhqMythN2QvSVRBOVBFanQ0YjFwUmowZVRz?=
 =?utf-8?B?bmR6ME1Ea2YwalhJSU5CMnFMQ0hWUU9NZmQ2TkhhcXBJa1IxQjF6SGU2YmRq?=
 =?utf-8?B?MnFOY3I0c3ZDNTIxbGR4RmxOclJiTW1xTWdhTm9Nek9jQkpFZXo0ZXg1cnNs?=
 =?utf-8?B?MlczODI5WjEvWE16T3VvcWFCV0VueXpPd1o1SlU0UDdQMHUyaHF4RGxrUGx3?=
 =?utf-8?B?WkQ1TGpHd0JEM2huWWFqa0xQdGRObnl2Y3UrM2FpNE9veUkvVkdvYWRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJGU0JmYllWQnduQUlDMG5YSG1nN3ZGaUE0VXREMll6aURTcmFKemQ3aDZG?=
 =?utf-8?B?bjN1Ym1pbWhETkVrNE5KOFpGTHgvMWdQWDRSK09wNkZMZWhtSExTY3NUdStv?=
 =?utf-8?B?OWFWeDREeVlET1U5SnhNS1AyOEJYN0dtWnNTVjNZejdnNC9udE1VVzJPUGdG?=
 =?utf-8?B?dFM1R1FwK2RRaXJaakthZlVxVk9kdS83a0YrZGNxUldHY3A0cmxSQjZhNmsr?=
 =?utf-8?B?Q0pBOTFGc0xCdGpNTWR6bFVOSTlQeitwZzRZeVdnNXdEL2tIRGd6K3YrYWJj?=
 =?utf-8?B?bWI1bzFydnU3Q0x6TXRCeHhheS91ZS9GYVYyMXRhU0F6T0F6eTNDQW1BTmF1?=
 =?utf-8?B?SDR6K2pDRjhoamlDMTZhUjdVcmUxMlI4NU01SG1DZ2RZWlRPNHJ2SnRGVWVo?=
 =?utf-8?B?dXZmMTBOZXB4TWhjL0k1YlVYNnkwbk8wdWpJUGN4dFFSeVdCWUg5ME5kcjg5?=
 =?utf-8?B?SktBdk1DSmlDUGJkcTdVUXN4Q2xJRjRJcVRQVUNVUG9VVHRrNXRub0crczFa?=
 =?utf-8?B?TktYKzdXLzR6ektYaVUrU1dlcytwbnlPN1F1Q0lZRHl1b0VyZlVGUmo2S2F0?=
 =?utf-8?B?aFZuMXpnOVlxWnMzWTJnUU9tSVJoa1YzNERLMFVGa3cySUhSWHlPUDNnK3hG?=
 =?utf-8?B?bVBNeUQ4dElWRldUN3NLS3cwWkNKRFcxRWt6N3phUE1pcE1xdHdEZkloV09B?=
 =?utf-8?B?RTVsVkF2OHR1WWdqZzR0bm94UEU0ZGQxWlB5YTQxNTQwRFZpbkFJMGVxU1pL?=
 =?utf-8?B?V1BEcU9vMzNldTBERVhXTXpuNHlITGU1UVNtSDJpVHZkb2pxL004KzMwK0Nv?=
 =?utf-8?B?SE1rcFVVSGVUUWFHLzNYWGt0QTc1YWFjd29HcU5QMlVmOXEzVjJVTkpoVUZk?=
 =?utf-8?B?dUZXZXJMWjl4UkJMQ1Qwa0hiQitXeWFzaHM2VW9HSXBya2V0YkZiTmVzMjVo?=
 =?utf-8?B?dThPMUl1MFFldHcvS2dJckRZNmowTGd3ZEZzVU9oMTBRL3JyUVRSdUFuaGFP?=
 =?utf-8?B?eFpxRnNrd0NtR2I2L0wxWW5hMkNQRm5yWElpa2VrSVNKRVZMRW5Bd0E1NWlj?=
 =?utf-8?B?UFNhRVExZkJOU3Z3TElUTldEbkcxS21mbkMzRDJkb0dmellCMHdJWThKMExZ?=
 =?utf-8?B?c3VGMExnMHF3WG1wKzIzNWx0bU9NWVZQYkd6bjgxMVE3aW9tM3I0aVNWNWxl?=
 =?utf-8?B?ZUVtMjlQY1hlWWxsNGllN0FJY2pMb1l6T0tqMTZhVXBtL1lDMzdxdEcrWjVk?=
 =?utf-8?B?T0FlK2xjbE9XeUUzanY0clIvTjBlaFdxeUpWdTEzZE15K2V5YVhUVTJqdnpZ?=
 =?utf-8?B?YWpKK1hMTERoQkt0OFlhY1pVTFNYd1hLUWwyV0hEb294eHBLSzdmYk03ZFFm?=
 =?utf-8?B?VjQrSE4xR2JaTDBuY1FXRFYwSmZwclNXbUs2Z2RWTmhFSjFTMEpYVitsRVpS?=
 =?utf-8?B?dVdWSGRTVHFFTnJKc3RqdlorK042NnJ6ZmRuMGhFcDBTMkVPRHlMMzM1NjhV?=
 =?utf-8?B?OXY1UWNmdXEzb09yMjNBNVJzOWZyUjY4TFJBT1BQRHQwdnFSK2RKeXpqRmJR?=
 =?utf-8?B?Y3dFRXNxdkVQVVQrbzgzejRmZG03VExvT3g0Z0dFbm8yREQzaVZ5ZnYvbitT?=
 =?utf-8?B?ZkFWTWtpWUtTdERQRnpmN0Z3eFlxRmZ3cHl4SUlVY3cyOTVLeE03akdJVkdF?=
 =?utf-8?B?dXM4T1dNRGpwY09VcUxjQ2hTR0V1cVZVbmtXUEpMclVQbi81ZlF4RGFhZTJv?=
 =?utf-8?B?eFhhb294OG5uV0FUTzYvQ1JUWllZWkpIcGJsbnd6ZVI1akw2d3lFSHBieFBl?=
 =?utf-8?B?VHZ4M3lPQm14Y2pMQ0ZMQmxTcFR2MFpnczNScEFLdldZTlQ5NEpXVW85QmRL?=
 =?utf-8?B?ZFAxRmVXRUVwTFVCc012ZnpiVzZhSVRBYkQzSUJmdnZpUks2Zkd0dE83SURV?=
 =?utf-8?B?dE9heXRRdWdKdjVid0JML21OdVZ4T0hBc2Y5NXJiVWNHODFNemJBOWdkYm1Y?=
 =?utf-8?B?TkpIbXc1YTRkN1Jtbm5HNnVFWTdmQTdBR1VhNXlld0JDZXJhTEYybEhjMjFq?=
 =?utf-8?B?dTNISEJteDhiSTlOK01tamtOL3Zwc0tKcHl2bWFVOGE4WlByT0NQdDQzSjUr?=
 =?utf-8?Q?t9Jxupqjh3YadqmbNo1tqpqPJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b531636c-e2e8-4c5c-fb9d-08dc73d1759f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 04:51:04.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9II1dsYnxtnD6HMC4ByvO8u7anur8tWwbguf2oNARLrwLTZa06lsF+6JpCpU2VRStbmEiq7jXjPsDsxjCzzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914

Hello Perry,

On 5/13/2024 7:37 AM, Perry Yuan wrote:
> To enhance the debugging capability of the driver loading failure for
> broken CPPC ACPI tables, it can optimize the expression by moving the
> verification of `min_freq`, `nominal_freq`, and other dependency values
> to the `amd_pstate_init_freq()` function where they are initialized.
> If any of these values are incorrect, the `amd-pstate` driver will not be registered.
> 
> By ensuring that these values are correct before they are used, it will facilitate
> the debugging process when encountering driver loading failures due to faulty CPPC
> ACPI tables from BIOS
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a342b0c0140..614f6fac0764 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -889,6 +889,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>  	WRITE_ONCE(cpudata->max_freq, max_freq);
>  
> +	/**
> +	 * Below values need to be initialized correctly, otherwise driver will fail to load
> +	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
> +	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
> +	 * Check _CPC in ACPI table objects if any values are incorrect
> +	 */
> +	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> +		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> +			min_freq, max_freq, nominal_freq);
> +		return -EINVAL;
> +	}
> +
> +	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
> +		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
> +			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);

A reminder, we should fix the below code section (due to only nominal freq being in MHz),

685 static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)                                                        
686 {                                                                                                                                
687         struct amd_cpudata *cpudata = policy->driver_data;                                                                       
688         int ret;                                                                                                                 
689                                                                                                                                  
690         if (!cpudata->boost_supported) {                                                                                         
691                 pr_err("Boost mode is not supported by this processor or SBIOS\n");                                              
692                 return -EINVAL;                                                                                                  
693         }                                                                                                                        
694                                                                                                                                  
695         if (state)                                                                                                               
696                 policy->cpuinfo.max_freq = cpudata->max_freq;                                                                    
697         else                                                                                                                     
698                 policy->cpuinfo.max_freq = cpudata->nominal_freq;      <--- mismatch in left and right hand side units  


To avoid below situation(from a Zen4 AMD EPYC system with boost disabled),

/sys/devices/system/cpu/cpu0/cpufreq# cat scaling_max_freq                                                             
2151                                                             	<--- MHz                                                                    
/sys/devices/system/cpu/cpu0/cpufreq# cat amd_pstate_max_freq                                                          
2287000									<--- KHz

Thanks,
Dhananjay


> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -927,15 +945,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
> -
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
> @@ -1388,14 +1397,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	min_freq = READ_ONCE(cpudata->min_freq);
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
>  
>  	policy->cpuinfo.min_freq = min_freq;
>  	policy->cpuinfo.max_freq = max_freq;


