Return-Path: <linux-pm+bounces-19559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9659F8CF0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 07:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778BC167B15
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F60198823;
	Fri, 20 Dec 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+D2HkXR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FB13B58D;
	Fri, 20 Dec 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734677819; cv=none; b=fT/p/nuYHKWQEsH04YqAMOzbEY2UgQpbru7c8woNd0r9z37/QSslavSW8GuSomZZhs5MjLBuueYbPfPwncFEn4s6SCl+ItwuHmDL2To8jm7ag0mVNtrrxQNGimrOZ663dc9703WBPmAyCBCVtfJU/xMmfZ4iv8VW+JRzIyNtHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734677819; c=relaxed/simple;
	bh=/CIwRAQpU+FEb+4P5INMAwLfobrrnCIKq8277eG46Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/QmloaELnU62KzH2jK9XmTFJ5m2Q/7oikVRcIdYltJAhEy2iBcPKXmEnSJI7F1UlceUZC7RXOwznOI2UBYmFIQkjRB1zQx7bHvXT7058eBdPjNDLHnsiSXSaTpkSWYdKzXTu6rQ6dD2F5YaP+N+1tHmX/R5pJF7zD/nv7lQYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+D2HkXR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734677816; x=1766213816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CIwRAQpU+FEb+4P5INMAwLfobrrnCIKq8277eG46Es=;
  b=K+D2HkXRK8wDcve7122qvnbDfXTy4GbnapyvbkSms6rkzBejEYK7GbFs
   kVxeLneuv09Dyd1GQvMQAfQqC3QGRdFyCjR4uWsxzF1/0yNtKQASlOOs+
   Ssn1aF995pyVAZBlDMsstHFhtDpVrzwLrgOmr7ZScDutH5cLEJkxzfiJH
   gfwbze8x2H6K9+03PFmyiXU+Z2yFz9kwPWo54ft76Hyttc05YG7AMK8wO
   kFc8zC2yC/+dahlplRqEWoy+nG6dt2DlEowRvHkOUsB6PssFPY6nhI0jV
   i4dH0GNfBhgFbT0ivgeYj3/Bw90lVt1hP3lQ4wDkeEpw4S3fkHrSUjJIE
   g==;
X-CSE-ConnectionGUID: fqmTsPDVT4KJ1bjJiXZodQ==
X-CSE-MsgGUID: zA4ZDvG0SrK2IHfNtKrLeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="45908535"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="45908535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 22:56:55 -0800
X-CSE-ConnectionGUID: pUZ2YiQFQOylVbzLCIoZzQ==
X-CSE-MsgGUID: GkSREMQWS6qG9O0E6BlgbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="98264060"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Dec 2024 22:56:49 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOWwJ-0000vf-22;
	Fri, 20 Dec 2024 06:56:47 +0000
Date: Fri, 20 Dec 2024 14:56:00 +0800
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
Subject: Re: [PATCH 04/11] reboot: rename now misleading hw_protection symbols
Message-ID: <202412201443.inJcQtcl-lkp@intel.com>
References: <20241219-hw_protection-reboot-v1-4-263a0c1df802@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-hw_protection-reboot-v1-4-263a0c1df802@pengutronix.de>

