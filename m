Return-Path: <linux-pm+bounces-32851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB67B30C22
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75BE1BA7E53
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 03:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17B626280A;
	Fri, 22 Aug 2025 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CxknHs5S"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5225DD07;
	Fri, 22 Aug 2025 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831923; cv=fail; b=r4kPStFGhcSioJ3AlZNhHvSMerGz4Qm9/x3Bf0Xi1mNMJtOeUuRuAl0a4bXda9UvMfk696KqmWO8DudIsawv3UaE8h5fwXZ3jds1PjPdmcTXKzWzK6UpGXy8iSdMNmsxlj7KcDpP796kldi22i6OrAJDL+HlQE5WsX216inRHig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831923; c=relaxed/simple;
	bh=Jw42Y67ayCfa2+s97MlT7iLiN51lsXcooWiu/Sdj3hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7W9yaP10jMz5Fs9G3aGEwnfHDV4kRCfOxVMHmhyBJKIM6hSrmzlIgFKN9+FUoF8mdjYsscYHbOUuvVVvin91r/F0v6cXHlwzzYhgmciMa/hD1UxASqk2ncb7PhkS7gKcWXXdE6m1Dvllg7Ch54ZZ97k1lkkEyucQx+AcJrE8cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CxknHs5S; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0VHAs9MjngPh+Oky8s44jfEsVMo+1lfmY9so+hJTa/Olv1ZR9j4OHK6XDOKSxNggteUijOUbtTSH1R+NXEMYldDz96kxqf9hnFFqUeW2FSSDx+ch+J1NHNT1Li3/e0jwFW7eXv+qP8yvMLewGvcrRnncuOIh3vAE2Q4RygJkVu7I6h4jMeOgtuV5em68CF+FleiWFis1d/C6lNunxZ1Jtdd4WCbG8zD+QL2NnQcNOrhMNcpNSQU7z64m5eXKBRcS2QAq1Ip9NdmFfN+Okl5+CeLU0iPIUa83VONDGqq880fJjaQM5W3AwCslyf/5m39YGnYJYYvpw5GuNF+Fp9RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg1DCd38LE986u7kzac5OIZNnDaLO1lGd34Le5UCxiQ=;
 b=qfk0oqS7ps/QKNqysSOufMbbsYpJ1v84cHrCQVdne/LXuh3u+cBRCzBdr7W4zYmqlqcaUJN6HzouohzeWWdayD3YP5LuerP6bXJ1iD3qtSzC625tZCQBUBHCBkmkwP1DI0MAurBSXNZdNzILkkRTHMjoBGz2Hj9uw3WSgDnK7Tc/NijQDzXtedIVc6NNa1O0CGlCGb3prwOSGtoxAEPmaKb2DXdWnN3MXVbZOwPGiqKZybVqvg4Jc/Yte4OORALjCsifPGJ2kjOsV+PmehCg7AYuYjEbiSvMsndiCRcVCMpDDfqn/GS50kHwkz0vLxT/HBycM0A5ozWjRpFt0BJ73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg1DCd38LE986u7kzac5OIZNnDaLO1lGd34Le5UCxiQ=;
 b=CxknHs5SRrnuXYBPVtlJRNQu3F8GMQJeY/vBRZnA7iMi5w358zchjmCSx54+bFTert7moeFr1RXrMP05zAUmAWiZtCOhBhqofTtF3vqehoUfSoCczM+eVtPBUs2lfBs4F0cY+n7mJh6tEpRvToWVQa8E+D9WKP9SIf9CJA84/TSI2gyFAcZ5Jwirz1vzPTVXlKaf/GO8tctqsQz7oB8acFmS8Rw3ZW+a1wNSvh09gaqBiy1KCfeXXYkojPmm1INejuLzM2pxzQmTzeNCgKIID2nOxqy2yys1E5bLI92rMnVbru0Aj/EV7KcH61iJzjNagdj8/gfSQYDbZmh8hUx5+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Fri, 22 Aug 2025 03:05:18 +0000
