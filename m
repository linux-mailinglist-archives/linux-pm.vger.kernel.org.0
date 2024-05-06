Return-Path: <linux-pm+bounces-7537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87A8BCEED
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5104B20E0B
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C52763FD;
	Mon,  6 May 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKRp77bh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC6763F0;
	Mon,  6 May 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002158; cv=fail; b=E95uW+QXtImirjbkIbR86HmKJx7M9vkARWmQMfjaFitJr342fH9h4mEwq7gv+5ysKsuW/KpKB02PVql05jfxHtdjf2SfUsd21njO8KlOQzeEQ/1k6guVF3sPYhiIj7NcH08ZWrovWaZAgEM2pXdYvg30uhh6QRgLEMZDoJabwN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002158; c=relaxed/simple;
	bh=0zjAMuWKYQscHoLMW7ixqNyEmL1OtNLiLXmdhPV9FKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ek8clnl1UfEkxmLDw/dUsIQWiSxqIgDOc6YJbGUCchsAMrgTUjJHcrxzJwWvsYY3UydQ+fgg+woNjxHNbBZ+WMj1ohj6qgY9txqA2tRlKsVgcTQhYRUph8Q41CNQFwIPuxx7kcLkeGAdAdHHIGqVUP5edmi1tlWy/RPijHAXjhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKRp77bh; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aALu8x5I9QX5xOf1AcEXADmHjqgRXlELpE2dSK24ljYspC2zQHBpn7uMP859rDFbrNIMzQlzvG1hDYgKnTAXwIVwr2PX2AQv/2ddgMNFdF/Uc9AB4zzHul0/0oAXTlQ6vVBiXeK+iVymEU7ysF6hSjG1EQZENhpIusRMRFn5aEEvTpcZrFtPMn0Dhl30wTXzyW3Xl80lwhZj6sekKM1XM32B4XGTbMbAzPwlLGRRnvM52reXb4vqnO9uzx7TOD5Sv5U9m1ttTu4psxVYgAUi7q8pPzheGEYST3koxWUA5sFZ6rEA+xpP2JPBsXXMmfHpuV6jKo5RxLEyi8g5mxF7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzdp7Rz8cHt+3PacvRjoDNwbMCoeQz2SnhmPAxOwJdw=;
 b=ddCB80vyDmkhUmLFKz4kW86YdE+G7xiJ2gEBH0MDeSLNyUupjnUvysfak8ypoTUEFmCXGDObn29S8RcaFLnod2EqAl2BCkeobQYfp8lKVwdOP7876kJfwBWsm7Tbzxf+7AgalyJQ+bEattSbay3TxkolQ9K6NcPzlgtZBfn8mcn0E+8drja2Fa5RNLKf/jz+h6DhNjPLzTl4/A9QyQ1yU6s99G0KAHqXPltFToOvI9IaMn2F8Nd+6XDd35vHjUxc4udeQ9Q4fxNv2JG+liMP/8hEKonWag6NNFEx4uuEZ8jFPmc1Ptme3xdp5lfzpjFHTGF0ZmKjNTANKI4teiZ26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzdp7Rz8cHt+3PacvRjoDNwbMCoeQz2SnhmPAxOwJdw=;
 b=GKRp77bhili3l/FJRcwLya3oI1v1eGUFPyUtQCRgXG00yN8bdQ9jpZv+yWN1LJTDKG4stfINzEkMyBAIGNfhKF+lvJTdR2UPqthVgWcQOHuEQHEpxdJSh0o0sANjwaKcBOdZ9OkQszNNJkS7FNSleyabYCMUhpOLEdosA9jtN4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 13:29:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:29:13 +0000
Message-ID: <6e97ca41-c730-4bac-89db-d3cfdfa7d8b2@amd.com>
Date: Mon, 6 May 2024 08:29:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] cpufreq: amd-pstate: introduce per CPU frequency
 boost control
