Return-Path: <linux-pm+bounces-19960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D5A017CB
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 03:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F8E3A3649
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 02:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D3D374EA;
	Sun,  5 Jan 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQYt8rkG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD0481B6;
	Sun,  5 Jan 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736042513; cv=none; b=cdi/XacxA7Z3dNGk4HenW2fCp8bbt0NbxxdIQjxMJVdwkTpXbC+woElCs2t3oV8cQyWGoIyhP2wW4O/9DXLb2yItLwtCcvGpU07sR0wOMeC22oceOYdoS5PC7JCszoOcHrvLmcTzWzKNnEB79TjjuOyu7K09B6eFPKMrvb7BE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736042513; c=relaxed/simple;
	bh=LXcv4FdNNG3Tf6TIBN0iAcj8De3t94GyOe4c1VqhcLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTgMMN4p+f/2R3GLQ2tlF/JlT5H1rEFNdZfYcqwlExUQ8HqbElAZ4uuI8b+7fv/GQ0BsnMGoJY5MhW2A4mpXnLyLD7WogS+ycX9izHqFMrzWXdFmspBWbWp/q5cm7WjlJ0HTol5lzwUOI08PHeFk2lbPwykcPScdct6+t3Sw4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQYt8rkG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736042512; x=1767578512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LXcv4FdNNG3Tf6TIBN0iAcj8De3t94GyOe4c1VqhcLM=;
  b=AQYt8rkGDzeHSLD0lT4EZpKxL8uaokEXC1rB9HzIY9ROlAOqNUVWNG5j
   GI7SetjLWE/Skcq558uc74/5GQrtyJJxHxo8UMO8iyj/l1UV4taAqr4jd
   oQOxJOSHFBdpsvMKbxKIXKy9aFmJQXYBpKRSl6FYeR4QKahtRdQZFzPmL
   q6pvqIAMPJ09IbmaTVLJQWKjMh2ajllTk5i87OoBgs91I/SwLDUyPAuZY
   9Cirmc3o85cRuHvd3RfMX4Yh5qFrSKfMkJAVoWxkKFyCa28lIzB3uv/Fn
   q9CfWnSMj0pN/jMGkucrY5ZNIsEyNRGfXbn7Xp7HNxGHYdOy+j9JsGp7m
   g==;
X-CSE-ConnectionGUID: yFBy5KVlSIyh35h9SaJn4w==
X-CSE-MsgGUID: axwkHzJ/SiWUfLtMy46Zuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11305"; a="61605947"
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="61605947"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 18:01:51 -0800
X-CSE-ConnectionGUID: qLFuF0vNQA2LiuIb2jLmTA==
X-CSE-MsgGUID: RPZ5+PsPT0yYnydOcdVMkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="102627239"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jan 2025 18:01:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUFxa-000BO3-1e;
	Sun, 05 Jan 2025 02:01:46 +0000
Date: Sun, 5 Jan 2025 10:01:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Message-ID: <202501050957.aylo1fso-lkp@intel.com>
References: <20250104181305.28185-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104181305.28185-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-CPUFreq-SMCCC-driver/20250105-022153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250104181305.28185-1-ansuelsmth%40gmail.com
patch subject: [PATCH v8 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
config: arm-randconfig-004-20250105 (https://download.01.org/0day-ci/archive/20250105/202501050957.aylo1fso-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250105/202501050957.aylo1fso-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501050957.aylo1fso-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:135:10: error: 'struct platform_driver' has no member named 'remove_new'; did you mean 'remove'?
     135 |         .remove_new = airoha_cpu_pmdomain_remove,
         |          ^~~~~~~~~~
         |          remove


vim +135 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c

   132	
   133	static struct platform_driver airoha_cpu_pmdomain_driver = {
   134		.probe = airoha_cpu_pmdomain_probe,
 > 135		.remove_new = airoha_cpu_pmdomain_remove,
   136		.driver = {
   137			.name = "airoha-cpu-pmdomain",
   138			.of_match_table = airoha_cpu_pmdomain_of_match,
   139		},
   140	};
   141	module_platform_driver(airoha_cpu_pmdomain_driver);
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

