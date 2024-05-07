Return-Path: <linux-pm+bounces-7555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169A8BDC3D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556271C22FF5
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA413C8F3;
	Tue,  7 May 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ofJEsp6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162113C81E;
	Tue,  7 May 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066163; cv=fail; b=mY0eTvtL2BJBjyzkpNQ3MuVPmGJ0L2JRRSYKIAhAsjzf4+UUmhIxSidubeHGHrGIXhYhD42klULHvjnACKfwMsH0CgVKjSLFZL56NoFa7Pmqa9qh99tVrE+mfRMMqrGJ+/8R4mRD7pa7m4MKE9HxgSDo4uk3kHb9omrw1xRZbu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066163; c=relaxed/simple;
	bh=2QWcL8qvjcHkp1laEepLCEKWkDrK5yClnFTR9U1AUXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMnUQh17jM+nvnJlzSBnDBKSwmoZLmwOJUwQQPVII7ku+XLBbQYZh9jTCty0WvrzKfxQQTjxAHMwyKMGS6XWQsFIx5QtN7/fpTlDuWDgCrrgNcGPp3zKLzSeG7D0ySrpOSeBSWgcqDRyZLUjwXWTPxek13HQ/r+vnF6f7TcTXtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ofJEsp6; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPDlOEFEFfOyvLBQKOPb5mRlkOpW8UvGObDABWWvcHtx/6iCkuxzSTbLCQIL/rS8InUalxWVcC6aGp8yKCURrCAa/0HmCshy//0K2wIxLlCdeEzfPXD2fIzhcIPC5L3P8h2ZhRD0aSRrag9TJjoaBoRUHDwX8ehJ3VCqX4YJgaT4KmbsDsxg1yBa55uMNizvFPz69eFHF9KCbb2kInIM7F77zftIBZ/T8RnA6mAqLB1f1d/Q8EAAfAmV2pv4XzYJSnFZy0JuV8OIJORanbGXgAwU4/FNHVMoaORJzwoT+/xjjAckM6WaqXTtqM16+OVwCunyUXTjy47gFYSlPbtrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpnm879Pu7fMJWfd3DcYy3lUmgpEU98v2ENOHj8Mx64=;
 b=nY+coYi8O55oxVxDhVdRVUdck3PyY0SAb2lB6l4NNA80UDlxDCy0fBpBLx70t9gnKqviWX/2AmMhmj+LW4OT9a1YogRsN/eGZWXxw/SamJzYDLe6FOZJyvWDScMr0V0Zw4gdjUaS+VOIRsZdGfa0KIfcL7OnOyMtdDoGr2JVxu5C+HMc0zVv2IwHlDbT/+GNpZKpss9mNI4LmnYoJdPzN4xWQrSfwGWCm15en7lfNpqU7P/a38BzyDrKi04uoWcJir7vmb16Oci2i38vzY8AfNO6Nw1b+ObpQI3xiey6WjQYetRDjQc3mEclNzRmqC8GC4j2pbtHTFOXn/odzuMosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpnm879Pu7fMJWfd3DcYy3lUmgpEU98v2ENOHj8Mx64=;
 b=5ofJEsp6kOR7p3AGKPVtw/TekioS6v7kl1rVUp0KNPjOx8q5x3U87iEWFtg/lB3M7wqq972oTWX72YJV2bu+mDhKRC/cL8K0fqhAcwiAglNmPnbTcgB4LTKQi4xbHrUqlPUSRiHGbeg+3qoiXblMG4v687NIXbptfMtjk/Gcuks=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 07:15:59 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::25) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 07:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:15:59 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:15:55 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
