Return-Path: <linux-pm+bounces-9723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3A5911974
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A88B1C235E3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 04:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B9127B57;
	Fri, 21 Jun 2024 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c/5A7gma"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59DEBE;
	Fri, 21 Jun 2024 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944246; cv=fail; b=k6YMZe73Lu9dSc1wGXkChs1Ib4TCTG86wOXyW59VtoyK0KDUyi7p6uqKxqZzD/Zl/dik0ixS3OVnLFh8c6DbSE4U+H2Dkf/MimvHynoElb5zP+bFBTI4xSSxELqkFxVlCaakBDEvGfo2O03VE9chOC0GG9aA1cqK+pQk56YcCts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944246; c=relaxed/simple;
	bh=Nw0NLhOHlIUb9k/ETV8JZ9+Qsa48ksrhKLdpnnEnR5Q=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvnbKjQJWj4zjS1mFLeQnjWuPTm7I9MxID12I5h6/78cYKtMUWP4Kquio4Cv+x+PGbGA1UGBHEznJzWzH+DmOz9Ji6DqbQIk0zTZ+uMzvcaU3E4PkZa4xDtLuCh+yadCGPvjZw57ghJa4IhYlFdoqkxfJl+IVgFQpoUVaJt8DOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c/5A7gma; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAo8VMpOh8SD29bdB47kIvDqwbhJF9As/u2eDTlwmVrUVRO018aMMsnBZ5M/xPuzA37a1Mc8YxH6XEKaGmuGbxg36PNVWQJrSCWn2nUgAa0dIIR7dRqMT458nrPcFN7kVs0Uxt2N+zXq1HHtyP+yoy0ktN4mkx35P7TQ56Da+R4I0vYTI6Nk7pGCjzwOIxy7M25OWYXkJDtHHVGuFqPb+L2pog8u4BWJcbi69xVhNyenh7q8LHo05RlBK8M7YQQTZMV7AM+RMxhWyHOufTs1cWzRBi4ceeWO2Dv7fFLwHopFJyoak+XKClL6uurm5shMfvx66Lz3OfG0Xof+r2rqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3eTkQe4Zp29FiagUcVg6E2Y+fkufWDw/Fx9iopTB7E=;
 b=hyTy0MjOBO0mbpAWcdEZxgGvlh97yubQrZvk9K1cNpoeNHq+rjH/R1xVazxs19K+qLJnmsjIZmZZFbdwXAoXo0oYyURdiPIxK9gTP0vvhL4lTjpu7Rag1hBu0V21A1NxyfD09ntiKi8FijQ3L+uMMy5Rta0H7f66yAOy6thPmWEsYf03MMBYhclBKjZyS7mLA/K3y4YfOc+i2ljX1EICFAe36Q+8PF2G/C9QWsasStISR32IxbXnZLRctHXPTmA2xd/oJXAauKWcSnliEoh3PdTg+YTWASwUdmxMsMWcArDzGA89FaBQKL1kCAv2sQYZX/YhPZffC8YnuSzDBWT6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3eTkQe4Zp29FiagUcVg6E2Y+fkufWDw/Fx9iopTB7E=;
 b=c/5A7gmaBRaAM0hzqPG4vmXBiw5nU2TnK3KqhYuMfKzF2eET+boMfGJLxuFSpjQhF4pRgXMqJoWKyQXIjQXcaqhDLMVKop2x7imOdT5RLXLf1QjFrOX6VGxna57GHWd/riMVLKzbSE9POPGNB6P5KCLX90AbUVx2ffPcuXwSHnw=
Received: from BLAPR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:36e::13)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 04:30:42 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::98) by BLAPR05CA0018.outlook.office365.com
 (2603:10b6:208:36e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 04:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 04:30:42 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:30:39 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <rafael.j.wysocki@intel.com>,
	<Mario.Limonciello@amd.com>, <viresh.kumar@linaro.org>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/9] cpufreq: simplify boolean parsing with
 kstrtobool in store function
