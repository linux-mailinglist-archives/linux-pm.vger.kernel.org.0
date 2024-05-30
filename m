Return-Path: <linux-pm+bounces-8399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D156A8D42AA
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 03:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805F52853AC
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3591E556;
	Thu, 30 May 2024 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MF7RyiLw"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2027.outbound.protection.outlook.com [40.92.98.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58BDDC5;
	Thu, 30 May 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031214; cv=fail; b=m9SUQqj2UsKoa4gFs5QUvdujUF5f2t/1nK4vLsujsDIbhkoSx7wxCSdvkUrTzV4MKLkAPM9mimprI84LMp6INPKLFvkv4HWHYX/+4MPsWWcqnCdUaOTLN00XP/h5NQ76DASJsypLRw/DhFiix/nD9YE4ii4SYmBuT7wB4AFORiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031214; c=relaxed/simple;
	bh=03mnA7OV7YVYq/JkrXfDbiaIaiPakOLY3In/uZy1NqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghOzqCzazLxwDweY4MvMFifcEgUwpa0ajxeT42ffVYs5G7pOpFTncAdmAUfGT1Rl5kRTgzLKFg/y/E8GSaOrhYnxogrugKLCbYWyNlP7lnBVhnfQiZb0QVPvSchwKkmBi0rixgn1rByFzEAj8M5dxKAn0/pibFL6hLfOFm30C8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=MF7RyiLw; arc=fail smtp.client-ip=40.92.98.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5UB8ThtMf767xexev7s/g933hee2EKTdrvdJUCpq3ohfy3PM9sHv4DhrqJCC3eEHG0/ayWo2JAups0s0p4s3t8LFsNG4S+6phNLjJsZjq5i7iOCL4DBk3wvFxWgA2XZeoPYW/mNRBeSAh2yODfC5xoL1gxSRGaUIISeoku9sSYse+Xy+2+4gXsExgtaFdkuUMAVuMCHGYBPCGsswJHuHkqbxD8jqqzeus2ETHJbTQ3xxrPcWzKrcsDufDAF4FVSV4FXzeBcjTKwz+THqZqNgikiDgcDBf+oBfXuZrpnqeQnJUuLdied5CrXK6De+jcX5bPKFWjiRSPjoXbVTlWgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOZivlHArkNyEr0rq1WxuWTUaO7PLbYnc5pnMXYxESE=;
 b=Od20RDWvQcHPjyrJEjKjBLk439HmInvN1sIaXRZt71VUqn5eFrHW11BK9RIGDKmlm0TmGKq9OczFjiShMun1IN8ylkfqYyTa4P8rtiSodNfj9zDukxS89OxZlZFLij14cjo6DN/6TIvxW+T8LF2JQzEo0lArMX9ze1Rv219T6BExE4iIb4flucgZb9nQfiNgZNNa/h5ykYV6oX2mkaYdKc7Ll5pZ5bFbX9ak/TxcDG3K3nZRDd55ug6XC57Rh15F5v4vE/P0mKyQw6+EVbM8NUJO23K7PRsPlswwagkLxpES4pWbvXJVBsqZE314StgrxHRAEyFfTdu4a3by5Q3TsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOZivlHArkNyEr0rq1WxuWTUaO7PLbYnc5pnMXYxESE=;
 b=MF7RyiLwK4RJQyXe9tIWhaLx/fVe1L41RkHHmbOQW2q3m2fhG+krXNCuXr6uim9tTCR4ROJs0QeT6gr9Q5ibS3EiaibMd8DHPupU5g19BGgmaHixfkkPAecHKvH7IAV1jPrmu6VbLEeE4GZBsMbNqItDiyM2xwnoxTtuP1Z5/WAINUngG+4nnJhXMg7y81Z6dPTN7mcJq75+2rPFHeE7qb7Vr50yE0VZcxT7qCO8DxFRPSPU9o2V//p2aM9N9mqaaNck4Ke96cFbTUmGPNU53VBn6AK/Qv6U9vxNIJSg4AFftx3SfIUHbSGNIx9CUbFeQMq1veN3iDsaJJ/yysgIyA==
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:221::11)
 by TYVP286MB3168.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 01:06:50 +0000
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19]) by TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 01:06:50 +0000
Message-ID:
 <TYCP286MB2486B1D734F8E2D74BFBEEB1B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Date: Thu, 30 May 2024 09:06:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529071244.vwognqagaa4347dm@vireshk-i7>
