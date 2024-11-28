Return-Path: <linux-pm+bounces-18209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269029DB8C4
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FB2B230C3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF51A9B49;
	Thu, 28 Nov 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HncoIo+M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421B1A29A;
	Thu, 28 Nov 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800710; cv=none; b=HXTXt4w2SIAYG22FPco/tRFqmiKwSafhb3zldQZ+mVwwgOezuX6Wg1x7K5hS2anq8LoN7I4EtU0hGQr1+cwoWLF9bLHnVICE8p1vkDeFMx8KF7a676ozLSIKyd2ln/95BRmVgkAL43IfrCgLvDj29hEfvp9vuT5i0F1/3ixn0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800710; c=relaxed/simple;
	bh=LDLma4KPHs4whzkaYX0ncnAsr1tRfMFptcqIq79SpVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npBAd9EXiIDiUpS4q1q4PsvXF5zmOI4nC53PY0iwobWA9MP/GaioXg4tZaIABEAHpEO738tCjp0KnOr0uPyqQrlMbnH5vs7oxNRSEF3xvvZvsa/ogoxWm6rU0hGSxQhr9hrqb6qIqKUbNfMY1zj4tPf+JtNgLuf4y8jDmqRGVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HncoIo+M; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732800708; x=1764336708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LDLma4KPHs4whzkaYX0ncnAsr1tRfMFptcqIq79SpVQ=;
  b=HncoIo+MqqagPzjMmHZ8197TQVUw1Z0mE8jQVUs9atKuTPM+MSvh7uPM
   D8SB92ZIxZHwimhP9NXcIVj1GKuyFqj1+3bsxEjFtnIXr5ssd6tvLpRww
   efylx8J29IiBTmcsEnUg0zNDdqMtvHT9L46pp4hZp0qYX/404DUzvizjX
   RXHLjXo/ugkewJWoVUxRDy2sshyiWj/LdrvJj+l9lG4m/nBboF5/FdJRS
   6dzmVylfMa606bhh1N6hiA5+sjKVWYhGr/3b1pDCFRv1Jo4xBgOSqH8kE
   7D5Nh5lmgMAiAAiMFJczeZYTrxhORGXSjjYx6bPPDtk8H8ckYkZxigsWF
   A==;
X-CSE-ConnectionGUID: ECGtkxymSmq5VNIOyZ7jtg==
X-CSE-MsgGUID: fBU3luveR0GkS21xYob9CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33089510"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33089510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:31:48 -0800
X-CSE-ConnectionGUID: yf60ommbRDC3GgfPWJN/3g==
X-CSE-MsgGUID: 46w3cIxySsSzsU29tQ1LiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="91860875"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Nov 2024 05:31:45 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGecQ-0009c3-2Q;
	Thu, 28 Nov 2024 13:31:42 +0000
Date: Thu, 28 Nov 2024 21:31:19 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, gautham.shenoy@amd.com,
	tglx@linutronix.de, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, patryk.wlazlyn@linux.intel.com
Subject: Re: [PATCH v6 2/4] ACPI: processor_idle: Add FFH state handling
Message-ID: <202411282127.KFanck22-lkp@intel.com>
References: <20241127161518.432616-3-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127161518.432616-3-patryk.wlazlyn@linux.intel.com>

Hi Patryk,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge acpi/next tip/x86/core linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Patryk-Wlazlyn/x86-smp-Allow-calling-mwait_play_dead-with-an-arbitrary-hint/20241128-113851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241127161518.432616-3-patryk.wlazlyn%40linux.intel.com
patch subject: [PATCH v6 2/4] ACPI: processor_idle: Add FFH state handling
config: i386-buildonly-randconfig-002-20241128 (https://download.01.org/0day-ci/archive/20241128/202411282127.KFanck22-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282127.KFanck22-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411282127.KFanck22-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/acpi/cstate.c:213:2: error: call to undeclared function 'mwait_play_dead_with_hint'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     213 |         mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
         |         ^
   1 error generated.


vim +/mwait_play_dead_with_hint +213 arch/x86/kernel/acpi/cstate.c

   206	
   207	void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
   208	{
   209		unsigned int cpu = smp_processor_id();
   210		struct cstate_entry *percpu_entry;
   211	
   212		percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
 > 213		mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

