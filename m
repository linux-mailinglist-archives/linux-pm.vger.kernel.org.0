Return-Path: <linux-pm+bounces-38194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB64C6BF9C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 00:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F06334D351
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABC3081D8;
	Tue, 18 Nov 2025 23:22:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022072.outbound.protection.outlook.com [52.101.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129332DCC17;
	Tue, 18 Nov 2025 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508141; cv=fail; b=qE3f8G+3ky2MlYHsEmvCIaJKRKrSWBff+eKiZhObo2kZDaq3dAODSehmze9+13iVogOQUhpa35lRroTZqC9Cv7H+x+ieMNCCgEtquI+olkwgnmzmp/miURuZonbbPK5Hy9UwzHGfnTBnbCkA1arx60tV2jeuXfL5OgB6elpV60U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508141; c=relaxed/simple;
	bh=S3n/bwfNiBCb4MfCCvxPB5VwH6C++lB1UiFoRG04v3k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BOmot0bn5SaPAaYwJXMFpBGisOLJTrC31ZpZgaJbc5NaY4KtYjZiqDrpcpQDpeZ3fbb/0R6jddv1lpd5FpIjAvq3oNcz2L4pnr4pLVMb5h/qLWtNe6JCzVRI+1qayBqk+9V2xRw+i6W4OqLVvAoByOB34k0314+AVe3ZZzXRsJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOH4DiJDzOAzrzoZuI+KW7WOMYxjp/gGgi8X0gycsI0daMKt8bJtUKRI/Kr+9BFMkXqZsdY90tKS4qIz/dATUcIe8t/Omw7LID0EKRSz/Hu8b4qk3uNeWQuo8BoMji7+ZX3iLTTJ41VedizpNdKMZzwOpuPdYgVJIfGJvz9EtXR5Yl0henWcAmpTytAlZwyqTigr9qt3h11aThKM23tAXMShNRkYKEUdott1IEAyRUvmT5fedGNA5cUmBcXJbsh5DcifA/DjtisCBuiQEkSmoE0iIK218ovphroG2jCT0Rbn/5ea4oIW1ZYWQ4dvl4h1RIiFZ2eJEfPj1vktNFppPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oYs6iwtln+wgq+swG4opyXCHdTOgxB/UDjVCkv4Ca0=;
 b=iKoEyc/ymDYO0SqCL2wcI4YYrNpt93W8V4TfIBjEGytSgTp93Dp7skj6N+694wIBJTksIaP217Q8lM7kF/tYw8mLSVeOXL7gO2NYU2CCQX/7KUg0mAwJHmvuc7VDoho5O8KbFB6G6EgrLM3L/qdI0O9KIXcbmgR27peUdYu+6LuIwzfSWyN0O1cDvhs+g7LamWDYIiRz4zIEdao84rmwgMZZ9lVz3e1LxkpPvTD8h6LSGCW8gul2KL6iDP4O23OgIlLoZl04zDH+8CE3Jes5Qip4vji6AJNslEYJJs+lFI6M7Rif2+ulJVDC6g9CTuAMk/Ip8yJaAYc/GBYt//aDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7200.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:31f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 23:22:15 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 23:22:14 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: sysfs: Display idle state enter function name
Date: Tue, 18 Nov 2025 18:22:08 -0500
Message-ID: <20251118232208.660255-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:408:fe::23) To LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:be::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d43690d-eb64-42f2-4941-08de26f94d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZeSKKn3O0vPYXa89EW83TGeLTnYGNRy0HvBw9tOycJg9EuomuqkTIXkp25e3?=
 =?us-ascii?Q?+mETlKM0/5LSTD2rE467MRpQS8IBAS74SMmTMAXv7TCWZefwoQKBgvTiVPLx?=
 =?us-ascii?Q?ndZCkgUXqe99z2MFU+1+YJW69iwi4syo5x8FdtbJ4dB+b5MoIpJoa/BYMUuo?=
 =?us-ascii?Q?ScrwQIGyE6e5wbO6eUTnUq0v08aEoprRw55u2IS4iH0b8+LV4GyhR3yI+Pxk?=
 =?us-ascii?Q?+j1BtB7IJLdrr3ooGwBc360yEQD3VWPGC+12p/rlMX29U8ZUDUMJ5slHdHk7?=
 =?us-ascii?Q?DdxtJfBHuU/qSUfXCksL/w47FRUGPW7oVt8dS7uMF9+wOIp/lLI1NgXm8m3B?=
 =?us-ascii?Q?5cQJPiH2+vpdxytZnYzQz5/x2doyqVcxJEASzBPXyPG2ZJ0IyRfdEq9VYtNM?=
 =?us-ascii?Q?SGGOwS+Jef/u795XXZ6x7Hci1UTty6hSpx5mqu6TJ0ZB25dcIoDWx9LM1Lwv?=
 =?us-ascii?Q?8JDI2rb+K3ixKfeLz4xp2hXR1d9ParYf7P/rly2IYYqXQMHMlIBBGeDR4qnH?=
 =?us-ascii?Q?V6FKrFy8Yqrt4v3oUoBigVi+jr934qXOmbFjMJZkzcCqgYGPxc19BtIoK6/3?=
 =?us-ascii?Q?i8A66ColKoGVjEYg/NymFYj2doT5+B3NI90EDFRIv+Nw9fXkM++sqiWp3ztw?=
 =?us-ascii?Q?M1zW9D8HKmRD5lximJkpIPh5LNGvLwK3ni3azBLDCefVjWySnVIVqKAYExGA?=
 =?us-ascii?Q?Bv3jkWB3C/0G0TbF0uT+BPyCpgA5hJm+jr8RlH1hPiDLrJU/+jfW11xgep9W?=
 =?us-ascii?Q?A+SSUtfbGgVCfNK3WnZNUp08UqRc8A3SBb/O+WFDORC3iCvlgy/o8xx1WaRH?=
 =?us-ascii?Q?rfok1I9bdyFajk3vY5fCtvLyKclZjlu2Gbg2eroMW7uCHV1LY5lFuPmt19V8?=
 =?us-ascii?Q?Ni+jHONUtotPjAn7S7iSsrO5HbNH6olQlJHJaonWyNyPgRVBr9DslV93P4tN?=
 =?us-ascii?Q?ri4H6JykWQm2Cg495NGhVf13GSteXrhyTcqFIMLjWi29jhCqaKROlmwf+tal?=
 =?us-ascii?Q?tGt5xyl8eFtac1Uv4ub7DpLvcTiN4VhYnZ/n9CcUtm4/cfwg+wgAIBzme1kc?=
 =?us-ascii?Q?4Sth8eroinSx/AtD9mTMSCXsAMsk10SNS81b7R/5HrI67pcWF9MFhobIrXuI?=
 =?us-ascii?Q?S4lTNao7NmQWCbuBFVULAud+8bP0mPLgmDbwF5FuDfCfYEPOQeYqSkCb6VrH?=
 =?us-ascii?Q?vNrpdzvtlRzY97dpWIbeiolagIZamLZ/eCqyXvFtiF30WJ7iGKB50U0irevV?=
 =?us-ascii?Q?7tpBt3Kb7sbtWbu87Fjmgu831GSuAgcBPyemnkmz3hcTs8tIoT/aVW+4AmXi?=
 =?us-ascii?Q?TIr367dZ7uA1MfaFX4RAIAF6U0oY1r36dUvKmRxPmeOc60bu4CcGbL54aWH4?=
 =?us-ascii?Q?18Htc6rAfT0SmK3xlFCypJTU4mQLH6zvB9UniK+MvfBiDesxociT9USuea4+?=
 =?us-ascii?Q?Bt74FWtlW+MHnE0GUju3sSpoOdIUielL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfAQ5xF+aQYxSd9HZU3Z1tOXrz9HioTWFiGKkrpMgYP8KLDm+xkpWVxjobBd?=
 =?us-ascii?Q?Qj9nemx1YwwlgFq4e4nRqapWGDi5YzBLATmEnWcbWaCbLASebBVezJPZ1toR?=
 =?us-ascii?Q?oVXZJLQsyg0YikrCIWat0bY7fTyAKtTfjPp4g5/yyPznv6JFeB02LpL7kRrp?=
 =?us-ascii?Q?jRZQM0Sfn8isFHgradqc3nH6GaIcIjVCnru4UN9XF39s9PA2uppZXTHMSbXv?=
 =?us-ascii?Q?oSnA6sGsfMCt1WT7JX3NS7wo2dAdR7G3ZPLUcgKsKH5KTeawri4HIXJHwO+K?=
 =?us-ascii?Q?RsZV7aQc6FSkmnHUUTLiwQMI/BQga4DA6eJfHvyTMiv2Ce6P9Vv9LGBUVcv3?=
 =?us-ascii?Q?2X3Vx8xg7k4vyt/H6bPImAchV1cioYX3GRE3s9yBuxZVg1zocb10FPCcoqyh?=
 =?us-ascii?Q?KNZMKlfuU9sJUXanLd61oUHcxVWWTOptDDwA93U2wWHe8Lzm1furL1DRL3XH?=
 =?us-ascii?Q?u6Kvt+W1awA5dkB8AA0RR9HgRjGAzfGQ7GSU79OhfJFY+fHhFJj/rSj9p6iF?=
 =?us-ascii?Q?vT1PSA5EcYAsTgO/xgXVn54DDp628Qi33yPSSZTASFg8HEGheb7UlU0p/E8n?=
 =?us-ascii?Q?2QOxyG6cUFsth6gc7G+yE9Dvo/Ij4KI6C40R/fhFnTEsNOtYT9nVTl/LYsxS?=
 =?us-ascii?Q?xqTkpwtZfRl49kdTIitls1pkNStJP98mCczFTlIZq32J522HBlzireLwGlDf?=
 =?us-ascii?Q?q2YLuwpaTdjFWP6Rsa7gQxgVGTbeYDJT3xTDvelCIfF3Y1a74JJtW2tFCORE?=
 =?us-ascii?Q?j2N3fDcDpyb0T+AuIFkEnhd5Mk6WUrh5jktwrffFhzoH6hBWYQmbYzs06DvL?=
 =?us-ascii?Q?+z4xXlhxle/O8wVzZWDQrF/rgASmBB8AlcF/p0RGshWbvPne8s18jQQlmfJt?=
 =?us-ascii?Q?WCjjsw817bGQk0q55xclai5UDx8GI77Zc62bQzJfkgAV70XEF+gGScG6lEzv?=
 =?us-ascii?Q?qpgQRZZcnqbJPDKmPxR9ff1TNf75+gcibxr8UFEfq6y5v7c8775/tPXkCeNz?=
 =?us-ascii?Q?ijj4kSrfwVb3XaW2xlVcFA6mLTTzeC1LWFU+JECW9B+NCslOgkjxJlOxFdJy?=
 =?us-ascii?Q?Td045y8fLWQ5Xeru79KTTShKUoNNtsb3HtjZvbs+n118W3DCg5o8H1d5J9rw?=
 =?us-ascii?Q?pfk52YYyPi/sWmET+1RauZCVkg3SNgapDPI/vRs1DYTyUFfp9zozljtDlW4I?=
 =?us-ascii?Q?q0nF1kN18mpTfLrD9DAx6w/vkZ15PYfgVj0A8I17BpTUJZyOiSmFCc9wgivY?=
 =?us-ascii?Q?nIp99v/clP8nkq1RJO8Oudfray9mZJqmJKtaM8BzZy5VolpHrH5bZRTRBThp?=
 =?us-ascii?Q?/TpO4yUhscTt7q0YhPWktlTQbJOmm4tiX1/nCQJHEpFzJjb5GnbZFrDrZG+/?=
 =?us-ascii?Q?or4sMF5L/UEs2JkPOm9UNwMBFvm5try280W3Y4DJmK4lGoSzuZuCFLMi+LJu?=
 =?us-ascii?Q?Hb305QC4p/L5ACC6nhLXh+MLXV8MXcy51gYIXY3pzJWilfkPvK7Di88HYSqj?=
 =?us-ascii?Q?r8LCK3Xud46a3m1sx3x6ntYlijEjdcqmLcOq/S7ZYR8n9izgEFEMZtHKVK0+?=
 =?us-ascii?Q?GIEafgibcCy88qnvCzw6cQQqQ0+a3tBESova8txx?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d43690d-eb64-42f2-4941-08de26f94d9f
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:22:14.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC7rJd7DVbWAuNXhzl891PE5EmGowpwSqt0kfd3Fn0R58MiW3ZrLhOKFNlVB6K9k8l++CbLvDOywb40bC6SZgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7200

