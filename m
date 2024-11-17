Return-Path: <linux-pm+bounces-17682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77ED9D0419
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4EC283CD5
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912AB1714DF;
	Sun, 17 Nov 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIw/hJFZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F51803A;
	Sun, 17 Nov 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850484; cv=none; b=L0NI6HXMt3KUwLTrq9DiptM4XnuCwI9Sr0GqsjAjVgLIcJ193D0IufP7CyLqvCUyXo3VsAwh9w36Emcd3KVbY+meuJZbX/7Oeei4tVSHAo6K6ralZ2R7a7arxidZM9EPfcDlvYs6tzwDkiTal1QxerYYLK/IEKxKjQwCU8RDvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850484; c=relaxed/simple;
	bh=B187G/gUaksl/fOU+jVWa2TR01jUHxL+V+NIxnNek3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQZS5GPaxmEEMCk9Q1WtJHWBbnLjYN9YGou7W3QqqkfJ/VUveWT/bl2E+AWXmYJzodzrQfYUjn+rMVbV+lMfMwk+9gqWPXU3f4wRRVZSnEgRPQdcd0U4ek2Yw2kcV9NSOrzQW7F6l9NJqbeLz4mP5G/7hTtfj2j/ztQ6XrHzMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIw/hJFZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731850482; x=1763386482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B187G/gUaksl/fOU+jVWa2TR01jUHxL+V+NIxnNek3s=;
  b=oIw/hJFZZcHSpN82A2O+NP4nWGYIlwLWI/3U13+ARkDGbtALN1lja3kT
   YtbobYTQKiotE9bIwPAJnnoihqrWbMqkxaToYIAA9TruMuWlJ20rttr7h
   cJW7Ut53BwXT0m9dAd+yvyhl9FBJIagiF0B28CHhrbgxuB0JKVL0zjQ2s
   unfYRStl3fuU8glAL3y/4j4Ynwp4O4+9qvxyT5feXaAnnO25esd6r86+l
   2pxm8hW3BHlLxwXs+G2yhoykLwONTtdIAcLaOem/F0T/Hfwu8ROlh829w
   oMqxx9W5NJ0c16dYYN+gmCWY98KgWVB1LMSQ9pF29jusY/OLZWd+QFyDC
   A==;
X-CSE-ConnectionGUID: O5qPOUJxTmi88OrjDlKZKA==
X-CSE-MsgGUID: CyaFUraMTQKnSDDHPThU5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31904892"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31904892"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 05:34:41 -0800
X-CSE-ConnectionGUID: gMfRsQC1RHerc2kLqKrJSg==
X-CSE-MsgGUID: KFqujJ72QvqC2dpOS9fN2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="93447773"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Nov 2024 05:34:36 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCfQA-0001m5-1n;
	Sun, 17 Nov 2024 13:34:34 +0000
Date: Sun, 17 Nov 2024 21:34:06 +0800
From: kernel test robot <lkp@intel.com>
To: Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <202411172344.QqFap290-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge tip/sched/core amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saravana-Kannan/PM-sleep-Fix-runtime-PM-issue-in-dpm_resume/20241115-183855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114220921.2529905-6-saravanak%40google.com
patch subject: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during dpm_resume*() phases
config: arm-randconfig-003-20241117 (https://download.01.org/0day-ci/archive/20241117/202411172344.QqFap290-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411172344.QqFap290-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411172344.QqFap290-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:88:
>> kernel/sched/topology.c:287:6: warning: no previous prototype for 'sched_set_energy_aware' [-Wmissing-prototypes]
     287 | void sched_set_energy_aware(unsigned int enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +/sched_set_energy_aware +287 kernel/sched/topology.c

   286	
 > 287	void sched_set_energy_aware(unsigned int enable)
   288	{
   289		int state;
   290	
   291		if (!sched_is_eas_possible(cpu_active_mask))
   292			return;
   293	
   294		sysctl_sched_energy_aware = enable;
   295		state = static_branch_unlikely(&sched_energy_present);
   296		if (state != sysctl_sched_energy_aware)
   297			rebuild_sched_domains_energy();
   298	}
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

