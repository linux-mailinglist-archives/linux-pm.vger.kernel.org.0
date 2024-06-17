Return-Path: <linux-pm+bounces-9377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855390B9D9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F5B31DB9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D14194C6B;
	Mon, 17 Jun 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dd945dAE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD24192B88;
	Mon, 17 Jun 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648756; cv=none; b=UX5IswZapFGh3GeUXv5aQZoplTaPOsN0wgDAI8KXsZCBFsEfLxDDdxPuY3V4gr/VgYXZ7o5pL4/Wkt6bBSifWcJar+AAyQAzyQy3AIVBv/KZCz589loKGF5cFXL+owJc+ZPO8OD/JGbnt3j+ExWvHDPVoHr8Roz7yqaiO3V0GHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648756; c=relaxed/simple;
	bh=NqerbviuZuOzLrbX+rKOzS146N4t7YDVoAkNbjWSVw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFHb4oowoApTiUHJ55pOefkArlPCFLHPyAzvnPvMsgyeLT6cHX2MEDwck6Dern3GeeHEJY5JWsdqrj3qMXqMHiUV/+ogPz8wbIM8Id4Xw45yk7EnHafGDT4P89VjWprwJgX8XoZjnO/1bYIMQDFi5x+RPj7gy5YnHyTCJ9nfKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dd945dAE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718648754; x=1750184754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqerbviuZuOzLrbX+rKOzS146N4t7YDVoAkNbjWSVw8=;
  b=Dd945dAECaSaZE/qi+a/lXiKSMT/zqiNH1E1cIE7hzytLZvbGQYtlHp4
   TPfbv0Bhj2koP01XSB6q3ve0Oz52wkKPQ8QrsvOtAffE2WNSTRvokFljo
   i+C+MbwVkAZYAaZbiBQ8ZWvESgUKa6Insmb6EW5484fN3mozstVGyyJqk
   iNEDN6DflaLw8pTDE/7Ew0Kuh/C86YuShqOGLYoQTJOApTYSHCe5+4g9N
   v+/wy1TZ+iRLe3Vz2/OESDP23ghLH/D32VNOvc7wEogSoSyXSdvvW3qG6
   lo1fn9S0gGlK8+OdmroIqgUbRPV2Q90l0w3B5LXwW4835mTumN3fLacMz
   Q==;
X-CSE-ConnectionGUID: BAPH3knTQ3e7H2RgYp4r6Q==
X-CSE-MsgGUID: HwAgR0XERP2rNvizZpy0SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15615865"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15615865"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:25:54 -0700
X-CSE-ConnectionGUID: QbnXQa6/Qo+c5kyTH7gHvQ==
X-CSE-MsgGUID: WzXxJHVDQ8StKJEeAJIxlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="46228721"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:25:53 -0700
Date: Mon, 17 Jun 2024 11:25:48 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 3/9] perf/x86/intel: Use topology_cpu_type() to get
 cpu-type
Message-ID: <20240617182548.2uqh2yawjucxhsqh@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-3-b88998c01e76@linux.intel.com>
 <7c4978b4-ac69-480e-b8cf-a473b64ed917@intel.com>
 <20240617180905.7ao623w6eyu64hs2@desk>
 <513abce9-48f5-4dab-9e8c-7023077ea589@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513abce9-48f5-4dab-9e8c-7023077ea589@intel.com>

On Mon, Jun 17, 2024 at 11:17:35AM -0700, Dave Hansen wrote:
> On 6/17/24 11:09, Pawan Gupta wrote:
> >> Is this trying to make the case that get_this_hybrid_cpu_type() and
> >> topology_cpu_type() are equivalent or pointing out a difference?
> > Pointing out a difference. get_this_hybrid_cpu_type() misses a case when
> > cpu-type is enumerated regardless of X86_FEATURE_HYBRID_CPU. I don't think
> > checking for the hybrid feature is necessary here, because there is an
> > existing fixup for this case:
> 
> OK, that makes sense.  Could you include that in the changelog, please?

Sure.

