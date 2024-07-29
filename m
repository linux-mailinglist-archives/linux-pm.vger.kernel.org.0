Return-Path: <linux-pm+bounces-11615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8188B9401CC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC6A282F49
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F5145B24;
	Mon, 29 Jul 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsXWWgt/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAA1E49E
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296713; cv=none; b=H0URZdntN2QgLyBF1zYVUsUtRgo5/mf/y4eqtIT2zUbD7P1qm6EKwhXH20CuxTNYkcvkxhZbNEWpku9yI+AOHSM733jEqhUBa3hKUHxjvOEhqt9D6B4GCXsMckdZA5YpuQhH85THBY5q2cwZkKiwn3qQETEnPC798XLmtXm9B/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296713; c=relaxed/simple;
	bh=jsEouXldoNvEvwAUR0x1SXHsSpJJXXkpqS9prI6hwYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPhww1+a6VWgx4mLdIB8+xWn4KFNdleC/dgBOFJCj66FmAS12LskhIC6WAU+NOpDREQ0Y3UEU811TOcENSstlJA1Qtc1mhKcSo0tfroLUxVAKH8cxm5YJBAkJS3nBeJNIzE7pjHXb/yUF0wJiOT1Rwb8LohwfS984igQmZ0miis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsXWWgt/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722296712; x=1753832712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsEouXldoNvEvwAUR0x1SXHsSpJJXXkpqS9prI6hwYU=;
  b=GsXWWgt/Uah6i80P4iG3b8qrIwsAmvoS+Txg4kDmyWPNa+dC5n2DHsp9
   IruZ61R4cAWV+285VAv7laZVqM13T7WPVMwmU9rD1p9rLBBXR3x8sSIJt
   zkofBI/7UOc7XczlziRyUzFv2JkCMG9ADSelf9741aRY85GmlPSBJXDUA
   6/krK2Qnq3iL+Oj8SKtP0YDwG8y0RtMvtMWQuEwDug5SkO/suZRjfl/Do
   dMDdp1NbFbzC0D3GYpjRh56Pl8XL/GzFpYnt4KMsAWsWNDIwk8LcZwZ4y
   EDCyCK84ueADa4c5TGYOBRqWH4VbO/doA2wcsgoyRXYswacjzbXyBzlrR
   w==;
X-CSE-ConnectionGUID: MxKaOx+GSiaTsVoIazggxA==
X-CSE-MsgGUID: nJ+I8E/xQJ+dsrh0etixpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23876204"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="23876204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 16:45:11 -0700
X-CSE-ConnectionGUID: qZAIMuy4SfKGomQArj4TLA==
X-CSE-MsgGUID: bX83H8VARNGtTkm7/0tBGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="58753537"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Jul 2024 16:45:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYa38-000sC0-2j;
	Mon, 29 Jul 2024 23:45:06 +0000
Date: Tue, 30 Jul 2024 07:45:01 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, quic_manafm@quicinc.com
Subject: Re: [PATCH v1 1/7] thermal/core: Encapsulate more handle_thermal_trip
Message-ID: <202407300733.L6f9tFOM-lkp@intel.com>
References: <20240729150259.1089814-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729150259.1089814-2-daniel.lezcano@linaro.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Encapsulate-more-handle_thermal_trip/20240730-005842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20240729150259.1089814-2-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 1/7] thermal/core: Encapsulate more handle_thermal_trip
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240730/202407300733.L6f9tFOM-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300733.L6f9tFOM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300733.L6f9tFOM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_trip.c:80: warning: Function parameter or struct member 'low' not described in 'thermal_zone_set_trips'
>> drivers/thermal/thermal_trip.c:80: warning: Function parameter or struct member 'high' not described in 'thermal_zone_set_trips'


vim +80 drivers/thermal/thermal_trip.c

