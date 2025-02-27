Return-Path: <linux-pm+bounces-23078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE99A4814B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD019C34C3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F55231A22;
	Thu, 27 Feb 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5rDSo8n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EB2309AA;
	Thu, 27 Feb 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665946; cv=none; b=XPs2f+mvlRCh8nSO5cj6FX////1Pl+YBZ6bGj9mZmsw4vTeXPZXv6VfVoQ3+X5H+jt1V8UT9tszh37Rz5woiuak06CdVXwLOpKeZVJNk+q4j5iYEPbHaetKWIdEJ5V/L6a2O/hMtv/qFFazsyNRCi4T18+eOZ91WSbFCWSFWx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665946; c=relaxed/simple;
	bh=bfYW3LHwMOMgvcuWqLOaQFxhtTvpWF53uj1Tq7lCn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx1LflWF0XwCQSsx6RVmX1Uybk037F5X9+/HAx2bd+GsYqMcOVHfxG5q3F/1AxSmfWQRgTszxi3LGju8gu0jwUu/3E7e0jhIvuY8mGU2UZo/OA0nl03KL1ssjOq7UompG0nS7W79mXZNG987oibMruiy/ZK0Vhm8+xkqeg0vQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5rDSo8n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665945; x=1772201945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfYW3LHwMOMgvcuWqLOaQFxhtTvpWF53uj1Tq7lCn7A=;
  b=n5rDSo8nkCc2a8OBfZ6vxiQjljZihXqyGtl7Smwq+V7QCYfWvzzXKo8G
   9VPG3KA8pRXdYBGXcXVfTd8ESz9kroki9Ml82v4zIrcS4Iw/hHKH0DgpI
   xYIPF8ABGMVDcT5NcG/f3+X85cfWDzIgok55OULFRizOrLPzv44TNF1YJ
   qWnMoL7HraV58TnxNhNxC0Z+7N31wNDU21ZL6GkzZsCYmFJq00HvhRuHc
   wENO0dQcGF1pS+WQEPS5S1mq6YN2/8gVgIn+6g8a3rwVdhqcH6xSksS9H
   G8JLwCDOA5Jsjnvz1s38JBMCz2jHL0BRNPiAYWiOaZJD5TJiblmUlER6A
   g==;
X-CSE-ConnectionGUID: 2yEDdmRuS2m+EqKjEFaJzw==
X-CSE-MsgGUID: YLCVXucqQAyGdYA29GLN4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52543185"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52543185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:19:03 -0800
X-CSE-ConnectionGUID: 1x2Rj4zmTJuMrUEbdFhdRg==
X-CSE-MsgGUID: 3bHSuuctQEKD3UopNX7e+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="140269609"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 06:19:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnein-000DTW-0L;
	Thu, 27 Feb 2025 14:18:53 +0000
Date: Thu, 27 Feb 2025 22:18:40 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: Add support for Maxim MAX8971
 charger
Message-ID: <202502272232.bykWJmpq-lkp@intel.com>
References: <20250226093700.44726-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226093700.44726-3-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-power-supply-Document-Maxim-MAX8971-charger/20250226-174046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250226093700.44726-3-clamor95%40gmail.com
patch subject: [PATCH v2 2/2] power: supply: Add support for Maxim MAX8971 charger
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250227/202502272232.bykWJmpq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272232.bykWJmpq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272232.bykWJmpq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/max8971_charger.c:653:12: warning: 'max8971_resume' defined but not used [-Wunused-function]
     653 | static int max8971_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~


vim +/max8971_resume +653 drivers/power/supply/max8971_charger.c

   652	
 > 653	static int max8971_resume(struct device *dev)
   654	{
   655		struct i2c_client *client = to_i2c_client(dev);
   656		struct max8971_data *priv = i2c_get_clientdata(client);
   657	
   658		irq_wake_thread(client->irq, priv);
   659	
   660		return 0;
   661	}
   662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

