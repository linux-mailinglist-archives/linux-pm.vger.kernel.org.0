Return-Path: <linux-pm+bounces-38196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27875C6C1FE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 01:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FEDA362AFA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633320298D;
	Wed, 19 Nov 2025 00:25:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021103.outbound.protection.outlook.com [52.101.95.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611D1FE47C;
	Wed, 19 Nov 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511959; cv=fail; b=RZho7FXgr5qWcTEZDv6ThhINrOqXu0vaorRNmJSa76gkXVmhYxlnHyoADjNBs7ZrDgtf7/ctIQX06xkhnAGM6CYaYBhe3SkQnWzUDNRTApHQtvocq8eo9tbcNnvKkJ++ta3s6725fGS093VBmUpRgTR8YIZaCRFhSdC0zGctH54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511959; c=relaxed/simple;
	bh=c0BzO/3hNEFUEf9lD/BxT9jSbZUXXO/msbqi6F17n5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFwXazB+1WOvGeNa8/Owp+Na+avvr9X6hDzMMeX1d9ruiDrNp2e378CCE36210hl0Nu1324Mv1zpD/kbDK0Lmf5iOpmAIVZ1TqkjgsvpxMfKOQpH35AZpw+h/kKyz933SxmqHnVORYWYoj8FqCGqxmNu/EjTIKYzCKWtlXfa1jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q67zLmtIMOZO8h+GSI0Vlvhv1O0LFufye8inQfx3U/kvRurRaz09gF2gkTh4YgSgV1fnq4imoncAyJmwCAn35Ceb/gkzakJ2/Lyr14ql0Gm12k6p4U1d1Bi1DKaKUMdy7Jubq+LStX+XNDaXdUBv3YYKGFOyOkx1auawoxmvB+/+h+ayN5k75WWSvLNffananUBIBfUiHestoX9GxUP8xrGjNPkq0lRg85ZEdjbGaUm+5ylTljxtjSg5qaKVdip5Z9+EDSyyWjM/kBSi7RVAjOPX1HDkohWeez6HRpDljjYoXxqrt4E9apVcSjqPjv/bZPZTR2f56/3Tv7dPY9VI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR3HDMBnz8mS1tt96WimP/k/uAnjAjJszPNh/bk6rjc=;
 b=RwE1bLtO+sTdSTrvRXJwy5BO57oKb1sLM/85qro/gSTS9GEQZzbrWRvwFBLHlRmf3HxaRPA+w21qSeIM7pLthrEY06p3ALkAXw/Tyr70YyBFqSVprxUBmjHBFOtrh8t2WFo294rrHHPi8oC8zuHazxCszWJ+pUsMxH2ATukX+tdXXMT6mGJvmRpJK/IFOwejE7sgW7u2RQ/m8IfBD5+zq7ZjujsrIyNiFDYiCkDgjARGBPEbW5LjPTcWaJxKRzJwmeE76FyH1RsLzNy8ZDUZAIhqfIuszzsPQEbfVOYoF7SZS6eyG4N+5xlJKjTNP668pdzJV+b+4fEwEQM8C21w3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO3P123MB3242.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:25:55 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:25:54 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	gregkh@linuxfoundation.org,
	nathan@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] cpuidle: sysfs: Display idle state enter function name
