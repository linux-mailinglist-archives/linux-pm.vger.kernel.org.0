Return-Path: <linux-pm+bounces-43359-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEvZJ3tComlz1QQAu9opvQ
	(envelope-from <linux-pm+bounces-43359-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:18:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022661BFB0B
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B370F302DB50
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5092EBB8A;
	Sat, 28 Feb 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nm8j+ArJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78914B950;
	Sat, 28 Feb 2026 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241442; cv=fail; b=nmwyhZvNd7XAjLM5L3F6ioK+SNm/+DudkZs6spHSExK8SqM1cImS33aJK0ELLKN+C/r2Q7aNIOLEzOzd/lHEhnH3RNUtbf7FBI/SDIrzx9PnGivfVVUX8fipPx1xMbrJjbeKkkT229AML4y6xM0Es++yV+1wE2z9r+wxRs8G2c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241442; c=relaxed/simple;
	bh=VjiEztM2F5IB855WqpYIBpsYI2DiQJFP8wCYGrPuM+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqObFijd542WqexQxbgUZw94p6tYwjVHuMrAA7SsRqVcF5iN4wCpPSeMMSh3u4CbKsMh592Vo9lwvVjNr3es7k2d6qFnez7PBXkFfvnRhKaiZwNCm/R81ffT8/pBB4MelWEgz/4PW0l8eQ4h06irhc4EYlhWkvuzAmw+J9FZO4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nm8j+ArJ; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkiII3M1jked+rKrWdeyY3XICJZWS5Z8r0xoyQmyeDhDtiPfVT0fODo/KbZgoP657hE1yYR2bvnZyC1IQvVrB+ThgL5He9pPbpet/7Jv51AoF+pfWlkLWpWcwRlfUk9fLAgRsX3rLG7kR9bXx9bwqB0/fT/30Z6J85xIkpnx9fRCGWr65fb7UKUBD8btinrEa7IYvomECv+ezuKuoCGW3mqYC1chtAlUReI0DvQNxCw6V1ENn5Nfr6VGecJ9JpYOJ3ZqQGN1ZSn16l1hVk55dqPli8/crZYjUcsn1uPcFVmrA+4FCp1ZSrOwRBXoErMtGMKRYb/1obmu6/SFvNAV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIWliT7Ly15LywCUQrZfDvcxGAJQBO5AYWBkKnIBqNM=;
 b=UQ8s7xVD2i77kV133jdMy63TDqDpq9QF1fl53kINe+p7K4+KUwgx6hRUjfv2xIN1BOG9CUQIZJY6DjuVnA4Mfw5Y9ibEHTCfQINLooG7R/p3A2e47ky39WQLvmYj+OvnOUYnXQLX6PzZfUiaP9ifVdLvJgnUHqbMSWWAsS6YVCpmbqxkCfiCzuIXd+l4AC9OmxcnqsfQB+xshNL5IRx/99X7B8D3LhVBeMEKeKMuAYKGI/cLjUTmfXzUektWSXTyWeosLe9CVK87crz21ZmOHBMm2sc4uFvV2jezoTjJMrv4V0+aXT+THR8a7ylfr31uBr0jWKXiVC6ak6RcZOT6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIWliT7Ly15LywCUQrZfDvcxGAJQBO5AYWBkKnIBqNM=;
 b=nm8j+ArJ3P7PgX1l2fUcKhAK+HvPkWPlVgPfGSeA3Hj4+ksvVdyRrZ1Gow1SKWjaUrT26V8SzkDuNf+jexoQ22dGA8+i3nzSG3aj8js+pE7o/PVW9qmOrc3xMsLQFuw0YpiPHbSB7mIVyWIHFDB9ItCyA155D4MGV1F3AEhlgEpcynEKfDB5vO/SyBPYCGxjmp1XlsS9XQf+NiFdtVdJp/ZtkRayHgUIAnffY0CLE/wh4+HBkuavKWdC5EKN6nXIo4dBxmNqjFYPBinvWEoigMauE02l22Zvt4NfKrJpA0ADU2CVaf7mCD4BIZppvVCq+gohwsWAduitvXFIHlM9fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Sat, 28 Feb 2026 01:17:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:17:16 +0000
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
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Date: Fri, 27 Feb 2026 20:17:10 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <0FDFF760-40A3-4910-906C-AC13C3396B5A@nvidia.com>
In-Reply-To: <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: d06eaf9f-6507-4927-aac7-08de76671ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	w7+IScq2C8MF1G+NIrm29MjwbXHlXc+sNZQHp7HtY+5o861kxPQhtoMXJ2yKAXbLsi+PDQ26Q6hFnW/T9su36ZRiSG8XWpF7hcovd8F889QnzyX401PPm8WWrrhX2G+/DnHl+6bbaezTU9xZDaBwuDH9SOE8PzMt5wHEeJZ9MH1z/gbjStu6TXCDhppOY4oE8/DgnjkrCAvQI2d0O36VPiBw79p6A/zGuUOfzLiId2gaX3zmVxX0HV5CfxUlQa7ENgnt8PMsxBrMP63LjhsMFcAsEFgWrFVrBNafh6taBPIvXAZsO85y07y+5A3ehf3LFbipCdVNOlTFB47Dfsv5eoRzTVN61bfG0AjokSLDIVEUf3n5UL/aRwifTqIM00FSS4YnOsepfrUZ542V750uiSZaRdDSVDhRVH9/RluJ3+REbUUs5rf9yYQfK3Vmzmlb22puD4wnAJZoxA7CgLMcZHnjZvBpwP60gOzhAjNwn3KgBtIvayLfMBEI+bP+nbLQ7+CgCyxMTkq3BTSIgvCjuRgoga7Byj2HxL5RkaHNMhQkgmIMnqva/XpYMcyt3vhfwkGTI4684hecEoQrIZzSnfe1NjKq0jusC8vOaUZTq9lrEfj7P8SiWU0NWU+mHbcx/We/VAdufcyS+DdP3U19cNZCJyu+u1e6lw0tKxIwjx3FQ0PtRHrS46y/ywhmBI9grmfmzPfBU13z59nxb36bRIveEWtIhjWZ/jSixOoEI7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lpUCFs6cLdsQ9nO3SQWM+uypaldZ6RfBZpNTAF1TCb7iJ9MFOmj3Fts4Lx8l?=
 =?us-ascii?Q?ivg+z3s00sfquKLQRN/4UuLctU9xEvZD1cEpJx4YXHf1GdB2lausZGEP3Yr5?=
 =?us-ascii?Q?qXV4tRcyTTNWSoHfXzzCkDyOMyA7ubh6iND1e1BOZ2+1sg7g9Ye0ifBtV9z3?=
 =?us-ascii?Q?v2NJKlDuA/TnETd/Bc8bCUlbFJR4vY0/40E4UbHlQhFdxroOoilvMnSRNKqL?=
 =?us-ascii?Q?wBURCXJGyXYl6lcuzo8lNLbrb+ioalLOTFTIkDcDlspwdM2Hpz/jnflte0qp?=
 =?us-ascii?Q?nb/IVffjhRlRVQRxS3Lft+yr8TrsR1WFtJ1xSxEM507HcLS1pWmKIkjS6079?=
 =?us-ascii?Q?dHGH/tRojLWqNx/51lKsqTxzBvQ8yqXuSPfjQlCb88LlagKsMeN3e5l42aYw?=
 =?us-ascii?Q?NA8RwbQ8NiaMhvGPkfRR4xjcKccz6vDgXexQLyhsFY4i9rroJrbuj/p3uaow?=
 =?us-ascii?Q?wc8Ii3wXrUazmGofa12KryqEFpMNYz7tQKZvTZ3ePz1p0+u1095GHwYW0vuF?=
 =?us-ascii?Q?rxIi/XH6VOUxoz9cj2tKTTtBsBX5RzFkRQQOMF4UIVjRb3a7Z+CQNq0FPhqU?=
 =?us-ascii?Q?HiOjrid+H97PuZ1RuR2UzXDVM9QyXFUJTK8bYD++ZVgYq4K+UXUin0VbcAzU?=
 =?us-ascii?Q?AqHCfxV8FgTMyBNroTCqGtwGokcWC2d+Rac6BxoGjOWvzxAnSyw834VFh2b8?=
 =?us-ascii?Q?WFcTDhjByD2mCBEVxNB/5IBKoRhldNBugdArTn9U7VWhNSGs8MUB0d9Cf8ad?=
 =?us-ascii?Q?LAILbWl4X+gDIEjk2OxK5JQ/tQ479yW5sQSFlRuWyQNv5fC2IxYzC+qxiO85?=
 =?us-ascii?Q?+V09r2LzLBdVEMd/FnPUJdTJZzSEmyWkOpZddENaSPGeXfr/Sd1vacJD8D/7?=
 =?us-ascii?Q?d68XGAXHu1J2xtHSDGHE4Ebn2yRS5diexcO0oYC4knqHHCjKCvdDidTVbNEC?=
 =?us-ascii?Q?9FDZ4EOfmYfnDiDRwmGDvZJ52tuqqOzIG3yOiBdHnl7bMfiqumdKagHScbYT?=
 =?us-ascii?Q?l9wKB7TznIaGs0gKoXiGWDPAQU+dFWx0Gr73fK9D5oBf6ilog2BAgMJ93vUh?=
 =?us-ascii?Q?x4xP9QeHGHTaT/wEz1poZ06f96g22QmFMElA8oSySDXU7KAnaVHR91e1uLP5?=
 =?us-ascii?Q?Z0G0f0tERZry1xJXhlinjoNDKTFttJ5NFE0XqK9zlIZdK2C/DekJ5C58fKLE?=
 =?us-ascii?Q?YcGwkmSmKNbTae6TKx0cDrBBkFTLSPLsgZQxyM7QCD2FIl0suKDwgCX+j9Do?=
 =?us-ascii?Q?OQ2v+jhwQItMccJsLoaar5VyL2t0Dfx1kklTImPLQKiYhsBRupcWNsssE+82?=
 =?us-ascii?Q?lBnCFgULDybBXkxHvBmCEeZ485mH9AQ127U7EbSZMpHB1uVQZuiHlrY21jm3?=
 =?us-ascii?Q?0OsdCOUwX2mNR8uRxgSGwZm2D0cvCeyTQhM2DFl4/+MFQxOqYxu3e7HZzdyp?=
 =?us-ascii?Q?Yc0ttiUqrtl56wIUJIHBmDQZ/zlT8BLx5dBaw9Tr5210PYJ4yFzcqZc/kksz?=
 =?us-ascii?Q?2IrE7ZtxF3zdgT6+9gH4Kb3qDf6jPtkAhWrpP4PL4BkmxhyMmJityhd/fz7p?=
 =?us-ascii?Q?4Uqug2GwJqZ/chNUHwjxasU06mkPDQJm7MHkulRTIWcQqD0AYIPJqbO7pbsN?=
 =?us-ascii?Q?yajlxjWfTPTaA3FPHxLF/NH2Z3ZIyg3WtXYz4UQ+Mr42BDBrBrUWXTDZ4M8S?=
 =?us-ascii?Q?hG3SYjDvb2CmV71g8cK/66snA1zIcFtCfi7oYd8eYMJsTch+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06eaf9f-6507-4927-aac7-08de76671ca8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:17:16.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZSI8nFe1PkSTbKpwquhZG4X4nTOQSHNHXozeMWS6EKeInor88oM/5CptHJdVaaF
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
	TAGGED_FROM(0.00)[bounces-43359-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 022661BFB0B
X-Rspamd-Action: no action

On 27 Feb 2026, at 11:00, Dmitry Ilvokhin wrote:

> This intentionally breaks direct users of zone->lock at compile time so
> all call sites are converted to the zone lock wrappers. Without the
> rename, present and future out-of-tree code could continue using
> spin_lock(&zone->lock) and bypass the wrappers and tracing
> infrastructure.
>
> No functional change intended.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/mmzone.h      |  7 +++++--
>  include/linux/mmzone_lock.h | 12 ++++++------
>  mm/compaction.c             |  4 ++--
>  mm/internal.h               |  2 +-
>  mm/page_alloc.c             | 16 ++++++++--------
>  mm/page_isolation.c         |  4 ++--
>  mm/page_owner.c             |  2 +-
>  7 files changed, 25 insertions(+), 22 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

