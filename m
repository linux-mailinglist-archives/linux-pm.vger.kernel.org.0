Return-Path: <linux-pm+bounces-25285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C61A864B4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 19:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943C9188C4A8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E25224896;
	Fri, 11 Apr 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ahi7LpIQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D122367D0;
	Fri, 11 Apr 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392322; cv=fail; b=ZnYH+LHZOmC2jxRra6iwDp+oZBo86bjkWO7VD2KyMhZNgGKMkZa27RdLn1neXl+sXVHPVRBRC7A/FFecjLuHHGYhDndWMLWvEDzRaKeFrUypOGZmFh6WtenWa0hIS8jE0Z0UrOSDUl2UJyEYqp+rp+EObUIVq8lKQOYLLbZqVNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392322; c=relaxed/simple;
	bh=oGtcKkhPKlbtqjUxB3crMGCXBC5U81vg3SQVKTUtFgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBGJ8Ih5Den8d6RWng+2WZB1M7A6MUE+MZlQp0Jhf1oo3q5e6EsMcejlhNXV8TL6X//+05O3GyYd1ubTRBYrFX8NEob4JPtR2scaSHz8ZkBcaGPaJ5brBAHtn3QnsFQYFike0H97doOMIoJKJHqBe7ykTbjweydfoQnFPH8+b10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ahi7LpIQ; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c66VxcZgbAVusp4N5dO0uy5gX+IeQHZ0SVKth27GCx3+7Ma0sd9iMlqH9yAwnRSKHn7byEGNsd2R4ZrjDmW9UE9CZh132ROBT6FVYFR8v+vFYxaiLH8MiUbmPU7ZglHUzKsdjn5UIH1QpY2Yg8K8D2DeNmTBlsLcJwwMOJcg3O+sDoaUn82NktCTLzK/Phq43y9Wbr9QJIWJ9yHF2ntyn5n3FWcOX/hYXz0udLOz9xc/s2zw2TxyAyBTQoFXqlfSbWK0QxN0P5YexOiqhPC816wfFT9FIKZBictkpDSRTIqFJYts5Ta/X5ZmYm49/xq0VMJyP1g8P4NmuIPjUbfv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEZ93H7wRpJd9s5DuYKg1vq0bhxrUbKCeZu+4iF1FMU=;
 b=U0v/sW+xKA9lVGiOevp0SGtdZQxjtGstNSoMSV7hLlDjDk3A17NszEdsLhs5IcnzS1YAmyvAhdzNBtI71mGH1hGJ++LkpXsnNIdqauL5czsch/hZuBCoKFqUnaYknyuoDPb8OFLiObFDQN0KOZvBvePCgR177bS2H6/uXpaAekky7IcQjvUfU1m0YzCVS5d3ePjKjp4+eiiwCcz6N/0QQuZTc8LLFgpCWkuGJv00xu6FcreKCFBC9biDxl42+Rt1EELVNp5eWHFExslUNBn917tIJ94oEG4OgKDTZMSkrDZv0FxY6f2v20+ToGmPLCS2zGkP6l0tEdtAORIQWDCztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEZ93H7wRpJd9s5DuYKg1vq0bhxrUbKCeZu+4iF1FMU=;
 b=ahi7LpIQ6hBIPcCLXlF3/5ybL3VGSwWbpm0AnN7Vz8itV3FYHVyN6ppwZH92zA4uLoEhxN7bIc85OtJwqIsGLEC3AxRr6bVi1qLQ22GaHxY3fb9w+6w2Ow3oWLgM+pBF2W6hEr+302SkOle2TDiGxSfPJPHMDYdQfdN6VmaCJpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 17:25:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 17:25:15 +0000
