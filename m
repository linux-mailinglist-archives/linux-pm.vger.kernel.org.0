Return-Path: <linux-pm+bounces-36659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30ABFCF9A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 17:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FDC1892D48
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CB24CEE8;
	Wed, 22 Oct 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sIY8UEKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64E24DCF9;
	Wed, 22 Oct 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148314; cv=fail; b=U/JdvoLxCJl9gg0JZ7vZftD8sedbTUfLT2Z7A1ur/ESJFwqAWWObV0GrOQ6KKfRIVW5BOUKRaOe3m6zc1UntTCuqelmMJXQKbLyo4SKxLwdo22N4IV2wcrcy8TfqIDPT4ugt3NOxsJtU7tFccxFReI1OLgLy5KF5Dzjk/2cmx/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148314; c=relaxed/simple;
	bh=2b+1WuYWJE3cI3jM5ln5OIznMqMmj8HunMBvC3A2PUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoESnle+p+2SFhKteYvhRwQdCRVcLD0xcq3Z2eVAn4tmROrQVGEYjlkl1t8ep+lv/UU7zdnWcZS387mdCOKhnBGmiB8DyMbeNnC7R7CeOMvafan1bIsNO63XNX4OzUHpYFB7S3h2uOY+NX9C8Rblu/AexxO4DFW3tBEFL2Rf+CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sIY8UEKf; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLqmVWK5l4ibjPRgFy1EYdldh1N863cFlQ2Y7RoVKXYn9+HozoDdAxfbUe6N+eEoL6tqXF6N+y3AJ4EpGjM0o3LyteFFB1pCRlDhrzgafAv4VOe9yMd4cmxBHFM7ut0692+Gq2i66cy8gsOW3hNkHbdZAcO9ubyjAaHZlu/N0v3rRwBbAeB5VcS5t4sdH+RHmyvd8NJ4yerFG7mI7rHAf+ljlHdM7+AKbu5S8Hbq3QzZRLCopTL/EVKp3Who2FWmeeJePKac6AQCiFFAhIOGjau0CmmAsIRMC/bjCQcG1Lv44f2rDvrSHIZRNP8eajGI6aqmjQhh7tIhCSAPhPw7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR+rc/mlH/9KCT7wYzKlQPdAV30DeJg1/I0yoGaR1hs=;
 b=tZ+wdEdMHYnzLc9TR4huPmz3zjiC/9WJM5VoOW55qjmHVaJ/bU5niGszjNvF+1GosFqsLwv18LJkOfGf4XeIEh2F0tb5XqfK37qEFPagi4hIRG6KMoG5HdT3jJjV2DWgIj/h2DsfOMy2Zy4iZYh6onYryB18Q6wzfhugPOVGL+uMFeDPNXAp7MGa1HexGuqCAknu4/WTJD+0NkJY2QuAe9XsMoQmrGIOvxxLC/Xwq/LTsqNRukactNH/CUDkZGMy1Yy7IDb21cwPEBoPoc/JWJf7Pin7YiDIOM8rwM2gfrI/vZ69Wcf+2hdRuIF9B82BVJbpsrgYQd6kNuBAxHOhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR+rc/mlH/9KCT7wYzKlQPdAV30DeJg1/I0yoGaR1hs=;
 b=sIY8UEKfuCx5P9iUbcFwrWme/lXthIfifCU906sxKe8QDSFc+Ut4YLUZ2wIizFXd9IvkD0jFQZ88a/bQXykDPPdtJDqD/sz8GYnsmMofwe7XGP+fn1KPlKHsA0DbizMWd+L7X8/PTScjxkIhvxsLnqmyfhCMzUpCMLn5qIyoE34=
Received: from BN9PR03CA0905.namprd03.prod.outlook.com (2603:10b6:408:107::10)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:51:45 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::36) by BN9PR03CA0905.outlook.office365.com
 (2603:10b6:408:107::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 15:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Wed, 22 Oct 2025 15:51:45 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 08:51:41 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<corbet@lwn.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
	<dakr@kernel.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH 1/2] PM: Allow device drivers to manage the frozen state of a device
