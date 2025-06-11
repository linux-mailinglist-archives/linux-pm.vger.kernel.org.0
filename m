Return-Path: <linux-pm+bounces-28513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F0DAD622F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1979E189FF05
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 22:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E83248F4C;
	Wed, 11 Jun 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jtr7GlFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2A1E9B28;
	Wed, 11 Jun 2025 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679785; cv=none; b=qMGbCKnas845ey73ZV+9su3woR0w6tWci0/xJBw2s9hBlTY2LVGqrPWVImsT5iRoMjTBdqSNhdjBks9S8DRpyp5MAKjRaBC5J2HnnC1K8uspI5gHI5FGZiTD/TtvT3AtJXI4Lqq2BZper9HE1tjf70/mM1mHgZeGOxJcU7xesYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679785; c=relaxed/simple;
	bh=q3xX2X7h9he/dUJnCnbpHt/NgJ+2yrK0a9aojccAvFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDU/vDtyNzLi356GfKW043FBIFH5V0Q9bfmYJ3oYKCWfilUoTYIgalYWAQL9eRG//tfYgSmaK2pLQ+u2DXwhb8sbRQeM07K/VZ4Ktufezk1gG8YnCxSpjlA2hR4P+dAI8VD57rx0yAMwp6HMoN6tLNz7taDQFQe2ulc091jj9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jtr7GlFL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749679783; x=1781215783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q3xX2X7h9he/dUJnCnbpHt/NgJ+2yrK0a9aojccAvFc=;
  b=Jtr7GlFLaVxQibFvgXW0Bo2njFQh6sTO+0B9BunqFZl/K7Wkliu+4CW9
   wmxs06IROtMt8FVYDZ5e7auSqYti22OJHMueTFFQB3p1NdaJtKqkOUmdE
   yRVV/XbHQhpph4rbNYxof4amppIX2dUrorQMnWwqnN4HtbHHeHbrPVRW4
   O+T5aOz5X00DNRjIN9FjKbFr7n2YoRTFySqTPWavp4PL2iWtAfMNlUW/d
   E5Anz8tEXsTwiFZJPnQA/K/cvgGYhvgRW28S2lqoxDfE37v/k0LSYAfzV
   SLRd60AVQ+L7552W10TL85zm9SXxQ0F7zmttkVedUuo8e9offAjb1/kJ2
   g==;
X-CSE-ConnectionGUID: sJWnWLE9Rd2RmFt5Y8mwgw==
X-CSE-MsgGUID: f2AKRsOwTNymlFQWnHyUnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51707291"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51707291"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 15:09:41 -0700
X-CSE-ConnectionGUID: IpgnycrbQlKXGyi3trCu0w==
X-CSE-MsgGUID: W1gk8/exQIulUE0QautbAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="147220983"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Jun 2025 15:09:38 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPTdX-000AtS-2b;
	Wed, 11 Jun 2025 22:09:35 +0000
Date: Thu, 12 Jun 2025 06:09:05 +0800
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
Message-ID: <202506120535.f1iULf9O-lkp@intel.com>
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
config: riscv-kismet-CONFIG_PM_GENERIC_DOMAINS_OF-CONFIG_SIFIVE_DMC_PD_CPUIDLE-0-0 (https://download.01.org/0day-ci/archive/20250612/202506120535.f1iULf9O-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250612/202506120535.f1iULf9O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120535.f1iULf9O-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF when selected by SIFIVE_DMC_PD_CPUIDLE
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
     Depends on [n]: PM_GENERIC_DOMAINS [=n] && OF [=y]
     Selected by [y]:
     - SIFIVE_DMC_PD_CPUIDLE [=y] && CPU_IDLE [=y] && RISCV [=y] && ARCH_SIFIVE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

