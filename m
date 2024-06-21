Return-Path: <linux-pm+bounces-9728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE1911A96
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D41F25BD8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B183CD7;
	Fri, 21 Jun 2024 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r3CqK0Rs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C300A34;
	Fri, 21 Jun 2024 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948796; cv=fail; b=Y/EeNCA6OgcxoKl9tFEJeGaFJWnIhQnBzjaCMJPGRE3lKTEhgAHDqA1Qdc596OnyOLtxDwwYtGwDqfehbPT7IBb19s55UhNzRfb4ZELiPKdpx8zvSJXKpskMzFWEA3wGaaYtFbzYiyxb72J81We4xkxpnNVgJfIQn7Ze8r/zoQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948796; c=relaxed/simple;
	bh=jSvGPEBc/1OQU28T3lVt1VfeylDp6cByFD9uwkW69xE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bF5fzT4hkvF+86pKj1wAhS3Y/EwikXPZqdGTcaugpmiGForoVhmHDqpiaJ0Tuc3fvNMXnuUfGRDCFZfnt0TFRX5udOFn22Yx8QJdQfdcoHt3uMlJYSyxrMr5ukKUspZ/bfDF217O0oamKK1rcAb1jDhYf3/8JVYaq16aQ83HsJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r3CqK0Rs; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig7dWrwt9oTmUMNlCbnc4q69eC1c9SRVyDDIcOvTpW8iMVht+GstpinchTPWEi0gYG48sRLQ7Z6P4obPmaKWuTFr73ED2J1FsXcMtJhEOY3LCNYyAq3KFBBgknEISbfhJYumCWn5ehuESnBv6Iqk4D+vmoJxk1NLWiboUTZsfSOazzl/K40AqX5oDJ9CqF5T8srKzlwjjZ67cSbSgAnmmjnTWPR+FtkvjZfa9WKUV9/3WSyrTRmWCzJtIAmHS1QR0dxTBRJr8qLCHIv5+R/lldMFugCo08R62J7IQKfT+XnT2WNzNEiu1zDbFTYyfClRWoIETw+Mh8zPLd27X/sNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ysLAw7txxdOlxij8xkAnue/KWsvoqsjXGr++e5qfvw=;
 b=IBUIDgnAboZU9wPvsOaurUzOeJQpAVdQfhMKhMwsDucguf9vndVodmUBatwVY0mYO2H8JimXfB8meKA/t7nB25vUYtnXk0cMoLJlQ58e6HH7tzhPS/hPQCHp7IekMaXuoFvP7KmaBE1syLE6VY8HgMs72FhFXmyd3CxdrWqGZ4Av1Y2fdmBL6XK/ZUBhJ8cPpTxyhmZZRMzqG0WYmLwyGTPefmOhoa9ajiCFuZGaNeAyzOyrM68JcQQLnjFiP5BaH5hYAUzgp2XcgwudZIo/wI40fLRAn3XKAS9QQQN6oETXShLIYQu7mc3spiVjcHgJMUueWikzjZNPP8sREcsARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ysLAw7txxdOlxij8xkAnue/KWsvoqsjXGr++e5qfvw=;
 b=r3CqK0RslaMjvLVWqUlAARV/m0oq6MA5Ly0Pu8/v7+FZ1rkNXgQ7V9v9bauih5UWFlLZ+VGIux7G4I2Z6+S5hYHJ6N7UsxNw3tiYinPswvYAaBZEdhuw2OiAijClcYtjtwQ1fAEhPZFw1pcMlHVBQY08twGoxPmpcO3vSgqyAjs=
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:46:31 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::75) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 05:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 05:46:29 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 00:46:26 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <rafael.j.wysocki@intel.com>,
	<Mario.Limonciello@amd.com>, <viresh.kumar@linaro.org>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 7/9] cpufreq: amd-pstate: fix the MSR highest perf
 will be reset issue while cpb boost off
