Return-Path: <linux-pm+bounces-10013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406191780B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9663AB21B9A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B35813D635;
	Wed, 26 Jun 2024 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZPwu7FTX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F328DDF;
	Wed, 26 Jun 2024 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379485; cv=fail; b=DCB8LRRzq7NXSQDL62BXARbhxtRnE4IIoebeVuH1GrxMoME8Xtefn8LOm5kFMdMRF8DUF7sQjUjmXDpWq8TiPIcQSjxey/EDeENExz0ZYR3GiSDVw1QHuT+mEW0AC6YC/y4qHOrj+jHMniy2mZgLEkx3Els3S3+Gtr6NSEv+MWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379485; c=relaxed/simple;
	bh=Fx3RvdhPGt90n+fvWjJX5+oFIxsuLuq/IW6urXHXK5s=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbNPzGe4ymEV6tm3wastu9R+hs2reTXkIR9kwInE8a9dCLp7ByZRzIrUJQd+58Wdd50uoNYXChqGTzpY1OuTPiYGYe1Jpvj7HPTzEKco6CvEgeWikNQnQYatpWAVyo54AJKjOWqC3cPErT6wjdDe58v6ZFN0rrgKFkdIyv1I1Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZPwu7FTX; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho3vdh4FVdOj6jPOtxknVerY0XNJuCTDcR9OY9sTvPCHe29rvjde4cVkq2VoywXtTX2YF+HhIwAazGjoEWT1dzDIJ0oZgzWGnJN/VEqYCgmx/4a4w/wc2/izR8kHwNaakukCxVuZMn5lHlqhMcAQ1jdZpkOTbycsYEHIBje5WirlomEwcSi4F+TOb34r1sO7ZRmmvXhkCk6bUArXdUzWCJI6xCYHLdJpU1iJTQGkLrpRw7Jd5hijwWUewLGt/HGZG1RHVCpwwU6zakqrc3PLN9u/RyjXgxkJj7hLp9yG4iTjHvmDUodGySd+bJJcNUjhg/SLaAHIxuZUGye9SIQqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA9hQSywSGLwEa03hGMf/DMtS55MTbWx2DPfavkHOE4=;
 b=TyJ4AWsbXit2IKV1gztm+TLbRFnNQJi5KKtkQfxtbOAx69WIP4b1kNuT/QhdGu/V10t8qbCXmiWao2lZYxWJR19C+segSSHERk8bYNcqSf/1H0jk+YzuOBzgO/d85rjeWhnxfzepfZMp4UPT1WfkwhIzm3JQmIcCJ8yoxbS5aWI5OSYMEZK3zSgO1QrCik/sc48d5gxqaHBz9xpHmgD1RkfzfSMoPKBOdc4i/blX+UYgiqa9jFUvxDiPy1+n4OiO/etu+s/gK74/WeV+cyZbamu18cC/hQekIT7ZKt5ikoIPGoYlqOXS6ZuFtkZc1kIbMdiiHtNi22P+Ba6fzkFMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA9hQSywSGLwEa03hGMf/DMtS55MTbWx2DPfavkHOE4=;
 b=ZPwu7FTXjEI9xMBaM7czJqiXWrerrCwOlMUQjHgWuCP0srnYuORLbGxHE90o2c9/rowzeaw6CNO8NpSqeXRJ97NHPGgnKEP2X+BAEand21XMCggALBaYgLM1bDqzHXBvKPeXs3e0fd49/Nll+PSxBQC2psFxBr7i84VbqMAf05o=
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 05:24:41 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::73) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 05:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 05:24:40 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 00:24:36 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, <darcari@redhat.com>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Fix the scaling_min/max_freq
 setting on shared memory CPPC systems
