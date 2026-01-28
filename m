Return-Path: <linux-pm+bounces-41589-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKtsL0CDeWmexQEAu9opvQ
	(envelope-from <linux-pm+bounces-41589-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:32:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CE9CB65
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5001630107EA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D52EC541;
	Wed, 28 Jan 2026 03:31:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022125.outbound.protection.outlook.com [52.101.96.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA31F4181;
	Wed, 28 Jan 2026 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571113; cv=fail; b=Jc01Nduf3X7/iiY+dcJ9/Diz4lmQlczJJNUPnKGtIk9lgPBdJXhbgoz9OiFVURX373EIj5NVSJrq4EHQDiaKQcE61R1YarjNlUBH1T+5FUep8psqcgznrt/o/mGCNUjbUlNdXF7aCxVu7Vi+nGlGMxN+2p2+l5md3CZnzoy//3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571113; c=relaxed/simple;
	bh=NNUqsA9W30VhvsUUwkNgkbfGIsKsBwz0DjkJKpdsh84=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lJa67iZtmv2/1sCwOfdkC/byTOAEvBJM0ubELXA3mS79aTcbHdJeJZMiGsOV5s0iHScNGsl9AmHHlILQ1GQJeUNhxgGcgIl4I4y+Z0RrHA4jTHPP9gtEgHJ1X7eBUfGcpUrVUwkNaxFbn0sLxbMkV/vo3uow3VymMx8uC+KFuIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtnVbR4tTHhl1ntM9BvmsBRh9Hoo0nMgo27F/7kX26YUttOJysK8rd1osfDfwzPBFlZJfjZDrYjbuSE28kgKRKB+E6pkDMSVCU0LNMNZpjfEllsLPZhMut04c92y+ukCIOgqm9zf0VDjYm/Q3zhT1v2Bq+fj+7KVn1pBNFz5osR4MWjzZJONXjFxZotIN95IYDSHtb3M6epBJLXRPMfMkakNX11k4graWpGlJfZAJgvk49GI4dUmGY7d/3e1de/J9PTdZIrcjFzSOcjwfIyutj1sDbx02pDk8tKNUUg0P3NlfFkpAmzyLpTYcON6F65JT9YOhGXiRgxUzVfnVUcrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiszUIf5dQ/JAWBu0LqRgG2tMo2Ej4vxTgn5JliBgVQ=;
 b=LnbcC2wy1LrMrea0cSuAaWhm8mWa/Pvc5UXoWM6iP5jpsYGgC4FdqyJNWANy8D/2+0GauUGrde2VuAPBmdla54jT1Mek5l61VH9E5NPRds0rmZU1VpFL4EEb6dpnOqbasZVkikzmRT9iXa4tLx2D0UOrc8Mi3Bu8A8zJMrfPBPSUjONSelokmJLsXNxHjuC+ZE317kEGKihTtrTCVwwcuFOSjEhAbSfRjNhO6q37rqQwgNBncdI/9cMSkuzTrSJ2EV/m8XfRiweyN9/dJFqraWZ0UodWaFs/rAF97vJJQCcOTrcqDzJm5NOMrfFPvaFehwO2OiouloW3kwxFbIkAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3222.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 03:31:48 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 03:31:48 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	dakr@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	pmladek@suse.com,
	rdunlap@infradead.org,
	feng.tang@linux.alibaba.com,
	pawan.kumar.gupta@linux.intel.com,
	kees@kernel.org,
	elver@google.com,
	arnd@arndb.de,
	fvdl@google.com,
	lirongqing@baidu.com,
	bhelgaas@google.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	nick.lange@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [v2 PATCH 0/1] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
Date: Tue, 27 Jan 2026 22:31:42 -0500
Message-ID: <20260128033143.3456074-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3222:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ebb15c-f737-4677-6056-08de5e1dc472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HE8NF1oJDEV0gPv4/FZZqyckPHbLHV0R0lTlJnb8luwWlSy28kxoXDDBh1TD?=
 =?us-ascii?Q?EzSBXt6qWNqsfgwRnidVV178mwC6SJTxEpNiHWlQq4QUPqwOgaLasyQbaMYB?=
 =?us-ascii?Q?bUZ9OHQadI8lTMV9R/iY/qw3vyr+Hcxna1qryt0EQrxnchNw4Huro8nbXFvE?=
 =?us-ascii?Q?NmOMrmEdYXbYFEWYMAWmfnEICrZbSuzKVHc0BrPtrHgKYI3lpYbfb8sMYTnJ?=
 =?us-ascii?Q?JsxzBM7+qnwlQ1/U30+i0ETBCn9P8j1yrsO+b5cEeLuwPJaZTAVOaPH2m7Ix?=
 =?us-ascii?Q?SRMb8vwQATfkMkMJQwzukJEpP9+kq8K67kRkIM247Gj8dkteSpo+GRmJKPzC?=
 =?us-ascii?Q?G0B3JvWJKIhLrrujY2PoFZ4AmMiyXuZmuvUnJFZbdXV3xD+0cv/ayMMhUhtw?=
 =?us-ascii?Q?r/AdrIEYNFVT2mjY3vzsHzbGrKUSpmILXwsy9LxtXLNGwdScyzom+S3j2Y4a?=
 =?us-ascii?Q?494E0TYuDskDsoPWUxf0+0nqxRaCwGdWjrLOpUT+EQ1CrxyqWzSsMoR0C8RR?=
 =?us-ascii?Q?0NlwDQePga43vImFF1I+ikRkttjuuI+yaB5Anivp8nSh1iMKyl5N2oroyDGv?=
 =?us-ascii?Q?sUq6zouyR0d+mham4zIgOuIMpp9mHF864TSbycb2iCCTiYjfhGq8UdY7G0si?=
 =?us-ascii?Q?kQbDib4K4ltGlSUOQld6mQVzYOZ7ZM/9/JbUiQ7FRP5CINABamjvrpCJ7FOH?=
 =?us-ascii?Q?0hOLPEwMACf1xmJJzlrlLd9+0+rWJ51VXseK4Y88k7OBqSyWuJK3/PsMxK5D?=
 =?us-ascii?Q?7L8AIrCGxvFEMQeWW//N2HVvJPd03yfM5ULIq9Rh13cFYX1sB9fAJ5fCacEy?=
 =?us-ascii?Q?DFoCk4MN+6o/qMV/I1pwGqX6+83RUm5Vvxc5BjMgZFcu+rdJw4x6NNl1v7RL?=
 =?us-ascii?Q?bdSyg/34MGAonbrMrOm2I/juzmOHR/BWdB5EFc/c6KKSYa9xVwA9vgUQvxjX?=
 =?us-ascii?Q?zew9kkhZnSkpDoKZPdbt8jjoUynFqiK3/nliGCL6aW7Wrc5I60ufIiA6dAWt?=
 =?us-ascii?Q?pIzwaURlZcquhEqV1YCHbihi7LudWJaZuJBpk6FdCNaYL9OvkvYKLDZCfhMI?=
 =?us-ascii?Q?5gGwKu241A7hwQA0+eGUAA1hduXjmI5OnLWWj/ZHGYIjCL7jgEszM+Hg5+Id?=
 =?us-ascii?Q?DucGvHIoUnNMq4wFJy1ZjLBhuFUi2zR8k3r5iCoxMGrGvRrPDjTUShUgvP01?=
 =?us-ascii?Q?aCnoaElXo1xv6xlUU5uBWApWSGT9gFZvB8eiZdNX42YzrgIpfNKOZQ17pjUR?=
 =?us-ascii?Q?xufkSb6sn8pLxjqvIC3ddzy6j5NMzmIUOH5GNyEMBE8uHxEggwli6a//+lHw?=
 =?us-ascii?Q?9iginNKKEKAZs5zadJYXsdsGkpYaTaj10bzn33+d+l7+MzapWLdK0rnmLfCR?=
 =?us-ascii?Q?fwiCgd11XiB7g4Q9RLC1oAOWzFQTPLrYIfQ6hEkmTG2RJu7ArEvQ37p5cc0m?=
 =?us-ascii?Q?MucKto1a8SFAHpRTT7zqwsbTP0Mmef+WMuGx5qkkRIt9TCWGmam54kmy/+6s?=
 =?us-ascii?Q?f6+SlWKA2aG55zMykaRbEpPL09/qd5kjn3wasOz11sIY6+VMdVPOBQsPHW3g?=
 =?us-ascii?Q?FkbnU2YAOYTPfIU8DOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DapTuhOLmJY9EO5sEXSc+n8EWKiiHHsMaMH9fpZCZoCVR88PMm2xq2KReMgT?=
 =?us-ascii?Q?itcmZz02Srx4xYsGncszr0zHDTBLTx+qs22LNyCdHsVAzAjfLzEZs/CrZy9K?=
 =?us-ascii?Q?DcNYFXNObNfDL2GjvK66sooU3RllxBJiw1+VdwU4ZpTHyEz5ZHU8LOfZJt0r?=
 =?us-ascii?Q?uVLmUl59fUD+wULsoCKu/XPrnzjXTZgHMbsgyqY7q1AzqAtfXcOCI8fyRsJ4?=
 =?us-ascii?Q?QWEghuvhfvWyq3H9XKsXlhSrm3dwlNFL1FjJK6qWqiOImGN45wizDmqh2RKF?=
 =?us-ascii?Q?bFpHq1kiU2+1ORG/AYpAAXa2ceZdlgrgCMUZWoYcnDTpuj8DE7GNT9OocLWr?=
 =?us-ascii?Q?i1SQors+0ah44WBMqMG6Zq4HlPYyx6DEWnlItySlRQYrfmH6iAp+u/edJ4QF?=
 =?us-ascii?Q?3Tj4gfe8jGuVR50rDHyNOtM6ftzB/d60n7D/neqtLeGWa7yrUsv58kBDVbtn?=
 =?us-ascii?Q?HrkYBBVtumY34YFNPMy5TetZC+rJwtP3PRnFw7QITlpvfMHFDQS1eolwjZBr?=
 =?us-ascii?Q?iVrRO5TuX9IDfbFSyXGB4jz6KdHBgb9/yNhvmirHoP3icIySWxBseRhqCepp?=
 =?us-ascii?Q?GHIcr+D684O1H8v1W5OxbO2vI7gwXQA59QaRvjjoiqZddudhvSMfCnR1AMjz?=
 =?us-ascii?Q?yxEvTLrybf6JGadF7R2D9uDC1gwhI33ysKS04ImKbqr4xtvgYN7Pbuw8sLEA?=
 =?us-ascii?Q?0iCB9ZD7W5YZkMl6lyTr7gZGHa6JjiFPF1TxfP16JeNX75WlxV2N1GKCKWcN?=
 =?us-ascii?Q?SMVZHIaMkLOdUQcsqP6rCfjK6jnZi2anPQ+RNR0PiO7x0Hgpw0pOQu0ZTtBd?=
 =?us-ascii?Q?YyOpjyqhQ9lk6s8bKGbF0vFYvWuXkye4U/RXY65BOllWKxzM804gysYNOoRF?=
 =?us-ascii?Q?dC1cOjltWQM1tmmkvDTbkxQm1H68uKB4x0WMg8Zs7/NqEHL7dgfcspYbU0lP?=
 =?us-ascii?Q?5GJpPL3YR0iWXpgID9xvEmEKUiWn15flapuB7t6502rMNrOeO4I1RIT6yq6/?=
 =?us-ascii?Q?/BKdstqOFKZGpTC7EjjvSTyKCpxYNAHu57/YBS5lb4YMkIQZD27CQOeebQQ/?=
 =?us-ascii?Q?SMcw182IXfXXoIA6k79fuD8mU/p03UUdo21oF8pQmOs2LaatDtH3j2Cqeqbf?=
 =?us-ascii?Q?8nqp1TnZ8IWJgr0BypCIXjGC4JaGUTgy1AGo/DKHgoaDCsbAGZEgweotNTIi?=
 =?us-ascii?Q?FIkWGJEqvoAxFnxLIGMo8MDKFQ6OdaBxF3KfYAJuDga88aeTbLs99kVA/4yc?=
 =?us-ascii?Q?XBjTKgkLmkeEMSdeQewOuLcS38FGWGZ9If9foj8aL77BkXmKcXPWizUpXvdi?=
 =?us-ascii?Q?Tfeg+qmkunYJ6JTIYyPd/06eEQcdAsTXopixX1Pif+lZPYZGmL3P9K62tatQ?=
 =?us-ascii?Q?LMccwSovUdC0KkU4mFt0xZhLCR+q1/MQYZ6CrkuGzz0g0m+lPJhIjQZQ9G7o?=
 =?us-ascii?Q?2dW72ohs95b4CbFDF3DgBv63XgxNIVGXzvObGzOmaVyjDdJkfdfk8xWTm3Wd?=
 =?us-ascii?Q?7gqbf++ljkr7Vg1qaL6+UZsDOBVh2Kc2sizGf3r4YwPVvoZxLhNmC2Vgbiuf?=
 =?us-ascii?Q?1Qv9NsGk25EIqdCnFgJ1LaAFKBknc6crskg5DJwRHnrDUxKODbjR1zICWpDQ?=
 =?us-ascii?Q?bxD/DhRbfzqpfmw4IhdSFVikofx2eElaC/XXRYTh4gmlCGZTopvgHOKupQSe?=
 =?us-ascii?Q?2bGE9jpaSmObmUgp7dJeFd6uh2ME5tstOy6kIq1CLQROD4M3bUw7moRaxVUR?=
 =?us-ascii?Q?VDepCuS6/Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ebb15c-f737-4677-6056-08de5e1dc472
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 03:31:47.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SC7ZZkkrw7yp7SsHOZH0D7zVB8tx/YO577f1OUmsgPguia7nupiC00ihrLOdiQ0lTpTvbRM2+O6s3OnGDOBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3222
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
	TAGGED_FROM(0.00)[bounces-41589-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,kernel.org,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 571CE9CB65
X-Rspamd-Action: no action

Hi Rafael, Danilo, Pavel, Len,

Users currently lack a mechanism to define granular, per-CPU PM QoS
resume latency constraints during the early boot phase.

While the "idle=poll" boot parameter exists, it enforces a global
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

Please let me know your thoughts.


Changes since v1 [1]:
 - Removed boot_option_idle_override == IDLE_POLL check
 - Decoupled implementation from CONFIG_CPU_IDLE
 - Added kernel-parameters.txt documentation
 - Renamed internal setup functions for consistency

[1]: https://lore.kernel.org/lkml/20260123010024.3301276-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  PM: QoS: Introduce boot parameter pm_qos_resume_latency_us

 .../admin-guide/kernel-parameters.txt         |  23 +++
 drivers/base/cpu.c                            |   5 +-
 include/linux/pm_qos.h                        |   5 +
 kernel/power/qos.c                            | 141 ++++++++++++++++++
 4 files changed, 172 insertions(+), 2 deletions(-)

-- 
2.51.0


