Return-Path: <linux-pm+bounces-10225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB291C81A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 23:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C9B2838CF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516037E57F;
	Fri, 28 Jun 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjEC6bjp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EA7D3EF;
	Fri, 28 Jun 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609971; cv=none; b=o/j9WxhqmYPU+H+rZ2QJ8wcuIuNS5WpDcGW1pdw1JMCLTJqWHRxhpyk1Msvkmnetz3CLxvpQ2s/EdHHrjUu9/LcNqqnN73d/nIXKlhOc9cOzoRyR9n/ccLjgYqck8ZsOvPhxDNBtOPT9AYPEGw7Yi1jdiRCEzXJRuOC9fJs8obg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609971; c=relaxed/simple;
	bh=7iwPNb0zaCH3MThVE7R/uhMo+IPySwi3vQTNsKQo880=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr45YRIRb99MugazsQq/ihhsrfqHAZjUbmIx9NkuHpfYHpo0cfAbvLrruJI1+rD1P9J1PgBT66Iq/kaOXmM7JQVz7VGaprYaBHzR2/8h6FZn0hgfWkL7Lq9EkpJreoY9rFR3Q2W4lKpC2yUmNRfzEuSp14ew7yEDdnrCo+TR69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjEC6bjp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719609968; x=1751145968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7iwPNb0zaCH3MThVE7R/uhMo+IPySwi3vQTNsKQo880=;
  b=DjEC6bjp+kIB2bkwuas1wtSAiyg4RWQrYiaxG+WCgpw8W1BKoQmK0kow
   wG4m5n2uSjzfEQfEMPFOH9pTH0s6cIJ608B+PVcsls75x5GYUmRJm14O7
   QNWvyrgoxpx4zh7fUfgQUDYxObAJb4f7NMwwS/rDxoguWF8+seVxZGIHQ
   2aG0Y54RN1qkWg1F/ZFt32WEhF2zP/dP3qizovdm+4Wc81keC/bG1gFv8
   CFWyzS1553WXIdGovcTfcScHjQk3yZDGKZvpCs5U1DDy8bMrwq+9cBWAh
   JKCO48ZenMBfxJhBL3Snep74dWW8SjkHL5v2kfSf/NM2M1xIK9T2plp21
   g==;
X-CSE-ConnectionGUID: L9f+IHGZRPOAgbxFSv9cIw==
X-CSE-MsgGUID: e3xbjWwmQOe5mCPN2YgUnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20622967"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20622967"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:26:07 -0700
X-CSE-ConnectionGUID: 54F0s+cWQzerdFzKDr4PwA==
X-CSE-MsgGUID: i5XhAPB9SGOLX/Aqmu/0iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49206798"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Jun 2024 14:26:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNJ6Y-000IUw-2X;
	Fri, 28 Jun 2024 21:26:02 +0000
Date: Sat, 29 Jun 2024 05:25:58 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add MSM8953 driver
Message-ID: <202406290557.izx4yyVD-lkp@intel.com>
References: <20240627-msm8953-interconnect-v2-2-b4940a8eab69@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240627-msm8953-interconnect-v2-2-b4940a8eab69@mainlining.org>

Hi Barnabás,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 62c97045b8f720c2eac807a5f38e26c9ed512371]

url:    https://github.com/intel-lab-lkp/linux/commits/Barnab-s-Cz-m-n/dt-bindings-interconnect-qcom-Add-Qualcomm-MSM8953-NoC/20240628-154505
base:   62c97045b8f720c2eac807a5f38e26c9ed512371
patch link:    https://lore.kernel.org/r/20240627-msm8953-interconnect-v2-2-b4940a8eab69%40mainlining.org
patch subject: [PATCH v2 2/2] interconnect: qcom: Add MSM8953 driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240629/202406290557.izx4yyVD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240629/202406290557.izx4yyVD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406290557.izx4yyVD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/interconnect/qcom/msm8953.c:1220:27: warning: 'msm8953_pcnoc_bus_clocks' defined but not used [-Wunused-const-variable=]
    1220 | static const char * const msm8953_pcnoc_bus_clocks[] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/msm8953_pcnoc_bus_clocks +1220 drivers/interconnect/qcom/msm8953.c

  1219	
> 1220	static const char * const msm8953_pcnoc_bus_clocks[] = {
  1221		"bus", "bus_a"
  1222	};
  1223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

