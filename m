Return-Path: <linux-pm+bounces-9725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B1911A6E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14EFB2102F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D412C46F;
	Fri, 21 Jun 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GmVhVjoT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094CFBF3;
	Fri, 21 Jun 2024 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948219; cv=fail; b=FgRCiWLF+ebTOso4sWljZT9WgZk8gKtep9WYfpTlV1eVRWbJ1ngB33WF7eNqlhwCBZDXHUmIZWrhv/hupyEViDwxq6Tdt8BME68L4hC8o52skcOoE9bCeW6Of60incrSuBD2VFHeQ0b62si7CGrXCsQlp8JLGPMrF8oXSymxqaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948219; c=relaxed/simple;
	bh=SJWnIimdSl+2Kk0GfA+lo7fCW1MZrxD0L1sNt4VXXcY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EM4G/jJ0kCY/m7Sn+wqh9U83V0vWsbYad+zOnfZBW1hyz3iIm2d5CFEYKRh+XjIm0BHJ0PTQ+HdJqMzeSpjA37hDytwAA1DddXOXNNScsz79n/INokIs53usxWYJNKOE8WoH5edDSnNxe3x8Oe2sAga7i5gvkspONEJGN3v5i7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GmVhVjoT; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgnPfcPsBJ9E1Ml+N6APownoRUGJxQVy8SHsVySJOPTKRpGvqpI8tkaM4S3wJfDKtkHfpQ+weQhox8P+239s8T8HPpMemTZIifZwksFJCJ5khrDs70eH60N1eKxKQiDVJ4viC016mt9LtutE3YKzDiA88IUYvtEFj5hSdTdKHgEi8MghMh+y39EYRCQ+FXQi1IPbw1OHwBE9lTgQ6dQWvqxodwKuYcJ/vUmn4EMxySmgOy9PC5DobO+m2uRq+vV+IxYVW67XpiT3NRNYCCUsQB/65jJG8VmgocE2Cl6ninwR36qPvALCZ+qHfMaGxIktX9R8Yn+mjS3Hana5eRfjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAClJaPMeBO5PlucHiBWDRUJ8DKDuFHk3nI4kyaBb5M=;
 b=UiLPP0kToCBvGq6A/S4W5NKB5AkclyNfRmNG5wl2VAUA825EvinNtph1b+fvhysZ50RWCpUDbNX9ESdIb31tZP9jnI6R3fHf+l17VzlePfJcEnDa7Nyj7sDgH58qjHCyMCaghC0XCjDrdq2Y/ifA68+OyYmJDkgFYixmFZkd2hFMehid9yU+ORpE0N6Rcz8d1T903PuX2An3Vffwfqk6mH5KuB087qVLGCpzBWXY3IG+duXzdhATYAsUdc04kBw+5VCi0VBi5klH9eEdk8eA0Dd5y+6D55E/kSj3E1HhE7ADrI+Rd7DpRvJsx1VHpVLfS2j00Fk72a0PDm8BruC3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAClJaPMeBO5PlucHiBWDRUJ8DKDuFHk3nI4kyaBb5M=;
 b=GmVhVjoTNdeTuHMf7J513m3Z32c2c+e2vALVKNzLz9XooT8aCqbqgfAkg9F9sQA21t7/sid95Pif5pKC5I2FSesuE89h+8vxceFau9An2XZA9T02mWHQifx70TfNF0qkwRTQAJbpu/Qqex2T48553redkAhayooRGdllAr6gvPg=
