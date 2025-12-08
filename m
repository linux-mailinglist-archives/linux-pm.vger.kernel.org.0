Return-Path: <linux-pm+bounces-39282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9BCABDFA
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18B63037175
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93DC2C0262;
	Mon,  8 Dec 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hmJsQeUV"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E552765D3;
	Mon,  8 Dec 2025 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162048; cv=fail; b=cktn4dnZ1ue9YTSyalWCSs+LW9YnFGeC6PCd4DoknZCpvIS9oJUWcWm/Pn7VN7D0x7qLMLgIrk3jNFDdFtD1X8ONC02dix7B8+ZuWdF58G8pSfqtE1DiFRxI34YGCdv3oWZ0tOMlqXCfGMlTQ7P/fQ1+MsnE1IEclI/IvPH1KJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162048; c=relaxed/simple;
	bh=bWbps+fRrxwUzrGjrXXtsa6mbflZkVUSscIdN1Fq27w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TzRnVsmWNxtcOymIy3M8K05iod5H2HifSp1NI7MKMUEwiOpRjZashQMy/5COj+ozp+VMyHhhiWWzpUO1D4WqYzqOLAdH/qNF9HYDuF/Se5EyqhMz12oUhbRSPT61ZXrOFEBepA0NL7WC6IgedbFtILK42MoOdmFJV5EQPhPCFxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hmJsQeUV; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYrsV4qt05J5DvfaNC4bTexChMKmmz3liKNqByRN4MR4m7oGYnZdt9g0Fv/pQX3gqlLtR4H0MQ7v4wnLqG+hNab+okOK5mlGW5volk6SfkO9RcHAUOAA8dKP9cTbvdOFmKKEbfAgMCqemVb62ALsrd7NbrpD3dFqaL4K/+oye7lKeqIjA/zclLMgWQc/EvKNWNNRrjtneUPhHuTtBSdYIDV5IxGzxgspC4zm8L32JTSVod6D3Y6iw52PdnVZFU8b/9TecjtrXOutaqe0dz6wA0zVHL3DpepsP4PQcrJ3NUqXmbkrGZb9CNwm9tvQhNnleaQVz0sqKK4X8hDv2sIPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTY2GLBiyIlt35cuMN3m6Ybn9CiTeqQ3Oz9UN7PmImo=;
 b=mtU78KCvJC8NpeTVN4/OigWVpXxcTc+3+aZu2KkuNtdUW93DQO/x+wWRscKO/cfG1gJXKVxCYr68lOPlkz68vCiZNF2hulIvgImxCv7AREqZYtYDSFvCKa2AH3Oh8SvsqvdGYSUUo2ZX7uk+2L/Qr5HSqicpAOAKW5vkh5R+qlEN0Uqs1AFMx8jLo3tlKPVQRGXbYtgVOOLkzfaQtCapU5S5aRRpo6xaqFMTfE26XIfdp9xrGu/gGKEbi0FARtZNSWN39cvbKlBvHUGoz0ehoxzI1rXQN5H4ZpzjKBTTv4jErtSpKGC8Gw5amWxyLT71wno7Kj8Yxs+QrDt+iurCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTY2GLBiyIlt35cuMN3m6Ybn9CiTeqQ3Oz9UN7PmImo=;
 b=hmJsQeUVExMynq+yYUena2fsYsdkr5WhcNgAaGRcOpApuyV/0mHRqQGmhavi6uqkMtg3iYU42eg932UNEkdEZi9I/1Wnvh9OVsj1+ILWFembKM7nelFmY4ZBwA6afvgh6rIRU9X5bN/8B+lnHfa85vdDdGF5zXvsEU7BFEm2urofl0KM9ARrlsFOc8BFKQ8f5X6sc4IvxtCEM51aQpSdjDJxWNsDPwUoVT9aNfgATGZg9EGbgRVKm2sxI1CqswzVA2vTVxtyjwN8LMG43//Ri7Und7sUu9L8kVV2IuFTUi53AUiPw2bMbKttzSI38hRgkqQsZwZWMgQbLYNfCfmK4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:47:01 +0900
