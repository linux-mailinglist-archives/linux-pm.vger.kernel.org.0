Return-Path: <linux-pm+bounces-41338-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCp5OUDIcmnzpQAAu9opvQ
	(envelope-from <linux-pm+bounces-41338-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:00:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AB6EE29
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F2A300877C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD1356A35;
	Fri, 23 Jan 2026 01:00:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022110.outbound.protection.outlook.com [52.101.101.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414833E363;
	Fri, 23 Jan 2026 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130044; cv=fail; b=spXf/YwCT0T/J1cx7FqEEqUDW2PE2Towi+snxxwrCznukhd+ZAd+AfPg0HxkmjT+6bk7SfeR+3vxDtYOWefwMUZTYQ0P6/omXCqKH1F36EASWKaDU80lCutFaCIQdo6GfpXd2pf57Ad3bVL9ji1/tchSIDiElfVP0f/txFD4hu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130044; c=relaxed/simple;
	bh=uQSZI7uoRVtYx9h6TqSLzpkyAdSeOTV58/6eSbUi2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jIDn7oOVKcIJrz4xq0YUhe/Eo7j2V0zxTrPaCLbyPfw5wACBWGevxoXHz7j9VFsJXObJXoKdfSw0A2W4vMcM6TGdKaOfWj5FOtKKA12M0QDGVXtSs6d+zAfaSKAX7mzIU247o73Ht/BBvgDstMJbMTarojVwl6NWOO82UDwcnW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLpeO2aGIhYtDYQV78pSIET70ehWgANrUdHcSomaxKz7ttGlvxXpapz/fJ+Dr7JpzFCEeao++WUvl1EncOBJNAZwL0K3j2b1XcogptDWdIJpj4LRzuxAHWB7QlKDbsbbTbKb0srWJLIwGyRebzxJMhqhY88KCwyLujU5SCa7nvCNbJmWOmuqrce56AssH7E8sEP+2ppo1CtJxv8lpxAb52Tw8M2uR7nlJ8aEu3tLJcuyHSAlBIRtRIPcY5yhVcFEPJGwKUtU5E16A8yMdu4LRnx4RTMhdp0h9oXxvuXAtyUHNg9V8j7ZkvbM1f/Qqxsunwhqq66sezshrs9QYBFQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofEVdeAGI+3APA3MKderfFrS4povFf6KPKBkCfXA8po=;
 b=JK7iQdKj3yX3kyDC9Gw8rCUJLO29pTaGwYdyaYgWlcahgiBGInS3xc6lhuatBDLxb95eULN9ECIKJEQb4xJ5MMEB0hpvGaPXkd3OF27MzTr8YhePYecJEJSOZwwa+PpOm/wkbLnwUHa8WtvkyLZRp3cv8+sE9OsHWzaYlN/sEIXcno08sVDjT6pLwqGGVnhiZKnfChs5UD760S2burvKLyMPU7UNHX+qFW/YMql73ICbHYd8Gdsi5RqBFxIKOTLpMqRhjlUHEIO1+7lc7X4WXBpgTwwgkICzBfhFf85XgTE2LlshGUYqZcJdgkOq0OzawNbEtTtbqCrHU12QLIzhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7924.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:405::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:00:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 01:00:29 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	dakr@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	neelx@suse.com,
	atomlin@atomlin.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	nick.lange@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
Date: Thu, 22 Jan 2026 20:00:24 -0500
Message-ID: <20260123010024.3301276-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:408:fd::8) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e39cf8b-179e-4246-29af-08de5a1acd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okb8WBvYMtM8jCGvNmVUqQbOM1ve8fQ95flPvno1o6KK/gfOmRXqGq6X2jLS?=
 =?us-ascii?Q?oarYX1Mw2L5su4iRkm99cUcDBsjqBf+tqeXkhvSVKsIB40is1IC3st70hn3Y?=
 =?us-ascii?Q?Btj/EKBTMC5fB1mzyG0Xrj1PjQBDSW6a6az8x5S90RDwoNRsFCJ8DRVS9weT?=
 =?us-ascii?Q?gmcowNuLHRgMRZ0ODaYFJ7paltBMHZmF4wBavpb1v8VwpRIXwc7wW4uR9giV?=
 =?us-ascii?Q?fAxNxKwqVBgv2HiY+UHACSr8DGBGsAIaCLpFGqn8rGQR4rOmyYtZSGVp0O7A?=
 =?us-ascii?Q?OddbQ9deeaIZJaP3tiUNp6ZjpD+vmpk1/q1YE44N8c1hC76417TG5gQkjdj7?=
 =?us-ascii?Q?OUCVG6zkRN4X4/ugqGwXqQIXalnnfA/6L4VPSqPd5e44GZbhEWHfcwJl/Vf3?=
 =?us-ascii?Q?U5hVwgKvYMbApn+Hx4/0CdB8AxoxarRJ3pnJzmjRUIP5SwqwY8nBTZgkdXqH?=
 =?us-ascii?Q?notBImm+0eNLmlDGR8AhyFIyau3TEXEg70m9GTc4CYtQ8VXSnCbvW1VYkPHk?=
 =?us-ascii?Q?YYaEhV3ESfrl42rboz0rDXuQxfWRdaYyr65PKll5lXrLexfrslGWvPiyK4ws?=
 =?us-ascii?Q?1U8hjkr3M3fDK9SnFs+RTAYJijXihpEDMl/KcT8CyOpZqmhPWARf6+dmtCsL?=
 =?us-ascii?Q?rlXC8wC8UmgsVPXQWuS98D0U5szXUCbrZFco5BLeboTz1xKZ9pDMjU6BX2OZ?=
 =?us-ascii?Q?qG0s4kOj9txWZxQ/0ZuGlbvLKWaAJxwuRPHQAOO3k/by8m4jRMvGFjHZfwPP?=
 =?us-ascii?Q?HQipsU+NZry+gr5NfRzuV1LVazxaLYU0JJSj9Df9FkWSxTWg4zohh65EihzE?=
 =?us-ascii?Q?xDqsjb626WcgG5sY8mwyZ8FfMTYvOwPdIdgf/xwlGmkZrbIH8D13ShGluQht?=
 =?us-ascii?Q?yotvuiPgr5g78hIHj6B3ikezkH5/2/YGyxZ6hs5IVYl5w2HFBJPc030MnJ2E?=
 =?us-ascii?Q?BylhA18Yw79cIYTO1XoF1qPn6+VLdL1//u/8ERjunB76cRx/bZsK/JoCK4Mm?=
 =?us-ascii?Q?n+IATWEs697lKT4fO3yFu9a5Rs1nXv92ezU62yjSOQnByMpkPAvNXogjlUSj?=
 =?us-ascii?Q?a3Ruu6Bcc4wvuxrMrB7GO1WSmuJs5P3NA7ghBUcrUd3xOZwwHHrCL3lkQsG2?=
 =?us-ascii?Q?pKuKn2O4uoFbHjeQw2ncNZ10BlxE1hSJP3m1a9okpw0B8j8vLCHZaXakcquH?=
 =?us-ascii?Q?6G2F9c07KuYJeF1byICe/eSpDGntoOPxGbNf0Sl1xgB5a8imM0naXBkOcllg?=
 =?us-ascii?Q?5hoeGzb1VqKYIRDDz4MP6vCRwcb3jqOPUCXMMClxTO6ZCl7d8Rvpp2Cd0Y4p?=
 =?us-ascii?Q?qkY6uZJ3Bo5kZt1pxdOWI4CscMslcJAEu0KBEf+zv92XpzvJ43BfLv/w8f4k?=
 =?us-ascii?Q?PajGp5GVYIoZm5HDCqWyLBszlmGY8VOe04kItG6RjZ2bVFdiN6IljMrufVQe?=
 =?us-ascii?Q?LUTCZL/ibhRZtjub4thaJHUqOCDKDiRucC4/enNITm3ph2JOB3YRte8BuCUA?=
 =?us-ascii?Q?re85krXbycBqPWqP6CSY6u9MjRar6hJ1psGODtTThbSAD8rjX9TTtMz627iF?=
 =?us-ascii?Q?Mqp+fGivkkdRmsYx8tU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TyFPm27PDUWZVyMsfqGyL1G38gs/yAo9NB0pi2rhvLjctPzgTiJcUmmMVyq+?=
 =?us-ascii?Q?2ZxWApckuNsjs5VsGgKSrt5RRnhgXgYZRh7A0jxAZO3twJAENuTpqE/Cx8YU?=
 =?us-ascii?Q?jSjTK/0w1jP6eMF/goBfn0ZEP58j9C2Bn69o7P7uq/9wOr1ZRsnr3HjUDC6J?=
 =?us-ascii?Q?vGkFqGC36DrzZkmGRT3vlLXOsE3YXKoxRye+yNM4+xu/XBqE55i/1wS6qT7g?=
 =?us-ascii?Q?WNQ18gjm8f5Ufg52hHqQK3K0qkbK8El6GrjglLrePzmhtckKhUxffucydJnR?=
 =?us-ascii?Q?sdaFln4+G1trdhN8UNLQd+vagPaDrGL0/xFab5bMCxH3mca9K3UdYSvRvNwx?=
 =?us-ascii?Q?3clMOx/rHQFwvA2eIvCFoZ2sTFFkrTxLXeILo7RPCsKiAlMS7iQU0y2U+Ttn?=
 =?us-ascii?Q?jS524KB06JGPGlSRYO7uWcKzRot+pcYZeMhBy3j7J3admtjvZRIkzGh3wRod?=
 =?us-ascii?Q?zj/lbyQn/JGRP52s1OaM9Bp+V9OrfLWSS7R0kl8Kw7z+k2D8RODKECDsna6J?=
 =?us-ascii?Q?fBlUC+o10FKF59l0KKpLn4AnNIeV65cVfovplNoRybNu6pbp2a7DosEdVJyg?=
 =?us-ascii?Q?mpezoO/USLE99Q+xyPJ+K15q7AESg9Ip07yHucU8q8H6P8MEWVeQhYTrhdlG?=
 =?us-ascii?Q?w4G2w+iwWrjo8xscaaGXN+SzH2MfB7UD/khRpaH0xwLsrNIp5wbwpOGvYCAF?=
 =?us-ascii?Q?dxACkFZdK0XFS86FN6Hipum+O9MUlzs9Axj/7khA251KoI2xG/unv1TQgc1O?=
 =?us-ascii?Q?6byIIxdZpgPOs9bajsAn6e3L5WDBacyvJKiwbnwPHpoUrOgpGU7wI8Hf1dt/?=
 =?us-ascii?Q?ZtTT1y+p+O/p+/0Be//NKB1Xp4OXwMAqgCHn7j4rJYqTjHNpqqACQh1TogIL?=
 =?us-ascii?Q?G/WMHvAocCar95FWsowHA4PiTmXcwkKzTubb+miujEkLs7tU4Ed+wUcSYVom?=
 =?us-ascii?Q?Ssqof1t/xlGy1Itih2EaGb7Eibwg5OdEWHmF+CaofIwIV6jARNXoV1oJxQJq?=
 =?us-ascii?Q?s+m2Bcks+unjeLBTBVhz84t7m1GIAwHLjHvakW63tjxTtQbPlKLSk1om25MA?=
 =?us-ascii?Q?a7WpaK3dseL1QAsmVhkvWId+AADQ27Fyh8dIYQI3Q2Fkcch6S1z5qJKo2JNm?=
 =?us-ascii?Q?62hN7aI5ibxUh3B5rOaOTZDd2QMh8uVR4GO8XBsFs/vlNWMmXeqG8rMHLHr5?=
 =?us-ascii?Q?3vAoLVkUBomLEWVMna1Rm+PVsC2wf0NMb8bTaF3L10Y0miXLNfxNS8yp0Uqr?=
 =?us-ascii?Q?oCCe2wUmNZEAk/+mHL8ePuA+fMMJc6YQYau1j0WDyJpSqMbhyurHnCLUxTdV?=
 =?us-ascii?Q?MrSBpR1A7VxgSN9nk8iZ6RcA4SKmq5AuSOj7wGjWw2l4lq84siBLyx2dFIWm?=
 =?us-ascii?Q?ZhsN7dOw66iDJDD5mKndqQ8aNI9JFz8oWOcsPWe7Ypi2bFzcN9iQc+PpSWv5?=
 =?us-ascii?Q?hDXXatu96QOYwqQJ70Qo/aIH+/+0LIMHlt+zO5/yrEDoZUcuGQQ7lyZnCKb2?=
 =?us-ascii?Q?f9ybXNGNuwxUawfYsxfXpci1RauyqZ9Xir4NgDyhm2I1eNBiA1c7bssI8PyS?=
 =?us-ascii?Q?X00aoL7+SF8J4uAfIbBC3unipN8KsZWHE/d87FiHM2bbUetyCOYQtx6bMZLx?=
 =?us-ascii?Q?tUzQIuMc4eig7vGYW3bncEfVQzIiuMKOc5u0CNH9cMyNHK2/ZYUQqevNQ42a?=
 =?us-ascii?Q?2Xc62P9aEOZLnQKbznbK6YSH6MDGStxhTEJM52vpb+TIMfYz7zoDaiooKU6T?=
 =?us-ascii?Q?HqnFklEwcA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e39cf8b-179e-4246-29af-08de5a1acd35
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:00:29.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OPZ8WtCfz1rJvWmKuWdhib0P5SQY5nhstzKHeF5/QKhSOGYwGhIjdt464Lv4A1W2uE3noOjAhnj/FoiDLVLKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41338-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,atomlin.com,ashe.io,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B6AB6EE29
X-Rspamd-Action: no action

Users currently lack a mechanism to define granular, per-CPU PM QoS
resume latency constraints during the early boot phase.

While the idle=poll boot parameter exists, it enforces a global
override, forcing all CPUs in the system to "poll". This global approach
is not suitable for asymmetric workloads where strict latency guarantees
are required only on specific critical CPUs, while housekeeping or
non-critical CPUs should be allowed to enter deeper power states to save
energy.

Additionally, the existing sysfs interface
(/sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us) becomes
available only after userspace initialisation. This is too late to
prevent deep C-state entry during the early kernel boot phase, which may
be required for debugging early boot hangs related to C-state
transitions or for workloads requiring strict latency guarantees
immediately upon system start.

This patch introduces the pm_qos_resume_latency_us kernel boot
parameter, which allows users to specify distinct resume latency
constraints for specific CPU ranges.

	Syntax: pm_qos_resume_latency_us=range:value,range:value...

Unlike the sysfs interface which accepts the special string "n/a" to
remove a constraint, this boot parameter strictly requires integer
values. The special value "n/a" is not supported; the integer 0 must be
used to represent a 0 us latency constraint (polling).

For example:

	"pm_qos_resume_latency_us=0:0,1-15:20"

Forces CPU 0 to poll on idle; constrains CPUs 1-15 to not enter a sleep
state that takes longer than 20 us to wake up. All other CPUs will have
the default (no resume latency) applied.

Implementation Details:

	- The parameter string is captured via __setup() and parsed in
	  an early_initcall() to ensure suitable memory allocators are
	  available.

	- Constraints are stored in a read-only linked list.

	- The constraints are queried and applied in register_cpu().
	  This ensures the latency requirement is active immediately
	  upon CPU registration, effectively acting as a "birth"
	  constraint before the cpuidle governor takes over.

	- The parsing logic enforces a "First Match Wins" policy: if a
	  CPU falls into multiple specified ranges, the latency value
	  from the first matching entry is used.

	- The constraints persist across CPU hotplug events.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/base/cpu.c     |   5 +-
 include/linux/pm_qos.h |   5 ++
 kernel/power/qos.c     | 147 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c6c57b6f61c6..1dea5bcd76a0 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -416,6 +416,7 @@ EXPORT_SYMBOL_GPL(cpu_subsys);
 int register_cpu(struct cpu *cpu, int num)
 {
 	int error;
+	s32 resume_latency;
 
 	cpu->node_id = cpu_to_node(num);
 	memset(&cpu->dev, 0x00, sizeof(struct device));
@@ -436,8 +437,8 @@ int register_cpu(struct cpu *cpu, int num)
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
-	dev_pm_qos_expose_latency_limit(&cpu->dev,
-					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	resume_latency = pm_qos_get_boot_cpu_latency_limit(num);
+	dev_pm_qos_expose_latency_limit(&cpu->dev, resume_latency);
 	set_cpu_enabled(num, true);
 
 	return 0;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..556a7dff1419 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -174,6 +174,7 @@ static inline s32 cpu_wakeup_latency_qos_limit(void)
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu);
 s32 __dev_pm_qos_resume_latency(struct device *dev);
 s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
@@ -218,6 +219,10 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
 #else
+static inline s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
+{
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
 			{ return PM_QOS_FLAGS_UNDEFINED; }
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index f7d8064e9adc..6a12f1143358 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -34,6 +34,11 @@
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/cpumask.h>
+#include <linux/cpu.h>
+#include <linux/list.h>
+
+#include <asm/setup.h>
 
 #include <linux/uaccess.h>
 #include <linux/export.h>
@@ -46,6 +51,10 @@
  */
 static DEFINE_SPINLOCK(pm_qos_lock);
 
+static LIST_HEAD(pm_qos_boot_list);
+
+static char pm_qos_resume_latency_cmdline[COMMAND_LINE_SIZE] __initdata;
+
 /**
  * pm_qos_read_value - Return the current effective constraint value.
  * @c: List of PM QoS constraint requests.
@@ -220,6 +229,144 @@ static struct pm_qos_constraints cpu_latency_constraints = {
 	.type = PM_QOS_MIN,
 };
 
+struct pm_qos_boot_entry {
+	struct list_head node;
+	struct cpumask mask;
+	s32 latency;
+};
+
+static int __init pm_qos_latency_us_setup(char *str)
+{
+	strscpy(pm_qos_resume_latency_cmdline, str,
+		sizeof(pm_qos_resume_latency_cmdline));
+	return 1;
+}
+__setup("pm_qos_resume_latency_us=", pm_qos_latency_us_setup);
+
+/* init_pm_qos_latency_us_setup - Parse the pm_qos_latency_us boot parameter.
+ *
+ * Parses the kernel command line option "pm_qos_resume_latency_us=" to establish
+ * per-CPU resume latency constraints. These constraints are applied
+ * immediately when a CPU is registered.
+ *
+ * Syntax: pm_qos_resume_latency_us=<cpu-list>:<value>[,<cpu-list>:<value>...]
+ * Example: pm_qos_resume_latency_us=0-3:0,4-7:20
+ *
+ * The parsing logic enforces a "First Match Wins" policy. If a CPU is
+ * covered by multiple entries in the list, only the first valid entry
+ * applies. Any subsequent overlapping ranges for that CPU are ignored.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int __init init_pm_qos_latency_us_setup(void)
+{
+	char *token, *cmd = pm_qos_resume_latency_cmdline;
+	struct pm_qos_boot_entry *entry, *tentry;
+	cpumask_var_t covered;
+	int ret;
+
+	if (boot_option_idle_override == IDLE_POLL) {
+		pr_warn("pm_qos: Cannot be used with idle=poll\n");
+		return -EINVAL;
+	}
+
+	if (!zalloc_cpumask_var(&covered, GFP_KERNEL)) {
+		pr_warn("pm_qos: Failed to allocate memory for parsing boot parameter\n");
+		return -ENOMEM;
+	}
+
+	while ((token = strsep(&cmd, ",")) != NULL) {
+		char *str_range, *str_val;
+
+		str_range = strsep(&token, ":");
+		str_val = token;
+
+		if (!str_val) {
+			pr_warn("pm_qos: Missing value range %s\n",
+				str_range);
+			continue;
+		}
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			pr_warn("pm_qos: Failed to allocate memory for boot entry\n");
+			goto cleanup;
+		}
+
+		if (cpulist_parse(str_range, &entry->mask)) {
+			pr_warn("pm_qos: Failed to parse cpulist range %s\n",
+				str_range);
+			kfree(entry);
+			continue;
+		}
+
+		cpumask_andnot(&entry->mask, &entry->mask, covered);
+		if (cpumask_empty(&entry->mask)) {
+			pr_warn("pm_qos: Entry %s already covered, ignoring\n",
+				str_range);
+			kfree(entry);
+			continue;
+		}
+		cpumask_or(covered, covered, &entry->mask);
+
+		if (kstrtos32(str_val, 0, &entry->latency)) {
+			pr_warn("pm_qos: Invalid latency requirement value %s\n",
+				str_val);
+			kfree(entry);
+			continue;
+		}
+
+		if (entry->latency < 0) {
+			pr_warn("pm_qos: Latency requirement cannot be negative: %d\n",
+				entry->latency);
+			kfree(entry);
+			continue;
+		}
+
+		list_add_tail(&entry->node, &pm_qos_boot_list);
+	}
+
+	free_cpumask_var(covered);
+	return 0;
+
+cleanup:
+	list_for_each_entry_safe(entry, tentry, &pm_qos_boot_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+
+	free_cpumask_var(covered);
+	return ret;
+}
+early_initcall(init_pm_qos_latency_us_setup);
+
+/**
+ * pm_qos_get_boot_cpu_latency_limit - Get boot-time latency limit for a CPU.
+ * @cpu: Logical CPU number to check.
+ *
+ * Checks the read-only boot-time constraints list to see if a specific
+ * PM QoS latency override was requested for this CPU via the kernel
+ * command line.
+ *
+ * Return: The latency limit in microseconds if a constraint exists,
+ * or PM_QOS_RESUME_LATENCY_NO_CONSTRAINT if no boot override applies.
+ */
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
+{
+	struct pm_qos_boot_entry *entry;
+
+	if (list_empty(&pm_qos_boot_list))
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+
+	list_for_each_entry(entry, &pm_qos_boot_list, node) {
+		if (cpumask_test_cpu(cpu, &entry->mask))
+			return entry->latency;
+	}
+
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+EXPORT_SYMBOL_GPL(pm_qos_get_boot_cpu_latency_limit);
+
 static inline bool cpu_latency_qos_value_invalid(s32 value)
 {
 	return value < 0 && value != PM_QOS_DEFAULT_VALUE;
-- 
2.51.0


