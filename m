Return-Path: <linux-pm+bounces-33827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37747B439B7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EF75A215F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB22E8B86;
	Thu,  4 Sep 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oNZIz/FU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5C2A1B2;
	Thu,  4 Sep 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984782; cv=fail; b=SIlhnBexPXSXw6Ev14gdTbG4jQjBcZB5Sq8hmiZW+Yd0SnNwWbZ6165KnnKNFHf5YeUS4/Q/+KMoTmPjZaz6Q8jZ382Be2COUJ3YlhUk2++hNTZJFrO0s7JeXiB2+ytkcF/h1Unvt7cNhx89kIDbXHmzBR40sx0n9yexknxmPCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984782; c=relaxed/simple;
	bh=agDz+08msGh2Xf8ZOF4cLyXgGIbjcuKPOaCg5xf7Yu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7GOzVpMR/hAVDBZwvgUhf446GIvMz4ckx00gan+p46wGjV+996uiB2dbmkahWDSw9cZaMgcQ/K++xKm1e3ntUiDe5pTtJU57u7IcKfOrGIG8kE+zb6dojHc6alf7/oM8UuItPYXI/lAU1e3x3YMEkE5gvS0JF3qbxno0pmu520=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oNZIz/FU; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY60WyhK0tZmpgi6YS0Jb0U3URRDgvmcC5LSt8rQn5lLitioJjjp92M/gJjjrG4zxFIqJTguBugJquP9INpk2Le7Yadt3jaydhqVqsSZOLFuaRUXBZjxOp31fOlF4CG6G7qrFOqJKEOCD9G8AsIfretvk/W+EYBgTL3P0u0EjmMCHuKcPcHUpfBJF8Fdp+NCMIoL3N9tnU/Ouy04HNtffPy0XNwHIIHvJpj0PqeI9JsuoMyahODcYawT+Qe2QR7JALzIXZykgluzLu6Eop+HMQRlsGGCOfFO7T/CLLKT4lvQ3hpzJ4sW23ErjSGBqH8XwOakByu0E2IaMXs1Gn407w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVqtB02Z91ggEYSHUcJlzlJmiY4s3Cg3Hl+nu1g/oeU=;
 b=hlGN90C4QXepJ2PRLdQ19JnW7EhAk+Hs7sTmeYdREulDqLEjd3PRpazSwA5myRpMWd1ppEkgIGtLwkDzpe6akbmlriTJ9TYX3PoOQapjrmwLVIqk+CmIvjgl02I3Uqbq5xLjr95tulsIAQ4iupaxl6vNs3/r5dBrRtXGuzQ4mSKgJJU0Jg5YVJksxtWy220vxcHnV6HQH6YhG2IQT7QvI0LLr6y7N171XquYs3Wt4Sr7gOdlPigSSOoGhaX+ZwkaihBqwYJhQv3A7jLH2qG5GFahm6v4n0DXpBGeiWuEcgY6p+m0gZa68JzpQp9JQ06S/g+YO9k+SMmbp/1rDFVL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVqtB02Z91ggEYSHUcJlzlJmiY4s3Cg3Hl+nu1g/oeU=;
 b=oNZIz/FUMMnjzBhvhdmus5or+bEUF9YwSfUG1e9bJsdeE120cvx00EA5+splXNWiwz2cZVNM2efCYGv8vL9DZ3RSlETkz8cA4wS8nwVUmaHYOqVXcP6CdntzLRXndsc282JU18oQ4D+J3qvDxDz/n8T6JeMB6UBJ8YPKsmabAR98DnZk2jggY1kV80J41fmwlQnTz1pzI03fxn4/BMgjAratNROXig/go3jXL7GnERwhGaH9JyPTsG2c2nnqYE1TB0OTYYTcNi8Ndg3gEgBsb8YP9tQC2Tgva3LM2/FSSAnQ582Zc5m9QpnoyagkdoclWoExglwL4nwfr2Lv1S614g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 11:19:36 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 11:19:35 +0000
