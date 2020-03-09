Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E277F17DA8A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCIITP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 04:19:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53958 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCIITO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 04:19:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1266317pjb.3;
        Mon, 09 Mar 2020 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IVmmUD2LX/XKO2jYcRB3hPlqs1LzccGE0vVFCynCeIQ=;
        b=T8JfBJxZhiNslsh1cb88g0iyg5Q3MO7I8FbcK7sDEiY+HOhUV1r6ZjD9yFzTbVowZ0
         yhAajULCJsCJDzfGvl+IBZr6CtwW3P/vDya2QGwsZl1NF2F1md+R00gz2G1sV3wveeu0
         x2SBI3zwsF+yTfEYUWs+tT3vEc1gSGt5QmTjJKd8N+ru3PyGRjN/MbLvZ9n0J21vVUeG
         hcTgpMqNnN2CBhlHVmfFEj0QazxS8MKT9jlUu6yFmorOjrjF3huvF+DZowAJJbuS/Nuo
         fi5+0k4GUR7ZA6XKv+Gaw79IVQfaAZKO/Xi5HGTszOZ2Bn8o1AfrGkb0p6IDqROi2kXq
         VKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IVmmUD2LX/XKO2jYcRB3hPlqs1LzccGE0vVFCynCeIQ=;
        b=AJTENxVKyBBjCeUHowjqkWQwkUAY3IUx72kJvZ2l+4g6cavPydrp0mA7UXALB0kqbJ
         Y+NMNOhTrX78rF6lniwgqFsH4SsGjH6932Rq2SbB5Ut/7LDiMyEFEXNqEaEGA1eQAmrB
         u46C41fdDZRSbBuJ/tis54IrqTSSNsjd5SjUed6oTB8FZV82moFsmnSbAg27Mtcirpb+
         vB3S/bvTUXaN5RhCGW7uNjJscNpqulT21J3jJFRsAHvS85R0gDYjkp1JbB7z0KNoK3ow
         Waa0hh7yJuXmBioI+yxfe+QnhiflVZXLLRis9ATv8m2qsWog2HGT8WQg573btzK9Li0E
         mm4g==
X-Gm-Message-State: ANhLgQ364kVCp02gs5Tq7dVC0gBUSxma5B7rOU3Ll1wIO7L0vPChA5+4
        XHhE61iEDNOJmQOgCwkJ2kUZ0MGM
X-Google-Smtp-Source: ADFU+vt07ko5Ux+nhpJGcf/tTP4BM2pXWm5admO9dpIzsxJRVA5Fr5ezWQDfTL6XroDkJdOu+BrHvg==
X-Received: by 2002:a17:90a:a483:: with SMTP id z3mr12870263pjp.43.1583741952723;
        Mon, 09 Mar 2020 01:19:12 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 193sm21862277pfu.181.2020.03.09.01.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 01:19:12 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] power: reset: sc27xx: Allow the SC27XX poweroff driver building into a module
Date:   Mon,  9 Mar 2020 16:18:46 +0800
Message-Id: <12b6c11ec62956173fcd84581720b4e0aed54a11.1583740881.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the config to 'tristate' and use module_platform_driver() to
allow the SC27XX poweroff driver building into a module, as well as
adding some mudule information.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/reset/Kconfig           | 2 +-
 drivers/power/reset/sc27xx-poweroff.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 513efe8..8903803 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -248,7 +248,7 @@ config SYSCON_REBOOT_MODE
 	  action according to the mode.
 
 config POWER_RESET_SC27XX
-	bool "Spreadtrum SC27xx PMIC power-off driver"
+	tristate "Spreadtrum SC27xx PMIC power-off driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
 	help
 	  This driver supports powering off a system through
diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 91b5ece..6986307 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -6,6 +6,7 @@
 
 #include <linux/cpu.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
@@ -71,4 +72,8 @@ static int sc27xx_poweroff_probe(struct platform_device *pdev)
 		.name = "sc27xx-poweroff",
 	},
 };
-builtin_platform_driver(sc27xx_poweroff_driver);
+module_platform_driver(sc27xx_poweroff_driver);
+
+MODULE_DESCRIPTION("Power off driver for SC27XX PMIC Device");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

