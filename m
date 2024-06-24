Return-Path: <linux-pm+bounces-9844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7635914136
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC01283964
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228CCD272;
	Mon, 24 Jun 2024 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zxn2duUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB915E83;
	Mon, 24 Jun 2024 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204065; cv=fail; b=VmS+TXxCwW0/Hn/cL8WpLCJeanOEj3R/PSjMWCTnJpWTsfIs5PmGw1TneXbZaE0/yGkgoby3RWt8SvfsetCIQl4eRQfNSCjnBYPu/Cd6dT99LdpDoTPRf7XOSok0MZUUGdf7p1JJqQIDbIeAhCMAP5XbtFk2M0nMvPUGvQ8+tdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204065; c=relaxed/simple;
	bh=II+LIKajECa3x08HvlTGrIVgewPGv9/NXe3m2zUEE9M=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWXCTB2ZY+PMjw79yf6GpF41z+VgV6FiGLU5IAbGRGSBumbCWCssiPZhMhEvFZGU5KQ8JTFSih1am3jkV5dkDotV1QD+2NhNnNp8cxTnWuJEG4pl2Lw461QMEkRbUIA6plZ/qRishvvElhhn3L5eqI8zwSxZnJVAnUMXNO59Np0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zxn2duUn; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StdsZdF2Pe9XCA1amsL/OQ9YN5YQ+0GnRe5kvFowkWdFLgbqt/nbILx7rRoIxQaordFm8K7m581IiRo66f0u+6RWnV7Xn7lP63VV/9q/jtNlZfCpeKXDLgnFIqXaBtpLJfa6mVlhG+ctBwqm0c90JrTR388mn5ZIJbEdBe6hfeBvifecS8x6tmZNP8F8q48cYXcJ9bG6kt0Fj24pP+/2iO4zb4AIaQt9TNbIBILTp/dB/ZVwc85NdbZNiV50YPPJxLRhzP0QK6fFZEDjnSnk3drT1d56Gb2NNkYHfMzRBFQMKVrM+CH8JCvNgpw4MBif6o1609Gr4UCEIJXoTVJOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY023DBTGvMwxPbnKBfFz9nLfu8y6oPeljbg9rMwNXI=;
 b=ZPfnzUXo8Z+XVJjU7Bipx0rvk+/PNkgnQ/RxYsjwuz5haS7/QPn1WxRsKyTCry0gCfnt/4lGKae9Uva2Mo33e9rPeankxfqPjw8Gg2+QGKhj203xv4LQ5XAyaRaV7vBlXe3cePmBMgnBiE6jfn/rcAlYttWGU/9mvfMJaQIiQWQ64LjoI9By0kmuoDDyD2as1GPIld03Vbu+n1xQItvbs5ihDUNBeebOMfaB/DRyqoivZRG0hdLWQkoKkpn8jLbUUbGwF4Co/t2cq5sYrMgWWFHWSfSjlP6MyaAeA4u17vLSjEQDqY1rtQitPDhp3Ffm7wS7tdFY6/R9ezHizbNNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY023DBTGvMwxPbnKBfFz9nLfu8y6oPeljbg9rMwNXI=;
 b=Zxn2duUntW+DOvhXg/hGdNOlnKjPbrjJqv4sQ3ft9OvmlRfXeHR1uS3zMNuu92nqj/RbtNlheQ/LtMhcenauslo37ZUW6pd17ijlP0NXzhIhBk4i7/vous5hudt1MUdpJMydv3yemVBCyJOVhxyM9MPB2Us+3RAs50XHt236SwY=
