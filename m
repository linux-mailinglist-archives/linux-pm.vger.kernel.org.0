Return-Path: <linux-pm+bounces-43919-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FwbFkLIrWmb7QEAu9opvQ
	(envelope-from <linux-pm+bounces-43919-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 20:04:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBE231D11
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 20:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE093010DA5
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B4387362;
	Sun,  8 Mar 2026 19:04:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022132.outbound.protection.outlook.com [52.101.96.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3901C8604;
	Sun,  8 Mar 2026 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772996670; cv=fail; b=sdmL+tRaqFBF3lwqMC7CRC8VyHG9zvQ21zIsv9cgSv/NHJL5lFmVzVe7pmYKwYX0rDa07qraMMWW8f6qQDginoUgVVDOtlzY3XzXB39LimLdH4Q89OSy2ZPDvmiKOFInb6QU0pRh9Z4TUQg5u3ERgIRUIKaykubyYZBQEeBd1DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772996670; c=relaxed/simple;
	bh=BWwtC3pzJgevnRc1e1tFQgGo9wq4ehVVIM0WFRSXe7o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZfuyICdv4mbfmMeKfYTrif0FseyDZpF1XfhPjCMYjMdVIv9LTn1HJYsbM6jEcH9jkMJtRDMiH0tVr8HTMlyyO75w8NE3IYQOXgOgJujJfXVqHocn91xPKhKhkDssxFpPG2ChStK7tHqOcxNoG17uwFNU8oTR/eNbsMS5MnXpA88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOcWPQvI7AyiTSzO6fKevVWY5fbzpq+0QceG2s6oCPuOkSbgKG2sz9OhQaKFtIe6tPhqfVnseHwgOtwbq3mh/WJdHoESE5twrGscNGPJCN8g2+WY6O6e3JvVuukO7CvnSXuhaXu3GCXCL4Y0pEFHb+3SSP9a7fsViIUM7VzxdJFC14CGNB/4z4ze+vDkx6so0y/NXeB9cU6q72tQzfb5fsgjZZzsjwH969gs1Zc60MYBjP5wxJDz5UAZACJoMnnJoiaToWZ9cJLlyJQ+jDSKYbf5OhOfenwAOOnZJO4SiD48c96ZgqnWAn0gfKthmI+vNbigYSd5IgBR7TZrg7t53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wmmBw8OvWoeDZSLqMb9kpGfkWigWWdZ7+jCZcrSgbE=;
 b=Ix1wvT7m2G3tBWtbMgo2KgyZ5YBe35ozS4+MG6cLccPpk0M+Rj20Go6bOHofwkbbHDsZi6aMOfGqlZM2bnvJo/J61uC8VqDh3+WV4ipRewJ8wgQozPh7bXKWcWlbgs7YD1bDSAbpFHcWcQfLkPJnwADYDpMD87Bl4gvefiME+IecQ1R/ywIynOqc/FChcuOJL9Zcw5HJqIx0eTFH3uJOb7ZrsK+PtJXIrfpzFviIwl1QkxSxaLaes2zDljUDz90l/F/UTJtHa4jDaj3EgXfQF1cyYJhvOrm6R+DTriSn58BM2vO2JfeeoaLLNlX/rsqQgAxZWG7vD1w31e946VVVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO8P123MB7873.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Sun, 8 Mar
 2026 19:04:25 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Sun, 8 Mar 2026
 19:04:25 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	dakr@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: zhongqiu.han@oss.qualcomm.com,
	akpm@linux-foundation.org,
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
Subject: [PATCH v4] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
Date: Sun,  8 Mar 2026 15:04:21 -0400
Message-ID: <20260308190421.46657-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0883.namprd03.prod.outlook.com
 (2603:10b6:408:13c::18) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO8P123MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eda0d4-4cad-4b61-cc1f-08de7d4583b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	URT6UEvVDZIpZsbyPXX/vwoX3Gd6xh5Ukctu9ZVYZO8JtmAZLa9KaRyp2dYxQy6Hkr1wZUKdQERMVpb85z2e3oJiHzBeEEWpSi0BeMd+nLxNtzV5MvXRfFIOmWLQWqA145HaR9aKNuPeznr4Uw2rcNSH+Cl0dnbcO5Ci/2gSRA/aTFflkIheVv1GKL8oY5/rk/sLWbDhCFQk9AWA14jR4VcKXLAtsqQwJpZ5fjG6H6bLjHIsX6WSXJE8F35/U7b6d5NuMzyxgmGKa2nMehd1hJwPaNoD1FF4gx3S/TW68xrCw6ucs9tKIcSKu2L3mKehV4NF0l2/zfOzLh1gZN8isLI6QbRMHgGX/Hla3VujSd0jTI+EhzCl/eEuBUkDL9sxrVyJ9XkxoweU7QSpJowSGE1UPJUxYMIQgjxTPrCWz3M4o/3IBvZLrcjY7Eo9sYNDU1A3dwr9nv9YbL0JMHgOU/dfOHKzNgZEYXulGOgdbo9aZCaG/74xgjtoKTncHW0Sf889B6HHW0Mb6lpLA+Vred5wJBI4p8AA1eYyBltZVXMbZ17F4j41qbYJrsCVxyHC9pn7WFvUudLoV1JIWyFK6/gyKQzNsfP51j24GAQzAMcB7m/Kz9lHBrQJNwfGvYSHJxD9AnULxOREWJ5Ut8nae56dsQN2Jk0r0ZIv4cGz06OfJvUbBKio5dilxo2sizEW8RkOoW+H+HoapMLYTptLXg+EXqK2sBjwhmJfyobKdgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PCu3PhYehdGiXZlC64wul0v5U/LKZq8QGOz4Taqir/qpzRfiE/r56qQCHtJb?=
 =?us-ascii?Q?PXXidcRXzfxV2LXmhlVcWyMxVc5dfGx9UN772tb/tIlGDiuu5B9U4aaZlah8?=
 =?us-ascii?Q?tSP/dDuxQQskH5oA0LLdUA6gGZf7QKO+3D6jWKuLyinCMaQuZlrTl1Q597to?=
 =?us-ascii?Q?actRBg1xOjHT3IWrOeG0lgl+OI3PZsHmUzP7Rl9v7zgm6EO9rKGkOfIh2Lci?=
 =?us-ascii?Q?NkIfAiWpuE9H/2+HgQfvg1oaio/W10N8G5ux9LI07OCnRPUf6ZHuEH0qR56G?=
 =?us-ascii?Q?EHxT+eyQgvriVSHFdQsl7MfXo39VCiyWW9S/RnXHMtPvyVgO0AaEvwuxcooK?=
 =?us-ascii?Q?QcH/YyHiBa386ZzpY4deuhkjBatkcqKbp7I3VfW05cSYQxEjSKPkcXjJKFoB?=
 =?us-ascii?Q?nqLBGQzy0zqxS7WCUUoPkd1DNuWTu8sJHCojEynE2Op3bSvcAVnKqNA5xUiQ?=
 =?us-ascii?Q?8naEF88N5Z+uOa/XUFiIsp0CE1FzazVLff9yeLNXEc9wbVmVRRRfic5gbH2Y?=
 =?us-ascii?Q?yIwJ92CrryWFvfhNZeqWo/4pHy95s2pFkMjn2O3KHkfyiz3MWgSYb4hsPE6G?=
 =?us-ascii?Q?0bEsSUnwxBneKADX101JxcnimxtIxBYQ0A0HvN9mqpHyXy0PhkjpMgSmgmep?=
 =?us-ascii?Q?KxuPKQq9lcjolQywsEMRIEBgpDo/ZC9KztUlTwVmR+cSw/ZyqbSOT2SvQrqw?=
 =?us-ascii?Q?7ab/gJUP+Lv4/0x6yGLoke8EBnjIZmPkxWhgbzwg4afiOeqnzLIgfRJAhzp6?=
 =?us-ascii?Q?c0Z2KNaHaVzS9zErDrMSrWeivW37U+fRbmIQ3uqirxTECfYaPBRoDl+KhlpD?=
 =?us-ascii?Q?l4rmqWeuDykeEmkpvnPls5QfRTjrKO7Wf/h5844KnZUAVlh54PG0HgakBfRp?=
 =?us-ascii?Q?+XlA39GPrejenq04EQfubVFMm2c5qSqcsglS3Pfi5LxnjBLDf8T3AqNxWrxn?=
 =?us-ascii?Q?8NXaDyb2gaNUikw/p7+uyD/jgvIO4YgNWO7SsKnW6k+RV0DW1iLadteeMlHH?=
 =?us-ascii?Q?CCe8r8dqhz2KTuQSOBTDSOsIRncEUNp7xDyY63SGoJC5D7hwHZuDVCJ5p5va?=
 =?us-ascii?Q?fpPnc5RxybJ52wupkI5EHBroGXfF4kv2R8QEVMeI6xv2+r8C595r40IbQD7a?=
 =?us-ascii?Q?Zr0C+YJwdIR/RKIiplXUpy6u5suFrM4NTXvkZz98/GQI7O7Qe2ZOdEJpV4+g?=
 =?us-ascii?Q?v+DmeWOrAdmvQ3zxx8CjeUBK2qou+Rb30lDj+QlsGMx5TI9jjjL+M6WntncK?=
 =?us-ascii?Q?8UtZBogMezLvGc22eNoI78cPypJrW9lVp8PTjcaaOU2jRRvc10AcC8v3NbbO?=
 =?us-ascii?Q?BNI8QGbE36OvTLxV0XT2Hnsryf0iwkygthD4GMZwRcXvPTfNca1qYXtPEF71?=
 =?us-ascii?Q?QBf6B4Pl6BQXNtBlc9dO8oIgwn0ODVo39GH8xFUb01U7YgsMSY9fWQVfj4va?=
 =?us-ascii?Q?hlfowE5Rm+1MWonS6gEJanTYAAT2jz7+UxYF2c22m3oCMJKf/wQX2HG/EPoh?=
 =?us-ascii?Q?Y233tehQ5I/6TH9bh81D5q3HaTMMzO/Qv1iBUnQCfNb4kioZkzi8hl4aiWYK?=
 =?us-ascii?Q?KgZYriQR6U4Y7Gl9HY0464sG50naHvvRiLmtEzTFXx0vHJFYEcQMQwHV5cV/?=
 =?us-ascii?Q?QdoLnxLzBosdlPq8c+GpmOb5liyF54+hBoiNEdJ7D/xTeHy2SujIx0WV5Eub?=
 =?us-ascii?Q?OaqcrDyENFe+gsHTepehmKnGn7p3Arb1nBv6vYR/PZpMSKslAf3Pv0NvN55a?=
 =?us-ascii?Q?eMSKCfDadg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eda0d4-4cad-4b61-cc1f-08de7d4583b8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 19:04:25.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9DAulYXxS8Nm6MjdwRIPhQ3IBbhUJOyN2OYTMzX9y03xOW+IVS19HLEDMERc3mVOyMOMHZkX+8Dge6+fVbmJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7873
X-Rspamd-Queue-Id: ACCBE231D11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43919-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,kernel.org,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.864];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:mid,atomlin.com:email]
X-Rspamd-Action: no action

