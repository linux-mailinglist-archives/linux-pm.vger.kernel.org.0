Return-Path: <linux-pm+bounces-32476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C80B2952A
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 23:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E074E128D
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153E244186;
	Sun, 17 Aug 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/MjflZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BB21D3EE;
	Sun, 17 Aug 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755466419; cv=none; b=Gel6cYs3uwhm6ssEGnb6rzoyq1kUcyyPbxl4nAKnMEYE26a50A7wAuDijK1nraP2jmacPwqZ1BBGEfUwFGgYzUtPYPXOU1N/GnmHlA9pD84nMmGLBzXN7YL9VCoPCh+WobqR21JR5ZTKPSwmN/0mx6WAHFMFniXj+mGrCtSl9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755466419; c=relaxed/simple;
	bh=t9Q+VQW3Y9xyJgZNofK2udYImmD4JkyR64F111ooGM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA62hXaSe5Pc1o3qFlqZXQPTTAOKT/nX1tYn+lGX7qTR2SiJFWdxsjxaj3261HshSV8rZWdL1FrmZeQ1/hb4KW5ErK7V+UBMjq73T28lAIMtJIGXtir5P1mrnZ0krXLpC/EH9d5+c77bOrUl48O36RVjechhElaP0yF/gcqVX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/MjflZS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755466417; x=1787002417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t9Q+VQW3Y9xyJgZNofK2udYImmD4JkyR64F111ooGM4=;
  b=n/MjflZS7W62eAHk7YHzAzFReROJg6mVmPJg7+KGjpyNZHb8L2tXXDOP
   WO+xnD5lG40KDQUF45K/Qu0eZ9us+nzMHau4H1p4KKAmeplQkyaIIAb9N
   v/sQPsADLIr1FTLBDWe8B3THAsjwlRjvUGDjQPK1N5E1wT/09e/lvuJPC
   99OffY0BNYHjVbySHLuJry4P/y9gnO/1n2ECFZUsJUGmirIIYaAw9//j2
   DZrnP8Ulw7nxlFn0DnVFiIEosUy6OU5ipFBitupQFg9ucIwr/y8Est10E
   7sgbKS5F3p6us0y4EkrYHTXSiYUYcgStK/MsKhi7US+DaNvfSr8GmjLut
   A==;
X-CSE-ConnectionGUID: 2qEPUtBRRqS2OXHUEpVFSQ==
X-CSE-MsgGUID: iJ5ne5j6RPSqhV34ygDDcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69062736"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69062736"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 14:33:37 -0700
X-CSE-ConnectionGUID: snVhK1rxQSmIl3OlixuAUQ==
X-CSE-MsgGUID: fpQW4rqJQ2y6PgpQZobrNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198434635"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Aug 2025 14:33:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unl0N-000Dj5-35;
	Sun, 17 Aug 2025 21:33:31 +0000
Date: Mon, 18 Aug 2025 05:33:22 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <202508180501.24kGNF9b-lkp@intel.com>
References: <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/mfd-bd71828-bd71815-prepare-for-power-supply-support/20250817-032146
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250816-bd71828-charger-v1-2-71b11bde5c73%40kemnade.info
patch subject: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
config: m68k-randconfig-r111-20250818 (https://download.01.org/0day-ci/archive/20250818/202508180501.24kGNF9b-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250818/202508180501.24kGNF9b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508180501.24kGNF9b-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/supply/bd71828-power.c:257:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [addressable] [usertype] tmp_curr @@     got unsigned short [usertype] @@
   drivers/power/supply/bd71828-power.c:257:26: sparse:     expected restricted __be16 [addressable] [usertype] tmp_curr
   drivers/power/supply/bd71828-power.c:257:26: sparse:     got unsigned short [usertype]
>> drivers/power/supply/bd71828-power.c:259:36: sparse: sparse: cast from restricted __be16

vim +257 drivers/power/supply/bd71828-power.c

   237	
   238	static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *curr, int *curr_avg)
   239	{
   240		__be16 tmp_curr;
   241		char *tmp = (char *)&tmp_curr;
   242		int dir = 1;
   243		int regs[] = { pwr->regs->ibat, pwr->regs->ibat_avg };
   244		int *vals[] = { curr, curr_avg };
   245		int ret, i;
   246	
   247		for (dir = 1, i = 0; i < ARRAY_SIZE(regs); i++) {
   248			ret = regmap_bulk_read(pwr->regmap, regs[i], &tmp_curr,
   249					       sizeof(tmp_curr));
   250			if (ret)
   251				break;
   252	
   253			if (*tmp & BD7182x_MASK_CURDIR_DISCHG)
   254				dir = -1;
   255	
   256			*tmp &= BD7182x_MASK_IBAT_U;
 > 257			tmp_curr = be16_to_cpu(tmp_curr);
   258	
 > 259			*vals[i] = dir * ((int)tmp_curr) * pwr->curr_factor;
   260		}
   261	
   262		return ret;
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