To: Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, Borislav.Petkov@amd.com, gautham.shenoy@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com
References: <cover.1714989803.git.perry.yuan@amd.com>
 <2d200d0fb4135465e81b9213de940e31a7b88dce.1714989803.git.perry.yuan@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <2d200d0fb4135465e81b9213de940e31a7b88dce.1714989803.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:5:14c::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 66aaab12-857f-44e3-b0b6-08dc6dd08510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDBZS1ZVZkxDM2diYjlUejBzWG1GODhCV3ZwdndqRjNLWFM2MlVtR3pPY0J5?=
 =?utf-8?B?L25NM0g1RWRqbitnUWtkT1pRVkYzYjlmUStIaFVDbUw5MCt4WXBEeEJDTmZv?=
 =?utf-8?B?OHJFdWNUZHZRMUV1YTNNVXgyR1Y3MHNjYjFGdlBIeE9pdzUySHppM3hMd2J3?=
 =?utf-8?B?NHExUDRRbW5Gc0VyNC96NkxZbnY3Si9CbU4xbmlTTUpiQ2xZbVlkUFhyVHVD?=
 =?utf-8?B?VVN5Qzd1cFlPS011ZUlVdnlmakozTU0zd0dQSSt0OW5ZYW1DVE9SNVU5cVBP?=
 =?utf-8?B?N3F3UFozdFhqdTEwbVFDTCt4VlFUSEpUck5iQnllWXNNcCtBTkl6d3B2azFu?=
 =?utf-8?B?ajdTQTRHTmVhMml6WXN2L0VVbHBaMU5vaUhLMVpxVEpEeWVWc1l4S2c5OVVl?=
 =?utf-8?B?b210V0hPVTdEZXM1cldpQnhaZ29VR3p2alNjZlZKNzUwcTRsVnh3eHFGWldl?=
 =?utf-8?B?TUZUR2xEendyekFkY0h6cmJiZnlTNVJtUmFOSmxkblFKOE1RN0JBL2hEZHQ2?=
 =?utf-8?B?SlhPaEZLbEdSUWNscndsN211SlpEdjNFd2hmZ3VwTzZCMGRuNi9keDdSVk1E?=
 =?utf-8?B?ZXlZYytyYXdyT2wwcGtiV3V4ak1JM3NhR3IxcUdSakRSNzhXeTdrSlJlQ2hq?=
 =?utf-8?B?T1JXZldRQmtQRTdMc2gycDliNGFhSm52L3hoK0pTSHBLMjRzdXcwMDRYdFNj?=
 =?utf-8?B?MUdXRC81WkE1WnJ3azZRUVAxODBjSWlYbDkzcGJNYVVHRXo5T2tHS0l6S3FO?=
 =?utf-8?B?TXJXOHlieWtpVVlwYXdBSVJhUlFNUFhrZFQwTU5wdVlXY1Y3eHllQ0tjZG8r?=
 =?utf-8?B?dVRkd0xaNXpTNS9MbnhHS2hJcnNTNkRTU3lYZDBaaFhlR0dYM0l6WmJ6SDdR?=
 =?utf-8?B?UzVsMHF6bEkwRElyakxBUWgyV1kzbWJTNldFMlM5NUQ0SnErazdIVzJUcGFK?=
 =?utf-8?B?Z0g4YWJ3VVFDT1BWREQzM09zRVpvNjdWMzZrTWwvYkhpNi82SVAydzdaMUVF?=
 =?utf-8?B?bW0xa3RzM0M0S3lJTFJNUnkzUHM1d1IvQlUzeUJMMElNR0JpbHR6eC9WN29E?=
 =?utf-8?B?N0ZJVVFVbHhYRmFYRWh4RmR2b3BIS3RDMVlKOGVqeGF2OWthLyt0TDBYb0hT?=
 =?utf-8?B?L1M3WmZjcVlIam1hTE9PMi92RFRBZnl6ZXo4VUMvcDBNM1FoTHYxNG5rVEVP?=
 =?utf-8?B?K24vUnV3QitkcUgyUkJyQ05JQzE2em1ycTk2c24vNFBuTnJVZysyM2FKWVhP?=
 =?utf-8?B?bFBlVEhXRys2ekZCYTJEenZxOEZBZHdKK1Q4MEc3K1E0eVlIb1krTTRJZTNC?=
 =?utf-8?B?c3pRdXlpU1MzN1hnQnh0QndvL0UrZDlsN2tFNnNlTXFkc2pUUmY2N2tpazBE?=
 =?utf-8?B?bUdXcG9OU2NOQUpBSEVyNjFVZk9UZEw5dGdCK1lKVS82elZEUGhjNjJ2Q0dm?=
 =?utf-8?B?aUhUNHA1bjNEL3J4VnFPOTZQL3hpOVg0ajJmWmpETW1MSlBxa3g1ckpMVVhp?=
 =?utf-8?B?VzFvZlVpakJ2RWxmTkhBZ1RWQ09xUzEwM2NlbTRTWHhUKzU3dUZ2S0pLVWFa?=
 =?utf-8?B?VytVekNVU0VmVEpaSnYxSWUzTHRxUjRsdm9SQzRhcGZ0anhETGlBSnNJZHVK?=
 =?utf-8?B?S2VCakZGUG84WWJDZXhkbXRxbEpLaGR1Y1R4UEdKNFEwQitOTnhJZGlPdXJm?=
 =?utf-8?B?bFNQZS8zeDNUT041VHRFS05RTmtYY3hTV0J1STVSREExcGRXRWxmTzJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M24vZ2kvVWtjZ3crUXMrSmlKRDA1bndKcWJCaDRiSVhtNDRQVTJjTUt5Tk1X?=
 =?utf-8?B?ZHpQNExNRUhyT3Y4YjIyQUI0bGp4VkRZSkVmK3N6eDFad1NidDF2Z2g5UjBw?=
 =?utf-8?B?aHJLdkR6Z1dTRFJFbUdiYzNDK3lqMjJoUk5IUFRnMHNBeHg4VVMvVEV4UU43?=
 =?utf-8?B?bzRJejVMdWt0Y2JqU3VJank1WjZhZE1DSG9mMlQ4a2FkaXhNWmNsRnlzanZq?=
 =?utf-8?B?RE5BTzZUdU1NSWUzdWl6SmFrWFVmZ2w5NnM3MTlDVmVyZUxQS29wVitJTkNS?=
 =?utf-8?B?ZUdnYzU2aVZyV2NGeHJCV1Vjcm5FOGhuMTlNdG5aTUYzSXQyRFp2eS84WEtq?=
 =?utf-8?B?b1IvVDZUOThPcUlJMFA0N0wrYm42T3RwTmd1Vm1hdWsyZ2ZDa3V3UzRQQWJh?=
 =?utf-8?B?clZBV1lLT2E0aHNTQjJVRHlYbkV2YlFncjZzQ1U3aWhzUkZQc3dWdEJFUzcy?=
 =?utf-8?B?VGpxWGVYNGI2aXpyR3NBMjBIcXZVOHlkU2FvKzhzM0VDeS9QVHJRTWk5OVRS?=
 =?utf-8?B?NWNJZGgrbTg4MEFqTWcvSStBWWJVeEpWS1hBRmdqUHBsV2tzS09iQTFtREUy?=
 =?utf-8?B?dndDQkljZ1NDTGVmd3pCMVcrc3lMWHVYQWdnenZOMFd6enhNemc2N29ReDVN?=
 =?utf-8?B?N0kyTTJkMlNSaTBqRjNSR1F0Vkd5Q1dKQml1MWhQTTdPeVZyY2lMTUU4eTFp?=
 =?utf-8?B?ME1JNFlkdWhyckVoQWZQSzZTUVVtYVkzUW9jWU5WKzVwNVJQOU5ZaGdUT0Jh?=
 =?utf-8?B?SFMvV290SDZmNkROOEpRMGdncXRpanBISDJnVFdNTkluZFRsZXh0T0FkK3Nw?=
 =?utf-8?B?RjBzbVpnZGZsV0xLWXNlalFMb3RabS8zWUVPeGN6cFFWejErdzRtbXlRdEJh?=
 =?utf-8?B?aGZudWlqNkxBWm1ORnR4d1RzR2JvUklwb29lUWdneU5OcEJiRklwYUZlaWNX?=
 =?utf-8?B?MnVyVGxCVWpJY1YyS0c0a1RLQWpRNlJLVXZTbmY5TURxWDlzUmt6cGg2bTli?=
 =?utf-8?B?cDVNUlRzWVkvQVFFSUhxbnJEWjhObi9GUmI0cGpvY2JvUE5ZZFNwUHArN3M4?=
 =?utf-8?B?OEZ4QW5adnVhUm9BcHBhd2YvTjJaMWFXVU5kWlJjcWlGOXdnVTJhQ2E2OHBS?=
 =?utf-8?B?bDJwWjhtMWRyS2tBR1RUZVhSU0taTTNHY2Z3dmgxTHNsT1V4eENzNS94VDJT?=
 =?utf-8?B?VFphcU9wS1dRZzVuMVB4b0ZMVk8ySndXRDZNYS91eTBadk1mekxtNm9RR3h5?=
 =?utf-8?B?NElOUVdZU2RFblowVjZXb2ZNdUk1NnpSakljSE1aTlQ1Y3QyaHl0Nk1ZS0xo?=
 =?utf-8?B?Q1ZyUnVWVnp0VTlQa3dzR2tiWi83Y0xxc2tUeFdxcGV5QVNPQk55c3paYjlo?=
 =?utf-8?B?b1BEVlgraHpDQkpNUXk5RU1jSzR2TjRLWVZMTHhjT2dnbGdoRG5zYXdiRC8y?=
 =?utf-8?B?MmtqcmY2TlJkd0ZuSEs1d0VnWnY0QlVnQUhPeXFnRXBVNnFoOVl3NCtDdDhs?=
 =?utf-8?B?R1kzUjZJTmFEMEZqZWxZMDBRK2ZXWFp2ZWlVVE1DdzNkam1NV0JiTnBMOWNI?=
 =?utf-8?B?NmxzUmlpSnpJd0JRcFdiNmp1MXk1S3JIZTNnRU15bVVhSUp3NVdFQzllMWJR?=
 =?utf-8?B?eTBsYzR2aXRXdGovbzFPM1VUWTBBZlgzYjNHMHBPYkcwTjM3ODlpNzlZam4w?=
 =?utf-8?B?blU5ZWZiSUtZUDlZS3VPMnp4c2pidkQzZXd4L3JrT1g3bzlzd3NPbGdNT3hH?=
 =?utf-8?B?UnBobTh1NzFEVG40dDFSU1ZaUTBtN0NjQVNCNHEwN3d6SUlaRENkY3NFWnlN?=
 =?utf-8?B?bzVMTU9QQ3JDUGVjNm5Jbzhscnlkc05PeEZCK2NNNWdRZ0ZPYXhlcnU2Wktl?=
 =?utf-8?B?RE1VQWg0NXdDeWV2cEF1aERxUXlzVTI1bithcUZNRlpxMWV6QXc3dk91Qkk4?=
 =?utf-8?B?NjlwL3N4R3plNklPS2s4d1NQOHVjQTNJU0NBblNBdFR4TTNtVjd4Nm1kUTNx?=
 =?utf-8?B?SjQxN0RiTllJNHdwdzRweEZQQm1CUSt2cldsOU5zMTBlNml0R3RSdmdWdngw?=
 =?utf-8?B?VjMvVnhVMy9teisvSDRndVBFNFg1T2pGVkJnekFYRE5rc2V4YVpXUVZnS01y?=
 =?utf-8?Q?3K+QjtMfxuO4YXAkVuzphezBb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aaab12-857f-44e3-b0b6-08dc6dd08510
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:29:13.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOr8kGQI5BLUo6yUIIAWtpDvYJQGVpOEFVi0rTxXfAZ4hMwnkFAsLx/A8YRTz77nY1UyyvAiWd3aCnFxHdqevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465



