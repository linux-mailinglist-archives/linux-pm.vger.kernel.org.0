Return-Path: <linux-pm+bounces-37356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45852C30E5F
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939D718C19A3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD472ECEAC;
	Tue,  4 Nov 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBH+MlKg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A712EC56F;
	Tue,  4 Nov 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258212; cv=none; b=OYvOHfTLh9uiwyjvsLHSgi+DtGRHpGo3YkSs86azSYKe/28pj7soE+foTMICBEU7HP7OSoe0ZA2re7YAhJdsqRvyNqBPFmTYtdgIYMo4GyG53gm0+zyTcsGECqn2D3JF40E/9A2/d2MZ2sBcs3epM5q8N2UXGHpOuQk65DxBhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258212; c=relaxed/simple;
	bh=+6EJ9lfIc5BbPa0NS7PF2URnPHdRP1lGEnDP8NUd2Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYAoY1eaHau677bnw/YdNvPo0B3SueG4ehiAn61JkCmPqG0rTbZF4t56MdoJ4pOQ8JIiCuZbGjs8JlFPUzc92c6ELVIhbyzZuW1rNn3tYow8e1SJ3Igsk8e83vafhxMKMPABH3/QopVA3E8/NyXrjdElmrRwA8F5aiknV8FJsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBH+MlKg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258210; x=1793794210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+6EJ9lfIc5BbPa0NS7PF2URnPHdRP1lGEnDP8NUd2Ko=;
  b=gBH+MlKgGvxKMZsgCombeAy+3kTg5gKi4ZSqQm6lWFv5f1EQWGoqtbzu
   Xlp3lkFH+wthC2oSxs+hfeRdpNFxIo/n2PXOm5o+NR0Q/m1o0PajikgV+
   lHFASR+x5GyafTriyYGhoGtPs7j7oxhKiQ1ygfUSMdhvWKxFb5OjwpdLV
   0KfpWWJ58fcy7E/8mT0dS2qaQIad68jBNuBv/KDZ21nSCBsHXw8yP/M/q
   zdd0f64BnNVK4sv2rU/S/gTI5Sii1crPSHy6gVc/zJ3WUrag9AEf7hSmu
   EtRVIoArJ9nNnYUvO6VjgNwtzL4LLj85GCaO1Amz7qGUVAzzWIlUscLBg
   Q==;
X-CSE-ConnectionGUID: /DU3m8HLR1yZEp2lq3wimQ==
X-CSE-MsgGUID: cXMKaw+QTPaw4yLgI4dW7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63361470"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="63361470"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:10:08 -0800
X-CSE-ConnectionGUID: If3LwOHXS9u+PNOfEGfuOw==
X-CSE-MsgGUID: 2Zyy1jrBTjiE0OLk+3zfQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="192232511"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 04 Nov 2025 04:10:03 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGFqz-000RNM-2V;
	Tue, 04 Nov 2025 12:09:43 +0000
Date: Tue, 4 Nov 2025 20:09:31 +0800
From: kernel test robot <lkp@intel.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, sre@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] firmware: qcom: scm: Support for EDL reboot mode
Message-ID: <202511041928.at1dqqZH-lkp@intel.com>
References: <20251103182006.1158383-5-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-5-loic.poulain@oss.qualcomm.com>

Hi Loic,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on sre-power-supply/for-next linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Loic-Poulain/dt-bindings-power-reset-qcom-pon-Document-qcom-warm-reset/20251104-022140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251103182006.1158383-5-loic.poulain%40oss.qualcomm.com
patch subject: [PATCH 4/5] firmware: qcom: scm: Support for EDL reboot mode
config: sparc-randconfig-001-20251104 (https://download.01.org/0day-ci/archive/20251104/202511041928.at1dqqZH-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041928.at1dqqZH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041928.at1dqqZH-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/spi/spi-amlogic-spifc-a4.o: in function `aml_sfc_set_bus_width':
   spi-amlogic-spifc-a4.c:(.text+0x3e8): undefined reference to `__ffsdi2'
   sparc64-linux-ld: drivers/firmware/qcom/qcom_scm.o: in function `qcom_scm_probe':
>> qcom_scm.c:(.text+0x2488): undefined reference to `devm_reboot_mode_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

