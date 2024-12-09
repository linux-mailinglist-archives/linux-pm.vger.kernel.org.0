Return-Path: <linux-pm+bounces-18846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CB9E9E58
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45964282471
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3815666A;
	Mon,  9 Dec 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmsymqp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6E13B59A;
	Mon,  9 Dec 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770396; cv=fail; b=cr1ZPEqfJMCz5N+uFkzo/kg3u3oC4oQKq3drEK9X3gFyGsw8KP6HUXh+h+hY0vz4ile5HsZgPPcDTjPlmyzpYNxTAI5JPF5Bymy7jSSgzJwjL7M3NXiju2D6TWi+YBhju6AJMB5HyxgwgbFLu/4+vGWDH7xa40yjuZMxYI6mE7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770396; c=relaxed/simple;
	bh=eKThXE4pTAWAbtAJhZPRdmGMtwp/UB7bddMpJz2A0Dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=amQQZnfxntiBxz7CQFPmy2T0dTuD0PhAqFRpWioiAVr8C/XwrY4535XWMlL0lDkyp9p4awVOQL2+S1VEk1vvibrjdPILlDcqRXsW5bYe2JXvD809V2Nwy8pHq7Q0694aUGCW0OyKcyC/QLbZN6BhyOvTfH5Pdh0kK/iL6c4F+EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmsymqp8; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwP2oa+HM7afeojPH4zpN09qE8c0S+hyaZpnf16tXQqy4EdedmLlEHIyR9u12xfHVg642cZBEGEikTylhGbJHFa1BSvpLykrC7wTLOCzokZBuOG+/4eL+jaZhL6wTN7VFMBmy4wftjxFhHSkqBi3M1/uKLBzxUw8BRp+Y6TPnrV6dzCG8le4guMd1pE4jpxjDMiSrqTewOzF3epZjwPkTb7lgZsodDarJnII9aJGngyWmO6WWEnXJi31bs8F04J/2bPTTuLpst1DAMUZkweyIoDBNUgTn6y2wdUo2yYKLk0yObaxuYf+qUzhwL/p11HEgz/TkC3tIVEu6q5FyyKEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=114cxWIsjb0XMnLWuijIaUx3jDhoz+x8D9BAAoCvciA=;
 b=Dek7EiepCk+SoN8o8TT+C6LdnKgjJye7TghHvUuRs8J3E+iLQ+OgpvXswHcR2tvuhVqKXxP81wSi5ZA0wh+RF5YpjterV7yAJolnbTJNSXi23r4r3s9gtmAAxofV911rLsPodO7cdgmnapKfvejr3iQUaegjfkcIlf8yL7CdXLNP2Zi63rA49hXHVsqBiM2Std7+s3TFXFCCyoC6yE9/z2LV/eKe+dPh57HF0i4W6wXXKdhPwWhkojFmQTP0XVSTNHF27yAgiS03fyGuSo4QpILfRPni6iUEgIclkcudh67gnO61ztNeTSsrYDileC9LZzAQRmw8CAnip5tjO8fEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=114cxWIsjb0XMnLWuijIaUx3jDhoz+x8D9BAAoCvciA=;
 b=nmsymqp8Ncut42bWzauSsv3lPsS+764IGqSoI6H5EMMR3ATSyAmzXVRS0QQqwTN9+pjOa39UNyyXfpelGLkIJwlFit0r2iMl5a+lq730J3dGLzmJVT+x5n2daJYpVyca0Sa+hNvUxAdnoku8MZHiPB7zskwmruRznF9y4ZTnQbw=
Received: from CH2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:610:4d::15)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:53:10 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::63) by CH2PR19CA0005.outlook.office365.com
 (2603:10b6:610:4d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Mon,
 9 Dec 2024 18:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:09 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 00/15] amd-pstate fixes and improvements for 6.14