Date: Tue, 7 May 2024 15:15:19 +0800
Message-ID: <0ec1b203bc83c1acdaf1c5a2f3e51031b4374da2.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: a7095868-004d-49a3-4b81-08dc6e658be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?baacAqzS2brWWoBxTGbyCXAWRQdrr3IY4DSHWLlisLe3gWMZ1+uZ0/B58BR1?=
 =?us-ascii?Q?HOJ/tFebSsBiiJ3jmliuTUc3JJHXBpSWDdN33KRee5U3jJnmVnkvXSqgSeBo?=
 =?us-ascii?Q?KsGj7dgWQFHNM+UecXeKG+dJRc+8OJGwYJLpk12FkknoXuftT1YzV16PVHmk?=
 =?us-ascii?Q?4xHK1gmRLaqlRIHncb6BZWo2FX0e3McVVh643jSTskm9djwXZn13zGlVZb16?=
 =?us-ascii?Q?M23XYX20b1vH1v/6yujWwLTfS3Ccox7kQURATwy9Q69J9fZxGZ4L54AxKR7j?=
 =?us-ascii?Q?GnFBz/45I/Q9tM+Snhiic29rNhli932FOdgZ+7FkBMyhZOCR4ak4YOO/tbBa?=
 =?us-ascii?Q?7gqJEyiHzdLhYaK11JdfkmHXx50ckz/DjFs5wAoTmKOhiPAHxTYr7pkVSepF?=
 =?us-ascii?Q?oC8hv/P2ThsRUKnW1cHVFLvKMVjz5MF5MU5bpt+wCCtRQQ/9cWERk+dHSmFU?=
 =?us-ascii?Q?bIIADm9lJMnvrVVVCo/McXBGNzv/mpuFzDSJmYS3geugO9hwrz8CnGl20A/X?=
 =?us-ascii?Q?jYEHyduPYnMC88HqM0mOLARorioFVauGkyI/NEUSfTOroBw8MZQLvQIp+nXv?=
 =?us-ascii?Q?3Ep6j6AtazS5GI/HZ6DYT+kbFKrCxTXIHQ+hqunpgiFgHOtwblIzugn4PuYg?=
 =?us-ascii?Q?yTRM36x0pTeSDVI/8o3bOO/zBc1KupJ2SRN/AuSHDcCGG6jf9uB4legZ3RGY?=
 =?us-ascii?Q?g24+wIqwJr3TJXqaInd8mbZRYo0oYvoaYgvarIXV0zUeMAHmhvbL+/0i4VWI?=
 =?us-ascii?Q?mUJcRiTAe/lnO+cEj/CDxP7eUkEZPOcJkJIP3gOcKdb7xxLZK/wEjs2c17p0?=
 =?us-ascii?Q?tuBfAsEpdLozWII4PNxE7QwscLaZESik72qRc1YASn6vgsSAQFTQsUyBsH2i?=
 =?us-ascii?Q?2Vjrq0Yb32CnV6T1oauodcxtmOnhPNQvb9l49KHScz7+PZ7SeEOfNICcz8RE?=
 =?us-ascii?Q?Z7a3WR+fesiq6odcM8Ut9MJszvWyBhXm1Vlx+VqW111xOYR47KD9iWJP9X1R?=
 =?us-ascii?Q?BwedGAY9UTM8TBsUYgqW92PsJDpsqTS0J+ts0BjyOBVJaeahM2mvyAxhXLZc?=
 =?us-ascii?Q?kvbVv8ozKdSeXuvazaIm8l5jZUm6JNwVoSM3osgXCluF1GI40YpBDjne7FEk?=
 =?us-ascii?Q?0qIm6uvKgFgVsz3zWatftfRrP+k1Sz8SHHFIcYcFDPnJDZxac2yHGK5iBfM5?=
 =?us-ascii?Q?AWNRpvuDfwD020PoMZM9TgS/LFx5LBaCRC7kDFAi2kFQRPwfcNa3+f8XuaIr?=
 =?us-ascii?Q?dPEtRTo45n1xMjnN8xvPrn5gkt/oPsqspcOkq6WDCu99MozMJpYoKxI1uMI0?=
 =?us-ascii?Q?2WsB2G/cE7JQ0dMYn1u9mJYS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:15:59.6577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7095868-004d-49a3-4b81-08dc6e658be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476

If CPPC feature is supported by the CPU however the CPUID flag bit is not
set by SBIOS, the `amd_pstate` will be failed to load while system
booting.
So adding one more debug message to inform user to check the SBIOS setting,
The change also can help maintainers to debug why amd_pstate driver failed
to be loaded at system booting if the processor support CPPC.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cb766c061c86..e94b55a7bb59 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1698,6 +1698,17 @@ static bool amd_cppc_supported(void)
 		return false;
 	}
 
+	/*
+	 * If the CPPC flag is disabled in the BIOS for processors that support MSR-based CPPC
+	 * the AMD Pstate driver may not function correctly.
+	 */
+	if ((boot_cpu_data.x86 >= 0x19) && (boot_cpu_data.x86_model >= 0x40) &&
+			!cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		pr_debug_once("The CPPC feature is supported but disabled by the BIOS. "
+						"Please enable it if your BIOS has the CPPC option.\n");
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.34.1


