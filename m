Return-Path: <linux-pm+bounces-38850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A84C90977
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 252CC343644
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA60273D6F;
	Fri, 28 Nov 2025 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KeIa1lbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8226FD86;
	Fri, 28 Nov 2025 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295917; cv=fail; b=DgOLf7CmWvM7sAhz2KPa0OVFDLQH3vSy6STRZup95YkmDTcLWZxIVxZ+Maj8YkqnowK0lNwg9JGn0Gd119gxfXJu1DgGkNdGK9DCUwzEnkQ98QE6onJG9DN0IxxHp9+mBy+j8xxHsYhM9LEYXdDaM7bbaI4XO2tDzCJexTVUgJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295917; c=relaxed/simple;
	bh=HyYlm9tMddocBa9zhzwC5KDiV8ER81V+JWBZ1DYR1tk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iBDD/9fRembpe5fEls512XyYGlDIRoYvj+Vnr5EGXFDGu6JX5mtWxb83OESMCRWI3kba5Y6oRHmqq2etNebSlONOwxLgluN8WUhXripBhq+MstA33T8MV5uYzpFQibbKHAC5RUNDb4KKFt6v9NpdI4faKP5UEPaaFvRmE34WSrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KeIa1lbT; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyKqkk+epyb3AAIEML1WxgVM8cavnMkYGewgvyvRXmEHTmsMBBJsAxs44As4AQwT27FoIWD2EOXeSdC4SUnZ6cyjhBn5xYMB8Lsotaf8mPQaAsPg90HJC2q6sCRgcO6z7I2GG2PTqS1QOeynu24R9x4PnymZHI7FpwPkQzJQTyfATLATfpOXaPnmBTobZ00OokcuRxfuEiJ7Dp0vEHUIifptsmOFjV5QVEpctZiwSDkousDqV4gMCAke88rzkGc2LU/+xYkgNpj21C2g3i0a2Svlvt3oIN5taMmuE7YpDiIUUdhGHXg3DUzKSWKvjcJxjh62lE1Via7ezcAwTX7+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OGeC8vZ6/8hbxtcjKUxGJIrXtZrtJ+kbfVvR4EtkBI=;
 b=MH5aKWYGSScigrRT0mloR5hSRNBvVQl9lgIk+NMtLV2LJVX+TjM+cabdi1r5AkVBIBJYZVZxieAqgiesN15FLnvXmWKHhxXBXjTv0yUrG4mB0Rth9optG5uxd9UHHJW3Upe4gefeOblvqY8mB/MCElNYaFNMoFUV10nV91B1Tvse68vaqiEXfvs+ajyemAT1U9oTJkwkZyyud9ALs2wXmLFK5rW0twHc/Jxhm74xuGDk8rqmzRps+EImM9xrfIULU4YGmTKCS6Dse/NpXrE1r6Ig6DuKsJsDS6kIOZ+YYSm10tlvYSi5tFZFOENfairAyTgQ9RKGXklPUXyKdrJyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OGeC8vZ6/8hbxtcjKUxGJIrXtZrtJ+kbfVvR4EtkBI=;
 b=KeIa1lbTDMJYbwBV0yiwTzxlNm+dgMgzffee8+Bnf2s9o7jXeFMLndPMK16ymi85S5/C8T3rJHAopU9mrHe9lSukuV5vk9I2TQ6cnUs1WQD5ovlntrAIRab7zdwUO3XFxRb25uAHiSS4UKMzLs6AooJkzJFR1DHo074DqP68Z94dVlRgWb3F3f/pJRV+eV22jLUArVKrB4tK9U/ZHDWyUouS2Jh3LYw4AVI1zWVjOZj/dvrAKR2MxFXYDQy1bfsjVT6ell21Ezq6S06HQk2EcZf6e7sTsUJvxbpJuoj6KQembFKovk2vV4E2OgTnvYBy4o4FzHSYZqe4bn13NPPx4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:11:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:11:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:37 +0900
