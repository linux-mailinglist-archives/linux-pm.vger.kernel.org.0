Return-Path: <linux-pm+bounces-14977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F998AFD1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 00:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D04D1F23EB1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5918891E;
	Mon, 30 Sep 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3h4fqv4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BE186E56;
	Mon, 30 Sep 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735344; cv=none; b=D4kRVjBhLvcMSgFddM/euvPFegALWPEmNBkf46B6bYiSRUaWHath7zh0Iw7O/ErVv6KzN/X0sGjABMO9K2HwgFMH05YHD7thip7V/CdmZ9PW4O7+BCuB4Vt83GWg+NpKoD495DESVKGFo+fD87S1zlwhRVC4OJWKF/YN84Y+ovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735344; c=relaxed/simple;
	bh=z+n2UQSWlwP+wMogZCWfmgbHLSl16zo+IImxnpZYpII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+Rwrord0mk6PONf4JUfC2Y/R7h9sEgo5yNNrTzs4sI8DqrDsTzndIw5ccxsPmxIUjdvHE8Et4js33FnWYV6EaOSTFdrXPOCzeKBVvszXcpAc/uHJl1M8VpgOFm4ufh5zpYqh4G+xJBX1URjYdxZNYROVLs7CpdBR8/9cX+QY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3h4fqv4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735343; x=1759271343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+n2UQSWlwP+wMogZCWfmgbHLSl16zo+IImxnpZYpII=;
  b=h3h4fqv4Ywxe7vsngfqt7Hs7U8HgqJ1X3TXQQwsoUfFhDwjyRD2dzVfY
   oiDoeIXR88P9ksGr94SKHvLLIXNDC7pCOuX6tRUTyxA6fToxDAF4CQRcw
   GgVBKlTFxCJB7jeNvpnvULnlyY0TufsEOV/dd+m+Is66NxQ6rUbtulDaK
   k7Dpc5p91+K8LkQ3tjVzwRFq5NzeoB+28mqXnrHDI3ISvJJECJ2CznHqu
   1/LgX69B04Lw/LSj9aEhjeJhwGxFIqlhcEMAUO+/Ukv4LmMY3iHZfd7SS
   bJvjmWBQXWgczEKO7AU5jFVD+sR1e0B6h8VWNjpI5cw+t4kJVUrfxiWQT
   A==;
X-CSE-ConnectionGUID: 6Hn9b34URo+2eB2gYDhdkg==
X-CSE-MsgGUID: 1wKoA3AlQ5il03poatb0ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44370266"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="44370266"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:29:02 -0700
X-CSE-ConnectionGUID: 9+EZa6/5S/CEe3tXIltZDg==
X-CSE-MsgGUID: Vrse0KvZTYacdmDOVFUJfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78189235"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:29:01 -0700
Date: Mon, 30 Sep 2024 15:28:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 00/10] Add CPU-type to topology
Message-ID: <20240930222856.mwqqeexb4ezqq77z@desk>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <0d054389-c60e-4b7f-bff2-e95f50c239f3@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d054389-c60e-4b7f-bff2-e95f50c239f3@intel.com>

On Mon, Sep 30, 2024 at 08:12:57AM -0700, Dave Hansen wrote:
> On 9/30/24 07:47, Pawan Gupta wrote:
> > This series adds support for CPU-type (CPUID.1A.EAX[31-24] on Intel) to
> > differentiate between hybrid variants P+E, P-only, E-only that share the
> > same Family/Model/Stepping. One of the use case for CPU-type is the
> > affected CPU table for CPU vulnerabilities, which can now use the CPU-type
> > to filter the unaffected variants.
> 
> The series looks fine to me now.  The diffstat is _almost_ even, despite
> the series adding functionality.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks.

