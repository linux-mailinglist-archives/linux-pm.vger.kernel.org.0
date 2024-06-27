Return-Path: <linux-pm+bounces-10128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797C91AAF2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322CC1F26A4A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0219885B;
	Thu, 27 Jun 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtMUsgH2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805715216F;
	Thu, 27 Jun 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501415; cv=none; b=eFNHcnHfAIOm6fQxNxx2RGEQM745u/K3pSHVZyY39JQ2wkG/20Pj2xt/xZhA/y1XJgXGOnZss2tZFjl8Zts/0ifFeA515AZJlXkaeBWLoY+gmLv5gkypUzPCbzkCp67nQaCtVtuzDXdMzEK4qznaVtAkYCj9NwcjrSEF48JBE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501415; c=relaxed/simple;
	bh=3GozPIpP9jAx9el91ibI+vx4flekmq46sTMmK/4U6m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFcdKmA7WSvIwpK3rbZFhPtrtp0vVm437kaTdi+9SBMuMIiu7yW6Q/okiHf9zWmut8zvlw5hPSNOW3feWGKzIH2A+iC4KCGYm+84DvxRR4743ghCD53KEhl2Sjd+O0TY6aV+QaL0YAPZv+/JZVRdaoGMrav6OPw8zaaOLDqoO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtMUsgH2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719501415; x=1751037415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3GozPIpP9jAx9el91ibI+vx4flekmq46sTMmK/4U6m0=;
  b=DtMUsgH2GvJcVoo3xam8Tj4w9i6qM0a00FEAYWlESYlshfDne2ZaYTFA
   ASjNbU72BlWl8Grq3qCvO71iSADi0/GOgxz1gO2cAWkcQvQoyLLBjxZ+R
   zAGaof+ZvEWsb9ttptgWUIgQLNS8r/hIjIwoSRklA7TolXEwBvijw6jCX
   /oPLKafCMZIDr3VdJcOComu3WSjjtQ4y6R+t9f7T4fcGfUE2KC8L2fv1R
   f6a5eI6XJ7RuWm0sQAVoclSIyiku0gypusNH4S4wGZuUt42BjATPUZWoX
   2p683EMrwr4bnhYm6t61uAiiq2+8ln6j30kgIZkCFzt3ODw14CUvFO2Xd
   Q==;
X-CSE-ConnectionGUID: ffg1S4zQSmKAIvXw0ySyNg==
X-CSE-MsgGUID: cyV3Vh+/RLG6JAPab249iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16469949"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16469949"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:16:54 -0700
X-CSE-ConnectionGUID: kDj9fzqvTfCF4dhc72knZA==
X-CSE-MsgGUID: 9kmkGbpiQuq+VPsyOAnhZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44236881"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:16:53 -0700
Date: Thu, 27 Jun 2024 08:22:59 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Brice Goglin <brice.goglin@gmail.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Message-ID: <20240627152259.GB5201@ranerica-svr.sc.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jun 18, 2024 at 02:49:10PM +0200, Brice Goglin wrote:
> Le 17/06/2024 à 11:11, Pawan Gupta a écrit :

[...]
 
> Hello
> 
> Is there still a plan to expose this info in sysfs? Userspace currently uses
> frequencies to guess which cores are E or P. Intel sent some patches several
> years ago [1], but they got abandoned nowhere as far as I know.

At the time of writing those patches an alternative interface emerged from
perf sysfs. You can read the CPUs of a given type from
/sys/devices/cpu_{core,atom}/cpus .

Yes, this is perf sysfs, but is not obvious from the name and has a list of
CPUs. It meet the need, IMO.

