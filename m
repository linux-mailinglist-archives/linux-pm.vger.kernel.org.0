Return-Path: <linux-pm+bounces-17572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9E49C90E2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D573280EA5
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4318BC21;
	Thu, 14 Nov 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X6mrRpuL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AF2AE8E;
	Thu, 14 Nov 2024 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605813; cv=fail; b=eHbd6PP2S/BfPEwVWlfsSn4xxgtHz1LIKiu5VTHEkgqh1z/4q36kzyg8OZwGQM78NSIj+YjzfMBNHv812pdZWHjppYGeLX2O9qSMuIS7P0Kdg0989osjhxuwyJo3MGg8pMijm/WbP7B3I0TmNbrL7PFStOsPXQcxNcEEIDd+MUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605813; c=relaxed/simple;
	bh=1C3orRMGSwzTwowtmfkFdCFC99G+zpsTLr/Av5CdiJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fYxmrNWfVlPP7fz4UMZ05yPnNFfP6/gYCEeG+LOE46SJo987NCx+a2A4wILHr16jJe+sT7YeQl4kH/KG4BHTb2664OrHWrjjyY0b96zUDoNv+Wk1iLyYTptZtcWQTgyQV9ZsiNKYlw5XVdQy/U8TBBSLwWPHLsfOg1hrVRHZjRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X6mrRpuL; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLFw/VxiNN6E8KKeqFXCLnTm3Gvl3b4RvbT0uaIO9k3YOVkN7qfbPNb5VkBD3nsdf6u+M63yP1njl4NjiMKaALJ1/6EYrESRpXP5MKAE183+f6/2HLJApPH1BQV96XchMman4QpUGXyhlKcpaWvvSOHpbUe2/v2JBn1xFFBOMIX4Xk00v1ABggkS7twrimJQQ54NUhj9Zb7IwEvXsJatRh9lFPK2qRDRl+tMGfwTU5i2syUWAgYmkWDZLeQ+Lzfh4kImiPWce0+UvteXDGlGdhK8C1SiJQLczjbQ1JdGN5CldL8hhTZm1xSSaeWtPDhpFPuqNrGLxP7wZTEE3qrQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFaZwlXMm154RyzvoO9SPFgT+R+gc8riXsKJwfhE8n4=;
 b=DgOO+Nm/SwevfGaGxbcUoDREy0lU/4wcp1y8zir7F79XXHBPewCBfjudcuis6TZEhLhTX4HC14yYT/+F99Ro5Q6CXh3166eiyMqO8hwc8Z7q6iYbqjvPJj1LPvHLSYGvk+mLVhH3w4L9DKeRbACIQxXVGg68rE5hoGKDIm5Wg+n6V5lJPIXYoOscvUbHRFgYOA3CIloKkW3yt2ag1Cwuv6Vh5HBhzAQ7qPic5bFR9L/AcVEmHKxrbWFpTu5DltBSFgEVqULVTukXaUiICKzkcg+KhKipSWzjYYznpGb4J8u+iu1fHY7JJffa3k2BLBFhiJKSoWLBewzOAnSWB+V1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFaZwlXMm154RyzvoO9SPFgT+R+gc8riXsKJwfhE8n4=;
 b=X6mrRpuLd9lU0Nho5+/EMTZ+/hzTHebW8IhcOe36xhooztiiMduzACrVuO+EA4fxnNnKl0/OvuzOweSDEmmw6zClqsIsnAz5dvuDhweU+kERZldNfIVbqcFCCXuKaqPRJ6rRGJNOigo6REGqkTr3EegkzDY81YjNmJ3e6iXM/44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 17:36:48 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 17:36:48 +0000