This patch introduces a read-only "enter_function" attribute to the
cpuidle sysfs interface. It exports the kernel symbolic name of the
enter callback responsible for executing the CPU idle state entry
(state->enter). It allows users to reliably map an abstract C-state
(e.g., "C1") to its concrete kernel implementation
(e.g., acpi_idle_do_entry or poll_idle).

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
 drivers/cpuidle/sysfs.c                            | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 8aed6d94c4cd..7be4555d502a 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -217,6 +217,13 @@ Description:
 		time (in microseconds) this cpu should spend in this idle state
 		to make the transition worth the effort.
 
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/enter_function
+Date:		November 2025
+KernelVersion:	v6.18
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		(RO) Display the symbolic name of the idle state's enter callback.
+
 What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/s2idle/
 Date:		March 2018
 KernelVersion:	v4.17
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 61de64817604..dbd8d796ad29 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -314,6 +314,13 @@ static ssize_t show_state_default_status(struct cpuidle_state *state,
 		       state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "enabled");
 }
 
+static ssize_t show_state_enter_function(struct cpuidle_state *state,
+					 struct cpuidle_state_usage *state_usage,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%ps\n", state->enter);
+}
+
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
@@ -326,6 +333,7 @@ define_one_state_rw(disable, show_state_disable, store_state_disable);
 define_one_state_ro(above, show_state_above);
 define_one_state_ro(below, show_state_below);
 define_one_state_ro(default_status, show_state_default_status);
+define_one_state_ro(enter_function, show_state_enter_function);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -340,6 +348,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_above.attr,
 	&attr_below.attr,
 	&attr_default_status.attr,
+	&attr_enter_function.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cpuidle_state_default);
-- 
2.51.0


