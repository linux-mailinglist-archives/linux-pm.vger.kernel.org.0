Return-Path: <linux-pm+bounces-43357-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMC0KxJComlz1QQAu9opvQ
	(envelope-from <linux-pm+bounces-43357-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:17:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC31BFAEC
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A007312DA22
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967702E9749;
	Sat, 28 Feb 2026 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWI0TQEw"
X-Original-To: linux-pm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6A2E54A3;
	Sat, 28 Feb 2026 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241308; cv=fail; b=ePjFkaKavfvYkeWVhdbCJtiGcO0RWRjTYatxl7zfWQsmYNWbnBF+cOG5lpFv5LUQUXKNt7F4fd0Xr8+NnIa7QxUYm1ILpLtHPQ3MjUMPdwHFQ/o1Flli0yIOw3rUCY7S4amAjql90DKUfy59P+ySF3ySKN/MZrlCmY4gWzLLVwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241308; c=relaxed/simple;
	bh=7bCbjEvj580kq+8azcIUqvg1sS8/l9QeUlLv5Ngwy+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usCAsCAP6tTOhK700hiNjoHL5+m8orXhL120957ykHpR8L/qiW1eYGzzZ4eiLYry54d3BkBPfHsPrXG44+3kfeZZsfplPo1miS2G5bNTulMqFIqfgkf2j8CCMpU2dpvtvqW/j3SFE5Cj8xfnbGMk87MZVIQYB4SlQBOwjbwm+Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWI0TQEw; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhgJSVFnpLkOeFmxYRpd0YSgDwAxZvJjSXVUkFjpiaIjtewGyO2YESo4y5JMsSNGyBh8z6XJWA83qBP9cgTG7H7BoS1HT3pBZnbSgOUyFhwNNfpZ4eBio/16lcG7bnVmeZZz8KC5KawqUWgVWjdB9sCBKPnuN6Fa0+zuUMxoHpPtXJ3dha1OMTOYZPxd3WAVPiy7ucOCYjVT1E/w9YdONzXQp0T8uU1w/Y9wHftyM8UJcp6xiwwwcuBdl/3PAJsYIZaEfC+Eh+xQV6Euq80z29aaQ9HBt9SBBMoJmYv5mYl5gK/dTeoHvl/lqDMkyNMwVbc4LOMZKxW6BypNbsROig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJzMURJXw5b8Ocf2wkR1Eiyqp2b+Umdqh4CFiqYnwTY=;
 b=s+3oY8d1GN4zBonnAQwgQZ+td2PWGJ38djXN2Eef3eyP70zZyW26Qe0Far/MO7/gfRKU50Heu34iJs7IXxFSVWFB5rVTfx/b8NJfthCUj9HacIYNtRAbiqznEZArCdv0GLnjFN5YtaNkhe9c1vmkL/d4CdyIJ7Br9Y/xB4ShdbMlju60xulQOHkCEUO7h2YrJTOCCpzq/TTv1G8VEQ3OIbHMqXO6r3AG4mguIxUUtwBSR3NZ5OicpQwCF66LhDGiHdqndUzvAxrf5e24MugO/zBkB+zXPAPBQnj4xrQa6ieTyMi6NQmw20tmnp2iHusvxAIdr4JclrtqPs/NueHUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJzMURJXw5b8Ocf2wkR1Eiyqp2b+Umdqh4CFiqYnwTY=;
 b=kWI0TQEwn4V9AxEoE5g4DMPOiivmNDY4pE9wLxq7cGYMY3wGL5QZQcTfJBkpp1UCLg3x1pYQgmDTm3MrMrOOuu7Nkcc5fsVciyN/p9uKF8WZLVELfCBcKG5epIUb/jrAX3lPSd1jtkRK+M81lkvm+rxpcH9VhaazSQLTf4AiY3KdTavuiVtHgmpai6yZot/0RkWz3ZVlLiRbHKV6Bc0siHF3O2Tr3dfxgCkAsk8+1BrpIiiwiCuptIcctTz+KiiG4xx8O+21FgVfmAkvFP7f8FDUfdJ+znRMhXpkts9BicWCB4cxdlDu5jySt0Dd3Tgybg9wWRUvHIMCyV3hJj5k9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Sat, 28 Feb 2026 01:15:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:15:02 +0000
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
 SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4 2/5] mm: convert zone lock users to wrappers
