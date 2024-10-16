Return-Path: <linux-pm+bounces-15750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0BC9A0617
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCA11C22225
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFD206067;
	Wed, 16 Oct 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eJneajoc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D644204F94;
	Wed, 16 Oct 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072225; cv=fail; b=hUlKwp5oJ+nnokcrPNL4B70RSWyn5OruHcnOz7rA7QJ0Lfw/vkBRi3LX3zEGb+c3Tu2sohsIPNRRnVMo7/5w92iJpw5PqqVb/4oBMFPy/M6CqtMW3pjtLsnC+ANpNAAkSPSvGFyU9u1EkGbFdZrYQsXLB/rsyFTmH75ElbD7KyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072225; c=relaxed/simple;
	bh=ZaCSWU95yXy1df3reCL72X76L4iOnOB4RJLahVTl/K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZxsGQRLRfeRx98yJ2V4jNwncC4pJzZIN0RbEi1nEW2pSzJNV9iuh0nRy6z3v5Jno/GNEuWhjNUaIUnXi7k3m8BFaJ0Q/TVSSrnUVrsiFktLNdPPoTJzZ5iGUyyDA6eJ53r+5uOswQTAQGiOMG6oeZr608cNaRp0BO2kZBH10NWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eJneajoc; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydBtNlA+p9nHKiuJPO0+stEqbguPn10VkiRqIPkNfVskNOWJmPPIEn1TykrMpaJBEoyorJbw/UYn475LbVPMAzrPudBH2VyTVT7g3TNZIh2RfIjUZGQtAqyQ7HiCqsFTBUXu29WXd9kRoLNrQvx2OKi/xGag5/Yfaaj7fmjOxdiJbSpPmzbLWS39feisD12v9eyL73RJTY/s+5+ZItazu+gqt1OoeD8x1dXyt05yUhIagzJXpwMvxtxDpeTLT7Wv/Q2BzqI6Am6bYQ6PO+fL9DYOK90pjVGBBrKz6zoytgNZFhc++by61ajFMfm4spFTKLIAKyRylnRDiExop2ElIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g62j06Q//1dASWgnek742O+vDlZsvXk4GuxpMJUVvOM=;
 b=eb1MXGeeIDAQo8LUj8lRdfhHWwKt73kwvQeUn2Y3bxLxtOjcplnd+e0coGfOooIqZD6AkTlIS46vPdCfXXd1MVUE1vmf17dKZayBx+egThzmjOaTLlTbyoR2KA/HKb0yO7jljqfeofwzGhCqPKEhYV0u5sRg2u/pQz6DtA/83FRQfF91ONwy7G7wOdcjhuNmT8pCugZ/z+l1f1dEViWZFLYdPdPdbnA5JXr2hyKyy4qO37xs+eKCUqRFTHKHtKe/GjgqjYOHZ6gBJG49kBd7vqZJ6JjrWP5GFODYIJoyFcNexjEzKQ1lOn9tu7i3CoULi6UOE/vRL9B/S5IC8QPxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g62j06Q//1dASWgnek742O+vDlZsvXk4GuxpMJUVvOM=;
 b=eJneajocVkYzP+WJcEpbO7z7QIkvjCzeY2nQK8gLPNx1w3vdRfqIpjTEVa25JPJIHIJ7w478z19In0F7wjAPg8li+K5O/AB/6KI4cCDu2/Tf3EAFuZkDZF4Cgj8GZBB2VWzO6/kdKy+VxSnT/Lk6a3vwFUrzpddXKv/xlIV2ZPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Wed, 16 Oct 2024 09:50:18 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 09:50:18 +0000
Date: Wed, 16 Oct 2024 15:20:08 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 2/4] cpufreq/amd-pstate: Don't update CPPC request in
 amd_pstate_cpu_boost_update()
