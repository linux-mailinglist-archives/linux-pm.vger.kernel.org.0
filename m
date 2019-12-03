Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37810FB85
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfLCKPX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 05:15:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCKPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 05:15:23 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ic5D7-0006Qc-Ml; Tue, 03 Dec 2019 11:15:13 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ic5D3-0002Xv-TN; Tue, 03 Dec 2019 11:15:09 +0100
Date:   Tue, 3 Dec 2019 11:15:09 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Igor Plyatov <plyatov@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Issue with imx_get_temp()
Message-ID: <20191203101509.wte47aad5k4mqu2y@pengutronix.de>
References: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:11:20 up 18 days,  1:29, 28 users,  load average: 0.10, 0.03,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Igor,

On 19-12-02 16:45, Igor Plyatov wrote:
> Dear all,
> 
> please  look at back-trace below. It happens on Freescale i.MX6 Quad.
> 
> Found a few of those during power on/off stress test in the climate chamber:
> 
> [    0.657596] ------------[ cut here ]------------
> [    0.657626] WARNING: CPU: 3 PID: 150 at /home/geosig/development/oe-core-toradex-cr7/build/tmp-glibc/work-shared/cr7/kernel-source/kernel/irq/chip.c:242 __irq_startup+0x94/0xa8
> [    0.657630] Modules linked in:
> [    0.657643] CPU: 3 PID: 150 Comm: kworker/3:1 Not tainted 5.1.1 #1
> [    0.657648] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    0.657660] Workqueue: events deferred_probe_work_func
> [    0.657691] [<8011005c>] (unwind_backtrace) from [<8010b8c8>] (show_stack+0x10/0x14)
> [    0.657709] [<8010b8c8>] (show_stack) from [<80857b04>] (dump_stack+0x88/0x9c)
> [    0.657727] [<80857b04>] (dump_stack) from [<8011f308>] (__warn+0xdc/0xf4)
> [    0.657741] [<8011f308>] (__warn) from [<8011f438>] (warn_slowpath_null+0x40/0x48)
> [    0.657752] [<8011f438>] (warn_slowpath_null) from [<8016d1a8>] (__irq_startup+0x94/0xa8)
> [    0.657762] [<8016d1a8>] (__irq_startup) from [<8016d208>] (irq_startup+0x4c/0x130)
> [    0.657772] [<8016d208>] (irq_startup) from [<8016a6dc>] (enable_irq+0x44/0x90)
> [    0.657790] [<8016a6dc>] (enable_irq) from [<8066f05c>] (imx_get_temp+0x1bc/0x1fc)
> [    0.657804] [<8066f05c>] (imx_get_temp) from [<8066cd78>] (thermal_zone_get_temp+0x48/0x68)
> [    0.657816] [<8066cd78>] (thermal_zone_get_temp) from [<8066a3e4>] (thermal_zone_device_update.part.3+0x28/0xcc)
> [    0.657827] [<8066a3e4>] (thermal_zone_device_update.part.3) from [<8066afc4>] (thermal_zone_device_register+0x4ac/0x5ec)
> [    0.657837] [<8066afc4>] (thermal_zone_device_register) from [<8066f580>] (imx_thermal_probe+0x3a8/0x61c)
> [    0.657853] [<8066f580>] (imx_thermal_probe) from [<8054ae90>] (platform_drv_probe+0x48/0x98)
> [    0.657864] [<8054ae90>] (platform_drv_probe) from [<805492a4>] (really_probe+0x228/0x2d0)
> [    0.657875] [<805492a4>] (really_probe) from [<805494ac>] (driver_probe_device+0x60/0x174)
> [    0.657892] [<805494ac>] (driver_probe_device) from [<805476f4>] (bus_for_each_drv+0x58/0xb8)
> [    0.657903] [<805476f4>] (bus_for_each_drv) from [<80549008>] (__device_attach+0xd0/0x13c)
> [    0.657914] [<80549008>] (__device_attach) from [<80548404>] (bus_probe_device+0x84/0x8c)
> [    0.657923] [<80548404>] (bus_probe_device) from [<8054889c>] (deferred_probe_work_func+0x64/0x90)
> [    0.657938] [<8054889c>] (deferred_probe_work_func) from [<80136fd0>] (process_one_work+0x204/0x420)
> [    0.657952] [<80136fd0>] (process_one_work) from [<80137ddc>] (worker_thread+0x44/0x5bc)
> [    0.657966] [<80137ddc>] (worker_thread) from [<8013cab0>] (kthread+0x144/0x14c)
> [    0.657978] [<8013cab0>] (kthread) from [<801010e8>] (ret_from_fork+0x14/0x2c)
> [    0.657984] Exception stack(0xd0ae1fb0 to 0xd0ae1ff8)
> [    0.657992] 1fa0:                                     00000000 00000000 00000000 00000000
> [    0.658002] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.658010] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.658016] ---[ end trace 6bb553a60c0886bd ]---
> 
> Can somebody recommend, how to debug/resolve this issue?

Mh.. it seems that the irq gets enabled before a irq-handler is
registered. As your backlog shows the thermal_zone_device_register()
triggers a imx_get_temp() and during boot the irq_enabled is false and
it seems that your temperature is below the alarm_temp. So in such a
case the enable_irq() is executed. I don't know what happens if we
enable a irq without a irq-handler.

Regards,
  Marco 

> Best wishes.
> --
> Igor Plyatov
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