In-Reply-To: <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
Date: Wed, 26 Jun 2024 10:54:34 +0530
Message-ID: <8734p02s4t.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 591c7380-d3ac-485b-1ba7-08dc95a04797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|376012|1800799022|36860700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pigCBzSCZWiqljFb94WxEPNNl9SXifUR11QUe6DxmX9JYSoXgNoyXg75juTP?=
 =?us-ascii?Q?kSdoro3jbhQLXuTWXt5ILoPvfWE341nBsjn4jU4K6svNoeRaeFrH+c5KGZWB?=
 =?us-ascii?Q?Xv7C56WYIuMoomIFR58l/lm3dMpS42+B95hnIZStXRlyZyQE/8SwoWKJ+0ER?=
 =?us-ascii?Q?7OYXNja4PiqY/ikowquDGz2TAuM/3pKy5XeIq+UCdmPq+pNWEdzmh42u0nt/?=
 =?us-ascii?Q?jmhbImp68p/Ppwiob9Nq62XeKg62UXNOCmV2GXAO1N7p1vCrujMg1m1XkmCU?=
 =?us-ascii?Q?6Q6lyydc398O7t8JOwWr/86a331M/CyVjfhuaAD3shMiQY77nslc+H/9Hklr?=
 =?us-ascii?Q?5E3cTJLlG1s0TZANTQrfkjjcech9eaHkc5oq4uw7r8VGZ1kl6bH0KtSxeGiR?=
 =?us-ascii?Q?AT8GzKRZHpWoKCGE6fJ68e5rDGyS5U0wWq3hdjAp9si8gRZkFH3GF1I9hfS/?=
 =?us-ascii?Q?7LlhPm956icU0sePeRnpwSkjdN1JpU1pNNsEGP8QydamuJgkcRomwUiR7bPc?=
 =?us-ascii?Q?4z3Gy5MxcZVs37SOH7aP5lfWQndftD3tjJbBqamiMtzj23bwUO9XgJuMHGWE?=
 =?us-ascii?Q?tYAuQv/mh7MUIftWX8YG9Okv/K0HVAcJ6dZa+0gim5xQW/bDZp+uTNBPFESH?=
 =?us-ascii?Q?SdnESFV8Yq7eTTEJekEs2ilCuhC/VhLbaEA/hYAg2cZKTxP1ztwZDNBhtobP?=
 =?us-ascii?Q?YNgavOrBAjG7xTL0+7Ir6gskfI7ADWHhCicGZx0N+LCIG6QGws4Y4wIZXiMs?=
 =?us-ascii?Q?Mv0rbTVGv0LIm9mc7btnjX7I4d9k5B7AlG3OPKUJ9lzeRB7XyC41Yif/eMiK?=
 =?us-ascii?Q?dVmoHro87x2wtrFvGlElMqWxb4RPUabywWMjiwIOSaFzLbHZDGb4dE8pbPjJ?=
 =?us-ascii?Q?lqk/jmhxP44VZ9LwrpRu1HXtsXJWgicT5K4E2V4pktUQvL3BhEqyfbp70hFP?=
 =?us-ascii?Q?/4VpTF5WyhhgpCk2KMYnLCq+1w1dxJtVsyCV2dFyJg/eUDpK8xvsr1yC0608?=
 =?us-ascii?Q?UDF5y8vGADH/WbkQ5DNekBM3+qmkKLS8M986b6Cn6b/FC3WfLaoHOTMyl53t?=
 =?us-ascii?Q?cUaWt0o9Ql6b+u4QlGJ2ujAgOK++q+9maVHPuoRKLQ5IGj4wer2Ihwiuovgj?=
 =?us-ascii?Q?qBvG1UMDqVliJaZHsdRhG0eKDqYLImfFu6SoQ9rn7admQXzeKJSQq4Cc17yF?=
 =?us-ascii?Q?PPuMthVfVkFx2gCOxiEaf8Grd6yeuyAHfOYoFX2cyS+gHtajgonRWgsa6yzj?=
 =?us-ascii?Q?LupTjrvYCdu7jI//17SmYenm6p2zLKenZvMg3EaiQJOcpN/Epj2ysMppVXxE?=
 =?us-ascii?Q?6+v9/xx7tGAs7rCmsCWTYe8WRyMxu4mImqJNGGLQaoxR8dwXFgwC/cUA5Ipn?=
 =?us-ascii?Q?h0cAwNVA/LE6JWjHbjEWLGyk1In8XUG4xLxOBcC3oPeMPb313bpXFvCK2ACs?=
 =?us-ascii?Q?9NPDzeuJTAE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(82310400024)(376012)(1800799022)(36860700011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:24:40.6596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 591c7380-d3ac-485b-1ba7-08dc95a04797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> writes:

> On shared memory CPPC systems, with amd_pstate=active mode, the change
> in scaling_min/max_freq doesn't get written to the shared memory
> region. Due to this, the writes to the scaling_min/max_freq sysfs file
> don't take effect. Fix this by propagating the scaling_min/max_freq
> changes to the shared memory region.
>
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Please add the following in your v2:

Reported-by: David Arcari <darcari@redhat.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ad62dbe8bfb..7c1c96abe5bd 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -264,6 +264,15 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  			cpudata->epp_cached = epp;
>  	} else {
>  		perf_ctrls.energy_perf = epp;
> +		perf_ctrls.max_perf = cpudata->max_limit_perf;
> +		perf_ctrls.min_perf = cpudata->min_limit_perf;
> +		perf_ctrls.desired_perf = 0U;
> +
> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +		if (ret) {
> +			pr_debug("failed to set min max limits (%d)\n", ret);
> +			return ret;
> +		}
>  		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>  		if (ret) {
>  			pr_debug("failed to set energy perf value (%d)\n", ret);
> @@ -1547,6 +1556,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	}
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
>  	amd_pstate_set_epp(cpudata, epp);
>  }
>  
> -- 

--
Thanks and Regards
gautham.

