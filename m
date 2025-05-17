Return-Path: <linux-pm+bounces-27268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18CABAC40
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 22:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9837D189E113
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32F214815;
	Sat, 17 May 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAAZM1iQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184B1D514F;
	Sat, 17 May 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512860; cv=none; b=qyj3VJaziV+s3huH4IFvQz0mFUL/gv4urM08G7dat/ueKmtuVq9q4Uo/Q25Z22MjLUe9lEoE51YhGWm0TNY9CdUf+B4OPU+A83ptYy6mB1YPMQ6RrAyyGSdDBGRM5xdU7h3EA8Ni7IKTwyHdKeEMqj+KNyLxLuHSunWBtOYXoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512860; c=relaxed/simple;
	bh=SKCXI74U/gmxDrxYFYuuztblXn49b0th/copPEAX0yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAeFuoc5vb4ll7b7zlSxPy+9ZY6+eNZk+vbpjf3Xoo+iZFLd3fog3y1ypiY9+C1YHoNNwkPzQU2zyrxKEFXXXd6EzJs3jgSahuMZGXoeWk++p+AUSZkScEvxHVHvmmqGXrtzaNUqdpj6/HMqYgYG6+oQyS6fP4qFnSpz9IiXXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAAZM1iQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747512858; x=1779048858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKCXI74U/gmxDrxYFYuuztblXn49b0th/copPEAX0yY=;
  b=NAAZM1iQu7o9eOvMNHvIujreYQZz+EmZIp0DufE9XRk02/XfoSTAC7i0
   Llfu0VMWKRhgy1r6JZgqJIfu6BJ/EbOuR3zec+KlmSeS+DIP5bt6sXwrM
   16QQkBWRV4f6rUMUCUFlCKdPvSnZzugUvUf3Rinycma7gRjHejK99jYTS
   gNf0AeID9nGPJ3AwZlaR2t3JBYiryDZSd9n2V/F3NhUfcyu2/VGsiRG9W
   2zRBUu4Cmel5Hw9ZCUusbmG7cbFS3tMTZZa3UNDZCy72sX0HqO0LpPKfl
   GKEO6aUzthLuXZD4KRwEItrjcDOH4bU1NeOBXbDZKx5vuUfQ/t9RnxbAf
   g==;
X-CSE-ConnectionGUID: w7BWnZsTT8Co0CGAUDvb3w==
X-CSE-MsgGUID: ROqHLJkHSTueapHaVycYwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="37075922"
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="37075922"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 13:14:17 -0700
X-CSE-ConnectionGUID: ENNxh/SVSKKbaUQ9PgtivQ==
X-CSE-MsgGUID: plOD7kqdRKK6xKcgcWpZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,297,1739865600"; 
   d="scan'208";a="144244932"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 May 2025 13:14:14 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGNvA-000KP5-04;
	Sat, 17 May 2025 20:14:12 +0000
Date: Sun, 18 May 2025 04:13:46 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-imx@nxp.com,
	linux-input@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 6/9] regulator: pf1550: add support for regulator
Message-ID: <202505180341.aMQhbUVJ-lkp@intel.com>
References: <4dd316e06a66634b5af13f1faedc985753b061bc.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd316e06a66634b5af13f1faedc985753b061bc.1747409892.git.samuel.kayode@savoirfairelinux.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b1d8766052eb0534b27edda8af1865d53621bd6a]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Kayode/dt-bindings-power-supply-add-pf1550/20250517-030259
base:   b1d8766052eb0534b27edda8af1865d53621bd6a
patch link:    https://lore.kernel.org/r/4dd316e06a66634b5af13f1faedc985753b061bc.1747409892.git.samuel.kayode%40savoirfairelinux.com
patch subject: [PATCH v2 6/9] regulator: pf1550: add support for regulator
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505180341.aMQhbUVJ-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/regulator/pf1550.c: linux/regulator/machine.h is included more than once.
>> drivers/regulator/pf1550.c: linux/slab.h is included more than once.

vim +19 drivers/regulator/pf1550.c

  > 19	#include <linux/regulator/machine.h>
    20	#include <linux/regulator/of_regulator.h>
  > 21	#include <linux/regulator/machine.h>
    22	#include <linux/platform_device.h>
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

