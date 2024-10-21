Return-Path: <linux-pm+bounces-16113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043269A6FAD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90951B20BD2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC71CFEC1;
	Mon, 21 Oct 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlR79deu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1F1C3F01;
	Mon, 21 Oct 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528642; cv=none; b=FeKarYQxxBGCW0orzOS+295xvsBRSRD38ptljCXIfVMf0E7MprT5k3hF9/+ufDad22/3BUrOH8OM9ojrTDT8gPUhExUYP7NaywgSPBnHA3INM3uqPVut2XlXb/1SLXVUsS0SCvW8waWeZXxp6N3K8eeK2jQrjo2ygiu7pkxPEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528642; c=relaxed/simple;
	bh=cp6oYYgOsrrCc+iShk2LoGhhdoylFkelstQyBdhSgZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcM0IovmOQRxjEbUgu3ZUEzXBxf1he9oGlL2TZNYr+nJN4oaj9QOUSZDEmTcgUJmumDek808kMtJerEOWJk8j9cPxRscVpbxTkc4cZQ9hEVTmcFEWqXphmgisbB/djtS3nIdIQNqOLsPE9/87DQyn6FIWd3IvHOOZDl7qBKINFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlR79deu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729528641; x=1761064641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cp6oYYgOsrrCc+iShk2LoGhhdoylFkelstQyBdhSgZI=;
  b=mlR79deulDXtOqSUZQdxShlc5p+6bU8TCbUJHE6DhythjNNos3KXPhhe
   FRd8eQpGsMZRhFVQLlfZ8ta+LQpWirdV20rjnIpBmPFtoXLVEvRiAzvjb
   aeVkYJyNVlenXPUCaYzUx27UnafVeXk6d8cHroLZp+AK0vNgQysHZcAz5
   wWj+WeRQt6S/Up8dC9/EL4lZNjOoYYJBGI8raAE0XeYhEHzCkt7HnJgOI
   s+m/hnS3x64nHSA8BUdiamdYCRTJNmXsDFYnJFx4uXpWnblLHsMraT723
   4jnGz0Ei+cMV/YjYYNnyyTgmzSv0QllMF5VV85ccLULpzDRL1AzqUxcb/
   Q==;
X-CSE-ConnectionGUID: NUEWT9syTaqcQd5yvg3JHA==
X-CSE-MsgGUID: wMNM98QcTWimfjVqvEOKhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28900005"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28900005"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:37:20 -0700
X-CSE-ConnectionGUID: 8xlQShIjQsq3KoV5yIMmAQ==
X-CSE-MsgGUID: GB/DnTueSuO03UYI1IwLdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="110343285"
Received: from cphoward-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.124])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:37:12 -0700
Date: Mon, 21 Oct 2024 09:36:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20241021163656.zyyugk4vyqyhzh3i@desk>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>
 <20241018203053.2x6oyws3dkxfw6rm@desk>
 <9534B53F-7B91-4525-97DC-889EC3836658@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9534B53F-7B91-4525-97DC-889EC3836658@alien8.de>

On Mon, Oct 21, 2024 at 03:38:06PM +0200, Borislav Petkov wrote:
> On October 18, 2024 10:30:53 PM GMT+02:00, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> >I will drop "core", but can we keep "native"? "native" is used in SDM to
> >define this field. Also model_id could be confused with model number.
> >
> >  From Intel SDM Vol. 2A:
> >
> >  Bits 23-00: Native model ID of the core. The core-type and native model
> >  ID can be used to uniquely identify the microarchitecture of the core.
> >  This native model ID is not unique across core types, and not related to
> >  the model ID reported in CPUID leaf 01H, and does not identify the SOC.
> 
> I'm still not clear on what "native" is supposed to mean here?
>
> The core is born this way and then it changes... so this is its native
> model ID? Weird...

In a hybrid system the model number reported by CPUID could represent
multiple core-types. As model number is same for all cores, it is
insufficient to uniquely identify the microarchitecture of a core. I
believe "native model ID" bridges that gap as it is specific to a core.

> >Yes, topo.hw_cpu_type is initialized to TOPO_HW_CPU_TYPE_UNKNOWN. We should
> >not ideally need the vendor check at all. As long as topo.hw_cpu_type has
> >the core type, returning it should be enough here. For Intel hw_cpu_type
> >also has the native_model_id, that is why we need the vendor check.
> >
> >If AMD or other vendors have similar use case, it makes sense to add the
> >explicit vendor check. Please let me know if thats the likely case.
> 
> Yes, it either needs to be vendor-agnostic or you need to accommodate all
> vendors. Former sounds cleaner...

Ok, I will add an explicit vendor check for AMD as well.

