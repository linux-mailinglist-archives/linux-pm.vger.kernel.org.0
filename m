Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17207138250
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAKQQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 11:16:32 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:53159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgAKQQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 11:16:32 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MlO5j-1jWldt45e9-00lm2O; Sat, 11 Jan 2020 17:15:53 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V4 4/4] ARM: configs: Build BCM2711 thermal as module
Date:   Sat, 11 Jan 2020 17:15:42 +0100
Message-Id: <1578759342-4550-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
References: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:PGzIYruZHR30DesD7wJ+elb2eQS3441bmcXLTgoww362SkbKOqv
 y7l5+cOKxknUI5qQREvnPRQFO9rGVdK/fg6udRYDUhnh6l2HVbHpbVal0TisaemPqmZhYd9
 hkKTRdm5rttJmKhtKWCgonPaRep1878OxdPg5aJhFQBzNBEZOTx4v633r3p2gAoMpP60lJt
 +K5AO/aaMSTS4iYcMYffQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zIMcgdIknNE=:G0dKVNn1GloLF3qitLLuSB
 zg3m/E+0b0lWgdxg8628Ty/PZDjhlxYm4PEja1NDFOtC4y6ia8Dwt4EX4CBaw9utcqdeZIxtz
 8r5UHDDQdVuyacIOpBbGnHjCOuvxstimNhT94ji1iQEM3bpOyb8lOKKbRizkHGB6KX5aAWvPi
 GdW78ry9/fDuUeOsoyvKxKuAvwwL6pEiMqaOtPnhMeqwORtId7bJGkPZuFMyyh6QxeWVRRM14
 i6729LkdbfxD3x+Mbwg3bkWi5gkgCd/Zl5sO6gdeLhrRjXvT0b0MEx9GCv5uxfkHdBp7//QB+
 zrzCLslqKP5+dGPvdxgnsgLMZ5mn93NcYehcjUKx3Vt1mzVUlAeRK3Ym2Pw3YE/jH4r3+aIke
 l5Jo2NbRLZHa7cvO7YGTfdtfr/jWp99vwx3v8vLEQAEi8vy/L2LeVlfhRjB2eRbPHOJFMLQg3
 ocpxR74nwNS9gVY8ioJ3RiWrlbCaHKeIk2xqCIAtxByxP7brYblBsjdUa2DARzR9D7otEvHUE
 rxtWTtJfX1TdzaUCBbCoy/frTSqG5b6XUp+LE3vVBP5rDWvA+8jd+aQy38ANIyE+mJNZLNQ3A
 ZctZLrhuuGGNyWzqkc5U1rqQEydTcp0iBq1qp/2KI7ObuYUWhqYHCy3pvh9daKNB8+o/YdJwj
 IOFg4CZx0LqlaUQiBI7vJ59a+XdFCar6TIzH4dD2Y3X/Xo02ahJH+uEG14zE6vXKL1nhhukqs
 z7JvsEmSfX6M1vawD2IgfkzDyHef70gWjgiZ8wNVT16aAde6qpzU+T54P0OCKYFO5RbPK+iLS
 vFA//jHVaVxwTiem8wL/ER7q1/KP+Gj8FM/mxndW8WXkFkQ6+cfiJGRY8KAlpeJuYHL+FENuF
 dm82scAuUFUTGlMWM6M/ZJBbDeu0P0viprN25wAQI=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This builds the BCM2711 thermal driver as module for the Raspberry Pi 4.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm64/configs/defconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3f1b96d..f5d19cc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -496,6 +496,7 @@ CONFIG_IMX_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_ST_THERMAL_MEMMAP=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2..b2f6673 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -442,6 +442,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
-- 
2.7.4

