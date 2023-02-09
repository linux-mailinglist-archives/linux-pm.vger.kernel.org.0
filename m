Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E5690E0E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 17:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjBIQMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBIQMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 11:12:05 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C6329413
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 08:12:01 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:eeed:e695:5a2f:fc6d])
        by michel.telenet-ops.be with bizsmtp
        id K4Bw2900n4vi5L7064BwPx; Thu, 09 Feb 2023 17:11:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pQ9WM-008RDk-FL;
        Thu, 09 Feb 2023 17:11:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pQ9We-007aV7-IO;
        Thu, 09 Feb 2023 17:11:56 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] thermal: Add support for R-Car V4H
Date:   Thu,  9 Feb 2023 17:11:52 +0100
Message-Id: <cover.1675958665.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

	Hi all,

This patch series adds support for the Thermal Sensor in the Renesas
R-Car V4H SoC.

Unfortunately early revisions of R-Car V4H may suffer from a hardware
issue with the thermal sensor, causing the values in
/sys/devices/virtual/thermal/thermal_zone*/temp to be off.

Thanks for your comments!

Geert Uytterhoeven (2):
  dt-bindings: thermal: rcar-gen3-thermal: Add r8a779g0 support
  thermal/drivers/rcar_gen3: Add support for R-Car V4H

 .../devicetree/bindings/thermal/rcar-gen3-thermal.yaml        | 3 +++
 drivers/thermal/rcar_gen3_thermal.c                           | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
