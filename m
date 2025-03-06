Return-Path: <linux-pm+bounces-23574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649CEA552D3
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 18:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE7B175B0A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EF25D1F9;
	Thu,  6 Mar 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jawEpkgl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5525C713;
	Thu,  6 Mar 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281645; cv=none; b=dwWcIeFPD7pOvQ3fWX9BTZod9BBttQnxzKC/sakhyKcXe9Yut1+b8hImTPy3N8/FVCw5VRIJc8a4resDlvXqu81bQ0ZGk200JPGIDSRl9JSB6RB5A9pku2eUIKNhBS3Va7FdMofIeWNnhgleQ79AvOJ+yoB8IL+t5+NK9KJjjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281645; c=relaxed/simple;
	bh=9GUHUm17IEQGFD6aYmbJ0438ocdu4QCOxvX9Y6riGNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0uRIEW75vhUEVyk1h2MPT9hZkJenffEnRi+I82Jy2siYfisGHPMHFYq5eWz6y+YfdYEe6j505elSssL8t61lN4bKgruzmCQjTCWk0kuZh5wxHCPO/4YHE5ZecWbYaPQUBtzjnYMUn5xotIXeFJV7A57k7Cq5MP44MHhQTivVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jawEpkgl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741281643; x=1772817643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9GUHUm17IEQGFD6aYmbJ0438ocdu4QCOxvX9Y6riGNw=;
  b=jawEpkgl/u2AVTWr/G/Ey8ashubYmJbL7BeZc9JI/D1Qy2+Q45+r6J5n
   vxQ8coyA2SZXyKDDVaAznjho6vnctlrzl+8xCq/G2LeeF7jhQYVvwZeFa
   FzAcOmaMwq3sID1Va1KDaXj0GL5d1r1XH1+cOVpSwK7GRVEdjWfVxbKV9
   yLVxEkuutC7Yn/3wiZDgQzIc/EcGO+Ot2SWiYXGKGSYxm781MRQ45Q9zi
   8IGv9ddAKXrzP6TSqBNnI9fTpOzWugUk8v6W+Q4+xt/xXcF9GZG/aFw+M
   S9ouzsYdj9gv9QV+3iPUIsUM4jOtN4ZT1EY+8socSvuXqwwu55YFB/Anm
   Q==;
X-CSE-ConnectionGUID: AIbOlETDRNu6Kr+OY4sABQ==
X-CSE-MsgGUID: A55RFoOfTRuXJHN4LTYNDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45113709"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="45113709"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 09:20:41 -0800
X-CSE-ConnectionGUID: q6yKqGi/RTO2LwlRfA2WsQ==
X-CSE-MsgGUID: fQND1tF+R4268TMVX/TiMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119589068"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.178])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 09:20:41 -0800
Date: Thu, 6 Mar 2025 09:20:34 -0800
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v6 4/5] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20250306172034.qf767eqcrw5m22ln@desk>
References: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>
 <20250305-add-cpu-type-v6-4-4741735bcd75@linux.intel.com>
 <542cfd1b-65f8-4fa9-811e-d70850d0cf9a@intel.com>
 <20250306165757.sh6azitvazhq5lxj@desk>
 <39d1597a-d165-4f79-a2fc-d37fc2822909@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d1597a-d165-4f79-a2fc-d37fc2822909@intel.com>

On Thu, Mar 06, 2025 at 09:03:52AM -0800, Dave Hansen wrote:
> On 3/6/25 08:57, Pawan Gupta wrote:
> > As one of the goal of the patch is to shorten the macro names and follow
> > the VULNWL_<> pattern, would it make sense to rename VULNWL_INTEL to:
> > 
> > #define VULNWL_VFM(vfm, whitelist)		\
> > 	X86_MATCH_VFM(vfm, whitelist)
> 
> I don't think saving 6 characters justifies the extra level of
> abstraction personally.

Ok, I will stick with X86_MATCH_VFM().

