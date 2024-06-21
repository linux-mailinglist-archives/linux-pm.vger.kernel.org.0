Return-Path: <linux-pm+bounces-9786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E9912BD8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B801F1F2113E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D1169AE2;
	Fri, 21 Jun 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aFAPcynC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A6168494;
	Fri, 21 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988714; cv=fail; b=VQwYvnVlXLn2PJomEy/MRwVkmhiqEYA4xuyqqybdUjOEJun+Mouzdtqxsd/VlwT+KPaOHzwqctnKjKCp+7RJfLbXxu9sFDDxUwRTYau/Kup6tFGOgJewT4gAhnKfKtbQcsPnLBvbGp8i9/VtuinGqNBrYwy8dT4CgKdO+kt54d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988714; c=relaxed/simple;
	bh=PtWSKaQ+YAJZ+jOMXMgvwreqsjUys380ni0tSAVv0TU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAyNbQm1C/mGebHzlOfKdZlTnXqdZrMNOhBf026PllVoEp0J/wzS/8X6sARMmvPSI5r+qWKBD9zm26iuQVjVOJ4scHD17NqHCySgzhOHzAFhVqB8nLcgX+jh+piwGqXLn6q+9VPNz8pdJRnTmU4mx/k3mUNZv6j3totB8+RBEQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aFAPcynC; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9oTcG7zJXCcehADHI2eqWIRNen0hNb5zx3fTP0BeDuM2JcbqGFtoF/m5orbqXEvpYMZuQHWzJIi3D85SI51B+AaRIbrcZ829znVakMabZXk9qMeCF3Udfbm7zMC22NPC7GxBVdtbEbJfZ03ThamXgnGiCa01KFJW99jngmq2D2j5yZL2+Rxgz5akNQLwIsCmCxfuMZTglPhQ15MWdo4FHgZPqiLyZ2mf/B/TnDYyKxDtBOrl3QFe89/pHb3lByH7JbzbVN3cPaTfwnAbjgCb/Gd50mwCVrZ7mHui4vu4kOsB0Vbo/dZI4DmTp1o1fOQkbYeyspwvv3lEXVG9urpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC0+hEGpnovTRjFQWdyN+1MUH1HsOnyJcd/zaZAUyM8=;
 b=Lh6rm5AuDe0d+YapDsEnYSfdSEzHDfK/+pw2K6hLFgd/InG98mZamK9E9uq6cW4Z5WHsZwZJy6dp1i17AlnZt4gK4e9qrTSmPWmwglxpvDnD9NdiCbWWGOHW/ktRZI0ou9m27OFNRDDbsYGW9EC8x9Vg+vlyqS3OVdG07bBBA8iIWUkjcPTTVeCUxHQLeW1DJ+Veez6t1HSTW0yLZdJ5WE19GevrL6TD5ZJrlf9vbMy/3By02pyQPtQsqzv4p18YvEUoPMspU1ecz4MEo7WsJ81/FhUmHZRg0ASKC8qGpdGjPfpuzWH+1gL0zFX1wh4Rc3ghu7BNMfAiqHzryKPk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC0+hEGpnovTRjFQWdyN+1MUH1HsOnyJcd/zaZAUyM8=;
 b=aFAPcynCgW1xFTyV+NdUf7OMLH33vq1X4XTmZfQ+AF5QPbZIKk5oYYNjl0r0v1ksiYHECX8aZFBX4N2rbBMpaKWiPe1AWmycwvGJ4LDXucm5K7S8ECqxmAOOjBxMEdQwclLu9JJCizvDZvnm8njpDfrPGmpUYlJ4WTPKaZRPI2Q=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Fri, 21 Jun
 2024 16:51:43 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::cd) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 8/9] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Sat, 22 Jun 2024 00:51:03 +0800
