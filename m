Return-Path: <linux-pm+bounces-22785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C0A418F1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FF116BECE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6924501D;
	Mon, 24 Feb 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d7/eacrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8688243369;
	Mon, 24 Feb 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388889; cv=fail; b=X4n9DzDHYY9Z+MbSDTjmPRhtvCXTP8A63UGZnTHBEfv6ijiUhtuOL9YErUSM5xfaw4cvBxnCeZ89xBMb4aWMkWzo0WPsmKd+O953bY1Efps4FnvVfG9XEftpV4Fr/P6DHVr9FM0coEyrNEQaSPrap1fQ9arNpCI6sY929Y3Y7fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388889; c=relaxed/simple;
	bh=2Xuo3VisFro4DsJNFxxJREfQZH7/YFoizYeJZf/vQxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YnilBOIxHPJwlVlcfb62hav+pEudkxcVN4lQzk3wFWb1qbSpivb/7Bbx2xVg19Y0mPg8w7m45fw3kQk+FmNrOvql2/oEGfqa1i0nIf6lAZ5Hh0uugL1j5rttfw8yUTPVVvSqo2gkkAzPsJ4Fw2IzYe9JGnOAZidSmF4Si+gUWO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d7/eacrh; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/X+DYfBnNBiXaroB8CikWbz2RBsCYxabQgHgWl+xnlzYFedTHr8oUsQK8GR9uadun6MS7yjel54kUgaNOWd73vI4gkFfCdn42iCrU7CU+euJKNjy9Kxq8y7+rFkHB68kjYcQx8ZGYiT/rFoWiGKEBoCxg5fvEXJIZFo/+FRAdVd+9zhSb879uiIa8TXGNwty2kQsgaf47gbxMGGjjZ/iNagIFKuqTsU7B3VH4x4tq0IqR7smJtdzh0fCADZR/zTRRIPo2iFFaeqBp94ftnh2HAPMcrJgmzSL9DmXeHDhEHqjRxwsTzc79+UMhk/SAyct3OblIcV1YGgeUhP/wnY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kGQ61wZVJZLNni9T7xLmS/S2Kr6urqfAYc8NzNLRO0=;
 b=oEW2FXh2zmET9ALmIVQaPzB5Kowef6AdQsRZk0xWipDcQRZ6gV4JQzPtu/URr97DDUgaRzbpwy3vt4EIhEVgBOnICpSmQOsb0jZnxXexTlK30miNnVapoSgF+/U0CuIrK+DfL21ewoisBAiZJAaS9S0j4VWHPc/olTym5xaftpRHY2a4AwJRM0Ok4EQPaVC6EHwUaqWJs1QDHwtHK/J9eJjEJQ33QUMJy6CEQHkJuLcC7bl6RPvWA9/hT/IeWGbfDp2RKya7otYWB72lop8qZntkZqJ5QLq41NpY0pEpV9V5/GIU1TSjVkYqECDU1Kagp5wCFp0OvvaibPbpVl4RcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kGQ61wZVJZLNni9T7xLmS/S2Kr6urqfAYc8NzNLRO0=;
 b=d7/eacrhFKhv59SMxbaEoAtQhDiKfqLO2UmuZTCvDJ+EITTnhDJttMvuv+py8L3kc/FSriq1t0PM5btaK/qDbatjeQT7BQw7JR95csDncatagVtiR6/bZ2CKFSxVOxrDxPr716ePmwcZQ7/uboOx7uSzoSUPUjvVI13vgf7k3O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 09:21:20 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 09:21:19 +0000
