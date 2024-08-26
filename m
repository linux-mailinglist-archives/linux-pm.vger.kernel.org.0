Return-Path: <linux-pm+bounces-12869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937295EDD6
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 11:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888DC1F21E0D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A61465A9;
	Mon, 26 Aug 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxx5HHHI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154114659C;
	Mon, 26 Aug 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666307; cv=none; b=DJNo/YxXO0uWzpLOAuwj4YxP2SIDa0Zkf4mScJzh/MHqgOjSt5dya2fbzZnfOvDtQcvU4N3N/1nRKK015VB1LQRkDGjB8e/rkioWoxZaqLIO6zUU9MzDZ8pL4FVmNpRG3q8hxvdaZoDOtYgGErL0/HJwYuSDqSjOY/eeNvf0KB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666307; c=relaxed/simple;
	bh=3tJR/usZRWFc6I1sKQuKhNPlp5OZs0UlKa+WjgSjJzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlHGq0XbQhuHDjKVGXhroD9ZLQLLcFwm8o/gAT9zje2WEPCetiUhFJUh/dXPvhXVaY5bMMEBIjnmzxZwmUlUMokMQVrwnqVmgfC59MZ0amuH6aNAqCPCSrK1aV4K9DwcHjpxKef2Tizchny7YCUeorU4KjiP64S+NJo47Cy/mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxx5HHHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06ACC51404;
	Mon, 26 Aug 2024 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724666306;
	bh=3tJR/usZRWFc6I1sKQuKhNPlp5OZs0UlKa+WjgSjJzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gxx5HHHIgeHg+3w0jtG2B+fgi9D3+GJppTiU/ckNp0EYDLvaZp1z/VLmIhq2H6rRV
	 TD3i/FJbIZ8drsCYktYdwJB1qQ7OYUi1l3LlCXb01fF+g3MsyNQaxizsSSBq0XVKjP
	 lkMeOeiWb9JZ4S37qZ+o8BSmJcW7ZmKXaow26sTfZB2hqATLrJZ27UGyOmqn2pHbkU
	 AE9979FG01XGOswTrPppslBhegNFWjTMW+CHkyWQiof7jzxQUrvScpgx+pDunBaJgz
	 k5s0VwXgqGLURHkfVNTMnG4k5nlYlzqFpsR16agT7SdrR+s9yfYIxSdJ07fi3AUkW9
	 69OupUhLOUymw==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093b53f315so2538831a34.2;
        Mon, 26 Aug 2024 02:58:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWO9DfuIT4NJh1Mn5zLQtbvNZ1Jd+cw0BxIAhohmMQ+NFw7QmPQ7LPbw3AWlFc7GwGJ+1A8ijeHn0zmqEg=@vger.kernel.org, AJvYcCXJCLr5fw258t6WIwGZoYH9+RbqniwGHGS2f+YToPQ1fbGBwccqRL8DXR9QhUS8WPA5TrwTADzT2Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8i1gkVxFPWoXANYSl9PScCnJ9CaBHmXLx7H7cn4yR6GVAPclE
	6x3rXsACvU3LBb0p3Z7UyZfqWFMCu3xlOVNWtcGuHIE6xCRfnmz3NojfUJ6rKYD90dwFc5GEdIB
	SiJ6WKjzQLaZLi8P7Qc2XES3pwUc=
X-Google-Smtp-Source: AGHT+IEiBfBr6hnM5d2zLao9ZBJo6E+dVkNFr05a1RwXsbZioEGVN/T0oYb89eHC7trmZL4iHGUVp599AMeNHjn5O4M=
X-Received: by 2002:a05:6870:4409:b0:255:1819:b458 with SMTP id
 586e51a60fabf-273e63d6acbmr11205203fac.8.1724666305980; Mon, 26 Aug 2024
 02:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <ff528ebb-2c09-4b03-a641-4a306b31ff62@notapiano>
