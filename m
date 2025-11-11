Return-Path: <linux-pm+bounces-37777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D152C4C804
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 10:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AD218903C1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC021CC59;
	Tue, 11 Nov 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQpeFS2V"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388034D3AA;
	Tue, 11 Nov 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851653; cv=fail; b=rfcx3UDmWaIk4SUQQ5hLEpPqj9Iv2PUhKZb6QkdTFSWcNZtdpjEOTAkNUPb/JwcL09HbShfTgiw0uQz75F577yjlh8ZyzFzn4o9lvIW16X6D0NZ9fopycCVUX4Vd5n1ORcy/0+sK+uUVU5j/vvkO/qx1knTvhxM8R35rvCfU/Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851653; c=relaxed/simple;
	bh=Df6pkjhczxwOnHcGkoebgZHhAMQsbUIJPwQNtin6AoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LnlOy0rTs+w7LdckdRRtYwIonqsmdSCvIWjk4sGIm9oariSf9YOqjUM3FBJFVhoLgwheLtwtLznvhCN9FaQaWtQ/hnyapvE3WvoJfvrwq2Rh3sJCHeBt5n+kUZsMrGbGncNChXdew660wd0yQpWu3XQUl8ZkNEBToonI0ILT9Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQpeFS2V; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDcRy0lRE50mWEFfFd0bbB+TKn8nCWaxzhXzXNh3pyIFhrnVJZkwdXBLrqBigoTa92ORQ06B7F3nD1tIzRBKlCARDFedgRouNxMjdU1kgpJfq2CIYVq2W53tfy9YNW8pyZZINR01AH2f3irgdUm0W10DDc9TuHHfzeVflMQJ14bjg/TrfOaioWLtJiHvIioZJ5QfZMJVS6JlVw6qIaX/XHvr7Ydwu8Hsue9bEQYXs/UiJYlM6Z6WjNj4bW06+XJH35XEsttVsxkFp1dC6pB8gY/oUXbeJpX7gbkACG8L4FWlwVcZfJpA7YEg31f+9mOToz/F1bVjZxw2LXgpQpAUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AumZJ8sXS8gzx8QYUd4XulpbjlWl40XL8ApI4yhCs/8=;
 b=nUxV0ZBpra5OXIygZ6ga4WYqjbfjTkDzjVpd71q1zmpZTWDTZqCYvutesRqZ8vyGcGW47OEKvq77W7E6KCmiMfeFl3c9TWeIKHvsNPLXe80sEsm5KSrZv7bnfRwt9Jq2uSSi0W4KDIORNyXGSZ+HcxT71dokubDd3e4cH5kLtQVb6BuvzmQS/STNu1immXuMvlyZxS3AizYxrlO/6t3r3jMsoJ7J7EEstwXJwSYPW3PDeCi4DMrPJAIHH6BLPiz6Wz9N2w7uslD1BKKTAi7vYGycUZPo4w1QiBE80ra4LbymCZNmiCT+yirWy8zpo+VTyC7zyEgPwx0Lu9OdY9cDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AumZJ8sXS8gzx8QYUd4XulpbjlWl40XL8ApI4yhCs/8=;
 b=DQpeFS2Vu2bMtN3JRvgiYsHvT0UyYWGTRQVcObVH4fGOU2VmQ+FIypfw9XoKT+x4WWrcPUPiGe2/HI8AhPmoD60jDYCv21e6SHFJPFrLHRSCygQK9vNBo5lLXmn/M3M96X89W6fPh6GzTllq0ij7RkIi+R9A+K6fPKm1rkBu6iDBZLoSK0yAkEQRG1nx5xfY0MCcl+HM464Gym2ecovq1dnIQ+L8k5J/Cq3z9+ZhCgIU5yQqs3Vj+HWJaYqJjv6CfTDIM7aSdSukdoMrJjmCIg+ha1AuGWKdV+8Jl2vv5bZObLGUiNt3/MPAfCzd9cn87MuPyGOdYDHWBd2yh/GK9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 09:00:48 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:00:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 02/11] ARM: tegra: Add ACTMON node to Tegra114 device tree
