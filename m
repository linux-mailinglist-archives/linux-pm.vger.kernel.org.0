Return-Path: <linux-pm+bounces-16131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B19A71D2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC4EB233F2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D21FBC90;
	Mon, 21 Oct 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5bBrpXa3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2A1F8936;
	Mon, 21 Oct 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533810; cv=fail; b=dnsUhjMLFu2aZVZnYBkJ6CjBckdiVlhKxWbTmHX9G6lCv2gjpnEkQmSsutd4eoVnbQ3uwlIfz/rfSfym9+RcmQAhMSTXx5eiBoua+rloZkIUVvayTsg49AlVgLZQlB6a7JYpbvsg2Be5HpE3ZpEekiZh82aenJgD22DV7yXqKD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533810; c=relaxed/simple;
	bh=N2X1daJNxpFcwk3aesP39bqcSpNu0EodGBbGgZp3sQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLFVj2e8PUXwiStiJc5kZQvL6uusb05ITdYG8bAUwxt6nc0qrPLxxP9U3GUaNyFJfD9SAaOsiMdzBK2SAseLjcg1ICk3YuJRMA9PgSrq6G9N3lUTuZ9xnZecgirG4Uh3fvzaLDTbMeYCpb6MuitPF6ZexK+OLiGhwiwqSYb1HNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5bBrpXa3; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzdyX/jFze0ULg9/rrK+hgxZ8xV327DmrBtqTLtVnVGp2uU1lb2QepLt9MBiPwFfqvVUmJ6JsZe9RdbNL+3M8VnE6/c8julj2hQ9HOvdoU7by8x3EZhfxa8POtM05o967j+PvWZEqF5A/6Vvmt1ThWZoxZUlTMNgHrkRUpw317UBiv4Ni2K0CNuYO/ORAOGymu9b7cG4dHpQKM/BCPXAcaE47t4fWStGJA5jhIoI6fXgx3l/BPr3WKpCKvjti6ghPKSfKYCkMSNM3yIiW8+6BGpMr9Ec7qHfRM3WI+vae7tnm3K2g9ozWxBd2UZPLCksqB/gwT00Q7So8oelKU7f7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVP+U8ii1Mg3eySxgqncAX3dgI3Dzxd8w4v5szgkmeA=;
 b=I0lmVvpzdCquk8jjFNKRURIUJ5gaOR/y51TKW7atCpKK4+k9+Wmk05zyZanQILq4hI2gZRJwjnYWD9m/2wkYBuPnyCBcmfEdt/X1EciwwOpfkeXaMsfkEZKAoU1q9oA5ThBeuKj5rTUQs5XJ+dYgdvPHMVmM6ouEs7mntjUSaZBV590ittAizRgXxoDcEB7+Aa8fubUwCP2fLarUqm1YG4N+/1k3wz0+xn3UV0Tiof/Yk9b1EhGnmmLjgtEsmJL4ccku0+igWpZukkb68FfaOWxSBIcIIEeLPulGou6Pv0iW8e6fwnLyqt+AHERwNs3XwO8kvKxpFJkirZy1Ozao5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVP+U8ii1Mg3eySxgqncAX3dgI3Dzxd8w4v5szgkmeA=;
 b=5bBrpXa3Ew1NhtLFQXsAYs38bAHFMpU5M0nbNCOFdW6q3HhU6qnSU00M7RqL6jsZLtTV334asOlvg91si3hSLMXC31ri9A9ZkF6KLDg4fmX7vct0K+BLWVXArocu/Z0LlPjRa5Vdxa89D2A2E1U5zgmoxB7Lu0fhOpe+MWlMECk=