In-Reply-To: <ff528ebb-2c09-4b03-a641-4a306b31ff62@notapiano>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 11:58:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjt3ptZ8=qJcXagZfXrJbpcz7nDwZxRvg50PytdNScRQ@mail.gmail.com>
Message-ID: <CAJZ5v0gjt3ptZ8=qJcXagZfXrJbpcz7nDwZxRvg50PytdNScRQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] thermal: Rework binding cooling devices to trip points
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, regressions@lists.linux.dev, 
	kernelci@lists.linux.dev, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 8:45=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Mon, Aug 19, 2024 at 05:49:07PM +0200, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is one more update of
> >
> > https://lore.kernel.org/linux-pm/3134863.CbtlEUcBR6@rjwysocki.net/#r
> >
> > the cover letter of which was sent separately by mistake:
> >
> > https://lore.kernel.org/linux-pm/CAJZ5v0jo5vh2uD5t4GqBnN0qukMBG_ty33PB=
=3DNiEqigqxzBcsw@mail.gmail.com/
> >
> > and it has been updated once already:
> >
> > https://lore.kernel.org/linux-pm/114901234.nniJfEyVGO@rjwysocki.net/
> >
> > Relative to the v2 above it drops 3 patches, one because it was broken =
([04/17
> > in the v2), and two more that would need to be rebased significantly, e=
ither
> > because of dropping the other broken patch or because of the recent Ban=
g-bang
> > governor fixes:
> >
> > https://lore.kernel.org/linux-pm/1903691.tdWV9SEqCh@rjwysocki.net/
> >
> > The remaining 14 patches, 2 of which have been slightly rebased and the=
 rest
> > is mostly unchanged (except for some very minor subject and changelog f=
ixes),
> > is not expected to be controversial and are targeting 6.12, on top of t=
he
> > current linux-next material.
> >
> > The original motivation for this series quoted below has not changed:
> >
> >  The code for binding cooling devices to trip points (and unbinding the=
m from
> >  trip point) is one of the murkiest pieces of the thermal subsystem.  I=
t is
> >  convoluted, bloated with unnecessary code doing questionable things, a=
nd it
> >  works backwards.
> >
> >  The idea is to bind cooling devices to trip points in accordance with =
some
> >  information known to the thermal zone owner (thermal driver).  This in=
formation
> >  is not known to the thermal core when the thermal zone is registered, =
so the
> >  driver needs to be involved, but instead of just asking the driver whe=
ther
> >  or not the given cooling device should be bound to a given trip point,=
 the
> >  thermal core expects the driver to carry out all of the binding proces=
s
> >  including calling functions specifically provided by the core for this
> >  purpose which is cumbersome and counter-intuitive.
> >
> >  Because the driver has no information regarding the representation of =
the trip
> >  points at the core level, it is forced to walk them (and it has to avo=
id some
> >  locking traps while doing this), or it needs to make questionable assu=
mptions
> >  regarding the ordering of the trips in the core.  There are drivers do=
ing both
> >  these things.
> >
> > The first 5 patches in the series are preliminary.
> >
> > Patch [06/14] introduces a new .should_bind() callback for thermal zone=
s and
> > patches [07,09-12/14] modifies drivers to use it instead of the .bind()=
 and
> > .unbind() callbacks which allows them to be simplified quite a bit.
> >
> > The other patches [08,13-14/14] get rid of code that becomes unused aft=
er the
> > previous changes and do some cleanups on top of that.
> >
> > The entire series along with 2 patches on top of it (that were present =
in the
> > v2 of this set of patches) is available in the thermal-core-testing git=
 branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dthermal-core-testing
> >
> > (note that this branch is going to be rebased shortly on top of 6.11-rc=
4
> > and the thermal control material in linux-next).
> >
> > Thanks!
>
> Hi,
>
> KernelCI has identified a boot regression originating from this series. I=
've
> verified that reverting the series fixes the issue.

Thanks for the report!

There was a bug in the original patch [12/14] that would cause
symptoms like what you are observing to appear, which was reported on
Friday and has since been fixed in the tree.  Please see:

https://lore.kernel.org/linux-pm/CAJZ5v0iw7uXE_cfU5VXOjFDg9GM8Hu0+hKxqfzU3v=
0OM5KK9oQ@mail.gmail.com/

You probably have not tested the fixed tree yet, so please let
kernelci run again on it and if the issue is still there, please let
me know.


> Affected platforms:
> * mt8195-cherry-tomato-r2
> * mt8192-asurada-spherion-r0
> * mt8183-kukui-jacuzzi-juniper-sku16
> * mt8186-corsola-steelix-sku131072
> * sc7180-trogdor-kingoftown
> * sc7180-trogdor-lazor-limozeen
>
> Relevant log from mt8195-cherry-tomato-r2 (with additional debug configs
> enabled):
>
> [   11.326726] BUG: sleeping function called from invalid context at kern=
el/locking/rwsem.c:1578
> [   11.335294] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 165=
, name: udevd
> [   11.342944] preempt_count: 1, expected: 0
> [   11.346943] RCU nest depth: 0, expected: 0
> [   11.351028] 4 locks held by udevd/165:
> [   11.354766]  #0: ffff4dc8825db0f8 (&dev->mutex){....}-{3:3}, at: __dri=
ver_attach+0x130/0x4a8
> [   11.363207]  #1: ffffc208f386c3c8 (thermal_list_lock){+.+.}-{3:3}, at:=
 thermal_zone_device_register_with_trips+0x85c/0xcd8
> [   11.374248]  #2: ffff4dc7dc3586f0 (&tz->lock){+.+.}-{3:3}, at: thermal=
_zone_cdev_binding.part.0+0x98/0x280
> [   11.383896]  #3: ffffc208f39b7b78 (devtree_lock){....}-{2:2}, at: of_g=
et_next_child+0x2c/0xc4
> [   11.392418] irq event stamp: 173740
> [   11.395895] hardirqs last  enabled at (173739): [<ffffc208ecde804c>] _=
raw_spin_unlock_irqrestore+0x84/0x90
> [   11.405537] hardirqs last disabled at (173740): [<ffffc208ecde6f7c>] _=
raw_spin_lock_irqsave+0xe0/0xf4
> [   11.414742] softirqs last  enabled at (172404): [<ffffc208e978bb20>] h=
andle_softirqs+0x534/0x874
> [   11.423517] softirqs last disabled at (172393): [<ffffc208e961097c>] _=
_do_softirq+0x14/0x20
> [   11.431857] CPU: 5 UID: 0 PID: 165 Comm: udevd Not tainted 6.11.0-rc4-=
next-20240822-00002-gfbbbf9faa56a #628
> [   11.441670] Hardware name: Acer Tomato (rev2) board (DT)
> [   11.446970] Call trace:
> [   11.449407]  dump_backtrace+0x98/0xf0
> [   11.453059]  show_stack+0x18/0x24
> [   11.456364]  dump_stack_lvl+0x90/0xd0
> [   11.460018]  dump_stack+0x1c/0x28
> [   11.463322]  __might_resched+0x358/0x570
> [   11.467234]  __might_sleep+0xa4/0x16c
> [   11.470885]  down_write+0x8c/0x21c
> [   11.474277]  kernfs_remove+0x64/0x98
> [   11.477844]  sysfs_remove_dir+0xa8/0xe8
> [   11.481669]  __kobject_del+0xb0/0x27c
> [   11.485321]  kobject_release+0xfc/0x134
> [   11.489146]  kobject_put+0xb0/0x130
> [   11.492624]  of_node_put+0x18/0x28
> [   11.496016]  of_get_next_child+0x64/0xc4
> [   11.499929]  thermal_of_should_bind+0x154/0x390
> [   11.504449]  thermal_zone_cdev_binding.part.0+0x174/0x280
> [   11.509836]  thermal_zone_device_register_with_trips+0x914/0xcd8
> [   11.515831]  thermal_of_zone_register+0x284/0x464
> [   11.520523]  devm_thermal_of_zone_register+0x80/0xf4
> [   11.525476]  lvts_domain_init+0x500/0x760 [lvts_thermal]
> [   11.530785]  lvts_probe+0x1b4/0x3ac [lvts_thermal]
> [   11.535565]  platform_probe+0xc4/0x214
> [   11.539303]  really_probe+0x188/0x5d0
> [   11.542954]  __driver_probe_device+0x160/0x2e8
> [   11.547386]  driver_probe_device+0x5c/0x298
> [   11.551558]  __driver_attach+0x13c/0x4a8
> [   11.555470]  bus_for_each_dev+0xf8/0x180
> [   11.559383]  driver_attach+0x3c/0x58
> [   11.562947]  bus_add_driver+0x1c4/0x458
> [   11.566772]  driver_register+0xf4/0x3c0
> [   11.570598]  __platform_driver_register+0x60/0x88
> [   11.575291]  lvts_driver_init+0x20/0x1000 [lvts_thermal]
> [   11.580593]  do_one_initcall+0xcc/0x284
> [   11.584418]  do_init_module+0x278/0x740
> [   11.588244]  load_module+0xed8/0x1434
> [   11.591897]  init_module_from_file+0xdc/0x1fc
> [   11.596243]  idempotent_init_module+0x2bc/0x604
> [   11.600762]  __arm64_sys_finit_module+0xac/0x100
> [   11.605368]  invoke_syscall+0x6c/0x258
> [   11.609107]  el0_svc_common.constprop.0+0xac/0x230
> [   11.613886]  do_el0_svc+0x40/0x58
> [   11.617190]  el0_svc+0x48/0xb8
> [   11.620234]  el0t_64_sync_handler+0x100/0x12c
> [   11.624580]  el0t_64_sync+0x190/0x194
> [   11.628233]
> [   11.629713] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   11.633708] [ BUG: Invalid wait context ]
> [   11.637705] 6.11.0-rc4-next-20240822-00002-gfbbbf9faa56a #628 Tainted:=
 G        W