In-Reply-To: <df44ee42774efd7d1c656ed43ff3b35988e22e60.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <df44ee42774efd7d1c656ed43ff3b35988e22e60.1718787627.git.perry.yuan@amd.com>
Date: Fri, 21 Jun 2024 11:16:24 +0530
Message-ID: <87frt6voen.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6e6c6c-944a-4bee-0091-08dc91b57fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jQ96Oz5AcD0kKqfgZ3zmUP8y7Nihu5ZirmCP08ZvyU7OX+4XhsoUEfCGyxbk?=
 =?us-ascii?Q?M3Qi/2S6v1qQlqeN/Y+nDWXFSDspNzrP3F4Unf+Z07uKBopnGbsmNF6E8hE+?=
 =?us-ascii?Q?eoACb6y48yEWakrgp5P+jAD7VuqTd3xeXvpdKBC6AQpCBa2BgL8KyHid9ipY?=
 =?us-ascii?Q?7I+uleJr/65AOaGUtWRnqQ9hSL0t/rZHnrTY3tub36+1NJ7P8CUJb357/gNO?=
 =?us-ascii?Q?Wtt4sV/0RmCx2ZORyrN8uRoikrtYyo0BN/F0Yrp3W/+DekORVa1/cM8sJMVE?=
 =?us-ascii?Q?I/RbtkdAYwSXx+aek6iJ+tyXXqZqsPaqjcw0kp89dMynbGnKFixn494nsIhZ?=
 =?us-ascii?Q?ksvpStfO4WpgyemPSSY1Dv0xbkeFOBSJ6zjqxGPcZgJeOM2EyhSAwrjtIrAl?=
 =?us-ascii?Q?uUN9QLrqc3K6smskrngGU6oB04+vfC18Ej4DCMz1rxr6F/wucRXSI8qrr05G?=
 =?us-ascii?Q?SjFjBDNT2DfvEGttq2RktqssIsVzpEi48XmRA+Qcb3u0XdfEejQvWZV2QXZz?=
 =?us-ascii?Q?X+6u5rCDguQXcW1DlhkmUki62u/GfX2eX+PZGU7r10rsqjdi5EGNY/ynAk6t?=
 =?us-ascii?Q?DV8NhJxoXoPNtM2iQcZFayyhjOJx0QJNC+VQDrAofj1knE+3WVGnHSPI9HVF?=
 =?us-ascii?Q?ixAkJ18axKUO6/FDHoF1tZZQcW+DqhT6hHY9+R0fpWQzYjs/q3aLTDUsHjc5?=
 =?us-ascii?Q?tR1Sj2xXiB1bZISc0JWyyDBRGmqoNuIId44T90d1sQfec6sHHxyiPgdivuVq?=
 =?us-ascii?Q?yDCVfhO59/3lyKHcWUxFxJUuwTX99t51pZYA5SdGFLm/ZC33C3n8gPx89KVt?=
 =?us-ascii?Q?uYEc5BLUvol4acz9Ww1ZQihTOSyFOOFLBStaCkGDnKeUn/4C9CIi6nXI1CCr?=
 =?us-ascii?Q?0vAvun1u5FLhMmLI/PulxOc7+L5jpDI5kCZfZZm25LyrstptA2YeKBCeIin8?=
 =?us-ascii?Q?m1oJUbKmejNMEteyIjgTJqAEKKAtEsn64NROI/ZE1QbE0LsTre7lzSPrI5Rz?=
 =?us-ascii?Q?WrUqhGK1QYcIDAGhM+3Mmr9zewmjH1yaX3mJZJze7nugHRs52Um0L2dxQ2jx?=
 =?us-ascii?Q?3SRaJ1hhsu/SCbbMITXbGD6m9LUVHlE0NF66yRfuVnoxQyv07zS//ToEfHcr?=
 =?us-ascii?Q?CqAPxxJ7RZb2eAjVLWAfzZAbVTlBQwV4PhaLybWHVAszk/YEJIyMroJpeT8m?=
 =?us-ascii?Q?QYUjqQfdkDcCyouIhrXiYYuKHYEArBcLo4ZCCLw+qbhgW9q5nKCl4Y0nvPSG?=
 =?us-ascii?Q?IKQ1/fsnd8Bbmx1xR32KrNO2BlRwiGL9E+EXTjTuT9O41/l5aogZfenonLlg?=
 =?us-ascii?Q?rv57sUKMZucJTPmhC7Y6O5uUZvCXGEELlxAHZfV7Fp/9rU/w5DSBbXt0kut/?=
 =?us-ascii?Q?UfiEZrS+cTNPf2Y7IrPNJlShRSZzVID92R3tNKWCOkBL5GYbEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:46:29.5614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6e6c6c-944a-4bee-0091-08dc91b57fa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893

Perry Yuan <perry.yuan@amd.com> writes:

> From: Perry Yuan <Perry.Yuan@amd.com>
>
> Select the min perf to fix the highest perf value while update pstate
> CPPC request MSR register, here it needs to limit the max perf value when
> CPU boost is disabled in case of that highest perf value in the MSR will be
> reset to original highest perf value which cause the BOOST control
> failed.

Perhaps we could rephrase this as

"When Core Performance Boost is disabled by the user, the
CPPC_REQ.max_perf should not exceed the nominal_perf since by definition
the frequencies between nominal_perf and the highest_perf are in the
boost range. Fix this in amd_pstate_update()"

Also change the subject to

"cpufreq:amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is off"

?
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Other than that,

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 299e52d4b17e..f2ccef089acc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -524,6 +524,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
>  {
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	u64 value = prev;
>  
>  	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> @@ -543,6 +544,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	value &= ~AMD_CPPC_DES_PERF(~0L);
>  	value |= AMD_CPPC_DES_PERF(des_perf);
>  
> +	/* limit the max perf when core performance boost feature is disabled */
> +	if (!amd_pstate_global_params.cpb_boost)
> +		max_perf = min_t(unsigned long, nominal_perf, max_perf);
> +
>  	value &= ~AMD_CPPC_MAX_PERF(~0L);
>  	value |= AMD_CPPC_MAX_PERF(max_perf);
>  
> -- 
> 2.34.1

--
Thanks and Regards
gautham.

