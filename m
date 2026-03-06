Return-Path: <linux-pm+bounces-43778-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMzACDmmqml6UwEAu9opvQ
	(envelope-from <linux-pm+bounces-43778-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:02:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A721E5D8
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 503B730A65DF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B3356A38;
	Fri,  6 Mar 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvaYO4BQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB534D4DF;
	Fri,  6 Mar 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791128; cv=fail; b=m9oyAl+Il93fh1v45BnPv4GVlfatDgW/422DKTi6RiVaMk0FJJHxrb3+Li0hwGQ296dQp6iNCsbwSDesp1EUkNBQV1Lz9KozoykeC/qzm9fjf3GHeXI2j5VItcbQIgJhF9rwB0/0SJu+5pbnNfzbAXjiuFgDwgtoEbgDeuq7PdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791128; c=relaxed/simple;
	bh=eXJTKR8Nb9eX4QEH9d0mCZ0lAH2TIwNGOJ/dtCvfWM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=am2LSYl5ONd0lzPORncG7nEJ4jnTh5Q15/ouA1O/1XXqV0gGeAkUttBxkgW+zjQ9PP1HXP+0Uaq5W/uSE4Vc1R74tIAq4VHhKMan69ulwliHCeJrfPf88E2pg3aF1YFlOTgjFvqiIxJGd/71K4aKpV1i1r3mbPi1TQW+QXMe6WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvaYO4BQ; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6mL9067GtNjNSeq++Dot8rmVSpO7UIOuJZkMwaPDy0prgqj6FMVl1CVPA5mBRtHH0PZVA1+f9AEK23E68nT1CJtSGJ45XolFmHiOKA4pzJ8ArjuKZc5NM62wQUwv9RiNjxo+h77412/dScL15yMijEtc3TMMpi4buMA35LcvuOs9sztxDVI4coQSJkE1TJgdYfKERGs8FMCyaEqqeHe93JIopTJSBpuC1SxtU7p/VZjBqkKO60B/U/J9W7LkfX7kwijABTaEOtGCTUHVrt8e5SCbVjZ4fvsZFm1RVyzOBBibfzb0wBGim9P6jgqNLNqCInhNpldMb5SlWW21uzUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HJ1P1oBWTPl19WwPkFDpeACpQAoxlqO8fpx6Awg3vg=;
 b=GoPhRLKL6pSplmZI74I93y2X9vExuyMl+yoYU2zS8t24hyInmFC06hr/ZY8UhI9ewnBCVPk7eSq7AwaiIDLZDPM8rfoZJcMN2NWu1XthhkC8HSLb/vFR0Y+TsDUZ/x3dXIyxPcWYyFQhlZis2K39BgCgkvY4FwRQ7vIWQt5zXQrFnqqmsG1nrjcj562zbSA6tnIiAZGSW7vKYBepHHIJd1efzlRYUtYVcrPlvg+BaMr2+tzUCiJIGR3CQbT5mn8YYkG3H1GjItsTFvKHjeWFI6D/VtCJY9MLvio4a5DlY8bictezKQ/C2DxIUvdVO8Sj741xMPYwerQrqN5PylpCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HJ1P1oBWTPl19WwPkFDpeACpQAoxlqO8fpx6Awg3vg=;
 b=lvaYO4BQaNspqyuaLrIhBZMUB7bIvfA2f32XncrXKk7EQZxU/FKeO6c6TIqmnIIbL+1MOUIw36/aXhasrFD2AkcmCAq7Uu22JEeWeNasE79YY0s5xbNljQfHmGBpQAgPtU3CUdeAqZ7/Rj+fboamRojVbnspqZdQ9BvoU2Tv3JE=
Received: from BN9PR03CA0574.namprd03.prod.outlook.com (2603:10b6:408:10d::9)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:58:41 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::b) by BN9PR03CA0574.outlook.office365.com
 (2603:10b6:408:10d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 09:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:58:41 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:38 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Subject: [PATCH 9/9] Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}
