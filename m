Return-Path: <linux-pm+bounces-18678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D343F9E6742
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618041883B5E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3A1D5AB5;
	Fri,  6 Dec 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DxXQ61Ys"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C19047C;
	Fri,  6 Dec 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466076; cv=fail; b=j65gAOvjwC0IWvnmlB7tUcSWHVekB5LpMHWNpyYytEhLdfFGazlPkdd4w2siVWxiku0PwgT/AHlcSLahRXBhR6yOVMvnECtZediOb9ZsiD/oCQd7ygVFyNxv9tNQOnhu6lcCgy0/PMrl0jCoInE8SOuF8R4wKt88IbZ4gzkAqpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466076; c=relaxed/simple;
	bh=dkrDPPfsbxPqDKI2wsPO/hmEFRrcr+I350yt3sYxngk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=de14HdCKhwRwIUo+L7htAtxNAcjN116FV0OzHwYjGcQU8HXq8G9XVbM+2qGH8zE1O/Nxt8u2W8qOlLd7WbxgCqA8TPvjPn5x+sNQTmeU4+iPAByvx7B8hHh+eDGPpvR+YVk0ADvKyx3zrobp46NtKsv0krvoqaqZnlojmMg1N3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DxXQ61Ys; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hONPT6+UZEDODxlmf5Z+7zWqkgUJy8Zgj8NEXmgVWQWAr6dVJTRZqMvbV6R2jcdyd5iIUCg9Sh/2aZn5rgK7vxEPzU69+C0bIhMYNo05lWC5YRFIh2bXmJ13eQTOEYZUADj4+pFRTUI6M6pduqpv7XTuDZmBoPx68laD1EJm1j6iNHimYKVx4/xATPCKbWOLKC1+BfN4UykXAFajf/KDKIU2kIfXqZabNpsxUHq6GLIK5REJCT/KGJTMAVA2wMSBJEbO5lZSnPMh3AJ0S/h9r8PYIwlJgxmGHvvy6rm/W89u75JQyn+0T5Pd0CC43nS9FdpQpngw3DJZr3+V51UXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13j5jovhKOCT3A4+LujiA9nY3rc4EvrXqQFzJqSqu9s=;
 b=b5I9emODTvt0zH1PnTZMaeccItn/jn/M+mgqVdICWzJe72BfE6Z7fGqKSs9obpujA6OnjUyI36ORNNHUShG8d/3at7Q8c3MpX+PpuvvFWXkvOPw285g2acOR5+L8lm1q+g9WPO/UWEtA5CteLqC9Z5ZsKEl0ux/EJkbiRmD2UgFOjhhvq12MuzPevHbKlepifH8+xsSiQSH/b1e9BeAnDiatlU2xkDb2o10ed1cj8Q7Ytr9Jee3weW3RKu16t+fsUYDlsYFNEQQ84bhnU8e3/0IkKJJHYxgpNqOdZMziDtVTLhW7qrSF48YqxuvMeRDzTl73mV9Mas0d1c9pMovdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13j5jovhKOCT3A4+LujiA9nY3rc4EvrXqQFzJqSqu9s=;
 b=DxXQ61YsMKFjJFk5iXxIDJmySVm3Ac9iqCDM+HnBXVYPbPSO7na8yoOCmscS8wDy1CBdTCFy6S+rkZLKHdbxezq+o2WFhhMdYXLckiOab/7CWuEiGOK2Kuu5TPmmvVOKW09TWzJLfENFHmSDbHUtx0Gn6SNmIa7uEJX8l2XXXT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 06:21:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:21:11 +0000
Date: Fri, 6 Dec 2024 11:51:03 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 04/15] cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET
 macros