Date: Wed, 22 Oct 2025 10:50:28 -0500
Message-ID: <20251022155114.48418-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022155114.48418-1-mario.limonciello@amd.com>
References: <20251022155114.48418-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac1fa07-7351-4e9a-5353-08de1182e737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHdaQ0D4K4hVYNqMBIXas1BQUTtYm0NSWQs0MAnwkuX+SJEwWe3nj4RxGi6N?=
 =?us-ascii?Q?j495wjD7SKKOAQGSWQXVEtBx5KL1QcvuFDvTqubb1/MNf7gzwS9vCjuEMY4N?=
 =?us-ascii?Q?F0jbLD5a5vgDRYn3dTqoxXkW6wc2Jb7uy2/ot4hNZMy/RVA8Yf9h0xcxkO1s?=
 =?us-ascii?Q?DlMtrjSoBxnZ77MY2xamlArRe8ML3e/cFcG7KUkyxw8pf3sOx0FP1LSYONsh?=
 =?us-ascii?Q?7ybhV+zPYu/dIevJ2qltxWiEeHALCFyl5pNmkg67CcICAtfSSXL3TiTozbP0?=
 =?us-ascii?Q?w1pXUcDEvO0kZTGcfCDIjhrBRQ9eVajo5G4uzKSamTHvz6gJbrtfEYdDXsay?=
 =?us-ascii?Q?wQVbsxD618NMGPa7K8iDlC2XvxErN6+2uIRNARF/cu//lyQje7yx+vZqZEg4?=
 =?us-ascii?Q?Np8Jnj4lVa4IO3UqZflF9TY7rj470VZu44rXBT0bPMzrEcCU6PdU3cv5sKQE?=
 =?us-ascii?Q?adSJxmit/vGRXrS1pZfcD492aznDKQa13mJCPqLJFh2bSMJ46lfFFFp5Jhru?=
 =?us-ascii?Q?iNs/+XyX9hUJW7r0RmiSFUhd17tsFt2Wmk32xU9ej8ndq1bQVlLRfs94odHn?=
 =?us-ascii?Q?WFJbMA3pnuYS3/2gL7OJfTFZPxANJegbpMLGR4etgNzX+QmgNmPVmX9T9xIa?=
 =?us-ascii?Q?JpoR5QyQLHDFNHuXgGUP3kKFjxZchnbRTusqZPx2jQTrU8BRntBG4hAx3NFx?=
 =?us-ascii?Q?mQMe1TzOLU+0FN1mRjdB0TPoLlHscL1QzoP6rRwQMV31O9sXC5jv2Ryv+6WA?=
 =?us-ascii?Q?ortYPUia6knnrF2rp4jWJcEUrJ9HP5b6sxj9vbdElV1Xy2dBvF9Qnyzn86LP?=
 =?us-ascii?Q?vrfK1/5lukPr/tm5ychfAfAaXHsTE2E/hiwLLIncyzf1Jfu9QieT3sPTGDQm?=
 =?us-ascii?Q?PmAYnYU/emQGezsge60I+UWX5fdTupi6VMVyXAkhB+Zzz33XNHOYt1V5fBaS?=
 =?us-ascii?Q?Z3TTm5YWWAIUmrhwCUHJ7ccgtA5qYDcZhqe4CS1xqwARKWPNVQtt//+ctak1?=
 =?us-ascii?Q?lUYXPXo6jBdx65izDoitIQ1O0RhAoSd3PJmXsxWB/bM+ld5DgxgOqKJBL7+K?=
 =?us-ascii?Q?KFiUbfZtGru4Lyxl1A3xXzedynNMyj65Z1pO3/ecnXbMqPPYfiuYjtH+4xA9?=
 =?us-ascii?Q?4qLPWXIS2UHu2igXZTd5EkLWDToVfIfujTHO/HT51jAYFhpo3LWQnXapiogK?=
 =?us-ascii?Q?KwFML2VUqnVV4Y9i6A8cTIXPFF5MKE93pLNdNn9rsV/cAJLu1nBBpC1fDCmf?=
 =?us-ascii?Q?3BS1sUU2/Vd+3QX/9ZC7N8TmsaqTvbhGZjKDDPEZYXIYHi3+NvoWGN8hF63R?=
 =?us-ascii?Q?S6+X0OrXMztgXrmvGqnBmCG8RztL1Ts8WUwBV06SEEtLC9+F8jjBVeleYjDz?=
 =?us-ascii?Q?rvgP2sxGhlOL4gip1XzI62YpjhUxK82kLO1fKhVePj8vxaYlnnig4qXrw56L?=
 =?us-ascii?Q?R5jMHBfkyTmRgWu0bxgwGmMVYRavpKGHBuNhpBZa8lGK4rScGx7DG7SDC+mK?=
 =?us-ascii?Q?rXI3BQjHdGz4Pg8qsg6ZNmiAHVTL74pEdHqc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:51:45.5351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac1fa07-7351-4e9a-5353-08de1182e737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

During a normal successful hibernate sequence devices will go through
the freeze() callbacks create an image, go through the thaw() callbacks,
and poweroff() callbacks.

During a successful hibernate sequence some device drivers may want to
skip the thaw() callbacks.  This confuses the PM core though because it
thinks the device is no longer suspended.

To accommodate drivers that want to do this, introduce a new is_frozen
bit that the driver can set and manage.  From the driver perspective
any thaw() or restore() callbacks that are being skipped should set
is_frozen and return an error code.  The PM core will then put the
device back into the list of devices to resume for any aborted hibernate.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 Documentation/driver-api/pm/devices.rst | 8 ++++++++
 drivers/base/power/main.c               | 5 +++++
 include/linux/pm.h                      | 3 +++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index 36d5c9c9fd11..55c633727108 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -578,6 +578,14 @@ should already have been stored during the ``freeze``, ``freeze_late`` or
 the entire system, so it is not necessary for the callback to put the device in
 a low-power state.
 
+Skipping thaw phase
+-------------------
+In some rare situations, it may be desirable to skip the thaw phases
+(``thaw_noirq``, ``thaw_early``, ``thaw``) of a device entirely.  This can be
+achieved by a device driver returning an error code from any of it's thaw
+callbacks but also setting dev->power.is_frozen to true.  This indicates to the
+PM core that the device is still in the frozen state.  The PM core will consider
+this when resuming the device in later phases such as `restore` or `poweroff`.
 
 Leaving Hibernation
 -------------------
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e83503bdc1fd..451d54486645 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1100,6 +1100,11 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
+	/* device manages frozen state */
+	if (error && dev->power.is_frozen) {
+		dev->power.is_suspended = true;
+		error = 0;
+	}
 
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574..52ee38d72aa2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -688,6 +688,9 @@ struct dev_pm_info {
 #else
 	bool			should_wakeup:1;
 #endif
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+	bool			is_frozen:1;	/* Owned by the driver */
+#endif
 #ifdef CONFIG_PM
 	struct hrtimer		suspend_timer;
 	u64			timer_expires;
-- 
2.51.0