Message-ID: <59c1fb63-1342-4aed-8b4d-f07c263cc74f@amd.com>
Date: Mon, 24 Feb 2025 14:51:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] cpufreq/amd-pstate: Rework CPPC enabling
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-18-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-18-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b87c80f-1175-4831-4f2e-08dd54b498f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzRzMDhWZTVQYnJhTXBOenpFZlJYcGZSOTZ5Ujl1bXE3UGpaMUhxckZsODFR?=
 =?utf-8?B?ZHFLeEw5QjQvQnczaGtPZy90cnZKdmF3OTR0N2c4cGNLOWR6dTA3Ym5JMXJO?=
 =?utf-8?B?NjlJZ3Z6OTRSQlc2aCtKbjR2Z2J0K3U2OHFySm1zdlBQcDg2SkpvQlE1WmF2?=
 =?utf-8?B?cXJibDJvNGs2OUlmaWRVeDZ3dUpZUlF5d1VmcXNjbkg2cUtLVG04aVl6cHVR?=
 =?utf-8?B?UE8zcmRqTHlOMVZvblpEMENBc0xUYkNMNkRGdytvMUJXWDFpR01FaVNiWk9s?=
 =?utf-8?B?cnR5ZnBUY0p4Q1AxaVlVN0pKRllSekExckxQZTFlOEhGTHVYc3ByejR5QkE2?=
 =?utf-8?B?Tm9Qc1V0VWlQTVNvYy9aQ08vY2RaUDFGejFSMTZvV2FPaXlrR3QxUzNWVUdH?=
 =?utf-8?B?WjYwYmE2U3pwZHg3bGtwQWd0R2prM3Z1ZFpDSWFNVzY5SkNxaEJOUUJKa3p3?=
 =?utf-8?B?K0VxeEthZi8yaElXZlV2aCt1YmNQNGF2VVkvM3h4SmNsYVFJQ3NwMnQwYTJT?=
 =?utf-8?B?Slh2c2J5R01HZlJqRzhRU1ArTGZQYW5DYU8wM2pFRndwN3U4SWFGYnhvYXNN?=
 =?utf-8?B?QW9VUWswNmV1K0duZWN1cVkyb0xPenlXak5KcWwwbkhpUEJoRWhuYmR6UTU4?=
 =?utf-8?B?REdmWUdlLzRuQm5TejBVci9OT1M5TlpPV1V5a2ZwMCtzRksyQlZNOUFTYXAr?=
 =?utf-8?B?OHU1NlluMVIyY2FLNG5NTnFSNDhLbWJVQTJ2VlNnbExLRnRKaXdYTGk1Ym5C?=
 =?utf-8?B?U1NLODBWNEUrWUZNQ0RNc3gybkM2T3BPamtHeExVeW5CRWJPaFY5UlRnM0NJ?=
 =?utf-8?B?L1dSMFpxaWtmcEgxMGdyQytWUmVLdGdjdjI2Yy9HbjZ1K1hqajBjSW9UanZl?=
 =?utf-8?B?MXFxMkNja1RKY0trSkZSaFhiZ3A0MzZKTnhDeUxHS2pOUi9KL0N2alBERjJH?=
 =?utf-8?B?WkRwRmxoUmFsQ2JGN0VFV2hJVk92bzEyV0xWN1B1cTFFTHRTc2FXNzhtTjM4?=
 =?utf-8?B?VkkwczZJNmlNNDZqeWdhcUZYZVN2R2FiWGUyNkptY3JRNFlvUjcxTjEwcU41?=
 =?utf-8?B?UVorNGpqd2JIT1A3Ykh3V2tUbjYyaXBGcGovTUx2Uk81Vi9aMkp2aWI2cDVa?=
 =?utf-8?B?L0had01SL3ltYlh1M0ZxZVlsV09FajFRaDFGWEhTNnphR2RKY25JOXdGQ2ly?=
 =?utf-8?B?WTlCYXBhenk1WkFUMlYwRW1uVWYzQnNjcFVIOFJTUUlRZldCKzIwRFQ0QlV1?=
 =?utf-8?B?dHptdkNDTCswcmtYR1NLdVZZcjZEZGtuUnlxY0Y4b2NmRkhZbEsvbndwbHc2?=
 =?utf-8?B?S0lXZ05RMUIzOXpObWVJN2FxVkdjS2R5b2xDRVh2M09vaVNsNjY2cnlUR1Ix?=
 =?utf-8?B?ZGd4LzhOUkJobCtxQU51dVZEcFFUTWxsL3NTNklrQ2U1dE5uVUhyelJab0N4?=
 =?utf-8?B?dzlFbmQ3Wk94RkdOSDh4NTVoZ2FwY204TXdaZ2FhSHZ5WVB5S1JkRXl1VWQ0?=
 =?utf-8?B?Qy83YmpuRFQxZEFaYU9FSGJoaVhWN0d2SDJxMm5pcElYN3hydjU5WVd4N3lT?=
 =?utf-8?B?azRGbHVzU1hwUUFFMnRUNG1XdGltcDJ1TUpJTElJZjdUQVJwWE1oeVRNanhW?=
 =?utf-8?B?dzlpR2pLWThzU0FxTkwvM1FNcWNKOUhnMDhGOTJjYndFRmg1bENGLzRFTXZE?=
 =?utf-8?B?QlFkZUdIM3p1cE5UWFpRUFFtQ0F3cE1OQmJaemhXVEdQNVY3cDBSMnJ4N0p1?=
 =?utf-8?B?Q3VUTlNCczljZDg5czE4cU5HY3FHeXRkQ3Qycmd2ZVdnL2pYTGF2ekRXS09t?=
 =?utf-8?B?cjMvQ3Jpem1tbDhsWkx3ZEVXNkd4VHQ2ZWhZM296R1g0VStzbng1RDdMNERO?=
 =?utf-8?Q?rtnJ3sLLXcbVC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHpEN3RucjJ3Z0tLd29kandZSXlYUzJOQWg2RG53VDQxTWNQZUZuMUVVSkxz?=
 =?utf-8?B?SkJIcEQ5WFNxazcrenNRYkhBRVRhdm9DbTBCTXNraWhsZSs1YVMrdCtBL0RL?=
 =?utf-8?B?VEhEaFFVenlIMVBXdlRjVU02NThMTU5GU2VqTVQrcFNsQ2E2cXlJQU1CdXJr?=
 =?utf-8?B?c1RhQjE3SDluM1IxaXJ1dlBPQzU4QklDQzdwWDFCcWd2MUFNVHIyQ1FERUI1?=
 =?utf-8?B?bEpYYzRHSndic1k5bS9tL0EwVWxBTmlMTWp6ME5NK3doU29IbDJGU2cxTHM0?=
 =?utf-8?B?eWJrN0FrV3hNdVVtakVnTVJ3VzhaZzZvTHEyZXh2Y20wdHZrZW1NNUJpQlQ1?=
 =?utf-8?B?Snh5bnM0bEYvYS8vQS9yd0l5Q3FhMWNYb3duMHZEZ0dlZHRhVWJoL1JjL0pX?=
 =?utf-8?B?bGFkMmUxYXpZM1o3SlRyRWRtTDREUkJzeDlLRHFBOFo2WWhRY3dCdWVzc2Vn?=
 =?utf-8?B?Q2YrTUFJcG1KcVA0d08vd2tOWjV5dHp6Mm8rSXNvR01TQVdDRjZVdHEyVjlq?=
 =?utf-8?B?aUhXU09sbERLRWlvN0VPTUpPb3FNQTk4QUtwWTkvRHJrRG9jTHBOZCtxcmFz?=
 =?utf-8?B?YjFhZHpXTHhsWU1kRXF1ZnZrMTliL1U4cndCWUgrdkdCdllhUS9xMXZvZVJD?=
 =?utf-8?B?RDU0KytRUWF0eWtHMlVRZ1Y0dWpxWG1GL2hoZXhhNFhQS2d4Q3pBS21DVDZs?=
 =?utf-8?B?ZGVNeDArQjJISVF4WnFXNzFzSFYrMFNVUzdrNEg5dWJlWmRLc1RkY3I3eC9k?=
 =?utf-8?B?cmNudnJaQ2tubGJvc3c4aTBMRHlkZVhCWEo5cFhtcm1nT2dtcllQcVl3alh3?=
 =?utf-8?B?SklKTmI3b0Y1M09VYlVaU1pXMDRxLzFDZ3pVeE1HWXJOM21zdGVJdVhrZ3l5?=
 =?utf-8?B?WnU3cFBzYUE3NktrZFBKcXd1N1piZmdmM1Y5TVVseVorWC9HVmZ5VGZ3T0Vl?=
 =?utf-8?B?eDFjZDJZc2FPQUp6a3JBNVAycEFtSGhrK2NlS0JldGxuRVBKMmdvLzhJYVFJ?=
 =?utf-8?B?TngxOEJVUGxaN0RrYmZvSjR0Q1UrVGlwckZJWFdaRmZRaHNZWkNaZUNNdXpt?=
 =?utf-8?B?czk3VHhMbzVJNDRvSkRMekwwZXZGdHNlNTBuVnJ1OXNOWS9tK1hkWjFROWcw?=
 =?utf-8?B?QWZDRnBiWVl5TmVBUjlWVWxSL01SQStaY1ZZK0d4bVBJaGIzZEVTL1JtTTcw?=
 =?utf-8?B?TkRFTnQ4MkZNMFVyMDJsZDlsRDZVM2dNWlo1Zk1ORGJkZHIrNnU5eEFJMTNl?=
 =?utf-8?B?OWZER1FLbXc2azdwckJEMjhwUUlIUTZZMWN5Vzh6ZkdFd2ZLZVRnR0tCK2pN?=
 =?utf-8?B?aGdDbXNiZGRLMVArTXIwSGUzUktnTHdmYzFGNlVlNG9SekZMQW9lWk84SENp?=
 =?utf-8?B?TjhwVElkV2Y2QVU0cXZrUXBwdjlPN0RFQlBRTFpWeWN3VHEvYjJoRXJuRW1Y?=
 =?utf-8?B?WjhZL04wSHBOWVJCZHlYdGtFY1NsVUQ2ODU5NENIL3ZydWhWTlo3L2t1TFNl?=
 =?utf-8?B?YWU4N1UxQ0ZpYzlNdkRjdmw2OUJ3bXdHRUpZTnNDU0NNOFZVSW5tRGx1NFRU?=
 =?utf-8?B?Mkx6b2ptdlZVenYyelZYd2Zkc21Yc3hQdi84NS9GTEsxNTE4ZUdDSm5haGZO?=
 =?utf-8?B?Tk5SZ3ZITWlRdTdkd3FwdW5FdCtHdFpSZFlsTWlyUGk2WmFzeTRSV2pvYndk?=
 =?utf-8?B?NEJCanNoeUg2OVJ3S3ozQWlPekdLeGdFOEdrTzBoOEpSaDA0Vnlra1dHTmI4?=
 =?utf-8?B?NUdJUEZvUVJsOGIrbWNvWFV3cE8rYkhQQ1lwNllTanNseEd0ZG9rMEpvd2pM?=
 =?utf-8?B?UUVpcUtNRmNmWjdYdnBiTy9JU25SL2xmMjdOYWFHUXJjMEZqSk9CdlRWdmJw?=
 =?utf-8?B?SitLd1JzN01FZEJoTi8zck1RK21sSXdwdkR2ZzR2WXkxNFBYazdySERmMHlG?=
 =?utf-8?B?Qmd5NmhKak9NK0VFc3hQalN4NUNnaFRsUXpHTis0SFdHZjdkRk15Z3U2WGJG?=
 =?utf-8?B?Q3Rxb25ZVEVVZUxxSWFpTERud2RUdXhlejNvSjBlM2xDK2M0RFN3V1NzK1Qw?=
 =?utf-8?B?cGxXcXNpeUdIWUlBK0JGaHNEWEQycGZVSHJCZ3pZdXVJTzI2bWRaVlFuNnFn?=
 =?utf-8?Q?sm5xunJvLdLg9AXOI9Tf4tnQX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b87c80f-1175-4831-4f2e-08dd54b498f9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:21:19.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA6zBuni3yySuTUDUp6gHyaSweqCJvLCaj4qDXdO+2GIuv3kP/mOV6in4QWcKF1XP7g0zAY8uASKtah87naOog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

