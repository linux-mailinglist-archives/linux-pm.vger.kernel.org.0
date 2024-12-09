Return-Path: <linux-pm+bounces-18799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E7B9E8EB4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB072833CC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8561215F65;
	Mon,  9 Dec 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZ9x1jmM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA073215F5F;
	Mon,  9 Dec 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736490; cv=fail; b=SedNiZIB32+XGKNGqP8H7D3CvcVweDkXRX9fNoJ4RZkpOeyL4sWopSYv1Dibhcyf0fMpXlq7ZnycadYzA1SlFgtXj9Qw2+P+uy3u46QJTHvf3yw0eswdBsdN+dP92zp2/6LYrU6mMhuqWX1GkkGybCbqHwMLVIev8QytCXq4DQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736490; c=relaxed/simple;
	bh=K3VqOE8k9zHprTgqbBJRYzr73gY4XUGskJKD9jSn48k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rsy4cfTo112pKHjX+FI4tPybqGTiBQEX+wo+MLLUDqn+uM7vUfuTYWLesRwOL7rUtWfgVByvqinpH0C/Fc5syowpz7rD5BOgcwRwXoprj4N4ssY5Ah+0eK9qfT9gHuPDhhT4LrZ52LtHKCpzdrx4A8gZn0IQ7EmDgh51Zfbexo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZ9x1jmM; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCTaFeXcK1MMVGdUxDe6tV/b3Qw9mJ7Ay6WqmO3vmT4K0VoY9kMBKvJk4+qJDzIIxEzriaZj49U8CWmEeUfT80KnKTINkFRir4aW2vR5xk7uD5rIUblMtb+9GqcOwrhBZ92xxLoYtcQC4Kmdbv9chCsqiba65yloKXso27pq2IqxGQJbDqktVx4wNuwnI2Ma1GafrT2VKCblBxGz8ezJUQh06SipRMZHA95IInCpx99+LZ25z4waDyBVT1r1o/K2fMhqo5tKT/zmpdz7mFV3SZBSSH5HVwnQSjEZ9MNl+R6qyaSTYDa6kKy9bD3+bm9TlblN0I4AJg4Bsk/umBQbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e92nMRRp5ufODbMRuV5IHLawfofREBNMJA3mjooKILo=;
 b=orUMS5xXRE0pDVNqGj7h4tAUDSx2Z61rQydnfokqYs7E6d5nzXb3zgOtmlba8wm/SSNNXf5O0ox9h+2tujXbtoN04TOVq+rGzqIsWmYH3ZbKKX3qVuumf5+80x0p6dEuG2omzumU9F+tZbC6n1GZQVDr1wexdhOWIYB4ktTgEDWNhe8uAbwgdS8QD/KdTPGvbeELp/df0rESSkUkM8j9tLMdGPt2s+68rjYjflMqBPMR74KMgsFGmvb3JL73l2YxgKJ4jcvUE7NE5MoBaIf2Heti9QuFc1Qxx149qRDP4z/CJwcuMQPO1gn1AKuNkM6fHpNEBUTO6qaXwlnzvtk6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e92nMRRp5ufODbMRuV5IHLawfofREBNMJA3mjooKILo=;
 b=CZ9x1jmMIUBknapbxs66sKvS+qxC4DOC5WmkhjDgCDExhvS41PHiRMxU0O/x2AFm0i0luGF5hP73uG0doEsAaA8YIAjIzkhdJoCOObC/ddAcC7bD4cZkVpUPHWbz6p3uUC2o6/EGAjr7/LGaP9jWEyzJXMDi/f9q6ww7Gu07Qds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 9 Dec 2024 09:28:06 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 09:28:06 +0000
Date: Mon, 9 Dec 2024 14:57:58 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"Artem S . Tashkinov" <aros@gmx.com>
Subject: Re: [PATCH v2 15/16] cpufreq/amd-pstate: Set different default EPP
 policy for Epyc and Ryzen