Message-ID: <Zw+MUOYw+nMuQ9Nk@BLRRASHENOY1.amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-2-mario.limonciello@amd.com>
 <CYYPR12MB865575C121660188BDD977B89C462@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR12MB865575C121660188BDD977B89C462@CYYPR12MB8655.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN2PR01CA0242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 483cfb41-2fea-4e94-4a6e-08dcedc7f117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n0OLoAqUrpEH2KK2CCIaVK57/m3UjxB4T0XK4z2JIgRNXGR8oO+VGONMAa3/?=
 =?us-ascii?Q?MRsVOUiSsmhW4LJUOinq5ZExylty0etZw9Su+JS8hBpa8YilfhiGxMyOTmRE?=
 =?us-ascii?Q?ZHxSHQVt/7z6JfpD7lPJxV9/AIez9BwrGwaWAp1wmHxGSzPCh9hx2P2eTjlP?=
 =?us-ascii?Q?0RJLDoVQSefyBBWpi2zo/npx3hpSRDEbwwZvf99yH87Ojpj6gsjRbfPi3UqS?=
 =?us-ascii?Q?eCLpx441MGP5QUXtB8bMXb/U6gcKzaTa8rtkAwW+LlrDcVOkU1jGg3s2G3d+?=
 =?us-ascii?Q?bMD+nSnhAlu5IUc9vLHSPWsdng+38pjqI0w8LdyWvunNomqLoz6TxkiCmXhh?=
 =?us-ascii?Q?sqPSKDz70H8ma5399BFlc41Lgzac/zFNzuBgdopI7qfXnigR6xBA0mVKahrW?=
 =?us-ascii?Q?3yfx2yZyvewsqfMdhLpRCJtbWMfco/W6a9Mt+0dO6cAEy/q6KEyMtCAXL5xA?=
 =?us-ascii?Q?HnPyT2WFqBoRU3PhglMp8VidEVq3lMe9meX/2R36EvT63BUYOIq59TD9tFd6?=
 =?us-ascii?Q?GYCoEvnOeDmsVQ/F7WVK5PGviYwot61O9AwBfB0QikkJkI6RX5T9SzvwUql8?=
 =?us-ascii?Q?yi3G7D3b5Y0dKMN42BfxAkkwl60da3iYL1W2MWaynKzuijJwG+th9qF94eW8?=
 =?us-ascii?Q?Vpg/9CwNTWWV56zWAbiesU7ImihxMaQXeG8Q1E8701AcpMKuYHu10R2CLpk7?=
 =?us-ascii?Q?nZwk295Ckft4eZrpxpVKW3hQM+EMY+6wQSy3r9IlrDSMijcA+yxVIpIgrLYl?=
 =?us-ascii?Q?aijeu7/Gpobnef6m2kVZsWE/N3ByTG8dry99vVGrEnpJkvtPF6wPi7XcNMqe?=
 =?us-ascii?Q?iDaocajDYeKZ08OpWN4NFpNaHxMMIXo+RIpV4TvDEM0L4f0TMIdA++ILtH+z?=
 =?us-ascii?Q?RsMhpR62UGhMC/77MY6X+W25iNFgi9Sxsqn1k71bR9g8uf47RXVp6aNls5rf?=
 =?us-ascii?Q?y2/rb9ovf+DS7xMtMZSYSK33rgtxpNUaNasB1tjClXlbXsNfroRNRaI7wRec?=
 =?us-ascii?Q?dSRSy0ENVGZ1KtH3470OyH9kXDzGO+LqEAVya1zSc71/fklKxO8TnjKepBkT?=
 =?us-ascii?Q?K5unjUfw8Rmenq7/WlWbbad0D0rU90IRyZ3tKmYv8tMepoVY9BjHpe7yVnrQ?=
 =?us-ascii?Q?gSK69ufjPkhNKo85cl/AjFtYtSJ4gZ/vaArBkU+LreSRiquDNRWdOSCkCsb6?=
 =?us-ascii?Q?HEwe5FYsPF+ZTEOV509XnCNnuPal/0cJogJPPB8fMZ3I8Bk4EF6aWzFOMMo4?=
 =?us-ascii?Q?hzWyko691S5WcVkseMAXbj3XiaZDzbjohUNRbW/hsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cFmxV+iiQ/utS0Eg0SqPG/SzyxldqvALqbAh2HiELwGZD5Q4Lt19xnLHQutO?=
 =?us-ascii?Q?DzZdEezr7w+dbva6HRRza4J46t67L5AHwI6ynb3/LAXW2+1p6gey9K2f+gqq?=
 =?us-ascii?Q?1Z3QAioWGJ5h12W4XrgTHJh1Pq4DipIPNErtdtUqpa+LihkXhH2uZlItGXFq?=
 =?us-ascii?Q?SpHhg6xMrvWPKbc4RrmEF4qCEv2/Eu22/HnQnW5iCklxfevrmT70lCGllKt1?=
 =?us-ascii?Q?7SHptQuJeCv5Wz/LMbwm2qQOXoSAYvVW9ydDKVlpE0ktveGzuJpp0GRGh6R7?=
 =?us-ascii?Q?NGbBtqWKan5yFiw74Fk0ugcspLdIq/YcNJlVKjwbT/QwqJfKCyWnbOfhZN7r?=
 =?us-ascii?Q?JUEMZ5cClGQRMV7Qw8qA5QUTm0aY9APX9el4CAhS4FfLrty9rtX1LKuj9roQ?=
 =?us-ascii?Q?S38xTP7caTQkJhBk4FSQaUtCRt2j5A3ZBV0YhZhARpBJj0msYbGpHXOstNu0?=
 =?us-ascii?Q?i//OaTqmxH5vRvfuF9Ad5t5Q3dFmnvaflGsWI1JvF/dIC9q7gj8cS3Gp3uPh?=
 =?us-ascii?Q?/FYUrkHfjlywktL7x65hsijbHxea0XmC89QCA4hmLIC+d6lr1ofJq94m1cJX?=
 =?us-ascii?Q?Our6vzwdoFv+8bB5XQMyQsO3hzhHvL9SNlleUat508HbvWD5grW6JpNstEh2?=
 =?us-ascii?Q?eNs1/Or623jBONsHSgFYyf5Re25RyJE5URAT3pHGNVFKm8M/hHeJioRD+Zol?=
 =?us-ascii?Q?Yaw8EMclHGpz9kTCH+6ZHpVRor3zKOAQMQVC7jusgoOFmd+KywaPcVsJnSMx?=
 =?us-ascii?Q?bEQYl0s/i/ik47KXNZpalbeyt4Jm63G8mDK8cpIoG7wJ8Sq33ffO8xeB0jV0?=
 =?us-ascii?Q?yBOzkfN77EF5i7kQPq/q3IX4A3d1B+dUvgrrDHza1i0AzDBZFb9fvc7YhTfu?=
 =?us-ascii?Q?27AL2tRxg/7pPFmuH5L3LCxKxSxP9m+9dS7QuV8MmZAC1FC5/0M/bg1vQJMo?=
 =?us-ascii?Q?Q7VjSHHR4YCQdwjRzMK03JEInhSRcMMLDDqZaNpMgE1FhznN9IXfZ0vIVHUS?=
 =?us-ascii?Q?qt8abTu6enTERrqixXks+IYul05APjWs8biQZ6kPSLUMuBCm6xbCl+tfRCMB?=
 =?us-ascii?Q?+r/MZ3cFbLmtDxWP2ZKltXQ+AOAWo3kfHYFvEeZ/r6ueOzkpYMwldCYWCfvm?=
 =?us-ascii?Q?jP0fEtVosm3lEJdofcY1NHkue0xvGX+X34n1zUjpK5PpWd9M3cdx2SH2yNCN?=
 =?us-ascii?Q?gN7r+4iXmMiLOATRnWIAUib1cuAPCBXQ8kQfkZ5NvHFCHo5Um43JncfNzQMQ?=
 =?us-ascii?Q?ofjW48dOD8P3tqJb9StsX/4a0J8hZi7amoIgXlqjOnPJg5nb+Yj3GKZEX2NU?=
 =?us-ascii?Q?ZQcSSgDa2ReZ5F7us1+u4Nnf5b0llFa1/cdW4vx2+rGcBC0IGifQTSFY4jdq?=
 =?us-ascii?Q?UPy5jh4W2PRSOHEVI8yexivkH4VUxS1CWZsGxixyTp3lgFCDAhaEYEtDkT4Q?=
 =?us-ascii?Q?HWcOIn+jLPl3ULqayaApP37eiI+6sZeQm04be1ZHsxtPM6OkNDpwvxeHXIN/?=
 =?us-ascii?Q?z1XUa7rhkzOg1oN1ytNuT3S3UhwQzS9vjRUbd32gwdFsv8xMQC5npclOMmGJ?=
 =?us-ascii?Q?59/EzZ9o6QhYYUEtgkSooolG+pBMONwr78PxMbSr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483cfb41-2fea-4e94-4a6e-08dcedc7f117
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:50:18.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi2ZwOgB/Ve+NvFpYT24qu+dgyYLxlPUlW436pg82puFnA4PdkVdP86hVVJwmGpe0o1qkyq5w/VG6QkWZg22Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