Date: Thu, 14 Nov 2024 23:06:36 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <ZzY1JJequFwJr/of@BLRRASHENOY1.amd.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241113162222.GA24625@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113162222.GA24625@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 08409df9-b317-4f28-195b-08dd04d2ea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJgRM1NElmb/EZrzXVDx1AVWLk3lErlTqt74RJc+xUCk786PMCaDH9RZ099F?=
 =?us-ascii?Q?5b5WXXdzJtsj7E0U5s7bW0gQQJTy8ClZjXKzPNKa2/0zfQUN+e+VjAlfvKRY?=
 =?us-ascii?Q?4bEsy7IU/pX8d23mVxSdxBmNO2dNVhVobHHvrmduuMphVQldr/9mQ/Cxwo3L?=
 =?us-ascii?Q?s/0qN9gK0laRFKnUqHWyzJ9R3PVQnmbMrrSApxtK8aBPSbv5qH9w51rzZH96?=
 =?us-ascii?Q?5PTGxFr1+Ki+OS2K6TPU9bmBnnDOePIqtVI9sksFFTw+cgGnwmWjLRXwelN5?=
 =?us-ascii?Q?UKXBplPb/AstWyU1xQRHFHuEsMvJw4VV6v6kGp752i4OjME3oxuzQH0Pv7K6?=
 =?us-ascii?Q?899jw6LCZDx1n3/0bFSI0OAS5cVHYTj++Zw2kMi2QMhUJyu2Bjy6Rnnp5ooo?=
 =?us-ascii?Q?W9O81KCv525R983w9vlMrs5BLHzsEbc4yh37qByWSB3Da8PBHuCRptrFZM9H?=
 =?us-ascii?Q?g7zGPuA0Yqwe6443of+jtwLO4OjksIX98mkFxp4ZXpmF/fQtAyQG35FO5sZl?=
 =?us-ascii?Q?cdT90g3EMAu3hqBbjSH1KAIUgpKO3JY1ThIhtvohdxD3NGC1QIuqbyphC85m?=
 =?us-ascii?Q?kaCjS0VVdTN4d06giR4+QXMskHA0jJPC1kLMRJhkMrDu1d0ena0bIFz26qzA?=
 =?us-ascii?Q?DSrOmCOBrD0GUcSp3Qcnil22qwydMxgGABin6UqMsqUCE6/TpSw6SXyGdjbS?=
 =?us-ascii?Q?bRTHGf9Dj+T/c+ZbEEBCtnOSiTRroA8ljdpn2OtA3GjuN/Fpx9fapPkAbwx+?=
 =?us-ascii?Q?ushoeaulkuv2HdR7rgSwerVQzcy4PzOoNCnvGoVQfY/fvVWh5WXvZJH8Ew1g?=
 =?us-ascii?Q?0hVdLju5mlxt3XPitLnzgOaeRKQyErM1urmRmZEKLSjgBffxJJ+w7K+oXsVM?=
 =?us-ascii?Q?zhWCGUlDMXRAYVQg9ucZ6c5CkBio41F1STTqT2JHX0JusDXz8Xe2KLLi1jE6?=
 =?us-ascii?Q?xtcZwyIpwQqXd7ldjwZ0QRfp09N+2QFQ2lLj+X8CIUpEEbg70IfXRxS8bFWg?=
 =?us-ascii?Q?5NVBgknCj1JYqCrTQe3RPVR29UhoXscmvr+5izAOzmzb4bk/OmbsmsRPK09C?=
 =?us-ascii?Q?jZrQU8KFQqL9fKvTKlbOSZ1ylEw8tnPSfq+eSFr9WD+evRpUr52VTd5YGSWM?=
 =?us-ascii?Q?igqVBAGm0V3q787RdkWjIVcdrl7oaYVfRW1cMcTatw1+9fsb/9RhteRst9h0?=
 =?us-ascii?Q?/cvn739BsO596fc/VbZ6V9EornyHVkAyFndWB/EAU7gvU1GZlzadOQAl2maS?=
 =?us-ascii?Q?YuOOjT+ZDGU6v1wAL8rqdnyNp5rvtdGxtS6PEkXU6XFxOV4gp5d/0NcRVQtl?=
 =?us-ascii?Q?hEQdr7P9/57tadNnfIw+Rs2k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZHs+JPeNihkFGZKRvisY5rhKhRHQdWrU50F+RvZVDI6SR5G9WSVGXksDuMZ?=
 =?us-ascii?Q?7nLxuEsSrbmI72qUD/JiAo7+Run3zH3cOnjNjdVD8cdD1jHsGVAYP3/4Mh+M?=
 =?us-ascii?Q?lHYBtH0vQAM359rJ9cnXoA2oTOKC1zifwysdF0rVt+0O8KKjEqirtEZ1HHa+?=
 =?us-ascii?Q?8bLBlcERbkMo8HOnB+AecBOFySIOVjZDcSTtrjHktI2Ikf+qb9/VbLrkOGva?=
 =?us-ascii?Q?O9URvFD3kcKnPmoaX1CpTprl5L2Fh4hmFPTGHvqONxEUN1DOWqvlGX8Ft0Gd?=
 =?us-ascii?Q?YzOefGQDb/b/cvPI+B6pO31y9MajzoPcqjjyR9rpwk6yMDbkd4dXh7b/mqc0?=
 =?us-ascii?Q?x80Utnvtdz2VA6VTPZG2uxDiOSh9HW+lDHNPr5HXuK95U4hhDftvMls7f4jv?=
 =?us-ascii?Q?cnQdLSBHQ/ZUb/Werr0pnSd4fX9cT+3XNY+1ecGuf3zlCQ3w1OAYOK9j0nGm?=
 =?us-ascii?Q?7jUIBt7mNVHvD/q9k+gV124QaEe84Lzzi9AABfA/LPVU+uaTGoukFSB26SM6?=
 =?us-ascii?Q?p/o8By8lvUXb8QINJokhGVJtH+FNOw7vKnI2l1rjom0FuMCzDoM/4VmtiXOC?=
 =?us-ascii?Q?SKa0VXhnDzu9+figRU8JW9iZzxo2zah750hf0Uvgqbc3DROMK4D4IIhwTQOS?=
 =?us-ascii?Q?yYjhxCNgSNeJdrlHGU53botIlsBBH7ssR3Z1FphBH3o8fbyEKKB8zF5T1B3y?=
 =?us-ascii?Q?ifXxh+6WS5hC6yXvbAVSQk6NTL1U6npolzQo4VqkDQk5hR4FEGUBiacFa+qN?=
 =?us-ascii?Q?vE58gVgt9fGFxfKGeuAriJ8tPRJBbzQKV/8LpYIhhzzMBBF9EHc9Tte2069Y?=
 =?us-ascii?Q?eleEcpr4wGs4tJlWv1CoMyJtKQ/h4e1TTvQjkpZ5KLVsjuw2yQSR7lSZpVgz?=
 =?us-ascii?Q?JLvLTLCV1W0VGwA6lMkSTFyeHzMkKFjqfdm6siId3OzXrBp2OFeEc8Opq8IE?=
 =?us-ascii?Q?6unwagYxf+w3AADgNgbm1hsyRpC7NardZcfKK2Hrj01bzbTDmd3S9k2L6UoZ?=
 =?us-ascii?Q?AjJSQa2+OaQE9xO5vgsWZlYC/U6qn5ocbq2EaOjcBRZd46JpBtrjjFst1apL?=
 =?us-ascii?Q?ivj9WeAg1UcmcAdpR5crNTqUyOERopDNkVbkNFtYa9rrKgX/vmv79bo3C5RG?=
 =?us-ascii?Q?uNJUtrPgGPcIy4tlyYKrIRFixoDspSkbgRrpqf/gceHZZhkDvhGaJKlpv/24?=
 =?us-ascii?Q?gdSCkj30tYZVhRZ8NBJFIYIYzLQe2k6zkuFlh3V6LTsF73/QjCd+w19nLwyx?=
 =?us-ascii?Q?r/9rc8lttTInGRdFNydKd5iMTSXKK5PqO49Fg31hg9irEZavuqzwzHstMr9J?=
 =?us-ascii?Q?FT/7FRrlM5/nHqiHtdEPAnSPhClC6wP4bNQ71c8CmoJz8aIo1xM7Rbwu+SK9?=
 =?us-ascii?Q?X7UdeyZ05WQngsGi+Gb7QDaoHlSGY5uj7ps5wR9vrmXdYZpE6j8LSxjZFMTE?=
 =?us-ascii?Q?XBpaZXP0Dij2cZkum4rNwtzXHs1mBte7V+8IXQm3EGGUx39It0tDtGHWHtpa?=
 =?us-ascii?Q?fR4k960E8RieGOf5OOD4y1i5jFWJLXFQe2dl2/q0irURYFUuBOBO/5URG0IC?=
 =?us-ascii?Q?uqKaXi3uJtFYmZvjxBvwiQuCOPHbMv0dGp0M2ak/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08409df9-b317-4f28-195b-08dd04d2ea3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:36:48.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6gq6VA+D8zYYVnPCOtiQHZ/Rzg+wNBDbgedAtBHwxtOCZSwlnD6Tump35wKODp1kh0QvCKjYUXr3sYJmBaR0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

