Return-Path: <linux-pm+bounces-17677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED439D01CE
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 02:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CAAB2319E
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F3137E;
	Sun, 17 Nov 2024 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUhbWL9X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE428F5;
	Sun, 17 Nov 2024 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731806316; cv=none; b=uoiT9OO1T7ryEqA9w9+uoCLDsWCjnq8hpo9FD5LGMoMsBKcXJMh4Ec6SGi8MWDHSU5TuIYofMZoM5RmuOBiMCm8XlAcYy85kiYigocktxXjBU3SHWLrVBI2/MIkokP8I1d4eMkTax/Fuqw+Kl9dptugpROK8QqbSWhv3nDLUbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731806316; c=relaxed/simple;
	bh=fmZz4Ox1V6/YI4z4z086vR4yIgUKFKXGPYU2I4JDp+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+huH+xX6pYoObnqrS0bciPT3UPwf2klNYibJMVFQlpO3WVmqcokIet74H/h2t9ZeHJl+P6iF91Rq3rsyJ89l7auGNhT7OnDdG8yz3msIBKuqmk6/7KJuq4hiQuEO7FREfEEmKUv9u3FF8Wpb2EsQuzVc2uf3eVZGfju50E1J4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUhbWL9X; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731806312; x=1763342312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmZz4Ox1V6/YI4z4z086vR4yIgUKFKXGPYU2I4JDp+s=;
  b=VUhbWL9XFxvT5xc3nCH4Z19h1AhbCPa2OdJfDtOU4S5JEYXOpi8BZz09
   Z9idLS9B8LaliptnPEG9SeWhH+9NNcP6VMVyM0srPSulrbVQFpnHcPCPd
   +whTYMkNGh7asZv1vXhmykkVs6/YIGz8UZo+/Oqh8IUx1Zi7CVp7+fhaC
   bSx7DbW3+jG4+jMKI/dNvsQUXXNaoLVZ8/lo41adG2yGvWg35FG5c0yXi
   FEEetrE2yN2vDFU8wnmC88It3UJTODJ5qAOgEIG4tV9t3GzUeUgB3Xwpa
   ijl9L+nqYGVHvYuk98T8GMsV1recwzFkNHB1uJORb76HfdSEMNIIWUXUT
   A==;
X-CSE-ConnectionGUID: qltRXSGATJi3o5aukL8hFg==
X-CSE-MsgGUID: NsMxxXMLQpKR4ObBwopeQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31629574"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="31629574"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 17:18:32 -0800
X-CSE-ConnectionGUID: lmtxy1W6T+OeQksERZgQkg==
X-CSE-MsgGUID: /paFkVRuS/G8hLFGlfXWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="93353318"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Nov 2024 17:18:27 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCTvl-0001Cr-0j;
	Sun, 17 Nov 2024 01:18:25 +0000
Date: Sun, 17 Nov 2024 09:17:57 +0800
From: kernel test robot <lkp@intel.com>
To: Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marex@denx.de>, Bird@google.com,
	Tim <Tim.Bird@sony.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads
 during dpm_resume*() phases
Message-ID: <202411170920.Pv29JceD-lkp@intel.com>
References: <20241114220921.2529905-6-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114220921.2529905-6-saravanak@google.com>

Hi Saravana,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge tip/sched/core amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saravana-Kannan/PM-sleep-Fix-runtime-PM-issue-in-dpm_resume/20241115-183855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114220921.2529905-6-saravanak%40google.com
patch subject: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during dpm_resume*() phases
config: powerpc-tqm8560_defconfig (https://download.01.org/0day-ci/archive/20241117/202411170920.Pv29JceD-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170920.Pv29JceD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170920.Pv29JceD-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: kernel/power/suspend.o: in function `suspend_enter':
   suspend.c:(.text+0x414): undefined reference to `sched_set_energy_aware'
>> powerpc-linux-ld: suspend.c:(.text+0x63c): undefined reference to `sched_set_energy_aware'
   powerpc-linux-ld: kernel/power/suspend.o: in function `suspend_devices_and_enter':
   suspend.c:(.text+0x834): undefined reference to `sched_set_energy_aware'
   powerpc-linux-ld: suspend.c:(.text+0x950): undefined reference to `sched_set_energy_aware'
   powerpc-linux-ld: suspend.c:(.text+0x970): undefined reference to `sched_set_energy_aware'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