Message-ID: <acc7b401-d511-43a0-a15f-63a223dda924@nvidia.com>
Date: Thu, 4 Sep 2025 16:49:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] cpufreq: tegra186: add OPP support and set bandwidth
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, bbasu@nvidia.com, sumitg@nvidia.com
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250831-tegra186-icc-v1-3-607ddc53b507@gmail.com>
 <20250901055322.eorgaa3sycydjrrj@vireshk-i7>
 <CALHNRZ_EbtHSXaDQ+1gGf3HjdyW5Q54EDN901-r8A_aXLbDJkw@mail.gmail.com>
 <20250903050107.sbri6snqrzq4hale@vireshk-i7>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250903050107.sbri6snqrzq4hale@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b257a16-5034-4cfc-653d-08ddeba4ed9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0wyMk0zdnVLc3d2RnRIVVpIWW8xVTNwWDNXdWVBRTVIdXpyQXB6WmVod2NX?=
 =?utf-8?B?WW9sMy9xNENUUCtLODZZL0FUZ2NYekN5SjQ2TEVERStqakFySzFQZzF0dURO?=
 =?utf-8?B?dVFmemI4R2NCWmNHRjJYek0za2JBcldWTjNpOVFvMSt2OXkvVGs0NEwwSkdJ?=
 =?utf-8?B?WC80czVNTkxVNGczQjhmNkxYOUFYYUlUWGQveUlxU0Z4K0tpV3JJYTBIWXhl?=
 =?utf-8?B?cmtVaks3Vys1cnk2YzJ2c21pWXZoOUhPL2tTN1IzMEc0MDRzcHJGOVB3YmxG?=
 =?utf-8?B?UFFDV1B4dHlZOU85TExJK0YyKzZiZ2FCU3haNUUxUVlIaGVyN0FFRkI4ZFhS?=
 =?utf-8?B?ZHZPcTBqd1ZjejlTS3NFbnd5RnQ0K0poeWhtL0ZuNUpKYW1oekdGcnhMa3lD?=
 =?utf-8?B?VXVVYmM5MDVISmlrT0RXKzNqcGtiZ0pKZHVsZ1U3aU1DVSt3K2pVMG52WGNB?=
 =?utf-8?B?UDdGdTlVS1JoZW55N3RaTlZpVmRvcURmTEJVSGpIeXU3QTNaak1TZ2tKQ0x1?=
 =?utf-8?B?UXlDbGZYVE5pV3R0YkZjY3daSmk5ZU5YeGE5cW1sa2RWc2FvTXUxaExEV0hl?=
 =?utf-8?B?MVVyaytoQmZ6U0tXL29rZnFsS1JFdzdiZlIzc1lkNG9STmI2ZnBnbmE5ck1R?=
 =?utf-8?B?THdybEpQQkI5T2xxVGhHcFNWdDc5dXBZVHJwYU52U3RoVUg0YUcwYkpPU0Z3?=
 =?utf-8?B?SXhpTllDRmJpdXlZOTVldUoxKytwdFNyOUJmT2xkYjZQL3U5amhzQ2RzUk1q?=
 =?utf-8?B?STBPSzJUSFNvZkJmUWF6WWk3RUlHSFdFaTFhZTVwMzRrQ0VRMmphYkh2aFpZ?=
 =?utf-8?B?U0RHeHV5a0dnb3JRY1I0YXBQb0JSbWFRL1BHVCtDTk5TcW9sZlQvZnpiUEhv?=
 =?utf-8?B?TGZNek1QWnFqWDVFZmpzc3VIeEZYZGR0YU4wSWVISGNwTWdvRzE2TGhKaUF1?=
 =?utf-8?B?OHREYnNoOFZqMVlxTEZSQmpjUHNHbDJibEZoSkh3SzNCaWJCZTMxL3JXejVn?=
 =?utf-8?B?aDZnaUROYU0xcUNZV3hxWXlzVUsxWWJyL0h0TXlCMEN5MDBnVFZUa0psM3Fx?=
 =?utf-8?B?M3ZKWk1Vd2c5N0tYdWNGZnZtQ0VidkQ4OXAyL0tlb3kwTWZmd0JTbnNnTEVZ?=
 =?utf-8?B?aWZhN25NODIrSEFBSkNPYU9FSkRoL3UzZ2wxcnRGY21vS05ySjBoOW1TV3FP?=
 =?utf-8?B?YkJsbHZmN2FyWEU5WnNQSWJTaFNLeEg4U08zRzhhNFpYMmI4TE9KOG4yQzVG?=
 =?utf-8?B?d2VZdEVEaFZIZ01vZ0NoS2NxTDE0ek0xTm4vUGRIN3owTC9BSVcwNm53RXAw?=
 =?utf-8?B?NWJlbjRXZCthRTFKMFJxNjY1U3VoeGJkVi9nTGkxQlVNQnh0eXJueDhDTkxF?=
 =?utf-8?B?MTdYMjdsYTdpMEE1YnNYTDQvblRUeVRjcVduQ2xaelBURDZQaG80enlGdUVS?=
 =?utf-8?B?TUpxcGV2MTBHVHpCYjVBTkY2emlmS2EraERYeStwWnk4NEZ2TG90TVRqK3VT?=
 =?utf-8?B?dTNUemhBT3BhRkpMTGZpUXhwczF1YXlVWXk3dUNrVXpRTTJ6LytMeXdKUzJ6?=
 =?utf-8?B?aUxKVUdSUGI0WlRsUm54NUNDWGVPcklvb09pNk5rc0lRT0k1YUdYS0lsbkt0?=
 =?utf-8?B?K0hKajk3bEcxRVVSTW9UeThMazZyL1NaRWVDN0h0QlF1QzVCK1gyd1BmdmtG?=
 =?utf-8?B?c3YrZU1Ma2FhR1g2cUpONkZPQ1JyV0lSLytXU29jcjdVOUM4SkduWklnT0Ry?=
 =?utf-8?B?L0FiQWt6d2tUMVE2RXFpMmRVdk0xcmxpQmo3dnRWVjRxRDRWZktlVUI0RVBq?=
 =?utf-8?B?TmVMR0xhRG1KTTdjVGtOajdiZG1hQjNDRWhDWjhhdjFONEVXTkg2blhUZUVP?=
 =?utf-8?B?cHkrTWNHQlBUVUdteHlqOHM1c1pucmpBVFo3eWIyU3MvSVROaXgzdk9OcHNi?=
 =?utf-8?Q?BvUYWca89Vs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWl3aWxaMldWRWtZVVBIbXNDdTlGVFJ5WDV2RkZ0Ym93RnIvUlZkR29ncUFU?=
 =?utf-8?B?cFgvbnNXTy9iN0xLOEl5OUtzdGticHRBcjdWRWE0ZUEvbnV3dDN3RFF0UXc3?=
 =?utf-8?B?V043L1VtVUJEUUtvRFB0TWR5NE55ZUl4T2oxREl3cE1uWmsxenRWS1lJcUpS?=
 =?utf-8?B?d2w1Mk82d1BZZUd2eFMzN2F0SWhhcGNZWkJGVFFsRVV0QkRYamIwQVhyU2xk?=
 =?utf-8?B?ZEkyTHppR0Zxd25jVE1wK0EvOXQ3eWFzMk9PSVpIZlZEeHFiazh3bWhLZFRj?=
 =?utf-8?B?QWUwZVY4WWJnd2NLbk5RaWlpbG42T0NvOEN2QmtsQ2Mvd1czYlBlTHc5YkxB?=
 =?utf-8?B?YnI0WVJoN05lT0RwUG1hY291bmFDTEw0QkpkZ2FzZngrek1ETFByV0szeGFz?=
 =?utf-8?B?YzNHaWlFdEFLNnFnSlhSV3lSb3lpS3MwWE8ySVc1aWZLUkZSdjd1SGg5SU1D?=
 =?utf-8?B?cDdkOUdiT0RRSk15ODRRVk9hRUFyNGFzUTltM0ZEL1NCZHg0dW5xZzZxTnAy?=
 =?utf-8?B?ZVBWYi9iM21JTjF2V3ZEWUVXVUJVV2RPS1RoalhpR0dtZlFObU41UnFJZW05?=
 =?utf-8?B?cTRidFRVekhaTHVRR0RrS2tkL1ViMzB5eXVqQ2QwektWbTl0amZhSzdNb2xM?=
 =?utf-8?B?Ry9MRnhDSXdCeTF5aVk5SHJFRUxGNCtPaDgxN3QyaGloVUUwNy9VZC9IYzJa?=
 =?utf-8?B?TTEzT0d1bTRxYjZlVExpUTFFYUpGMVc3bXUxM0k0R2xScC82TlBndmxRZlE4?=
 =?utf-8?B?ZE5HM2FMdjVXM0tWS1JYNW5pbnJMTy93Rk9BL2diWk5KdkwwelVickkzeURa?=
 =?utf-8?B?TFhwdXE2SmdnVFhscHd6ZXFUc0JWakRqdlF2dUFNbE1jRmRIRTJIdjJlcWNF?=
 =?utf-8?B?SGpVb0V5djRIWndFc3VReVk4UWwwUTZsZVpmM2VEbVhJcVkxS2tIaytuVXFs?=
 =?utf-8?B?VktTUHByeHBNcEJNRHM0R2FPWmNRcVBKMWxJSzgyWWsza2ZWRmUwbDJTMnFU?=
 =?utf-8?B?RnhYc2VqMnFFSjM0MmR3RDVkYklWQS9IQ3VETFdoS1REUXdJU0ZjYm9PLzgz?=
 =?utf-8?B?OVJWK3N0MnhTTDN5V0tLOXhvR1ZvTzRycEtaUm5KZEYreEdxc0I2WVRRdW9F?=
 =?utf-8?B?OFJ6VWovSDZOVk85dHFWQlpEWU40NVBwcG44b244M0JTaTlBeW5OUE5NU1o4?=
 =?utf-8?B?RFBsbWU1OFhxTVd2M3kzcE1wSTZKYTI3bmlYdjhKVHBCV253K1pHOCs2UEtV?=
 =?utf-8?B?Tkt2MytOTjF0elZHakNuaUVOSWVZeUtBUEE1ZDgxZnZtQW5wblMwZ3YrNWIw?=
 =?utf-8?B?WGdQVVhGN0J5RFpDQnhXSWM4VVJBRWY0QittNnJQVmdNWWh3STgrbjJwWlc4?=
 =?utf-8?B?ektXczdFTlhRVk5yVG4raUtJdW5pQVVhWHh0dXkva0E0L1ZJNlFxdE9odjBk?=
 =?utf-8?B?TlcvRDhFVm94ZnU5VFVVQmt1TnNLQ3ROKzBlTURQQjVQWUhJWFd4Y21kNEVv?=
 =?utf-8?B?T24vQlY0V0xsaXRzczllZnorNVVaNXc3SEZmempxTXJyTXVDajJzbkVKejMy?=
 =?utf-8?B?MGY2aVdERkFzcHBKRGJaMmtSTnBFZnBnS2czSnZ1ZHBCQkduRERra2dUdWJG?=
 =?utf-8?B?czQ4MU5ROXlOWHRwbTBJWmV0SlFvWjBaL1VPeVZYWTNLMGg5UEV3UDRyMDFV?=
 =?utf-8?B?a0JCaURBcjVmdW8ybFJWUVNIa1JHRitDYkExYmdDclBucGZWMXQxQmxmdjVI?=
 =?utf-8?B?UEJwSTRZNmFRZGUzOXJVUFdZTjE3bzNIbStNS3BMeDBnL0dkRTYyUTB4a2lB?=
 =?utf-8?B?d0hrbDk2MjR2bUVsYUkyeDVCTUg4d25hZ2REQ3FLUFRRb0c0TElMYmhYU2ll?=
 =?utf-8?B?U2hMWU42V2JSNnN4b1ZnWWFZSkhiVThJUVVyM2JGSi9aajQ0ODVsTlozSE1T?=
 =?utf-8?B?dEdxNHFleFJsdWdUbHpGL0JLM3crWXB4QXVmTWxYRjlOWmk5ZXFCWnRuRU1F?=
 =?utf-8?B?RDJJT1RseURvYjQrYTcwbmJyV09FeE5zOFB3K2tWdjBtMVg5T0xrK0lmV3hq?=
 =?utf-8?B?Q3RnOFplRDAzZEJPZUFaQ09YVWhmS0s3WWZ4eVhrWCtBT0w0RWFpNEV6YUJL?=
 =?utf-8?Q?CNO11VLVurkttKPVqPjqut1jB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b257a16-5034-4cfc-653d-08ddeba4ed9f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:19:35.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l30grPXs5bEV/IC/IkCXMpnv4qAC9toykEo1tiot7hGgbRBFXkJ01/6XoiglfvUNHexCpmbjN05aDijRiwGWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160


