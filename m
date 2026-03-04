Return-Path: <linux-pm+bounces-43620-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOkRBdSNqGmbvgAAu9opvQ
	(envelope-from <linux-pm+bounces-43620-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:53:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749952073EA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79ED304B4E6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A903CCA07;
	Wed,  4 Mar 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z4/ZMhEq"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD373DEACE;
	Wed,  4 Mar 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654020; cv=fail; b=gDfWEbyVEYzWeGH7aQSyApziXcRAKzf93k7NgM2emooFMwKqxSC4w4OwBOGjjw/Ww1yDp1rrINPQ4j0Lc4lWcAqsjw1/AhYJRRkuPStD3EkZC/b/bzywwSRLaDyNTjZw9OxVEdD1uQw9bvAi46rUggczb+aSE5xAlGu/mv+NP+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654020; c=relaxed/simple;
	bh=id9BIAAKSU33ZI5XudXqKl0ef55I99AJwDtCUxB1904=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ihAuxUt/WoRjhG3UmUJ8kJOBhFftk6RGIASv/gDC+eYeAXFenUsVIAwaCFa2S0T5A7UwdlfW+COhGYTWzvYeyGrXyQbS8YMK0MNejV2A7M+LnQtIokBFQz82kYhbhoVpQD7cLJ1SEy/0ZGtChzxrn5+kCNCOg+KZhG8mm+rQ3Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z4/ZMhEq; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYmP8PgHeCvQryybbAIvupUIyC703kzhDTLM6Sq2O/cYCyqnvm28cH1ZtIyfiRWd88Ri0bFMRL4euRfuvN5SgeNy98/3PgmoIiHyIZlpefOz1a83cMLgZ987/k7xj9YV+HtNEIqyBqLuD3968KEZNvav1TLRj+6KnXJ0aKEHQNJx9mlx0mx5wRIBwVQ9iDWLSQ5k2cSb/gsDGsybbRnoXwtDEaVx1n+htiS5WhGnBYVDKSaqB6qzFRpOZdVx7rsku5WIPUXDQBNp5u9PQuIsDyxvkzGA6UKSm4vDagu81qwg1gG80hGhMLplO9Rr7WpfEdAJBWHj+Zy0PmRDg3G2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIWnOSH0F5U2W5IKr37AWd8il5JuwxSGBk+t1rGsaaE=;
 b=aNmni0AMPhyXMKFgs+YqVuTUxwAwDZFMLVwWRKMZofl4S10e3QQCQFqOH4mB5Ae6qm2Vnc7g3yWO+/1idpTcRdfRAZjpwk4gowNB/Ppr1vQ+GWjoNP0yq5Jja2NkspmPWeaD5gFjThanTCjyaFZiuSsXrUHmeRE/s7PS7pIXesePoDsGQwZz6CGbdXAO4nfiEm+wg47KET7t+FYOPERuZNZNji7+x8wpC8EAb0rXqCDcQCZ8pf/tRVpcTLuy6EHUF3NJ2GKC+o9I0A9I3Q3WjSs0zNnLjUFoJlK+tOYXE9mp6rbrqslJQhJ8Pvcc0xCVbLIi8PkS/wR1bUQyzx13qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIWnOSH0F5U2W5IKr37AWd8il5JuwxSGBk+t1rGsaaE=;
 b=Z4/ZMhEqH3JbUynvksskunLUZXQ8wY8rfQz6qBFeTBfevHyzCWLZvY++OrYH8gP7m2HAuucaidZRLIZ3MtZil/GO9C7vYGC5o6lztf2BNPA5s1KN1eC/yds8r6TbMJ3iHHnTLxQfgcM1stdYmjMGBU7AaHb+EDaxEir1Ut7iuJxplWmgK8/nUUV2cIOuDYRMkv2fWkUihuIJ8ilCQdtd2qnsLfgsdRSThxnELkC3IuNzzUCjmwAcQMRMp7ejfy5N6pZzQQ23l+SfvVs0PxledkkG0KbJ8pQYZg7ckJH05XNEC648Pn0/wkQ09y/MfZABs0VWi8qj5kYazRBOtrkQqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 19:53:34 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 19:53:32 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] rust: cpufreq: fix clippy::double_parens warning in Policy doctest
