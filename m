Return-Path: <linux-pm+bounces-7552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D88BDC30
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38E42811A0
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35586246;
	Tue,  7 May 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xnyg6ab4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685743D0BD;
	Tue,  7 May 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066154; cv=fail; b=l9kLH9Ap8HAosDNmSj9c48yef1Ov5iyfCcRGbGY+koRPj+fJinBoM3i7UTVKwQqFAA++7K56gZrhRvMu5/+QJJQwT8MjLWJbtvr9LXJ9EJ3nr83fRCbleDn55cik1/n/EsCQteUHbx4IwcZjwYddJqvduK5L107K0UfoWPwEeEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066154; c=relaxed/simple;
	bh=3ZQLT2Z7Oyqy92LgFRa6hafv79IOoBgty/6T5x9Mjk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k12dqu41bEitG0Nr0Lm8Ba7t9wA8yKHd6ICrhxOC4nYZPvEKshklMJLgIq12LWhdM8Ies/iZ12jm8bBVgsJYOLu7i+1Q6x70b64MYL9A+6ePc2bhHxLP0PvjooFNxqfAyUsGwHDWqocnvnRqtZITJrG32nAbOTYF4yC9muAV/nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xnyg6ab4; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKpX2t8V79do9O/4QHqoeI17X8PP3JeHwt4k5EXVwUGwCmQYRnEiNsSWT47SMi8WugBe3U9LutNO16ElzDtuzafAe3McI9a8U8Zn/7nkb/VkvH76Z/XFz2b8Q+048GzIA0YlPb+gyCIXaEvBYKgSwDpXiqWdRWq7hvwGTvIlPO4WIeIGPepSI+SM4mOj+6sc72S+upejHz8gzkuWfwEgu04IkWS0Pu9evsebFQIEhPPB1eVSAJsCNEaf4/902WtyCuQL87/+/y4+hgZZXCY57jJL6FUR19d6WR7ITIuwWDMsQUMy/GJlAW3omK4PBwcj/bR664PfGv4NEaeHKp/liQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFuv1BjKcIVaBxVhSyVF7qLgPUtuSeZBx4xpioTUz7A=;
 b=SXNcL2z5Lf4524ANawHDy9OSRnc/0bgp/bRCbhX2Z0TH8+MC7xb1YaPLNqj9jgtpThu2jv7WcGDfdbGMLEYAU2ZkdPnDcprbC1Y+KI60qWyXyeQOwDRDlGN1cIxIbH/lPmJfh57lF8m0Q8DCftbUYApE+U7qU+MGW8XgApz7FNG9ANL5DBtBl5trCQXFdTBxgpCGO/dXDczl80vOYtfcllxLdJ+A2YHNE/EVBOqWDl6cnIYoH8PIf2e2nqQHfMNYt3XopTWteOwGUtYAQKa6mZ8uw8sk3h3FbAwYwupSUz80fQ8KiSaBiklaia3S2/taQpI4mw/G9NSH/BHBlfAqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFuv1BjKcIVaBxVhSyVF7qLgPUtuSeZBx4xpioTUz7A=;
 b=Xnyg6ab4dVTrT1LKj+39IWLKX7i4u7UicGv3e9Y/cqjfCp4b4P9o3R7YKsCEouvsuviWX+EYRewryj1NUZNomdkNqOhYqmiSRou4Zgyw8Jc6RFHfgobZ/+o+zI5TXznddmLxCPpw7GNW/lQbUjjDzUYWgelENic4OndliJTn/Do=
Received: from DS7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:8:54::7) by
 DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 07:15:49 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::19) by DS7PR06CA0039.outlook.office365.com
 (2603:10b6:8:54::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Tue, 7 May 2024 07:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:15:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:15:45 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] AMD Pstate Driver Fixes and Improvements
