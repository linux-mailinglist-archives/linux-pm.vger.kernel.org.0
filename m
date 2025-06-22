Return-Path: <linux-pm+bounces-29226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD2AE3054
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D80166796
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F01E7C38;
	Sun, 22 Jun 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRqJVIHx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B61A29A;
	Sun, 22 Jun 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750601577; cv=none; b=ahsuKWFCMDjFPNTct7JmT9wF9DSPU9WTb0JkgazBWy8GWDiwQtESvAitQT5b7K4NnMRAauEin9v9yyJZm2YcJ/hKtP32UmmCXTnmnomoQ5TljbCldls2Ri5jdGRbCEouchJJRPBm9pvzOHVgbfYXntrt8gg72Mj0hC71oG89wVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750601577; c=relaxed/simple;
	bh=f1LVrqYHd5nJ9/e8djtzbBcTtvAXQDxzr8Z+AcN5gZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYyEApXlK1hF/8cBXTJKyun38NV4jjgSsG4FtuwQCiFJ8selofYC4eymYWDPacrQVYsiQPU5GS33ArPvJhWB+JG6CxZ383kxQgIU2NecSGSePmTcUgn9zST2x9eZrElsWvZIq2XuZqYD/xUjrx+sBbAah3nwUxHASL8Hu4UZ/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRqJVIHx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750601576; x=1782137576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f1LVrqYHd5nJ9/e8djtzbBcTtvAXQDxzr8Z+AcN5gZ8=;
  b=HRqJVIHxT/ikaizhYoQqBZYN66IIrp67P0HEtQiQGDe4Jvfv73K/Afzi
   ByE6jsCM/xrMJWlTk5NE1wtkPk/kFz0zQ8fNww8qWYEw7RS4lW2Qoe6db
   pA3Vk9JyLkYcBaApTaPr46y31I8pSm5HkQ0byUyVd9SmYz+p2cyWTYfNd
   c8m/fXijf+4sX/zj9Mpvq2B/5gKlp9cPZOBNaeZyP0wAg8TMb07vKycC2
   AgiREEdgghgjpE5J0IY2haGzi38WwnQqFS+44HubFY9tjlOjGQzgAR1iM
   jPYXyYVyng/8clRwGnMETl/aEhA2i//imUrOScE6otYGIG3y20+XYLrkr
   A==;
X-CSE-ConnectionGUID: F592ZIeHSKWz8b7eOhbguw==
X-CSE-MsgGUID: 9QwckiosRUCQNY3pnFLQhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52741710"
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="52741710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 07:12:55 -0700
X-CSE-ConnectionGUID: YGjot7OcTFqAfGQ6z1gKTA==
X-CSE-MsgGUID: Vh/3X8VvQICY00j/oPMgbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="157153885"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Jun 2025 07:12:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTLRB-000NKg-0y;
	Sun, 22 Jun 2025 14:12:49 +0000
Date: Sun, 22 Jun 2025 22:11:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	broonie@kernel.org, lgirdwood@gmail.com, sre@kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 4/5] regulator: bq257xx: Add bq257xx boost regulator
 driver
Message-ID: <202506222132.hzKC0iLG-lkp@intel.com>
References: <20250621180119.163423-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621180119.163423-5-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on lee-mfd/for-mfd-fixes broonie-regulator/for-next sre-power-supply/for-next linus/master v6.16-rc2 next-20250620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-mfd-ti-bq25703a-Add-TI-BQ25703A-Charger/20250622-020443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20250621180119.163423-5-macroalpha82%40gmail.com
patch subject: [PATCH V2 4/5] regulator: bq257xx: Add bq257xx boost regulator driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250622/202506222132.hzKC0iLG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250622/202506222132.hzKC0iLG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506222132.hzKC0iLG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/bq257xx-regulator.c:33:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      33 |         return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
         |                ^
>> drivers/regulator/bq257xx-regulator.c:56:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      56 |                             FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
         |                             ^
   2 errors generated.


vim +/FIELD_GET +33 drivers/regulator/bq257xx-regulator.c

    23	
    24	static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
    25	{
    26		struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
    27		int ret;
    28		unsigned int reg;
    29	
    30		ret = regmap_read(pdata->bq->regmap, BQ25703_OTG_CURRENT, &reg);
    31		if (ret)
    32			return ret;
  > 33		return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
    34	}
    35	
    36	/*
    37	 * Check if the minimum current and maximum current requested are
    38	 * sane values, then set the register accordingly.
    39	 */
    40	static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
    41					      int min_uA, int max_uA)
    42	{
    43		struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
    44		unsigned int reg;
    45	
    46		if ((min_uA > BQ25703_OTG_CUR_MAX_UA) || (max_uA < 0))
    47			return -EINVAL;
    48	
    49		reg = (max_uA / BQ25703_OTG_CUR_STEP_UA);
    50	
    51		/* Catch rounding errors since our step is 50000uA. */
    52		if ((reg * BQ25703_OTG_CUR_STEP_UA) < min_uA)
    53			return -EINVAL;
    54	
    55		return regmap_write(pdata->bq->regmap, BQ25703_OTG_CURRENT,
  > 56				    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
    57	}
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

