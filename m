Return-Path: <linux-pm+bounces-39323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB68CAE900
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22CD3031709
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 00:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517902367CE;
	Tue,  9 Dec 2025 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXcvOcRB"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473A2139CE;
	Tue,  9 Dec 2025 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765241542; cv=fail; b=RgYBqIaxJKSwd43DANa20IBI3SH3jGzqPSnOTupdebx5ZSbCYo3XfehqI8Ou9gw6urfkRS9u8BeqveZwmpxJRNo5fRzq9JmDlGlq9kvKzlNFKRnJsmSUFLcU0Bbtgkx1sseDSl+WvRCx1fVJYpzcs2vRlaMiFpawBxSwct4vxbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765241542; c=relaxed/simple;
	bh=VFUoA/Zj6Dxxvqxg9mAc5ESGl2cm9bWvcqCI9q/+h54=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Zgyf7GQ13DzQ+bYQuXvParPg3ZKK2HqeWVPUTO4jLib09v8JwDG6w+9XsXkxTdEsbars2Na26xfYCawluaSCq9ZZN9QUMM72Vhr7m3UDigylrGi7s4LkKvkDNVaYNUDq6Nn5q2+WLUGuEVEtVGnSeacNStk4PAZ6n/OgHVnnaJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXcvOcRB; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqQmfboilmjK06QOrbaJZvsGNS029IdoQFF9WFROQYus3MT256qbo+1dloI/8WedCaBvONgZgCXWQvDT3ZouzpSSCLjz91ASy+jV18IRA8+hffrwlFOCmh4yQC78/t4rVmCudRNz6IIYcvcV/vn+6/gvLq90IG8MHNl8rNmHdGJ/bMzlZXyXatExChS3Bc271I9OE0W4zDw54Lw5EFXBltpAFsZ14wyjQ6yXnjaIr8H4IGS9s+muMOMsu4Jjr9YSI20oWhFNH9Bk8SgVs92yQ11en41eKQ6u2pZVlbCABUKGOLvomTfpik+MbHe6VGMETWROTSeG3RdGj/XD/I/mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Pkc+5sWQ9Jl/1oNihLHw4tGe39Wq/KRNDnki8F5uo=;
 b=enZobG3iE10TbFtMKJnoujQ4H52XZy5k4R2p55bIFDTkbKAemufPEigyEe66Q1ymSoX+tc/rVaIAyVEfrDqRvpGib/kNs4WzzoPjk6Xp238ua3QwOFzodiYJWthzvAWlTFgLFbKPq5c3SI4Y5+Vw1rlyZOsU3HIp4FSwHPqtYguL9MPEQD1BKcJ5uL2yFEuQrltZlggSvtdo0Q7Eyo+9/mHHQqWXlOzz8EUeNE51PNrEpSZZOc2T7lnUw4VtKgU55+ZHIuOOviPB64Uldfinq4mPRN7/7qhar4QK1Pk3nrQA2HGvkwecFV+ifGdFIHdsrFyDNRdyj/eRZ+JcqbqT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Pkc+5sWQ9Jl/1oNihLHw4tGe39Wq/KRNDnki8F5uo=;
 b=rXcvOcRBHPbv+8nYVMtthpQ9OsMxvjoZL8d4Y6ZQXkmmBGrFFI+mLxmxrlk+PAwW3e94zq6dWeq8Rg8DIhU46X2PV+A7B681mJL107fij6jbo0ciaTVMTJc2lfi5fnHgaVaHavjjxjC3kf+uY7EbsxQIrlPAioxs9lsEneoXWJGO1kxMfu+VvEPxC70013nmBacOPc48LBbDaMN0XI5th74jJXdubj2d3KIhC5CAVtBR8hVAmSGEnZSoOe8nd5CwcKjASZQgJpRNR/znSlB8FLNgMsUbpUOFblD06gl8V0SU5uYHlDPcNNfRBS7XygWtOe7RLjRmmgXwxXVJA3Jm/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 00:52:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Tue, 9 Dec 2025
 00:52:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 09:52:13 +0900
Message-Id: <DET9WD6T0KR4.1MILPHIC2LIWB@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
 <20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
 <20251208135521.5d1dd7f6.gary@garyguo.net>
