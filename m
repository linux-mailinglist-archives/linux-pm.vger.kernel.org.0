Return-Path: <linux-pm+bounces-39285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A1CABE15
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A176D30577F5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD212BDC26;
	Mon,  8 Dec 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uT1F1YNE"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C154654;
	Mon,  8 Dec 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162060; cv=fail; b=AcE2H/E9lFoSOzIvSYtPSGn6PNFG1vIBEItKfHn18AjjXe0TfkTrQ1AZHMStIRIiYEz9Wubski9YzNey43M8EAVxumDTwxdlUujdiJo9lwNaUeWeoqCBzLOKAs6SuKoB6LdgnrjS/ZCtSbiqtm8H+MnOvH1H2Axmdd1Cn+YGkLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162060; c=relaxed/simple;
	bh=0jrXumIzvEMkrDLmoxKSpwN8UnEE+ezoLaY+NbHiddM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L3GAOIg2Xa9jyfQ7jhnxomumucD+c2GCbfONFnxotvtn41ZeQJPlTeleFKdnO1rKtKXMCW/Z/6In1vcf5jh7W8igVdxpziFxg0TfzN90XcUZlFZ2igyRT7T999XH5iKU8VObmrHziMdNsQGxhFQksNPtkEN5GEVjNe2FuaEJl2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uT1F1YNE; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S14/84jiO9qkSj7e2i/LpA5+IlI5xglLyP8VEb9yJK0zVSDyxQQB8Bmxx8SkRCoYSbcc90Qw5tVouHkggdgWcfI1QJza9WgH7+4MsXog4qWC0m10Tv+HFhdpH2rsRPUJKmTJXCd1XrHMxfafEfwNiRZCHT27OIJPX00rWxFbf1e10c3r7k/HoXWxz7VhSeQtpt5i3CdBAJgOj9LvFUZ7vgnnVjG+LbHr2cZgHN4/VFvgqL/vZ3STew/6kp1ncRUbDYhdL6xjGCgywB/Fgw08NwaxlQeAcl4SQ5MwTwOeto1c9mYmLM/IDueyaSrFuabP4CBjfFD+QhmW/yZA4vSDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga2BuHbnDSHVGD+tOfHPdeBJOZ260CQSBsK9NPyHgl4=;
 b=CPrxAlzyh3S4U4e9CM4UP4VbjXCQMcX1AawHuGqVmnLMbE/JumGRHZjdKp2h66Zs+XGSL07ZjK9lucphzAhXT7sjphHPSAo1T8KZakTASxU7exsNyOQ79uyrnFpSwjM2Ttyc3h+I0j7rWQ/Ji5VH+wEpVae62lKH8ZOhlVSpkiY8W4OuhVJMY4wdxWqUtWrlHl4/+xUxGywDEU1ccoS3ZT8x4WFYd5j/GukZbEFM1Iv4tfEg50wJpkzpHwBEoNLTZQgx1w4MkK+Ap5AFYqJPin7O+MIAq/Ks0xo6Tf57j8rV1OeDsp7nCdLX7NaSXqjCJ/Kp3lvnQO1TjtDDdnzOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga2BuHbnDSHVGD+tOfHPdeBJOZ260CQSBsK9NPyHgl4=;
 b=uT1F1YNELEWERzWOH3y/7O50c2b9uC6D/INzV6P/qaXoj3V8241SHwiY2D6TlWbec3CJ7js8se+wPjCt+40mbhq6IOTPPOs+L0zFw00Y5+/xzz8o9OEYPecE0KG2U6v1ooJ9t9orM9E7IzXfWsX7LodTD1B7KznqtvzNV6qOx7Ssa9SMuZ6iIDe0paK3mPgM2v6ZRjUkKAZjClYYE3iWxYVtnXjFCBXVKH/lLAwilhVKzYLqVLc7eSZaFWol0hqnJG/OCQQR3E28Bbf+CfiP02Vhjqkxsk55QXpdRKbaW4X9KTAGtEHZ16J1rG3/b91Z4Cx0VV44hZ0rfycetE6a2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:47:04 +0900
