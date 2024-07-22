Return-Path: <linux-pm+bounces-11277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD63938788
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 04:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A54B20C49
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04989D53F;
	Mon, 22 Jul 2024 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="hPy0XrZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A01611E;
	Mon, 22 Jul 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721615448; cv=fail; b=F4OI/WbySFvvffdRGSzSps1Ri2qRnr8webcuPpdXn1ylLdccNFXukb9Vf4i2DV4eyol6UjjGMQHx2bRM5QxtVdHupofUEnnDZCyrzKoy69V43XXSTmmj0ryIA2W935WZXE0R2oPLCSxzR2Irdvv+lXvOixnGqX5oFHoT6JUllrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721615448; c=relaxed/simple;
	bh=Hpqh2g7CAcNG/3R4+peMZnpr4ZkA0VxvNwR8EFlpmgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb7JLy5NMnK+al07wbadDiV1p81/aOPX9dxm7gZkBS7wfAjDvOTmHPSRhKBjPo+gj0Q2TQgN6Lmuz4BzAGlPTfIEjtgBIT5Njk5VJVaHjxxT8VQyBJtkAO2u3Ht8SMst9yOn1spngfPcQ9R8gAI08husPPUJNONYKRiH3sWMQtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=hPy0XrZs; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3nEV9QIlnwoV4o5OlAYmMXNwBH5sf1MD0jIROMXDYY1YyZuOaQRfsnnlNf6C2yarJl2FJsDKH4YeIFjNV2IMlepYrSFNwH7cPwRPak8q/idRICMasQ0wOlCIBwjZAUCaS/OScVYNjimqBnpmjzPQwZ5L0/aw4JPAPBMotpdN6oGT3Jk4GV7CirykW/WM7lURUW5KNdzS9APGeV3N0l8Wg0mbIYGHOiR4soAY3HEnxdbp7RFq/VEDcnZl4BovV+p351IRkX8ztNgAVdLi/TPmxQHX4nQPyZ6LGQmJDLQrsROPYYPtOjst01Wlp14Qwlre6hcFr7qkKwfTGszKB8fSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Fe8lyjATVIVv6oV8dzktNFfA7vI1Yk1z0L2ZJ40rUQ=;
 b=H3Syd0siPRRWWhXH6xSFV0QxxTZa4GcGfzlmkvonu7yW2TbdZ2u32OxYTioBGlhWZZJtKie68W1c+X7ho6UMEolw+0BjIag2ko+hgD/KPER2iKfRmVGdyBrgNP6KSOGJOtmjHGFLErXs6tqwfl3XUp6f20CY/VZRAyywNaJzKQpEAmX30tNDO7OUFx5DXFkEH0IedyjXiXAM05/g1hz5zmBZKp4/FeZ7n7v8azNgRC65fWV+7kNHZEsOjHKrfJY6j730fetlGKmAAqy1Y+4DKZAYSU9QLFLDSVhdUbUqW4GcPzOcwfhNM9tzqKS3GxNacMdR6CkB5K+3spcTxlSMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Fe8lyjATVIVv6oV8dzktNFfA7vI1Yk1z0L2ZJ40rUQ=;
 b=hPy0XrZsQuejw3gZnxrK3zWNGgJGpSCaHOoTIq/B3n3p2XPPyQfxW7gQb2TBstYgRlj/iVcaFd5/fALvcMnY0G8QMj6wzd0AtToDbuFsgMkkdrzvrIYikECVp5eEz+b0/QqNIdK34bx3t1jHyp6OlO9j3oNJ1dfzKTE02rNx2ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by SEZPR02MB5830.apcprd02.prod.outlook.com (2603:1096:101:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 02:30:39 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 02:30:39 +0000
Message-ID: <06ce2143-cc74-41e5-b39f-15053133b232@oppo.com>
Date: Mon, 22 Jul 2024 10:30:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: queue policy->update work to rt thread to reduce
 its schedule latency
To: Tim Chen <tim.c.chen@linux.intel.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240717063321.629-1-pugaowei@oppo.com>
 <b07c39fab5ac0e32e7768ed3e8a799c8eb68802a.camel@linux.intel.com>
From: Gaowei Pu <pugaowei@oppo.com>
In-Reply-To: <b07c39fab5ac0e32e7768ed3e8a799c8eb68802a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|SEZPR02MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3eff25-97b9-400c-6b57-08dca9f646be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dCSW5ORWxSK0FlYjVsTGZsU0dWcGlWaURibk5oem5lTjdUUThoTElQdGRK?=
 =?utf-8?B?bFRHOXlXNmtWVEFoQzBkYkV4eGVkQk9YdnFTS2tPaGMxbTV6Qk1kT2MzTENP?=
 =?utf-8?B?YmdSYy92eTZJNEc2NExjTWtyV213NGh5ZVZnRlVmbkh3L0xtV05oRHFYRTcx?=
 =?utf-8?B?M0l0d2ZibHd3R2ZpUUt6Ynl0NGMwLzMzbGl3YmxtSWx0R2VDdVZaTVI4Sk5R?=
 =?utf-8?B?enRGNFdIM0Y1anYzZEN4a0RhM1FLQlJOaDVyY0E3dUpkdldvaHZaam15ZHdr?=
 =?utf-8?B?WHlIbktOOGVHMC9YcVRVRnVtUFlnV2lHWkM0UllXVGFZWm1LdXhmN2R6Y0E1?=
 =?utf-8?B?Y1Vka1QwRW9peU5MakRrTmpialFQb0hYcEN6VVVyNlhvVVpVdElTN1NtVFpm?=
 =?utf-8?B?b0pBdFlTZkRjLzBqZHJlNTFBTlNRWmdjQUFFcTlZYVNzcnZsVEpmNk5BTExw?=
 =?utf-8?B?T2FyeXJmT2pUVjZIckxqbjFKeFpYcFFKRkdXT3d4ZUpPeDVadGdnZ0d6QXVR?=
 =?utf-8?B?ZDRGaEhBNXlzWTU3TWVsanFnSkNodGd5TGNtOWxRVE5EdWhSNGJLNHJWNUZO?=
 =?utf-8?B?NkxkS0VndkZoaXBTc251M1NHOElRS1MyNzNKWC9ZcWgwSGdtUU9IWEdJdHFI?=
 =?utf-8?B?RnV4NTZGNHpYTnlEdnVNSWlCSHJIOEZ6ZVMzQkpGTnRucTNDWWFkMFROdis3?=
 =?utf-8?B?dTFheXRFeDZKWGw4WUY2UjRKdllXWXlTOHFReDJwTzR0S2c2OGwvRGpoWVhm?=
 =?utf-8?B?azNtS3VkdEt4OVhnUG9Fa2JzbUtyRUlObElVN1JzR2VXUnlQNFo0MUhlaHB6?=
 =?utf-8?B?ZGhrVkc3U1pHMkxLN0xFSXBYL2ZwVnlRUjZEREdUbGZnV3JURFByU3JQM1pK?=
 =?utf-8?B?YTU1WmMwUHpienJTODZkU05qRTE5U0c1OWdTTUNsaU1ud1VFY1RnZlluK2d4?=
 =?utf-8?B?SzVKNE1WQ0VtU1owd0lMd2o3ZjIvOEVMQllqVWI4NUY2ZDlyekt0YzhmLzkr?=
 =?utf-8?B?RU1RRnFHSjRwT2liT1B0dDloK2Z1eWpNYXlMYnFuWDUxL2tndGZXUjZETW9G?=
 =?utf-8?B?eUVKc3ZsSG9tZ05jbWYvdjRidGxSWmtocWFTYzZHVHMzZFBxVkNSbnRwbi9T?=
 =?utf-8?B?K05QRjhvblhERDhRc3lzaDczS3p2Q0M3VGhlY1NudmpkeUIxRm02Ui9RV2hJ?=
 =?utf-8?B?M1RiYklndVFJeGloOGNsOVJBb1NrWVJ1UUljWm5QQWtTZWJ6MlB6VitmbTMz?=
 =?utf-8?B?bW1uYThiaVp0RU5wSEpjUFFZeEI4MFpXMDlBZW9XMENlcmJpeGZqMWp5Yi9E?=
 =?utf-8?B?cXBvUVE3WkVhRFk2VFpXWTFhMmdCWWVpVW0wVGNxcUFibDQ3NmMzdE9CTHp1?=
 =?utf-8?B?YUFVVW1HcDVGNHJWcCtMTC9yT3IyL1p6ZDFNeGdRRzlqSDlDRGJ5VCtza0tm?=
 =?utf-8?B?WFJUNmp0ZEgzQTl5Y2pyU1hKODNDQndSRWR1NHNZbERQYUlwcDVNOTRML0wy?=
 =?utf-8?B?S3IyY3B4S2UzRkR4WGFoa2hlWEFFMUJpYlN0MVg4ZkJvYUhuMkc0WnR1cjhZ?=
 =?utf-8?B?d1F2WnhiZ1Zsb1BDclFJMVZhOGVkWDZ1YXBjRVRUSUpPNzYxWGtDa1o2a3lY?=
 =?utf-8?B?UHBOa3pnelgrZTFCRmJGdENJalFUcFlNbnVQQlVhNWppSGVheHhGbXgrWHB4?=
 =?utf-8?B?K0JYVmx3dnNHbnJjTjluSkt2UC9sMFVrM2NhWkVLQWM1c1Znb0hBWTRLayti?=
 =?utf-8?B?NTJBQkE2SGtwOThQQmFlV0Z0bDkwcEZoRjVrTytyamZneXhML09RUVI4S3or?=
 =?utf-8?B?TFBwYzIvN1ZUVlFOc2xiQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGk5MUxHNlB1R3YwUmJiZVBZWUxMOHhMdHZVU2wzTlJWeG1KTE5td24wUkZs?=
 =?utf-8?B?NmNBa1VxRUxYQ3VtZEhFb0JFT2FDZ29PWnJ6ZFFncENmcnVENWRFdGh2Zk5q?=
 =?utf-8?B?SHlLdEhrYkhxa00yWEtzR3piSERNWnhJZHVXa2V2TDNvMnJOMzg5blhXLzhu?=
 =?utf-8?B?TkM2RmMyWXRWVUJER3ZUVTdWMTVmTUt1dkJUbUxPN0doZUFJTS9nMWZXd1dY?=
 =?utf-8?B?ZEp3Ung2VkJ5aHZCa2FURkRxSGdrd0xvZzQvd3RZd1NGd0dZTklpME5NdlY3?=
 =?utf-8?B?Q1VaRkQ1MlkweHpOMWY1R3NOc2Z4Uy9iTEkzd3V4ZndzTlBjaUcxUllTOGh1?=
 =?utf-8?B?Qmtwb3ZVNUY1N2JQcHhVMTBudVhJbmx6eG9zQ1JONW5SQms1ZS80NmhRSEdD?=
 =?utf-8?B?Rmh6amtlMC9KMllkTGtUTTVyT2QyR01GWUM1TUdGT0RMU3ZKMnFuRlJ0djQ2?=
 =?utf-8?B?NE9pbXJDNmcwOTlmZmtzODQyUlFtUmFzU3lmdFJKMktESXUyZ1hzamJWb0pz?=
 =?utf-8?B?K3ltTkF5eFZWK0libDN0RVR4KzFuTmdIWGFka2RwMVJ4SlJHckNKNEF1R1hr?=
 =?utf-8?B?SDZPWUU1eGVEeUE5cnZQR2hoaElBZTR6djk3di84bGJJWkQ5aGRyWUtKMU5G?=
 =?utf-8?B?L1ZJOUNFNTlCRnRUM21NNEN3NmM3QWFCeGY1UEtzOTBaSm5Mc3JtQVZSUHJJ?=
 =?utf-8?B?MGtUOGtpVHpBWFZuaG5pVkdNckFQcTI3cFFjSkRSSHR3QmVtcHg2ZWdOdWVZ?=
 =?utf-8?B?RWtLaTNCVTl0Q0NkVVc5QzB1Szd3RHU4REtmTFZUMFVnRGtxTmJFcmhtamlH?=
 =?utf-8?B?dFBvem1KeWs1akFocEM4ald2OGc3SmNkQWxXeUFLdVlXTDVaWElpLzYyNndo?=
 =?utf-8?B?cWpvY3NLSHhKT0hHRTZZTXNhSU5RbEdnejhpV2NYeVVNN0Y0ajlROEtwUFBB?=
 =?utf-8?B?NStKTE5WaS9NZnl6L2Y3RHBUeGpuZkRPU1N1MnpCNVdPeWhhc0VPcldQZjBx?=
 =?utf-8?B?RVlYeG9EM2Jmb3BYY01iMGlhVHBkK2hhYmhRY3VIdCtwUTY5YWpTRi9NYkRV?=
 =?utf-8?B?RXo2aUtUcGZSNkZHcWlvU3lRclhEemFQdkVFUUF6cXZYNEszOGZqNGNQN2Jj?=
 =?utf-8?B?QVBCWUcwK05oazhHcXIwUU9ZYUlyaGZmUlNETExTSCt4eFVlU3FMSENFaStR?=
 =?utf-8?B?Vm9qb2E0WVdtWUVKUTBwUzJpWTZOVzRlNytGQ0V5Vy9vVitxM1k0WHFyT2xD?=
 =?utf-8?B?bnpZZ3hucmh1aTJmSzM2VTZvSFJhWTQ0TzQvUnZjNGxRS2paenBReDNOY3Yw?=
 =?utf-8?B?RTdMMDJ6OXNHMVJFVTlQNEhtR29lRENzOXl4QWo4Mm5Bb015OHdBczI5bmZi?=
 =?utf-8?B?MTEzSHZreWJoN1cxNWdneXRlQWRXaUl0NHRGMWZOblRDWU1DUWZmYlczSVpy?=
 =?utf-8?B?QWRxZDU1dVhYRlZRU3g5dEYyR1ZIcXBkWHhZYWxLZG9ScDVSQWFtNERCT1lS?=
 =?utf-8?B?eGNZb1dLWlNJOU41MFhiUDF6UUl5YmxPWmJ3eU1TRXZLeFVZMWJWeU5QMTA2?=
 =?utf-8?B?YkEvTlF2U0pZWHZ5ck5KWkNKSU41b0VjZkNSUi9NQlNIQmtaLy9zRjVScUJx?=
 =?utf-8?B?WHZXZ1ByUTRnODZrS2tTQmZqZnc5UUtiL2QzbWgwSFRKUmUxSGZnRVVEUGJr?=
 =?utf-8?B?TlFBN3hCVTBLRS9yQURNQ0QrdmY3bWNxWkRnbXdyRE8vb0VRM1Nrcm13c3NT?=
 =?utf-8?B?aVNIWmtLbnFKNnJJK1IyZ2hmU3IxYlVLMlNram45Wnl5NjJlQUhJQ3FoK3Uv?=
 =?utf-8?B?QVZlbXEzMEtDaXZaWnRnMDRpQjVzczh5SGtOdXlrWk9lblp2QWRFVk1Fbjlr?=
 =?utf-8?B?aEg5STZmVWxTMGpxeE00Q0VyRzFrTEtyR2pqWHRkZFp2Sk80UWJPb1ZmcVY4?=
 =?utf-8?B?NTUyMEllR1l1MTJFdzYwM3N4S1dKTmJ1Kyt3RHgvSzAxTmhsWlRVNXlSbmNC?=
 =?utf-8?B?K0Jzc1VOSEc5UE5uSXR5Q055OUwwWXFMNlNaVFpRYXFESms2M2lYMUFxSDNJ?=
 =?utf-8?B?d2tsRVMrUjU4WUZNVTBrZ0pmWHVxT2tNZXE2Q0YwOWZiSVdxZ0xkeWdvYWpM?=
 =?utf-8?Q?IJOTjxnaHIqB4garF1K7S6JFa?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3eff25-97b9-400c-6b57-08dca9f646be
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 02:30:39.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGCTbxZAJ8OK+ljdkWoTDqKIrEQfBayqud0Rk45c6UeRSBvvK7q2TSlaWSavf3O6HN3K5Pl/dr7MlsAyVfRw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5830

Hi Tim,

On 2024/7/19 6:03, Tim Chen wrote:
> On Wed, 2024-07-17 at 14:33 +0800, Gaowei Pu wrote:
>> Currently we encountered a problem that the cpufreq boost latency
>> is about 10 milliseconds or worse when we boost through cpufreq QOS request
>> under high workload scenarios, while the boost latency mainly consumed by
>> schedule latency of policy->update work.
> 
> What is the tail latency now after your change?
> 
>>
>> We should ensure the low schedule latency of cpu frequency limits work
>> to meet performance and power demands. so queue the policy->update work
>> to rt thread to reduce its schedule latency.
> 
> If my understanding is correct, kthread has a default nice
> value of 0 and is not a rt thread. 
> 
> I think the gain you see is
> your patch created a dedicated kthread work queue on CPU 0.
> The work from policy change no longer have to compete time with other
> requests coming from schedule_work(). 
It's not just other requests coming from schedule_work(), also some normal
cfs tasks running on the same cpu.

In order to not competing time with the above threads, i change the thread
policy to rt and prio set to 98 to reduce the schedule latency.
> 
> If the policy change really needs to get ahead
> of other tasks, I think you need a dedicated
> workqueue with alloc_workqueue() using WQ_HIGHPRI flag.I think the cpufreq boost or limit action should be trigger in time to meet
performance and power demands. An dedicated workqueue with highpri will be
better but maybe not good enough because cfs pick or preempt policy is not
purely based on thread nice value. So i think the final solution is rt thread
and the policy change work deserves it :)
thanks.
> 
> Tim
> 
>>
>> Signed-off-by: Gaowei Pu <pugaowei@oppo.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 24 ++++++++++++++++++------
>>  include/linux/cpufreq.h   |  4 +++-
>>  2 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index a45aac17c20f..e6e42a3ba9ab 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1193,7 +1193,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
>>  }
>>  EXPORT_SYMBOL(refresh_frequency_limits);
>>  
>> -static void handle_update(struct work_struct *work)
>> +static void handle_update(struct kthread_work *work)
>>  {
>>  	struct cpufreq_policy *policy =
>>  		container_of(work, struct cpufreq_policy, update);
>> @@ -1209,7 +1209,7 @@ static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
>>  {
>>  	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
>>  
>> -	schedule_work(&policy->update);
>> +	kthread_queue_work(policy->worker, &policy->update);
>>  	return 0;
>>  }
>>  
>> @@ -1218,7 +1218,7 @@ static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
>>  {
>>  	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
>>  
>> -	schedule_work(&policy->update);
>> +	kthread_queue_work(policy->worker, &policy->update);
>>  	return 0;
>>  }
>>  
>> @@ -1301,15 +1301,25 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>>  		goto err_min_qos_notifier;
>>  	}
>>  
>> +	policy->worker = kthread_create_worker_on_cpu(cpu, 0, "policy_worker%d", cpu);
>> +	if (IS_ERR(policy->worker)) {
>> +		dev_err(dev, "Failed to create policy_worker%d\n", cpu);
>> +		goto err_max_qos_notifier;
>> +	}
>> +
>> +	sched_set_fifo_low(policy->worker->task);
>>  	INIT_LIST_HEAD(&policy->policy_list);
>>  	init_rwsem(&policy->rwsem);
>>  	spin_lock_init(&policy->transition_lock);
>>  	init_waitqueue_head(&policy->transition_wait);
>> -	INIT_WORK(&policy->update, handle_update);
>> +	kthread_init_work(&policy->update, handle_update);
>>  
>>  	policy->cpu = cpu;
>>  	return policy;
>>  
>> +err_max_qos_notifier:
>> +	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
>> +				 &policy->nb_max);
>>  err_min_qos_notifier:
>>  	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
>>  				 &policy->nb_min);
>> @@ -1353,7 +1363,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>  				 &policy->nb_min);
>>  
>>  	/* Cancel any pending policy->update work before freeing the policy. */
>> -	cancel_work_sync(&policy->update);
>> +	kthread_cancel_work_sync(&policy->update);
>> +	if (policy->worker)
>> +		kthread_destroy_worker(policy->worker);
>>  
>>  	if (policy->max_freq_req) {
>>  		/*
>> @@ -1802,7 +1814,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>  
>>  		cpufreq_out_of_sync(policy, new_freq);
>>  		if (update)
>> -			schedule_work(&policy->update);
>> +			kthread_queue_work(policy->worker, &policy->update);
>>  	}
>>  
>>  	return new_freq;
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 20f7e98ee8af..73029daddfc5 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -20,6 +20,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/sysfs.h>
>>  #include <linux/minmax.h>
>> +#include <linux/kthread.h>
>>  
>>  /*********************************************************************
>>   *                        CPUFREQ INTERFACE                          *
>> @@ -77,8 +78,9 @@ struct cpufreq_policy {
>>  	void			*governor_data;
>>  	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
>>  
>> -	struct work_struct	update; /* if update_policy() needs to be
>> +	struct kthread_work	update; /* if update_policy() needs to be
>>  					 * called, but you're in IRQ context */
>> +	struct kthread_worker *worker;
>>  
>>  	struct freq_constraints	constraints;
>>  	struct freq_qos_request	*min_freq_req;
> 

