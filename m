Return-Path: <linux-pm+bounces-10130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F691AB01
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC4B20D76
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02F198A09;
	Thu, 27 Jun 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5b4zUYw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17D179647;
	Thu, 27 Jun 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501658; cv=none; b=jPzKGdSwXEj/Ok9uB8DaxKw/rI09I3UtpaEDBtDrC7okPWL4TuW8R1EhYiLBMc0Z6wXdyZmGSWVnCzGbEZaaQg7GXUhwYQ/HfeIhrjl7eEYZbvZMTLla8Np9zjybY+4sbLvQ20whBMD8OujW9p69jJgIdKo8JKQ8rkytST/lIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501658; c=relaxed/simple;
	bh=NkvMMppuUbS6id5yTyzLodQXYpLnaEoYzmCfyXpSxOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7ZEv/HnUfS2UAPuqf89+JfNsDyMiP3YI8d6iMW8TqzuiAfpvtHh4CuuIVxg6s5yARbK4QkhSsvm08YzZBnoD0gIPP3qDVdMKfbXEQhjiRIK5V0V9e0JUeOAa5Qwa5CmuysKaANf1DkIalYOql+xldpjfXslZSw/370x3BA8caU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5b4zUYw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719501658; x=1751037658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkvMMppuUbS6id5yTyzLodQXYpLnaEoYzmCfyXpSxOU=;
  b=Q5b4zUYwJYVnGwccwyMvrKeodErxBCvwm375jUTlEjmkOtygaXpV3lnp
   LmiQMi7p637UToz4cbkxsqWF3TdlDUAcOYNvJIK5Oq7ZDqnAbPx3fsqIU
   fZnxYtclpvR4PYk/1Ko0Bg8B9ZmMUgaQn/43aRRBs/NxWyjdZYjxgKIna
   18G/9g74rVcsWAskn/UWc5YCKO8dOI4iZr+e3NaYQ3iUnWBmDvbrZ2ZRv
   h0NIff658P6ND0iNsg08xgk5+GCGC08duV+FUgTSgyhP3YSgkqYXlMNHL
   CZtFaqKIV4Ulvqp+7rR5h516JGYOgWH/KFNEYbw/raItKyXuridLCyveA
   w==;
X-CSE-ConnectionGUID: eUBS5FRVSwK8jIVKpyhM0A==
X-CSE-MsgGUID: L6eJ8QnVQ+yNKfELxv7PXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16598246"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16598246"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:20:05 -0700
X-CSE-ConnectionGUID: laF0R0DCS324PwXm2xKZAA==
X-CSE-MsgGUID: yXj6WzGcSD6YukqcR3Unrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49580365"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:20:04 -0700
Date: Thu, 27 Jun 2024 08:26:09 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
Message-ID: <20240627152609.GC5201@ranerica-svr.sc.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
 <20240627125154.GA4743@ranerica-svr.sc.intel.com>
 <20240627132230.hondzls5bt3jspay@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627132230.hondzls5bt3jspay@desk>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jun 27, 2024 at 06:22:30AM -0700, Pawan Gupta wrote:
> On Thu, Jun 27, 2024 at 05:51:54AM -0700, Ricardo Neri wrote:
> > ARM gives userspace specific details. This makes more sense to me. Instead
> > of reading these details, user space would have to infer these details if
> > a CPU type was given in sysfs.
> > 
> > Having said that, Intel does have a CPUID leaf that gives the CPU type. Such
> > leaf also has a "Native Model ID". Exposing only the CPU type may not be
> > sufficient.
> 
> Do we know if there are applications that would benefit from this information?

Probably not, but exposing it would follow ARM's approach of exposing the
raw details and let user space consume it as it wishes instead of having
kernel give an answer that could probably be imcomplete.

> 
> We agreed to leave sysfs for another series. I will be sending v2 soon.

It is fine, just wanted to express some opinions. :)

