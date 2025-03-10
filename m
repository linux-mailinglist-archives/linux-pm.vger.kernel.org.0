Return-Path: <linux-pm+bounces-23776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4FA59A99
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E21188B1B5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140722C327;
	Mon, 10 Mar 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJpb99QQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7B229B1D;
	Mon, 10 Mar 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622687; cv=none; b=tqco2flimlw9UulmuyQQ27nm9STnhMLXBqV20fMDOsVFdZPhnEKLXMKQGesxU5eVYHnch4aWZ3gGYTqx+EfMLAkpQDIwBgtgEWa+bKBs/vjrHcPRk6M0knvVFjcXn5/AwFTaeY/+8yqLQ/NtXMRVGqTz0Y6V1wqDRH6YsBvBDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622687; c=relaxed/simple;
	bh=3EK/RHDZlXScO9zJVdipiTEeCB3RB7JprJxMdp+IKmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtVzqNKErQm6hzVHCkrAhwM98rLVFnIeurbNHiNl0NBto7xmRAd0Ua+Ih9rs3cWL21/KCTATJ2lD25qL4PE0kgpm8QMRS3oio4ed7KSPUzE8KxnXBM84YXU+5LrsOfiGo7OWQRD6cbJIuomh1An766BLdrl7DZhsSmDWZnsiL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJpb99QQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741622685; x=1773158685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3EK/RHDZlXScO9zJVdipiTEeCB3RB7JprJxMdp+IKmg=;
  b=bJpb99QQ8xaEWoU8jn6eBQ1SvS/fQ4d9Kb/n9Vm02M/c0n9F4rISPtOb
   3DuUmcQWHsj/NQvbZ+Eo1TNt+YuN4Scjdd9Lxj8JbikC39A5dco9/bOuM
   rZpJfSCsThboYmM8+pNZu7gI94/u8kKNCJbVQ3Ln8k7t1EaYyWnxYvYux
   cJ3zCWMJzxB+a3GKQPGGa2pgGKKCBvlL6WQaSFRqH8H+0J4aIMQWfOzHk
   /SPa5yjutvmJA3JveE8IikLCyFz1QwnobKGQWH0o6Gql52IxtmdDzydOI
   sUF7sBKbdQrcOqPa7K20YW7s7dqeVs6rI/KuSWS6aIRVZOUGO9njZJq3D
   Q==;
X-CSE-ConnectionGUID: IhuBqk0+RDS5ENCfPV5Tew==
X-CSE-MsgGUID: dUEhVWLJQNKH68sxypFowA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54003938"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="54003938"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:04:44 -0700
X-CSE-ConnectionGUID: +TZhXV7uSBqwzp4qb5jl9g==
X-CSE-MsgGUID: u4ep8jsaRJmC9K+ttaiq1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="143235466"
Received: from msridhar-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.183])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:04:44 -0700
Date: Mon, 10 Mar 2025 09:04:37 -0700
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
Subject: Re: [PATCH v7 1/4] x86/cpu: Name CPU matching macro more generically
 (and shorten)
Message-ID: <20250310160437.4o43lp53hpj7uyqj@desk>
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
 <20250306-add-cpu-type-v7-1-f903fb022fd4@linux.intel.com>
 <20250309172920.GBZ83P8ClXskqjmira@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172920.GBZ83P8ClXskqjmira@fat_crate.local>

On Sun, Mar 09, 2025 at 06:29:20PM +0100, Borislav Petkov wrote:
> On Thu, Mar 06, 2025 at 06:18:03PM -0800, Pawan Gupta wrote:
> > @@ -106,13 +94,10 @@
> >   * @_data:	Driver specific data or NULL. The internal storage
> >   *		format is unsigned long. The supplied value, pointer
> >   *		etc. is casted to unsigned long internally.
> > - *
> > - * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
> > - * set to wildcards.
> >   */
> > -#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
> > -	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
> > -						X86_STEPPING_ANY, feature, data)
> > +#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data)	\
> > +	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,		\
> > +		      feature, data)
> >  
> 
> That one is unused. Zap it.

Correct. I will remove it.