In-Reply-To: <20251208135521.5d1dd7f6.gary@garyguo.net>
X-ClientProxiedBy: TYWPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f72c3e6-8c1b-4e05-8bde-08de36bd3349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1dyRkcyemtYMjNPK3NzdTN2enBvZFl0dDEreEJLRFBsRmcwd3JuNWxWWkpi?=
 =?utf-8?B?bVZsbHJ5WUY2aDM2aDNHa2lYUldYY3FRWjNjRVZWQW1rRm9LRkFHdWNUQyt2?=
 =?utf-8?B?SGFXTFFnMHFBbEw2V3NldVBud005cGJhZEFzTWFBWm1WMWJ4cnRLVjVLaENB?=
 =?utf-8?B?MVprWDJCaVp4WEkyTUFsalM2SjdZMnNiOEhFeDdiMjZWdHRDM0tmU0ZPOXJj?=
 =?utf-8?B?ZkR6QWdLQkhGTHdEcmRVR0l5VU1LTU1STkE4Q0ZVcU9tY0gydUszSzRVbUFI?=
 =?utf-8?B?RWJORi9HRHFoajFVNGxvODZYMnFrNWY1SFkxOTlsZGgrd0tFSDdrdFgxNWNv?=
 =?utf-8?B?TkpyU05UYXgvMXlMRnIxOURXV0tMSlYzLzR6bHpuVjc5Zit1cHF5YVBhQVkv?=
 =?utf-8?B?WnkzMmdqWFFIL0VxaFEzR0dWaUZVRzhaTldpVmtoQnJlV2xFaUd4d3o2YUhU?=
 =?utf-8?B?cXgrZFQ3UjNFdnBIbE54MERNNGZSdStKcjhURERDZ1YvTjJrTGpqdmg0OE1W?=
 =?utf-8?B?QVZnTzFZZGxWd2xhbDlSTnJKNE14ZEhKdm9hbW90eTFseTdxSU55Tm96MWlz?=
 =?utf-8?B?MDhqQXhwZVg5eEJCUmVkTkN0V0d3ZFUyUzdiWml2QmMveDRjbHlLWDFTMXBx?=
 =?utf-8?B?a2thM0pzbWp5M1lacUlyMVRYZWJyZXpPd2phMW1rVlRaZEN5WlhNelQwK09m?=
 =?utf-8?B?YVVPUm13dmRzYXoxMExidDhxTlRHcmhFbEhOdVdSbUZsUnpYQ0x5bUloeXRi?=
 =?utf-8?B?cC9sMzVQVG5odUE3aEZXcHJ5cW4xa2pZQUpLRVM0eXpUQWd1Smxvb09tNW12?=
 =?utf-8?B?K2V6bXFPenMrWlZmWXNndGxTVDc2RkthekVHVUw5aldkV1lralNUWGRNRHpx?=
 =?utf-8?B?aW56U1NtcXd4Q1F4NlJRTTRLM1ZxVjc4TVl3UURyUnFiRStvY0JuNk5OTFRY?=
 =?utf-8?B?VGY2ajJQVXBBNW5TWllMWTNuNW90NEJHYVFnTEg3NkUwUzVveGhKd0Y3UmhH?=
 =?utf-8?B?WklVbkhZRFNQbDVpNDIxQ3NXckQ0bHVZZ2w3c1ZKZjZGMTdUNjUvQ3FtRXJQ?=
 =?utf-8?B?TDdLWU9BRnhxcDJhQzc0MGRYRmJiTmRodEtTcjFqdVR4YmxLNVR1ZjdEczly?=
 =?utf-8?B?OUFFL1pqTmVoejRRQlhGdWU5STkvL1BWcFJWMDlRL0ZxR08zZnZMQmpUcGh1?=
 =?utf-8?B?MWFCNEVCTFBpWXdRQU5wVi81N2dIYTl0U3VRMWFaRXpMekFqMHFNcmdXWFlx?=
 =?utf-8?B?d1lnNVlUVVlxWlVJTkxTT09MTXp0b3p2dXVxRDFPaWtaZGgrZG5qbnB0VTY2?=
 =?utf-8?B?NWhHTmZ4SkNhZkVoN2pDM29scjVjVDBmaHNRZ2pvbUsvZnR0SG1Ra1VScElx?=
 =?utf-8?B?ZU9PeFZuZ1duaHRHVVNadmVWZGtTVk5KV0t5ZElPMGxuajh5NEtucjhxNjNl?=
 =?utf-8?B?K2c2c3MzTk11YmN0S0J5eXFlRW00cXd6YytNUStFTndpTEQwazNZbmgzT09l?=
 =?utf-8?B?UGE1UXBPbmtCSEdtdXNvMW44RnVSdFJ5aFp0WHZDbW9DalZNMDBxSHMraURE?=
 =?utf-8?B?cGNjL0hLKzVzcnJvZ0dtb2NtcmsvZE9OQk9UdlBpR1lReW1WZXJnYWQ3bEhU?=
 =?utf-8?B?Q3VzYzNVVXFQNVpwcXIxdnoza3YvZHd1cEU3UStmdjNBZmNXUGk4dEpoRWdj?=
 =?utf-8?B?ek5rZnE3d1JTZVhQQ2VNcG1BbzByQkU1QVBnTXlvSlRuMFlZRGhJR2NVWHVw?=
 =?utf-8?B?SjRSNjNzUUtPQUpFT0c0U1JLMU1FdnJnZ1FmQkJFMnNJV3RRM2JBeWMyTnRC?=
 =?utf-8?B?eDBRQkpNZll1aTVpR3VaSDlWWTJJdGZFQzVQSjA4TnBmdGVadXl0c0FRUUtH?=
 =?utf-8?B?cnJnUTJXOWxNWjFIREdqOTZTd2dvMERTWFN3TUh3T2NvQ25WTWhkMHBXOU5h?=
 =?utf-8?Q?IxJZS5tUXNPJaphTEaFFfDo5MT6FonCd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czBURS85WjliODZEUjFEaDZ1cHgrUTFFS1dtREUzeVNZekFFQmVwL0MwQTBw?=
 =?utf-8?B?NEtxR09OQSttNzlCSCtKYW41Y0RVb2FEWWNyalZFT1BhLzZ1UjQvR0Y0dDBX?=
 =?utf-8?B?U2dCVEdUMVJXT2xhSmh4UTREeFVJekJQQnU1dVpaQXRhZ21NTFBCT0lHcGZi?=
 =?utf-8?B?QytyVTJpTjllQzNQS055VEUxZHFvRTFJbWVCc1RRazBHQzNkd3VUZHhYODAv?=
 =?utf-8?B?Y0Rtd2hXaUU0MFozM0huU09rVTVSelNlN0wwdWpVWU5wTDBXSUx1a3RwZUlN?=
 =?utf-8?B?bVhaUmdKS0RJOERxazk4STRrQ0IzUlg4elF6SW9PYjMxV1ZzaGdiajFUWmlk?=
 =?utf-8?B?SFM1MDV2eXo5WjBZdGNDaGw2bFpGdTJ3d3BwMThrTzJOUXdLMlRzQUhNL0ta?=
 =?utf-8?B?YlY3WndMVnF6UHlIZGlDdWpNMmNXTnBvelJGMnpQTTFsbHovay82aVcrb1dy?=
 =?utf-8?B?d0prcG9sWko3REd2VFZJUjB4NkJlSFk5ejc4OVhBVVVBcExOcHZ6MEF6cWJo?=
 =?utf-8?B?c0VQM0VnUmlMSE10b3lkaWV3OTJ5eW1sTWNoTGkxMStTaVhPZmd2VElKcG9G?=
 =?utf-8?B?UFlCZHhvS25EQWszWDl2TUtuSzAvVGFVQzlGM0FHS0cweWhaNWhXVlQ0cFl3?=
 =?utf-8?B?bUt6Q3lMVkxiQVMrR1JZdzNMNlg1NmxlMDJHTkN1TEhsZEEycGkvTFBpVUZP?=
 =?utf-8?B?OE5RbFBvODQ5UUVNUFRVMWpKR1JXRWFQWE9YdllLMnlzM2dsNEgzbnBzZC9u?=
 =?utf-8?B?UXRoNmxKdzJLMUxZRDhFMVB4YU1EWGlJb21RT3k0QlZQV3htVWJMRkYvNzBZ?=
 =?utf-8?B?UStOQkw1MWovUUVhaGdiZ0hXNUtISU11WGZCZnluc1hwZGh1R0FBUld5c1R0?=
 =?utf-8?B?Q0ZtVGttek9tRVJFZkpMYzdaV1lLQVh2ZVB1c0JqUkplS20wWkpsMElhd2lh?=
 =?utf-8?B?c3owTjBpendPWWc3TmNabGRkdENEdlhqbDAvZXh1ZEtQZGFRYWxhRGRsNS85?=
 =?utf-8?B?dUtsWnBVcnN3QXpVdTZWWWtrVzl3WWtwVXBEWnF5L3pPUFR1bGhmSlJ4OHRG?=
 =?utf-8?B?N0hPVnhyRE5LU3FnbnlQRE9DZ0xVQmNIZTNiVEcwMng4WVdnOW1YR2dESW93?=
 =?utf-8?B?bFYrcS9NWStSQndCNHVGcWg5ZXZsSU83WE9OckE4MjZMVlRybmFoWjNYcTNa?=
 =?utf-8?B?a3hzWHpqdnV2TkRzSURLM3I3SlkvZ0FKMzZkMDBCampxZnRqUkxEK2VQOU1H?=
 =?utf-8?B?ejc4ZkFxZm81WGVPUWhlYXF6Y1EvRmZJcnVBcEs3Z1UyZmd4VTBhZWNoamxI?=
 =?utf-8?B?TVVjQUp3bTNtQjJxcE92bUloLy95TWxjNlpXVlFlejhmUlU1RVVuZVZSMDRY?=
 =?utf-8?B?Z2hKMDBPbFc5NFVaTDYrc09kZ1I1c1ZCcHNVSlFvS08vclhFSWlGMHR0cSsy?=
 =?utf-8?B?cHVSNmpjbng1alQ4UlVHNXFIanIwVE1qUXlidGNTcytBUnA0akEycDFXdzcv?=
 =?utf-8?B?Q3J2Y1RJRHp1OHBUVk9ITEdqNlFDZ1N0RWFtVWNYUmlMcHlib2VLOHVxS1JR?=
 =?utf-8?B?cXhPbVowV05SSFhmd1VDa3ArK0ltTnI1STN4bXRaQ29tMzZlWmNneGo2V29W?=
 =?utf-8?B?NUxsTzJTRHBxNEdYMjhaU0NoMmJTZ3ZoUmUza2VpWUYyK3Q1VzRPVE1MaEt6?=
 =?utf-8?B?WS96bnc3aUNaeWJTanR0RkNkcm55SkJ4Vi9vZEI1ZjcwdWUzQ3JsbWljSUFS?=
 =?utf-8?B?YWxuRWpOd0ZEMk8vZXlmV2hCc3EyaXNmYTI2bFFNWTl0SFZDdnV1UzYzbW4v?=
 =?utf-8?B?SzA4SEdIYTFCNmcyQVU5TkN0c0dob0xxUnhibldIVE9tU3dWOUU2Si9xWGxJ?=
 =?utf-8?B?QUcydlUyY0d1bWxIemFlU3VzYlJIcG1MSWpYbTArQlBza0Fra3lqTUk1R01l?=
 =?utf-8?B?UlZEeFRzcWpCSU1hYW9UMGRaV2I4L1hnUEtWUXNUMUhXa2l2OHdRUXpKWlZY?=
 =?utf-8?B?NEpYQm13YXF3SFgxSHFCcjAzemg3a09paWtrZ3Z4MEo4Uy9PRnpXdUtjTThQ?=
 =?utf-8?B?MFphSk9RS0VKMjNKbGFSbHFxTWNldWFhU0JBMmQyb0g2R2FkWVY4SzQzbTdm?=
 =?utf-8?B?NGFVaVc1Qk5LMnJnSWdhWTduZWhVSllvaUhzY1FzaU80M1VWdVpMK3VxdGJC?=
 =?utf-8?Q?HSs9u1vtcn3yrvzqKRbBAB/61trGXGju79e7c5uX5tz5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f72c3e6-8c1b-4e05-8bde-08de36bd3349
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 00:52:17.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi8S8epRkQ/kGmo/nIU9c/73y/UXnWk935X7VG5bjjjpLkgoLDUuVlOiGVJp0vwMIYsRdaZ1KALwFQyOkgwNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