Date: Tue, 7 May 2024 15:15:16 +0800
Message-ID: <cover.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2aa99f-3b44-434f-2abe-08dc6e6585c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeudud+L/ug8V3ITEl0QPgUZ0xRXkfIpKCPljca0S/8OCXKOqJJAc8wwChXx?=
 =?us-ascii?Q?faflAYkwM5Fi8r/IzKgjcBsy7Khwhs29Oh63/NBcHIsE8FhT91V60DHSq2hM?=
 =?us-ascii?Q?/zfPQ+qHdwjOkvN1iJIWnqSwBf8bLROh5ajGmuNIhYvlgmneHVHWrctD7oL1?=
 =?us-ascii?Q?paH7SqCv1eaO+ZV5Pge/We8FISoNGC/HW0NXOc7ShpqQMpsiFw1uqQ2GH6AY?=
 =?us-ascii?Q?LOPTUu5QozHP3bhjQMV37+o8PRrZIEaH6RYKi1T5HLYnzRcr7d+HRi2DXTSj?=
 =?us-ascii?Q?qAoul6VE2tOQG1LTgwWUjKvMEhMjPSxSrrJVhFhp/S1nfY2iPzInqLNya6vL?=
 =?us-ascii?Q?VUbkzTJ6wpsEIeXq/Ey7aOQmd+vBPuejoeWkrD083B6koB7IHvQaWVSPPpf9?=
 =?us-ascii?Q?WF28LCKXkVLTiTTtvX+qIok5dB87+YKnLItiKAST2sqWhTMBIpaICQQwguKd?=
 =?us-ascii?Q?6TAcUujCtd7Uxt7xopX3V+vsgC1kTnvB39zu/KKSPa7k+YjfRHu2bf2BJbSn?=
 =?us-ascii?Q?zKcMAieUfpDmIF/lyKavU9Sfwh4r6haAGvV13GYwKEZU61W8WE4JeyQTuCpD?=
 =?us-ascii?Q?b5TuSUFnbskfE38ht3eB9VmtToyfHdgQd0XV01wQjRgto8W5E6jqc0U2OB2V?=
 =?us-ascii?Q?hgq1wWB0ojy6vS6Hlw+rL31j5C/vyP4u5+a/UGNHgJF7Ypb6VVjKbyEK9tsj?=
 =?us-ascii?Q?m/itaU4miOJCSdHjHOR2uflvqGepzXbiFGaBLjHV2zvE5h8tqMw6rAl3Zqbi?=
 =?us-ascii?Q?GZO3MvqmjjwDBE6BdIl8eLcZDUbLV18sfRULhq8V03aYEaBOcVtixX6ARPGh?=
 =?us-ascii?Q?fmzO/m7vSNB+HbA8n6XTAlXWf2SsZndUR1iUdz91TfJL8cJgFUCo4fID0Q7M?=
 =?us-ascii?Q?O627zJbWCk/o8uCvzPjb9tS9uQIarsbmNGpDLVezULUq6euZc3JGPOf94Ayd?=
 =?us-ascii?Q?W+gzSy2CQyAVxXJGc3Q3pccBarb9IazNMg1pvsEYyUZThcOlfxBgNuLhbuBn?=
 =?us-ascii?Q?0GT4vwYnxQWtdOBbIu3BMralncQ92TyGVQEABccGP698uI2l5i6wLI2iBrvb?=
 =?us-ascii?Q?a7OzX+hSOWxZT6mXElVDXLWlX8pdo7Qj12iPQGT6nEqYEs6p/RRN0hVQW+Io?=
 =?us-ascii?Q?KpnBydTNGYAEWBV60p3JdyX0ydZZ1C5PdjkKD/zx39PCV5OfD5SJeuFAt0H8?=
 =?us-ascii?Q?0hqaRf/x7QHHYUKXkJZMTV0sa0S5Dy70ww0uBPKb/1ZFvx1Y5tjlcLtMYzXR?=
 =?us-ascii?Q?N5FADf1C4PNhPJDxWVGW0cT05mzpt905KkxtzyZYyWdfJkwnlZeL2eWExjbu?=
 =?us-ascii?Q?fItXaC6+HI8qo1GOF4Np2mtKKyzDB1jWYJJJP9ZM5CMHqKdPZWvYysjBzh0h?=
 =?us-ascii?Q?4RYjNa9UMMt7WvdnvDW7ouaqVwSV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:15:49.3873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2aa99f-3b44-434f-2abe-08dc6e6585c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

Hello everyone,

This patchset addresses critical issues and enhances performance settings for CPUs
with heterogeneous core types in the AMD pstate driver. 
Specifically, it resolves problems related to calculating the highest performance
and frequency on the latest CPUs with preferred cores. 
Additionally, the patchset includes documentation improvements in amd-pstate.rst,
offering a comprehensive guide covering topics such as recommended reboot requirements
during driver switching, debugging procedures for driver loading failures.

Your feedback and suggestions for improvement are highly appreciated. 
Please review the patches and provide your valuable input.

Thank you.

Best regards,
Perry.

Perry Yuan (11):
  cpufreq: amd-pstate: optimiza the initial frequency values
    verification
  cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
  cpufreq: amd-pstate: add debug message while CPPC is supported and
    disabled by SBIOS
  Documentation: PM: amd-pstate: introducing recommended reboot
    requirement during driver switch
  Documentation: PM: amd-pstate: add debugging section for driver
    loading failure
  Documentation: PM: amd-pstate: add guide mode to the Operation mode
  cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
  x86/cpufeatures: Add feature bits for AMD heterogeneous processor
  cpufreq: amd-pstate: implement heterogeneous core topology for highest
    performance initialization
  cpufreq: amd-pstate: fix the highest frequency issue which limit
    performance
  cpufreq: amd-pstate: automatically load pstate driver by default

 Documentation/admin-guide/pm/amd-pstate.rst |  19 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/processor.h            |   2 +
 arch/x86/kernel/cpu/amd.c                   |  19 ++
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate.c                | 196 ++++++++++++++------
 include/linux/amd-pstate.h                  |   8 +
 7 files changed, 185 insertions(+), 61 deletions(-)

-- 
2.34.1


