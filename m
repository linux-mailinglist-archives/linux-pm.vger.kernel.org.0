Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0810EB01
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfLBNpc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 08:45:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBNpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 08:45:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id y23so10774057wma.0;
        Mon, 02 Dec 2019 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=KWDqcKWZeedBFFm4F7JOnGTR8JoGKWT55ZUJbiUqPGA=;
        b=ElvtWJZ+cCPmklplbOUer6+D7PjFv2PbguqdRtdIrZX+lhdNwGf26thXZT8kcvfJl3
         Cqsz7sp0EvgBoDYO8APYogpc5fZlsoo+r19LTAuI5LAIOZGfJu9rvaWpojExxwGyncFX
         852KKF1En07cH4zXQNmLkdbPcKmmNkbhuF4xPX0oP5NCDxymAU/oSFXR7gMTiksxE5Pv
         ucUPUX8xgGRobywB7CwTA5/19Xzu9m+NP5+CvgU12freookq+8U2UbNVvgBqK7yvzlc3
         wSlo+vpa54HQx24v1+299+ZZIpASzVXS/AjrRbHKihVM38bSWIkOLHu9nZnIFNHHuhIT
         fv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=KWDqcKWZeedBFFm4F7JOnGTR8JoGKWT55ZUJbiUqPGA=;
        b=OCqG8wUUkARqkyUVfe+LbC4JbMGKv2rlNKqYuy/6TCHWry3K9oWE7fA5t0/XnwDxDY
         pn7B575PG8hDBRXX3N8jvJq/mOIiR6zSzhwfdP+s2tL8oQLYzn/vD2M9oQVA8lTWIvSh
         NQYiyWUzxzP3dkhVNBehNk7j7L77in1i2p2AX25oN06spNkwMezTgRDZRfs/9JrlBbhJ
         fhg/FRsmq+fXoQTqDCyQACeKDeDxx5SHQ4G+0ZWORJLOEWWU34tpJTuT5k3hBtOWKZjC
         hpwoScBui74ujdB6WTjr2xKPMwCVd6QKyc4tVfRm6fCydBqk4m2ecotnAmUrKFprinkp
         NwGA==
X-Gm-Message-State: APjAAAWtdUHsfcDzittGbSnPrzKkN+m8yuV6QIADo1mLT2fUaVFOj2xP
        +qf2Oys+HqmxWyQXt0bDt8xkGtbsqo4=
X-Google-Smtp-Source: APXvYqxQvxkWQgON5DzxrLvp726hjj6Yq+/cWuJafSGLJxNx8m/9Oy1DkA+6xa3ov63qCMzpt/gVzQ==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr27960543wmi.51.1575294328217;
        Mon, 02 Dec 2019 05:45:28 -0800 (PST)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id u10sm948310wmd.1.2019.12.02.05.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 05:45:27 -0800 (PST)
From:   Igor Plyatov <plyatov@gmail.com>
Subject: Issue with imx_get_temp()
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
Date:   Mon, 2 Dec 2019 16:45:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear all,

please  look at back-trace below. It happens on Freescale i.MX6 Quad.

Found a few of those during power on/off stress test in the climate chamber:

[    0.657596] ------------[ cut here ]------------
[    0.657626] WARNING: CPU: 3 PID: 150 at /home/geosig/development/oe-core-toradex-cr7/build/tmp-glibc/work-shared/cr7/kernel-source/kernel/irq/chip.c:242 __irq_startup+0x94/0xa8
[    0.657630] Modules linked in:
[    0.657643] CPU: 3 PID: 150 Comm: kworker/3:1 Not tainted 5.1.1 #1
[    0.657648] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    0.657660] Workqueue: events deferred_probe_work_func
[    0.657691] [<8011005c>] (unwind_backtrace) from [<8010b8c8>] (show_stack+0x10/0x14)
[    0.657709] [<8010b8c8>] (show_stack) from [<80857b04>] (dump_stack+0x88/0x9c)
[    0.657727] [<80857b04>] (dump_stack) from [<8011f308>] (__warn+0xdc/0xf4)
[    0.657741] [<8011f308>] (__warn) from [<8011f438>] (warn_slowpath_null+0x40/0x48)
[    0.657752] [<8011f438>] (warn_slowpath_null) from [<8016d1a8>] (__irq_startup+0x94/0xa8)
[    0.657762] [<8016d1a8>] (__irq_startup) from [<8016d208>] (irq_startup+0x4c/0x130)
[    0.657772] [<8016d208>] (irq_startup) from [<8016a6dc>] (enable_irq+0x44/0x90)
[    0.657790] [<8016a6dc>] (enable_irq) from [<8066f05c>] (imx_get_temp+0x1bc/0x1fc)
[    0.657804] [<8066f05c>] (imx_get_temp) from [<8066cd78>] (thermal_zone_get_temp+0x48/0x68)
[    0.657816] [<8066cd78>] (thermal_zone_get_temp) from [<8066a3e4>] (thermal_zone_device_update.part.3+0x28/0xcc)
[    0.657827] [<8066a3e4>] (thermal_zone_device_update.part.3) from [<8066afc4>] (thermal_zone_device_register+0x4ac/0x5ec)
[    0.657837] [<8066afc4>] (thermal_zone_device_register) from [<8066f580>] (imx_thermal_probe+0x3a8/0x61c)
[    0.657853] [<8066f580>] (imx_thermal_probe) from [<8054ae90>] (platform_drv_probe+0x48/0x98)
[    0.657864] [<8054ae90>] (platform_drv_probe) from [<805492a4>] (really_probe+0x228/0x2d0)
[    0.657875] [<805492a4>] (really_probe) from [<805494ac>] (driver_probe_device+0x60/0x174)
[    0.657892] [<805494ac>] (driver_probe_device) from [<805476f4>] (bus_for_each_drv+0x58/0xb8)
[    0.657903] [<805476f4>] (bus_for_each_drv) from [<80549008>] (__device_attach+0xd0/0x13c)
[    0.657914] [<80549008>] (__device_attach) from [<80548404>] (bus_probe_device+0x84/0x8c)
[    0.657923] [<80548404>] (bus_probe_device) from [<8054889c>] (deferred_probe_work_func+0x64/0x90)
[    0.657938] [<8054889c>] (deferred_probe_work_func) from [<80136fd0>] (process_one_work+0x204/0x420)
[    0.657952] [<80136fd0>] (process_one_work) from [<80137ddc>] (worker_thread+0x44/0x5bc)
[    0.657966] [<80137ddc>] (worker_thread) from [<8013cab0>] (kthread+0x144/0x14c)
[    0.657978] [<8013cab0>] (kthread) from [<801010e8>] (ret_from_fork+0x14/0x2c)
[    0.657984] Exception stack(0xd0ae1fb0 to 0xd0ae1ff8)
[    0.657992] 1fa0:                                     00000000 00000000 00000000 00000000
[    0.658002] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.658010] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.658016] ---[ end trace 6bb553a60c0886bd ]---

Can somebody recommend, how to debug/resolve this issue?

Best wishes.
--
Igor Plyatov

