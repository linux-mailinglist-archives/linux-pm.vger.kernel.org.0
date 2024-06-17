Return-Path: <linux-pm+bounces-9378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B0E90B9CD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD921F21AAB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF572194C63;
	Mon, 17 Jun 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEJMdMmv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36620DDD7;
	Mon, 17 Jun 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649423; cv=none; b=EUwpA1uVx2nVY4zCRHg5maojkIlcAFAZ1FgJINTkhVx8GtFLPMihTSMPaYbEPNQqjUMZ+gRhWpEYaYSCVb10hsbAzcmx9l7VDAzJkw9gMvFS2u7CUL1Pws8APiMuWTojxO1PCg208WfWQNLngIuRN60vk+MUejt2maaebYlycTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649423; c=relaxed/simple;
	bh=u2eStRmHIkadI2AZ4JryxOSu2DAIp7P1OsKonpwYmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kusOX8v9j3EOBHmG9or/t9pLsHNyil+puQuR9HosS3BS8JtwVbJwe6YxCsuKzzbz7DX4bj5JVgeePwVWvCVTisle9pquOsaX6bc29SXtVTa+CixOK0KyljgEoN9KR9MiOYCxl28f96Ky41s9mwzg6PcCAeateWHCXDVFo3Fxuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEJMdMmv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718649422; x=1750185422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2eStRmHIkadI2AZ4JryxOSu2DAIp7P1OsKonpwYmF4=;
  b=WEJMdMmvTHm+QAXWRuc/qyTupwd56i8hUkcMAcm/jX9eT2LhYhNKiLF1
   Go+aKwa/HpxxwxoypINMEtGuDrjwjb+I0ulGyaAEbdlhmWIgn+PtQSpMn
   6/fM2I2pE0FOmlq95CTTAwThFhAAIH6Qupia7eCcQH8mc407Dz6hLKcUz
   pxyKAavovZTM+x7Hwa0Uiks6Id6t/MptxlsclKdRnxSNnjPeCWCMn9c0k
   AsB46Yr0SVUMVBa21aI27iUDpcRdgcf006jkZMDFC49q30uB/TQFgHx5C
   Wwbf11izNTUPyeLUX2LHylv1G7zaeApZ0ROcPKqbUXC8xS3/Kd8htmNaw
   A==;
X-CSE-ConnectionGUID: GaTwUuebRa2ptdOIY7ARoQ==
X-CSE-MsgGUID: RFBXFq3HTuCjfWhulcWUUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15459839"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15459839"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:37:01 -0700
X-CSE-ConnectionGUID: vY969m1ASByHYkiebJiaXQ==
X-CSE-MsgGUID: gBmVhymxRYOgdsHG5I7FXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41969188"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:37:01 -0700
Date: Mon, 17 Jun 2024 11:36:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 2/9] cpufreq: intel_pstate: Use topology_cpu_type()
 to get cpu-type
Message-ID: <20240617183654.3rf6igiqp55pujrj@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-2-b88998c01e76@linux.intel.com>
 <27018603c7ed574451520aeeae405f7b1fcd6c4e.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27018603c7ed574451520aeeae405f7b1fcd6c4e.camel@linux.intel.com>

On Mon, Jun 17, 2024 at 02:27:02AM -0700, srinivas pandruvada wrote:
> On Mon, 2024-06-17 at 02:11 -0700, Pawan Gupta wrote:
> > Intel pstate driver uses hybrid_get_type() to get the cpu-type of a
> > given
> > CPU. It uses smp_call_function_single() which is sub-optimal and can
> > be
> > avoided as cpu-type is also available in the per-cpu topology
> > structure.
> > 
> > Use topology_cpu_type() to get the cpu-type.
> > 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks.

