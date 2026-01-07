Return-Path: <linux-pm+bounces-40408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74246D004AC
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5205B3014DE9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A594149659;
	Wed,  7 Jan 2026 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxyNKw8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071441E511
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824276; cv=none; b=kLvAa+Pr/gjeXfTuF25aPqb0RGmBWMaTEQAAHOMZJwFL4NHLCsx4mvLRR58ctqToD85Vg6yACNt5s+jLjMEArQOLviQs0X7HVMIWk0Nip6k1TDj0zxPwr4SEHn2R8sHt6r2gQDEujO83/LORUMU0weKt+mBs59SB9Afv2uck/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824276; c=relaxed/simple;
	bh=Zlo0CmN+rPcs3sRSQ7xchoQ1HyxThyGFblgLrl1PFj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7f+fstdsG8p9dwb6Qy9wh7Fdph1M4co4NUkLeZSpbKodFcc0ftOER29Ldzv924rKq9ej8a12FSMwQX65EcfArwQW3+tXOuhZYPUr5OVf5vtCIWi8jUTcpF5qWE78BeZvoQiPXzm3YKNefUZY0vZ5vBypWKeGvxc4CsX2YlXNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxyNKw8c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767824275; x=1799360275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zlo0CmN+rPcs3sRSQ7xchoQ1HyxThyGFblgLrl1PFj0=;
  b=YxyNKw8cjLOa73q59vFPXRRGTf7cOx4OaSOiD7belvARPC5Kxz3OIZjb
   gvJ0k3sKox56JILvPIdmIIrSAfQtK9ZN8o1VIigT0xdt/WruND8EaYK9D
   vmljbpdOLnWemD/KBsu2gKLeUgMLAkCYwnWtJodx+CBWnlLRjO7FfgZxZ
   dvIW79qku+z4YAofLl5a0coLZE2m+/2cwIM2emMGnnpmirSXYzdzaKRnD
   WMmqJnHreI1zYwZcXl0o75lmXjcHUPoO0eZCVaw6So1N/1YUHKT3dZXfI
   N+ZXL32yEHxZXN1TU6Ba2iHzU68Q26k2BzbshrmEntUN8qZt1L6Za/GOR
   w==;
X-CSE-ConnectionGUID: Kl/uumnkSnCoza8nlb3DSQ==
X-CSE-MsgGUID: q93ZOy0iQx2d1ZR0NiBgIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69181968"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69181968"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 14:17:54 -0800
X-CSE-ConnectionGUID: EVas2kpySpmlWi33SBKJVg==
X-CSE-MsgGUID: 5qtEwj8qRpOhbUdAIamdQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="234185958"
Received: from debox1-desk4.jf.intel.com (HELO localhost) ([10.88.27.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 14:17:54 -0800
Date: Wed, 7 Jan 2026 14:17:53 -0800
From: David Box <david.e.box@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>, bhelgaas@google.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: OK, let's try ONE more time to get the VMD ASPM patches in, ...
 please?!
Message-ID: <d33kx7if7cwin7migv7jm2gaf6s3rf6j5zi3rzvmaddmymi2q6@lnazkzumnclf>
References: <1a1e80e8-e821-4736-b772-b27f1ad88dc3@panix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a1e80e8-e821-4736-b772-b27f1ad88dc3@panix.com>

Hi Kenny,

On Mon, Dec 29, 2025 at 03:37:31PM -0800, Kenneth Crudup wrote:
> 
> The good news is that after all the ASPM refactoring of late, the patchset
> to get VMD ASPM working has dropped from 6 to just two (see attached).
> 
> I've been running some form or other of these patches for THREE years now
> (with, OK, sample-size of "one"), no issues for me in all that time.
> 
> But without these, any VMD-enabled laptop never goes into s01x suspend and
> drains so much more battery when idle or suspended (I'd give anything for a
> true S3, but that ship has long ago sailed).
> 
> What say everyone? What can I do to help get these into mainline?
> 
> Thanks,

To be clear, the two patches you sent do fix the VMD ASPM problem.  The
reason they didn’t land earlier wasn’t correctness or testing.

The concern (Bjorn please correct if I misstate) was that the ASPM enabling
path in the PCI core is already too complex, and adding a new host-bridge
override API (even for VMD) made it harder to reason about in the
long-term. His ask was to first simplify the core flow, then consider
scoped overrides.

The recent devicetree ASPM work shows the direction this is going. I think
VMD can fit into that model, but not until that first step is done as it
requires a different tweak to get around aspm_disabled = 1.

So I can’t resubmit those patches as-is right now, but I am planning
(within the next 2-3 weeks) to start with the core simplification work,
transitioning to a default PCIE_LINK_STATE_ALL, that would make a
VMD-specific override acceptable.

I appreciate your patience and the long-term testing. It’s been important
in keeping this visible.

David

