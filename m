Return-Path: <linux-pm+bounces-15539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E660499A2CB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 13:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224761C21A04
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163B215F75;
	Fri, 11 Oct 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpOITlxG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821F192D77;
	Fri, 11 Oct 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646519; cv=none; b=NY5o6IBRo6WJ39no9Qr1DGoPnvv2guDhpIuO7+yEscPqnKWJ2P9fhU8I4AtiPkZA1hL1qsxDOqjZvOv1Qwz1tMtUkz5eEWEus1GMRFb4wlP+jcWdVHTnGC+mLcRUaGAmR6M4uSUSi4Gfua5RXkw4hFDqTRGC86KrmlYj1BvGS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646519; c=relaxed/simple;
	bh=ZBZUlNi8h/D5QWW+bum5UjcTb6lETOPGVvmQjW3+6jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJPuK7KneNGK5xTF006QrSsAR3/bZ/Zvydeyagf7rZFZyKBcF/TDJKNd2yXvR1OERVBCEDKodkC18NixC9tbYTymbKH65app2/ZnRHAm6FCfDUmCI+dVFYyIxLWcb1S3esNFl2kZdSEiXRhUxk8zCNqZ04XIh/38frxjW1kW5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpOITlxG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728646517; x=1760182517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZBZUlNi8h/D5QWW+bum5UjcTb6lETOPGVvmQjW3+6jY=;
  b=OpOITlxGYUs9SyFVd67vT3SvtTZzKC95Btd4dSl3iSqD4bR2R6M9BG3B
   411lkNxcLy2H1VPhtjiY2ycr/I9K/pfZVNGlEMS8lfd0dWmFk/Y0DzmhY
   9MxNxUMbvWmxkZlNNS7R4HluWIZUUFzNnoH25UCvZgRSF1JqhBEexmsCc
   AUPwS1sybosOBn1S+REx15Pk+O3Qa4au0XpgmjVBBsHtoxbycTKSuQUKD
   v+gBPsHquR5yJi/6pOGYinIxqnCCL/fqjDDClc2AAT0EdIWz05xMFGokk
   /OLsEKZhACknqYLnxWeD1iBQK0dL5IFfoKPtaE18+COoWIPQAoHwdeONJ
   g==;
X-CSE-ConnectionGUID: /PkL3tqMSIy/snGBErEWqg==
X-CSE-MsgGUID: lgapOt64TgKYDrK+02xyyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53448450"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="53448450"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:35:16 -0700
X-CSE-ConnectionGUID: O14eHymeRoi8cs5j1wr0Yw==
X-CSE-MsgGUID: jGCbzQY9Tn+Jhp6BuY8+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76892191"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Oct 2024 04:35:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szDvL-000CF0-0o;
	Fri, 11 Oct 2024 11:35:11 +0000
Date: Fri, 11 Oct 2024 19:34:38 +0800
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
Message-ID: <202410111913.5ADtNHNM-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241011/202410111913.5ADtNHNM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111913.5ADtNHNM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410111913.5ADtNHNM-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/power/supply/max77705_fuel_gauge.o: in function `max77705_fg_get_property':
>> max77705_fuel_gauge.c:(.text+0x244): undefined reference to `__divdi3'
>> ld: max77705_fuel_gauge.c:(.text+0x2b1): undefined reference to `__udivdi3'
   ld: drivers/power/supply/max77705_fuel_gauge.o: in function `max77705_fg_vs_convert':
>> max77705_fuel_gauge.c:(.text+0x6c2): undefined reference to `__udivdi3'
   ld: drivers/power/supply/max77705_fuel_gauge.o: in function `max77705_fg_cs_convert':
   max77705_fuel_gauge.c:(.text+0x706): undefined reference to `__divdi3'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

