Return-Path: <linux-pm+bounces-11091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F8F931151
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F731F2315E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1268186E4E;
	Mon, 15 Jul 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TEN0z/Cr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732C186E44;
	Mon, 15 Jul 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036167; cv=fail; b=OyZDNWzPrFYw6PCd35t5IRyD2rRal3ecRCP4aJcQIFaJ9mBRwZCnX9ljIL/JzNWfgzjRpROkVQfHpfZU2RcL2wSIG+Bep6zwuMNEV2Cr+Yje94dEbAlohhXu1OAD3U/ws/J65QnpKfFi91KVriz3K+oZXHlefr/wc9yeB22Xoak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036167; c=relaxed/simple;
	bh=+dsgDHiDuWJ7/YY8o0Y5M0PxZAeFHW0hH2lcw3Q2LQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DTkIYqMsZWjHYkfNBUHfmBBQga0HgbqN4F8QnBtAoBFI+Hf/FcP2ebYgn9ShN5FK/s0gfzG4nV0VcIiInHPOrZ8AWe3snrO6WUroKearoGs568tKgHF4S8H58MYDss2dgzQ60rGpRTUCMDbeylyue8Xc8rOCv3jVtqsooLocMYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TEN0z/Cr; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df9mqb2LmuuW328f5e9si+AEqfFx/rj6mhHlJALjihtFJJ4sXX38yOWhoRzzCxS+BGbC4X6/BV3pPfn+QtRcqigZgDupig5tPHxkF9flqHmxNyDt6ja8cyh6y8rIvTkY4qGycrELKbjA1IyOoqjGfHMsCYqCTDJIltJdEverVtrUW8GPhzhprqNs5/W24yJNdvxWYzxmHiCJAi0Yo1OAOzTxPRnr87/xHvUvdk0yiJA747JsNtdJ82eWwZ2P02HaBUCWlfYEwP5UmB/v/omOBo0/SjTHPfaMHLXQ7X+jmysl/7pKFRNXZdAWH054VtyTK4JIqGDXWqtApK14reVpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Os/GASZXDAzaICvQZlgyBoME4/y0fhU21IKbI261LA=;
 b=UYTWEglbktULq337Fd4iR/bjCyspp7dYFkzDxwdvnhEh3V5kCydLl+r5XMu+8jD0/e+A4I8KBA/qwt7HKorZITuXwflzOPC7cAuYYgE2MFIsp0738pZz9ni7+mTb7+nQC44n80a1JEzVG7DOp9tRS5Fp8Nd4Tr7KjsNywJEMDaZ2YQXDaG+mQr1geYduEBsWx9BXw5g3aFGO3XWC0xb2kzd52lPx73BWGPmE3qF3+6PqwoFASAvmOheQsFHOmnB+J9zTw2khGDrAvgfZXxmbVWQ3O6xBPPnN371h30lKNixwCgRyDtL33dKvTIXhGYwk1I3dQ1cwiNSW5+fjkbuyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Os/GASZXDAzaICvQZlgyBoME4/y0fhU21IKbI261LA=;
 b=TEN0z/CrWWN/lVOc6j3KF3NVD0cp6l9V1srDmy5RMT8eA/SzcRW0I8Fv2ioawcM8z6m98pkWZKzSEL2Mr/Vomb3xS6g7iDC59nVa1cscei31mHYctFqgLM3KD5V/wX43oQ84I6s6GcWqKUwKKq9B2MYuimJQgCNx5qJbyVdd2Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 09:36:02 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 09:36:02 +0000
