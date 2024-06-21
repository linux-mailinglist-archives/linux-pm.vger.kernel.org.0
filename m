Return-Path: <linux-pm+bounces-9733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF4911B9A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E36AB24A30
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666213C9DC;
	Fri, 21 Jun 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDORCxfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0B12F365;
	Fri, 21 Jun 2024 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951050; cv=none; b=HjLK6LtEr+0Ik/E5VVgpCvA+z2SaivVgGHLDhZJk9yzlgbE+x6KvIz3a5IU7HAnWdvPEZ//ntFIPkniG0s5X1nogbY6XyFS8jcNTT1sDIOz0KEZCI3x66BbjcN7E/n87lEN8eHGX2x5RtrkLlk8KLjKVheblk9tLMLSGmFbYNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951050; c=relaxed/simple;
	bh=7Cn2LiEwUik0k5WAFctKO8MFLAbRBS347iFlEJ7yo5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBoEgYol/tzDQmrlOPMhfNoZY87D/X9ZB+IOAKXmLLoqczMTNy2elZWD3cFHkHEBtID4JQVUXYCCuj2SSaTM5pSIG+JSJumlBzcG/42q6ShVjWLmNk7VbXzQixDSFXP8FGOt+ZnhThWHm5r5xC89E8xum1CokgFOA9Boa0js9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDORCxfO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718951049; x=1750487049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7Cn2LiEwUik0k5WAFctKO8MFLAbRBS347iFlEJ7yo5k=;
  b=ZDORCxfO6az9vJ4qcbjCGNdgFI7ONW38ZNsoghk60kSzp0gIUxxNifx5
   2/8q55nUpus+7mvUvFTD8qHVBwc/O9mJBONEuMd98Nn+zx60tTdUxyKj3
   qC/uKmIxC8LdRnbUGMqgmKMopj4O8qbJcx3nG3lA90fKGt3ljXFQhhva2
   PSzhYlHiSzQr04VGASon/knSnpIch5peJ8kry0brVmdGIHrp0dinwiqRN
   NXkoEX+pCj4Cga560+wxL2I7idF24Y4XlM9pIZDG9kRtScDSyRcs2q1Yq
   byBN8NvHOCwonmFYSi/+URF6TpKJWjuH84bWXpH3Lg6WVceCzfhq1eBce
   A==;
X-CSE-ConnectionGUID: yBd7O+YXRN6dOcFM9EKu0g==
X-CSE-MsgGUID: Mu5FDXb3QvaiKukxuEd9bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27106815"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="27106815"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:24:09 -0700
X-CSE-ConnectionGUID: CK2E6po+Sd60GzmEnY+SpQ==
X-CSE-MsgGUID: ZQx7FbvFSRSuVXrXE+lpVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42572422"
Received: from mesincla-mobl1.amr.corp.intel.com (HELO desk) ([10.209.40.87])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:24:07 -0700
Date: Thu, 20 Jun 2024 23:23:58 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Brice Goglin <brice.goglin@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Message-ID: <20240621062358.w4fjrs62uu2s5onk@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
 <ec4eeab6-ce32-4a2f-a32c-dfd95cdd9ccd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec4eeab6-ce32-4a2f-a32c-dfd95cdd9ccd@gmail.com>

On Thu, Jun 20, 2024 at 05:22:59PM +0200, Brice Goglin wrote:
> Le 20/06/2024 à 17:06, Dave Hansen a écrit :
> 
> > On 6/19/24 14:25, Brice Goglin wrote:
> > > Good point. From this patch series, I understand that the current kernel
> > > side doesn't care about these different E-cores. However it might be
> > > good to expose them as different cpu-types (or better name) to userspace ?
> > > 
> > > Something like type 0 = P-core, 1 = normal E-core, 2 = low power E-core ?
> > The first priority here is getting the kernel to comprehend these types
> > for architectural purposes: when there are functional differences
> > between the cores.
> > 
> > Let's get that in place, first.  Then we can discuss the possibility of
> > new ABI in the area.
> 
> Agreed.

Sorry replying late, I was on vacation. Yes, let's leave the ABI for
another series when we have a clear use case.

