Return-Path: <linux-pm+bounces-16541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9999B2273
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD30280C4E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27E1922C0;
	Mon, 28 Oct 2024 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x5AA6tjA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD491917CD;
	Mon, 28 Oct 2024 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081006; cv=fail; b=pZl6zRbVEOrAgIb1fLPuf8+xH8wnyHlebW7J1UEPsifgsoJnB1FLgDcY5pUFzU+sf5atzH2ZUbIq8efDBCFJJKZ8wQhix/b673/c/eR3YM7vNOw08JttPEv4XJffOIM7FrKD5uY0rDIhWurx9jOApNqSefzDL5APVleugjui49E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081006; c=relaxed/simple;
	bh=itfXua4qpgG9+kXYjPNb/78er2v0xwR5No4sCxPP3y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=at1xMNLNnsAte0Ae0diCe3OSYkDIcz/SmBlHhj3muTUkmS8NOXXc6eq/xvQwLCa9U70SLebzEcnfzBII/QoeDJqCNuFPU6gq8BQay4MR5zx09UZ/dTAyL/O/bojCtIMz46DEwx4FFsgPPXuJsFAbH+9KjvWdUUohqOtKGWqiWSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x5AA6tjA; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GasWYO5976EokZjVtDE6j3ebxxDg7AXwzyUjogIlJM5GyyQh11Q1o8uJ3eZ1EwIvJ2xYNCPhXMgPPHgzIUih05ayTWHDIXZpk003OcnNw18CwMXRRavEfWiaOjEhv4yVjlOGAeNLoUpdptQFbnxjolLnj5HFCCX348ahGibDyHrih16GZgjQW5jYuckTXVnTxOBMdqyjvfNFA63QqcrpNeofVqA/pVgALO341J7EOuj3wzYn9/nrkGfcPtgd0CUU70lKnPLG4p5pLz0ciRC9bJ8plpTFLYnhpMv7bDWCyXF4hU4y9k0Bw3PYRIZPIwsj2/MoDFdPkRlKog6xdA6nHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR1buJWyFrgM7Z/t+E69AO2DjJlOxtWn+lX4bRidqPA=;
 b=HDc0FONWZpRn3ZfZr4t52TJR1OuC38NFSizroTvmBBgrk9aMOEMKZQdgyw4vAVk2+u/OP6/XRk19elx/B3Xk9WGsEFza6WEtQAytcZeWw/lgDXGPxIjXJFuUSUN+hsoVOM7s3O2NDjYw0ESSZWGwJJ2V0ctemPfKzeil5JpF02Age0DQpGD+lIJQWNlHnDiZCnPcvJ23Sbokbmx8f5f45hkayOhwWU49efTydvpWB4GrEIShPKac0ZfzXRg9sXTV6yr4pPCrt9TQv7j21lAfuE/a2XTCxlswSKt2OkmZktJC5zMx/O+gezV++3SDE8Da244WgqBXMVOxAmX8ddRD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR1buJWyFrgM7Z/t+E69AO2DjJlOxtWn+lX4bRidqPA=;
 b=x5AA6tjAU3ONmfcpcgQ+CTebUvDe86QBBcqkiHDwgZ/dWDNHgNSqVT5v5IqwRSwISvlZqB2q+9b7p3kq6YAf5v5ZvwBn5jVn14dIasLUYIVwCbzHpAKzZLwofJ4EjdCLuaNv40Zc9yENEAAwVX3Gk29WFxQoJEcp6AspJ7AY+1U=
Received: from MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 02:03:19 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::79) by MN2PR06CA0026.outlook.office365.com
 (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 07/13] platform/x86: hfi: init per-cpu scores for each class
