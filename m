Return-Path: <linux-pm+bounces-39914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216ECDC279
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C32300A346
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63153346A5;
	Wed, 24 Dec 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP9aJI8e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE231B81B
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766576708; cv=none; b=kMkuFvLGpD3CU5vb3V9bDQkM1ol9fV8xYEqYkj55rltw8DzdZS2J6jJWQzdpH7mE4pOpdSdngKr2hvhvXO/Jii649Kg+0paaxQ4FRi0d9FaJYOORQEPa5X7DnrGjvHmVLHgxV/DtogVw5tPvYwbJUuoxoLwM4OlvNpIxt1ThWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766576708; c=relaxed/simple;
	bh=3BV0jKjx1on246YjKv71sRz1ldolo7+vNMC9Adftz7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsrwbVb08eMNYV/TcB27wZPrb60rfVnZPE/gABJ/KrjE8lEq3WDVXJsVaIMTt7lL+GKKa4GZuiluU0lL2Eg1uPqPYWdMjGwHKVJNKFtC3sUooCX9bVcLm+yskQc8ZgtiVXm9qsCPFet/4wjf3kTWHul9CbxYnbMCdMfUkY8l2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP9aJI8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF682C19423
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766576708;
	bh=3BV0jKjx1on246YjKv71sRz1ldolo7+vNMC9Adftz7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hP9aJI8esHY/lGvIuAxzNfQNXyBKRRdiXjxf1ZVUEqj3FHzbhEkUWqKQ9l3Jl7zPf
	 PKDpqHzty6UQX9+ck92Yjoqufq7OpdcN/W/6hIWEwZzgWv9bWnuKXDDj/3FnlKshDs
	 xQuvGvE1DpwwsIXrjNyKTOqF3NC5ZNP1FIdf6yT86JPPac9CdE6sp5giE4eg4vPAiT
	 OWda/6ak2JHPPag+r07p++gWvBKvYD73il60Qp1kYGlDWiBXC2VrrILBtwx27/MJzG
	 yWw84cvHqdcs4shIfpJen61qSSs+Y7cZdLeTHip9J1k4nMYKFhsogBcTzHa10hUh0o
	 IHKymG/yxeYGQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45391956bfcso4715938b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 03:45:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVK/wKWHE0GJaEiXHyjkiwx0O7nxjpfxHWuX5vem15SIB8q4Xqs375b8SR5IyV7BnK8HU+mcZnr8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuV30J3WVR5Fd/vyYoFKnucu4yS03/hs5B6fhRrEMqRr4oL14J
	Ys7Cv022oTv1zp8nO6tNwEFtU7iOqQYZ9dMxSbboyW6+bdwLbKR8rZS6ZWAvCKXjrVf5jPMNZij
	W3pFRa8aPvZDDPEudyaXM1k8ag/gso3Y=
X-Google-Smtp-Source: AGHT+IH8bs0hnvwab8a8QE4izhwJUAnePBHPRnVYLnQWXJxry4ZCwizRGyWMTQYslki3UIz+IKX5+SpJmw4xSp96s7E=
X-Received: by 2002:a05:6820:1501:b0:659:9a49:8f94 with SMTP id
 006d021491bc7-65d0e9fdfc8mr5714162eaf.13.1766576707003; Wed, 24 Dec 2025
 03:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113012638.1362013-1-luriwen@kylinos.cn> <CAJZ5v0hwhVO6J2nS2-byU0+Lm8QbzdBzv4-X4eLNNUpTg+41Kg@mail.gmail.com>
 <aUsAk0k1N9hw8IkY@venus>
In-Reply-To: <aUsAk0k1N9hw8IkY@venus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Dec 2025 12:44:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jha1VEHGfqYfu1G9WCwPEM=kDa-_c1LqchnkxAWbCBiw@mail.gmail.com>
X-Gm-Features: AQt7F2ooQZ3bsUw0m64FunF4PQllQzkZZcoMIET_xTHQws74R8oxowivBi_Jq5k
Message-ID: <CAJZ5v0jha1VEHGfqYfu1G9WCwPEM=kDa-_c1LqchnkxAWbCBiw@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v3] PM: suspend: Make pm_test delay
 interruptible by wakeup events
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Riwen Lu <luriwen@kylinos.cn>, pavel@kernel.org, 
	lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiongxin <xiongxin@kylinos.cn>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 10:09=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Fri, Nov 14, 2025 at 05:11:16PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 13, 2025 at 2:26=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> w=
