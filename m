Return-Path: <linux-pm+bounces-21846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F266A3120A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6243A4C71
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375625EF81;
	Tue, 11 Feb 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLk65OaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016526BD9C;
	Tue, 11 Feb 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292586; cv=fail; b=ku1Zeyrp7+arq0tgCWkaGq2mtAalri/WF+CA7TVF4k3a0Doaqh+/TX2Vqj3/rax2KRTRDb4Kpr65qaCS+LInbU1ic5flSh0G2Qv9BRrldfgPKRMLHALdsOHmSuTdf8NQa1KoAPTwZUBHrDQgZFqNGIVI3tDO2EpDz2MagumV0so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292586; c=relaxed/simple;
	bh=WARetMZScg5U+C7CCBaS6RCxvQKvcjepGoomToTKiaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jSybT1UuoDSiq8mXJNKp6y9k2rVqT2bnVzgdY2xJH5BdvVXzk0EcjXVh+onUwf7Ha3NQO8shh3rOFbT+A8C2wgdGztA3cgpyO2isqBpv0NJISX5fVRHa2/tpQWolJOOykZPyS3p9JmuDKbQ3w7KEMc6qdrpni6SAbysFsoPmCWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLk65OaI; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs6HzkysII2svhn9/6YhpnUq9LuGPFoSvyXn94ZOQR6gEs7H2mOSCrkgeaW7OJcxyy5ItwTbLV5jsaqwoTsH7CqZP/MPGK7HsHh9zeiY4cMeIl2CeYv8JCc2//NfX+dBlW5+uWOWtlCasMbmBXiT4G9mhHvrWz8uYkdsvT1W+3URKIAa/bQ/8Fd+72Q7fWXV4D11F8QG2CpUOAmX8F7LQreQ9HZwa4K6Qbohg+NDKx0+RzqxuZ/SHeNHEGMAZnCp1rdGKZKtVyYgB14d8p6x8C3wCmXWtBQEn6RfgPo6UaRIer/BumN8obsyq5GeJSf7yqCP3djB7BaLruO/fIJ5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19splAI2HcUPgS+eeHQIOHc8tQ6T4OyFh8l05wajxio=;
 b=fpOOlyJJ8lTb4vdVEpHWeAL9/mdBQtnUiXuwyjQnKRER8F3cMJnndVfR3odvwtTGVYfa30ce+up93D0mhAad+8LusJhRHs6YrYREu7q8aht2JwxpdcEetqoYqO88cNaK+Nh1PI4B1iiocodsgFx6GTuhOQf+NhJC52mWc8wedZJTAq81UxxvEb10E2YCl6VsI9iy57fyOycQSSEsQbvyB998s5Jq1LCjlBu31KjtJpL/X3BNTe9a8hOj4bb9K3Ul9BUW8gbsjPAoo5kOHpIME6yPYyhPfGWBzmlyHuzrR3sfbc4cC+BZ3soZQiyg9Gr1ugo6fR95nZXW3wRMzm6Axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19splAI2HcUPgS+eeHQIOHc8tQ6T4OyFh8l05wajxio=;
 b=YLk65OaIy61E6i6/AJL6sG0nkieq3KlVgYV72gI32v1BtTHiJChvDmuTlD/2Y0VFhjNdfPVNtRIeb6+isojNLgcy5YT45lE+HRTX9oBlWimCeqxGz4VbizA37ziLTQDFbtnHpmFxINx9m7c6J0KDJB4mr+lyjJgM2jXKLPZZZs92AJcuHS7wBw0vwqe407xaWjXm0Df7xg07oRlXWkKpa4SEBsaWKdJN6WRk344nhURgBfSUllbM6odfc+ts1EdSnpx0YJooKwfQuAoOi2S3euiVGpNdP7YVAQmsWO/vohZ6uFEIzafEaO9JWPqWGE1++4qah3PXYGmYItDqa4Bwcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 16:49:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:49:39 +0000
