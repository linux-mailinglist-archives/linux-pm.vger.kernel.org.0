Return-Path: <linux-pm+bounces-20146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC8A076CC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825421673C0
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB33217F4A;
	Thu,  9 Jan 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GB+LNnJy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CD217F28;
	Thu,  9 Jan 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428337; cv=none; b=ixJ/0ipKcH3BfotN0SztuXuoWGUsLdhGbfrk0votT9AUa2XIcU0JtmIAD3x5IIQlQvALyEUhRBTbcp/cDBRTz6qvPyyxL6GcMX3EFGlIntonoQGgJf44kEKuagboXATVZg+XKlWPnXwpe2+iv/32XJ2g3T4bWg2UT48d4aTNTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428337; c=relaxed/simple;
	bh=ag+CVL8GO1ZYXa8AfDCwJl1QeL0yUyMSeLoUvIHHepE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGlcUGo2NUGtZmZ33Qxv7v3bNUP6L1ST2HDFCM6Xxity9MQj4fNIAACF2MnMkF2hVJ4N0qGj904PHkPEw0NyZF3HiB0SumGapBFPLr545mCXEpin1hbhaZ+bu34nR66YIVAlfpTeszrFMPxysvUDHehVRPCc0G28XwMluIzgk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GB+LNnJy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736428337; x=1767964337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ag+CVL8GO1ZYXa8AfDCwJl1QeL0yUyMSeLoUvIHHepE=;
  b=GB+LNnJykrosOwogLmVgsLQHpcolJXe13fHrKC94VzS2biEMzeVsFvZr
   xQEeMbq4WHi3BsHlBjoQ85Xg64tPgaqS4VrcpBRSDVAS9cGRZ9FgYaoBG
   2CkD4FTspVO+n7uETmYVsv6SB9ogTSXcqzWyHTkkh6toi8t+poKBT61Js
   8qBUBx9dXi0MLZlMb3m42AFuSiRayhDieHvBqDghu7+gXUf0K6iLFu3J0
   gECIYU8c2Hj/j4j7A8eXUVxqxpg/MSonmeHEO5BS2wlP0poYDM1aOJi0/
   mZbuM9B5tvPub6o2VOQMWUnyfjD/du2hr8H52Q/ZHh5cvk1Lq9F3XyeQz
   w==;
X-CSE-ConnectionGUID: +ZEc85x3SEqpqFji1zP7jw==
X-CSE-MsgGUID: Rkv2lW+pTYqW231t9/uu6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36802438"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="36802438"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 05:12:16 -0800
X-CSE-ConnectionGUID: fJrEWseXQLiO5pdH9F86mA==
X-CSE-MsgGUID: fAZbMe0HR5ieD1l6xsc5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="134235630"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2025 05:12:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVsKV-000HZX-2u;
	Thu, 09 Jan 2025 13:12:07 +0000
Date: Thu, 9 Jan 2025 21:11:53 +0800
From: kernel test robot <lkp@intel.com>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Message-ID: <202501092058.5rRJ1ocm-lkp@intel.com>
References: <20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com>

Hi Akhil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dbfac60febfa806abb2d384cb6441e77335d2799]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-P-Oommen/drm-msm-adreno-Add-support-for-ACD/20250109-044339
base:   dbfac60febfa806abb2d384cb6441e77335d2799
patch link:    https://lore.kernel.org/r/20250109-gpu-acd-v4-5-08a5efaf4a23%40quicinc.com
patch subject: [PATCH v4 5/7] dt-bindings: opp: Add v2-qcom-adreno vendor bindings
config: csky-randconfig-051-20250109 (https://download.01.org/0day-ci/archive/20250109/202501092058.5rRJ1ocm-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
dtschema version: 2024.12.dev6+gc4da38d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501092058.5rRJ1ocm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092058.5rRJ1ocm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>> Warning: Duplicate compatible "operating-points-v2" found in schemas matching "$id":
   	http://devicetree.org/schemas/opp/opp-v2.yaml#
   	http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

