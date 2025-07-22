Return-Path: <linux-pm+bounces-31287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72385B0E165
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C76C1C84F56
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83E27AC3A;
	Tue, 22 Jul 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noRFXw3m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD127A927;
	Tue, 22 Jul 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200734; cv=none; b=ZSFQZys+Ak8ZpGv88JclPAgF/hMDELVzhQBQUnEvlt+5QCL3YN6B1unjD5Jx/MPIQmhXgWGn19w3ULeKPaSa2s12/N83X2hg8D/rBY771TfJk6aT7L6IzQISPUlJ5kNxA1Y+OQdzN8WbeNKycgv8aQ4lQNb7q7QZOL5C79AMigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200734; c=relaxed/simple;
	bh=wc7sZ3S0IslTIoF+msfigfhqbg/qOeWHRUi0QWVAODE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOOGYAYHp7WBDwYhnSK7V56y+Q9p+NMv1f7AKmUblt3sS+yh6GNSVvlb7XMv+zI3YXrx57NjOV45t5lBtDCZAbdq6bYFyqi6CNdvaOUCIr8z6ZpxhUCwVLjqVI2hYjx1UO6oEDVgG6LNWEuGd8WDNJryfBMsCujVQ/k6F0ZXlz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noRFXw3m; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753200733; x=1784736733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wc7sZ3S0IslTIoF+msfigfhqbg/qOeWHRUi0QWVAODE=;
  b=noRFXw3mo9g61CC5++4ueHBHZ0cw7imw5C7X2M5sZtOxTRI+hup2Jo01
   /U060LWnLAyg45zr1upY3BQmGiBkFzWmbl61Y80scD9QoOINgShlz6W5q
   lIl6CM331qHiDeC8CxcbGMpVCfb41Ak45j+t99wxbQmii2bGLOKEp4V4M
   7qo9eLI1bPCRMpO4B4EtLvS97lAYXV6u6fAN65gVUgakLsrlOfV7MT2wH
   7+B/0PBXCv+JimlTmC+0UuZay1Ibr0Xi0o+dzZHaGBgOzt9uRbzesgbL4
   vQCWer7fTno2FU/earI0WP6D2tResf0rMYYTjQH6D3iCprprMt4712Lns
   A==;
X-CSE-ConnectionGUID: i1womCDjRe6sxvqjOllngw==
X-CSE-MsgGUID: X/gvXTZISHGA3VGT2v/OcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59119994"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59119994"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:12:13 -0700
X-CSE-ConnectionGUID: alaIQqnqRbeNo2GEbzjqGQ==
X-CSE-MsgGUID: hA7iUIOoRXahbK6So4MVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="164835899"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Jul 2025 09:12:05 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueFb0-000IVT-21;
	Tue, 22 Jul 2025 16:12:02 +0000
Date: Wed, 23 Jul 2025 00:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Dmitry Baryshkov <lumag@kernel.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v12 4/8] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Message-ID: <202507222304.UhUacchO-lkp@intel.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-4-87bac3ec422e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-4-87bac3ec422e@oss.qualcomm.com>

Hi Shivendra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 97987520025658f30bb787a99ffbd9bbff9ffc9d]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivendra-Pratap/power-reset-reboot-mode-Add-device-tree-node-based-registration/20250722-023323
base:   97987520025658f30bb787a99ffbd9bbff9ffc9d
patch link:    https://lore.kernel.org/r/20250721-arm-psci-system_reset2-vendor-reboots-v12-4-87bac3ec422e%40oss.qualcomm.com
patch subject: [PATCH v12 4/8] firmware: psci: Implement vendor-specific resets as reboot-mode
config: arm-kismet-CONFIG_REBOOT_MODE-CONFIG_ARM_PSCI_FW-0-0 (https://download.01.org/0day-ci/archive/20250722/202507222304.UhUacchO-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250722/202507222304.UhUacchO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507222304.UhUacchO-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for REBOOT_MODE when selected by ARM_PSCI_FW
   WARNING: unmet direct dependencies detected for REBOOT_MODE
     Depends on [n]: POWER_RESET [=n]
     Selected by [y]:
     - ARM_PSCI_FW [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

