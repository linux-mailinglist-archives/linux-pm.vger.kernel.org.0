Return-Path: <linux-pm+bounces-10298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32E91E65F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91F31C21124
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FA16E88B;
	Mon,  1 Jul 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm0pZK/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469616E880;
	Mon,  1 Jul 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854107; cv=none; b=q5JFXU8yS10kK3grI9aR+9XmOxXLT+V90zebiBOk2zBUoSsgS3rsUQWdrBhRD7CDYrFMVHp2ICeNbxmZL9LwUq6nghFtOZ9Lu6hHlNfTkikGlBPgYzjGGjfqXKN7jR9D8R40sU5/ULHhhSCm02qP+86dVAmVF89ozUvyCZOnZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854107; c=relaxed/simple;
	bh=E4tGo/UIChU9oL44JjrZYtncmJdcFllLulfgmDghc4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItQ6k/6XSPoR1nTJ40LYdR+qxAX37MOWFXag4BV35hdKJp3WZJ9YXmOzUy2jhHe5KzP9KC4DtnaL1tqbhejyBLsdRXp4PZYxhZ6nuBi3YSSsaxSyDnS1F3/ZeyVkKYNV3zPb9zL5rjujH9hNaLFY07L9D+um+r5PX8XFSlVCjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm0pZK/i; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719854106; x=1751390106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E4tGo/UIChU9oL44JjrZYtncmJdcFllLulfgmDghc4g=;
  b=Qm0pZK/i8ZANVdTw5sYQ4J05vUF2DTz8yLsZQ5VGG1cWFnaidTcdO07Q
   LYAJJVx1Oj24CftvzwlJVI8P55QaLJwcw+o8nnZY1VHLDT63DD+lVGJ8E
   jFidWSSA3yHp12KM8kWZX5aP5ihdMd1BgvahtwNrr6/JJq28TpthTKjmH
   apaUvYItqy9AhpMsLtFFFbBVizSHS741NmbHd1p0hUtVG7O6YzPCiSzI4
   HnwsZCEts+QmcRWwLLSMd19CH7nuB/UPKZYedbEs+gAcYWweLzaX2S4eY
   H25+0iqXIm2uPCrO8DZXiopXjFGggvo3RqaIKgQjmbfO9KlF9cJAkCxUt
   w==;
X-CSE-ConnectionGUID: O7/dLit4STe9Nk66N/yRcg==
X-CSE-MsgGUID: k2DXVdS6SnWfalEbsPjTng==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34538878"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34538878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:15:05 -0700
X-CSE-ConnectionGUID: anAxlbOqSouXpEKK/BL55A==
X-CSE-MsgGUID: dmQG5tqPQrWPU1KAvBBnRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="76769766"
Received: from aadeosun-mobl.amr.corp.intel.com (HELO desk) ([10.209.8.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:15:05 -0700
Date: Mon, 1 Jul 2024 10:14:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH PATCH v2 2/9] cpufreq: intel_pstate: Use
 topology_cpu_type()
Message-ID: <20240701171456.ahmlmm7vb3gk5rcg@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-2-f927bde83ad0@linux.intel.com>
 <CAJZ5v0g+ih6Yh3su58Wrj+p04vr_4nmcJc41O-8_OCyzVQFKpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g+ih6Yh3su58Wrj+p04vr_4nmcJc41O-8_OCyzVQFKpA@mail.gmail.com>

On Mon, Jul 01, 2024 at 07:08:41PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 27, 2024 at 10:44 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > Intel pstate driver uses hybrid_get_type() to get the cpu-type of a given
> > CPU. It uses smp_call_function_single() which is sub-optimal. Avoid it by
> > using topology_hw_cpu_type(cpu) that returns the cached cpu-type.
> >
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks.

> and I'm assuming that it will be routed along with the rest of the series.

I believe yes, as it has a dependency on the first patch.