Content-Language: en-US
From: Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <20240529071244.vwognqagaa4347dm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [sD+EsY3wpkz8D/ftSxW5ot3dKP9DjZcC]
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:221::11)
X-Microsoft-Original-Message-ID:
 <11e96f77-7dec-4c38-af87-0703ebf79a88@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2486:EE_|TYVP286MB3168:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b830da3-5d1f-46e3-1637-08dc8044c8e7
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	3R0sEPX7XrdMsQNboWlJPwzXS8V71JQ2vP9QstYmzt5oPEhgrYaIZtNVXmzf3CME33QdiRqmjphS/61lhuKuc8s0tWJKT3yqLvhHuB9jsNCNR4TgfVm98F2i+5PNTZdVATXx/kkA+wKDad8SpfnZm9K2L0GIDZYVKCF83jfc5ULKb+kRreSOSC4Y9nVSMYwvWzCVhA+PdcvcaP7+aJuA5JCpxcnFwv4vTczKOb9oidp/rMtZtz1Q9/J8HofN7rUvIz5cPeoEvg9X5qp+tk8znsaOuLVZYyqoIogREvx9KEcCR9XMOQz2505uEOOsPU3uGT1j5G/pv237UmddgrXcQ2Lr0uIof2oFE9DrBcY0Br+vzAjpEbHEYacIuUOFKzdz1+lvW/rzcETbN93XDEoDg83kG8LALjrlO3ZbAfj8UQekzlgBKG0UNYgYFjmXOUlYgNOI/5kvK0bJndZl3ODMjuixDEK8Yc1WAHOpObRtbDJxeLQJdGIHjr0lpL2+LeDEml1SbwZd8tJC5lQA9+4vHldwJyN3N2FMtyTZhOnl5QpUzBNhU5tarjBpLow3p1Bd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1R3dWZXd2NJQUdSbHMzL0p4N2Q4N1BPWTdYN1VPYzRTdzVTNFQzeHRXMVAx?=
 =?utf-8?B?cVMyNTBSTmN3bytQQzVSME1oVGt2N0hLblZnS0JBeEJQY1ZkR05OcCtqaVky?=
 =?utf-8?B?c1RrNWRBQU1nd0dLS2pUU3NGb0IrOWVmVGRzYUZsa2oyVkRzQUR2L2JOK0RD?=
 =?utf-8?B?T3RUdmY4Z1pEc013NDhzMHJLeGhyNWliNlZ3a3o1VGo2MnQvNUVRdTZvUVpG?=
 =?utf-8?B?akRyWWh6eVRxUzd2d0Y4d1ppa29JelRGZTVyUHFOWUQyaUV1aUJucG94R0xH?=
 =?utf-8?B?aDh5Vjk3OFg0cm9TZ09QSVJwa09mcVRIekhrNnhMd2dRZjl1RWh5a1oyazhP?=
 =?utf-8?B?RWFBbFIvUGNHTjNnNWxFZWZBeTF4SjRBUzMzRWhOSVFFb2t3TUNUeU85VFho?=
 =?utf-8?B?M2J5QWxmTmhXK3ZyVzJVZ1EyL1FRVDE5a2ZqN0Y0em5Sb1VmQkc1bzJPLzlZ?=
 =?utf-8?B?azlZc1IvQUl6TGZURGZ0S21jNUJjclZFQ0pJT0lnV0pDdzVkcmRVaVVHT0s4?=
 =?utf-8?B?bWg2c25yRVpqMjRENnY5K2x1ZHk0bHNiYkJYSWplZndINjVBaE1MYnlSRTd4?=
 =?utf-8?B?Nk1aTlVSM01jZFJJME5CbzNOdnZHa01EYzBKU2RWUEhYMDhJSkt5bmhZY2l0?=
 =?utf-8?B?c01JSlZFbmVUSndjOGU2cjdZZFdrSTFEeTgwZ09YbTdDczVKOHk4Q1o0ODht?=
 =?utf-8?B?TTlHSVBEWG51b1ZKc1lxSE9uRk9SbDJodXZnMFZVWmc3QkQ2Z2VsdTlqcmI4?=
 =?utf-8?B?enJyUkE4QVZyTjdWVE5iVTd2TURHVUlYa3diTjNiVytMZEJDWmpmN1pRQzF2?=
 =?utf-8?B?L1J6anVVaHF0WVN0TlVnVklCNXg3V0w4RllSc2swbTJDd0xJSFFLN1Q5NHhD?=
 =?utf-8?B?bGg0cVR5RW0yWXI0Z25peWdJSFUwRVk0THNrRGcrMTlYbkIyYnJKOHk1cDBM?=
 =?utf-8?B?T1phbXRyYUc2OGNrUWk0MHJVMDFYZVU1MXgwb2ZCVVdCZVlvK0EwUndBVTZ5?=
 =?utf-8?B?VURMZ3J3alBOMElPUFhjRDRLYU0ycWVHc1g1UjFvVDBibXgzMC9RMXFPOUF5?=
 =?utf-8?B?S1dEaGdHN21OTVVmVGVNSVpMWE1IdTRFNlo3M2hTaU1mcUROeHNKdHN0Unp3?=
 =?utf-8?B?cVZHbHZ1YmZLYVFKUEZxRWtVeGhja0h5QUdxZUkySnptVXlRZ2cvcjdFeHRU?=
 =?utf-8?B?eWZIdTZTK2pEakYvTHVBUDd3MFlnaUdlN2VYRWtvMkxDQkRoZERvQzhjYThm?=
 =?utf-8?B?eElPUXUzNyt5dERwU0gydmFLM3kvUnE5MTBRYlNpTkJkaG9GSm9jRWNndkM5?=
 =?utf-8?B?SUpNV2pKcjhQZVZNMFZqajUvUUFuekxzdEcxdldlWTBwQXcyREllRkFIbzBu?=
 =?utf-8?B?cFdPQTVWaTlqL2ttQ2N6YTV5aVB6cnl2eWF1bk04b1VDL3VpTWNyc2Z2dThl?=
 =?utf-8?B?c1RUWnFhYVRVSnV5dE9xVEN4ME5aUWs4L1dvUTljc0pJcnRsNmxNTXBmZjJk?=
 =?utf-8?B?STkzNlFKYkRJMWpySFZQZ0k1bGdnRVRKajcwWmlLSWxEOTkzZmpIeHV5L2JR?=
 =?utf-8?B?c1IzT0dlWlZsT0dONTBjbGcxY3BuNmtpem5DcVhLNSs2dkRQL3doWWVnZzJH?=
 =?utf-8?Q?gnFfWF43xVckORAuMF9o3FAPQmXVXBefyEN4Wv2kHEJ4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b830da3-5d1f-46e3-1637-08dc8044c8e7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:06:50.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3168

