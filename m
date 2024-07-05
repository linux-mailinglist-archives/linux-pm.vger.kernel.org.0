Return-Path: <linux-pm+bounces-10660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21C92850E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC11C1F221E4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D31465A2;
	Fri,  5 Jul 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b0CZp3Sn"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310914601D;
	Fri,  5 Jul 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171474; cv=none; b=tI90E9C9yV6796n+2EhipXAydGDvznhDD4xi6nvx5vLMZA5b46V3qWEgkwsUsFLmpQV2aj7WMPiGWXoFqAPMETu+7YN53AYsxe9UUA3GgvpaH5hQl45EgQitdjlN2o/czp4EVYRAOYzgUfu6cxKp3IX/lYM/B/L+DMyFi10gxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171474; c=relaxed/simple;
	bh=wrgauMu8WDBKUzt7ug+gOYD9v2MYaRcikXbMm7m/y8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5/6aQel1iYFhIcP6bKBLho+v3xtKIvM1wNJh+uD66HQAn+AxFPOgXrOwwzDZAmT3mrgaxFWLqK76nEzx+0+xF+VKzhxhwqn+mSDPrmJHj7r0m1RWI4M5Ge1Mp5d1F5w1oKfTBbTsXb5pqu1MDDEvAAtJbOXfobEPVb0zZ0VEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b0CZp3Sn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9d9e9NKb26jkd56IqLIPmaIOsn8kDGjWaVSl8Oq200k=; b=b0CZp3SnRHXPv6mSDBzfqhD+ez
	Z/f0sOBgZijWwlARPT9yCGeF4DKcUtguQTqc0SHHihv75yYAbDeDIHA9L5YxKbCEkhaH8j0GwnO/d
	0Oej+TFp76UDc0HMT4fl1hYvpnbTJGzsD12HTGh32BsOHLfv73+Uk9aweMys9uJHV5ws7FdAEuvKJ
	0ryi9JQOyBpZYDgfmFZryqndAg4CyOrkK3jcGdSLbFZ6rjjAqNVxVAdus050M+rsxOwy6QGiXL6uV
	WOBTLs57maieN8A1KAM+q+bYmuMmBewyGroWvzng0bVGRjxedfe2otArrwbDdpVLcyqKy/nja7bdR
	wLtnk+xg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPfAx-00000003oqr-2fXw;
	Fri, 05 Jul 2024 09:24:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 34EB43005AF; Fri,  5 Jul 2024 11:24:16 +0200 (CEST)
Date: Fri, 5 Jul 2024 11:24:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"irogers@google.com" <irogers@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable
 names to *_pkg*
Message-ID: <20240705092416.GB11386@noisy.programming.kicks-ass.net>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
 <20240701130845.GI20127@noisy.programming.kicks-ass.net>
 <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
 <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
 <738e2dcc26926ce948bc7647cf17d83ed5d637b7.camel@intel.com>
 <9f99286e-b840-4c50-8ff4-a25f2d2fdc67@amd.com>
 <bf76302d2d427522d4842cb1df8f58700cb669d4.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf76302d2d427522d4842cb1df8f58700cb669d4.camel@intel.com>

On Fri, Jul 05, 2024 at 02:18:30AM +0000, Zhang, Rui wrote:

> > > > I have a doubt about this, won't the future Intel multi-die
> > > > systems 
> > > > have die-scope for the RAPL PMU like Casecadelake-AP?
> > > 
> > > For future multi-die systems that I know, the RAPL is still package
> > > scope 
> > 
> > I think in that case we can go with rule 2, it would be future proof
> > for Intel systems. If you agree, I can make the change in next
> > version.
> > 
> > Something like below?,
> > 
> > -#define rapl_pmu_is_pkg_scope()                         \
> > -        (boot_cpu_data.x86_vendor == X86_VENDOR_AMD || 
> > \                                                                    
> >                                                                      
> >                          
> > -        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> > 
> > +#define rapl_pmu_is_die_scope()                        \
> > +       (boot_cpu_data.x86_model_id == CASCADELAKE)
> > 
> sounds good to me. Just a reminder that using boot_cpu_data.vfm is a
> better choice here.
> 
> And it would be great to get Peter' view on this.

Peter is confused :-) So you're saying that:

 - old Intel is pkg wide (it has no DIE enumeration)
 - Cascadelake (part of the skylake refresh) is per-DIE
 - modern Intel is pkg wide (they have no DIE enumeration)
 - future Intel will be pkg wide

And this works because for everything that does not enumerate a specific
DIE topology, it ends up begin the same as the PKG topology.

But what about future products that have DIE but are not CASCADE (what
about COOPERLAKE) ?

If this really is a one off for CASCADE, then yes, I think we should be
doing what Dhananjay suggests, and then the PKG naming is fine.