Message-ID: <05e96873-12a9-4b1f-b1b3-1db7647211ce@amd.com>
Date: Mon, 15 Jul 2024 15:05:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Add per-core RAPL energy counter support for AMD
 CPUs
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, rui.zhang@intel.com, oleksandr@natalenko.name,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 sandipan.das@amd.com, linux-pm@vger.kernel.org
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::8) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fcf6a6-3066-446b-36c5-08dca4b18aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEtUQ3MxT3FxVkswQjZFYXBvL2g1RzZMSnRLV3pUUHhLVFFKQ1BleVNvc3Yz?=
 =?utf-8?B?ZjVRcHpVc0tkMXpJSXN1bkpoaGRpTGVjNkxFb2ttU1ltUmtrem5jVnF3aERs?=
 =?utf-8?B?QzY4M1E3MS92dWtwemNKUndRbFBlTUVOUlRkdHBlVjU1TG0vUGtMR2lWM3E1?=
 =?utf-8?B?Z1l6LzMxSTlSTjNRZWFMb2RhMjltQy96bTRYa0gxU3dxbjcva0tCcHJJVHRL?=
 =?utf-8?B?ZldmT0lCenBBZUFSdDlRWk1kaHliMHJiNWZhUVZyUkxET056bnVCMmJxRkRT?=
 =?utf-8?B?UnVmdmZMKzVzZy9yWXd2ait6SXAyNnhMZklqMXlaNUVFMW92Q1Vvdk55Ukkw?=
 =?utf-8?B?eVlEMm93cVpRc1IwaW1UTzFTZys2OXovT1p5N2NnVUZaTDArdFBYUU9HT2Rm?=
 =?utf-8?B?YXZxVVhkS25kMU91SmVZajg4bC9XR0M1U2NIc3RNNERXRUM2N1hQeEJhdkQ4?=
 =?utf-8?B?RFdrSkl2TjNkc01kdGViNFJNaTFHR0dvdTY5R3d3bno2K0dkc0ZxeG9uNXJl?=
 =?utf-8?B?YkI4cGttaDdxSU9TVW5oR0U2QVh0M3NQVFUwWUhjY2NhMDJrVHVNZVNKTWRz?=
 =?utf-8?B?UEp5NVM4ODArT2JqZ2RtRWt5eEVwdXh4SXMrRkJmYjhKdkFPYWhFK0YvV1dR?=
 =?utf-8?B?amF4U2N4TkxkWmZVdHNZcVJwUE9mWDh6QnFrNFU0SjBiK1gxcFc5cEx1OEFN?=
 =?utf-8?B?Q0U4Vk4yckdVbThGQjEwOFpHMks4UHowb3R0UnJDNHRnems0ajA3VHFwZlV0?=
 =?utf-8?B?SG5GUHlyQTMySkRQWHc0VlpKL1pPbk5RbzBjdG5WZ1FlcHo2MjRBVG1aTWli?=
 =?utf-8?B?c2lZWmhPK09IK2hLOXY1VVJSLzA3bkFNbjNsMDdGQWlOQ1dLTWJwL0gvZlov?=
 =?utf-8?B?VXJlQ2xVdUpzUSszUVRrZEJCa2Q4UTJaZGhFTXZYVENTdCtjR09KUVMvRUhL?=
 =?utf-8?B?RlVROXB5bzhiTyt2a1FjcHEwenI1M1JVS0I2aHlPTVVRaU1Hd3cyQUUyUGxr?=
 =?utf-8?B?MVlhN2tBczg1a0JUWk8xSlRZWTNQQVFOQnhUYXg4MkNVRW8yV2s2MERuUTg4?=
 =?utf-8?B?L2FHVEZHdnZrUDJRYnBYY1pTMkYzR29ObEh3bTZCb2NDWUlaL2tNdmphMG84?=
 =?utf-8?B?M0k2Ukp5Q3JjempXcm5jNjNYdXdKYm1XS0RqckhSZFJWMHA4UThPd01wQU4w?=
 =?utf-8?B?UXl1YXJ5Nlg4VmZyUmV6b2l4U2ZQZzVGRDJJUzUzMm95b3hmVjdvTXdmM1Bl?=
 =?utf-8?B?TEg1UDJSR2wyY2dFVElkWFJIaHpOQ0RUUjZPZW93ZE4yNGVLOG9DOHFma1hX?=
 =?utf-8?B?em56MCs5cmlMNmtjYTdHaWQzK3lSeCtNUy9JNzRlNlBUZDBmT1pxTzVsckVK?=
 =?utf-8?B?T3poR2o3dTZYUmVnc2c3RDhJenRSaDZLclh5MFpnYkJ1bWNteVZnRWpZbk1a?=
 =?utf-8?B?QW90b0RabTVJa2NWcDY3aGxiS2I3SndOa2RkWW8zbXY1VUp1TWExYmxRRUR4?=
 =?utf-8?B?ZzRIVTE4TEpOdFJwVnhVaUtjZk1hc2NPSlF2cklCZ0JRWHBRM1VUZXJ1RkRY?=
 =?utf-8?B?R3VwY0dHRDJCc2w3Rmt4cXdOWElPT2xhOXhRanN1a1UrZnNmR1MvOVNJZ2FU?=
 =?utf-8?B?RGxhM0JybjlBUmxRTitWVW0zRDA3dFFHb0MyanlOcUZKMDFPdmo2UU1DVm5o?=
 =?utf-8?B?NTAvRG40dmxPVnlSZ2RyOFdPekdVYUhwRUxSZWxUNjhEOGpESzUzaW5KNUw3?=
 =?utf-8?Q?tzepNlv3rjnfc12RxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zy9JTktpYURVL21XRUtlc0FQU1E2d1Z2cWlsVy9PZUMxSWtuT2dvVDRsdWdx?=
 =?utf-8?B?OXBuVHBhQy9lRnB0czRLQW5iS25tNitNdXhEd2tTTGUxcHJLNVhLK2d2UEUz?=
 =?utf-8?B?VUhmUEF1U2huRnFBd25nMy81VjhZYnBjMmV1cTZRNE5LTVNCalFQeTZSRzZk?=
 =?utf-8?B?NDVEYUIzYkp0T01haXp5anlyOFJEOTh4TzN5Z2JIbWVhN2t3ektoM3paYUZ2?=
 =?utf-8?B?VGljYUROS0xNY1RSOGhFZDR4SmpOVUdaTlhVa3lNYU85TFgrbXlsU0lHSUhz?=
 =?utf-8?B?Y0Q5dFhPSWJKSW1OVDZDQ3pUMmhiNlpRaGlpeFhaeHQrSHAwaEVZbW0yL1pk?=
 =?utf-8?B?QTJIZnAyZnhKK050Y2o4U2lQaWU1VGhSVW8yNTVFZWRMblJGWWJnR0lOQVhu?=
 =?utf-8?B?NVVjY2dkb1lzYXVUTzY5SmZzUHZUQ0ZaQ21mSUZiRmtVcU9SdC9GaStBL3NP?=
 =?utf-8?B?NGdqZDl4L05sNWFDUjNJV3ZqcEZiL21UYk1MakpNcmJOVEU4OHk3MzRucFc2?=
 =?utf-8?B?ZDVLSnp2QnlTUHRQcHJNRUI1R09NRE5ySnlJSHFQNWJsS21mN3JDUHJmUC83?=
 =?utf-8?B?cklVWlg0R1JIVStyRksrYmVFc2pkeXdPTHRsQ1MycE1QanpZQVRDOGtLaFhU?=
 =?utf-8?B?eWU1THhYYmc3TGpVem11OS9DaXJYdFRBdGZmZndQb3hqMWR3eGRGVnlxTVNL?=
 =?utf-8?B?MmY3dDhZSDRNbjR2NUR2bEhOM2JEK3UzZ3FHNndXaEdLUnpvNWlDaERjSmlz?=
 =?utf-8?B?NXIwS3FwMnFHaXNicFJsWi9Ca2NsZmRvYUROR0RtYXFGOXh5SjNnNk91c1Js?=
 =?utf-8?B?WEZkRmpocnZNWEhld1ZLUFRzZGRBRDlKNkNrQU9kL2lyOFNOb0ZxSEl5bm1C?=
 =?utf-8?B?ZEViWjB6WXVDdVEvZXlFRXhiWEpBK0dGbUxaMXQ5dFhzVHFBbWZXeTMzdkpB?=
 =?utf-8?B?aXB0STViT2t2NlVtcVAwUEdlNEVDTnh4cTR2Tys3dStlK2xXdE5QdkpqeTgw?=
 =?utf-8?B?YTNJMEZnRC9IcU5DUlRCTUpQZGx2bTJTa2tObnJxUmxGU2Nab3pKaVZkcnhi?=
 =?utf-8?B?VUdTcUwvVjZPSm1VN0o4MEVpNjJHdzBEMnZUcmNOMk9nNDM3YldoLzNDSVJ2?=
 =?utf-8?B?OWp2dnZjVFZkcVRQZnRjSERibFlVQ2NpY0hGcVRvbFE5OUI5UWVNbmkzWEc3?=
 =?utf-8?B?QitqZjA3Q0QveTZySmtBeWVDWURLTmppZGphOHBFK0FTNGgxWXZnakVVUnFh?=
 =?utf-8?B?WnlzZFRyME1VcWEzS1ZNZ25rRHdqUm1PSGZLUjZ4ZVk5eTcyZWxHcnh6TkUx?=
 =?utf-8?B?Nmg0QUVMc0Z1ZHJpaDYzYTJ1bnpHV29RS1o5aSs4bk5TYnBhQ0hKUFFGeHFu?=
 =?utf-8?B?S1lnb1JOYWo1UzIwYk00cDlRTFRoNENVNDdRUVhtd2tXMWNPa3dFLzhFdU0r?=
 =?utf-8?B?ditUTXhpbHFVSmpqT2ZJK1RsWGw5dUY5ZWljTWFZQWRzV25VdkJZQ1FsbmdU?=
 =?utf-8?B?SE5oUnpXdk5FNlVtNVRjRFJGUTVFNGRoQW5CbVFHVHBVL2U1dnZ1d2VvQmpp?=
 =?utf-8?B?KzY4WUtsamI3U0NwQmNheXY5V2xBTTllQWx5WlhzRXdDZll5T1dINmdvTWIz?=
 =?utf-8?B?ajJwRGxCdEE2U2IwbFFEOWVPUjQ4TWRMVnZQUHR5NVNNSVk1R2huS0gzT2ln?=
 =?utf-8?B?ME1HV1JlMFRPZ0haNnhqUnlhdzNEalJ4VEM4SnlJUm1uWFBHakk3VUZiVWVh?=
 =?utf-8?B?aXlLRHQ4NnFtZjFnRG5oUmZEMnEvYzdmWUIxODRrQnRwZVo3VGFNWDhBaFpp?=
 =?utf-8?B?NXF2M3BxVjVHMmhscnh6NmlXVkhwMWt0SWRZTnR6MVNBcHhaeFd2bmU2aEpw?=
 =?utf-8?B?dVE0azdnbDh4M2hES09BemlwR0NSY2g0NTNtTkRiVXNvbjhPWUs1enZMZEZy?=
 =?utf-8?B?WDVubnc4ZUZ1SXBGd2pna3hKNzdCbVZCRVduSkRBTFFESnFIRHh1NldCTHZ0?=
 =?utf-8?B?eXBhampsZXFONWp5YUtBeU1OU001RWNnamdzQ0UySjFnRnRVTjJsclFmam1N?=
 =?utf-8?B?cld3UUJhRVNkQitNaEJNalFRVkNOWjlmWEdGZHhuUkpMcFRnakRueEZkTXhJ?=
 =?utf-8?Q?McmHP0i97I+khFeZJy+pgO9sb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fcf6a6-3066-446b-36c5-08dca4b18aaa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 09:36:02.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x11tX9op6YsujGjbarCv5EpJ7KY4HGlp4m/Znwp74YgNxO7S/ySH0j3Lnvb9ZpNDHcEXhMyA0phL5PrAk55HcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

