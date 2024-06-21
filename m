Return-Path: <linux-pm+bounces-9778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47318912BC6
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88FB1F2491A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767021684B8;
	Fri, 21 Jun 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOMi0GTn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D341667FA;
	Fri, 21 Jun 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988690; cv=fail; b=r+qXgnYLfm84Z+8/UfTgh+oPBl4fM/6m4gUHm+C5QX70c5rDLOGK8sVNfyZWOWhPuiQqETOhcuWYmid0zRK6uYQOYvsur7RebGF3TJCOLUXHh4eKcd0TiQ9zVIbjKXTRv27jvES58S4hiWKWFcs8x0/fMJMjygjuJIXfrJAHDSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988690; c=relaxed/simple;
	bh=Cd4o31nRJDqpkwQ9lV6l/FXng5Yhuw8GyKFXX0Sjacg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=imzt1G2Dcjcr2vGX9wtojXnGVQnaA75mFKm/UnNybLTnsCHmTUX/YvWDhT7cg4/phd+DT/nCSuya0eU/0jiefoFI8/qMCVfH0L1ge2hCoostReByNSG5UslszJ6xK3CLhSEzFiPmclMD/FBkrZNFu5d/pFuz8G/R71W4pSlcJDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOMi0GTn; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKfdVqSrGB+okQs56QHIGLk0zRhAtrq+SHZM+ZwwWdOuZLYcIggwf/YNL+tSDmDe7FjzlZsk8eJ4cHiyBO7dw+RrEQZDlFCKRZH+qBHFz3kh8Npvdq63OQtRnQkTAQ79ruJrQoFSXznOhLRm/0FHt1tghQTaRUSggVXqh1FbD3Ql3wjgg0P2Vi6xwnOLRPlASJxapD3IkjcfMgRsM5qiQZvGvq3So1UM87ZLQUTq+3H9bbevIhWq11yjVle/zzrNaykeIeTkN2YHKb4WqBbitkUrQTYY3wHa4cwLe9smjJCMuxbvUVtb6nanKWNA32PtsRiZIF3hqmL2QKalajqwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u143B2giXDXRTxuY8JttkpZwENVtVHwMqEvMak6nveE=;
 b=Af7gsLYj2NgMDEaLxHHtJoO9IGl89ECYN7CWLLu+n7ybfUmOj3kQ0lTjgDGcAUxuI+HquqzsehC/8anOKygrOnc8MkdYNL108hDTHfD1LXrp0q3NojegjjMdQHnVI5+toNx8PJFiz832KXyweVAaZ6BeTxMrYYGVaYSxQbeAyctPt9DRpxRCnjskXEijVG3TWnzm2fNG1EXkn5X08t+F4hexMBsbEaA2Bfaz27Feevx+vSl4htCuxwF4LADKwMj1HZ0z0k4xxVqSwk2OsaSC0H5AytA0dr/0eP5pRcXeSDX/N9ACBq82JHFhIgk7LWDc0ZXJG5QQx3yAr8CQ4i2Yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u143B2giXDXRTxuY8JttkpZwENVtVHwMqEvMak6nveE=;
 b=EOMi0GTn/b7/od0HwEeufUh4i8Tnlg61uE4g3l17nWt/07/avqknQOThY4+tY552ZEG9qFn6QIIyfZvdHKSUP50SJy0feOf440n0V/QCKH2h2ENrqgFWkLfypUAVw7i/UhPvHFMYTNp3bqfteviGCPEMsaBqxgqkQU4PxmYJsJU=
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 16:51:23 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::43) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:19 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:16 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 0/9] AMD Pstate Driver Core Performance Boost
Date: Sat, 22 Jun 2024 00:50:55 +0800
Message-ID: <cover.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 870239ab-21c2-4b8a-2188-08dc92126019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFlyVVAzc3p1OTc5azFtcHVCOHRiZ1B5ODhUQ1lra3pyU3JrTFZhS0pwQ2tM?=
 =?utf-8?B?Z2tHMUVVOC9VRXEwOHFuQ3lDQXgxSGhOeWgvcHhGTU93MjRPRTBiakhHb0oz?=
 =?utf-8?B?UHd3NlVZZTFEUWczOThVcTlpTU9hZngwK3VuZFg0Qno5a1JGS1BTamQwUVJ6?=
 =?utf-8?B?ejNIU2Z5RzErbW5rWDc5b0dLNzNRZnJBWlo2bkhxemF1dG5TOUhVaVpNTmpO?=
 =?utf-8?B?cGF1RkRXdnNZMDVXVUxFbHMvck9RdzYzZUJjby83VjJpM0p3NnVpT3RTNkRs?=
 =?utf-8?B?cFAyOUl0ZW9KQU03VXhqWXJLdTNXWEVYTjZVR2ZsOWg1UXZiamY0SjhxRGRW?=
 =?utf-8?B?V1NMTjdwWTAxN3ZWRlBkSDh3Znh6OHhLTTJQV3N3bDRLb0txd3lKYWlLWkMz?=
 =?utf-8?B?OTdlaXkwamJrQVpyMVZiS016bCthY25CWk5mNElkUDdhZ1IzU1ZZeWcySkls?=
 =?utf-8?B?bHNlRHdGWjZyUHRQQnd3OFNnYTRRSHpNa2RlS0ZIVUc2R3M5RDgwR1pKMGRP?=
 =?utf-8?B?cmlVOWZtUjdIL1JtUG1ER3ZKRlFrRFJaZGZjODl5V0dqSUc1VHpKL3BrWWJz?=
 =?utf-8?B?WGYxL2IyZWYxZkFxUXZCTmJNZ2NrY3JhM1c4Tmg1UTd0UTNqZ2pXU051RWJH?=
 =?utf-8?B?YnM0cDM4bVlZa0tkbTRySzgzRTR5WXlkZSsyMWZtSzYzYS82K3dTcjIxaXAr?=
 =?utf-8?B?SzlzbmFQQmxSUVFTaExUQ3ljSmwwNVdySk84bzBVQktTUWgvODdiRG9SV3RH?=
 =?utf-8?B?dFlzaTZmdVpvS3MzeVZod2I1K05UYXhVV3RHOVQ0NG9jbGVVMjZUUUhBUzhK?=
 =?utf-8?B?Z0ROaUQvY2xCdUJXemVVRE01R09HUjVxajQxQmd5Snk2Smd1TUhCWGsxZGFB?=
 =?utf-8?B?b2I3Z24rUnMybGF1NEM1TDVDTk9FRGtHeitzYjRVK0dmaFlCazJTb2w2cENj?=
 =?utf-8?B?Wk5SQWhZM1IrNzdYbm45b3RYejFxa1ZZdE5velNXUUVuOGVBeGxSWUc1cEMv?=
 =?utf-8?B?Q291L0lqVy84M0FkYmFiM09SQ3M1ZE0vUFRPWk5qM3pIbVNLRFZncllaTHd6?=
 =?utf-8?B?ODRtSGdmUmtudEdadk9Ic3B4ZGN5OURzRmt2RjRPWjZGVEtPSmdHRldaNVRt?=
 =?utf-8?B?VkpTNFJQM0JOUkNnOEU3NTB4MXJ0b09NK3BLMnNsclRWQ1J6SEJqbFc5c0lm?=
 =?utf-8?B?T29QOGlWWUVTRTlsS1VrbWdRKzVGOE9oUG5rb0tZUzZ0WnUrTG9QVlhjeWRs?=
 =?utf-8?B?OHN2Z04rN3BtM0lMZkJKcEZSQ3RrM1EvMEdSemFWeUduTDFaMWo2QTROWVA1?=
 =?utf-8?B?cTNmb3NVdW9zRm44WkJvTzVDZDE4Mk5EYWd3NnllSHhVcDM3YStVQ0dqL20v?=
 =?utf-8?B?ZmllT1ROUTFINkJpQ3JGVjd4Q0phaE1wbkxHWWVaZ29sYTlGc1MvTC8rVUFL?=
 =?utf-8?B?bmorMCtGQXdOc1pzVlFxb1o5NWtKM2UvVUFWaFVIb3hpWkxIbEt1L2V1WDU5?=
 =?utf-8?B?aVhYcjNjcUJ0Q3FoRUViNEowZkxIYXhwM203NnBzbXVLUllCY3lBOHYwZS9a?=
 =?utf-8?B?Z21oQW81Y3dFRUpzVi9GWFR6NkprN01vS3laZjlEcjFmK05qUTVSaVB5NWpG?=
 =?utf-8?B?VG8xRHJnWHVWNlZIUkRvTzBCU1pCL2FCMHp2T0RrSzMzUC96T0x6NUZacU4v?=
 =?utf-8?B?ZEc4cVVveUtXYW9qa2FWRHhQSktJZjB5Q0J0VG1NUDI3YWZ5SVJWSmxNWTM2?=
 =?utf-8?B?ZURmOWFhampqYUJoTG9xV1F4VDI4L1hVbTk4bHlVWm83UWFNbzdyL0syQmIy?=
 =?utf-8?Q?I0nL6KkNwBiw8DSSBp8VL1uleHtyEbbB+dbE8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:19.7687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870239ab-21c2-4b8a-2188-08dc92126019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

