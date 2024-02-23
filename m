Return-Path: <linux-pm+bounces-4329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A5861621
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE8E1F210ED
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E182882;
	Fri, 23 Feb 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8mhjl5s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEBB8287B;
	Fri, 23 Feb 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703056; cv=none; b=sHbtDw6TbaGo59cgelLQFDkpHw73I25oWSpdov8F400vcTcoZf23fQnj2l1i5krWyRDPEadSihjQ0tH6uHl2bC0fY2u3dj0DPTjmLOO9Tj/OaqZsJXJ5Jv5BBzMMKPCPjCt/rDHjF9OowsI10DvWxyZeOBmN0jCIvdqXAT4IfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703056; c=relaxed/simple;
	bh=GKrFapZlvSWxGoxTrSpuYyRv5Do4WhNJBO+W7E9esiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C89/wk3LjuqL+5wn/tZIKBp5reCHhVQ+rYyzn+gzLkTlogrgLcbSDvh+Sg0y5migTJvO3nLq60Vrz4C9ns9l9L8Li3H5OK8+/tTVd1FSKUs8kVI8fUkSiBqXlQnddSKSsWGIkgfo/6Ff5p20Xo4YmrPNAhfcEipb5tF9PMW7mF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8mhjl5s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703056; x=1740239056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKrFapZlvSWxGoxTrSpuYyRv5Do4WhNJBO+W7E9esiE=;
  b=e8mhjl5sp4Em3UZciQONniNIue5ZLDTqq/jvQ7vRK4u/xX9H5GvDTl7n
   d2ILViK2RaMtb2x9SFGG+SOTB5RwKVMzcLRXtlvgjEypLHJy1TpmIfmGP
   RfHUwi9yuu+3wRA7+GTFModokTD4j2+L2i5GuuMb4B+a0Uewb4f326jY2
   oRVocclncmJHEDPCQU/YoamgB1+J/tbvgTLZl8boxGUUfy0ews2hbyxDk
   cSZ8kMVmyfu/gcMMPNl2Sfz1D4pNCmRiCd0NHAxBk/Q3xWnpwL0ANDMD7
   hdTo9JyIhYNjAXQqMk2QxzlDAgRwIi4r1lIsVBR/WZo6OnJtlRGkaFryD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2909710"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2909710"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5888041"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.110])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:44:11 -0800
Date: Fri, 23 Feb 2024 16:44:08 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature
 only when required
Message-ID: <Zdi9SGVE3tT/f2KT@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <20240215212946.08c730d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215212946.08c730d9@kernel.org>

On Thu, Feb 15, 2024 at 09:29:46PM -0800, Jakub Kicinski wrote:
> On Mon, 12 Feb 2024 17:16:12 +0100 Stanislaw Gruszka wrote:
> >   genetlink: Add per family bind/unbind callbacks
> 
> genetlink patch is now in net-next, and pushed to a 6.8-rc4-based
> branch at:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
>   for-thermal-genetlink-family-bind-unbind-callbacks
> 
> for anyone to pull.

Thanks!

I'll post next version of this set just to linux-pm since remaining
patches are thermal specific. If they will be ready to apply
the above dependency can be pulled by Rafael - I assume this will
not create any marge conflict.

Regards
Stanislaw