Subject: [PATCH v3 6/7] rust: irq: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-6-98aded02c1ea@nvidia.com>
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
X-ClientProxiedBy: OSTP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3f0b5c-985b-4561-d3e0-08de36042486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anZrcUZhblU4emhkaEFCcjhrVUtpTmJ1Z1JZOVFyVzNEWWdLQjJyR0tEWWNX?=
 =?utf-8?B?Q084NzRxUU9WamptNjFaQ0JFSSs3akc5UkVDNE0yV25WQWVvSEZiTk5JYjhw?=
 =?utf-8?B?UlpMOURDbW5yVVlSN3hyUlk0VVZtUW1taStIalY1bUxEbVBwZmluZlVncko5?=
 =?utf-8?B?MCsxYlJhYmNtOTN4UjR5MnlkcFVlY21KYWxCNmlvdW8zeUpxVGE2ZUcyZ2tw?=
 =?utf-8?B?WGN4SXU5OStEN2gzeFdac2djWTNtYUpuODhyYUd2dE5Zck50MmJwWnh5bmNl?=
 =?utf-8?B?R1J0bkRhRFNpMkUvOUlnV3EzQVJGUGQ2OTJOYkpCc1RtWmFiSlE1K2NrM3A1?=
 =?utf-8?B?ZEdXbGhwY0cvd0ZKQit1d0tHckRrZDRJMTJBVk5PSGpTdmdCYVlVTWNuQSt3?=
 =?utf-8?B?MjJWUUYrbVB2WHMwYmZ2dzRJM0Q0anN6YWZoRmNpUDJDTlJ3c2Z1MDNDNDJZ?=
 =?utf-8?B?ci8yYkhUWFJUNndhdk9sZ3h4SVkvVU43ZmFuMHkydXQzNG5Bc25UMHlYRCtS?=
 =?utf-8?B?bW5xSWkwc1VKRkdvNk8vbVdKL3p2ajhJNDFpTHlrZjhkMU9reElLNENZdzVW?=
 =?utf-8?B?T3NrVGVXNkpsNjJsOXBoNnVSUlovbUpuTmJrUi9aQ0k0c1RCOFIrd1BaQ2h5?=
 =?utf-8?B?eVVFS1FVSVlhYlc1cjUrZ0ptWHI3YVlOQ2lIKzBLOUF6bXh3Lys3cGw0NFNQ?=
 =?utf-8?B?K29CZHYxeWd1ekhhUERUVmdoWTFZR1lYcnZKRWVQN3RVSXJwaklpKzI3bjhO?=
 =?utf-8?B?VDVadkUrb2ZlcHlNZmMrUzh5U0MvS0FXeXAzclNtMzl2cUNnWXJ2WjRlZVM1?=
 =?utf-8?B?WEt3Tm1lNExwanRWUUhPTXVhZXI5aHdXYnNFcTcycldoOEJiWGlPNUxqckNq?=
 =?utf-8?B?cDNJcVlEcy9TOEpmci9aa1dFTXhhSDZwTktYaUl1eEVzYmYrOGVWQ2FDVWNN?=
 =?utf-8?B?SkxaOWgyc1k5L1dFc1h3ZjM1ZDd1MitGZlo3OFBDQ0Y0d2UxVDdjZTFJWkdX?=
 =?utf-8?B?TVBJZk1qazFyM1c5WWtyQWVIRnFzaWpRQjdtM1haWWt6ZTdCK1BYMkxTdWtu?=
 =?utf-8?B?Z3Q0Q21ocDd5R05vMXcrWmdMSFVabXp2UmhsS1AxMDF6MFl6ZDdLTEgyV2hv?=
 =?utf-8?B?K3FCZnUrRHQ1cDdxOUVWeHduZDZSUVR4aW93OFBoOUF6cEFEMS9vZlBhMGE0?=
 =?utf-8?B?YjdwZ2ltNWVlODdiMzBEQnptb1dmdExzREdBeUEydmVZcWY1S2tvOTNCU25l?=
 =?utf-8?B?bnlCcnczRzk3Wmx0WkpZcHNVb0RPcCtpeUhpc21XaWNKd3NqRE90L2VaVURq?=
 =?utf-8?B?cG5zL2xXYXJ1ZGxFM0d4UTRmaldacjFxeUJwanV0T00rNUFteGluKzcxclc1?=
 =?utf-8?B?ZnlOVFNDQk52cERoQmdEemxsdjQ2M3hMWklwOGN6eGlXMFozWHc5dms4cVR1?=
 =?utf-8?B?UU9KUC8ya1VFcDhhdVFxMjZyMG9vclY3WVpNRTRMeC9uaklUclNtd2Z4M1BZ?=
 =?utf-8?B?TWlDZkxJV1pUR0paWWRsR3ZianFIL0prd2hoZFg5Z2pIdGYwWCs3ZktBSVlY?=
 =?utf-8?B?OGNBLzgwcGdqTHNZTTlPRi9xSXh0ZmZwZkRCSXRrYTdnOW16eFZOS1lHbW9K?=
 =?utf-8?B?M211RXJteU9oVlVPV1ErZHhNRHdVKzc0aDZFaEVpZVpuQXI0QzdETmZla0Y2?=
 =?utf-8?B?dzlBM01IY1BjaWRJVnMyV0V0N1cySDZVZ2RKZHJEalRPTndNRFd2enFIM2tk?=
 =?utf-8?B?aXdxZk8rbUc1VzBoRnpNU2VKcUovVUZlZHlNcGxoaWxidGFQckNOaEg0Y2I5?=
 =?utf-8?B?VTZuK3ZUdlU1ZWNFTmVjWkFkMExldFdNbEdzelRENDl3RmJnV0p6Yy9na1BN?=
 =?utf-8?B?Nmt2dVdVcmhOTlZpYW1yZHEwVDc4bEtpR2pVOXhXd1M1YXVIQXk1YTJGT2c3?=
 =?utf-8?B?TzNjZGZJTHdnTzA0NmFJTXdPdStiM1NEMmVoeHJBaTN2M3RtNCs1MW5RR2lD?=
 =?utf-8?Q?GtXBKSluAQVFszBHKlWY2/r77b7niI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajd1Y0w5aVloZ1BSRTFGT2IrOUx3TTJpTzBQZkNoSWUxWE9waHdLS0tnckNM?=
 =?utf-8?B?U25uY2VYVXdOQnI1U1lCUUJkTzg3WkJJa3llTkxkUzRwUlMzNGpnVjFabGxV?=
 =?utf-8?B?cEltMVBJcG53ODlUeGhnQW5pSmJ0TWZtYTMydE1tWWlFakJiN2UrY3ZHRndJ?=
 =?utf-8?B?cVhmNDhoOUtBbjBseUlON3dhSUMyaHNRSmJVU0JXTWI0VmVLUSsza0RoUDZm?=
 =?utf-8?B?bFROenpXQkRTZlhaSHUrbEhvRXkxRStEK3BOaDlUK0FJRXljcGlSZS9KTmtx?=
 =?utf-8?B?ZXRINWZ5cGZOZEFPY1RTdEl5RUJKWFBvaitSRlVZMXFGOTR3K3ZKcE5tY1Zj?=
 =?utf-8?B?eWVDOFZJTzNPZlVtOHYzM0FsVVpPQjF4MDlmekVpYmtMSVZuTVhnZmdZQld6?=
 =?utf-8?B?QjNVdFVCeVhiejdlS0p4WVlGOVppdEJHcStrcDNaKzhxQVFuM2N0aHdZaGFs?=
 =?utf-8?B?aWFLMVJ6MXFjdHg1ekFjT1lYNWZRL29Bc09OTmlnZ2lvRjB3UHJXRWNnNnov?=
 =?utf-8?B?bmJ2ZFZKUDljdUZKR1YvMmRPV1BZc21hM1NqQ25sZUJOdUZ3QXY3TEw1OFQ0?=
 =?utf-8?B?WnN5eEcrTGsvdkpwQlFvWDk3K2RxVHk4T0l2VDlTeVU5WW9IdUxFOXAvT25x?=
 =?utf-8?B?L1dtWFYrZ0gvcXVQS01yWHlQZmJWcnhpbnNYSW5teVVOQ3FQUzlzMFNrZU85?=
 =?utf-8?B?Q1Z4TGxoMWgxMjBSZlFTaWlCK1N5ZjBPUTltb0Z6MVBCMVNCZ094ejZ6Uk1P?=
 =?utf-8?B?Q0NVWGIrcFk0b1k0K3pCOHBEdWtWQ3NNOVo3NXZCcTh0RkxiM1FuV1lLWlA0?=
 =?utf-8?B?N3V4aDN5SHZtRzRxY0dNbHpIQWx4QkZtenBWRlZ6djNEQ1dIRHpicC8vSkFz?=
 =?utf-8?B?QVN6QklVSUxMa3UzcGZpRXlLbFJxTm1hV1BVZDdCNDdScHcvVWgvSCtmZmly?=
 =?utf-8?B?Y1o2SmVaNnlrblp6dUR3YUREVndybXJzNVhJT1BZbGVISHJ2aGhyN3NjdGN2?=
 =?utf-8?B?VVFmUVNleDRrSzFWVFlXSzl4cFA5UHNiM0Fnak5nWXdZajZsUVV3eW5YUWhq?=
 =?utf-8?B?VW0ySjF3RHl6ZUVienVKZmlpcVZIb05EUzRENzJEemttYnJBTTRpUUM1Ykt4?=
 =?utf-8?B?WnBKZHlzTW14eXJqTWM5SW9tK3AzdS9JR01DSlh2WHk0Qng2QnR0YzR5cWNz?=
 =?utf-8?B?UkZITnFQU05URWdPS3JOSStWUzUwRU5GWDJTYi9KZEh0cGloQ1BoR2M0OEZ2?=
 =?utf-8?B?VVpWTm1NajJJQktYUFd5eFBGQ1lIdWhTdmt2THRpbXFmaDZKdnBvSzd1SUs5?=
 =?utf-8?B?QWk1TUMrM2V4YUVjc2JlR2dCWmlOMGpFLzA2Ris5UTRqZml1aHZQWWpwU1VE?=
 =?utf-8?B?VTQ3VDNGSTNqemYrUjQxMTFuS1pQR2NFa1VaaUxrSXNWNjdwdVlMb0t6dnJy?=
 =?utf-8?B?ZitmSUQyNWN1dktqeVd4Qld6MWxEUlFsTWRsU1FNa1lxMEU1ME5wMGhNRzV2?=
 =?utf-8?B?U1pkWHZvRm42UzRLS3VoY3d1T0NONTBpZ29HaC9lc0lZS0tkNVVjNFBwNWJ2?=
 =?utf-8?B?bDFvNjdXZFVyeElDdDhvNmlTeFJoMXJEeWhnUFBObGVOK3R2TDVQK1dnK3Ar?=
 =?utf-8?B?VHV2eEE1RC80YjhhQ04wZURRZW9FMlp0UFdDYUFCU2hnNDF4ajlMR0psWm5C?=
 =?utf-8?B?VlRkSFVnNDhSQkFoeExuWmJCK0VZTmNDelREcmRLclpTRFE3UThNZnlwNFBE?=
 =?utf-8?B?M1lmL3JGdVB1UEJqd2xiMWdTMjgvT3dSek1Kc3NLK3IrMnhUckxROGhPeVVq?=
 =?utf-8?B?WWNOY0dHK3U0YTdJUmpwaFNndm41VmNFVldONTFzOCtNK3N6dDdLNS9abnhN?=
 =?utf-8?B?VEQ0Kzd6bmZQdEhTYk9qT3pNaWxST1NzcDEvUkg4YW1jVUExZk5rWjJCY2xj?=
 =?utf-8?B?dE4za0pmdVdPUkMwOEsyY1dWMzZXeVZKVEFSMk1RcCtOSEV5aGwzcXBRakI3?=
 =?utf-8?B?QXdTMU9teFBzU1FPSmwxQ1k1ZnFHSUJCL2Z3SkgrMUt3Ykx3OElmYXBzL0lo?=
 =?utf-8?B?SEkrNFRNT2pKNUNyVUU2LzJmb1RmTEVZWlJ2bUU2VnlwQlJ5QjdKYUVZemNm?=
 =?utf-8?B?ZDIrWHBFWDJBN2FxWHFoMjV5OTFyZzM1OGtDVmFkc2c1OWpBVUtaajRmUWIx?=
 =?utf-8?Q?AOc1Rs26kQfjGPVedUBnjyKXNOTR0g3EdzxPrSCxcYIv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3f0b5c-985b-4561-d3e0-08de36042486
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:35.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IgnnB0HjxI7oNJvB/noieRjIs2W0GfGl/+mb4s5gXrusX5G7HA9BchZy6XfG4jcWWcIJa8QzPIioW8okD//Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: 746680ec6696 ("rust: irq: add flags module")
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/irq/flags.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/irq/flags.rs b/rust/kernel/irq/flags.rs
index adfde96ec47c..d26e25af06ee 100644
--- a/rust/kernel/irq/flags.rs
+++ b/rust/kernel/irq/flags.rs
@@ -96,6 +96,8 @@ pub(crate) fn into_inner(self) -> c_ulong {
         self.0
     }
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn new(value: u32) -> Self {
         build_assert!(value as u64 <= c_ulong::MAX as u64);
         Self(value as c_ulong)

-- 
2.52.0


