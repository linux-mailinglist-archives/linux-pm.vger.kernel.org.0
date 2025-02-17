Return-Path: <linux-pm+bounces-22214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B993EA385EA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B876A3B5B3E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB221D001;
	Mon, 17 Feb 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qswJykDi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039954765;
	Mon, 17 Feb 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801672; cv=fail; b=HFKm+n7qN58hUq4+1QT655CYPca9MLMoNGZQANCjY+QrH7rianJ6HcUAHBPDGEErDRA0vgX2arWNr+cFuA8Wa136QbqKtJ4iJnQkKvSZqN3xNVI3IBZQGWvYodKuOyG3d0FUpABNEXcyWX/vhWNBRXpjDwHRvJWCks4sFcI32SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801672; c=relaxed/simple;
	bh=XKQH4c4JcVH2R5k4L9Mn/O97Qfs9sQ09nDGh53JNFBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmCoNFYkY4tdlyVbDmivf8O9uTdN4tuQ5ziUJx6CKx+WSpGsDAo3CokrJ0XxyDkRNPZ1nx6rSknt7Rc2NojIOksgdUPBeqZd2NSfwJRm2xWX/OgpMg4ZfHTXDVzY5PvwFKOOhWGqKOe5RZY21XlibzFPvkWPdqdC6OVeTWRhJDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qswJykDi; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpkvl/GOrId88xxj1cWzIRUC/Qi+/b4S7Z+aE5glG/WKCjgGH7VEcq/TPWPC6Lc1zI5hdPXnOxNdv9JdaCPg+/wWa1h7vms5oBr13zVdq/SNECvTPEJtLs/Q8cWD0/FR6cLmsrcdRz+tj8ZEdmZ8lz6cXTvqwNjV7we6jCMWNSbrPg3cTTo6e3rG3Yl2BnLwzXsAqn2qDv83u6LHuV93zDqq5CtJKn4atLR4xVx1F5G9s2bdH6kVlp9Yqm6aoEg7VmkFvj1pI3xBN5cyqdhXGQmLVs+VLRnsA+xswuSn0VdxrCg28bNf81yHD02M6b1AciJT5TGcC7RTauXWhjdUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcO4lXLq3MHcLVf9abQ36OUrMyMNCu5x2KqMoPPBowI=;
 b=wfxU8y4H1EaxI57HxvkasOqc0m0be0CX0e78brBd7PLXRlsvcRtR05RpA+CH+8pcxk3D/icd7FXYq3SkJ5ZqMxLRHLt8tx3xmmtA+kG6tWyFrGmcy4CPrrgKoAeKwDzC8/VDrzgVcJe+b/d1hdpOI8m8bARJn8NyCF32Pa55SuxDHw/0XyHpg6v3J0B8su83A1PiI35GX5fl2FtryuXIIDw7A8RmmTB5G67K5BRGHj1QrrIKfe4CWnHMCeuQr258s0q/1c1AWXI3VJu1DYtTzVPvrlMc35tq4DS9CuWXPKvbOIoVK2LmxC1Jyker4hyHSLuXHDXE5WDVk6RCMQhotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcO4lXLq3MHcLVf9abQ36OUrMyMNCu5x2KqMoPPBowI=;
 b=qswJykDiJHoOVcBQwOICmWZrjnognBFF64pVS2H9YkXc4CvrMRDYwJLNjL34bg3+8nWRDRFOyX2MSrSlzkNrhVeuyW6K3S/yDsdmb8SzTUPTTEItg/UHecxH4gF+HU43pE8X6W5g+CO83DDnauG4kb2wkG1B36OBJFJf5SoVQKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Mon, 17 Feb 2025 14:14:28 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:14:28 +0000
Date: Mon, 17 Feb 2025 19:44:19 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 13/17] cpufreq/amd-pstate: Move all EPP tracing into
 *_update_perf and *_set_epp functions
