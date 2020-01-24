Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43934148624
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbgAXNaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 08:30:20 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:42548 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbgAXNaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 08:30:19 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id uDW42100T5USYZQ01DW4BW; Fri, 24 Jan 2020 14:30:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iuz2C-0007bG-Cp; Fri, 24 Jan 2020 14:30:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iuz2C-00047A-AH; Fri, 24 Jan 2020 14:30:04 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] Fix debugfs register access while suspended
Date:   Fri, 24 Jan 2020 14:29:55 +0100
Message-Id: <20200124132957.15769-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

	Hi all,

While comparing register values read from debugfs files under
/sys/kernel/debug/ccree/, I noticed some oddities.
Apparently there is no guarantee these registers are read from the
device while it is resumed.  This may lead to bogus values, or crashes
and lock-ups.

This patch series:
  1. Allows debugfs_create_regset32() to be used for devices whose
     registers must be accessed when resumed,
  2. Fixes the CCREE driver to make use of this.

I have identified several other drivers that may be affected (i.e.
using debugfs_create_regset32() and pm_runtime_*()):
  - drivers/gpu/drm/msm/disp/dpu1
  - drivers/usb/dwc3
  - drivers/usb/host/ehci-omap.c
  - drivers/usb/host/ehci-tegra.c
  - drivers/usb/host/ohci-platform.c
  - drivers/usb/host/xhci.c
  - drivers/usb/host/xhci-dbgcap.c
  - drivers/usb/host/xhci-histb.c
  - drivers/usb/host/xhci-hub.c
  - drivers/usb/host/xhci-mtk.c
  - drivers/usb/host/xhci-pci.c
  - drivers/usb/host/xhci-plat.c
  - drivers/usb/host/xhci-tegra.c
  - drivers/usb/mtu3
  - drivers/usb/musb

Some of these call pm_runtime_forbid(), but given the comment "users
should enable runtime pm using power/control in sysfs", this can be
overridden from userspace, so these are unsafe, too?

Thanks for your comments!

Geert Uytterhoeven (2):
  debugfs: regset32: Add Runtime PM support
  crypto: ccree - fix debugfs register access while suspended

 drivers/crypto/ccree/cc_debugfs.c | 2 ++
 fs/debugfs/file.c                 | 8 ++++++++
 include/linux/debugfs.h           | 1 +
 3 files changed, 11 insertions(+)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
