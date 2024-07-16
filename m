Return-Path: <linux-pm+bounces-11136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5C932248
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64E7282519
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2319538C;
	Tue, 16 Jul 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WcIRssme"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28496FBE;
	Tue, 16 Jul 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120195; cv=fail; b=HH9UljWBRRX2EXar+eh9BrrZec51dTmXjVuyKZOELS3RkA9hY+QDqGfFsfzA2U+Z7RzfEN6j1OXzwMjP44jjZqUWlOeNwJlEc/hJwO610yAk8dWFb4+E+7nhHZHaI5FneEffxIJM8YUAdRFhR6PS2zWXn5QiuwpZDeRjaxaVs9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120195; c=relaxed/simple;
	bh=y04kveCeHIm8eerfmzaBn0c7rIZX3FGcFB7QdmEyXCA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R0I5sI3Aolc8PjYa2VDpMfkz0n+oGaynsjP8bl6caZpzZdkh9oAg/JD95P1BaQM2AqEAXaSmwflX/4lNmnZMIAZAQv4jgd4duNXcz4ivrSpvMnBAhVJ7RjqdphQQMppSIVDKSIBil/30+ZtSPZjEtWVI39UCSLmsbR4gS5o7HDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WcIRssme; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu2HtEzAPKMMCU/yRkgZfuZav1KO905qcS1wgyx2udLr220+ADi4Oq0B59c1NDOwy/pQv/5cEjB37MG1scviX3ikMgD7FFYm3gsfmwUeuZXrFlqVLTLtTSn99t8wzgY/rPDAg7GQoUsE3Uq6Aqi1SU4gFDqm98bEbcUVrYRbCEh9qqtM5lTFFKsKMlm6DxxmOtwK2N+fQqPzVrgHQjVJb0QDbAQPSvKNZ9FmTUnktWKy3TcQ6d6LhEob9m6QF917lGjhWj5thErWsfqwzB/FljscNmXz0HW3DaxiJYZ/uONjmyfZ9Uz5+bu4QfezFt4TKgcHtKzXKCL0GdFI7AZjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=822nQnOOieJvhTbRtxMpXgpMhMC5ErbYefKoSV7pYWI=;
 b=cJOmF4wFKokeag+zQrvWpO+wdcqiylns5OKzEX4DcS5q7dwxcYb5bW4Uw6eo4nT7ZsyPABchkZWCgi2eJNqeLOkG3wfsUb4sspKUe2AasbriUGMUAyUexBsjApTOLeGHYDdzARQYu9xbgg99KWToOaZncVZyqSyIobHVIqod1qkxJv9fGXmaLIwsCJDmOkg+3Vso36qkrhOPVKn42KtqP5IauvdMTAq/iqpTJbrG2fxkbS3RI7MZv3THB1B3QxNtt/0RxMqRe1mKgE/X/zV9OHyaXKcOhI9IUZg+kYlGt2j8GYFkjsM4NJahVyG6m8iyAQI/N6ugGdBEsg2YSsSk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=822nQnOOieJvhTbRtxMpXgpMhMC5ErbYefKoSV7pYWI=;
 b=WcIRssmeqOWJqMrT4VRvqMIDodocDvYCRgqcMAMHdVlxajAr/OGiHGlHLRT0f79xbDde28OXU2AsqzyKC1BxGBEtvRvdUIDGFPf2xhgEADtTsGG+4XWJaz39Oy0A7gqCag9El6DxciT2PYqZANQAG96Vtp+RZG1POFpC2EG+doA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 08:56:31 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:56:31 +0000
