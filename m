Return-Path: <linux-pm+bounces-22194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB972A37F98
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A688A3AA87E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26102163B7;
	Mon, 17 Feb 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="08i+ERwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E301A0BF3;
	Mon, 17 Feb 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787132; cv=fail; b=Ln9U/BNeBXiLFVcO8jaF5GgqaLc8Lo7UZe14ly2wrCl0IjK5s2C2cQTtx1np4/hK1B3yFYKTDh2VogPF7g4gZvri1ifCthHsp3Hj27/E42m9GiwNaaUfplMeSVIlYGp41s9dELdklp5hbqAR1dFJqAiBdfEzwZmNt6aMtbRfP5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787132; c=relaxed/simple;
	bh=8dsPkZ1Ju1V0JUi0S0u8niOirb0OSP+5sHPgeQJczXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTONDXelFbhaHsQraXMRORqgxgkg+4vZqFjDMAYvB6NntlFQnDcF0biH0w9mh/zWGVpC8JUn2RDCIO5RHfhy0UTKMR9nPDMXwMNIn/maoJCPPT4bYpnNhnwNzc7M+LBSOKc7nHoiQJsvxRHgNLRXmdCMEDxsxNDvFFp4UvxmSyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=08i+ERwh; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxkC1A04ZDAP75tp7wAiM5K2kkGCgsxWwnjllKToq+nb2Xx0xvjhR/GwhGBlx/bpOJ+/qXpbeQDUJfcuC8CUWDsI+m4j1BY/HG0H6KbFsszu795TXvk1TrrVoEnFgzkVgRS/8eyNbpW3vLqFXqnVrXBpweoKuAYs81Qy5luVGzbDoIgDFK0BJoY5FqdtC7HnHkEzt0YOF+XZxK8uVck4B5WVx4i0320rLyGutf7SjdueC5SstOU1Ol5OpUGFHsf7E0jUkuR5nlDPVyRCHDh4G+gSxJG5+OBP/mZX3RFaeUuhi77vg8HfY29C8fnLscv7SDvVGTKuo14rSpW1ZE613Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+3kG8FOsjmqbxUW7TuWzsTkptcfFN4vhfbwgg111VU=;
 b=OYPLc7ie4NMQeV/S6ot1l9OKQ2QaUumXHSe7wmtFDB5MSPDujldDnurGsZ/4tKX1yioptVwJW55MqkrVpU8a7zHI4WlurSn2hOUVWxOgyPJn3grHECVPyrcCzrhZGGOspgnI+FgyAiGw5jrpsuJmWO6ABi5YBJDnWGK5AzfGR2zulypFeSSs/6FwFNzjSFeds0ZLWhHSEdMl3W9RePpT/a+kwYLg94PYOLnCJsXMn+As/3KsaAdNTBLYqR5BIh8DevIpPZHMClagRMo9HRuJ9zEY93xD+P9kaTn3UqmIeZEMK31+LI4MTm0o4/ZQU2uvibJL3DtQfS0MuRR6X5Ld3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+3kG8FOsjmqbxUW7TuWzsTkptcfFN4vhfbwgg111VU=;
 b=08i+ERwhLDKj5l7o6rutOGlx1BYWNPaS0q4GAbPNQJUknw/ECC1fQuNH9H2E35/4ew2lLQ8OmK3hSMHLeWLHWUneA3EHxGMYPrZ5SaK25LgE8fi5qyXQV4G0iZSC1970N401Mjzis4eJqfhM8CnaVYbP2sB6cQzYl3GeXaWSiBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Mon, 17 Feb 2025 10:12:08 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:12:08 +0000
Date: Mon, 17 Feb 2025 15:41:57 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 06/17] cpufreq/amd-pstate-ut: Use _free macro to free
 put policy
