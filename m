Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF550284F74
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJFQFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJFQFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 12:05:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2469C0613D5
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 09:05:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so6260031lfc.7
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sbRqka7VOpWJvR8NFku+h5QvbiHvJEFttxv9N2qOng=;
        b=IP0AxjwDsHlI6+fSO0IUC3LWgmNJ5GLuT544dFAtlVKq1qD3XPtIVFUpEi7yHfS6Xj
         BGRxyBBD9nrwbW+23IcFzr913gf27EXknEneMDMSmJJBhhxuELEp4V+lW9hx93fl4CHI
         E7QMdwustdUqe4jXudHTP5mh8WZ9eIpP+BxaLJQvKCj2aB6fvdBId4y3Wevv72/RgcFa
         7uPkHNZOK9h5WaAQt+pGyzs/Fe9o3CBGv9JhAf/fQD5oYHdQyEUC56poI+3fx5kcYM6E
         0A6+Lj7izWYQaZPwS8hHTI+cN0P/MjZ8/+uI5qMieARE2sGFI9iLwxHlgUMWgmIQXnDE
         GcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sbRqka7VOpWJvR8NFku+h5QvbiHvJEFttxv9N2qOng=;
        b=kPnY3wGQnnPVYm8d9koQMX+ZYUWxpjmUVvMC0LCyx9rOF9FXpl7ZO3oaGKVdFFisoX
         fcBRzC878YWvYSVtTw8pZYmkEoOGbASvgWW/c4HAu+2h1kl7ms0AlZ2dSx2SBSrhChN+
         xT9x8tOZ+4zVWqg+vtXhiOvlckMD6mlVX5QUmMBXRVh3ujyHIQDCsxw0sh/wsMy2OFga
         4mf6A9cP+nMAnJhr3yE9zIHMtiyytBBSKFzNmAE1A+vgnVB8SxEwcIWvmhi5d//nacXf
         e0Vi3AUNzWgFXK1bFFtFUPmMmT632PwRC4ZbjYTYv6rZ5n8XrmK08atsIUFcuYT1CddT
         zj3w==
X-Gm-Message-State: AOAM530thBtfKKwfvThppgD/cmiNMX0tnUOUKoCOTVcafna/iBeisubF
        piEk2aGCx6PdGVByF7u/Ey7TQw==
X-Google-Smtp-Source: ABdhPJyPCOhGePPMb/XByxcKzn/y0EtL47PskUp7B2kWgWNliuG/yslxxaxmERCk5i9tfPa/xyg9lw==
X-Received: by 2002:ac2:5496:: with SMTP id t22mr723232lfk.43.1602000334219;
        Tue, 06 Oct 2020 09:05:34 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id c16sm640925lfc.304.2020.10.06.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:05:33 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] power: avs: Drop the avs directory and the corresponding Kconfig
Date:   Tue,  6 Oct 2020 18:05:16 +0200
Message-Id: <20201006160516.319830-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006160516.319830-1-ulf.hansson@linaro.org>
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All avs drivers have now been moved to their corresponding soc specific
directories. Additionally, they don't depend on the POWER_AVS Kconfig
anymore. Therefore, let's simply drop the drivers/power/avs directory
altogether.

Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/power/Kconfig      | 1 -
 drivers/power/Makefile     | 1 -
 drivers/power/avs/Kconfig  | 1 -
 drivers/power/avs/Makefile | 1 -
 4 files changed, 4 deletions(-)
 delete mode 100644 drivers/power/avs/Kconfig
 delete mode 100644 drivers/power/avs/Makefile

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index ff0350ca3b74..696bf77a7042 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-source "drivers/power/avs/Kconfig"
 source "drivers/power/reset/Kconfig"
 source "drivers/power/supply/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b7c2e372186b..effbf0377f32 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_POWER_AVS)		+= avs/
 obj-$(CONFIG_POWER_RESET)	+= reset/
 obj-$(CONFIG_POWER_SUPPLY)	+= supply/
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
deleted file mode 100644
index a4e40e534e6a..000000000000
--- a/drivers/power/avs/Kconfig
+++ /dev/null
@@ -1 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
deleted file mode 100644
index a4e40e534e6a..000000000000
--- a/drivers/power/avs/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-- 
2.25.1