Hi Ahmad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmad-Fatoum/reboot-replace-__hw_protection_shutdown-bool-action-parameter-with-an-enum/20241219-155416
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241219-hw_protection-reboot-v1-4-263a0c1df802%40pengutronix.de
patch subject: [PATCH 04/11] reboot: rename now misleading hw_protection symbols
config: i386-buildonly-randconfig-003-20241220 (https://download.01.org/0day-ci/archive/20241220/202412201443.inJcQtcl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412201443.inJcQtcl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412201443.inJcQtcl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/reboot.c:241: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
   kernel/reboot.c:995: warning: Function parameter or struct member 'action' not described in 'hw_failure_emergency_schedule'
   kernel/reboot.c:995: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_schedule'
>> kernel/reboot.c:1023: warning: Function parameter or struct member 'action' not described in '__hw_protection_trigger'
>> kernel/reboot.c:1023: warning: Excess function parameter 'shutdown' description in '__hw_protection_trigger'


vim +1023 kernel/reboot.c

dfa19b11385d4c Matti Vaittinen 2021-06-03  1002  
dfa19b11385d4c Matti Vaittinen 2021-06-03  1003  /**
c37fda1c195d45 Ahmad Fatoum    2024-12-19  1004   * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
dfa19b11385d4c Matti Vaittinen 2021-06-03  1005   *
79fa723ba84c2b Fabio Estevam   2023-11-29  1006   * @reason:		Reason of emergency shutdown or reboot to be printed.
79fa723ba84c2b Fabio Estevam   2023-11-29  1007   * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
79fa723ba84c2b Fabio Estevam   2023-11-29  1008   *			triggering it. Negative value disables the forced
79fa723ba84c2b Fabio Estevam   2023-11-29  1009   *			shutdown or reboot.
79fa723ba84c2b Fabio Estevam   2023-11-29  1010   * @shutdown:		If true, indicates that a shutdown will happen
79fa723ba84c2b Fabio Estevam   2023-11-29  1011   *			after the critical tempeature is reached.
79fa723ba84c2b Fabio Estevam   2023-11-29  1012   *			If false, indicates that a reboot will happen
79fa723ba84c2b Fabio Estevam   2023-11-29  1013   *			after the critical tempeature is reached.
dfa19b11385d4c Matti Vaittinen 2021-06-03  1014   *
79fa723ba84c2b Fabio Estevam   2023-11-29  1015   * Initiate an emergency system shutdown or reboot in order to protect
79fa723ba84c2b Fabio Estevam   2023-11-29  1016   * hardware from further damage. Usage examples include a thermal protection.
79fa723ba84c2b Fabio Estevam   2023-11-29  1017   * NOTE: The request is ignored if protection shutdown or reboot is already
79fa723ba84c2b Fabio Estevam   2023-11-29  1018   * pending even if the previous request has given a large timeout for forced
79fa723ba84c2b Fabio Estevam   2023-11-29  1019   * shutdown/reboot.
dfa19b11385d4c Matti Vaittinen 2021-06-03  1020   */
c37fda1c195d45 Ahmad Fatoum    2024-12-19  1021  void __hw_protection_trigger(const char *reason, int ms_until_forced,
d3e5893beaf551 Ahmad Fatoum    2024-12-19  1022  			     enum hw_protection_action action)
dfa19b11385d4c Matti Vaittinen 2021-06-03 @1023  {
dfa19b11385d4c Matti Vaittinen 2021-06-03  1024  	static atomic_t allow_proceed = ATOMIC_INIT(1);
dfa19b11385d4c Matti Vaittinen 2021-06-03  1025  
dfa19b11385d4c Matti Vaittinen 2021-06-03  1026  	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
dfa19b11385d4c Matti Vaittinen 2021-06-03  1027  
dfa19b11385d4c Matti Vaittinen 2021-06-03  1028  	/* Shutdown should be initiated only once. */
dfa19b11385d4c Matti Vaittinen 2021-06-03  1029  	if (!atomic_dec_and_test(&allow_proceed))
07a22b61946f0b Petr Mladek     2022-06-23  1030  		return;
dfa19b11385d4c Matti Vaittinen 2021-06-03  1031  
dfa19b11385d4c Matti Vaittinen 2021-06-03  1032  	/*
dfa19b11385d4c Matti Vaittinen 2021-06-03  1033  	 * Queue a backup emergency shutdown in the event of
dfa19b11385d4c Matti Vaittinen 2021-06-03  1034  	 * orderly_poweroff failure
dfa19b11385d4c Matti Vaittinen 2021-06-03  1035  	 */
595ab92650cc28 Ahmad Fatoum    2024-12-19  1036  	hw_failure_emergency_schedule(action, ms_until_forced);
d3e5893beaf551 Ahmad Fatoum    2024-12-19  1037  	if (action == HWPROT_ACT_REBOOT)
79fa723ba84c2b Fabio Estevam   2023-11-29  1038  		orderly_reboot();
d3e5893beaf551 Ahmad Fatoum    2024-12-19  1039  	else
d3e5893beaf551 Ahmad Fatoum    2024-12-19  1040  		orderly_poweroff(true);
dfa19b11385d4c Matti Vaittinen 2021-06-03  1041  }
c37fda1c195d45 Ahmad Fatoum    2024-12-19  1042  EXPORT_SYMBOL_GPL(__hw_protection_trigger);
dfa19b11385d4c Matti Vaittinen 2021-06-03  1043  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

