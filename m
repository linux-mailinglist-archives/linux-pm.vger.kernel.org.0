Return-Path: <linux-pm+bounces-8999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E9904D8A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 10:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AE52881D9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 08:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669F16D30E;
	Wed, 12 Jun 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gFps6zft"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717B16C84E;
	Wed, 12 Jun 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179489; cv=fail; b=Ifm6NrCsXiTTpiL+KCJqbrrv1yy28pMcIG2ABJTFoxlpXXtSaHseRzeg6xmXMfYn4bInhXO/Y9PkKW0Wv2bQmLRUYp3r2oQ2WC7bV+NVYGEQb2h0/f/MBnyyZpLhnreDivqVkgg16SPwFUzbQqd5T1ppod9F1IZ454vZAAMur6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179489; c=relaxed/simple;
	bh=xx7cfIY91yRgBEbFCGIZmvw9PkoBaqhWHo2tN58OGfQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VtIl1Tz+biawJwi3MelgEfUrX4QshxCiJaHnfbOvYOYIYv7D03vFQECItF9BCfPyka2R8VZGJ2ZI5xBxooE9eKWXetefSlfVtVrnZ1xzOyQQbsPMO3KVBVutX+axj3KXyimRhCYC7O1bBalgIGUdgfJoQQWM2c5ybGQmP5ApCEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gFps6zft; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlUERNrmk0gEvrEI55jSfXMFZebcAzae+EXoQFoPrgppkBFE2QxPh2zBB0qwhyTcXJS1RhiRKVSAf7hFG/Ck+8QHiEWc8s5s4ndyMCJQUanVnVxiS4MyU5VFLOHkcYOUtaLfpM7+hverubFBxYf2Sn8Rgn6HcdIZHPLbl8QOWm7/Tq5PH4amwnQ19vIMD16TDWIM0GB5shzlAiLoh82MUcP5NVGqeD19og6AG/wuOr4GYdyuG418MfxZ3KGScGo+8dQAda2X5dTqhO/fm+SrPph+nNEzaCq4P+EtZEcR6bMfIJB15hFElGRsGIoJ/nzZeUURSJbkHofTkIW+HGoZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx7cfIY91yRgBEbFCGIZmvw9PkoBaqhWHo2tN58OGfQ=;
 b=ZKmNk2UbWD61CKw04Z6D7PQP9OajYYDMKjjeHviIdIcIgYvvtvS3KtyYgUYYbGK9wduP9cp5W816Ihj8kP4DJpr1Gedq85FPtQojpCVm7UxPIR14juYHuYFDwwfDkrPpHEhrv/00/lthJPJUBo8OtLoz8UhausCDqI4KLQqYuNak/4OKSRguTyo5eJCxuZ4wKbdUUgOd/m63GD5jyim3QiKFTpOZZOqWz+rQDcEZQgqMjDnfyQK1P/TI+B2f7YZivaDSJwj9sDuUrlIyeUOR9JMprqGax3MdDYmFuAzmDXtRIerOuf8mk2wke8xWiaZjZUVf9x79kzizqJFs8HuVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx7cfIY91yRgBEbFCGIZmvw9PkoBaqhWHo2tN58OGfQ=;
 b=gFps6zftTgIoMkk+OfOhHOEhK5ypfyS/utrqIWLD55qnZ5Bed8pfRINLvExNRcsS9lH081/HWcsPeXOTWGQ1TBnhCu6w3RGC8g4SDRJSzdOAVrr+4ZQmJcE3iveTEoOYsw1XSbBqOSNKuIBqLNtCms8WdZh9fofYr5IUYJsvsGw=
Received: from MN2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:236::11)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 08:04:44 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::4c) by MN2PR05CA0042.outlook.office365.com
 (2603:10b6:208:236::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 08:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 08:04:44 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 03:04:39 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] cpufreq: amd-pstate: add debug message while
 CPPC is supported and disabled by SBIOS
