Return-Path: <linux-pm+bounces-23777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19FA59AA6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0A716E406
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2E22DFA5;
	Mon, 10 Mar 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeHp2oRJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6821E0BF;
	Mon, 10 Mar 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622875; cv=none; b=oC2TjdgW1mW2+psEQDujJxwIg5Nt1e6LqkuIUKct1TRaa4fmK4tKyCgXYTSQNR/z5dvQJlbvU1WgG77wuwbMgfLML2Bh+MK6kMq+1QTKi49Udvgy/ZVSdy/stQ6yghEn4/262WPCZR+aTbZ2OXGEY/eqaApDfkBlIAd3YtrfyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622875; c=relaxed/simple;
	bh=GfYXbXdVM2junb3FP9MdUtt3UzjUNiOmD6x2DR0SHJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1JGxnYHfNKGpH1H+XF6cYwoxNCOYnTOTVJWD+7g1Tv+8synXXlRmUMzO4HriUuhs6fNnaH1/kEYiV6U9s9bjizt/93jP4awe17I9oPAi7Jhhs3qjKcDSV2tZj+JC8cmOdeThXNSRqYBBPoB3cJfZN0TW1yY8mqBrsCI10hitoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeHp2oRJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741622874; x=1773158874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GfYXbXdVM2junb3FP9MdUtt3UzjUNiOmD6x2DR0SHJc=;
  b=UeHp2oRJ0bL0MnRAR6w5U0Nxny5IpZl+S3wIz6rcc01+iEERzutj7bs7
   0b55VDoPzi9nA0YgurzEerpQts/0uuG3TfFK0noqK90b8Q9Sjq4DRWLCu
   lsD4A5mc6WZZYE3eB+AhE4NroBgxATYEcRYS3opBl2qMaCA5hYXuQ+xRW
   Eus4iRDfB3rye4ho7xNJZ7NiFKH9y/AkahDFrIXj3pv5zdXPQl3ZPpXi+
   4IbwmeHxxgTBNq5cNS9kuZ+7MjUCHNds6UNkfBFxSMBGsx5X1XcH0IZLB
   QfPTGBgY0yKTPpb+X2HlVparq4ozSBps4Pi7UCyLVjl/gyFbQGBPCS7eC
   g==;
X-CSE-ConnectionGUID: kLodOL+pTkGM+lCFDLoobA==
X-CSE-MsgGUID: HR56QVZLSmijD91DO76+Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52835384"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="52835384"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:07:16 -0700
X-CSE-ConnectionGUID: 0qDULhEgQ7manLBV/PWGSg==
X-CSE-MsgGUID: 1g1wHcYZRlepn4CPQeyaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120929319"
Received: from msridhar-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.183])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:07:16 -0700
Date: Mon, 10 Mar 2025 09:07:09 -0700
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
Subject: Re: [PATCH v7 2/4] x86/cpu: Add cpu_type to struct x86_cpu_id
Message-ID: <20250310160709.5cxlvwv6flaeu75o@desk>
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
 <20250306-add-cpu-type-v7-2-f903fb022fd4@linux.intel.com>
 <20250309173239.GCZ83Qt2uxtPvMNxVL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309173239.GCZ83Qt2uxtPvMNxVL@fat_crate.local>

On Sun, Mar 09, 2025 at 06:32:39PM +0100, Borislav Petkov wrote:
> On Thu, Mar 06, 2025 at 06:18:20PM -0800, Pawan Gupta wrote:
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index d67614f7b7f1..18e996acb49a 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -692,6 +692,7 @@ struct x86_cpu_id {
> >  	__u16 feature;	/* bit index */
> >  	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
> >  	__u16 flags;
> > +	__u8  cpu_type;
> 
> The struct is called "x86_cpu_id" and all its members describe a CPU. There's
> no need to have more "cpu_" redundancy in the member names - just call that
> "type".  It is clear that it is about a CPU's type.

Makes sense, I will change it to "type".