Message-ID: <e0f66414-e960-41a7-a8d2-06437405a3d5@amd.com>
Date: Fri, 11 Apr 2025 12:25:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Enable ITMT support after
 initializing core rankings
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Meng Li <li.meng@amd.com>
References: <20250411081439.27652-1-kprateek.nayak@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250411081439.27652-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fcab04-a210-4637-1b4d-08dd791dd2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZktDTGVNUVVmQXNFL0pRbm5LeGc5b2x2T1lnZ2FZQTZjSGJDaEw5UFRwTHpP?=
 =?utf-8?B?cDZyOFM3cmxSSWJUbmh2cnhFSDBKUkhaYzlrUkVQdm53QU4rc0RQaTFJMVp5?=
 =?utf-8?B?QW5nWG52azFRMkdib1BqK28yNDBZcWR2V2ZQZmZoZENYb3VCRDdCMFlwazZR?=
 =?utf-8?B?R1VCajBqNVVwSFN1ZG9pSm43c2xJMkFZaDBNbWFTeDlackcremovMThNa0dC?=
 =?utf-8?B?dHY1TkZETXdtaGsxYk9DQm05TUNSL2pweEJWZTBYcjNEWGlNODhWeElmUjRt?=
 =?utf-8?B?Qm1hRkV6dVl2bDUxZUJMMm5NSkpra1ErSU44a3hIMThXMTBjVzhCNTd4aExE?=
 =?utf-8?B?T1JZMmxJckd4SWNDbWFuSUNXOUdzVjFUTzhzRGgzcXFJNVhrUmFlZEhobjRk?=
 =?utf-8?B?OVN3OG9LL2Y4RmNCNzQzSkl0bUZTcEtXOTBNb2h4U09XMm82SDc0dUY5VHhT?=
 =?utf-8?B?Q2t3cUNyVnMrQ1c5aEVyc1VERTdwRDhNbVhFUXhneU5nMXp5SmtuUENNQmNW?=
 =?utf-8?B?b0JMaG5tZnA3dU9jRC9MNXZTTENPZmNyWkt2eTN3QnV0bTZnRHo2L28rL251?=
 =?utf-8?B?K1U1dWNYeit4UE9GZkM2UnkvQkkvcmZZOURpTVhpOEZDNWd4ZlJydlBRUDl4?=
 =?utf-8?B?RGV1RnhYWkJLUTNCeXo5bVVsZlFKWExTMmZNQXNQOXlTQkJhQzgzNHlqOElv?=
 =?utf-8?B?VWhqWVl0aXgrRnRZZWVkanhUZWIwalBkZnFJWHJOeVpiMTFwamRNckR0Z2Z4?=
 =?utf-8?B?U2hZRy9RR2UvV1ZsMWRwRWZ6T25Sak5PR2F1WFpkN3lKcm5yeGZpRm5MWTNP?=
 =?utf-8?B?aEFpbkZGSmY3MHg4Zitoek9CSjF5SmFOdGdjbEhtZzVPVW5qY2pnVGYxZWY1?=
 =?utf-8?B?K3UzYXBseldCdThuakxhZVBaaEdWczlPL3dNN2R0dXVQaUFYOHlwZjV6T0FG?=
 =?utf-8?B?QWVCbllNL3JGcnpRclk2QjhFTnlEODZjZWFxa1NxUDl0ZElDVTVxZ1dDNnk2?=
 =?utf-8?B?MTFobXVKOThtQmVlRkJoOE8yWFpGanlrNXd5Rjc2MW15NXZnWmNzWmZrL3ZE?=
 =?utf-8?B?YW1reWJicHRBYm1UV3Z6SWRqYmhPa3JHT2ZtSksyUVo1RU1vbjJ0eUJrTXN4?=
 =?utf-8?B?MDBRaldzZzZqTWdNbGtkaXB6T3UySDBzQnRpUGFNUnN4eS8wUWN4c3RQMVh4?=
 =?utf-8?B?MDlNQXNSQnoyUGNDOG4xZy84S2hvWW1UWjdXaXUrNklhY1VYU0kyR2tiSmky?=
 =?utf-8?B?a3dQRU9CWk05YXdNYzB6S0Rsb0tBL2hITVdOeUVIM0g1RjNEMWJ2OElqOGxy?=
 =?utf-8?B?WndPYVp6MVMvc3dyUmxzRXJyNTJ6NS9YVSs0bVRNTzhONWhSNms0cVNneFdi?=
 =?utf-8?B?Wk5JaTJOaXdrREVjZXJIUHBOalIvUDQ2QzFBdG9lU2haN0RjK1FrRU9sVVQy?=
 =?utf-8?B?cXE4aGdKMnNQUitYaUF1ZjF4TVJDTlhZWWZvSWkvN29KOFNHVHJRbzBtc0c2?=
 =?utf-8?B?eDZSWGJBNDhLeGp3RVhzVkwzL0ZMNHhFK1hsQkE3eW9Vczlpakd1MnFvTWpV?=
 =?utf-8?B?eEkxcXpGWUVMU3BEc2xMQi9NS0RVcjhDRzlwZmJLK09aUjk3VlRBcnJkZlFz?=
 =?utf-8?B?MEtBSTZERk9aQkRzeDRmTTVNWER6NHQ5ME1ENUJwb3lKODVYcjBRMU81SzJw?=
 =?utf-8?B?SXB4WlU2WlZQaU90N05tNTV5SW1iK1AzUDc0K2VxaHpBbDJxa3JVVWs1d2RK?=
 =?utf-8?B?UU92WHdMaTZJaW50NHF5M2FOVDhOTE9uQVJYUncxKzEzSGE4OEVVSlVPb1R6?=
 =?utf-8?B?YXpkd1pXS1VTWDVPdTFMK1lNYTlwR1FhbWt3VlZXRFZza05lR2NjemxMRnFx?=
 =?utf-8?B?NWVMbVlJQ0Y4aW9meE9lTktScC9BOWxIK1RUVkxuaVRLMzBxVXFnbUczZERS?=
 =?utf-8?Q?5B9rlklDDw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG5HZkh6ZGp0Q1I1Z2l3QXlndEM2dDhiTjhTYlJ1NUxseW5vSCtlaGl1RFVW?=
 =?utf-8?B?Nkx0cm96YTNTSU1HWTBsZERBTU02b0lvMy9VSkZuY282ZUpDOEpPeitlTHRK?=
 =?utf-8?B?dTU2eXh3MGVRTUZUclpnOXJYNlFoQ2MwalkwRXhhY0RHTEd5MTcrWDVMck9m?=
 =?utf-8?B?S2lnMWptb2ZZOGxLRUlHQmxhSk9DY1lrcUorSnlrZnAzYjhTU0I0bm1iY3J6?=
 =?utf-8?B?S0ZGQTZTazlORzVQalcvZ3dYb2tEZG0zZE1nTUMyTmt5dTdjRXg3WTJxVlh1?=
 =?utf-8?B?NnIyM21Xd1MxdUpFaGNzMHpVMnNMcGVYVHd4L3VPRHBwbDdKcXJnMUZNWnNZ?=
 =?utf-8?B?N1RaaXU0R2owUU5XdWJqMmp3UXhGamN4Wmo2cTNuenVGZzFoSmRNN2pOMjJm?=
 =?utf-8?B?Qzc5ODZDYVVLdTFVbnJ6ZkFpZHNCSWo1NzdOQXBuZ2ZzRHliR2wxbVVsVkFk?=
 =?utf-8?B?d2o3MVVlanU5U3IweUNXckRPdmhLTncwb0lrR0krQWNLNzFJMGJRdE1JaUVt?=
 =?utf-8?B?M0VUempHVnpVblBYOWxrSngyNm5YZitLT292TGhUaG1xaVhXMU1oeXlySHNH?=
 =?utf-8?B?L2ZxVm5VMnZ4ZGlBOG1MSmQ3S2VvZVJtS0V1L1FZV1dhZGtDTU1WRFN4VEcy?=
 =?utf-8?B?cDVXaGt0VmlJMHhkOGVEWUh2S1E2OUQ3NkJqclJwT0F2a0ZwU3lzZERuKzR2?=
 =?utf-8?B?ZWVWbGNaTnNGTVJPd1RRMVlCVEt2L096Q21PK21hNHhlOXVUZlVneGkvQVVZ?=
 =?utf-8?B?SS9QMWoyT2lvblg4RUNFdFVRcCt3Rk1PZ0hGTFB0RUdsTVkrTmNCRjFnL25n?=
 =?utf-8?B?ZTdyUGlaYWlyMkxNS1BhRUNLK3RoV083M2RtZlhVbFM2YldRcnNkZVIxTGdN?=
 =?utf-8?B?K3hwNGJvUjg1Ymg1Wm9uVjB1RlV5by9IUUVKVit0bEFoaHlaRElXSUFGZEVh?=
 =?utf-8?B?MjcvYjc2QmZSOEk0NnNrK2tWMGdydmFPcVhlZlloanJqSHRXQTJvRjRhUytQ?=
 =?utf-8?B?Y2JJVlY2emliVnNDZHdqcnRnZVN1M1ptcGxJNC9WVzVGallIMEhFNGtWU0lh?=
 =?utf-8?B?cUZObGp3cFo4UnBYVzRqbkF6UzRXYnVLS28wa0pJY2wzOUZ1SVJKNW5nOGtT?=
 =?utf-8?B?QnpJSjBsVVhqQ1IrREFMMGJTVUM5dFFWNWUxeit4bGtpTWZaajJTRmRVQ0lx?=
 =?utf-8?B?RFgrVE56Y05GWllYNTVDRjZnRng0U2V0NTNiU09jU0tXZUcxYXcxZjFreFR2?=
 =?utf-8?B?dUR4L1d0T2RMVWV5aWNGUmRyRzVuU0FPU1BNZjROQ0lkbStLMnhydVJtaENn?=
 =?utf-8?B?ZmwxQ1RFK1hCY29JYUpXNzNIS1JzdnlMZWpJdEZZYjUvdW9xQzkvM0pibWVt?=
 =?utf-8?B?SUlyT3FrRndpWjF3b2c0Q0hPNmYyam1zazBxbDhoaTFkN3orQUs5VEFER2k1?=
 =?utf-8?B?a0FWZUlHMTM5TGlWaXYrYjZ3M2dLYnZ1ZkJVSWIrVWRwNlpURTVNTEY3OU50?=
 =?utf-8?B?NnYwQzUrd25WdFZPMmZWSzR5bi91Q2RuOGR4MUZGazhUV3BkK2tYVHliUk9W?=
 =?utf-8?B?d1ZjTGMzZk1tdWNBWTlZTFM4VnFPYTBjZWhYZTU4aHlEMFJ0NHR0REhUckRZ?=
 =?utf-8?B?Z2hZenZmMnRpS041OTZuNzVsSVhQOUMwM0s3ZmVLUnRNZ1NCVy8vUEpUSkxV?=
 =?utf-8?B?Y2N1NmhmTXZFT0NWOGFSYjVHWE54MFpXYXU2R2FOc0NPc1ZUV3dMZGlRQmJB?=
 =?utf-8?B?WnlsMElPcE1BaGFNbDZNM09kK0xRbmxpQlR5ek1OT21JN0M3NjA5QjQxbW1V?=
 =?utf-8?B?VzJoaDlXUG9sMWkyMFFkSDFXa2dWNXR3N1hSQ1RWeTdCNkFUKy9qRnE4TTdN?=
 =?utf-8?B?KzV5WW1pZ1Q5Rmtta0NNVGllckJyL24wSWM0enhGckhNTWd6ei9admtuL1ZI?=
 =?utf-8?B?VlNLOHBoNHloWldjTDQ0aVZ0eWdUU0pFdE9Vc3hiTFZSaEY0M0RQaFBVcmxh?=
 =?utf-8?B?STc1MVNLS2lmMmU3RzB5Tm1QNEJBOEFyQ0VmUTZER3pvUUpRTDVINGIvc0RW?=
 =?utf-8?B?WUJzMlNaL2o2WmplUmRUaVRMYVBxTzF3SWx3ZlgxN2ZuZE5tQjhIbFZNVGl1?=
 =?utf-8?Q?EeXI4hSJe6gNmNmxeG/BBekhE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fcab04-a210-4637-1b4d-08dd791dd2c5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:25:15.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8whLP2Qjbi6pu5opX5s/juVNICvP4iaUpM5HTehkA8NP8kdeoDSikMiLtQaMow9QYS8Aswtts/r1bqq5fZHvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

