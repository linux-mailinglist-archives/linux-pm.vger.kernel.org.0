Return-Path: <linux-pm+bounces-38682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C48AC88730
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 08:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652454E273F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99162C0265;
	Wed, 26 Nov 2025 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhLPpFNV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331A2BE04F;
	Wed, 26 Nov 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142784; cv=none; b=PfrX6ttp0iN6rCzPvZKREzIcKK9o3vwbeyhZgcm7qpYR6egMeDn/IvlDNlVg8NwakR8Ef9KwOs9+G4nbwptVJENH49zeJH1n7R/ZX4vx9GoLIAQPD9DCL42xST8rUo6j5c6pZSPFjpGhBH6LbSGMkQT1gsKOZGClOjQi402NYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142784; c=relaxed/simple;
	bh=EMct42WoiiGjcksMl7vwP//cvhacHtrR+zrVyuvWuGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7Q8M3Gguvxmhf2eZFOhdpg1mCbdbMzQqrf7Y79fiSdyuM7xHtEG76EDZYy0C7OrlSU+gE2ajqzTI37Uv8cKgLB/HoQiztbfD6t/5aH2Ow0a2DI/cfbQhxlQ/YwT14n87H3kbQCogNiZLuaEM68Fbbi08FuWCPLumKDxNGgcOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhLPpFNV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764142784; x=1795678784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EMct42WoiiGjcksMl7vwP//cvhacHtrR+zrVyuvWuGI=;
  b=GhLPpFNVgOverOCUQfJGJCSkLsHbY8xqZVaP+7fgRIoy5kDDlWeH8zSx
   fsDwRTTU1VioNK3pJhS5bH3x/aApBEpixA3ejB3YWJjsuRSrzE8fHmau8
   hsaTx6bMI7QU79dcISQDdFxLqkPxngUO3zO9gBP6c36RQn3C9DMRKqakp
   kcXldyFQKpFpvz+w4QkbnMQKVLklZX8DqMJb3unRYTdW5LFy1dVXn0YSg
   i7o5xvt2kNF1RNEjjoYprOohTS3BmLREZAtVQe4Uc/UqP02EX5wvsHE45
   RVxKI/vgkxKAT1Tgz4dxeclyUKpUCnf27/buelwASbJq/4fLFV33NxVqm
   A==;
X-CSE-ConnectionGUID: qcCy/TseTMC0yI3U/jV/IQ==
X-CSE-MsgGUID: EAQlX/hCRPeNIt/D5RhMvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83563493"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="83563493"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:39:43 -0800
X-CSE-ConnectionGUID: U+ariKqbS4mjldTk3ROtsw==
X-CSE-MsgGUID: LJpZH5gTQ9ah/6mzKzzK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="193297094"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 23:39:37 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOA7i-000000002bl-41Uh;
	Wed, 26 Nov 2025 07:39:34 +0000
Date: Wed, 26 Nov 2025 15:38:54 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH 5/6] power: supply: max77759: add charger driver
Message-ID: <202511261521.hSYp4ttf-lkp@intel.com>
References: <20251123-max77759-charger-v1-5-6b2e4b8f7f54@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-max77759-charger-v1-5-6b2e4b8f7f54@google.com>

Hi Amit,

kernel test robot noticed the following build errors:

[auto build test ERROR on 39f90c1967215375f7d87b81d14b0f3ed6b40c29]

url:    https://github.com/intel-lab-lkp/linux/commits/Amit-Sunil-Dhamne-via-B4-Relay/dt-bindings-power-supply-Add-Maxim-MAX77759-charger/20251123-163840
base:   39f90c1967215375f7d87b81d14b0f3ed6b40c29
patch link:    https://lore.kernel.org/r/20251123-max77759-charger-v1-5-6b2e4b8f7f54%40google.com
patch subject: [PATCH 5/6] power: supply: max77759: add charger driver
config: um-randconfig-001-20251126 (https://download.01.org/0day-ci/archive/20251126/202511261521.hSYp4ttf-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511261521.hSYp4ttf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511261521.hSYp4ttf-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: drivers/power/supply/max77759_charger.o: in function `max77759_charger_probe':
>> max77759_charger.c:(.ltext+0x27b): undefined reference to `devm_regulator_register'
   /usr/bin/ld: drivers/power/supply/max77759_charger.o: in function `enable_usb_otg':
>> max77759_charger.c:(.ltext+0x983): undefined reference to `rdev_get_drvdata'
   /usr/bin/ld: drivers/power/supply/max77759_charger.o: in function `disable_usb_otg':
   max77759_charger.c:(.ltext+0x9c3): undefined reference to `rdev_get_drvdata'
   /usr/bin/ld: drivers/power/supply/max77759_charger.o: in function `usb_otg_status':
   max77759_charger.c:(.ltext+0xa06): undefined reference to `rdev_get_drvdata'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

