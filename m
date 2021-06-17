Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2003AAD73
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFQH01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 03:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFQH00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 03:26:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4130DC061574;
        Thu, 17 Jun 2021 00:24:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r198so8716084lff.11;
        Thu, 17 Jun 2021 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtRECjuHE8VSl/pHqjivxGI8ToSVE21apQFUXU7vdb8=;
        b=Z1JZqiKZBB7gCeAUgnrr58Sux4Mb1dytkvz39WcLmuJRLa/3NxdxiEkAi7B7iGK7X/
         s8JbQifq15J0xb5c3kOS67XC6GfX/oR7EW3MR07vHdZbQlovkohPk3X1rRuxIyFUWcAU
         cLbK13S9WJN/UXXVv7v0ia/gJXUfu1l2FtCvbz5FvQgs1yFTxEcsNBB5BgaZrimsfFFX
         chz2rH0lBiUnda63qWfizyDL2D/Z6Rw3ipQS0RRJizxYRySvKqWea65Bh/w7PqCpJsoc
         szyoSREiF5gg+r4p75Qqc0brdYa5xEqtYW7TLtjeTfNDSsMSGb3M6ONhfzQVRe0WPwDb
         r5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtRECjuHE8VSl/pHqjivxGI8ToSVE21apQFUXU7vdb8=;
        b=ee6mQk3rW18/I8JrsccYyw5lnjcaluGoaKpC5UIeZlYWPGOUSRhSy6yMAYEOvXu4qF
         PEbC7Q2S9jzNNKcaAIR1jTp9dMgS2o0gp0knUKvK8UIIhDUa/oxVmnyD+POhC9RX4q3l
         /ktbH/14lvKyscTJ/nD0anaw1gF3lDf+3z5/fd6c1Phj4uSwqG3ISEotkbgovYh/SWAg
         +yHFAkDG9dATYGusvllZZtIMYarolxS/o/M1YVO+ucDHH2W4HUhnf11pLGyA8getzI6M
         Znnij1/kColBML5RisMqmEPlBWbGF8WNsK3MFrMGYukMlJjq3t6KGm10QV+mGBK17xw4
         +ZXw==
X-Gm-Message-State: AOAM530EVSlRtFswY0Y7Vo07eVYOZGeYfYxMWCLOZmBaiQow9++xT9H8
        Hd4kH5q+nvy8r0VbmZqiefk=
X-Google-Smtp-Source: ABdhPJwiWJwBIEAXOcnfax5b9NHW3VV+Ld0Pc9uh1XV/GUCp9Hfb9RK3N+WJ3oHbgd5MU1L91QFkTw==
X-Received: by 2002:ac2:5547:: with SMTP id l7mr2812424lfk.402.1623914657659;
        Thu, 17 Jun 2021 00:24:17 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id d23sm487140lfi.4.2021.06.17.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:24:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1] thermal/drivers/tegra: Correct compile-testing of drivers
Date:   Thu, 17 Jun 2021 10:24:03 +0300
Message-Id: <20210617072403.3487-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All Tegra thermal drivers support compile-testing, but the drivers are
not available for compile-testing because the whole Kconfig meny entry
depends on ARCH_TEGRA, missing the alternative COMPILE_TEST dependency
option. Correct the Kconfig entry.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/tegra/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
index 019e3a2eb69e..cfa41d87a794 100644
--- a/drivers/thermal/tegra/Kconfig
+++ b/drivers/thermal/tegra/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "NVIDIA Tegra thermal drivers"
-depends on ARCH_TEGRA
+depends on ARCH_TEGRA || COMPILE_TEST
 
 config TEGRA_SOCTHERM
 	tristate "Tegra SOCTHERM thermal management"
-- 
2.30.2

