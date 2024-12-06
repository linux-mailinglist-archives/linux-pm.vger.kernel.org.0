Return-Path: <linux-pm+bounces-18674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9809E66F8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB7F169E64
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A32197A9E;
	Fri,  6 Dec 2024 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0obwgung"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451481AD7;
	Fri,  6 Dec 2024 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463869; cv=fail; b=LPlB6WyDmhrt0qlVcOfXCdQYv1IBrkEibEMyg8tUMdeT1KZiIiQITOHxwZKaujHomzLR89Td6zaVjXZoQT+LLlfZCkUWGIXY6Ke5r8hqCVRqIPvCLz1RofC9jEH5v6tc/9TUbhZIrv2ksnU5AqBD6UdALDrLKq3HjWMrQcn03v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463869; c=relaxed/simple;
	bh=tUTCr+QeArS3C5x1gpy5g/2ool1QgcLVTJTZYhrRMEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgY4sxTPwBwu3vHX0Hq3uUDqSaOiazqhh51QrMmC2CEh1eJHWUI9cCGtjt3XPtNTVErsD3g+eoNQldVtixvnqjGXVcvj51jguE6A0MorFM0cLqUu1YEhtIvMLlDs0TWmWYQOwoQ81YtcG2qeoi+54ljmgS2OBO4Z9gM50vlpqgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0obwgung; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/xN8/KCjcBJR4LEWCKcIqLv0bSb3d1G4CttiS9fv0GXvI3CA2yOHw0BPnfnx9D/QCIqcJTghOQa0ZC8Ckwvh/obMAAU2y4lu/ODLcTs+XgQMb7bmc6hVbDhG5JUrrgGGJOU2yMIxC6jLHwz2lQfcCJChZGUrizknL6KaPluw4Ye4y0dT0ysOJuCk9iu97/DXv2hi9Rdfxs84pgY/ZeSVMsV8FPyOGrLtGG2A6OufuietfFABZoe+sYe1pTfpEFRpRuUZPnOC0lMxYzAyyRdSMSbXyApKuO/w/+RsU4wnMMGAQzLOG0dPac5ehBGi+VixW2+xT1iwzq83X80Vl2IOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6j14jf0oKNqHLQamFdWjU0mlhAvTJ2yyP8dQTaLIQ4=;
 b=nKgTLxtAxTD+tIpnQ4WypHF53DJ2ppnB0CApH+30vbN95w8693js1NxwZoiPZkn68UnCjalMBjkLhu+EVgwAgI2BTGMMjr5J4ERPlYte+idZUtZgF67tzivy+Xz5eZRsnqex7GbYDTOXhZcWW4/1M+pNjMWcbJ3UuU3iRRSW32CZJM59XLYMAfeWj27XWHs/Lk9FDPPQzY7jrsx1jExj1tpm3Sy0WzLR43HgeXJfeeMYDL5CVKM3HZrYnlmgLp4YKMI1AkunlRW8ioRaMasiKVULUfeTPJYYDPLvODd7/8VaPnzKTwz8NUrdpIc3fREyLCbrjZ/71MCOH3l5a39ohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6j14jf0oKNqHLQamFdWjU0mlhAvTJ2yyP8dQTaLIQ4=;
 b=0obwgung5hbIK6Knvdi+Q+KQi8qYwlZsxDcZzKYhi5Ij1GDHi6+mi1+bYLjM1T3XzyrIlF6+AUcGKrNwC1RHvCsXWPkAb5CsRf2s7eVK5SF8+hEFs7aIqhBMY8Q2nadjFd6EipamGBm9qjsmG8STmIu+eVQDiPdckImoM+K8EU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:44:25 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 05:44:25 +0000
Date: Fri, 6 Dec 2024 11:14:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 01/15] cpufreq/amd-pstate: Add trace event for EPP perf
 updates