Message-ID: <Z7MLbYpQ0juUU9Lv@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-7-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-7-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: af3115f2-4d5e-4047-1ca0-08dd4f3b88e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LiPW5LF+UF6hKJIWEu4nDwDGmEyVcITJ3ImHkIMpp02w/1H2ZygrJmSwhit5?=
 =?us-ascii?Q?YvvwvOmpR+XZtCmZWuZm8BRDYVYFHwmUFFYnXs1ThEjF3tTdL8AJMg7Vui60?=
 =?us-ascii?Q?m24YiH/pxLs28yXu7VdZjjMCM3C3Xb5mRwOgf16D9ANE9YynaCvTGn54TDVo?=
 =?us-ascii?Q?h2iOi1FXgiVam+YzT+1ziTPg0LF8Ymy4Z/FmWyxv+Nr4PJxnOFnucFdezeWy?=
 =?us-ascii?Q?+aUnl0jhy+lZC4UdBjJbjX3cTnif2vIdgvqXbomT6jvsG8RiuJ3o/tza6Sbp?=
 =?us-ascii?Q?6wvPz6+Aj8YxVzcXcvMh5pSkfb14ZLveCLGrwoGRhFaj3kEKmhGZ3Pg+zXcV?=
 =?us-ascii?Q?G1g08PZkNprYT5rYTQjEW40bNUcbvZby3fNxwGejsAJ3PNBqT6BUGLhMIuHX?=
 =?us-ascii?Q?csBhHM5DieIG4Ijv9vJ+5OeRdgHXTk2OcBhJhoXS9IFJ9h6OkqzirP9K4wlY?=
 =?us-ascii?Q?TelWgNz0wRshAcWe0ugNQbPsGkV3q0M8qL1AB1hHerrNhUJn4Oiy+8fJCjWS?=
 =?us-ascii?Q?Oc2ZAdgGUKsFih0KbC8v1f9hQB+WXUCiv+6CfXl3TFgXiHLs8VW/s9QoB2jd?=
 =?us-ascii?Q?OyyrD1om20TaL7DK9SY/rwUFXISy/Gjxt9/w+cCIWdk7v/BC1gkIJbr42e6I?=
 =?us-ascii?Q?7kFKevZU2Zf2nQBdI9Pf0r6qerEvsn5lMWwpHkDwgmTAZFW9kL5fD4cX35pI?=
 =?us-ascii?Q?M9sjc51d7HWbHYqW++ocKgLnqULnepOIYrjo8/20tmoc5SKOfIOX1XWqZMvA?=
 =?us-ascii?Q?+vuKzxt0WtMRlqJ7aezcFIneN0NOICLU30ncJWYTa1D61RXds0qGzYU9UKLE?=
 =?us-ascii?Q?KWTLtVqOylAIET/XdxmX3wk/8wN6QHfrHuQNqGRYmEeYcLumBss0qfa5sX4e?=
 =?us-ascii?Q?XJkZ4i0Fj3WSg0ISeWcAaFHmbnTQqp8ZT0hScV282JflPIGZ7VKHRUg02fLP?=
 =?us-ascii?Q?P/yM0p8GG16USWrBcbtcC9Bt5w2brOqJP/K97zM58U/Fy353k5r95xdozuNY?=
 =?us-ascii?Q?co7aOmRDxRR92+3VU9xEvOF1vw27tdjd9n5owfdMM6DlonYX8kLr2OREiV+h?=
 =?us-ascii?Q?Eo4ySqAdTmZq1r8o5ByLlzm9af1hV7i7ASz2CCmY7lNig5GG79Dll+sBrujJ?=
 =?us-ascii?Q?BtYSDyJXgX4v84iYpLGgnnfM8dBkVgzM/8h+J3zK5V+nKMpjMeJLGJ5n3Q7F?=
 =?us-ascii?Q?P9IvoT5YD64bZuSBQ/rHJeRhkjcsLDRQGsAQgyQhOF8dXy64uQmjnpkhiaVf?=
 =?us-ascii?Q?h0m1JUjs0hZ0II/fy4g52Uk6lddMjO1La8xteKLzGYd2OPPelvfaUQM/CLYz?=
 =?us-ascii?Q?LXOuDwMSy43ZWgDcU2gsUmNKT7P/gC3EuvSIwOo6xTbLdyTsmbHt9uezW5BA?=
 =?us-ascii?Q?MyXYADiXoWzKDwzFuPgreNofiIKA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5yW4G6uaE3IPl0HKfzr+NV6I8tNUODMgnQfiZGIR1riZtDFxAuvGIwAKrq3?=
 =?us-ascii?Q?ICJGiAccBX+QGNfjfpA81f3u6L3dHL2I+JvMNQP7D2BiXOKPy4qBcOj7BWvH?=
 =?us-ascii?Q?pyj3YrhIE/rlo8vVY0flHgcbYeSuUzufREokQcaxoNerC8eCkITK2yCx11J2?=
 =?us-ascii?Q?tuhCPO1dPNWfMIPB4hzMKGmAdUB5tkSHx98IjHR+71CAw6GnHbNEynfXieO/?=
 =?us-ascii?Q?ajISfzK8WzrMaWO39OIJpJx5qFcoFG+Ke/B1WcBBBDVsQeNYXf0W8PfCBWsI?=
 =?us-ascii?Q?lg3dQ6ctogeEe3FzWfXaF9miCVFxRfzaTiQuQF4mXzc56s9vrKjlQbFJe/CE?=
 =?us-ascii?Q?8novIdpRXLoOjYI1OBhvRnCzynF3ppne/fePCqYENG51cfZGMjBl2U8n1Znk?=
 =?us-ascii?Q?hjinp1SIf99Hsg9uYH7sElu9XoWpJZm8uAa7ud5IusauP3zkYgOptvBJiPLC?=
 =?us-ascii?Q?wm75ImY698w/Jg0HM+D1i3hwzGKhMBJ1FvN/CgWZXOCJxEZxDk3dRc2IOZbs?=
 =?us-ascii?Q?2TRI+CRw3NP08rgsX+P9rZj5uLfrBX1hOGpj5BjZq+IAz29NHLFSedGCTr3G?=
 =?us-ascii?Q?oAd1lQMEQNdQlqkJ5pBeS+eofdQMD2jRBbVrVNB+D09GEpBTGPqwBHW96Jyf?=
 =?us-ascii?Q?9IqL7Il6vJDEe21Z9hPawqkKXDpvWEBR7MoI6k0cgHsrRkrXesriknbVRvLe?=
 =?us-ascii?Q?8Wh/aLsFBXcGkoDnwLvDU2gmwPeRXi20NHxgrtFKL8QXKfY5viGISdzW6PRA?=
 =?us-ascii?Q?85D583rY0rg0GPJXg1SvrSqtfSxaUhecz+7NBFuXGGld8cr18sEcxqnleVgN?=
 =?us-ascii?Q?KPH+EnA5OVgYpvTN189w6ka8n4XprD8cv7eDVnw3MT120xdpjO0xmc1wU5WV?=
 =?us-ascii?Q?nPSC8AMO2jJ/3rmZztCP/N0IdxKTGdhXGIHmETn7MLwyZlUzlXQR8zbtnk/+?=
 =?us-ascii?Q?g6mGSTzO01QD6DK80kF2So9f36rghVlInMzedbzOHV3/hDr4MjUFJicCbv50?=
 =?us-ascii?Q?JLrAIFHo/mHJpa2bHGM8hcgMyLSABV/3AHnOtE3V9sY48rKv2Ku9dJ0riGoT?=
 =?us-ascii?Q?O8T9165VA7D9jS01lxTkJES/6VBzoTtGqaTJECj0dfCM3lh4NBmdIeturgvY?=
 =?us-ascii?Q?Z+HRNo3EBKecjEQbsDFXQgFbu4+NaYK2JRp7+wzOLTFmriZ7RegnUgRXc87Z?=
 =?us-ascii?Q?Fhs2wdUWV7cCxwsx9F7YCp3Q3/ICFds7fixnAaiDA1EidjxyV4POJEuuxm1p?=
 =?us-ascii?Q?G8EOTzswTLz4oZJz68/tBWqYKWofXCYwptNzqZIYzScmAaLi4lAFSGi8okHn?=
 =?us-ascii?Q?SaiWSrByKdkSPftbDWcXfVYuSGQZwqJ2hggZJsTUi1nMvUySM3g9HefN9JZ0?=
 =?us-ascii?Q?C3WImAOkE91XquvmCxZBTbG87UTWDDvs6zaBlxZ+RPpvcHLhHAn0PxNwFd5U?=
 =?us-ascii?Q?Q/lGUlcHYP1e9oIMNKY+6psP4nky/8Rpcxahax+SJTX6T/BuyJTbLoLyIh+W?=
 =?us-ascii?Q?9DvnjKCpiLjaG+Ao9lASRLv+GSB0LjRsFYYOvpnIqey474me4csLoAcS5UJ9?=
 =?us-ascii?Q?6d4ykr2yrnsbQGO/WEJ++VPeOrdQIIWoaPCBqraB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3115f2-4d5e-4047-1ca0-08dd4f3b88e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 10:12:07.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC0md5OgpffQx35TS2EOmZ/BRPfI+WjOX2rrqIoos/ihXCs1hm6Iq8Jx8xOhJfrZzno24F3xZoJwl6dAIxR1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Fri, Feb 14, 2025 at 06:52:33PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Using a scoped cleanup macro simplifies cleanup code.
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate-ut.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index ba3e06f349c6d..9f790c7254d52 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/fs.h>
> +#include <linux/cleanup.h>
>  
>  #include <acpi/cppc_acpi.h>
>  
> @@ -127,11 +128,12 @@ static void amd_pstate_ut_check_perf(u32 index)
>  	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
>  	u64 cap1 = 0;
>  	struct cppc_perf_caps cppc_perf;
> -	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
>  	union perf_cached cur_perf;
>  
>  	for_each_possible_cpu(cpu) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
>  			break;
> @@ -142,7 +144,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			if (ret) {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
> -				goto skip_test;
> +				return;
>  			}
>  
>  			highest_perf = cppc_perf.highest_perf;
> @@ -154,7 +156,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			if (ret) {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
> -				goto skip_test;
> +				return;
>  			}
>  
>  			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> @@ -167,7 +169,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
>  			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
>  				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
> -			goto skip_test;
> +			return;
>  		}
>  		if (nominal_perf != cur_perf.nominal_perf ||
>  		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
> @@ -177,7 +179,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
>  				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
>  				lowest_perf, cpudata->perf.lowest_perf);
> -			goto skip_test;
> +			return;
>  		}
>  
>  		if (!((highest_perf >= nominal_perf) &&
> @@ -188,15 +190,11 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
>  				__func__, cpu, highest_perf, nominal_perf,
>  				lowest_nonlinear_perf, lowest_perf);
> -			goto skip_test;
> +			return;
>  		}
> -		cpufreq_cpu_put(policy);
>  	}
>  
>  	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	return;
> -skip_test:
> -	cpufreq_cpu_put(policy);
>  }
>  
>  /*
> @@ -207,10 +205,11 @@ static void amd_pstate_ut_check_perf(u32 index)
>  static void amd_pstate_ut_check_freq(u32 index)
>  {
>  	int cpu = 0;
> -	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
>  
>  	for_each_possible_cpu(cpu) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
>  			break;
> @@ -224,14 +223,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>  				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
>  				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
> -			goto skip_test;
> +			return;
>  		}
>  
>  		if (cpudata->lowest_nonlinear_freq != policy->min) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
>  				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
> -			goto skip_test;
> +			return;
>  		}
>  
>  		if (cpudata->boost_supported) {
> @@ -243,20 +242,16 @@ static void amd_pstate_ut_check_freq(u32 index)
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
>  					cpudata->nominal_freq);
> -				goto skip_test;
> +				return;
>  			}
>  		} else {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
> -			goto skip_test;
> +			return;
>  		}
> -		cpufreq_cpu_put(policy);
>  	}
>  
>  	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	return;
> -skip_test:
> -	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_set_mode(enum amd_pstate_mode mode)
> -- 
> 2.43.0
> 

