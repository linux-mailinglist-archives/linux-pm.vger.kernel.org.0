Return-Path: <linux-pm+bounces-9942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01279166E6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55388284BB6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD214B959;
	Tue, 25 Jun 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fCRXS32B"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392B14A4F0
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317044; cv=fail; b=b6TCofio1BkohXXMrbFATtnSNRZCNIZluRbZKGC6xGDMQFjwAok4JC5YeQQC4aZ1WAZy42H2C0IZAihhPJa4rbONymZwtsfkP+eLbempaoi0UgjziScunWyPeMcMQRbpfBGQ9jm8F8xYIQBl2tSNTsHvKg25Qk5H+jEvdO3J48s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317044; c=relaxed/simple;
	bh=ZXv/h61rZpfNTuEW+/YbPaWChtYr0Ge4s9UG5nheSdU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=taLZ5PeXkTX1SjBEaQFCBcTXm6ZScflcigpmGo5q/BMhy9yYPkzLWOL7Xg4Jnkr/ihFa78y/EBbr7g7iynRYV2m9TEzcQO+fJPdLpdI2tcO1NOuY9OpwmW9mg4fdZzVPi20p7+dKjNW2B9wE+zT8q5K6IZzo1j2bncXn5JDDHXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fCRXS32B; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBLcNXG8Ccb8pc5Gag4q+rHvGebclJ19dqPuy26ff0US3UXYcrEO8RjV8SUDUdQAonvDoFCXn3kxt0BPkMPARwwwjdhOwczP79WT/IR/lqm9FWB/SHAG0jDxDd6YdnhsKzO+pUm7X6aCcX3xv7mx87HHCWpq6eqemggW+D2BajjSi8VTfFPv/DrmVc7c8Vzt/k73EEPFCEOFnq7HkKZOfJCSniKv06yBN+8Kyv5FooIk3zAbxu2m8S1SOG3AIQr0NTrRW1a05AXkfoyhPX+2rdO7Da7DlO3dg8/kACeLaN2C6CRK4NZRomkVzeIdNr/4KvemvMG9XNbm6sJ41+VQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL4NDFWvfRNlbSuJTo4CS23yw96OBkvLeCv72BtnOK4=;
 b=HdlSAtCdojmZAulthzHQ+v1b4EaxK3rE16f8eD1BomK+1cp4SGSNCIZQMtDMdpp9VtUofpxEzPWBVbXYIpK663YjJglw8f2T/NB9Rq5gZOCuiNJLbf05v/y0Ueq23H9mNpFamxdtHZur92lojet3cGZQ8B9pPpu/KcvSSzi5g7tqAt1EgMsPU8BDnMKjUHJ1INieQgmMeZb8iaNsp0wbWEodE9dNmM+LtVURcljrVL7HlUqiAmMlZqr2cX4L3GO3xAKZ5YhT9yUU5uGAd63ATaj0+7+q13X3N5DrLqfqWB66lO4dHW5AXMeiMWviMwIzYLVESQB/8/wM0uzrV+CXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL4NDFWvfRNlbSuJTo4CS23yw96OBkvLeCv72BtnOK4=;
 b=fCRXS32BExfA/SnBSuA7knFDInzROUNZFNCCaeZHJBQyFajAAUvYQsPIP4ShGf2yibXgeLndv07NeBmv1aTOglB2uA4l5kAUYk6DPkPSQln/GiA3GwRj70W4kFmO3flMcOQdPo59625sRv+NNS+Scw4AZ3dxuXKcWq4M+DR2xDU=
