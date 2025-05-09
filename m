Return-Path: <linux-pm+bounces-26947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1FAB1562
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA01D500359
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05482900B7;
	Fri,  9 May 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2Is/zMt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17232EAC7;
	Fri,  9 May 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797884; cv=fail; b=tbMhfZUGy2qw89WAPyyzzHgswgIu4mWh+VG9QAqI+bIC8o1jZ3lnyoZct2XKZOdoKqqmPQkVBiYOPaCyOsZapgN5Z0O3dfJNblG8J3LVWJOAfkSoAXisGa4BLPvtehvQha0vmHVn4sn1cavbsb3yuql3L2H9ssaXcfOl+QdLBgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797884; c=relaxed/simple;
	bh=8qTPdlZWL31+xM2wd29iHnFmlFZIuUm9YJ6/eg2MYw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqgIYMlV21HgOllLpNaolWkPQHlWYcpatWtYL/NvEwk/2cN5vIun/GEj5OlFa/qSCKch+8BfWu73gQrd8VPa9OXNUUGuVJ8aV73S8FKXD4PFVT+RGYb6qW2vp0RMcYrW2hb+TRvSs4KJLJdQ47fU1F3Poywxn5ZlHdVYiek+CM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2Is/zMt; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkyxZUQm41uOdgs2Rt6/TrQSwDQ5c1Wm6d1Nemg4n8LDyiv0Ymqihrkt0ltmdZMw6jP4OavLcVim7G7Rm9ti4axMctizAr32EpeLnyXTkSgsPfx+MVdwxNasa7+BVO3R463mYZU/gV3mdiPNNPRmTs7QyBItMT8SiZzxvyskt+5WpO4WhuthhLq28Jb0b4V3cTKhf8MAYxR8xeJjXyzyVo3F0g/vD7aVVEH9zaAwgA/VpXqG5plWQ55XG0nNLXOjErAdVNmGCoHCqFt0bRMjI5NGAia6w5fbVbdY+tM9az7VmLowVc6m6SaDO8znAShSOs9MISuLJOulNzCWBZEu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JesImqvwE/v9i+fhEI0+JVHpdB3VIfuTw+1rE2SWBWU=;
 b=jIAG91xVCQmjGinuR8RUhLyGYqPv3rtzDIMEDWCq6n3Wq1T4obWk5sxP4tNHfE0OlVKHBuU8QJVEadZQgB6vbnO/NudCAALEOT1CtoicJil6Wfq4bGIwVBiEI50Uk/C3BUdFTjFErpi0nYZ7TxOCCew8UOiG4l9qqKTpA0dQrR92MrapcSE9LOI+zqAcu3SpVojmOSxyA2GTUCxIjRoEbkH9cM1y6Kzd+aexOYCp1pwCe1grPSrtJ1CV1Uhv4hjn74MKF2073f3+6dwa8hrodX4Ut78YCOnsELJ20+d4mnlrPodYYrAw5oI380LY1YO0B5b2ddtm6XCt5tkAawUIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JesImqvwE/v9i+fhEI0+JVHpdB3VIfuTw+1rE2SWBWU=;
 b=e2Is/zMtLopvqhKj4gKEHCyV8R6yADhlrMebtxWQOQt1Nrj5KNdjnre7XEr0KtajBlWuLL13tLmSA1mCGTNURizWu+pkNIdIaVajqgXqWER0vNSXGc0sIxd/LPcdQpZJaYp/ty9n0n6Gkuie6EU8NMTunw2TZBkpoTfqoOfiBBUaebakKn0TWuyEg1UJHujrvRZeNyieCKoq4T6JkHKxX/gz/CD4kc98GwuDLNLQ4q43iPaOFzDJ7HibBzxbJZE2XiTFDEiLh9yf0Flt5a0IZvwdeQqhi2QMKsv26RYMk/a1f1JVHLlQbvWf4FijZeKJjZ2LgGBA5CSlz1+YUn3Ujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 13:38:00 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 13:38:00 +0000
