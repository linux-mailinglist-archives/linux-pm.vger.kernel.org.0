Return-Path: <linux-pm+bounces-39764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02806CD3C79
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 08:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FBEA300B839
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCDE2222B2;
	Sun, 21 Dec 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPk2S39r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F4219FC;
	Sun, 21 Dec 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766302382; cv=none; b=X10QZipiG1roYsB9sXe98UlAG/NXIc+5Cu9I+HZ3mN2ek77k6m2WvMMDDwvM6WFtpm1OeCCtG0sr9RMSXBNMs4OKUYKcQ9a4Kv169tmlmGp7UP48vRZtoYaW0toJJ9G0NMH1VwVhtfLy0ohjSIfpTTedtmGKKxJfV9Vtf84yQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766302382; c=relaxed/simple;
	bh=acLNH9XZUwJ+/RUGFg15css9I9hbu1oRWu7mAn9c4XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/O1m9GZTOAgylmIYJYrNr0XcG+XmA1bwazlIj7TDQbXaoHpBsDGDLK9p6z+PWAJI6xQWfcIqblO7ULwT6jvnLbFS18k4ZfujWDZcitXdyV0Ca7gFO8p+/gWuuJBDXfk3+YYGvzdmawEdjk+f+LBzFWcOJc9PCAiPpyQQiYInsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPk2S39r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766302382; x=1797838382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=acLNH9XZUwJ+/RUGFg15css9I9hbu1oRWu7mAn9c4XA=;
  b=RPk2S39raFefSgmMNL0y5LirZF3+SeuONNQCzGK4byi/x1LEx9q474cj
   iW56eXHfAY9AN2Bpk3B8Jw+dT2jY0FxpX9yRi8naVqlpP7FNberdU6jTi
   FiThVkaBTMVrtAbVi7MuR/IVn4OStNVjPHUm4d6jmx/Yad0/9FFK4+ICE
   BdaSrVKSy0OLdogdqjxiZMKjuddRQWt3d4L2zlvTSG0WZ+Yam4A2wOe+c
   +Pmbsh/xUgYzfA3+lLMMmlUJ5OKj4XClExenhPxPyI9Fwl2a+GR61QBxk
   UV78boy3OrzOrkyeVF0hYFeYz3YWumxzfxT1Y7h5KBN6WtyEmFuW87zpE
   g==;
X-CSE-ConnectionGUID: CX1f3As1SsaW36+vJQgT2g==
X-CSE-MsgGUID: PDiZ2seDSSqobsyt3i42yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="72044553"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="72044553"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 23:33:01 -0800
X-CSE-ConnectionGUID: WhT26M+xQ7i3MqpLrDYIvA==
X-CSE-MsgGUID: /f0OMu86QL+ajuC4w0edDw==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2025 23:32:56 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXDvx-000000004y0-3IUv;
	Sun, 21 Dec 2025 07:32:53 +0000
Date: Sun, 21 Dec 2025 08:31:59 +0100
From: kernel test robot <lkp@intel.com>
To: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH v2 4/5] power: supply: max77759: add charger driver
Message-ID: <202512210844.O8gAG2p9-lkp@intel.com>
References: <20251218-max77759-charger-v2-4-2b259980a686@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-max77759-charger-v2-4-2b259980a686@google.com>

Hi Amit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-fixes]
[also build test WARNING on sre-power-supply/for-next usb/usb-testing usb/usb-next usb/usb-linus v6.16-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Amit-Sunil-Dhamne-via-B4-Relay/dt-bindings-mfd-maxim-max77759-add-charger-child-node/20251219-065531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-fixes
patch link:    https://lore.kernel.org/r/20251218-max77759-charger-v2-4-2b259980a686%40google.com
patch subject: [PATCH v2 4/5] power: supply: max77759: add charger driver
reproduce: (https://download.01.org/0day-ci/archive/20251221/202512210844.O8gAG2p9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210844.O8gAG2p9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_CN/how-to.rst references a file that doesn't exist: Documentation/xxx/xxx.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
   Warning: arch/riscv/kernel/kexec_image.c references a file that doesn't exist: Documentation/riscv/boot-image-header.rst
   Warning: drivers/clocksource/timer-armada-370-xp.c references a file that doesn't exist: Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
   Warning: include/rv/da_monitor.h references a file that doesn't exist: Documentation/trace/rv/da_monitor_synthesis.rst
   Using alabaster theme
   ERROR: Cannot find file ./include/linux/pci.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

