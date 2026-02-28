Return-Path: <linux-pm+bounces-43356-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLrZDrVBomlz1QQAu9opvQ
	(envelope-from <linux-pm+bounces-43356-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:15:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10D1BFAB6
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F9FB30936C8
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 01:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC02D1F7B;
	Sat, 28 Feb 2026 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0y3vQzh"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E02262D0B;
	Sat, 28 Feb 2026 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241198; cv=fail; b=KOcFt1lHlXt3MQQ4QXHMtS5bxFkvyWFSDnIyEvutkDrk7Q68JTTSDvGeJsAZMM4aYkM5Zv6JbgRi+pOWu21WeZ/7xUcrxY8DA0NDZzKAJJsZu4HV133cvrVV6AMbhLxLKOlgaV9deJx/FjjTqrrYpwNMojo3rtTEXLZSswoObS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241198; c=relaxed/simple;
	bh=b+58K/YAHFTP/5WteZWlh66bAXFlBqteY0ShXtl4Dkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzZruhJYous3xX8e4IclHNee7QAxEpq0QoH8H9hlEa1F8ggAVUpybmY7MmohQ17CdguAk3FnQgyB1dfEVafrBd/89wrzxQfhPeLREfG/LaNLNbsyhOiC5v/dEg2A8S9A589xZ5yMfyQM0tz/AbgGIalQ+kNAoigX7AEzGdtIOxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0y3vQzh; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d46r0n90wAzHLO6/Hf4b3YsDPLETe3lDzPTJ9Hf0DmWDR4uYxSy+AoBq0ZgJikJNcwZDfJ9Fx3VDHckDnYi6NVk2In43NFXzciEuc6adL3N0t9U94rg46uaf8z2weqRUEaorOeQE0Cdr4GYpu6ReSFMri4TlrtHglyeuQmaZh88ES4NchhePEJ8mib7/Mdi7jYdpgUfkiUo2/x3ZnLkqqcDxMuQ3kwCVPUhIpWvtFwxSts0EKkHGdYP0wh9rumJYg1AacaUgKgbX7kyBeUteUergDucfZmshyUIZMP63yPOyR3c2lcdDAAZ+hKGWvbMJ/RDmLyO3FF8gKKJXBifVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu4MrCy/Hj8ZNkpktcYu61yH8f4Y20W08DnyvEKdG3Y=;
 b=UuhOmi7aGxaFOQaMxTCwnP5pHwtk5QluK3cRm+oXHaGT962jQ77weYe7TuD6b5OUSk8wd01Fuc6oYARhaVJ60iRW8Zl76MkwOqJKRs9T/EVlNv8/aaM8D8YBS0ioDtqFtZ3ldiVS2PXcHRQIGO10A8NmMSXOjznKqdtO8sgXIeieD8/oAGfVJUUDht6Ig30ix4KO+vkiWoiV7NlpEZPkqBBSxNjE7wmvXCZg/Tm7g6bqzGhBJdSyU8Ubbik26MhYEE0nzeH2SV10JWCGoZyj7mbtnhuk5bsH3duHc2HX6MbxAO10cN9XPkV5wIc/iILtUCaTJHbFAkXbbamd4N2BPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu4MrCy/Hj8ZNkpktcYu61yH8f4Y20W08DnyvEKdG3Y=;
 b=j0y3vQzhda7qHYz8JvqB274p+6jmXNGGujh6ZoirlX418ONotYLfRQu+ySdfpDpnBuHPeJ6K8ybePuyhccY7PGW6MI6MeuVeAUYesRROtztRQb4GDwabqbWk8V4Xe5uShb0dBydv3s+wCc80laEvZuxZARZyziwaPU28JendiLcBwELExVtbmnPPHN5ICUenq0I1vA59gHFFsWGpEoiBjjrYaQ1+5lEDopVpyTfok41hWqlQoXlFm5p28RWt0WmpxE4Gg78ja/9qbVrpKY/9hp5SmXfy+ANMSnSIevxp5ZyN5AGXtCQ045wMVJEcghyGB01k+6b1vuKiDSR8aq6jMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Sat, 28 Feb 2026 01:13:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:13:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Oscar Salvador <osalvador@suse.de>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-cxl@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/5] mm: introduce zone lock wrappers