Received: from CH0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:76::27)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Mon, 24 Jun
 2024 04:40:58 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::73) by CH0PR04CA0022.outlook.office365.com
 (2603:10b6:610:76::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 04:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 04:40:58 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Jun
 2024 23:40:55 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, <alex.s.cochran@proton.me>, "Peter
 Jung" <peterjung1337@gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Don't create attributes when
 registration fails
In-Reply-To: <20240623200918.52104-1-mario.limonciello@amd.com>
References: <20240623200918.52104-1-mario.limonciello@amd.com>
Date: Mon, 24 Jun 2024 10:10:50 +0530
Message-ID: <87h6dj3qct.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a1edb3-e7b2-4ba3-fdac-08dc9407d7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgDuew+8nmNaYLmxN1kyn9zo8+26k5bnNsgJ2EAE8OaKgUke1Dqk8UNsEQsQ?=
 =?us-ascii?Q?8rp9A3MkRH3MmrE+2ZXNqV6j0qx0eBjFpAY6WFWn8Gewmj+LQkgfUG54TPKG?=
 =?us-ascii?Q?EqBhGddp1lwmafBcahviR9g1X/wEnjMl+3xmXqxi8aQf+kFz4n1fQo+rCyiQ?=
 =?us-ascii?Q?ZjAW5IAWHena4F9DllxuLcqOl/KWJEQVxjysIg3fnPG1U7lTb9D6meVj9Vka?=
 =?us-ascii?Q?JTonlQesC6GLw72Cszmi0AhjPs3S1EVvL6bUBBcQyn2rNbOGRfsXTjqmtmko?=
 =?us-ascii?Q?xbJGf6HYYxQ489DQCoEApWRyr4M7Upi6Kk4ob94YaEySs2GdQwC93vdOSiC6?=
 =?us-ascii?Q?ogWx0oKEMjaHUe1kDdMdZYMnOrYxlRJnDr7Or3ex8dsU2yH/rCBY4aU0Ewg5?=
 =?us-ascii?Q?k7QaYlhqjOXqHYbov2iZg/TN9stBHSUDj5HEu7AGqtRkPc5uvLm6cBaEDMFr?=
 =?us-ascii?Q?8Acxzx0MR2G09ezm2ko08F1SJj6y9WYyaxXcPD4apsknUA88NJoRq3qVoy8T?=
 =?us-ascii?Q?kc/pAmjcSx9/sjABbfDUgV2U0/O7MzSlNTBmwVV0ImvquROmC8wn/MPTtCCC?=
 =?us-ascii?Q?nCCaaT7zt4iwumUktPF2MvQAaNCho0nSXbqf8v+T0Hdu8a1rZldWiq+W0KmB?=
 =?us-ascii?Q?IXFt5iLcCWNutq3e54n0PMfckEVlRq4LHWl73rbPVHPZ109F/cSVNOUQZTTX?=
 =?us-ascii?Q?YsRIA7/kDMxWFkBjX+Rl/3kCb/AALm0GfgP95ehhNJpGZIbHcKP9/T48WLVi?=
 =?us-ascii?Q?DSDOf8SIowGCeQECB6zDhJUCuqNB6Dw9qdzcIheEcZASZ32CHDclhTKV4mfI?=
 =?us-ascii?Q?RtY/bqnFWm5CmBXIbvEODKYLi8VPlkXshjJOGLgT0Lf3uW6+r+z++IlnRVvj?=
 =?us-ascii?Q?gDFbiMsZESK8oJWJ4zu+n8d+v/TO3hzKTCTShZ2Hzvs6rRXTVxp9ixoezFLI?=
 =?us-ascii?Q?o5Kvw6lIbSosiSE4qYTWRHgPR8aXUUiG3wy7KRAtejkM6U57ynTMrtTEt4vr?=
 =?us-ascii?Q?N3pv6YgYv560wvH95RKFXm6s967pqr0nXl1hOaG2z0dXr5P8yZfX7BffkN3e?=
 =?us-ascii?Q?yWuFtinfJROFtM8yAJ/kE7fxwY5sxkqKUaURa9QN9Haqpj3pgwsROF0rudY/?=
 =?us-ascii?Q?UlmrBgFJEosl1lABRdIlrLLaERHq6ffZhJa901yTe2qZKpDrkKH79CZAWak/?=
 =?us-ascii?Q?roSgqCGiF8VmYcCjMrEDxauj4ULkmucRGQb2WBhjffNxNwB9rw0m+vcpI6a8?=
 =?us-ascii?Q?s10UUH/5tY/scZ4cg9M0McGIGW7LrIAPoRC/173y3QSyZCW6RSaDSpDzE32D?=
 =?us-ascii?Q?axPsNDbk6X+1bOb3TTjvf9CIVPeA+IjNod7XeIbDzUnW6MJuxwpmTgVGEkbt?=
 =?us-ascii?Q?anfPdErpUTr5tA6em59kKgZwuPmJzkJ1a5wif1wZQHlNlcMGQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 04:40:58.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a1edb3-e7b2-4ba3-fdac-08dc9407d7d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

Mario Limonciello <mario.limonciello@amd.com> writes:

> If driver registration fails then immediately return the failure
> instead of continuing to register attributes.
>
> This fixes issues of falling back from amd-pstate to other drivers
> when cpufreq init has failed for any reason.
>
> Reported-by: alex.s.cochran@proton.me
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for fixing this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
> Cc: Peter Jung <peterjung1337@gmail.com>
>  drivers/cpufreq/amd-pstate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 05e80d2f8803..7195dfa98cc5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2030,8 +2030,10 @@ static int __init amd_pstate_init(void)
>  	}
>  
>  	ret = cpufreq_register_driver(current_pstate_driver);
> -	if (ret)
> +	if (ret) {
>  		pr_err("failed to register with return %d\n", ret);
> +		goto disable_driver;
> +	}
>  
>  	dev_root = bus_get_dev_root(&cpu_subsys);
>  	if (dev_root) {
> @@ -2047,6 +2049,8 @@ static int __init amd_pstate_init(void)
>  
>  global_attr_free:
>  	cpufreq_unregister_driver(current_pstate_driver);
> +disable_driver:
> +	amd_pstate_enable(false);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);
> -- 
> 2.43.0

