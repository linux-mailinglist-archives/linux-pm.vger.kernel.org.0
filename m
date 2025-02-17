Return-Path: <linux-pm+bounces-22212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242BA3852C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1B3A8D09
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0321ADB7;
	Mon, 17 Feb 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ED/moILa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49867179BC;
	Mon, 17 Feb 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800468; cv=fail; b=Rr4ZtoSjZR5MbrMdE0cRwllVkKihh0+PPXDscupTiwEXnFnghKoDC3k3GPUUGghz/dZHEYExzMw8P3OELfjVoiM0D9GxWP+bCTcV8vemWpuVooBJnPTgAGj2TmPvCZhCP5anl1O38i3utXJlf3xGMLPLTEBdbJnG9zF8zlRxGSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800468; c=relaxed/simple;
	bh=pc7+lT/v/uCxZ4vAWybrTpSlYeo+aImO5MKQQcjqrcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKDkkNWUtKTkGHuJmKy9OUYpQPXyx8nLZzNQT6ASS1WBjU5nsWbyNtXrsk/0nMMUkmkcwPMr5Fp6PMo41mK/PBAdBrRsybfX5sdmylN6ANknfAsnV0lT/usCHEsA+CrnP3H/pDOHo3A/Osb4IimAs8NJvn9Kz2DVy5YfwMa1i9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ED/moILa; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sa8Z+iagPQUzoI5MxwuzURQjuVJjKa85EOAQDNF/GFuY2/mJZ/2DPosRfvXwcB7CrJhW77ocinxWq4iaxMgMf5sbNOI79RYTXMYyB14ZftrkrgNYDkwHFF7H2P5K9n20sD7KUg2zql7Ztj55YHFwISk764Iel6Oz5M9QR88UXKJtMyq8j6FsOZmV8FyUWq1duruQECxOExjVVdu1uzXTbIJwvZMArk5GFoBEkaEWJjCniow2RvzXMrzPXGBGp9fg1WyR3Yo4Z6WxhLIVEQaVMOUgtV9HhAxfNzYljHGvZ15vxgT+qf7q9oS/ZBTzsN4+Wkdd2mBkYYJ/aGKU7SLVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1XS4XYc+Y7jBwEgyCzxy6Mjre0veL5zk48GTunHdKk=;
 b=gQ0Axk4AmqOz0gybF5GsP2tkiuSl1bITIagm0dFMIY4krgU3sq7laDfe+LsCBXiHbR4D/Y1E8Cfo6XvL60XObH80MHfxRTKBcVx7ZM96t9sRpLQULAc53/pDoLOi7MnoEtMlO7n9ZVChS3R3CdX9OTVT8V0qGv86ExYBfZHtftJ5iPekOJeRdovAVn999qDZdzf6njJZnoOAIXJIMWEdojNLCIFeN6uxvyUwclJu0DhYYaFLl3Jp4gB9RB7+VgV2e2KuJBygozYKVAKQQ1SLMEyoGYVelIQXeq3wVM1lgPXIxq9LIvVhPHTS7E864FlNy8PhwmuT58GGPqDms1Z46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1XS4XYc+Y7jBwEgyCzxy6Mjre0veL5zk48GTunHdKk=;
 b=ED/moILalZKplRNlls374fnv91KisGewDtIK6HXBJAQ2bSWCWP6PFOre5aVy7PQNoREq3YOc3KUldykJhcQ728qDVi6TBF3S1aw8IMfaQty9MAHIhQVA2s5hA8pIWznTY68uUKsO+0QsXeHKOGfFC/JzBTml+tYXmjcjf8i1EhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 13:54:23 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:54:23 +0000
Date: Mon, 17 Feb 2025 19:24:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 12/17] cpufreq/amd-pstate: Cache CPPC request in
 shared mem case too
