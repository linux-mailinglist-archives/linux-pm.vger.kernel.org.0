Return-Path: <linux-pm+bounces-8872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6D5902296
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052271F23845
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C131839E3;
	Mon, 10 Jun 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RghWsiHj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27C824BC;
	Mon, 10 Jun 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025775; cv=none; b=WnEKbNgWMoM9uyj/c3m+mDRX47C0dn/o1lzBbJGs+6DOI5h4AeiH5mqvO/L0cqaWyIvRIPuSjJFZX8LzEky0yd1knpmhYJphdrXbMnvUU8YBGsDTobCt0gJ6bEYYwg7Ah+AGu5jgGwJxYmFpGX06VTEakaxdo0YD9/OrM4//nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025775; c=relaxed/simple;
	bh=NepeI8ob9FXfvNHO4LXDjbHQpKCdIwqnMC08bVFhulo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPG9/SWMU/xeBRg2XpyT/l8yFgayPWPH/lyVtuqkPtQVCeZSgEJv/080Ek4BLFhi2CTP/RAd39cvAkqq+B9SrVjHDwt6scJBKIdtvDjQ2/TyhQbIr+IpTpbYI1O9btI06CjA2wZ6Vq6/Oh2kKzN3nRzQeS6ivKCQuOFEHKWswWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RghWsiHj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718025773; x=1749561773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NepeI8ob9FXfvNHO4LXDjbHQpKCdIwqnMC08bVFhulo=;
  b=RghWsiHjbKdtUb/UEO9Q7lAJrwav/YbHeFakvLaKBYf6ja3v0mr/gqoQ
   iiALqBY7fD12/HtVOAOq73HFAQcfBSH16vQxst62T6RyOp7o223Pp7L0/
   tfcRlhrlX/1Dp1HkroNaziUJA4aUniDs29oXiaEij5V5kfbijAiNvUlBi
   IM+M2dtQRBf/rWS7iCoCpCvteI9JW9KXsZcPI9lm6yS1hjNN1J/VwG+Lo
   6Igpz8WFsRDf/XsEYB8h1WPtjUCih+HnEbNtyUXa6m7POzYKOESAhHhmI
   GzHWKtxHfdeHXXo24uumBMlW2aBO8g5K7ORMRXqFl/KGl4YNNTWcUtBjZ
   Q==;
X-CSE-ConnectionGUID: eepkyb5NTYKrgZ2Yo8g2TQ==
X-CSE-MsgGUID: lb/ezKeLRt++VY1JtZOPfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14514971"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14514971"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 06:17:44 -0700
X-CSE-ConnectionGUID: vVswg6JuRhizRL9I0CY4iA==
X-CSE-MsgGUID: aMrqn/CUTJmFElQblBKmqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39056580"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 06:17:39 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGeu1-0002A7-0g;
	Mon, 10 Jun 2024 13:17:37 +0000
Date: Mon, 10 Jun 2024 21:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] interconnect: qcom: qcs404: Add regmaps and more bus
 descriptions
Message-ID: <202406102141.1kH3LXFy-lkp@intel.com>
References: <20240609182112.13032-7-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609182112.13032-7-a39.skl@gmail.com>

Hi Adam,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adam-Skladowski/dt-bindings-interconnect-Add-Qualcomm-MSM8976-DT-bindings/20240610-022416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240609182112.13032-7-a39.skl%40gmail.com
patch subject: [PATCH 6/7] interconnect: qcom: qcs404: Add regmaps and more bus descriptions
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240610/202406102141.1kH3LXFy-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4403cdbaf01379de96f8d0d6ea4f51a085e37766)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406102141.1kH3LXFy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406102141.1kH3LXFy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/interconnect/qcom/qcs404.c:1070:35: error: variable has incomplete type 'const struct regmap_config'
    1070 | static const struct regmap_config qcs404_bimc_regmap_config = {
         |                                   ^
   drivers/interconnect/qcom/icc-rpm.h:136:15: note: forward declaration of 'struct regmap_config'
     136 |         const struct regmap_config *regmap_cfg;
         |                      ^
   drivers/interconnect/qcom/qcs404.c:1137:35: error: variable has incomplete type 'const struct regmap_config'
    1137 | static const struct regmap_config qcs404_pcnoc_regmap_config = {
         |                                   ^
   drivers/interconnect/qcom/icc-rpm.h:136:15: note: forward declaration of 'struct regmap_config'
     136 |         const struct regmap_config *regmap_cfg;
         |                      ^
   drivers/interconnect/qcom/qcs404.c:1178:35: error: variable has incomplete type 'const struct regmap_config'
    1178 | static const struct regmap_config qcs404_snoc_regmap_config = {
         |                                   ^
   drivers/interconnect/qcom/icc-rpm.h:136:15: note: forward declaration of 'struct regmap_config'
     136 |         const struct regmap_config *regmap_cfg;
         |                      ^
   3 errors generated.


vim +1070 drivers/interconnect/qcom/qcs404.c

  1069	
> 1070	static const struct regmap_config qcs404_bimc_regmap_config = {
  1071		.reg_bits = 32,
  1072		.reg_stride = 4,
  1073		.val_bits = 32,
  1074		.max_register = 0x80000,
  1075		.fast_io = true,
  1076	};
  1077	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

