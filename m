Return-Path: <linux-pm+bounces-9051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230679064F5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C289628568C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96313B2A5;
	Thu, 13 Jun 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sIcD9Tgx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E813A87C;
	Thu, 13 Jun 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263551; cv=fail; b=TI0Z090+3i7V8DeBUB0cu0u+beugTwlscAOmWpszTWdR5SyMIZBtUh1cH3ZTGXpNpG7LAYvH2PchCW0gV4Lk75hzX+ufeq0k589pjJSNRxADIS7nk0tPM29G8vDVNGhr7TDJmpNkcpEw9ayr/ZWjyeXkuCbmwhTYHBAUdYotkDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263551; c=relaxed/simple;
	bh=sESF924X/JgC2ijtbqJxQuCzR1GlLYtm4lY3ohUeVF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VeGPZODRJuz4rD6vTj0P8UO/SsNsIpRfPl3yvRtAqVdYS7SOM+fC1rR3LcDbVVbI1cOFTkr1fWTr9mRoWUt7HXenJgE3gj5WrTpJdd9rJedFgkVufuWFHLOFKdAZb0pSX5fZDUM3N+5m9SH//QKfphT9PNUbM52PWhfgn8aTXPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sIcD9Tgx; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umv11jzBH1c/+u703tr23dSo0k42jib2xNxKut0hntVorDVEsq7ocj1BLyNywSdg7odOe2B2kYAIFnO9w0dJLG0C+Ar7YvwzKLHqYDLCXjSosyuqCNgX4y74Qdib06WTQnx98PxlRKOlrSGvMDjlvygib4f4ThuHgIcYbcAP2iIQ8yd5o+Rawv/DZbxRtnEHPipBzTndrhNKEBy2jvvp9w8+2yuAmx0zt7mP9EqsZ75I6xHB0HCxvraUIDJz9Vbg1EpgS5hEfxpLkfKGp1zzV2L/XDvv8K0NNL3+UCIM+B3aD+WPip1gjpB+ZQ2kbT1+UISXC7A8akXuq4bBv2VxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQMa8y1Db/3cCCxOJ24WZOC8kSYVIitmUNkj/QLuWFk=;
 b=Q+AxGYn2MRXmGfCXrtJxGgGMZ2mlxl+v8WK/PEqYUjAiXL01Zp2EqdFRtgUO8Gx5tdQFFW18xi7MjfKSa9AtcDDWCN5g1dgCOOCWqu0IRmtoRe5a2lQ1z1+0qsojHAwUA5Lya5wpPKjY99bovaPQb8tGZGCpAGn/NUtCWIhO7Fs9SfisIBkVRraw5l/sNginzy5OgY4voIywT+1VoJ9/VNuf868Tevw4A/ISnCBuupLdgZE4/vrkj95f/EX16b0msX8XpQeeXY0YjMQQK5M6evZEe2ZzUmlLwlFa0yu8yT4rZRYkyULcZQHeHbWPf5Xopudi72IA+aAVOKZtx4weHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQMa8y1Db/3cCCxOJ24WZOC8kSYVIitmUNkj/QLuWFk=;
 b=sIcD9TgxcDZY7BSrpbUQ8QSykBAaEZR4I8x1q+YQ3qfmrv90cAybGcPUZOE7pxBXZwioAQTHI0qwcywKt8twPjGGdxMhOyhvyTHQCx68486AyR0JqHfuYq2MVRtlRnw8S6lLcPwoCUXDkjRpw/o1tIuX3P54YRaqqwb6cVKaKCk=
Received: from MN2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:208:134::42)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 07:25:39 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::68) by MN2PR16CA0029.outlook.office365.com
 (2603:10b6:208:134::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 07:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:25:38 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:35 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/9] AMD Pstate Driver Core Performance Boost
