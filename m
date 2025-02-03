Return-Path: <linux-pm+bounces-21306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA58A25EE5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2837F3AAC68
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C2520A5CA;
	Mon,  3 Feb 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h5+OGA5E"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83F209F58;
	Mon,  3 Feb 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596878; cv=fail; b=FYC7a74T6K1oiFmjg9QfUHbAnpEe6AOQlBIdxON4xzWeBPuon97p6fIPMo/iDSEVsugM2IzQpz3LzilyC72FgvQB8bEznoZ9DI1fTGES5KnONMgPkVyebZE3rZ0aJEXtZwTvPRBcDuk8Dl0rbo4/q8dXCaDGW7r82URR5QMezzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596878; c=relaxed/simple;
	bh=COTiaxeTFHr/2MRPMj7iexrn1kbK9I9X7HwFHlKCCaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxqvTG+xMzqki9HvmlGtKN0shvzkXIwicAG5X5rKFobHi0OzlXxqsKMx6go8LEw8j/6cRlvjYgWkxyzxnxST0nzl7c+ZXPxfpjFcJRW1AkBVIyrLZ/L1keBMlk6jeeblMa6jxD5NFryfZFA51XodzSNLLuLMrpMWM9CsoYft50c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h5+OGA5E; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXJn2BZoHGSauNX4b0EiMPRIKiI9g7DH8+f01RJh0hOssRG5VQz5TW/G+jByi05DfBQYABoCZO5wb1JRHMlXxuamqsdR+C2EjYC1Kf44kljwTnjy6N9wbBDW4H5OPyOmqm26gmbgq5XbDXms2C+8vEncZOHTmV6g2Jc2LEOyMGzqFPFHgAiTWuK/dz/eAWGniwUOBJBNc9k6hEe/XU6YRCWANy6xJYPF/2IypvsHETGFPLq1VIeKQCosuLdY5jkPo5E5g7iKmbuLlKgQm/zf6sRaiwmHKj9+DCEsRfMjzYpkDlfiXMIBLZ/qfdlv7/TPN0turLryhLSxk/+qaILwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq8yLcNUKyLIE6MKDAzAGY8IyZOv3tpg5DrsIxSBs/M=;
 b=u4+GLsZXerv9/f+suocumzmTHY9qauCgy7zKL7trPavrpACNdSrEjjplZTYsREYCdE+hghF+FEFZ6NxFWprsjHfCycIkYIIL1svu4RypQcPbgtvxnPLmOMTJ6XlLIhwKYZVD+NPbEpN4D/bk3IyWz2YRNom/hw0ANyaOLhxsyMePSOFg7seybGCCGKkyMQWjp8TENuUHcLP9NGr4BtIUWHI1bSC3Bu9Jb5J2YkeJRgHmjV+SfqjHXiPePaOHaavZrZWtc0muWHnDQ+srQrXUNy4ceFOYFxuo09TC+DfP1y2S1Ud/pkHQVSORqBfpx9zBqZn659ahX5C+97kF5ert1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq8yLcNUKyLIE6MKDAzAGY8IyZOv3tpg5DrsIxSBs/M=;
 b=h5+OGA5EROULGx+2odCh2rORADyspqXPM2TtI9pbu5gPN9bRvrzdZ5xTdzY/DTelJGkKRBwpWgeMzY/i3DiMcPuyLhFetlVjPFj0CuoYS65J08AHcwzdX5W45jvJymOYyq6ByqPE/OCNcIp483W4M0j7/fASisA2gJM2fbeBUfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 15:34:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 15:34:34 +0000