5b8de18ee9027c Daniel Lezcano    2023-01-23   63  
5b8de18ee9027c Daniel Lezcano    2023-01-23   64  /**
28d5cc12671c8b Rafael J. Wysocki 2024-06-07   65   * thermal_zone_set_trips - Computes the next trip points for the driver
5b8de18ee9027c Daniel Lezcano    2023-01-23   66   * @tz: a pointer to a thermal zone device structure
5b8de18ee9027c Daniel Lezcano    2023-01-23   67   *
5b8de18ee9027c Daniel Lezcano    2023-01-23   68   * The function computes the next temperature boundaries by browsing
5b8de18ee9027c Daniel Lezcano    2023-01-23   69   * the trip points. The result is the closer low and high trip points
5b8de18ee9027c Daniel Lezcano    2023-01-23   70   * to the current temperature. These values are passed to the backend
5b8de18ee9027c Daniel Lezcano    2023-01-23   71   * driver to let it set its own notification mechanism (usually an
5b8de18ee9027c Daniel Lezcano    2023-01-23   72   * interrupt).
5b8de18ee9027c Daniel Lezcano    2023-01-23   73   *
5b8de18ee9027c Daniel Lezcano    2023-01-23   74   * This function must be called with tz->lock held. Both tz and tz->ops
5b8de18ee9027c Daniel Lezcano    2023-01-23   75   * must be valid pointers.
5b8de18ee9027c Daniel Lezcano    2023-01-23   76   *
5b8de18ee9027c Daniel Lezcano    2023-01-23   77   * It does not return a value
5b8de18ee9027c Daniel Lezcano    2023-01-23   78   */
4c090556217f53 Daniel Lezcano    2024-07-29   79  void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
5b8de18ee9027c Daniel Lezcano    2023-01-23  @80  {
0c0c4740c9d266 Rafael J. Wysocki 2023-12-04   81  	int ret;
5b8de18ee9027c Daniel Lezcano    2023-01-23   82  
5b8de18ee9027c Daniel Lezcano    2023-01-23   83  	lockdep_assert_held(&tz->lock);
5b8de18ee9027c Daniel Lezcano    2023-01-23   84  
698a1eb1f75eb6 Rafael J. Wysocki 2024-02-22   85  	if (!tz->ops.set_trips)
5b8de18ee9027c Daniel Lezcano    2023-01-23   86  		return;
5b8de18ee9027c Daniel Lezcano    2023-01-23   87  
5b8de18ee9027c Daniel Lezcano    2023-01-23   88  	/* No need to change trip points */
5b8de18ee9027c Daniel Lezcano    2023-01-23   89  	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
5b8de18ee9027c Daniel Lezcano    2023-01-23   90  		return;
5b8de18ee9027c Daniel Lezcano    2023-01-23   91  
5b8de18ee9027c Daniel Lezcano    2023-01-23   92  	tz->prev_low_trip = low;
5b8de18ee9027c Daniel Lezcano    2023-01-23   93  	tz->prev_high_trip = high;
5b8de18ee9027c Daniel Lezcano    2023-01-23   94  
5b8de18ee9027c Daniel Lezcano    2023-01-23   95  	dev_dbg(&tz->device,
5b8de18ee9027c Daniel Lezcano    2023-01-23   96  		"new temperature boundaries: %d < x < %d\n", low, high);
5b8de18ee9027c Daniel Lezcano    2023-01-23   97  
5b8de18ee9027c Daniel Lezcano    2023-01-23   98  	/*
5b8de18ee9027c Daniel Lezcano    2023-01-23   99  	 * Set a temperature window. When this window is left the driver
5b8de18ee9027c Daniel Lezcano    2023-01-23  100  	 * must inform the thermal core via thermal_zone_device_update.
5b8de18ee9027c Daniel Lezcano    2023-01-23  101  	 */
698a1eb1f75eb6 Rafael J. Wysocki 2024-02-22  102  	ret = tz->ops.set_trips(tz, low, high);
5b8de18ee9027c Daniel Lezcano    2023-01-23  103  	if (ret)
5b8de18ee9027c Daniel Lezcano    2023-01-23  104  		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
5b8de18ee9027c Daniel Lezcano    2023-01-23  105  }
5b8de18ee9027c Daniel Lezcano    2023-01-23  106  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

