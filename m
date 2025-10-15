Return-Path: <linux-pm+bounces-36176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5734BDD9FA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 11:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B76619227E5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E230BB83;
	Wed, 15 Oct 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eNhZ0rGC"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764B30B53C;
	Wed, 15 Oct 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519480; cv=fail; b=VjHvhvO8t2XQFpVorbwVP75JbrhDuxnSlIsAHNoSo707Xjz1haURpO9JlBOD/yH1EfrTpAJLCxR6oSBvLlcIy2eZ8iydkMispJkL/dYJl939o3596ri5X/J92EqkzBma0OHUn7vwxWF7ZbPIUqzU3DTSvyZ3oY37EdFU0+ewCaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519480; c=relaxed/simple;
	bh=/EONgZKCV/K9B0riM/elagtTFYyVcbs9o7NW8vXSmeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeWCBihz6qVLtz03/gysM3u7h5UOGCaqz3xvqdzJhmHW97kpAJxuk2UpMeeS3le/c8I+T0CPkoEPfMmZLR+q1AxwKqcT0pBl6wfy5tRBuKV6t4sisUS2P9WDme/GVx3vuef66r3Ts7FN4JvMkathWw8ALtipwNG5WeoiSaeXNgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eNhZ0rGC; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrSo2h96MQQPVMCSpOmXwzJimXf9NC7Do6/A+jzwcsmoyetGKt8IH6WVBpSDBWYoMK/0No7V7jU60n62r1FHBd0Y2bcqAomlEIxUAbP3E0VVREDUtOKOe1Yw4rzTxk5rWzc44zA3wODSu2pv1msTpsVlQuEa9SpPzWGowfra90Ka3b7728lpyR3RZb+zhHosWrgG/B3H+t0zJBj/d12tlpERYwXuYBAvOBYFIvE9lrcHXMRSKXmmgKe88am4fv9oBM8/9cdRRER/RFxVFmimOt6nPDo19JiXGQ5Acv9SAfUganMijnfk+O1YceURBew/+IGJnTWjyRi4JzqhzK1i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu/S3/tBcOuhU73nIX08XWWTtQvyiTP+bTobx2xdTqk=;
 b=WZjQnsUwhzUO10cUkyjcLWor6BxhXFhQvbj0eJGfmOwzYwvTRCko2KPJI/A1M76mjNANfB/joFlcfGgYpj8Jtov+h0DziBCOtB47xYEPXtiwkzLSExunDc+M31g9+ffX5MtaLSs8DeofPWQrudNsc3ZJVcCMxkddKqcCuicUtv/tCND4AdF1d2GeP5E17o8fwJWt44vZ8zFgtMm0PY9F1/zP1o0UFtPYc3HJ25bhwOxQzWtNMfo5Bpo8u2/MGyP+0EmqkyQhpr/0gCLWxDNEvAKDZD9U+hQOMZSEYN2td4eTiq3EFyWl1ZPRc+pnoR2cj/nn6zeNUdmFe02jdGB+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu/S3/tBcOuhU73nIX08XWWTtQvyiTP+bTobx2xdTqk=;
 b=eNhZ0rGCrc0fcPllLmdFj8WiFWgl2TLi+cSwcLEx7313FU7lc2ZO8JpDgShzadn4DqubeaPqned7iBjQZCQI3aIAy7+B3SzkCw66Q11D7GLa6cx182ZDc2w99ouat1l61+QoeohTyEjFcX2zieka4Vj1by3JdITBGqYvtOIC5i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 09:11:17 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:11:16 +0000
Date: Wed, 15 Oct 2025 14:41:09 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] cpufreq/amd-pstate: Add static asserts for EPP
 indices
Message-ID: <aO9lLek9mJxrmgpx@BLRRASHENOY1.amd.com>
References: <20251009161756.2728199-1-superm1@kernel.org>
 <20251009161756.2728199-7-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161756.2728199-7-superm1@kernel.org>
