Return-Path: <linux-pm+bounces-9726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA6911A77
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1263EB212BE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66112D1FF;
	Fri, 21 Jun 2024 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xqVv+mUz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD712C481;
	Fri, 21 Jun 2024 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948365; cv=fail; b=NvEX70PBqwyf4X+QLYXekhCPz67ISXQYUlreb81OdjO3w1eMoXX+KPSSp88CRuTEouErx60v+Cq4ILfE/59nVB76XH2le1qNCK7ZM5SJ/ZUcXkuSU+XX9sUzg0Fg0Y5vKllnba5WYBjgwwiXTgK9WlTPAFP31ZnXddUpySD3mBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948365; c=relaxed/simple;
	bh=trgFK9aN2D9jOldNyCFVCEt4c/0vnUrQNcuKC5w/pao=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9y6K5HL7xviJ2IpIopMUOdck32zMwkE36oolOcfw1R9atBTinKiqvYCM8hnRYUn1TEcr69do/6HJazA4ETpGeAPPF9N7BNGdfVuDHO86idLg78whNkCefnP6XHXbzKm3Fa6l8zFRhafoSa4wa5w1Ybw9Tld1rh7QzCHzXMxBEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xqVv+mUz; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HockuYua8oJ2iVu8XSd1jBUKdyZsvJQEzDvAXf5j3XosmzUaOqChf9duzklyh4trfVJuGEGfYCUGflazlLag9xjSG0EN7g7Lb0yhEam2f0VyOlB1EXOyO11/W0vzldyZarU3VIidpDse/pbzWmI6GH0cL5cLegeunQZcRlUs6D8+gRLVSb5ywhquDggYxQ+v1c0FRP6S5tXkSQRkJXbeSanYqeCvQfCFvoXvx+6rIuA0NtIsMzkLKr/GAgotvR2boWeX8ObtaLZ1pBl1NrmTwBYLQ3l5SD7TubV6Y8ujkmnF7SarW9i5wlF/x2tayo7Jwe9KU1D8aus+UGHeTiU4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AH4e40hZiGECfjoel+VgjnhrRawPzcaAgBE40GmfJI=;
 b=aG86KjunojYMPHlhtoCG5K6lq7Qcc44xI1xh2Vknk7/ejmfAh1IFHOu3zuNGlSqvluFEU4/byrUqcom87X9cjLD55ypsl2OdFxVODG7YK1/LHH2liwKfcynIduJ+R0LlfFJ/ibvmNc83EBJ+ASj0QTggUidt7MTiCZsPORH9CHxKiFjLcxVL2XymcdL5T0Kr4xG/LcGiv4aTOpYw+tryHoM6Y23dXLnEkQmi1Wv/fa+Tw0e5h/GoKBifBxiJKahwvGSV1XkfwdPhoIDwgWFieMqWCdpC31Ekk1WUfYHK20q41ouy8XbiZ8PACQFGTwvUkrHGuARHw/s0Y3xmHLRh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AH4e40hZiGECfjoel+VgjnhrRawPzcaAgBE40GmfJI=;
 b=xqVv+mUz+f0gwmNp3c19KnRZ5SYWfblIZS+olYV/z7b9WURGBYqNhfR8JsV5d7AwT8ceeIKwzC8pNJTqwQ/nmuXKzLNY9byLQjeEtwRe5YPT/zFi9GCCKE7i9womPbT72SD9YSKTUWziscbCMcoYSmjWcQdL8Ss+IC8on4rUzlo=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 21 Jun
 2024 05:39:19 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::2d) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 05:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 05:39:18 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 00:39:14 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <rafael.j.wysocki@intel.com>,
	<Mario.Limonciello@amd.com>, <viresh.kumar@linaro.org>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