Date: Tue, 11 Feb 2025 12:49:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <20250211164938.GI3754072@nvidia.com>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6t51xodSV21ER4M@thinkpad>
X-ClientProxiedBy: MN0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:52f::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dedece0-c899-4253-56a2-08dd4abc135a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cksSgPsxvn94LzhteakJdF2aZoeenGXBNRlDNudKVKLBFG4wEL68ZqGMrQBT?=
 =?us-ascii?Q?qtlzB9Fk4+rG28UsAK0TejDWuF2g24zUZCM3hzXqQN6RSHA6pMpw1hYugrRJ?=
 =?us-ascii?Q?FG+SvM9qkCHBO9/Li2dpI5im6BjrCgXXBpzV+KwOPG+SfUk+TDPZJ8WzM+Oj?=
 =?us-ascii?Q?nKXKVhyh4k/GwEdHEaWO0TcOnjM896E5Pif/aoum2lwg0HPajEVXuceRZ+Vu?=
 =?us-ascii?Q?4m3EkCGMf+5m7nY/lfxlKqzq7+1u/gvikTc8F9fOZS93aY9O5Fy2BApe0RDK?=
 =?us-ascii?Q?OU8kKRY01t5f21yQhBSUJktuUjB5ofv1Fpz0f6ZLjF0ChuPrR9Al3s25L0CC?=
 =?us-ascii?Q?Fhg1GkbyErR45fEPjtTgroZNTFwlEhH63D/HaMs/K8C4rkJjF/CSd5S6hszi?=
 =?us-ascii?Q?y4ILewMWcReqNhy6WW/feOEUzUOuvXCoYSag2hk1WSh6h81IfBs1uk1v8qBZ?=
 =?us-ascii?Q?QfebpbXZFDYmzO2FLV7nK8EoZFOf5Ll89JmpW5yWg7ELF8p/dF/sevRIUuWS?=
 =?us-ascii?Q?UhNbo76aC1450+TMA7ur1f5+AHb78/AV3I58uXVUnR56J8WkthAUqa3sG7VE?=
 =?us-ascii?Q?20CpeTh+m30fGhG8ghKn9jj+HYOq/ntqGxe7k1IgDoQkarvy1MQJQOdJyCuQ?=
 =?us-ascii?Q?b+4fdR8V8VVbi2G+Zpudbh8gZgApNPJLsojz52w+STKI8j0da+orIxrRLzxG?=
 =?us-ascii?Q?CDPmz1GI4y8hA1/NAx9jgrhdC6ZtAHVzV4l+o8/cQBYZMdBfXQv36pU1IlIu?=
 =?us-ascii?Q?TyVkKkCneosaphe+aalKZBZ0H1iEVMof/y4n0Qol4hWcV7/dk+ucW1p9qje1?=
 =?us-ascii?Q?sz+tlX39HNI0GW4JgxL+Laf9WtT3TTfy2R65fnGQn7KCe4pAvPyPtRn4Pl+R?=
 =?us-ascii?Q?y/2J/CNf2xpc8648tMuSqGfeREYYc/0f21CIfP6x+jyH42p/bpnZLBQ4Vdnl?=
 =?us-ascii?Q?xQB43bukJxu8MFAf5LpNytMiP2pskuZy27GZpwj/9qsmLETmeyySRbsaZkZ/?=
 =?us-ascii?Q?TqWYVbiwsLyoY2f8je07++xwPz14zkPHvJT+q5uy7Sk60sosNn5zy8c5KTOr?=
 =?us-ascii?Q?ll+I4eyJkXE97HF8PIJfRR5XXDtimce6irYqXMhe1HXPE2ZSEvoobJjfeEM4?=
 =?us-ascii?Q?LVE8r+LnUm539BiL3iHmRPJ/N9aK8bPRs+kq59LfIHeecww+aPK9gCIfTqWU?=
 =?us-ascii?Q?O/p5CcucMCZ2gt1TrgjjE3+QZoESzRI3V+w4CXEnBVjEy7FY2JwYOVl3UYEo?=
 =?us-ascii?Q?ElhQKcIlxFDmnA4JGwsCmlFZKkCxZ1AVc33KzV5ei/eCjBY+1qw+EBpBLoHH?=
 =?us-ascii?Q?Zm3AwNpJ6/RUKZ59F8Pvvqc3lbbqSm8fgTzUaOXTyX2uYM2WPwdwfiIkmeL1?=
 =?us-ascii?Q?2P7qH9cqFF7TushsuJOoItJGzjhl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6v+ADrURcr3Qj7hvYBh8zxcLgt+hjEVgnG9q/1FWBl7s/Kg8yST2m4/ojpGC?=
 =?us-ascii?Q?TpKH4xNGQuUs2WCsvVBR9G2jxSYJICLA9DNkc/SqH64MiVyJGwoyi+3gXvDJ?=
 =?us-ascii?Q?VlbPENTDrxI5lh0v9Fgf1Yo2NrmwgnqpY54Vnt+V4fAO4mH9DLPFvtWF/fRe?=
 =?us-ascii?Q?euij6pf1B1LYjQVh+bW7Pi2DlS9ZcaPKJwmD2FKbBl2Z7IZdOH4oErYDlKds?=
 =?us-ascii?Q?KGMFMbsbXlVijfqHJlc1I1PfqqxJ0Z+0HknF0DZ1UauSEN2+6Zt86sd6MLz9?=
 =?us-ascii?Q?OlT6FkYSyoupsQDdjQ89BFxtcw9SX4Bt6M3cYktHHKHvPsWKLAxv9+k+4zCZ?=
 =?us-ascii?Q?xQ4FAs7zHrMJIIanuxunIg6b9voYhyQQztL4NWXor81WqJ+pj08kRF/A+HJn?=
 =?us-ascii?Q?nKDW2xGICnBQFzY9Md3Np7sswgGDO/LEplsnKGWEhEBRSzYJJXgn4OhhZFyR?=
 =?us-ascii?Q?0ukAHWDPaKg+tap0g5BV2+4Ll3Ve6dA20zhhOS7hdXRISTjmK1/MdqMMmphY?=
 =?us-ascii?Q?9KxH09ROgi51M1Efqmx3k54cRBHraxJ3/KZVXL4yINB4JzfYdxS162lng2hp?=
 =?us-ascii?Q?t+d077EtK1zIjhdMEsweN5JrkCF86endSogRNBru7qcgEHh4shhuEhv+iZTe?=
 =?us-ascii?Q?ZVlBcSTWeNVrZwNyE7nZrIhpHYSawyeit6uLd1jSC1vvxTRO8/lAv1sUA9ml?=
 =?us-ascii?Q?wVkd608T5g/Cd3jjGljbiO641bkcqt3xKZvfeODXPBszc7KxnV4w1qF6HBWh?=
 =?us-ascii?Q?YtSmJmFZhKHuZojbMEYXKBPJWiCCh3vsqIo4EPR5qYMMOKtwPDWXu7Qgn+Gr?=
 =?us-ascii?Q?2nFyqof5TWo5eLI/Eai3+09qge/gXzGCaMCFvHh8ISKdA9Md97PXOQiCVvE4?=
 =?us-ascii?Q?vFGd4DNThpSxkZQeNZPgTMzLW2Euag9qDE5r7g6mFCwyTjwEQ6yExOhhKBr+?=
 =?us-ascii?Q?Pssrv5bPwy1Voqy33GexebqBXHP+j6/kkswZiZb3i7uJmhvHX9wOaKWxA3Cm?=
 =?us-ascii?Q?SCSNK1VFN10g6iT70AhNDD5RuNQ7yLlkEWglolPY/kmaIrUngJQHjM4nzcNw?=
 =?us-ascii?Q?asOH5dC/XXJjTkXItXIygBXOlAoXF8n4zJZTqDjLeFiFSgSare9KAxsIu3of?=
 =?us-ascii?Q?BUU+b7FZ3+syOmUcbJamYb1lmKm9vyUiCnyQIfGB4ekQAPXB2akZxCLc8snM?=
 =?us-ascii?Q?gE/tYmEUWhFPGkW6G++FK15XUXl4gfnCQ/M3ZffSewgeoHA95pMPhMpGktxJ?=
 =?us-ascii?Q?ylRu0IA/O1wZPJzclR8AlldIASv2UM2dksdBgSNiiz+0ylHcXi3pplafu1Qd?=
 =?us-ascii?Q?qB4jcmqcAR7LnPFXxtOxjNKV7/Q6OXZcuZaaoa3EYLBFWl+R3LCw6Z3/upMM?=
 =?us-ascii?Q?8AKeMW20Tdrmqs2037wlNarpAtX7xRVAoEonnc2KEq8uPl2b+lS1rab3CU8m?=
 =?us-ascii?Q?Q64GnxA2TacSscHjtXxtMeEvcO2Dq1iqk4xZJ9zRzH2U/XJfk9T+z5SNyAJx?=
 =?us-ascii?Q?CjybTlNntmYIAWrghaaSWqwEaqG3X8o4fUZuiqFTvaA1zzlD1skI67/lxrZP?=
 =?us-ascii?Q?VTobYe/2lfg/oQtxiQ9ApLzTyb0JPzDdaeAKKvv+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dedece0-c899-4253-56a2-08dd4abc135a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 16:49:39.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2Un73sEoaUkctlkshuKjqPaYFtL8fTzth+EvURunvAUvu94wS0hIzvNRNuDyXNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

