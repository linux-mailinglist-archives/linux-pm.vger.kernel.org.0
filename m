Return-Path: <linux-pm+bounces-18286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1339DF17A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45960163047
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59F1A08C6;
	Sat, 30 Nov 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FUe2mCon"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8C188CB5;
	Sat, 30 Nov 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980054; cv=fail; b=U/Pu3FziCnO+c+Zx4/N7FS6Hju9Yk7eg/mHOKWhx9oEYSc69TwWDufw5HlnzDr/Bo3tIvrWGpI1KpzuGgCzBzwBEEMHGIUdY7bndwVolhCCz3CdGEB5PcgjQK4nDsl4UEkJOnS+Pw0ILqDSr9x1h1uAfrYdHNtqQ8AkKX6kiEIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980054; c=relaxed/simple;
	bh=hECZMkZyOmPdRV/C1pJPOiwKMNq1IeQEeYFCaag9Rmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8Em5TAdCoSCdh47tSPnUAQpzmb3dplBkkDGpu1GhEipHwKfoG3qGtRjRek3Ig+n/WjBQIAk8Q+vd638NI3ThAivXkkTqQ5EeL1RbYW5FzgIKdy1QuEk8znNEdKVPs18bL51xmETK66xa4r3DaJx4oFIMQgXB77nzNZUpFV0Ma0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FUe2mCon; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbywpTqP1gwKMehbnMrXzjUiFYnsyGUiLgWJWB+ym+0Yz7x/1wt6YQx9m2TmPcGiFTE0lRf/GXQWDcdE9+4LfFPquU0tr1lb9MjyBTAA7yGE1QTjxDYotqBmy9VCcsjfCX+lu/goB8DxalHs8BhvZgddPveqtpo9l2loAoj8x1jePF7BNpK6rDN3L71Ih3WTzu7W6u4X6+QWvmei7q75vYQwX0V0ZwdakxW6BS/fLbIpeUJ/FKeJ5uBD1SGRRuPOaxexuvojLABXmxo9jVq5dyf6De+BHhgwbwRwIdkTr2adiJehCFvXpQe9ScAS3Cr/WiiE/h7H8B8+AR1RNRW3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmzaxmQPUpba4J+WKUoRefh7jYYsfc17cMXsX7vJa98=;
 b=pZwMlqhxyy1mDMrmErvGh3Q1mlF9LTCdRLilR6oGItP+cbyURY+2kjfhO9zsJ6vVz0mri5/fICZ7wOtG2+FXraWrahKT34cOTPSxU8u4ewroZmPrs9xGw2mknE0zvJWLtSzFSgBAAgPvZxKRS2FUdR2tKvTRkfoQa3AcPpn2c8tq9B1039s523nehBnl+ns9ZmDlc23iS9jFyIqcVlPR7tm0th8PKmDAUmG4uo5TeJx5pBIU/jqsbYQ8TYV6ymAo+ijtybjp1MprMpLYZ78WDgaM7YPcIFxvxTzoeHI5rI7UqrYYEDlOa2RukRDhswwh+9NJURaL6/JLd0MlWxC5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmzaxmQPUpba4J+WKUoRefh7jYYsfc17cMXsX7vJa98=;
 b=FUe2mCon6KN3H+swqzsOsGBMuzyp0SX//+XMoerJDpUMs/He7GYo6Xv6Joz9loqJX06mCEYYGsBfYjT/O7OddamJCicxl8YBAYRhk4INmW0nb6FTfDvfrdUH1ZETLOqAR/0R9A02yfGinTdoRyl1YT7NBP4QHJf7qvzg1HQ8SMI=
Received: from CH0PR03CA0304.namprd03.prod.outlook.com (2603:10b6:610:118::28)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 15:20:48 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::b2) by CH0PR03CA0304.outlook.office365.com
 (2603:10b6:610:118::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:46 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 02/12] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Sat, 30 Nov 2024 09:20:13 -0600
