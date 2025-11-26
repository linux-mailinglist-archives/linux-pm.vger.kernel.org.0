Return-Path: <linux-pm+bounces-38692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AFBC893D5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6153B7044
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065131CA54;
	Wed, 26 Nov 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aFoKVc5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC5302CA2;
	Wed, 26 Nov 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152228; cv=fail; b=VvzdPGyuihezZG4C4X4erfJ/1TnBf2wipLb5NzWZE+HaAq8hWt4wiedtYpwlBtzu4crlteQdwgN20OuRf+u4CXhE/QlLvkayHkSFDW6CTDpVJ2E75LoAld0YU34UAbxVu/atjdKi2nY+i3EcdKkk3o7P+fWUEmjzFVveAbkdGoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152228; c=relaxed/simple;
	bh=WcVL2HCfkBKduxVmVuNQ2vCeOfZ++S4mxzEpxBSUpy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqNUm3qU7nw/eN37FVAIcqGYy/IbK8EFkcBBOgSjA35ej1AF0pL00H2tjOh/kzeDI/71Vrbdik/Tyy57Dgn1ioK5s3/ekRucyg87FxQzAo4tCaJeJyJjrKcQZCuBKy+LqkOccFSM5+JrdgW07vFyOFD8YGAVqWYAPM4lVHJO25o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aFoKVc5x; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXVsd8suKM/JYu3K5XyO4qoojhMxXnAG4pi7U18HZQwfGobIf/w6McKpM220lDlCtG9TXvt/uWagJV7+ROZKVMvMUf4/5p+qVtZ86paj7dGhSVFnsOlxMYKRcESJ/eQZKXP9H0HzswbXZdprYtC+2U9t5yK5sdtw3GfgJ80jBErdS1bi2G+P3V8lR7WwNhVySEAcgEIBr9x5dowiA0KG1phuunjjQTHIBqmtmX0vElFnwf3WAVaCU4Wigqc+Rpx0+rsBp85UPOntzpVQryu68S/utZ/vHQVqqEQKt0LxxpmikM9h2K0cPCozURP6DdJqe/0+BB2vIz0E5qf4he3M5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV+/ELoOPdTCP93j7rq7G0HuGXxD/d/lp7gCMlDfswU=;
 b=FPKaZWrhrG4re1NfGAkqsaXi4ukhMbtoKMjvBkdydohcQ2nl+ds6hiEkOrOIpi9OX7zpU8BDWkCHTNDC1mpXrSVYdEYCBg6IEU850GaZ5QUbS+PGSAMaZy0BQXhsmK2K2z5z5oLzcUHq94bH5aIR4h8EXRZQXYEhrI2HZN66TohyGaClDzIWSbmwH+xfqwUTkxuAccZoSANGDcliPbFe498xt3cYeRHoAPaKPG5uvyJU0v5kPklud2/Cp7IPWz3X3BV++0JodHa1CDSd7uVl9RSuSM0EvHZVht8kIV6b2C/j8tRD6peZkn+jeKI5fq8xiZ5rKExtqtARF98Ca+z2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV+/ELoOPdTCP93j7rq7G0HuGXxD/d/lp7gCMlDfswU=;
 b=aFoKVc5xBfiBSuoQeHE0ndItJfl1Bj3BXae+AZVK5U1bLUn0SN7Yu+C1gLKZtGAfXRIcacG9YlqWkNeebETZVgEzyR0isaQghexijv7GM3vxDiBzs8ZWDqVHWAt8jDHKCQV01Pd9HNCfzETYysaDtwszzeim7Iyc/M25dKj3TcT07DbVQgEl7kTlkxGRd0jSQQEsXoIOYQ2BkesqErniEdY9SEbHgxPly+Y9dVQjdOlBzkCs3MPlvpMEajn12gkYrWocb+kxf4duftWZxd3eT5JB90AwJZrDEL/cNJkqhI/KyWbwWhg/AaNBN6Jad/itJlNHlXlCoa8Knkqs1z0dzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5211.apcprd06.prod.outlook.com (2603:1096:400:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 26 Nov
 2025 10:17:03 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 10:17:03 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume and runtime disable
Date: Wed, 26 Nov 2025 18:16:35 +0800
Message-Id: <20251126101636.205505-2-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126101636.205505-1-yang.yang@vivo.com>
References: <20251126101636.205505-1-yang.yang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6cb58c-599e-4c93-8c46-08de2cd4f1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ufe3+qaiqo/G0ujfBfp75db4yBnjFgPRrPr71jXPmlnkd9yphAYeH+7vBfCd?=
 =?us-ascii?Q?lx8pqPxtFFe4/qsnQx10AazYGG1mtyBfdWecDSqQOd2wMeY+C3xjZxWo4GnZ?=
 =?us-ascii?Q?rO4L7gzLwsGNAlbcYfjDUDG8oyLLZ4uZDjtnYcBzAZzmg/vhq8GsVmK3DRCE?=
 =?us-ascii?Q?+5J3uyzSy+f4QPG7MkQmBKwitjXLGGeXgfOh9TIObOa0lOdZXjI532R4xcdN?=
 =?us-ascii?Q?84n8Ibifq2YtboMQcezc/H0wtML0oxNyhNGsBJkdQfQOx/D8lJd1guL56qa5?=
 =?us-ascii?Q?i6eMf9N/6QOEVMKrFFKTCC+Tt1FtH2vVkFJLck5NleN1A4e7RzJBdm2TmdXA?=
 =?us-ascii?Q?1OSMsNba/rhlES4p7f5hVSvgyP5q7AENJ+z/NAvyX15IMjABWoPjmFmV5i71?=
 =?us-ascii?Q?IENgP6AK1MQBoxXPjpuLWqEO4UjCvBZt6wxMBxGWj33OgIuNlGkvUwzQU1Ly?=
 =?us-ascii?Q?9AUAhFLhGBG9xBpa3ALA7xWMztF0skvSNixRNUF9Uf0hfx6pRpNCtEk1kJqA?=
 =?us-ascii?Q?EWviuvaOtBNWJRbSeqODzxvWIUaaQrJtP2y7Be+2VAnv072F8KU4wAxY14sn?=
 =?us-ascii?Q?R49fINFjhuAs56gNijYbf1SmrqlleVm1kOQyOMnwmgQz/FtzhM/poU53ptGG?=
 =?us-ascii?Q?nvlvrVwPZ4cwFBzo6EjS5M44nDivcPsWvAWb+hY0ggovMJfcVDiyrFVrhU10?=
 =?us-ascii?Q?UZpIL6a6cLwYUD+UzoRpLso5iHYSZW74YzJn7XfshMHh7yUop3Az8YrWczRV?=
 =?us-ascii?Q?Gxy2rJkIt3JDD5go19txhUoYGh/ikDJQcJQsZfn3AGca38+I7PNfez7pY9l1?=
 =?us-ascii?Q?W3LSzUTO5XGNbsggF2zOEi4nQo0yc7RPThe4uD42WaaBjx+U2Z+tEGUURBqJ?=
 =?us-ascii?Q?fGIr+1jqalGBH8/YueYdxLs1G0Pgp029nJppBzrI5GsYUnc4m4RqrhbaGaiJ?=
 =?us-ascii?Q?099s7oLIEZxEeVE+j/VFrVu5/mcPEITcsb75OnFS5qvXlm27An5sHofwwl7v?=
 =?us-ascii?Q?E0Po0pzIQZCdjiqM9EMjdBSIER/0d6GMBDHAkybqjht0DrBK3Sc5onh16TO5?=
 =?us-ascii?Q?6zbQowidhbsw+u6Tjk9x34QyzTQDPvvutiI4LxqsduXinXZy4j0gKnBM5OIi?=
 =?us-ascii?Q?IO0eIrZDZEz62Z5r1XalKN1lVempcFZ6VDNFL+y+1cMwNzTYpAv602aZatL8?=
 =?us-ascii?Q?cCyOy+HRTTvEDJ7RPdcJvY61cqZ33XbrFKNuJNf1y3tjXVDwovfTvha8tDs4?=
 =?us-ascii?Q?OWTjoS9fnVwADzREYDPCapM6MOnvbYSANgoTcWRX9eYi4MqPNl9+B0D9npYQ?=
 =?us-ascii?Q?B+zrd95OywbfSwFHPtX1UGGIJZFdptHt1dtvh7Z1UlVMMdUPZ88N+PsVqIXv?=
 =?us-ascii?Q?KzMO1xhzpah5ukA8wh5LiA4FAIfvnhSPVvZ7meccMi9f5IDTj59D4uGUtln8?=
 =?us-ascii?Q?laKYvGom50AIee8YNoPAYsptJMAYPN3uPnmfiC0MM6S/5AlRrKait0hcS2b6?=
 =?us-ascii?Q?tQG57uWC9C23a3Yn8cws9ZB2pI5ek5aSNIxM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRp+EizPB0Vm4tD6BLCcCfyatTb3GhxkQFrx77i5CLrzdDsAKK3DPxnROnDL?=
 =?us-ascii?Q?9/5pSsYHZmfrOpjkNXRiF5mck3D0MvV8bgCXSY0z8kFzqLjwVuOv7heZGQZF?=
 =?us-ascii?Q?5WFP/TMsjiNrzRGUO2WRIpUpy7MYpcVJdNXSj/QMxt+Jrm7bGR7g2MLZw4jM?=
 =?us-ascii?Q?rK3ahyMdeteRjI8prHL1fajkh1M5Ai1VJEtk3Lo/KV1FNLtmc7UJeCDF0jYp?=
 =?us-ascii?Q?MEVqMwwss2kqlvEu39lOGLZeusxjiiowQHgvh0YeywxEgRFZYgwguUHqDy04?=
 =?us-ascii?Q?WLjmw+q3WJAIRt93QxwheP7dtFm/DFAhRT5cUW+Rw86hlgt/y1QDOM2AARVn?=
 =?us-ascii?Q?AD0Cz3INXW28n2dXNSaBeJ2gOSEJGY/LzRfWr/SlsHp/de+N6iprmV0O8gNc?=
 =?us-ascii?Q?qewClJ45jS4rJ8nCjU0WbJKZfHeGYoxNUg0cYYXnSZXjXWYLobZMrqJDjMpD?=
 =?us-ascii?Q?C8Ijql4k3ctw3/2HMhRgdN9MBUA2fWVBTEM7kOjUeSyQoJvT3f/Lsx6OOXa/?=
 =?us-ascii?Q?mGV7WAGmLnxcftu6v4aAnWWlhWKM26YwU8SbTAUOnkZ+JZ3uobZRX2BDMCrO?=
 =?us-ascii?Q?V9SISuzHIw8H45cf3C4xJWfyoZq6WTd9nzSZJSf1LVCOdsDqydYfsFMBLuWU?=
 =?us-ascii?Q?eHDE33mqjQUQ415/N85tUgTZUHqZ3wWpVujzPnIvgHD5PTwIIZ/FKSJOjZPX?=
 =?us-ascii?Q?Jjhv28mg+hacIcarX6fD0JPDAyG9YSAqTuAz6rMYxVwUJ6BneDarSI0fv2gX?=
 =?us-ascii?Q?ifk4/mbKzNc48ruTUpe9qfHbI1SEfZ37W18hr4mRWYPBw2ocmHg6J/t1RKLm?=
 =?us-ascii?Q?FcPzGwJ/rotmt4C4GJdY5fjbNVG1URACQPL6CHQcq67z63rl38vPhySnLSo2?=
 =?us-ascii?Q?V2VLQGwjQBfQ6YqXqr9lf0I53cW2Z3X3s1KmKpF4FyQNvJIT7yg0OWI+AYHM?=
 =?us-ascii?Q?8c3omVVYxi/9qmuOmz3VQbaYLruK7KiprzenuHPgvAMFEhYFyBYD942qZyLT?=
 =?us-ascii?Q?XAIx71U0hQVj6HvuIGR1R3ZllMRV8FfSMRBLksVBT8OYLcBXsrH83A6ukP/a?=
 =?us-ascii?Q?A+eCTVHE5Y2A08m08pBVteU83RB9da9Bi+jUztygeh3474fLuMwPyIVDEIFn?=
 =?us-ascii?Q?LzSF3DW6y87/fcsSzNdCPvqF57urvjOCRkuggjuX3P6lZttv50Nho10Npl52?=
 =?us-ascii?Q?bQ65vbe3I+5Ec2Q1941pahoKbB5OehhwCe18cMB+c/WqyOB+GYA/cEuADkhx?=
 =?us-ascii?Q?LLA37t+72Z9ApbVUKuJ1dSLSOpWM3MJnw6hxvgo3HXvh08lOTq/nEIJ78O3l?=
 =?us-ascii?Q?FznxposIx5pK/3opGC82CSEdBFqrgOk4r/Rx/h+Uze+/+rvU6WCpD1Rr7ohk?=
 =?us-ascii?Q?QwLLHbg6d2UUUY/w5K8Fjfgo/RR+o8ll331lvjvNd2HUdhoqnVjejv1UXYxw?=
 =?us-ascii?Q?P98BOM2ZSEiwDzZsTF59P/Ats9IZeyJwcQN6HNubD4JNMOv9+7WwyDEi4flR?=
 =?us-ascii?Q?W5T7OmXMfXZsBh4u/1G4hklckD0x9btTcjmNC6YJIucAjMstK1ys+V2599fn?=
 =?us-ascii?Q?v/tXGnYCJ3UGoahJbJTSI+4OczpfaIvHwsqmqJsD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6cb58c-599e-4c93-8c46-08de2cd4f1c3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:17:03.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFW4h9uzyKJ/e4V2kwVZBrx7GJP58LiPvkqT9DJ6mfH3cW3+7rgOho29tIvGlDd6NZ5fmxuNMiF7HvDviYprWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5211

We observed the following hung task during our test:

[ 3987.095999] INFO: task "kworker/u32:7":239 blocked for more than 188 seconds.
[ 3987.096017] task:kworker/u32:7   state:D stack:0     pid:239   tgid:239   ppid:2      flags:0x00000408
[ 3987.096042] Workqueue: writeback wb_workfn (flush-254:59)
[ 3987.096069] Call trace:
[ 3987.096073]  __switch_to+0x1a0/0x318
[ 3987.096089]  __schedule+0xa38/0xf9c
[ 3987.096104]  schedule+0x74/0x10c
[ 3987.096118]  __bio_queue_enter+0xb8/0x178
[ 3987.096132]  blk_mq_submit_bio+0x104/0x728
[ 3987.096145]  __submit_bio+0xa0/0x23c
[ 3987.096159]  submit_bio_noacct_nocheck+0x164/0x330
[ 3987.096173]  submit_bio_noacct+0x348/0x468
[ 3987.096186]  submit_bio+0x17c/0x198
[ 3987.096199]  f2fs_submit_write_bio+0x44/0xe8
[ 3987.096211]  __submit_merged_bio+0x40/0x11c
[ 3987.096222]  __submit_merged_write_cond+0xcc/0x1f8
[ 3987.096233]  f2fs_write_data_pages+0xbb8/0xd0c
[ 3987.096246]  do_writepages+0xe0/0x2f4
[ 3987.096255]  __writeback_single_inode+0x44/0x4ac
[ 3987.096272]  writeback_sb_inodes+0x30c/0x538
[ 3987.096289]  __writeback_inodes_wb+0x9c/0xec
[ 3987.096305]  wb_writeback+0x158/0x440
[ 3987.096321]  wb_workfn+0x388/0x5d4
[ 3987.096335]  process_scheduled_works+0x1c4/0x45c
[ 3987.096346]  worker_thread+0x32c/0x3e8
[ 3987.096356]  kthread+0x11c/0x1b0
[ 3987.096372]  ret_from_fork+0x10/0x20

 T1:                                   T2:
 blk_queue_enter
 blk_pm_resume_queue
 pm_request_resume
 __pm_runtime_resume(dev, RPM_ASYNC)
 rpm_resume                            __pm_runtime_disable
 dev->power.request_pending = true     dev->power.disable_depth++
 queue_work(pm_wq, &dev->power.work)   __pm_runtime_barrier
 wait_event                            cancel_work_sync(&dev->power.work)

T1 queues the work item, which is then cancelled by T2 before it starts
execution. As a result, q->dev cannot be resumed, and T1 waits here for
a long time.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 drivers/base/power/runtime.c | 3 ++-
 include/linux/pm.h           | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1b11a3cd4acc..fc9bf3fb3bb7 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1533,7 +1533,8 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 	 * means there probably is some I/O to process and disabling runtime PM
 	 * shouldn't prevent the device from processing the I/O.
 	 */
-	if (check_resume && dev->power.request_pending &&
+	if ((check_resume || dev->power.force_check_resume) &&
+	    dev->power.request_pending &&
 	    dev->power.request == RPM_REQ_RESUME) {
 		/*
 		 * Prevent suspends and idle notifications from being carried
diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574..4eb20569cdbc 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -708,6 +708,7 @@ struct dev_pm_info {
 	bool			use_autosuspend:1;
 	bool			timer_autosuspends:1;
 	bool			memalloc_noio:1;
+	bool			force_check_resume:1;
 	unsigned int		links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
-- 
2.34.1


