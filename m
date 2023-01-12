Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A17668632
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 22:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjALVvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 16:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbjALVto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 16:49:44 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77266DFD
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 13:44:13 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 68AABCD139;
        Thu, 12 Jan 2023 21:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1673559821; bh=OvAUROFUHsSXVKTWEJjt7eisHUhHtgruEGm/AB50W+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B6QHQhCGerY1b8oHcksVhBObwnSVKWMBbQzqxPvEw78zgAQ8oaUN0NETLoRDR0y06
         dXIvQF0uV/2mZdXpnSOUBOSrmZuRb+lppeBju/XLQsmFdOrQT9ZYFUkKd/Ku8JdhBf
         WQn/UaXFF5B+h9w87hyatjEJZWxV6i74+a0fKV1Q=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Date:   Thu, 12 Jan 2023 22:43:40 +0100
Message-ID: <5894723.lOV4Wx5bFT@g550jk>
In-Reply-To: <20230112154721.452292-1-caleb.connolly@linaro.org>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Donnerstag, 12. J=E4nner 2023 16:47:20 CET Caleb Connolly wrote:
> There is in invalid call to thermal_cooling_device_destroy_sysfs() and
> another to put_device() in the error paths here. Fix them.
>=20
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

=46ixes attached warnings on boot on qcom-apq8026-lg-lenok (with smbb drive=
r)

Tested-by: Luca Weiss <luca@z3ntu.xyz>

[    2.095494] qcom-smbb fc4cf000.spmi:pm8226@0:charger@1000: Initializing =
SMBB rev 1
[    2.097362] ------------[ cut here ]------------
[    2.103582] WARNING: CPU: 0 PID: 1 at lib/kobject.c:718 kobject_put+0xcc=
/0x130
[    2.108393] kobject: '(null)' ((ptrval)): is not initialized, yet kobjec=
t_put() is being called.
[    2.115406] Modules linked in:
[    2.124340] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3-00011-gd=
6a0fe8a370f #229
[    2.127151] Hardware name: Generic DT based system
[    2.135394]  unwind_backtrace from show_stack+0x10/0x14
[    2.139988]  show_stack from dump_stack_lvl+0x40/0x4c
[    2.145111]  dump_stack_lvl from __warn+0x78/0x158
[    2.150317]  __warn from warn_slowpath_fmt+0x98/0xc8
[    2.155006]  warn_slowpath_fmt from kobject_put+0xcc/0x130
[    2.160128]  kobject_put from __thermal_cooling_device_register.part.0+0=
xf8/0x388
[    2.165432]  __thermal_cooling_device_register.part.0 from __power_suppl=
y_register+0x43c/0x534
[    2.172986]  __power_supply_register from devm_power_supply_register+0x5=
4/0x90
[    2.181489]  devm_power_supply_register from smbb_charger_probe+0x278/0x=
614
[    2.188690]  smbb_charger_probe from platform_probe+0x5c/0xb0
[    2.195546]  platform_probe from really_probe+0xc8/0x2ec
[    2.201447]  really_probe from __driver_probe_device+0x84/0xe4
[    2.206830]  __driver_probe_device from driver_probe_device+0x30/0x104
[    2.212474]  driver_probe_device from __driver_attach+0x90/0x174
[    2.218983]  __driver_attach from bus_for_each_dev+0x7c/0xc4
[    2.225145]  bus_for_each_dev from bus_add_driver+0x164/0x1f0
[    2.230789]  bus_add_driver from driver_register+0x88/0x11c
[    2.236429]  driver_register from do_one_initcall+0x5c/0x274
[    2.241812]  do_one_initcall from kernel_init_freeable+0x1a8/0x204
[    2.247717]  kernel_init_freeable from kernel_init+0x18/0x130
[    2.253704]  kernel_init from ret_from_fork+0x14/0x2c
[    2.259517] Exception stack(0xd0815fb0 to 0xd0815ff8)
[    2.264555] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    2.269604] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    2.277762] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.286024] ---[ end trace 0000000000000000 ]---
[    2.292369] ------------[ cut here ]------------
[    2.297253] WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 __thermal_coolin=
g_device_register.part.0+0xf8/0x388
[    2.301844] refcount_t: underflow; use-after-free.
[    2.311337] Modules linked in:
[    2.316178] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6=
=2E2.0-rc3-00011-gd6a0fe8a370f #229
[    2.319168] Hardware name: Generic DT based system
[    2.328789]  unwind_backtrace from show_stack+0x10/0x14
[    2.333478]  show_stack from dump_stack_lvl+0x40/0x4c
[    2.338598]  dump_stack_lvl from __warn+0x78/0x158
[    2.343806]  __warn from warn_slowpath_fmt+0x98/0xc8
[    2.348494]  warn_slowpath_fmt from __thermal_cooling_device_register.pa=
rt.0+0xf8/0x388
[    2.353626]  __thermal_cooling_device_register.part.0 from __power_suppl=
y_register+0x43c/0x534
[    2.361354]  __power_supply_register from devm_power_supply_register+0x5=
4/0x90
[    2.370030]  devm_power_supply_register from smbb_charger_probe+0x278/0x=
614
[    2.377231]  smbb_charger_probe from platform_probe+0x5c/0xb0
[    2.384086]  platform_probe from really_probe+0xc8/0x2ec
[    2.389987]  really_probe from __driver_probe_device+0x84/0xe4
[    2.395371]  __driver_probe_device from driver_probe_device+0x30/0x104
[    2.401015]  driver_probe_device from __driver_attach+0x90/0x174
[    2.407524]  __driver_attach from bus_for_each_dev+0x7c/0xc4
[    2.413686]  bus_for_each_dev from bus_add_driver+0x164/0x1f0
[    2.419329]  bus_add_driver from driver_register+0x88/0x11c
[    2.424971]  driver_register from do_one_initcall+0x5c/0x274
[    2.430353]  do_one_initcall from kernel_init_freeable+0x1a8/0x204
[    2.436257]  kernel_init_freeable from kernel_init+0x18/0x130
[    2.442245]  kernel_init from ret_from_fork+0x14/0x2c
[    2.448059] Exception stack(0xd0815fb0 to 0xd0815ff8)
[    2.453097] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    2.458145] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    2.466303] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.474560] ---[ end trace 0000000000000000 ]---
[    2.481478] qcom-smbb fc4cf000.spmi:pm8226@0:charger@1000: failed to reg=
ister USB power supply
[    2.485838] qcom-smbb: probe of fc4cf000.spmi:pm8226@0:charger@1000 fail=
ed with error -11

Regards
Luca

> ---
> Changes since v2:
>  * Rework and simplify into one patch following Yang's suggestions.
>=20
> V2:
> https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro=
=2Eo
> rg/ ---
>  drivers/thermal/thermal_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index f17ab2316dbd..321d2a6300c4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -909,15 +909,16 @@ __thermal_cooling_device_register(struct device_node
> *np, cdev->devdata =3D devdata;
>=20
>  	ret =3D cdev->ops->get_max_state(cdev, &cdev->max_state);
> -	if (ret)
> -		goto out_kfree_type;
> +	if (ret) {
> +		kfree(cdev->type);
> +		goto out_ida_remove;
> +	}
>=20
>  	thermal_cooling_device_setup_sysfs(cdev);
>  	ret =3D dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -	if (ret) {
> -		thermal_cooling_device_destroy_sysfs(cdev);
> +	if (ret)
>  		goto out_kfree_type;
> -	}
> +
>  	ret =3D device_register(&cdev->device);
>  	if (ret)
>  		goto out_kfree_type;




