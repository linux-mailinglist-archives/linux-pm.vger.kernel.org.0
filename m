Return-Path: <linux-pm+bounces-9785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A750C912BD5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7E41C23DF7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A3176246;
	Fri, 21 Jun 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S0uL4Pcv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FD168491;
	Fri, 21 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988709; cv=fail; b=QzNr2li9/7B14a1F/FXqFViO7l7wGqGfxmyq/Q1lFXZdEQiXCk/7xVtXoGJbjh36iregqPnIh8j/KK9IqClAzr71h/w8lZM5JnCRFhjTospaEEuhYr3q3WgK0w0A2vHUCXKm2gtCNRvobnh6qVUYpIsCQLC/DZugZexLCMF/Do0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988709; c=relaxed/simple;
	bh=pMBC6gxUeoOjPn4k+KS51ROO1oYl4S4hlfOolztnRO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsDw6k+WfUWNDx8F+OwkQ4n+5lzV10V7mwKYPgGH6dHDtusu2T1dhK8p9Nex8ZiOQ5SXgahpMtHd8bxpXIpR6dAhfdRaSaojn9/OYQ9gOsfrgF0lmrBbUVWLMcsvavQayrZPKYhirKdo6d7tm3MudH+nJAkq5zC52gRHk8faFWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S0uL4Pcv; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO1Zu7P6Pm1HEjMyeYKLkR1HD74ckZ38bA6XrEFYQTlAeqwAYJqYh9nHa2w8PuI2lL/suJ+f20qlZZkGLan+9lvm/nlf+dpMP9JMOQ/plLiVe9dc7PGXG5FjZ8D71SFC1FuiY2GV3DxnHXBU1npncFmTGU4uxzjO9ybiDaEtO+fMF16Rg0h3jjyOPZyIotQN1IZX0DVgaqJaZqA9cA5hGwhUU9FBjce1VhDY8RdvQKAEkGLQN0rNWfLi8jhf6Fx/dVes8f12LEvPrlYwy/L/3DtrR97Cf1s+C2+IxLm+BtzqiKjYixK5ah4P09XO/Fg1CsZ+0ewW2GIbeYbxe/MytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovj6wbQK5jpoaNgpuE5BxXhP7O8BSr/ouZVyWoC8UOE=;
 b=fBMg6Kf7tNcos/4y34ItJTV0d4Hldn7EKXG4vIAa8U+vT/NrQOejnSjxPjx26HOyFT8/CtPYUN9J03RtXVex1RifybRy66gXiycceE/FQQhDkgmCvnfNm+wG+vrD+0mdjpea/eoPSgwqGgkp9mGOotYI+S0VyGRc0kLSge4hr+MB9mCVLcl2G92QLBQ14CHcMd2abgwX0pvHZQVcLO1Beb0lIeRbk5cegm1lSlIC2y+PnBddbkGDacn9iC+Vatbb937bADfCuqc6MWm1ktr4bsTLY4RSRUCFxGmibe3MZRrmAOM4nBE1uySBfmpI/oNSVmeldXrbUgEnf2LPn+emlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovj6wbQK5jpoaNgpuE5BxXhP7O8BSr/ouZVyWoC8UOE=;
 b=S0uL4Pcv+OAaGzj4Tv5U7IxA1rdS9DFovfbEjLhJaiRMmoRBDySXgX/uQ4sZMfCeO/l14gEIJVCsPes0mNbQZw7WZOX7lGxJhqnKharzy6Rcb9KfcIBRvrNLFD3trS1Hhy+q5kX5MkC/QkomPA6X1/Wl6pnVykw6TyhIKpIJstw=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 16:51:45 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::4b) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:42 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 9/9] Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
