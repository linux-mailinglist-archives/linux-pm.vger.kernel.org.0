Return-Path: <linux-pm+bounces-16474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FB9B09DE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D56C1C22ADE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A0189B9C;
	Fri, 25 Oct 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RuifxMa5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612E70819;
	Fri, 25 Oct 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873510; cv=fail; b=sYtwtxPGdimYZN5l2NVns3UaQRjxDyclHyb60UCwfkD7ETMfxVAqNWF+2ooptP9pBAVXwB+8v6gx77Rgoin6K5X4fIxn49/7+9Lhhg7J69B3g4mwsrbq23A8GhrFWXp4LzdCPYIfrgRUp2WxRunO2RqNaXLyhjbm+KiVKtZP34o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873510; c=relaxed/simple;
	bh=PYgME071D/UCHNCeLLWwAk0nEy6WklS6iDft1c7A+LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMdTzcj7snqVL8F0DOVJLfX0yO4Mecu2Ch88Sn7gBmzkpT+ky9wEuQmw3X7bjjtGA8G6O2tZHlWHq8KIfL6MBSTKQFAc3TBLjfpjyWLdqyhzGPYLYxc48p4wRkz4hyUas1G5nk6ObWqSwLVrutb2taVQRp2jlIfgbfjKIwbsuGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RuifxMa5; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgQepzGlFl1p8aSxBdi0xul8UvWprik3CSRqxB/MoTSqolTVNsmqIhN0v0mCcGOWZaUDMfK4PdL9jXCewfsPIqt83vS/+JGsTtf66llVA49EOK0SN1+zl37by+sccbD4bZyJWFCSST8Rm1WAvVKFg8to8TAW4YC8kvN6SsQSfuXTCo1ggAOfUrxDsS4ztqTasLuBNeARy97uazQ8w4WP14957KaUDu+cLQyAe12H1uDZMSi/YS23PBtw9aNsk0WWgSxN50/8Uw+1sQAq7gf3MC2F7nX7Cbul9CzhnL3Y0pizwZJEk2iS8OT30sgW1MgMT2R5OncreSXuBlSB/pTfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpl5Z0RUqB+CgkFqkwx3hPIYTzl5ACkXch0iVQGMDYI=;
 b=BkRSrp39ab+ZYi6czsjdlSJVtmDKpiM+due/EAVgTaTO2Sb4LArnly7K/ly2XGupz1mL5LLNW6O/7/2gvg5IUAOtYpWkv2Wl8BXZCC+weuZ24V7duWjXODiliEz0TAFGYaPPDoFddTMHfxGPsagBUQUr54b5ZX4RVTe3X+vH8GFoiDl7+Mfslzm9wZqQxB2ZCEr/zRvottaO9M10EXxWSg/AIxRjccQrOwUBUmmru6hfW4uLs+oS2Arp8xCfXNZ+ZC+6LMZ/Uo8uUD6QF9aZlAv0SYQIGLpxnqxHnSBz2IbPFB+wtJZytq5HrpiqqMXsbTqnb0+I925D08F5vG7TFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpl5Z0RUqB+CgkFqkwx3hPIYTzl5ACkXch0iVQGMDYI=;
 b=RuifxMa5B6k7IjYCjK8XuumtzUsyGi4nPq/xK4f8n4r7YgMYAHhp0fwt9tAE+zMdys7BwISufbzrDFvG0PiTkttzBY5KJBoFYeRdMloWu0l7QGjdh2THRRdo7TMmbZ65QbvoZ92UDmC2DOPvx2rKZ3yGpQkX6LE9BdPgmfzYrn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 16:25:02 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 16:25:02 +0000
Date: Fri, 25 Oct 2024 21:54:54 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] cpufreq/amd-pstate: Call cppc_set_epp_perf in the
 reenable function
