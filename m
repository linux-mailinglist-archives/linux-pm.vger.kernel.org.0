Return-Path: <linux-pm+bounces-22180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA800A37B11
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DF7A2951
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009C186615;
	Mon, 17 Feb 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eH7I8y55"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B16433A8;
	Mon, 17 Feb 2025 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771610; cv=fail; b=YjVRiOKbDEKooG87I/7zbmYxPRSP3C+PARrVqeWyAwI1D8zDoRMfLV9hjClAuXHWDF8782VTH+JDKmFv10sQ3ZI3LIooJJCTff1Vz7bhaAKfWe0n0FOUjsAPdTgACMlKmN2RFVCX6uEjifY6Zyzx7fYAIhNLrF4xS4M10FTfqWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771610; c=relaxed/simple;
	bh=9h+3P7Y0JktJzdp0tA7cD+jw3V8PPjzWI3uQqaYFeNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pFvAGM/8D8nR2dpWGiHBWnvYzABqkdhjfs38sOerbzygF9jLQ33RlbEdN/9laXv1dHSauhY9UBF3vl6So+H9vnvS8eeBMxdSr2ZLjh7IrieYhkOl8HaYI4DotcdPWULCSKVpj8pAn5BbkdzqUNuQntNYlHpvfpQcW7a5//1EMJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eH7I8y55; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxH1CpdnwJopDii+S86dhkU2fmOmLh7IaDOpSJPJAkOr2k1AEr1jUAYYej7mWL39mCNvDEOejnkOIz6ObXvpPPNhUuXKovfh+U+7xD7FsA7UvF6pLIA2YYw55TCP3Z/Qd3B+Dyz6sR7+q0QtVYjDtRYhAcODGCcNFrhX8aaoS6Qd3WdRN0PMH1da5x66rKmGeuhjEPc+8BfMwclfiNffUhdlc9mv4QttLsaE+gLh8pmMOxypkbjBR51zT7/y75N2JR4yvbKzqPdDkICctaKGD805yWB92bOkfJ9O8m7zLf5egVHerJ+6grqSB6byUOIvswddhOj9RBI7epZfnX3Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqHjpssfi5rE+GQe4Cnc+pZ1iNxKXyHd8ai/jIxqIXs=;
 b=xHOYIx4h7563v5UIeIBEWx7Dehlz2gOp0ozng27x2d8QfjbQ+E21BZkETGeBEYh4ggbXdx/nPJXCSORgbjlZ4gBpTGOgICs789X+AfA0jrVCQpYJYffrhY3S0qhYN4ebe+2j9yIRWlksp2h1HEQ8zHL2xXX1oyiLSBBvUH26pNi2/LidluAKcn0ruuqQYge9KeyN/LJ1VgKVARdDJEL6rMoePRmFhs5rvll7s4CVlXWcZ6Gu0hKA2pqFKZUlBt9sKXUGpuTC7u70X8NG26rVHVbBsDqBIh8J3RWHQvqGYRMjzkAz5AkuS5o6P8J6b1piNjCUvDkOYvYYxC/Sn/W4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqHjpssfi5rE+GQe4Cnc+pZ1iNxKXyHd8ai/jIxqIXs=;
 b=eH7I8y557j6lj/7jayZUOfV8mkpg3kYd7mHgZxRKUYoZ5yJvQ4kf7ATdeYUA0S0vh9DTFFRoT3visK4COAvcw5s1wYAPwVnedoPaeZ/CQWQaYnAgShid8aE+h1Y1Tr6s15HMoJuhkrPh/K0FrmmQG0aiyDXzvQQ5ReDC3PhCXHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 05:53:25 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 05:53:24 +0000
Date: Mon, 17 Feb 2025 11:23:17 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 01/17] cpufreq/amd-pstate: Show a warning when a CPU
 fails to setup