Subject: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCPR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:4::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bcd419-d89d-4f87-14ce-08de2e237f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2kzd1dIVklVYmJoWkZjWnJqZ1kzVmlsYVB0YzVUTFZYSXZpRU1BcnFYWkM5?=
 =?utf-8?B?UzQ5MHYwL3dDcnB0WkxTTDV6NzZFdGVaTkdKTzRYR1ExL3JzUVY4M0pXdjJm?=
 =?utf-8?B?NFI5WjRvMlFZekF0Uy8xdjM4WlZOeWFwaWh3RVY0K0NGSnM5TzJ6eERPRXJR?=
 =?utf-8?B?MlNGQzUvWis0VFBWU2U0VGloaXRuUVkyRnFOOXA5ZjVJbitpQjlnczJrTXRU?=
 =?utf-8?B?YnpmY2xGV05xR21OR0ZKZVplTi90YndCcDVYaVlrR1JvcVVrYU5NU0N0R3Nt?=
 =?utf-8?B?UW5TR2tIOXpHV2RQZVUvOE1Gbjdjb25hVWhSUy9wTWQyeGh1NEMyWWhTZmpz?=
 =?utf-8?B?M0pvT3NYNkY0R1hEN2RQd2MrcDVTTjJpZ29xTXYrU1Z2SExXSjR2Mk9rbkFz?=
 =?utf-8?B?TS90S1NmcEYyYnVQNm1LUldDbVNHUzZBNkNia1dNT3ladUlveklXU0dIYTdl?=
 =?utf-8?B?Ny9sS2tFb25md3p1MHlCeGhQbGw1bGRpWW9VYktheVYwTXh5RmQweWhJc1BI?=
 =?utf-8?B?UGZiVGE0aFBpWjRoUXFSZk9aS1kzR0Z3elhLKzFiR3BLSTBEeFowdzFVVGpP?=
 =?utf-8?B?cWtDaGtXaDRyU21IQTUzMmFabUQ2VlpLMm9aMURLZTRRODgxdjJuMEtNZ2dv?=
 =?utf-8?B?ZmxuYUdrVlQza2ovdlJmQnplK1FIclc3L1IzOUVqRHE5a21Zb1NlV0JzQTB4?=
 =?utf-8?B?bW5NWHRMR3FxWVk5QlJBSkZTVnFXclI2VkIveUp4Y3lHMlE3SXRaTUVicWs2?=
 =?utf-8?B?NklGZS9FK2tuTThFUUE4ZXdQdVBxWmk1c2loY2RBRlVpVFBGZGkxL1BjZU10?=
 =?utf-8?B?Q1J1WXlKdGd3dzdDM0QxbWJvQklGYjcrL20reEVXZk9UQXV4dDR0c0hYb0ND?=
 =?utf-8?B?aWt1bkZzNnRCMFhkcTQyMURHc3JrdlhIUjh4dFo5VWNOZWZRSkpuVFBUWThp?=
 =?utf-8?B?bWt1NjVLeVlPVlp3cjRsVDdYalhtMzBhdSt2aWlUcXgxUmRBdFUyN2IwSXRL?=
 =?utf-8?B?UG1YWThEUHRvRW45SXE2WTI4ZGc1MURLdzNTWm1zN24yM1FabytWblhmanFT?=
 =?utf-8?B?VjVOREhyQ29pNG84Y3I3VkhrNjdCZEtMOEJZSFR4Z0xrQWlmN3BlbEdwODdj?=
 =?utf-8?B?MEJQQnFXT3grRmpQUDY3c1dteUUyTGdmYWx0MENmUXVRTXVXc0JTM3VRUDVZ?=
 =?utf-8?B?Q0xjQjYvekkrNGxBVGFEZS8wUUxTcUVwTlBoa3NvbW9LdGxYSVZTRVFZbThu?=
 =?utf-8?B?SjhSeEVJc0JMbENMNTZ0cFFYSzVCTkMybXlaTllKdUtaUXlJRm82dVdjSmVV?=
 =?utf-8?B?OFZ2Y1lhTW1uMWJqc2JnV1lXbVZhK0VpNUJic1k3VW9wVHdKT3N1T0lGMHNs?=
 =?utf-8?B?OWNvanFOOVNTZGU0VGtBdTFtbVZIN2NRRkpkckFnOXBrenhWL2FUcFg0UXV6?=
 =?utf-8?B?NWg5MVlwaEZxVTlPc1I4d1Z3bExCc2s1eEgyUFh5K1pkNjFLWHN1VHlNdTRs?=
 =?utf-8?B?ZUdRV0RHRG55bnhIRTFkSzFJQmVtSGR5c3JOWnRwMk5iN2xhcGlJTVM2N3lW?=
 =?utf-8?B?Qm8zTlk1VVVIMDRHTWVCRG5iSDlraGlLVWd6cjNOUWNORlJQMEVvM082bHJq?=
 =?utf-8?B?eEcxVk1aQS9NV1F1UENhcmhMZEpFR0dNa0NzVUlCVm1naXVnTHhOeEJrRG5L?=
 =?utf-8?B?SmFPdW41Y2kzbFBzUlRJU2c3S28vWWtWaEhpZVBwRW9lOU9FbUdNZUVReGdO?=
 =?utf-8?B?UndaT1hDVGIzZ1gyelptMSs3RFBuRlRPZUZxeFE2S0xOcXJxUHVFSDZWdDZi?=
 =?utf-8?B?NUlhcjhlMm5BM21wb084VElhOFU5OFN2N1BUYzFkWGlWeWV0YmtaS1gxYjM3?=
 =?utf-8?B?ZGRSM1FpSDljVUVwdzBhV0hkR0orcGNzNHZYb21ZZVRQVUZSMEh3TnZpQkxm?=
 =?utf-8?B?V0JLMnAwMnFucGh3eXpIL0hjR2VlVTFudnZMcCtqUUNOekIvSEZkYndHbXpl?=
 =?utf-8?Q?4XnMJJRccbkh7dwFj8UPAbNlsTj+YU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZiTFNrZTZFT1l5WnBpQXhTZk1INDZmY0IvdzRLaU1LZVlRS2UyYUJOaWhU?=
 =?utf-8?B?QXlZZnRxZHNyY3FvN2dmRHpoQmc2bTkwOGlzUkJpb1pRc1ZJeG5Vajc2L1FP?=
 =?utf-8?B?YS9tSHY3d0xjMTQwQklGODlQOWszQlFWdmlVVGRKMDFzMUxjWEQ3RnZuYWhy?=
 =?utf-8?B?OE9aUFllOEVucXVXT3REcTFjVXVBTjhFZkgzSUgvbWo4S1VueTVXS0FvSDZK?=
 =?utf-8?B?TnhkY29XMzFyd1lQejFRZTNLUHBKWUF1NXlBandJbGdYUldrRmc2NWd3Wk0z?=
 =?utf-8?B?MTdrS2k2NU9DcDZBdkJKdHlxUUlYQVBvTi9DdEVxbFdpZG1pbmNtbnVDVURG?=
 =?utf-8?B?anJLVkw2ZWxUaEh4VGx5WEtRRVc5ODZkTGoxT0piZ3RJdjZqcTJCN0N4S0g4?=
 =?utf-8?B?YlIwcm5WZTVLT3FEMVNLelhVN0xSOU5SaHJucGFsYWhicHZlYkdqcTF4aTE3?=
 =?utf-8?B?SjhTeDVXTWVnYkx1elNXaTEyWmdZTSs5QllDRHg0NzcyODZ1bSs1TU9Cb0o2?=
 =?utf-8?B?TVlOMFYwTVV1V2RQdnUrMTY1WTk5NzIxU3MyRUY4VnJZWEVSbzhkT2ZQZUVZ?=
 =?utf-8?B?UFB6b05GTURyc0NEcUlDTGZHNGZ6ME1nWWhkTTZDcXc2eCs2K204MmVnMHhY?=
 =?utf-8?B?d0lGejc3MEFvaXlYemxyblBoeGxubitlaGcvWU1aMS9oT2w3M1Exc1JHMndK?=
 =?utf-8?B?ZUthTlRubWxlQlN0U0RkZVdYRk5NeFBya3pXNjNjOUdKTytVT3ZKVi96ZUcz?=
 =?utf-8?B?VFprR1QxNnk1dEcwZ2dXdERkazhTSWRDN0lKbUNLSlQ2eGpEZTgzUUQwR0Vv?=
 =?utf-8?B?dUVFYlZqYWJXRVZDREROc3N4RERWTFBnQk5WUGpHSHVjNmxZV216dDgzTHlM?=
 =?utf-8?B?RHVBelNmRHBkUXlsdmtWd2xZQVd5NE8vSFBacEdrNlVYOGZDTmFqZlZLY0VD?=
 =?utf-8?B?b1VEc0ZJMWZadVdKRE1xcEZBcFBLNU95ZkVMenpVTm03R0U4N3BGMEthNlJq?=
 =?utf-8?B?WkZuRUdmV3NVVzA0ekJCdlNIdi9NQTg0bnFsVTVVWWt2REs1NTlEWk0wOGd3?=
 =?utf-8?B?Y2IyS2hodUpJYnovVXJvWFZ5RkQ0N0N0Z3BtMjg2TmowZEtJenB2alBLNDZE?=
 =?utf-8?B?YlhsdDhOUkxGWHUwMTVRNU1BcWg3WHhETkpuUWJKL3VBSXFiQTdMaUNCNDdW?=
 =?utf-8?B?UmhtbnpwRTJoNEpxaUh4TlNtSHJJMlRIMlRmV3JOVTF2QWtBbHErUHc5K2h5?=
 =?utf-8?B?M3VHK2ZPUjZiRXBGNWp4ZWpjbjRqZzlOYmR4ODZtbkphMEQzcU0vRFFnMTBF?=
 =?utf-8?B?RURPcE5iUmh3TUtqekNudzJFaVd5MGVZZ3FvVHR1c1J1RVE4SHV3M3doZ2Nq?=
 =?utf-8?B?WWVkSnZaSmZ0eFFaRTA5eWZrT0xKdGg4YWNINnlDM2R0WFArNmFGK2QwYXlI?=
 =?utf-8?B?Z1Y1WHlWU0xFVWVJMlVXWkJnOGIwZmVYNVd2SmdtRTBIUkdzS1V5bTRHVVN2?=
 =?utf-8?B?aEpKbktUbXdud2U0dHpQempZbDZMNG1hTmdKZ0RXWjFhdVBRaGZrek1oTnJE?=
 =?utf-8?B?SkFLSzA2VFkvUjVPT1FncC80Y2p3aWVyK0ZHd04rNmxHUFRHTTRHMThOeEI0?=
 =?utf-8?B?TDgvckZ2WkZ4UWhjR2FCS1ArV2NsNDZnQWlHK0F3cWh5VXB0blNGVHNkT0Rm?=
 =?utf-8?B?bEFoejN6MzcyUkNEeCtzNlZpbUFldVIwWjY5T05kY1BIQS9lM3djS3dRVllL?=
 =?utf-8?B?dnNIUzZvMXZtQWU2K1FTckFNbVA2akxMd1FNTE93Q1pURG90UEhjNVJhY1Nj?=
 =?utf-8?B?ZGpHL0JrSVJxNWZGZkFKLzJ6ejlrbFJ1YnUrQmQ5WWVDOUFSVHpnZ0ZUWUhW?=
 =?utf-8?B?RXh2bW41NXJsY3VuR3gxNmpHVkxCcXdaaTVDTCt3M3B6dnR0WjZQQlM2Z2k0?=
 =?utf-8?B?bXRRVzErMVIxT0J1RStqc0E2a2c5ODN2cm1PMDhVRkhDWW1PQmpDV2pDbXlE?=
 =?utf-8?B?RGlCVCtZNko5Y0JVdHJxMk9aVXVQc0g4MEdXaWpPN2JHeDFHOTFzcEV5YXdR?=
 =?utf-8?B?bWVoajlzSGR3S0MyTFBIUmJKUmVLdlJ1Mm1KOXlnT2pueW5DVjkxS3UvWDFa?=
 =?utf-8?B?ditsTEpRK1RKYXFnZng5Mys3S1RZclBMbDBSeHBtQzNJUVg4SVBUclJORFMz?=
 =?utf-8?Q?U6WEdVHRHAACTSjeyuvgHCGFQrv9koDWth1RsNw84xpJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bcd419-d89d-4f87-14ce-08de2e237f7c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:11:53.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFlzCnJyd8bbyGw7d1IK+cH2M2ejuGCMbfABy8/WkjBaBCEKb/RHIHWiMez6xkIxej6Q6jm6e6y3XRogh2P9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path,
