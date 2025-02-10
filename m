Return-Path: <linux-pm+bounces-21696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C9A2EECE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BDF1639C0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C7230991;
	Mon, 10 Feb 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwTWG7Ia"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3B22FDE5;
	Mon, 10 Feb 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195454; cv=fail; b=RxyI4xnKyYiH4n2zwuDkF+0zuWDK0EJghacJyIG33L63GFibuKT5NhFATi63oVscaTrtP5xP3M8Ez64LEnOc8vta4clM7C6kUpDV//7+HYfPazVCDckKRbaPrY3mX9Yhw9omlBav86T40nO9N/eFFStdTHPO3vc0JSyPG27K/SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195454; c=relaxed/simple;
	bh=xtDbg9bmdPX3Cll6DQTP10FQbNgg3L2CMVoqbPJ8C7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBTVMxw5zxMgfUnbr9n+ScoieDESci6TMf8RYx+PsyAwRpesud6OEXWHvk8YsoLVOsbSXdKsGZRhxYmWAjUE/jlPFRKe2gYldCqxOas3NGzouKh/9wcIA5ODPDdqKBJ1dXb+ADgCGSms/xCzaL12lyiG3xLK7cuIzrjK4X2fiXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwTWG7Ia; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGLa5zXItNj0/FJuJvaMDxyVGVSEpVl/qmMeLdLg+6DaMy1uuoQ19QHi4RCfyaSQFeUBJKSQY1GWci4B73mJa6hvFLYgpnMP4nU+rwmu9CHdvECTnVfU0cjqNBR8gb0SgniGmhC/OuQixdvvbqLu495WWRi25XUKbEr3BetKhx75sdqktyIwm+BtAlQJojYGX/NyThwArRvQMzVGQ7ZT9/WugtVTKvUFXsW14eEDSJ6ICtCUY7a3JsqP9Lctd8lMe6ocP1vxWP5nKnfy0BUAkmoXYSgET9bKrdIb8k3KCO0Q9QbTxwd8nQVt07aylW7ldLHpZ0n26cRD60c0BDKqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq8KihL/EO+486s2E6J8g2iOJQBYf1yaow4Wct7N5Sg=;
 b=gIJOxb0dm7XdXLFrtd0QJaVezp0fPt5j82ufRC1yi6E5ol3U3dfN2lmHsJ36iAU/eBwaJDDXrUYWQolV5pfovKFNufHvjxFEN4YhkzvlIgTX3V6NJZrdLoBQgi8phGclc7G7ofRrtEajUnpNWjccnpbtY+0oPHBIRftCnwJuXkZUWyox9yZ0d3tUJSOui1FMW7y1d/kkJuilMGkEmPfWTRiMR5g9QykNr1KyGmoZuu9n3ZlHEB56ej7xgNQjMd0FsOmBm2lvN1DghVi72xbUnZmVqctRhTtKyXcFw+kN4jL4JntDFBSQCoQ1K8sLS1uZlZyY/JVwWALWFX8YwPN9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq8KihL/EO+486s2E6J8g2iOJQBYf1yaow4Wct7N5Sg=;
 b=BwTWG7IaY0zlvRr4T2sww5/XBPczyJujqr7VKGMGuVIRVPAW4xtwuvFSjmnpVynYUbcZLjVx/RcgFVuyMTi4kOe71R1ru26nYOKxgy6IMyn3RYMC4s5MQYyKTqPG271mfbXtYeuHUIPU5d5ihecCwUd2pG43+UHs/L39ZVcrKZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 13:50:49 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 13:50:48 +0000
Date: Mon, 10 Feb 2025 19:20:38 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 01/14] cpufreq/amd-pstate: Show a warning when a CPU
 fails to setup
