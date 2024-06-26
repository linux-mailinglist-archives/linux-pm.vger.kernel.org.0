Return-Path: <linux-pm+bounces-10027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE8917A45
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 09:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE911C235CD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BA15E5CB;
	Wed, 26 Jun 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DSbYHiAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984814532F;
	Wed, 26 Jun 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388690; cv=fail; b=YFXHnNrnYcta250H1tbd1FoZB+0rRTpWi41sEFDdQ+Cl2UOeQxMmJX33v+/cB52F6uynbK2q346sRSew34bYjet3PKlIjLhtz4mJDS3n7o7yLc/9oih8fkEDV6K6Py/LwTR3dA01Zq1Taps7e4EpZThOJXaqaGXohm86sIkLpbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388690; c=relaxed/simple;
	bh=H+o60DO4QGIl+6OsPdfZmlz2v8F11zD24l3dmtgvx34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pY96hUm03O1iqNkgpWKviheDFN/BfPp6rwAgIzSNc/XEtR+kap5UQcugmbdDXTy/80evyv4M699UeGN5qAtVEPQb9hGs/mM20OYJgp3JKFL419sKoHNNJUfp8wQyeNcdZb0qrNOZbU2n/QqI4bTYe2zpdbzmgGBpHOFpcxyBQFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DSbYHiAX; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITZrMN5QHNJzdeemQyhg6nW80QWV/hI5U80igNWeiykfcwOQlnkFp6iz7DWNkFFlKpSLm3IBNAh53UQl8QNW9iS6UiX1TNavhvBAMNPiDy8FO7irbnzyBhn5gwmXKEOinV16Bt1DX48OewXt10P+UY7bt26lQCyikRx61iH5cCVm5kg9gNseSunV5TgkdKqrBo6MaJOEUJR5MMMjiBbjrNdr1UL5hXwFTCS2KzzLk6ZaKta0a0D5YynJi88SkoyaMshspr8hPrIHI+SkI+JganfoWZTh/vSmDFjz4ZZCWz33dDF2mAAOs3I6fDCz/bTQacYxFghxaOmiuyuliDCcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnKSZ/lnJgptltrcRcMMVWWKQsmFFSVEcE7HJ3sXg4o=;
 b=KMDEGp6j4Ff/nbaIq+JkZH9zotWOp7EB0gqQD9T86psLK0IN37+ybSj7CYJiWzkNvmofoV7Qg4tl11mZIlgkzGQtVyGQ42l6CtGnGuXL3j/0Q+V3ITmNNhhSQ9Rjn+VH2TFz62ypr95RA/V/jtMwx7rrTk6RUSZ09yEgXa/T3wDreo7PdMq/Z/iAb9/eQwukUU6rD+zqnwuj4CzAwPx03gXhMuEQ0qPwY597rGYfE2qD1th8AaBaCkbAUJ2+JdU8PYX0ZoL3IG/Rvon56b+dz0VEZA76uVvVqicTCruv1dd1kknebU6B6BxS0c7MKADKWRzW9MQGPMIsuv2jYGxhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnKSZ/lnJgptltrcRcMMVWWKQsmFFSVEcE7HJ3sXg4o=;
 b=DSbYHiAXjQooXB11LXy/NMciPdsXPMHFxvXx1t4lTTHISr+D5VWL708wurcqZiR3twFNsifbL+5JChnN1mbBcAwKPYF4xnT4nPReMcXAjGrY1PzPLbvdy189EMsK/bAAP8FRQlrT4fl4+wt6JJ673XoR0JTTZSvpREauXHbfbUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:58:06 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 07:58:05 +0000