Date: Fri, 27 Feb 2026 20:14:55 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <50E4BB45-4F7A-49B1-96E0-3D1961E1821D@nvidia.com>
In-Reply-To: <d26a43ebed2f0f1edb9cfe4fbed16dd31c7a069c.1772206930.git.d@ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d26a43ebed2f0f1edb9cfe4fbed16dd31c7a069c.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5c56dc-9651-4397-b4ef-08de7666cc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	Er2mMdSyHOZYCeuMPIMkeYycncqZ0nrhYTn3bmElUbatN0MOlA4lWyNm1Ns926c/SfCyjJMgFxsb7jYB4iJLingxCLYEz9h/P6A4sZ6zysquNR74zv1YLOBdjVs6MyMJKpOSwK3o21EvVva/BJrBFaG4Qj2X2z7kr9IR+lIOYgK6YO2I6yti2xE1b2Tf1r1F0TuSuUuxIwXAYCTIZZWuILnwqd+/4ANZWqEi5W4FLGaj59XfUThe9QDp5Xw5ZmkmeTNu0jS9p4/Js17GlQOG8cO0ubvDjFMfxtCakbmdSI9BGhFxnWa5jt3EFpJXHk9D3eR944+kA2sD1h9v5ulcaeA1WSSNLcnFYpIEUZCUpEnv/llu58RJvU90YbEN9WhvInQWaoqe5BavyBN5PMfvvmszO2zZBnpPhceJAk6S1oahUV8GxovFaS3ckOfKNPPeLNLkEk1IsWzCZH3WJMST9bXBSrjrxkPwZQUgYR0X5ABH6yR24R0gvbdeLvgdLn8o9TaYIgEyM9boNSZis4WKB4byjr1WzprwYR+qNSPBbb7zpR029CgeDdg92mNLiAcuK/kbT9m1EEOL5DfUTL5tjmh0ZnN4ak5cMLTZ39snpgZyDliqGc0J7VjbEUtxg6uQPty5PAXipB5cmpJFAjCb0vEKTctKa93hp/BKJmy3jZS5iqg650KOPT9AkJqQyiQ13U9qnr5rOcfqLyg0c2LPQXAHD5+5FEsegU3TmKmTdJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0weVCVKrbURgZQysGuQTlClQi0kai1p/q5tH1KlibRHMVJ+QUF+CFA4MP1L?=
 =?us-ascii?Q?5Al06evjN7+E9d6dG0M2mOSTQ8MmABSs+ME5VtXLft5LCm6MbXkci5iQZOR/?=
 =?us-ascii?Q?HZnMyJtrh8GD/xzkaiQv9bGdhhsmfnjVtpGTO1hzkOy6m3xyfsuuVPP1k4gO?=
 =?us-ascii?Q?trf7PHRTRFoPW4seOyvzS1iaZd28YHj16jIdTjndAf8DzPKbxTirnGrgz5Eo?=
 =?us-ascii?Q?7LjdpYlEv/oSZRZZPdXez977fsBtdQJ8YB24G2XP+4Ut9NXOW4LXyxaSUdcG?=
 =?us-ascii?Q?o+j2/+wZXWhEnZL8D/KPlWhLKUkMjpNu0q1olfIJI4s610dQ7Rq7CUvW8HS/?=
 =?us-ascii?Q?X0ukPY3+Qzh2BvcTp2VT92t1s30NM9LV67wnP/6r4jzVFUgWd73nwKv7GAQN?=
 =?us-ascii?Q?mbIEumDdu1OS28UlKfU3KK/444WDAXrFZHsryQc+38xlb4TbGnI+2CmhSq09?=
 =?us-ascii?Q?wa59pMnG9cLlhNkP6hm0PmMqBxMB42wtr9olQVuHfrLPaDPukpp81iR9Xsbx?=
 =?us-ascii?Q?8LN9T4xwgoYWMlg4Rylx9HNPzEIAezRMgX2mbf/XfSA9wVKoMFPn/95GED9Z?=
 =?us-ascii?Q?5T6urFwjqHF5H44Lyk0vebXiVNC0l3FvUOx5M8XtHn/TD/oB6RnGRNwzyvpx?=
 =?us-ascii?Q?u97g13plm5KkpqQgjEObSVvrutptDT0Z/zk8ZixgBMZznIDo24pmKWuMSZfK?=
 =?us-ascii?Q?2CTRx+OwCRs2MeBXZlmqp2351HLb0hP5EyJsmwb/aWIEJ8TXPE0iSPO/A15E?=
 =?us-ascii?Q?djSA4UXXeTZXm1q+r92F6YbfjrrnubgyQ3KL+BRyZrlFllmv6pPSQDitRaYI?=
 =?us-ascii?Q?lsjiyap9qkDGW66QqohxT7MCfmeevQRQcN+HNMutIJ6dAXSC/Co/iyFAeLI4?=
 =?us-ascii?Q?ctDsOLuqkpL7E7Z/0PXNVfSJ9vDmT3UReetGgu5LjBEysh4BzRwz46smGGSi?=
 =?us-ascii?Q?69EVIIGIk1SjlD1GTVbWBGm0w7vz5jYC2WIek32zchGq+LL2IeETfUjOeMxG?=
 =?us-ascii?Q?Y74Mm5KSB45BBvY2Vc3j9aGBt+ZcFlcxHEGjr4rSIgIbkj7rdANp+7wT1dC7?=
 =?us-ascii?Q?6uQZFDnrQ97lFL2Cxwxl9iiewYPwImzU0rbT6BBjmQ6tJFARZ+BjeHNFooHG?=
 =?us-ascii?Q?W+aI4X4zt6fE6ZSgqDzQVhTAQXVq3Epfp67qTHyIdZLL8K4Zpvbdlc7XSL5a?=
 =?us-ascii?Q?34M8ZZi79jaYeTiEiSBMC1Dd8PIg1ZMG8ATc9NHJNXLpnNFaFUPRPT35EJYW?=
 =?us-ascii?Q?ZJdAs5fEpZkC61ZwR8plyjlstNygFT+F6jV9B4Gy83Fzoan+lWVBOCA1778A?=
 =?us-ascii?Q?R/KKESdgzuMV1ySMqmAYUtIn1bv/koHohX0HaU8vOhfP9+znDg5dkj+Kziom?=
 =?us-ascii?Q?/XFvwka8JOnaDR5gQQykxVs0j9wX0nXYdLKXiLaLYhPCGE3vSNzhleGkWiJE?=
 =?us-ascii?Q?/TXids3CDx7om0UQS9wicZZGrKQhZG4sWqIbjM/BAmtZ1I1xywRvo1iGa35d?=
 =?us-ascii?Q?vOpIur+1s/ndWAdrnHot9Mx7wgZMCb5gIMspsbqKWx6YALANgHFFSNaEGAL+?=
 =?us-ascii?Q?KVwP1Eym5qiMVMKMjbbw2mt7jUWXtjHGuaMweUTfInuDiQdTJ1iq4gbf6mff?=
 =?us-ascii?Q?+ifkNYhke2IQqNexKNfQ7hUEqwkDnNeSi/uvfcYy+NcSD+cVTbtmDy5CBhyB?=
 =?us-ascii?Q?bozx+nnKhqr61oQEtxDdCbh5XMCF0bFuWxinOUrogiLG3K3a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5c56dc-9651-4397-b4ef-08de7666cc96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:15:02.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t9KvnI9qq3dgFuU6SLNaFKJH3NxYDz+8Gg9Iw1Fes4iz9vIIKdW1aPkqJ1wDXUC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-43357-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20CC31BFAEC
X-Rspamd-Action: no action

On 27 Feb 2026, at 11:00, Dmitry Ilvokhin wrote:

> Replace direct zone lock acquire/release operations with the
> newly introduced wrappers.
>
> The changes are purely mechanical substitutions. No functional change
> intended. Locking semantics and ordering remain unchanged.
>
> The compaction path is left unchanged for now and will be
> handled separately in the following patch due to additional
> non-trivial modifications.
>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  kernel/power/snapshot.c |  5 +--
>  mm/compaction.c         | 25 +++++++-------
>  mm/memory_hotplug.c     |  9 ++---
>  mm/mm_init.c            |  3 +-
>  mm/page_alloc.c         | 73 +++++++++++++++++++++--------------------
>  mm/page_isolation.c     | 19 ++++++-----
>  mm/page_reporting.c     | 13 ++++----
>  mm/show_mem.c           |  5 +--
>  mm/shuffle.c            |  9 ++---
>  mm/vmscan.c             |  5 +--
>  mm/vmstat.c             |  9 ++---
>  11 files changed, 94 insertions(+), 81 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

