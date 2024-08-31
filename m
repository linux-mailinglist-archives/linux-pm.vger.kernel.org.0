Return-Path: <linux-pm+bounces-13273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7E966F86
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 07:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4901F238DC
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C81531EC;
	Sat, 31 Aug 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXDV2zZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05581531D0;
	Sat, 31 Aug 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083519; cv=none; b=Y6vZ0N1AR1aP/Fjck9KJl98tPd7n4gpdwwsNHs55tUAcUBBI7aX0GqIanllM2LAtUnjd8SIKHubWeOhs1RlLqqLRlkric67cUjxTSw3J7a0NlwCc0eJVYO2FOlDmEKxeTrxl/yqqg5kL/demMtt1+z/ClyHcVFCZ6lpCZS2k550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083519; c=relaxed/simple;
	bh=gPZnJLAmb2ixn8ewvoBsQp1uqRI1JfKOKD/pMy6DPEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3DWvOzAfGedBafrPr00W3hd3khzxagbFkFt7kaEOu3ReSvpqqkXaPbrD3bNQvswTr3Yixy1lM9Vx6HL773CouhXMCWFfzAYqSnz34AJ8CUB2mvxNHaRVBXV6IpVWongnlfRPa+OapCg41+RBPEG4IKsp53Bas6nkRgVsy9/CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXDV2zZr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725083515; x=1756619515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gPZnJLAmb2ixn8ewvoBsQp1uqRI1JfKOKD/pMy6DPEs=;
  b=MXDV2zZrjOs73n8Ig9wrrUsz71Zyj6zmpUDV+p0NrXjWy5H4aTwGG225
   6edJGq3cJK+pzQEwrkLEZZRPvvyUE8qvXMayA/e6tUrhRVmDFSnRp/iVJ
   /C/Smb8h2b8qGeCY4HrV0pK4+1C7Aoxgp70l+r8R1cedomtr3VQo8f0dq
   7ujdqxxlEpl0ylxB1hQtO+wAbPEknXiE8gyuKcMx+ENYAw3NrewMX9nWv
   ALlT3+fSJqQbeJ6/Ok1WeC2q8BVdvQOtJdiyrIzSSrKA8FXV8BNFbKZGz
   IPduqnidWEqj4hq9I+hETcwpO0pPeDd/4X2oW37cFs75CChgXXwbWY7o5
   Q==;
X-CSE-ConnectionGUID: Rcq+VS/qQXWF1fs44yHyVg==
X-CSE-MsgGUID: LB2NTPwCQTim/yXiJb7cwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26641534"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="26641534"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 22:51:55 -0700
X-CSE-ConnectionGUID: Lmh+3MbJTRatYH3r/JoKcg==
X-CSE-MsgGUID: rVRYx+vlQuis3rwFQlpgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68996526"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Aug 2024 22:51:48 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skH1V-0002NU-2w;
	Sat, 31 Aug 2024 05:51:45 +0000
Date: Sat, 31 Aug 2024 13:51:04 +0800
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
Subject: Re: [PATCH v2 1/7] regulator: dt-bindings: mt6323: Convert to DT
 schema
Message-ID: <202408311355.zKsAfb64-lkp@intel.com>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-1-macpaul.lin@mediatek.com>

Hi Macpaul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on lee-mfd/for-mfd-next robh/for-next lee-mfd/for-mfd-fixes linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Macpaul-Lin/dt-bindings-mfd-mediatek-mt6397-Convert-to-DT-schema-format/20240830-191309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20240830110732.30080-1-macpaul.lin%40mediatek.com
patch subject: [PATCH v2 1/7] regulator: dt-bindings: mt6323: Convert to DT schema
reproduce: (https://download.01.org/0day-ci/archive/20240831/202408311355.zKsAfb64-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311355.zKsAfb64-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml references a file that doesn't exist: Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

