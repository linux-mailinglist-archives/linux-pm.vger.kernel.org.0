Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3142C1BE506
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2RVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2RVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 13:21:01 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Apr 2020 10:21:01 PDT
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498CFC035493
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 10:21:01 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:182a:142e:a95f:66c2])
        by baptiste.telenet-ops.be with bizsmtp
        id YhFx2200E0w8ZL601hFxGf; Wed, 29 Apr 2020 19:15:57 +0200
Received: from geert (helo=localhost)
        by ramsan with local-esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jTqJR-0005gr-93; Wed, 29 Apr 2020 19:15:57 +0200
Date:   Wed, 29 Apr 2020 19:15:57 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     =?ISO-8859-15?Q?Niklas_S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: tmio: undo PM autosuspend when removing the
 host
In-Reply-To: <20190109223452.11184-2-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <alpine.DEB.2.21.2004291630090.4052@ramsan.of.borg>
References: <20190109223452.11184-1-niklas.soderlund+renesas@ragnatech.se> <20190109223452.11184-2-niklas.soderlund+renesas@ragnatech.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1654730921-1588180557=:4052"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1654730921-1588180557=:4052
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Niklas,

On Wed, 9 Jan 2019, Niklas Söderlund wrote:
> When removing the driver make sure to undo the PM autosuspend configured
> when probing the host.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is commit bb60023c6387842b ("mmc: tmio: undo PM autosuspend when
removing the host"), and I've bisected a regression to it.
Sorry for taking that long to discover this issue (by loading a DT
overlay to enable SCIFA5 on Koelsch, which requires unbinding SHDI0
first).

> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1287,6 +1287,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
> 	cancel_delayed_work_sync(&host->delayed_reset_work);
> 	tmio_mmc_release_dma(host);
>
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> 	pm_runtime_put_sync(&pdev->dev);
> 	pm_runtime_disable(&pdev->dev);
> }

When unbinding the sdhi driver on e.g. Koelsch or Salvator-XS:

     echo ee100000.sd > /sys/bus/platform/drivers/sh_mobile_sdhi/unbind
     echo ee100000.sd > /sys/bus/platform/drivers/renesas_sdhi_internal_dmac/unbind

