Return-Path: <linux-pm+bounces-43910-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDREAZqFrGmqqQEAu9opvQ
	(envelope-from <linux-pm+bounces-43910-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 21:07:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9422D795
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF97E300B509
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68F37AA63;
	Sat,  7 Mar 2026 20:07:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022124.outbound.protection.outlook.com [52.101.101.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EF35F5EB;
	Sat,  7 Mar 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772914066; cv=fail; b=ICcT/O7TCrPiMfnIIb84hIGprPqYp8rBFn5ejfEnIaoOmWLICu9WYD1t3tS2d3rJnMpEq8EYYYoeRrwtKnZhMydm4bNMm8+x3yFNdMm4slRqGe8wyUGlgUIBQJBhwJh4IgtAzS0O2Gj54yuP5mgT4vGb7E0MZ063TmQtvX9cRkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772914066; c=relaxed/simple;
	bh=yu0Vw3uqrZA2Un4vUQcsoTwEve4hgQX0DBbDoHxReuE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QT61VLFepiciV2MmgWKEz6sOznmPqCReqO9rXIchi24xOYi88IH8QaKxe6lXtwkU2IL/z8dXMOzNp37njet37mJQ4Hb8zMOcC1BrBe2CDABxN8bKFT5BGnnH2/sGIwprO4ithP6y3h1wP9ZpQld4RO6NSvMTWalf7FvHK6wgH6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf2ZT6UYfm7ti8T6sESkxXUylC0R9dWbZ1wlbqxHTEPE3M9SakukxoOFxPUHykjILV9KRbdzNs1AWhqbIOcygJQqwy4TYOvzmZEw3K3ZuGwz02gl3ZdpojaJ8eOxeDArAPGgHG5hUJFixPtgZVlJ88pvQi9xwcphYH4DqP6USZWNln7sUckAr3JHTWsrF7+YGAQUYx/ZYLYSzTGfGJ/x75cdbON07hAk/NEEGIZUL6FXNt/PItddRtOoSTuZyNxzxm4mMUlQ25f715JM8H1W5+WCm0A9zxKg85YReTJKhyHG/zCk9JHUib8PrIuC9FqpOzujxKGsuY67Tc2RyWFTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okySM4Oyrnrx2XF92cD0c1ztRCvfJC67ZuXZsaf3spY=;
 b=AEJjbag3ZGpLnbpSqAMgag9dA9ZBxz7OT0TU4nWAYHwccfH96zG5PUfx0nyZxFyR64HQF1Ajf0SqvLcJNIAdeeXbV0HPhDpuDmdjlcTpVQSMTQRsEtdnRxvzPxuI4FR7rOJqK1uQ4YEgGNuNidaJp2BQK1bkFGIj3vNHiFlqCjn7gMDfL5tL+LRdDOrRIHg8my2v1+67zZUKcQ4HYXv8tTtsiBUnepAO8UFiMMRMtDTlO7XVZRIjJIUa1HIGjIVgpK4emNiBJiEQPftJpnP5dMNTat2c/+MuXm8cMy5xYzs9gixdeMJvMJ+ov7kXqLIpKX+vgCJOE5t8GM9xg2uwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO8P123MB7891.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Sat, 7 Mar
 2026 20:07:41 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Sat, 7 Mar 2026
 20:07:41 +0000
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
Subject: [PATCH v3] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
Date: Sat,  7 Mar 2026 15:07:36 -0500
Message-ID: <20260307200736.4192234-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:408:e1::20) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO8P123MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cb3464-f4b7-4d6c-0f14-08de7c852fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	HLfkz/S1JbgM5HmKdIxdJB6Iv7qliBbFKPwJ/1H0c7+jiyDsDO0nCoNg7ZXyR1jONSJBIV/7oJLbeBkXs9q9EaQPthCMf37q22t80oSjYzjmLLQMXvnRgaKXaQqofBrsnhjA7N3OPiTtnz5slmTG2RIUHBR1r3WkRRez2P+UobehB4ngydRcQq+zjOBx7LJVgckTpdIPtN89yfvGVeKzvz4j4g8MiVW46yYwifJIQrIJ2OrudTk30AEnqVXSrBu3tWzikl9YqdropSNYo2qszvgYPtjU/lxURWE1Dl2jBFkdBeCSOO2yWHNX+NpQbRZWtKT+hS+ghKLN9e/52ZsmvcTwGGknsXSpmsHaIh6kFVByQD/aPMt5Njku1JjQLTaEOEMTIwmnnr5cHXQH2t+H9djo1hVj/5VUF9BGWDUDAH3UXPVAZ0YDCWhBdhZKhWfW1iocXDaYLLEX/0a2cE9UP/Lhfj8KqybvpFq4J37EGW97xWm4l9i5F7SUAIgmRD+uB3h1qbiA0mSSz4avHnG7pT/IqOv80qnjZ51Z2+DgYNH2SspPrElawGkzNZvr8ttuddSdtIVqfpSAb0TbIwUx2I872aEuyNo92QjCG8D4z9aq0JYIGPev1E3v+8LwCjtIXTT63OYaKrDjx0x6Uj+fUpGxkN5j4Csuoq80sOtd6ANtRe4cPMbUMGkcjMWrUImkt5his2gLFQsjreqyVHy4qyyBwrE01u63NgnwxLUPavA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdC8RBAJt2LdN/gIX2lwe56k/60Iruj0k4s+v2qUxFXXzjD78JFG8e4DzQoz?=
 =?us-ascii?Q?6jbZFaijikQoCZkayIqDazgr45y/vgMlqNYueeVYnvYpYav8Spck2opDS2l+?=
 =?us-ascii?Q?W90Xyg9f7jNt3sH1DY77gyfvlO29dqFdUwxX4NsmqIMdts/KdwB/DwKwPiYA?=
 =?us-ascii?Q?rRa/DhqqGk1iKgjZjXPLkcPyqHjEDcf5hDoQsFcNFRNYlvc01/kWik/dA/nN?=
 =?us-ascii?Q?IgBWneFXoW53Vekc9HT9wb6vZZTev3KDIUutA0RD9InWuDmEASieYAETzjZL?=
 =?us-ascii?Q?L/jjOcoXciDO5BJom+nOkIqvwwI/5Xi2IherLtm7W7aiXS8917spTrUS9Zly?=
 =?us-ascii?Q?dOpzMRekH5GIi0WyaRKh/kBOORYoZu0PyzF+IRHjeqlL4LbPidCvUOaBlRrE?=
 =?us-ascii?Q?lbwa9B1UNxEJ1RL3IhcdXGFBD62G7jTpCnde3Y6RUSWvMW0ZN74/cAqQ7rfH?=
 =?us-ascii?Q?5Rv6tPdrLzniEakI8EuxUBns+OkjpQtNJaoY110rB2Bmy2sp4pa+NRTagfE4?=
 =?us-ascii?Q?grw/31R5DXGKoRU8fcsAW1J71LuKOCzc9F9/+qq0D0wDP8E9HCoiIcmtKq2L?=
 =?us-ascii?Q?XJs8hLHXhJBZL44ClNE4Lw9EZQC+3cXxgrSNrqf9AD3vTIveMpOi9lF0SkAS?=
 =?us-ascii?Q?KAz4NrHOVDEvRVh2MR2O091msBTr0W7cfCGPAPGdsTBySaE2tuW3ruyeGx46?=
 =?us-ascii?Q?CSXdVVoGIzYbNHmzxFKp8vKBaFmx6wLxODhDzwQhtzdbFI3EQ+wRQU8cQLGb?=
 =?us-ascii?Q?CKg9ALwk/A3PzIlRfVqd8FoT1GwIKYpHXRGVdBVeznHt6OiA/3re6/hvFp2J?=
 =?us-ascii?Q?q/86RrLlgUjCO9H3e5oerrbLjKwlnTz8LeGFSXd4bopG13Yl+wePU1fLjAf/?=
 =?us-ascii?Q?ZX/sK9sbM1TwfrO5JznBF7/X7Z2nnGYvTgtCyTHlT8396LNBUYg2lROBdy9D?=
 =?us-ascii?Q?kFWCwYgI7E4L4CyabZJH394AIraNE4quWQCXxhg8LboR5ozuPLygaLV+AtjQ?=
 =?us-ascii?Q?QWE4xunsJmQRwLZdPSi6ZC/2VTwxS0+R4ydaLYV7Q+i3MvIDBzanp0UwVBLI?=
 =?us-ascii?Q?FqK6A/CbKGOnBJQNgliTX2/xZf+eX7A2Lf6jGw733HIn5OgafvocTf9NjcZR?=
 =?us-ascii?Q?pUea83yGSoZKU9K2YGd/gKBtGtj8ssYnNTLUk11jpxvGhWUH2qxrtlCXa039?=
 =?us-ascii?Q?QUcf9Tg61TMEmTMzUcfWyQED1yj+OcZURTbCjb/DIAZHY5ULTKu9jognB8b1?=
 =?us-ascii?Q?aMXowHU5+GDSHRcedNDWFbndoH73XAZxUfxt/lb2uQVWw75GQPF64QqToThi?=
 =?us-ascii?Q?PK7dFf4m/Vnlt4IYFm85C5qwHrBaPhg2UeR4w+9Gyv1Y3/gX50lTYYIKsrkC?=
 =?us-ascii?Q?VHmHQR23RDGhMI49kjcoS0oJsebam33zxGrj5vCNf3x63hutbxazUdkrx5vN?=
 =?us-ascii?Q?bXx7THbwr0CiaGaze9LxLi4N6Dp/+GpwEvKIVR5fSBx6ci6bbxrgmBWtFEOJ?=
 =?us-ascii?Q?ImudG2oi9m5xR9scK5HANigdSbPFJKLCYMYzwEHT+zsdvj46bm00NhIqgt4z?=
 =?us-ascii?Q?qmteMQIyOBKWo7AhswlOtiaGqIH5yIv6QEQQW5CAewsHWbwLpapD7U9KG1T2?=
 =?us-ascii?Q?0CQHzUqe3CtAbsDHNDEyV1s5GbsYd16IT57pGThDpbmglmybuQ8I1dsnq7Y1?=
 =?us-ascii?Q?VhQsfjxwFcFA91Z0i8L5s+UxzMGLvm9xlFBeLP/5Gckyt/ovRWdzAxQn/p1s?=
 =?us-ascii?Q?1uGrHHMUbA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cb3464-f4b7-4d6c-0f14-08de7c852fae
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 20:07:40.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F/HQiOKY5iSh4x3FuOQK32FsRcN4erk49zOqp1U644tJuNrLMLzFxq4zf/4NeLArOhult9bVtNytzEuh1RGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7891
X-Rspamd-Queue-Id: F3B9422D795
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43910-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:mid,atomlin.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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
Changes in v2 [1]:
 - Add pr_fmt() to standardise log prefixes (Zhongqiu Han)
 - Drop <asm/setup.h> by duplicating the command line with kstrdup()
   (Zhongqiu Han)
 - Fix init_pm_qos_resume_latency_us_setup() error path to return -ENOMEM
   (Zhongqiu Han)

Changes since v1 [2]:
 - Removed boot_option_idle_override == IDLE_POLL check
 - Decoupled implementation from CONFIG_CPU_IDLE
 - Added kernel-parameters.txt documentation
 - Renamed internal setup functions for consistency

[1]: https://lore.kernel.org/lkml/20260128033143.3456074-2-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260123010024.3301276-1-atomlin@atomlin.com/

 .../admin-guide/kernel-parameters.txt         |  23 +++
 drivers/base/cpu.c                            |   5 +-
 include/linux/pm_qos.h                        |   5 +
 kernel/power/qos.c                            | 148 ++++++++++++++++++
 4 files changed, 179 insertions(+), 2 deletions(-)

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
index 398b994b73aa..0d33ea1c9b30 100644
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


