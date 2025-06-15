Return-Path: <linux-pm+bounces-28723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B4ADA212
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2265E16DD72
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32450155326;
	Sun, 15 Jun 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GG1aF//A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271FD1E89C;
	Sun, 15 Jun 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749997692; cv=none; b=lDgIVLh664+H9iSkBzBsdAsYN93U2WBFxbSDhixiay+6cvxD8nKhf6i5KIcfY2XBNeypy6+VHZqajS3CzuEXiHl4QzraJjhnxb5Z1UQUdKXpLfT8ENGVk03UwmYJrEECMrJk9LPht8bTMInviFAMdSkfvnjqqJJn/t/JNuUdHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749997692; c=relaxed/simple;
	bh=d+bEPGbZ32eRHBPWuFiJZbVDZF3W4zfier/8Do1YGOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbsO5sgxAsn+2OgmYzCqQ9CUKIm8B1oMnYFq8Bc4EbFed64fTynSTG2ZzXT76VImzBs8MNfFx4QzJsC3YemS4Xs6TJVjrtr/K1/DhIDVQPGfn2jW/JYDgdg1eLFo4SMzhM7+qu92kEoM6P1TRcwGIapdCxUktQJu8c1kqcUlDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GG1aF//A; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749997690; x=1781533690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d+bEPGbZ32eRHBPWuFiJZbVDZF3W4zfier/8Do1YGOY=;
  b=GG1aF//AC3rNwzu1negs4HhaOAvx78m/hk5fBQRinOwBdpliWymm5XL1
   P+y3Ty9D0H6V5gG9LEhe9ARBS/5oOoIKVTNzBR7VShqJUuNP2m9uebkws
   MEIyaHvMVvEz/LE4w4q5FzLqfJ8ueaXXxweeJm+bIp4gL7ip1qscZ1jg5
   pNRKF5uGXD8hE9KI2loBztaeBA7WgnOxdDRilSMCGRK0OR2jI31Ofj9Qa
   ESIaLjjdmF7SVCLg7kSd0anDR2IzwTO4t4WDpvd1C9SiZ3NVfMxxJQe+B
   Ka2dSDy0FXwmHx3ep465p6i2qxBnW+MQegTwwF3W/d9mpGRHM7e2mX/4w
   g==;
X-CSE-ConnectionGUID: AcFlUfmOSWysnKmSY8C7uQ==
X-CSE-MsgGUID: GnKJ7zyPRZ2IOVud9bufOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52287161"
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="52287161"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 07:28:10 -0700
X-CSE-ConnectionGUID: +Bx5D87HRlaAf4Hdy+Sc4w==
X-CSE-MsgGUID: 37ZCB5gwTWeQI0uyayMB9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="148631282"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jun 2025 07:28:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQoL7-000EMm-1l;
	Sun, 15 Jun 2025 14:28:05 +0000
Date: Sun, 15 Jun 2025 22:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Prashant Malani <pmalani@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Prashant Malani <pmalani@google.com>
Subject: Re: [PATCH] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <202506152245.BJAubGbp-lkp@intel.com>
References: <20250614003601.1600784-1-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614003601.1600784-1-pmalani@google.com>

Hi Prashant,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.16-rc1 next-20250613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prashant-Malani/cpufreq-CPPC-Dont-read-counters-for-idle-CPUs/20250614-083659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250614003601.1600784-1-pmalani%40google.com
patch subject: [PATCH] cpufreq: CPPC: Dont read counters for idle CPUs
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20250615/202506152245.BJAubGbp-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250615/202506152245.BJAubGbp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506152245.BJAubGbp-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "idle_cpu" [drivers/cpufreq/cppc_cpufreq.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