Message-ID: <9725dfcbb8848d68ce5c8c099cd3c6805bebf20b.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ff4a14-cbfe-42ae-809d-08dc92126e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSjWHyqDPGrAhMm0ejNPPXfTeMTiXn/Wbdcm112fNMKlt2+Ft9AUNszSbf0w?=
 =?us-ascii?Q?8OcNqsgxV+iSxgEnEcRSCo3STvhzeo3rDsshyFYzd+KC1VcbOAix6tl2rJ8b?=
 =?us-ascii?Q?9dOLdUeUn8pF4blOzSMQNbC1HnRBCEHPSwUhYRvFExYCifR8wkbrb9AKs/zN?=
 =?us-ascii?Q?SKQPMnEAev+21BG9bMklPcw3ySyvIUWEYGqyO6H6zJZz04tgRNl+r0nGzeSw?=
 =?us-ascii?Q?23YeuIlj3HXftJ2F7sfGa4b8e2WlzKKXGE7+N+I0NSdd4aiESmUuaj6CvHLN?=
 =?us-ascii?Q?TkV5DFIsrgxpn9r66dV4PeVbOTFGo+XYQdrFNNAIE483oHhzKpVQ4JBqF/Un?=
 =?us-ascii?Q?sKN4ZdszBCiXdV5rZEIKdDnuUFfo3LIF2Nt1fOu7c3y1E+2zKV9X/zKKKQo6?=
 =?us-ascii?Q?bJA5VvKH2Jx3ABlCskFcSmu7UnY9fqxrHmSrBCLV32ErQrVI4m/YPQ9ilJjm?=
 =?us-ascii?Q?Cbod4oTJtBaCCSgRio1vEB5sqATTDQN4OQjmk4S9GwBx/eXOAdeZ2g8FOh68?=
 =?us-ascii?Q?TR8IEdDuQ01afyT8nShX+XBw4ZCDniuBlxzVFpgi+waXP+35Die8WcytMQO4?=
 =?us-ascii?Q?sT9KmnYbK3uI2+2Lq47Kz24n1DlbOdIR6c0o4tzuHanffbOyG/KJDRnTkz+y?=
 =?us-ascii?Q?4ntvSEl4YWVVPrwfnPP1PFeYTHU8y5hh1bpQ90qGxBEixipoAzMKyzYni3Lr?=
 =?us-ascii?Q?H3ihRzzMogB6HfVW6fB4oIm6xTwIezeNW7/KJ6+YgSIWi+tg+5cGt2ZqZcMe?=
 =?us-ascii?Q?j+eqsjcJCE5+iBJMJhQffexgwEBg+gK7hxe5O+AyL7itBRQNUQD1URbUA/sH?=
 =?us-ascii?Q?tarQUJ6gvdo+VEOpVymZv7M1jQvkYhjNjT7wBFgRl80ICogyFUTW7uOPbikK?=
 =?us-ascii?Q?2xYvIiddvnHati9DFKF9hk9u+fJsl/ZJpxqopnwHKzovNV+5rQttA+QmOG91?=
 =?us-ascii?Q?sGdwZ8p0ZuPMvB2rxknRdiUq2AINehc3LOLcvOg3d9x5jQ88GWRtYAa7nU8h?=
 =?us-ascii?Q?ggZKckY7IP+iY4XAVS/mpx6T00jm9VKjjaRKDbjOBZ1mThnpU0Tx39P4dHfa?=
 =?us-ascii?Q?cze8pQ2riM09MCdVGL5vn7cRhE3mqby0qnefRX3Our0ipDWSWkvOJUTuqwJM?=
 =?us-ascii?Q?i2qWn0OhZavWDGtHT0FWZ0wscH9LKCB716bNfrk/fgljZft9zS/ZGsGXQ2yB?=
 =?us-ascii?Q?7rkbOTo61dqAbdDT9yi1r/obzecqEk5qIamyRu3NF1/dXpEPJ/1zwXUMyHgX?=
 =?us-ascii?Q?qNziPxauAzuaKfU2mTl8u0H9ULu8OJ8mRE8SFNzY+VgcosAocTHtho6yVa97?=
 =?us-ascii?Q?MVgu8hG1VzG9kohpQmoXCBUuR80sOSATRKKj5w8srPjEGWbK7A04ubZNywsW?=
 =?us-ascii?Q?FOvIr3MvKZk7PU0m5OxRA/MsSjSYNN79TJ1ySWp5BqIts711xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:43.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ff4a14-cbfe-42ae-809d-08dc92126e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index f5ee81419a93..dc1b10d7dd09 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,23 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this attribute file which allows
+        user to change all cores frequency boosting state. It supports all amd-pstate modes.
+
+        States of the driver "/sys/devices/system/cpu/amd_pstate/cpb_boost"
+        "disabled" Core Performance Boosting Disabled.
+        "enabled"  Core Performance Boosting Enabled.
+
+        To enable core performance boost:
+          # echo "enabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost
+
+        To disable core performance boost:
+          # echo "disabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