In-Reply-To: <26f6ce59390a157cf37c622dd2fcf14b5738a8cf.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <26f6ce59390a157cf37c622dd2fcf14b5738a8cf.1718787627.git.perry.yuan@amd.com>
Date: Fri, 21 Jun 2024 10:00:32 +0530
Message-ID: <87iky2x6hj.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: eaba7f62-31bf-48bc-7e18-08dc91aae95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/U2UZO61fFdWpGVH9AXo3cP5wf4sPN1itbqovGxkh3RIcdKmdS314tN5G5d?=
 =?us-ascii?Q?It2OkV764zl844zMnm924KxZ60JUYmj/BwiyHYz+ZoGWgaae6q39bJB1Vlqs?=
 =?us-ascii?Q?ogwbz2G9gLJQ7NdS4RX5oSkavwiA3To+Cgz+uOPhIdMArkeIxAApDNp84liu?=
 =?us-ascii?Q?5Gy/qNpq5QgUfbpbdrov5Y5D5uMWL4YJ0/X8aHBKjOENcaJEG8uqX2hvgezd?=
 =?us-ascii?Q?V0yCpfUrKTf/UgmLCppTf+4phlVAj42LX6qEie51x7Y/6AjvsSt+B6IuRKF4?=
 =?us-ascii?Q?k+taugYCQzqcDB62QNW0ht9mK5G7jNInaRE3K/EoYAEB6XPJCqOB01R/Xlr9?=
 =?us-ascii?Q?jhImekhq7Y2hChMUoMtljndcLnvnpHjg3Y4beH2CH9l8lV3FydvKkDn4WtXj?=
 =?us-ascii?Q?WNj/0466Sg5kNuu8GZ+MlupsnlWXjmc2bsXaPd9KLglcdUOA1ibJZcR34FhN?=
 =?us-ascii?Q?Oex18YPypIAC/TI/cwCIgvvqgyvbgTqCzLWR8pLXB8BkN1MDY2qZFD3J03rR?=
 =?us-ascii?Q?yHNzw10EbSE7E5dnWu2ql9ICx8wwfhuNIITThNNHK4IJTRjSqugWfoQJF16s?=
 =?us-ascii?Q?TiN2KQfbrukpppOsFraZdvUSmo5pOakmn9SUrdaA6/LCpPkAVtu/Mz+jTb11?=
 =?us-ascii?Q?QjJp0DD5aujHu3xPIeZ7lOnINxhc+4xSMi+yoO8cXyf3SSkWL0O4LZZWlWiB?=
 =?us-ascii?Q?LGVQYSoTLtsc8r2l2sJcGO6osrw8C3KekYv8TfMnrXECpn0yHYjuvWeDR5Pv?=
 =?us-ascii?Q?DhaGbrGTlJOYkxh9DwQWatLADSXtfhw7gK/OGT+FgZaA/A0AzxgS3ROI9uV2?=
 =?us-ascii?Q?C97/q5zKGfKInxacgH5iHnpnTk1rS9K0MNu+NIPltlL7jLYoVgRJ5Xo8s3WO?=
 =?us-ascii?Q?nSgvu0uhfgOwQST44iIxwFMG9cV91ULh4LNzqOW8K31Nu5sLu9baCTxVqE5s?=
 =?us-ascii?Q?DN5ITs6pI99fosULrJ6AyTbaHJBhgvUVjZFyy1sU1rbQJ1T1+pndUCyv5CDN?=
 =?us-ascii?Q?Kyu81JfDlIu2RHzxEL6Ym9k0TopWf4yVmFiSI2IjiezeSdvn9RPm322G1mj1?=
 =?us-ascii?Q?ayYmYGHHHPMURABnpsKT55Fg3IrGSuRD1ZFu+dZdC69uUDrnZ/ZtYnnFHDBW?=
 =?us-ascii?Q?Ib0O3tmQvCJuklQuEfl5486RGbQAwkWPUudl8XH1y7H3ijdx5YpcDuZFVYx6?=
 =?us-ascii?Q?Ww36Hp1A911PpjQL1fr/xdDeWkIieB3FpyfssKjLywzqAJJ4p4GJ8fQxIrcR?=
 =?us-ascii?Q?erd5n4BH9VPdINesBEVsTJ8blbo905LXhfRbBwBGpc1GvONhNqKqPiEcNYx4?=
 =?us-ascii?Q?20NV6Vjy8wfqan/gExIt7IO7pCx+4rcPQyfJxJgan1c2xqgndpavH56poGZO?=
 =?us-ascii?Q?dzNryolO4R0n3vkXuwQrhgBXIKXyriAHSOIz3/OKVWMGouWjFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:30:42.4763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaba7f62-31bf-48bc-7e18-08dc91aae95c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

Perry Yuan <perry.yuan@amd.com> writes:

> Update the cpufreq store function to use kstrtobool for parsing boolean
> values. This simplifies the code and improves readability by using a
> standard kernel function for boolean string conversion.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a45aac17c20f..1fdabb660231 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -614,10 +614,9 @@ static ssize_t show_boost(struct kobject *kobj,
>  static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> -	int ret, enable;
> +	bool enable;
>  
> -	ret = sscanf(buf, "%d", &enable);
> -	if (ret != 1 || enable < 0 || enable > 1)
> +	if (kstrtobool(buf, &enable))
>  		return -EINVAL;
>  
>  	if (cpufreq_boost_trigger_state(enable)) {
> @@ -641,10 +640,10 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,
>  				 const char *buf, size_t count)
>  {
> -	int ret, enable;
> +	int ret;
> +	bool enable;
>  
> -	ret = kstrtoint(buf, 10, &enable);
> -	if (ret || enable < 0 || enable > 1)
> +	if (kstrtobool(buf, &enable))
>  		return -EINVAL;
>  
>  	if (!cpufreq_driver->boost_enabled)
> -- 
> 2.34.1