Message-ID: <ZxvGViueBBbS5I1Q@BLRRASHENOY1.amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
 <20241023102108.5980-4-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023102108.5980-4-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 5daac087-09d3-4d0e-363f-08dcf511938f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65hvlwYxI2xk9nfoc2LTr91zNbb3Vcd9G1MjDdPjsehhhhw6Oirdo0pPYFwA?=
 =?us-ascii?Q?lB7ZTIsqy/MBQMnUFtCWE2uz+4y2RJXDM5zum//n+7UOqvpOcuQojtjJIonf?=
 =?us-ascii?Q?aoC/lM7vmHdJSnAxuqg0j6ACHUHbJ4LMkLftK5V+Wq2VHR9fW7pwQA/Iicn2?=
 =?us-ascii?Q?Jtuq8qqQttoxoqbr7oPmexyNXvfn/aFwqmtGNvHoWexv0yNGIjt6lPOBxC4p?=
 =?us-ascii?Q?CgFKwEyZYFDmYkrb0OlxbAl8LfSLk7pMkFUvTe6Svl84kp8SRLkPV4PoYsZY?=
 =?us-ascii?Q?2kpv89I+4nRfi/9wRdOei1c69RjlVXt8zy3FK87Kvv4iW+ody1wUtK4k5re9?=
 =?us-ascii?Q?6s+VAmkTA0Sht7MPx0ZhXFWTTIcQLn+PubMeU9EJIhtv8zOvy0n3lVCCtYpw?=
 =?us-ascii?Q?/Z07nPtuVnj1iNZa4srZvJjEtnFj48yB99beL9rDQsY8tC5uLvEfyYH39GsR?=
 =?us-ascii?Q?GVfumery5yR7Tb1O2HGJmR85/lQSkE7konvQbv/a4tyZUgSX6OpuHT0VkjZW?=
 =?us-ascii?Q?G/VYgc4Tgsinfo1G23I/cIkUerWUl1Z1ksYUYq89wSBglVDXMQSF5J1Fwj04?=
 =?us-ascii?Q?+whn1pRyjyMd0rukzTrK5vkZ+Jxt54/ln/EjTsV0yORm2/X3ccaWulQ7XQTf?=
 =?us-ascii?Q?2kw97IE7B0a2Yy/dYeh/cgC6mDJVtX6prHk4EoS42TAk07IlZsWW6VXe7qzV?=
 =?us-ascii?Q?NMMt2xwaWMFeVq5DcU62xVmGmfRAgtMbO9QLjJoI082OL5ncNCahRzpGaovS?=
 =?us-ascii?Q?yf8P0SxTVEwTbG0NjepaBKHG7itie2leRi8vQCZ2lvQg3GOcRg2LiJ7uVOR/?=
 =?us-ascii?Q?EZ71Macq31NiYN+fywI0PF/+F4/y18b6kYc0SFZuifAlZDv6A7hl74pkaYiH?=
 =?us-ascii?Q?hMe/W5cnW9FFSHGNKckBjoFluXc3b3LEyUbvWaij7ztAIAactEf9p3WoUIok?=
 =?us-ascii?Q?261AU4DvJQkYjEJ2JynASLdGoMpevlJvo2Rp4GLtbA8ouLzHGc+6HCFzLAcp?=
 =?us-ascii?Q?6PWgqjo4whXaIAuwNAxeAW6DrtLS/jP5gWYBZytVuwIKDDrqBozUztZl5sw9?=
 =?us-ascii?Q?XI4MDB6DB1BIp38zfqExaBFwlUXCMws7Mv8c/DcNd1DIAlX+eupREQAJRuwI?=
 =?us-ascii?Q?+3JiSrSjSv9qfKGNLWX8ROdPG9ZIACaUd1ckmwbfhjsjbpG3Qea0x63dx1d1?=
 =?us-ascii?Q?BTQ3IJhNMACcWPNLvahgi6GE9p1n/zZM8pGFCdnGpvUcB7gg0Bo+ObdiNUzz?=
 =?us-ascii?Q?iSB3HDr/SNq8sM0wTDGwSmNxFoc5qpJzQ1d4j08+3tjyFD89csnPGnkLu10Z?=
 =?us-ascii?Q?r/QUJmBc1upLxNpgV+JhAjBQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ESDs0DTa3SbFVw2DYbk7BNKTAHH6FKwpMISA/d5K4SI0lm1kUCQEPKsLo7RY?=
 =?us-ascii?Q?5Othh5zzpfuUWao0KtpUTttclsJ0IYzHHPj6q4zkTp6y/zVwc5DO1r6UadT5?=
 =?us-ascii?Q?5yWz7zFaEjh1SzHOTPJjls2QX/MfF11+cVn9y6hrJZDkEf8zbkETTnDzdzBl?=
 =?us-ascii?Q?ffNtFkiw7CsriNnSKD2au80Xfq8u4R/+ZoaA89A20N3B0+GvSkH2uTO+qzS2?=
 =?us-ascii?Q?PfyHIysDeBdbth54EIs8gsKsWMdj11f6AHfJkU8i9+9gS1KFdRQ/rETWH7f3?=
 =?us-ascii?Q?gdwgC7OrwmqUWhCQXhXipxoR1b7VuNmLFCHgDQ9v2IBjUaOG60Hxp431KYVc?=
 =?us-ascii?Q?jNrvmsm7l4+k7ghAA0AkAt5M7HVCRiDW2EljAg+VDYsvs1bLtOnABRsuoLed?=
 =?us-ascii?Q?fq10mH0ZaVPZLqnPJG3U1nXgRbzFKKkuhjdERU5GJj1ZawyVvvDpD6sL7SVt?=
 =?us-ascii?Q?WofsS8JTd4Q4me28dtRTC9Cs4deOE+1ye9S7rW/LRC5G7AFxQj+4ncDr+Qgn?=
 =?us-ascii?Q?zqdjKkxXfKIJ7/rpEmaWQw7GGzgBMNb/UZfgCz/ibt++WitfUqX/hk237vh3?=
 =?us-ascii?Q?WYiF3ws2SH6sIjOc8qo3oYIGnarlunwZqhGsV4hSiuEtj5TuwPYKak5K8PFl?=
 =?us-ascii?Q?soPu3xmqkq7PMWMOobsN6v/CI7HaLMt/wZY7wD2rYPmxYA+nwcVVzYh8SebX?=
 =?us-ascii?Q?Rb3y0QlkwkXSwGQMWG3mmPzax80wOPN/MLUUTXnCDq6yCB9Fw8jZfjfKNHMN?=
 =?us-ascii?Q?Lj63FO9Tf5uNdXKviNV4RF8bAou4ZUHzBXRKyrrnc60++3kMZzekPixQGoEv?=
 =?us-ascii?Q?eqCPPqgNCEwNJYQmxXyu/+cD8NlsA8h4y7p+LUTmeFM1lN+4os7vBgvEVZbu?=
 =?us-ascii?Q?FDxTZqSiLumDGyTDKFBavX2CNObHpgL6CJ3RbooHy1OM8+PjoNsjpRGFLURq?=
 =?us-ascii?Q?JcL/tKNVlPf2XtrkrLi25DPvCSIkcdcT1wspSCSzZu8FOaRMakiWKB5XtJXp?=
 =?us-ascii?Q?ygwPQAbmMNKlNCzBlG/wwOOON5obSgEegO6fM/ryhzO+BXttBtN9eNseGM15?=
 =?us-ascii?Q?TW6MbGLMp7OFNiCX8/Vb6OXwhLvdygmPE9oUA/Lx4mLaFOwPxVZe9f1fPNxJ?=
 =?us-ascii?Q?C7MJx9sxjC1tJRclOuj5oTbav0rFFoUn6oEoH35FCF+BfEJBje/VppsNHSkf?=
 =?us-ascii?Q?vT3kbvqL6x7bPYkumpEDvBJmchnTqpyGOh67ShzDpH4wi1iNigNbNfV/sCPt?=
 =?us-ascii?Q?BpZdrT3KmKHaLvvjLX7vi/v5J3hcNQkHfbuSoZRagyJHMEeSn7lsXf33Qc2f?=
 =?us-ascii?Q?MC4MMC9ppRyCMD5DiwVtHQvy4aiuleQgW4SZBlbs7GXv6+kHkzW7a9Wktvkw?=
 =?us-ascii?Q?JZGI1CawYLZweSX5W9QZVsnwspC5qKWg2qo49IDVGzLQZeW+1kGYrajvMSQU?=
 =?us-ascii?Q?PiTQEtEz3KdcHtFt6nIEHJtRL7RYHovIdT1jKhb0Ch+ypdrnMqv2+vfEgSFf?=
 =?us-ascii?Q?fQ/kQhPD95ztjjabEywXjQlP1+YS/oXPMvqwLNe4DU777y8q3kg7hXlDKzlD?=
 =?us-ascii?Q?sCCM5fSbgGjflfRtIcyaDA4bix07Geunj+Wy6RWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daac087-09d3-4d0e-363f-08dcf511938f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:25:02.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4NCh3H8b1O044olLUbJBSnevytQM61Tu/SRdQRJg1BB2+mEJfdrFC+b5KTjCqQSzfIyid4FrnQiaPBO3lBNew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

On Wed, Oct 23, 2024 at 10:21:10AM +0000, Dhananjay Ugwekar wrote:
> The EPP value being set in perf_ctrls.energy_perf is not being propagated
> to the shared memory, fix that.

Thanks for fixing this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 576251e61ce0..bbeddce90823 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1616,8 +1616,9 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>  	} else {
>  		perf_ctrls.max_perf = max_perf;
> -		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
>  		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> +		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>  	}
>  }
>  
> @@ -1658,8 +1659,9 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>  	} else {
>  		perf_ctrls.desired_perf = 0;
>  		perf_ctrls.max_perf = min_perf;
> -		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
>  		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
> +		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>  	}
>  	mutex_unlock(&amd_pstate_limits_lock);
>  }
> -- 
> 2.34.1
> 