Received: from PH8PR22CA0007.namprd22.prod.outlook.com (2603:10b6:510:2d1::12)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 12:03:56 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::f6) by PH8PR22CA0007.outlook.office365.com
 (2603:10b6:510:2d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.39 via Frontend
 Transport; Tue, 25 Jun 2024 12:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 12:03:55 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 07:03:53 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: Re: [PATCH v14 4/5] Documentation: cpufreq: amd-pstate: update doc
 for Per CPU boost control method
In-Reply-To: <20240624213400.67773-5-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-5-mario.limonciello@amd.com>
Date: Tue, 25 Jun 2024 17:33:51 +0530
Message-ID: <8734p12pqw.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cacaab-7809-44ee-4b0e-08dc950ee38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BP9HFBqcVExjL5PLbDvPLfu7n65ybVXcLi0aw28/++XMM+Pc+5u0RHykETVD?=
 =?us-ascii?Q?ZZNjrZQTisG7BcxjjIPGBT8kDr8pNCdLb4nNeHP+l3aYQFes1GkXG/DoZdvi?=
 =?us-ascii?Q?jiQokT+N8QkendHMC0p3LUdBUDqyZMlm7F4zqSP3Xs9YmFuWbK8Y/6ooFugp?=
 =?us-ascii?Q?j/FFFE3byQitmCvsqZ/keEknx6+jbSydKy8SOXve/tKqEcO/dAESQ5ySk96d?=
 =?us-ascii?Q?HHqTcTH0p0d50JZ5eyZQgyb3NqyR2eRQZ6eoeopFb97EN60hpT0UStXCLfnS?=
 =?us-ascii?Q?48eZtiD39Lphs0wViCaFSkVcU7OigB5Fl7n/eNZ3ldq5jHwtfEdYB+vUcuUV?=
 =?us-ascii?Q?7QKYYNWohQHzHkKVJ7SvHkQaabFdemRVJdLEFtgvKT3SfX0f5UU6wLjA5H6m?=
 =?us-ascii?Q?37RpAm8rksLJcXSKHsQLzmR7TF2DCn79HcNiv9pXB1aAtaBRQnD+lSaBBubu?=
 =?us-ascii?Q?7VdZdYhzSBv9MSihAnmBxJBFDvyAPbCOGDtSZWALtifkjlsji4L10S8/rMvf?=
 =?us-ascii?Q?MbzJcOTw9DLB1MM2Fy55hp21YyzU7yEZdM+vSRqyXB2Sj3yuT/ofV6hfkqsq?=
 =?us-ascii?Q?K7tM7NW6HRp6fi4qINn8VbWRee2nVic0l6KHRV4kOfdetptFY43xpm5nUVVn?=
 =?us-ascii?Q?ARRY4gxflFcRY+WbOHy7SadGpD/+Sr3VbOz8r8OKStFCsgsMnFfSVkV0Pb3u?=
 =?us-ascii?Q?DvdQ8lavg8K/wJ4jGuxgnwZ6ZuP7uFWKYoEhBa1Y8veTLlQg3i/q9PdbtIOl?=
 =?us-ascii?Q?LEqCnikmrLIRjLN4MFCJupPufpmI+l/Qoxur445R7VO05NjYImhYoQPX6J+L?=
 =?us-ascii?Q?tth32sZbDhzVJIfyulGa/WB3ODTwbtTFNZEjHizrDgKQi5DEhZpG7XnjFQTM?=
 =?us-ascii?Q?iqAdEeWyR0ty/Ri19RRIQtWLNt93C711CHLML+qYniHapKPva4MRRly4VQk6?=
 =?us-ascii?Q?AU9QH91tGRC3UODiqdaZDXgJrpWUwmQDHTe+jtUXGzcZ490z0PxJL4S56GKO?=
 =?us-ascii?Q?jVukm1yA1xL0UDVonAy7/SjwWKA8nb7Vt78E3cubuORr9Q8OU6Pd/lkRaPGH?=
 =?us-ascii?Q?ygVgTWhTPrnDEjNJLQ+clZUxQu5hI2VBC9vSl1GqrnDLfaIp8I57vYRDz1SB?=
 =?us-ascii?Q?EDvs6w7laDTsxU55l5ETikM0O0pfqi7V4RLDHMOWrB3o6Ri25mPJYsONu85+?=
 =?us-ascii?Q?S6vkyHol2sWlqhBRM3WkmuooGuw4t3kXeyoo/YkmMQJTX7Uc0/BLnHTcqYSV?=
 =?us-ascii?Q?gCA3C7PlaRyRcmlFQMDPCJxxvfLH5/HaWS4RcKfc1gTt5Qv05r/37aRjxJJB?=
 =?us-ascii?Q?p3HL7Xw7DDnGnmpv2tgtKw60V4GrfftZMoTyU7ZyHRzPBegz1wUtsIDQei4j?=
 =?us-ascii?Q?T9QyPHaDCLdMOzw0iUF8//hLhvK5gwlHcCu/oOva3jkvz2Pp8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:03:55.8558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cacaab-7809-44ee-4b0e-08dc950ee38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764

Mario Limonciello <mario.limonciello@amd.com> writes:

> From: Perry Yuan <perry.yuan@amd.com>
>
> Updates the documentation in `amd-pstate.rst` to include information about
> the per CPU boost control feature. Users can now enable or disable the
> Core Performance Boost (CPB) feature on individual CPUs using the `boost`
> sysfs attribute.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>


LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index f5ee81419a93..d0324d44f548 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -281,6 +281,22 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
>  firmware, if EPP feature is disabled, driver will ignore the written value
>  This attribute is read-write.
>  
> +``boost``
> +The `boost` sysfs attribute provides control over the CPU core
> +performance boost, allowing users to manage the maximum frequency limitation
> +of the CPU. This attribute can be used to enable or disable the boost feature
> +on individual CPUs.
> +
> +When the boost feature is enabled, the CPU can dynamically increase its frequency
> +beyond the base frequency, providing enhanced performance for demanding workloads.
> +On the other hand, disabling the boost feature restricts the CPU to operate at the
> +base frequency, which may be desirable in certain scenarios to prioritize power
> +efficiency or manage temperature.
> +
> +To manipulate the `boost` attribute, users can write a value of `0` to disable the
> +boost or `1` to enable it, for the respective CPU using the sysfs path
> +`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
> +
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  
> -- 
> 2.43.0