> [   11.645953] -----------------------------
> [   11.649950] udevd/165 is trying to lock:
> [   11.653859] ffff4dc880881148 (&root->kernfs_rwsem){++++}-{3:3}, at: ke=
rnfs_remove+0x64/0x98
> [   11.662200] other info that might help us debug this:
> [   11.667238] context-{4:4}
> [   11.669846] 4 locks held by udevd/165:
> [   11.673582]  #0: ffff4dc8825db0f8 (&dev->mutex){....}-{3:3}, at: __dri=
ver_attach+0x130/0x4a8
> [   11.682009]  #1: ffffc208f386c3c8 (thermal_list_lock){+.+.}-{3:3}, at:=
 thermal_zone_device_register_with_trips+0x85c/0xcd8
> [   11.693041]  #2: ffff4dc7dc3586f0 (&tz->lock){+.+.}-{3:3}, at: thermal=
_zone_cdev_binding.part.0+0x98/0x280
> [   11.702684]  #3: ffffc208f39b7b78 (devtree_lock){....}-{2:2}, at: of_g=
et_next_child+0x2c/0xc4
> [   11.711199] stack backtrace:
> [   11.714067] CPU: 5 UID: 0 PID: 165 Comm: udevd Tainted: G        W    =
      6.11.0-rc4-next-20240822-00002-gfbbbf9faa56a #628
