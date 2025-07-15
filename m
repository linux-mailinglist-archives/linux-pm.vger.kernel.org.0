Return-Path: <linux-pm+bounces-30889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E5B0690E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55ED17B337E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A562C159D;
	Tue, 15 Jul 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJxL1QV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA962AF1D;
	Tue, 15 Jul 2025 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617276; cv=none; b=BmM0BYU6pkRP4zB5iervSOH2dbor1KW5VZflGXnvxDPgDxCtS0YO8ChDpiSjDf2fW3QhkhiZQA1A1SAtA5dJZPykqLbJKWNQEnBVOdimzE88WvGcUJMv8HyDQBEUg6D7cuCws7SHF+GaN5cEXi/G6zLiIFa989qMR3pSOCB98AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617276; c=relaxed/simple;
	bh=Zd8zXCwF0hQTiVzyVbw1IEp0HkYJGefGxnsNS4GWNqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrmOSRhUMOxGKcCAnRif5y2mWVHpHGpbADDv1nCJbhsSPBvkNBYx/CQfY3UHgAbogQXBmxFe1/+y3lKdg80Buf/kitb95fJiFwP5QS6gN1QNiquAtYkrM8Z2nUL8QRTvAq1uJAcIDdemlXsH1Z3aF5Ugh/vDAHUL8sjjceYqZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJxL1QV+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752617274; x=1784153274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zd8zXCwF0hQTiVzyVbw1IEp0HkYJGefGxnsNS4GWNqE=;
  b=hJxL1QV+HcyChGetheMDP19YQ896IpEDKkHe+4L8kFBRdlQeQcyzdich
   83n0FbvgHmfhEysMc7Ul731rOpFJ3UNTcYnLIFLKIsAIw+U8UzEVU7jSM
   qGF0DoNoQolL7zbLUERuU3HaPNg9ivUKbcOUHoZdMD/6CsBafxfc0Sz16
   YepXMYWeFKgmPGkLLUOspe5du070JBRdUdk9y2+OTAtJijKMkAabyVVgE
   yM7Ppz8pUPjZs9cL7JrqywlOUWUjUDx88Pp6o9JP2F95vdBR0PVS7H86q
   z0r+SOTNTYpy7FbBr+eBwj2JloZy6Kzv4BvRtj2od64MmLPZ/wGM5TUqv
   Q==;
X-CSE-ConnectionGUID: MzafmcvlTAysCsZ5nClFOw==
X-CSE-MsgGUID: cOoaIl/SQQ6A0VW7X9QqFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54826714"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54826714"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 15:07:53 -0700
X-CSE-ConnectionGUID: 2/CTSCq4QzqxTY/7962AOA==
X-CSE-MsgGUID: h6UmUrYARBK8MvLyxd9OmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="156731421"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Jul 2025 15:07:47 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubnoO-000BaZ-1F;
	Tue, 15 Jul 2025 22:07:44 +0000
Date: Wed, 16 Jul 2025 06:06:56 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Kling <webgeek1234@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH 13/17] thermal: tegra: Add Tegra210B01 Support
Message-ID: <202507160557.t7TfWvFP-lkp@intel.com>
References: <20250714-t210b01-v1-13-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-13-e3f5f7de5dce@gmail.com>

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 347e9f5043c89695b01e66b3ed111755afcf1911]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Kling/dt-bindings-arm-tegra-pmc-Document-Tegra210B01/20250715-160630
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250714-t210b01-v1-13-e3f5f7de5dce%40gmail.com
patch subject: [PATCH 13/17] thermal: tegra: Add Tegra210B01 Support
config: arm64-randconfig-003-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160557.t7TfWvFP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160557.t7TfWvFP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160557.t7TfWvFP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/tegra/tegra210-soctherm.c:47:49: warning: 'tegra210b01_tsensor_config' defined but not used [-Wunused-const-variable=]
    static const struct tegra_tsensor_configuration tegra210b01_tsensor_config = {
                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tegra210b01_tsensor_config +47 drivers/thermal/tegra/tegra210-soctherm.c

    46	
  > 47	static const struct tegra_tsensor_configuration tegra210b01_tsensor_config = {
    48		.tall = 16300,
    49		.tiddq_en = 1,
    50		.ten_count = 1,
    51		.tsample = 240,
    52		.tsample_ate = 480,
    53	};
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