Date: Fri, 6 Mar 2026 15:27:53 +0530
Message-ID: <20260306095753.17155-10-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: c0484825-48cb-4c1d-c713-08de7b66f276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	43C7WcejKenrlW8kiCWP3vkPZulAOZWl90eMueIag13vgpR9OCiJgjS9JZ88XGVBhkpgavdZp0EkaOwqUFpa8sCevrL2aRX3II+UYWMPkQFjaNGVuUU+MoH+4sRDe9F931lYcMrrbNPAifVhPI4yOg728fbwQL8elHrjTNTOQdhP1pnLhhU4beKWjXSQcJTkakbWksjQzJlOTxWGEJ2OxqeimsXgKdlQe/USpaSV4t1i3yIzvEZJEkzWc1OBnFqBIx9xHV++fl5iqfx8Fqr/DheSUkELhtBTZYY9Ug/kYpfphTU1x2M7hVIQxvhYN4iq7ZSAFoNwlYumDkUNtYsWQDHEcpfuO3Z3ZAqBr6dnKTIvVjtkkRUe/f++bvn7Y5e5gkM0uolEgExaTw5fv6v+VM2gfnMKQdkTNyjirMQSJiHR8VlTP03uocUu+oVpj3yqYH61nY7CqBllqMJKSxBOe4MKom95KhPubQ7siQQjcjqemm2t+Ch2iUI1h6FgJF4SZmoYDWrUCu1zsM2kRAVVFIEjRK8x/pCIs11nzG7+0PzMBdE8jnM69nrh4DTdiCZpD/+o2qUBlFufs35Ki76vElcBRlzhb7KDb3WPokTTfZDXTCrzcs8oMkJyaNUWjd+CD4azGOHYHAB6/nuM7/aKfyQdrbsUL+8wPciBjUay0UaR293+e1Q3rPyD9Y3OqxR1kGA+0zol8xt7f8AgFcmfTY8BfV4Vn+2W7dEXIkx91apuAHBhzFqyg7MWv3TFq4zba0mo85j7fY5b20XTa6JdEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mW71fTaeiUPerimY26TPzWuqSboZrjLHX0Fn+Cy01b50aROPdIcGtY8tBtpdmVhuRBXZzp61y/XH5+J7CYgbuxWN65QFEpgmtGLRJWpHWaDougQz7c6lG/9As0z71xvozftzowxx+w9KP8kGWcahL2BJh8/Y3kfuH6tRtzwnZjMXNByzril5gOABbVORecNA+XA6rpzoOyF+oN+iWwKUxJILTKW8LeQtBRDMGqIhCKDlC/TdWR6KugI6CvhPzj588CDxVAtD/Tz6S2FJ0bdwFUnV1uyqzkLl7fKxy567EdRzYcBhLujQdX3DhTvFbWomItyACwPE8p6eee7X9BNjHDplM8tcrFwh05mdw+8EIOcdZy+z72Fv8Ni0fxtY2h7n1X4CzSqZSr98aar6hTzvUi1CSSBxrE4TwIZRjQUs4t5eA7Ed56Xg4RABGo88nbSt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:41.7551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0484825-48cb-4c1d-c713-08de7b66f276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-Rspamd-Queue-Id: D74A721E5D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43778-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

Add documentation for the sysfs files
/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq
and
/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_count.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index f566fea6613e6..5fd2a36f8a4b8 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -242,6 +242,8 @@ control its functionality at the system level. They are located in the
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_count
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
@@ -278,6 +280,36 @@ can change at runtime based on platform conditions. This attribute is
 read-only.  This file is only visible on platforms which support the
 preferred core feature.
 
+``amd_pstate_floor_freq``
+
+The floor frequency associated with each CPU. Userspace can write any
+value between ``cpuinfo_min_freq`` and ``scaling_max_freq`` into this
+file. When the system is under power or thermal constraints, the
+platform firmware will attempt to throttle the CPU frequency to the
+value specified in ``amd_pstate_floor_freq`` before throttling it
+further. This allows userspace to specify different floor frequencies
+to different CPUs. For optimal results, threads of the same core
+should have the same floor frequency value. This file is only visible
+on platforms that support the CPPC Performance Priority feature.
+
+
+``amd_pstate_floor_count``
+
+The number of distinct Floor Performance levels supported by the
+platform. For example, if this value is 2, then the number of unique
+values obtained from the command ``cat
+/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq |
+sort -n | uniq`` should be at most this number for the behavior
+described in ``amd_pstate_floor_freq`` to take effect. A zero value
+implies that the platform supports unlimited floor performance levels.
+This file is only visible on platforms that support the CPPC
+Performance Priority feature.
+
+**Note**: When ``amd_pstate_floor_count`` is non-zero, the frequency to
+which the CPU is throttled under power or thermal constraints is
+undefined when the number of unique values of ``amd_pstate_floor_freq``
+across all CPUs in the system exceeds ``amd_pstate_floor_count``.
+
 ``energy_performance_available_preferences``
 
 A list of all the supported EPP preferences that could be used for
-- 
2.34.1


