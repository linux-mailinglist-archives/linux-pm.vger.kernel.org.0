Return-Path: <linux-pm+bounces-10090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D81919E88
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 07:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F739B2172E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49B175A6;
	Thu, 27 Jun 2024 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eMl0XotF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38A2139A6;
	Thu, 27 Jun 2024 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719465460; cv=fail; b=IpZWxi7Le24wc8cTo1UPsaLs02UumBP3CidP4twzpbsUnBnkdANY/t/y1NgRwPja58VUnp6iZYClhrk6VKYzs7IC9+7aB23kMS4XzYIhWlut5KS18gjfcu2ZRQ259SCvUevd7BnM07gwp5rsskcANDCE9u6d8m9BBrf9tEcyb6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719465460; c=relaxed/simple;
	bh=tXARRv9k6WfsXC618vo7xEFbx5U03ch527SrIL8+AAI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hlIzp45Kg2IWiyaX/8kSoaLX7fDlnhubLbmkBWIfv0zb2/Oy7zW2nHM58ckRgO4+brbZuTXuiZuRhbLxYjcSK5GiEtsB4nV+uYydaWlbdztemlMU/DAWQ4sBQkuAmX7KYZvoT91fDRdzKEr4w8f205W65oDCPwxK6FlJuqoNCzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eMl0XotF; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp4ezjsDIwfp18xgMNnoyU8gcQEIC6FNq0FJTRSUsjuYF+yTwsVL+zWSzUkxmkDZ2SZ2++PMqkegDrigyn2ZubFQXEiKVqWIr0Uh041L3sYuYcg7MLiYXLgm3WDfVVGsR0NM6uBE1DgJqZRC8ciJkMEImPHadLe9PeLNF7pZD2tIIZB5KOP+bL316mK6D6ze3tR1mY6bAZM7qHNdBMIp3LRnw15fc0kobohL9m0L2Qg+/mwqZpUbNId151WDZCwra5hdutDKurDDLDj+JBL6rDfyagMYDBX7bQNeSu4hNzdbjmC/Dj5XresdQl5v+WJqr+JU+i13XjJTqrFhLcZa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l80OjoQPieRSeboaG42xQ3HWleXGphDjZ9nv+QQq5QY=;
 b=Uk0LrCC6Eyjr4ClRZwCdOb1mfEDav70sDOEmle35JFpRDF+Dwj65RSEtxzcCqCXc59Vea2EAZsSTN31vtcHCytC4MyHalDhmGM1Q3wIbXpvM8FvvOm9maDZapfqIG3IgXpswmAtTkAtc+ZBt3AgVha9H8JT7pdjyTxG5vB9w0eeNN9L3P4XnSNJxRhka4cDaCZS4HCDeM4M9OAihVrqpTsh6GPBv5U66lVMdRCVZENESgupyk8QE95L+P8l8oc9aKbVPZY1Yqk+W7Fty3OSUPj7Zo0VDT3d2G1xtm89OKc/fJ35k/Gwpqssn6XXNMvkSYhVs79WfGQuY+v1DIJ2K4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l80OjoQPieRSeboaG42xQ3HWleXGphDjZ9nv+QQq5QY=;
 b=eMl0XotFDNKIXAEM+u/qcy4E3Qwmx72I65giKSeFUA2RPSLYRF4QD+Xx+JZDbNvFjVsHGtfR1WlcfBWv3NSI8B0RBD+GHiOZklH8804M1COHXGrZG3c5dMDyYikwDwtawAs8gbOeVXRkNUgGyk5PWmK8FOS0QiKkXhCV6kUnHf8=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 05:17:29 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::e7) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 05:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 05:17:28 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 00:17:23 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Sibi
 Sankar" <quic_sibis@quicinc.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>, Yipeng Zou
	<zouyipeng@huawei.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] cpufreq: acpi: Mark boost policy as enabled when
 setting boost
In-Reply-To: <20240626204723.6237-2-mario.limonciello@amd.com>
References: <20240626204723.6237-1-mario.limonciello@amd.com>
 <20240626204723.6237-2-mario.limonciello@amd.com>