Message-ID: <9b4251e1-e250-4b79-8e08-5ca8e44fb101@amd.com>
Date: Wed, 26 Jun 2024 13:27:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Fix the scaling_min/max_freq
 setting on shared memory CPPC systems
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, mario.limonciello@amd.com, perry.yuan@amd.com,
 skhan@linuxfoundation.org, li.meng@amd.com, ray.huang@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, darcari@redhat.com
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
 <8734p02s4t.fsf@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <8734p02s4t.fsf@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::30) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 298efb4e-363b-4d4a-a090-08dc95b5b629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHFVTXV2ZHJuY1VMa20wcWhVakNyR2k5M3RoS3lCVldVZ1NUTEdWSEMraVZy?=
 =?utf-8?B?a1Z1cmE4QWxlTG43aFJsVlJoaW9ETERWZ29BdGhmNVN3Vm9jS3FCWW9aMTE2?=
 =?utf-8?B?VGlQUnIxVXJWenp1THMyMmwrM09LMnNXQW1FRDl4STdqVE1oeXJjRWwwRU1r?=
 =?utf-8?B?WVYyL3NKcUZVOHBlb1VnaTdEWG5vSGJTZmFzcStjelVKLzNXOVJsM09FMWRX?=
 =?utf-8?B?WkJRQ3pqd1lsakNxZ0RBQzFyTUJXSXpEMDFwV1dDeU10YTdTZmxFRHR0ZmhQ?=
 =?utf-8?B?bHE4SEszMHV2dE9LdGZhY3FyckFzN2tHWTZmcGkyc0VGcEZTUzFRWHpEdXZI?=
 =?utf-8?B?NXZVUHpOQUZmdlJ4WmY1YndhaERRU1YrbkozWXlzNnRVc0pZOUg3ZG9GWE1F?=
 =?utf-8?B?NGJRWERRK2tPSHZpYWlXMnh5UUJGa0w5TmdLTU9TMlh0dWd0ZG5nN0hoWEMy?=
 =?utf-8?B?SG1mZU1vaEhmSDFuWTF0VjJLV3ZkWTZmL3BYRmkrVjljV0s0TzhoQzVraVRP?=
 =?utf-8?B?bVYyK3dYMzdWSkgrY0NHS1p1Y3VwSWNyOUJwMVA4M2NjV01QK0hadGpjSXRs?=
 =?utf-8?B?VVR4MDRBd0tFY1FVeFBSSFpySWRMOWliT1JXTThzR1JvZ3ZYVUlnQjQvZGls?=
 =?utf-8?B?UXM1WGM2TW83U1h5RXI2TTdNdEtzUkRlV3c1K1VaQlJBek5LWDNDczJQMGpC?=
 =?utf-8?B?QVRKbkFVQUxEVnRCbkx2amJjZ1hNL0NveVFwVzFKM1N2bzI1VHQyODlrZjJ1?=
 =?utf-8?B?VHJFSC96SnY5S0djdmd1NGhaUzFCS1QxczMrUFllR2xJWTBGMHRYalVKNGk1?=
 =?utf-8?B?bmVkdjVuQkc3aDF6dVhpUUJhMVJ2QzErenRSVVVwcnNVYkx0VUxwU0NldTlJ?=
 =?utf-8?B?OWJuN3dWaENzUUlJRGRqRTdYM0o4ODNqYmpvZGJsOGQvU1JaaGIrc2NTQnJl?=
 =?utf-8?B?dm8wZ2ZOZGplTGQ4cjhDazRZcU1QZzBXV0ZiM2VLOGNIVmlXUWRZZ293enRu?=
 =?utf-8?B?aDZ4aUVRc3hRdHVjSkNJT2xjbGlyc3A4K3gwZmc0VGxPNm9EQ3JRdkpkQXAw?=
 =?utf-8?B?RW5DcllmRCt0bFdhUDlrTXV4RjRqK0g4eS9BVllxWmZKWndMRmwvczRaM016?=
 =?utf-8?B?VUJRUTlneElxRytCV2RMSDU0RElEK0FrZFU4enBTakt3UDdDMjU3R25ITm1R?=
 =?utf-8?B?dUJpVzQ3dWNVNmhvbDRZdEdnQVJEOXIzUzJNTzgyd3RMRFBJVTI2QjlSb2ls?=
 =?utf-8?B?QXhuWjE1d2tJUTNEQkhuNSs1ck04TFZoamR5S2pHNG5GMVRtRXZiSzFWdHEw?=
 =?utf-8?B?dnZCcEpuMHQxbWx5eFRqVXYvM1pJUzVMZkVUZWIwQ1B6ckt5OFJLZUcwY2hv?=
 =?utf-8?B?ZmN5NmlrbUE2OVA1OFFpYkIwTTloT21mOTR1MXlpZzgxSVBkbVFwd3JTNlc5?=
 =?utf-8?B?bkpPZUFlZDJvdVRQVFQwODlJb3U2RGlVMTNoYVJBMEZtdnptY3NyMWoyYVB1?=
 =?utf-8?B?VTBOdExOdUNKK2lUcXczTGZRUTdoZ2E5Q3JTaFB5Tmh0UnMyeGdiRGZzdU5n?=
 =?utf-8?B?ZDRNYVVwWjVRUmxYOGN1aC9zTW1CaktnWmYvbEJreUlxUFM1TzZLTElWMnFZ?=
 =?utf-8?B?T3lMSzNIWlZ3NDNXZTE4Z1J0d2hmTWlQQWs0aVo0ekZtSm81QWlEYjVCNGln?=
 =?utf-8?B?NEhCYkt3QjNHNGVIakVZUkxvVi90bS9iVm9lSlVvY2JWZjVwVU5uamNHTFJv?=
 =?utf-8?Q?74ilMGPVQ+QqWDNFMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVNpWjcyNnMvOHJHOW4ranBoL1FqbDZpUE5BdzU0YlV4ZTFBMTlBblJlWWVG?=
 =?utf-8?B?SkZNS3RmL2hXY1ozekFQS2dTYjZsWUdCdDNhdDhtSUExOXV2NFZjTzQxMlZt?=
 =?utf-8?B?VGZGeVJCUTFaQzJrMmJBRHllT215ZHZTOHpwdFU3UjZ1WW9YQnFXbHZiU1M4?=
 =?utf-8?B?V1NlTnVxd1RXbDdJY3Z6b3luWkpXZnd1YjJIdGJTRHN5Q1UrUHFIZTFLNC9l?=
 =?utf-8?B?L3dpNEthMDNHa1N1TzdNcDBadWRqOXplTkRUZ3RoajQrNWhNMkIwbnl0ZzFv?=
 =?utf-8?B?OHlNejMyUmFybWJ3U3ROaVEzcDJlYTVUNkIzWWRCdmh3d3hrSm1BQ09kWjYr?=
 =?utf-8?B?SWlITUZwR1VYMTBDZWFacWZ4aUlJdnFaUi9NZHMycHVjVVlpa3poNFA5YWFt?=
 =?utf-8?B?NCtRNXFSMzhYU2FwbDVINGtwdnNBMjdhNTNqTjFjSExoV1FqRmJ4Q29LU2dZ?=
 =?utf-8?B?SlhpclFFM0RWQkFhZUxJTzVMTThFWmVhRmJqRmlFSTd4MTAxSXhsdEtjSnMy?=
 =?utf-8?B?VjhUR3BQV2VXOUZrK3RSUFJHcnZUejNva3FuQ2RGb3JvdWVHWEhVOGxCaG45?=
 =?utf-8?B?c291cHZEQW1XT0Q3ODR5emhHVWN5cDZlcFBtY1VtZzB3K09Cd1h1MFlMc1RK?=
 =?utf-8?B?YUF1NWxmSGZlcjZ6SlFZNkE3eWlzSE1lb1ptQVFpa2g4SjZNWUhmQlhrajl1?=
 =?utf-8?B?VUtiNlVETnVBVlBlUXlUUHltQzFwLzc5TVBJRWNscUJsOHkxWXZnMEJmREpY?=
 =?utf-8?B?a3o3N2NkWFhSOFF6QjJIeHFZdVM4L205VHhMcUYzb0NWaStJUkJleDFZQ21Q?=
 =?utf-8?B?OFVDQlJVRGNzeU55Y3FBYUt4ZTlRdjArajNqTnhRQVdzUzg1b0hyb1BDNEx0?=
 =?utf-8?B?UHdZRUJqNUx2ZkttSGV4MXVpT3RDZGtOa3huWWU4Rng3QWV2SE1IcUNQbi91?=
 =?utf-8?B?T3E4Z0dPS1cxMTBTRS85MzE1dkx6WWFIWUtCbjRvaHhaK0h0RXdSVy96ci9B?=
 =?utf-8?B?bHE2WlJWa2pTaGxJaVZmY0N4WDMrNGJMS3craW94UDVIYW83S3N2R0V5T25j?=
 =?utf-8?B?N1h6MFVONitQR0pudklDdUUvR1NZV3BVNndYNWR5MHA0c1lWYXJLUXgrMkpy?=
 =?utf-8?B?eUxOcHRJZGRoK3hyNnYyaFRwSXBnazNzb29lYy82NklQR0g2bXo0MGRpbVFz?=
 =?utf-8?B?TWVrZTMwSlNVNGNRbDZOVDA3SFZERnhCcFdRaWQzRzVvTDdOelNnRkJFbFly?=
 =?utf-8?B?M3ZFdnpodWg1bVpEQ2lzWGhyNlBERGJsM21JRU9ZUlNCTnc0M0dLdFhmSXZ4?=
 =?utf-8?B?NXozc0FjNUUvZ0lNNnlvN2NVdkdYRDNlSWlVR1ZBR3JKWjVxSkxlRDBYcDRK?=
 =?utf-8?B?bGdXMForcENSRUlwYzAwMExZM2lCTC9Id0NzbXdtTk4vRWVKUDlydTZWS2FM?=
 =?utf-8?B?N2Y2YTN5bDZ4clhqaTdmYThSSjV0RFJiWTlTU3JqUHZyMm1nZHVybENmdXZ6?=
 =?utf-8?B?RUFGRGovcWppTzhzdk9rZ2RhK3pxSkZmN3lqT3psMXVTQ2xhK0h1YmNPVnNO?=
 =?utf-8?B?cCtVL1IrSWRkd3AvWVAzOUEzOEZOa3puSGVBd1dRNzhtR3FXV3QwUHdWbW1k?=
 =?utf-8?B?bVlpTHJucVlPWDBodG1ZL0plWEw0THg1NXBiaTdXU0J5Wko3QmlGcm1MTEJV?=
 =?utf-8?B?Q3NYcU9TdXVYMyt3Ym8zVkM3VGxHbnE5Y01Td3UrSkJSRWpic0pESVpaeitl?=
 =?utf-8?B?ckJCWmE4aSt3dUp0aGFVRUxVWlpWblYyQ0RJUkx5ZElNdlJBTEpaY3NReWow?=
 =?utf-8?B?dTZjYnlnT0FySFpkczJYNFRlaGxCeGFrbDdPOXdPVk10V1MrM1krNzBVUG9C?=
 =?utf-8?B?YjBBZVM1clNkYVFReC9FWWlQMGZMa3VYMHVRK3lPVTFCVnNYdFZzMkVWVWY1?=
 =?utf-8?B?QnpEZGptM2VnMmZxeGg5bE1pclhSdHdGbFR2ZzJnUmY4Q3l3a0xiVmNqUXZ6?=
 =?utf-8?B?RHBhbHNIRzZramFZYVMwMStmRitWYTlRSUZid1VpSFpmM0h2eEFBUXpLZUFI?=
 =?utf-8?B?bEJabzF5NzJZQjFDMmZWVmJwNEM2dzZRTGlYWFB2TUtlN1h2SlpzVzVBVTNN?=
 =?utf-8?Q?dTQ3c99XIlKV3WPih7eNNY0av?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298efb4e-363b-4d4a-a090-08dc95b5b629
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:58:05.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9BCDDyBBZXoEknJRtyUjbHTkolIv/DX4PZB13WUAaQ+5vt8jay5cg5SFW47wXBT2GQ17LaYgPhIHy8TIicUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

