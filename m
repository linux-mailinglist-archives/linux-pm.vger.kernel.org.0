Return-Path: <linux-pm+bounces-14421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53C97C13F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ED31C21446
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE91CA6B6;
	Wed, 18 Sep 2024 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ta25809g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A11C57AA;
	Wed, 18 Sep 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693977; cv=none; b=Cl5NSu1ky+o1l2uUdQfFYIsiMBM0g2wv5waZUkZn5PbmrDjlLJ92WJRlu+xu+YPq9KM7ueSEn4VQj4AQ5I8YRpcDlc2pgaMhU6f545MauYPDPO1cv/rCq95sSd5mfiDydd3x7saiGkeOyxt8HPp5b3ZxgP3UlDgXrJi9b7pFLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693977; c=relaxed/simple;
	bh=EuIAYQen4UEyM5aIIdtqLWQXGCDcfNVSaN6O6Jib6yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZJHe8LL1aK9pNC6cXAmqoYdrEC0jX2M3nXTvjJ30pfsEDki4rG2MeTmjO2m7cPNm+aihRjX6OyGyozvjNo8rRbtevN296HarAO9lEjoMPboyGF37zFTCEwpHZEtTtHPi/vqSPhZF8w9bixKj2Tb8z+N4zVRqrYqWYwo+n39k8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ta25809g; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726693975; x=1758229975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EuIAYQen4UEyM5aIIdtqLWQXGCDcfNVSaN6O6Jib6yg=;
  b=Ta25809gclqGjnpwwhb2pIr9nEnuoS7w0CE5JR4SZUyFsB3GijjvE7D7
   1lIeAhxOq0waDwjsTvZowISXMmUX+StbYUHrumgm7PYBjBkwMJ0ztJuKK
   DYMdX344m/055e0bYfDxVAc6q/LBhfsdDXJqeNIg681NfR69pozgSHroR
   cNUIPz6KZxcC00h3fXNNpAVGo1huCYRTliKGyNNRfNgfRzMfzbHPy6krE
   n0V4odrye4IDMYOYUh9NQyD9AZPUjKZ2h9DhnwWupuqXXU6ysVGpOSnQN
   dorSH1JwVThGh3Hn44gs0GwSAl5wH8PcISzqj9LAHjfP0aOlegkPxMM4O
   w==;
X-CSE-ConnectionGUID: IDjrI6iYTBSB+44Xtrvkmw==
X-CSE-MsgGUID: ORCw4Su+Sj23piTKM+5UpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29371531"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="29371531"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 14:12:54 -0700
X-CSE-ConnectionGUID: TfTSnpzaRZOE0gtisMt6sg==
X-CSE-MsgGUID: idQGEEQ8Q8CujhvjrhfCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="70164644"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 14:12:52 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr1yj-000Cdo-0n;
	Wed, 18 Sep 2024 21:12:49 +0000
Date: Thu, 19 Sep 2024 05:11:49 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
	Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 3/3] power: supply: initial support for TWL6030/32
Message-ID: <202409190409.0mOjgpq4-lkp@intel.com>
References: <20240918084132.928295-4-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918084132.928295-4-andreas@kemnade.info>

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master v6.11 next-20240918]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/dt-bindings-power-supply-Add-TI-TWL603X-charger/20240918-164406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240918084132.928295-4-andreas%40kemnade.info
patch subject: [PATCH 3/3] power: supply: initial support for TWL6030/32
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240919/202409190409.0mOjgpq4-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190409.0mOjgpq4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409190409.0mOjgpq4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/power/supply/twl6030_charger.c:20:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/power/supply/twl6030_charger.c:20:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/power/supply/twl6030_charger.c:20:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/power/supply/twl6030_charger.c:24:
   In file included from include/linux/usb/otg.h:13:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/power/supply/twl6030_charger.c:360:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     360 |                 u8 intstat;
         |                 ^
   8 warnings generated.


vim +360 drivers/power/supply/twl6030_charger.c

   345	
   346	static int twl6030_charger_usb_get_property(struct power_supply *psy,
   347						    enum power_supply_property psp,
   348						    union power_supply_propval *val)
   349	{
   350		struct twl6030_charger_info *charger = power_supply_get_drvdata(psy);
   351		int ret;
   352		u8 stat1;
   353	
   354		ret = twl6030_charger_read(CONTROLLER_STAT1, &stat1);
   355		if (ret)
   356			return ret;
   357	
   358		switch (psp) {
   359		case POWER_SUPPLY_PROP_STATUS:
 > 360			u8 intstat;
   361	
   362			if (!(stat1 & VBUS_DET)) {
   363				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
   364				break;
   365			}
   366			ret = twl6030_charger_read(CHARGERUSB_STATUS_INT2, &intstat);
   367			if (ret)
   368				return ret;
   369	
   370			if (intstat & CHARGE_DONE)
   371				val->intval = POWER_SUPPLY_STATUS_FULL;
   372			else if (intstat & CURRENT_TERM)
   373				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
   374			else
   375				val->intval = POWER_SUPPLY_STATUS_CHARGING;
   376			break;
   377		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   378			if (!charger->channel_vusb)
   379				return -ENODATA;
   380	
   381			ret = iio_read_channel_processed_scale(charger->channel_vusb, &val->intval, 1000);
   382			if (ret < 0)
   383				return ret;
   384	
   385			break;
   386		case POWER_SUPPLY_PROP_ONLINE:
   387			val->intval = !!(stat1 & VBUS_DET);
   388			break;
   389		case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
   390			val->intval = charger->input_current_limit;
   391			break;
   392		default:
   393			return -EINVAL;
   394		}
   395	
   396		return 0;
   397	}
   398	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