X-ClientProxiedBy: PN4P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 68564e8d-6e27-4ea9-555b-08de0bcacbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfNOhA+eOp1nwI81+JdbByvEkoTlZtCfTUKl4K4NAJUP7Ps0nzArr7yGoKKb?=
 =?us-ascii?Q?3bX1L5s9gHb0TlZy/IXtQE1dC7TV0N0U/JpgUjtB62QPmWXE3GG+zDW7X6WR?=
 =?us-ascii?Q?LveuBzS2aYB5OZjB/ifCdcqVaJ+QNGDilx4FWlanI0kbEUZMfQc0L3qbKvpb?=
 =?us-ascii?Q?S8Bz3T1LExEOblu1kiMo37HV8zopwysU5fHJkxXt8C1SeiGA4TxHV1fu3pLA?=
 =?us-ascii?Q?h3fzjcw4sQje4TmQwlSRRaJQxHA/OoCw7a7VuvwpW7uBDc/HlyNRACw59Icg?=
 =?us-ascii?Q?z6HWJQNgt10LEGoR+FYf//sdAZhP22N/k7YH5P6V6di398peODbnjvP3NEJS?=
 =?us-ascii?Q?PUnZkGr8RAKpAmen6dKdbW2DmGPAQ65xdwJp5MHtBQzNTR01WnZwhCTXSKqK?=
 =?us-ascii?Q?BIQdXYOi5z6l33tUxp9LcjF/A1LtQ2a52r6anvcpHCgeS4PmYMLurYamoKMs?=
 =?us-ascii?Q?xhut+7+OjvDfFPyfJHUnge0PDfa6kj16hmuPRXzhJETrNX2TwOnfQNwJwGt5?=
 =?us-ascii?Q?7Agq/yHG68ch1pzd4kP3XDqcYRJY/jYlZwxe8JhbrZWbr0gc6pk2k8U9txRm?=
 =?us-ascii?Q?swHBEXFp9tPzf0gUYSydwPe4RID477IeCCGl+Ett5Nina3CuyLj3VKkaxNtk?=
 =?us-ascii?Q?H8d/RgNiMr9zv3QGy9b4WlnybtuS6oUcVCq3gg3BWdrKX1kUR4WMFtuyAfAo?=
 =?us-ascii?Q?sUTDYOvQwKH+2N2fJm6fQO6F2FsGmbYb0KbVK5pszmuDf2eL0zBM3IimsWJG?=
 =?us-ascii?Q?H4DcWgUJHFMVTOrvyBrygP8f9vBjPhZqKvgOISVDLwzfkyB/vb5/HDcL+Ypi?=
 =?us-ascii?Q?436oFqtNxkXA+639bnAUr3FVEHvRuMyg1r+90rTqUG1j6isAYX18Q+bB/71B?=
 =?us-ascii?Q?9fRxv4ZCXKU1xwy0jE8jkk+zXPkSKnuKYr6siRyL+HgNYO69bM2SJZkYbLW3?=
 =?us-ascii?Q?r3pqVBQGPVi81VjDMzYn19ha8qY00O1SII2b0Y58iAIbIgA983QP7GA1uKz9?=
 =?us-ascii?Q?KV/OgspzqbrrKhBkUaTSZu5gn0C2F8QYeL1NKRzMSQ1xTBofTiSkt4yxKzxE?=
 =?us-ascii?Q?sH4Lv+JFIFdZXgtgW4hS8hPKQkzZZ3KeFv1wboTA5TR/ldncaeOu6RuKXG4j?=
 =?us-ascii?Q?H3ZNAgNBD47SuHfAmIbbap9VfK45DCx/yg1GbmNirnt/6HR19rijtLTfXyY3?=
 =?us-ascii?Q?qLfIqRkZffswSnHZ/J98JiMbycVjmiF0D+KFzvebqBrLWe2ahUP/rGYyWv8Q?=
 =?us-ascii?Q?MJHm2hFp9UyswayRd9RfqLJkzZnrxKp7ahlceCYkUSxbCrCcFjQnnDI7FwfP?=
 =?us-ascii?Q?milJMut8fHDk43jnyDeaV5snkqFD57e57lttqYZKFisoqJuI74GSDXCQGAd0?=
 =?us-ascii?Q?+AFC6sig3bWErAyu53ez65dzR027oG8HNdWunDGi8A2hiGzqrMXpSjmpLwFo?=
 =?us-ascii?Q?ptSWjOjMaGOMPsOj8Y3MJNatJt4btmFi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nlVEKoaszn4e9jjXkF0TtAIrc7ukvmFRQ783t5mlDK8ODBS4wC+5629jBrRV?=
 =?us-ascii?Q?6e8X3jG+v06f5a5IPKpgA+tcXQAzaXHDKVaT6RrhbWgiwseTzUZczyqCFBkn?=
 =?us-ascii?Q?QbDlzablJvbbI4MyhrHMiNNYdNJh58NLJaqcGFDuHWKck1nA0NZRN5uQzWsw?=
 =?us-ascii?Q?IrC6JqPKZV3VdV35hOudzOLnfy0FlXrGlGb5QqWlkJbne0zEv8hCIWIf+ZVd?=
 =?us-ascii?Q?hw2edJhIwMThHW5j2MwdFhrRSLtKGeBjz7eLbNbHzw5UGifoNsWieoSq8P4z?=
 =?us-ascii?Q?3usWhA/HfZ8xfP6+VgspCRQP+BCBucc/JbxHjVYdyUASDhuKDPASYOs7cXPo?=
 =?us-ascii?Q?Z/5kkneaGvM8tC+v14sze6xcvNTYfAoycMu7cuL2meiIXwZBKXP3WSFBBT7/?=
 =?us-ascii?Q?8w7PALh4J3ssNNTVbidV5s82XOvKIO+gLUbIIicSv0EQr8Rp/rLvEcKP4ujs?=
 =?us-ascii?Q?OtldsPJ1T9KQ3v0CIalQELU8x/Vo07NJjt2jY+nfjpNFjvQ76dgmLelriHv0?=
 =?us-ascii?Q?8syNt84JHmt1z2Fv0+AMxDXq6xRUQV8NFNW1znSq5jMh07xzxchNWm0HtAXe?=
 =?us-ascii?Q?BefT4AdVng0MUCinc8Pq9n3ebDjJel37xVZr2R4BgGJRSlcXsyXhSV2xNnF6?=
 =?us-ascii?Q?p2a1+628yXhoJc7MIwoUHOYjwIVxBdJCBImMzgz11SKhzLonPiw6rxTq6z7Y?=
 =?us-ascii?Q?LYgGt1p3uEjuEaNu80TAwNiQOszIkuxARlQeAm5s/Vmo1oHLQAK9yVtiLNtA?=
 =?us-ascii?Q?KztdBQn1b1EA29AU9Eg24nweJqQfOh8SMymNZfrRytAss0QRYW2GqBIJdgnI?=
 =?us-ascii?Q?Ayf4SsIw9l64jTaXGiGtqzpsj0npoJV6m7v2K0wBwQQ9kznNblItfRcSHaoJ?=
 =?us-ascii?Q?McReqDkilm7ORoA3WXoKk9ujIfTMOQ23kdVadC/j6xuSyQKRL/e1PbjWh6y0?=
 =?us-ascii?Q?zzN93uPaSPGc/4CsFfgNPOad9oKjVsx4YzunsVpAEvCIv7VhbnaYPxQoqtaX?=
 =?us-ascii?Q?0oyC7h5Pd7Vz0HWbEYuSArAuwen51C5fe8WqZ9uL2Wkx9PVpguvvjEi88Kk+?=
 =?us-ascii?Q?sFZhfp8ZE9xy3a01jw02oP0Jg0XdQ15ox8uZdHh3w6io8oZBa5t9srrQvchn?=
 =?us-ascii?Q?3+VNzjbHsawIeRQSLhHu/RsumLo0nkpCI26FpKdWYtBGQ1bXTNi1AKaM7xO7?=
 =?us-ascii?Q?7o/5GYo2AJBRG9asn9N4AlV/CkkiAkPawtAOLKFXwLNUH1Zk2sE4uwkoglZm?=
 =?us-ascii?Q?FeB0k23i5AJ/xx0h75XPkv6FzGfSUPHC7BQlkERpYMAsxVZJ9SvWbR9Oa49v?=
 =?us-ascii?Q?qQXFyAsA38Jb8Lkjah1wNWTfbPyxS2dojOk5AXlu7mX8DdiuPuvyAXepozOA?=
 =?us-ascii?Q?cWwUplKL2iV0IV/sOFJaug4tL7VVZgipftvCleld825SAFlvll1ooXBvwIxt?=
 =?us-ascii?Q?829lK6wD/ahjXYVTJ3dgv29oTis7QK9+gaTsNZB7XNI1i4SMzBDoWVs+M8Ia?=
 =?us-ascii?Q?PF4DOjfBvjzBOvNGC96yc3xC1BqscTHWVGpf+lcHAxmeLauAjzKuHIf6E6C7?=
 =?us-ascii?Q?z/xDVrZrngjF0u1E+rqTPIqJ8GcJx2rKeENfHLUb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68564e8d-6e27-4ea9-555b-08de0bcacbf3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:11:16.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC4p1mXU1ciAANqBZXU/EauDRoQFINQ0DFrAmJX+t7Rn/sVWExMHQs/2ZHNm9BC0zYGROvz3k5pXZwm5oHZeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926

Hello Mario,

On Thu, Oct 09, 2025 at 11:17:56AM -0500, Mario Limonciello (AMD) wrote:
> In case a new index is introduced add a static assert to make sure
> that strings and values are updated.
>

Thanks for hardening this part of the code.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a0f21ac1205af..b3dad7cde46f0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -110,6 +110,7 @@ enum energy_perf_value_index {
>  	EPP_INDEX_BALANCE_PERFORMANCE,
>  	EPP_INDEX_BALANCE_POWERSAVE,
>  	EPP_INDEX_POWERSAVE,
> +	EPP_INDEX_MAX,
>  };
>  
>  static const char * const energy_perf_strings[] = {
> @@ -119,6 +120,7 @@ static const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>  	[EPP_INDEX_POWERSAVE] = "power",
>  };
> +static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
>  
>  static unsigned int epp_values[] = {
>  	[EPP_INDEX_DEFAULT] = 0,
> @@ -127,6 +129,7 @@ static unsigned int epp_values[] = {
>  	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
>  	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
>  };
> +static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX);
>  
>  typedef int (*cppc_mode_transition_fn)(int);
>  
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

