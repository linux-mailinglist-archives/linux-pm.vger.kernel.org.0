Return-Path: <linux-pm+bounces-19989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA3A027FD
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 15:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4F7A029C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76781DE3A7;
	Mon,  6 Jan 2025 14:29:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C801DCB2B
	for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173749; cv=none; b=VJcOWfoH24yEjEhWnhvxaL+unTt5xy2nEMlfTYMoPcosmi0uw+udvugsfyjQW97Yk1PIbpP/29VNIGDXD+3kLKUVW5XsYFPZKk95QWOfUIVvtTp7/GjoL8EM3nLatW7mqjMvbDG5bPRhZbFcgthOapa6nLYV6DiiAOtqQm3v1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173749; c=relaxed/simple;
	bh=tDpzm4Bj9QcJNosTjFSSPqoZ3zZOgYkdsQMreDEVpwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDqG6ovqg6c3/xxoq3zvBZ2Ip1okxhVy8xszBTwTUSi8zKhMNJ/D3N10ua4EjGfMsMcfGkAUmWBL2xMl2QFNQXsmp0AC0LVe1pB4q5Mf6vsOLnqEe41LfyQDzV+C9HIxIERClgBuD4YGYkobdOh2ZBA1RPC5HE48Td4aoEYTTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tUo5x-0005hl-W8; Mon, 06 Jan 2025 15:28:42 +0100
Message-ID: <1c0957b2-48cf-49a1-aa5e-666defd7f0fd@pengutronix.de>
Date: Mon, 6 Jan 2025 15:28:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
To: kernel test robot <lkp@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org, chrome-platform@lists.linux.dev,
 devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20241219-hw_protection-reboot-v1-2-263a0c1df802@pengutronix.de>
 <202412201310.JWkUQ9qf-lkp@intel.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <202412201310.JWkUQ9qf-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 20.12.24 07:12, kernel test robot wrote:
> Hi Ahmad,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ahmad-Fatoum/reboot-replace-__hw_protection_shutdown-bool-action-parameter-with-an-enum/20241219-155416
> base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> patch link:    https://lore.kernel.org/r/20241219-hw_protection-reboot-v1-2-263a0c1df802%40pengutronix.de
> patch subject: [PATCH 02/11] reboot: reboot, not shutdown, on hw_protection_reboot timeout
> config: i386-buildonly-randconfig-003-20241220 (https://download.01.org/0day-ci/archive/20241220/202412201310.JWkUQ9qf-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412201310.JWkUQ9qf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412201310.JWkUQ9qf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/reboot.c:241: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
>>> kernel/reboot.c:995: warning: Function parameter or struct member 'action' not described in 'hw_failure_emergency_schedule'
>>> kernel/reboot.c:995: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_schedule'

Will fix the kernel doc issues for v2.

>    kernel/reboot.c:1023: warning: Function parameter or struct member 'action' not described in '__hw_protection_shutdown'
>    kernel/reboot.c:1023: warning: Excess function parameter 'shutdown' description in '__hw_protection_shutdown'
> 
> 
> vim +995 kernel/reboot.c
> 
> dfa19b11385d4c Matti Vaittinen 2021-06-03   983  
> dfa19b11385d4c Matti Vaittinen 2021-06-03   984  static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
> dfa19b11385d4c Matti Vaittinen 2021-06-03   985  			    hw_failure_emergency_poweroff_func);
> dfa19b11385d4c Matti Vaittinen 2021-06-03   986  
> dfa19b11385d4c Matti Vaittinen 2021-06-03   987  /**
> 595ab92650cc28 Ahmad Fatoum    2024-12-19   988   * hw_failure_emergency_schedule - Schedule an emergency system shutdown or reboot
> dfa19b11385d4c Matti Vaittinen 2021-06-03   989   *
> dfa19b11385d4c Matti Vaittinen 2021-06-03   990   * This may be called from any critical situation to trigger a system shutdown
> dfa19b11385d4c Matti Vaittinen 2021-06-03   991   * after a given period of time. If time is negative this is not scheduled.
> dfa19b11385d4c Matti Vaittinen 2021-06-03   992   */
> 595ab92650cc28 Ahmad Fatoum    2024-12-19   993  static void hw_failure_emergency_schedule(enum hw_protection_action action,
> 595ab92650cc28 Ahmad Fatoum    2024-12-19   994  					  int poweroff_delay_ms)
> dfa19b11385d4c Matti Vaittinen 2021-06-03  @995  {
> dfa19b11385d4c Matti Vaittinen 2021-06-03   996  	if (poweroff_delay_ms <= 0)
> dfa19b11385d4c Matti Vaittinen 2021-06-03   997  		return;
> 595ab92650cc28 Ahmad Fatoum    2024-12-19   998  	hw_failure_emergency_action = action;
> dfa19b11385d4c Matti Vaittinen 2021-06-03   999  	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
> dfa19b11385d4c Matti Vaittinen 2021-06-03  1000  			      msecs_to_jiffies(poweroff_delay_ms));
> dfa19b11385d4c Matti Vaittinen 2021-06-03  1001  }
> dfa19b11385d4c Matti Vaittinen 2021-06-03  1002  
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