On 03/09/25 10:31, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
>
>
> +Sumit
>
> On 02-09-25, 12:21, Aaron Kling wrote:
>> On Mon, Sep 1, 2025 at 12:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 31-08-25, 22:33, Aaron Kling via B4 Relay wrote:
>>>> +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
>>>> +{
>>>> +     struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>>>> +     struct dev_pm_opp *opp;
>>>> +     struct device *dev;
>>>> +     int ret;
>>>> +
>>>> +     dev = get_cpu_device(policy->cpu);
>>>> +     if (!dev)
>>>> +             return -ENODEV;
>>>> +
>>>> +     opp = dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
>>>> +     if (IS_ERR(opp))
>>>> +             return PTR_ERR(opp);
>>>> +
>>>> +     ret = dev_pm_opp_set_opp(dev, opp);
>>> Won't it be easier to use dev_pm_opp_set_rate() instead ?
>> I'm not very familiar with the opp system. If I read correctly,
>> dev_pm_opp_set_rate() will round to the closest rate while this code
>> will fail if the exact rate isn't found. This code is based on the
>> existing tegra194-cpufreq driver. And I'm unsure if this was done for
>> a reason.
> Sumit, any explanation for this ?

dev_pm_opp_set_rate() is additionally checking clock. In Tegra194/234
the clock is handled by BPMP-FW and CPU nodes don't have clocks property.
So, the clk_round_rate() API causes NULL pointer. I see same in 
Tegra186/194 dtsi.
Tegra210 and previous SoCs have clocks property in CPU node.

Thank you,
Sumit Gupta


>> I have seen unexpected rates returned from clk_round_rate in
>> the development of this topic, so that could be related.
> Right, but we should end up configuring a valid rate from the OPP
> table.
>
>>>> +static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>>>> +                                         struct cpufreq_frequency_table *bpmp_lut,
>>>> +                                         struct cpufreq_frequency_table **opp_table)
>>>> +{
>>>> +     struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>>>> +     struct cpufreq_frequency_table *freq_table = NULL;
>>>> +     struct cpufreq_frequency_table *pos;
>>>> +     struct device *cpu_dev;
>>>> +     struct dev_pm_opp *opp;
>>>> +     unsigned long rate;
>>>> +     int ret, max_opps;
>>>> +     int j = 0;
>>>> +
>>>> +     cpu_dev = get_cpu_device(policy->cpu);
>>>> +     if (!cpu_dev) {
>>>> +             pr_err("%s: failed to get cpu%d device\n", __func__, policy->cpu);
>>>> +             return -ENODEV;
>>>> +     }
>>>> +
>>>> +     /* Initialize OPP table mentioned in operating-points-v2 property in DT */
>>>> +     ret = dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
>>>> +     if (!ret) {
>>> If you handle the error case here, then the below can move out of the
>>> if/else block.
>> I'd prefer not to deviate too much from the tegra194-cpufreq code this
>> is based on, so the drivers can be more easily kept in parity to each
>> other.
> I am not sure if that is really important here. The kernel normally
> contains code in this format:
>
> if (err)
>          return;
>
> keep-working;
>
> If you want both the drivers to have similar code, then maybe that
> code should be moved to another file and used by both. But we
> shouldn't keep them same when we feel that we can do better.
>
>> But I will look at making this a bit cleaner as per this and
>> the next comment.
> Thanks.
>
>>>> +             max_opps = dev_pm_opp_get_opp_count(cpu_dev);
>>>> +             if (max_opps <= 0) {
>>>> +                     dev_err(cpu_dev, "Failed to add OPPs\n");
>>>> +                     return max_opps;
>>>> +             }
>>>> +
>>>> +             /* Disable all opps and cross-validate against LUT later */
>>>> +             for (rate = 0; ; rate++) {
>>> Maybe using while(1) would be more readable ?
>>>
>>>> +                     opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>>>> +                     if (IS_ERR(opp))
>>>> +                             break;
>>>> +
>>>> +                     dev_pm_opp_put(opp);
>>>> +                     dev_pm_opp_disable(cpu_dev, rate);
>>>> +             }
>>>> +     } else {
>>>> +             dev_err(cpu_dev, "Invalid or empty opp table in device tree\n");
>>>> +             data->icc_dram_bw_scaling = false;
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
>>>> +     if (!freq_table)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     /*
>>>> +      * Cross check the frequencies from BPMP-FW LUT against the OPP's present in DT.
>>>> +      * Enable only those DT OPP's which are present in LUT also.
>>>> +      */
>>>> +     cpufreq_for_each_valid_entry(pos, bpmp_lut) {
>>>> +             opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * KHZ, false);
>>>> +             if (IS_ERR(opp))
>>>> +                     continue;
>>>> +
>>>> +             dev_pm_opp_put(opp);
>>>> +
>>>> +             ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
>>>> +             if (ret < 0)
>>>> +                     return ret;
>>>> +
>>>> +             freq_table[j].driver_data = pos->driver_data;
>>>> +             freq_table[j].frequency = pos->frequency;
>>>> +             j++;
>>>> +     }
>>>> +
>>>> +     freq_table[j].driver_data = pos->driver_data;
>>>> +     freq_table[j].frequency = CPUFREQ_TABLE_END;
>>>> +
>>>> +     *opp_table = &freq_table[0];
>>>> +
>>>> +     dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
>>>> +
>>>> +     tegra_cpufreq_set_bw(policy, freq_table[j - 1].frequency);
>>> Maybe a comment on why exactly you are changing the freq here ?
> I meant bandwidth here.
>
>> To my knowledge, this does not change any clocks. The intent here is
>> to prime the interconnect data. In the pre-req series, there's a
>> change that sets all clocks to max frequency during probe. Then my use
>> case involves setting performance governor by default on some boots.
>> During testing, I noticed that the interconnect data provided by this
>> driver was all zeroes. Which led me to notice that set_bw is only
>> called when the target frequency changes. Which wasn't happening
>> because clocks were already set to max. If my understanding here is
>> wrong or there's a better way to handle this, I will fix it.
> There are a lot of synchronization issues here because we are trying
> to set clk and bw separately. I guess other variables, like regulator,
> level, etc. (if used) will also be out of sync here.
>
> I think the right way to fix this would be to call set-opp for the
> device, so all the variables are configured properly.
>
> --
> viresh