Date: Mon, 9 Dec 2024 12:52:33 -0600
Message-ID: <20241209185248.16301-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: b2476baf-e897-41ab-0354-08dd1882b9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFuh0boeN68lL6GMis+NAdHOgFZzkG9rBsJ9A1YJQZwYFCXVxZSj/keS2Spv?=
 =?us-ascii?Q?hfYKKTNRXv8estB0B3IVty74XHHhBgM8Vs7vACMwUzWq56rlL/9awLAw35Zb?=
 =?us-ascii?Q?BDuHavkP5Vyb1MBxlu1h5I8Fm8jzbVf8BSYJmtIAoSLQVmyhcdOtgC/A7V0f?=
 =?us-ascii?Q?6YsaG5sGw2T6gzZaARl6YfBlNw4QZTXIYxGZ41Uf9/qxyUPxTFr9SzusW/Su?=
 =?us-ascii?Q?bKRjcyWF/u7hOxeL92DnEPgIMT+ZZ5dVPaaoXeBBlCZTYwalzSUrCSxPb1O6?=
 =?us-ascii?Q?n7v5aw6i30tghLUGo0stVoGWHdU6FRSpgImgwKIyHNl9hnBPlsYWzwJhgHOd?=
 =?us-ascii?Q?R9tSUXgCn3YIeEze8dZnkJDsWbIhq/wot00q+bLYREIvdX3j0xGBd1H3HQyu?=
 =?us-ascii?Q?L5vEBibIB2VfSxh+FhwV4j6NoLcw+yOyH6S/0sKf5ECMh4yp/bIYYCn/+PLY?=
 =?us-ascii?Q?pky88XtMW1JNbfNaCODhtzcerptlsn9UVbw3/+aDUjowiF1Qit3aSSCLB8GY?=
 =?us-ascii?Q?8bw1+zeTT7KbIoHOoP4iWwZSoGsVTnMJrGph4wnYfWlx94WcFxumWOvpeAWU?=
 =?us-ascii?Q?EArNv1z+fo2dAq863xGv09X+CHma3opp5RxoMY4Vg75BIdKR5igX3cwpdGnM?=
 =?us-ascii?Q?D6vzi3iDtWwwv3SDK9bJmZvoUxIq8hM48M0hEn7hWJQLq2kbCKZRDSEpLizc?=
 =?us-ascii?Q?FdnhB06/bctLSREtf1jLhbXz7/K5+PKo+QHCYrc9+fslJ8UYdDhDbVHHM7Ow?=
 =?us-ascii?Q?8wsRF5ovQZBaukGUY6TGEZsWOpU7VfN2DrZrc+5O5XVCCtHHOHlErTZjTbTf?=
 =?us-ascii?Q?UfF4trbDwGdb5N/AtQ77vdejTmTAq8xrTK2gP9RJJoMEyycGPfOD29da3Bk9?=
 =?us-ascii?Q?WuWcmDCEJowBG/QnESWs7ceV7kWF8aZluchbtXuP29SbkI6k+8HLcEuUl+qr?=
 =?us-ascii?Q?aG6aeTpmphnPxJ9kC8gXeK0So2WQhr1Df1ZPgD71ln4LGwKHwPDa2kapiXrU?=
 =?us-ascii?Q?oMiUV/A5kuzqHm5ArLsR4IiLNpahtQ3o2oEf7X277IyAPWNHBbMBzw6LhUhr?=
 =?us-ascii?Q?7kWUA06mQJzV7Y0J6DyCS6S/EXRZb1RKZYF3HXHKyr2Jjg5vSvBkq8NbwTOP?=
 =?us-ascii?Q?k+6SvCTDr5Kioje7iReuiDNS1mYdrut4WJcdnOE5zg2oTmhXdYBNF+Kh8sv6?=
 =?us-ascii?Q?t9p0F+ZOjw0WRrKvNnruLV3mkdbyPpLIW4NK03/fYc0JCwvJN2OKC90getRz?=
 =?us-ascii?Q?MPVqYkCYLS8JmqvV4A5Gkqb5h1x21Zn6NR+xRalfLttbEt8LzIhMfNEu2bSo?=
 =?us-ascii?Q?sg++OfJIfhNMPh33WFIsw10ea0dzNjG36TpaH9jGoPnyZQeTHQaUqb4HyLfl?=
 =?us-ascii?Q?BnsAgGbum7WoxrH+tIcRsfXQUVRoxgf/9YV65jvKhW8X19o3gW+Gg5vTuDFi?=
 =?us-ascii?Q?+QNQcjmN6iyK0NEvl1EQnUUrE4jsPpUE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:10.0525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2476baf-e897-41ab-0354-08dd1882b9fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

This series started as work on the behavior around boost numerator that
was changed in the last few kernels to make it more expected.

As part of the process, of these improvements I found various other
optimizations that made a lot of sense in the context of the code.

While I was working on the issues I found it was really helpful to have
ftrace for EPP, so it introduces that as well.

Lastly a bug was reported requesting that amd-pstate default policy be
changed for client systems that don't use other software after bootup
so it includes that change too.

v3:
---
 * Pick up tags
 * Squash two patches together
 * Remove extra write to cached value
 * Add comment explaining why updating two cached variables

Mario Limonciello (15):
  cpufreq/amd-pstate: Store the boost numerator as highest perf again
  cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies
  cpufreq/amd-pstate: Add trace event for EPP perf updates
  cpufreq/amd-pstate: convert mutex use to guard()
  cpufreq/amd-pstate: Drop cached epp_policy variable
  cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
  cpufreq/amd-pstate: Only update the cached value in msr_set_epp() on
    success
  cpufreq/amd-pstate: store all values in cpudata struct in khz
  cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
  cpufreq/amd-pstate: Move limit updating code
  cpufreq/amd-pstate: Cache EPP value and use that everywhere
  cpufreq/amd-pstate: Always write EPP value when updating perf
  cpufreq/amd-pstate: Drop ret variable from
    amd_pstate_set_energy_pref_index()
  cpufreq/amd-pstate: Set different default EPP policy for Epyc and
    Ryzen
  cpufreq/amd-pstate: Drop boost_state variable

 Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
 drivers/cpufreq/amd-pstate-trace.h          |  52 ++-
 drivers/cpufreq/amd-pstate-ut.c             |  12 +-
 drivers/cpufreq/amd-pstate.c                | 411 ++++++++++----------
 drivers/cpufreq/amd-pstate.h                |   3 -
 5 files changed, 250 insertions(+), 232 deletions(-)

--
2.43.0


