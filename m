Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517A1DB62F
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgETOWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgETOWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 10:22:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36258C061A0E
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 07:22:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c21so2430162lfb.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHLQVyByllAsLV9q0W4W++svAyzlYBPAqfr50eKbfzo=;
        b=COUxdVvelmP88VBI3mT2/KoKOC6ICS6YuLHK5a1Y0gCSVMBPhjeyGH9lNT/eSf28W8
         +i1NYwu0rHLChGdfKFvIdDMOXY5bUNAHXNDJWFmCR8mOz0NPtTWrKzPofbybotKy4I4G
         vUgnJSjCrdWpm3a39CLtQYOAD05vthRJlpPdUR3b8MhGPx6YdhAzvsC/LmqyB5c4s25h
         Ckl/lbgOPPVh/DD4/tcJNFty/GHN2tleCAMP+NRa3CEnUVEtr2Es7fpMQyQb5jkBpCc+
         O/is04JNtWtCAMb/qwjRsCLfteGgQGFzrAqtYC61yF724jeEAO9A3yEhtsCylIlAelWk
         z/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHLQVyByllAsLV9q0W4W++svAyzlYBPAqfr50eKbfzo=;
        b=G29I8gJfrcYeVx/g1lh7OycUi1HY6G758LTsVTczIPfLEGrFiGqfeyMVnWh5bibSqe
         EAgVRB3AkPkHgkWNC0YV8B9DyZYT7KGXV/9K4h66fW5ONEaBiSmKjcOfm42mBHyH6LVO
         0xjxI0MmqMJ6/Zm+i+Gwiape6haoR+1zXwigR4JTpxIZVPo0VbQxz+v0PGABlrpovepE
         ucNlOzfwnukUjlF9yG93Xs8R3vw/XByx6Tn41ctVWgV8B/54dqDn8SOmFzAMGkyurhbQ
         y6345/8h140ZWATTz60Jibi7bnb8W2pyLg5UHUVVzyaiRhbqQ8OPQlXYjhnTsLwmQcts
         SwBQ==
X-Gm-Message-State: AOAM531u5mjKe948BkrDVIBPnidApNc4BpqWXcbVC8nFQoVo0leDl1py
        8mX2BFB9k0ruZktJjguz1IH4Kg==
X-Google-Smtp-Source: ABdhPJxWVfMEMFuUY2WYAiK6bM9GpKNsS0vYqJqSFoizkjBB9A0n8JG6mgKEO9U+dC0YZDti3nlxww==
X-Received: by 2002:a19:ad49:: with SMTP id s9mr2753439lfd.9.1589984556554;
        Wed, 20 May 2020 07:22:36 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id u15sm1096636lfg.92.2020.05.20.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:22:35 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     sre@kernel.org, robh@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] power: reset: vexpress: fix build issue
Date:   Wed, 20 May 2020 16:21:44 +0200
Message-Id: <20200520142144.520139-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

An allmodconfig kernel makes CONFIG_VEXPRESS_CONFIG a module and
CONFIG_POWER_RESET_VEXPRESS builtin. That makes us see this build
error:

aarch64-linux-gnu-ld: drivers/power/reset/vexpress-poweroff.o: in function `vexpress_reset_probe':
../drivers/power/reset/vexpress-poweroff.c:119: undefined reference to `devm_regmap_init_vexpress_config'
../drivers/power/reset/vexpress-poweroff.c:119:(.text+0x48c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`devm_regmap_init_vexpress_config'
make[1]: *** [/srv/src/kernel/next/Makefile:1126: vmlinux] Error 1

Rework so that POWER_RESET_VEXPRESS depends on 'VEXPRESS_CONFIG=y'.

Fixes: d06cfe3f123c ("bus: vexpress-config: Merge vexpress-syscfg into vexpress-config")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4dfac618b942..f07b982c8dff 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -191,7 +191,7 @@ config POWER_RESET_VERSATILE
 config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
-	depends on VEXPRESS_CONFIG
+	depends on VEXPRESS_CONFIG=y
 	help
 	  Power off and reset support for the ARM Ltd. Versatile
 	  Express boards.
-- 
2.26.2

