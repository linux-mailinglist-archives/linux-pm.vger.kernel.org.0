Return-Path: <linux-pm+bounces-39280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0CCABDE8
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD953020494
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78827AC45;
	Mon,  8 Dec 2025 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b45dxZtw"
X-Original-To: linux-pm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FC2765D3;
	Mon,  8 Dec 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162040; cv=fail; b=RI3tWP4rjTczmJh6qZlDxa04d0qHqCRSK8eG7Z1IvRAMVVL8YqOdF4zEUFUhyfEs2oDNwH3v4crnD762Wyl0CQaRPoN7keTx+rm90kJnuvKMyuLFHe0UmO3sTlFmCAaHJptMZXvQNBbPmkxy1gXrkq/YC+0c2EZ2W7WmAnx8jOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162040; c=relaxed/simple;
	bh=e4Lh9309ocBYPm9YsTZoOXeJbHv/HxSe7fDA824zpZo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WLwxNSnsIIvOKJfZADYoYqZj196vIx62RMERIq38g/yNso1h43yXvaeoyrb23vHv3OTeQqYdb3Y4agFr2VK5WRiqGcZJP7QbaZyXf7PauSuXS89UWC0PQs9Du7SsHAHpi+Vjl538vD5nvCDx+gO7soLDciq05Zjy6KIO9XaY2yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b45dxZtw; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAwJL+CUdmOTWHeql3NsHGEYJh3GBq3O40rOxOgfap/Awm9ecK2Mnvu6zeJnNzSGCfoe9tWq+QsylMORIW2sL1PlRKBBrnjkLgocEsF/pkn6cP0EDxr8tQ4K9sKQNVJp/JB6wWrYgymU+aysrOfT9zuy8dmH9jhjsIOazDm2Ax5Qmc0vaMWX+p53wePd+fI+UceuqZC5JdMBoCJIRQvV+ess3c4CSnzqS+AO77uZCG8yb8Bl3Y1xc3LvEGsLaGsOZtgGGiKZm/GAn8p/I9BgzzyQJRMvuzznL3LXO4Aw0KpKS3Q2rXU2JZFJz7rDgNNCXBvdAnEGN4iJbDHhYfOK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o66DoC9W6bNxUwExNIKtV5WSe4lsqu/Y2to9Gnlld1M=;
 b=K6MCfL4Vm2MjwUKsY4y2dv6cCiVlFppy/HvKU/O2h52BwxZeFC0e+l32A2Qqn/xzPBBbwQcODy2S/Crtgk/vBScE4J3Av1ebrd8fYZhRYmZNxdZd1LjMYUga/xKqxAdKZeuVQAQys0OKLgR6U3m3dwmnJzRVRoWm4U7prbZpRln5iN9uOhX9YmGaNhB3lZtEQKhzNQZAuIEfrwMymaa4m/bmoYMp29jSJVjmaExVqeP4jYy72TgabLqSzbm4ZDa0cDmeWvNC9rvEtqUMe/srJTQJXGXpmKGTaNvPJKFtdcinwXJj9lKw9XfWxRq9SVDRe24J8GxnfcFYoeZRydfAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o66DoC9W6bNxUwExNIKtV5WSe4lsqu/Y2to9Gnlld1M=;
 b=b45dxZtw79Ki+ukz7RqRj3gPEgbcNSnSjLRuOegiGwAxb4YrFMPQXJFUSaNJp4ETqt/i2+wvcP4Vn955RU8ocAQ0riYBpsiY7wreEjfBPoTJwNOjGBZcGzjaGFbcCAny7BR36MyifmVoWJXXeqCrTd+ne1CLwSgsS9epJUVGbN2Ye/Kvmicm92TNLe0bI7GoyZHKbA6D0D00VQXUqi0wPs1izbKXXIVGIY7i84NPRUiC0lkdz6/vKcPRw3YShm25gOJ8YoZfW5q6U9w7tabu4V4qnciCkMj7BrFAiJ92NvqEL30XpoNirWxkxdJBIYNBqwUDQ7BbDyvGWBnQF0AI5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:46:59 +0900