Subject: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
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
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb32456-6daa-4640-cdc2-08de36041da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG9ZNzBjQk42TENwQ3VRUmFvZUd3a1R2dXFhVEo3ZXh6bGp0akMyU1MvRytC?=
 =?utf-8?B?V1V1L1RIZ21PMjU0MmZPaU5NcVRLTEhyTlB6S2Y0WlNMckkxVGZHWXRSdUt0?=
 =?utf-8?B?cmxhNXhYYlU4cWNzU1pCanpEeUx4U0hmZGpjRzNWbTJTeXREcFdmMHFwemN4?=
 =?utf-8?B?MkdCQVI5VEE2ZGRXeW1wZU5FYmVRdG00TUNqTGFzSHNxM2FManJ1eGVVaFpM?=
 =?utf-8?B?QWJrS1FrSzJNcFpDQkR6aFpQejNPSkx6OWd0NEZrdU5PV3RGZ0h2NE1SYUpZ?=
 =?utf-8?B?cVUwUXRaTDhjdGZIcGtNZU1LVlljWGd6WjJVOWhlWWUzMmlaMjYzbWpSRjU2?=
 =?utf-8?B?YVJrdWgvdXRPVStSeGU5SkNDWDh5Z3BrcEFHRVFUakZJcngyMURibjVCMVE5?=
 =?utf-8?B?S1QyaGI2U3JSVlQvNkcvZXVoU2xxbEhIOG1KQUwzb0t6M1NDWGVjbHdnOWx0?=
 =?utf-8?B?RUZRUzM5VnE0TDFIN281ekFmS3ZicW5Dai9IRis4VWx6K2NFZGxzZmxwSUtY?=
 =?utf-8?B?d0tCQWZxOW5FTUJwRUpyeU5IVVZvU2xlQmZMTWVVRkMxc3I1OXFWRzVoZDRq?=
 =?utf-8?B?T0RMejRuYTE4NzYxalE0UnE0Uk82Smh3UE5aWUhMb0Z5MzVOZDE3RGcraENi?=
 =?utf-8?B?YmVud0V2dkZHTjY2ZXduQW9hUFZjY0hZM1MxRy9teGRFNmVhQk5MV0hiTGgy?=
 =?utf-8?B?RDdiTnQvWXJKc2lzcHQyNE5FMmhCWFF2a0NtQ3VUc2ovVGFhT1V1QXVCYXBL?=
 =?utf-8?B?OURVOW8vaEcwMUZjNExMSy90SmwwVGwxOEZlc1djMXhUUElNWGorYlFmSmR2?=
 =?utf-8?B?OVdDUVcwVVNQajk0cjQzOTd1VEk1S2RQMlV4MU1CakFGWHZGOVEwRGMwQkdE?=
 =?utf-8?B?OWNzYlFveHpUTDMzSkx5VjZVWm93STNTME90NjdjU1gzeVROQ0FGTk10QUwx?=
 =?utf-8?B?V3o2eFQ4c1JiVm1SSGhCVk5DNVQ3SXRPQVN5VWNBRFBEWjNOejFDVnlPSnIz?=
 =?utf-8?B?b2hvODNnTWRtZ0dUeXp1cmJtamJjanpqaWUwcGtydEFaSlRJdjJGRWxlU3VF?=
 =?utf-8?B?MXFqM2FMbXJFZ1ZWVzYwQkNUK1A4cytMM0x2QWZzb01aWnRrVGZKbS9hZlVi?=
 =?utf-8?B?VWx1L2V3TFF0MElQSzN2aEc1aExyZVFqdGtIZDRybUpZelVkNTNWdHF4eWxK?=
 =?utf-8?B?TlJMblo5a2M4NnNjSjczS1JsV2VXYmhTVEdFUW1tTW5vTm9aYXlmL0MxZklV?=
 =?utf-8?B?UEpZVXA5YWdRd2NEczBrSExSQ1U5WlNja1dYQjdIbXBZQ0drN1BFUExkQkU5?=
 =?utf-8?B?RVFHRHk4NGRyYlRrZ0xMNTIwaDBtNXhNMmpnYkJ1SkN0ZGpJaENBejJCYU1C?=
 =?utf-8?B?allQdWxQY2lqTE9uaVJuOWdSVmtlZzVuRWxDRm1UTDgxUC9KVlJuV1pNcmo0?=
 =?utf-8?B?aW43dlhpb0xkVE1EQzBpaXZtbm1pRkl4S2syOHE0Y2dFUHpFS3VrNlZTYVpm?=
 =?utf-8?B?ZHVzK05oZXZVdUdNcmlGU0VXYXh6OWJQWnFieStwNDhjUVJUYld1SHFWZ1pC?=
 =?utf-8?B?MjR2eC9BRmJKLzd1NkxGZXRGK28zZ3gyQUlxeUFsb1U1VGdPZW16M1NnYnY0?=
 =?utf-8?B?SmN3dnZCVjNGT0lpTTM0dlRzNjdlTWVtWTVjMjF2d2VsQ0Jka0U0UjVJZFZL?=
 =?utf-8?B?WDhOTlVEc2RqMktNb2pNYW5tc2Z5TnA0UHFRdDlQZFZwd050bUdBbmYza3lt?=
 =?utf-8?B?QmIraHVHNFlzVFFQSmIxWHFGdnNxZ09kRGl6ckNiU2lNL2ZKbTdCRWkvR3hY?=
 =?utf-8?B?UnpnWFp3SHNucHlPUTZ2eWhaYUdBQUo0V2xGUmNxK1h4WmtnVU1XMitYSHNn?=
 =?utf-8?B?NDJxSzZRREI3RUk0V0NrWERLQzVXdERUQ3lDNXMzc0QzVzFQelRna0laSGdv?=
 =?utf-8?B?dHBHRWpYMXhBcFdBdHJtMlNaVzc1Ulk3dEpySkFpeG05NVhuV3ZrZGFmYUM2?=
 =?utf-8?Q?PCV29Y4i1GnPW9O1prjjloIBAnX+jk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3NoWlFHTGRDZmVvbnMrQmkxUlZrTWpDa0FpZW02V2ZuR0dQZDhlSDdoeGdR?=
 =?utf-8?B?dGFyb0xoM2s1Wjd3djFqditkb0hNZ0l3bEFDUzhHUWw5QTlCdkw1TnhyTzFG?=
 =?utf-8?B?SnlsbUFJQlc2RHFuMXdIcGxUTEoyOHllRTQ4V244TFZXbkNHNGM1VUxxWnJE?=
 =?utf-8?B?dU9lSC9JNXVFbmNJQXRSNkFXY0xpQjdOUExpSjRaY3VGempXcVlUbEk0Nzhn?=
 =?utf-8?B?UGdzLzVGQkczSjFoeE9seFFFUmFtL1JHTk0rYmNqWHlIRzhNTlZrcU5iSWI5?=
 =?utf-8?B?R3IvQnd6RU85QjRzQVM3NmpZazl5MHFXTTczSTA4N0hpR0w2ODZJK2N6RG53?=
 =?utf-8?B?RWExN3ArYzFqSG9xSjE2OStpaTh1QkFuRFpMaXhyTVRoMkFVbVZWdVNpcTBG?=
 =?utf-8?B?OHlZK1JyRHhXSlQ4OWZvYmoybzQ4cEc4ZHFOWHpBbE1sR29CQS8xMXNpTTN2?=
 =?utf-8?B?cVdXa3M4MzdoUUlLNTBBUkk0aTNTLzg5cmpYeWltKzFpK1I4NGhiTDNvK2Q4?=
 =?utf-8?B?dVlnU2N2Umt6RHc1eXM4ZDlGTFZVeERFMEZCU2dET0Zjd2lMS2dkdUhzVlZo?=
 =?utf-8?B?RDVKUDVtRWlQSDI4cjJVaThyeGR5elExUXZlSlkwZFMwQkxiNHdDd201dURB?=
 =?utf-8?B?TXdDTFBSNUlLbVdoZk9hTVVmbENkZnVOcmZCSnJZZU1qNUtnSFZHb3kzdWRS?=
 =?utf-8?B?R3A4b0FCcUhIeEVycjRyVEVVWjhyZ3A2RnJ2RmpKbFRSNmVZMkxsalczZnpN?=
 =?utf-8?B?OGhXcFpLcE1hNTQyZTl1a0I3VW5mSTZFR09OLzY2RmhrWWI2clBuYUxLYzNs?=
 =?utf-8?B?NWhER0pWUW9GWjN2WmtSVDhQZlYvY3hudzdPc01MMFhwWVZFRFZLV0l0U2tW?=
 =?utf-8?B?NWJhZnBRc2NaSjBzUS9zK1FBbFBiZGplU3VKSFlHcDNYSVRMUW5iUjhwWW0y?=
 =?utf-8?B?Qnh4eXpDNVRHMkNNOUFBbGN4TkZKcE5ERlA4TDZMRXlJUHR0Q2FVYWFlemMr?=
 =?utf-8?B?emxvYnFsSzZwVkt5Ym9DRHJ6OXVrOWxGTk5iaTE4VVlJVVMrNUhFRDRLWklq?=
 =?utf-8?B?Zlg4SjluZzh4OGlXVlRYeDRid1lJSXpaR1dVdTNxOHd3WlFyYzB1QUtzcEJw?=
 =?utf-8?B?d3FZM01CWUJWV3JOKzBzNTV6WGhpYW1UMnRBSENtNGQ0MXZmSFN1VjQ5UjQy?=
 =?utf-8?B?V0hUUWhoTWw4Tm42VU9aODNXRGJYTmsxTW5YTVpsVm9mWjVCOVVqYzRBUGV5?=
 =?utf-8?B?TlpsUnlqUkdmam0rY0daYkJ5T05weldxMEprcisybXZXcUdnaW5maWtLTDhv?=
 =?utf-8?B?Y0QwTG91Z050MlhYbjI5c1UvYmV5RkZjY3Z2Q0UyTk5tWHBDRnM2aXZqbDFK?=
 =?utf-8?B?MUtBTWt2VmNuaDFMSXg4Y25BZldkcUw4MTRFYjNLOTcvWnpHQ2thbjRPditt?=
 =?utf-8?B?RkkzRitxb0lIRk5rZWV2N2RhTjFZZm9FOTdHWGdpeVc0V1R1N2Y1eWhlUjVC?=
 =?utf-8?B?LzhFc2xTQ0JDekhTcTcrQW5IYWlEd1kxcTZ5MGhiUDFMT1AxeUZmYjBJNkk3?=
 =?utf-8?B?Z3F4UTJPaUtxcGpqSk5YNUt6VGhNWDNDZHBSVnR2RzRwa2dPdUptM3BtZXhO?=
 =?utf-8?B?eWtWU2hLbi9Xd29oYTU5cHlqYS9XbkZPT1hBZjdqeFI3RUovdE5jek1hcXNE?=
 =?utf-8?B?SHJkUUZTL3UwcnJFSU56eFB1ZUxxajJsNmZwZTBLMk82SzRvaCttWmZZRmsx?=
 =?utf-8?B?TkI1TjV4MFhKK0V5SGg2SEZLYjcyTjVxV2lqalVwbmU4WHgwd05nY0R1bHpN?=
 =?utf-8?B?Vm9uMEtpdlBJcDhETGJ2SExzdjNHcHFwRy9zcG5tcVgyeCtOcG5hMTFGYVRY?=
 =?utf-8?B?MStlSzltSXBYam9kWnIwWmx2cnZORW9NeDZYQytIUlFOTWtNK0hYZUdXQ211?=
 =?utf-8?B?NDBBdUI3enFCUjhuNVpNVUpvTnhreDFNM1BnbE5BejFsUTRMZ25tSGhlQXlD?=
 =?utf-8?B?SXJvaVhJMEJqMzJiN3gxRXhlbWJNbzlvNUt0MkR5ZDJWRklJNi9KNXdUVEdV?=
 =?utf-8?B?bXA1dlJkNTlrMnZpS2lTTTlsMVRuNDFqZjZ4R01SS091NnVkQUQ3MWlmMExn?=
 =?utf-8?B?UGdUQ0FkMGlSY3ZFNHBxZVhWSk5ja2x1d0pLTVV6dDZyUlFOV2xERGRLcmlz?=
 =?utf-8?Q?WgoDbVR4y0WCfptPaT/JVNt0FZVCNoh8twPkqjwizodJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb32456-6daa-4640-cdc2-08de36041da9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:24.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3Hj2CI3azPYAQpCKCCf+3s/ZthS2uqZohWmh7WsDNHlS/uj83lFNsGZ9Bifa67kZjrum8gzFv6J+IstpsBI6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: c6af9a1191d0 ("rust: cpufreq: Extend abstractions for driver registration")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/cpufreq.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd22890..0879a79485f8 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
         ..pin_init::zeroed()
     };
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
         let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];

-- 
2.52.0


