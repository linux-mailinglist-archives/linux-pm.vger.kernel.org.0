Return-Path: <linux-pm+bounces-10804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3692AE0E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AB1F21F24
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07C38DF2;
	Tue,  9 Jul 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQmDKBXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7037147;
	Tue,  9 Jul 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491181; cv=none; b=Uuks3IRXKn1vTX75INGFo761lWxZRogqJ8Xp2hJXiKXwNvhCPEmSEViQ3FAq/fNpUmafg4fILeSxnC1RC9XZqgMhC1Dm0wEWtZJzlwOGD41fOxuq+GDWJOuiAgVzsZrMkfLrBe/EQ7DTNcgeM/ZpmphwymlNrozXBRJNTUrr7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491181; c=relaxed/simple;
	bh=w5UaszG4XXKi5o1MoKE2BrIX11vIICgpXkxs0Zot6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNBL8zZICLdpxB/uPL92pj0BrYpcjbHYgiDX2urkodLeKmmAIxML7PNK7+GmLVWHKLJvTvJViECMgbIqv+yVIEU8E59lo5NbtwFWq54UelQLS+ybIn0Q7VqBS2kaQubMM17M3YLy7nyNoG58CgA2ebwixetn0m1tIMmL8/7ne3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQmDKBXI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720491179; x=1752027179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w5UaszG4XXKi5o1MoKE2BrIX11vIICgpXkxs0Zot6ic=;
  b=ZQmDKBXIsGOhuWONlxRLkh78XQHuWsfa/Xu1nEJkolqf72IAXzafYMWh
   tw+LcnSwQ3kPz82cVH2P22sLNgTruIeqXmeCSALxNq9HrauCO2Adr9CFo
   kO+/xe0KXzrsnLLb6CU5iYgeHbYr1cUYRDl/oC6H6Wgd7KZTdEAeZ3MWM
   lbrYlF3Uy9cRZ/aLoDiTqZsZ67j4uJQZpi6pjaWiMXSnIF3VFBSkvp2rr
   ob3CkIicmx/16Hx84QoQ5CNrE8bbwcpjagD6ACSzlHVXdS4oo0hunThN5
   4qYU9jROsKiyxtoHopMhJLts2SGM7fKjSbY0H1OEy0+TpF8CxQ9Nwyf6F
   Q==;
X-CSE-ConnectionGUID: v4VF0BkzTt+iGyOq5qPf/g==
X-CSE-MsgGUID: ouyEQjjlTIugDB4JuX3BzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17426005"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17426005"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 19:12:58 -0700
X-CSE-ConnectionGUID: TwhE19AgQOqinpqkSvBWtw==
X-CSE-MsgGUID: gADE25TSQvOmNCB4/aPMvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47791317"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 19:12:58 -0700
Date: Mon, 8 Jul 2024 19:19:17 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] Thermal: intel: hfi: Give HFI instances package scope
Message-ID: <20240709021917.GA1891@ranerica-svr.sc.intel.com>
References: <20240703055445.125362-1-rui.zhang@intel.com>
 <CAJZ5v0gVFPNK=_=Tnr0QJ-yBWfSWc+wuJrE079Fz+Ba1P57TmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gVFPNK=_=Tnr0QJ-yBWfSWc+wuJrE079Fz+Ba1P57TmA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jul 03, 2024 at 01:33:03PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 3, 2024 at 7:55 AM Zhang Rui <rui.zhang@intel.com> wrote:
> >
> > The Intel Software Developer's Manual defines the scope of HFI (registers
> > and memory buffer) as package. Use package scope* in the software
> 
> "as a package"
> 
> > representation of an HFI instance.
> >
> > Using die scope in HFI instances has the effect of creating multiple,
> > conflicting, instances for the same package: each instance allocates its
> > own memory buffer and configures the same package-level registers.
> > Specifically, only one of the allocated memory buffers can be set in the
> > MSR_IA32_HW_FEEDBACK_PTR register. CPUs get incorrect HFI data from the
> > table.
> >
> > The problem does not affect current HFI-capable platforms because they
> > all have single-die processors.
> >
> > * We used die scope for HFI instances because there have been processors
> > in which packages where enumerated as dies. None of those systems support
> 
> "were"
> 
> > HFI. If such a system emerged we would need to quirk it.
> >
> > Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Ricardo, any concerns?

No concerns. IMO, it is important to document why we were using die scope
before. Rui has done it.

This patch looks good to me.

FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


