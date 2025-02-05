Return-Path: <linux-pm+bounces-21424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4188A2980E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124651631B2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118AA20C473;
	Wed,  5 Feb 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E81wQzXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E42207DE0;
	Wed,  5 Feb 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777890; cv=fail; b=YHAoUWRmF1DtVGfm7XBERkAyVimL8i+kIGXfkB4tu7On4XOiFjwOoSyRM/nnMYY1p/a1UpJ6mBYOKFZ2Kn2+LNsDmakmFpQOpkdkk+2ufmKHUekMf0iOB5vAHqQFobeYINV2OduBLrk7hciNxGeZtUarKc4pQlBVhPUFvkln5Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777890; c=relaxed/simple;
	bh=zTZUTVC4SvbsykgoDV151C23m8FeqTxIX8nQCsdCOoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CywCE2BhLU5v9mE7T3kffQ7tkeuD0/9WpoiPFZZ671DAuYBFzsR5CKUeUySgiyfilCtiqP13ErzIi207aeoU02GrS8R+71xN4/P/cakc5aQHtHekPvz9oPWTAHsqwOj6kFxYWI7B2wiPc73qkaxbwy+wb/o4J+eu01g9abd0USo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E81wQzXw; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbtTiZ7ABiTkNOZcHHSOrVdWSm8iTjG+G2EXrLaZ+/CpR/LDlCoMfmtyhQXu2cFiy4nr6v69ImufWiWRSIs2RcxjTMMtkzrnn1UUfw01uoroICvvdeoMGHHvxdtV3DZFRndfEeH0VVZwjOkAIsQXpAAtsYcAkM/rs+MbKZPXZcTt3UlNHzhX0K80QXqOC89z65CqjBtve6v2JH0OpPGnhFPzWNXJiX4TfRxbjiH6ofaIbqi+QS4BH3Psj18zUOwr+x+uvS5K3Xp6/Hvu/7tnAOBKZv5quPLoMgC5LUMExhWaNavL/hSkuq94BFMrwJ5x6AsWIt9Ajw6LjqBIFMW5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqaFRHvOknBvOpKFZaoP+NOww2t7oA7Q1Y9ulcyO/iU=;
 b=AGlMTfb338ynGl7WTzK4ZQ1ixds4NMX7BSC7kHYWqNlBmZqNGgeXb+7wLddMEWkrJIiHWwx8uYrDUBNAfKeyr2FOFMUZWPVR+qFCKc45Mo+tHMQCuLJQ/RLMfhGgCnra3fTXwsEEOOBhxPgPsQV542fe8Y4sb9E+KfBrSsnBWye5sK65edYOl5tC+3R9Iz7opYIiOLtrCIURGOtRR8b27CnBiCQq2J6sjSN93Sf6rPf0h0SwMnawj8FGTi4D2JZAUIZ8tYqzOhpUp1/KVQqPEpGSursH7fm//4FpKT9mlrzlFwiR7aBO3LcMS9zuCQxbOgcboyg50l1jOZrd7FBGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqaFRHvOknBvOpKFZaoP+NOww2t7oA7Q1Y9ulcyO/iU=;
 b=E81wQzXwiFl5LLtXSCfaj4dg7ghPLTWYvzBjWcEkSOtnB7RlRzkoZGmcdo+Zl1meffj0/hC2xgqttT0rPmA7lpr8ZjbWmvkQBjeMqBU9Orja86z48j0U0nm7DpJeqS8RWaveF7SyiD42Rx/Rzi2YyHwlWN62j6WQ32pGKrzqQP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:25 +0000