Message-ID: <f10aab50-5d82-489b-8543-76301bf22e70@amd.com>
Date: Mon, 3 Feb 2025 09:34:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove unnecessary driver_lock in
 set_boost
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, rafael@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>
 <20250203104811.ccf3pj53cjlhwvti@vireshk-i7>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250203104811.ccf3pj53cjlhwvti@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e81032-7424-4ee3-b68d-08dd446842d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck04ekVBNk04WXdYbGhqeUI1MzFXWkpwNkVSNDYzVHhDOGdCa1lDZ29OVE83?=
 =?utf-8?B?MGRjZ1BaZFdmKzQ3NXlRVUJwSlN4Z3hSTEhSL05yMjROeHBWS2NzbWdyWmgv?=
 =?utf-8?B?RG5TNHpMNnVaQkcwZDVHZU8wODVocnNQYWt0NmJYZTN4a21RT0VyK3U5cGlW?=
 =?utf-8?B?bHdQcGhVY3o4aXg0eTBnZUdxWXVlR3ViNmhTN0tJMW1ielh2bHRPWWVRZVRU?=
 =?utf-8?B?ZWt3WTZmaS9KV3JoTHVOUUdWc1FwVXMwNlViZDRDQ0w4djVtL0srZXcvWDVa?=
 =?utf-8?B?ZWlMc3VoOXl1MnZLbDdtRVA0S0g0OGl6OWd0Q25iNldHVzQ5SEFYdC9vSHpJ?=
 =?utf-8?B?MVlBaTdPa0lMRWIzYlU0WjdscGNOUi9qamk5MmF5V084cit5YWxsbEp2Z3ND?=
 =?utf-8?B?L2lSZSttOEJsNWg5NC9VTjZhREJVNUtwL0RsaWVETHI0SVNIT25rNjRDR01r?=
 =?utf-8?B?bFFmemQwZEFuL2c5Y3hqUkRIeW10c1FRSjF5bGFxV3F0NUxxMmhKUTh4akJS?=
 =?utf-8?B?WUV2Vjk5aDFmZkdLcTBKTW1raGEzSEdWY2dnbDUwSGl4TWZsbThOWVZwYTNS?=
 =?utf-8?B?YlcrUUxIbUdBa1BpTXBJR1dFQ2UxUE5LRkJFOHRHYVNVV1BIcHNFSzhGN0NL?=
 =?utf-8?B?LzNUZjllSXlGLzQwR0g3eThrcnN4enl4czJlY3UxNTJwc2VNYzBJUGZ2SzJJ?=
 =?utf-8?B?c2FqVGhkb1ZhRFZ6NnVUK2hSZnZucDRJWkVuZmJFa0tKMlV4bzVmRE5hRTRu?=
 =?utf-8?B?WWcyMFFjdTErWlpEZEVSQnM2NGF0WDkvYnFsTHJBUlowcFpLUlpIakxmOG5M?=
 =?utf-8?B?Wm9HTW5TNVdNTko5WDlOTld1TzRNWTYrOTB4SUNWM3AzMGo1VmtCazl5elNC?=
 =?utf-8?B?ZzF1VGQwaHQza05PYlA0Y3gzQlhWU1BybGtzVnFjdkE2OEFKRjE0eFdJMWdE?=
 =?utf-8?B?Q3JQdFprengvL0grV01PUFhnanZiTTVvcGZLUWxyZXdWdFF0ck85SDBaOXNq?=
 =?utf-8?B?N1NieitINVo2SWhnZm51RXVBWncxN0Zla0wwT3NrdDV1TVV5K21Lb2JzTEVq?=
 =?utf-8?B?amM2OWFMQ2dmZFBQY0FEeVdxM1BUY2xKV2VHNEpNUTZXK1JHZkdLOHRwb3lp?=
 =?utf-8?B?TnlqN1ZUMXA0ek1uTm90a3ZsTURWOE1ickhROGl2VlhHcnlBekJtWFhGQ0gv?=
 =?utf-8?B?d1c3b2FzZTlWZ1pvQk1qOGhiais0VmJtWDVrQW90U1o2eEMvVmRCUVljT29l?=
 =?utf-8?B?a3o5WHNjOUprZnhiM01EWUQ2MTI3ME92a1hmUTVXWlFhdWJ0NkdQZDEyWjZT?=
 =?utf-8?B?aU1ZMmxjdWNGZGZsN1FTK3pGcGRHN2dNVmpNY0h1S0dHK2FjUHBlRzZKNkFQ?=
 =?utf-8?B?M1JnMGNkNjcwenpyTis0Rkl4MDY2M2QyUjI5bVJtNFRXR3I4TDFNeVVFeGhv?=
 =?utf-8?B?VUxYWEdRSGl5N053RmtkOHNZcGtpOFBMRWVNZHVBa1c3bTJKNDBaZk42SkZo?=
 =?utf-8?B?TUNzSWFNdnNBd2k1aUhYY3JqSitGZ0UwU3pzTC9XYzlsOGhPVnlwbXQwMTFS?=
 =?utf-8?B?OXorbElWTUwyU01LNGNUNVZmMFpKaWtITzl1V2ZpeVlQTWJ1R00xUUNVdmtK?=
 =?utf-8?B?UTBMS3IrZzBpanE3UE5PaGJRamxiSGZkWG5XNEtiTDdvekgyUXE2WHd3MXNm?=
 =?utf-8?B?UlhwY2tOaCtKQkdxUmVjUU5xM2ZsaE1HRU9hdE05SjJCaDZqY1ZTdGxJL0Ny?=
 =?utf-8?B?TGFxampaUnY2UFEvU1ZBYXhlQ2hKSXJaV280V0p4VjlvN0h6bml2cG4rcFRa?=
 =?utf-8?B?ekZEekhQekNxMkViR0RZMi91T2I0QVZEYjlhK2dpWmlwc3FCWUkxbUVqVmNv?=
 =?utf-8?Q?rq+b8KFs5PY5A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVhSMnQ4NFVpMVpnbW9teTZqREZ2WmRscmdTQzZEN3pKc1VZdFMwNExBTDhI?=
 =?utf-8?B?b1pjbkdDbEdnaGNIbWRwRXBsVHJ5a1FFZnRZZWZjaTJmV0I4eWUzejEyVlpq?=
 =?utf-8?B?S2hsc0FRWW9KczhEVXAzcktDeERWdWozRkJCaUhQUGpvdklhQjVRKzN6SS9m?=
 =?utf-8?B?THRYSkhjc1cvZkhkaFVCejNpR0hhRWt1RVlKTFhRanBZbDJWbHFTT2xpREda?=
 =?utf-8?B?MVBtV21aZEJ4UzhQQ1lBK3ArOUFHWWtIbVVaTTdmUExoM2FOdTYrTm5NMFU1?=
 =?utf-8?B?OXc5TUd2U2wrd3NRTGgybzN0cTVmZ1pOTVZmZExDVWg4bmZya3FkV2V1RFZZ?=
 =?utf-8?B?cktObSs2NWhkV0RJQm9qZHF6Qks0R0VuOEpnbFVNbnlhd2ZSTG9UME1telc1?=
 =?utf-8?B?cmVSWFp3eVpNZEtRMVkydUZVSUh6Vis0WFlsaEcyMW45WlY4Q2wrc0ZkTVE4?=
 =?utf-8?B?bGtsNTJIZGYvSjIwN011cGZhc0JWNFhmOXVPeXVacFNLWjNlMFVQdUJ1K3ZI?=
 =?utf-8?B?bWRWazhGdEs4QkhoaFRWenhIL0RaazUwWWxERW1PUTBxRzVUZjN5K1RzTDA2?=
 =?utf-8?B?eEVuOWlQN3NlN2g2SXQ2TG4yR1pONytqMFBKcEhqdWVkTWd3R1Azdlp3bDFB?=
 =?utf-8?B?SUlLQlBpN2RYWCtKd3N3MnlpT3p5cE4zOWh5SmVDVWwzUlluVFpKd1ExQ2VZ?=
 =?utf-8?B?V0RYaHdZOXI4R1Npby9KRHdFRU5ldHoyaTl5YkpLTU1JMjNYczZTR3BuN1pH?=
 =?utf-8?B?b2JSejExVmwyd041U3BacVpkaEhpV3IwTDVDYVlDemRzdkRwZjRCOEpvQzFm?=
 =?utf-8?B?ZnNVem5WQUZNbXcyMWlMZmhObGdBMXJKRk1yYk5uNXMvQUZPUHM0ZHFUMFhs?=
 =?utf-8?B?MThWbThwWkJ4ZjNtdTlObCtKclpPVklxSGxlQ3hiZ2thYkNyajB1VnlkRXN4?=
 =?utf-8?B?WDQyL3lsQ0tRTzJUUml3TE1IUFRmdEU4Slg4R0gySk5WM1VIK0t0MEFCMHd3?=
 =?utf-8?B?UXg1M1A1WTBoTWR5a3lCU2xaVktxWEVhWEZXSjkwdk5qaE5yUldhYjhLbUl2?=
 =?utf-8?B?QlBPeTNtbkZrY2JTMmhmdGVuTlhNNVNZbmZXN2dBZ2wrcWJFdDdQK3FTcHl4?=
 =?utf-8?B?UWh2eWV2UXlZUkJjRk5TN2FkZ3RkM0xpaVBoRDF6VjMxM3lKVU0wME53bUpU?=
 =?utf-8?B?V3BYVGx4SVV5WVliRjl5M0V5MDNDaFM3TEJ5SnpuS0U5eEtEbnpEYXlZbGtm?=
 =?utf-8?B?UC9CNXJOVVBTUUE2WUphbW1nSFRWSDRwZHA4aldERUVCOWE2bEp0Qkw4UjZU?=
 =?utf-8?B?OVU3eWVtUWlrSEg4UDJRWWNwa1FNa2dsUE1BY3pUU2FsU2EzeHQyakt6U3kx?=
 =?utf-8?B?UG5QbDNPMmxOSmZIMVJOeGhacGlUbXdNekFDWU5qK0c5YVovVXBCczhkRE1B?=
 =?utf-8?B?ZGRhTDV6YlpLWnArbmJoaTgrYUppYlVJb2t3MTBEdE03Y2k2VlVubU00cDE4?=
 =?utf-8?B?R0JwRDZVT0h2dGhYQTU0akMwNTZvTjlPMWhJVEpERDNVQm9hUFc0Y2tvQW50?=
 =?utf-8?B?dndHQStkdVMrQlRoUDFIL0xDMGJOQVlwTWVhRzI5UTBoRjhCOWtBbmQ4T2Nm?=
 =?utf-8?B?Q1MyKzA4dEZEek4rb2FGR3ZuNzQvOUVKOVhJK2Q5eTRpWHNpbkFqREJORTl5?=
 =?utf-8?B?SGJIU2lBbVRtK1dpb3AvVUgvdFVtaGlvVHpGZ2xMQXpJc2JXZnJKSUR4RGFp?=
 =?utf-8?B?MjN2c3dOdWc0VUF6YURCaGM5c3Uwb0J4OTZJZHM1cUVuZFFQMXdlRk16bUVJ?=
 =?utf-8?B?VFFFYkhDandpRGlYUzlsKzlPbGc2angxUjd2QklyTWtzbkdieVp4TFRQZHQ1?=
 =?utf-8?B?K3N4MWswQ0c1eEFDM3lPWXFSb1NFdmhLT0Rqb1FSWHgzZCtCeWY5cDFwU2JD?=
 =?utf-8?B?YlIwV1A4NlpUalIzdzE4YTRrTlhqb1pwbmNHNGJDVTk0ZUVOQnc0RGxNNStT?=
 =?utf-8?B?cUIwN3IxRlROb3F0UGhmTXh5bi9Ha3BpQUR0dTVIWmNyQitZellLVXFuR2hO?=
 =?utf-8?B?eG1iUjZKckR6eTY2RWRMU2J6WGVVOXFjUTVLSTYyZUZJNWVLMHhLUEhRM2hI?=
 =?utf-8?Q?QIrLU1Lal7oYqVAWM+TNVDapk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e81032-7424-4ee3-b68d-08dd446842d5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:34:34.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7Ap00c4j/X/eAr9xrCXIHwJoaEQUBD/4Aq1+VZXkNkLfdca2JBowiMdFWFbcCxkh8xb98ecSpiA1CiaTwjoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

On 2/3/2025 04:48, Viresh Kumar wrote:
> On 30-01-25, 08:52, Dhananjay Ugwekar wrote:
>> set_boost is a per-policy function call, hence a driver wide lock is
>> unnecessary. Also this mutex_acquire can collide with the mutex_acquire
>> from the mode-switch path in status_store(), which can lead to a
>> deadlock. So, remove it.
>>
>> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>> ---
>> PS: This patch should ideally go before [1], as that patch uncovers this
>> bug and actually leads to a deadlock when switching the amd_pstate driver
>> mode.
>> [1] https://lore.kernel.org/linux-pm/e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org/
>> ---
>>   drivers/cpufreq/amd-pstate.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index d5be51bf8692..93788bce7e6a 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -740,7 +740,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>>   		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>>   		return -EOPNOTSUPP;
>>   	}
>> -	guard(mutex)(&amd_pstate_driver_lock);
>>   
>>   	ret = amd_pstate_cpu_boost_update(policy, state);
>>   	refresh_frequency_limits(policy);
> 
> Applied. Thanks.
> 

Sorry for my delay with the recent holiday.
I have no concerns with this going to the start of the series.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

