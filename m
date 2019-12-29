Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49C512C244
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2019 12:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfL2LRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Dec 2019 06:17:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41042 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfL2LRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Dec 2019 06:17:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so16994661pfw.8;
        Sun, 29 Dec 2019 03:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9kYL0AbI0K/3Y35gdAZ0mqdn7JZ3azuVmXkrAEbJZuQ=;
        b=JQ29jlrFR8SmXfg0BMdcNCVX/kFNDiG4O7lwF5Hpi9xG51ONSXfv6ZhILyXCGQR+Y8
         ft9/y2PpOKfbHaeFDCr2mIm6KIOJqoPnXtqSBe7xhTclymKj8lz1AgKEAxmou9HFt51Q
         R2L/FH5jjlcRrtjRTqIvMRbdRhfQwSBB3Mu3MOn/VRW+ySpog/PHlA9dY8ZC9+Ma1HKT
         EiaLAy40oeAdF9Y7j/d5yqESi7wK/TxtZ0NYloopLqJpj0eQAuLPOBQJWyqRZSFps1UG
         BXKSi2o/+KFGXSjVzj2R3zyTO4W4esoTeslIVVrWeYu3J45RgFXbLW8zwJsMBZX8m+3N
         pPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kYL0AbI0K/3Y35gdAZ0mqdn7JZ3azuVmXkrAEbJZuQ=;
        b=p4TooFZYNZPl/z/OqkKaVDpm2aeIo54n1LLGFVhlfUusEjZHPg8zl6826KV3FVZJqD
         RtLmC0DE7LbfmLER1bzpZefXpDCMTineTwuzVd5Cdo8hRA+PtqDQb6ATWWR8JACfqJu9
         MsVp4e49sXXNPwUXJaTFot/5afcCpseOeSVucgxC5lGt2N2cyU0R+eQNr5X8MUsAUWZp
         PfwmjvISpFftN/olUbfWoslIBtkbCdOAgThDbt0i3YigZwIqIyer7Rt9mc9caUJyiCsd
         4kwa0ajTssI6lEHp0D+UrF7OiZsEJH5XeDWoVwKrSztTM3uQTssvNxRXQ+StufALT84y
         nVOQ==
X-Gm-Message-State: APjAAAU135Iz+uekTAVzZvu9zUYQRcXM6mK5koD3unfnKcOiFun3dVzD
        0Nuj7bnlhBxVz+0HmxAued8=
X-Google-Smtp-Source: APXvYqzmFJSzaHjRWVCpHp2zsBHqqe7XHajN63Yudc2qAPEpuZfxjnD0DoLGNIQpwwh8FSkBtsOyew==
X-Received: by 2002:a63:551a:: with SMTP id j26mr65069179pgb.370.1577618231815;
        Sun, 29 Dec 2019 03:17:11 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id d1sm20867030pjx.6.2019.12.29.03.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 03:17:10 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linux@armlinux.org.uk, mripard@kernel.org, wens@csie.org,
        catalin.marinas@arm.com, will@kernel.org,
        clabbe.montjoie@gmail.com, tiny.windzz@gmail.com, plaes@plaes.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anarsoul@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 1/2] arm64: defconfig: Enable CONFIG_SUN8I_THERMAL
Date:   Sun, 29 Dec 2019 11:17:06 +0000
Message-Id: <20191229111707.16574-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many sunxi based board needs CONFIG_SUN8I_THERMAL for thermal support.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2aea3e..c3c1cc900d4d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -438,6 +438,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
+CONFIG_SUN8I_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
-- 
2.17.1