Message-ID: <30e56a47-4201-4f2b-aa6d-0547c0d09c38@amd.com>
Date: Wed, 5 Feb 2025 11:50:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] cpufreq/amd-pstate: Use scope based cleanup for
 cpufreq_policy refs
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-12-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-12-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 426e3e59-f428-4206-f151-08dd460db595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUdaQVpLM0JJNERpMm0xeVdBbms2N2Fham5qWjJJY0VpYVJ6enpjNWw3WVpx?=
 =?utf-8?B?eGpENkpFa3B2eXBFb2Jta1lIemlCNmsyTTJJaFFvTzFwbEZ1dEFlZmQ0VTZ6?=
 =?utf-8?B?MXFaVHVvUlh2VEJhVVpHd0dYSmRMdE93Q01wcnlPMUJRRCtScE1XcjZlZXR3?=
 =?utf-8?B?TkdJR2JNZlowb1p4TGp6anBqaUxESFN4cGwwR2pERjdSeGE1Umw1dTRPL3V4?=
 =?utf-8?B?RHZzejAzUkFtVURSUkduMnJTcWxIbkFlS0dra3pJaUg3VmNGNWt0R21qWk9H?=
 =?utf-8?B?Q3ZmSUJiRGovZno4clI5TWJDL1A3bkltNTNucE41K0pXVjh3Rk5jbTN2eTFR?=
 =?utf-8?B?TmVFTnJyUzQ3aFUrdC81L05oSEpmT3F0SEpIeDFMZVkzMUJoNFJqYkV1UWcv?=
 =?utf-8?B?VXY3NEoxYXhIWHhPbW83M044N1puMytHS1BJYXU3MFhVSDFkWWZsM2pTZTlW?=
 =?utf-8?B?NWpaSDRSbHBxTEFudTIxWXFGVzBkenE1Uy9qbEIrSnh3MWVUd25jbDliRnpJ?=
 =?utf-8?B?R1BFNDRPVC8xek5venljaDE5ZFV6bDN2NFQzbVRoNlUxVVM0OGRPVDB1d0xV?=
 =?utf-8?B?bjNNbzZ6VEtyQ0xIeFk3OWM5d1pTVUdoYWVod3dIWjRpZktPL25MY3I1TXp1?=
 =?utf-8?B?N0dHQUg3MjNqL1N6TFpIY0JPbGI4RHJyZFowaUkrYVp0UFU5S1c4a0liNkcw?=
 =?utf-8?B?bDB0UXU2UzhDbkhhenZYZGhmeURra1V3M1hGQ2QxZ2hINzhnZkYyQXA1Vk1S?=
 =?utf-8?B?S2hxT1Z0ZXIvdlVrL0s0dk83a3ViYVRSdFk0NHNkOUFnZExjYkxPbGhmbUNm?=
 =?utf-8?B?WThRRG0yRk5OdWN0RWErVlNyRDVNcCt6Ry9pL1FCczRUSG9tc09OeHBDcWFh?=
 =?utf-8?B?a3lkRGZWZ2tZYXMxSDdsbmUwZUhpVU9DTVBJTnRtY1FUaTNwMkZzbHhrOXV1?=
 =?utf-8?B?UEVUY1AwZ0gxRUVLMWlzeitYN0J6d0lncWw1cWpqTS9sWVdRNHNxNGFWQmNE?=
 =?utf-8?B?OUtuYkhUTXlKT3A3TE9xMkF1WGh6QXcraG14OHVjT2g4eklrbXVadEJoNHhw?=
 =?utf-8?B?UHNqakV3clhYQmZQdDRkQTAwTnBBUGdnODNEMkExUm9sbWdMRTVUWFVlOVkr?=
 =?utf-8?B?dzNkTEFqNVl3anZtKzdyQmhqM2tqOWNmVU9PTCs0VlA4dmNjbE5uVm9ya3Rt?=
 =?utf-8?B?SVhzcjA4NUF0ek9EQjJsSmNtTlBmNVVKMG9kYmJsTTRrUnBqcS8zemYrenRr?=
 =?utf-8?B?SnlwL0J6SFRHd1VFOVk5cG5yMm13c0xsSE1FbEFnT0lRSmE1cEFyZUhpbzRy?=
 =?utf-8?B?czZzMmJsNEZ3dytSdHZpZ3lPeXR1Zm5uVzJVVWlzNTBFNE8zdFpPOHlaYTMv?=
 =?utf-8?B?MlFzWjhoa01aSDhuK3VvK1ZRUTU4V25kVlU2cnVXM3BzdzF6Ry9mOTJpU2tq?=
 =?utf-8?B?UHhTb1FIQUtjOGtwSDFqVDhwUXRBaHVXajA3bEcyQ0Z5U2NldFJNWTMvbk9i?=
 =?utf-8?B?dHpFRXQ3VVV2NFVRSXF3Tmo2MkxnOHFWUkpiVDVRWm91RzZkd2pUK3YwcFYy?=
 =?utf-8?B?Y2xabGhyVFJrSGdLTXo3VHd1ZTZVd2t3L0l0S2dJY21lS2dyakFWVGVNQlhr?=
 =?utf-8?B?WGxIZjEra3VuYUpZaXBFREt6RkVvVUxkRklXQ0w0MElmcHZ1dkdtQWdyTkxt?=
 =?utf-8?B?M1Y4ditDcWIxTVdzZkR3TU1neEg3VWdRN1VybUovdEJmNDR5endLdXVvV1pK?=
 =?utf-8?B?azhOaFl4R3REeTk1bE44d0QrOXg4ZGIycExUZ1hjNWg5eEVBb3dQV1lRWk9V?=
 =?utf-8?B?ZzU0ZzVaUnJHZDJnQWdjaTZiM2hJT0xRcTliemd5bDZsL20vbzlESnVWRFRS?=
 =?utf-8?Q?gSsjscRdtlFA/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXhvdkRFcjdxV0lmZkNMblhzUWt3Vy9XQ2JuRzc4K0trbWFweWcxOE9rcnRy?=
 =?utf-8?B?anlhUmRDcjlQazJDc0Q5Y0VIdXAzZS9OZmZ4ODcvUTZDNUp5bUN6MWJ1MEJB?=
 =?utf-8?B?OXFZSGZ4a1BySDV5cGxNWDVuRGZ0ZFhpN2dkSWRGb0FveStUQjNrT0pIOFJm?=
 =?utf-8?B?Z09RVk1YRG1IVDZxQjcxc2h3S1dmQ204Qi9PaFNEZ2laUGVPOW81TTZjY0N6?=
 =?utf-8?B?dFRZeWZGczgwRDFpZ1hDVXpqR1AzSytYTVYyVTV0NS8ycHgyTXlRVmZTdzlp?=
 =?utf-8?B?bTdYT01mbURKMllyakhad0Y4MUdCUHdVOVJuS0dDYlZIUWNSNE1VQm9PTWtW?=
 =?utf-8?B?TFVxeWQ5UEFEQVFCNU5aclpJWlE3cWlQR3A0TnFQTFFNTXpickdud3Jtc2Fv?=
 =?utf-8?B?M2crbjh5S1E3WW54a1p3QTNYSDNPMzlaN1l1aEh1RFBPekFhcElrL2h4K0ZX?=
 =?utf-8?B?dExoTlJHNVlocXZ4QkY3MDd2aVBWVG5nQmYydXI5NldzM2g1ZDdjTjVBc2dT?=
 =?utf-8?B?b1VEdUZqQXRQenhmVDBpcmNrNDQxVUQ4dW53VEVVZWQyUno2Tms5L1hTQis2?=
 =?utf-8?B?MTVjd21uS21pazFYbjhLNUpSK3VyTk1sUHA5R010Qnh0dDhCRjJVTWRYV2FR?=
 =?utf-8?B?TTZxTHRPR05RUlAyaUZ2OW1qdFNxRU5QclZoV0RPNjV5QzdwbXNyUmtnTkdm?=
 =?utf-8?B?S0VRaXFoYlZRQlEzTEQ5Ymo3SkNGYi9YYkpxKzFiTGlXUm0wTmpzbjlqSjlh?=
 =?utf-8?B?UVZkV21lUnFyZU16UEMyQ2ExM0c1ZnNvcnAvSXQ3Sy90blU5VFFKTm14aVd0?=
 =?utf-8?B?aWtvQjh3VXhHYkFsU2hFRWhzS1lOc3U5NG53V1pRVUUyUUFHcmZlb3dKbEo0?=
 =?utf-8?B?NVBLWmZaMHM1ZXA1dndQUG1ydFdmdHRsdnEzOUkvYkZ3QnFpYjBZVEVTN1VH?=
 =?utf-8?B?cDhnZDh6cHFmNVEzV1piUjBqc3FoTzl6ZmFqZUxFTVdZRzJhQSsyZEpTWGtV?=
 =?utf-8?B?N0tUZEU1VENEbEVCQXlja25LMzZza3NRcjV4cWVGRjM2aWtBQWxHdDE1Q01I?=
 =?utf-8?B?dURBNE1Ca1pnNDVrWUtNWkp0V3FCbURYYUxnQ29uWE5ldjFBSlR4aUNqdFhL?=
 =?utf-8?B?em1IQ2FOc1dBVEQyVmRLcmt4SzFVUVlsYTljdGZGdHVGM0ZhYlNJaVNmS1JD?=
 =?utf-8?B?RmkzN2huNGg5bE1ZOG9pVGt4QmE5ZkRpOG9xUFhzVEI1eFdyK0pmVkZIRmxV?=
 =?utf-8?B?VlpTMlJDOTdOVW5LelJORW5SclpqMENqZ2hPd0tNV3N6MXZWV3lmbVBXL2RP?=
 =?utf-8?B?SFI0SFR6aEtoMnVwU0xJSzlXWC8zQkl4M3BsOVR6bll4enFEUFpWTytWb0pw?=
 =?utf-8?B?Tjh4R2dZa000Y1dDWVRLVFd2NkdibS8xcWQ5eGNJWHdJQ21SWk9NYmFlRlZY?=
 =?utf-8?B?azI4dkpTMGYzSXkyY3V4U1hzU2JTWVlXc0NhK0MvT3NYVnBEU0h3QWIvY21o?=
 =?utf-8?B?VGIxOUxtTENHNXNaVUFvbFBjMTJuNDdrbVU5L3ZkMUN0OUdZMzZ0R1ZvT0pa?=
 =?utf-8?B?c3ZVeTQvUHQwQS9JN1dFQW5aanJKTGx2VTJlUEdBYzJvQ2w2NW5JbVdaU1Nz?=
 =?utf-8?B?MW5OU29QZitEeExxRWpNSzd5SXhqYWk5VTBxM2xJbGJ5SzFHQU1seEI5d05x?=
 =?utf-8?B?b25sckNtTDBtcW9xR1JhWlphdGRoQUtQWGszS1A4dCtnK2lhUWpnOHNESVNr?=
 =?utf-8?B?RnEybmhIR0FEdWd0ajllbjdLQXhQOFJNUWYzYlJhcnhUNGFwREloalJwbGlx?=
 =?utf-8?B?NzNORXRCTDBHSkM3T2NlRmRQTSt5VTVma0RTZVVwK0N2WDUvWkJVeVorWkZZ?=
 =?utf-8?B?WGdYVjJuTmpNcGVYVFg5dGV2VkhHc0hEeWY5NzhhRmxwU1h6WXhiaU5qRDdX?=
 =?utf-8?B?WFdteW01N3hENk1LSFg2VjVWZzcyeWlnVmsxWHFLYzdlQ01tRVpLU05OUHgw?=
 =?utf-8?B?WUlYb1FyNWhjdHVCWTM0N3I1cERvQVEySmlHT3ZwNDJqdEZ2aWNMZkJlNUUy?=
 =?utf-8?B?em5JMUVlWElBa000TkxJU1p2R3gzUGtkemo5QnU2NGp4eDVKRDRGS0lCZ1ZE?=
 =?utf-8?Q?+xPeUoE3PydkMY9aJUnvBfqkA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426e3e59-f428-4206-f151-08dd460db595
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:25.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OssJp4xTs1pWkcjKTGNOa8sH2bmdfo7KUbQBqDfbOG/AJbUBG848HPJTVukOiRrCbyIY34bwn9ltcIWhvy/g2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> There have been instances in past where refcount decrementing is missed
> while exiting a function. Use automatic scope based cleanup to avoid
> such errors.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 25 ++++++++-----------------
>   include/linux/cpufreq.h      |  3 +++
>   2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a604f0797d9..ee7e3f0a4c0a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -548,7 +548,7 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>   			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>   {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
>   	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   
>   	if (!policy)
> @@ -574,8 +574,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>   	}
>   
>   	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
> -
> -	cpufreq_cpu_put(policy);
>   }
>   
>   static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
> @@ -587,7 +585,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   	 * amd-pstate qos_requests.
>   	 */
>   	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
> -		struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +					      cpufreq_cpu_get(policy_data->cpu);
>   		struct amd_cpudata *cpudata;
>   
>   		if (!policy)
> @@ -595,7 +594,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   
>   		cpudata = policy->driver_data;
>   		policy_data->min = cpudata->lowest_nonlinear_freq;
> -		cpufreq_cpu_put(policy);
>   	}
>   
>   	cpufreq_verify_within_cpu_limits(policy_data);
> @@ -678,7 +676,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   				   unsigned long capacity)
>   {
>   	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   
>   	if (!policy)
> @@ -710,7 +708,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   
>   	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
>   			policy->governor->flags);
> -	cpufreq_cpu_put(policy);
>   }
>   
>   static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
> @@ -824,28 +821,23 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   
>   static void amd_pstate_update_limits(unsigned int cpu)
>   {
> -	struct cpufreq_policy *policy = NULL;
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   	u32 prev_high = 0, cur_high = 0;
> -	int ret;
>   	bool highest_perf_changed = false;
>   
>   	if (!amd_pstate_prefcore)
>   		return;
>   
> -	policy = cpufreq_cpu_get(cpu);
>   	if (!policy)
>   		return;
>   
> -	cpudata = policy->driver_data;
> -
>   	guard(mutex)(&amd_pstate_driver_lock);
>   
> -	ret = amd_get_highest_perf(cpu, &cur_high);
> -	if (ret) {
> -		cpufreq_cpu_put(policy);
> +	if (amd_get_highest_perf(cpu, &cur_high))
>   		return;
> -	}
> +
> +	cpudata = policy->driver_data;
>   
>   	prev_high = READ_ONCE(cpudata->prefcore_ranking);
>   	highest_perf_changed = (prev_high != cur_high);
> @@ -855,7 +847,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   		if (cur_high < CPPC_MAX_PERF)
>   			sched_set_itmt_core_prio((int)cur_high, cpu);
>   	}
> -	cpufreq_cpu_put(policy);
>   }
>   
>   /*
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7fe0981a7e46..dde5212d256c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -210,6 +210,9 @@ static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
>   #endif
>   
> +/* Scope based cleanup macro for cpufreq_policy kobject reference counting */
> +DEFINE_FREE(put_cpufreq_policy, struct cpufreq_policy *, if (_T) cpufreq_cpu_put(_T))
> +
>   static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>   {
>   	return cpumask_empty(policy->cpus);


