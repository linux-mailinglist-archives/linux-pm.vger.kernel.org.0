Return-Path: <linux-pm+bounces-10088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B939B919E82
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 07:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC7D1F21526
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD21BC58;
	Thu, 27 Jun 2024 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5LCJPhJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0951CD13;
	Thu, 27 Jun 2024 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719465184; cv=fail; b=T7iBWtjbL122yJ7jTOSkkGObFRXZZILhvUhB4mrPLqqDCaAZ1Ib6uMoAvJm8JZhVCOzgwHwnaoZO6FzawaM7DhQ234mKRPrgJoLWC46f1re5S0CkeoBFq7qU+CSGpQDLUm1yrboPIPGr+o3QrTmjneALPl5OYi06GEexOIKPPoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719465184; c=relaxed/simple;
	bh=WqhuKFa4tQGOBrhTOIeUKIOi+iGJlSOcZLbMakQPRjE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CXwPkLpb8CNBNRZTeWmvVI4LatztVluF+BY9C6xaEPoXrYlvvFZBbP0cyo8jyPVGvr075Ml3D9MAQlcF3vYkr3MByhxi/PxA97QYT2P3Vm7OvItfojXuN3p8gKaCG4Hj/XBYAQwJSObV/bKOIMItxzziudEDMkH4EO40ScwiI4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5LCJPhJ; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRFdb/Ki1DYFklgQ6UTCOs0kZY10fk3SRxl/IrMkQehyGPxGGWZniiePdPhphhQyG4MVhsn+mXZm0HZdhWmYlhWPBO6FbhIjvKZKIwIuoRXkomtTL5Sk3+Xws7coD7SswD+hlp5VlkhxXcfELfW+kHb9CsyCMoXW/q2fGN6G3yfvjhWBu8B3YWl4Z9UHDdUavDcuHcHJDj/T5ROYIlBHF0cW61LPSYRFiRXLolKOVomVdO2aUpG10pmnzvwbruKfjW2VZdsCQbMlDkUIE+aN3uHKVbejCqq0W31RQf3Sewq2TLd4pfMF2WFOjSRl79MEkJkEJowzIqMuBl0K7xcQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNR3b2BAaTlLLEU7wclWDKGkYZMeD0q7PEfnRJ2n/0s=;
 b=VXtpEAVKtNF8SPLarLH/1jUYhVl/oVXmZgfcM1nMBf2NJnJ8OKUP745lc5zvnpBApY7p7n2rVt8C+y3LPbTSngumUd50TwWlSjSpnw31vbDeAmS4Ac4RVRkBISh7tFL32dpcsOAtpSlNTP35EOOKNiAEPBVb6hXs1IKuqT8d1zRzDgXu6S1dWDx6AY+Q0gXTJ2nXzRM3yljhc5SvMTI01LnHewGE9k/5UkKxn1m6qnmXJq6beE0IbJtCSL4yqMt/3LI6ct1eBcmfFJl+T7JhvJApTNfpIhma+/moal3DydYBDIOzs0kD/Z4PaPU6V5VYfNyZ0Zy09Aj3zwvfcjzkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNR3b2BAaTlLLEU7wclWDKGkYZMeD0q7PEfnRJ2n/0s=;
 b=U5LCJPhJCOYKvXx0SUx+Ad3zu1rg52OzQ5sDgw9BBafR3vHf4pIFySNt7VbySgww0fw4EviDVk38ZPd+AdnEO5OKR6kaak41BqMGeS3QGexKMlW9lAGuBI/Pzu4hi75WcQdh2ayg0W69GAgjq6aNUPmDUm4zV+7Ef8VZg7m2iOY=
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Thu, 27 Jun
 2024 05:12:58 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::50) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Thu, 27 Jun 2024 05:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 05:12:58 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 00:12:54 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Borislav Petkov
	<bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nikolay Borisov <nik.borisov@suse.com>, Peter
 Zijlstra <peterz@infradead.org>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
