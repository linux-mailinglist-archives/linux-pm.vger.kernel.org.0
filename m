Return-Path: <linux-pm+bounces-11818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B70945743
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE541C23663
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 05:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA319478;
	Fri,  2 Aug 2024 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eeH2Zs+m"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F28836;
	Fri,  2 Aug 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575059; cv=fail; b=evjpX006mamOxzBKnKpGSo32/xGnxvcxrNBfz8qM3WaphkT1cVhQUeoIQ+0pfnHuDy2j3HdZwK0EyKkdzXHitgmz/6UQetZvXynDQYFVW+zIu8deNcTZ3a437i7OdtU/zz9srWp9lAWMURoyXZQ9tgPbmMrm6IG0JWlb6cPLkuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575059; c=relaxed/simple;
	bh=7El0q5005LcbyPHmZOCOLAcJ7PVatbY+wAG6/G5l7+I=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dIqyKKBed7HAnWFcgnmcMpgohLK29SJ/UlokM92W7H3rZF4bgD9E/FzNoHpNpurjnOVnj+3yk2OiAeI2Wg3+R+dRM5xI71l3HDjE459+9vut991apukRLqw7sePUVEB8DbVKV+JewS+iWAsN7AVEUARulBA1xkQWcSm8nfTKbd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eeH2Zs+m; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMTgGp9cDarMrsWO43uTA7dDq5iqYn8zXOTB2JzXxpTA7PfEwQSJVugEGfVVOkr+Q/bmUzgz3sSJx0TBQ+OnyZomEewPwGj7JcudF7Hv7dRFyQcFd0HgdtWNN1VhZumH2IBToABntdbpxj38z6qC2g4CCN9c1MaUv3RZGFCla28+YEmiZTsb8thrNGn5rO17JaYhQu72CZt/AfaDi6X89nJKxwdLXvflbaBKhOSXtUJM/K7u2TuxqG3IVZxKA18rF5xNpf0ME6XmTKw/rqKatf9PHXs4gFEIkrQJEuPTsnIxJSVOo5zi0PiioakvKvzHh+t08uAj22HqwLE3Nj6eBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtsKxPqotvHupur6Ww8A/srPFiUAbDB5dcTB032qEWc=;
 b=QDKRIPBCclGydslzhfWJJcoD3B0jiMWkWV31xq3YNXYeKQH/MGk/utnYAGEUn/3u3fRHDiyLmPwE5fAe4UYqYbFTFr4Oud00g65xKAJTI89LszCA+LNfsD4kVNIi55j59LbvcdP162wjq8NxBqh8zQZGCAWtciufBBgrbqRQdHMXbQc289DO0mpkR6iY2u0r3iYBCNT3Ka1bN3dvdKb8+GIhXfbrkcjDsmPNeTSMlIXiA254v6VE5kzS/iQduTaAeiHCGFFfa9MY0sEaed547FuKezXrhapnYiMk/tEhZF2MErixm0PvI4YzYYbqnoaOWXMXOaQt9dZV1OTL3A2oTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtsKxPqotvHupur6Ww8A/srPFiUAbDB5dcTB032qEWc=;
 b=eeH2Zs+mJSnKDW5Ww4pGdj+kYdvOgarUaSge09tNPhFZWqR7xzAsekdo6jXwACDohUogphHz9HJKhKwwvg+dv8VKq1/MgJCUusaeG763NejBM+QGH6G+iMu6vVVZ3z8ffQFXCVxJYYC5sv3NpiLjSei2S6HHLcV3xDqCcwaln3w=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 05:04:13 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::4b) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 05:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 05:04:12 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 00:02:57 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: David Wang <00107082@163.com>
CC: <perry.yuan@amd.com>, <Alexander.Deucher@amd.com>, <Li.Meng@amd.com>,
	<Mario.Limonciello@amd.com>, <Xiaojian.Du@amd.com>, <Xinmei.Huang@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
In-Reply-To: <2f793cc8.a13d.19108df0a58.Coremail.00107082@163.com>
References: <20240730140111.4491-1-00107082@163.com>
 <87zfpxsweb.fsf@BLR-5CG11610CF.amd.com>
 <2f793cc8.a13d.19108df0a58.Coremail.00107082@163.com>
