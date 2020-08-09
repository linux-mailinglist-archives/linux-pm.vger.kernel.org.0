Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD823FFBD
	for <lists+linux-pm@lfdr.de>; Sun,  9 Aug 2020 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHISzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Aug 2020 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgHISzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Aug 2020 14:55:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9266C061756;
        Sun,  9 Aug 2020 11:55:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so6201023wrm.12;
        Sun, 09 Aug 2020 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkK1EIAgZylgRKWRlji+TY5L9QOPoxkZUp8VwA6Thvs=;
        b=WD/x3d6lwSejSqnSDks1Dp81FxXMvHsGtZKPWT3L63St1zxI3VLGT9rvyionRjxchq
         LI6lMQCV6UDKL25BRxUYgA4Ki2DwOkwl+xoWPWgVxUUTMxr4zF1KtH/v5g0Cp+G0kakW
         3lT+/RKAbwv1lj2pqX0VmG9+W1g65d7e9pQQz0FmKY6n+jKj5PSrz9hs2TttZJvaur3G
         omsZaIngi465WC6l0nXoXY+VO7EaZQ0HTdq1iu2WeOwwmD2+VorucFeAVBcsPmGcGcWK
         u5qfH6EyOxy4ohbSSWwIgr480hYQ5D2jzWk5Hnc8CzSXg5M3pBP849m34fy7no/hYRd7
         vHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkK1EIAgZylgRKWRlji+TY5L9QOPoxkZUp8VwA6Thvs=;
        b=jRr+DfIr5/ja6IaxkE8Kn+HqIsnAY6MtQxJoSqW71IyUhMeo3c4zm75EVY/v1dIGtG
         ktgLNKg6Ox1OT+NBaodX8NaSc9/YWkp5/ZVLRI0wA6UeTvnBHSRof2yKOUaCkuxgn5j9
         9ONSvKN+S+wK+/D6HP0LvNAny0ZHxM8IkfIerr5LQUxSR6xtQPOmi27w7baJaucKVs8w
         a3WYGkUvtBNxzpTcUndWzwX7W5Sk0PbXYnAVPto78RVL+Z87N3HnOksdgEA4CWGvufT+
         qF8RCzbb6cBrX6Cu9E1IvDOd69xq4ZXGtIIG8mxNhtGiZDucvrnIQ3O899RrjGhZXNSB
         bnag==
X-Gm-Message-State: AOAM532C9XvtPiVmVtfFHUdx8mICfMc3aFIfqNWh86ASiWoltMSVEpN/
        iFtJTHmW8uan7WfrmsWEHMw=
X-Google-Smtp-Source: ABdhPJx3U9dY6P4zPqtSfUGUdZT7wbwvW39SH6n3WFMylMzQt2GzmB9hSffBH8CQp3ZwfvalnOembA==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr20009736wrp.99.1596999307151;
        Sun, 09 Aug 2020 11:55:07 -0700 (PDT)
Received: from localhost.localdomain (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id h13sm18063867wrx.17.2020.08.09.11.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 11:55:06 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] power: supply: Add dependency to lego-ev3-battery Kconfig options
Date:   Sun,  9 Aug 2020 19:54:44 +0100
Message-Id: <20200809185444.54247-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This battery appears only to be used by a single board (DA850), so it
makes sense to add this to the Kconfig file so that users don't build
the module unnecessarily. It currently seems to be built for the x86
Arch Linux kernel where it's probably not doing much good.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/power/supply/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index faf2830aa1527..9f76e2f47ac6d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -164,7 +164,7 @@ config BATTERY_DS2782
 
 config BATTERY_LEGO_EV3
 	tristate "LEGO MINDSTORMS EV3 battery"
-	depends on OF && IIO && GPIOLIB
+	depends on OF && IIO && GPIOLIB && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
 	help
 	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
 
-- 
2.28.0