Date: Fri, 27 Feb 2026 20:13:06 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <E2E9A337-5174-4C58-9CA1-F60CC193B32C@nvidia.com>
In-Reply-To: <849dee9c47df1e6fba97c9933af0d5a08b8e15d3.1772206930.git.d@ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <849dee9c47df1e6fba97c9933af0d5a08b8e15d3.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f7fca3-517c-4058-bc0b-08de76668b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	yzPyqamXrmapaAaRLpdVd+/cPq3nfRe2GpXrhYxOOYF951SVFK3HvvjXoaHAWOazBrE0+drnv70HI2YnjPmkTxRT3oqhd8nEKhqeIH2mivMIcvNjnX5J28n2DOiSyJbM/QtqiF6B7fKVm13iMziF69KMGJvu4BICn9U3E9jL4YT7u4/rUgPdYKXLu7YAdldm/DXepczrnbll+AOJE7nbD/q5C2PgM9aP3MWko5qm9hu4CnRAMTub/vyaklOUTCjPNIvIPXpmy7k8F41BEZ/YNpils97jToYet408/OB4AE2RTtAb1I8x39JCSFcQM9Qrj53AgjOQILVfII7BQrI4s5A39sFCRo3WxNrAQplN+yaUWHWlN5KdtyRXrwkwo/Mj4ts5ZePFM1cm9Bf0NnA+c0s8gb2rhc6tpG60VnGCd4GJvvX6GX3WupOP+q4P/1fDwwrvO3YB5ZTwYf29jMPLuPdSeYxrayj5oHQ1j5UKrr3N0mXd45IWSu6QLcO3r82FObGllrSPgzj9IOW6TvUx1BQqrYbp6N/MgbEfNfh5vw9uzo25ZVYZBTVX1zfq3FsnYkLPz2qcuIpoMlZwttmwL9oDdpvfJYcarDZUdAow26RMIyFyn85j2mpMslM3oFSPk7bi/E0V3M0cjTeYf/y30m/pBFLFiUjkOGfbtQQC2zHsoRR64TJUgPwTuMpx55Pk9/uqYb82gImnf5NCSwcIDTxNn6F4N7K9pJaEIXqx/HI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?quVnE8/OfGZZwdzIi1T9BzM6g9GfSfFdSMtQSUYFRU+VMLTzg8AuH0ZeLzXP?=
 =?us-ascii?Q?4VV762XLdBLCisS/0UwbeMcAUuGCKTp9bJUH3OMa3XBmCArQKJnpRtur8jtc?=
 =?us-ascii?Q?npyGoHUByYp5Jcl1kv9Ufdb8M36K0frpT4tKNZW3coFXzHZFG0B8nIuwzqZ6?=
 =?us-ascii?Q?LGTZzpDoFU/uD/waH1/RB6lTPxugmVNGdbCUul9a2JlM35oh9Tv46CcK36ZG?=
 =?us-ascii?Q?DXgE94h73nfoq7wrLmuk0q7PRaIBFcY4HOENvrQU5FTpvgrMfrE1R1M+lgpo?=
 =?us-ascii?Q?xwmr0Nvu+DBdjYSMMPQLrdUBnXihfhw9oWTPzRmTxjx7JpICEgxBufWcYvxE?=
 =?us-ascii?Q?TKW1byqZyvyZE0fxVWdOrw6shz+LSv0D+55M0ndDZj0/gVZ37CwL/YUuqbHJ?=
 =?us-ascii?Q?+H/C1GXJdryqq3yoeOphhivBpXyLWlydf/IojB0M8bdCAob3XhmA5IKDwQcw?=
 =?us-ascii?Q?lDFwjoLBhY2kjEBm9Ny3k+wsP7sK6HA5RGnusFDQkqyPGMHUPX9flyICrVaF?=
 =?us-ascii?Q?sxYwdZUq4YNuF+vKqPeUCIQFqiIkNAa71Xg3fxUBAYm88Pg/0HOkJKOhXNa3?=
 =?us-ascii?Q?EUxl0sZfK6LelD9R2qy7jRBsMEl+CSOk0aZodKqfwCVy+yI6VWcKFGQmp/Yx?=
 =?us-ascii?Q?t66u9lRS/tMxrd4+vb4JwkDRssLzZQ2JUaYCCxkfkMGWdEATY3qS9rNXRN9u?=
 =?us-ascii?Q?JIyLEmwvL79lFR906Gn0QaZ1uqkA71sJfJ6uiPeCCfGPau10sJuIHM2RhEcg?=
 =?us-ascii?Q?0lWn3ihn+hP8NuJOFZkg0r82cKqwszivD6HsSCA6od8wesIrOyMSpWc0oHoP?=
 =?us-ascii?Q?DyyIC+THGo9lEg0SU8lNySc41dHc7Hfcw7vYgTaYCdEnlOl+A/gwyoUtl4XY?=
 =?us-ascii?Q?lbB7Y8xm8sLoy4VjxaicCZQB00mm9PA3v2Fwmz7Ci1qhLhgMYUt//K606Kj5?=
 =?us-ascii?Q?bnfvwFt1YmQHN/A4/Sxc9COeRQM0wB8Ioo1HmdgRT9zZlN7FApELpiCU+AoX?=
 =?us-ascii?Q?J1nreCkyiRmVLV82hGd5Q+Y5cPAldjl6/1a9yMJZB9lhHkuH7p+ySoZyOFFr?=
 =?us-ascii?Q?gFM51oChlph+q6FbeE8c7wByHxpDO4c/u2jcTmNTK7pd0+c7D3yYAPRErYd9?=
 =?us-ascii?Q?4H4FDbmm8pd8M2CK0i7xppd0qeN0Jtx9xQR16bF4zLwgr4/ue1P7U/Quu2MS?=
 =?us-ascii?Q?7s3siVvyYhnK98aEAn3ivLGsTrvfz9XGReZm5Y4Dw02pMU5cAlYD4FCA1tKN?=
 =?us-ascii?Q?/Pl++BmTy//3qbkj5LUIkmBa+7zwheP7UNNysPxJfseKDikljlN7qcWIb6A1?=
 =?us-ascii?Q?bBIGZsfvZN5zmG6Au6TCitnYzevoDVAK56nXPLAQMC2vUlC1Cw7A/bDMLS3c?=
 =?us-ascii?Q?fcOchBK8KuZkFF4eYkUMbdZi3VYM2d4rA92NtZFcoKLNr7pG2c4jWFOtPFGQ?=
 =?us-ascii?Q?pNXYc1FNelCh/pnMMGfR/YozR44qxS8f5HwHjDjRLCyLdLLl8n7s9AQw8n9b?=
 =?us-ascii?Q?UDwskhN3ujAXGlnQrxsMN9WcmgY4QS3YI9Y8qX93CQeo8pHWZvQMCIKg1hho?=
 =?us-ascii?Q?4FF4/zYhXKBXWR61iWDF+1U7s8hqAOqF8FWV/fbsp9xeVWY/1CdA0YtMkyxk?=
 =?us-ascii?Q?JWB5jNnkwI8bHC8ZD3MUBuTdolyZzSZ+gvmhA54XNVUc9MiWmiF2hRd65LIU?=
 =?us-ascii?Q?adV4YuKRByrhuGhTgSL83MqUym0hLC/AJUyXYINajr1lgztO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f7fca3-517c-4058-bc0b-08de76668b17
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:13:12.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1WljCQ0xUD6AK9oCPvwjOKjycpSyjhpKeuWCHXO9MhgDwMtR+kf01WyiAdK4xt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43356-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 8E10D1BFAB6
X-Rspamd-Action: no action

On 27 Feb 2026, at 11:00, Dmitry Ilvokhin wrote:

> Add thin wrappers around zone lock acquire/release operations. This
> prepares the code for future tracepoint instrumentation without
> modifying individual call sites.
>
> Centralizing zone lock operations behind wrappers allows future
> instrumentation or debugging hooks to be added without touching
> all users.
>
> No functional change intended. The wrappers are introduced in
> preparation for subsequent patches and are not yet used.
>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  MAINTAINERS                 |  1 +
>  include/linux/mmzone_lock.h | 38 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/linux/mmzone_lock.h
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

