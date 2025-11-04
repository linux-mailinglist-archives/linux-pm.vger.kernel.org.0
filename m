Return-Path: <linux-pm+bounces-37359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A0C31323
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 14:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C784C4F8A10
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE42FB984;
	Tue,  4 Nov 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbHSiTHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F12F7AB4;
	Tue,  4 Nov 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262099; cv=none; b=SoWlLHs1LtDmTt9MraH7TAO7DsNaVw3K2qghTsiK02zP81coDAulj5vZgwNiUhAKz9Eg45WCzV4uHjEV1StPCarPwj5BFviUpEcGLu5v4j6PD9GXOuk1yafZfrowDd8G8xjV28DoxsTQwMFefzmkV4n0KQdjppZn/E3T0i86vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262099; c=relaxed/simple;
	bh=ZEU8FvkHiwIhUuKOfPNCnyWW5StZUux0a+VENGL9yng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p36CiOCpXIwSb1dkmaXvwdSMVQI2aJ6eMVq5xUO3DLAqU0NamhU/QcR7L6H43BI3vPUh6W9I9Xbm7nE88RlzLprzDbOOIju3KrrAWls7CHuzlrVTEa0bYGCqo+h7InkhoBNsSvCdKdWSXFheZp4rQz0cCRWR0MU1U4zxHeqgW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbHSiTHQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762262098; x=1793798098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEU8FvkHiwIhUuKOfPNCnyWW5StZUux0a+VENGL9yng=;
  b=BbHSiTHQYe36haAvJDcOd7Ktqea1vFzmEtPZYfBfAO0sHj5a0a8ThMSR
   +fG1JCtUd047GaTf3kPGU9byjSRTfU5hnTEYlEbVxGONPXbIEE6M5jV6H
   AeElgIqjERMlensbxRp+F+kc1BOPOFMKdHdK8Jmjat53BuZeFY1jypoXu
   r27YiuxUbF0ium4lxpNzV1UOaFTOP1JdB00FcBkxatOEAfXzjq6bBFKzH
   a+9WS07tcAFwDKGF/FAz5r8dQUzO514+LbC2alxCo0XCJ0fw5od9xR+ll
   GcCkmMNFr8LY4h2oe00Q9RJFFk7gDc5PtEopO1wfYb8mJ29rQcg8T6gyc
   Q==;
X-CSE-ConnectionGUID: Gth/IuAfTa63wc2DXda0sQ==
X-CSE-MsgGUID: 3X1yerdcSnyF+OYY+7Q9IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74648188"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="74648188"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 05:14:57 -0800
X-CSE-ConnectionGUID: dCqmaljzTcyrDLfwN0qA1Q==
X-CSE-MsgGUID: jRDMMh8+RIOlcOj7+nYusg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186833101"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2025 05:14:54 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGGrl-000RQC-2H;
	Tue, 04 Nov 2025 13:14:41 +0000
Date: Tue, 4 Nov 2025 21:13:07 +0800
From: kernel test robot <lkp@intel.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, sre@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] firmware: qcom: scm: Support for EDL reboot mode
Message-ID: <202511042044.FqeSCxnF-lkp@intel.com>
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
[also build test ERROR on sre-power-supply/for-next linus/master v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Loic-Poulain/dt-bindings-power-reset-qcom-pon-Document-qcom-warm-reset/20251104-022140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251103182006.1158383-5-loic.poulain%40oss.qualcomm.com
patch subject: [PATCH 4/5] firmware: qcom: scm: Support for EDL reboot mode
config: arm64-randconfig-003-20251104 (https://download.01.org/0day-ci/archive/20251104/202511042044.FqeSCxnF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511042044.FqeSCxnF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511042044.FqeSCxnF-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_reboot_mode_register" [drivers/firmware/qcom/qcom-scm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

