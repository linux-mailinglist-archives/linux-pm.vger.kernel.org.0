Return-Path: <linux-pm+bounces-28213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB8AD0A36
	for <lists+linux-pm@lfdr.de>; Sat,  7 Jun 2025 01:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290247A16DD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B19923D2AC;
	Fri,  6 Jun 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNiFaxTS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6A126C17;
	Fri,  6 Jun 2025 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252224; cv=none; b=c6rbyqTQo48+lY2F5HScMnHghuBVtWF998nSjCgazHWjekXgokHii9do3vQrm4FuOq3T1vg0USRC2rH8gckU3GWo7qz5S96gc6d/QWdNx2lfdx0Eq2yJ55TzuYUrNzO9x2uzfWHsU2oVRdOISH2+uwl2s2LjCCaI3u/hOCDIAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252224; c=relaxed/simple;
	bh=nk0adjKeA8nMvS/JXyOJRsJFhrbYKZB2dialpfkhKwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDt6+TMYFc+W8Ac3omdJpjwL6nMCL0BLBNjPD1w3MCgUMA708CzLAtl3/2Lxrt5vdZ/gwBkR+I4pLV1Bf9lueGhtr1EP8vSPXvlO+7qTor+sugQ143JwiqdpLw8hR1J3uyHVQotQ/6Nc5LFEJVN7Sw9Pm6mmHHv16F/ubEjld/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNiFaxTS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749252222; x=1780788222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nk0adjKeA8nMvS/JXyOJRsJFhrbYKZB2dialpfkhKwg=;
  b=kNiFaxTStnfLTYAK74XsPw1UuJxUThXB3gWxPNIeZpZqhS4yz1AXOv78
   o1az6wQDN1QeKmB27eRutzqteC+TIjyrE1mzM3sK/xbqXjnGq6g4urpR0
   4D8LVng8Bl6BPSxyJlWZJrcOiXssRcr0D6+Zgsl/gxtTG8RN2oNXVG6xt
   bs7vj4cFnJVls11JbxxHLQHPboZc6RsWYT1mglSLsuhSdQRqgvuT2C/e0
   fq3c98pkvkShoy97HYNU3AQRa+9PBkdfVFE+itk61JOwFyh/MXBzqIIj0
   bg6rjlpEvBgaZQCGCneI+MlDHIfSS/tVUbH29d9cTi3nXMOzdyx4XgnmO
   Q==;
X-CSE-ConnectionGUID: XN57pPFnSBGJvLcoXMwsRA==
X-CSE-MsgGUID: cPj8855RSPGPXpNQEGBfvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="62809855"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="62809855"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 16:23:41 -0700
X-CSE-ConnectionGUID: 6vARsndVQ9OefKbRucXDKQ==
X-CSE-MsgGUID: VYhtg7hyTXqW0/RCPetyWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="145878058"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 16:23:37 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNgPO-0005Kt-2q;
	Fri, 06 Jun 2025 23:23:34 +0000
Date: Sat, 7 Jun 2025 07:23:21 +0800
From: kernel test robot <lkp@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
Message-ID: <202506070707.giDP6xhc-lkp@intel.com>
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>

Hi Viresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master next-20250606]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viresh-Kumar/rust-cpumask-Validate-CPU-number-in-set-and-clear/20250606-121822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar%40linaro.org
patch subject: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
config: um-randconfig-001-20250607 (https://download.01.org/0day-ci/archive/20250607/202506070707.giDP6xhc-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506070707.giDP6xhc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506070707.giDP6xhc-lkp@intel.com/

All errors (new ones prefixed by >>):

   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 21.0.0
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
>> error[E0425]: cannot find value `nr_cpu_ids` in crate `bindings`
   --> rust/kernel/cpumask.rs:96:38
   |
   96 |         if unsafe { cpu >= bindings::nr_cpu_ids } {
   |                                      ^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find value `nr_cpu_ids` in crate `bindings`
   --> rust/kernel/cpumask.rs:113:45
   |
   113 |         if unsafe { cpu as u32 >= bindings::nr_cpu_ids } {
   |                                             ^^^^^^^^^^ not found in `bindings`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