Message-ID: <Z1KXz3N1bIfI1pmd@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-5-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PEPF000001A8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::e) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 412195a2-9c65-4155-de63-08dd15be2da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uv28Q1figghxupqyhqhK7i3dbkWSX4RuKtjdj056nI+7Rcl4y67objOWFh88?=
 =?us-ascii?Q?v3pdf8GO3V+e8BGzU64vPnwYfyPvDQPz4gIhfZopWW/ETa3KF8yUVW7jaGM2?=
 =?us-ascii?Q?LhjbcPwck7nj/MsDoe0tKNEJzPShOg/K7mIUD/ABndbA+yUiVh28XVmhozTp?=
 =?us-ascii?Q?6+I7sTjdDo+d9DCByBoUJR5x6OxzIEDqmpWmeDg4ZZXBB5TdEQj2l5gBJbfs?=
 =?us-ascii?Q?eOmgnpANE9m9ouZrnSPwxV2pxLUED4DYUmQ2KYYMSLMPcrzq0Y4fB/rxP+JM?=
 =?us-ascii?Q?TU8PlAlNNKw9NDKZqRNUsUxdBHaW38xWfUBJn6w9n2KLYCg/H5Sdj92av9Os?=
 =?us-ascii?Q?LZzLLfrOquw7P9DMnc1+/Wk6FKv83G7vsJ2MAr2gINT+JZSLrRGDwPxP/NeY?=
 =?us-ascii?Q?VBSzmPMJftXCJenPVXfddpD2lvWMx5iHJDLPLXuLHXYyiS57/Ku71EPWRjAG?=
 =?us-ascii?Q?TF094iASrc1NGyT7F4INHeyHB8bqp92hKjEn0Xsp6YwvJVGnnrvCpxLbaCM1?=
 =?us-ascii?Q?FAf20G1riJh0YEb5bNo6S5gOJWeF8MHVKQ5GlHCtG93xPVrdmSfCV9mo5po0?=
 =?us-ascii?Q?WTs84rP0R469rCytMenyriYuFJ8u2iBaXLkwz7z25YXhnN/N43s0OwvUNdCP?=
 =?us-ascii?Q?TjHfsrucGUStZv2g3PIgwQ8J+ofpuOaS2NcqZ50olOAaJnc3JXlhd2AkTFyf?=
 =?us-ascii?Q?tDO1NR/gTzlki1HQwtGoEUAf5p9xxcd63jGsVaQOZI0cK8Ll+WzetO4AiLK4?=
 =?us-ascii?Q?ZKV6dKIojupBqvFvwgXE4JWSGepTfoV9VM45PVh1UWjt5zKu7CCTcDu4kwFg?=
 =?us-ascii?Q?g6RlC6Km0h0MiAYp0pJ1/uPCgo16JqWTOvyK9ikq55QjmBWXu4MxhnsELPnJ?=
 =?us-ascii?Q?qMCr/yuvBOM96VvDIQwLmvgvujljfd0X0h5qpsn7nv4pKzBYRKHkH9R6SUyJ?=
 =?us-ascii?Q?Zud9J3lO7Qwgi+oJppqP9Y7UN0fyarIfoWB2+amXm2dXnn0vnbShDa4fbGj4?=
 =?us-ascii?Q?ETnowy8hfHYtnilBu4UGXS50v1gSFfq8d9Km9oXaoJnTnihAy8kafzvDs2kK?=
 =?us-ascii?Q?58wntkBkoHykkytpCJTpIp+SOW6RrrvJH4PD9hGvqrieeUuoYUEEi4tdehF/?=
 =?us-ascii?Q?BO5dXzC2otjNYAuvOoquEkZ3MEeOlnf8PdXqqLZjp64rmy10IUJPRAZJCogh?=
 =?us-ascii?Q?95pbxWIkZAogaCcBFr7bhzS8jgWKFXybNU2gB8nD77ikAtrpmpJYxugxERGC?=
 =?us-ascii?Q?6HN1LM5IK+dsZ86WaQZ8jtqAp/cY2u0a0JBrf6t7NKbSq6MB67LpIYwSFs49?=
 =?us-ascii?Q?Z0xCb8GxrHkUCali3bZJrFvRvU9k8F1RqXYRmULH17g4Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAdtRysdecPMP4dxhTF+rs60t1UI797cgkdryEGZEHBq64SBtguPYLUsi1We?=
 =?us-ascii?Q?kFuu+EQ41pR8cqqdzYzcZzWwtmf9woQ1mm1miKBsyx6loAvwppg2KaSCLtTW?=
 =?us-ascii?Q?KqManJ69+gXP3dTUMszCEmQVSygAdyFiqvyMAJLEm0FO+uylx7oI9aL/3df/?=
 =?us-ascii?Q?T0OJ1SZh7kArpO3qh7+WuYaYm6YMQIuI2bs1E4VySoDVrUxwStTHBIQTIRXT?=
 =?us-ascii?Q?zBp42/0ECgbE654hBzOoEANi7Ne9dXqndBduySEfs51XevxvXxu6fBOs+OPk?=
 =?us-ascii?Q?H7b2rVvV5gdI7woCHqO08hHQZXnvYoe3a9w65a2tuLwzgON8mVzG1zYTPewe?=
 =?us-ascii?Q?CQcLCqHfhcdq96eKWemZM7RPrlNTNuvbyopywUrDaBkYvEKIroVXt4bi91MW?=
 =?us-ascii?Q?xoxp5md07mQka83Xc4wl3Uaau03A8I3l6YgnqJMK+IKs1iRq4Yp6yDry7EE/?=
 =?us-ascii?Q?Dgf+Get0Hng71yZJR2x7KfwQbo+XtjlXku/NJsaYGNn+hnzXljCOdYEEvX18?=
 =?us-ascii?Q?+YBgT/LoCHxDjXnHlsRmQkcvD2Mjh0SkHBA+po0nyx/kWlP6CznOtfv6YrhB?=
 =?us-ascii?Q?CSe6Z8eqKkDqSnTHTb3xWAOuAaGQRwMYhe/FGsjvG484hHutiMHY/gy/T66o?=
 =?us-ascii?Q?SROYmyhoqCGrZ2+dChOWzp39Pb+qcPiIGDtTsiZCsBNWN/4gnin9ays+NCY0?=
 =?us-ascii?Q?j+w4c49u3FOLsRi42aNwpZuVnzHWlvaWn+X/U3dIaYtYE1728XfsBg/UGJjP?=
 =?us-ascii?Q?txNyz9BYIXmgC9XUewXLEkKaXL3yZtMff5M9K8pBZ62tnW8kgcbtBLzixWft?=
 =?us-ascii?Q?DShSOjna0lC/K7PttDvSMuRvm4Lw2SpjGdNdSFeP3BUq88eKIMcj8aSU1ils?=
 =?us-ascii?Q?Zw4FLgaaA1a5R1wJ3We188TSgEEWIL8fySVfzJPv/Lzqk3HQkVDbDWkRtNrK?=
 =?us-ascii?Q?vQA+ZNeymAXqxzV5bOrNO8lQQbOjDKgHANEEN0+nECMZP1905rnJkOHlA1vv?=
 =?us-ascii?Q?JQooemkVdmIa0ha5lzu23w8akxobA9COGoD76kRN9RG9SB0muiIzzacR0jaJ?=
 =?us-ascii?Q?WPWHjdr5h6LmbTnVp1dCn3GnPiRFdNEeq/Zs4kONGvSMiifXpTVVu1EGHufa?=
 =?us-ascii?Q?12IEdLljvM3rD0mkt1lSCvbR4JguZc78F0FuB9SpaP0oz+9I8PMwxhXQQJMW?=
 =?us-ascii?Q?vzoej2+kGwbQnBvxhDDPTG0aVcjw/Ii0WmgPSfGypcCjWQOzlrPPleExDy86?=
 =?us-ascii?Q?/Sp4MhDq2oNpP3gRcvI4M3GV2Q6kARRTbSW1saexigGvf+j1/Nyu5bI11YZw?=
 =?us-ascii?Q?e+6QihbBv0sf0xhJv4ZY/Q87Oc4UFxCTVjzQ5iN254xaQU9bcQQrCQRpqZKS?=
 =?us-ascii?Q?EQsiyf/68jGBW/UcdTc7O/NEpHoS1lAkKijOSec9IUEwuZpTFhJ1sv5vUbMu?=
 =?us-ascii?Q?IU40d5dS9va5yp2q8hxdoTNu6OHAOrkhNQaMeH+WnnaNkHr2y80NmUey+yy4?=
 =?us-ascii?Q?dLRQIkDIfk6qyVUwoxf56cVnXEUdy1fpTLcH++xo42hVM2NUje/HyjAq64vR?=
 =?us-ascii?Q?Of1EN8FTICr8Xdmo07k+2jDnNOybSL+qw57GI5BS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412195a2-9c65-4155-de63-08dd15be2da6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:21:11.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooerZWRyx1sxo4hJfO9wANEHJMSYOeSxA5sMdOLad9T5Yoqnc6rG4dTdat8RlRTFrFnFTUdH+2jQdumIWvrH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757

