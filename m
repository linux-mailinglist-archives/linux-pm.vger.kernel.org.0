Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54E23DE36A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 02:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHCANS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 20:13:18 -0400
Received: from mail-dm3nam07on2055.outbound.protection.outlook.com ([40.107.95.55]:36193
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232311AbhHCANS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Aug 2021 20:13:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V099Tvg9WFCMc3RrC+j48CudR7ng9c4sPgMgdj91eIs2BHI8QgLwSDNmRo8gajJCcJE6kAtFrjcTA//RpzKYwjZbGfrCdcVx719xoabAWpxbtjc8HHqTHeqZotX0hFAqgoyNNFZxX4Qx4aiOXsbtB8DA+dosAuqM7W4rAAsnSb668J2U2Brl8xjybVIWgHaIvZN7Nh+OogdybnsLDwEl7VFnsKMS8bmmM8N3el8IjG/N+jGjPX8slfziuZlGoOItPKKZUBpT5xaRP6xXd+9CuAC8fQdjSYrbSYEZa0lrM3s78IoLSKhop1CsfQzPWZOeb+bA+pejrmDJwjWedMIbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk22+HFw6B0jgEsyWedPFpYUSfH+2q9taCcabLA0S0g=;
 b=Xu+dTMMgtbDORL2gZ78fke1QGkXdfrRQcqDjnillHTf6I9J7f/EIhbMQpayUAnRQUskUjuVoRK5xjeU/z7XXRyWft7JyyBQOc9zFUw11nlddxzFL7RyC4xvRayxZ5anfKvhZMu88RsViF2kgL3hY0UsULeM/4XaPzzDehfYmV0hG1x0lewAtSAj0Hp7VjXVRd4sSWF0E7GTfC3GXJQXetntBaNl1AdvIQdPsN1mZfTkgm0aj7wA/nOA0GS4jVFMCoTcQbENgAJqll/kw5GQ3M8LaLqbIrg3C39/356esodHG94Oosy3FhOEKRYxMRsEWPJXxC0VStm5AuYaMGPlRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk22+HFw6B0jgEsyWedPFpYUSfH+2q9taCcabLA0S0g=;
 b=BanV6wQKD+4EuHVw/0v3pbFLr4xrH9kJXyHR4ijy0/f5/9/hpZcKkJLQWRTv9B5xXHirirV3FYogD1hln0s44LrLaC2lE0BPMBlo073ePHfeoY/lhKMgm9NFmZMqsj2s/YzmF9H6j605iRDR/9rxg41Vl+Hp6fe33tHbH5HezJM=
Received: from DM3PR11CA0008.namprd11.prod.outlook.com (2603:10b6:0:54::18) by
 DM5PR12MB2342.namprd12.prod.outlook.com (2603:10b6:4:ba::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Tue, 3 Aug 2021 00:13:06 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::6e) by DM3PR11CA0008.outlook.office365.com
 (2603:10b6:0:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Tue, 3 Aug 2021 00:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 00:13:05 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 19:13:03 -0500
Date:   Tue, 3 Aug 2021 08:13:39 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: enhance the sequency of governor change
Message-ID: <20210803001339.GG2563957@hr-amd>
References: <20210721101658.9235-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210721101658.9235-1-ray.huang@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61dec347-53bc-4579-95d6-08d956137776
X-MS-TrafficTypeDiagnostic: DM5PR12MB2342:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23422DB43603F142E5C9A221ECF09@DM5PR12MB2342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eo6fHbyCITiNdf1HNLS7pfwjjjL0y36RtU53NeKZ4HVbzlSJa+NaA1nEfR4PwUghFIuE3m0U/fMMAbWirBEshJXl6XoCdAfo/JrsWwLt54o4JknIRuUwizr//EVboOc6w4XZELRyFLleJ6pJT9Xp5s7GkHVHc/2r1oBtll8N6j3UrF3N6iB7Az3EUv2RUOS1i7UCnP92ZITVeTcQK8YLQ46Vdro/CZf3upqZtaX7wpQQdWM6FDe+xnjnsYdEhuKG1I5JKpNuY8MHU0grdX3IufQK2CsD2jFUpT4GQIb1nuznrgiHQNsTfFQADogSTo6vSrc4bYBMRT3EUvhAYC0qoBzMbo354II22h+rmfY2ZEoVRraUztjmmxZNH0/ztVMCR26r4lyvN/vP8OLXXcl4eS9W7mKFAUR9qviz20fDfMyleD7e6IPaaUSjjN+wpsUaC8JCIy1/QGo4kmE4MNFDn8/bn6lucdNO+C6DZ8gJV6D15KuLIxetYAidonptq6unp0oTLgSasaPytTHtYT1PPXf08tg3pfzuS4oNygYXNuR3R3rolxrI5HnQe/EuoPnfGBw6VtcCWnRux2Dq6GnETSO+EMvRDcE4PYH+rubU3MYyZz2JoELf0qCMwaLgJ6UGoMCPxEybJQgShUKYNgTZc5cyvWOO3Y80VQ5ixBNtVLejxUMrcJI5pINSXQd6fq0aS1u/SW0s3LhHka2it1LA8qelHXY0vTEhSanQ0PqwWgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(6666004)(8676002)(8936002)(33656002)(82310400003)(110136005)(336012)(26005)(9686003)(70206006)(70586007)(55016002)(81166007)(316002)(83380400001)(33716001)(86362001)(426003)(36860700001)(5660300002)(47076005)(478600001)(186003)(1076003)(356005)(2906002)(82740400003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 00:13:05.6894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dec347-53bc-4579-95d6-08d956137776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ping~

On Wed, Jul 21, 2021 at 06:16:58PM +0800, Huang, Ray wrote:
> Keep the "success" case of governor change in the mainline of the
> function not in "if" case. And using restart_old_gov flag to indicate
> the fallback case to old governor. This is more readable and no function
> change.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc925b2a..4f7005ddb70c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2545,18 +2545,25 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	/* start new governor */
>  	policy->governor = new_gov;
>  	ret = cpufreq_init_governor(policy);
> -	if (!ret) {
> -		ret = cpufreq_start_governor(policy);
> -		if (!ret) {
> -			pr_debug("governor change\n");
> -			sched_cpufreq_governor_change(policy, old_gov);
> -			return 0;
> -		}
> +	if (ret)
> +		goto restart_old_gov;
> +
> +	ret = cpufreq_start_governor(policy);
> +	if (ret) {
>  		cpufreq_exit_governor(policy);
> +		goto restart_old_gov;
>  	}
>  
> +	pr_debug("governor change\n");
> +
> +	sched_cpufreq_governor_change(policy, old_gov);
> +
> +	return 0;
> +
> +restart_old_gov:
>  	/* new governor failed, so re-start old one */
> -	pr_debug("starting governor %s failed\n", policy->governor->name);
> +	pr_debug("starting governor %s failed\n",
> +		 policy->governor->name);
>  	if (old_gov) {
>  		policy->governor = old_gov;
>  		if (cpufreq_init_governor(policy))
> -- 
> 2.25.1
> 
