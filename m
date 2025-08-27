Return-Path: <linux-pm+bounces-33139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B816B3778C
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 04:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202621B648B6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 02:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21DD1DB356;
	Wed, 27 Aug 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f3ujdFJ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C13597C;
	Wed, 27 Aug 2025 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260581; cv=fail; b=PU2BFDnor9lQkSCgNIybQSrnPjvEHc9386aC/Osd94ZGJsfZWOWPRX8Y8UCujIpSBsI3xiN5auKLLnZgv/rp2qxungNSP3WuZRh2OToxQfxZvvttNyUrotHKtC1leKQYrI8GvaAO+jFsK5Ly6z9YAuHCaFVYkVYpyAe7Q1hK+DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260581; c=relaxed/simple;
	bh=Hnn1UT3X9m1IUnTFw57uTw4WRg8tXbpoMY11rhchVfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxgRMIUMtiwrTMGzZufaKszouBtg0DBiYlAaA1lEdhzK2qh5UPGiDpa7rt4RgPb2qMngU00XiRpH5SK6xSeeAnu3MJQCjNcalm2d8QIcgxFAB0iS2KoADV909nGV9I6jeK+zig98/+tdoedQ/kPPLeuVgb0SzkaKz7l8e92joHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f3ujdFJ9; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGtU4fXNyw/QA2ZrLDnODcP/U7sQI/lIyJrsuiTC7u6sm8r6aJ8DiC5+tX6cC3fqM2huqBwOhA5MnxtEJpiWJHoP45+am+FzDwkYKIjxRtP/Hqh2wLgabHd+jsJmE+d2J4WAQRaj5Zj3qAsc1NPD91z0qhO96QltBtPaDO45o8WKUES7yYzBRu0+FUUwH0TCr/ofa/mptmEMuO+2Vzf26E5HT92TjAyhHPETB4X/rgjvC7XZ63LUW/79iaFxUmqMg09+1WVe8V1tSKX2lYTchLwPYadZek+myTBMBkwtU+H0kxZIwV8zPkoGGn+FR6wYDjNZYjoUxtfqpXWBPke99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob11Yg3LOZAbldCqjaHc2rmO7r3KHnlHuUCrOtIWh6U=;
 b=FZBb1yJ+2EVSPudCfQA8LBeVQs9e+adfiQ9S1kP1jHg0THElKnp4C5tBxkkU+E7VqYsZzTVxOAdmUMYGSsrd0FByl4GXfGMu3OOVx810lQ/xMqXA41P5zvP8xrGCNSWIKCgwwi+tWV9SRB/jDL39MPh6rsmUr/ZKrkrAGtzg8ahv2JwfTUDyCx3cKDRPtQlmbG4fXh0fgoVKmslDLzTTYyyjEYxjnwrucri0Vfpxs/fIPNa5PgSWO7Kmkd5j8hXzoQa0odVGfft8WGi8kwGdFSJomNP+eEDAm7b2a2P49eB6XbQx3lwmQGSsGgnVfuRNZZM78CihV8swMFVHK/LNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob11Yg3LOZAbldCqjaHc2rmO7r3KHnlHuUCrOtIWh6U=;
 b=f3ujdFJ9SFVyrzYWTec9vQkxbnhi2M59G3yeGdv5VD/GshXEsXowFI9vBOehHB7AVO830YapHM/kLp3Mav7hFJ3T8uYBwVlP+WJ9l5ll1JzQ3nwlN5NMglltU+gqeYbNnZh8nY1GSvcPzh6NOogKY6dWN6ubQyhXVOnN2KM5A85N9G27tZiEXsHOnwoMv1d3jsX5/jgM0Yq6cDYPWapavpKrLMtmf+bebW6X5joOMKWwHx2YqwgSydWQEGAvoHJLIBdsJFh9JUK0e7O6G/2O2nS4s19/o4jr0ySM7KpV3lMwiqBoq44rZJc3L1k7ltvEi6Gzqe3csDb/eGc8K7XKuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 02:09:37 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 02:09:37 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>,
 Sumit Gupta <sumitg@nvidia.com>, webgeek1234@gmail.com
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Kling <webgeek1234@gmail.com>
Subject:
 Re: [PATCH 2/2] cpufreq: tegra186: Initialize all cores to base frequencies