Hi all,

This patch series implements the Core Performance Boost (CPB) feature for
the AMD pstate driver, including support for passive, guided, and active modes.

Users can change the global core frequency boost control with a new sysfs entry:

/sys/devices/system/cpu/amd_pstate/cpb_boost

It also supports updating the individual CPU boost state in the sysfs boost file:

/sys/devices/system/cpu/cpuX/cpufreq/boost

By default, the global control will override the individual CPU boost state.

1) disable core boost globally:
$ sudo bash -c "echo "disabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ cat /sys/devices/system/cpu/amd_pstate/cpb_boost
disabled

$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2) enable core boost globally:
$ sudo bash -c "echo "enabled" > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ cat /sys/devices/system/cpu/amd_pstate/cpb_boost
enabled
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

Changes from v12:
 * fix the braces for patch #3(Mario)
 * fix the return value for patch #4(Mario)
 * use enabled and disabled for cpb_boost (Mario)
 * pick RB flags and Ack flags from Mario and Gautham
 * update commit log for patch #7 (Gautham)
 * add more details to doc for the patch #8(Mario)
 * address feedback from Gautham
 * rebaed to Mario kernel branch
 * fix the commit typos for patches #5(Mario)
 * update cover letter for cpb_boost state change.
 * tested on shared memory system for cpb_boost control(no regression found)

Changes from v11:
 * add “goto out_free_policy" for error handling and update error 
   mesasge for init_boost in cpufreq.c (Mario)
 * drop dead code policy check in amd_pstate_cpu_boost_update (Mario)
 * pick RB flags and Ack flags from Mario
 * rebased to Mario bleeding edge kerne branch

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
v11: https://lore.kernel.org/lkml/cover.1718262992.git.perry.yuan@amd.com/
v12: https://lore.kernel.org/lkml/cover.1718787627.git.perry.yuan@amd.com/

Perry Yuan (9):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: simplify boolean parsing with kstrtobool in store function
  cpufreq: introduce init_boost callback to initialize boost state for
    pstate drivers
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: Add set_boost callback for active mode
  cpufreq:amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is
    off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  38 ++++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 215 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |  14 ++
 drivers/cpufreq/cpufreq.c                   |  25 ++-
 include/linux/cpufreq.h                     |   2 +
 8 files changed, 265 insertions(+), 35 deletions(-)

-- 
2.34.1


