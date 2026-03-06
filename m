Return-Path: <linux-pm+bounces-43777-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyHC9GmqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43777-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:05:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A448B21E69B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D24630675B7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348135504D;
	Fri,  6 Mar 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LNKc26Cm"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D29350A3A;
	Fri,  6 Mar 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791123; cv=fail; b=YJ/0AvwbfSqP2ud17GtzZ+JD/zrFgcI4kBNKHJAD+uVgoVD0ao9SvrDjlqYQYomnTYH3RdbRYoUxDC2eSOOpN1X+iA2HPRT3SUN1ML9TZqPd9+5OgBUFC2SDxWRWq9R2Iy6NTxUdJvk2W4Eq66yeXuYi7JKZ3XOXisEDQHdUF4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791123; c=relaxed/simple;
	bh=A1yHnhB/IYVOd2+W3u/SqDV3u1aRzkm3Sb8Rxq9owic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo0QmPYj5+HQnZ3vqdwd8/o5o/e+KABtwjg10ZZ93lFm1Jkxq8YiccxLZAQtE+ld4uyYumjocDP7sYgatQmtSP9odJQuBo6JysMGT+LHpq1XpJIlhb9KHcFkdaax7s8r9unmrYCtke6WEN9KWXmKn7gVRoAfefQ/RngmhfymVV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LNKc26Cm; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwtZMVfHxChz4hpkykra/iNSBuH0bSw9G4QYsGGU4yJM764kW9LFLce4ojYd8a+w8WwNxfwaElorOrYw8UCtSf0qFk52zNOtzQJF5Rs2X577ooAi7++YF0opKrEIrWvHEut0ZHk5acOPTG5EvD76lW3m3Uk8yOJ/2gxArAk6SrLh5M9TcjJseSUq8ttVxOCJkuWdACJNtswXGp3gySCeeSl/RmQtTdQHJpG5LSkVCVjx4fR8Qls9o/V1OAhP61zVj8XV0U99YJwq/tFwWFvFtpiUdR82Y4fzQDY4NTiYJFZUHhHqEpJfz8S3MSK65BEYa/bRlBtroTDIzlvYxG29rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0pDnujbxihaJ9jacUUeRsP4e8AtFNDFw9OChWnL/PY=;
 b=XtvDshIR2ADcB8nUgEf00gfbuD9Uog4uSRuBim4GJc95tFo0Hxs4MBBOYZfrcIqnfdHGy99wOy0BfJPZXZl7Uya53k2G0nDDVRcHl92vcVGnTjffRp6GGbhi8mdr07GO5eeyF+moy2M/3mOkocsQaykwLkcde4NMnBxSQ5U9kjYP8f3J793QTKJ0krSdceXmQ53fzaG7EgqPo8cfCzdXrND1a9xxie8SOKf/n1uSQ4qeW2MtT1pRVpfNGVAi9yXxVL/KnYqxORTenULDXBWtVL5umGP0LnFRxU3sjP0zkGkkjeUKHH1Yg0Tql8IPN2THvNJSTBn1DHbCzGNvL72Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0pDnujbxihaJ9jacUUeRsP4e8AtFNDFw9OChWnL/PY=;
 b=LNKc26CmpGljKyipKQLTqlDd3B+sGjY0g3A7i8+rvghr2lVqeLGtH2OEHbG1uwFRG78Ts4FHAS5wKgaYLTRpFk9l3XDl/dpCW01BeeAMXrXl4FYhB/snXkGNs/PXtttbcSdPADC0X2Kyzv6m0eqFmSPfSSsAwmuu/SxeeruEm3I=
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 09:58:39 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::23) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 09:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:38 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:36 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Subject: [PATCH 8/9] Documentation/amd-pstate: List prefcore related sysfs files
Date: Fri, 6 Mar 2026 15:27:52 +0530
Message-ID: <20260306095753.17155-9-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306095753.17155-1-gautham.shenoy@amd.com>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0e62c6-df25-4935-61df-08de7b66f0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	CJYx1k9GEF5peKRE3o3M2nS761zaxq261EYQf1CrQi6om3EOCrVJgOrtFYL+SIHzjyuVto3L0zfO8ZV0SKvv2PFlQsOUFaIC6/qC9uqu4Z7t8yVH7NCZuA3guv8txmwvjIpkSIIqCVBlrR/WTuN8cUiezLi6xXNGM6UQzfrLdT5Wi4sgdsaf13kXR9JO6qDVowCfoVJycV8GBUoOdg1hZheq+cc1Fae2kVSlB5GXqBnQ/XmPywV1E8CmGYnFF5H6DrX/BHViTEUjPqRvP3OLp/4gd67UqN8FdOpfxEz2QfIpVSdVmpauGBfpO0CyiVHYM6zUoUfdArt0jrn2yu3Pb4pkkFI/JSVlVzbhOJHz78LiDBTTlf8Fy7cC/ihsmlC1tlOjELkozwi8f6KgDy1OveFgH/z70GAtO6QB+JjJ8Z3XFVkA7ESUW0d0VZBsfKwv4cEd+GfgrjPzh/TGsKhuRhXewTPKPlODHoickPF7mFwU1AeEKztajDHqMh2xkd+0AR/+ix78wDVGi6OOPmQDcZFW2IXriVBYpSJ/y1iOKgZU5dOxduLcgM2fnuiDDKGXDiqCVELnTCZ4oiy9TvR2VGEyU5IE/gOyHS2ms9loolZjBJv4mHEp4y2ElQDX3tjAnjSuBmvSuAmtDljYzy5Rrdefef2VChzsi1Z3/bTm0Dur5ctUhDBCuNCm9U3krHWB+3qAjwhVBDTsxBHLIYGMdbkM8UIG7Jqaz7seUz3VvCGuc3l+PiFdJ97yxgHDRKsAnR0hTo0Kor/7WQNQQE2Hfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eMGXYcZELVeGAAg6zX0SG0NMJcehJUjW4hqyR686+hW/92WmgBAB2GRrUyzSqd5KUP21NkQ4nCsI1tOu/yyVDcX4QwTqlU/T7xoDg7+xl0GWjcBPMYNkPklPN7Xclg13DAhgKKavXB8two0yTDopB/UgwmKlGBhlA1k3FFRond9FmmabsMpe0wuNDdIcOlxqt5pb9K+ZOtNqO+xsV8KLfHp8K4SnEvMAmHepxPKvlGOT5LQdIXshzEOMdPtGPsDrBB5T02JcZGI9Pk4rAbZeD9aR55oDzsJbbvGrpbMNtFE4lhQfTkzriCznDjwP6mp5sfDPz4Sn0GnvJ4zDKOkTzVMKn9x+oyF9XfDl5CIn/9/ukUObwhjXr4ikac5Fh7YklCpjvWA1c8XWuck84w6m0zkLgSY9pskO2aSF5q6EIPrJQCNKjfwP3WR+aQ3pKS6D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:38.9690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0e62c6-df25-4935-61df-08de7b66f0ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531
X-Rspamd-Queue-Id: A448B21E69B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43777-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautham.shenoy@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add the missing amd_pstate_hw_prefcore and amd_pstate_prefcore_ranking
filenames in the sysfs listing example leading to the descriptions of
these parameters.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5f..f566fea6613e6 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -239,8 +239,10 @@ control its functionality at the system level. They are located in the
 
  root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
 ``amd_pstate_highest_perf / amd_pstate_max_freq``
@@ -264,14 +266,17 @@ This attribute is read-only.
 
 ``amd_pstate_hw_prefcore``
 
-Whether the platform supports the preferred core feature and it has been
-enabled. This attribute is read-only.
+Whether the platform supports the preferred core feature and it has
+been enabled. This attribute is read-only. This file is only visible
+on platforms which support the preferred core feature.
 
 ``amd_pstate_prefcore_ranking``
 
-The performance ranking of the core. This number doesn't have any unit, but
-larger numbers are preferred at the time of reading. This can change at
-runtime based on platform conditions. This attribute is read-only.
+The performance ranking of the core. This number doesn't have any
+unit, but larger numbers are preferred at the time of reading. This
+can change at runtime based on platform conditions. This attribute is
+read-only.  This file is only visible on platforms which support the
+preferred core feature.
 
 ``energy_performance_available_preferences``
 
-- 
2.34.1


