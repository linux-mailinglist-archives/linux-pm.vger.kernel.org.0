Return-Path: <linux-pm+bounces-18218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AB9DBF0A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 05:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCAC281935
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 04:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E05155301;
	Fri, 29 Nov 2024 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nac4k2JP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3E154BE0;
	Fri, 29 Nov 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854470; cv=fail; b=BAQI5457AyhCGHtFURjQ77WCa6oVaZYHLo3JtmnImbUexzHsGQnUhChL+tKVpzaay2ijIYE+bjI4MUINEI2P1RcQh3HAb1bPnsLz3upR8BC2KlWp3ESIeAnzZnN7VhP4Z0g2Adtk+F9RBt3QonyXkm3tdvjZjHy9qy3WDuxirmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854470; c=relaxed/simple;
	bh=7eLebN+LofautY/++kXTtKMWKeX+Cd7khu+Ih6/rtAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SVPU8fa8toeQPKYAY7IMsVtFCG+85gpMveKvR5cdRS30qXtE5pSb+vJ4hcSguvFhq5xpkiN0lQJ0uZoTQgpLrdPmPSnzNa8ZssGcjrNI/T2qIg0CblFms90oeUOYStuqwv8yVLrNqQ33AaOfLQNc1N0B1Q2nNY3BwB2oNiFayf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nac4k2JP; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWWxrIiyldA+ohG/bxTRoByLNpORslVK8lhODRE2T25R2jz/PggcQ3goTb4RZcDT4fmNy5nclWrefbiSIGziFN8Gl3OeDMSWjsJo/smDuXFtnZYszxaN7+Obh6VlALg2BPFyNLeh/Gl07yhLUDWzuc/bF6r5eopJjCptGI5fEKazaIs0ZSyyLiOqqMtqtjkTjLEcxiepsjPAdK6pCKMzFGSuCCzhB01k7v2JBXsflDT6AFm5Znxh6FWttTpydiXcccwpM/vOlIEisRCoVGuuWgCis3DImOBzRvWZAnUI1IuOAEQt2OmvZDCpiHI4eMmtftEQB0dqb9XXG6lKbOBUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7Q99SJSTB5MNkpoFhj5e7vtfTRNET71V+JZ7J54O/I=;
 b=EG5+FcZY/5/GJYoyKG92UNAfJ89kCudPNWbbcyRAgKLcENKyZKVP+UnDAKNU5RnHSMHTSVgvVBVcUQfOrL8wne7y6UPLYMHLyHC8sXKBo7FUJAvfEuINRQNG6oUJIZFW9thpXRhKOyTBmmfRJy5PIxwzbuhlq+PcUfadkpQiX2vag5p4haTAFVynI2EkqEZOudnFhrj6PY1Hm7NlPkom6poEdzI5jvSqtS/kIoyn92WOPD79Xm5iklRcDGLrZu1XZ6l303uY+8PcJlPH1nJA6ab28PbSU1rX59D0B+dW3CXex2H3EhUp01h9/4+EnHI55m9iSsk97QXp+EO82/tD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7Q99SJSTB5MNkpoFhj5e7vtfTRNET71V+JZ7J54O/I=;
 b=Nac4k2JPHqaoKar0nJSIcxZ/UfKQYtHCcqdqqWT3jRgILDbS4gHQGDvdrGt6RHLuMGoh/GBPt4tUnKOftljTfXKuW12rk72L2jfYkoQaA7wMENq5vG38x3dNMgdqfaeVaeE+IKj/ifZcFXFvSnwfpltXsmkKnm3paLjTTX005IY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 04:27:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8182.019; Fri, 29 Nov 2024
 04:27:43 +0000