Date: Tue, 11 Nov 2025 18:00:44 +0900
Message-ID: <8678078.T7Z3S40VBb@senjougahara>
In-Reply-To: <20250915080157.28195-3-clamor95@gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-3-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe8367f-7f0f-4de6-852b-08de2100ce58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2xHeXMzd1BRRFpWWUZsNzZMQkFKakJWalNTMTF1cXNWUmtDVDZ6eGhiMm1M?=
 =?utf-8?B?Qm9meVpFT0NFODdFU0hYSlZ2TjJTSHB0bDZYSGhZWTdoUEZzek9pQitxdUZT?=
 =?utf-8?B?Zm13TWRldVU2eWNkY3B1VzlFMXpIQVBHclFKd0hHTGw0SEhoVER4dlhNbURW?=
 =?utf-8?B?NkZWVkI2WE1qRTBERDFremVjbHQ4MmVyTlZNSzBDZzYzZzdsRUM5WHQzVXM2?=
 =?utf-8?B?OXBwSGh5dzZVMUN5R0tFTnpwc1Z3dlBYZ05GS3ZZVkIwRXdWNXRrL3RqclFz?=
 =?utf-8?B?WTVtUXdRWDVWYnlTcE5VWmlzdVUvWmNNd0hQTngrZ3FDdjRFWjQvL3NITm9o?=
 =?utf-8?B?NW1RS0ZBR2x4RGh5MlJVUCtrUFVBMVpNcWNwTFh6NGVzNUpqM0h1VVF1YjhU?=
 =?utf-8?B?aUxEU3MzZ2J1UURlSFd6MStnNkdvdEtNcmlKdG5VNlp2M2ltWnJac3Nmd1h0?=
 =?utf-8?B?TGtidWIyVWVnK2t6M3Nkem92L0hqM0dmcmFsRGxqTTdOdEFHT1FMT1E0bUVn?=
 =?utf-8?B?Ulh0aTByUTl5bHYyUUhpV2kzOVFaRTdZUlh2MlJoODgxdWhiQ0hBZGFIWlds?=
 =?utf-8?B?UERwQitDeVI3aUliUXhXK05DaDh6bTdRMWE4ajA2NUNrV05TNGZLUUt0ZU1m?=
 =?utf-8?B?bmdwM0FlaVB2WnAyR2VsTXNWekpqYnl2TXE1RmpQc2MyQ2lvdzlRK3ZOeVBw?=
 =?utf-8?B?Zm5VWEZicjQ1c3Y1eHlqdVlBWG43MkZiMXpMeVhCS1ArRzlveVMrTE4ySk02?=
 =?utf-8?B?eFNBWENXODB3UURFSkl5RzVVS3dTNkR6VEJNcy90blFuMldZYzFUd1FhZldU?=
 =?utf-8?B?M2JPV0NubGN0OCtQUC9JbFRMNWRscnNrUkkzbTR1alRablFtSVcrVWNJUEFC?=
 =?utf-8?B?T3hsdXZMaVUwSEh3cmxYYnlIbmhRK1E2aGxlL1RxKzdVVTZWNFVqeWM0RnpF?=
 =?utf-8?B?bUdiVit4aGZRMUMyQTRnTTRSVlRJSjZxVXA4bkZ4QWZNL3JrL0hPTGQ2ODAy?=
 =?utf-8?B?aE9OVnBKLytwVnVQZ0RoSE9SNUtuRzdBS1F5S2NzLzBMMm9tK20rN2UxbFlm?=
 =?utf-8?B?VnNQSDBYb01qRzdobldjMnFabEt5cEJhb256NWU0SUdnNHM4SVZnMWYzSDJj?=
 =?utf-8?B?cFhaT3dsSkI5YjVUUC8rUkNkT1YzYWFRRE4yUFkvVlNSbGNZdVRDM1IzK3Vn?=
 =?utf-8?B?ZzdaM1NIQld0cXBkcDM0YzhacVQ4VHBOMkp3N0ZaNjFHc01GUFpGUXVuTjdo?=
 =?utf-8?B?Z1Z5RW1Dd3owRjRmdHoyRzBGMHpoTmdWVCsvaEdqYmZ3OHUybG56bWZlME05?=
 =?utf-8?B?RmkvZm9HcmZXNUxlVHZ0ZHhRVnFUbnpQd0JTbUFSTndrSUpkTm5sNkV5OVBi?=
 =?utf-8?B?dm9QTmkxcW9KSzQ0T3RobHRHcmM1cFBVWmZmZ05hb09RaFI1UXJkeFJiNERq?=
 =?utf-8?B?YTBGV0J5UkxUQS9rbEdFWVV2aHYzRDVIRWlYbEFYNUIxRml5YjhKTUFPczRW?=
 =?utf-8?B?THp0TjlESS8vamV4RzU5Z0FLaHREaHA4MHVlWXViMEMrV3BrMUdzSlZvKzJr?=
 =?utf-8?B?YXlBcTR0MTBNeGhWV3N1Z1p5N05nc1VBUkpCQ0llNXl5b1BCOVNQWHRTQTg5?=
 =?utf-8?B?RG9pd3BrRDBDeDhPcGgvY1VIK1p6c0VBN1R4dTZncnEvWkw0ZnRuTjNWOTB2?=
 =?utf-8?B?SlVLdWtYL0lmYk9pZGQxMnVtNGgrLzlsYkI5bmlNb0tRRTUySFlkV2VhNEd0?=
 =?utf-8?B?NndtaHZVbGExb3ZZVGplOG53UDArcktwMld3b3FnMEk1ZjR6emVKS3A1STFj?=
 =?utf-8?B?amt2cjYzckZWOG5tSUFSdkpUTUIrUzVZVzNMbWJlYk10VHlOWEluT1kxZlQx?=
 =?utf-8?B?dUw0K2JmOW5BOS9HS211TG9kb20rQ1NibUMvM3pOaDZhaDJESUNiYVZJaER3?=
 =?utf-8?B?NFVGajcvb2tIZm5DaitkdVVvN0dTNnV4eG5manFMQW5BVEo5Rnh0K1ZjQTF3?=
 =?utf-8?Q?YI5UUjYmAwPpOxTLIlQTHZmI8k2xQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJxWkZ6M3AyQmFUUlpjYVhlQVVEdWw5SG1kVGhIUWR0azAvdXBlcXlpaTht?=
 =?utf-8?B?bkNxR3RqN00reG52MlBqbGliWGFxcVdJVHI2OGxlOWJPYlNxNWNUMnhhdjRL?=
 =?utf-8?B?cnRYWXU4Q3Q4akZGSWdmTjRBZ0poOGJpdGpDUUZLN0QrSU4wMWV5SXFDd2lz?=
 =?utf-8?B?aU5wMlRLMUhjUHV0dktvYWlWa1Y1cmpib3Q1SWFMU1NrSk9oQWs5dHZ5cm5I?=
 =?utf-8?B?NDJKNmtpUzkzbnpjN1B2SU95UmsvaXF6ZEJqVHd1V2FKc0YxbTZCSkxLTklQ?=
 =?utf-8?B?ZXRtR2RhTHEvLzRUZ1ZKai9YeUVYalFONzJBZmxJZWZiRUY5Mm41TXZnS2NZ?=
 =?utf-8?B?KzE2T1MvMU9qNEJ4Z3lSTDlJdXRoQzJzblBtQzg3UTljZlBwdXArdGJlOXJR?=
 =?utf-8?B?RUVPdEFOOTM5QktkZmEwaHhWbWw3Q3JrTGVqc2hTUEY5d2dIWXl3Tk0rZWw1?=
 =?utf-8?B?a0JXR25BNkhmUWV2aGlSd0RFeTBKMjdDb2lJOUhQSDdjell5eXFCU3NFdmtt?=
 =?utf-8?B?c2xGSlhhazIzMWEvQjM2NTJxeWNPYXRNSlZ3QUpVR3JLQjlmWEM5Q2Jmam9W?=
 =?utf-8?B?Q29pL3RzWVF2VUhDU0V4VmR6Rk0rWlcvbm9WZGpOUG9helhxTnFLUWdLU1la?=
 =?utf-8?B?dEJVMUFTdGZyVHVsOE1YS2s2Zzc4ekJKd2dIZVV1ZnR3bTRGUWl0VEtMd1Zs?=
 =?utf-8?B?aWdDVVJBR3kzSmdRQitieEdVRmw1dnpYbEpNZ2FKTFpjMk5WUjVNYVF0bXFm?=
 =?utf-8?B?NEpJLzg0Q1RPbWt4Q1NWNlh6L3NpOTY4L1oyVGF1K2F2N3kwa2VBZ0VIN3gr?=
 =?utf-8?B?Z3BDNE43QVMwVTVpN0RxdFd2VlVEakpZZHZNc1VCWEdzUFZlMjJwZXpvUGRs?=
 =?utf-8?B?eW1kMWNReWpQaVpRajJNaUlGUkNEU0gxcWxvV3Y4VlVQSGhLRGdheGdTL25G?=
 =?utf-8?B?VFBrRjBwdUFhRkQyWWx0ZzNJODRPbnN5aSs3eGJNcndhQ0ZObTdacXRwRUNl?=
 =?utf-8?B?eUlqWGpjSlRmS1pPZTNCZXhJdE1YdGxLKzdtaEViVW42SHprT2RZQ29OV0Qw?=
 =?utf-8?B?OENJYVV5QWF0NXA2NGRzQ3RaUzNwbldpbU8yamJhN2ZLcG8rdkNwOWVVSkJo?=
 =?utf-8?B?SlVQa01ENXpZeERsNFMyS2pUT0lEYnVHcnhlYXhsNHczT0dlNHcwdVhTZndx?=
 =?utf-8?B?WlpneG5lNCtEcnhETzNEOXJnMXgrRGdKZktNSmhrQWxmZEdQRGZyQ3ZiSEV0?=
 =?utf-8?B?Rng0ZWZXVy8vUC85UkczRmtTMFpkMHYvR2hIL2xWQlVGdFdJZjRjRzU5RG50?=
 =?utf-8?B?RzBOYU9zSE9iRFJNbE83czlFNGZHMWJZSVZmVVNadUtMWUttcGJEQ3NVOFJz?=
 =?utf-8?B?QVIvUHU3TWhCaUIyMXJmc0c2SnNnQ2wvVDRKV3B1bjNlakpEQWxncGc2NHRa?=
 =?utf-8?B?aDlGNWt5dkkrWlNVVmJBd0lCRWxMVlllZXQ3MjVoZ040ejhMNjBlaEl3Rlp6?=
 =?utf-8?B?MDBBOWFXNDhGZkZYcDhlcVNlYUloTTM2WkwyK3Rsb2hPUkJOTGV3UC9ITG9q?=
 =?utf-8?B?eklFS1NaNDRFR0tEQ1BvNFVnMUdlRnRkbDJGVU9tMGtUUUx2ME1MQ3ZIdGQw?=
 =?utf-8?B?RWsyU2dnYS81SktIQnJScGlwNnlJNjhycWtxL00wcE5RenRTZ3NpazhqRDJH?=
 =?utf-8?B?dTB2U1d2OVNva2VyekxENWlraTEzUDBRTHh1TDFhWjhzdkZMNWgwL3AxUVRW?=
 =?utf-8?B?ci94ODZVVzlsTGRJcVN5TmJodEp0UWRSS0x0Uk1aRDUrMHFZL0ZnaUc2eWRX?=
 =?utf-8?B?ZENia2F6eUNvVHlyZDJCbWgrVVFtNk9YZWQ3V1FqT1IvMzZEZWVweVMxOG4v?=
 =?utf-8?B?WThPZ1JZVHpkR2NKQ3JpMkJpK1NDc3p3dnR6TWk5SjlNNTVCakg1aGtzQzBj?=
 =?utf-8?B?UVFhR3dXV3ZaMzJocDA5SzIrRVU3NXZyT0hGa3pLb1BpQVdrcDExWk1SM3Bu?=
 =?utf-8?B?Q3M2M3JZMDlIblI4SnlIaFJaY2wvL0pLN2VBbEJvUWZOWGloQ092a28zdnB2?=
 =?utf-8?B?dDhnR3hieHY0TndJRVVkU2Y4QWUzcFVKRGpIN2pZL2gvc0prMjBWWlJpaDBW?=
 =?utf-8?B?SXlTNERIRU81azdvTXZkRFlsZEw4WHRBUmhKRlc0ZktWbm9OTlF2TEJYOEx5?=
 =?utf-8?B?SzBDRmVGWUdwYlRrSDVSdlpWVVdJdjFJQ2pHc014NjFkWXY0NDBrRndMT0Qz?=
 =?utf-8?B?SnprNVUrSXh4NlN4eDVla3VqVU1nPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe8367f-7f0f-4de6-852b-08de2100ce58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:00:48.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDHFX8X9IBqvOIVW+msdnjcWWcMTuHpPY3YzoankOMKPX6FLO5NQg2elGeKDvt7GtJkw0lFaR/YVfwby1XpHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add support for ACTMON on Tegra114. This is used to monitor activity from
> different components. Based on the collected statistics, the rate at whic=
h
> the external memory needs to be clocked can be derived.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/n=
vidia/tegra114.dtsi
> index 5e695431ad2e..08f81a3d11de 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -248,6 +248,18 @@ ahb: ahb@6000c000 {
>  		reg =3D <0x6000c000 0x150>;
>  	};
> =20
> +	actmon: actmon@6000c800 {
> +		compatible =3D "nvidia,tegra114-actmon";
> +		reg =3D <0x6000c800 0x400>;
> +		interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&tegra_car TEGRA114_CLK_ACTMON>,
> +			 <&tegra_car TEGRA114_CLK_EMC>;
> +		clock-names =3D "actmon", "emc";
> +		resets =3D <&tegra_car TEGRA114_CLK_ACTMON>;
> +		reset-names =3D "actmon";
> +		#cooling-cells =3D <2>;
> +	};
> +
>  	gpio: gpio@6000d000 {
>  		compatible =3D "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
>  		reg =3D <0x6000d000 0x1000>;
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