Message-ID: <cd0bc6bf-a86f-4a10-87dd-56535650424b@amd.com>
Date: Tue, 16 Jul 2024 14:26:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, rui.zhang@intel.com, oleksandr@natalenko.name
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 sandipan.das@amd.com, linux-pm@vger.kernel.org
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <20240711102436.4432-3-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c51840b-6aba-4fff-85d0-08dca5752fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDR4MytybEp4aDhyekJIeHRBaGUvRERDSStxZWFwZmovM2Ywclc5aU13a0g4?=
 =?utf-8?B?bS9TV3FsUXArbHhUeVd6aWwzTnJVQ2F4bUlyV2lUZEpQVkdIMzNGeUNvaGVm?=
 =?utf-8?B?QmZTWWlhSm96Zzl4RXdzTmFQMWhXVFM5RG1jNERzV0grV2J5eUV5azZxa0VF?=
 =?utf-8?B?R3dYYllhazNWekpOZ08vbDhZTW9SUVJ5eWZXdUJlc0E5WjVqbjRBMWhpa0tO?=
 =?utf-8?B?U2FIZ1BkeTlXd2FaTXd1K0ZiazBuaDdGK1VsSGVLY094dWNvS2hYQitVeFV4?=
 =?utf-8?B?bTh0OWdFWWdycG52V0wzbjd3VndvdVpLRHIxbEhqeHM1VXFEZkVac0tkQWVX?=
 =?utf-8?B?SGIzSWQ5OE9WVm5vK2JrRjIwRWlvd05reVhGWnFXZ0VQcDl0MXZpbU41ZXFQ?=
 =?utf-8?B?U2hKMU9mb3FPQUk2R200V1p4NklzK2g5bjFDL1Z4MDF1bGNWUHpjOTNTdG43?=
 =?utf-8?B?VlE1eEM4WEg3YlBYOGRJVUdYZnhjVnV1ZFRCeksvUlpTQ01yaW9BRzkyUElu?=
 =?utf-8?B?TE9NMW9ydmQrTk1VU2NpTUFMZzdYZldjNU9iVXJaK3FKVUpmTFVvanJiaER4?=
 =?utf-8?B?VHZCc1gzcklLYkt4NmQ3MlcvU0RZWjMyTDAwaWRhY0QxTXBPcmg5UEpYU1Za?=
 =?utf-8?B?enNKN1hTdEU2WFpxQ0lmWmNpQUhYaDN4ZEdOb3BoN2FuRUxjakpCc1VYV1Bt?=
 =?utf-8?B?cFJVdlNrU25Pak5HYksvVmFhWDBYekgxNlJCTlVleS9JQmY5akpVeGI1K2U5?=
 =?utf-8?B?MHptUmtsdjFOcGFzZ3lHVjRKZXl1VDJoSHZPQ1U3clE0UGN6SXlSWWRaYWV6?=
 =?utf-8?B?ZUxqbWd5N3kvemp3WUw3M0hxenVidW5ONTUyYW43Y0Z2VkRMK2NEeWFmeFlo?=
 =?utf-8?B?SU9CVjFqTXkvTFVPQ2FNSWh4RGlSbktabE9ZbG5qNVQ5bnFTb3NOS3VvNlMz?=
 =?utf-8?B?d2l6eCt3dE5vSTdoQS90SHJOTXpPMmVKUi9xSmJ3M2NMNzR1RzhrbmQwRGxi?=
 =?utf-8?B?blExa0FCQ2RpcGJFRkt3VmFGNVVlTXNoYUdlb2s5d2dhR3paa3grWjJIU1BC?=
 =?utf-8?B?ZUdKdzduTTBqNVplcmRHUjZ0Mm8xUzNiSGpOa2xLSEdldTl4SGVvYlhNaHVX?=
 =?utf-8?B?Wm9uZmREbEc1OUVUZXhEMk55NS9NN0xBWHRJRDV2ZWpSeXZxY21ia2xLWFFj?=
 =?utf-8?B?azRNQVIwcTc2R0RjWGdTVW1OQ3NseDdVVHlHZ3JMaHVXQWZJcStwclVuMUl1?=
 =?utf-8?B?cHVObW0xaDN2M3J6OHExaUU5MmlkWGRYRHgyYVBLdlVrZVNPczA3RkhweFhP?=
 =?utf-8?B?WTZ4ektHZ2V4MnlQNUpKT1dsN0dLdVcxek5yaGVpc1M2ZTdWMXJSMFhQeUtS?=
 =?utf-8?B?NVJnRkVTd3lJM3BFeXhCSk5pckdlang0MWNkUytMYWo0NVhnTEZzbDhsM3I0?=
 =?utf-8?B?emNRdnRFc1lZZEQ4cDZSL0xlYzh4Q05nSHM4MytpaDZPdmh1cXZabDBrZllr?=
 =?utf-8?B?Ry9XalFPNVB5YTNOS2ZkeVNoTVdrT0tPNU1rRHg2SzJDbkQ4SXFDbmVYZURw?=
 =?utf-8?B?VzVtaHNhaE14aVlRclFiM3A2cWhKZ3cxZ2VkcTgwZFptUnhmYVJ2Y051bFhC?=
 =?utf-8?B?UHNTNjBXZ0x3VFBlTHJEa3pvUkl4SHVsMFErVUcrZnBBbm5QS3E2djhYcklz?=
 =?utf-8?B?K2x0bU1FY3VPaFppZmtWN1dyTUY0dFlkK0ErNFRPZlk5WHptOVhuaVY3bmhH?=
 =?utf-8?B?a3ZITW45NkhsY09xY2FHK1FQbTJmdlcvSVZESkVHT2dnWnFESXZGOU93cy9x?=
 =?utf-8?B?UlFKdnNGWkJxNW43T1RUSlNackM5TURKQWdoN0FtbWFncm83NDhLUXBrK1ZK?=
 =?utf-8?Q?gc+VXbkiZC8B0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJ4MEF4cExGS1hBeWxQSnYzV1M0QTd1N3B6c0pQMFF5VHpPRVVJOE00aTVN?=
 =?utf-8?B?YWNORnY5REVlS1l1VjNnYVRxMlJLR21BbkJMMzR3emZJNHFoS2JmTHQ3bS84?=
 =?utf-8?B?QmpicStkWHdjd3lLN3lTSVhrTjVzdVlxMjlSVUJHU1F5Q01wbGIzV2pKY2Y1?=
 =?utf-8?B?Z3krdkpld256dlVwTlVKcFJ2SmIrdDBUNW9pVmpROFV3SUJMUHYvZlVMOGZK?=
 =?utf-8?B?dTFvMm5hbldTRGY1QVU4VHFsWUwyQzFuNGNSc3Q4aVBwSFlaWmlQSWdNM0pn?=
 =?utf-8?B?Q3VYR1hMckw1OXBvVkFhOUpOS0czYUdRaDdNSjI2RjdDYTdad09GQnEwMlhs?=
 =?utf-8?B?OGNWUFFxeFhaZ05xWDY5dldKMG01eDlyYmtPSUpEQk5wTlg1ZzUyZ0lKZnNk?=
 =?utf-8?B?MUUrV3l4c2N5amJtbWkyWERBRVJONUh6ZjhhVHRQczF5T2R5dGFsbGdVWVlI?=
 =?utf-8?B?aXR6RHltV2tqajVjSGV1cUhVYTFWQkZ2K3FycjJzdHZ3cGFQZVFmcDFhRVpU?=
 =?utf-8?B?RXBNSU50b0cyQzNrd1pUMjBqVHo5amthcTZTTm9jaFdDaWtxL1JlL1lXSjBM?=
 =?utf-8?B?V1ZmMDIwOWdnOTRwZnFPbXJLNG9jUGNROVE4ZGdISDZUT2pqK0xLVHArNDJM?=
 =?utf-8?B?SUlzei9zT2RBTUdxOHpCaHREbHM3K25USytla2lGY3FqSWViYmNMUlZDR3Y2?=
 =?utf-8?B?cE9hRmtSYWVTRHFKRGFINVdiYnA2V0RUSEFqTDlNMmlORnFNVUVCRTFiK2Jq?=
 =?utf-8?B?dDE3eTBPWkpTQ1J0ZUNLSkswUlNoVHFQclc0QU1EMGlNSHM5QzByYXRwbXBo?=
 =?utf-8?B?amtDc29WdWhjMjA5Z3krc2oyaHJCMjd0eWhtWDg1WVozVnBkakozTVJJQXdI?=
 =?utf-8?B?WFVGeWZFYkZNU3FseGlsWU8zeDBsaS9vclIrcmlXT29YbGZ5aGphL0ZWYVhY?=
 =?utf-8?B?STBHcTdDTTQxNzdONGFsUUpRWlB2U0tyNTNmWXBsdHVBZndPWDIvZTVBRWxy?=
 =?utf-8?B?NVdvOGRqRzdSYWRQVVU0RHN0bkM4aFFiT1NKWVNPSkVWelI2b1hxYXNoNGlH?=
 =?utf-8?B?T3NJQjNQdUViRDN0UWlldkRTWUMyZjh6Ull5RTNGa0JqK01iRFMxSlBYc2Uy?=
 =?utf-8?B?Rk9VZ1JWaWZ6cmk5bHJGUm1uMVo4bzJKVE1MK3pkd3cwbDBJbzAxU1VEMnh1?=
 =?utf-8?B?UWxBSHN3OWRTN3UwVmt6KzRIa1M4bTFkeGJVV0tJNkJVcHRyWmE2OHBPV1c0?=
 =?utf-8?B?aXNlTjg3S2NPWTdsS1JxbldQemlKYkFlMlUzY1A4Z01SUEV2ekJIbkMyRlc0?=
 =?utf-8?B?bkpqOW11M2NBRDdoNXh6S010bHVid29TWUVPZ0xubkpHMmZRRFc2NWhibW81?=
 =?utf-8?B?VHAyU3pTQVg3WEtHYjBab05ub2RBR0pzSHViSU1nYlJJazBVMUh5OHRaWHVN?=
 =?utf-8?B?SVpJcndyYldXNTRTNzFLVVNMQU9uSFV3dGZsOVc1TEpRcG1TR2JDRlJyb0FM?=
 =?utf-8?B?cjRzdmtKMGk1UEJYR2NsUXpQc2xQLzNIR3cvZHVJM3JyWVA4eFFjK05sQVpR?=
 =?utf-8?B?V3hmU3Iyd3pSS0VFbnphUE5ZSlRldnBCME1tRmxtSEN1aGJwL3V0ZVhJK3hn?=
 =?utf-8?B?ekUwR3dBZmRKMC9VSWVKcHlKZnc5cWl5SXI4ZHBrVGFaV05JNnZpcisrTHhx?=
 =?utf-8?B?UkFDbUgzME1lNEFhVnVDK20vazllckFRejh0NnQ5QVZtbUNVamtjYjdVdE1i?=
 =?utf-8?B?SjhLYjRnKzZhWUJTMDNNMXRvd1NtYkJ0QklUOHBOTE5oVmNMTDh0MEdNOWRr?=
 =?utf-8?B?YTdPWEhYa2xxWEE0Ty9ZVU9JMFlia3BLbTZOWXkwTVljbkJZNG8veHRZOGJU?=
 =?utf-8?B?b0gvOW5Qb25wdUpCc0w4TUttblYrVG5RYTJLMjV1RitDMHFlNTVIdjRDUHY3?=
 =?utf-8?B?YURMdmsvWVpnaW5tQ3F1YXdLVXU2czE5aWNQRGtjbDVJV1dqT29OMU5NVWFM?=
 =?utf-8?B?RU55SmN1dlIwZVJZeTRzZW9lVGdDd3FjalZxMWE0dEYyYzFDUk1ISDRaakY0?=
 =?utf-8?B?YXBJeEVEcjNKRUlTa0lQMWh6N2grVkZHelVwUjY1UGVrT000M3V6aVhMVjgz?=
 =?utf-8?Q?qE8GG1eNqSmSBqtRfkRBhW0DM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c51840b-6aba-4fff-85d0-08dca5752fda
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:56:31.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhY25kJrkxrngMbnx2LR6zescsDy5uQh0Jux3RBZu0wm9nDq6E3JgNCvMT4SbK6qWbx3GLMS3fAIbTxSIaXhpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

