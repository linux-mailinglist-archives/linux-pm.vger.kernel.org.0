Return-Path: <linux-pm+bounces-31951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE33B1B098
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D43164944
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA323C4FF;
	Tue,  5 Aug 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoKXIyry"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621B19E98C;
	Tue,  5 Aug 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384506; cv=none; b=FyIwk9njEXHdO6U8VOxGG3O3ru92URixXXrUmxD1vaJ8x540hJFRoa0rcYsKLNlKyYgKUuovIMsqk4iyYuX1yhAAa15Yu55qSK3QkIAM9o1ZDSvpZgZWgJeDZm0d45LeS2sJ1AJ6qX57jZbI+cS7mpRUCIkvUXyDJYjtyyM5C48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384506; c=relaxed/simple;
	bh=gf1YHbam51GMAXwrHRGJvU/JvLb/rUHVZyplFxxR3CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew260Uso5GBKVZiieMg7vxAJ633ua9hbmZAJNfV+DaZkhgTPGVDQo4YOI/Uz6JLd23gk/rG+xrcpXZninILwCv4sg2RYGAR9HBcxslWXVJ75R0WnkjWDZ4x4ZEuVnEcWQDbUQzVIpFsCA4gBB3OrnTE050yBxiXGrQCGjvxKbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoKXIyry; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754384505; x=1785920505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gf1YHbam51GMAXwrHRGJvU/JvLb/rUHVZyplFxxR3CM=;
  b=EoKXIyry/SRpFuC6VXg0z03lsdSr9ZnPbxtBlxh1JxlnpJSsFye88C18
   eUZduwQc7fdeeMuVjBEk13frbMMoneSje5WLtfeByoDORa2fiixeWposn
   aw/z/6l8q2tYTgWNpBky5cUXFaipFVw0amTuNdoMopvdHZGsn+mhSfG5e
   JAPRPb8KhGAcN1aTuB+oLa/pFCLWQAZncVTu8rQjI8wXaaseXwYq3K1aO
   e/axdJlVqsFjSO2n/UcucUZSw/CVzAE0HB4SELJHgfc7Gvxm5VI2pdAZJ
   91ab1vI9GyqT1E7nXRAs5K8DAboJ9eqyxlP/J1P52kMsceCmCFQtr7Xnb
   A==;
X-CSE-ConnectionGUID: 5FnDeFoAS7CAhFn5vGdCng==
X-CSE-MsgGUID: 8TUPdItvTZ2c6VYwjlBNkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="60501699"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="60501699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 02:01:45 -0700
X-CSE-ConnectionGUID: ku7DH78QTCyT3ySdc82PYQ==
X-CSE-MsgGUID: NeBvjl4QSdCmHZQiDtmxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="163679737"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2025 02:01:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujDY8-0000Uc-2T;
	Tue, 05 Aug 2025 09:01:36 +0000
Date: Tue, 5 Aug 2025 17:01:35 +0800
From: kernel test robot <lkp@intel.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
	will@kernel.org, maz@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ry111@xry111.site, Dave.Martin@arm.com, ahmed.genidi@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 07/11] arm64: make the per-task SCTLR2_EL1
Message-ID: <202508051649.pyaqcE8d-lkp@intel.com>
References: <20250804121724.3681531-8-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804121724.3681531-8-yeoreum.yun@arm.com>

Hi Yeoreum,

kernel test robot noticed the following build errors:

[auto build test ERROR on 038d61fd642278bab63ee8ef722c50d10ab01e8f]

url:    https://github.com/intel-lab-lkp/linux/commits/Yeoreum-Yun/arm64-sysreg-add-system-registers-SCTLR2_EL2/20250804-202225
base:   038d61fd642278bab63ee8ef722c50d10ab01e8f
patch link:    https://lore.kernel.org/r/20250804121724.3681531-8-yeoreum.yun%40arm.com
patch subject: [PATCH 07/11] arm64: make the per-task SCTLR2_EL1
config: arm64-randconfig-001-20250805 (https://download.01.org/0day-ci/archive/20250805/202508051649.pyaqcE8d-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250805/202508051649.pyaqcE8d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508051649.pyaqcE8d-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/ccFwinHr.s: Assembler messages:
>> /tmp/ccFwinHr.s:1352: Error: selected processor does not support system register name 'sctlr2_el1'
   /tmp/ccFwinHr.s:1362: Error: selected processor does not support system register name 'sctlr2_el1'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

