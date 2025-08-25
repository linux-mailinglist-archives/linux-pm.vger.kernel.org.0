Return-Path: <linux-pm+bounces-32963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB21B334F9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B07A72FE
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E92823C4FF;
	Mon, 25 Aug 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LrBROXB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4A22758F;
	Mon, 25 Aug 2025 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756095622; cv=fail; b=aNBN7g3AHRj3qH2n7BRvA5qGXRxpkH9dWdNR4d0R5z4MjnXQZw1NTEda1dCHn1UESEkdTUjwSTvo6Ng/LKdPPCDb45ujXD20lvs8J9HZPqM9+75SXMnc1aPmuhk9W07euqrKtoevdFj8pvZJzSm1YQjKvze8TtnW9qL8otUGGdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756095622; c=relaxed/simple;
	bh=+gK65leG1AasaHDI+TBu1eYBpHHYQUYeMaX0acIxvzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/ypWjPeOyzupxTOLYDx/FfapAH7AQcM+EubvPNq6mP3Ovf8ToCsDdyp4a333J/R6lk9o/26/YlIMATLp46xx7uDyLpMHHM4K7ZDmYnOeHe05v218qhwVzc7Gwn+atNRlF45swapa3YGk1GnU9eUcOkpNCuoH3n5SjbjvbEjQhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LrBROXB8; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdfXo952G0LSuTl8ZkcM9Cl1RmPr0MATgxbIhLBEXVeWDvBN38Vc/nkU88gLtrVeGYxesV/+15Y1rsSBISus8bv9pqWi4ivLFS3q2WR+pW8qhlMtr9CEVkJ2sv355Qk235+SC1CmFRo68+KR8OnGpZc1iQAVvss2PsP/p9T3cU+DqwaZcqSGD78RI1NZ5k4KxQPhd0pDKHrkP1/UqoKxCjwoVzLJD31I/a8AXewd7FL4+3j4Tn8UHTpghcPngKkHoRMZ62B+N9ohKZFKr8SKZdM18EprbPpEAvPD/hdtpvweN4sHAyXBzVv9dz6xKvigi2xfdOogU5tKPKuKAcKvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECIJ9wlxeOThgMvnQX0UGzQa0B/r6RlcCSqUK30oL18=;
 b=pMtSSU9v8sd1zt7nbFAAeKMq2v0StVvaoy+4Ry36u/cUb50hgV1NRHxeFzrvgiSygq6KB2Wb46iOr8EB5Jvf9B+yN3yHjrEsOqBbdj2i0EA04Zqkpf0zUtyK7oYZYU/fQLM5ttH5tPuN6YfHRlhbCDJkakWcymxwIG3o8TjzVpcT0KhmWnU6CWXSCKMHc9LyTBCiLSO6hfjbKXQuIw9Ju87BRKaaW4pou0Bi+Doj/PvPvbXC/X9Yyf8CMamJOov8ker9kkWidisOAk2g5FgOaoga0xXcuU0JJSAAKn0H76LIHSVe/cP8lm4YpTcn4dRJKzgzQAbI9QE9G04qoBbk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECIJ9wlxeOThgMvnQX0UGzQa0B/r6RlcCSqUK30oL18=;
 b=LrBROXB8P7a2Q8r5JpuXgKd3rohCdOXjO2maxUJ1zqU4QvJwbBsqnG0UlWQFACLZto7gukNKj5TTNFSFVsINqNupiJbkZgQdZ29Rqn4jiKRBlnMWaSsR0Vtwh4Wg0EwAvenRKVn1YUjGaYWGUr+9gSlQsZoktroPROjFJSojfmiw8A75o2aL3LSq6Qeua25xEaSHjI0e8TwrXPZpXqHgfWR5c0nLLGAtwMgKV7aLO4NFGM0Oh/yaIRb9pMZ+ojY4iPMbjzI7YuAu0/8Uk0CzroNVDZ0SHHJGhdAt2b7CJaHw+8AC+ApdvbS1qdpJhmrSVoaUIcQhbkF6pFzcw6I88g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Mon, 25 Aug
 2025 04:20:14 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 04:20:14 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] ARM: tegra: Add DFLL clock support on Tegra 4
Date: Mon, 25 Aug 2025 13:20:10 +0900
Message-ID: <2480891.iZASKD2KPV@senjougahara>
In-Reply-To:
 <CAPVz0n24N1-iAoQFpzw7r7sz2E4Xhd8fB-gaoPesdc7XaR2HcQ@mail.gmail.com>