Received: from DM4PR12MB6496.namprd12.prod.outlook.com
 ([fe80::bede:bc2a:5e14:e393]) by DM4PR12MB6496.namprd12.prod.outlook.com
 ([fe80::bede:bc2a:5e14:e393%7]) with mapi id 15.20.9009.013; Fri, 22 Aug 2025
 03:05:18 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] ARM: tegra: Add DFLL clock support on Tegra 4
Date: Fri, 22 Aug 2025 12:05:13 +0900
Message-ID: <117069551.nniJfEyVGO@senjougahara>
In-Reply-To: <20250321095556.91425-4-clamor95@gmail.com>
References:
 <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-4-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:404:f6::23) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6496:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e26ed95-e951-4706-3afd-08dde128b8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlBYSkE1NkltNWxHREFlNHNCZW81aTgzOXVvMEtUSDRiQ2RaR2UvNTM4RFp5?=
 =?utf-8?B?Y1QzOFE4RWYrR3R4c3JGUnVpWE9HeXFOWnc1MWZ6S0hEVU56am1vdVZSUTV6?=
 =?utf-8?B?bmlyOGtYWlpwaXZUbjkzNG9nUCtEZWEyWFNnYVNDcXZFcmVTbFBUWHk5L1Zk?=
 =?utf-8?B?ZzhuUlppV21kMndaakUzTTN6WXVwZFg1VVFJcWZXYXppMlBjZFZRR0k4SkVH?=
 =?utf-8?B?WlFlOHdlbk5Cc01HYnVDVlo0eitXTVlsa1VrM3RCTzFvZFpzTVJOYUZaRXFk?=
 =?utf-8?B?Q3VVaUlmNnMzRm1FWkRwVFhjK2F6OVBqNlFDRHU1SVJZWkJCUXoySmVzM055?=
 =?utf-8?B?cUVNVXNtR0UvZGpoeWcweE1NVDJxQjAzQldXQVpHV1Q1Y1UrYkl6dVR6SzRQ?=
 =?utf-8?B?VW5wU2hUWHVUa1J2cU9pMFRITDM5cFlWbFUxaXpqeW9rMDY3NWRuRG9EZlhv?=
 =?utf-8?B?TmxtMlVWcXhSNERwUjBlZFN0RGJsd1VKaGZJRFpkWWtIQWprejVlUnlhVkVn?=
 =?utf-8?B?V24valBydDRSY1FEcmRmdFE1WG1odlJFZnE1b081b2JaeXFPTWE4TU9uZllS?=
 =?utf-8?B?cjdhaEtvdHdNcENmN0hMRm5laWlRVzdCeitmUS9rbjI2ejlvOC93K0d4OGlG?=
 =?utf-8?B?clJ0WDRIVlNuMjU0ZzRZMFFreWFVU25rZXVUeUVLUUxhOTdsSlZEOHN6TXd3?=
 =?utf-8?B?KzJ2V2dzMjNEbnlaQmVKaENucDRYeE5tUkxMNnU2cWg2dFh4TEZyRFllZEZs?=
 =?utf-8?B?VFV5U2ZrN1I4VzljVmJJemQ3ODI4aDh2SWsxU0ZzeDNrK1pKcTZ1Sk9ZeFAy?=
 =?utf-8?B?QVZmdEdieHB3MWNFZFpLUFdMaDZ6ektMbXN0dkZqdkdTekRMdVlQbUZLb3U1?=
 =?utf-8?B?RU9mT3BzRHIxZ3dBQlFDWGZZV01NVVo4S2RlSlNsOTc1YWl3RXRzblA1UXFl?=
 =?utf-8?B?NDZOcnJhZFFJUGtGWVl3ai9xenI3eEVuTmIvTmFHOEtXblY1ZmZIVkQ2TFV0?=
 =?utf-8?B?UmVnRmg2VG12R2w5eTFWM2tDSmx6dElodWE0K1lWaklYSmRNUVpPempBVDB3?=
 =?utf-8?B?RjF3NDRJWUlLTm1ia3NrWlVaaHV2S1FXZGtQMlRtZlRCMThnOUpXeDVBLzhY?=
 =?utf-8?B?dnZ2d1Y1R1NwWWdMc2xvTnJueHJscTFSZGJreUkxR05sb1NaYmRXSTA4N0Za?=
 =?utf-8?B?b2U5MjlBZDdlWVAxQ2QrT1dQOWFGbXV4SzEyckNaQjIvMXY0MzhoNUx3MXFu?=
 =?utf-8?B?Y3o5Z3ZpZHF2aHRERjZOZldicElQOGZLTUxGb2pxVkhZdnJBSkhwWHpPOHpr?=
 =?utf-8?B?UDR3UFUrZHdkbTdtdmx0VHhqS1diaTNyZzZsREk0TEMxZTFNMkszV0psNXlt?=
 =?utf-8?B?WDNuYjFzd09qV3E4Sy9JQ1djYkM1RnM3TjZ3aDVyV2NWRGs1QVpZdTVKOW9F?=
 =?utf-8?B?cjljU2E0cDJKaHgyelZ5VHVoZHdMUzNUcDIrTFg2WTd5dnlTai9VY1l4ekNS?=
 =?utf-8?B?eDFWODlIckZYK1huakVYZW5KRzgrZk9mVC9WUXUreS9CdWNDUlgxVG1zQnEv?=
 =?utf-8?B?d0F1c3RuRVJReFk1ZjJsSnV6aHRSWlVXZHhTZUFtZm45VTloSkJibDVaeDZ0?=
 =?utf-8?B?SzF2QWI0c1JQdEtxOFhBTWdCTmNrL1cra1VDK01zTTBJU3Y2SzJZc2VwMG53?=
 =?utf-8?B?SEsvQ2VaWlRLaW1mVmkzY2hENFpqelE4dEFxdmZsMm9NZzRMREd3RkpRSDBi?=
 =?utf-8?B?ZFlHL2JNQkpLclUzTENDakREZjZQc3N1T0FZSVBlRWJyRTkwYzdMT3RuU3JP?=
 =?utf-8?B?aUJaVVo4bkNSNVg0TW9YWUt1bzFjWlpMVFVlVlVuV0w4LzFIU21YZi92eUdt?=
 =?utf-8?B?Vm5FSWViaHdmUTljcVgvSDdCS25ISnNBRC91cGxSUmhyNmhJOE1xTktwNGYw?=
 =?utf-8?B?NWM2QTQydUVKVFFkOGl3bWtrY3FMbzQ5UndDR1J4MktQeDdKNTd4enlSY0Vw?=
 =?utf-8?B?bHJuNmpkM1ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3pnbUpwbDVDeXl1MC8rZWdCV25Fa1czMnEyaW4xemZ2T1c4MFNMcG92MzhE?=
 =?utf-8?B?aXpKVVhPamxCWUF5eW52eGk3UGF0WTFGUjhXNGV2NEVJTlBnN0JjdzdsWVg0?=
 =?utf-8?B?dEthK0s1Q1ZuUXVwUWoxNGNpRGpYOWRwRStFWkx0MHh1c25SYkxCZjBqU1lH?=
 =?utf-8?B?ZnpyZ29Qc3FTa29ZMzkvQkU3RWlKYnc0TnY3Mjc1eEplQ29GUWJRTHpQa0Mw?=
 =?utf-8?B?cEw4bmdOVkRFdUR0S0d3MHRLQXNaZzNmM2liVHFuMlA0MDZLUG9FRHZUN1pX?=
 =?utf-8?B?WEhBdUxGa2x4RXJqLzlHaFJxK1dTMml5dGNOMkpKYWdGZVF4U0Q3L3VjMVZW?=
 =?utf-8?B?b0VVbUgxY1ZmUVFXTStzRUFCdklQZEQ5Y2loNTk4d1FNdEJQQlBKMFl2bXJu?=
 =?utf-8?B?SlBhckxsTEIwMnBqSnJBb1VZYWd3bVl0K2t4VFpkRGRyczdPSGsyWE10U29X?=
 =?utf-8?B?aUMvLzhkb0h5eWE5WG1aakt5NFlRa1BLd2JvaE95d2taNXBxTFVGdTJvQ0gr?=
 =?utf-8?B?S0RUL1cwQUtwaFlIcDliRDNYTEV6VEcvSlNqMU1tWnFqZk56aGx0SXg3Rmxw?=
 =?utf-8?B?Qjd4Qisxai9zQ3JpRllCakpqb2dEdkM3Ym9Oa2tpMEZ0TnMyaVRFZnd1NnNC?=
 =?utf-8?B?cXBENlcrNHFQaU1GcmlOWmVjcUhzRm1yeGxVbUEvWGp5RVFPdDFXdmtmVnRo?=
 =?utf-8?B?UVpiMmg2MTY2bmZFNlI4UTNWUzJBZGQ2T2xySkhOTzNkSk50Y0RUcGt3N1p0?=
 =?utf-8?B?K2FGZGc4TjdTY1FnRkxOcjNCMm9UZGFsT2hlKytwUGpJQnlOK0hrd0VyMDNJ?=
 =?utf-8?B?YzNzeXF0ZjJNeExJZzhDQVRwT0xKQmNweGVTaHUvbzJLcW1Zb3MzNjZ6blhK?=
 =?utf-8?B?UEVMNnB1STRkbGZYS2g3K0EwMzQwU3NaeFdhekpMTFZIa2J2ZHEwWXpUTWZO?=
 =?utf-8?B?NEViMEcxUk9EeHE3R1JBdWZxYnQ4UTNFMk45R2N3dW1zMURBUzBKRGFNV1Jl?=
 =?utf-8?B?a1BzNUFoME1XajhqSXZDWWdwMVA4V3FTdnAwVlNNRnV3MW9sK0xHd3paWGxM?=
 =?utf-8?B?U3NCWVVOZmIwRjFCK0FyT3I2ZThvRUVoQ0pKbDV4UmpRS284YjcvdnllbnJw?=
 =?utf-8?B?a0NZcUVHOVdtTmNmQ0I4amordW1OamVIc09FRUtRTThrYmVwVndsQ2xOd1JI?=
 =?utf-8?B?Q2liWHM2SmRubWx5ZEQ5aHBFWHRBLytJL2ltbWYwUlZSMXl6RG1QMDlmZTNo?=
 =?utf-8?B?WEJ1ZkFDZ2ZKeHFhUzEyd3dacnRGdkdMbGNweU1IMjY3UHA5NC9tY3paQ2Fk?=
 =?utf-8?B?anVJRkVWM01obTR0aFVlb1pmbDBQRnpxcEpLQ1NiQkRGMnYxV0g4M2JkMlQw?=
 =?utf-8?B?RU8yUHJkaFRYZWVCSE0vSUcwSVZSUStWak1TTjVPVEZVV3F1SWdjcC8zeTN1?=
 =?utf-8?B?Zkk1ci9iN1QwUFdHYk9weGQ3Mi9sUEk3ckgrdkVmTzVlY1JCTXYxTEdJN0tp?=
 =?utf-8?B?blAyRDhXZWM0VjUwM0puMnFTdnBHY3o1elFPcGFJM2c3bGJVVjArZlVESVhE?=
 =?utf-8?B?c0E5S1VsVFNQNE5FaEVwOUFlZ1FKUWJnN0NBdVY4Wm0wZnRQZ3JTL3BCSGIr?=
 =?utf-8?B?WmZYamtWWkRRRmd6WlNtWHhxZlRsOTFoalNzRS9VRVQ0RkRhRjdWQzB5K2lu?=
 =?utf-8?B?SktMeUQyYktPSmozZGhqdGdsclREdUdRQ0xSdzdQK2d6V3dvOE9FQ1BSK3VD?=
 =?utf-8?B?UG51KzBoYitxcUxsd3BuSlAzTTg0U1pRNlhuRnBVL1V6Z05ac0M1WVExRllD?=
 =?utf-8?B?dnU1eVlKNXdtQnlWK0x2VWlobFdEbzVOUmhrVUNMTENFMC85QS91QnlycU83?=
 =?utf-8?B?c0w3bW1naWIwR1hEZnlTakJDUmFnZHBZdWlyZVYxTUxQa1gxMkIxNWw2NkJy?=
 =?utf-8?B?TTBJcGJWcUdTak5nRWpFS3E1U3FnR2FhYmxhd3FlWEZkZCs3dXluckNPMXdF?=
 =?utf-8?B?QnplN3o1WkxkekwrL0ZnMm03bWdTV2tJdjZPNlM5emFaTktaZE9nU1BPMHk2?=
 =?utf-8?B?aVdCOTIwTHBOLzlBa0VQb2xINGxtVzBNNlVyR3JuNFU0WDFVL2dYYnJBYS9L?=
 =?utf-8?B?WThVa3cyTlo2SitFbUY2K294WDJrY0RsOTVQRll4QUtmNHBaMytSaENUd1JL?=
 =?utf-8?B?Nk5OV1BjakwyNTJOL1FXbjFoRTZsQVY4UjNuZjZYYlFZS3B1WjZRQnRueUI1?=
 =?utf-8?B?cnBNalBHeDQ3eHJwTTZNTFRkUHBBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e26ed95-e951-4706-3afd-08dde128b8d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:05:18.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U/YcmakEG3C8G1j0g5O7wUUj3HaKkrDLL4qwAvNQkKO0b3ZZkELje5gGiVl8FPFBTSV/kzzXPbYuT95gFzHyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012

