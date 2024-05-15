Return-Path: <linux-pm+bounces-7863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C798C61A1
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 09:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BBE1C21CE2
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80004C62E;
	Wed, 15 May 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEJ3pu+6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08755C3B;
	Wed, 15 May 2024 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757767; cv=none; b=L/kifiqOTfr1JcXCsTl21uVY1CANSbPzcRBqEd+mMNP8iq5A93Zxa164eb8K1H9m5KErOS1M7isVtM0TczrWSZ3yZ5jaJz1j5J7tzsNMXjJIZ2qnXEO1E8MDj/ecfu8F59PeUUp7IsiR5cDjq+hXYTSha857SYfwK1f/3EBtR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757767; c=relaxed/simple;
	bh=YYVK4RKso1daeoRIfgcpHOGP02pbyujQXd14HOeOJKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwQQkzwJzCmAR3cPVfWiaE+hREDhT7CQLieJpwJtPcK9RsButQjiDB79dPN1G1gNyHqwCwHdiD97l/RhoRc/KZQOWapB3nBZYQp/bn6zATzKgibV3jQewIomjpds00onCV+uMnNFkE/5o4mYuDlcBO0DIumCB7glcgMxtxEfoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEJ3pu+6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715757766; x=1747293766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YYVK4RKso1daeoRIfgcpHOGP02pbyujQXd14HOeOJKQ=;
  b=KEJ3pu+6pf0suhfyABsfLe/8lx+3/Mjb1yV9RjD85hIB5opvtdkeGAPb
   Z77HfUzMaKmQz6cy2oYb1nyN6aJVQBS9a9NXaO6fIAqAIUJbRQQpqLanY
   CMyvUWmEMy2AraACaznz/BDxf7S2BRLk37S/fzO/fy2I5KtblCSf1ApiE
   vsNqAIXy4zd4bLNKfOrr5ltaXCiXCCCXIIinrBbe+1Knt/78zAmwFsFQA
   CYTrFQEDgCw+WWVwmoMNkqetQ5BLXGRATtifDe6Mh8muIbXD2awXgIZ1H
   RMjpVbcKzapeeJRftoChcqH1lUsYQnj0Bkl0zG/JnfEXzPIYZrKk+3Fse
   g==;
X-CSE-ConnectionGUID: nTMNZKffRF+66z3RS+nGyA==
X-CSE-MsgGUID: 5lLRZqrJSWSMF48jUWqA6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11657742"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11657742"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:22:45 -0700
X-CSE-ConnectionGUID: HqIFPuDXQGKGnsQxC6Os6Q==
X-CSE-MsgGUID: xxQiwBrtSf2Afa0HFCYydg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="54163895"
Received: from standuka-mobl.amr.corp.intel.com (HELO desk) ([10.209.83.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:22:46 -0700
Date: Wed, 15 May 2024 00:22:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240515072231.z3wlyoblyc34ldmr@desk>
References: <87o79cjjik.fsf@kernel.org>
 <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
 <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>

On Tue, May 14, 2024 at 09:10:07AM -0700, Dave Hansen wrote:
> On 5/14/24 06:17, Kalle Valo wrote:
> > The kernel we use in our ath11k testing has almost all kernel debug
> > features enabled so I decided disable all of them, which unsurprisingly
> > also fixed my suspend problems. So maybe this is something which happens
> > only when MITIGATION_IBRS_ENTRY and some debug option from 'Kernel
> > hacking' are both enabled?
> 
> I had my money on DEBUG_ENTRY, but it doesn't look like you ever had it
> enabled.
> 
> I've got basically two theories:
> 
> One, the IBRS value is getting mucked up somewhere, either that %r15
> value is getting stepped on or the per-cpu value is corrupt and the
> WRMSR #GP's, causing the hang.
> 
> Two, IBRS_{ENTER,EXIT} is called in a "wrong" context somewhere.  Either
> it is clobbering something it shouldn't or it is assuming something is
> in place that is not (like a valid stack).
> 
> But the whole "'sudo shutdown -h now' then suspend somehow immediately
> unstalls" thing is really perplexing.  I hope Pawan has some ideas.

Nothing promising yet. I now have the system with the same model, but the
system is only booting in recovery mode with the config attached with the
report.

Kalle, I wanted to try reverting the below commits:

aa1567a7e644 ("intel_idle: Add ibrs_off module parameter to force-disable IBRS")
1e4d3001f59f ("x86/entry: Harden return-to-user")
c516213726fb ("x86/entry: Optimize common_interrupt_return()")

... but I haven't reproduced the issue yet.

FYI, cmdline "spectre_v2=off" should have the same effect as
CONFIG_IBRS_ENTRY=n. Other interesting thing to try is cmdline
"dis_ucode_ldr".