On Wed, Nov 13, 2024 at 05:22:22PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
> 
> > How about something like this (completely untested)
> > 
> > ---------------------x8----------------------------------------------------
> > 
> > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> > index f3ffd0a3a012..bd611771fa6c 100644
> > --- a/arch/x86/kernel/acpi/cstate.c
> > +++ b/arch/x86/kernel/acpi/cstate.c
> > @@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
> >  
> > +static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> > +{
> > +       unsigned int cpu = smp_processor_id();
> > +       struct cstate_entry *percpu_entry;
> > +
> > +       /*
> > +        * This is ugly. But AMD processors don't prefer MWAIT based
> > +        * C-states when processors are offlined.
> > +        */
> > +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> > +           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> > +               return -ENODEV;
> 
> Are there AMD systems with FFh idle states at all?

Yes. On AMD systems, the ACPI C1 state is an FFh idle state. An
example from my server box.


$ cpupower idle-info  | grep "FFH" -B1 -A3
C1:
Flags/Description: ACPI FFH MWAIT 0x0
Latency: 1
Usage: 6591
Duration: 1482606

> 
> Also, I don't think this works right, the loop in cpuidle_play_dead()
> will terminate on this, and not try a shallower state which might have
> IO/HLT on.

Ah yes. You are right. I didn't observe that cpuidle_play_dead() calls
"return idle_state.enter_state". I suppose the solution would be to
not populate .enter_dead callback for FFH based C-States on AMD/Hygon
Platforms.

How about something like the following? I have tested this on AMD
servers by disabling the IO based C2 state, and I could observe that
the offlined CPUs entered HLT bypassing the MWAIT based C1. When IO
based C2 state is enabled, offlined CPUs enter the C2 state as before.
If Global C-States are disabled, then, offlined CPUs enter HLT.

This is on top of Patrick's series.

I have defined X86_FEATURE_NO_MWAIT_OFFLINE as suggested by Dave to
prevent MWAIT based C-states being used for CPU Offline on AMD and
Hygon.

---------------------x8----------------------------------------------------
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Thu, 14 Nov 2024 14:48:17 +0530
Subject: [PATCH] acpi_idle: Teach acpi_idle_play_dead about FFH states

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/acpi/cstate.c      | 14 ++++++++++++++
 arch/x86/kernel/smpboot.c          |  6 +++---
 drivers/acpi/processor_idle.c      | 24 ++++++++++++++++++++++--
 include/acpi/processor.h           |  6 ++++++
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 05e985ce9880..ceb002406d0c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -236,6 +236,7 @@
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_NO_MWAIT_OFFLINE    ( 8*32+23) /* Don't use MWAIT states for offlined CPUs*/
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a3a012..a5255a603745 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -215,6 +215,16 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 
+void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+{
+	unsigned int cpu = smp_processor_id();
+	struct cstate_entry *percpu_entry;
+
+	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
+}
+EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);
+
 static int __init ffh_cstate_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -224,6 +234,10 @@ static int __init ffh_cstate_init(void)
 	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -1;
 
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON)
+		set_cpu_cap(c, X86_FEATURE_NO_MWAIT_OFFLINE);
+
 	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
 	return 0;
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 106f26e976b8..b5939bf96be6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1285,9 +1285,9 @@ static inline int mwait_play_dead(void)
 	unsigned int highest_subcstate = 0;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return 1;