Message-ID: <Z1KPLzoKy8s35Zf7@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-2-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e4629d-43a3-4511-d8ce-08dd15b90acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaO3XWsp+ia/lgeSQva/rGkAZWaK02Fq4eFBeU2xPO24K2YjtliQF8p7mub6?=
 =?us-ascii?Q?ISM/adG5vBJIpV9OGhanDNa0K3SC3vLHlD2gQ/AJaSgIG2X+J9hXLrO1z537?=
 =?us-ascii?Q?GxTQlm0jRt6QYo5m0x/ak4jPRA4IGBA0BFFQSH2kuShMQWguF0wgjzlRU4uq?=
 =?us-ascii?Q?YN4RZG/YZ8jGPrlEYyjOAxidpePsJc3PFi0A6AnpdnK43p9LLPAg78GAzR+3?=
 =?us-ascii?Q?Uu8pKc6y2VRaiiKknWLAd6pE5+Z9/Fci5+u+NOqwu6/geID4bmEU8ZKrkmdY?=
 =?us-ascii?Q?Ydupf+IGksFCfKEdmKcgCAy3fKyQH3UYJ7uy3AdKlZ0bOdL7HCmV2g1Zh9BO?=
 =?us-ascii?Q?5N/j/tQw8G7EWsrlRwYTdmULeUmalwDPdq+f2oARIOLhuzm2VEsBbJ8VdmGO?=
 =?us-ascii?Q?VGRM1RX2hoKygMltiREYATRvs1l+wdpspcK+tzNV3bXUo9QPQY3TV+sN8B29?=
 =?us-ascii?Q?A8DT6h7cbVA3lQK5cHVt9x31Y8S+Oms+fTiSjFfmehLZkYhQyfee8cergL4R?=
 =?us-ascii?Q?HPZB/Ee/XxR1Usocm67rMNc4VlrmcYWqUThU0Wm2+pPKBu7yx878J2yhDu0R?=
 =?us-ascii?Q?P/yg79tE5n9qEdZG/wXbGikV0vHGf5xxM05ktWeCUKl9/hPbjJO7X3AO8oyk?=
 =?us-ascii?Q?+XDZraMlM4DgSO7jozbSwdWFhvRGpySiETwKt04TttHun8dDYfPDXdSFFur8?=
 =?us-ascii?Q?qXlZehbp4BffY3Zc6fwNsQ/T4Up5LlREDgd0Ecw1cPwWmMKGRdu8KSE9jMDq?=
 =?us-ascii?Q?okpeO2clv0lFuksaaw3+kHG+9G5U5rhuGomJILjLA9RoPUrYDJCpNT+oVu7r?=
 =?us-ascii?Q?rvX+N/26t8wJ6K2uCri7pIujMLwDcPWj2YaHOmPTG54+FYBxHR6NlHVN0aen?=
 =?us-ascii?Q?Rjrp3r9TkXDP13wp30Qczz0aH7iphFWKXuX7uv22KIOtg7ypPqSnqB7nCJZf?=
 =?us-ascii?Q?VlK4Qbtidyay898A8h4QXgmOOhgZhS3MnDAFT0cnXSvZT4VGkOrV7rL3Kg2s?=
 =?us-ascii?Q?NNDPK8oGp+oV1vTPEowWPMb0oIFXwGujidNRzLPv33ZhstSpW+C/oqh4/XhZ?=
 =?us-ascii?Q?5biqpTMq1aS6d9riVLGXxTGp/mAPH3FWGpG2tP8pDRDed3vCinMWq5qC/cqq?=
 =?us-ascii?Q?u4k6eV8Suo4v52Al4WU0e3MVrtYQEnEeK8tTjvYY45+Wjj3W20S4mGYqs2QF?=
 =?us-ascii?Q?LU5tCfX8KLsXY9Zo2k2NzUT1AkOGPA5+mhp8EN4ekudUtFMDJbXkF7PV52xV?=
 =?us-ascii?Q?iOxPcgtHMUDZQRZGuohoBI0VThFae81vLqDgdAJN6iTabNuY5qXrgKaT21vF?=
 =?us-ascii?Q?/XOMAwImtli+XtCtHAvalZldGC0YPeYLhws4AEKdL1CJX/0lkgziWAFvl8ih?=
 =?us-ascii?Q?0BGtvo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJsSti6pnyoaA2pbp3Bd49ATjZCX4FdCBTEs2JNr27rvFDAhhm6ekA7DwQ+w?=
 =?us-ascii?Q?3si/bH++QWG2ZgO8H8cNzR4qT4HwycmGBQP7Ef24Bxdl4La8jwRCvze33JV1?=
 =?us-ascii?Q?nmlePUvB3LkfZBKjHouBKAZXZBP+4Pee15qMjicVpCgSGvVGmoAh236GXtof?=
 =?us-ascii?Q?lDXA91fJwMP8Efgeq5hPpmpdCyghHebcqk01oTnR1tP0SUoxu2mscJ91tRqZ?=
 =?us-ascii?Q?+3L54p2EQhwrKer/8M4vRPXtPWaTMlXOqpgHlOHv+yysnsFslvWBsrWkxeiy?=
 =?us-ascii?Q?QRMJi4ycJOe48sNVT6t9AO8woLUKdF6odSuK6hV8/H3NZ+lRAUeDYSY4SULp?=
 =?us-ascii?Q?HX4FYCeI+HbSTSo29lIM4JahKcWcGDYPXJ9MCZ+MkzN92otsZdKf9+91Soq4?=
 =?us-ascii?Q?FioKMtz2/UzQRkTzhzSz6Zy31VgtmtKaMf7NHFZCeuYoSxXCLlR2T59As/Cd?=
 =?us-ascii?Q?PscvXQplE0jspsiMDBW3g6Y0jKnv7rEKygYU71AgWo63XybNUC33SSAjSrlI?=
 =?us-ascii?Q?KM5hdy54hYQvW3F5ZkHnB4GQpL/ecf2SzumfEqfBv6LuYXB+FAPDT3SQbw0e?=
 =?us-ascii?Q?dY8bM/iqF5kfFdxvi6ejcs8lrCSe+TlzsFCiSUjszR40TOrDCE88WBYh5pYb?=
 =?us-ascii?Q?6106Cf4ruMhrRGmHVsINvQO6XCiQB7/bsHHypcWisMvi0HFJ+4WeOrNA0Fnc?=
 =?us-ascii?Q?0g9p1fBdSaLZIMUPpbcL+u6TTGnVKXjzgz+SvreOtgV/kr67dzql6NLqAIOb?=
 =?us-ascii?Q?/3dvBt2EP/xTS0HZNMZ73pPouJXHNn1yA72NDLl97PV7iD1Jhgz7PpRyNN1V?=
 =?us-ascii?Q?SBVM0qEGNHPVSt/XycRHYy74v3s5E9wuhnWBM1je5Bsqq8aWQGyefp9u8VQt?=
 =?us-ascii?Q?K803sodSL9OGl60H6RXdjmBkHAZNpBOaNnQs/ApQduuH8IwaiBZ5aK5M9HHD?=
 =?us-ascii?Q?5XLuJhJU5KerX7ngI3munxNXSCufx1JR92K0uP3ywWMWrs3HC7o8ZmxafB/F?=
 =?us-ascii?Q?VaZk8HjeDZBFU5EKWX+2x0r5UOUgoZ2Dc060CaUEbwyw1OtyUFO0eK8aWNol?=
 =?us-ascii?Q?nLk8Y61Uw0/GSn3v0GH/j0aVrXWLR+bMMMCz4FihsFpGBpLsl+2GB8rHBQbA?=
 =?us-ascii?Q?EFmhwvK+lJXNtLp5+qjqYk0ic/K/I7mfb2ozNn0vdwc0ux5w0DLTkTGjuEEl?=
 =?us-ascii?Q?B5C6Z8AuLuc2IuY+ks7/NP0CfpJrFy0+q0DlTTlrooK9cClIhl9ccuyA/VHK?=
 =?us-ascii?Q?okSxXJj9qHrMntYhDtNu2U/CK+yAplPDVEe4fqCr2qLZ3AHkmelZPq607ngC?=
 =?us-ascii?Q?6tNOycZIaw7IREI2gU/Cdm3Yea5imDXZqZfydUYgpj74e3fneL5Cc32rFodw?=
 =?us-ascii?Q?IMAwIlEVnxZR9AtYsEElTbNfv/f9pkHvDomvdxoW7LYRuYGK6Ip6bkkItpCe?=
 =?us-ascii?Q?jovExbCPGe/7Rv6cGJWezZEDJ87hPHgs5phmPEdsQD/5STsVEgTIBVEwDonW?=
 =?us-ascii?Q?NzzmKwenyoHwzSI2kLbaICFSF7ewksoBX+RWUyk6V2y8LsMuVIxhuJIZnwhE?=
 =?us-ascii?Q?6v6y98Kmsh74n3JMrD9+reCMOs4YPsaSAZ0s4k9P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e4629d-43a3-4511-d8ce-08dd15b90acd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:44:25.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXaoNKECwYkWbiPvmuFpf/oLcsIo3anHTyxX+6GDZ1yHapqtzemWi5XhjClbs1qDgE88nISc4A4hMroG2Eo8YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924