In-Reply-To: <adf1b81c44806e73a391aa6bb49a9fddca95550c.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <adf1b81c44806e73a391aa6bb49a9fddca95550c.1718095377.git.perry.yuan@amd.com>
Date: Wed, 12 Jun 2024 13:34:31 +0530
Message-ID: <87o786ziwg.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 88971fce-1fa0-42e1-ae96-08dc8ab6521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|376006|1800799016|82310400018|36860700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tr0CcH7jVTR3+346B6AtQOdgZEZoi3SFJ9RFQUijRVqpJhXrB3ntUWRvIGIE?=
 =?us-ascii?Q?sF3DzPs2S87Hd1dlVSl32XDclTFBOGhHRY/yfYowJdUNHCpTDXgakNFgkzex?=
 =?us-ascii?Q?c4K64K1aHCM+MhOssua75HeRbae+He7/wMqeb7LvAkKWZiFwGGUp/RAVUEcj?=
 =?us-ascii?Q?gKx0b2xYrtCOhST+v4mQixE9kaEbVqEY9nBoi1m58lGDJ/6MxRxigrYtHkds?=
 =?us-ascii?Q?qyGx+ObsRuaA+exzg8Dr14WlBT4HTzfynmOxN8AokctOFRDjVAjurNzDA5Vv?=
 =?us-ascii?Q?nbSadY6iboatpGY6VVrPGAGStpSfPDwAi6b8nWr4HNYEFgvsXg8idVFqKDW9?=
 =?us-ascii?Q?L3MYjKReaPSOJT6yW3lsWEl2lLHPDdHhyrvVmx6J5Hd/ar6FITzMP6r3rcWd?=
 =?us-ascii?Q?fbQi9/SHzDqG6vrKVOhqhB6ywjxlv0UdH3MMuTGCgEm0O45+2CaiZiZ3S8wd?=
 =?us-ascii?Q?z9ymkF77vn0Sy2tNT2P/WiWS+/GbUQD94RlMvhZZM8gcGNacEKW4SgPOK5Pa?=
 =?us-ascii?Q?IexsCeD32r3KGS4EzH335Po61Mir7wSO6uNLENlWlWoyRKODOrV71OWP9Mbn?=
 =?us-ascii?Q?Uka3uzkdoZlUlIFYVnctg+wZtRB21+/Tft+FFc3PYCY/txZn7HvM90SeoT/O?=
 =?us-ascii?Q?VYq3NHAGsyruBvLU/bY85iu6DH0MMfBaaQ8glczkZiERW3Qh/AQ2uhgEbknD?=
 =?us-ascii?Q?9HA0/8VJTr0wpEnHQSdD7xzsPcnFPVvHs12Y2l3L2t9uxuhIdSrcUSYSknNa?=
 =?us-ascii?Q?7k5wNmAuZb2VOG85ODIWtmwXskrPW8hk+Iu1iF8s+PZQOiAuWHsSijUIsLj2?=
 =?us-ascii?Q?EIcz2ULyTGUjA2IODoTwijiB0FCOUdxwZDs5XW0fN732MweMl0T4Fl0LeN7b?=
 =?us-ascii?Q?z7+E+QiV4Q2tZd6yHi6SOFOY/bLJ5uazMoo8JeYB6q392MhCbMWkt6y7h66m?=
 =?us-ascii?Q?GhinECpQhGF7lvLO+O9RKKIqhMlWE16r5mo2TfZ8Nt8CwG7SAbXbhsltD1F0?=
 =?us-ascii?Q?0/LGcj/ITSyiAnsDycQe5pZtLYQzwjkCHB2PCstBIVxcZ8vYh+i93R/tCYKd?=
 =?us-ascii?Q?JDHHiBMW8pJK1Tlio5jwi9WQjcv9NY2qUa4vvhz4oV4R7LCghWCT7MW0Ei3K?=
 =?us-ascii?Q?gtiO1hTnqsMW2HgVlq8CUEvOxnuGG/sH3kiVzr5BVV/mpyl4XA4B68AH7bGI?=
 =?us-ascii?Q?1133OghTW0jzgI8iJmheCCcmt8MEydWL4bEajWbIjLh9OPGr60iBOdM4agMB?=
 =?us-ascii?Q?nI68L85GHIqIlKQvGxS6lEpTWREfsvJZcgtj5gsJkeAooQU8ZcYpuAfEY2y7?=
 =?us-ascii?Q?CCIkhHUMUrETODmmPyJG+X3/OIOwCnFggVm7BGUVMdAs5WFno+7XKmpHzpi7?=
 =?us-ascii?Q?HyUmtzs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(376006)(1800799016)(82310400018)(36860700005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:04:44.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88971fce-1fa0-42e1-ae96-08dc8ab6521b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

Perry Yuan <perry.yuan@amd.com> writes:

> If CPPC feature is supported by the CPU however the CPUID flag bit is not
> set by SBIOS, the `amd_pstate` will be failed to load while system
> booting.
> So adding one more debug message to inform user to check the SBIOS setting,
> The change also can help maintainers to debug why amd_pstate driver failed
> to be loaded at system booting if the processor support CPPC.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218686
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham

