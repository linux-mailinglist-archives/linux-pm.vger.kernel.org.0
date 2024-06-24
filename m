Return-Path: <linux-pm+bounces-9845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BE914138
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30120283944
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 04:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E423D272;
	Mon, 24 Jun 2024 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yHwuXDK3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86336CA64
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204115; cv=fail; b=fX/gulJbyOd6Xbjg3sW9KMB7A/2mTzSoai98poKgClg4N0QGv/OIwVTV/mtz1MpO1K1dwyXATwf6KQknWkzrl6uIDVNcht85J4VBSt0MD1v80WD1Cfsm84/0PNnlwqbdcRkQt9MtmKLxll40cyZIaLZYsueKSeLdXA0QsNNIejY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204115; c=relaxed/simple;
	bh=CizzgSfTLbedM8kwmJK+yl2sEEX04vTUYgCaHDsb8QE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NMOvAiomP96a1HUP12Sv/g/n61cEOq7faGmOavSx1uQuMIovrYBYVDMCYOErPaFyqRfh9CSwg590BalpI9EZ5tqn9wrzkBl83s1wp/PF473F5bX5b89PniNFohdjQXVIzoQuV+z33+3QjUm1KaKnOU4o5w5fpYK8ZU188t/LNiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yHwuXDK3; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK+OMz+NIoNlxyHkM33fKs++qp0+/Y+kf3TvovG15Iho7diVhfLwm3Uykzq6BgpoRuF3+XjSZl1JQFnKnZPDT3pPuy2fLBpjpSM7/QhSfo4yo0aDp4rIU3N2ky3yqYRj/iMLijHx/mJfXyeG/bXHOjkKdfvkjS/2bzmXSPjYiZWfTqoZthARh2EzTUcqOC8DBoOh2wYq6LbAO5tfjl3IyIFcIuPALTYfy+4ZUlYhRoNkv3p1nCSbEsjU/JwJiuS+/9CRb8/t/HR9yXaGgTng6xfLrdlfqKog05eC3lSDQ0JY8iePhnB/BEqLcVWH6m392KXjHXJRBNJ1gNjxr44+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg+jx1mrRC8di/4kGI7scMW82Ol8GJ3bp5Gi+A70t+o=;
 b=Z50m+O3HK9POAs/NhYW6OiCvQhuURsMCMrotyWSfdponvdgoomwklewExgluuvAttOmNxbTwNsxlSqeZ9u1vnnWsSIaJ5HERO8UTkhi7vklKEJ2Vo+5GkjabjpwVk8rxBmGQ6Gn7q+6P3sQzEqNA8yTiWGNXrgGgz+5olZbfkCT/hEwjvKMwRIRxb6WPG9Bkr28p6ifsoPHtM8gGNlNbRr12A2TkZ06CF0fCYhFVJ8K1nz+jTpBNckLkRvuY4piMWx6133QJFmK8q4TaAwHlQpxtH1AWC/LTTbSZUe6rm0MLBQAzLvDOrRe7PuFHY71JYF4vOhSFFOjvb7XJ/1mWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg+jx1mrRC8di/4kGI7scMW82Ol8GJ3bp5Gi+A70t+o=;
 b=yHwuXDK37Xe5qC8S0TiBDqjx8X18g5+Oq/Qe6Ao8yfUniV06BO+up0lsFCmZ9pXkXp3oN7M6iH3SG5nRKocUZku0fZYOM8LVXWM8m4E4kjW8jkGQlMswlsu90Kz0/zIJLOVulnxeJKSIsY0hY5lqpAv19YRdhmyuGvAkr2iwVfo=
Received: from CH2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:610:60::35)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 04:41:51 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::b7) by CH2PR14CA0025.outlook.office365.com
 (2603:10b6:610:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 04:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 04:41:51 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Jun
 2024 23:41:48 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Make amd-pstate unit tests depend
 on amd-pstate
In-Reply-To: <20240622215219.47911-1-mario.limonciello@amd.com>
References: <20240622215219.47911-1-mario.limonciello@amd.com>
Date: Mon, 24 Jun 2024 10:11:46 +0530
Message-ID: <87ed8n3qb9.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 8124b35b-42c2-4cb4-724d-08dc9407f728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7wJiuDCX7SvjTzlLpwmlpRDw32CHKYVs5reIaS3l+LS62Gvxi61Uwp8FS0s?=
 =?us-ascii?Q?zMRzxJIHd4B6edPMmyP4TciJUsGWUd7UTVAww50sRWQacXmz7PvELchunC7b?=
 =?us-ascii?Q?/3ufSpNUyI8GXG+KvxsZr4npmsRxbGGdZyFqFgx7UJf3+/FHIH9Y7JaKfdvO?=
 =?us-ascii?Q?Gb72c1o+Y6n8SZZCXWNsQZb53/KSv+nncMd1PbVysFYLObHTn8B9VAi5NQmq?=
 =?us-ascii?Q?0+U972HxUhRk41WKlKQoj245V5DDaTZEa+bqwGMdSVx3Al52mupDNVdUQ2/B?=
 =?us-ascii?Q?yYVdb5Xy+ZRXtOs81aDLr1S3oVgyAJ7cMN8pCEorHnkFnwSZ+23Y6vRwoAby?=
 =?us-ascii?Q?dFgs2SB0lE9NeOJzQIEA41/IQrnNU8hZIXxXqS7rBMXRde+0ZmRR65JZayZk?=
 =?us-ascii?Q?9XjoY8Cu0jI0CTFLdS2xS7ZgG+wh1N4BFOYkriLXe805jj86IKmXTgnYmOZp?=
 =?us-ascii?Q?SrjOuxOwH/UopFr92OB6uPKNF+qF3AhObDnuE881w2zvBm7k+V8qXl/SaYOO?=
 =?us-ascii?Q?MMsM+Lub/pXuYnD6GB1zx15amL7f+wS4hy/Y1F9dDrw/5kCViGGD7svHHp0a?=
 =?us-ascii?Q?WdY4hirYd5CJUTUBqwsAJfGZD30RbCBW4H372juDu6lGTRSGX0S4fUdTGiTB?=
 =?us-ascii?Q?6oacfFaTDq5SSRCRvWgYRbzlKbwT9bGsqvycV55kaOwAQOVaGVTK4RPP1mHN?=
 =?us-ascii?Q?FpBLtAtgOIvxTVbKDhJTgP6QPipspGJbWkpanfwcax/SuN3CagVDPPXMY5qR?=
 =?us-ascii?Q?l7e5jifAFb3FTyFoiK5yK6Ui1R/6e8PthtLMTsgd2hkDVLo9Dd95WHyugmsZ?=
 =?us-ascii?Q?Phie8Obl3rMAHoIWCXrxd9D8qO/4bObDT8T4feAtnL1LYRaUUR4UbdRgjDMP?=
 =?us-ascii?Q?HLJgI3b4vTpIZsAEbsT/GRR7lWNvnFhQ6qMOg9g1kPse54QxS6DB/0aR8JWN?=
 =?us-ascii?Q?YNnt/Uo8obeNyCHyWbSkpbY/PqPxt13xFQVcXWRkIFqwPJBq6g02Fvki4plA?=
 =?us-ascii?Q?VhJKz4DwM2gNGgBo4Hc1llSaLDuF5hJOvYoww4E/ukbgu6UGcGehaGeulVk+?=
 =?us-ascii?Q?SblO1VjFhPGjoQOZQ4YW4y2W984CTFf6pCd9DW985aSS3EIIzZ5n1LZ0YRZk?=
 =?us-ascii?Q?UjPQdYoWaXfX1DKkZxH9pmET936PzNgOoBevuvzoTGwfB+HwIlNhTYI5LYc1?=
 =?us-ascii?Q?CYx0pVSzxTNLMP1XF5+Z8UnFFHs+DzXnYQP5CqBxTTRII8hk29DFtAoKcE/a?=
 =?us-ascii?Q?EaZu8PZ3aYYc9esNqlXdRLCtCbTVYZzCkIMdeb5njJjFiIMfB442+bIFgrWE?=
 =?us-ascii?Q?gFRZ1+FI4a1yOHqcOyigBbbU6oDKg1EfVF/jOPq83BWFNiRy100WCwQ8rJ1R?=
 =?us-ascii?Q?I2si1Jw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 04:41:51.1291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8124b35b-42c2-4cb4-724d-08dc9407f728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

Mario Limonciello <mario.limonciello@amd.com> writes:

> As the unit tests use a symbol from the driver an explicit dependency
> is required.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406222016.R4A2TMs8-lkp@intel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/Kconfig.x86 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 438c9e75a04d..97c2d4f15d76 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -71,6 +71,7 @@ config X86_AMD_PSTATE_DEFAULT_MODE
>  config X86_AMD_PSTATE_UT
>  	tristate "selftest for AMD Processor P-State driver"
>  	depends on X86 && ACPI_PROCESSOR
> +	depends on X86_AMD_PSTATE
>  	default n
>  	help
>  	  This kernel module is used for testing. It's safe to say M here.
> -- 
> 2.43.0