Date: Wed, 27 Aug 2025 11:09:23 +0900
Message-ID: <24066927.6Emhk5qWAg@senjougahara>
In-Reply-To: <20250826-tegra186-cpufreq-fixes-v1-2-97f98d3e0adb@gmail.com>
References:
 <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
 <20250826-tegra186-cpufreq-fixes-v1-2-97f98d3e0adb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY2PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:404:a::30) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bce688-3127-451e-a6d8-08dde50ec663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZEQXlCSjZKWjFaZ1BEdmFMRmdRR1N5U0hleE5pSHkrbHIvbktPWmZXY2lp?=
 =?utf-8?B?T3dPSDFpa1o0SzR5bkV6NjgrT2kzZW9rMDY5OEVmS3hNOFdXUzlkWWw4YWwv?=
 =?utf-8?B?cWp3OXpNNXlEb3RYZEVYYjNWSE5saEUxTkhIRGFnbkpQR0p2Mm5NcWtsa2U4?=
 =?utf-8?B?dVhPTTI3S2RMVzZsbTNQemJXNnpQUmxnNXF1SERQTDZHbkIxaG1LTXZBTndy?=
 =?utf-8?B?RmpxZHdrcURmRGN4Mmc2ZDVqWWh1MXNkOEVnQ2c3VzJqM0dWcmVwWEdNdkdU?=
 =?utf-8?B?RlBIUjQ2UlQwN25mQURqZTZ5Tm5pSWFxajZ4N1o3NUtmTk5HdjUxNUhBcGJL?=
 =?utf-8?B?YUJ6bDdEanhWNUxwNFFZa1ZvRGV2QkhnYkovOFRzeFE0NElTZnB2cWFycUpU?=
 =?utf-8?B?Vkx0S3MzWnYxVi9nRjN2MWxXMndiZ0I2a21JeXA4Rk1reVBCc3A2ZDlYT1dt?=
 =?utf-8?B?NXQ3U2hHT1lrOXNRUFF2a0kwU2FvMmtDdWkwRVNCamYwOGdTdWZoUEFUUm1j?=
 =?utf-8?B?czRZZ0JxZ1BmS1FyRVAvOVZJZVhUa2VmekNMK3diTC9LajlhdWNCSnFBakh2?=
 =?utf-8?B?TWw5M280K1dmYkRkLzJWWnUrZVMzVHVhTG91UndhQWNvRXAzMFlOeEhzbVVo?=
 =?utf-8?B?bDVLZElyMnFHaTBFNDNIVU55eG9QTUFEcXdWdVNCbXFYUDVqSDB0M21zLy95?=
 =?utf-8?B?cFVlSDVJVnRGdWwwR0t3YnZ6NFo5dkNveG5Qc294QW9WcVVxWnBvNVpWQjJs?=
 =?utf-8?B?ZGEzVEVNb3diL0FTNGlIbTBLb0Z4cHFsYWdaRTVuelBNc1FidmxHckxTbnhT?=
 =?utf-8?B?c0FvTXh1V1U2dk0xK09RemR6M1hMZlp5blhaRkdDcHM4c2FxdlZUQ2pTMThT?=
 =?utf-8?B?c3BTMll4V0xnbzZFdFYydW83b2V4UG15dGhCd1ZRZlFvSDdseDA2Vkh5eXRh?=
 =?utf-8?B?dFZxNlhsTjJuQ29wbVUxbHUzRHhUYm1ReVh4bi9ZM0s2dGRweGJzY1VMRGNW?=
 =?utf-8?B?ZnFvUU0yL1VUUlo4dVMwbW9SNmQ5aU13QnNNOWpVcGJUaExoOTh3R0gzdG1L?=
 =?utf-8?B?TVczSVVMNmpCOFRiRWh4VXVCcjU0VWhubXFYYzFtQis4djhGM2w3Mm0zSEZx?=
 =?utf-8?B?WG9ZOEhUOXRKZm5vK2pBOEZLSVlHeEVPQjE5RjRkL1BBVytrUVl0Nm5GV3pF?=
 =?utf-8?B?QnFnUXFkSlhHcURMQXVUeml6SDZSaTZpdU5YeG0rcUhnQklmVUhHWDczOE5I?=
 =?utf-8?B?d0JXWXlQaGxWZGNHdXFQcDVxZEtiV1p3TU9ha1ovcnhYOGRLK3UzdVdVUTFW?=
 =?utf-8?B?YjJWcVFlSjIxM09ocWZEclNQcVhvM1Z3TzhCd0dOeC9lc3dlRklIRDc3VFUr?=
 =?utf-8?B?T3N6bEVVdXFLVFkrOXYwSENCWC9xNjEza3Rpbkh3Y2VMNlZzem9LWmNOdHNO?=
 =?utf-8?B?Tkw4TnpBSlc1d2IvWTB5Q1FKTDNXTmhnQ21tUDZPZHpia2g0K3lyYU81cmRo?=
 =?utf-8?B?Vkc0Y2VlVlYwZDM4enJ1Nm5ML21tNExtQmZjN1lHVyt5YVBnTnVCSmw0aVhk?=
 =?utf-8?B?MUVwOS9YK1NPN3J0S2kyV3ptT3NIdzlrN0U5RDU2TnZYMzhnS0pFVzZhT0Ra?=
 =?utf-8?B?SkRXTXBxaUwwNkxmRjVNU2xObERYQnhHc05ycFhqNVJQR2Izak5tWFIvYkF6?=
 =?utf-8?B?ejBiNDJmZHBmdnVWTWxWbS9TY3dQMDZNZWxIVjRyRFhzY1RmdWdaRVgvdVhI?=
 =?utf-8?B?TXdGbWhnYUEvUEFCUXdIK2tSM2NpOGNrV1p1NVkxMTFCYWdXcktWMndabk9N?=
 =?utf-8?B?SlJnQTR4NFM5a2hHa2ZjTGlYa0FsL28vQlgyRG5ka2l6cGRTcDVCVDJ6WlQx?=
 =?utf-8?B?OFJaclJIRWdnR3kyUG1FZ21TWTF2UzVndmZlR3ZaV0tCNlZxUW1PQmxiVStQ?=
 =?utf-8?Q?//Y2Ddg6ngg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWdLSjduVmtEdGRJbDlZd3ViWTVQam9iSStiNmN4Q2JLc0xvL0pBbFNJbWdm?=
 =?utf-8?B?N3BYNWFDV3NYeTNKRDRkNU9Nd09sRXRaSDh0cXhHVFVuMTlGVkNwYXZRSUZ0?=
 =?utf-8?B?TDhtV3lCQ1JkSWlLb2xjT2RrY2l3WUZZc0NIQzBQU3BkMm5JaWVZLzNqVjJp?=
 =?utf-8?B?VWJqaW5CVXpjWjBjbHFWS3czTHdiN2Evcktjd211Wmh3RC8xY3c2L2UzR2Jl?=
 =?utf-8?B?akxNSVJobmwxZWpuaVcycmRnZ0ozL2NScDB0Z2lneCtQcEt1b1V5VmFWSmtp?=
 =?utf-8?B?QkFqQWF3UHhRRUhHeTk0Nm5lQTBvMnJiSVlYWXk2QVhBM0dFS0svYk9JbEpv?=
 =?utf-8?B?RjlnT1lySUlaR0JFNDA4VzllM1lyZlpQY21LZkdoZDRPVEJlTlNYVnNoV3JR?=
 =?utf-8?B?M3gvRStMczR0MURqWHA1VE9tK0x3Mi9ySExoWXZqZkdMWlNFWVloNm5SRmxO?=
 =?utf-8?B?bjhFblFDNDhBNUMzWWM2QkZrVlAxK0dmcGx1K0hZR2g4dURqWHVIcFRlV3BT?=
 =?utf-8?B?ZEdpU2JUcWpQcTZJS0RRVEdPckgydjJUaEVwQ080VGJMcVB2SWJKc2MydCtz?=
 =?utf-8?B?ekdnU3JoS3RoOHphTzIxV3hTSE9kTm1YTGp4WmxudHUzRHVkTTRacVBETVpP?=
 =?utf-8?B?eWI0anRLNks1dW9IK0V0OFBEVXNsVVRYVS9GYmNZMFZmVGQ5c2VwNTlBMkF2?=
 =?utf-8?B?SisrclQrRTFKaUpBNjI3aGxoTjBkOGN5U0tURDRyMWUzVmlOLzc4QisvME9i?=
 =?utf-8?B?OUYxODFDWFo1cHR6QUorSFRWeSs1UzJPWDR2ZnZPNXpyQVZKMlNRNHpuK3lL?=
 =?utf-8?B?ZVdIMlNQakJwdHRGQzEwaUI2MXBKdjRyZVBhRzBNSjJ1U2U3aTRML3F4bDZX?=
 =?utf-8?B?b1I2dGNuaDUvMFVjdFFVZkF6UWYrM2Zqb3NyTm5xbklqUFFhVUJ1YUphWGhM?=
 =?utf-8?B?clErZTVFZ0hZR2lkcFlIREYvbEF6aE02SXF2bWxvWExVSzFiWFIvLzhSTjJ2?=
 =?utf-8?B?VTV3K1BXNUVCbUViL2dhS1crTWI3MGU2Q2tCNUkwRzFQV3ZCdDVaQUhVa2VP?=
 =?utf-8?B?UFd1eEw3enJLb2x3MGEwUytSOUlDLzZjc3E2UWhndnk4RWh3SFo1MnNybCtx?=
 =?utf-8?B?RXhJKy9EdDBRd0x3T0Joc3dpdXJlOHA5ME1WK3hhTnZDaXpGSnNhckpxUnAx?=
 =?utf-8?B?WWxYUjBCeGc2ZzI2RSt3cW5FSXNKU2kxMGI4SUZKMlZsVUZrMXNmSjhiaHZ2?=
 =?utf-8?B?MnJqbE1sNVJyUEVoYzJyRDVqNFptWG4wc095enBrT2pBNDVocHVwZVBqR2kz?=
 =?utf-8?B?OW04QnJMRHJjODhFaGs1YVRCTUc4VlNaZG9SSkpoNjFoRnFKSWZHRlpoeUlN?=
 =?utf-8?B?d0o2RmpDbVZwMEtEMnY5TzFiQ1NvbENzRHhrZ2NzNzBtT3hGV1NpL0wwTldW?=
 =?utf-8?B?QVhkNE9kNTJKM0V2Tnc3bERYNC85MCt6QWJEMExCQ0JIalp1cTJLSlRSNE1X?=
 =?utf-8?B?T1plUExENE5DUGdLYW1nT2FveTYwanEzM1ZPaldnTWh2ekcxOTJGVnR1NUI5?=
 =?utf-8?B?V3MyTWtLNXUvbjBmcFIwdkMrYUJTUmRucHY4TVFCUTQrcUxqdG5FNGJkODkv?=
 =?utf-8?B?RzE1a29WSGlQREFyc04zSUw0T1dkN2wzSmJRc244S29OdVFuVXZzRnRXTWVN?=
 =?utf-8?B?dVFLTldwejZVMnJpUWE1dzRZSStRMlNNdjE0WnJLSHE1amd6QTVxYVhXdjhP?=
 =?utf-8?B?Z2JGek5jeGQyZDNBMk55aFFKbzlienJPN1dSTCtxSXV6SkdYNGN4SWN4UjRG?=
 =?utf-8?B?OW9Za29PcEFERGtNaUJUZW85SU52Um1kOVhaYjl3NGszU3NkT3Jra09kQ21H?=
 =?utf-8?B?M0lHYTFjWWZmTDVNaWwwVDh4azBUU1hMMEtUeFJHajZ1OFh5bGE0RVcvMlBs?=
 =?utf-8?B?VzRVaW9rd04xa1hyYlBRMTdJMnJtRVVjRjdsTXpVMzBEcjNKVGZuMTBOekFu?=
 =?utf-8?B?dHVhU0FoQ2dORXBSTFQ1Nk1LY1BLazRZQkpuR0EvN2twNkhTdWgyYWlRQ1Y0?=
 =?utf-8?B?eUdOVzFMcklrV0tIK213dEE3bllUVWxhenFCVWpkczB3QzdDdGs2RXZ1UVVt?=
 =?utf-8?B?Tk4rVjhRaFlHME5JSmc2bmRrT1dsOFpEY2JHUkpSRXV0Z0lsNFQ3aGxtdUQ2?=
 =?utf-8?B?QVYzaWllemtiK1l6UHovUUFWVG5NeVZ3KzVFQ044UDRzMXpITE5mejc5cTBm?=
 =?utf-8?B?R1BjNDhGMDI0bHB2WkNGc2JENTFRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bce688-3127-451e-a6d8-08dde50ec663
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:09:37.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlbrt1nxmwYxZfBjIuBBwJbWx2aeVyDMwf1cxyykcAo/A6ZDJolmGj2gRVnp3DGW2uCX1282H/wNexoZpofEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

