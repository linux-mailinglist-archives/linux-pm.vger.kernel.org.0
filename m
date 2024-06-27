Return-Path: <linux-pm+bounces-10118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6A91A7C5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F059282913
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21D192B99;
	Thu, 27 Jun 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgGZ45cO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F61922F0;
	Thu, 27 Jun 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494560; cv=none; b=agl5Ihk/dmPJw+VSxCnJiV03Z/W+lgTwiN9+rBPPFINAqZ3NZMtS7QJNWP1owPJeF2GSUy71uAaC5kSvgJWdL/uHjTd5PH2cAOylm8WTKTwu7ob7VvyOppt8+LhtXoc5TkufapAfmign+WE6LlgiKcUIuFhkyjvKtm1UQXJeP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494560; c=relaxed/simple;
	bh=sYZzBfVpbkVWGXURUrII3QmUq5Xw6Km4gz1FrEScJGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIEV/wm9iqURicuip98vhHt9zNwwG6nmmAz6sziB3T6NIzFIT7hfAjqIIkN5WFNqxEw3OHD/JUjS12LiuB5p/nnEyl949NKqgf8Tw1KA5boLiCMeMbdsuoMXx4WGp6CQT8fWDKNY0dbHZAM3FbrF1BZZxNqQZ80jRvh86mRk4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgGZ45cO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494559; x=1751030559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sYZzBfVpbkVWGXURUrII3QmUq5Xw6Km4gz1FrEScJGg=;
  b=QgGZ45cOJ/Nq+P4SF2TpSaOzaDLRmVAYe+LvI+3s8sLuYuuO/EhOw5NP
   nV+p3N/I8glE/XyMD0rTEgc7f4F0vUV8WxnQ8Emk+owZLgRZe8iVraNV5
   KyDnyVPZE3NFnGGoE7xxG7wWI8Gl42hzJLdGlDhnfKjU+D9nAbpXY+Duc
   mtEcfeAjsrUZy5YV58GgcutUum3mXPItVI4V8T9LdQn8KFq1d0XFkUZSm
   1ZzbY55xIFxo/cPnWA7sGuq7xsvSD3CxfridCKb67sNl0qvc2+IhS5gJ7
   Tg+1EtNMWvXlnuIs5CHrTUS64HWk7ax/HsVtXGWjef37roYee1fvJhGt3
   Q==;
X-CSE-ConnectionGUID: slCPcKKnQKSXuOdqQMaieQ==
X-CSE-MsgGUID: FE/lNSCUQ4ikNrZit5TCJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="28018776"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="28018776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:22:39 -0700
X-CSE-ConnectionGUID: qdCob1gQQJWd/B+mutPrkA==
X-CSE-MsgGUID: jdMa1DTATRO5fJ2LEKU7bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44440231"
Received: from cdipalma-mobl.amr.corp.intel.com (HELO desk) ([10.209.104.34])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:22:37 -0700
Date: Thu, 27 Jun 2024 06:22:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Message-ID: <20240627132230.hondzls5bt3jspay@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
 <20240627125154.GA4743@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627125154.GA4743@ranerica-svr.sc.intel.com>

On Thu, Jun 27, 2024 at 05:51:54AM -0700, Ricardo Neri wrote:
> ARM gives userspace specific details. This makes more sense to me. Instead
> of reading these details, user space would have to infer these details if
> a CPU type was given in sysfs.
> 
> Having said that, Intel does have a CPUID leaf that gives the CPU type. Such
> leaf also has a "Native Model ID". Exposing only the CPU type may not be
> sufficient.

Do we know if there are applications that would benefit from this information?

We agreed to leave sysfs for another series. I will be sending v2 soon.