Date: Fri, 29 Nov 2024 09:57:33 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH v6 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
Message-ID: <Z0lCtdZKzZQXTWxF@BLRRASHENOY1.amd.com>
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
 <20241127161518.432616-2-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127161518.432616-2-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN1PEPF000067EB.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::27) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de41b8a-88ea-4c38-859c-08dd102e2b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9leu5PnLy287PtvBaJ+qXqPJIM5itQPyOLdyyLjj+pVLkXKjp7MAwS9l1rb?=
 =?us-ascii?Q?4pSGoI1iPCfGRRKahhsCHTEvHU25yhWu5r+n6Y1fX8SVa6bz6Wp7p5mDgnpU?=
 =?us-ascii?Q?pL2LS99nyYpX8DdWUMXs1AESCK5JzOKEjfxWVrYW5J+m4JTpk3yBJHALCM6A?=
 =?us-ascii?Q?L+uDSyidUlQyY0caSTGGGkuvzKLJIKUgTIhGTpUl0FpIKaxuiRNPSQRSInPe?=
 =?us-ascii?Q?Tsefj0yZc8DZOymJffg6Cz9P656/+b6DypOceSP5Sumsc+BV07rS3ZL6+fAX?=
 =?us-ascii?Q?v15BbICN+E8iN7XqfItSODuvrwlspwhBu8yIWd1kcEqYwRce/qv0FqYy3K7G?=
 =?us-ascii?Q?uQla71fp1tOmwDYdVSaOUF7DS8ZuYUjaqGb/sXZP1p10kpQd/iOoOQmQHbXv?=
 =?us-ascii?Q?DQSKH+3GhcddIDd6wt1/bJ7z1ECTdyo0SQdUMDkoiM7oFuLelt4+OU9tzYkT?=
 =?us-ascii?Q?zzFG3EroSmcvchuIbAb/d/Lizt7N1Lb/1LGEjKRRKvWqaY6IR9QY8b38l2AT?=
 =?us-ascii?Q?2bWmWoRsXfvaXDH8bXYNl3I2jhQFMKkbzS0U49c3Sp/uQnEDbUeAAQLt/ow+?=
 =?us-ascii?Q?PYwsLP1tRX+wyXEx/oEBzTwc8RWXDOjhJpTqiPC7pHL9HZD/KyW73j/kEhn7?=
 =?us-ascii?Q?3CfChysuD7xpqkbD3F0vXYx4C+wQ8HMWLbHpeR6UMoE6zp85jM8OSJbU+E6Q?=
 =?us-ascii?Q?K0l9OrQxyCc0t/0+Jo6di3HgQVCC4O2gzGFfEaBckdspE6jj51f+85Deavr8?=
 =?us-ascii?Q?9PQCFh5gsnxybEXRHqg8+VwrCccpfcAe9pplgZIBvrU2m76xdxhjAjSZlPvG?=
 =?us-ascii?Q?jIatWel8jUMd2KPxOEqUq2Nadmpq8ziblYfbdZsNyhiiTMsbn2XxNIyOf8tJ?=
 =?us-ascii?Q?H18Ee7sIW0dLFhNYVfRFgFvehD9aReFO9xujQmxDdtmwWxK6d7xdH/TeDPWu?=
 =?us-ascii?Q?gMERNKG1QQtNyG6cSrE3/CSkQjY4pZEz2n94ioFXD9ig4b3XVxu7sxexWuOe?=
 =?us-ascii?Q?gJEt8ElM+QJYD6Xmx4batrWnO9JgG2iM4uckSc+YKOAhtqj9UJHiRdsmxfLy?=
 =?us-ascii?Q?LTE+gf0IWxx47lVCQGSOXORx1L7gob1NmJCSNdm1qiVvvR/1Tief3U9wr1pZ?=
 =?us-ascii?Q?BxvlbH+bLq3xLEUSlHlP3i/R//E8HYAjv9YBIg89fAnOMulYV97InMD8Vh+Z?=
 =?us-ascii?Q?EkQDVIHHYmwTC/eX+bkHwyEzNeMueXw9VWqhlqdp9RB3YFvD1ZKQR37kB8lo?=
 =?us-ascii?Q?L9LGRCqYTdCJTgKpaKHTw2ypXKeSxF6JVhC//oxvEjCa8IdPhCqvEUoEUJjm?=
 =?us-ascii?Q?P51G+RjqPdg1WKwDmZOpOOCv4u6ufMMdhTwW7TWZiDvEEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXIjBJeiiDFW5/Hn63FSK6lqaIl9lxuVY2lGYxI/6bzuF0dgGXkg4tBhSs6T?=
 =?us-ascii?Q?I7DOZLG8vX1OdQbnM6r7chapYjyvBGxKRRxX31R2DabLhc/aJud7Zy0/U7FU?=
 =?us-ascii?Q?kvxyqd3BUAjGLFbkDJtwpAYhTV3UOHp0pHzCcebMMJ2IaiMHeAHLBSE9CsnL?=
 =?us-ascii?Q?SLdHx9mAEEIa66vj+y0niKbHx4aYdI7LevmJHCn45qV08LbpAv+bL9yfoG0w?=
 =?us-ascii?Q?MM0A5jqmt7uS/hWJEIBwIsW2u4sKRftEb8gRpYlkToXfXtpD3AroCO1F+1bQ?=
 =?us-ascii?Q?VTCTw1rL7l2bscNkFW1jYeoozYOuhHfNK6ce8+dl79DmseDU5djJYP196wZF?=
 =?us-ascii?Q?CX1kV0CjNFrXKwc6V/Ois53XcDJtGNMmpe5SYa86YE3bLSUjRFDwlx5eXjq9?=
 =?us-ascii?Q?1qhWFE5IrZg2+2ESFwVhwG4h1L6BtXLhLbhDM8t/FVVWZItyuBhKj7LhjB0F?=
 =?us-ascii?Q?l6STElNCloS+dA6PibGv7DiBex/HtKXqPo5L1w9wsf8Q7JS7jYobg37Oh6nH?=
 =?us-ascii?Q?/wj9JjEm9W0XueqqXaR9RYm7OaZ1sBdn+t/gGS1bgiVTA6UV4IbaY2uj6G7h?=
 =?us-ascii?Q?KUFiRNZn165xlFKWGZ4rKfVrUxkjGRtqFuFMu4F99BI8dVNxmR7Lpjx1QaP4?=
 =?us-ascii?Q?7C3Q5l7zUKDNlJ3CSEMHX2MRgdQsX45M3pBS+UI0mBbiGuDmvBjehNGK4JVp?=
 =?us-ascii?Q?yZDVuyvCRttHwHSxCi4ehgLJdI+cDYdoAnipp0HSC3WcoeCCsriYaX3UjkxW?=
 =?us-ascii?Q?3Jo055cKjEO0tkkTVIKBk6AxnrCa9bJ1fsb4ZuLcp4LdM49lMWWKeFXuwbvw?=
 =?us-ascii?Q?s/WuY229srrpM7diZc8dNMSXOcs412QldRboGAOv1s99/QrK0oM7rfkXjp2p?=
 =?us-ascii?Q?413/Bjg2qcQtOBie4COKw/DAb5MljQfO0Wc3lV/u8CKDaG2cwPEhNpR7raw6?=
 =?us-ascii?Q?8JMH5J7Gdj4J7mraglw07ij6cp9dRQ3KriPVPf4MWRBf/2qQgJoslXge7Q64?=
 =?us-ascii?Q?xWFnbLkSGJlsZp4Lbk/dLLu2yJZzG4c1UZNkNqDG16CQUt2Lcw8NLkHTa47H?=
 =?us-ascii?Q?6StreTck7WHCY3GZ9VpkjhqUuwrzwhqSPdpGZAzlwsPC4Vz/vafTvdzxqJj+?=
 =?us-ascii?Q?+7/w9m/xN2X5X+3qFub53A04uqoLjQgBgfpybEXnpO2fciSsdYkWRvN4QV19?=
 =?us-ascii?Q?SHFPYmsuEOWAwHo/Oarx22Fb+pKwkOJVbm/9zzprMtSlO/mFYvIXzKWlsQi5?=
 =?us-ascii?Q?FVplRE70IslcY41L+onHj/QF3sgpXgdWmNbDIL1f4e3QksnUVhG20W8SHcCU?=
 =?us-ascii?Q?F3p4kyDG0I4fbu1fMyjEeq+dwixhsOhyaTzlSWOjLys6W0H6jxb3nxp6gxCV?=
 =?us-ascii?Q?LRe0frxb1FKdt52FJbkUPegaCDP3G6jGA+0GR7FweqTvqNGqzfP8Q8vemhbT?=
 =?us-ascii?Q?DF+/fcRKWxx/899BqHUUvG1j59EyxbwaDAYrtB8DKHyKKUftYjGNHgPQl56h?=
 =?us-ascii?Q?KqU/4cuyFom4O7/jlnptbfuzRw83euLVxPnAg3TGGVPrBN8/EOCftYIiyQGU?=
 =?us-ascii?Q?kLNKx1PTya07k7Jht03GbNlirBdm2RqGLfal02M5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de41b8a-88ea-4c38-859c-08dd102e2b2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 04:27:43.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l6+X5aFhlE33xgq11zvH2AObGYvOAPXTR6YSOlMQKJnPhwyfEw8aPdm1WXnMzOwEVo78Z6wGo4RYjix6pJeNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