Date: Tue, 18 Nov 2025 19:25:45 -0500
Message-ID: <20251119002545.666251-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119002545.666251-1-atomlin@atomlin.com>
References: <20251119002545.666251-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:408:e0::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO3P123MB3242:EE_
X-MS-Office365-Filtering-Correlation-Id: cd57b2d2-4756-4ea1-38ab-08de2702338d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzbrEyNxA654OXVAdC61mEA95U0CF+U1Sf1urOnXuRqXfwfdV2DXgI/cBra9?=
 =?us-ascii?Q?eqjZCpPUJfHTu+W05ohkHlHFGl5aeNG6B3Fe/9jgbCTPdapNTHBdcbOiDsYu?=
 =?us-ascii?Q?1NTd6tR2qHpf+mw0ji+E2wu01YvFFptE+5pTiRS2Bur698JdXa49xHJNvSFQ?=
 =?us-ascii?Q?VOlWyeIDr/9OsFxGGn0FRnQQv9gCyQBSRq7QVKx1dakZaasbn0B/A61uBQrv?=
 =?us-ascii?Q?1O5ss1xFUb7TonnNUWC6sjbFpGkiC0VKHWGDSzHgvKGhznAGlQZMMYDK/iwh?=
 =?us-ascii?Q?tSDpr7hiiR9jSB2GrBdx0JBgrt58uFk8TR0oO84KJaLFXiMeJo5pZTrHF/hY?=
 =?us-ascii?Q?98ZZVCCn4m0L6s9bT8WHS5EZU5dOImG2Icx2u1X4txAVvxpBm+B8POJYNx+H?=
 =?us-ascii?Q?SSwXC0CKs/TWDJze76Lkn0i3VReVTukSmuoQnqq78N4EqqN91Fv7/bOFd6NG?=
 =?us-ascii?Q?JOar2ieqI9UKXBMwKZoPc0fXuvL4Xxnf97svJxi7JW/UbjdVP9srjgwFTeQW?=
 =?us-ascii?Q?drCRcXta36PjfeKJiIv5yDeuhFXbl+BVXA62U0KJnDy1Z49j8j7Md3IkLb7x?=
 =?us-ascii?Q?vnhapLL4eG6BcSjW2jLkzkrg+p+RRNCSiNuB/0/x533PKgK31jxtfrLQDzA7?=
 =?us-ascii?Q?czZn2+yOaxVXlaHeQyXFequy55bIX+ei4yeHRLiJgGgZ3AzgcC0M5cec7ne3?=
 =?us-ascii?Q?fLcQLGmHIad8F1GJz3+DbWPl0NGOQcFtE72xtW+4B8Wb0YHRNupmwnsxOKYm?=
 =?us-ascii?Q?clKP4Ur9jxupSTrmEVIFZdJYJaSOLrYVm7vX5yK9G7Gl9ire8uzUp56p2YD2?=
 =?us-ascii?Q?G5aZklf0oJx6XzRWxQU25bXIu8UOIHkrirRILyofUD/Hc1AzjNT183S3nr5j?=
 =?us-ascii?Q?AtIIbsnvUwvOryabNTM568ErizFo25c51wklZrCpFPBlKwTJrNXLmItupY1X?=
 =?us-ascii?Q?sRuGzjILkom8ZIHXQ5fv/EZ5SAoyg1U6lyzjRpjvVGPIMsQBWCu3K2jfA61B?=
 =?us-ascii?Q?XMzfwrP/VAiefHQ3PTxsfJEDPPpeeauWTdzpQ+PvcApCD9UNkuD5nvgaGWLV?=
 =?us-ascii?Q?+NMSgbtl5Jyprvkl4KvLnGAbITJyrrXWUvRI92/O4pE32C4cydx1ONjiVMnq?=
 =?us-ascii?Q?NkIK6aRN2gvLLLlxXXQEUulCXlt26UBDr3y082ESncoLBCTxc8XrmnvukFxU?=
 =?us-ascii?Q?78SeGL9kHjRpjdHm5FT0k93rCVjGag2xQ6X3G46UBmbqx3fWAeBwGwUD+mE6?=
 =?us-ascii?Q?V2JQZbNqSY+ozluIeuFJcSwr0dE1L1JAstQmqvIU8lj9kjV81+4bu811Ptll?=
 =?us-ascii?Q?VEQmGJu/NLvsCLii+6qfBj2XovZqGhgVC2H9rGmti7RRDozArIrTxlwRz32i?=
 =?us-ascii?Q?4FpCVffvf+uoheLKa3dzlAdmg00kNz98DtVKf8jfQeZr1zeXwBiaFW9fGUgT?=
 =?us-ascii?Q?A5ogFAaoWPcLkVkNrIngz66hwxBq5B5o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKi2tAem4vYHanWEeflzVCPrMcmPVIeodV0A8n4c78Wxg4ax+uSVlRG3z880?=
 =?us-ascii?Q?JiaV2Ebn2CrRWpNGYgJFIk8ioh/DafaY9m56kIt149abuW461Wl0O8bR7Hmo?=
 =?us-ascii?Q?UQCyD9K0yW3XoDyER927ZdFfNO31Q2XPQEvmIdBBsslk4GeG68CDSwLb7EMo?=
 =?us-ascii?Q?pKmIE8Y9RFrkQ4SEXUuFc1TlUWr248GNXZrjMKnepSRL5khid3F600pFCNtw?=
 =?us-ascii?Q?0jIX51930IQ6ep2Y0ZgWtIaHFDJkOJrALNPhVxQKkOEAJtmt5A1YLkPAdfO3?=
 =?us-ascii?Q?eLlN/Dkl+D5Ld/ysCPqu6Ye2DnlNbHZhjyybu6gENRTKEgO7KPSyIV41zujX?=
 =?us-ascii?Q?VPcJ0WoNCWio3orQ1DhA1H050dWrZ3Oz8hJkv5oBTy442ejQYkzrXE+hR6f5?=
 =?us-ascii?Q?X1QLtVmizied04I3xW71vXDpP4yYixlIsC/uyNOG8HUOLOC/qO6EEmOl09xB?=
 =?us-ascii?Q?Imjykv5yJQOqcsQZdTgRVzoXSr/JV+ubu/4m/F66ONOgonrj29uVHnEoOXxU?=
 =?us-ascii?Q?ADf/XeovXIow8kY/JBuzg6JFoP+wmFsMD1ic4E0eLbNoHCdglTOzX3nXZKiZ?=
 =?us-ascii?Q?yWrN+KJLV26BcOSrG5SteDP+0yRA6KXdJUf+oKAypLB3EvG91ROAaVjgmukQ?=
 =?us-ascii?Q?3thcuJNgJzwyTElky7Hgi+Nix+Jf7ioZ431x35eP+9hHyjpo9oWjWfKUlpZj?=
 =?us-ascii?Q?v7sPRKLZhYtTOvlt3gs9yJlSd40L5JGqvd6JQWa4PrPD+4uevXH6oVC3K62c?=
 =?us-ascii?Q?jEfbzL+0roiL+pcpO6QGNZYPxISpI3GFBxBR5kZpdP+LU0unYpA/Scl8Him+?=
 =?us-ascii?Q?Mw9IaX/7BSS65dGJCMgn2ISLtTkKFjorrewW+kXGo/gA8VJzy1MRSSY5U4C0?=
 =?us-ascii?Q?JWKrNnog9L9G/Lppou+koHO+QXtJXn3A1CSe4umJVn1lgAM5V8kxKZ95vZL0?=
 =?us-ascii?Q?yVsHAB4ZEnp65XM6NDuVIaFmCekQx1DKE36cqkvtPLMxnafLpoQrapfhHNrx?=
 =?us-ascii?Q?VslPGaD0TKBlqEGa8VxyijgNPDChDI4UKBvowGsbSDsranYFkyDjrlTFuEIO?=
 =?us-ascii?Q?ZxvbLN3ZEPCSl21mOE+WUmKh604jlg+Hmd6C/0WnRqkyHoRR6qKGRTBacPcl?=
 =?us-ascii?Q?HczRTkRtWUrrZY1RN97LoDiSt/844/fMGkNaPAdmcmHL5BeaHux8HLQEAbws?=
 =?us-ascii?Q?SGAY0AAwOlTcR5+2FPKl1eswOSwq/JQtqqNFQPJCTk+MgvMacLXQ0kgdVGKT?=
 =?us-ascii?Q?DeH452sz0RPrjRISM60mgo2QJjWmxP/GnNqpwHKRJAPJSJr99lAYkviG5671?=
 =?us-ascii?Q?bOmmnGxZuEfdtoBj385l+ucdjmUMrxP0t21dDFAKukpYzyFHdmYD6HDaq0vz?=
 =?us-ascii?Q?0XrbY/dwhIVzTAAbaBsChpx0ubMy1k3Ceb5AeK5W73glXpW+nnUG526olvka?=
 =?us-ascii?Q?g9RKJJ7ymenoNJKs4ZFuG73QusJ14ZjL8clGIf5nGn2eUaDtFLHzyL/9mSRy?=
 =?us-ascii?Q?sQgkk/bEsRk9GKgZmA8iePU3xgudo2nS3lqKxFzs+UFER1QqhLLKmibXnx19?=
 =?us-ascii?Q?kK88/5zWfOpkqIVHK/A/xiENzHvtGD3pB4aw0GxF?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd57b2d2-4756-4ea1-38ab-08de2702338d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:25:54.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVBoFlA5ZjmqQ/NF4lheF3POtS9XVHRyVzjRZvfNcty+P8xjrZ57GF4m5a6/Pzr7XFMwHooxX4hik/NYPq9ETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3242

This patch introduces a read-only "enter_function" attribute to the
cpuidle sysfs interface. It exports the kernel symbolic name of the
enter callback responsible for executing the CPU idle state entry
state->enter(). It allows users to reliably map an abstract C-state
e.g., "C0", to its concrete kernel implementation (e.g., poll_idle).

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