Two warnings are triggered:

     WARNING: CPU: 0 PID: 586 at drivers/clk/clk.c:954 clk_core_disable+0x40/0x214
     sdhi0 already disabled
     CPU: 0 PID: 586 Comm: bash Not tainted 5.7.0-rc3-shmobile-00508-g3c2c87c467f1c34e-dirty #547
     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
     [<c010de5c>] (unwind_backtrace) from [<c0109cbc>] (show_stack+0x10/0x14)
     [<c0109cbc>] (show_stack) from [<c072d5ac>] (dump_stack+0x88/0xa8)
     [<c072d5ac>] (dump_stack) from [<c011c190>] (__warn+0xd0/0xec)
     [<c011c190>] (__warn) from [<c011c21c>] (warn_slowpath_fmt+0x70/0x9c)
     [<c011c21c>] (warn_slowpath_fmt) from [<c03a09e4>] (clk_core_disable+0x40/0x214)
     [<c03a09e4>] (clk_core_disable) from [<c03a0bd0>] (clk_core_disable_lock+0x18/0x24)
     [<c03a0bd0>] (clk_core_disable_lock) from [<c059e910>] (renesas_sdhi_clk_disable+0x14/0x34)
     [<c059e910>] (renesas_sdhi_clk_disable) from [<c059f2fc>] (renesas_sdhi_remove+0x18/0x20)
     [<c059f2fc>] (renesas_sdhi_remove) from [<c043c054>] (platform_drv_remove+0x24/0x3c)
     [<c043c054>] (platform_drv_remove) from [<c043afb4>] (device_release_driver_internal+0xf0/0x198)
     [<c043afb4>] (device_release_driver_internal) from [<c0439140>] (unbind_store+0x44/0x68)
     [<c0439140>] (unbind_store) from [<c02941fc>] (kernfs_fop_write+0x128/0x1e4)
     [<c02941fc>] (kernfs_fop_write) from [<c0225598>] (__vfs_write+0x28/0xe0)
     [<c0225598>] (__vfs_write) from [<c0226664>] (vfs_write+0x98/0xbc)
     [<c0226664>] (vfs_write) from [<c02267ec>] (ksys_write+0x68/0xb4)
     [<c02267ec>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x54)

     ...
 	WARNING: CPU: 0 PID: 586 at drivers/clk/clk.c:813 clk_core_unprepare+0x40/0x108
     sdhi0 already unprepared
     CPU: 0 PID: 586 Comm: bash Tainted: G        W         5.7.0-rc3-shmobile-00508-g3c2c87c467f1c34e-dirty #547
     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
     [<c010de5c>] (unwind_backtrace) from [<c0109cbc>] (show_stack+0x10/0x14)
     [<c0109cbc>] (show_stack) from [<c072d5ac>] (dump_stack+0x88/0xa8)
     [<c072d5ac>] (dump_stack) from [<c011c190>] (__warn+0xd0/0xec)
     [<c011c190>] (__warn) from [<c011c21c>] (warn_slowpath_fmt+0x70/0x9c)
     [<c011c21c>] (warn_slowpath_fmt) from [<c03a1150>] (clk_core_unprepare+0x40/0x108)
     [<c03a1150>] (clk_core_unprepare) from [<c03a2d34>] (clk_unprepare+0x24/0x2c)
     [<c03a2d34>] (clk_unprepare) from [<c044e244>] (__pm_clk_remove+0x38/0x54)
     [<c044e244>] (__pm_clk_remove) from [<c044e6cc>] (pm_clk_destroy+0xc4/0xdc)
     [<c044e6cc>] (pm_clk_destroy) from [<c044c4ec>] (genpd_remove_device+0x10c/0x128)
     [<c044c4ec>] (genpd_remove_device) from [<c044c54c>] (genpd_dev_pm_detach+0x44/0xe4)
     [<c044c54c>] (genpd_dev_pm_detach) from [<c043c064>] (platform_drv_remove+0x34/0x3c)
     [<c043c064>] (platform_drv_remove) from [<c043afb4>] (device_release_driver_internal+0xf0/0x198)
     [<c043afb4>] (device_release_driver_internal) from [<c0439140>] (unbind_store+0x44/0x68)
     [<c0439140>] (unbind_store) from [<c02941fc>] (kernfs_fop_write+0x128/0x1e4)
     [<c02941fc>] (kernfs_fop_write) from [<c0225598>] (__vfs_write+0x28/0xe0)
     [<c0225598>] (__vfs_write) from [<c0226664>] (vfs_write+0x98/0xbc)
     [<c0226664>] (vfs_write) from [<c02267ec>] (ksys_write+0x68/0xb4)
     [<c02267ec>] (ksys_write) from [<c0100060>] (ret_fast_syscall+0x0/0x54)

Removing the call to pm_runtime_dont_use_autosuspend() fixes that
symptom.  But that is definitely not the right fix, as doing so causes
genpd_stop_dev() to no longer being called on unbind.

What seems to happen is:
   - During driver probe, the clocks are enabled twice, by
       1. renesas_sdhi_clk_enable(), called from renesas_sdhi_probe(),
       2. pm_clk_resume(), called from tmio_mmc_host_probe().
   - During driver unbind, the clocks are disabled thrice, by:
       1. renesas_sdhi_clk_disable(), called from
          tmio_mmc_host_runtime_suspend(),
       2. pm_clk_suspend(), called from tmio_mmc_host_remove() through
          pm_runtime_put_sync(),
       3. renesas_sdhi_clk_disable(), called from renesas_sdhi_remove().
     In addition, an extra clock unprepare happens in __pm_clk_remove(),
     called from genpd_remove_device() through pm_clk_destroy().

Note that tmio_mmc_host_runtime_suspend() is never called, so there is
definitely an imbalance in the Runtime PM handling..

Without the call to pm_runtime_dont_use_autosuspend(), the clocks are
disabled twice during driver unbind, by:
   1. renesas_sdhi_clk_disable(), called from renesas_sdhi_remove(),
   2. __pm_clk_remove(), called from genpd_remove_device() through
      pm_clk_destroy().
Hence the warning is gone, by accident, as e.g. the pm_clk_resume() call is
never balanced by its counterpart pm_clk_suspend().

Thanks for your comments!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-1654730921-1588180557=:4052--