> [   11.725355] Tainted: [W]=3DWARN
> [   11.728310] Hardware name: Acer Tomato (rev2) board (DT)
> [   11.733608] Call trace:
> [   11.736041]  dump_backtrace+0x98/0xf0
> [   11.739692]  show_stack+0x18/0x24
> [   11.742994]  dump_stack_lvl+0x90/0xd0
> [   11.746645]  dump_stack+0x1c/0x28
> [   11.749948]  __lock_acquire+0x10f8/0x2710
> [   11.753948]  lock_acquire.part.0+0x218/0x518
> [   11.758206]  lock_acquire+0x90/0xb4
> [   11.761683]  down_write+0xb4/0x21c
> [   11.765074]  kernfs_remove+0x64/0x98
> [   11.768637]  sysfs_remove_dir+0xa8/0xe8
> [   11.772461]  __kobject_del+0xb0/0x27c
> [   11.776111]  kobject_release+0xfc/0x134
> [   11.779935]  kobject_put+0xb0/0x130
> [   11.783413]  of_node_put+0x18/0x28
> [   11.786803]  of_get_next_child+0x64/0xc4
> [   11.790714]  thermal_of_should_bind+0x154/0x390
> [   11.795231]  thermal_zone_cdev_binding.part.0+0x174/0x280
> [   11.800617]  thermal_zone_device_register_with_trips+0x914/0xcd8
> [   11.806609]  thermal_of_zone_register+0x284/0x464
> [   11.811301]  devm_thermal_of_zone_register+0x80/0xf4
> [   11.816253]  lvts_domain_init+0x500/0x760 [lvts_thermal]
> [   11.821553]  lvts_probe+0x1b4/0x3ac [lvts_thermal]
> [   11.826332]  platform_probe+0xc4/0x214
> [   11.830069]  really_probe+0x188/0x5d0
> [   11.833719]  __driver_probe_device+0x160/0x2e8
> [   11.838150]  driver_probe_device+0x5c/0x298
> [   11.842320]  __driver_attach+0x13c/0x4a8
> [   11.846230]  bus_for_each_dev+0xf8/0x180
> [   11.850141]  driver_attach+0x3c/0x58
> [   11.853704]  bus_add_driver+0x1c4/0x458
> [   11.857529]  driver_register+0xf4/0x3c0
> [   11.861352]  __platform_driver_register+0x60/0x88
> [   11.866043]  lvts_driver_init+0x20/0x1000 [lvts_thermal]
> [   11.871342]  do_one_initcall+0xcc/0x284
> [   11.875166]  do_init_module+0x278/0x740
> [   11.878990]  load_module+0xed8/0x1434
> [   11.882641]  init_module_from_file+0xdc/0x1fc
> [   11.886986]  idempotent_init_module+0x2bc/0x604
> [   11.891504]  __arm64_sys_finit_module+0xac/0x100
> [   11.896109]  invoke_syscall+0x6c/0x258
> [   11.899846]  el0_svc_common.constprop.0+0xac/0x230
> [   11.904624]  do_el0_svc+0x40/0x58
> [   11.907927]  el0_svc+0x48/0xb8
> [   11.910969]  el0t_64_sync_handler+0x100/0x12c
> [   11.915314]  el0t_64_sync+0x190/0x194
> [   36.261761] watchdog: Watchdog detected hard LOCKUP on cpu 0
> [   36.267414] Modules linked in: cbmem cros_ec_lid_angle cros_ec_sensors=
(+) cros_ec_sensors_core pcie_mediatek_gen3 sbs_battery cros_kbd_led_backli=
ght industrialio_triggered_buffer kfifo_buf cros_ec_chardev cros_ec_rpmsg l=
vts_thermal(+) cros_ec_typec leds_cros_ec mtk_svs snd_sof_mt8195 mtk_adsp_c=
ommon snd_sof_xtensa_dsp snd_sof_of mt6577_auxadc snd_soc_mt8195_afe snd_so=
f snd_sof_utils mtk_scp mtk_rpmsg mtk_scp_ipi pwm_bl mtk_wdt coreboot_table=
 backlight mt8195_mt6359 ramoops reed_solomon
> [   36.310414] irq event stamp: 197347
> [   36.313890] hardirqs last  enabled at (197347): [<ffffc208ecdc994c>] e=
xit_to_kernel_mode+0x38/0x118
> [   36.322923] hardirqs last disabled at (197346): [<ffffc208ecdcac44>] e=
l1_interrupt+0x24/0x54
> [   36.331347] softirqs last  enabled at (197268): [<ffffc208e978bb20>] h=
andle_softirqs+0x534/0x874
> [   36.340117] softirqs last disabled at (197263): [<ffffc208e961097c>] _=
_do_softirq+0x14/0x20
>
> Full log at http://0x0.st/XyID.txt
>
> Let me know if you need any more information.
>
> #regzbot introduced: next-20240821..next-20240822
> #regzbot title: Hang during boot in sysfs_remove_dir() called by thermal_=
of_zone_register()
>
> Thanks,
> N=C3=ADcolas
>

