Return-Path: <linux-pm+bounces-36658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC019BFCF8B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCD118915CC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38967252910;
	Wed, 22 Oct 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qi/x4Htj"
X-Original-To: linux-pm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6D2472A6;
	Wed, 22 Oct 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148312; cv=fail; b=UqbzGLDKO3yUKXUKVTkJ2+vo7adrvQOl7ZxsOZUjJYZCdn3MTI63hLHp+TsX/NCMplZ94sHdMiSxc0ecYUiTxbs4BtgjnlbaOsJ0A2AYOzeT6+IT27wK2oaQeuBA4DkNUPi9ST9XTcUISNwFBExAeTv7rJXRaRITukDeaJyQ32g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148312; c=relaxed/simple;
	bh=AAYb/OGYjXrOf2rAAVfFjVK35uQcQjm83c+OXtB+1Vo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QM60bBd1NY57toHtdIz4itgFu/YP7pjCeCJkIrJwzJF7dMp0i4ordgHoWBk5nilw11/1zHK8rLvyGnP7vYPzfE4gw5tyYVMhdYufgCwZ0VPn1s8mx8WUzgtl6zXBZot2MoLAC6eiHLConatTtXfQKcv3UhfjFTdW++KvQTes884=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qi/x4Htj; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS1EPacSFexJIPZTsuQLH57SYkBkjP+mCJmm2sEoULJlbtiBeknX6HfjYcvrIjDQmDVMW3SzRBKNxF88zfydzZaKzhLDVpEfJ8KNW+4hdlHYuO9aKM+cEUuibdhb0ivxf57xMoE57z65JLfp/KB4nsx7QXMW7Mcd+/XRxmT4ehPpiNyhfOAQrWjYz5Ou6ESH93Rstbxc+M/FWnLbbo/BM2jLrc0M9vxn9aB4gO9xrioZ5ort3UztTXnRTg/ZlzR662VtUEypiNNQNpgSvyrzUw31vGm5kz67AJET09g7nf0n2HvR3v2F3sfADjc3NUA6NRtd/a35ehyBW+8dFjNdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90Nndxqn/PfzgZdN+XbMUgalWPyA+GGSp4bwPU7KJSg=;
 b=tO7BGB1MUhpKn8y07/V5M0zVTqBxq3sN9ynWgTOzPaCacMZ9ulJ60M/280hwy9lq/hcpCxqnEuaBCZiGGjhQsD7Kgx4jfb+K2oOJmSdPQO7whX8uESao4YaYHCdR+Zfq5wnGhrfpXKAEe1D5j73wcTVxeXClIyb2Y3W+GT0o9WjeQ/bDqTjcRQOcr30QcffENnCN0W91BQvFc5AiDLyAKUGsTu8q0MVJV3fzA9EsHy0NBip09u/HMzVYMYec5tfJ3x28OCKHe6AwRK4W4KWay8JVIzgFH50kJ2VOBRmktgSgpOkb2h4pMkKmGwlUGdaZbqXWgXet3c6BgiUH3IGiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90Nndxqn/PfzgZdN+XbMUgalWPyA+GGSp4bwPU7KJSg=;
 b=Qi/x4HtjLzJxAfDJ6TQ9gdDPaIDPmXYxRAbAi1JBGKgSViXPlin/SyaGPsF7uSJFytTsOptleyHYAJa/9crDuLMx52YztGhfWRcaW2T9zymimc5VwHdl8QmWMPhFzZcB/AqsxvJiCldlu1Gn92aN+pQHLLPu7q0fPYcUHpuhLlo=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by CH1PPF6D0742E7B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::613) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:51:45 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::d4) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 15:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Wed, 22 Oct 2025 15:51:41 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 08:51:40 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<airlied@gmail.com>, <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<corbet@lwn.net>, <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <simona@ffwll.ch>
