Return-Path: <linux-pm+bounces-9735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB05911BEE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCDE2876BC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA44155726;
	Fri, 21 Jun 2024 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsF8gVfB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B413C802;
	Fri, 21 Jun 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951826; cv=none; b=gjsfheqByAGf7QbH1wU/BAxhlp76zEiYCttk6OSQ7XYBiXq7jgDabB74Rggvw8vaQmYuswvo4O5B1zRMykFvjDjW4mFnSpM9kRGXTXR3z/t0LZBuISbmwmEEw/6qYTIbmZWFw6P9RZ8Ih4A9A9VSaJZCHMbbrdrKBLD3Igbvg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951826; c=relaxed/simple;
	bh=PILEGcto9L0Fv29TPcqXWioRKaLwrMhrClPCWXIU4iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhTsHweFr7QhsjfwfBBpRFThNbvajoqSLT2bpiS7sPinAxpESsYcDq0sT4XLERdXzqxX8+ezqTZ8bqpboBX0UP0rlLrDQ/gVxfrGmFanJQ7w4QIWGyD3drPdxJg5IenjayLEFW4sRUKkh1hWUp6jbhryt7iG+ap+s7t82u3jI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsF8gVfB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718951825; x=1750487825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PILEGcto9L0Fv29TPcqXWioRKaLwrMhrClPCWXIU4iY=;
  b=GsF8gVfBCLQ8ilC8PQPxhoFLpKcwoHa7GclRc1UOGvh6RBeXsgz/W2aj
   ty0UoJhzUudXtngLpsI1gX0fPERG0hDBI0623DtL3wktv/OaEYdhzC+sy
   7NaQOOTcntXvTQpGTCLl7iZE4CTfSmZLeyk9kNnt20e91li5DqhYAvscT
   SEDXMILhrPH8EFpU9Ix4kasq51fdoRtpyW+QemWld5tAtSjPlefy+d6Zl
   TulgTZIN76whqrCUl7Tlvj/4Z1hiZl1SpUhGSmtal8ijAxFxKBaqI0P/h
   aTg1rKfSKfCTtKtL362qDdKV47cTAmuKd15jaOxF3E5fXtSZma7POE3rS
   w==;
X-CSE-ConnectionGUID: cMQNhvsBT9OyNNQY0OEi2g==
X-CSE-MsgGUID: cflb9Y1bShmiU2DFOxK6Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27391478"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="27391478"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:37:05 -0700
X-CSE-ConnectionGUID: ZQVcD7i3Se2Thk4cdWxn9Q==
X-CSE-MsgGUID: otw7n1PbQTqHJo2zGZIGag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42602423"
Received: from mesincla-mobl1.amr.corp.intel.com (HELO desk) ([10.209.40.87])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:37:03 -0700
Date: Thu, 20 Jun 2024 23:36:54 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <20240621063654.eabkd337tujqs6p2@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
 <20240618212801.GJZnH74Q4yknT-4X12@fat_crate.local>
 <20240619033126.irudoer3pw4fb5be@desk>
 <20240620155111.GIZnRP7-XYvJZPY0_6@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620155111.GIZnRP7-XYvJZPY0_6@fat_crate.local>

On Thu, Jun 20, 2024 at 05:51:11PM +0200, Borislav Petkov wrote:
> On Tue, Jun 18, 2024 at 08:31:26PM -0700, Pawan Gupta wrote:
> > To accommodate for that we can name the vendor specific types in this
> > series as vendor_cpu_type. And if we ever need to add generic types, we can
> > call them cpu_type?
> 
> Yes, then that member you're adding should not just be called "cpu_type" but
> either "vendor_cpu_type" or "hw_cpu_type" or whatnot and every vendor can then
> put its own values there.

I like hw_cpu_type better, as it leaves room for architecture defined
types as well.

