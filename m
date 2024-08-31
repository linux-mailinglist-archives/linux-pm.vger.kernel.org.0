Return-Path: <linux-pm+bounces-13277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF52966FF1
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 09:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF8A1C20D9E
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266217CA12;
	Sat, 31 Aug 2024 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edQ7Gt8m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AA16D4FF;
	Sat, 31 Aug 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087901; cv=none; b=iGBIg0GU/M398RzNBNYunXK9PdNx8vK9REmFZfgfg0Pa2A4pV+xHu9YfohU0iNwPcGFHYduqUX/ExTZF6jtNQ93HgdW01pYOhjGI+dH0bi3aHLRGwWgWjjNmHftBmzezayFKYftDX+yLEFjIfr8L+NXjN1PP4zSHpFU6kqr6wRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087901; c=relaxed/simple;
	bh=2MIvjife9TxEOVM4N//TXAhsxKXULju5kqrwtaSFDZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlSWikrWS/P96BIo92EMU07/hwntbHvWLeBEXD1WPRf9dznPfwh4lb5qJzhbW+g1fFq+4VlvKv2dzUA6oD5+C4V8i85SUTWy1qv38pD2Y1WG8NsfZ7Lf/D4T23H4jCU72YhPxwGfDT6QOHCdTJqVZmmFSlR1eBaG8KBkDl2u29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edQ7Gt8m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725087897; x=1756623897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2MIvjife9TxEOVM4N//TXAhsxKXULju5kqrwtaSFDZI=;
  b=edQ7Gt8mmXBpdXS9M/rn/3IwDMuaaSnCpuiz4eJEPB9rRkL5FPvCnoo5
   lTSK1r3E/Hrshovh9++k5y8xbV8JGP+5LYX51+K/iqEvL4QvFNVS0BITY
   BuieiZWpTGXH2hrVCx3AHsa/YrkVaMQxnhK5AtOyqp9+RD7CRKHTYY4fY
   FLMHC3GrJ3b4PIq/h+zeWc5WzQYLoNY1m3XlEykh5P1YyR9FAr7/01Ms8
   yebvpIqB8ze8h1yINOONHoG5uU8ELn0g3qr65ONOrVSGp9IarO8eK1B7k
   hZTpnE1AJYHKf83mdcwLNjKMy6a0e2UacyinreffO0XpSBdsVL4WQxUbv
   Q==;
X-CSE-ConnectionGUID: 9DsinZPPTMGN9Fwb6WQmUQ==
X-CSE-MsgGUID: QIXGcIBHRRqI5hgpLNw4Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="35142355"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="35142355"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 00:04:56 -0700
X-CSE-ConnectionGUID: pBaWsdrATdClvQIISpIntA==
X-CSE-MsgGUID: PGOW7AjMQ2qLPMI3JEsoQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64160004"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2024 00:04:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skIAC-0002Ps-0A;
	Sat, 31 Aug 2024 07:04:48 +0000
Date: Sat, 31 Aug 2024 15:04:06 +0800
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
Subject: Re: [PATCH v2 2/7] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <202408311453.Ui9YGyJc-lkp@intel.com>
References: <20240830110732.30080-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-2-macpaul.lin@mediatek.com>

Hi Macpaul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on lee-mfd/for-mfd-next robh/for-next lee-mfd/for-mfd-fixes linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Macpaul-Lin/dt-bindings-mfd-mediatek-mt6397-Convert-to-DT-schema-format/20240830-191309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20240830110732.30080-2-macpaul.lin%40mediatek.com
patch subject: [PATCH v2 2/7] dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format
reproduce: (https://download.01.org/0day-ci/archive/20240831/202408311453.Ui9YGyJc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311453.Ui9YGyJc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6397.txt
   Warning: Documentation/devicetree/bindings/leds/leds-mt6323.txt references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6397.txt
   Warning: Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml references a file that doesn't exist: Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

