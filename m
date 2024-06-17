Return-Path: <linux-pm+bounces-9354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8990B879
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 19:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B730F1C239A8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADE18EFF2;
	Mon, 17 Jun 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUzpdER7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B018A94C;
	Mon, 17 Jun 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646743; cv=none; b=YcuEBcrpCH7umiIr/H+L1IB8eMx2NnSEohAwWdwmu/HLm4XbTFvcqm9NwbQb15XYdcTBzG0oZ0LLsLdNLchx1tz1JDOpNI598iNszCzT4DUB+OAhmbLkKiP8l3/ZTdJUPDt6VrcuGiwBlQCj+xwJd9COWL/6kXkXia0yV2aOSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646743; c=relaxed/simple;
	bh=vk02w9S3tVvpEn7klolVsvvXbuaOMdfrZ5sxrW1smsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P06P0XFCPvi9RwkbizpiAY+db9dOZOHyc3yBMrAft9dSsmAmc62qvQDULY9ck46tcg/duqx36DlMStXc7aIzwAzSuGI0hT6RfwIZ6OB9SAn3jWDDln1dKAaq2oAWImCd0h0QYW3GVWKWxxBS1RrdqjCR4sMEUW8Bndd2OmwqVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUzpdER7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718646742; x=1750182742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vk02w9S3tVvpEn7klolVsvvXbuaOMdfrZ5sxrW1smsM=;
  b=IUzpdER7Yk8D85T/l4qoL4raT40PNT9WfzE3z2bdU4cjKMWb2Ge9RLeD
   OqZGhfowONo8kjAUiXPmFmlgyUbJ/yFenaFp1aoRCU+W28VtKFixczj4O
   MJXiR0PolKayN9++9su/rPtFNsKO/OpCo+DgTRC+zLvo4ypT1tpMf1R3H
   y3laRpYHIaVmIsmE6H+eOEuda0GOqyaoTzeOadRDiN9c/NcLzJdaWuew4
   PRcWuZ5N4Hr8JGNLVpHpauJheFHrNzZgS/hRKyGznWyqyC1LyNJC0OZOa
   B5mTm0XzJQF2zJvkA+Y6W5ZP1MljsO+Oo9kVAHKTjhaOXjYYSGv6O9fzU
   g==;
X-CSE-ConnectionGUID: E2nYtlNgQKKeZpzZMdlwcw==
X-CSE-MsgGUID: 1E2IJ7OsTzGllEe+Txzqwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15327119"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15327119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:51:29 -0700
X-CSE-ConnectionGUID: UnOBOO2LTdCE53ENRUeWRg==
X-CSE-MsgGUID: tXxyaKh7TyqfvgGcwFNxYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41138954"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:51:28 -0700
Date: Mon, 17 Jun 2024 10:51:17 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <20240617175117.wdldhu4qdf7gowl7@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
 <f4242edf-6c78-421c-8e21-63627b13c35f@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4242edf-6c78-421c-8e21-63627b13c35f@citrix.com>

On Mon, Jun 17, 2024 at 10:35:15AM +0100, Andrew Cooper wrote:
> On 17/06/2024 10:11 am, Pawan Gupta wrote:
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index cb4f6c513c48..f310a7fb4e00 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -95,6 +95,9 @@ struct cpuinfo_topology {
> >  	// Core ID relative to the package
> >  	u32			core_id;
> >  
> > +	// CPU-type e.g. performance, efficiency etc.
> > +	u8			cpu_type;
> > +
> 
> End of the structure?  At least that way new additions are less likely
> to add more padding.

Right, I will move it to the end of the structure.

> > diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> > index 9a6069e7133c..be82c8769bb2 100644
> > --- a/arch/x86/kernel/cpu/topology_common.c
> > +++ b/arch/x86/kernel/cpu/topology_common.c
> > @@ -140,6 +140,14 @@ static void parse_topology(struct topo_scan *tscan, bool early)
> >  	}
> >  }
> >  
> > +static void topo_set_cpu_type(struct cpuinfo_x86 *c)
> > +{
> > +	c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
> > +
> > +	if (c->x86_vendor == X86_VENDOR_INTEL && cpuid_eax(0) >= 0x1a)
> 
> c->cpuid_level ?

Will do.