Hello Mario,

[..snip..]

> >
> > When boost is changed the CPPC value is changed in
> > amd_pstate_cpu_boost_update() but then changed again when
> > refresh_frequency_limits() and all it's callbacks occur.  The first is a pointless write,
> > so instead just update the limits for the policy and let the policy refresh anchor
> > everything properly.
> >
> > Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 24 +-----------------------
> >  1 file changed, 1 insertion(+), 23 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c index
> > dfa9a146769b..13dec8b1e7a8 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -665,34 +665,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
> > static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)  {
> >       struct amd_cpudata *cpudata = policy->driver_data;
> > -     struct cppc_perf_ctrls perf_ctrls;
> > -     u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> > +     u32 nominal_freq, max_freq;
> >       int ret = 0;
> >
> > -     highest_perf = READ_ONCE(cpudata->highest_perf);
> > -     nominal_perf = READ_ONCE(cpudata->nominal_perf);
> >       nominal_freq = READ_ONCE(cpudata->nominal_freq);
> >       max_freq = READ_ONCE(cpudata->max_freq);
> >
> > -     if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > -             u64 value = READ_ONCE(cpudata->cppc_req_cached);
> > -
> > -             value &= ~GENMASK_ULL(7, 0);
> > -             value |= on ? highest_perf : nominal_perf;
> > -             WRITE_ONCE(cpudata->cppc_req_cached, value);
> > -
> > -             wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);

So, for amd-pstate-epp driver

refresh_frequency_limits()
  --> cpufreq_set_policy()
       --> amd_pstate_epp_set_policy()
           --> amd_pstate_epp_update_limit()

will ensure that the MSR is updated with the is updated with the
value after Patch 1.


> > -     } else {
> > -             perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> > -             ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);


refresh_frequency_limits()
 --> cpufreq_start_governor()
   --> governor->limits()
      --> cpufreq_policy_apply_limits()
        --> __cpufreq_driver_target()
	   --> amd_pstate_target()
	     --> amd_pstate_update_freq()
	       --> amd_pstate_update()

So these updates in amd_pstate_cpu_boost_update() seem redundant.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