Message-ID: <Z7NEO1lnH5/BpnF1@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-14-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-14-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::31) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 88578a81-d382-40b6-f59a-08dd4f5d639d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zf1KlXcjaqnf7waxpPIytNRyeanMgM7ywiyAcLlYITHhZBvfWz1jkchMx1Jl?=
 =?us-ascii?Q?x1HqJRYUaP/jBB8MFvx9rh+l7Z7tcwYbjn2v4dQNMjuvJKKt58C8E+SNrZDd?=
 =?us-ascii?Q?w5C2EMe6Zl2Kwj/7RrrQaA1NfNOQQel6uVZP4XJaPuM+PUSaLICnTV42ItyB?=
 =?us-ascii?Q?Ff8orumqA/idkMelIvYDZ2M6tG3EWjhn9zk5XOQPkYtW+ZKj/Isw0vxYP9Hr?=
 =?us-ascii?Q?PoPa+y+SZNC3IEGsYDs7CB4AGnyQ1JKeVMe7d5nzNG2rAxpkc2J3bEw/aCfW?=
 =?us-ascii?Q?kX5317lNd3blZZloZJOvhCVccLNZBRACUPq+LLAqwThaP6MvxEmSh2gp7f/j?=
 =?us-ascii?Q?qSZ48Z+yAsdx+d+dc9C57WOkKROMJ9JR1sx60slGlO0BQCft2Strn86dwtpx?=
 =?us-ascii?Q?lE1ivD/M/oll7ZOWdhTDW8neXUKizke6AJalVERZQImu3/mG8Gil1VazcGyj?=
 =?us-ascii?Q?CzTfpfBD1XNy4bWpb4ERzlAkpXUR32JbxasVK8DYZRYjSgS9buLx9VUEJXCZ?=
 =?us-ascii?Q?Re1UFi0tQ1cy6jPBbI7WCzVKnysTOsRNVrROYSe44t9ad79jrj6Hm+yMpsvt?=
 =?us-ascii?Q?4inUfuFpTs3Gjs1EuRxqGmmWgzPVFlvnqVCgCHrWjBTOMBUYbm8hPZkbFfF/?=
 =?us-ascii?Q?DLBbBU8aqLHoP+mKilaNDhdx01erAgKGnmGy1UFYkckx3tK1aiRc43DrjedE?=
 =?us-ascii?Q?BIiVJH+lHFBKL2Bznj9EiWnjwhnpeeqfx7tjCjE2Dc2djVixIEnDfkywM8Cn?=
 =?us-ascii?Q?2R1YO3LiWyqSIDk+A31k7O8eRSF3/0NvwH9qAvgNopqAG4bxv3Ft4QrD8cA3?=
 =?us-ascii?Q?cZOZNdOJnPsV8sjzKLCTMqZD9L8ZaKCvbzpGGSOu0kSjEXKm54HVAZRq1u0n?=
 =?us-ascii?Q?a1fPtzYvCSBZPJMZlMOwOBy/nCzyepGh46y33WApHkcq3qDL2A1bhF7Snjzq?=
 =?us-ascii?Q?1jr9Trr2lJKW27AV0BMZDCGameOxGCDOVO17Pk1MJr2WmtPwG2tDieHRDsaL?=
 =?us-ascii?Q?RhlNPtJumvljt5odcvdwq3Q/e1adokvFi6hxPRLsUGk6aRcChrRonn47Vibi?=
 =?us-ascii?Q?CWp86jAdFf720zB5Sxysba9h3Uh5jOvWfSgtwTaAB6OyRlp/Bn4lWImaV7ap?=
 =?us-ascii?Q?netzawoZYTMRKg7/qm2+KgtVLgdlTM2/33Iw01xV8D3zbe3fA4NG9uDsCWwG?=
 =?us-ascii?Q?jG+r44A38LJlYnkwydx6ypMtAtcZhNSagdhSn2now5L6GZ8ZVN40maqDS+93?=
 =?us-ascii?Q?gCGlHuaFoV34kPh49roxmrXKyGEfWifgFy4bvH48oG8km7TB7h8QqNr+7wbD?=
 =?us-ascii?Q?dS5uaXhZTge+HLiRpEex8n1tejrcYy12026j6Keb4KYUsen+JBBKks1Mj1w/?=
 =?us-ascii?Q?A7EQQiKmW+CuZFqhGyIfYVwcNZaQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ksT3mk+4pVB7TBPPftWoOFmKkIhXm5Vwf/ZI2JHlPP9E+TruUQGRVreqgydO?=
 =?us-ascii?Q?RxYOZaC0MQPBu1Ah2xce9Vl4pBFqX7t67mOW5JFONeYZHoPkYlmskGkyPfVL?=
 =?us-ascii?Q?BsMz7D9OPZZGQ5Fa1IUk+DryCOkipYHccMP/t8xLWkA4CZThOEHXr3LVdegx?=
 =?us-ascii?Q?4pKm/pvRq01heWooezDFeLtEdp7Hc6RwazjhSuAww9Y/sy1hvQNL/zlopQpz?=
 =?us-ascii?Q?2CQYcwv7ocovc/o/VK6G/kLYyyJhg+VL0SsJTyAoqP2u9yUxeEznpx+6AklC?=
 =?us-ascii?Q?+1MFxjdxEWD2OrXu5UDhcg3GRSsienaNFEUS3qApuxl52SVUV7EEzFNTYVW+?=
 =?us-ascii?Q?GHYGq7HPNb8ewYXtPH5HqoOPkDkIx+St6QmvGrGxoSkyhm+FAsrXC2B2NKxN?=
 =?us-ascii?Q?3CjZ0vk4b4PAqo0/rvydFW3R8O1EMAfI29Apigh2K/6kTWM6YvVZ4ZUJkxvb?=
 =?us-ascii?Q?5pdXUaOLxiZsF2LDpUYZ0ZjVDAnmYN875OBR7FKMpqoTKkOubt8C6JbEAtzY?=
 =?us-ascii?Q?dqaLiygudE+9pbQuaHbUiSC10DQgRKeJ7D265kcDwYfLBBxhirXmiORcVP0K?=
 =?us-ascii?Q?oC1119Dyv34vcFQoql2ShjEdfsgku/xyi++Qv3Z2W53HV3kiwmFwB12uzE+m?=
 =?us-ascii?Q?qUawTc2DDxwpaxHwApAryCp7L9IDFXJwNmZF6XMvVroBwv0+tgJjHEompukB?=
 =?us-ascii?Q?dcpBelLpVUawCpZvehDYMUwq7s0254bEtxvgE+lXMmfDOhG6gG238FbRUqCg?=
 =?us-ascii?Q?RTWxTXf3vupr4KojNNvriHdM1JHkpytlXyR6Ab/YvzL7uQzCP+BcH/d5Jsg2?=
 =?us-ascii?Q?Tx8iZxJtqWVvkHL0QSJyiEWYaTmvmMfcsj/c5A2g+sKHjKOWzW5usbdU1Yts?=
 =?us-ascii?Q?Xbq/GSOtp4Dre6z76CrQC+MXy7Lm7dYR3PBIiJk5xSCvfhvpfexn9VLvqfHG?=
 =?us-ascii?Q?tOB5gQkT7O3R33XfBLJf3NtI4pgj9z8a2ht3XoeAlW4BY1HECGdwAFHt/5R7?=
 =?us-ascii?Q?EKUb5uCjGYtGh2Dcf4gMAH5mfMnJmEHldoQ84W2+6Ba05q0eMR+2RSqyAlma?=
 =?us-ascii?Q?2a9YTDITgnM8WDFIMc0IF71i/7H+P37sCLkJAK1nlWbLK0SaGvanhVixk47U?=
 =?us-ascii?Q?tOuIsTxiccU1O7UOKbL0v2qlFBic0sAiE8ODFlRqAI0E9qKtpsV/ZlLKKm1i?=
 =?us-ascii?Q?B9RIq4YZQXUqrqrlpmp6iAAjt8iN9qjxAEZQiU6eUAtIKzQRH5kolf+SUKAJ?=
 =?us-ascii?Q?zQ0NTkyD1vUYqngU6+TrN6Lxtx6D7KhRcrAGS9gh87FU65d7bzJlP1IxbRmR?=
 =?us-ascii?Q?vUBw84lCPlRzUglmr26TQJrtOU+GIuAkz1MpvLOy7BH7smsed49XEB9u/nax?=
 =?us-ascii?Q?43KEcPWslXI0O7bBmf0JS4XkHUXYsv9eI6zfeK+2ZHyxrh3xevJdKcZJkZPU?=
 =?us-ascii?Q?K0Jm9VRVFUJcEZZqIP8P3gjis0jhhF6udT3MuNvXIBLakUXWnpyREhfJ4jYb?=
 =?us-ascii?Q?B6Ly11T33FBB+uTlt/ArTfv9DWNATCroAthrbY+4cNUh51bHCYTeMEiMzJ5b?=
 =?us-ascii?Q?QNXQdUJySNZ8hYNuGn/Wm6ELMSzQ2H33chCWeHgg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88578a81-d382-40b6-f59a-08dd4f5d639d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:14:28.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm4K5vS7+6TWNZxSSPDL40wOGJc53P0m/xzgpOHjPqm1wShSh/hOysodK068nYnVXNCeajxrIOS+2pNbx9GY4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