Hello Ian,

On 7/12/2024 3:53 AM, Ian Rogers wrote:
> On Thu, Jul 11, 2024 at 3:25 AM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
>>
>> Currently the energy-cores event in the power PMU aggregates energy
>> consumption data at a package level. On the other hand the core energy
>> RAPL counter in AMD CPUs has a core scope (which means the energy
>> consumption is recorded separately for each core). Earlier efforts to add
>> the core event in the power PMU had failed [1], due to the difference in
>> the scope of these two events. Hence, there is a need for a new core scope
>> PMU.
>>
>> This patchset adds a new "power_per_core" PMU alongside the existing
>> "power" PMU, which will be responsible for collecting the new
>> "energy-per-core" event.
> 
> Sorry for being naive, is the only reason for adding the new PMU for
> the sake of the cpumask? Perhaps we can add per event cpumasks like
> say `/sys/devices/power/events/energy-per-core.cpumask` which contains
> the CPUs of the different cores in this case. There's supporting
> hotplugging CPUs as an issue. Adding the tool support for this
> wouldn't be hard and it may be less messy (although old perf tools on
> new kernels wouldn't know about these files).

I went over the two approaches and below are my thoughts,
 
New PMU approach:
Pros
* It will work with older perf tools, hence these patches can be backported to an older kernel and the new per-core event will work there as well.
Cons
* More code changes in rapl.c

