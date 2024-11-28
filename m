Return-Path: <linux-pm+bounces-18210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED79DB902
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E930C162F19
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7D1A9B4D;
	Thu, 28 Nov 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+c4s3+l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1E1A9B35;
	Thu, 28 Nov 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801315; cv=none; b=gYrKWTELDlURsUFVdqW1NiNwo7Jb89X4PydCKvg7SIuqIJspWjvQbr+Q7BY/U5iozOFqKqoJ/xPEwNAmOoLeh0aop6Tjp7ZoUHTZP6q3XULJ36Q96WB0drzbPJKd454MBDEDVoTGwlEHVbSo81ufo8XN5Eraxdgu1s/dPoKERrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801315; c=relaxed/simple;
	bh=zO5nlBNC/AA3wucj6yTZrJnMjwDYYmT3yIbThV22NN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsvNOXvO6lVXK1k8pkKgTvCcxLWZGr26IZDD4Za0ZKBtKJ7tppyEgoIBJoGSwlVNBd/Fmx05pzH9t2I+8O1nU7sqf7zKPxzmWcJFFLe+d/PDjehOkks/4Rc3QRgQwmyMauc0XALdMbsz+OJtYJGV6xWdqr5hIzMOi+wKN/pmJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+c4s3+l; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732801313; x=1764337313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zO5nlBNC/AA3wucj6yTZrJnMjwDYYmT3yIbThV22NN8=;
  b=Q+c4s3+lhCzUf/DtQxeWFco+t/zf0Oplk7dNmsQHlgszWiz9xmTf7Ro0
   YrYgPjlP0L1y6kUJHr+M0joVXhfkOd73xsMIw+l5DYQ8uUBhm3H8DhVhQ
   6qa0CrZ9q0biwqBYKWmyxjomXyFN5DaHI99kIz6ikTf2D4/xDyyNMCqEI
   CXXhuo3P/xEiTgAMgXXWooj+xtlLx+UnLFh2oIkQ1hUyD644FC7fqolt6
   m3Kho/4Gie/uhvxLkHIunNzy6Qsl7qzYX5ERPZXJI676oZyD2/WEkamW+
   ME7ttAwLdUxJnQ86kuLzw4Un0SGLvHm4QykxMP4kpWaNKgqtaKjY9sGAp
   w==;
X-CSE-ConnectionGUID: +0qogKlBQYWnPjQ5XsACaA==
X-CSE-MsgGUID: zUzxPWEkQkKnp/anAocU4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32400913"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32400913"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:41:52 -0800
X-CSE-ConnectionGUID: x/4457j+RvqMTEWgnQN5Iw==
X-CSE-MsgGUID: VLGjCtqGR1ammSjXLb32Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97338148"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Nov 2024 05:41:49 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGemB-0009cr-0r;
	Thu, 28 Nov 2024 13:41:47 +0000
Date: Thu, 28 Nov 2024 21:41:40 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, patryk.wlazlyn@linux.intel.com
Subject: Re: [PATCH v6 2/4] ACPI: processor_idle: Add FFH state handling
Message-ID: <202411282102.WIsGlK4X-lkp@intel.com>
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
config: i386-buildonly-randconfig-001-20241128 (https://download.01.org/0day-ci/archive/20241128/202411282102.WIsGlK4X-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282102.WIsGlK4X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411282102.WIsGlK4X-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/acpi/cstate.c: In function 'acpi_processor_ffh_play_dead':
>> arch/x86/kernel/acpi/cstate.c:213:9: error: implicit declaration of function 'mwait_play_dead_with_hint'; did you mean 'mwait_idle_with_hints'? [-Werror=implicit-function-declaration]
     213 |         mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         mwait_idle_with_hints
   cc1: some warnings being treated as errors


vim +213 arch/x86/kernel/acpi/cstate.c

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