On 4/11/2025 3:14 AM, K Prateek Nayak wrote:
> When working on dynamic ITMT priority support, it was observed that
> "asym_prefer_cpu" on AMD systems supporting Preferred Core ranking
> was always set to the first CPU in the sched group when the system boots
> up despite another CPU in the group having a higher ITMT ranking.
> 
> "asym_prefer_cpu" is cached when the sched domain hierarchy is
> constructed. On AMD systems that support Preferred Core rankings, sched
> domains are rebuilt when ITMT support is enabled for the first time from
> amd_pstate*_cpu_init().
> 
> Since amd_pstate*_cpu_init() is called to initialize the cpudata for
> each CPU, the ITMT support is enabled after the first CPU initializes
> its asym priority but this is too early since other CPUs have not yet
> initialized their asym priorities and the sched domain is rebuilt only
> once when the support is toggled on for the first time.
> 
> Initialize the asym priorities first in amd_pstate*_cpu_init() and then
> enable ITMT support later in amd_pstate_register_driver() to ensure all
> CPUs have correctly initialized their asym priorities before sched
> domain hierarchy is rebuilt.
> 
> Clear the ITMT support when the amd-pstate driver unregisters since core
> rankings cannot be trusted unless the update_limits() callback is
> operational.
> 
> Remove the delayed work mechanism now that ITMT support is only toggled
> from the driver init path which is outside the cpuhp critical section.
> 
> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Will queue it up for testing.