lest build fails with the dreaded error:

    ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!

It has been observed that very trivial code performing I/O accesses
(sometimes even using an immediate value) would seemingly randomly fail
with this error whenever `CLIPPY=1` was set. The same behavior was also
observed until different, very similar conditions [1][2].

The cause appears to be that the failing function is eventually using
`build_assert` with its argument, but is only annotated with
`#[inline]`. This gives the compiler freedom to not inline the function,
which it notably did when Clippy was active, triggering the error.

The fix is to annotate functions passing their argument to
`build_assert` with `#[inline(always)]`, telling the compiler to be as
aggressive as possible with their inlining. This is also the correct
behavior as inlining is mandatory for correct behavior in these cases.

Add a paragraph instructing to annotate such functions with
`#[inline(always)]` in `build_assert`'s documentation, and split its
example to illustrate.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/build_assert.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
index 6331b15d7c4d..f8124dbc663f 100644
--- a/rust/kernel/build_assert.rs
+++ b/rust/kernel/build_assert.rs
@@ -61,8 +61,13 @@ macro_rules! build_error {
 ///     build_assert!(N > 1); // Build-time check
 ///     assert!(N > 1); // Run-time check
 /// }
+/// ```
 ///
-/// #[inline]
+/// When a condition depends on a function argument, the function must be annotated with
+/// `#[inline(always)]`. Without this attribute, the compiler may choose to not inline the
+/// function, preventing it from optimizing out the error path.
+/// ```
+/// #[inline(always)]
 /// fn bar(n: usize) {
 ///     // `static_assert!(n > 1);` is not allowed
 ///     build_assert!(n > 1); // Build-time check

-- 
2.52.0