CC: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH 0/2] Fixups for cancelled hibernate
Date: Wed, 22 Oct 2025 10:50:27 -0500
Message-ID: <20251022155114.48418-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 84177267-9179-4cfa-2ad3-08de1182e4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hv7I8s+tjuWlUyUUzu+nC7k/v/fZXO6xKgvZHtnvrFhhxz1r52oqCZhmvt9A?=
 =?us-ascii?Q?7Tj2nHAScUWi6LcM94KvCG3XFkV11Nq1TeGWmqRKZYFlcCiyp7so4KXwRw8M?=
 =?us-ascii?Q?XMP/dAleIKLHPamb8h/YBeWANI5VZxJ+kkoofZ8XU5Ak1LFNAPwybF3exqfb?=
 =?us-ascii?Q?iYXO5W9GoZNNhOexljfQddP/PTJnENBgp16qwmY4ddlvGKVLXQo+8BY9Nbv7?=
 =?us-ascii?Q?g6iyHqvu/7rfXzptIMoKQbduY7C9n1NDJxdkZURZlA0zCKaNQcyVxRBpcD8r?=
 =?us-ascii?Q?dPYD+cAh8Dqbowz0IMTJF4pFby9qzSCw984md9myRIpxI4Sm2Okn5gnP+EuB?=
 =?us-ascii?Q?lJaQWqCA//hLgUusj2vBb0WwoXzgqr3TdXZmXlxRfJighscPBw64h2vj20+U?=
 =?us-ascii?Q?K+fhghmiDEDRxEwX2+eul3EJ9Yt5Epz4plmno5bnEy1RBuHnufILG9zVZlmy?=
 =?us-ascii?Q?4k8yHvH0z/1asIRhcqHt3a3ZLti6EQ02VRbUY7uE5L0sTY0TYG0d1eYsrrpO?=
 =?us-ascii?Q?NJ0GbSwFan3HUFwaGjR+ISC4eHRdPsAH/i+ovcXDpp3y2rYnQ7vx4i99uZ0l?=
 =?us-ascii?Q?VM7dg8K9bARGkA6wzccr6/va9mywCSgSre9nF8br4RVuBdRLQLShY0jz3doB?=
 =?us-ascii?Q?YFwVj6B9EuwsLrs+OMNGkzLUmx4tWFiL6E0R4BbtWZSOAuEyUoLuWzjuYpdx?=
 =?us-ascii?Q?/WPdUYYIXBzCNRmSyfFs3BDzExm6EMSs4mS1s13z6r0R6KENNgBR5OLSdcy+?=
 =?us-ascii?Q?R7/Q/S7elR8wydr3muvUGLHEUGwelwpVVLf9HI+m0YE70hXuJNWvDkFWvjkT?=
 =?us-ascii?Q?LeZ9+ygLDpSw/fmaZCIkSnuMReivrfGB/tpLCTLyzAe3DiY6KF1x2c+8WxAp?=
 =?us-ascii?Q?UV3xj0qH0q+dO3ZlKzX5G0yIVXM92Qnc6d7u0tHBKXByGSLPfZ6wGAFQ0kVF?=
 =?us-ascii?Q?wzWLQsEZ7g+bpZIRtWOb4SpWi97DGhROqyp0BTLQdL0NBq+MvtxtjllxK7JL?=
 =?us-ascii?Q?vRwc8Vt05twzot6aKLci6LWeVajWP6/7XM/XRj5LWALiENHj78RhYqLt6yRy?=
 =?us-ascii?Q?CNry3tICeo1h8t7E1vJQF7SHrDarRyyU6NIBydPVN7coL1CxjuP3f9oTPqY+?=
 =?us-ascii?Q?n+leb1g5Nd80Vsmq3aOhkiu8aiAfZa7YevjSe34SI//5OSLrdyhMMABpWAdl?=
 =?us-ascii?Q?TYdh64C8Wj5nmv1rNFP80uCEivKDjTt42tFtjKWkBKH98jMpwEN3Payb1svU?=
 =?us-ascii?Q?zamCyGwt3RbiC1i/6yRJex58fCeyGijkdA+gLAgT4QNoDObPDz8DhgxJuiNN?=
 =?us-ascii?Q?NfkNFHBGiwhBc9X4jy83JUSNZ/f4sznro7HIwgQkgcaGcH351mIEFMc2YeRr?=
 =?us-ascii?Q?5tAlZrVc04q8PDgB7e4W3HFSY8bNHRLMMGH8e1P1p0VBnCffWZN5/8Hoexsz?=
 =?us-ascii?Q?9ouHslW2p0dTCuBA3Chv9N79akyrtAYXFv65WgRz69oVbbDKMyUt9WSuQNE4?=
 =?us-ascii?Q?nJczd7OD9FziEHgRffiAwgfcMe510x4t67sDZvrwaf1MNqhYGM+KD89/Dg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:51:41.3788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84177267-9179-4cfa-2ad3-08de1182e4bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

Muhammad Usama Anjun's recent series for being able to cancel
the hibernate sequence [1] exposes a bug with amdgpu handling for
skipping the thaw step.

Because the thaw step is skipped in most cases, cancelling the
hibernate means that the device is left in an inconsistent
state.

Add support to the PM core to let a driver track it's frozen
state when an error code is returned during thaw(). This will
ensure that the poweroff() and restore() callbacks get run.

changes since RFC:
 * Drop first patch
 * Introduce is_frozen

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>

Mario Limonciello (AMD) (2):
  PM: Allow device drivers to manage the frozen state of a device
  drm/amd: Manage frozen state internally

 Documentation/driver-api/pm/devices.rst    |  8 ++++++++
 drivers/base/power/main.c                  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 include/linux/pm.h                         |  3 +++
 5 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.51.0