rote:
> > >
> > > Modify the suspend_test() function to make the test delay can be
> > > interrupted by wakeup events.
> > >
> > > This improves the responsiveness of the system during suspend testing
> > > when wakeup events occur, allowing the suspend process to proceed
> > > without waiting for the full test delay to complete when wakeup event=
s
> > > are detected.
> > >
> > > Additionally, using msleep() instead of mdelay() avoids potential sof=
t
> > > lockup "CPU stuck" issues when long test delays are configured.
> > >
> > > Co-developed-by: xiongxin <xiongxin@kylinos.cn>
> > > Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> > > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> > > ---
> > >  kernel/power/suspend.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > index b4ca17c2fecf..1c2f777da367 100644
> > > --- a/kernel/power/suspend.c
> > > +++ b/kernel/power/suspend.c
> > > @@ -344,10 +344,14 @@ MODULE_PARM_DESC(pm_test_delay,
> > >  static int suspend_test(int level)
> > >  {
> > >  #ifdef CONFIG_PM_DEBUG
> > > +       int i;
> > > +
> > >         if (pm_test_level =3D=3D level) {
> > >                 pr_info("suspend debug: Waiting for %d second(s).\n",
> > >                                 pm_test_delay);
> > > -               mdelay(pm_test_delay * 1000);
> > > +               for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending=
(); i++)
> > > +                       msleep(1000);
> > > +
> > >                 return 1;
> > >         }
> > >  #endif /* !CONFIG_PM_DEBUG */
> > > --
> >
> > Applied as 6.19 material, thanks!
>
> This is now upstream as a10ad1b10402 ("PM: suspend: Make pm_test delay in=
terruptible by wakeup events").
> When doing the following PM debugging test on ROCK 4D on v6.19-rc2
>
> echo N > /sys/module/printk/parameters/console_suspend
> echo 1 > /sys/power/pm_print_times
> echo 1 > /sys/power/pm_debug_messages
> echo core > /sys/power/pm_test
> echo mem > /sys/power/state
>
> I see the following error triggered reliably, which did not happen on 6.1=
8
> and no longer appears after reverting this patch:
>
> [   49.647656] ------------[ cut here ]------------
> [   49.647656] WARNING: kernel/time/timekeeping.c:821 at ktime_get+0xb8/0=
xd8, CPU#0: swapper/0/0
> [   49.647656] Modules linked in: sha256 cfg80211 binfmt_misc fuse ipv6 s=
nd_soc_hdmi_codec rk805_pwrkey rockchip_saradc dwmac_rk stmmac_platform rtc=
_hym8563 snd_soc_es8328_i2c phy_rockchip_usbdp rockchipdrm stmmac snd_soc_e=
s8328 dw_hdmi_qp industrialio_triggered_buffer analogix_dp typec phy_rockch=
ip_samsung_hdptx kfifo_buf dw_dp rockchip_thermal dw_mipi_dsi spi_rockchip_=
sfc phy_rockchip_naneng_combphy pcs_xpcs panfrost drm_shmem_helper gpu_sche=
d snd_soc_rockchip_sai snd_soc_simple_card drm_dp_aux_bus dw_hdmi snd_soc_s=
imple_card_utils rfkill_gpio rfkill snd_soc_core drm_display_helper snd_com=
press cec drm_client_lib drm_dma_helper display_connector snd_pcm_dmaengine=
 drm_kms_helper snd_pcm drm snd_timer snd backlight soundcore adc_keys
> [   49.647656] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc=
2-g7211b2cf9c08 #1 PREEMPT
> [   49.647656] Hardware name: Radxa ROCK 4D (DT)
> [   49.647656] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   49.647656] pc : ktime_get+0xb8/0xd8
> [   49.647656] lr : tick_nohz_idle_enter+0x50/0x90
> [   49.647656] sp : ffffc1a17b573d50
> [   49.647656] x29: ffffc1a17b573d50 x28: 00000000fdf57ec0 x27: ffffc1a17=
b57b260
> [   49.647656] x26: ffffc1a17b57e000 x25: 0000000000000000 x24: 000000000=
00000ea
> [   49.647656] x23: ffffc1a17a470000 x22: ffffc1a17b57ad00 x21: ffff3e628=
2a25000
> [   49.647656] x20: ffff0003fdead5d8 x19: ffffc1a17b4885d8 x18: 000000000=
000000a
> [   49.647656] x17: ffff3e6282a25000 x16: ffff800080000000 x15: 00700ea23=
1d1d404
> [   49.647656] x14: 0000000000000396 x13: 0000000000000001 x12: 000000000=
0000001
> [   49.647656] x11: 00000000000000c0 x10: 0000000000000aa0 x9 : ffffc1a17=
b573d00
> [   49.647656] x8 : ffffc1a17b586680 x7 : 0000000000000000 x6 : 000000000=
0000000
> [   49.647656] x5 : 0000000000000004 x4 : ffffc1a17b57eb68 x3 : 000000000=
0000000
> [   49.647656] x2 : ffffc1a17b48ec40 x1 : 0000000000000000 x0 : 000000000=
0000001
> [   49.647656] Call trace:
> [   49.647656]  ktime_get+0xb8/0xd8 (P)
> [   49.647656]  tick_nohz_idle_enter+0x50/0x90
> [   49.647656]  do_idle+0x38/0x260
> [   49.647656]  cpu_startup_entry+0x38/0x40
> [   49.647656]  rest_init+0xd8/0xe0
> [   49.647656]  console_on_rootfs+0x0/0x6c
> [   49.647656]  __primary_switched+0x88/0x90
> [   49.647656] ---[ end trace 0000000000000000 ]---

msleep() is not suitable for the "core" level testing.

Change msleep() in suspend_test() back to mdelay() and the backtrace
should go away.

I'll send a patch for that later this week unless someone beats me to it.

