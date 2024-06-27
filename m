Return-Path: <linux-pm+bounces-10116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F5991A6D4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 14:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939622853BE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A25178373;
	Thu, 27 Jun 2024 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnVLnTZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1E1779A5;
	Thu, 27 Jun 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492457; cv=none; b=hQRjLdPXX+AOqdZPw6UBgqcJ5adqY7Zlm+Ce1VJEGCzmoU7FP17AXELaLz9YkKjtzs/n9af1qIbm2VW3UgmCz16YwMMZM56tz55FZFFsvW2Wh+KmTglW2dWW18sSdZzUWrzz5CHqJrZwlYwLFXW9BVCc93WVyOj8VtRz9GRh39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492457; c=relaxed/simple;
	bh=RiAYip+1ZCrRFfOtFF2919/xDLkxaKuQsUwtdQsoJxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuAaAGrevSz/Hc9u4BU6l/1lTMSZr6LRfqkVjm5sxtTKe0a2APOLJxiruRa+MiPyW7ruRooPFczLHqD+n9zlS7wRYM0xa2HI588UjmzQjilNwHImPmiyVS1toQmPUMF2iboK0wgkdQ8pLHxWTFfUB6VJrzCQo6dgjGaGhbPF2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnVLnTZS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719492456; x=1751028456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RiAYip+1ZCrRFfOtFF2919/xDLkxaKuQsUwtdQsoJxI=;
  b=QnVLnTZSQ08vy7/6bLZUUSx4CQOfj2t3lXQPn2+QjrteCC4byMWI9C9B
   skJixhoiwvdvO3ZIwCopgITM+xuFgwPTk0PrDKc5wI5i9D8YObm6re/Xl
   uMsV5xFaxlmZLomWA3M4ZKysP0rGS0oaIZZFSuTPi9U1/Og8N/YkD6nrn
   qroyigLB1NgB71UgaFE79EbwvwYJH+YZrAvuao9XBf9F5VfYdgxa2uvzv
   dUiQYmhLjeX0pEnS6+pV9q0VO5JDXqm5xCIyRgbceEpMo/t7rHQW4mrWj
   IuJg4BS93eGX6EBQETuJ3TjcnD3VvnQOaUUkV69Xtiv41QX2BUtOpN6c4
   Q==;
X-CSE-ConnectionGUID: A6t8/237QoGp6Ch288LHZg==
X-CSE-MsgGUID: m/czTZEXSeOU0g7ed7h+Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16838972"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16838972"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:47:35 -0700
X-CSE-ConnectionGUID: ue3SHnc7SCCTLiXpM4Tu1Q==
X-CSE-MsgGUID: 6osAN1ZfTne6Ys3Mlzf8nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44480814"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:47:35 -0700
Date: Thu, 27 Jun 2024 05:53:40 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Brice Goglin <brice.goglin@gmail.com>,
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
Message-ID: <20240627125340.GB4743@ranerica-svr.sc.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jun 19, 2024 at 03:34:46AM -0700, srinivas pandruvada wrote:

[...]

> > 
> > There can be many ways to expose this information in sysfs. Like this
> > ...
> > 
> > > [1] https://lkml.org/lkml/2020/10/2/1208
> > 
> > ... exposes /sys/devices/system/cpu/types which, in hybrid parts,
> > creates a
> > subdirectory for each type of CPU. Each subdirectory contains a CPU
> > list
> > and a CPU map that user space can query.
> > 
> > The other way is to expose the CPU-type in a file:
> > 
> >         /sys/devices/system/cpu/cpuN/type
> > 
> > that could return the CPU-type of the CPU N. Is there a preference?
> 
> But you still have to look at frequency or caches as there are Low
> power E-cores which will have same type but different capabilities.

By the way, /sys/devices/system/cpuN/cache is broken on these systems with
low power Ecores. I proposed a patch to fix it here [B]. May I ask for a few
extra reviews and testing? Perhaps this will raise the confidence of the
x86 maintainers? :)

The patchset continues to apply cleanly on v6.10-rc5.

[B]. https://lore.kernel.org/all/20231212222519.12834-5-ricardo.neri-calderon@linux.intel.com/

