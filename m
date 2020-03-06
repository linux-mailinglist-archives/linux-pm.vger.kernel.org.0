Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6398E17BAD2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCFKzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 05:55:08 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49596 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgCFKzI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 05:55:08 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Ayv52200j5USYZQ01yv6n2; Fri, 06 Mar 2020 11:55:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAdF-000473-TJ; Fri, 06 Mar 2020 11:55:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAdF-0006KA-QN; Fri, 06 Mar 2020 11:55:05 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] thermal: Add support for Renesas R-Car M3-W+
Date:   Fri,  6 Mar 2020 11:55:01 +0100
Message-Id: <20200306105503.24267-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

	Hi,

This patch series adds support for the Thermal Sensor/Chip Internal
Voltage Monitor in the R-Car M3-W+ (R8A77961) SoC.

It has been tested on a Salvator-XS development board with R-Car M3-W+.

Geert Uytterhoeven (2):
  dt-bindings: thermal: rcar-gen3-thermal: Add r8a77961 support
  thermal: rcar_gen3_thermal: Add r8a77961 support

 .../devicetree/bindings/thermal/rcar-gen3-thermal.txt         | 1 +
 drivers/thermal/rcar_gen3_thermal.c                           | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