On Thu, Dec 05, 2024 at 04:28:36PM -0600, Mario Limonciello wrote:
> The FIELD_PREP and FIELD_GET macros improve readability and help
> to avoid shifting bugs.

Indeed.

The code looks better with this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 45 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 22e212ca514c5..dbe014f3c2beb 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -22,6 +22,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -88,6 +89,11 @@ static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
>  
> +#define AMD_PSTATE_MAX_PERF_MASK		GENMASK(7, 0)
> +#define AMD_PSTATE_MIN_PERF_MASK		GENMASK(15, 8)
> +#define AMD_PSTATE_DES_PERF_MASK		GENMASK(23, 16)
> +#define AMD_PSTATE_EPP_PERF_MASK		GENMASK(31, 24)
> +
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -182,7 +188,6 @@ static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
>  static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>  {
> -	u64 epp;
>  	int ret;
>  
>  	if (!cppc_req_cached) {
> @@ -192,9 +197,8 @@ static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>  			return ret;
>  		}
>  	}
> -	epp = (cppc_req_cached >> 24) & 0xFF;
>  
> -	return (s16)epp;
> +	return FIELD_GET(AMD_PSTATE_EPP_PERF_MASK, cppc_req_cached);
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
> @@ -269,12 +273,11 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>  
>  static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  {
> -	int ret;
> -
>  	u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +	int ret;
>  
> -	value &= ~GENMASK_ULL(31, 24);
> -	value |= (u64)epp << 24;
> +	value &= ~AMD_PSTATE_EPP_PERF_MASK;
> +	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, epp);
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> @@ -533,18 +536,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  		des_perf = 0;
>  	}
>  
> -	value &= ~AMD_CPPC_MIN_PERF(~0L);
> -	value |= AMD_CPPC_MIN_PERF(min_perf);
> -
> -	value &= ~AMD_CPPC_DES_PERF(~0L);
> -	value |= AMD_CPPC_DES_PERF(des_perf);
> -
>  	/* limit the max perf when core performance boost feature is disabled */
>  	if (!cpudata->boost_supported)
>  		max_perf = min_t(unsigned long, nominal_perf, max_perf);
>  
> -	value &= ~AMD_CPPC_MAX_PERF(~0L);
> -	value |= AMD_CPPC_MAX_PERF(max_perf);
> +	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
> +		   AMD_PSTATE_DES_PERF_MASK);
> +	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, des_perf);
> +	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
>  
>  	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>  		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> @@ -1571,16 +1571,11 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		min_perf = min(cpudata->nominal_perf, max_perf);
>  
> -	/* Initial min/max values for CPPC Performance Controls Register */
> -	value &= ~AMD_CPPC_MIN_PERF(~0L);
> -	value |= AMD_CPPC_MIN_PERF(min_perf);
> -
> -	value &= ~AMD_CPPC_MAX_PERF(~0L);
> -	value |= AMD_CPPC_MAX_PERF(max_perf);
> -
> -	/* CPPC EPP feature require to set zero to the desire perf bit */
> -	value &= ~AMD_CPPC_DES_PERF(~0L);
> -	value |= AMD_CPPC_DES_PERF(0);
> +	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
> +		   AMD_PSTATE_DES_PERF_MASK);
> +	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, 0);
> +	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
>  
>  	/* Get BIOS pre-defined epp value */
>  	epp = amd_pstate_get_epp(cpudata, value);
> -- 
> 2.43.0
> 