In-Reply-To: <20240626042043.2410-3-mario.limonciello@amd.com>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-3-mario.limonciello@amd.com>
Date: Thu, 27 Jun 2024 10:42:44 +0530
Message-ID: <87msn7ezoz.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd9b41c-a4f2-481c-2556-08dc9667cfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NnGnDEm+IvX3fL8Ru/iM8gl5A3svbTyX7+tKrR0u8JzjlkADCr+wqzUkDAwk?=
 =?us-ascii?Q?dq+EXkUOnGisuP5TkzcW62NZBtyMhroryFGCxoGQ+xApKnxdq0blCzzb3qfB?=
 =?us-ascii?Q?WFZId3hoT7UaKp7Ujd+U0SgSesESL5oF6c/DFyxKu5+pEzMiv0ndMob0TT3A?=
 =?us-ascii?Q?HSZjxjAH6/6BK/BIZxS9kMKN9GxJaBrXtmJd+hA1Mb7NfJ8BTnkkYPonF2rC?=
 =?us-ascii?Q?I0yHnB4qIJa4CW8s1FE9/wnWLb3NRoNb6VW/0HWVtj3+7GLNnQz2tOJNwJSJ?=
 =?us-ascii?Q?dYHnGcpEoH7vQM9DOs+Tanj4x2UwJZ7KEr0m4Uxjb+3kezh3tPlvKp/vU+gX?=
 =?us-ascii?Q?e0tPYMZunUoAreY+lNVW3qXB+c4dB9ucrkfd6NpArAW4HEuwtC2P/90g2gfe?=
 =?us-ascii?Q?hnG84maVrhzSVsbBtTgMHLzi81Vxt2ZsLizCGJU6SHeu0+0ed1T3PMsXJ8Mo?=
 =?us-ascii?Q?G0pFHAFrb7+6p0qczDZb6m9fGJL2ER20bxdAD3nexauF0UmHVfQdFXTYZ5PM?=
 =?us-ascii?Q?LbDT7c4TgODeLP5XYVV8u0bWxVTCPs9vnJ2xOSttJDa/lycsZDym9PJGMMNJ?=
 =?us-ascii?Q?NAfzcurwbuwv2XFxfFb7T28YYecg7elBprCApAuqzyaCp/PK5Dvn3XWIFC1f?=
 =?us-ascii?Q?HaUFB2VRJATDFMlWvlUmb2NVXPYvyvfWbi4r4fOFfwAa9lDC61H7mrqkQJBR?=
 =?us-ascii?Q?5OafawjAXIBSgVBGIOsuq4FaR2p4ag1zUDZPE6IDmV4awJ24SjymfIqnhwtN?=
 =?us-ascii?Q?gI/dti9NQUrKkhdARYnWM107J0ChREhHa3MdCZi6PyxAjC1JlX5PtKA8B8pl?=
 =?us-ascii?Q?tIYmYUzfh6wxocwNKwJgPxVVKUaIaR403Fz1O6+w5RkNbT147zqNxVdwtHiL?=
 =?us-ascii?Q?9oIbHrN2FQx+5aBgBrgc+vfTI1NElE/3pUYERc19LRJtp63Dtns+Evj9p5Hj?=
 =?us-ascii?Q?+blI5r/E1TKzzmWesw87/aTJxPrMEo4Fs6u6kEIXVaPzvci3g1NjS6VGeqbU?=
 =?us-ascii?Q?OUYyR78wg9S0zT24FljbGAMzXwV7VlvNXuw2dl++EqfNgCBbOmnmCVNwnwqu?=
 =?us-ascii?Q?dkkOfu3lyn49QFQ9yzku272cQAOmHqJnayJuj8JneYvdMJvZ8tboJ8nyWfnD?=
 =?us-ascii?Q?BpwwhL2+1rNOGwiUlnReO/Zw/oA6usTmPYaXn2Opji9sIHp9my8KmhPPLDGP?=
 =?us-ascii?Q?npwbk1XPGlxhzX0a54RsPHxSWCLNYXegJ9cRE1G2GjseAkGt2ySTUkJ4blSj?=
 =?us-ascii?Q?bvQUukZ/m4UuCz8fgXww0uMMWhkv+RU3TatiZR+Z2GMs6gtPfRAc0ZE9t4Zw?=
 =?us-ascii?Q?Tr6lPl/AmXGeBP7s5bHC1Yj2f49YgcCjVsuEGBD/lAg8qbnXKu62mR2oyeBt?=
 =?us-ascii?Q?peUvzXn0zQ+HdmliGlVjzwL3YAXS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 05:12:58.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd9b41c-a4f2-481c-2556-08dc9667cfa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

Mario Limonciello <mario.limonciello@amd.com> writes:

> To keep consistency with amd-pstate and acpi-cpufreq behavior, use
> amd_get_highest_perf() to find the highest perf value for a given
> platform.
>
> This fixes the exact same problem as commit bf202e654bfa ("cpufreq:
> amd-pstate: fix the highest frequency issue which limits performance")
> from happening on acpi-cpufreq too.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c    | 16 +++++++++++++++-
>  drivers/cpufreq/amd-pstate.c | 21 ++-------------------
>  2 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 8b730193d79e..e69f640cc248 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1218,7 +1218,21 @@ u32 amd_get_highest_perf(void)
>  		}
>  	}
>

From Patch 1,

+#define CPPC_HIGHEST_PERF_MAX		255
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
+#define CPPC_HIGHEST_PERF_DEFAULT	166
+



> -	return CPPC_HIGHEST_PERF_MAX;
> +	/*
> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> +	 * the highest performance level is set to 196.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +		switch (c->x86_model) {
> +		case 0x70 ... 0x7f:
> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
> +		default:
> +			return CPPC_HIGHEST_PERF_DEFAULT;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Should this be CPPC_HIGHEST_PERF_MAX ?

Without this patchset, this function returns 255 on Genoa (0x10-0x1f)
and Bergamo (0xa0-0xaf) systems. This patchset changes the return value
to 166.

The acpi-cpufreq driver computes the max frequency based on the
boost-ratio, which is the ratio of the highest_perf (returned by this
function) to the nominal_perf.

So assuming a nominal_freq of 2000Mhz, nominal_perf of 159.

Previously the max_perf = (2000*255/159) ~ 3200Mhz
With this patch max_perf = (2000*166/159) ~ 2100Mhz.

Am I missing something ?


--
Thanks and Regards
gautham.