On Fri, Feb 14, 2025 at 06:52:40PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The EPP tracing is done by the caller today, but this precludes the
> information about whether the CPPC request has changed.
> 
> Move it into the update_perf and set_epp functions and include information
> about whether the request has changed from the last one.

A consequential change is that the amd_pstate_update_perf() and the
amd_pstate_set_epp() functions now have the cpufreq_policy parameter
in place of the cpudata parameter as policy->boost_enabled is needed
by the tracepoint. Can you please add this to the commit log?


Otherwise, the patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


-- 
Thanks and Regards
gautham.


> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-trace.h |  13 +++-
>  drivers/cpufreq/amd-pstate.c       | 119 +++++++++++++++++------------
>  2 files changed, 81 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index f457d4af2c62e..32e1bdc588c52 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -90,7 +90,8 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		 u8 epp,
>  		 u8 min_perf,
>  		 u8 max_perf,
> -		 bool boost
> +		 bool boost,
> +		 bool changed
>  		 ),
>  
>  	TP_ARGS(cpu_id,
> @@ -98,7 +99,8 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		epp,
>  		min_perf,
>  		max_perf,
> -		boost),
> +		boost,
> +		changed),
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned int, cpu_id)
> @@ -107,6 +109,7 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		__field(u8, min_perf)
>  		__field(u8, max_perf)
>  		__field(bool, boost)
> +		__field(bool, changed)
>  		),
>  
>  	TP_fast_assign(
> @@ -116,15 +119,17 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		__entry->min_perf = min_perf;
>  		__entry->max_perf = max_perf;
>  		__entry->boost = boost;
> +		__entry->changed = changed;
>  		),
>  
> -	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
> +	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u, changed=%u",
>  		  (unsigned int)__entry->cpu_id,
>  		  (u8)__entry->min_perf,
>  		  (u8)__entry->max_perf,
>  		  (u8)__entry->highest_perf,
>  		  (u8)__entry->epp,
> -		  (bool)__entry->boost
> +		  (bool)__entry->boost,
> +		  (bool)__entry->changed
>  		 )
>  );
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9517da9b7e692..1304bdc23e809 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -228,9 +228,10 @@ static u8 shmem_get_epp(struct amd_cpudata *cpudata)
>  	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
>  }
>  
> -static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	u64 value, prev;
>  
>  	value = prev = READ_ONCE(cpudata->cppc_req_cached);
> @@ -242,6 +243,18 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu,
> +					  perf.highest_perf,
> +					  epp,
> +					  min_perf,
> +					  max_perf,
> +					  policy->boost_enabled,
> +					  value != prev);
> +	}
> +
>  	if (value == prev)
>  		return 0;
>  
> @@ -256,24 +269,26 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  	}
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	WRITE_ONCE(cpudata->epp_cached, epp);
> +	if (epp != cpudata->epp_cached)
> +		WRITE_ONCE(cpudata->epp_cached, epp);
>  
>  	return 0;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>  
> -static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
> +static inline int amd_pstate_update_perf(struct cpufreq_policy *policy,
>  					  u8 min_perf, u8 des_perf,
>  					  u8 max_perf, u8 epp,
>  					  bool fast_switch)
>  {
> -	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +	return static_call(amd_pstate_update_perf)(policy, min_perf, des_perf,
>  						   max_perf, epp, fast_switch);
>  }
>  
> -static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
> +static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	u64 value, prev;
>  	int ret;
>  
> @@ -281,6 +296,19 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  	value &= ~AMD_CPPC_EPP_PERF_MASK;
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +					  epp,
> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  policy->boost_enabled,
> +					  value != prev);
> +	}
> +
>  	if (value == prev)
>  		return 0;
>  
> @@ -299,15 +327,29 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  
>  DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
>  
> -static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
> +static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
> -	return static_call(amd_pstate_set_epp)(cpudata, epp);
> +	return static_call(amd_pstate_set_epp)(policy, epp);
>  }
>  
> -static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
> +static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
> -	int ret;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	int ret;
> +
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +					  epp,
> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  policy->boost_enabled,
> +					  epp != cpudata->epp_cached);
> +	}
>  
>  	if (epp == cpudata->epp_cached)
>  		return 0;
> @@ -339,17 +381,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  		return -EBUSY;
>  	}
>  
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		union perf_cached perf = READ_ONCE(cpudata->perf);
> -
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> -					  epp,
> -					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> -					  policy->boost_enabled);
> -	}
> -
> -	return amd_pstate_set_epp(cpudata, epp);
> +	return amd_pstate_set_epp(policy, epp);
>  }
>  
>  static inline int msr_cppc_enable(bool enable)
> @@ -492,15 +524,16 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
>  	u64 value, prev;
>  	int ret;
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE) {
> -		int ret = shmem_set_epp(cpudata, epp);
> +		int ret = shmem_set_epp(policy, epp);
>  
>  		if (ret)
>  			return ret;
> @@ -515,6 +548,18 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu,
> +					  perf.highest_perf,
> +					  epp,
> +					  min_perf,
> +					  max_perf,
> +					  policy->boost_enabled,
> +					  value != prev);
> +	}
> +
>  	if (value == prev)
>  		return 0;
>  
> @@ -592,7 +637,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  				cpudata->cpu, fast_switch);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
> +	amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, 0, fast_switch);
>  }
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
> @@ -1527,7 +1572,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	}
> -	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
> +	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>  	if (ret)
>  		return ret;
>  
> @@ -1568,14 +1613,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  		epp = READ_ONCE(cpudata->epp_cached);
>  
>  	perf = READ_ONCE(cpudata->perf);
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf, epp,
> -					  perf.min_limit_perf,
> -					  perf.max_limit_perf,
> -					  policy->boost_enabled);
> -	}
>  
> -	return amd_pstate_update_perf(cpudata, perf.min_limit_perf, 0U,
> +	return amd_pstate_update_perf(policy, perf.min_limit_perf, 0U,
>  				      perf.max_limit_perf, epp, false);
>  }
>  
> @@ -1615,14 +1654,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  	if (ret)
>  		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>  
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> -					  cpudata->epp_cached,
> -					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  perf.highest_perf, policy->boost_enabled);
> -	}
> -
> -	return amd_pstate_update_perf(cpudata, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> +	return amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> @@ -1648,14 +1680,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> -					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> -					  perf.lowest_perf, perf.lowest_perf,
> -					  policy->boost_enabled);
> -	}
> -
> -	return amd_pstate_update_perf(cpudata, perf.lowest_perf, 0, perf.lowest_perf,
> +	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
>  				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>  }
>  
> -- 
> 2.43.0
> 