On 2/20/2025 2:33 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The CPPC enable register is configured as "write once".  That is
> any future writes don't actually do anything.
> 
> Because of this, all the cleanup paths that currently exist for
> CPPC disable are non-effective.
> 
> Rework CPPC enable to only enable after all the CAP registers have
> been read to avoid enabling CPPC on CPUs with invalid _CPC or
> unpopulated MSRs.
> 
> As the register is write once, remove all cleanup paths as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>  * Remove unnecessary amd_pstate_update_perf() call during online
>  * Remove unnecessary if (ret) ret.
>  * Drop amd_pstate_cpu_resume()
>  * Drop unnecessary derefs
> v3:
>  * Fixup for suspend/resume issue
> ---
>  drivers/cpufreq/amd-pstate.c | 187 +++++++++++------------------------
>  1 file changed, 55 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fa9c581c68a39..f152636cecbeb 100644
[Snip]
> -static inline int msr_cppc_enable(bool enable)
> +static int shmem_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	int ret, cpu;
> -	unsigned long logical_proc_id_mask = 0;
> -
> -       /*
> -        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
> -        */
> -	if (!enable)
> -		return 0;
> -
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		unsigned long logical_id = topology_logical_package_id(cpu);
> -
> -		if (test_bit(logical_id, &logical_proc_id_mask))
> -			continue;
> -
> -		set_bit(logical_id, &logical_proc_id_mask);
> -
> -		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
> -				enable);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	cppc_enabled = enable;
> -	return 0;
> -}
> -
> -static int shmem_cppc_enable(bool enable)
> -{
> -	int cpu, ret = 0;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	int ret;
>  
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		ret = cppc_set_enable(cpu, enable);
> -		if (ret)
> -			return ret;
> +	ret = cppc_set_enable(policy->cpu, 1);
> +	if (ret)
> +		return ret;
>  
> -		/* Enable autonomous mode for EPP */
> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
> -			/* Set desired perf as zero to allow EPP firmware control */
> -			perf_ctrls.desired_perf = 0;
> -			ret = cppc_set_perf(cpu, &perf_ctrls);
> -			if (ret)
> -				return ret;
> -		}
> +	/* Enable autonomous mode for EPP */
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		/* Set desired perf as zero to allow EPP firmware control */
> +		perf_ctrls.desired_perf = 0;
> +		ret = cppc_set_perf(policy->cpu, &perf_ctrls);

