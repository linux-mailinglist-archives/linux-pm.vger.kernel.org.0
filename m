Return-Path: <linux-pm+bounces-9373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDC990B97B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FED61C24633
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AF19882C;
	Mon, 17 Jun 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSLWBRTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505DF176AB9;
	Mon, 17 Jun 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648098; cv=none; b=Bs6ofTDS6xCt3Fcvar/RVVtyD9XN9+cWt+UQZp1M13BkRbUmlnKeXv8ixIe4tzoSpVMK23ZiHphZu95Rf6KOPa97+EXzT5gSxMMeXV4NfRzpMmnBfJFWsEO5aoOukQ7xuUm/r6j5cZ6/OE1Am+WYlC6VkgWgDwWXYv2FKkPtJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648098; c=relaxed/simple;
	bh=MIa3xvuV+HOiLJMXu/l2HyJt6CJ/cL6AEHNsbQwcJmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj+N84zxMqyM+YLV4x6LGiTb6id8vjs7dPG03MR+bWjys1aEkNDYN9KbX0WUWVXLjeE0XPYj/8m0evMTJNpXSaIr7Xds2KFi2XzmfI5cYekfN7F73B89UDCJg/xS4K+T0gc3tlGTd3PrFXQ2Dz8gDgo8KGV1ivLCK4lJntqhH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSLWBRTe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718648097; x=1750184097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MIa3xvuV+HOiLJMXu/l2HyJt6CJ/cL6AEHNsbQwcJmo=;
  b=WSLWBRTetOjCle2rZmylPQQ/oqUroG6yKeZlMV6JU+WvvSzQLXBmKBiL
   BYuBUTsiP65lfyxFdfR/ltoSA6zG49JWmqagisEXBGGHsWRZ1PUwsxDRa
   hCtsGAl9E0ZS+Xs1ArncalE7Ox+01burwoGvrBYVKIG313lPj7Bu7GI8s
   fUHLaHqWDSgx7Fp3kUPd8b0aKMLyDlUAyWaizZliK/j9RNxNzLHGgtqPP
   tyxC8peaRUcHCmztYe15I74cFRZSVTiwMAqdBD/78mExzX2CEtMJohTic
   v/ZLTnpAot7EQI9bCz6LY/YIEGrM7GgyG6m/7IrabA35xaMlDO5FCAfcT
   g==;
X-CSE-ConnectionGUID: fQwvYVFQQnqT7rV3IHzwsw==
X-CSE-MsgGUID: 2vKVdsRXQBuqzUYdPkdAIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15259962"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15259962"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:14:56 -0700
X-CSE-ConnectionGUID: dHSGPgMkRQm1BslqX/cgWA==
X-CSE-MsgGUID: nQDlBqz0Qwq534tEpZ8d0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41145885"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:14:56 -0700
Date: Mon, 17 Jun 2024 11:14:49 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240617181449.mudbeq6kd7tcjft5@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
 <fb789f0a-0c80-49f3-ab7e-d22fc2793a49@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb789f0a-0c80-49f3-ab7e-d22fc2793a49@intel.com>

On Mon, Jun 17, 2024 at 07:13:15AM -0700, Dave Hansen wrote:
> On 6/17/24 02:12, Pawan Gupta wrote:
> > No functional change.
> 
> It would make me feel a *lot* better if you also dumped the before and
> after binaries and made sure they're identical.

Right, will do.