+	if (boot_cpu_has(X86_FEATURE_NO_MWAIT_OFFLINE))
+		return -ENODEV;
+
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return 1;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 831fa4a12159..1e2259b4395b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -590,6 +590,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 			raw_safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			io_idle(cx->address);
+		} else if (cx->entry_method == ACPI_CSTATE_FFH) {
+			acpi_processor_ffh_play_dead(cx);
 		} else
 			return -ENODEV;
 	}
@@ -772,6 +774,25 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 	return 0;
 }
 
+static inline bool valid_acpi_idle_type(struct acpi_processor_cx *cx)
+{
+	if (cx->type == ACPI_STATE_C1 ||
+	    cx->type == ACPI_STATE_C2 ||
+	    cx->type == ACPI_STATE_C3)
+		return true;
+
+	return false;
+}
+
+static inline bool acpi_idle_can_play_dead(struct acpi_processor_cx *cx)
+{
+	if (cx->entry_method == ACPI_CSTATE_FFH &&
+	    boot_cpu_has(X86_FEATURE_NO_MWAIT_OFFLINE))
+		return false;
+
+	return true;
+}
+
 static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 {
 	int i, count;
@@ -803,8 +824,7 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 		state->enter = acpi_idle_enter;
 
 		state->flags = 0;
-		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2 ||
-		    cx->type == ACPI_STATE_C3) {
+		if (valid_acpi_idle_type(cx) && acpi_idle_can_play_dead(cx)) {
 			state->enter_dead = acpi_idle_play_dead;
 			if (cx->type != ACPI_STATE_C3)
 				drv->safe_state_index = count;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index e6f6074eadbf..349fe47a579e 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 				    struct acpi_processor_cx *cx,
 				    struct acpi_power_register *reg);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
+void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cstate);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -300,6 +301,11 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 {
 	return;
 }
+
+static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cstate)
+{
+	return;
+}
 #endif
 
 static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,


--
Thanks and Regards
gautham.