Event specific cpumask approach:
Pros
* It might be easier to add diff scope events within the same PMU in future(although currently I'm not able to find such a usecase, apart from the RAPL pkg and core energy counters)
Cons
* Both new kernel and perf tool will be required to use the new per-core event.
  
I feel that while the event-specific cpumask is a viable alternative to the new PMU addition approach, I dont see any clear pros to select that over the current approach. Please let me know if you have any design related concerns to the addition of new PMU or your concern is mostly about the amount of code changes in this approach.

Thanks,
Dhananjay

> 
> Thanks,
> Ian
> 
> 
>> Tested the package level and core level PMU counters with workloads
>> pinned to different CPUs.
>>
>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
>> machine:
>>
>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>
>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>>
>> This patchset applies cleanly on top of v6.10-rc7 as well as latest
>> tip/master.
>>
>> v4 changes:
>> * Add patch 11 which removes the unused function cpu_to_rapl_pmu()
>> * Add Rui's rb tag for patch 1
>> * Invert the pmu scope check logic in patch 2 (Peter)
>> * Add comments explaining the scope check in patch 2 (Peter)
>> * Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
>> * Move renaming code to patch 8 (Rui)
>> * Reorder the cleanup order of per-core and per-pkg PMU in patch 10 (Rui)
>> * Add rapl_core_hw_unit variable to store the per-core PMU unit in patch
>>   10 (Rui)
>>
>> PS: Scope check logic is still kept the same (i.e., all Intel systems being
>> considered as die scope), Rui will be modifying it to limit the die-scope
>> only to Cascadelake-AP in a future patch on top of this patchset.
>>
>> v3 changes:
>> * Patch 1 added to introduce the logical_core_id which is unique across
>>   the system (Prateek)
>> * Use the unique topology_logical_core_id() instead of
>>   topology_core_id() (which is only unique within a package on tested
>>   AMD and Intel systems) in Patch 10
>>
>> v2 changes:
>> * Patches 6,7,8 added to split some changes out of the last patch
>> * Use container_of to get the rapl_pmus from event variable (Rui)
>> * Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
>> * Use event id 0x1 for energy-per-core event (Rui)
>> * Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
>>   per-core counter hw support (Rui)
>>
>> Dhananjay Ugwekar (10):
>>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
>>   perf/x86/rapl: Rename rapl_pmu variables
>>   perf/x86/rapl: Make rapl_model struct global
>>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
>>   perf/x86/rapl: Add wrapper for online/offline functions
>>   perf/x86/rapl: Add an argument to the cleanup and init functions
>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>   perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
>>
>> K Prateek Nayak (1):
>>   x86/topology: Introduce topology_logical_core_id()
>>
>>  Documentation/arch/x86/topology.rst   |   4 +
>>  arch/x86/events/rapl.c                | 454 ++++++++++++++++++--------
>>  arch/x86/include/asm/processor.h      |   1 +
>>  arch/x86/include/asm/topology.h       |   1 +
>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>  6 files changed, 328 insertions(+), 134 deletions(-)
>>
>> --
>> 2.34.1
>>