On 5/6/2024 5:19 AM, Perry Yuan wrote:
> Add a new sysfs attribute file to support per CPU frequency boost
> control, allowing individual CPUs to enable or disable CPB separately.

I don't think it should be "both" global and per CPU.  It should be one 
or the other (and I think per CPU is better).

> 
> The new sysfs attribute file is located at below path,
> `/sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_boost_cpb`,
> where `X` represents the CPU number.
> 
> To disable CPB for a specific CPU, you can use the following command:
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_boost_cpb"
> 
> After disabling CPB, the CPU frequency will no longer boost beyond
> the base frequency for that particular CPU.
> 
> for example:
> ----------------------------------------------------------------------
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
>    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
> 
> ----------------------------------------------------------------------
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_boost_cpb"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 3501.0000 400.0000 4154.3140
>    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
> 
> Please be aware that modifying the global variable
> `amd_pstate_global_params.cpb_boost` will overwrite the individual CPU settings.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 11bce2c1db32..44531711a5fa 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1371,6 +1371,30 @@ static int amd_pstate_cpu_boost(int cpu, bool state)
>   	return ret < 0 ? ret : 0;
>   }
>   
> +static ssize_t show_amd_pstate_boost_cpb(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	bool boost_val;
> +
> +	boost_val = READ_ONCE(cpudata->boost_state);
> +
> +	return sysfs_emit(buf, "%u\n", boost_val);
> +}
> +
> +static ssize_t store_amd_pstate_boost_cpb(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	bool boost_val;
> +	int ret;
> +
> +	if (sscanf(buf, "%d", &boost_val) != 1)
> +		return -EINVAL;
> +
> +	ret = amd_pstate_cpu_boost(policy->cpu, boost_val);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>   static ssize_t cpb_boost_show(struct device *dev,
>   			   struct device_attribute *attr, char *buf)
>   {
> @@ -1416,6 +1440,7 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
>   cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +cpufreq_freq_attr_rw(amd_pstate_boost_cpb);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
>   static DEVICE_ATTR_RW(cpb_boost);
> @@ -1426,6 +1451,7 @@ static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_highest_perf,
>   	&amd_pstate_prefcore_ranking,
>   	&amd_pstate_hw_prefcore,
> +	&amd_pstate_boost_cpb,
>   	NULL,
>   };
>   
> @@ -1437,6 +1463,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   	&amd_pstate_hw_prefcore,
>   	&energy_performance_preference,
>   	&energy_performance_available_preferences,
> +	&amd_pstate_boost_cpb,
>   	NULL,
>   };
>   

