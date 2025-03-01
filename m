Return-Path: <linux-pm+bounces-23214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF266A4AC43
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 15:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC57161666
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B81E0E14;
	Sat,  1 Mar 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAoiW8o1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90F179BC;
	Sat,  1 Mar 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839564; cv=none; b=c11DrQkHjV2r8l/aPbDg5Au97iEePf6G2o9JilaVZsV+ItudYHzBUtV6ginyz5Jgb77DFOwIBlrqz8qtTNYtKGyh4FSY1upm/bHM6z/kK58RBXqahqwIoZ0d1sYwxUMYqznfQpF2zOaULbkKnHZ0uZj3gq6MGqIg4LqRJoL9bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839564; c=relaxed/simple;
	bh=bLqzk0hZGh7JUidUtBf7joPxGae5Rem2KwHG3iQ/B5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd4kXoB6Rnu2Y29ng3fl6pvOEKvObLmEafH06hZV0h+hXkSnO19RqxwX97Ukg2fOyuTIxo34A8vQCiteniHs3vEy4/Q13dVlvYHMT1seOri6FauqVif8PahAP0RTCz6tom3lNGxMNFCbZ7eWEid4qJ0qr9Nrm6YkrwjREy3rDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAoiW8o1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740839563; x=1772375563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bLqzk0hZGh7JUidUtBf7joPxGae5Rem2KwHG3iQ/B5o=;
  b=OAoiW8o1X74ULXwoVLtFsw3Gr5RI7x0p8j2GjMKFqSUi3UDsun0Ob8zM
   QXpZsWd0sjGz5RXsA24iuynPmNwwR+tpLd2e6TF7SNymvsVuQ7768CN3H
   dVbacf90lIBi5B3iPmHe4NIaGc4Bdn0cxN7UiWMCg49RoYHj3zZkYGAz6
   REpRceUGNz+0bQDhrcD8aNfcK8DDOQCWfIh6n6DzD7+dPd4HIboxQhMPC
   Cx1PfdX28qC8ZEkJAl9KyErEGdPX36sGW7L9eXKKvtJx0jr1+1o+YPu7M
   8UqeFlPxfejMQth1OpwqeeA3+koFvNe6Ji5hFCJDJA/c+IWaHyLDKpt/U
   g==;
X-CSE-ConnectionGUID: A22VN2dmRi+UwSU1gRt47Q==
X-CSE-MsgGUID: /D1bdRd5SdScxkq/eSWtFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45676808"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45676808"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 06:32:42 -0800
X-CSE-ConnectionGUID: 6t94cAUDRsy77tuNTdIZRw==
X-CSE-MsgGUID: R9SOZY+fQTi+Kcp+lGgBnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="118089574"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 01 Mar 2025 06:32:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toNss-000GKE-2g;
	Sat, 01 Mar 2025 14:32:12 +0000
Date: Sat, 1 Mar 2025 22:31:17 +0800
From: kernel test robot <lkp@intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-hwmon@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH v2 11/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
Message-ID: <202503012254.EtBZW7gW-lkp@intel.com>
References: <20250222161824.172511-12-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222161824.172511-12-lkml@antheas.dev>

Hi Antheas,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on sre-power-supply/for-next amd-pstate/linux-next amd-pstate/bleeding-edge rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/hwmon-oxp-sensors-Distinguish-the-X1-variants/20250223-003148
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250222161824.172511-12-lkml%40antheas.dev
patch subject: [PATCH v2 11/12] platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
config: x86_64-randconfig-078-20250301 (https://download.01.org/0day-ci/archive/20250301/202503012254.EtBZW7gW-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503012254.EtBZW7gW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503012254.EtBZW7gW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_hwmon_device_register_with_info
   >>> referenced by oxpec.c:1051 (drivers/platform/x86/oxpec.c:1051)
   >>>               vmlinux.o:(oxp_platform_probe)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