References:
 <20250321095556.91425-1-clamor95@gmail.com>
 <117069551.nniJfEyVGO@senjougahara>
 <CAPVz0n24N1-iAoQFpzw7r7sz2E4Xhd8fB-gaoPesdc7XaR2HcQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::10) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: d1810a03-7965-4047-584a-08dde38eb033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXJLbnVyQW1VcjZDMUgrZFZ3QmlqMmQzSEFLT1BNaXJaeTJINmJmcjhQWktY?=
 =?utf-8?B?U0JNSDRmWjh0TEpIemhLbEdPNzRFMSs0em9jYzl5TnRqZC9BRHZvSEZ1ZEhF?=
 =?utf-8?B?eTE1TXpBdUNFMWZNOXVFRzdxc2FLVWFOcW1PemQ1eFErSnIzNzhYcGx3L1I3?=
 =?utf-8?B?WWFqeGVtczFPMk1Xcmxvb0lZdWNTWEVBRTFhSCtYQzdiT0xpL3JKVVFuaHF6?=
 =?utf-8?B?c09MRzJ6UzkzQTlkNzZkNFY3dHRSV2t3TEsyWFVHeDg5WGtmamNFQ3VNc1pQ?=
 =?utf-8?B?L2x0SnVzakhEd3VaVW5JUTZtMWEwYnZMY04wY0czUjJldXFtZ3JDNmRrRy9n?=
 =?utf-8?B?d2ZYWkRkYjV2YUhUK2ZaMy8wVjg3anhWSWh2RW53SjJvenh0cVhQY1dpY1o5?=
 =?utf-8?B?SklVNTQrWFVObDRZc1YxNXE1MlFZYUVPZ0Z5VjJST0NjcFJKelpLVDZReFZ2?=
 =?utf-8?B?RUNoWjZiMndyV2E5WGIxR0dVeWkxR2ZLKzgzNXhJZkVsamROczBweitUeTlw?=
 =?utf-8?B?b0s1aitVeHBKY1h5cUxhdHhwY0RTR2VaSnRxVFRabm1JU2tCQzlsb2wrSHBp?=
 =?utf-8?B?TVUzb0M5d0pGUXI0cUowNHpIdDhKSFF3S2RUcXhtcWk0UkpEMmJUSEV2aXFo?=
 =?utf-8?B?NWpaL3hNd0NxR2lhdDc2OHhQUXY0YnJxc3d2UFNnNEtYUjQxdTlQVm5NYlFj?=
 =?utf-8?B?SGprUElxMVlFbDJmSnlzU3c0WUhLL3l1V1E3cm1JYWk1RytDR2NaYW9pQzZ0?=
 =?utf-8?B?K0l0cTBzYVhBd25kaitZMTZDSGZuazUxWllNaVAyMmtnbGRScVJ4dG55Z0Vk?=
 =?utf-8?B?MFd0eEMvWVNka1ZKNlVZcHZYbG1FeVZ1TTFva1o4b0dYTFdxTXdGMmk3Ylo4?=
 =?utf-8?B?UTJXWE52VGpZbUpvTHpvb051VjVXQjN1VUV6ZGk1ek5OZzB2dmQ0T1kwalN6?=
 =?utf-8?B?R2tiMmRvTG5mWU5oRmJ1S0FHZFBQY1VHR0gydnlnY2R5WEljNWxvNjZoU2JU?=
 =?utf-8?B?MnAwekM2Y3hva2lINUVEWkZ6Qllya3ZENjJqVTVhRnhhODZOTlBrWkMxKzZI?=
 =?utf-8?B?ZGR4NnhuNExhN3NjL1dCbG5vUUJ1Z0d1OTVjT0FHT2Q1RVViemtaRWllSEN6?=
 =?utf-8?B?UzJ2VXNWRUtGS0x5MlBpWHB0U3hRV2RjTTF1TUk5c2NGeXc1Q1RpRWZMU0dR?=
 =?utf-8?B?Zm5DV2RnZ0MyRTRabVNTOWxCYzI4V01NRFk0elFERksxWDdSb01neXRMSkpX?=
 =?utf-8?B?VTdDalN0blFWL1ZmUU9oSncwZHYycXcwSTdQYmJOd1d6UndFY3FOaGR4SUth?=
 =?utf-8?B?WWo5eEVLMTZzK2NtS0F4N2V3ZEw4dE5qT25wRHdVcGI5cm10L0t0Zlhtd282?=
 =?utf-8?B?cHo3Mk5GYW5hQUIzeks5ZVVuVlFEVU5GdS9UbktMRkRGTVhiaUZwOEdpY1Vk?=
 =?utf-8?B?T0JJLzhNQ29sNU9ENjdOamZvbkxEK1ZLRkp6STBBWGtWeWVmNkhvWWZ6YUEy?=
 =?utf-8?B?UG5aMklIVlhpL01jQ0MvOUgwTklEM1FaU0lxQ3dKN3pCTkF6RnF5NTI0MlBu?=
 =?utf-8?B?aU9GWDJvR3laSU1wbVd0d29aNFBIajBMWVcrRDNzaG9JUEdYK1Azbk5EbkFo?=
 =?utf-8?B?RS9uRCtsRWZJS1RrZ1lpbTdkRkZMdktTWWRtUkJsV3RCcHlFMGk5UDFKSnpj?=
 =?utf-8?B?Q2k4OEpYU2p6eEU1Y3hBSmFGMkZJVUpTS1hSY1RRZmFST0JWWkdjbVlnWnBv?=
 =?utf-8?B?ZUlWN01YbmFwUUUzNGtZUVFnY0ZsUmYwaFVBdE44MDlrUExkYWE5MzVOZCtM?=
 =?utf-8?B?YThMYTNKU0RFU2kwZXQ1bXd3UjB1MnZ2ODBzNWNQTEQzbUY4SDlybGFpY2JZ?=
 =?utf-8?B?YTI5d0RMSjYraGxIV0FVV0xCenIyQVkvTUlRMStwa3ordk1PdDdZUGlGdnQv?=
 =?utf-8?Q?GKxjWvtd0Fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRPTWwwOC96N1dORkRTd1c5L0MrQkJ0N2Rja044cHNvcldTWnpQUjVRVFF3?=
 =?utf-8?B?ekpCYm1YSzR3VW93Tzg5UUY3ZEhPOTNuaklQQjZVZEgyVitjbm96U0xsS1du?=
 =?utf-8?B?TVBVVExjSkJUZ29YRWJ4M3lVZGMwd0VvNTNrc2VaakNOeUsrZnJNNG5zbWlz?=
 =?utf-8?B?R0Z5dm5OeExULzFjU21oZlQ4MmhScjYybTRkKzJuMmpWNmNqRWFQajIwM1ZZ?=
 =?utf-8?B?eGtkZnRpYXN6ZGhwejNNc0daakxaOHVadzdJWjZFYU8rYUFHak1qQUg0YzhS?=
 =?utf-8?B?SWx3Z2QrK0g3TldYNjYzeG1ESzFId1JweEF3SmJEbTR3WGZuSWhGbzZLWWtM?=
 =?utf-8?B?WTh5b0VML1E1aENxWElpM2tTTzNyOGhyaW9jMkVLM2FOUEZjRUk2dHpUZ1oy?=
 =?utf-8?B?OUJzNFZNWG4yMTdhdjB4VTZQRVdaMGRpQTRaYTNKbFloclgwVzNHWktoQkpH?=
 =?utf-8?B?aExva2JEUm53L29oMjh0bDYyYy9QYTI3ZVUreVhPTVFteXYxdXFaQjZNQUE5?=
 =?utf-8?B?QWdCOXYyaUJ4cURXdzBwVnMrK3Q4REU4UzJFRDVxN0V0eEdsZ1kxb2E5R0dL?=
 =?utf-8?B?dUEzRFh6aFRNT2lGa1lQMkN6QkZLL1R1aDltYXpzWkp1cUlnQVBDVXBRbVRr?=
 =?utf-8?B?THpnNDVTcDNJc05VTmdyajBIT2xiSkdXanY5bGV2RzZPdjU0c2pSWHpaVkZQ?=
 =?utf-8?B?RDdORTAvM0NnMkZJdFlXNTFEMTNPa2MzVTFrWUdiYy90bjQzbm84QnppRERH?=
 =?utf-8?B?NXFqMkdJN0o5RTMwZkUvWG5aNnB1eXIyNlQ3azRlTDViQ0s1Z3FweFY0YmE0?=
 =?utf-8?B?WTJyQkQwcGNWemt0NVdXVXQ0QWpIREVKVG9LQ1pzeXlFUXFRaXVNUGdWcVdX?=
 =?utf-8?B?ekVwV3ZNUFhST3l4OGRSbFBWeUxxMWIrdXlTV2p1Z3dMWTFuZjhuOTA1L25F?=
 =?utf-8?B?NlhkSFlqcXk4VS9uTWJXMWx2b0VHZzd6b2MvTjFiYi9NaEpSNldCcGFuMWZR?=
 =?utf-8?B?R1krY3B1OGlmK3lmNkdUWGt0ZnZER1ppdldMMnplaXp6U0xvUER3MVY0UzA1?=
 =?utf-8?B?b2NJTzRRcmx3REh0VEJNUmZBbW01elQ4YnJCYzNXZ3N0aTFnQ2JTRFl0UDhx?=
 =?utf-8?B?bGdDOEM0aVdySzVJVm9sVG1ZUWlSeldKVVpEbXNBa1d6R1I3QVF5V2dSY2NJ?=
 =?utf-8?B?aVl3MFl2MHJlUzIxYXYyTEtCUDg3TDhRemRpN29OL0U2eE9oNEx4cEtBU3BU?=
 =?utf-8?B?ZGJvOXQ1dURMOXBabTc2UVE2WUs5SVdFWkhMR0RCUUhFOUZHQ2J1STdWeTh1?=
 =?utf-8?B?K0tzTytjbHBWaWZ0SldYY2E2bWI0a2RVVlZHdU5NdDkwcmw5WVRYUTZBRFg2?=
 =?utf-8?B?U2VTNVJXcFBhR2dwaDFtRUU5WkhVbHBaU1JmRnRzcU1TaFV2TDEzSWttbnNn?=
 =?utf-8?B?V0dOSE9HWWtqZTZHWXBGWFc3RVBHUit3ckJkL2xuY01CZm05dUhWaVlsRloy?=
 =?utf-8?B?OGJNbnRSV09lUDc1cFJCNlpIVUM1Rmw2a1kvR3VUNm5QVU9QRDQ3QkhKMXov?=
 =?utf-8?B?bWJNK0ZCSktKamQ2ZzMzRHJ0dDJqM2sxazJDTFBGcDNINVU3RkRZVzNteXht?=
 =?utf-8?B?SHZ2OVh5ZTVlMlRGY0pSa0U2K084ZmdwNmtvR0ptTHJSRE4zZytVWVRFSXV6?=
 =?utf-8?B?cTdrTHl1ZDZDUlJOVzNncUx0S1d5eXc3Y0xTSVRVQXJ5MCthck84NldYYXc3?=
 =?utf-8?B?NG9WeDB4NmY3SWZiR3pjZC8wNnBXRnB3YmxodHJUeFpCSUhVUmlLY1gyNFlE?=
 =?utf-8?B?NlNqdytsWUpjQ3Q2OVhKTVdZeVp5dzR3V1AzNk5RNEh0YiszZHZQK05VUDhY?=
 =?utf-8?B?Ry9hMUxGS0RnS21KZFZ1MHI5SzIrTTZGYjRwMnlXbFpEbEFOMEU0d3R1ZEkz?=
 =?utf-8?B?WE1KeGFzOVRsVWxRaVdtVTZ3aytjTWx0bWlROGxFbDlEUnFGTVprazVnMGFZ?=
 =?utf-8?B?RGswMU0xaFdqN1JLWUxCdnlzTFowN1k4NXhBREhPVzB2dDh0WXRXVG9aQ0Ji?=
 =?utf-8?B?MTgyL1l3bjJIRGFSNVZqNExFcEQ3RVRScERYejRrU1hlazVENjVEeDFDdDFl?=
 =?utf-8?B?cTdRWE9rS1dIRHVkTzh0d3VMcUhjQzlPSHdQaWVzOU9VeGJOK3d5UnVZRUdr?=
 =?utf-8?B?SWxDeU83eE5jbTJBK3V6VkJTQjhuVjE2aHNJKzErcHU5SmI1OXhFenpFT3J1?=
 =?utf-8?B?ZmwvcklsRW1zZGk1ZHl2Q25VeThBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1810a03-7965-4047-584a-08dde38eb033
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:20:14.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psC9bEAjgh84cfgsd+O3+xacUKNgPpc7PfMxGFi1r23qhp0jvLRrujLUQZWsGSipAvw1Uv+q/J7LVPxXDElOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

