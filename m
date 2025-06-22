Return-Path: <linux-pm+bounces-29225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33808AE3008
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F013B13AE
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36301E0DDC;
	Sun, 22 Jun 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emD1FToN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0414EED7;
	Sun, 22 Jun 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750597249; cv=none; b=WIJ3zpOmpLjtt2gbe5SCeEZXVSabt94/KiuDvF1VPLX+0f51YzmaTZJvTlVt/y2TXnH4ikMUdhZFwl92HER6G6B4TLkA+tSS2ZJmSX/Fj1sK9YRwsslp+TkFwHU+rRq+KmlZc0hCWZI2eeFKY4+DgtSUocmxzlN8lI/AeJJMwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750597249; c=relaxed/simple;
	bh=zNPOMtqGCx67vztEqPzV5AkEy4ztrcs70oBFsyO1dzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emQweOhssfK2V82UuH/mDXKliUKi6BYrFiXz/7QlR3rLSRTf3ZOzHI8X85oESuPXFWrmQKYBvVksGhJ2D/n5fEE2WNittzEQ6AAuskq3m1uyOh5nYR4whokPjLqoeoY/qKouO7pC10y3rnA1vYJKX9/4YAkr9oFOM8rge0kwa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emD1FToN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750597248; x=1782133248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNPOMtqGCx67vztEqPzV5AkEy4ztrcs70oBFsyO1dzc=;
  b=emD1FToNOAtRd0i0WZ8dRZHHZ6R/RjPF2f/Tohfq3VorykadcCRntN3l
   9+tn2LY3cmcXHU1CPFdczn/3ho8Se12obpm8d2vMukldpQTVsHq0KOdaz
   b9Kw35VK7LtLM0IqxylZibH0BpUL3vLwl2JoxkiOFygieJjqL2v6uKFoX
   rSsGxpNEi1Hv5/v/Shcr55oMeVWNQ5/W1+Pbg9uHcrGjSV5uMqoJJltn+
   xcZH+eZ2NexqUeA5lKcJVlyVORECP+Hzv4vTSDf46KujJjm32Y4IB9wh6
   obQJy/8/wqwjvojs79jIgE+lnn26JycnFgoD53P/OwROvVQ1NfL1Wzktx
   A==;
X-CSE-ConnectionGUID: 79gm+NCnQ2G3Qt3urrOt1g==
X-CSE-MsgGUID: ou0MAh/LSu6L/0jDkMWsfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52953263"
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="52953263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 06:00:47 -0700
X-CSE-ConnectionGUID: oMyt4YPqRLeA3T1qvwZGfg==
X-CSE-MsgGUID: qEZK4XatTrS/qFyA3rmx9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="182374667"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Jun 2025 06:00:44 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTKJN-000NHW-2y;
	Sun, 22 Jun 2025 13:00:41 +0000
Date: Sun, 22 Jun 2025 20:59:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 3/5] power: supply: bq257xx: Add support for BQ257XX
 charger manager
Message-ID: <202506222057.1Q77TY6Y-lkp@intel.com>
References: <20250621180119.163423-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621180119.163423-4-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-mfd/for-mfd-fixes broonie-regulator/for-next sre-power-supply/for-next linus/master v6.16-rc2 next-20250620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-mfd-ti-bq25703a-Add-TI-BQ25703A-Charger/20250622-020443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20250621180119.163423-4-macroalpha82%40gmail.com
patch subject: [PATCH V2 3/5] power: supply: bq257xx: Add support for BQ257XX charger manager
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250622/202506222057.1Q77TY6Y-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250622/202506222057.1Q77TY6Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506222057.1Q77TY6Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/power/supply/bq257xx_charger.c:72 struct member 'chip' not described in 'bq257xx_chg'
>> Warning: drivers/power/supply/bq257xx_charger.c:72 struct member 'bq' not described in 'bq257xx_chg'
>> Warning: drivers/power/supply/bq257xx_charger.c:72 Excess struct member 'bq257xx_chip_info' description in 'bq257xx_chg'
>> Warning: drivers/power/supply/bq257xx_charger.c:72 Excess struct member 'bq257xx_device' description in 'bq257xx_chg'
>> Warning: drivers/power/supply/bq257xx_charger.c:139 function parameter 'vsys' not described in 'bq25703_set_min_vsys'
>> Warning: drivers/power/supply/bq257xx_charger.c:139 Excess function parameter 'ichg' description in 'bq25703_set_min_vsys'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