Users currently lack a mechanism to define granular, per-CPU PM QoS
resume latency constraints during the early boot phase.

While the idle=poll boot parameter exists, it enforces a global
override, forcing all CPUs in the system to "poll". This global approach
is not suitable for asymmetric workloads where strict latency guarantees
are required only on specific critical CPUs, while housekeeping or
non-critical CPUs should be allowed to enter deeper idle states to save
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
Changes in v3 [1]:
 - Moved pm_qos_get_boot_cpu_latency_limit() declaration out of the
   CONFIG_PM #ifdef block, as qos.c is compiled regardless

Changes in v2 [2]:
 - Add pr_fmt() to standardise log prefixes (Zhongqiu Han)
 - Drop <asm/setup.h> by duplicating the command line with kstrdup()
   (Zhongqiu Han)
 - Fix init_pm_qos_resume_latency_us_setup() error path to return -ENOMEM
   (Zhongqiu Han)

Changes since v1 [3]:
 - Removed boot_option_idle_override == IDLE_POLL check
 - Decoupled implementation from CONFIG_CPU_IDLE
 - Added kernel-parameters.txt documentation
 - Renamed internal setup functions for consistency

[1]: https://lore.kernel.org/lkml/20260307200736.4192234-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260128033143.3456074-2-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260123010024.3301276-1-atomlin@atomlin.com/

 .../admin-guide/kernel-parameters.txt         |  23 +++
 drivers/base/cpu.c                            |   5 +-
 include/linux/pm_qos.h                        |   1 +
 kernel/power/qos.c                            | 148 ++++++++++++++++++
 4 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 55ffc0f8858a..ef1f70de7d47 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2251,6 +2251,29 @@ Kernel parameters
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
+	pm_qos_resume_latency_us=	[KNL,EARLY]
+			Format: <cpu-list>:<value>[,<cpu-list>:<value>...]
+
+			Establish per-CPU resume latency constraints. These constraints
+			are applied immediately upon CPU registration and persist
+			across CPU hotplug events.
+
+			For example:
+				"pm_qos_resume_latency_us=0:0,1-15:20"
+
+			This restricts CPU 0 to a 0us resume latency (effectively
+			forcing polling) and limits CPUs 1-15 to C-states with a
+			maximum exit latency of 20us. All other CPUs remain
+			unconstrained by this parameter.
+
+			Unlike the sysfs interface, which accepts the string "n/a" to
+			remove a constraint, this boot parameter strictly requires
+			integer values. To specify a 0us latency constraint (polling),
+			the integer 0 must be used.
+
+			NOTE: The parsing logic enforces a "First Match Wins" policy.
+			If a CPU is included in multiple specified ranges, the latency
+			value from the first matching entry takes precedence.
 
 	idle=		[X86,EARLY]
 			Format: idle=poll, idle=halt, idle=nomwait
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e..e522cf6e7312 100644
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
index 6cea4455f867..65ce276282e8 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -142,6 +142,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu);
 
 #ifdef CONFIG_CPU_IDLE
 s32 cpu_latency_qos_limit(void);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 398b994b73aa..cf9c3b63a632 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -18,6 +18,8 @@
  * global CPU latency QoS requests and frequency QoS requests are provided.
  */
 