Date: Thu, 27 Jun 2024 10:47:21 +0530
Message-ID: <87jzibezha.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: de86d276-d2dd-4b13-709f-08dc966870a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2NAGo3ykVtblz0rJgkJQ56edfr6HNmlD51LFCfZiozCzAUtO+sidw0OeRs3?=
 =?us-ascii?Q?NVlT678KeLPm/ojpcTC0eKet0QZaLxdsP33PmYxbCBqqHMXCTUUWKuDArBIy?=
 =?us-ascii?Q?G261gFNPEACsBQ4cnB6DurI48DoEcWVhLWmrvVn7WE4KoCRlZnUduzpkMUcZ?=
 =?us-ascii?Q?01DEsX61L/aR7+TKZEVp6mp+f6gapMoSsGvcK51LinMKLyS+rDdofQLCNctJ?=
 =?us-ascii?Q?FlAdEp2zFlN3PEIoUB1pZRx2c5/Sfmlv+W/nBk0MPgHu+0mmESZ0uj03LmZw?=
 =?us-ascii?Q?krsSJI8gJOXtnskTgU+C+AweIw01yzHLgUdQ6HKoxz4XRmMKkVCc2Gp4C4Io?=
 =?us-ascii?Q?tmrD235k2vSxGJ0rqxfr8t987oj64X9BoVKlvx6CzxAJNF722SPwdBznK82R?=
 =?us-ascii?Q?LZ2MMtBCkdQ9TxaFsSkRrkChuphC1Zzd3UdUilQxbkFGHcLiLEwqy2mkpqWT?=
 =?us-ascii?Q?RQskuVd42nyywa0K1SnerZ5ipRuHliLORozd6ywk/iSBSTGfjrg4h9SJRVT6?=
 =?us-ascii?Q?e2K93Tik/vNypo9OHqEwvsuUUyF14Z/sMFvK+o3JJ9wpgJdYuUebi7/LlXwz?=
 =?us-ascii?Q?RshjhSnuvZtS79/lbWaLuRgZKpOCoM4rBgieFynnBmv0CeqgYHzxJ5Fb6RKg?=
 =?us-ascii?Q?MQr64JkAXDNTX+940oPcaLtTn0wO6e6h1wpKLfuD/K48mJbr+SF61dmdY2W+?=
 =?us-ascii?Q?82IcG/JWMuhh/spIdZVHA0su/Cx8kBcU1qplL8roJ5QRT+rqIvPuPckbaLsk?=
 =?us-ascii?Q?iar2hXchJxZ8iyeh0IDUJhvkRhb8njB7D9KXrHk/2aqTvaFsXFBLK1f6opYM?=
 =?us-ascii?Q?DrFzIUlWzH+N11HLwQTkrSra04Lu05U/Eul89MEh5ypWhUQllVpr3+Ru5foU?=
 =?us-ascii?Q?+1N+lPHyKeUWUiq7wHiey+AkoMi6WgxzrItP6ohLZf1YpVCcUQk9ZaySDspv?=
 =?us-ascii?Q?8owprvzYrQqmAI+w+KMSS/NQY8BH5ImwgKiX58K8itILxy8mR8oIgU7dJT9w?=
 =?us-ascii?Q?MBDfCn0KzN0VI9p61Lf7GlKAuRgV2T6Srq+lDcl6WaNWDBaV0mVN3FRL+BxI?=
 =?us-ascii?Q?Q3x01a6lVnrmd2sxJhI0mFuMJSnwiypUDCYWyTI7Q3O3EAlI80Xh8BOQ38UP?=
 =?us-ascii?Q?OnliLUWNmC8Q2Akjnbiu1FF/EYCkxngDgsio5PtZXsk2iyfDfIyfo0f/mrhx?=
 =?us-ascii?Q?CV+4TVQWBo56XO/aqy3GSuQersIdNZICfJfFF7ZoIzUcBRvl6O3aDBeIobpp?=
 =?us-ascii?Q?OW7Eu9gD2zNrTfIi7Dl8w0kJQV9T39FQRSi84WiOPuX3n5VDJjrPUdXBMkiZ?=
 =?us-ascii?Q?+O8VqRdw/ooNkCJgv/80mBFKYoH/2Wr5p5CTiRhPFeEOdBN9dQom4VCLY2ZI?=
 =?us-ascii?Q?EDgR/HirToTN9b2l2bJApmHMry1BBi1mIJYAFfjtGZ/3QMglRn7FJDK7oRXH?=
 =?us-ascii?Q?9BjVO+QimIH76CE3iFiLzEDDzKmTua96?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 05:17:28.8598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de86d276-d2dd-4b13-709f-08dc966870a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689

Mario Limonciello <mario.limonciello@amd.com> writes:

> When boost is set for CPUs using acpi-cpufreq the policy is not
> updated which can cause boost to be incorrectly not reported.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v1->v2:
>  * Move to init as suggested by Viresh

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  drivers/cpufreq/acpi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 2fc82831bddd..fa2664f9f259 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -888,8 +888,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>  		pr_warn(FW_WARN "P-state 0 is not max freq\n");
>  
> -	if (acpi_cpufreq_driver.set_boost)
> +	if (acpi_cpufreq_driver.set_boost) {
>  		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> +		policy->boost_enabled = acpi_cpufreq_driver.boost_enabled;
> +	}
>  
>  	return result;
>  
> -- 
> 2.43.0

