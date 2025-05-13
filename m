Return-Path: <linux-pm+bounces-27090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C194AB5AA2
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677FF189C38D
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40852BF3D5;
	Tue, 13 May 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtnKMIj9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED552BE7A8;
	Tue, 13 May 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155584; cv=none; b=Pzo9MjxVaOujBWXfo7c1HZ7jxlzZeha5f+I87Q2Op/CjhyoYqYCt0QrOHhAtmEFtePVUR1ojktqnsIfa9zN9lqE67vljeH3HVwhJ805F3SEHoCra7IcNeXvZo+9JQN3YcG/1GeCTp89XjpqwID27R6et8HZdtGWUOf45zhgHv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155584; c=relaxed/simple;
	bh=wT1jIMhAfxAIuR2cDTICkJPnwZnAngY5iWaiZPeA23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umrbV1eZjQvfagYQPRIm6tBDEhil0jG60cx6EJU8mw7yPOoX+rTp6Y8NyqT+PxNWhEr++5ZheQFJRWwdyBRz2tabaTgdqO6zofB1L7ryJdcNr9so/cYhFZfZbWNZQwqulq/PbenXWi8x90HpytLvlRajN/7APsiuh4B/7qU54IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtnKMIj9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747155582; x=1778691582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wT1jIMhAfxAIuR2cDTICkJPnwZnAngY5iWaiZPeA23k=;
  b=VtnKMIj9ruIXcnLCmnC7zVl8HjwKIa0Bs59xyKcmxR0UpWFrJxmITueU
   g/82ooNp0kSJ9ztHhLQoHE4GUHnBn3Liqj9YXyJg+ftDnjKzDyYTF2sgV
   2+WN0nTN5Xw8VhvihbBu4cdc090z64phSKFBuuHgoMoWwKNb9PBouW0Hw
   9hykegJBYEhDtZeWVzH5ECAwZAObs+MVNJ3dTnJ4Vg0sRO7eL3+ZxKK8w
   xj+QjsDJx31Me/YcFYGbmmxTRbO7aj7Ur21phdLd22Q4yUymAs6Wj3RZ/
   R0WM339jOFv3gUYFYb7nfRQv7p7b0N2GpGjU6YojCXoQFbgzI7JDHvaNh
   A==;
X-CSE-ConnectionGUID: 3adJXAPSTN+BakvQbuaAbA==
X-CSE-MsgGUID: FfuvJmcjRIGYxXFZ7KL1DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49004968"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49004968"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:59:42 -0700
X-CSE-ConnectionGUID: LqCGDER2TQKzQBomicmxjA==
X-CSE-MsgGUID: tIAkwncLTMKMayszpT6oWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138739643"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 May 2025 09:59:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEsye-000GFT-2d;
	Tue, 13 May 2025 16:59:36 +0000
Date: Wed, 14 May 2025 00:59:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
Message-ID: <202505132238.CSoMFWV9-lkp@intel.com>
References: <20250510172509.2547273-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510172509.2547273-2-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.15-rc6 next-20250513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/thermal-Add-support-for-Airoha-EN7581-thermal-sensor/20250511-012647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20250510172509.2547273-2-ansuelsmth%40gmail.com
patch subject: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal sensor
config: microblaze-randconfig-r073-20250513 (https://download.01.org/0day-ci/archive/20250513/202505132238.CSoMFWV9-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505132238.CSoMFWV9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505132238.CSoMFWV9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/airoha_thermal.c: In function 'airoha_thermal_irq':
>> drivers/thermal/airoha_thermal.c:316:2: error: label at end of compound statement
     316 |  default:
         |  ^~~~~~~


vim +316 drivers/thermal/airoha_thermal.c

   297	
   298	static irqreturn_t airoha_thermal_irq(int irq, void *data)
   299	{
   300		struct airoha_thermal_priv *priv = data;
   301		enum thermal_notify_event event;
   302		bool update = false;
   303		u32 status;
   304	
   305		status = readl(priv->base + EN7581_TEMPMONINTSTS);
   306		switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
   307		case EN7581_HOFSINTSTS0:
   308			event = THERMAL_TRIP_VIOLATED;
   309			update = true;
   310			break;
   311		case EN7581_LOFSINTSTS0:
   312			event = THERMAL_EVENT_UNSPECIFIED;
   313			update = true;
   314			break;
   315		/* Should be impossible as we enable only these interrupt */
 > 316		default:
   317		}
   318	
   319		/* reset interrupt */
   320		writel(status, priv->base + EN7581_TEMPMONINTSTS);
   321	
   322		if (update)
   323			thermal_zone_device_update(priv->tz, event);
   324	
   325		return IRQ_HANDLED;
   326	}
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