In-Reply-To: <851f4e8b2495f35f2ee1e848844dbaabb55411f4.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <851f4e8b2495f35f2ee1e848844dbaabb55411f4.1718787627.git.perry.yuan@amd.com>
Date: Fri, 21 Jun 2024 11:09:12 +0530
Message-ID: <87le2yvoqn.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: b9666c67-2814-44e9-44cd-08dc91b47e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6zJauDD3kgCe/vZH94d4jZoA142WsR1WquvZ7e2qDgvAGT5S+aIZRN20vcZD?=
 =?us-ascii?Q?XfqU9h+RF57/eJqxZrniYzsd0BW1s0IF0TsPqJ25tcjJfbNpCiTGGKKFIIHk?=
 =?us-ascii?Q?IeGHAKF8oSH7BxkiumVWoluYnI2JjCVD2Q+csR7VNS9+NEA0obcG9GDpOzqA?=
 =?us-ascii?Q?lkdWS4Yy/ICOTk1wlrhLhRmb9qWDGiTEVY/EqmfqR1jM+ugjRQFw7xE6BOpD?=
 =?us-ascii?Q?mVEisLRH7zfBb26XHL7oiGBaXRI3K1U+JqK4NsLFlDNevr7mMiFB6vpu0VVQ?=
 =?us-ascii?Q?PQkFTHDGvm+eWhPRSYe9XU26pXgc0bH9+htJGGbSmYJx32mwYhlEpcUHh++h?=
 =?us-ascii?Q?l6brZXGirdrdeVtW56jn8xRVnUvtQzS40ColqaeJYb/Xn53OJVXd9eQr4bg8?=
 =?us-ascii?Q?4wPYNC0Ab2d12Hc97E+7By9V/ps+kfZ8c9wD79XO4EoBjRqbxFi5rPKaTemc?=
 =?us-ascii?Q?HDGUff9YCy8S4hGgyUQ6n26K6VnjFLWU9pIPuh919dBWmcQgBTj6CGait0oa?=
 =?us-ascii?Q?Ho9SKVz2hwRxvADbRXpSb4lD6JMg2B2ez6lIaWZfnG4ZoHfoLzcjYVL1Whql?=
 =?us-ascii?Q?qJfPHWr3TroMPBu1Bw8QRzsCcsoKKK2Whw81+Ku6koPsnnU5RWkEaWCE+xEx?=
 =?us-ascii?Q?dpVuZhgwmkFFRnzpcoqrMX/GUNMqeKAkPo0EkFgGnJ9SnBpVWBQUbGL/TYyx?=
 =?us-ascii?Q?aQ6GuNIX0Fd0NdwiGHEmh5B9h6g53lS8c+majN+rTaLQ7odK5ovit62FQSOb?=
 =?us-ascii?Q?Lwwqb/943JoVogPS1WV1hOIjNVEh0AEP/jK1QB6VUNiNILN8YaAoplFkZnyi?=
 =?us-ascii?Q?l1iO5yzjNjlZyCubChh9VBELq/7Cw8tP/B4s4zay8QJwKCeCbvIQQQWvif23?=
 =?us-ascii?Q?7m7BPLpAuJDi6SDL3LxSY2qaGNWwq5qNOku0S/+r+3CiOdJIEGSSeTMHIiSc?=
 =?us-ascii?Q?X3DtUjcczmtnHbRptKWjdLb5Adv4/Bpd8lO6e5uBTF4S/Q/cxlv8Udm8Ib8q?=
 =?us-ascii?Q?39Sav1d8c5iqX5gvNMJxRUIWuA+zMioAvDgpAl09vtEEj90Zg0pkC7ne/dob?=
 =?us-ascii?Q?pvmOoElzpi+j1E1r79PbBCQ5i46K/EF7S1OWo2X9I7rmz6361Tb62ud2VTVy?=
 =?us-ascii?Q?etcgvlSdH4f487oxRbQAggJG1Gt4a7MRFPENRqC+cV00d9d+lrl1wFqeIarq?=
 =?us-ascii?Q?F2qYTr7xlikKqLE1N3AuyE3Vx3UEfWikQNJUGGPZY6GXgWFaVbnMVlTuwlvW?=
 =?us-ascii?Q?i9uynsDcmKhOTF6xlwWnx+xbXpyMPpTKZBBMIE5qIboYMzBgxHGh3+9mlccM?=
 =?us-ascii?Q?QIKxwJ+SN48oA1t9jRc6PXmCPv28F069JkohqrDenMm4KmIzAgfDBkfLuqwR?=
 =?us-ascii?Q?9Ivigery0t55afRIU7YOqGLbmD/NLJ0DGrQYaTNb6gtfx+rqGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:39:18.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9666c67-2814-44e9-44cd-08dc91b47e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843

Perry Yuan <perry.yuan@amd.com> writes:

> Add support for the set_boost callback in the active mode driver to
> enable boost control via the cpufreq core. This ensures a consistent
> boost control interface across all pstate modes, including passive
> mode, guided mode, and active mode.
>
> With this addition, all three pstate modes can support the same boost
> control interface with unique interface and global CPB control. Each
> CPU also supports individual boost control, allowing global CPB to
> change all cores' boost states simultaneously. Specific CPUs can
> update their boost states separately, ensuring all cores' boost
> states are synchronized.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>


Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

With this patch, is there any specific reason why we still need
/sys/devices/system/cpu/amd_pstate/boost_enable ?


> ---
>  drivers/cpufreq/amd-pstate.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1c2320808ae1..299e52d4b17e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -699,20 +699,11 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -ENOTSUPP;
>  	}
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_cpu_boost(policy->cpu, state);
> +	mutex_unlock(&amd_pstate_driver_lock);
>  
> -	if (state)
> -		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> -
> -	policy->max = policy->cpuinfo.max_freq;
> -
> -	ret = freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
> @@ -1868,6 +1859,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.resume		= amd_pstate_epp_resume,
>  	.update_limits	= amd_pstate_update_limits,
>  	.init_boost	= amd_pstate_init_boost,
> +	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> -- 
> 2.34.1

--
Thanks and Regards
gautham.