Message-ID: <Z1a4HuUug8+4nSYp@BLRRASHENOY1.amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-16-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208063031.3113-16-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbee651-8d44-421b-3d06-08dd1833c95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RildbeQZ1OgnuAM7srPsrQzXlbU8XNHMHD/xkqhCKrvVxzxX0FNFHMgKIXU2?=
 =?us-ascii?Q?oLO8zcdvomtedUTRJqxyyBaUU4U96FZwUE29GNQbph8HuHopH9CqujOhPWgQ?=
 =?us-ascii?Q?7DwxG9aHFSD5CcaHuTUX3X4R69nkXk5mSZ6SgpRrUwpdMYAWI8RlFkYYVFwQ?=
 =?us-ascii?Q?d/Y1XudWbUcxq4IAGe5JFv5OBUkphZsvaLK6UGm5MfadcqE3IalXghG1yOBH?=
 =?us-ascii?Q?Q0bj112y2c2L3jWy881QySjydAhgj2C4ZerLpHnEJylzlLh32rsIQL1yB4t0?=
 =?us-ascii?Q?WRskyrI8PU0Unmtrb+zfPPVnkmmoFPExFxANf+M6VoFJAQb/sFSM6gw99WBP?=
 =?us-ascii?Q?eK0np0T7ZFXnr0grLbp8XvNq25MkysN6NZfh7tQL5tQ1S/qt9ggoE1bLSqyc?=
 =?us-ascii?Q?qisKFAlj9oJq5AWbpM76P/aDovx25h6Md+n7PFuT5D+gC3xex1m9C3wsvScg?=
 =?us-ascii?Q?yPsnNA5HGVz3JRq6elliTQuvNptIfv02RwX/p2H0MSVh+oXiFxyKwPPUu3q/?=
 =?us-ascii?Q?5nQD16fDnCYavp5xClOYTUmuxFlC3MZWXeH09rt3s0ucq47BBGd220H1/5+f?=
 =?us-ascii?Q?fhGLlmXTxNtkyHbCWp3v0S6P0+TZExQfnDo2VcZiBInzEnjUScW9E5yRTkNc?=
 =?us-ascii?Q?iVMrDqWIEUA+iT5lto0IduC/YdS1EjBVYYqUfajp3SInmJfA3S9pQmeKiIJj?=
 =?us-ascii?Q?3nFby4xDNFhLk5p/GfjHs4S6t2Rup35/ST4uSYPONOzZgbpjHM3ZunGmey13?=
 =?us-ascii?Q?FzMtSn1fJUuwPQ2NM0VsgPjck6nGd9ufasMuDTOMOkFxKpoRGFwA9+35/djI?=
 =?us-ascii?Q?x+e5vRGVxgwXFzskRanytgExSNQkJBByvWw0X6Dd7YbV4emksBLBj10YNNnK?=
 =?us-ascii?Q?Ts/7XBpAQx8k0/qvfAR/eftfoNM3qYnVXRISDt8vWo8aifJSsXd2OXdoRCYO?=
 =?us-ascii?Q?IbM5wE2Rqgj1BsQ+W0EyNe3GWufVsDdqUewDQu3AYSf/C+Mnvl3DP0aSQbWV?=
 =?us-ascii?Q?KHtsyLpwFwK0PBzTg8w7qKHgrzeuKhCW+ZsIXP2DD1xSeSJGllmsuK2FjtN/?=
 =?us-ascii?Q?MY+taO1f5HG3oV7P1W02RVbi+BObh7w0+JbYbkxOa0U7xJ2qYkrbkoHjKJOl?=
 =?us-ascii?Q?uGEuiUf6iRj4ROlZpTKUxfsnh2CcnVntmFPm0xzfDfk0DqZlqMZ6uF2N2plo?=
 =?us-ascii?Q?jgfwPFyuOB7jLyIgDBq+9454KHc5O/DdsJl5+Z22nO2KYC8B1xQ/gGsjxazk?=
 =?us-ascii?Q?Qf9PzyYn71NHhgIaR33Qu2hVyQPRyAbzdT+7Ml8RrHcX72NkbN4d9M/7mB/X?=
 =?us-ascii?Q?GG23vxwt8WqoL/wruAjPrb3KvdIkGpex83EgLMeQGeV8bZV6g6KzZB3RjRSu?=
 =?us-ascii?Q?RmRobVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/F3v3PbWgGKLjad/zW9j4SUZj9N1ygal+4YVqyva6yULImy07bKQHrrZ85ub?=
 =?us-ascii?Q?RzgAAidLNJOCje1nND9lRnc72gJtanQfxxmvE6rdSNdtJM654XvsYQn7fHPu?=
 =?us-ascii?Q?1sxGXrcWqCi4AEAQYy3GkPlBQnrtSr7IG0GYF+pH96IGf69+LqEofINkV9E/?=
 =?us-ascii?Q?Cof2PhnpSf3osZWUG5zqNFqCQIqm5GVwlvc7ocYvxTFlAwZ6fw49CXrul0Cr?=
 =?us-ascii?Q?sBx21ngc5Az58nkvKos2Z4b5SlZy458rjHuT8ez/gnzU5w5UR0C72a881Ei+?=
 =?us-ascii?Q?yDf7Ag/Ix1foDG/83MJSdpIeZ6KLdAxqCbj6ALhJIkQydqVCbqFe0VQt8nkJ?=
 =?us-ascii?Q?uXlS23fbiLt5ewqoEsllPdYf0WVSre+vsc0NuCNXSPxlQ7d3ilOzTkhnVqIo?=
 =?us-ascii?Q?upUyXFM1e4+czsAjEDkaLjRYSsZB7VuU4VdZNEAxZ1SzmeNlirmV/CBWp/7L?=
 =?us-ascii?Q?HZt6H+fDzqA6YPnF6AV9fHw3Z45iKrf3mo1qXZNe7XH1zNrowRsIovkTfJV1?=
 =?us-ascii?Q?qTVgECGKzB3r8kEWDhVfvhLoWk5JYuhRq7ozjYrOFRSZmUbk0JC1l97SK6GO?=
 =?us-ascii?Q?0WQwAOs43lVTDbGFxpokk8BYTk/8wTP/i/mj0ue2RtdKQyokN6Cyg7IFLC8F?=
 =?us-ascii?Q?1AzoUW7rxaEz1D3z3d41/VbwoD/jBR7NhkZIPMRerULrBug+RoTtBz4nz5wh?=
 =?us-ascii?Q?U7P4QInpmr9IMv35kP+825Abx1u8XJw3+gfVNAfqj2Q+S/BoaWth3B1kknrr?=
 =?us-ascii?Q?6c5ZoTXFe02xD5/ZSNJVVCp4jgGq6WJ6aOAi7e6EEoRgDMyS/KkOemdRpgJg?=
 =?us-ascii?Q?vditYsNp/+4EQMBpD7hHJwNSyB2QO3z5rbW09lild6FYafMg1oTyKNa5z4u7?=
 =?us-ascii?Q?iUpNZK+sttDvmnSYf2usc+Q8q9Ghq3cT/6NGD2HqHr4LQQptnifKFCNXxme5?=
 =?us-ascii?Q?HUM6Eg08LIJV6e/0yhYAjY0oTbJlretWyLLuHCdYWfMgQjkafqampZK7WALv?=
 =?us-ascii?Q?nHh6ouA4lUmQ486bp3O9VuKd+2VhvaJGyywpDsJCpMXU7Y5QvRYVpDp7pw33?=
 =?us-ascii?Q?JGT4Lqb78iUFzLx/LBa07XuHRqGGbEuOuHW5D9RtUrGhcR6XQx5qZjArorc0?=
 =?us-ascii?Q?q22bHW6Abg79EE+J3RpJQZfFAqD4/9YA4RgjOuXU6pOk+t3KnS0AOARgHn4w?=
 =?us-ascii?Q?FoxfAaY66fb7DFfZhMIV/5uMmOqtETDYfZjZqry8tatx6OvR0GMpySXLQOrx?=
 =?us-ascii?Q?DGssCLymn+3Szkx8lYyIPKmqERJKyJqvsqdmpW+X3AUsbrLQ/B38FadRgtcq?=
 =?us-ascii?Q?OoAGTuc663L4UgcIRZuPw3k2U/cJBwDZ91DrBH7BLSJTN5hHBY2ove2cSA+w?=
 =?us-ascii?Q?ourG0RyqLLDQcExvpc/MUQGaVpmPrjogrbzZhuMvPIigxSHWCapa0CEzNQ5u?=
 =?us-ascii?Q?ZBBgPeS+KXM/ulR7ZfvmysQgPAm9Avebs0lMnXrh+PAHhWcnJgdoR75glrs5?=
 =?us-ascii?Q?jQsbLEifmquSBOFOjZJnJ8aETu50vnk2fj3u+KrClPdEAFKCtwQbtY5HvJBk?=
 =?us-ascii?Q?rlIcriFJplLJjLEXyKDGlcfRpxsDHnC0b3/YRBfK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbee651-8d44-421b-3d06-08dd1833c95b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:28:06.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuGgtJaWp4ioIS4RBIky3bcmDOrJsBFkugT9ptHBBHxNNOxGHLskBCIuZ6giYs4XpiDBfjiH6C83pzrYoaZjig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