> ---
> v1..v2:
> 
> o Retained the name amd_pstate_init_prefcore() (Mario)
> 
> o Moved sched_set_itmt_support() towards the end of
>    amd_pstate_register_driver() to address mode switch scenarios.
> 
> o Disable ITMT support when driver unregisters to prevent incorrect ITMT
>    behavior in absence of update_limits() callback.
> 
> v1: https://lore.kernel.org/lkml/20250409030004.23008-1-kprateek.nayak@amd.com/
> ---
>   drivers/cpufreq/amd-pstate.c | 25 ++++++++-----------------
>   1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c54c031939c8..b961f3a3b580 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -794,16 +794,6 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>   	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>   }
>   
> -/*
> - * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
> - * due to locking, so queue the work for later.
> - */
> -static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> -{
> -	sched_set_itmt_support();
> -}
> -static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
> -
>   #define CPPC_MAX_PERF	U8_MAX
>   
>   static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
> @@ -814,14 +804,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   
>   	cpudata->hw_prefcore = true;
>   
> -	/*
> -	 * The priorities can be set regardless of whether or not
> -	 * sched_set_itmt_support(true) has been called and it is valid to
> -	 * update them at any time after it has been called.
> -	 */
> +	/* Priorities must be initialized before ITMT support can be toggled on. */
>   	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
> -
> -	schedule_work(&sched_prefcore_work);
>   }
>   
>   static void amd_pstate_update_limits(unsigned int cpu)
> @@ -1196,6 +1180,9 @@ static ssize_t show_energy_performance_preference(
>   
>   static void amd_pstate_driver_cleanup(void)
>   {
> +	if (amd_pstate_prefcore)
> +		sched_clear_itmt_support();
> +
>   	cppc_state = AMD_PSTATE_DISABLE;
>   	current_pstate_driver = NULL;
>   }
> @@ -1238,6 +1225,10 @@ static int amd_pstate_register_driver(int mode)
>   		return ret;
>   	}
>   
> +	/* Enable ITMT support once all CPUs have initialized their asym priorities. */
> +	if (amd_pstate_prefcore)
> +		sched_set_itmt_support();
> +
>   	return 0;
>   }
>   
> 
> base-commit: 56a49e19e1aea1374e9ba58cfd40260587bb7355