Date: Thu, 13 Jun 2024 15:25:12 +0800
Message-ID: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 710883c0-4b79-43b9-e293-08dc8b7a0694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XoZhAxod7ZfJXu8grVHpm6KsIjCk7OyUv4R+O2BpPkMMhN+SBRFkJbMfNvyG?=
 =?us-ascii?Q?EvlKcFIy9nvef7m+SYc0h3eHdGfsepEtPv+mLC3S8PqKitYfxwFMsbtLibGy?=
 =?us-ascii?Q?7DWYONObdJ6XOGBbZ20slIJ8Heb0Vi6LfqZKE3Wn/RphXaTSXv3K3SK5G9ha?=
 =?us-ascii?Q?u7+ybFWKcWEL6/B1b/lSeh2Gw2lDjw/jZyQEoP81ldgcv5j1zTNaysM8a+KI?=
 =?us-ascii?Q?67LkWEzF3qzG/p0vU6qKK4O8Bced9I7Z+JWOM1tFGaDGe3jtU0IgljT/kcWf?=
 =?us-ascii?Q?rwVW7soS/ySQiSmkebyYabizCJRU3ukNAncHrlK6hiK8d1iuaos3rsJ95oEz?=
 =?us-ascii?Q?NlQX+V5VbZCJIlPKZJp9inD/w6hX3+vef8Ko3PdDoVoYOLxAw5acO7kQF/1I?=
 =?us-ascii?Q?No8KmuBcuZoFgBg5nIcoHcxSqpLDXxYcxUCjgMk2N2VIO6Y1MA1a11Mvkdie?=
 =?us-ascii?Q?FdMhP7sJGeR2XNOHBFCILZj0rCGwNADPaeAVSTG+r1nX3Cko1soWOZOTeyOy?=
 =?us-ascii?Q?JJJ7ixnVxzWikUyt+G/ZSXNyLBSW/jECGFwj5+JrNiE7slYXCgaLrgPz4IcE?=
 =?us-ascii?Q?5tyxO7nrG8iE/7JJ2/n3HLCjwDVuLaoXCR5aLvhI+C0kNbc0ST/muE2jMyu0?=
 =?us-ascii?Q?jVawhd+csIzjv+M0SGWxCosOsrwZ7UFnFdgQsSUxS+wEZTG3x3iwwXeAe8Mo?=
 =?us-ascii?Q?+sZlgNexVYFjhb4ii1WirbIUPHqoD16XvMMWImAJ+cFslvJIN2QlZ4tgl4/k?=
 =?us-ascii?Q?mPjmqNYRiRa0FdSBMW1nEhCMEFlY2YE24nYs6QcJLNjDp9nr8acxUpH1Y4eM?=
 =?us-ascii?Q?yv0Vl7ZSxSiXXHXT3yUm0xlh5ifU5U6AJBX1YKaJWzyniUpRUnpVyhsE1JHs?=
 =?us-ascii?Q?TCmgT5vXp/G4BRdqxvUal9ynUMRqCDXiqisMAy7FTY/lj2UBFD6TH48LATPb?=
 =?us-ascii?Q?tJifSmrsvUjtAWPZOEHtDh0tOEDhb+tGuVIJFfGwhGFTIsFzNXr7gR/TVsiw?=
 =?us-ascii?Q?7hoeOwyvO1Jzo/nURSCK1I1AlqibqCL/1nA2wVL/hep4MHTh2wFB2tUfuIa9?=
 =?us-ascii?Q?CG/9FBJE9IHo1dYI2yFvVMZhGyb9IsBO8k0S/55N7fDvze/Y4aExdKWYtOI4?=
 =?us-ascii?Q?BL4lub+c+7osIw+Jm92OkMVU7VsKz+tej1nuOBE/HnGFKqmqqqCBEvRjd1dJ?=
 =?us-ascii?Q?s3Tp1jVtIKkPzhySKlyiKEEQirPE/z6V6UO3aAQObjQEzEvdmSxFD1UTpQeR?=
 =?us-ascii?Q?U9fwIGpGIqLEhouOAZ+S47F+7szjEh1AKxF/UmmugREWS/4hbtj0yhfxS4Qi?=
 =?us-ascii?Q?fiHYt6+xtA/wfSRhW8CbTmNZPA1wwB22bj+b0tzKhj481Ia2TahWtc0CatVN?=
 =?us-ascii?Q?IUU0K+s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:25:38.9803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710883c0-4b79-43b9-e293-08dc8b7a0694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097

Hi all,
The patchset series implement CPB(core performance boost) feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change global core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"

Now it also support to update indivial CPU boost state in sysfs boost file. 
"/sys/devices/system/cpu/cpuX/cpufreq/boost"

And global control will override the indivial CPU boost state by default.

1) globally disable core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2) globally enable core boost:
$ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
   0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
  3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578


============================================================================
The V9 patches add per CPU boost control, user can enable/disable CPUs boost
as the below command tested on a laptop system.
# before
  CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
  1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
  2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
  3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
$ sudo rdmsr 0xc00102b3 -p 0
10a6

$ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
# after
  CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
    0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0000
    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0690
    2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4541
    3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
