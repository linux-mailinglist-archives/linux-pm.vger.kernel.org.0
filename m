Return-Path: <linux-pm+bounces-28516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17030AD63B8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 01:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4FA2C02AA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF82701D1;
	Wed, 11 Jun 2025 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aq7OfoyP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD0266588;
	Wed, 11 Jun 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683509; cv=none; b=DR/0ByRbuFTzPH//DUVX/xgAZQ7dGkIaAf2Oa/T0a2Va2oNeNWz85DqVyrbPJ/nK4qjIcuxovqVz67ueCJ6lSxgSEvMCq4dm4uOJMZzozNptYZyx0NAIDne06TVK6WCPxOvPBDtKuo3bO5A6n2AcVoB4gkQXNuMRBHD6pXdWCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683509; c=relaxed/simple;
	bh=Xi7Bn8Dl4dzWWpiOeR/DTKrcXEYcYeIJC7prsjMVDnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urEoh0Swp+f5uZ5zhV+HZyH8EZi4elhkL65ThF8R57G1JOclD0WEo+tzOB6cmLb30JjsNidQ/hFirNrhO3M7lEE9jXtoFwNBnE8qsS4dAm8GMNL2SGNarGbuXPi84RzjrH/DyjemQIOIEA6kHqwVwygaS6Rqz1oBNL9T8ajuFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aq7OfoyP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749683508; x=1781219508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xi7Bn8Dl4dzWWpiOeR/DTKrcXEYcYeIJC7prsjMVDnk=;
  b=aq7OfoyPryAYOwh+xcGnofJuEsfLy5kTNBOxfAHnjiT2+aEvmdNNlHI8
   sDvzNHmSATEL+X/SCSA42rBHnK8wyJdEDi2x2VRlQ9WKkjT2d8eKljTRc
   c5WD4GzK4KeF7g+YPXEccqfd9rKUV8G5gC+2AaSnAroWL0CpxrL5i/o7Z
   L68KjXAokt2h0GXy8xbgLsIGJ6pghoQqA1mzMysuDQOG37pKHPjDEpDMz
   dKOhkIiV8tBrlbosp1WprIJscishmuYZ3x4vbC4dqzSm+BbWFaXsy69KK
   PaiCjibWk9gnEknddr+cNh+kUat/GmZR7RraKCT1bhd9ss2RbLvDRR/41
   w==;
X-CSE-ConnectionGUID: KsIHq3oqTrG5M2SFIS061w==
X-CSE-MsgGUID: g3x1LF1QTAO3L2BUDojOJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51063181"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51063181"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 16:11:47 -0700
X-CSE-ConnectionGUID: WCKpKM7NRfePmN8CCfTQuw==
X-CSE-MsgGUID: jVTruJE9RbKw+bqDvkvdzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="178245955"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Jun 2025 16:11:43 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPUbc-000Av4-1y;
	Wed, 11 Jun 2025 23:11:40 +0000
Date: Thu, 12 Jun 2025 07:11:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Hu <nick.hu@sifive.com>, conor+dt@kernel.org, krzk+dt@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Nick Hu <nick.hu@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 3/3] cpuidle: Add SiFive power provider
Message-ID: <202506120735.Ek7I6Nze-lkp@intel.com>
References: <20250611031023.28769-4-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611031023.28769-4-nick.hu@sifive.com>

Hi Nick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge robh/for-next linus/master v6.16-rc1 next-20250611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Hu/cpuidle-riscv-sbi-Work-with-the-external-pmdomain-driver/20250611-121115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250611031023.28769-4-nick.hu%40sifive.com
patch subject: [PATCH v2 3/3] cpuidle: Add SiFive power provider
config: riscv-kismet-CONFIG_RISCV_SBI_CPUIDLE-CONFIG_SIFIVE_DMC_PD_CPUIDLE-0-0 (https://download.01.org/0day-ci/archive/20250612/202506120735.Ek7I6Nze-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250612/202506120735.Ek7I6Nze-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120735.Ek7I6Nze-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE when selected by SIFIVE_DMC_PD_CPUIDLE
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
     Depends on [n]: PM_GENERIC_DOMAINS [=n] && OF [=y]
     Selected by [y]:
     - SIFIVE_DMC_PD_CPUIDLE [=y] && CPU_IDLE [=y] && RISCV [=y] && ARCH_SIFIVE [=y]
   
   WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
     Depends on [n]: CPU_IDLE [=y] && RISCV [=y] && RISCV_SBI [=n]
     Selected by [y]:
     - SIFIVE_DMC_PD_CPUIDLE [=y] && CPU_IDLE [=y] && RISCV [=y] && ARCH_SIFIVE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