Hello Patryk,

On Wed, Nov 27, 2024 at 05:15:15PM +0100, Patryk Wlazlyn wrote:
> The MWAIT instruction needs different hints on different CPUs to reach
> specific idle states. The current hint calculation in mwait_play_dead()
> code works in practice on current Intel hardware, but is not documented
> and fails on a recent Intel's Sierra Forest and possibly some future
> ones. Those newer CPUs' power efficiency suffers when the CPU is put
> offline.
> 
> Allow cpuidle code to provide mwait_play_dead with a known hint for
> efficient play_dead code.


Just a couple of minor nits:

You could just reword this something along the lines of:

"Introduce a helper function to allow offlined CPUs to enter FFh idle
states with a specific MWAIT hint. The new helper will be used in
subsequent patches by the acpi_idle and intel_idle drivers. This patch
should not have any functional impact."

There is no need to mention MWAIT hint calculation and the Sierra
Forest failure in this patch, as this patch is not doing anything to
fix the issue. Very likely you will be covering that in Patch 4.

> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/include/asm/smp.h |  4 +-
>  arch/x86/kernel/smpboot.c  | 86 ++++++++++++++++++++------------------
>  2 files changed, 49 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..ab90b95037f3 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>  
>  void smp_kick_mwait_play_dead(void);
> +void mwait_play_dead_with_hint(unsigned int hint);
>  
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -151,7 +152,6 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
>  {
>  	return per_cpu(cpu_l2c_shared_map, cpu);
>  }
> -
>  #else /* !CONFIG_SMP */
>  #define wbinvd_on_cpu(cpu)     wbinvd()
>  static inline int wbinvd_on_all_cpus(void)

This hunk is not relevant to this patch.

The rest of the patch looks good to me.
--
Thanks and Regards
gautham.


