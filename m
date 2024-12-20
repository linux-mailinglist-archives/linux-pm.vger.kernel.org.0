Return-Path: <linux-pm+bounces-19555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489A9F8C78
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D44188DE2E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805017B50A;
	Fri, 20 Dec 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdF2XYTM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AE1632DD;
	Fri, 20 Dec 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675174; cv=none; b=aRFW0aOCe6zc2gecvcyECDe6InNkDPADqCfwcqCPkAF9PkiPKCFvsZaT0AW2WQVHVqkZ2sxMx5Q3P+DhgWnIo0IzAZ8pTWdR3D0WXR/hn68yLOFfHZDT+h8+gdtqEiNB2SLD2Z4Ljsh5d4/eYDGzqGp7w25mxBqok4t98VWuHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675174; c=relaxed/simple;
	bh=ZzuWvue3/Dyz3OEX4IuEIJmdALTB1lMDUAcKhYLsTpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQNaLsaj6PQOd6ou2mNvs0Y3ikjUxhEsH8zfAAk4LfJ3YQ2bhkq8q8FFt3DBKS97BhAY2Vhxs+HuzGMfYG7i5LYoDBhr3m3Y9JIApd+x3HIiLzz6o+ash7rO3qYs5L47CQWuEI0nAj8MgGTIFwOrr9wICxMP3iT1dn0PgRRuAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdF2XYTM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734675173; x=1766211173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzuWvue3/Dyz3OEX4IuEIJmdALTB1lMDUAcKhYLsTpI=;
  b=kdF2XYTMvIxUET2SN8KNoqLjMFPP8A2qi+x6I8FBlVGRMJ49E/V83xba
   g0b64k85iHP1n+e2VR7WPRlEkM1BLCldYBw5o35a2tSHDlS3YyF6i0RUM
   ByDJyvqWFcFTwOUlD08z/ww9ii/ZvvR/10YXpO7PE7TdlYUNzU16ftqO+
   1Nuoie0k28qLQs4WmTU0XhrmYuFRNbq/ArqBtMhjO6V9y7Zs/1JaOg2t2
   SvQi8oxnh08o/vKZysoQf32anC0YePHzhN0jkksRGVVYi80nKDByTSCaA
   Y0yrdAyW9ovUKQg/jMIJ32VL7Lw1KZbmwi6eaEqqVTHI43aSAqyb3KMS2
   w==;
X-CSE-ConnectionGUID: U+YpWyynTDqQRFY04taqXA==
X-CSE-MsgGUID: HKf3QRZeQh6Wx7dtXbtXLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="52624772"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="52624772"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 22:12:52 -0800
X-CSE-ConnectionGUID: sOKRon2lQOKdRxhfnSyVsg==
X-CSE-MsgGUID: MHx5yihkQumsZQA5kCOVYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="103405111"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 22:12:46 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOWFf-0000tP-2O;
	Fri, 20 Dec 2024 06:12:43 +0000
Date: Fri, 20 Dec 2024 14:12:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@denx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 02/11] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
Message-ID: <202412201310.JWkUQ9qf-lkp@intel.com>
References: <20241219-hw_protection-reboot-v1-2-263a0c1df802@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-hw_protection-reboot-v1-2-263a0c1df802@pengutronix.de>

Hi Ahmad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmad-Fatoum/reboot-replace-__hw_protection_shutdown-bool-action-parameter-with-an-enum/20241219-155416
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241219-hw_protection-reboot-v1-2-263a0c1df802%40pengutronix.de
patch subject: [PATCH 02/11] reboot: reboot, not shutdown, on hw_protection_reboot timeout
config: i386-buildonly-randconfig-003-20241220 (https://download.01.org/0day-ci/archive/20241220/202412201310.JWkUQ9qf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412201310.JWkUQ9qf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412201310.JWkUQ9qf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/reboot.c:241: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:995: warning: Function parameter or struct member 'action' not described in 'hw_failure_emergency_schedule'
>> kernel/reboot.c:995: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_schedule'
   kernel/reboot.c:1023: warning: Function parameter or struct member 'action' not described in '__hw_protection_shutdown'
   kernel/reboot.c:1023: warning: Excess function parameter 'shutdown' description in '__hw_protection_shutdown'


vim +995 kernel/reboot.c

dfa19b11385d4c Matti Vaittinen 2021-06-03   983  
dfa19b11385d4c Matti Vaittinen 2021-06-03   984  static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
dfa19b11385d4c Matti Vaittinen 2021-06-03   985  			    hw_failure_emergency_poweroff_func);
dfa19b11385d4c Matti Vaittinen 2021-06-03   986  
dfa19b11385d4c Matti Vaittinen 2021-06-03   987  /**
595ab92650cc28 Ahmad Fatoum    2024-12-19   988   * hw_failure_emergency_schedule - Schedule an emergency system shutdown or reboot
dfa19b11385d4c Matti Vaittinen 2021-06-03   989   *
dfa19b11385d4c Matti Vaittinen 2021-06-03   990   * This may be called from any critical situation to trigger a system shutdown
dfa19b11385d4c Matti Vaittinen 2021-06-03   991   * after a given period of time. If time is negative this is not scheduled.
dfa19b11385d4c Matti Vaittinen 2021-06-03   992   */
595ab92650cc28 Ahmad Fatoum    2024-12-19   993  static void hw_failure_emergency_schedule(enum hw_protection_action action,
595ab92650cc28 Ahmad Fatoum    2024-12-19   994  					  int poweroff_delay_ms)
dfa19b11385d4c Matti Vaittinen 2021-06-03  @995  {
dfa19b11385d4c Matti Vaittinen 2021-06-03   996  	if (poweroff_delay_ms <= 0)
dfa19b11385d4c Matti Vaittinen 2021-06-03   997  		return;
595ab92650cc28 Ahmad Fatoum    2024-12-19   998  	hw_failure_emergency_action = action;
dfa19b11385d4c Matti Vaittinen 2021-06-03   999  	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
dfa19b11385d4c Matti Vaittinen 2021-06-03  1000  			      msecs_to_jiffies(poweroff_delay_ms));
dfa19b11385d4c Matti Vaittinen 2021-06-03  1001  }
dfa19b11385d4c Matti Vaittinen 2021-06-03  1002  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