Message-ID: <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
Date: Fri, 9 May 2025 14:37:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0378.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::23) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e24ce1a-c4ab-4c78-4b32-08dd8efeb6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzBwS0ZoMUlOQ3pTaFpsWUJqOTNYeUw2RHI4ZTVTdG9mOTJNd1VlUng1ZGti?=
 =?utf-8?B?VHZCcGlTWVRJa05Tcmo3cnF5YUxrZGYzS2EySGFHQWh5UVd3eUFZR3YyUjJG?=
 =?utf-8?B?TTBFY2tiLzQ2N0NiZjVCUlRMbUViOUNDaFFnTnRKRXlMdUpZRjZGTXRKbnJm?=
 =?utf-8?B?MStaeVI1bERsUXZmVG95YldPRGNtR2RhUFFYeWJvK29aVmdoTnhXbXNTdXFU?=
 =?utf-8?B?Wkd0WUZhTlNmRGFxUkxpenRjajVnK1RjUWxieFF2NktvZ3RCQ0tXVHJsYm14?=
 =?utf-8?B?bGxRelpCbHc4NXo0bHRLZG5iMGYvWklvczF4aFhWWHUraTQ2aytNWmZuT2Ny?=
 =?utf-8?B?d2gyMjJIUnZLYmxMWm03bFNOUFoxbncwWmYzUzMxWmwzaWVJVEFtNnFNYjNQ?=
 =?utf-8?B?RzlpK2c5VTlrTDlBYzhMcjJQV3pHZFNFdy80amhPcmZNcEZwS2ViNElMcW5R?=
 =?utf-8?B?QzN6OTNZNU40VlZzczUvTy9xQysxR2pwVG1SWnUvTWJxbUxzSFk3MU45KzhP?=
 =?utf-8?B?YXpJMmtXMlArSzJBYkRiTlR2ZkpSQ3QyV256UDZ5NVFmT1JTdkE1bU9SVWtn?=
 =?utf-8?B?YlZBWFRPNHBEN1B2czBPR3V0M3dpNFVhZ0RVWlBkTndXSVdZM2pOMERPM3VN?=
 =?utf-8?B?UnRwRFFkZWE1bTB5VE5iV1kvVHNWdlRQVlRGQlpoMlEwUEpQUFcvVU1TOFdC?=
 =?utf-8?B?bjlOamxZOVYvcjZLZWd3UlRNaFJENGtYVzFmZnZBcHBKb09ORWJFK2RxdjhI?=
 =?utf-8?B?MnhoSGl6YzZQWEFBOTRneFQ3djQ0OGNtY2NsYW9nN214TnRTT0JBbkFVeFZZ?=
 =?utf-8?B?NW5IdmFEdnpBTWgzMEd2T3czS3E2Q2l1N1dPUU5FNXArS21DYThON3BnZlFP?=
 =?utf-8?B?N3M3RnFnTnVqdWVqUUtRcWhzS2ZJMjZhYit3MVRiaVVLVDNTTkxYNmxDcE5n?=
 =?utf-8?B?RkROcE41U0pER3JoNXAxUmpNbVZnVkZWWmh0TTVLS1plaEs2T1FFc1NyU002?=
 =?utf-8?B?cHZ1aUUvQzRPM1NmYm0rbVNSTjRGdUpOd1BhT0YzYmo1eG85ZzJ2RTRwaGRz?=
 =?utf-8?B?Y0ovZ2M2c1daU1c1TVNlTGhIVFcyRDlOZFVad3cvQ2pUc2svT2ZBaW9VRG92?=
 =?utf-8?B?VXFEREJld1l3ejJ4Z0tFMHQ0Q09tc2xoRzN6YjNCRTA0bXlpSlUxbmh3OGFu?=
 =?utf-8?B?ZVY2KytZeGdtVjN3RmppSlkvWXZYanlxT0pIVTQ3Y1J6bmpDMXk0aTJCdXIv?=
 =?utf-8?B?b01tRW5lNmtFdFhlZ2F5dFpkTE0yNlUzN2d6akFnRmg4b0FhYkx5eVZhWmVq?=
 =?utf-8?B?a3JmN1RkWm9EVlNYdXplZzBsMW1jQXRsV2IyblgwNmVuZHVqU2RWRWVNSGdM?=
 =?utf-8?B?a01LaFdGSmZGWjNsOVdFUmhPNGRNeUlSSjkyR3IzYkZGVkJlK1NacllZWGY3?=
 =?utf-8?B?SjNrdHFzZ0FJTkZEcjNBbTAwR0hVRXp1citJZTZhS0VFOCt6L09pcCtadjFJ?=
 =?utf-8?B?UE85TjY2YnJDZmZVdjJ4UENvRUM2SytNMCtPSXFRTkFYeG9BdEZqY3N5R0M1?=
 =?utf-8?B?enByZERQVTRpODdaUWkyQ2xoeWF0YXp6SXlhTTRSR29OeFJ4djFSa2xiWG1T?=
 =?utf-8?B?TElYVTZHNVVYY1JUa3R1azF4dkVraGVKMUoxcVR4cnRaV3IxYmkraTZLc1Zh?=
 =?utf-8?B?TXYxVWlGc09ESFlTT1J1YmxOdCtSZ2daWmQwdzh2NlRDVFhLZFdFL2dCdTZx?=
 =?utf-8?B?Y3lCYTNhT2lxa0p0U2RnbDY2NHJBQitJWGo2ZmNDdFMrRkJZK3ZhTXB1a2Js?=
 =?utf-8?B?R29TN1huWDgvZDI2TURaaGxMTG5iaGxtbktLL3JSMll2Yjc3b3U3UFZ5R3dy?=
 =?utf-8?B?T01NZFl3ZlRraXllb0tLQXZIMFlxd1ZPbllJT0xXcDRubUtGcjNyZkpGbno2?=
 =?utf-8?Q?Ep+Gvn++wXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2NHS2ptY2laWCtDdTFtVW0vRGFGS1M3d2U0M2twWTZvbkZYcjlYdzd1SGx2?=
 =?utf-8?B?cUtuT0FLVG5NR2ZHSXhvZ1BkWjA2NTdQdEFCY3lXK1NjaFRyNXE0dUF1c0dt?=
 =?utf-8?B?SEpjYmIvZnV5K2wvYUNpRnNwYzg3Q2ErakpyREJ3SWtESHRCTkRacHZWMjRP?=
 =?utf-8?B?YTlDSE1EUU1JTUNZSWpVTE4wQ0tEQXZQaHA4T2VnV0JpZnBpSXhaS3IxMkpX?=
 =?utf-8?B?U2dpRksxeUhjUno4Z3RZYnppWXVzLzBFdFZpU2J3OUZaQzZSdWVGd3c1Zk5S?=
 =?utf-8?B?aUhQd0RWRm1BTDRwWE1XV1FVV3k5NTdMSEtVVCtIWXlIWGt5elhWeE9hZlJW?=
 =?utf-8?B?c2Uva0pVbHlWbTVFNE5wYXJ2RjF1ZnhQQ1BaVTVyN1JOWWdQUG5xMERMRDBw?=
 =?utf-8?B?azg1Um9Zb2hYWlRkWmpkaytrVzJWb256VE45clgyOHVLZVFKb0dDZDRReVpH?=
 =?utf-8?B?NC9URDdBOTFINTJ2L3Q0VTcwczhLQytSQm5zSGVuT3Nucklhdk9jSmZnUXla?=
 =?utf-8?B?TmRyYzMyd3MwWlZKa0FQQWRxbEdhMFc3VmFRWEtDSmRQL3V4SEFFUU9YdmJJ?=
 =?utf-8?B?WWdITktPVDdVdnR1K1ExU0JIcnU3WS9EM3AxSmpEbWhaa0JzOEJkdG5wa3pZ?=
 =?utf-8?B?amhSWGM0WTlSVlpEOGpMRXRTYWFGbTJnSTZWWnhnY0xWUktIRHZoVXJ6ZElY?=
 =?utf-8?B?MzltWmpnTkx5dEJGQWdSN1VZZzZwSitOS3RpZlBMUWhreHlTT2ZHMHM5ZDhx?=
 =?utf-8?B?U1Fld0dkdGNOSGFtcC9Lbm4zeCtjTCsxMmducG1XSUtjdTdaOERvV2N5S1hw?=
 =?utf-8?B?TXZSMVZYWG84OUJ6R2JpZVovb3F4aWlDN0FHSnEwck1US1M3eWc0TXJKdTNY?=
 =?utf-8?B?MVFEdXNkWWNBbE1aRlVDZUtybEVZRGZyR2pKM1ZBdFVkemtnNFc3OUMxRm9j?=
 =?utf-8?B?S0xURlpJb1h6Y24zQnVGUnVTa3JnYmRqL3I1amQydVkxZGszOStaNWJ5MlBj?=
 =?utf-8?B?ek5IM21RcmtwcUdKMm0wa2hqVkppL3BKNi9BOFNaZDM5cEp4NDRWcHJ3S3Q5?=
 =?utf-8?B?QjV2dGZjZFE3U3NqdGlqMmEvM2FuaDhGcFdQcWFWWVFYMWh5eXB1V2JzUzJF?=
 =?utf-8?B?VWN4elVIZ292QjI0TXBVam5Da1IvR0xSaGpmbGEvbG1SQ1A0YVpRUHMvb2FW?=
 =?utf-8?B?dEkzYm13akJJNlgrcUR0V0p2UkpMRG11ODFYcFpBcTljZGlJT2RScTliVnJi?=
 =?utf-8?B?YzJYMlJ1VkdNT3JiWG40UVZMMVZYSk5kWVQrelQ5cHovQWtUNUJHejErNDZu?=
 =?utf-8?B?UXJVVTR5L0MxSzBuSzVtdFJ6cEcza1ZHQ2YvcGU4UGJYNXV3bk1NTkJBRHE1?=
 =?utf-8?B?MFVGb3BlQlVVK2FiYUpRakxvNCtIVlVRV3pVem50enRLUkJTZCtmMVJPR2Nq?=
 =?utf-8?B?SjNnbUJ6RHZKL3B5dEhRVnBMNk1mVmwrUzRNK2NoODZkSkJxSjRhYkcxc0FO?=
 =?utf-8?B?dUxlVkxKOGVWTHg0V0VTWUcwUzl5QW8rT0FvOWFhV3VVR0c2Sjkrb2dGMURr?=
 =?utf-8?B?aUFJTGZRVUliQTNUaGs5SEhRd3BLa0tiQnd0ZU5xcUxVUklVZmI1ZE1JZTBP?=
 =?utf-8?B?cUFiT00vUmx0SkxPWTJrZXhjRUQ4a2p3eEMvOU4wWUdPMXk1MWRxYWdyL0tU?=
 =?utf-8?B?NFN6Skc5VUpPRm9rTXZJTUp3L3V2WVhLakJhNUNtR0pHQTFKVDJzditsVkln?=
 =?utf-8?B?UFBXeEs4ZWovQm9DKysvdmc4akpqdFAzN1ZDR24wKzFhZk5QZFlXM1k5aEww?=
 =?utf-8?B?L1NPZnRYbzZaZGRpaTk5UStXVDZVaGcybEJpK0hqdEhuMFRpYTVyOGNuYjlV?=
 =?utf-8?B?TW94dVRIZUZEK2NyNWE5VFRCbVViOUNWNnVLRjZ0UWI5d3Ztd092c3RYMW01?=
 =?utf-8?B?UGhudnpsbjFrS1c3RlY0bHRmblplMWRYZWtoUzJVVFZHVDZ5MXI5clJlTFg2?=
 =?utf-8?B?WFFieTdvWUc1WFJyckx4Y0NEY3ZwTzZXVFZPQ0x5T1Z3WUx1eGtkQ2VYek1W?=
 =?utf-8?B?aHVJdXpXR1N0WUQ1enJqWE5XV1ZNN2xxUHNTU1RYZStnL2loazVxZHN0S3RI?=
 =?utf-8?B?VE9nenE2eWpUakdNdTRDVGRYOWFydFk4ZG5hWVBtMS9BZzJYZUowMDVGNGJZ?=
 =?utf-8?Q?Gls4nCtPlgaCO2UjE+vy9uqq7Q51Su+ZxL+06m5Wjmbf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e24ce1a-c4ab-4c78-4b32-08dd8efeb6e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:38:00.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti3cKRioSTRdhnxtxSt2tCQeTSdbqi+tfolezCNO3gr5kapWfzqzzDcz88aGmvDckIwrWSy/7Ytb/UXueXN1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044



