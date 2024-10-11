Return-Path: <linux-pm+bounces-15551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F599AC98
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 21:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C836B22DED
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F41CC179;
	Fri, 11 Oct 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs+/KZdj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49021C2327;
	Fri, 11 Oct 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674679; cv=none; b=CEquo7Hx8fqeow8nPdDcrmhL3W7aJ2e30na103Xq6h+hD4vOeYpPpqLhbAMl/iNV7I50rEMUAhnhkCixmCzefx1pZ6dUXxlmoYSRCy9ccVw+Pu0l+cGUYNgdPCzeb0Sbejkdhlcnf1W9Ug7rtrEtflbcIiQ5BrmS7QzymlA4Xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674679; c=relaxed/simple;
	bh=4nPb24ZEiQjI2CujzhQ2WwHWjHi/QZJvFIX6w92Wm+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmfF9vIrjwsVwnB2bEwlkLA0VtUZxoFOblKHrlYmRNFdAYfjFBuSFlVUI+ME6PF8fcENzYnDba02kDQY5iG9eZFnfpBHMsdQk7iVrsJi+lfqPXBYVMzGeF+vAPP4UlxBQgFnGCcLrP5rFy4wjYGWp4huzCoUsk41eNu2Jh687Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs+/KZdj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728674677; x=1760210677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nPb24ZEiQjI2CujzhQ2WwHWjHi/QZJvFIX6w92Wm+g=;
  b=Cs+/KZdj36f16HDAYQxeSV9v3d4Sst3ydVHzROaIdFrw6GRISeyQg6oh
   JjYoEXohxicA223HR4PNg6PFppgqZsJuO07PPLAjo7IyTSq2l1KdTpjOY
   oio+DPmMeDanyp9nMC2zirzHzQPYx6gm1volAZbIgcDliLK/HJjBHfPuG
   bt4f65qPSNXgmG3BIPBYckpeH6dG+NpBOHtrSOV8d0leB8iz2jHeDlD/c
   YfgQf28k7Uid73YtEioj+9PA2MxV0NPUAclErFQNgT5Z08MbWcnIV/FMe
   svG6E9OkP2F8qwvGfPycrfwcJN/BQhAusEBTVHUgAFSaM5YhQGvhmSEfH
   Q==;
X-CSE-ConnectionGUID: zY+Bpew5TA+Hd2slQktFlQ==
X-CSE-MsgGUID: +M6sLxznQ2iUUXWvMLBpZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53495214"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="53495214"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 12:24:36 -0700
X-CSE-ConnectionGUID: fYLHsV1TSIqfipBf9iIKlw==
X-CSE-MsgGUID: zyyMIgNCQM6TSitT/egsPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77003745"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Oct 2024 12:24:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szLFW-000Cet-2K;
	Fri, 11 Oct 2024 19:24:30 +0000
Date: Sat, 12 Oct 2024 03:23:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v6 6/7] power: supply: max77705: Add fuel gauge driver
 for Maxim 77705
Message-ID: <202410120358.OZgWQ1aJ-lkp@intel.com>
References: <20241007-starqltechn_integration_upstream-v6-6-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-6-0d38b5090c57@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 58ca61c1a866bfdaa5e19fb19a2416764f847d75]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20241008-000014
base:   58ca61c1a866bfdaa5e19fb19a2416764f847d75
patch link:    https://lore.kernel.org/r/20241007-starqltechn_integration_upstream-v6-6-0d38b5090c57%40gmail.com
patch subject: [PATCH v6 6/7] power: supply: max77705: Add fuel gauge driver for Maxim 77705
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241012/202410120358.OZgWQ1aJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410120358.OZgWQ1aJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410120358.OZgWQ1aJ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in security/tomoyo/tomoyo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/imx/imx-legacy-bridge.o
>> ERROR: modpost: "__udivdi3" [drivers/power/supply/max77705_fuel_gauge.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/power/supply/max77705_fuel_gauge.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