On Wednesday, August 27, 2025 5:16=E2=80=AFAM Aaron Kling via B4 Relay wrot=
e:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> During initialization, the EDVD_COREx_VOLT_FREQ registers for some cores
> are still at reset values and not reflecting the actual frequency. This
> causes get calls to fail. Set all cores to their respective base
> frequency during probe to initialize the registers to working values.
>=20
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c
> b/drivers/cpufreq/tegra186-cpufreq.c index
> 6c394b429b6182faffabf222e5af501393dbbba9..ef288705f00b0918d0f8963ef9cc9fc=
53
> be88091 100644 --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -229,7 +229,8 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice
> *pdev) {
>  	struct tegra186_cpufreq_data *data;
>  	struct tegra_bpmp *bpmp;
> -	unsigned int i =3D 0, err;
> +	unsigned int i =3D 0, err, edvd_offset;
> +	u32 edvd_val, cpu;
>=20
>  	data =3D devm_kzalloc(&pdev->dev,
>  			    struct_size(data, clusters,=20
TEGRA186_NUM_CLUSTERS),
> @@ -257,6 +258,14 @@ static int tegra186_cpufreq_probe(struct
> platform_device *pdev) err =3D PTR_ERR(cluster->table);
>  			goto put_bpmp;
>  		}
> +
> +		for (cpu =3D 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
> +			if (data->cpus[cpu].bpmp_cluster_id =3D=3D i) {
> +				edvd_val =3D cluster->table[0].driver_data;
> +				edvd_offset =3D data->cpus[cpu].edvd_offset;
> +				writel(edvd_val, data->regs +=20
edvd_offset);
> +			}
> +		}
>  	}
>=20
>  	tegra186_cpufreq_driver.driver_data =3D data;

Looks OK, but I think it might be better to set the frequency to Fmax inste=
ad=20
of Fmin to avoid any slowdown during boot.

Cheers,
Mikko