$ sudo rdmsr 0xc00102b3 -p 0
108a

rebasd to keep syncing to Mario kernel tree: bleeding-edge
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 

Tested result:

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
  3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 3110.0000
  4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2732.3569
  5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 2312.2109
  9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2310.1011
 11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140

sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu11/cpufreq/boost"
sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu10/cpufreq/boost"
sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu9/cpufreq/boost"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1242.7240
  1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2754.5710
  3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2659.8159
  4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2308.9929
  5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
  9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140
 11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140

sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1233.8630
  1    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2714.4851
  3    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2732.3569
  4    0      0    2 2:2:2:0          yes 2801.0000 400.0000 2564.2639
  5    0      0    2 2:2:2:0          yes 2801.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 2801.0000 400.0000 2732.3569
  7    0      0    3 3:3:3:0          yes 2801.0000 400.0000 1110.7140
  8    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1233.8660
  9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.6630
 11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.5050

sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1234.0200
  1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
  3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
  4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2278.8491
  7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2732.3569
  8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
  9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2353.0449
 11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140


Perry.

Changes from v10:
 * rework the boost interface with cpufreq core boost control, align the sysfs file 
  created from cpufreq.c and allow indivial CPU boost control (Mario)
 * fix the pr_warn code format with %zd (Oleksandr Natalenko)
 * replace sscanf with kstrtobool for cpufreq.c (new)
 * drop the boost sysfs file creation from amd pstate patch #6
 * add init_boost for cpufreq.c to unify the boost file creation(Mario)
 * add set_boost callback for EPP driver mode
 * fix syncronization issue for indivial boost control and global CPB control, now the
   two control way will keep syncronization after anyone CPU boost state changed.
 * rebased to Mario kernel tree: bleeding-edge
 * run testing on local system, no regression issue found so far.

Changes from v9:
 * change per CPU boost sysfs file name to `boost` (Mario)
 * rebased to latest linux-pm/bleeding-edge

Changes from v8:
 * pick RB flag for patch 4 (Mario)
 * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
 * merge patch 6 into patch 3 (Mario)
 * add two patch for per CPU boost control patch 6 & 7(Mario)
 * rebased to latest linux-pm/bleeding-edge

Changes from v7:
 * fix the mutext locking issue in the sysfs file update(Ray, Mario)
 * pick ack flag from Ray
 * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
 * rerun the testing to check function works well
 * rebased to linux-pm/bleeding-edge latest

Changes from v6:
 * reword patch 2 commit log (Gautham)
 * update cover letter description(Gautham)
 * rebase to kernel v6.9-rc5

Changes from v4:
 * drop the legacy boost remove patch, let us keep the legacy interface
   in case some applications break.
 * rebase to linux-pm/bleeding-edge branch
 * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
   Enhancements which has some intial work done there.

Changes from v4:
 * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
 * pick RB flag from Gautham R. Shenoy
 * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
 * rebase to latest linux-pm/bleeding-edge branch
 * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
 * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT

Changes from v3:
 * rebased to linux-pm/bleeding-edge v6.8
 * rename global to amd_pstate_global_params(Oleksandr Natalenko)
 * remove comments for boot_supported in amd_pstate.h
 * fix the compiler warning for amd-pstate-ut.ko
 * use for_each_online_cpu in cpb_boost_store which fix the null pointer
   error during testing
 * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)

Changes from v2:
 * move global struct to amd-pstate.h
 * fix the amd-pstate-ut with new cpb control interface

Changes from v1:
 * drop suspend/resume fix patch 6/7 because of the fix should be in
   another fix series instead of CPB feature
 * move the set_boost remove patch to the last(Mario)
 * Fix commit info with "Closes:" (Mario)
 * simplified global.cpb_supported initialization(Mario)
 * Add guide mode support for CPB control
 * Fixed some Doc typos and add guide mode info to Doc as well.

v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/
v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/
v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/
v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.com/
v10: https://lore.kernel.org/lkml/cover.1715152592.git.perry.yuan@amd.com/

Perry Yuan (9):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: simplify boolean parsing with kstrtobool in store function
  cpufreq: introduce init_boost callback to initialize boost state for
    pstate drivers
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: Add set_boost callback for active mode
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  30 +++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 197 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |  14 ++
 drivers/cpufreq/cpufreq.c                   |  23 ++-
 include/linux/cpufreq.h                     |   2 +
 8 files changed, 237 insertions(+), 35 deletions(-)

-- 
2.34.1