Date: Sat, 22 Jun 2024 00:51:04 +0800
Message-ID: <d6298998073125cab0f822507aaac1300faec6a2.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: a4858824-2278-4999-af2d-08dc92126f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QlGbI/e+NAqndc3EGidBpxmRsoJX7zNVfRIuYxhVkPKIBehGIWjcX3gGU99m?=
 =?us-ascii?Q?9s+sFAZLW6RknWFpr+Cq03G3Jc6nrTIyq9TkqLNPtzslYM1+Do1/54Nm0ryA?=
 =?us-ascii?Q?ukj9Icc1iPbF5UZNnqTUus/pY8UvBxKiU1jwRAGuF0t92hQ9DzYf3ODlVT4/?=
 =?us-ascii?Q?N8NQkbAxMQRgigadAuDyp0WPZodzsq3Ma0uF1ZSSdzgSBEfNrjqpsADU6NBp?=
 =?us-ascii?Q?PeAMRHzxgpQlvt0wn0LNRv2W0omXKPlw+aWA1KznXJcX+7bhytDW6N/e/uwz?=
 =?us-ascii?Q?XfcipM+hZKlTR2nS1WO0/rp+MfZyotfDSq05qYsMDbldbvKi38EX2RT7RtGX?=
 =?us-ascii?Q?kKJ+9aXRKPiGUUOcor0TnjbwYC5HBxvvKPsoGdul9yXtF3QV3SKEyKE4b+xc?=
 =?us-ascii?Q?PwfWt4JR6JGtFdY1kQ8v7UGhv3ngg4QKpMguaKOP7UMUgwkpIU3XwGH42b2B?=
 =?us-ascii?Q?Xu+y+VZO+LmtIbSwcK36Iry+91ktl9TS/0J4KWTRzuWzRNrAfUePFwEkqzyY?=
 =?us-ascii?Q?yeCXPWJO77IBGjcqC5AM3aywa+62F9I9VEXqqv2QFZ3o8oK7SFXiKd8azawQ?=
 =?us-ascii?Q?Z79l19n+Rcslrtb/qLbST+vGx27Q4LJJQ7gguSk3nHTGasBeO5L7pK+lUnXr?=
 =?us-ascii?Q?JWH8pNNwH162HfrkFMUxVmBM6MTxAMQUD5gK8A1awjARH1TyBe0X2TaEbJXu?=
 =?us-ascii?Q?9vcWZUwVxDDX1XjLdq4ynpWcmryoUJS0vpucbEx/w557XIb3daEva4yk9ITu?=
 =?us-ascii?Q?K6L7EGdKOQJ27C4D6AX31pgULlRb4sLRMVWBwcoMj38qp93xYjEjovdd/Kbj?=
 =?us-ascii?Q?ddg11FB/zkemj03nvT2JlpWAcdU9AODP/SllJdaqGnUzpTRtrslFnp7kBzzA?=
 =?us-ascii?Q?jm4JQSe5iCszU7oJVGbY76c18UYHWhZ0UNINrpON9OR873G81CgpUqRBTsVt?=
 =?us-ascii?Q?t9TSjUMsLyeUbyILSuJ183BzVXVT6YGD+bR74w+ciNFnVAspv89toFcJT1N6?=
 =?us-ascii?Q?Fxeg4Sx4othoa+MvMV1cw5kXA5l/8VK5E7OfNTw+YcuRQg0ZWD+3nhWLynWp?=
 =?us-ascii?Q?ljk6staVDbj2zEPIMOO8OQkZIRURT8P8waWUY3GM9d6kB/Hu+sgA7puEjIOf?=
 =?us-ascii?Q?cGcoXw2xNSTLtmVJCzJrp5qh6iMNBem0BwShLPk1Z6mIVXkkyzfitPx4qt5X?=
 =?us-ascii?Q?faooomF2FIXOH7qi3dadElMcZUXFNS3oLuHhnOEM2QrwTyUCd2mYOwd1ImnI?=
 =?us-ascii?Q?QKMHxU3Afnre5TWuUwWeq+wK3EhXxJJ3ktI9O4n8ECs2OES7lqsRE8V0CeKT?=
 =?us-ascii?Q?tru3DzZLbJsSGovSPz3g74/1t1a1+49KD0K5v1UgoXserHkDLhKik4bDXujC?=
 =?us-ascii?Q?SyM/+tcsls5sc+rzm1a+LbuBPUvr/auqBsGnPXOeNvi+LWN0ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:45.4993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4858824-2278-4999-af2d-08dc92126f71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

Updates the documentation in `amd-pstate.rst` to include information about the
per CPU boost control feature. Users can now enable or disable the Core Performance
Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index dc1b10d7dd09..57995f54f0c8 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,27 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
 firmware, if EPP feature is disabled, driver will ignore the written value
 This attribute is read-write.
 
+``boost``
+The `boost` sysfs attribute provides control over the CPU core
+performance boost, allowing users to manage the maximum frequency limitation
+of the CPU. This attribute can be used to enable or disable the boost feature
+on individual CPUs.
+
+When the boost feature is enabled, the CPU can dynamically increase its frequency
+beyond the base frequency, providing enhanced performance for demanding workloads.
+On the other hand, disabling the boost feature restricts the CPU to operate at the
+base frequency, which may be desirable in certain scenarios to prioritize power
+efficiency or manage temperature.
+
+To manipulate the `boost` attribute, users can write a value of `0` to disable the
+boost or `1` to enable it, for the respective CPU using the sysfs path
+`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
+
+It is important to note that modifying the global variable
+`/sys/devices/system/cpu/amd_pstate/cpb_boost` will override the individual CPU
+settings.
+
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1