Subject: [PATCH v3 1/7] rust: build_assert: add instructions for use with
 function arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-1-98aded02c1ea@nvidia.com>
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
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OSAPR01CA0289.jpnprd01.prod.outlook.com
 (2603:1096:604:2c::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef9c71e-effa-471b-3e02-08de3604186a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0RNNnNybmpHeCtvbmNydytqalhzdVBNNnBySGhuZWpQbldDeWg2emxEQ2FE?=
 =?utf-8?B?Sk81YU01ZXJDZ1NCUGQ5LzZtK29lZENucVQrOFZOam5hYzQ0Wk1xYS9WcWM3?=
 =?utf-8?B?dnQ0WmlyTGFDNENFeHZoWmpwL24zSXpseWFsOXNQYzRubEpUd2pXV0FoMzQ1?=
 =?utf-8?B?VUdKSjF3YksvVytkNHJCRnpDMWpyRjMwQWpoc2FqOFFaRmpCSUhZT2k2Z0RC?=
 =?utf-8?B?Z0xSYk94U2Y4RG13aUtDYWdpQUZJT1AwNVlFWFgvcUNvKzRFeUNSNnVVdWxn?=
 =?utf-8?B?OGxOQjh1Z2RpRC9HUzBUNE5INkdhNXk2cjJYN0p3K3JHbEh4RDY3V2k0VHJX?=
 =?utf-8?B?U1BXVG1MQmpLWVJPandvSE5mcEdwRDJsSWFaaXlNWEY3Z2lPcXg0dm80U0ZR?=
 =?utf-8?B?dGtvREJLRUJldE9OY3hYRkpzWUFTdmx3OVB2dUFDL1AvQzk4VitTVGdwalRS?=
 =?utf-8?B?QW5MY1dhdFB6RDlCMWxIcnRBOWwralBPQkpNSjcxdUVkODZOYVVabDV0Y3BJ?=
 =?utf-8?B?NUwwMlpwSVJtK01ISlRjZi9uOUR5dzg0cnlKYTZmdVFKSDBJTFg2RG92QmJQ?=
 =?utf-8?B?d1pBN242dCtmT0F3cUswS3Y5cHN2QjBhY1BzREtSOC9LajNDa1JjUEF4bnNr?=
 =?utf-8?B?UmVtQWdVSzBuU3N6YmJpREtrMFZDcjVUZHdxK1hBTW5qeWJCVmtqbGFyWGJC?=
 =?utf-8?B?MDFiMUlUcHNUUS85Ulg1VlJadE9UZXp3UVVaUHJCUHJwTERCcUpWWk9Ba1p1?=
 =?utf-8?B?L0NBT0FQeWpuNFdMeVRoWVF6MkhqUWN0Z2RmS2J6VllXYWZJc1VFTVpUUWt5?=
 =?utf-8?B?Y0Z0VnNmQ2t1b2RlVkxtaUVFMnNXdjFWTlgxSWtTNU1vQVllUmxPRkUwd28r?=
 =?utf-8?B?UVlFMlFCMVdnTnVXZEU2U0lyZ1l6YWNqaVhZVmRhVzhPS3lHeFBvN0ExTVc0?=
 =?utf-8?B?SFFkN2hLYUdiaFpQMHBpZUphTDMwekx2QlVjb2JCT3pGWU9kMW9vYkc0c3Nx?=
 =?utf-8?B?NkxmeW5jYVJQSWNZU0RzbUdzRmtTVTZibXowanZIcVVBSlB1aE1ZRmhqNUtQ?=
 =?utf-8?B?MjArUmJqYU93Nk5QTmN2MkE2Ym9uQVZOS00xTDQ0M0JHenFnVE92T0FFZTBR?=
 =?utf-8?B?QmJFcHpCdmFCemc2TTZtdDNUYWRmVHRzVHdiMytmRmQxcStCNmVpTnNQS1FW?=
 =?utf-8?B?eXp6K21QLzkwSDRWSG5kQVVjRWdmdHQ5QkdOSUovU1A3UzhHTlF5czlaUkRK?=
 =?utf-8?B?bnl6NGR1MHhOQlczOXdlZ2ZRbDNFK1JkRFpkSDNPM052TGtTUTE3VjZqOVNO?=
 =?utf-8?B?c0Y5cVF6TUdZd1lrZGRVRFJWNVVOR1pyTGtFMWE0RFhvS09BS20xODl1Q2tC?=
 =?utf-8?B?S3IybXlEWjNRd1hybERDRjBDamxtUHR2NjJIZFd4eVAwejVDM2lOSklQY0FW?=
 =?utf-8?B?YWVaZUgrZmJIM25CRENtREpHMisraGdpazZCb0JBRy9GNURrL1VyNHJHQ1g2?=
 =?utf-8?B?d1ZVN1lMQnRLTnhGM0srUXVpUUJDcVY3UzdMd2N4WFBScDIxYjJQbEdFWXBG?=
 =?utf-8?B?VHFVcjUvaFRWU3ZPOExmZnM4ZEJ3TCtYb2hhR0JjejgybjlsQm9EVU44SS92?=
 =?utf-8?B?RHFOZEdGYzFzMUFKS0xwZERnZk1XY3JtczJhQ0FGT1pyaVdISkJCekp0TzJB?=
 =?utf-8?B?cVFFUW55dUI0UWlla2R4NHR6bHhIei9xR1VaRWhBaVQvamZGeHdFQ0JiQkxR?=
 =?utf-8?B?WWhlSGRGNVl4Y01Qa2lTVzZiNFJneGsvcU1vczMraHB2MUNQU0loV2J6S2tQ?=
 =?utf-8?B?U3FNeVZVcmc3YlJ1Q0I5MHFmVllxU0dzbGVYeWFCL25vZEcxeXREZ2JRV2dK?=
 =?utf-8?B?VlI2UE1rNXRHanV3NU9qejFIVWV3c0xBelZUY2w4QnM3Z1ZXemR3RTEzVlRz?=
 =?utf-8?B?RkpiZXhuMmYwWnNuRUdyS3BUd2FkYklLZlErbWpGQWZoZkJyM0trWmtFeElV?=
 =?utf-8?Q?MTfWs6ORm4QpVlHiRFkw+EX9/oGfgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L29Vb2QwN0doQ0RWaWxGa2FRakFCSUdUZGZnZXBDb3ByS1k1OW00U3pjYkpI?=
 =?utf-8?B?c1VGTmowL0s0YlVFZ2VFVUdGNklBTzFZU3BwWkg1UlFBNDJQbXRpNXRVeGtF?=
 =?utf-8?B?Q2F2SWFpRUhTalZ2N2pGRUFXNUY5cFQxdzVvYkJNZ0tQRVd0czNMdWZvaDVh?=
 =?utf-8?B?d2dQVWZJMTNPc2dwNHNyVHQxRXdSc1JWMnNHWUtNd1FQRGczdVNXR3h0cUlT?=
 =?utf-8?B?cmlJRWN0bTZiQlJ3eE1EY0plcDVLZjhVQ0IwK3FjZnJyTm5pUzY3WFhnK0tO?=
 =?utf-8?B?cUVrcnY5TDFLNjBvNlpRZ1YwSlpQbXFHK2F4aHN3ZXgvV2Exb3R6eWJyaFJG?=
 =?utf-8?B?MzZ0V3VPRVpTQndZR05FWEpoUVFWbDZYdGp0alo1SkE3OHFNMlhSTEowbVdt?=
 =?utf-8?B?OUc5UCs5bmNoL05TZ2l0dUZIUUFJNVp5VHc5SktFamVncnZRN25YOGdoQk5p?=
 =?utf-8?B?OXlpRkhvRFFmR0FObEU4Z1FrdjZrWEpEKzlhM290M1MzNmIvckpDcWJIMlBR?=
 =?utf-8?B?OUZUNWlJQUJvQWR1R1FkOTd2a24vamxQR0lMQ3VheTVRbmtOSXBaVjdpN0lC?=
 =?utf-8?B?bnpWSDhiTGd4VHF0V3ZJYVdiY2MycmxIeFhORjd2S1JNMGdyaHdSeGJMUFhx?=
 =?utf-8?B?N0pFOG9KczhvZ2pVWjcyVm5KS2NlVnBWU0xWSlhJd0JYc3JkY2JVUXJzcFRB?=
 =?utf-8?B?UVNMSWRvTTlDWjBmZ20vcGN2Uy83a3p2cWpmakVFZ0YvT3VKbWtKR1dqNHgy?=
 =?utf-8?B?aVVwTlNNWWtNejFqZmt1VVhYQU5PS1BhMnpYM3R3Q0FrYkVIN2NKWDV3SjAv?=
 =?utf-8?B?eE5ZZjVUUUt6d0hPYVFXb2RhNTVWbG03RVk3L1dSbWU0SzF2OGJhOTlNRXZw?=
 =?utf-8?B?b1R2MWVtaEVJVk9QY0RwVWt2UjFSQThnakJIYlFhZEhVTW02RDRiOVFDN24v?=
 =?utf-8?B?ZlZPeEhwa1JqWFB1YnpLL3ZWeHcvRnJVbHV6QUJiS0tOUkdPMnFuUFlHb29T?=
 =?utf-8?B?b1VzbzlaUFBrRVZvcm5MV0tHSmpIa0hWaFhLckNUNjdONnJrNTJvTjhnNWk3?=
 =?utf-8?B?UE4rSzBoMDdaNWlia05XSTZxNWYvM0lmZmJLR0xmVGJ5Ynkxd21nWXNBMlhK?=
 =?utf-8?B?blJKNFJKbW9jdUgzZnFsaWJwYUJiUnR2WFUyVk9nT0FGcjZrb1JNUzc1UWhD?=
 =?utf-8?B?TnhMME9yY29WOThOeWk4U2hXNW9BWW1PTG8xNEhybE96T2lzZ3MrWk5WYWhi?=
 =?utf-8?B?OTc2V2JPeWFyY3VXUFBPMHFlVW80MHY5Y1BXNE1HbTBhRWZuSFVzZ3JKci94?=
 =?utf-8?B?bThOdTNObVVTUzJ6dVJoaWJ1bVNRdzZzdHlMcXdaTnpYZ1E1cndrTFI4Y0FW?=
 =?utf-8?B?SVNDeFlyR0t6bEtQOTFuN3o0Q2hPamFRZjZtSXFXVGd2R3FQYzE1OVlncFJW?=
 =?utf-8?B?U0lGVXRFWTRoUlViNWgrL1lMcnpJTlNSSXVEM2ROcUpFWmorL1MvWGgwU2pi?=
 =?utf-8?B?TWM4SUJ6YzNaRWc1OUlIYVpOUjVwSXFZY25WaXBWcnZPbGMxblc4elkyNk9t?=
 =?utf-8?B?MTRLR0tpSEVFWGJvaDhqK3ZlSWtpMFNTMnlsbGEyVzQ2aVZ0ZDMxNUhtWmZu?=
 =?utf-8?B?ZFFzdmZLQ28vUXZ1Qk1VZ3NMMlJqRnUwSllCeUZHa0xGazNyaHhGZVlrdnJh?=
 =?utf-8?B?QmpiU2lzVWhtcTkrSm9KTUszY1U2M0hmN25sTkRpMkhGRnA5MHZ6a0FjNjJJ?=
 =?utf-8?B?K2NkdURydVcxTVA3N1VXOStoS2JpdlFqMEFORmVHUXFaWkg1aXd5K2RrWVR5?=
 =?utf-8?B?dDJDY0taMXdwWUcwL3hyQ2dKSVA3RFN3SmgzUXlzZ0NpZWtMWEFjbCsrRy92?=
 =?utf-8?B?R2xiVVRxNHRqVmdZUnFTMjVINkFkL0UyNzFDMDNCNzh1VXkwRU5LQkVYektk?=
 =?utf-8?B?NWs2dnVSeXBySHhvVms2M3VlS2ZKQ3dZdWsxT3N2Wk9OaUo5S1Z0TGU4aGNz?=
 =?utf-8?B?SWdsRU9QQi9wYXR1ZVdpaEtFN0ErYVZRYXNzSVdla0w3ZVZTRDRVNFZNbFhp?=
 =?utf-8?B?aFZxdjBBa2J2UUlKTjJYM0VxOCtGT2dqQlNvR2tERlYxQlpxeG0vY2dZZHcy?=
 =?utf-8?B?ek9zY0ZIeFF6bEpIUmswdGd4WEJRR3JJSHg0R2E3NTcwc1d6RWpXOTg5VUti?=
 =?utf-8?Q?FZQr0b91y5wKoPe9CoJKQvoNUfz5bQ1EvxBsfU/qTgTt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef9c71e-effa-471b-3e02-08de3604186a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:15.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4Op8OC6AyIdLlTx/7lB3o4817ftyn9J3atNid2TGZRz58FQF36rP2X7ghFZ8eZ/eSz4lvPN2XPwo6PZbOOplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