在 2024/5/29 15:12, Viresh Kumar 写道:
> On 29-05-24, 14:53, Riwen Lu wrote:
>> Yes, you are right， I didn't think it through. In this circumstance, the
>> policy->cur is the highest frequency, desired_perf converted from
>> target_freq is the same with cpu_data->perf_ctrls.desired_perf which
>> shouldn't.
> 
> Please investigate more and see where the real problem is.
> 
The boot CPU's frequency would be configured to the highest perf when 
powered on from S3 even though the policy governor is powersave.

In cpufreq resume process, the booting CPU's new_freq obtained via 
.get() is the highest frequency, while the policy->cur and 
cpu->perf_ctrls.desired_perf are in the lowest level(powersave 
governor). Causing the warning: "CPU frequency out of sync:", and set 
policy->cur to new_freq. Then the governor->limits() calls 
cppc_cpufreq_set_target() to configures the CPU frequency and returns 
directly because the desired_perf converted from target_freq and 
cpu->perf_ctrls.desired_perf are the same and both are the lowest_perf.

The problem is that the cpu->perf_ctrls.desired_perf is the lowest_perf 
but it should be the highest_perf.

In my opinion, desired_perf and cpu->perf_ctrls.desired_perf represent 
the target_freq and policy->cur respectively. Since target_freq and 
policy->cur have been compared in __cpufreq_driver_target(), there's no 
need to compare desired_perf and cpu->perf_ctrls.desired_perf again in 
cppc_cpufreq_set_target().
So, maybe we can remove the following logic in cppc_cpufreq_set_target().
/* Return if it is exactly the same perf */
if (desired_perf == cpu_data->perf_ctrls.desired_perf)
	return ret;

