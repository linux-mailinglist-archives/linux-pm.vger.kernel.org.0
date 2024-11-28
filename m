Return-Path: <linux-pm+bounces-18214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5D9DBD47
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 22:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFB41649A1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257511C3033;
	Thu, 28 Nov 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbLAEJpG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00513DDB5;
	Thu, 28 Nov 2024 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828712; cv=none; b=X5/4jxYCsUck1BCdQk9GjTSpNDTJOiz9fAamO1V05pLhscHnkhxcCRDEeVQrn3gHMSPvtJTIfRyzLU7t1c5Mo6h0qG0ejw/+GqixUuaQrx3eQ1JmhD9TLGFolZ87QHgdVlLavHLPsJhrA27NmfqXQ6RoyPdNET0FJ9wqO7QIp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828712; c=relaxed/simple;
	bh=JR9HIv6Zf/V0Hie08szqxWG0je4RV0/U+w5I+NNf6Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOuSlUdOCk00tiYdR/zAeSlQqGqd9jAzOU76CqBpiaq4uqWixPA1H5AhXel2sJ3EhaL1HKwHSV+dQDPBFsXRELRY7fQsET4P2bY26Pj/MRU5UNziwkMo5DUU4+CTngSyzhKOggQNkHHnAkzld7bf5gsNlfZrnBXWms/5jfCbO7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbLAEJpG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732828709; x=1764364709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JR9HIv6Zf/V0Hie08szqxWG0je4RV0/U+w5I+NNf6Yk=;
  b=lbLAEJpGS/saMPHmtSLJ1yHjIOxTApMW1o/GRkrUFZhZM7RQmBDq5PoQ
   0FwQwU/CFdeIE/n3DzpdTnpWaP2NL0m79ReQUxovguIZyCqicptVhRYc6
   F6TjrCVBQGwK9D5t4rXBmC44x7uJAqiihQl42NteApbLGxbvhrzsTvwu6
   T1T+YGjxSHqdjqoE9WQzZVoFW6FhFpVdlzGEcrVLCPRd0DvAYSjvCNLdB
   ICdU2uQ6GVsD4aqKLeSfG3GZdQ3SIqUzkPBLnTDlMRooVrT7xLYxTY9sn
   0L+6/ultRsDTE0JLBh1yNNiK6ifTJ2w5auojV4x+vh5XfMlGiozZsWZea
   A==;
X-CSE-ConnectionGUID: KPM9uGOjT/KaExYAO7pMXw==
X-CSE-MsgGUID: ZwFw3yHcT7Sn5pTSt9PXgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="36999180"
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="36999180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 13:18:28 -0800
X-CSE-ConnectionGUID: 6CABNMLSR9inCOZZwNzSnQ==
X-CSE-MsgGUID: W2DK+mzwT125fBiIjGFPfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,193,1728975600"; 
   d="scan'208";a="129819821"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Nov 2024 13:18:25 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGlu3-000A3d-1M;
	Thu, 28 Nov 2024 21:18:23 +0000
Date: Fri, 29 Nov 2024 05:17:56 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, patryk.wlazlyn@linux.intel.com
Subject: Re: [PATCH v6 2/4] ACPI: processor_idle: Add FFH state handling
Message-ID: <202411290550.AphAcYyW-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Patryk-Wlazlyn/x86-smp-Allow-calling-mwait_play_dead-with-an-arbitrary-hint/20241128-113851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241127161518.432616-3-patryk.wlazlyn%40linux.intel.com
patch subject: [PATCH v6 2/4] ACPI: processor_idle: Add FFH state handling
config: x86_64-randconfig-074-20241128 (https://download.01.org/0day-ci/archive/20241129/202411290550.AphAcYyW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411290550.AphAcYyW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411290550.AphAcYyW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0xb9: mwait_play_dead_with_hint() is missing a __noreturn annotation

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