I'm thinking do we need this "setting of desired_perf" as a part of shmem_cppc_enable, 
one thing is we're not doing it in the "msr_" counterpart
also, I guess this would be taken care as part of amd_pstate_epp_set_policy()->amd_pstate_epp_update_limit()->amd_pstate_update_perf()

>  	}
>  
> -	cppc_enabled = enable;
>  	return ret;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>  
> -static inline int amd_pstate_cppc_enable(bool enable)
> +static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	return static_call(amd_pstate_cppc_enable)(enable);
> +	return static_call(amd_pstate_cppc_enable)(policy);
>  }
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
> @@ -1115,28 +1060,6 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(cpudata);
>  }
>  
> -static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
> -
> -	return ret;
> -}
> -
>  /* Sysfs attributes */
>  
>  /*
> @@ -1228,8 +1151,10 @@ static ssize_t show_energy_performance_available_preferences(
>  static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
>  	ssize_t ret;
> +	u8 epp;
>  
>  	ret = sscanf(buf, "%20s", str_preference);
>  	if (ret != 1)
> @@ -1239,7 +1164,29 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = amd_pstate_set_energy_pref_index(policy, ret);
> +	if (!ret)
> +		epp = cpudata->epp_default;
> +	else
> +		epp = epp_values[ret];
> +
> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +					  epp,
> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> +					  policy->boost_enabled,
> +					  FIELD_GET(AMD_CPPC_EPP_PERF_MASK,
> +						    cpudata->cppc_req_cached) != epp);

We are doing the tracing in amd_pstate_set_epp() as well right?, Isnt this one redundant?

> +	}
> +
> +	ret = amd_pstate_set_epp(policy, epp);
>  
>  	return ret ? ret : count;
>  }
> @@ -1272,7 +1219,6 @@ static ssize_t show_energy_performance_preference(
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> -	amd_pstate_cppc_enable(false);
>  	cppc_state = AMD_PSTATE_DISABLE;
>  	current_pstate_driver = NULL;
>  }
> @@ -1306,14 +1252,6 @@ static int amd_pstate_register_driver(int mode)
>  
>  	cppc_state = mode;
>  
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret) {
> -		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
> -		       ret);
> -		amd_pstate_driver_cleanup();
> -		return ret;
> -	}
> -
>  	/* at least one CPU supports CPB */
>  	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
>  
> @@ -1553,11 +1491,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
>  							      cpudata->nominal_freq,
>  							      perf.highest_perf);
> +	policy->driver_data = cpudata;
> +
> +	ret = amd_pstate_cppc_enable(policy);