+#define pr_fmt(fmt) "pm_qos: " fmt
+
 /*#define DEBUG*/
 
 #include <linux/pm_qos.h>
@@ -34,6 +36,9 @@
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/cpumask.h>
+#include <linux/cpu.h>
+#include <linux/list.h>
 
 #include <linux/uaccess.h>
 #include <linux/export.h>
@@ -209,6 +214,149 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	return prev_value != curr_value;
 }
 
+static LIST_HEAD(pm_qos_boot_list);
+static char *pm_qos_resume_latency_cmdline __initdata;
+
+struct pm_qos_boot_entry {
+	struct list_head node;
+	struct cpumask mask;
+	s32 latency;
+};
+
+static int __init pm_qos_resume_latency_us_setup(char *str)
+{
+	pm_qos_resume_latency_cmdline = str;
+	return 1;
+}
+__setup("pm_qos_resume_latency_us=", pm_qos_resume_latency_us_setup);
+
+/**
+ * init_pm_qos_resume_latency_us_setup - Parse the pm_qos_resume_latency_us boot parameter.
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
+static int __init init_pm_qos_resume_latency_us_setup(void)
+{
+	char *token, *cmd, *cmd_copy;
+	struct pm_qos_boot_entry *entry, *tentry;
+	cpumask_var_t covered;
+	int ret = 0;
+
+	if (!pm_qos_resume_latency_cmdline)
+		return 0;
+
+	cmd_copy = kstrdup(pm_qos_resume_latency_cmdline, GFP_KERNEL);
+	if (!cmd_copy)
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&covered, GFP_KERNEL)) {
+		pr_warn("Failed to allocate memory for parsing boot parameter\n");
+		ret = -ENOMEM;
+		goto free_cmd_copy;
+	}
+
+	cmd = cmd_copy;
+	while ((token = strsep(&cmd, ",")) != NULL) {
+		char *str_range, *str_val;
+
+		str_range = strsep(&token, ":");
+		str_val = token;
+
+		if (!str_val) {
+			pr_warn("Missing value range %s\n", str_range);
+			continue;
+		}
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			pr_warn("Failed to allocate memory for boot entry\n");
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		if (cpulist_parse(str_range, &entry->mask)) {
+			pr_warn("Failed to parse cpulist range %s\n", str_range);
+			kfree(entry);
+			continue;
+		}
+
+		cpumask_andnot(&entry->mask, &entry->mask, covered);
+		if (cpumask_empty(&entry->mask)) {
+			pr_warn("Entry %s already covered, ignoring\n", str_range);
+			kfree(entry);
+			continue;
+		}
+		cpumask_or(covered, covered, &entry->mask);
+
+		if (kstrtos32(str_val, 0, &entry->latency)) {
+			pr_warn("Invalid latency requirement value %s\n", str_val);
+			kfree(entry);
+			continue;
+		}
+
+		if (entry->latency < 0) {
+			pr_warn("Latency requirement cannot be negative: %d\n", entry->latency);
+			kfree(entry);
+			continue;
+		}
+
+		list_add_tail(&entry->node, &pm_qos_boot_list);
+	}
+
+	free_cpumask_var(covered);
+	kfree(cmd_copy);
+	return 0;
+
+cleanup:
+	list_for_each_entry_safe(entry, tentry, &pm_qos_boot_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	free_cpumask_var(covered);
+free_cmd_copy:
+	kfree(cmd_copy);
+	return ret;
+}
+early_initcall(init_pm_qos_resume_latency_us_setup);
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
 #ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
-- 
2.51.0


