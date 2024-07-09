Return-Path: <linux-pm+bounces-10802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B092ADC7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 03:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898F71C20A06
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D02A1CA;
	Tue,  9 Jul 2024 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUBsjP7e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D31FA1;
	Tue,  9 Jul 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488272; cv=none; b=XMVIAg553Ajv4l8j+KWUMoGXD+nf96lpQlT9jxD0GSbVbv3NlPhx+H+JiN+FCzPCG5VA68iSt/xTUeuMuf812QUZn5/d5NTZAwtMUjjlN3R9HQdGWY9tho7OyRfPFA2BFBI3koAVhwEcYcHkm4HmzoJcOjxpWfDkAw9TJZ0S09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488272; c=relaxed/simple;
	bh=AM1zc3TOLKbEMZJL0FayxJ0kf92Lx9TMSEFQSc/xuYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh9Qg7vXdlHBMPIVCr3heUQQi5yRcRLJTHZqX1m+vu72330O8qtCjATr1CPlJCSRoX58irecSjkXONveMfv5t8fMcav03vQrnDQw0LTIU4xEH24DxjhLQvUS+t/78+vyevSKu6Wkb2D7DZHhdFodDGvmyOhqho1+9Rc4gpbc1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUBsjP7e; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720488271; x=1752024271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AM1zc3TOLKbEMZJL0FayxJ0kf92Lx9TMSEFQSc/xuYc=;
  b=DUBsjP7eQ9CJ4vJF2B/E/y5kB5oaPkemSTRJTQnChQFI3Ef4Sdo/84Fs
   BfIn0Dx7KhP8OorAZVqjAYrEuefWE4O/XKsKoOxubRjn1Zlb7hSf2p0ii
   cNfTk0BJBviE6ps3wQrX/UdICZsx9BU1s/Cant9H6VYKvChqgaSU624mE
   1Z8e6+D88Th3SqxRwko0yCfHOTsn/+zhZMtGpvk6CuT05PTiN6kXMGSCM
   20HzRgF2KQsXgzC3gzSPOL3n/oJnnq/ABHlVy/2OC2jpxcn+orwEF4MB7
   SlFBdjTSJw1uSHIE54ZF7uI6DLF8d88mrE2Cnit8vQ8XdqVPZgRAaoWRb
   A==;
X-CSE-ConnectionGUID: QZ56jPtFSsGlIA7b6WASWw==
X-CSE-MsgGUID: rYqJn8JGQJWks+e0/FH97A==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17923110"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17923110"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:24:30 -0700
X-CSE-ConnectionGUID: EfAJ4DG9RtWvvkvGLJSbSw==
X-CSE-MsgGUID: C+Qh1yJBRXasDZT3JpnKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52488322"
Received: from salbargh-mobl.amr.corp.intel.com (HELO desk) ([10.209.72.151])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:24:30 -0700
Date: Mon, 8 Jul 2024 18:24:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 1/9] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240709012418.jyzkxvp3h4p2oda4@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>
 <20240628080305.GEZn5uOSnW40fVgaNA@fat_crate.local>
 <20240628173209.wzpc6pwnw4p6u57h@desk>
 <20240703230724.GEZoXZrIavchI2Kj-P@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703230724.GEZoXZrIavchI2Kj-P@fat_crate.local>

On Thu, Jul 04, 2024 at 01:07:24AM +0200, Borislav Petkov wrote:
> On Fri, Jun 28, 2024 at 10:32:09AM -0700, Pawan Gupta wrote:
> > On Fri, Jun 28, 2024 at 10:03:05AM +0200, Borislav Petkov wrote:
> > > On Thu, Jun 27, 2024 at 01:44:06PM -0700, Pawan Gupta wrote:
> > > > The hw_cpu_type is populated in the below debugfs file:
> > > > 
> > > >   # cat /sys/kernel/debug/x86/topo/cpus/#
> > > 
> > > What "below debugfs file"? A '#'?
> > 
> > That is the number of the CPU. If it is causing confusion, I can will
> > change it to N, or say # means the number of the CPU.
> 
> Or drop that sentence completely.

Ok.

> > > > +static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
> > > > +{
> > > > +	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
> > > > +
> > > > +	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
> > > > +		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
> > > > +}
> > > 
> > > Why isn't this happening in cpu/intel.c? And then you don't need yet
> > > another silly function.
> > 
> > I was preferring to keep the topology related code in one place. Would it
> > make sense to keep it in Intel specific leg in parse_topology() as below:
> 
> I guess.
> 
> Although looking around this code, I wonder why is this hw_cpu_type part of
> the topology and not part of cpuinfo_x86 directly?
> 
> struct cpuinfo_topology has all the IDs but the type? Feels out of place
> there.

The draft version had it in cpuinfo_x86, but it later got moved to
cpuinfo_topology as it appears to be topology related. Below is from AMD
documentation:

  E.4.24 Function 8000_0026—Extended CPU Topology

  CPUID Fn8000_0026 reports extended topology information for logical
  processors, including asymmetric and heterogenous topology descriptions.
  Individual logical processors may report different values in systems with
  asynchronous and heterogeneous topologies.
  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf

I can move it back to cpuinfo_x86 if you feel strongly about it.