On Mon Dec 8, 2025 at 10:55 PM JST, Gary Guo wrote:
> On Mon, 08 Dec 2025 11:47:01 +0900
> Alexandre Courbot <acourbot@nvidia.com> wrote:
>
>> `build_assert` relies on the compiler to optimize out its error path.
>> Functions using it with its arguments must thus always be inlined,
>> otherwise the error path of `build_assert` might not be optimized out,
>> triggering a build error.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: c6af9a1191d0 ("rust: cpufreq: Extend abstractions for driver regi=
stration")
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/cpufreq.rs | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
>> index f968fbd22890..0879a79485f8 100644
>> --- a/rust/kernel/cpufreq.rs
>> +++ b/rust/kernel/cpufreq.rs
>> @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
>>          ..pin_init::zeroed()
>>      };
>> =20
>> +    // Always inline to optimize out error path of `build_assert`.
>> +    #[inline(always)]
>>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LE=
N] {
>>          let src =3D name.to_bytes_with_nul();
>>          let mut dst =3D [0; CPUFREQ_NAME_LEN];
>>=20
>
> This change is not needed as this is a private function only used in
> const-eval only.

... for now. :)

>
> I wonder if I should add another macro to assert that the function is
> only used in const eval instead? Do you think it might be useful to have
> something like:
>
> 	#[const_only]
> 	const fn foo() {}
>
> or
>
> 	const fn foo() {
> 	    const_only!();
> 	}
>
> ? If so, I can send a patch that adds this feature.=20
>
> Implementation-wise, this will behave similar to build_error, where a
> function is going to be added that is never-linked but has a body for
> const eval.

It could be useful in the general sense, but for this particular case
the rule "if you do build_assert on a function argument, then always
inline it" also covers us in case `copy_name` gets used outside of const
context, so isn't it the preferable workaround?