Message-ID: <Z7LOzep0ISEIlYEp@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-2-superm1@kernel.org>
X-ClientProxiedBy: BM1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7133522f-47fc-4baa-4f2a-08dd4f176481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04/bhWZzsGveq/elUplHGZBCiQ3Lezq8nRjQutvaLL+Z8181Z2UJ7OkiLr00?=
 =?us-ascii?Q?9UcoHYrw5EvsVVJTLojdA4ckQqf/XFrWq0N9cCm9v2BJxwP2/7wzJopDfbnN?=
 =?us-ascii?Q?prNpTqTZxhR6vjlsMt1r043ZSwivz/dryvdT8lDvmyrTjRa0AoyU7Obr9iJ2?=
 =?us-ascii?Q?odGvxRYhbw/BO/Asy483RUYvgumqg0MTY3xkCkh2h4hJIQ0RXUrQcR52iQeH?=
 =?us-ascii?Q?sR3r3fPZUEoPrGJACZHZUO5+WCcifpGdSXuiUX2xSzZp1UNW5GwjaAG3pOL7?=
 =?us-ascii?Q?fuVJQ5vfTlP8fmwdmUXWgg3K3opPT+So7k8/6okTMv7kjfifoO435dwcRbAO?=
 =?us-ascii?Q?Gq1j/F+ebZeTYZ312MWdA47oGjwDThVGJc8ISthPYFj0X2YWq8dyESA5LtXR?=
 =?us-ascii?Q?zAG+evlV4He9yTsN5wa2TinUNfVePUuJzfZZLYxgIPa7zrxHvW9nsR8VMuif?=
 =?us-ascii?Q?IvM7G+W4JLG40teRYuJ+MkHub4NuoVU1oyR2XE6TOIB9kvnOaziNslIz8O18?=
 =?us-ascii?Q?I+AvZvNCi8j9JICI/LuEacPVbZbPZohKr6pJzkM9jJPcMgMFtBq/bIRT3XF9?=
 =?us-ascii?Q?d4hup6D0qnhDbmeyDGfg25EFJk9uL5bCXLf2otmvu2F9iNYwffQ39O3LpH2O?=
 =?us-ascii?Q?uRhUE0/yy50v+T89aHAt0yAt+Bxpex25wiFPacyaahXp9ZrSyVU69wHiaGI6?=
 =?us-ascii?Q?5kDCJG7o4pcjbH90XtxDs8TjPvJ8wphy0a1UUMw1YEz6wVAcPdwZ34x6YmHG?=
 =?us-ascii?Q?4tbH6hJZI2hLO4lrPCAOlWLw837XgvnHPub4SyPDyzGxDNIvz4IFWC4MJkVq?=
 =?us-ascii?Q?JYK+Lag+3HRkfhxSHFv4zTuPx2MlYJFGkUxjoE1yRdDmhLbSUWF/40Up/aQu?=
 =?us-ascii?Q?ZE0QWm3oKiLXGo3+IB2kQkSWnZQflWGAP13zN9+TpVCApCEg78K0fseGDiSs?=
 =?us-ascii?Q?nzR5Ay54YQbooknUI7pqKpVdsDf3Ck9KvMfnP3fhBXOrUB2NnEPfsZOrdqAj?=
 =?us-ascii?Q?yNoxddj+/lDiGOnlJdVKvjU/QNdbskVupmxJLOzAMmm+WXS5WfckXS9tTLL8?=
 =?us-ascii?Q?bfz9z1NW0taM/tcFxL2E19q9R59KfHzdeJ0DHgHXxk05+CCJpYaF2jqjHdJe?=
 =?us-ascii?Q?HM2S0phl2pqLkzsTF5mG1cN/J6QlbYw6mcPDUsvR7QS03GUkjK91Y8xDMyMY?=
 =?us-ascii?Q?FtwTPgYHESjpK4E/sV90+Vb36HGzCdglk7a+C6hjztkmuPJt5IGqlCsNmnvb?=
 =?us-ascii?Q?a0tHXK8hBNoJSmbx1AZnsq60gzjQt/wZj+yFCws1QHYMI/eDvD59rHLQlaum?=
 =?us-ascii?Q?UQqM27aI87ZPYfmtqR3tFzPyaOO/COAY/kxAOyYdASnDCzPzbJDjNlNkZKvC?=
 =?us-ascii?Q?2MSbDxi/8o3kjOU8g27EvrzMMP/Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RLtFUHaEu57nSIUPgJw5kgiNkFl9aRpQbQuQ3g1PACq6mKCoUFEXhaFJpzn?=
 =?us-ascii?Q?YCeRx+RVsjB/3r4f4kkZ4mtYnWXcJoqoec6CGjV4/nNdWxhXjPHycYZI1Uzl?=
 =?us-ascii?Q?SukMx9Qo90y5u7qI4v8isYqYM/8seRpeRfHvEQ1MJ7r28oCvQaXlaQ7IVa9n?=
 =?us-ascii?Q?o7CH4bmSLtrAOQfsFTdJiFJJw5XfNWMFbTl9yN97r+29d0mqmAT5yHOLYPRe?=
 =?us-ascii?Q?dSlPgZH5gL/FuBTAfuDisFY3+N9OmVb7WmePlIGrRam06GYN7oWxxyaaZnRG?=
 =?us-ascii?Q?Ow4A77LgYIao72rgzm1/kho79BDLLOdRCo0x4EsmFHERFaN18EbkrZgR/Jp/?=
 =?us-ascii?Q?ntcdgdWoz4XJtfYxxaT0XYsPL9paGpiWjn5ywv2m5RyDIZbcFEBKB3wKrvSA?=
 =?us-ascii?Q?3Dn7Z1Khs2lsGAwAlwdEqhwhI76MZPw3oc4pfMK6X55d3IW+gVTAOqJ5NfV1?=
 =?us-ascii?Q?MVEG9KpvLrudeVGtcfyJORObxEsVra2WL2fqYpuzcl6PVFnLQRutUKV1DGu7?=
 =?us-ascii?Q?qF3Cgyzsl1+oBcVXKFk+UsdmTU7563z2WJLJj6VmKhf420f7pHglyM1k39ta?=
 =?us-ascii?Q?sJGez8+j8QZZH/6RlRo0RJWvvmebjrb+6OdsQNQJV7dvU3+MYa5Z9kfkSkL7?=
 =?us-ascii?Q?LfMRPeDDk9Tg8dMIfC4n2saRtHPs9zcncTONGXZ3NrtO+rPd0EmUQanMO/J4?=
 =?us-ascii?Q?dobz2vNLpePMjteg/IVo3+BoaunFAkFx8iaUzcrjxTAtYSMhLstfQm/IdvMN?=
 =?us-ascii?Q?w7u78xBpr6474lgJk77AII2aqV1CCt8GLFEtvfsIF+muueTUQFkt0jlQF5pk?=
 =?us-ascii?Q?wI/MRfl7NURufFSYsXalgA4WmstMZDNET/kxwrPiPETlFxznCvWem3RpHgOO?=
 =?us-ascii?Q?Bk/LbS1ujw3Xd0NYV+VdhJZHLXY3yvDpgWoARbw/8UqGwGo1i96iQkUQJymb?=
 =?us-ascii?Q?cpfZ6yp2NOr+ei53xc08XD9O9O12bB7YYcBwRArwhpfnAkc8MTawgC1QwaVq?=
 =?us-ascii?Q?Q82dgla9Qcb95PhKvfsOUx2CaoFno6c2fBs0egfQ5xFaorgDFGY7gF33rCS0?=
 =?us-ascii?Q?6YIjAg80lGUqH1U4CaH+km/wMAgCynxmy37zYIo4RXpG3wcf8Gm97GX7egIa?=
 =?us-ascii?Q?30SQDwbHFlSbDOzx5z40yPNRXw95lar1Svl0LdDvgB5bAHSUYn8craKgh94U?=
 =?us-ascii?Q?bkJRa8XNZYDNw8fE0pjwH7OHpZmUOwnnrtscQWBMAMcaNWYt50l9y6I/R/Tv?=
 =?us-ascii?Q?z7hzkLnVwwCc4TMo+n0FK/Uij3Ds/iX/VPdjwsu6JYxwT7TvaUQwNlI5wR6r?=
 =?us-ascii?Q?uBiGEXDnlOuCgg+HZEKyJSXEs9eeVJu5faknWazTY15BfTutM3yzV5yG2f+P?=
 =?us-ascii?Q?9eXdwbFw9qaVZipaWGo6Rg6akWavY618IJkQkxppEsIxGkRxbKo4mceig2EJ?=
 =?us-ascii?Q?BJnM5DCnHsEBZhFQe138IeMWRdLG0b5XJmbDp+xhTcJOqI9MLMJzHBKYHAo+?=
 =?us-ascii?Q?QYHNavtmKnFWh+cpEUfYGO4kT2oyYB8kVJOnHjYUYSrYbJiWQdJASWkA8cTf?=
 =?us-ascii?Q?6H3+JfNb0gkD8Tq3zhkMdOOxraGm7wqLU9vux1ag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7133522f-47fc-4baa-4f2a-08dd4f176481
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 05:53:24.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdXhO9V/QiApEYrznB9+RU9gmRg7ZeoL9aM4NEwMntU3UYiVcwGSPhPqLmC54ES/pd7lajd55JfZw9w8XuJ59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

On Fri, Feb 14, 2025 at 06:52:28PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
> populated.  This is an unexpected behavior that is most likely a
> BIOS bug. In the event it happens I'd like users to report bugs
> to properly root cause and get this fixed.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f425fb7ec77d7..573643654e8d6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  free_cpudata2:
>  	freq_qos_remove_request(&cpudata->req[0]);
>  free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>  	kfree(cpudata);
>  	return ret;
>  }
> @@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	return 0;
>  
>  free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>  	kfree(cpudata);
>  	return ret;
>  }
> -- 
> 2.43.0
> 

