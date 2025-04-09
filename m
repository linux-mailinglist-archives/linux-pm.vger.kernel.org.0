Return-Path: <linux-pm+bounces-24979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D8A81C31
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 07:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E885D1B684FB
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CD1DED47;
	Wed,  9 Apr 2025 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oo4g/yqc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC71DE8BE;
	Wed,  9 Apr 2025 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176932; cv=fail; b=u2fzCLfydbw4pnaxO2RNEzxxNKef+qkMxPVkDYRsN2LI/E/10VGhrVw1Aol6dl9K57H017cHb6spfEwskiYqE69PdHWTgNCAvBqIgEjeXGYt5imDxNl4sYSj5Rc3YwAlRc42Oi8lYJqwHnvWtdiEfN1GkQuolBzp9SPozVLrawg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176932; c=relaxed/simple;
	bh=KoCzauALSNFlQV0QLANKavLjEfqdOa/anecedhSeu24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnAPNAdQ/mVmgOvANxINbmo9CqlbyPnj84+kzQDGnbqXN9Eh3LDnsJcx2EMtj6RjHs05HpUoC9kkiGEkQ0At7A7MsPYZjrHXwJ1D5r3qpD/t/r8GnPnkLvsnUdNstSU3RvLjHOa/1jcM25rGRxh7A3vR/W8EtkdJj5/Ks5PjTVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oo4g/yqc; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hukLKAOCXnGo32Si7xFno+YEtv9PltTeleIm1zgM0+hV/1ljK+0EV3UNXrEy/47MGmdfYxS082oA15PC++eE0dsmMYOIZZZP/Qa+G5qIul9FdyDfixiuiFVwbFON5vHJKl+h9cFUfWs8lbzjeX8Dfzy81IfS9TjHJtrUhLadbAKSF20kP3NGAmxg2IdenJckMGW3XUcuKpteBtB9+4/ypd93NRi2/pf+mkgXfQTisPyg7cE7vl/ywSbbij2QBkAxUDKOtiWsnHTZp6GpIy859A6xim/hs7/TnAS1uO5br3/gE2HyZPIaj3Cm5fcHA5jwE3lKeu1DVvZay+7Uaj061w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z5IuqlIlYFiC4oC0vmVqbtKJHcRr0/edZ+MJUI6tUg=;
 b=PZ2JK5gbAi27y4SFFXZFiEtVnJuvMukHNv4MPKKrVjUZTTrWabUFaWBeQpR9cxAGdghQ93Eci8zQRaepuRGh3D5IAplWjiskAxIihFVIKzIbsU4RIymrNfaBdd4Jr8UvokwIe27mo1/jN9ZaIkSKLqJsOCWMzsLpbLTCKN7sjBGcR3+wPtdz3wIK9boRt7WU+yoGftVh6eGBk67nAjX6r0YZwMSPhtd7Yud6uN8/E3ulCzwLiToSbllWiUlupjoELzItriw4zZCpinJbLbVNA270Lni4UvwZlNsG93ov8nbGGGbOAxDizVZWjNW/WmOC4dsaI0ePamvHPwGrUO9Zxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z5IuqlIlYFiC4oC0vmVqbtKJHcRr0/edZ+MJUI6tUg=;
 b=Oo4g/yqcO+JvmgKObUe+QS0X2zp/stsgp/iNRjY//Kl+8AY2nBRGh3ZswKo2Q2t7n7zRwJ11WIiRzO3iQ6x1/XATwhIg4BKvJwb3CNUKZNQSQ3WzL3mVqvB/XDzBoEiCx/7NJ2VicqiMt6voeC9AhX3ECmJ/jZic8LBrAElc8YQ=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Wed, 9 Apr
 2025 05:35:26 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a0) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 05:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 05:35:26 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 00:35:19 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Waiman Long
	<llong@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, Huang Rui <ray.huang@amd.com>, "Perry
 Yuan" <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 1/4] sched/fair: Use READ_ONCE() to read sg->asym_prefer_cpu