Date: Fri, 2 Aug 2024 10:32:48 +0530
Message-ID: <87v80jbjpj.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: b13d922c-7de3-41f8-4372-08dcb2b08d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3qimoRQ+RQymrU2GthNvciJ745r2qsw91lVrztRD45aY+A6vFO+upG6FUCgQ?=
 =?us-ascii?Q?5g/b0V7XT22oHgGikXGVWXuVSfc6mZPMo/PzdyJoYkDm57kHc8VSw0Brj+gq?=
 =?us-ascii?Q?6QfL0MmEmIewjFhwNf1XwtKgKtNYcr+ak05MmBab02sEjXOuN/+/0IXnkvae?=
 =?us-ascii?Q?qfHBvV1d4mkech2BujnGC3QPHLix+LFHZbPdut9NDkUM+8KE2maOZ0bn5oLg?=
 =?us-ascii?Q?3e72Nb6gKWe74xhOYGxV5Jz3Qof9gg7rF1mvz6tVOOBp89dfFOHKrqPMWRlK?=
 =?us-ascii?Q?We7WN6R8+D56U1ibf7IDiaa4hsFU88tZzLjGD6GYGXD+P7PACbnh6pYBQCRi?=
 =?us-ascii?Q?F9P0hVgVnHcFlDN6DCo9gjYMt5AskbUFHRi4Uz4jVjmUlFqdFgbl0cmXHr+2?=
 =?us-ascii?Q?y9G6PuY3atA58p/xWLruiW9QRk3ZC/gjZ9nPvkOiA2Cn85+NYsy/lVJxgR93?=
 =?us-ascii?Q?E/LKclDt81ijeXKrI8XLlRxuE40CzmIp0lEpavD0GXkkKvGF+xkaK1ApOItz?=
 =?us-ascii?Q?f0zhjeFLeNK+wjMNDwLT1r7baAdN3Ha9ZTpxR4DKer8xpoCgQclHxswFdVrd?=
 =?us-ascii?Q?ztIbeEUgFq37a+DkT1RO7mW36TYYHZaaI7ZjUqTyPpaWw8bo/Uxe27n9/yPV?=
 =?us-ascii?Q?0vLZPR4O4hRK8oMwJo6M/47rw/rFVL/k7LFq3Y1OAsLunzY7CvlAA6XZ65tq?=
 =?us-ascii?Q?wjYm0DjhbDmSgMYDHbH6+LDVDX1N2KKQiX3uNzMyEk5dyY3dRpPck4kggSUp?=
 =?us-ascii?Q?D8fBGb581afFntnMcd1uN/ic1tiWIzxKgj+5Cea6zf9IxGq1ZTYPFM+oroen?=
 =?us-ascii?Q?YnEgFMeuxcnfdZG8SiwggEVros/WjL5s62KtxV7iCjfWO9ya23aAct3ZJrwL?=
 =?us-ascii?Q?orhHnv0qkLp4Bi9crK6GLkr8n2AJmYt/vC2AWg4WathLmpgxdSGC07LKBBSE?=
 =?us-ascii?Q?CoLUf4PnFEQGQdp25Gt31ocmAxSBxKkQ9HEY+4cirQkhtlGFCzRoer0mZdhf?=
 =?us-ascii?Q?zDkmx9bH2W7rddBuaj37LSeSmbkdS5Qp5hYo/ingYHrhIM/ryQZKSMsmN43m?=
 =?us-ascii?Q?zV/mkFvCsenGULCaxYrM5CdDMAt+wS+dQcBeQL9Q9IivosOsTSaGzNhiYjaY?=
 =?us-ascii?Q?rerGklecWbKzyXEAmLqbmOX662/7AYsNXZz//K2+78kwwYMrexmZXsnw+16t?=
 =?us-ascii?Q?LOP5vffg0bsXrgqIR7MS3eHu3XF8ZqFIOGtmV71SitRSbXtmNbi0LJMTWXd1?=
 =?us-ascii?Q?6fMW+PXZJGdvG7uV04V6NJmLrwKiMt9QecMu2f2jsE2fZGTdcHXjq+h6ngsQ?=
 =?us-ascii?Q?bZ0mXUFN2lIfw8OjWUSwcsY//NgiOlxWTo5+aT/KxLOUZbxQJRPh725koV5E?=
 =?us-ascii?Q?CBnvBRHDlcWsTrkK3EmgNISRciwWYACL0paGwVu7wHbe2V0kjlwaj5vEAXTa?=
 =?us-ascii?Q?t7G7jPOFxtwHDsNckMacVjPU5gV2dqiW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 05:04:12.7173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13d922c-7de3-41f8-4372-08dcb2b08d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218


Hello David,

"David Wang" <00107082@163.com> writes:

> Hi,
>
> At 2024-07-31 18:12:12, "Gautham R.Shenoy" <gautham.shenoy@amd.com> wrote:
>>Hello David,
>>
>>David Wang <00107082@163.com> writes:
>>
>>> Hi,
>>>
>>> I notice some kernel warning and errors when I update to 6.11.0-rc1:
>>>
>>>  kernel: [    1.022739] amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>>>  kernel: [    1.022739] Please enable it if your BIOS has the CPPC option.
>>>  kernel: [    1.098054] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.110058] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.122057] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.134062] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.134641] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.135128] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.135693] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.136371] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.136390] amd_pstate: failed to register with return -19
>>>  kernel: [    1.138410] ledtrig-cpu: registered to indicate activity on CPUs
>>>
>>>
>>> Those warning message was introduced by commit:
>>>  bff7d13c190ad98cf4f877189b022c75df4cb383 ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS)
>>> , which make sense.
>>
>>
>>If CPPC is disabed in the BIOS, then the _CPC objects shouldn't have
>>been created. And the error message that you should have seen is
>>"the _CPC object is not present in SBIOS or ACPI disabled".
>>
>>
>>Could you please share the family and model number of the platform where
>>you are observing this ?
>
> My `cat /proc/cpuinfo` shows something as following:
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 23
> model		: 113


This is Family 0x17 (Zen2), Model 0x71. AFAIK, this processor supports
CPPC but does not have the support for the CPPC MSRs. Hence the CPPC
communication occurs via shared-memory.

Hence the warning introduced by the commit bff7d13c190a ("cpufreq:
amd-pstate: add debug message while CPPC is supported and disabled by
SBIOS") is not applicable on your platform. I will send a patch to
rectify this which avoids the warning for Zen2 Models 0x70-0x7F.

Regarding the following errors that you are observing 

>>>  kernel: [    1.098054] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.110058] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.122057] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.134062] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.134641] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.135128] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.135693] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.136371] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>>>  kernel: [    1.136390] amd_pstate: failed to register with return -19


it appears that the CPPC version on your platform is v2 which does not
advertise the nominal_freq and the lowest_freq. In the absence of these,
it is not possible for the amd-pstate driver to infer the
min/max_freq. Which is why the driver bails at this later stage.

The way around it is to add a quirk for your BIOS as done in this commit
from Perry:
eb8b6c368202 ("cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing")


--
Thanks and Regards
gautham.

