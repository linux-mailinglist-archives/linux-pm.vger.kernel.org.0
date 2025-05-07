Return-Path: <linux-pm+bounces-26782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87453AADB51
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 11:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25FE9A4272
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195424C668;
	Wed,  7 May 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC38VwAx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A424A07C;
	Wed,  7 May 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609358; cv=none; b=YdxeWNDvNC06IYGAikK3lRkDGP8f8HhFDr/YY/OahCBVzrCs/s7E4De2F5Z578zs0s/A38iIx8kVBSum85dmHU2sy/Q0t9M3wisVO1lyXWBhCG78+Izt5iCJRc4Rz7p0vhnBmi0A4wlWYUyA//sJnX/6xoUAiF4QhsVUazmGgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609358; c=relaxed/simple;
	bh=bOOav56FZimzUhF24N2AXUX+5EB9KykWAEnTyUrSAiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdFCCw1uPvevfHHqwDLPo/u0y1jj2Zmk9cm7X9WZuy8L6FseBZEZQwBRQh0berybD3/cUMu/MlgL5PQghjOVZS9S493KtqUcWx8K9QxCmJMPiX3mTYoWcupSxSwYlC4HMGwz7zaW45BETETq0LWqXtJ6jt3Yz+ZYk5hPJk/ZgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC38VwAx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746609357; x=1778145357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOOav56FZimzUhF24N2AXUX+5EB9KykWAEnTyUrSAiQ=;
  b=eC38VwAxbTRbBNSTzjfPVL+IU709Kda8Zh1y8CYHFTYVCuMcCvZAtisJ
   AA2gX1zs4WnIaH0IfO2kC8WsxpNaMhKTtacWZZK46Vv++hQtB49ciFk7n
   zAT4OEzkziQsQXkKcZuqmsMaTWOyqkzB75BjJWBoR6D5IAdpEwMjyVF9P
   NXNyv4CqksNXPSKdZ5yO/ZASk5S/oAn1BAYHMTF5e0exChyK7f3X0wkxn
   0KLpRf6BcPWRpRyPdCYRFWuf5CQqzDUPgLkS1n1S2RqoNzkzhXfTgugnA
   5v4wczplPhQ13cNeRWVb6yIzFrwVHEeLtpus5ouvOXnhHF1pn20uBu0DC
   w==;
X-CSE-ConnectionGUID: Zqf7zyAAQLW+QEktQRh2/A==
X-CSE-MsgGUID: QscKwT8WRVa3dvmqWg1XKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47426892"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47426892"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 02:15:57 -0700
X-CSE-ConnectionGUID: iTH8TkjZQm2HDsMx/ybclw==
X-CSE-MsgGUID: sO8jQgj7R8+sMnKf1/+BBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140739232"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2025 02:15:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCasX-0007U1-0K;
	Wed, 07 May 2025 09:15:49 +0000
Date: Wed, 7 May 2025 17:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <202505071649.g96zqzTU-lkp@intel.com>
References: <20250422085717.2605520-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422085717.2605520-4-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on broonie-regulator/for-next chrome-platform/for-next chrome-platform/for-firmware-next linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250422-170711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250422085717.2605520-4-o.rempel%40pengutronix.de
patch subject: [PATCH v9 3/7] power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
config: hexagon-randconfig-r113-20250426 (https://download.01.org/0day-ci/archive/20250507/202505071649.g96zqzTU-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250507/202505071649.g96zqzTU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071649.g96zqzTU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/reset/pscrr.c:81:3: sparse: sparse: symbol 'g_pscrr' was not declared. Should it be static?

vim +/g_pscrr +81 drivers/power/reset/pscrr.c

    74	
    75	struct pscrr_core {
    76		struct mutex lock;
    77		struct pscrr_backend *backend;
    78		/* Kobject for sysfs */
    79		struct kobject *kobj;
    80		struct notifier_block reboot_nb;
  > 81	} g_pscrr = {
    82		.lock = __MUTEX_INITIALIZER(g_pscrr.lock),
    83	};
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