Message-ID: <20241130152023.684-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fccdc6-56b2-480e-f6f0-08dd1152918b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mP4REPKerYKgK04f7qZVMU1FrmPKLGojw4B8mceVnouq1L8WFiTg2EVTS40u?=
 =?us-ascii?Q?Oewdtigm9qDroUMhbt9W1IWixhW6mqu3VDM+dJUxyYBqubKIbrg1RkTyz3/l?=
 =?us-ascii?Q?9vCeP8JAS2TwL/lfnWxIhDwulqIHtkjr0ZF0V7rtJkO0IuC+WEUvywbyPT2j?=
 =?us-ascii?Q?wq/Ss9YqSY4lkFMiF+8/Giyrbxi7AWhxvr8oZ96Pc+9TjfuR6TJQqOZ5ZpOk?=
 =?us-ascii?Q?C8ttD7u3EAdSdv5h9E7aJf8XQbxYpNHGbt+XLC9eb6M+L28mexVDTmOKu4+I?=
 =?us-ascii?Q?obcbbcW6hkX0l4C+to+qVH6W8BQwJnrnQnTACE4+pfol7xNbfEKbdZEAR31V?=
 =?us-ascii?Q?LT0pF7YI+M1kaBMHzSRaQnhnBJvCr2zHcR9x3YX2eisucFcO9beCAP+mcck4?=
 =?us-ascii?Q?FjMkk4yUQxZ4hCFtX1EeRq84oHANto2mR5bTwPjWwBk1LcJrhe5Qx0G5cuLP?=
 =?us-ascii?Q?6mfqh9Upg5T+ZlLWyQI9cu4/+aREU5wbKSZwH8vbZ34CBTdfUfQg+r4tNtxi?=
 =?us-ascii?Q?lwY6d1jaNHAz/ZXjesoEDqVY0JHLB9jS49wPRDnoM0x7S3zg87zDxHzy9EZ/?=
 =?us-ascii?Q?QqsmrPwHebRQ6883C8ebbT6QHzagXmJqHAeNP+iuPwAMQiy6o88uWtjICIDz?=
 =?us-ascii?Q?BAA4JmsTbx6RbjHaO5sTjM4byHqsYCRxWYlYezKXfTk/ih+1CwVExDzLOz+W?=
 =?us-ascii?Q?E7/LMe9n00PaD1mA12vnHWJlGSV0hVRG8v0L8boWGgzSqMEbfMndKDUoVnF/?=
 =?us-ascii?Q?zi6i+rVF3duS4uHbmAQ7nesDuYRoPikFebf1Xkaz6W0yoqyyXc9KuO8cAOZg?=
 =?us-ascii?Q?Z5R0FnHZWm2jsqV7GPJgIRRRPSfhtU6dEViCbb/AIuN1dmejxnfIvL53bcnf?=
 =?us-ascii?Q?lRYQ+BZZcZBDMF0Khj6oDZCljnEF3vNig+r55wUqKtuMG8lmbX2+PDqKUrYB?=
 =?us-ascii?Q?9xzo6uhp61l5r4LYh1D+4kru4b/crqIhS/ju/e2/HYcLq7NlK/8kilpiGEfc?=
 =?us-ascii?Q?77rFICqbesLD8lEaSVdgW31PDkWoq480zWIIfFAEFW5ibxSoywaKnsrdaE/8?=
 =?us-ascii?Q?69f4l1b0X3THDExyFyYiaG2VSV6nALi1rlJzw60+SYxJNHBbNzjFtknTVZTN?=
 =?us-ascii?Q?t8vOyHzeMvZ0pLBqUXlUtQnYp6cUeFw8jMXmKdV04pT2KsRyFKoGa7WRmnue?=
 =?us-ascii?Q?l2y6ftzdxORsEPq49tGTsYE44RnC+Ec4Hy+V4fIo0ww9qDIcR+QalOvTMmXe?=
 =?us-ascii?Q?YYB4fqoKBBjNNB+klQ89HPswpM3aNYVbQ4MimVjvnD7tz4TNdZeDh2vbPsRz?=
 =?us-ascii?Q?qqMdUIVg04JTsmfUmtfXlLeEACTaOcqJaUBHL0/noPJxgRQ93tJC1BIqwAqt?=
 =?us-ascii?Q?jKyu1TplDlhYJsnT7JkWH6i5+yqPX+jaDrhpRD9nO8Kn0olX6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:48.2244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fccdc6-56b2-480e-f6f0-08dd1152918b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Mario will be responsible for the maintenance
and Perry will assist on review of patches related to this driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1fcc56bf2fba..62f384c41b36b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1085,6 +1085,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp/
 
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	Documentation/arch/x86/amd-hfi.rst
+F:	drivers/platform/x86/amd/hfi/
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-- 
2.43.0