On Thu, Dec 05, 2024 at 04:28:33PM -0600, Mario Limonciello wrote:
> In "active" mode the most important thing for debugging whether
> an issue is hardware or software based is to look at what was the
> last thing written to the CPPC request MSR or shared memory region.
> 
> The 'amd_pstate_epp_perf' trace event shows the values being written
> for all CPUs.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you Mario for adding this. This is useful for correlating the
frequencies requested by the userspace with the min_per/max_perf/epp
values chosen by the hardware.

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate-trace.h | 45 ++++++++++++++++++++++++++++++
>  drivers/cpufreq/amd-pstate.c       | 28 +++++++++++++++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index 35f38ae67fb13..e2221a4b6901c 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -88,6 +88,51 @@ TRACE_EVENT(amd_pstate_perf,
>  		 )
>  );
>  
> +TRACE_EVENT(amd_pstate_epp_perf,
> +
> +	TP_PROTO(unsigned int cpu_id,
> +		 unsigned int highest_perf,
> +		 unsigned int epp,
> +		 unsigned int min_perf,
> +		 unsigned int max_perf,
> +		 bool boost
> +		 ),
> +
> +	TP_ARGS(cpu_id,
> +		highest_perf,
> +		epp,
> +		min_perf,
> +		max_perf,
> +		boost),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu_id)
> +		__field(unsigned int, highest_perf)
> +		__field(unsigned int, epp)
> +		__field(unsigned int, min_perf)
> +		__field(unsigned int, max_perf)
> +		__field(bool, boost)
> +		),
> +
> +	TP_fast_assign(
> +		__entry->cpu_id = cpu_id;
> +		__entry->highest_perf = highest_perf;
> +		__entry->epp = epp;
> +		__entry->min_perf = min_perf;
> +		__entry->max_perf = max_perf;
> +		__entry->boost = boost;
> +		),
> +
> +	TP_printk("cpu%u: [%u<->%u]/%u, epp=%u, boost=%u",
> +		  (unsigned int)__entry->cpu_id,
> +		  (unsigned int)__entry->min_perf,
> +		  (unsigned int)__entry->max_perf,
> +		  (unsigned int)__entry->highest_perf,
> +		  (unsigned int)__entry->epp,
> +		  (bool)__entry->boost
> +		 )
> +);
> +
>  #endif /* _AMD_PSTATE_TRACE_H */
>  
>  /* This part must be outside protection */
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66fb7aee95d24..4d1da49d345ec 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -324,6 +324,14 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  		return -EBUSY;
>  	}
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +					  epp,
> +					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
> +					  AMD_CPPC_MAX_PERF(cpudata->cppc_req_cached),
> +					  cpudata->boost_state);
> +	}
> +
>  	ret = amd_pstate_set_epp(cpudata, epp);
>  
>  	return ret;
> @@ -1596,6 +1604,13 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
> +					  cpudata->min_limit_perf,
> +					  cpudata->max_limit_perf,
> +					  cpudata->boost_state);
> +	}
> +
>  	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>  			       cpudata->max_limit_perf, false);
>  
> @@ -1639,6 +1654,13 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  
>  	max_perf = READ_ONCE(cpudata->highest_perf);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +					  cpudata->epp_cached,
> +					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
> +					  max_perf, cpudata->boost_state);
> +	}
> +
>  	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
>  	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
>  }
> @@ -1667,6 +1689,12 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  
>  	mutex_lock(&amd_pstate_limits_lock);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> +					  min_perf, min_perf, cpudata->boost_state);
> +	}
> +
>  	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
>  	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
>  
> -- 
> 2.43.0
> 