Received: from BY3PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:39b::21)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 18:03:25 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::55) by BY3PR05CA0046.outlook.office365.com
 (2603:10b6:a03:39b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 11/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Mon, 21 Oct 2024 13:02:50 -0500
Message-ID: <20241021180252.3531-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bdd2fc-9e39-49f1-6a9a-08dcf1faa87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCNUeDBIXlfkXYx8T3POI7cpErfOgenbS+47lCkObQFUy6mn6BNghxp2VDAd?=
 =?us-ascii?Q?JW1UHUdTQDY+p+wajAEyyPVAgj5rnxsqVMWdgXvnDYNBxvqzcSNE7/WnUtRz?=
 =?us-ascii?Q?piioRNib0ngtroEP/JRa2BuQynZtb98ryzUApbcYDlvzYkUoK6BLDEhHTS2y?=
 =?us-ascii?Q?HwZsUWYYSeGBBTnj3otQnOKHp4i91ZEc78aUP95zrpmM1hE3d+alU0aKQDGS?=
 =?us-ascii?Q?Pk+YLzW9F3bzl6Kolyde4kd8exlLmEWRdgwLeEpaQgHUSuhMZSVEXkml/WZI?=
 =?us-ascii?Q?e7Vu01lVIQAAxFV5tZgamHmId7DM9UwI0cWTK1GZr67QcHSYUrWN4Ah+fVFv?=
 =?us-ascii?Q?wKqhM3iF5JEv0gyHVB7aYGZYOPq0Me/Zt/KsU3rR6H3KeRHuPDXubxyGp/zR?=
 =?us-ascii?Q?L6M+Wo6ySupxunHBeksk0u68FHiT+g4nIBLF6bsGle1I6QcPYowufYAJLMJQ?=
 =?us-ascii?Q?EW166iH6xGLu38oVLDcaR3sOZm+xLv8sDmEpxTAgHrJzgIjYWUUjfN+hKu8a?=
 =?us-ascii?Q?wGiqx9Y7AAA/j+9tuMi7MWjCqz4QC4l6y+enJXdm+XXKoZLmM9oD7Ej/HJNB?=
 =?us-ascii?Q?dS6Fs7YSbQaGtVArVixwzeL0p1zoLf19Q9H0XmYxzephP86E1oC6vd/3jLYs?=
 =?us-ascii?Q?Vwb68NoeXj9pni3BzHPqeZscKFIKfKpElGiAHbMGyes2v9mG5IkhJH3/726t?=
 =?us-ascii?Q?/W3D3vm4UiF8jXat0yfHfQmDPBpDqXUxRl8n8AoIX6dHar8Zko0RuAyUxb6y?=
 =?us-ascii?Q?saUzx3Wrj1CKy5pEJrjnPT7fBjzc/Xbc20Cm1vVvh8R6UhT3D4jlgMVC+Qg6?=
 =?us-ascii?Q?gQfp0c3ZQmoFuyE8cKCd2sEtlkGFGPDVubj1M8lRbtDwFrd/xI8Qhxj5PHvL?=
 =?us-ascii?Q?73MG8WPmsDsvqaThZ+NTO3nM8ri4GmRxADGE8X8yJsNzq9N8i3+se5T/nsvc?=
 =?us-ascii?Q?RpZaUY/fS9vNngnXXMy+b7Pmh0n9EcXM4iS1MVozUH2dkuDQUJoDdQ5qaXxT?=
 =?us-ascii?Q?7ZGoP01BBSZABKvWWj4lK+VGMGqkJVaqIWVmaY7IWS5bIN0eas2U7SrPA2br?=
 =?us-ascii?Q?HEzPmUo0Z3xvo37X/a5SIjZlRbOxtvqz4PmhoWhntGNthgOTZniZooYboTbx?=
 =?us-ascii?Q?8+V/9IWZDWQbsDIyngGMJa9hCNflUENTrPalEZAM/W8641h4gHaOAJD1nAL8?=
 =?us-ascii?Q?y6u2Vn2H7RXx4lVV1HcSIEhk8B3NomXMjqGSq1L+FXyNaSnL0DLwg34wMkHK?=
 =?us-ascii?Q?viDDZj6zo6BoU+he3GIL9b12f3WNogSLyZPXJL7rmC66JYlQPC0Qv4TuIWZl?=
 =?us-ascii?Q?89l92KaHl//qkdWtpFRiV/ctnwyKkCRaSa2OZ71oMaEeTfPkX6jkDGjcwCCE?=
 =?us-ascii?Q?zACQLfjbWBS/oERFJP0HRIO0MyZy0juu5HQrkV/x4A3LvhkOlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:24.9140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bdd2fc-9e39-49f1-6a9a-08dcf1faa87b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Disable prefcore sysfs file too
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2670bdcad6eda..4dea5a6f86c11 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -782,6 +782,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore = false;
+		return;
+	}
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0


