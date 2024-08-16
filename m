Return-Path: <linux-pm+bounces-12303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E014D9542C4
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64190B2186A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71212C465;
	Fri, 16 Aug 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtvn8GAM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329908563E;
	Fri, 16 Aug 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793284; cv=none; b=KmVuk9yXV7FVg1iBNf0MPkgAHNI7gTWgI1xFAIHWj0Byla3Z0pUmDEF9/yWPbuEBDMruL1Zchym7bAL0SLGJ19sqgnQjnjcdlatOubCjLQAz9tOT+9RBMYQGJZGsjDYLqJx1ElsfIVzvoDWOMqO2IwRaAyxWSuuWgzD+jDGJHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793284; c=relaxed/simple;
	bh=Yue6WQ830weCdQe8FWjaTaPLieyUHCZqYinYPsMU+u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgM+SjKepuCbMviX83914bWv5p8NK2yrgQ330RXguS4y1yuOIjHX9qO4CZT3b+ltfw1CvNuNF98+f6RP7JG2x3rdcUaSUs9X/8OrV6aZfZePkuvtzK/P9ssWZV+u0oFRZuQOJCxRyEe7tcP/sz+KrobyScj2uFiKL8AkHsvzKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtvn8GAM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723793282; x=1755329282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yue6WQ830weCdQe8FWjaTaPLieyUHCZqYinYPsMU+u4=;
  b=dtvn8GAMWouohtMDFMStTv5fLOtypvImZxmQ6HWtdDw1S2x7ZCFgaEBN
   al2BdCvKSZ7VdnCD6nrGPazY8h7R3R/i70nb58lWU1IQ25ft8ZhK4vmIG
   XY6tUnKeER/PRkfS0TeZoEmbTF2kqYuN/R3BoqDPKIjZXD1bZbNc6Xm2T
   Q8roy1mEE8D/E5/4Ac+zGTUxaMBcT0TtiwOBllEJvskpCfixCLfgnM1qM
   y17pB0LVElYvpmLFKFiSJUEe77DEMcOuVqw2L2g4dG1wqAXg2Nq/xhv9q
   P/AtllparcxybI35Hrn4V4HBfZn14V2dN54ypxLMOGD7t6JvCG1fO5nEW
   A==;
X-CSE-ConnectionGUID: 7ezN2LDfS16BFMfpXGC5pw==
X-CSE-MsgGUID: IT5bdfB6TO2VpW6ikWI8fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22225647"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22225647"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 00:27:52 -0700
X-CSE-ConnectionGUID: TMSYtdU0ScSPiqwIoebVxg==
X-CSE-MsgGUID: pBRXIBB+QAa/o7Ioixu3ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59433899"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Aug 2024 00:27:49 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1serND-00066w-1a;
	Fri, 16 Aug 2024 07:27:47 +0000
Date: Fri, 16 Aug 2024 15:27:45 +0800
From: kernel test robot <lkp@intel.com>
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
  battery charge settings
Message-ID: <202408161520.j54E147f-lkp@intel.com>
References: <20240815192848.3489d3e1@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815192848.3489d3e1@5400>

Hi Andres,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.11-rc3 next-20240816]
[cannot apply to amd-pstate/linux-next amd-pstate/bleeding-edge]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andres-Salomon/platform-x86-dell-laptop-remove-duplicate-code-w-battery-function/20240816-102156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240815192848.3489d3e1%405400
patch subject: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change  battery charge settings
reproduce: (https://download.01.org/0day-ci/archive/20240816/202408161520.j54E147f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408161520.j54E147f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: /sys/class/power_supply/<supply_name>/charge_type is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-power-dell:0  ./Documentation/ABI/testing/sysfs-class-power:375
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