Message-ID: <Z6oELkyt+XEMp/nk@BLRRASHENOY1.amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-2-superm1@kernel.org>
 <c7b4e115-91b6-4964-ad4a-58e8924997a3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b4e115-91b6-4964-ad4a-58e8924997a3@amd.com>
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d1c586-1a36-41f0-34e4-08dd49d9ecb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6Cy7mOw5w+7P7+camsB246ZUHFTIW5Lri/mXdleeuWMtIICjF+KVbH0hU4u?=
 =?us-ascii?Q?hl19gQeTwoE0iVairunjYygK96aYhNYlyq3f4o8UY+izrOkfCwIPmV+jjEW8?=
 =?us-ascii?Q?85yXnmVqlMKH5tzlYQ3flb3ZWdB+wteDobPhm0hTEciRyvlFLszB3GTzkCs9?=
 =?us-ascii?Q?DGHFZ7+9YKLkXlmJWmbcoJBuLES/qSzRD/G7AD5jtebKMYRb794Mbx5eZ55+?=
 =?us-ascii?Q?pveeQshttnAtKUr4pA3X9VeXV00P78fb9YE9Q8AO27u7GDytndyVxhQ4vvBi?=
 =?us-ascii?Q?z6Kx4doi8eCv32NDmGhTE2CWW3tJH6P2i+R6YBP28/4gTnY7BjfeDj4c2ftd?=
 =?us-ascii?Q?Tv4SlBDa/gHhC8QVPzuH/NSk2j9JU+fn7g/D3rZFVO4GVO5GhMldV5pbl140?=
 =?us-ascii?Q?Cl6rTiZBioHP2cUvyKh3t7M66GMv/9PpqmMCk+E4zYziK5WTstM+gBtYP0Si?=
 =?us-ascii?Q?VTqJpIQGY6evVH1/lh3JAmm198Jj27AgqeeOfdFa2He6Y7CRjY7Ahr3qezco?=
 =?us-ascii?Q?SB3mZpRR3LI6uZROLBgEZ4i4XfNxZyV8yyK1uyT515HVGYBdNO8Xqvmd5Nx+?=
 =?us-ascii?Q?UQ2YOL77AbbVmt3PwxdrhY6hB1hfdGwRRHD9sfzOHJuQUBLD/hLH6LwqMA/Z?=
 =?us-ascii?Q?jQ7KTaeMr35vKSYyJte57h9o8dyGm/1FiP0/f1tujyaJkafhyXRmWB54SKvH?=
 =?us-ascii?Q?A9Pk6CkY9eiQA6PvqCLdrqORhd5zI8YwNiV68Mmxpcm9FrieQ6H/drF0Jxi4?=
 =?us-ascii?Q?z+ngy8prH63zrx9J423z4XlfUgpZbuBHrwi+KFXzGnKuOy2rDOl5XMqwphgH?=
 =?us-ascii?Q?MGkt/U2O3XF61bFojNoPT8/LEH8RmJMfZBU1aFPixkEh4GIq5F5Zh/LmkEHG?=
 =?us-ascii?Q?S0CE6xlbY+9PnCDXJYnyaXkMHwfDEZDYuMFzVyT5EMNOP4/FsevXiIeY3VV6?=
 =?us-ascii?Q?tsgYLxz/xwhtsdx+4f9mumLWayYTd7DYLUFp10t+m9F76IUO27aDf8AglgxX?=
 =?us-ascii?Q?oNv9N8lDCfTloPQVV+SEBnmdZNET6wvZHWFHlVqclFdsNrmku+rBeyHXCNfE?=
 =?us-ascii?Q?hRFUpQAPsJi3CrNaK4KV9GdK+ANdXwrjwbAWA3HWyBBHrq4BmcxqpyjFPdUG?=
 =?us-ascii?Q?SgbAhQz7qZDcfXO+cIl/iR3hy4T2pE6kInMY6phrC0YY4BA103dOUhpiE4Z9?=
 =?us-ascii?Q?G6ttNyk/UK4oUvSgrlFFvh7lsCwgSmmPVfMbTvLu24BHAVmpcW157MkEjJWZ?=
 =?us-ascii?Q?jXq8WrcTlFNsAMeK+S+xmBONEjmS7qCdbm9i0ikJnPmLs6owDV7eC4N9cnqk?=
 =?us-ascii?Q?rgtUJ1D/0+lI2MrvURMSRQf7pkY3VyczE8Gef4SGAf7DLx4bn9IANNYDx3Lh?=
 =?us-ascii?Q?HDVKAExWksCAK+EuNpjPTvb5kiBg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xB6Kb1+jJL6bVXRwyc7ZoAjFMO7UQzr8IkAzCVRlZWN3pCksbcj5hy+ag6ZP?=
 =?us-ascii?Q?n8jk6v2LSg/ndCUFcYRJ/j/P8BRkF4e7Yi/x1eq2a7XAd9jXyquVwmE8HMY/?=
 =?us-ascii?Q?8CNx3blOLIjP2/43TEnXdTqonALkBZ55hFzJegshyAcjis29u++S692IZiSD?=
 =?us-ascii?Q?7x421VTNcshtolbaiUwMw/rB6ovjghiOE+3JV9xHhaPgnieUkDx4jYxkzMHM?=
 =?us-ascii?Q?IHfY7XXEOtDXUKSKzg4W61zEXaA+Ha8G+vbxBpMvg3py00nYGoPS9YkTHNkO?=
 =?us-ascii?Q?0tyvV1z3mKAFaDyGJIvirXfGw/LOGrOpYPnIXdg0U+e4inQLd0CCBTuL+nrX?=
 =?us-ascii?Q?M6o9JC8rYxTCHk3MaQGhnp11PR9YeEi4AZwkQhTvsAk7+n+ocdPqycExdgI1?=
 =?us-ascii?Q?okrbQrpSH98aB4mBWfbO/salKMrq5ltQI3r+Ef8DxnrHVw3Wr3aCtKWhhkSu?=
 =?us-ascii?Q?tmeJ4E8RzOHsgh8h15onD3rIG2eyvivMlOK+sqG2ZbaWwQZ8luYnFv1NwVb0?=
 =?us-ascii?Q?i4/QlKeSjO12QLnZ/8n8BmgW6shBmcji5cVVn47148C5M/MYKR0nngMSFtLc?=
 =?us-ascii?Q?9XGFv9YTbfJHd1xzpzcUwnlVYPaW+S3vsXhSHNvke62s5bUcO6356NEY1p7/?=
 =?us-ascii?Q?nPj0THfbpFoHGoudaYqMUYXkVI9TNZjK1wKjO2FVqfiY3Fv625CPurzGPX1R?=
 =?us-ascii?Q?SLbdYYVPA1PbJR2mRM/oo8TnbmtlkQ10qIFs4ue5cfVMSVNn5XP+b6W8/lF7?=
 =?us-ascii?Q?XtreDRcPlNQOIq4JIME/sbtBu3DKr8dDDUb2uJhk3zLD3Avy/2+A0i05e69w?=
 =?us-ascii?Q?b1Wm77jgiXk/qFTxLR3mqvqaBowZG0XMe5MJolO+CZyk87s6Gp6E3jRcuuaD?=
 =?us-ascii?Q?VA/h8hXWjVf2Ep7iF3HdfoUEGoEQ3BsGhqenEBZQV8YfbopUULN357ew2DCh?=
 =?us-ascii?Q?GzbFOlJ03QeEjfHmebeUs3P0JnL1zZJycHjV5W9w+2yJpdaIXB1e01uOcmNG?=
 =?us-ascii?Q?27F5FP8hvmS2zf+AotQOIUjx9WwK0dmNpF+nuEt+XryZQEOpLwQ6IG3k8c+2?=
 =?us-ascii?Q?xFgU6F4sLL3HtWOqb7FNCm+j9HrU4VN0lx8SuA/a1i0TotMeSAfVPMIkpTsN?=
 =?us-ascii?Q?hhBS47U/g1yaOfDmhisoaEcFUctisVYCDuwyVoOjFLiFXX/zHpvGJ2TO5sWA?=
 =?us-ascii?Q?WgbcgfdLBeDQe4YNaITabi8KbRasII8n4+fhf3LquUjSRGBLCqgPCMCA1RtO?=
 =?us-ascii?Q?BtXPAhtln9GfBOcwRc1472o4sIIjo3oAuypF/xGA7+KhvMX08AApgVTBqFB5?=
 =?us-ascii?Q?zvc+ufTm47VniF7pUMNG9pSU5HqnFa4SVtRfo4rJekS/D1WTLUOOLztPbOOl?=
 =?us-ascii?Q?+3SB4bw6Hngs9pPi0tYzbfF/Qq7uPl3EdWuL/wzWgbW5MRfx61Pznezdngdg?=
 =?us-ascii?Q?pKbJ7I0r1J/Yy4Lch/gGkL4xSY2cJex4w0VtRIedAQKXyGrmopiJxdcVY1aQ?=
 =?us-ascii?Q?RTB/MjyUGg3b4NhgbPcFnyW2KIOnD/3U4+2Hsg0UIudCjdlcsG3G+PVtBcbh?=
 =?us-ascii?Q?PztyuKFOjd+d6voqvwfruMFvnswrVehL5BCHZtjw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d1c586-1a36-41f0-34e4-08dd49d9ecb0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:50:48.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gf79PSZWJ98v7HoYBaarTKk7pyAiXBi6G9X7UPRhbSnCaYE2D7qW6oG42XiS6IgDWOQ/3vSjDwCd6kILiNIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068

