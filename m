Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C237E58CDEC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiHHSoq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbiHHSop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 14:44:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163BDE2A;
        Mon,  8 Aug 2022 11:44:42 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5D3E92224F;
        Mon,  8 Aug 2022 20:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659984280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWoNgvMdfqDAxbR6k/hHBv3FXqYhiHMlRj43gtM2Wcw=;
        b=bBJKzXu97IPt0eYv7ORu6g2UXOatpq/MPbyJEG8Tstg1olVrBX0wK9mpmWmJw91ZRYx/vQ
        CerKP74gDA9XIZGW5a9dI09fE4DuDa/O3H95vMfg3C77OJmJKuzvmUawwLHRPoXTSkXeZO
        V8zAWU5eB+z8aG1zkDEoNs5mZ105dPc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Aug 2022 20:44:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/4] thermal/of: Fix free after use in
 thermal_of_unregister()
In-Reply-To: <20220808180915.446053-4-daniel.lezcano@linaro.org>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-4-daniel.lezcano@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2a4c16bd886dd5b4bbf5bb12fd3b2e05@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 2022-08-08 20:09, schrieb Daniel Lezcano:
> The thermal zone is freed after being unregistered. The release method
> devm_thermal_zone_device_register() calls
>   -> thermal_of_zone_device_unregister()
> 
> This one calls thermal_zone_device_unregister() which frees the
> thermal zone. However, thermal_of_zone_device_unregister() does access
> this freed pointer to free different resources allocated by the
> thermal_of framework which is invalid.
> 
> It results in a kernel panic:
> 
> [    1.915140] thermal_sys: Failed to find thermal zone for tmu id=2
> [    1.921279] qoriq_thermal 1f80000.tmu: Failed to register sensors
> [    1.927395] qoriq_thermal: probe of 1f80000.tmu failed with error 
> -22
> [    1.934189] Unable to handle kernel paging request at virtual
> address 01adadadadadad88
> [    1.942146] Mem abort info:
> [    1.944948]   ESR = 0x0000000096000004
> [    1.948708]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.954042]   SET = 0, FnV = 0
> [    1.957107]   EA = 0, S1PTW = 0
> [    1.960253]   FSC = 0x04: level 0 translation fault
> [    1.965147] Data abort info:
> [    1.968030]   ISV = 0, ISS = 0x00000004
> [    1.971878]   CM = 0, WnR = 0
> [    1.974852] [01adadadadadad88] address between user and kernel 
> address ranges
> [    1.982016] Internal error: Oops: 96000004 [#1] SMP
> [    1.986907] Modules linked in:
> [    1.989969] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.19.0-next-20220808-00080-g1c46f44502e0 #1697
> [    1.999135] Hardware name: Kontron KBox A-230-LS (DT)
> [    2.004199] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [    2.011185] pc : kfree+0x5c/0x3c0
> [    2.014516] lr : devm_thermal_of_zone_release+0x38/0x60
> [    2.019761] sp : ffff80000a22bad0
> [    2.023081] x29: ffff80000a22bad0 x28: 0000000000000000 x27: 
> ffff800009960464
> [    2.030245] x26: ffff800009a16960 x25: 0000000000000006 x24: 
> ffff800009f09a40
> [    2.037407] x23: ffff800009ab9008 x22: ffff800008d0eea8 x21: 
> 01adadadadadad80
> [    2.044569] x20: 6b6b6b6b6b6b6b6b x19: ffff00200232b800 x18: 
> 00000000fffffffb
> [    2.051731] x17: ffff800008d0eea0 x16: ffff800008d07d44 x15: 
> ffff800008d0d154
> [    2.056647] usb 1-1: new high-speed USB device number 2 using 
> xhci-hcd
> [    2.058893] x14: ffff800008d0cddc x13: ffff8000088d1c2c x12: 
> ffff8000088d5034
> [    2.072597] x11: ffff8000088d46d4 x10: 0000000000000000 x9 : 
> ffff800008d0eea8
> [    2.079759] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : 
> ffff80000a0f53b8
> [    2.086921] x5 : ffff80000a22b960 x4 : 0000000000000000 x3 : 
> 0000000000000000
> [    2.094082] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 
> 01adb1adadadad80
> [    2.101244] Call trace:
> [    2.103692]  kfree+0x5c/0x3c0
> [    2.106666]  devm_thermal_of_zone_release+0x38/0x60
> [    2.111561]  release_nodes+0x64/0xd0
> [    2.115146]  devres_release_all+0xbc/0x350
> [    2.119253]  device_unbind_cleanup+0x20/0x70
> [    2.123536]  really_probe+0x1a0/0x2e4
> [    2.127208]  __driver_probe_device+0x80/0xec
> [    2.131490]  driver_probe_device+0x44/0x130
> [    2.135685]  __driver_attach+0x104/0x1b4
> [    2.139619]  bus_for_each_dev+0x7c/0xe0
> [    2.143465]  driver_attach+0x30/0x40
> [    2.147048]  bus_add_driver+0x160/0x210
> [    2.150894]  driver_register+0x84/0x140
> [    2.154741]  __platform_driver_register+0x34/0x40
> [    2.159461]  qoriq_tmu_init+0x28/0x34
> [    2.163133]  do_one_initcall+0x50/0x250
> [    2.166979]  kernel_init_freeable+0x278/0x31c
> [    2.171349]  kernel_init+0x30/0x140
> [    2.174847]  ret_from_fork+0x10/0x20
> [    2.178433] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
> [    2.184546] ---[ end trace 0000000000000000 ]---
> 
> Store the allocated resource pointers before the thermal zone is free
> and use them to release the resource after unregistering the thermal
> zone.
> 
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> ---
>  drivers/thermal/thermal_of.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c 
> b/drivers/thermal/thermal_of.c
> index 4210c18ef7b2..91ffe8f90a2d 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -596,11 +596,15 @@ static int thermal_of_unbind(struct
> thermal_zone_device *tz,
>   */
>  void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>  {
> +	struct thermal_trip *trips = tz->trips;
> +	struct thermal_zone_params *tzp = tz->tzp;
> +	struct thermal_zone_device_ops *ops = tz->ops;
> +

git am shows a trailing whitespace here

otherwise:
Tested-by: Michael Walle <michael@walle.cc>

(Yes, tested without the previous patches so the error actually happens 
;))

-michael
>  	thermal_zone_device_disable(tz);
>  	thermal_zone_device_unregister(tz);
> -	kfree(tz->trips);
> -	kfree(tz->tzp);
> -	kfree(tz->ops);
> +	kfree(trips);
> +	kfree(tzp);
> +	kfree(ops);
>  }
>  EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