Date: Sun, 27 Oct 2024 21:02:45 -0500
Message-ID: <20241028020251.8085-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9babae-8945-40a0-b929-08dcf6f4b197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IWm6uTDCW6pM6nEw6IPc9yGKlbmqQyz2aCfWwdsjYMWR3QC5LX+SGf0eod4G?=
 =?us-ascii?Q?VZ+0MIhZNYJGrcZ7OgSVhmNnYtbSM+9Mj0giQUxvh33TDKUbQyUSi0jjATYL?=
 =?us-ascii?Q?Y1+dD6Dr3UU/Ubp35E47fkA0LodyxKmJfa51rYjLL16HwtLgGro3LU4tqZy0?=
 =?us-ascii?Q?linU+KFk8+HD2fIm2T1fv79T0A7QdkVXOUfnx9jJSBI5LPd49hUf8I/6vUMM?=
 =?us-ascii?Q?gwRFQT3LTf+zKECS24jgPQChkPHOvxmfHJOXAWJxrCQu5kb6Jq1pAMf51MOS?=
 =?us-ascii?Q?ncTWYlpmRsC210qR/nOy/ARcBCoOa7gVuvyOJoLXARXA1I9OlWed2ED8GUxi?=
 =?us-ascii?Q?9siLlhQY4P8fFu9ueAAozxgmtXRiQdIyxLP61xU6Of/VD+NFHZ/0pIMXjZiU?=
 =?us-ascii?Q?m69DQOBPgFIWWB7FfCFBZdfX3Kn3STtkV88JzDdpGrnKDyRx26TGzD1f03QX?=
 =?us-ascii?Q?udr87MfKl3mS+s2COajRMeS6HG3ykngayGT2OfyeXSdRHQFq/Z/shjMw3Nse?=
 =?us-ascii?Q?rIxXHkvrV7x9vMnvrbB+J+OCRGJFOGSgGgyCNFOhHT14pnN/9UUdDYNqPZ1m?=
 =?us-ascii?Q?4uHcUogfZsoC0NzqYMGt8cFVBF/9XiOD3XS22HyOjasg9V982jmlmctl0EGh?=
 =?us-ascii?Q?neeUuA9VUiMAXroQzBtLufRSVSwBA2EYd6I4QtoQIG6L9ZDClcoDLpRWA4Nt?=
 =?us-ascii?Q?cEZJHKouoLESr+cX2dksmVpNG+9Ool79Q2vOAtqNGlcix4A0AtNyuE5cXTh6?=
 =?us-ascii?Q?leujBhglyUYX1SxdBpEjMBkqAPUUVAQgnw3801VgZwpch/749z67KIbTNcZ1?=
 =?us-ascii?Q?9xL4jB5LAaQNyikWD6VbcCM6yWmuo26AR9dum8IsuZssAmgeqBU+W7ktp9aJ?=
 =?us-ascii?Q?tYCWlk5L+xa0P0YTo2b3uKtIfKDqUgdVG6NaHy67BJaIbt7QmN3QNIaZsEsb?=
 =?us-ascii?Q?563xOe00Vf64X7zF6OS9fmwdtaPv3vDkr5YW9nm80JuYgwFT5SOi+Pt081af?=
 =?us-ascii?Q?cxwuAB79SCh/Qd5Qh8ZsHChWMQ5cFOBrwrNakNLGGyfVz64bVnL3W3taJi4X?=
 =?us-ascii?Q?xx3R0h1Ghpw6ja3p44Xp057k5y6slI2WPaZLHOQWI8tw0hquI4K0MyWQcfN8?=
 =?us-ascii?Q?SJGYBGLpzmy4xFHk2V9uRQDe4aObJp4ISMH7BH0PJvuHY/0UzobSqa3YmS6X?=
 =?us-ascii?Q?tE4Oju72pLjd6aCIxBqSEHdGoAPN0fnYhNqXeME2EGROee10zNbjI4ezPAv0?=
 =?us-ascii?Q?X3K+Ymomym5fI2L+/LdWoYOjhdmWBtTFRRaFSTuR2E3RzXleBs9R24ssdmE0?=
 =?us-ascii?Q?UIMKfmaw4v1uZCjhVAxDP3tu6ARdSZ9t1cocpaLszCnNe/gbXlzm1K2UZ4VH?=
 =?us-ascii?Q?CHva/q2Vmed9LgtSTRX8UPE0Yk7dYLtU2/09piyXpRka7bSMEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:19.1106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9babae-8945-40a0-b929-08dcf6f4b197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index b5cfe20c11052..986ea056fa022 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -114,6 +114,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -234,6 +236,31 @@ static void amd_hfi_remove(struct platform_device *pdev)
 	mutex_destroy(&dev->lock);
 }
 
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
+{
+	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
+		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
+			   hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_present_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 				   struct amd_hfi_data *amd_hfi_data)
 {
@@ -317,6 +344,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = update_hfi_ipcc_scores();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