Date: Wed, 9 Apr 2025 05:34:43 +0000
Message-ID: <20250409053446.23367-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409053446.23367-1-kprateek.nayak@amd.com>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8ec31d-1216-465d-31ef-08dd772854d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qtve5uUpTzzFv9yp2sppvnaCTS5iu9KYrcmPeFM55prxG/pL+PK+zg9NRFgV?=
 =?us-ascii?Q?vUFCVu0uPkqYpoh9LDE692Diaj4iJXwCqY/CVQRFfK0F2SY2GL8+gpje/XwD?=
 =?us-ascii?Q?Y5LAKTGYANA4wE5Q/ILBM9DM1bzGOcHozd0YVkaEu2lSDzAkQSx4dohVj1j7?=
 =?us-ascii?Q?WcCL4c8tGcr/jHMalBEJNbBhI5aTnLf1F1xrMtI+a/Zt6tjXirg8ppBuYOtk?=
 =?us-ascii?Q?LeLydFuWp2A/X2f7wWhVgbIvucdLUKmfQ9x3dMWvqROhGNv3WsnWQmYobT+g?=
 =?us-ascii?Q?xmj6cQyZmxpX1U1oATAiLRt0klpzzNejfQfEt/FyhIglPtVmb7nifMslQ/5/?=
 =?us-ascii?Q?Iplc13IiCpBlAnJC/4kOLhjxT8W19hiu3HBN7YztuX5JXudLOyTWeTlVhp6Q?=
 =?us-ascii?Q?ZF+xBMQuQ6RTw2inakhhD51/mrHPYqX9heYeGeW3bxxDbDOSx0ewGsodaj1h?=
 =?us-ascii?Q?GcClv1MkiuVyc2AoX308SOc7lwuWhG0qg7R6WZHkRR+IetJHokKGm7Ekd8lj?=
 =?us-ascii?Q?vizYYRnlcgr/m+RNkZdCtDwvRMXJP54fgTPHSYACb5qwjWZvP8tAim2i1d0c?=
 =?us-ascii?Q?2jGF1Bz/A5bUEDT/9d25RL+9M0Qgl3QBkqk4YPIUfTknFiKd32c9kLXu4bMl?=
 =?us-ascii?Q?mmRuIZTpKgfZnV0h/wHChY47zGQx4w6uNoJRQxabMEHmF23I/9ocu72VpFBN?=
 =?us-ascii?Q?zI4UJiiJsVWoEHCxjjuS2RchI4z0Q8dhJY8FDOCJ+ZesrnNMIYc3ffMFLGsx?=
 =?us-ascii?Q?NYOSMoXHtRqjR6P8B+TNBfeLrA7PNi7D3IW/dL0Meb9vC/KCCdvC/7zDtA6r?=
 =?us-ascii?Q?cFvm35Xvje+A5QS624puC84NtaKIyiP9bE5MylgrTXoqu+E0vhIULGk6an46?=
 =?us-ascii?Q?1mCgkH0WPvMDnaQwKkvCZiCzNcwgpUZyCn+Dt7ndowntEQipEGbmUBVMalhe?=
 =?us-ascii?Q?D/30cuZXau8lsfNBplhNZFiNk7FApB7XoEjh8xZ5eWWCkLawqBvMRK9YIwVq?=
 =?us-ascii?Q?GoP/IakjcL3PT2w3U0eDopB2lZW3ELr3a35XQISeEGnx+6qOv/m1+mf28ez5?=
 =?us-ascii?Q?b/c7vZIi5aD0ORAiWVx1WpMjb6ToSH3MAf9J+jkbISq8+AldFDzm1BwDy38d?=
 =?us-ascii?Q?ONPxtTk9XiTnybxRuy89w/bbm9WLbp9hpQ1CaGOKh96iqgJ/JDdk0wyXTRN5?=
 =?us-ascii?Q?unwreWS2aZicr2QhQHWGL0ds6XK5VUgr70iA0uGVSAQ3RFTvyOSdQycKu/XL?=
 =?us-ascii?Q?qocveTNjUopZTJmOkajqOc3KUvH0FSsI7tHOSYMoukVIomnGKfPsT4g6wKol?=
 =?us-ascii?Q?b2sg7kgFCVvr2AB3QScHMc+G9fN6yjkDvPKEK+VcXMhvlT9f8YmdRcIenNgb?=
 =?us-ascii?Q?gKPr51nHOeDytneuWc/xS9GN0vO8SVv0X+Aym+6FjdAMTzbmuaTtTAfcrxuV?=
 =?us-ascii?Q?xcxxJNWgGa5h1Q6eRe1zKh/rLmUODsUY1xePT0eYtU8Q1YX65mRuakg2UKv6?=
 =?us-ascii?Q?C2vU7g6Ym2u3T24=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:35:26.0924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8ec31d-1216-465d-31ef-08dd772854d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

Subsequent commits add the support to dynamically update the sched_group
struct's "asym_prefer_cpu" member from a remote CPU. Use READ_ONCE()
when reading the "sg->asym_prefer_cpu" to ensure load balancer always
reads the latest value.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c19459c8042..5e1bd9e8464c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10251,7 +10251,7 @@ sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group
 	    (sgs->group_weight - sgs->idle_cpus != 1))
 		return false;
 
-	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
+	return sched_asym(env->sd, env->dst_cpu, READ_ONCE(group->asym_prefer_cpu));
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -10488,7 +10488,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
-		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
+		return sched_asym_prefer(READ_ONCE(sds->busiest->asym_prefer_cpu),
+					 READ_ONCE(sg->asym_prefer_cpu));
 
 	case group_misfit_task:
 		/*
-- 
2.34.1