Date: Wed,  4 Mar 2026 11:53:30 -0800
Message-ID: <20260304195330.185829-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 2435a88a-ed68-418e-c11d-08de7a27b6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	4q/p6zyT6hI9EFTljdHXwwtj1UVALEO+/3qbpJzUyAYUzO2+B1vox6ZUKavpTs6ll5jxDfWEtIkH7vreGoiDQJpoK2TH9DHXDOBIVh89XLhreQeg9z3I10nW7qotvYz7wa7uLazdOkh72eWozLWQYOF41ltZ386gUCKCLZc8pdwBhGfVLRKdz5T8vAkxLEXmeO4gAMPAwQgsUBE/Y4fU0svgJCuR9prEstwMukltx4FGh4jmyoq0R/IJ8P6cI4O8BNNLk1VFeTLIod1/3TGWd+vLRHtvdz0OzRYwyC5KuV+tEOzo2WfY2ukGb1YcuaBnwq+/zFQx8QUwJtBjVEmL4UrsMjxRSjyQNuP4vzyxMTAZBt/uZ5ATXLmLiM66kVlmoumWOiY/6d0L5fUKq21Or99m5lBNUDueWohTKyKvmPUggtxKV2zdFlE0L7fLd9UOo7YTggeibv5NaVqfP0Wbz//P/JQqr8HgK4b8T52PVvm6vL8LBPJA0FKC0wuJwz76aKL62z59+FHmuQQROr7Ysq5yWPft8LZ21zsw+JXKkBhjAyPJ7Y/uK3GBHlrVHjw47uVsAQvdSF2TYFkQ3ibZk1KwAEimj5X+Q9bAUnRVjSNwaSUKYO6/kLCvCuCHtMifzX0DRRXC7jxL+6Bsrm+ZHQpFfTDcxtRldrE9mxmzsGSB9bVX0OyKClhCTycRN+d/At31rmgo1kXcsHsTUXx1zN9IuqpuaZroe4eDW9vn1cA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qu613rehAg0SdWg9ZLyEAXdfNhBaXOZ9OBKK1LRl6xK+WM3Z2ZI5laBfOb4?=
 =?us-ascii?Q?FdnmuXV7NEZ+UFS3PJy37VzsNYHpp+rXk5F6gONOkQ8PGqSPQ07k5HgiAxf/?=
 =?us-ascii?Q?/CmePzcfDrJgeGcGqgauwG3Gsk97+g5/wmhP2oBKrobv/g2J6pgqn8YGiEfK?=
 =?us-ascii?Q?davskQIdlvAi03NQQNojUJAvWG53VXKiQ0xQnGFOmLL6Mha+m63UjOKowyaS?=
 =?us-ascii?Q?scaqRm6yPUraFamBHA+43+Bvn22yW4bZ7LZorMDgGEC3s2OHa1hnLuYOENDK?=
 =?us-ascii?Q?Nopwtw6q9bqYb9Hvm5vSmVZ0qWUmVD64nxhNvCm3GDiMvkJm5ALLzuWkWkQ0?=
 =?us-ascii?Q?RgFgkIFz6JFOYHI/+hEPyry3ja1SUNqGSKZYEFeBityMmCS4iEgqkq1dFpxk?=
 =?us-ascii?Q?oBwanj9YONjwxn3qKH31gBE4Q0LRntPMt777GvEunLF1S6nKx75+yJ1IBlDI?=
 =?us-ascii?Q?kh84a88c1vNsBpSro0aAq1lhjW5GXHfh5LNhj1FuSx5LWJwwKmYu/dprUx/S?=
 =?us-ascii?Q?BPL7QnYNJ1mlRBXYbzSwu0qlJ7BUEuSQT1wQpxRVo7Fp3BH9vjGktRkSMA/L?=
 =?us-ascii?Q?77igIk0kqP8xZRoOPtsoxjej0VUwsqBSlERJdV62ZrviqZMHvFQtksi9/Scf?=
 =?us-ascii?Q?V5rONl2IRHIO72fLV7nt5zMHTuZDQjxHF42YgmkQ+xccZ90X4wEyQPo68ltK?=
 =?us-ascii?Q?rhAD7nsh2/JtHOonQwUyVgQE3PyokJVvXP2I3OF6bMNqpWW7mS6HPpHQPVv7?=
 =?us-ascii?Q?pefNwBE3eDX0uBvXjHozR/WDvC/xDukCdW0bDsD+97fw7IVEccOqRlNcJtDY?=
 =?us-ascii?Q?MKbEr3N3Y/AZ6yP6S1e1XPqqZLzvZkgo+LLe2Y/TL1GLXCrJ0aryKTIkDwJ2?=
 =?us-ascii?Q?ayid2FMm2zUiyDvFNQ0IOitLH4SNSsqFnKkvesYcqMccem5g08CzUdGvyqWE?=
 =?us-ascii?Q?N8hJ/OLzkldks/wQmukmFhDHUSW7AOdav31NfFCEzvxe408Gq1U6VZPIyKNg?=
 =?us-ascii?Q?ziFi6ICbd8YBWXHLaU8eyWu47eEQ6kxuXogcxoeuTdY1ADf2pQJIrfIrRKHX?=
 =?us-ascii?Q?1ZqABmIex6tIKfxyHAoOrYzJswHDBf1IoY67UQ7QQtCm04UKlXz38OelIvSg?=
 =?us-ascii?Q?Kkvc2ZqrEXIsjxr4dza5bjqF1Jjo1nUZ1nm2RhmIMAhv+XqvW+HGmVy/4Ngc?=
 =?us-ascii?Q?b8mVUmSv2tIhZo9WlBbWnjnpjnakmm5IVGBrck7SFWve4CctovkZMf3srrPQ?=
 =?us-ascii?Q?T6QYlyDi6vWZ9Swm8R42Q50PkUrBgn/MKWqgNU77Kqu9alZS2u/nzS2XBBHl?=
 =?us-ascii?Q?ua/tfuO0psKHjIJk68tks7F7ORTYDG68obycdIuHDkfCvqSrJaL5AfAJxma4?=
 =?us-ascii?Q?6KvNbB2fzspa90G9ztxSOqZJbXoihclYkkvUaPkzIJTrrrk7xu5Lbyd5u5Oy?=
 =?us-ascii?Q?82+Ow6Qwk+WPYwbMVhp6RFrQk4Ce0fgGBL+vSFHK3mmnwTIWZHRW4QVtocwd?=
 =?us-ascii?Q?SkNfccF8o5ezkQ04LwVcwffsr9WwBNhnJjA9LHnncGMiqkjcvLNSv2EOvQpz?=
 =?us-ascii?Q?a0uLGBBFjydmYlJARgIwwi9yuH0VhXwEaQlggHVNESuQQuzDLWZQisK79Uys?=
 =?us-ascii?Q?g6NXMnICZdpx/Sm+Q3T+ZQfSqnXZE8HCOPHO6RIkteZGO7wOrKYPXHqc5qI/?=
 =?us-ascii?Q?z5r9hJn+CP0pIOJlgjpaAZAS2v1R3URfJiAkgi3EqVJnhaTWOWtRxsOem7a2?=
 =?us-ascii?Q?UDOytpGB2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2435a88a-ed68-418e-c11d-08de7a27b6ea
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 19:53:32.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxsqSFhtTr4Td+C8i+ub9rpzNDQpwbfsF87eeuhwyhMFuCiVw/bYk1qv4WyCTdMk5d7wN8/+fctAtdiArkeUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
X-Rspamd-Queue-Id: 749952073EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43620-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhubbard@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

Clippy reports:
    warning: consider removing unnecessary double parentheses
      --> rust/kernel/cpufreq.rs:410:60
       |
   410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
       |                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Fix this by using separate format arguments.

Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and driver ops")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 76faa1ac8501..e94a17731557 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -407,7 +407,7 @@ pub fn to_table(mut self) -> Result<TableBox> {
 ///         .set_fast_switch_possible(true)
 ///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
 ///
-///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
+///     pr_info!("The policy details are: cpu={:?}, cur={:?}\n", policy.cpu(), policy.cur());
 /// }
 /// ```
 #[repr(transparent)]

base-commit: ecc64d2dc9ff9738d2a896beb68e02c2feaf9a02
-- 
2.53.0


