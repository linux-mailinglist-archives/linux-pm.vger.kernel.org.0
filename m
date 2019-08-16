Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7B901FF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfHPMw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 08:52:28 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:40008 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHPMw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 08:52:28 -0400
Received: from ramsan ([84.194.98.4])
        by albert.telenet-ops.be with bizsmtp
        id posT2000405gfCL06osTCy; Fri, 16 Aug 2019 14:52:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybiU-0005JA-Ug; Fri, 16 Aug 2019 14:52:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybiU-0004Bs-ST; Fri, 16 Aug 2019 14:52:26 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] clk: renesas: Set GENPD_FLAG_ALWAYS_ON for clock domain
Date:   Fri, 16 Aug 2019 14:52:22 +0200
Message-Id: <20190816125225.16061-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

	Hi Mike, Stephen,

The Renesas Clock Domain drivers do not implement the
generic_pm_domain.power_{on,off}() callbacks, as the domains themselves
cannot be powered down.  Hence the domains should be marked as always-on
by setting the GENPD_FLAG_ALWAYS_ON flag.

This patch series that issue for R-Car M1A, RZ/A1, RZ/A2, and
RZ/N1 SoCs.
SH/R-Mobile SoCs are fixed in "[PATCH] soc: renesas: rmobile-sysc: Set
GENPD_FLAG_ALWAYS_ON for always-on domain"
(https://lore.kernel.org/linux-renesas-soc/20190816124106.15383-1-geert+renesas@glider.be/T/#u).
R-Car H1, Gen2, and Gen3 SoCs do not need a fix, as these SoCS use the
R-Car SYSC driver for Clock Domain creation, which already sets the
flag.

To be queued in clk-renesas for v5.4.

Thanks!

Geert Uytterhoeven (3):
  clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for clock domain
  clk: renesas: r9a06g032: Set GENPD_FLAG_ALWAYS_ON for clock domain
  clk: renesas: cpg-mssr: Set GENPD_FLAG_ALWAYS_ON for clock domain

 drivers/clk/renesas/clk-mstp.c         | 3 ++-
 drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
 drivers/clk/renesas/renesas-cpg-mssr.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
