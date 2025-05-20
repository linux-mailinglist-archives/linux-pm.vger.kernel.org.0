Return-Path: <linux-pm+bounces-27408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1339ABD74B
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB334A2C23
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EED27B4F7;
	Tue, 20 May 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yq/YZzgR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FC2673B5;
	Tue, 20 May 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741615; cv=fail; b=Lw5rfanakDRfGKAe55gSDfaR3yrQF1+XuqiPLWsOQQWW7JWD9kpPxCdVDgvCgGfl1nyFfebU2m+Vg5t5puyVcD0TbZfQmfHkPjMaW2Uj7B3hWQlWQPO+DPXkRmMpdfmyiVsh1kZwByHdQVsNo2Iyu4CDCjZxpgTaq7/sJcY5lLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741615; c=relaxed/simple;
	bh=O0pUG+tJTiMO1ubRMtXyw9ZC/76YrbKV7KXBjtJpDlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYwDUFOGR21xCG2MOxOwIwGkj8dRTMWRkJ3mpgJau2qP2kWHvo0YMsU+y9VDc0M5wYiOtiaDVdvPFZlUeoZ/cVzRt7VowzGOgV8UDr3W3orGmyR7ia1+BB/iWa5o3qxjDf/5mv8ZvmKI6+hp+NRA3Y6T4S7IsmFVBv1gFaX/S7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yq/YZzgR; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUsiBM9AQhgxoMYTTAlc2hba4lZzky2PlnJ6OeKujnF2C6zrFHp+JTXtIEw6ktoiNtqYa4Kf9PFAkkyJO1J5welZJS7tVxMvY7J/uSG20bEf0/sagYT3E2I2k31hawr5UqyWpGds6WQfw2mRY+iysptH6Knjv1A2dPkjAcW4e20QeBUCh2viFZFWODqvV6/avRcIeRirtcJzmZHa+flW+1sAmCEpkJpiS+HuIrD0ohfuCBeuiUGrRHcnxi7rStlOnV3WIO7ays3J4bZlWNY8AkL22nzuNymsLy9/BWXaA2dCPKtQCHtslo0PRuJasnezL0T2ZQTf9Jdv+kZdVWCusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v0SHFJjw8+n2fEBB89wDPFrDIc8UibImU9HNNZRHa8=;
 b=ZKoXT8VaH9yIK1Eb1Ah5n4apAdc+CKQYkVYEzqdrb2p6bNC7UMvgl+pbxsuaFA++DJhMIYkzSVA5xPxAZ4Fh+/GdpMj83k3rTS9ivm/PZc2wbBHZ5pzJ+Wepr3hZfsz93UwTGS8r5+RLRuEEN3AYclAisT/jY5x1lKyvbfgK8l5T28Nt+4QV/4Z3Yno1KHq0yKvWKRywFl2XWEr5Wt+z4gFJr0o/hKh8w+/qN7gcDpyQOBcpbYy8JAFMetOFVWC2fQHLG2U5rWon88hub0KuVTyRCe7J0SJqSuAo9wNt7UusJHIw0wGnn75KuSTyd5ayBk9S3MBsZBZLIsEWbLisEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v0SHFJjw8+n2fEBB89wDPFrDIc8UibImU9HNNZRHa8=;
 b=Yq/YZzgRUOsPfFDg6lKcXbDSUN3SkXqzDY5gfm1PWYlsGf7uF/PTH+rAGPF+KFyqJwitRK8Hhf14NzpSaGEhSMidlBjZtr50OoY1laz0N4YU0hBbmQ09zHxllnmYKGosU9wrV1cN+ntg+7XMOMj51koAtF5+PN/AjLUIRAHhdZLR5lHgdxInBeHpJhuf+s2hXdAe2+G9uV6SGUM03vgKHDbsl+jPUrgMB3DRXNLK88KVZ/WAGuBtoLQmdlA9Kr4fUNJeF/n/mLb6qhuFoXZkUaC0BsN45I8uN/OD8MjHeNQR2WKeMEakSitkwTheFT1exkzQmRDdzJ6Jwld3MXM3JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 11:46:50 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:46:50 +0000