Hello Gautham,

On 6/26/2024 10:54 AM, Gautham R.Shenoy wrote:
> Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> writes:
> 
>> On shared memory CPPC systems, with amd_pstate=active mode, the change
>> in scaling_min/max_freq doesn't get written to the shared memory
>> region. Due to this, the writes to the scaling_min/max_freq sysfs file
>> don't take effect. Fix this by propagating the scaling_min/max_freq
>> changes to the shared memory region.
>>
>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> 
> Please add the following in your v2:
> 
> Reported-by: David Arcari <darcari@redhat.com>

Yup, will add.

Thanks,
Dhananjay

> 
>> ---
>>  drivers/cpufreq/amd-pstate.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 9ad62dbe8bfb..7c1c96abe5bd 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -264,6 +264,15 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>  			cpudata->epp_cached = epp;
>>  	} else {
>>  		perf_ctrls.energy_perf = epp;
>> +		perf_ctrls.max_perf = cpudata->max_limit_perf;
>> +		perf_ctrls.min_perf = cpudata->min_limit_perf;
>> +		perf_ctrls.desired_perf = 0U;
>> +
>> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
>> +		if (ret) {
>> +			pr_debug("failed to set min max limits (%d)\n", ret);
>> +			return ret;
>> +		}
>>  		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>>  		if (ret) {
>>  			pr_debug("failed to set energy perf value (%d)\n", ret);
>> @@ -1547,6 +1556,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>  	}
>>  
>>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>> +
>>  	amd_pstate_set_epp(cpudata, epp);
>>  }
>>  
>> -- 
> 
> --
> Thanks and Regards
> gautham.