On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This requires three changes:
> * A soft dependency on cpufreq-dt as this driver only handles power
>    management and cpufreq-dt does the real operations

Hmmm .. how is this handled for other drivers using the cpufreq-dt 
driver? I see the imx driver has a dependency on this.

> * Adding a remove routine to remove the cpufreq-dt device
> * Adding a exit routine to handle cleaning up the driver
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/cpufreq/Kconfig.arm        |  2 +-
>   drivers/cpufreq/tegra124-cpufreq.c | 36 ++++++++++++++++++++++++++++++++----
>   2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb996eb7ce980da41ee 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
>   	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
>   
>   config ARM_TEGRA124_CPUFREQ
> -	bool "Tegra124 CPUFreq support"
> +	tristate "Tegra124 CPUFreq support"
>   	depends on ARCH_TEGRA || COMPILE_TEST
>   	depends on CPUFREQ_DT
>   	default y
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index bc0691e8971f9454def37f489e4a3e244100b9f4..b6059c91f2474c56809c403eca94eacf51df734f 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -16,6 +16,8 @@
>   #include <linux/pm_opp.h>
>   #include <linux/types.h>
>   
> +static struct platform_device *platform_device;

Do we need this?

> +
>   struct tegra124_cpufreq_priv {
>   	struct clk *cpu_clk;
>   	struct clk *pllp_clk;
> @@ -176,6 +178,21 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
>   	return err;
>   }
>   
> +static void tegra124_cpufreq_remove(struct platform_device *pdev)
> +{
> +	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> +		platform_device_unregister(priv->cpufreq_dt_pdev);
> +		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
> +	}
> +
> +	clk_put(priv->pllp_clk);
> +	clk_put(priv->pllx_clk);
> +	clk_put(priv->dfll_clk);
> +	clk_put(priv->cpu_clk);
> +}
> +
>   static const struct dev_pm_ops tegra124_cpufreq_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
>   				tegra124_cpufreq_resume)
> @@ -185,12 +202,12 @@ static struct platform_driver tegra124_cpufreq_platdrv = {
>   	.driver.name	= "cpufreq-tegra124",
>   	.driver.pm	= &tegra124_cpufreq_pm_ops,
>   	.probe		= tegra124_cpufreq_probe,
> +	.remove		= tegra124_cpufreq_remove,
>   };
>   
>   static int __init tegra_cpufreq_init(void)
>   {
>   	int ret;
> -	struct platform_device *pdev;
>   
>   	if (!(of_machine_is_compatible("nvidia,tegra124") ||
>   		of_machine_is_compatible("nvidia,tegra210")))
> @@ -204,15 +221,26 @@ static int __init tegra_cpufreq_init(void)
>   	if (ret)
>   		return ret;
>   
> -	pdev = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
> -	if (IS_ERR(pdev)) {
> +	platform_device = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
> +	if (IS_ERR(platform_device)) {
>   		platform_driver_unregister(&tegra124_cpufreq_platdrv);
> -		return PTR_ERR(pdev);
> +		return PTR_ERR(platform_device);
>   	}
>   
>   	return 0;
>   }
>   module_init(tegra_cpufreq_init);
>   
> +static void __exit tegra_cpufreq_module_exit(void)
> +{
> +	if (platform_device && !IS_ERR(platform_device))
> +		platform_device_unregister(platform_device);

The device is unregistered in the remove. Why do we need this?

> +
> +	platform_driver_unregister(&tegra124_cpufreq_platdrv);
> +}
> +module_exit(tegra_cpufreq_module_exit);
> +
> +MODULE_SOFTDEP("pre: cpufreq-dt");
>   MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
>   MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
> +MODULE_LICENSE("GPL");
> 

-- 
nvpublic