On Tue, Feb 11, 2025 at 11:24:55AM -0500, Yury Norov wrote:
> I'm particularly concerned with the following comment from Jason
> Gunthorpe:
> 
>   All PRs to Linus must not break the rust build and the responsibilty
>   for that falls to all the maintainers. If the Rust team is not quick
>   enough to resolve any issues during the development window then
>   patches must be dropped before sending PRs, or Linus will refuse the
>   PR.
> 
> https://lore.kernel.org/lkml/20250130154646.GA2298732@nvidia.com/
> 
> And that happened at least once, right?

Yes, 6 patches were dropped from the last merge window by Andrew and
Linus because of rust build breakage.

There has since been some clarification posted:

 https://lore.kernel.org/all/CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com/

Quoting:

   Who is responsible if a C change breaks a build with Rust enabled?

    The usual kernel policy applies. So, by default, changes should not
    be introduced if they are known to break the build, including Rust.

    However, exceptionally, for Rust, a subsystem may allow to
    temporarily break Rust code. The intention is to facilitate friendly
    adoption of Rust in a subsystem without introducing a burden to
    existing maintainers who may be working on urgent fixes for the C
    side. The breakage should nevertheless be fixed as soon as possible,
    ideally before the breakage reaches Linus.

    For instance, this approach was chosen by the block laye
    they called it "stage 1" in their Rust integration plan.

    We believe this approach is reasonable as long as the kernel does not
    have way too many subsystems doing that (because otherwise it would be
    very hard to build e.g. linux-next).

However, it is unclear how this "temporarily break Rust code" will
work in practice. We do not know under what conditions Linus will
accept a PR that forces him to go to CONFIG_RUST=n, or even if Linus
has agreed to this exception policy.

I suggest the safe thing for any maintainer is to not send Linus PRs
that break rust, otherwise they get to be a test case to see what
happens..

Jason