Hello Peter, Rui,

After Ian's comments on the series, I have decided to rethink the approach of
adding a new PMU for the per-core RAPL counters.

However this patch is still needed as a fix for the 
commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"), I will be
sending this separately along with a similar fix for powercap/intel_rapl_common.

Thanks,
Dhananjay

On 7/11/2024 3:54 PM, Dhananjay Ugwekar wrote:
> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer
> return the package cpumask and package id, instead they return the CCD
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
> event scope to be modified to CCD instead of package.
> 
> Replacing these macros with their package counterparts fixes the
> energy-pkg event for AMD CPUs.
> 
> However due to the difference between the scope of energy-pkg event for
> Intel and AMD CPUs, we have to replace these macros conditionally only for
> AMD CPUs.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package
> scope event, only one CPU will be collecting the event for all the CPUs in
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
> ---
> Changes in v4:
> * Invert the pkg scope check in init_rapl_pmus() (Peter)
> * Add comments to explain the pkg scope check (Peter)
> 
> PS: Scope check logic is still kept the same (i.e., all Intel systems being 
> considered as die scope), Rui will be modifying it to limit the die-scope 
> only to Cascadelake-AP in a future patch on top of this patchset.
> ---
>  arch/x86/events/rapl.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 0c5e7a7c43ac..df71f38ad98d 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -103,6 +103,13 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>  	.event_str	= str,							\
>  };
>  
> +/*
> + * RAPL PMU scope for AMD is package whereas for Intel it is die.
> + */
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
>  struct rapl_pmu {
>  	raw_spinlock_t		lock;
>  	int			n_active;
> @@ -140,9 +147,25 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +/*
> + * Helper functions to get the correct topology macros according to the
> + * RAPL PMU scope.
> + */
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> +					 topology_die_cpumask(cpu);
> +}
> +
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
> -	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>  
>  	/*
>  	 * The unsigned check also catches the '-1' return value for non
> @@ -543,6 +566,7 @@ static struct perf_msr amd_rapl_msrs[] = {
>  
>  static int rapl_cpu_offline(unsigned int cpu)
>  {
> +	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>  	int target;
>  
> @@ -552,7 +576,7 @@ static int rapl_cpu_offline(unsigned int cpu)
>  
>  	pmu->cpu = -1;
>  	/* Find a new cpu to collect rapl events */
> -	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
> +	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
>  
>  	/* Migrate rapl events to the new target */
>  	if (target < nr_cpu_ids) {
> @@ -565,6 +589,8 @@ static int rapl_cpu_offline(unsigned int cpu)
>  
>  static int rapl_cpu_online(unsigned int cpu)
>  {
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> +	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>  	int target;
>  
> @@ -579,14 +605,14 @@ static int rapl_cpu_online(unsigned int cpu)
>  		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>  		rapl_hrtimer_init(pmu);
>  
> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> +		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>  	}
>  
>  	/*
>  	 * Check if there is an online cpu in the package which collects rapl
>  	 * events already.
>  	 */
> -	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
> +	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
>  	if (target < nr_cpu_ids)
>  		return 0;
>  
> @@ -675,7 +701,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>  
>  static int __init init_rapl_pmus(void)
>  {
> -	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
> +	int nr_rapl_pmu = topology_max_packages();
> +
> +	if (!rapl_pmu_is_pkg_scope())
> +		nr_rapl_pmu *= topology_max_dies_per_package();
>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)

