Return-Path: <linux-pm+bounces-26845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02852AAEDAD
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28797B56FB
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55E28FABA;
	Wed,  7 May 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpzYs8Nn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46C1E4AB;
	Wed,  7 May 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652418; cv=none; b=Q7HnTKrRep2Qhp4gSWkYSPiK34jNw17JXITz5YRE+yLXXBr2KVQfXaimXzxkvjxy09FMGVt8x+PeYfLp8sHuobHWvEuMhMMErlrktQhlNFIcqb+5tLuEDIH1x63JZsPei05sE/ZClqHw1AMaumklZmewjtIEUdoo7CJM+rzTrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652418; c=relaxed/simple;
	bh=6fHhnpXDAQhZV2ukVhtrbZkclB2lIGfri+PqEM2Fm2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGoQJmTJiDPJdfvzWt/DAcZsKaGfhoWfXYKMnTzw9FAyQkfGTM7gY1ef0GKpUBIdmIW97ptnC++45E2qzHyyGx95xcQi6eWTrEQh1JJwsu1Vbg0KQRWcJ/VOnEL9w2YxthJ7JDn5UomFm0oe1FQ2xnP9iDyz0kBwfVLQrgUsKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpzYs8Nn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746652416; x=1778188416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6fHhnpXDAQhZV2ukVhtrbZkclB2lIGfri+PqEM2Fm2Y=;
  b=gpzYs8NnNYJun60RN0wUh0e44nWITo4mF36YAPX2Z7kUhwZnRaCNRf+U
   lQJvUKtdczG48K6tmfUbwhJDTyFwuh87KBhF8quFfFdZkQgAT9g3eLPrC
   zgOddsZzTv/GpQ5qkacUaz9uY51FsE7/b9O/mODjTrzGSNDqAASocazWh
   f79+kd2iGCguRFa6NilbiM52WpHDeRJFenPYqSatZLjBavDFmahDxpQ09
   PWx4KtQETypDbYu4QQheoHJuPInpJ7TaScc0mZjveen8lfseenkqG8TcT
   0BbSVUvRsmjKjQ+QkI5bfLRqEKeNoXSa2/oDQgpQgefenLbbYUfAvTb/z
   g==;
X-CSE-ConnectionGUID: /oxPP0Q3Q86lfS20i55usQ==
X-CSE-MsgGUID: Xtk0LUy6QUeIJIOmb8OkCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48278115"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="48278115"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 14:13:36 -0700
X-CSE-ConnectionGUID: MuRt1wA4S3e57hSpg6hFOw==
X-CSE-MsgGUID: BblFTQLDR/eNk/uhw3Rj5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="136593394"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 14:13:35 -0700
Date: Wed, 7 May 2025 14:18:41 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 1/2] arch_topology: Relocate cpu_scale to topology.[h|c]
Message-ID: <20250507211841.GA28763@ranerica-svr.sc.intel.com>
References: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
 <20250419025504.9760-2-ricardo.neri-calderon@linux.intel.com>
 <7c583e2e-14b6-40e5-8e12-01584b817e4c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c583e2e-14b6-40e5-8e12-01584b817e4c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Apr 25, 2025 at 05:31:01PM +0100, Christian Loehle wrote:
> On 4/19/25 03:55, Ricardo Neri wrote:
> > arch_topology.c provides functionality to parse and scale CPU capacity. It
> > also provides a corresponding sysfs interface. Some architectures parse
> > and scale CPU capacity differently as per their own needs. On Intel
> > processors, for instance, it is responsibility of the Intel P-state driver.
> > 
> > Relocate the implementation of that interface to a common location in
> > topology.c. Architectures can use the interface and populate it using their
> > own mechanisms.
> > 
> > An alternative approach would be to compile arch_topology.c even if not
> > needed only to get this interface. This approach would create duplicated
> > and conflicting functionality and data structures.
> > 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Maybe an FYI for the non-x86 folks, this doesn't break anything on the
> usual arm64 setup:
> Tested-by: Christian Loehle <christian.loehle@arm.com>

Thanks for testing these patches!