On Friday, August 22, 2025 2:19=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 22 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 06=
:05 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Add DFLL clock node to common Tegra114 device tree along with clocks
> > > property to cpu node.
> > >=20
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >=20
> > >  arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 ++++++++++++++++++++++++=
++
> > >  1 file changed, 34 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > b/arch/arm/boot/dts/nvidia/tegra114.dtsi index
> > > 341ec0962460..25d063a47ca5
> > > 100644
> > > --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > @@ -4,6 +4,7 @@
> > >=20
> > >  #include <dt-bindings/memory/tegra114-mc.h>
> > >  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >=20
> > > +#include <dt-bindings/reset/tegra114-car.h>
> > >=20
> > >  #include <dt-bindings/soc/tegra-pmc.h>
> > > =20
> > >  #include "tegra114-peripherals-opp.dtsi"
> > >=20
> > > @@ -710,6 +711,30 @@ mipi: mipi@700e3000 {
> > >=20
> > >               #nvidia,mipi-calibrate-cells =3D <1>;
> > >      =20
> > >       };
> > >=20
> > > +     dfll: clock@70110000 {
> > > +             compatible =3D "nvidia,tegra114-dfll";
> > > +             reg =3D <0x70110000 0x100>, /* DFLL control */
> > > +                   <0x70110000 0x100>, /* I2C output control */
> > > +                   <0x70110100 0x100>, /* Integrated I2C controller =
*/
> > > +                   <0x70110200 0x100>; /* Look-up table RAM */
> > > +             interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> > > +             clocks =3D <&tegra_car TEGRA114_CLK_DFLL_SOC>,
> > > +                      <&tegra_car TEGRA114_CLK_DFLL_REF>,
> > > +                      <&tegra_car TEGRA114_CLK_I2C5>;
> > > +             clock-names =3D "soc", "ref", "i2c";
> > > +             resets =3D <&tegra_car TEGRA114_RST_DFLL_DVCO>;
> > > +             reset-names =3D "dvco";
> > > +             #clock-cells =3D <0>;
> > > +             clock-output-names =3D "dfllCPU_out";
> > > +             nvidia,sample-rate =3D <11500>;
> >=20
> > Should this be 12500? That would match Tegra124 and a downstream kernel
> > for
> > Tegra114 I have.
>=20
> I referred to tegratab and macallan boards in 3.4 kernel which give
> 11500, maybe sample-rate was changed to 12500 later with tegra124
> addition?

That's interesting. I was looking at the public roth (Shield Portable) kern=
el,=20
which does not support Tegra124. I checked the L4T r17 release now, and it=
=20
seems it's a newer version, where the sample rate has been changed to 11500=
 on=20
some boards due to a voltage undershoot issue with vdd_cpu on macallan/
tegratab [1].

So on macallan/tegratab, the vdd_cpu (smps123) ramp rate should be set to=20
2.5mV/us and sample-rate to 11500, while on other boards it can be 5mV/us w=
ith=20
12500 for faster ramping.

[1] https://nv-tegra.nvidia.com/r/plugins/gitiles/linux-2.6/+/
b92cab2d4cb6379aeded80adc4c5d0708c3f038e%5E%21/#F0

Cheers,
Mikko

>=20
> > > +             nvidia,droop-ctrl =3D <0x00000f00>;
> > > +             nvidia,force-mode =3D <1>;
> > > +             nvidia,cf =3D <10>;
> > > +             nvidia,ci =3D <0>;
> > > +             nvidia,cg =3D <2>;
> > > +             status =3D "disabled";
> > > +     };
> > > +
> > >=20
> > >       mmc@78000000 {
> > >      =20
> > >               compatible =3D "nvidia,tegra114-sdhci";
> > >               reg =3D <0x78000000 0x200>;
> > >=20
> > > @@ -841,6 +866,15 @@ cpu@0 {
> > >=20
> > >                       device_type =3D "cpu";
> > >                       compatible =3D "arm,cortex-a15";
> > >                       reg =3D <0>;
> > >=20
> > > +
> > > +                     clocks =3D <&tegra_car TEGRA114_CLK_CCLK_G>,
> > > +                              <&tegra_car TEGRA114_CLK_CCLK_LP>,
> > > +                              <&tegra_car TEGRA114_CLK_PLL_X>,
> > > +                              <&tegra_car TEGRA114_CLK_PLL_P>,
> > > +                              <&dfll>;
> > > +                     clock-names =3D "cpu_g", "cpu_lp", "pll_x", "pl=
l_p",
> >=20
> > "dfll";
> >=20
> > > +                     /* FIXME: what's the actual transition time? */
> > > +                     clock-latency =3D <300000>;
> > >=20
> > >               };
> > >              =20
> > >               cpu@1 {