Message-ID: <Z7M/h84bi1FIrPqE@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-13-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-13-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a12ed9-b231-4b3f-4b4a-08dd4f5a954c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Bjv1RnYVk6bI1nspcfeNoTTn3QrC57ukz3GgpaLaV36Ctod4vFkDGsracLn?=
 =?us-ascii?Q?j+Y0smufbALeLAXFHpswR6d969hhAxLWSjDSRQ5Kh6R4WgXSXlSXs2IYPW3w?=
 =?us-ascii?Q?Rm0gBwqqH1g4d9MAZnw9PDHwHsA2eXM/xazTETg0J514kLQlueMFWBemxWXW?=
 =?us-ascii?Q?qLEqUVnwL4MAI9ew5L57Tjxqx4U3FnMZfuJJ1U+Cfi8CqFs8wH7U8DHI+Lzu?=
 =?us-ascii?Q?kkgFlgDD0eSiH78S8wuunV5WduTJk6Sm5soRuKzPoIZqznX/zSlWVeUt9rFp?=
 =?us-ascii?Q?uHrBwIToYlzpAI1F4E/RK5tbfzBVPT9K1seE60WlaTCwNPAKAUYbOZZ9UAi7?=
 =?us-ascii?Q?QI5xNYFxrt3s5ZqX933GmF6+nUBLorOqW42ia1vWqhglB+Jkz2SOgDo3GnYC?=
 =?us-ascii?Q?nN1gwCKP2Xb/ntOo3kSJPBqkC+PnkB2NiILfFxdezJjJP3xBxCBgwmbEMbDW?=
 =?us-ascii?Q?M6a1/4OZ1f3p4aUXX81wGzg8wkrtJc6HER013wihJcySGJXRg8OJy2o+Dzqf?=
 =?us-ascii?Q?nlrogokJh0h2oCrAzn8XVHECEAaM0aXcAKqHx8sZYwhn/PoLjXbEhj1NRHB1?=
 =?us-ascii?Q?gQ0qRB+v/SGq7uCkDDLSmsC4P6skT7cGabC1R8o1YaqBPw4iwye45M3Wqtve?=
 =?us-ascii?Q?W5nizjZkof5Sj+EfOXyyLU2FjWAbEZ5NdrgIAoDx/7WtvpXwMXXubE0p5pQI?=
 =?us-ascii?Q?yo7y0ccECHJSNMyW/XsQ1vG64SgNZ0OMrzgFQfFa99Z85QCB4Jc62TxrtCjT?=
 =?us-ascii?Q?5Ybk1dJtO7+X+GaF1XqvW+b+ML20JJBK9a6vYfp2Z4/lkmSRWeyICf3KgOey?=
 =?us-ascii?Q?x/DWbR9V3yORX8yr07qYrOStw5oUFhbAhtxteKPGGOwgTNriPTxR4sqRj5ZW?=
 =?us-ascii?Q?97tY85GhnzCYGmbERWmIaEFEfMWtN/XCN+Fgd58kbNWx9AvtVRSMvKjPKTOF?=
 =?us-ascii?Q?u698Adg9UqJL17VKo3WCbHT/nigu45ZZD/ZbMmvBowf25GwNbdJgRalQgv5v?=
 =?us-ascii?Q?UdK2rQkNvpSN+Doma5K+IDsPdGbhLv5REbSSaqDz2O+1nSyAMWaN43pkgfrW?=
 =?us-ascii?Q?FozhjC3BJsI0fEn6Ft21ab/ypkWZXIzkNUgvMqLTI7Ju/DyAtwboaflilHoE?=
 =?us-ascii?Q?nOLVI3per+6SmDdIFfK7lx3PkdZeOp20B8vQHu58jGz44VowGKI6KCp9+ThY?=
 =?us-ascii?Q?lTrboW8EAen74pcF/U+JNRqfFILgUXJ9t8XmfgArvpZGJ6U5BN7CZ/sy8FaA?=
 =?us-ascii?Q?pn2elLrpM36R9+D8eaxSdAjAXZwrxwC7umIaqt8GrjqS/WcK/ZLi1Jkvjfma?=
 =?us-ascii?Q?naee/MeBmWbnFDb7LI2WZaip76arinTjfv/VW+eXY7l7s+LmbX7YoLCpQefH?=
 =?us-ascii?Q?wqSqi8bM+2vYAeeWu7c0RIwCxSmH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2awCaltfJDfaFhgG9WI3+ANJywWPTLnFgbnRFHryaF3iGUdBUFdIQZhLDle?=
 =?us-ascii?Q?JaDz0TfV2/WhMg+dAqCfV+K1o9s2ElIdOgmuLUo1+GEdh3trgTnk+FFDA2B7?=
 =?us-ascii?Q?9O4ygzRt8JMePbXcqdjTqZO7eharSLFR9OENuOaQHUQ+khwK9bQS67UsyY1L?=
 =?us-ascii?Q?V+Dbqbn3E3xI3ZhnM7KnkTR+AU8yCMd/N75LdsFzFdffiaAyMIECBG+oWCj9?=
 =?us-ascii?Q?BI3f4mKvR4xR6RwROtRsx1XTUYPtgB5btWzpCtl6T5kxPTj0gM8UkCJizU0m?=
 =?us-ascii?Q?rQX9R3rH/6ZebIVsQgfvuskz8qqpu/ZfQQQEmj1K9VrPpkjhhP17xkTpvNQ4?=
 =?us-ascii?Q?qcNhDf7ZEvq/8dovFRp8xfReCB7cOVor2fAdYHH4J5seIX2J/nfbodEmRYFJ?=
 =?us-ascii?Q?ciVziibdQ6PQ12hoZ8Yq9TYv3PToZW4kaYIgIKBArjgAWUlhqfpLYNvyd9TP?=
 =?us-ascii?Q?85JQvnmNyZhKtAQ3+E54VGV5KE7M2Ln12QR5nhLHlJOMsAn1NkSzF9zet+Mm?=
 =?us-ascii?Q?PU93kWmW11o0qtcm8VLqHxkMR+dpPqBGLZ4KZzBoSnl+YY7CMa/MKeVjbchf?=
 =?us-ascii?Q?X2fkHvf/8HWR7+pV0rHP5+LJ6/qWdwY7yn1go3SXJyFWOA2h8/h9z2efUKkS?=
 =?us-ascii?Q?bfeFE0Y8VWKqYgdR18jU6fC3rObgc37MfUWWcTwY9BEwWjiv1a27nQnzdss/?=
 =?us-ascii?Q?qRjrDzaWO4cFpAYLbZK6vs3RXB3IY0JAUGZ3EHyNFj6/n0Wdpkdq3ItnvO00?=
 =?us-ascii?Q?f6Dc/AXAluDmUblKQS1TCOZp2PJFwDuvY4evb0REo5TIff16KOmeduU4bPK/?=
 =?us-ascii?Q?IsnwLBPDkzOFm7NA8c7/RO6BIN5MrES4Fv3HYtOEHfw0MhLMRBOklCFUOtZh?=
 =?us-ascii?Q?D6gTACBfbca/4nxMzQMIj2O0RIf3DgfHRdspNmkeeHqCXFJbTVE5KARyhFqM?=
 =?us-ascii?Q?Ds55auw7xC77lIHLFt3Eyvfczhx+Gxf2TUAFqAnFj+1ceOEsdqaG8zsdQtr4?=
 =?us-ascii?Q?ieOFws8rL5dvyhsXGvkhi10gC6j81wHbrCXeeAlTLXvqV8qB+bzcscPRsHG6?=
 =?us-ascii?Q?U7Nj+O2Lml6RYqrmeZKZX7KfOC5DWmFDrOtjFSUPZl0dhgZBhDqKp2NVEQke?=
 =?us-ascii?Q?qbn+CSupisDxSrFMu2yR7+zxdIBwqIyPJJQu2Q5Pr9w4DMwkIFFqeYQOcrps?=
 =?us-ascii?Q?IPMFvd1bnRQkNb+ukMaHafspzM6HIL7zE0H6yot9OFx4+uRfB/xIFzvpppim?=
 =?us-ascii?Q?jcqjBtiVLHfzZDBVwIf5qnXTNY+7MeD1sy3A8Qywhjd6NvMsq3F8+wmh9r6y?=
 =?us-ascii?Q?qAmRfidbgMxrLjHSez+piyNvdRmTtjA15PYrMR9n+1+g7tf+kceDQsD7/lQo?=
 =?us-ascii?Q?oGd9lSj2BdOE2B1f9PoEkRT2TLZK9G+rdRhna4zdb6mjScbHzrSMMAgu7uMo?=
 =?us-ascii?Q?W6mc9alfqMsOA7Psbiu/eUdLtrYgeLPU40HhTnXzPOHLhoXprnbr7qeMPuV6?=
 =?us-ascii?Q?5lgBvJlEgsDJN+gB7sJGEXwcXlcv36e7ujVkVq7FE6z8yeevlEWrj2jz6eL9?=
 =?us-ascii?Q?+V8biftB1MMJGcCqhLn2tjP3UUzLccmqmaBfwQOj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a12ed9-b231-4b3f-4b4a-08dd4f5a954c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:54:23.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abM+hhQm7BbDrq6ZzYXrIc/k48EaHSMmmozDHosYAMoDlvDdDVKnaO+HOj2xrDhOHL61RtiMuoP5VAjWeX5Quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

On Fri, Feb 14, 2025 at 06:52:39PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> In order to prevent a potential write for shmem_update_perf()
> cache the request into the cppc_req_cached variable normally only
> used for the MSR case.
> 
> This adds symmetry into the code and potentially avoids extra writes.
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0a7e69fd32dbf..9517da9b7e692 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -496,6 +496,8 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
>  	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value, prev;
> +	int ret;
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE) {
>  		int ret = shmem_set_epp(cpudata, epp);
> @@ -504,11 +506,29 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  			return ret;
>  	}
>  
> +	value = prev = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
> +		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
> +	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
> +	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
> +	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);


Perhaps this can be further simplified in the future using a new macro
FIELD_SET(var, mask, val) where

#define FIELD_SET(var, mask, val)     var = ((var) & ~(mask)) | FIELD_PREP(mask, val))

For this patch,

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