Message-ID: <c4dc20c6-d0cd-4a2f-81be-e672ace75e67@nvidia.com>
Date: Tue, 20 May 2025 12:46:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
 <20250519102618.4thbahapz3lfmfo5@vireshk-i7>
 <972984d6-a9b6-4847-be76-fca50782682a@nvidia.com>
 <20250520103035.udl25zv2uriljrby@vireshk-i7>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250520103035.udl25zv2uriljrby@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0130.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4c59bd-2d12-4cbc-f822-08dd979401c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStwcGd5eHo0TnRpYU9VVjE4Y2hGeUE4Ykd2ODI0ZGVTNGpsZFRPY3IyaFNM?=
 =?utf-8?B?emIwVnBUUVlMTWxNRmlXaytlcnR2ZHZsMkVTMlp0Z1BxSzBraDhXNFZUdzRG?=
 =?utf-8?B?NHdPaWIzbG1VSmFQdjFDWUpEZmtSQlcyWU5mUHV6eHpzSHVicXlXVFVlTGtk?=
 =?utf-8?B?WFU0cUt6Ry95a3pnc0QvSFVua25JTFVmVElsS05UY2tuQzhnaXZTQndTOVN3?=
 =?utf-8?B?Mit1aXB3YWtDcmdHTCsxS0xHajFsK0FXd2s1VnJTRGo5WUZvd1FCMFlFdFR6?=
 =?utf-8?B?b3dJcDd3WmFobFltQTR4Z2FpRW0rc3RyQ090MEVjdXVIYzJlYXRvSnMwVUlH?=
 =?utf-8?B?QUpPaXJqZkFTaE5sT2NjUmJlRk5aRnN2ZUR3bC9kMnFkTFlPZU9FZXc5VXVp?=
 =?utf-8?B?NlU0VDZBWHI0Z3hIQ0ZqWlNTUW11cFUzNnRNbmdzZHp5T242eE5iMGlzNlow?=
 =?utf-8?B?QWsvbzhVejRQQTZXR2ZqazRIU2dydUwxMHh1ditVKzJ0Z1djN3UrWGlKeUpq?=
 =?utf-8?B?cEp5dVBBalRqR3AzalRKalJDOEtOMjdmUEZQSmpleTFDZXhjaUNmS2E3TkNa?=
 =?utf-8?B?cVJPZVJPWlpCNXkrcG5IblM1YmhRZVVPRGxCQ0ZrWHdaWEtQQTU0NUFOZSto?=
 =?utf-8?B?Yk1XTVk3RW56YmFLVCtERU9qaEhnejVuKzh4V1VXZ3BmcHNwSmNFdjk2cWMx?=
 =?utf-8?B?eWxKWXJxOVdKU1hvcDFDSWtWTXJ2L1luWXQ4cm5LT1lYZ3FmVGtEZGlyT0dL?=
 =?utf-8?B?ZzllZXJrSC9VSzdlRWxDNE1LRit3bFd4Y0JsZEFKMGptRThoQVlqTnFvK2Qz?=
 =?utf-8?B?OWlhUDdKQ2V1RmJJN0ZDRTJydnVpMGxLcEl0TWkreVo3WEJZemtld2YwUHFi?=
 =?utf-8?B?MDNmSW91VlNlOUJQNElZY2tGM1VNc1JFTEMyUzc4QTRlVzVWMi95VzBKVHZu?=
 =?utf-8?B?ZmpWSjlCSTduQjdWS1ByU0F2RHdvYzJHVlQxYlBGWTRhUXNjbWlxM3AvTFJN?=
 =?utf-8?B?WFNCNUJ5QkhjTkVHYXlQanlKVUZnTDFCaTc5b080c2RFTG5rWGZrM280QU5X?=
 =?utf-8?B?SzEyeU8zSWhzc3h4UXVuSFQxL0dZMURMUXJ6RmM3U3JzVlVUWE5Kd1hSMno1?=
 =?utf-8?B?VkJTUFllcHpBanZ0RmlocEYyMWMxSCtxSFdVL05tOEdOTFhNVVYvKzhwbnB0?=
 =?utf-8?B?Y0ZoeXRnczFLMHRPZVZVa0krSEZHSjhicUxQMUhTamladXpxRXk3emNVQlVi?=
 =?utf-8?B?MFN1Yk51bU5FOU9oOHdBNW9mVHd1WnVwSS9SZ0t5b0Y2OVkyS1JXWmlNZElM?=
 =?utf-8?B?dHNtYit6T3FhL2g4UXJkZDdkdnhUZXJ5WXA5SHIyZ0xiZ2lLbDlsd2x3S04y?=
 =?utf-8?B?dmkzOHpwRGkxTkhjdHFibTF4RnV1SlBrV1FZT0FrM2hSaUNTMHZOa1ZRK1Fo?=
 =?utf-8?B?c0dLdDNCdnloNk9jUGRzMUdJdFRZcElPcVNaamZIQmtKRHhaRWVzY3dyODNT?=
 =?utf-8?B?K3pQS3dzREpMTFZETVBkTmhKTjFVK2I2dWNEanlNS1Q1aG5HYzlHTDFPR0h5?=
 =?utf-8?B?QzFEd0RsZk9xZU9OZkNEaWFoZ3I3R3VwZlFxQzNqRHBrRXZTZ0ZvSWtNeUVX?=
 =?utf-8?B?MW9td3FuZTNhQm5wT0xndkNVUlVGYnEyN2szUnRnclRLdXhhVC8vTnplM3R6?=
 =?utf-8?B?YkFMTndrdkkwa1Y2aXVMa2laNjRGSFBLemZFeFhNenVGbjNuYzlSeUNyeHNY?=
 =?utf-8?B?RFZid1JKR0ZTZEpqWTlnSU5jbm9JRFU2ZDZNbFl5OHBnV3RTTXQza09HcW9s?=
 =?utf-8?B?VXNHbkRxWUpiNTc5Y3dVUHRJcHZzODgycEc1cFU4U2QvMVhrNXJSaW00ZXNl?=
 =?utf-8?B?K1M3N1VMQnZoaXJKTTFVSUg4Ny9UWE9vblhOQlJCMEh2cjU5MDZpZWQxeURj?=
 =?utf-8?Q?Qm+g/tPgH+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUg0aVZwMDdaaU5XTkNZbTZuRlBKRng4ZDlWK2NobnQzekV3SW5URzd2OHp4?=
 =?utf-8?B?RjJLRUF1cDR3ZU1DTldlS3k4M3QyRkFIZ3g2cDFSYXpqUkdTdVoxRkl1Qklh?=
 =?utf-8?B?K2JuTzRaSENkVG9KUGI3NHAwa3Z5Wm9BYWlxYVJzemthdjRVclpXOXNrSUhJ?=
 =?utf-8?B?N1krdXBlZWl3RVA5TWhLSUMrelZHZ0NJRlRIVUVqa01DVm9aQXhEdHhsTUVy?=
 =?utf-8?B?cjZzTTVPTWxUQ1luTU9ON2NrSHJYbGtGQUFwTld3WVNpbkI3L1ZBRW5TTWRB?=
 =?utf-8?B?Z1I2NmNrdUQ3VDRORlhoRmZLa0IvM1JTR2ZQTFFDTlpjRWZYM0xYQ0tVV0xh?=
 =?utf-8?B?UlRCQXU2VFI2N0Z1MUZiN21oQStlVDlWMTVpUXVLQjNQaGx2L3JaNTNzZm0y?=
 =?utf-8?B?QktWME5jeTk2MktVSTJOTFV2aldDemRxRStzQldVdHhkTElOd3htZ2swUEs5?=
 =?utf-8?B?QUhSQ2RnT2VLMXZOSHZnOEM4QVZzUlhWdllReG1leDVYQ0lJcUhlUVM0OTdK?=
 =?utf-8?B?TDA0bTBSQ3pyb09xRjJPajAveVlZeTcvMHhPOVhmWkxVWlJSUVp3elcxOS82?=
 =?utf-8?B?Y2NKNFZsTDExY0hjMlhSK3BSM1YzTmtTa0t3K0dzV0luYnRvL1YwSTVkZG9i?=
 =?utf-8?B?VEt1b01SbUhvSyt0OVpaR3Nra2JNV1oyaktsdW13dmxLek8wZElIOVhxME5y?=
 =?utf-8?B?L05uaFdsZnhQeE1lWitqQ1Q5dTQxY0tqV3ZvdDRaYTJMdXNuR1hmd2tDNktN?=
 =?utf-8?B?OHJIK3Q4U3k4VnlCU1dXaVBCeEtCT2NaSVlmRDFwd1lBdUtBb3NRWVJKaDBR?=
 =?utf-8?B?Wm05U0JEWk1OL3ZGd3RVWDc4eDZxVWxPNEphSjh1WEhkcm5uQVh5WloybGE2?=
 =?utf-8?B?MXB1bzkwWCtVYU56dWRYUUhuSVQ2YXJqVWM0VUMwNmJUTlJlRHpxVUpqcFZj?=
 =?utf-8?B?V0NqT3FWQmVQaU1IRUdqcGhXQVRQdFByd2M4eXQ4OHlxcExRMWRUdTE3emNQ?=
 =?utf-8?B?eTFTY3duWjRibTUrQ1FreGMydlVqa0w0ZHJZUTEvWXVnbzVlRmkrYks5RE8v?=
 =?utf-8?B?OUFlU1RnZnZoZU11a2Y2UWsvM2FNdktFbGF0eWNkRExoSDZvQVBWcmpyODRx?=
 =?utf-8?B?STllRStoTmJuRWpvT3BvK05oUnRacEpPLzhEdDRHQkI3Z2FKZ2ZPT05tWjZo?=
 =?utf-8?B?NXp0dzF0ZkVKanNnNWJyNWQ3NnNCNG9haUx2VWZhcG5KNGtEcWVLbWNGMUd2?=
 =?utf-8?B?TW0zWjdjbHVHeDl5b2dLSTNGb3RWVTNzdjVwRkF5azJBUGlTNkFVNGNRM21u?=
 =?utf-8?B?T0tCUk9JWjR6TVhaMjdDVTFDWWtld1BvZkc2bDRDOVFXMkN0M3ZwdlFvQ1Fz?=
 =?utf-8?B?MWVmZHBDQXZWRloreHhSc2FwVTM5NW5OZ3djZUdGaGxlS3JsMXFqb3JPdGg0?=
 =?utf-8?B?ODR5QmJGQnl2Wm92TmNxcEFNNldNa1ZVR2ZjNVZnOFhhODAzZ0xDTkFreUdZ?=
 =?utf-8?B?YlRPZmZZeGYvTWcySC9ZaXhyV1V6TGcvVWkzcnpUVnhaVHRRYkhMMWtxemtP?=
 =?utf-8?B?bm1iMC9lSDUva0RNQnZxbEI2TE5NaXArTHdWMnRaeXpQSTdNKzZmQXAxSXZn?=
 =?utf-8?B?TGlJNklnRmVoOHpJaWkzeVR1RW9kVUpvNlFYR013RTZJdWpXT2k3cGc2YlFk?=
 =?utf-8?B?T2NxeUdSVnZuYWsyNUFnMDhGYytoVHA0RHVxc2g4OVRFUkhOVktYR2xJZ1NX?=
 =?utf-8?B?STlxcDg0MmZJVmJvaWlHOXlXRGJHTkY1S3JGT2graWdPUEloeXZiL3BacHV3?=
 =?utf-8?B?VlJ4VFZFa1lXcUVkanFKWFM1TCtVRU5UYXpXdU5VOUY3Z3FUT2l0ckNhY2NH?=
 =?utf-8?B?YWt0NVNwS1FlV3JjY2N3VGE0TTF5WHR2QkZqQmFIdWcrK1BQVmZBQThIdkV3?=
 =?utf-8?B?L0ZXNnlmUFVRemZURjE1ZkVFQXFIYmlQNTdUV1NRbUJkZFJDWEREdjBSaC8y?=
 =?utf-8?B?bUZ0VW5la2t1RGhlMjUyUkt6MWtBVWRYVk5IM0ZVMnpYQ1BsWVprRmdHdlJM?=
 =?utf-8?B?ZmlVdXN4T3ZndTYvVFYxbTVaaWloMmVrNWh3NFZvbGU4R2ZqcHgreStxSDU3?=
 =?utf-8?B?dzFzQlZnZHhTcVJvTVRvdVVURVRPN0ZPdWhIRXp0U2ovMmRJWmdOaTNMdVR5?=
 =?utf-8?B?ZTFWN25kSlFyd1V5WUVRc0o2UGpLOWdXNFdVd2NKR1FXaW1wazZvLzJQYWd6?=
 =?utf-8?B?Si9uUTFVV0c5Nkx4b0t2SGE3ZmZBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4c59bd-2d12-4cbc-f822-08dd979401c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:46:50.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g2nS544FuWIKI8zN2SuBqofIf44fsqM1Sd7X88iI3fLozOq8iV6IiOPIgvTXEFpEMcJTjMZY03g1q5LbUbhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583


On 20/05/2025 11:30, Viresh Kumar wrote:
> On 20-05-25, 11:03, Jon Hunter wrote:
>> On 19/05/2025 11:26, Viresh Kumar wrote:
>>> Not sure if we can do that. The clks belong to the CPU device, while
>>> the devm_* functions are using &pdev->dev. The CPU device never goes
>>> away and so the resources won't get freed if we use devm for the CPU
>>> device.
> 
> That would have been the case, if we can actually do a devm_clk_get()
> in the first place, but...
> 
>> I don't follow. If they are allocated in the probe using the pdev->dev
>> device by using devm_clk_get() they should get freed when the platform
>> device is removed.
> 
> ... devm_clk_get(&pdev->dev, ...) won't work here IIUC. The clks
> belong to the CPU device and not pdev->dev. That's why we are doing
> of_clk_get_by_name() over the CPU device's OF node here.
> 
> Maybe I am wrong, but I don't see how devm_* can be used here for
> clks.

Ah yes, we are using the 'np' pointer for the CPU node and not the 
platform device node. OK scratch that.

Jon

-- 
nvpublic