I think we missed cppc_enable in "amd_pstate_cpu_init". Confirmed this by booting with "amd_pstate=passive" 

Also, one weird behavior I saw while testing this part, if we boot with "amd_pstate=passive" 
initially, the MSR_AMD_CPPC_ENABLE register is 0. But after I run the amd-pstate-ut (which fails 
the check_amd_pstate_enabled() test the first time) the MSR_AMD_CPPC_ENABLE gets set to 1. But I 
didnt see any code in amd-pstate-ut that sets it. We can ignore this quirk for now, just 
mentioned to see if you have any idea about this.

> +	if (ret)
> +		goto free_cpudata1;
>  
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	policy->driver_data = cpudata;
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1649,31 +1591,21 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> -
> -
> -	return amd_pstate_epp_update_limit(policy);
> -}
> -
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	int ret;
>  
> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
>  
> -	ret = amd_pstate_epp_reenable(policy);
> +	ret = amd_pstate_cppc_enable(policy);
>  	if (ret)
>  		return ret;
> +
>  	cpudata->suspended = false;

Do we need this here?, shouldn't only resume() have this statement?

>  
>  	return 0;
> +
>  }
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> @@ -1691,11 +1623,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	/* avoid suspending when EPP is not enabled */
> -	if (cppc_state != AMD_PSTATE_ACTIVE)
> -		return 0;
>  
>  	/* invalidate to ensure it's rewritten during resume */
>  	cpudata->cppc_req_cached = 0;
> @@ -1703,11 +1630,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  
> -	/* disable CPPC in lowlevel firmware */
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to suspend, return %d\n", ret);
> -
>  	return 0;
>  }
>  
> @@ -1716,8 +1638,12 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> +		int ret;
> +
>  		/* enable amd pstate from suspend state*/
> -		amd_pstate_epp_reenable(policy);
> +		ret = amd_pstate_epp_update_limit(policy);
> +		if (ret)
> +			return ret;
>  
>  		cpudata->suspended = false;
>  	}
> @@ -1732,8 +1658,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> -	.suspend	= amd_pstate_cpu_suspend,
> -	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.update_limits	= amd_pstate_update_limits,
>  	.name		= "amd-pstate",
> @@ -1748,8 +1672,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> -	.suspend	= amd_pstate_epp_suspend,
> -	.resume		= amd_pstate_epp_resume,
> +	.suspend        = amd_pstate_epp_suspend,
> +	.resume         = amd_pstate_epp_resume,

Spurious whitespace change?

>  	.update_limits	= amd_pstate_update_limits,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate-epp",
> @@ -1900,7 +1824,6 @@ static int __init amd_pstate_init(void)
>  
>  global_attr_free:
>  	cpufreq_unregister_driver(current_pstate_driver);
> -	amd_pstate_cppc_enable(false);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);


