Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1691C8838
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGLaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEGLaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 07:30:14 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD7C05BD12
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 04:30:13 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:6572:4a1f:d283:9ae8])
        by xavier.telenet-ops.be with bizsmtp
        id bnW3220043ZRV0X01nW3Ki; Thu, 07 May 2020 13:30:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWej4-0006zG-Vp; Thu, 07 May 2020 13:30:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWej4-00068L-UG; Thu, 07 May 2020 13:30:02 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] qoriq: Add platform dependencies
Date:   Thu,  7 May 2020 13:29:51 +0200
Message-Id: <20200507112955.23520-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

	Hi all,

Several QorIQ blocks are only present on Freescale or NXP SoCs.
This series adds platform dependencies to the corresponding config
ymbols, to avoid asking the user about them when configuring a kernel
without support for these SoCs.

Most patches in this series are independent, but the third patch may
cause some Kconfig warnings when applied before the second patch, and
enabling the QorIQ CPU frequency scaling driver in a non-Layerscape
kernel.

Thanks for your comments!

Geert Uytterhoeven (4):
  ahci: qoriq: Add platform dependencies
  cpufreq: qoriq: Add platform dependencies
  clk: qoriq: Add platform dependencies
  thermal: qoriq: Add platform dependencies

 drivers/ata/Kconfig     | 1 +
 drivers/clk/Kconfig     | 3 ++-
 drivers/cpufreq/Kconfig | 3 ++-
 drivers/thermal/Kconfig | 4 ++--
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