On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add DFLL clock node to common Tegra114 device tree along with clocks
> property to cpu node.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> b/arch/arm/boot/dts/nvidia/tegra114.dtsi index 341ec0962460..25d063a47ca5
> 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/memory/tegra114-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/reset/tegra114-car.h>
>  #include <dt-bindings/soc/tegra-pmc.h>
>=20
>  #include "tegra114-peripherals-opp.dtsi"
> @@ -710,6 +711,30 @@ mipi: mipi@700e3000 {
>  		#nvidia,mipi-calibrate-cells =3D <1>;
>  	};
>=20
> +	dfll: clock@70110000 {
> +		compatible =3D "nvidia,tegra114-dfll";
> +		reg =3D <0x70110000 0x100>, /* DFLL control */
> +		      <0x70110000 0x100>, /* I2C output control */
> +		      <0x70110100 0x100>, /* Integrated I2C controller */
> +		      <0x70110200 0x100>; /* Look-up table RAM */
> +		interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&tegra_car TEGRA114_CLK_DFLL_SOC>,
> +			 <&tegra_car TEGRA114_CLK_DFLL_REF>,
> +			 <&tegra_car TEGRA114_CLK_I2C5>;
> +		clock-names =3D "soc", "ref", "i2c";
> +		resets =3D <&tegra_car TEGRA114_RST_DFLL_DVCO>;
> +		reset-names =3D "dvco";
> +		#clock-cells =3D <0>;
> +		clock-output-names =3D "dfllCPU_out";
> +		nvidia,sample-rate =3D <11500>;

Should this be 12500? That would match Tegra124 and a downstream kernel for=
=20
Tegra114 I have.

> +		nvidia,droop-ctrl =3D <0x00000f00>;
> +		nvidia,force-mode =3D <1>;
> +		nvidia,cf =3D <10>;
> +		nvidia,ci =3D <0>;
> +		nvidia,cg =3D <2>;
> +		status =3D "disabled";
> +	};
> +
>  	mmc@78000000 {
>  		compatible =3D "nvidia,tegra114-sdhci";
>  		reg =3D <0x78000000 0x200>;
> @@ -841,6 +866,15 @@ cpu@0 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <0>;
> +
> +			clocks =3D <&tegra_car TEGRA114_CLK_CCLK_G>,
> +				 <&tegra_car TEGRA114_CLK_CCLK_LP>,
> +				 <&tegra_car TEGRA114_CLK_PLL_X>,
> +				 <&tegra_car TEGRA114_CLK_PLL_P>,
> +				 <&dfll>;
> +			clock-names =3D "cpu_g", "cpu_lp", "pll_x", "pll_p",=20
"dfll";
> +			/* FIXME: what's the actual transition time? */
> +			clock-latency =3D <300000>;
>  		};
>=20
>  		cpu@1 {