Received: from CH2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:610:5b::25)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Fri, 21 Jun
 2024 05:36:52 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::e9) by CH2PR07CA0051.outlook.office365.com
 (2603:10b6:610:5b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 05:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 05:36:52 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 00:36:48 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
In-Reply-To: <4b4c4a5f-7ab2-4510-9dce-1c1407cca4f8@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <a6d890f77889555c090db754c9a7b81e91053116.1718787627.git.perry.yuan@amd.com>
 <4b4c4a5f-7ab2-4510-9dce-1c1407cca4f8@amd.com>
Date: Fri, 21 Jun 2024 11:06:46 +0530
Message-ID: <87plsavoup.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d658a2-cd71-4cf6-6d54-08dc91b42775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NQeG/o/uxEwHoUeBmwWQLaMz0WrbWsvHhwjTqC2O+ryTf/oCAJoiyrXde4Cr?=
 =?us-ascii?Q?OCV9bRZFIMGmVP4SLgc0mIO2VQFP5S3k/oldawpqgba2u73D/FR+SDYZuEBP?=
 =?us-ascii?Q?iVXRrQTZ3B2UGg8Lq33J4n9PUGA9IEzKMTxehAHou2R1H5Um41H7tbzUUk8f?=
 =?us-ascii?Q?bfWMZzLe7+1I8pxw/+1sgIJlQWmlO00oiGsN0FrQFMt/KNVxlPndc9PiGgnR?=
 =?us-ascii?Q?oI9fT4iWy8w0p6UyvCrWn4/Ab8aWCj9bAn1RG64I17WDLLuN7wG+g3MyXVrk?=
 =?us-ascii?Q?OKoRkOcUM658iDakN0RI4Pl8bf2v6cARpPXgzq+jLwKznuHpCoseXG+u0IEv?=
 =?us-ascii?Q?jk13IcOEWHi7H0iOeT+zArVnqnbtLN41WMq+vklGeQO+9H/g07fRJMejvMnQ?=
 =?us-ascii?Q?CX7Cvps89gumAGzt3oMBR/2jxb0haZfZoDamASgs5DvNGRT3+4y08wbsMCdk?=
 =?us-ascii?Q?EkY7uOLqD8bLmigAjA59MllrFr1oWaLVewyyvQoum1NVXegEXJNu+B4HfUid?=
 =?us-ascii?Q?dH/ZAcmbdCIWXMqPmvNutXcESlmriQRdRt1RFmU1oy9jHnb2VhQwui64xbpG?=
 =?us-ascii?Q?748O0djtJDhSESbfyprM8XpVH3reK8byLMh5dETT+A5/6Dp1vn5xWa2jSLw4?=
 =?us-ascii?Q?LBIlBSgVG1N+rhmWGc82TMc8o85N0cDCs/FaJ8NPH1Yitj+a1MKqj95qCrvP?=
 =?us-ascii?Q?5OChh/nt12TJine1SOSnomL0eyCRppyLXOaKh2/I0dWFvIktHT2p45u7L1dt?=
 =?us-ascii?Q?Pkt2p+h617OuhZnK6gTzYghTZ8/qzU+sCAuG0vj25JT5rCnTP7SUbM/F687C?=
 =?us-ascii?Q?d/6Td7zKnSpCh8orXy5nP2I0cttN/t3X3fJ1dmmo4uRkEQE33quBCB7nPod0?=
 =?us-ascii?Q?VcAYgkIZFZrCmkwk8Jb07kW++JIEunucgC4SU2o2z3kgDkq8qhMVDwzeHOP+?=
 =?us-ascii?Q?MQjTlBlQBHKhbsoUlpJ76aIn0BtjB+avwtxw5dKVP+YfEDw8Q9VYKoFgnwCE?=
 =?us-ascii?Q?idpj35LcwxqfMqAA0+5CkiHqWlmEc7Yjx6GfhB/NCzP1Xprl2cCACFZspJJy?=
 =?us-ascii?Q?aIjrkpsTvnAJZQpJ6nRsYQrvu+9Q6wkUtt6bZ0/kvHXrxsBYFNM7SPvXlGeS?=
 =?us-ascii?Q?qTsiLki9nrxtMnN61wVSjf0IoO9KExlV6VE0HDEtjOo7x5oJ4Pd3/qZ8TPpf?=
 =?us-ascii?Q?fFbq22try8/dFGxJe4MHoXHa3oFMn91q0z2OAORoEKUi30LgEBDRjRhPqubf?=
 =?us-ascii?Q?bKF8pAaTiJNAcq0nmXD1aUG0ADxxlMNpDmb81f/OqMF6ElMKpiCzkuQRrCA3?=
 =?us-ascii?Q?B0DYoI0jFP1kVLgQA3OeNjVMMlPFqWCGJr/cZF5MHdF6r2U5L4GIiJ9ZJ676?=
 =?us-ascii?Q?vGRBdujdprFEixIOUSQF4Wikx7VHmx8JBjuHSq53n03VJkkczA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:36:52.0978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d658a2-cd71-4cf6-6d54-08dc91b42775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 6/19/2024 04:16, Perry Yuan wrote:
>> From: Perry Yuan <Perry.Yuan@amd.com>
>> 
>> With this new sysfs entry `cpb_boost`created, user can change CPU boost
>> state dynamically under `active`, `guided` and `passive` modes.
>> And the highest perf and frequency will also be updated as the boost
>> state changing.
>
> s/changing/changes/
>
>> 
>> 0): check current boost state
>> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
>> 
>> 1): disable CPU boost
>> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>> 
>> 2): enable CPU boost
>> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

From the point of view of the functionality this new interface is no
different from

/sys/devices/system/cpu/cpufreq/boost, which is currently suppported for
the passive mode and the guided mode.

Is there anything that prevents us from enabling this interface for the
active mode as well? 

It is easier if we use the common interface because tools such as
cpupower will then not need to fiddle with several different sysfs files
to enable/disable boost.

--
Thanks and Regards
gautham.

