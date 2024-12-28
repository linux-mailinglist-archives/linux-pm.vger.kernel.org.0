Return-Path: <linux-pm+bounces-19799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC69FD8FD
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 06:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B218855FA
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 05:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D742056;
	Sat, 28 Dec 2024 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+nqXD2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA47635;
	Sat, 28 Dec 2024 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735362760; cv=none; b=NUBHSUMBEnPdCu9mDKpSMDpBeuoogZ/F2NS2YboQnlMXh3RXDaCuQM7h8sgZa+/vS0EgisWZsg1quqUhsaXmGUP7IE2hCwuSKpSOwdSlFROaU6ymIHR320N+YlDHITSKR2mt3TeghIvMcpcUE8/d3UEv/mEzw24/iGE6w1Wj4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735362760; c=relaxed/simple;
	bh=ioBF6btaLkebkM4HUjVJqFMRdhQwf4/nTJIficbpk6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxjSDMzcWmckaPGhCR6fL0JI858l5l+1zOASFzn77OCCuzryODBYTiLzAE0lYJuTlHLO/wDeoFEgDA2f7GuihW0nIGhgnbKiDrjTZj7F8hbS5cFqIvBbD9tDnAmM+HMXt3qMJ+xUUnAb5IvkAcbMQFC965BZTvtVHPdC/mKRBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+nqXD2n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735362759; x=1766898759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ioBF6btaLkebkM4HUjVJqFMRdhQwf4/nTJIficbpk6U=;
  b=U+nqXD2nmQVQST7bnip6BnxnvThstknorCV7bt7/MFS7kAILsQNF4f6g
   7Tw8jU98YmjmZ2mtVvaGApVevXRVwFa3JqteyR13jNcFzXkCF1fLE6LYc
   1fB079cNpdPNrsBr84o8H5qaGOVjTdc2XNfXh0zbQUPMsihRFdGg4UTkC
   +Md1baPrfThIfJM/yd5g9kF5khpqpAP19LlUP05JNEpF2lFKvz8SukrAa
   KRH4vfRfqZAs80CrXIHgA5szL5rD/m9rts4k1BSHexGHHAeDUWNP6NfpP
   IxH8/0WP2GD0NVGWG7QWvhlhJ0nKu5GZuVKvJewUkciyBgQxC53KFOiRW
   g==;
X-CSE-ConnectionGUID: BH4bLxumSqSPROke80GvFA==
X-CSE-MsgGUID: WaSav+V8RYiIFRWgZBIL4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="35886915"
X-IronPort-AV: E=Sophos;i="6.12,271,1728975600"; 
   d="scan'208";a="35886915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 21:12:38 -0800
X-CSE-ConnectionGUID: h4uyA0ddSTuuZ4tzLd9DvQ==
X-CSE-MsgGUID: Go8sLyvHTGyzRo44j8EaKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131267180"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Dec 2024 21:12:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRP7m-0003rw-0r;
	Sat, 28 Dec 2024 05:12:30 +0000
Date: Sat, 28 Dec 2024 13:11:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 03/12] input: keyboard: omap4_keypad: Use
 devm_pm_set_wake_irq
Message-ID: <202412281211.h6tPLOqJ-lkp@intel.com>
References: <20241228-wake_irq-v1-3-09cfca77cd47@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228-wake_irq-v1-3-09cfca77cd47@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/PM-sleep-wakeirq-Introduce-device-managed-variant-of-dev_pm_set_wake_irq/20241228-091859
base:   8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
patch link:    https://lore.kernel.org/r/20241228-wake_irq-v1-3-09cfca77cd47%40nxp.com
patch subject: [PATCH 03/12] input: keyboard: omap4_keypad: Use devm_pm_set_wake_irq
config: i386-buildonly-randconfig-002-20241228 (https://download.01.org/0day-ci/archive/20241228/202412281211.h6tPLOqJ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241228/202412281211.h6tPLOqJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412281211.h6tPLOqJ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
>> ERROR: modpost: "devm_pm_set_wake_irq" [drivers/input/keyboard/omap4-keypad.ko] undefined!
WARNING: modpost: module snd-compress uses symbol dma_buf_fd from namespace DMA_BUF, but does not import it.
WARNING: modpost: module snd-compress uses symbol dma_buf_get from namespace DMA_BUF, but does not import it.
WARNING: modpost: module snd-compress uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

