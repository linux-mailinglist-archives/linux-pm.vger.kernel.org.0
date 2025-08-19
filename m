Return-Path: <linux-pm+bounces-32617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D05B2BEC4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF13580A95
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C3279DC4;
	Tue, 19 Aug 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKv0/oJi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832B1990C7;
	Tue, 19 Aug 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598840; cv=none; b=aCJAWScg86oy0+pNfrpSO0P3CL/9ujac7ouiYzV4RAbem65KQtBLybj+w6xSACKm3jvZYVM0Xf8EY/lG4aOk2TbxTEUhkQX5uZvhzyrckqLx7JO2tW9W6kUSGDpaH5hfGqG6RbaK/3+UHEslVyaxz/DPbWAT5dc2YabpGBhuT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598840; c=relaxed/simple;
	bh=S47ygKL32ruBO8bjIs8S4nUDrgHAc2oSYPXd6ncSwnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoUY92z9ghJRi0eUjPDiiEngJlZN5c1dEri7fla3LmPQQBrhRHKvGFj4ac59BVNON7pbDq1iPuZTFw/XtNMBr9uk10AbyAPTH1jpvqDPCwXOPSoGwFH3CFm6knQuqTTbRzP9tKRLFWvUjfqRK9qTuvAzJEjDG1+5XtqZI7kFW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKv0/oJi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755598839; x=1787134839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S47ygKL32ruBO8bjIs8S4nUDrgHAc2oSYPXd6ncSwnQ=;
  b=DKv0/oJide/eFDYed1s/eCJvkVK+9tZBMl1/8Yola1ixDe+pHDa8AGls
   2Ns8jCEA645ScAeDDu/SRDeSqvnkz6vs5TD+2z4oHBKy6ZlTIzg5JGIZR
   mwyojRKBqcF5WvD7L4i3WJXTpEonveXYuFD+cZyL0wDkE0ZvBOSJ4bxC6
   QvSDSiOiyK+tkOnEfiO1G5NqoQbNs/WY06/SvY9VhRHK9b5wF+3l9V6oN
   J8x6nN4VILNBgMbDWNzzkvAMzi2cht2x8Spwm6lLgd+dPZeJDtWENuyt1
   zsGTUYjuGD6ed7RF8W3pAN8GcbagvU1J9JdqERxVshBnGeLWRBDX4a9QN
   w==;
X-CSE-ConnectionGUID: Dum/gjuIQOuOryabIXg71Q==
X-CSE-MsgGUID: f5XiBwa3Q3uOg+LeTm6qNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="69210751"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="69210751"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 03:20:38 -0700
X-CSE-ConnectionGUID: lOIoTR8OSUOebrRJdcrf/Q==
X-CSE-MsgGUID: lQlgxSwwTqerOwWQ0WNYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172049373"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2025 03:20:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoJSC-000Gjf-2S;
	Tue, 19 Aug 2025 10:20:32 +0000
Date: Tue, 19 Aug 2025 18:19:14 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
Message-ID: <202508191909.EIZEWxiJ-lkp@intel.com>
References: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/thermal-rockchip-shut-up-GRF-warning/20250819-012807
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250818-thermal-rockchip-grf-warning-v1-1-134152c97097%40kernel.org
patch subject: [PATCH] thermal: rockchip: shut up GRF warning
config: riscv-randconfig-001-20250819 (https://download.01.org/0day-ci/archive/20250819/202508191909.EIZEWxiJ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508191909.EIZEWxiJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508191909.EIZEWxiJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/thermal/rockchip_thermal.c:133 struct member 'grf_mode' not described in 'rockchip_tsadc_chip'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