On Mon, Feb 10, 2025 at 05:29:24PM +0530, Dhananjay Ugwekar wrote:
> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
> > populated.  This is an unexpected behavior that is most likely a
> > BIOS bug. In the event it happens I'd like users to report bugs
> > to properly root cause and get this fixed.
> 
> I'm okay with this patch, but I see a similar pr_debug in caller cpufreq_online(),
> so not sure if this is strictly necessary.
> 
> 1402                 /*
> 1403                  * Call driver. From then on the cpufreq must be able
> 1404                  * to accept all calls to ->verify and ->setpolicy for this CPU.
> 1405                  */
> 1406                 ret = cpufreq_driver->init(policy);
> 1407                 if (ret) {
> 1408                         pr_debug("%s: %d: initialization failed\n", __func__,
> 1409                                  __LINE__);
> 1410                         goto out_free_policy;
> 1411                  
>

Well, the pr_debug() doesn't always get printed unless the loglevel is
set to debug, which is usually done by the developers and not the end
users.

However you have a point that since the code jumps to free_cpudata1 on
failures from amd_pstate_init_perf(), amd_pstate_init_freq(),
amd_pstate_init_boost_support(), freq_qos_add_request(). So the
pr_warn() doesn't indicate that the failure is due to
MSR_AMD_CPPC_CAP1 not being populated.

-- 
Thanks and Regards
gautham.



> Thanks,
> Dhananjay
> 
> > 
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index f425fb7ec77d7..573643654e8d6 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >  free_cpudata2:
> >  	freq_qos_remove_request(&cpudata->req[0]);
> >  free_cpudata1:
> > +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
> >  	kfree(cpudata);
> >  	return ret;
> >  }
> > @@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >  	return 0;
> >  
> >  free_cpudata1:
> > +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
> >  	kfree(cpudata);
> >  	return ret;
> >  }
> 

