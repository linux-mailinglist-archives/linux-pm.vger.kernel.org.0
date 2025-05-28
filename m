Return-Path: <linux-pm+bounces-27747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9AAC6DEF
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0A71BA46AC
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93928CF56;
	Wed, 28 May 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KT0aTuo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D91244670;
	Wed, 28 May 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449412; cv=none; b=bpqkj4q8vJOmRjPSveqZKOVtuqohKt29PeZWMJminnS4TdevCPIEMSvw+B6Wuj5s6Ac4nWU25tTuZ0G4Eivu3B+kNg27NOFjHTbNajF9r13LRjV+V4dTQmZ09zCDnKQHSKRzjyVtnQNXgxQmpgmNKF6CmaBZvSj/9NWd1gkMEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449412; c=relaxed/simple;
	bh=cuyrb+k5/OZVTifVBSYnbWi26a1IZ56MqnHdcIIT5/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD/Znva7mI/D0nWu+ZuO1OTLPC3PS3L5n710y7YNHRR0ufMowMLo9lwWfFc4P9oqCc+1BHnL3HF/kba0v1x9aimAWa9XwZi+pGbXy9Twco0uhAXJnFOmEZEYhipPLa3SIcKysnuzvB6EP0uXyqqc2e9jxLt6A3xCf27Dqtg1ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KT0aTuo3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748449411; x=1779985411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cuyrb+k5/OZVTifVBSYnbWi26a1IZ56MqnHdcIIT5/g=;
  b=KT0aTuo3RDkDd2zmcztFTSfZr/txcrc74vYIRdnWYl/QlapiXOZy3vM/
   W0xZtHHH1vj0K1TeYBrH9i6y3DhXGkLgJCSjYleZtPS//3kgVSEM2/FlO
   D8JpLZqlVfQSuHR33AT4cmVOnK1n6AQD+A2Cr28XCWWng8/5cpndMVdU9
   wpIIBbyM+UFqYdffhLYTMjlMuORIJ47M+LMAelQRzAXwPqyGo8k6ABnVV
   8t02Dbpi7No55Kr/hdr0c5hb2vNGp8gxANZx4O9sti75GVj6QGiNnvdZW
   O1urVSqUVv7KF/yaKYN5NLbo+6HPDQO9TVgnBEzDDRNILn4WYbQdWdy9/
   Q==;
X-CSE-ConnectionGUID: XNeIfQpTT7Kk5Kw3StOvkg==
X-CSE-MsgGUID: V9S/1UrNRJW+DSbHzVl8DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="75873562"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="75873562"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 09:23:30 -0700
X-CSE-ConnectionGUID: rNRhxPlZTPqf4Kgi9QflkA==
X-CSE-MsgGUID: oIw3JplNSjaYtPOevmeJtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143285594"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2025 09:23:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKJYo-000VrE-3D;
	Wed, 28 May 2025 16:23:23 +0000
Date: Thu, 29 May 2025 00:22:37 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	eballetbo@gmail.com, abelvesa@linux.com, b38343@freescale.com,
	yibin.gong@nxp.com, Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 4/6] input: pf1550: add onkey support
Message-ID: <202505290028.2lbquDkW-lkp@intel.com>
References: <20250527-pf1550-v3-4-45f69453cd51@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-pf1550-v3-4-45f69453cd51@savoirfairelinux.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Kayode-via-B4-Relay/dt-bindings-mfd-add-pf1550/20250528-062840
base:   0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
patch link:    https://lore.kernel.org/r/20250527-pf1550-v3-4-45f69453cd51%40savoirfairelinux.com
patch subject: [PATCH v3 4/6] input: pf1550: add onkey support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250529/202505290028.2lbquDkW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505290028.2lbquDkW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505290028.2lbquDkW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/misc/pf1550-onkey.c:153:12: warning: 'pf1550_onkey_resume' defined but not used [-Wunused-function]
     153 | static int pf1550_onkey_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/input/misc/pf1550-onkey.c:126:12: warning: 'pf1550_onkey_suspend' defined but not used [-Wunused-function]
     126 | static int pf1550_onkey_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~


vim +/pf1550_onkey_resume +153 drivers/input/misc/pf1550-onkey.c

   125	
 > 126	static int pf1550_onkey_suspend(struct device *dev)
   127	{
   128		struct platform_device *pdev = to_platform_device(dev);
   129		struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
   130		struct irq_domain *domain;
   131		unsigned int virq;
   132		int i;
   133	
   134		domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
   135	
   136		if (!device_may_wakeup(&pdev->dev)) {
   137			regmap_write(onkey->pf1550->regmap,
   138				     PF1550_PMIC_REG_ONKEY_INT_MASK0,
   139				     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
   140				     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
   141		} else {
   142			for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
   143				virq = irq_find_mapping(domain, i);
   144	
   145				if (virq)
   146					enable_irq_wake(virq);
   147			}
   148		}
   149	
   150		return 0;
   151	}
   152	
 > 153	static int pf1550_onkey_resume(struct device *dev)
   154	{
   155		struct platform_device *pdev = to_platform_device(dev);
   156		struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
   157		struct irq_domain *domain;
   158		unsigned int virq;
   159		int i;
   160	
   161		domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
   162	
   163		if (!device_may_wakeup(&pdev->dev)) {
   164			regmap_write(onkey->pf1550->regmap,
   165				     PF1550_PMIC_REG_ONKEY_INT_MASK0,
   166				     ~((u8)(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI |
   167				     ONKEY_IRQ_2SI | ONKEY_IRQ_3SI | ONKEY_IRQ_4SI |
   168				     ONKEY_IRQ_8SI)));
   169		} else {
   170			for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
   171				virq = irq_find_mapping(domain, i);
   172	
   173				if (virq)
   174					disable_irq_wake(virq);
   175			}
   176		}
   177	
   178		return 0;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