On Sun, Dec 08, 2024 at 12:30:30AM -0600, Mario Limonciello wrote:
> For Ryzen systems the EPP policy set by the BIOS is generally configured
> to performance as this is the default register value for the CPPC request
> MSR.
> 
> If a user doesn't use additional software to configure EPP then the system
> will default biased towards performance and consume extra battery. Instead
> configure the default to "balanced_performance" for this case.
> 
> Suggested-by: Artem S. Tashkinov <aros@gmx.com>
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219526
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me for EPYC.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5869bcd287e87..a4ededb8d89df 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1501,8 +1501,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> -	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata);
> -
>  	policy->min = policy->cpuinfo.min_freq;
>  	policy->max = policy->cpuinfo.max_freq;
>  
> @@ -1513,10 +1511,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	 * the default cpufreq governor is neither powersave nor performance.
>  	 */
>  	if (amd_pstate_acpi_pm_profile_server() ||
> -	    amd_pstate_acpi_pm_profile_undefined())
> +	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -	else
> +		cpudata->epp_default = amd_pstate_get_epp(cpudata);
> +	} else {
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
> +	}
>  
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> @@ -1529,6 +1530,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
> +	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
> +	if (ret)
> +		return ret;
>  
>  	current_pstate_driver->adjust_perf = NULL;
>  
> -- 
> 2.43.0
> 

