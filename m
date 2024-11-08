Return-Path: <linux-pm+bounces-17233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B59C275C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 23:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A861F216C1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF51F26F7;
	Fri,  8 Nov 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ywgbcuzp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81C1AA1FD;
	Fri,  8 Nov 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104005; cv=none; b=I7cMkP1wM8HVtCkTF0L00XJAwYSbYim7atK1FCfQMTwzE5wUtUr8x6z4lNPV5/36fu6YoNTIJ1xIJSzPQXPvWNQNrLkSlQWSMwAHbUryYwVDv6mqFS2FCK7NYPFbHrimCPaLNm7/bYVh8abuGgHgL54JJJFEJ/h2jQQ/Bo7VfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104005; c=relaxed/simple;
	bh=g7alIN34O1EB60J+Qde0BhS8SjttSFElP0RMIcUQMfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/9pkKrHnntPsupQHqJ7KQm5OpTYEsEt9gUx9sp45H+bveR78VNw0jR88t8KmywEsdPbnp7XYFFr9vsA66/vtu61OGLGi++BqlxEtiCkwnbemMFc4fEbVJFhx8Ekbz3OrZ0cSnCwc9Vcicl0A/M+8tRXFvtEQnDA9WbpX4fsJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ywgbcuzp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731104004; x=1762640004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g7alIN34O1EB60J+Qde0BhS8SjttSFElP0RMIcUQMfo=;
  b=YwgbcuzphhR4GPJmz63htgWhoOVl1Mz9HLPSkRdwmJSdzeSo7nhcnErG
   2ZUUIbxqycCwPaoFP3BJYFyICpciNfMQ9Qng5srZdAWhDbUJKoCDJ+WYa
   GeUFP2LRsCiBxIaIUyJPDK35jrUua8AppyUKUO9EXQLSwU8NbZ6TLV0qi
   yTXurNQxKsC/2P5xAFHEsMDM5k1i59JH1lrn5zwjiqlWm/OlPPUIcqln6
   UEP11oUjbYDtkU5qAMQ4m7Hbsx4foTR+mY8H9U0dD+LcfogKG7yg5enlG
   dCG0F5nDLb9IlwSEUO+8LSB9zkBbF/GJ1qOpfkXO5JKuck1gufhkYGYaQ
   g==;
X-CSE-ConnectionGUID: rYkuAmp1Thu1114VsQ2clg==
X-CSE-MsgGUID: UVoQlzxFRr2JtDUBdaJ7Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30858892"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30858892"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 14:13:23 -0800
X-CSE-ConnectionGUID: tVXXtb8TSp6pvCm7Uhdchg==
X-CSE-MsgGUID: lej9TPAxS22XbyNCUzUJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="85376965"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Nov 2024 14:13:20 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9XEE-000rpu-2J;
	Fri, 08 Nov 2024 22:13:18 +0000
Date: Sat, 9 Nov 2024 06:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com, patryk.wlazlyn@linux.intel.com
Subject: Re: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
Message-ID: <202411090651.FNnbtLe2-lkp@intel.com>
References: <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>

Hi Patryk,

kernel test robot noticed the following build warnings:

[auto build test WARNING on acpi/next]
[also build test WARNING on tip/master tip/x86/core linus/master v6.12-rc6 next-20241108]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Patryk-Wlazlyn/x86-smp-Allow-calling-mwait_play_dead-with-arbitrary-hint/20241108-203137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next
patch link:    https://lore.kernel.org/r/20241108122909.763663-4-patryk.wlazlyn%40linux.intel.com
patch subject: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
config: x86_64-randconfig-161-20241109 (https://download.01.org/0day-ci/archive/20241109/202411090651.FNnbtLe2-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090651.FNnbtLe2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090651.FNnbtLe2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: intel_idle_enter_dead+0x9: call to cpuidle_get_cpu_driver() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

