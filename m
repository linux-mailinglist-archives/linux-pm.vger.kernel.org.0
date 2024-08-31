Return-Path: <linux-pm+bounces-13278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84B967048
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D27E1F218B2
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28716EB7C;
	Sat, 31 Aug 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NL6KefUk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754F3A1AC;
	Sat, 31 Aug 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091679; cv=none; b=ctyE8cZ+JVpseyFiMM6Yml+MMSUWvzpVPRrcZEKrvnlsXFTB4iUiMf9IVxrOQSIF2s0IIXeIxy1ejmDyFSut+fkm6BGgKpyVszdIVwfD53qpFyKvx3Vtw96GtbIIwaObCdnn2gOGylJlLRtjuD17HfSPZRf1enZn1YTKOyIAO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091679; c=relaxed/simple;
	bh=pMyd6VJ5fw/wGHIvhzQNZYG4qJelaQ5hTMxf5GnoR3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYSn5xBNxh8ba+Z1nNX3WPEMia4ZOHPXUyhj2YffRtCyFmfSi+jTOw3DZ3vE/agECygme2AxUjx8VZAMeIX1pU/gkGMDpko7p3T2ew/xokYVl7DfZhsMUPHO0+HmmDkrlVLq5Pa0CSLIO5vr3/TPZJ1DRVM9GuXVEA7JKZ+nHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NL6KefUk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725091678; x=1756627678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMyd6VJ5fw/wGHIvhzQNZYG4qJelaQ5hTMxf5GnoR3c=;
  b=NL6KefUkOr+IN0DnYlV0AjeZBOsYYd8uvfx/KG6W5kJ9muO7YmMm8fcS
   2xVn+sQXoVFkfbFxagFWeWv+5boKpn3pohGrBuwxzk6t8PKmwZbO/nx2v
   dLM6EsBnvrMC31kgz59DjqCGqNPl9L5E/D0dGzKuW+CWi3tzZBeGesu7v
   1MVo23fsqeltxJQwjPbSiLJ/wsccCOb3aES22mvJyu4KK+guuVwlUbOX9
   blDXKI4TyrRH6mkPjKesLkjNYjtvxC+RbMHnaOftZ6S0EjHfbloWD5rGp
   stx4GCOBOFm20oRLES8bTRCTKQoOusKigy0RVmswHjF4O7MFg54ihwFkj
   Q==;
X-CSE-ConnectionGUID: EHzDdnjqRPmsqxrr/GYwgQ==
X-CSE-MsgGUID: +UwtKZg1R0KruCwnWtcZHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23898825"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23898825"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 01:07:57 -0700
X-CSE-ConnectionGUID: +yHVbmu0R8O+HNdeMbMqzg==
X-CSE-MsgGUID: QuDWnnohQq6+5BdwTdhPig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64167540"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2024 01:07:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJ9A-0002Ra-2m;
	Sat, 31 Aug 2024 08:07:48 +0000
Date: Sat, 31 Aug 2024 16:06:53 +0800
From: kernel test robot <lkp@intel.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Flora Fu <flora.fu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: leds: mt6323: merge to MFD
 mediatek,mt6397 DT schema
Message-ID: <202408311533.GPosdKVY-lkp@intel.com>
References: <20240830110732.30080-5-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-5-macpaul.lin@mediatek.com>

Hi Macpaul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on next-20240830]
[cannot apply to lee-mfd/for-mfd-next robh/for-next lee-mfd/for-mfd-fixes linus/master v6.11-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Macpaul-Lin/dt-bindings-mfd-mediatek-mt6397-Convert-to-DT-schema-format/20240830-191309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20240830110732.30080-5-macpaul.lin%40mediatek.com
patch subject: [PATCH v2 5/7] dt-bindings: leds: mt6323: merge to MFD mediatek,mt6397 DT schema
reproduce: (https://download.01.org/0day-ci/archive/20240831/202408311533.GPosdKVY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311533.GPosdKVY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/leds-mt6323.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

