Return-Path: <linux-pm+bounces-22544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E460A3DA8A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11853189E720
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EB1F561B;
	Thu, 20 Feb 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjfIwrzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557171F4621;
	Thu, 20 Feb 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056101; cv=none; b=ovj+MKChdCsCMvpyfyXVlF5bCubLJAGkDGNDw7DvB8Zxm1urhE62bgkQlH348m/+gNSqR9dcjBiz3MAabZ/jT0EfoQg9GV0EzRNQIIrN4F9VmW3guijJdoBrZXC1Fe42WY1vSc+wsnwv5RXAbzSrugFNLSZELsJhdb5izcfS9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056101; c=relaxed/simple;
	bh=sBHem4zK9G85urgcW8anMZnYb9lfCBQvoHXta4ohn/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXffaTyAfJcbkJyLaeMVEqgzGml4gaj8TllNa4O5AywOduJdbxGIKV8aLqVsNIjK8hA6e0CS+2kZCWFcAyJ61zSNqJ5vWI/PCIG1ooGATSdbpaKgysU3hHDJK+n2W/p3ycoTOeuqpKer8cDRCBuSNRftkaOsIbbSqriakfFtkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjfIwrzL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740056099; x=1771592099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sBHem4zK9G85urgcW8anMZnYb9lfCBQvoHXta4ohn/Y=;
  b=bjfIwrzLSr1/tm79l95kmggkxPiYPpFL7O1LfWdLD4n0jQSotS/8HFv6
   0WhEuNi1AdyEONf1QL48kHtnVr4ru24TC6o06yXREg/4BhV5bxes5ptEa
   OSebiOEdf9nzdOKtchc3Htew02gS3cO5/byRQG4Ta2cwGqSA/a4Y0r9kJ
   p2PU+6Ob8voEtvICv92i6i3jaXIgi4O2bbFT+k8Jz5l/k7js1oP4pmMYy
   ZBLYdhShAnRu0l0SKrAdywMMkoxZ4BrVt4Wy5hK0u9mDFdTNw8PWonxq7
   RwUQOI6BkWuc7JwMuQr2Uxh9NM7fsabx+6hLX3GG4EgdT/RQz1agZwrIZ
   Q==;
X-CSE-ConnectionGUID: O74B6JuRSruQ4pdwy0Ra0w==
X-CSE-MsgGUID: CnorXsUOR5S+5pdaTx0U1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28429148"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="28429148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:54:58 -0800
X-CSE-ConnectionGUID: isdo0tmaQLabSEWAx0cJNA==
X-CSE-MsgGUID: huZm/DEhTC6VejN1rexusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120015815"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:54:57 -0800
Date: Thu, 20 Feb 2025 14:54:53 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: rafael@kernel.org, andriy.shevchenko@linux.intel.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: Discard runtime_xx() handles using pm_ptr()
Message-ID: <Z7cmHZ_uuM31mGRd@black.fi.intel.com>
References: <20250220080318.2660840-1-raag.jadav@intel.com>
 <04b87029f2237e209d8c8b620d009692d80eea2f.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04b87029f2237e209d8c8b620d009692d80eea2f.camel@crapouillou.net>

On Thu, Feb 20, 2025 at 01:15:19PM +0100, Paul Cercueil wrote:
> Hi Raag,
> 
> Le jeudi 20 février 2025 à 13:33 +0530, Raag Jadav a écrit :
> > Discard runtime_xx() handles in RUNTIME_PM_OPS() using pm_ptr() macro
> > and drop unnecessary CONFIG_PM ifdeffery.
> 
> So the RUNTIME_PM_OPS() is newer and people should use that, but we're
> not yet at the point where the older SET_RUNTIME_PM_OPS() macro can be
> dropped.
> 
> The difference is that in the !CONFIG_PM case, the former will
> reference the suspend/resume functions, but they will be detected as
> dead code; on the other hand, the latter macro won't reference them at
> all. Many drivers still wrap their suspend/resume functions in a #ifdef
> CONFIG_PM to avoid warnings about unused static functions. Therefore if
> you unconditionally force the use of the first macro everywhere, many
> drivers will fail to compile in the !CONFIG_PM case.
> 
> As for adding pm_ptr() inside RUNTIME_PM_OPS(), it is unnecesary, as
> the whole pm_ops struct should be referenced through pm_ptr() or
> pm_sleep_ptr() anyway, which means that the whole struct and the
> callback functions will be garbage-collected if PM is disabled.

True. My intent was to garbage collect the runtime handles, atleast until
the users are converted to reference their struct pm_ops through it. I
didn't account for the driver wide CONFIG_PM ifdeffery though.

I guess pm.h has its own learning curve.

Raag

