Return-Path: <linux-pm+bounces-10129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4E91AAF4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2911C22191
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131419883C;
	Thu, 27 Jun 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPl5dHh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D51327E5;
	Thu, 27 Jun 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501489; cv=none; b=UbYW5CCdXLB1WOOFUKGsVOmy14zh7F48HIglbp40AyCOaMXPF/yJNhw2i5xHXUSXDjWSGCQFofmWbJIEf6I3ZzoyBMxwuRXYMIi5h3yzAWme2pWXgn50x8iIKY094tlxaRRt3O2PDSK8yhfTM2lZOROqK6AP94NqV9POCBVI/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501489; c=relaxed/simple;
	bh=t6wOLVRtPvZOPfLZT8uMNs9TY/BtnLK/3szoxyqDWjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOrWA6iPYUjJBS8PJWfUX7Rjh+kqOXq5unPb9Bd+GUflwjYDyKPlaGAImgsO6qVLuFYqiuBjRqTRDOwM3mvNZbmbWptL+ZL/9yF/VUUU9alG8hyq7Hx16wSJZY4hNhr41D2oTL5Y+PsSr9jICsIPuaiXQpqZXmaQMKja4Fr8bn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPl5dHh/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719501489; x=1751037489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6wOLVRtPvZOPfLZT8uMNs9TY/BtnLK/3szoxyqDWjM=;
  b=SPl5dHh/h+iSpGc+QFOqD3M3ZJJRex4uxeb8vKLph/88hXCvnYUPPDKu
   Oj9EDCceYpfKFAyP9feKBYpiGNJgzohxrcCyVw/yIkbicVASjIQxsqDEW
   zIhqhs2B7PhMfUN4w3Sp0rfa4cuu9knYimzDYPaN+UMvmavmbiFUGBWGr
   8lAaRGLyZWm9G3MFDQlWyXF0XJ2LhPldBlLnhsNfYRt7ryr+h3CGWqoRF
   E/jpQRqpCj+0wmnvDnx0UO8xRxo5BcCLr13A6Doh5K5Yfu45NZ9480j0v
   jOYqj/5nZWwO2bsPrCzyu1QZrX+IX6B9+J0336m24u78lWWTD0PTmghZO
   A==;
X-CSE-ConnectionGUID: Y6MxXiwhSGiTQ7YIVQYyHA==
X-CSE-MsgGUID: NOXhm53DRtGZDkeSEtfKzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16459575"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16459575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:16:07 -0700
X-CSE-ConnectionGUID: TD9i/LBWRNCyaxtUPLZ/6A==
X-CSE-MsgGUID: lazvx7b7SIi1dmhUrposWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="45064396"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:16:05 -0700
Date: Thu, 27 Jun 2024 08:22:11 -0700
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
Message-ID: <20240627152211.GA5201@ranerica-svr.sc.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <16994d97-0499-4e3b-8890-328e74adc91d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16994d97-0499-4e3b-8890-328e74adc91d@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jun 19, 2024 at 11:22:16PM +0200, Brice Goglin wrote:

[...]

> > There can be many ways to expose this information in sysfs. Like this ...
> > 
> > > [1] https://lkml.org/lkml/2020/10/2/1208
> > ... exposes /sys/devices/system/cpu/types which, in hybrid parts, creates a
> > subdirectory for each type of CPU. Each subdirectory contains a CPU list
> > and a CPU map that user space can query.
> > 
> > The other way is to expose the CPU-type in a file:
> > 
> > 	/sys/devices/system/cpu/cpuN/type
> > 
> > that could return the CPU-type of the CPU N. Is there a preference?
> 
> 
> I'd vote for the former.

+1. With the former you can read all CPUs of a given type in one go whereas
with the latter you have to iterate over all CPUs. By the time you are done
CPUs may have gone offline or online.

