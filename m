Return-Path: <linux-pm+bounces-10085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C40919B06
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 01:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22216283265
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAE1940A1;
	Wed, 26 Jun 2024 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw4BKMAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8C18FDCD;
	Wed, 26 Jun 2024 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443276; cv=none; b=JL6bo0dSp5kk7f3liU9LiBy1sSgoUrriuouHZaMhr/hQ4toLrUHW0gyZd/qW2vQKaS/1cRtBPij5Np08VdlfcqkwdRmO9N9nmfdD+uwnsHYfZ/12dZDEdN8dog4A9574NITzGYwVf9cK02bNgZuMDazSPUoKvW/YD/rTuWjcKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443276; c=relaxed/simple;
	bh=bGsS6QAH1iQGXflkC3m0fScbHj4wlKNAw4ntnVc0CEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT/PkaAn5TB8kMJYaIUfrKBa1XG2RdliFtiuB0ELSqsO24E7cI9/ocTMVpNPBZ+RV0DEeR8Fptyfxl9UsuBIhhjW15FTKqXv3G+9UdRXItlKR704Z+4lMHudvBfYlr+kQ1EwXUHzaEoGXx45f2pLLHNaI4+vcwLSwte746NaFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw4BKMAp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719443274; x=1750979274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bGsS6QAH1iQGXflkC3m0fScbHj4wlKNAw4ntnVc0CEY=;
  b=Kw4BKMApq0+bZxmEbkuMjKQFa+DLnmaxZn0AV+Tb5SdsnipwcipGfbYH
   JdFt+ndDARQbGgyGHIcFmImLqkKmpwMhCcekxK6QbYH6yIEsHyzDdn9iQ
   hzPBsyMPgovVl9brocdX4BvFJQiT8kjn/LdxuSVcotDGEi6S3uA1KIVuK
   CpaESrvv7w1Qt+gIi1xiRCmWcjibTYrQS3cM7OA6ENnC/DO2gGDSAQje1
   6WMHdjpUj9HuiJwCbPHWIRKZKVi1y0GGOpD82AiHcXabpQPsyHlkVaI7Z
   B8E7sCvKMdLlxOqsPA7zCXMO5k7J3XSEQM7R4R06Y5p5qNkqwfGeYlCNN
   A==;
X-CSE-ConnectionGUID: ls/XAyU1S7u1OvpoUMgOMA==
X-CSE-MsgGUID: 0AWQRi/ETRKkzv3jJLpP9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="34078217"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="34078217"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 16:07:53 -0700
X-CSE-ConnectionGUID: V9jZL/3xQI6a9qnQu9Z9UQ==
X-CSE-MsgGUID: LAfmfYIOQZ2TdpOB7fLhaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="67390811"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2024 16:07:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMbjv-000Fe6-1J;
	Wed, 26 Jun 2024 23:07:47 +0000
Date: Thu, 27 Jun 2024 07:06:56 +0800
From: kernel test robot <lkp@intel.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thermal: sti: depend on THERMAL_OF subsystem
Message-ID: <202406270605.qodaWd4n-lkp@intel.com>
References: <20240625-thermal-v2-2-bf8354ed51ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-thermal-v2-2-bf8354ed51ee@gmail.com>

Hi Raphael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/thermal-st-switch-from-CONFIG_PM_SLEEP-guards-to-pm_sleep_ptr/20240626-090203
base:   0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
patch link:    https://lore.kernel.org/r/20240625-thermal-v2-2-bf8354ed51ee%40gmail.com
patch subject: [PATCH v2 2/3] thermal: sti: depend on THERMAL_OF subsystem
config: arm64-kismet-CONFIG_ST_THERMAL-CONFIG_ST_THERMAL_MEMMAP-0-0 (https://download.01.org/0day-ci/archive/20240627/202406270605.qodaWd4n-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240627/202406270605.qodaWd4n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270605.qodaWd4n-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ST_THERMAL when selected by ST_THERMAL_MEMMAP
   WARNING: unmet direct dependencies detected for ST_THERMAL
     Depends on [n]: THERMAL [=y] && (ARCH_STI || ARCH_STM32 [=y]) && OF [=y] && THERMAL_OF [=n]
     Selected by [y]:
     - ST_THERMAL_MEMMAP [=y] && THERMAL [=y] && (ARCH_STI || ARCH_STM32 [=y]) && OF [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

