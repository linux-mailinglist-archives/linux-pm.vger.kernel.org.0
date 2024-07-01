Return-Path: <linux-pm+bounces-10299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F891E6B6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285391F2390D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24016EC1B;
	Mon,  1 Jul 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaUTwfVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812E16EC05;
	Mon,  1 Jul 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855153; cv=none; b=AULlnoIBsz8WPH6MTPwmO5vR7UALJsqzkb12BLDG1diWS8mfj1BGR6f7IyIirTzmc4nQYHP10nNF3FhRz/x2sOOL9uzlWc3mplDw7F06V+HhcbeKZUXM7cmELZHJNKJ8QR9tvto+u5Xp9d0y0MdDJXbnyARQxNDFTYSam5UMmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855153; c=relaxed/simple;
	bh=RH54wpfJPFuq1p/47n403zxx5+QmRAvugMB5EeGq/DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm1HIWTFVgsHl7Ts2RwfWXJtuov7vvoxgiswA7gxChTpl1J6kyqgZfYR1SGzr+ZTtjYd6n8f2h7FphYgje++kvMYSyYJBmN5c7dSLvfai78goNCHj/xwzdqAz4lL2FpudADtT0UTzGhoajS3fAZEaGcZVuYEocApaci0EVSM97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaUTwfVa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719855152; x=1751391152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RH54wpfJPFuq1p/47n403zxx5+QmRAvugMB5EeGq/DM=;
  b=YaUTwfVa2Q7VbQVzCRb1r1/HJU9UPuG6oq+ztCoTd1+CC4WtHHCW38BL
   jEG5npCRKTGTPR5i8upMFdD7podYFVQ2tVWQ70qSzz21pxDIZCxtcfMHR
   r2sPpT9W5+X/f8R6VVBv1DxXdXhlYMyeVpeB50I4q9c5Fq3j+8Arz4eeE
   J4f8TrmwfDO1VT7ium5EEITt1qGNnlNZ8pLpun8ki8g7J8P3gkAi0LOct
   4TestWFCIq8r6OUgXO9q26TXKoCEInFct64cfrEjlwKHeuRhi8KeycMZU
   i5jGuVNB9D8O8zbpqEW+KYpQfK2LhHk1bQKDlkxHyGbkKhRuXhgapWrKA
   Q==;
X-CSE-ConnectionGUID: nBrwzkblSuOfHanpbYrxCA==
X-CSE-MsgGUID: EcilDMjWQCiWfQlteJVxYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12343503"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="12343503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:32:30 -0700
X-CSE-ConnectionGUID: hrC7i042S+KUbRkezbWGJA==
X-CSE-MsgGUID: QtPpU4dST423AiFJac8HDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="46259398"
Received: from aadeosun-mobl.amr.corp.intel.com (HELO desk) ([10.209.8.130])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:32:29 -0700
Date: Mon, 1 Jul 2024 10:32:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v2 3/9] perf/x86/intel: Use topology_hw_cpu_type()
Message-ID: <20240701173221.fb5k3dqyycsb4pmn@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-3-f927bde83ad0@linux.intel.com>
 <09000f4e-f373-448f-afef-35d2a413929f@linux.intel.com>
 <20240628185136.6rl4x3no3vl3zben@desk>
 <d866215b-bffc-453f-9d92-232b729946d0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d866215b-bffc-453f-9d92-232b729946d0@linux.intel.com>

On Mon, Jul 01, 2024 at 11:37:26AM +0800, Mi, Dapeng wrote:
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index d8d715fcc25c..08794668750f 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -107,7 +107,7 @@ struct cpuinfo_topology {
> >  	u32			l2c_id;
> >  
> >  	// Hardware defined CPU-type
> > -	u8			hw_cpu_type;
> > +	u32			hw_cpu_type;
> 
> Since hw_cpu_type represents the whole EAX right now, it may need to be
> changed to a more generic name, like hw_cpu_model, or others.

Even with whole EAX it still identifies the CPU-type (just more granular).

Since hw_cpu_type will be used by AMD as well, I think it is better to keep
it as is. Interpretation of what hw_cpu_type means can be left to vendor
specific code.

