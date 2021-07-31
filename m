Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5E3DC779
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhGaRju (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhGaRjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12DC0617A0;
        Sat, 31 Jul 2021 10:39:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u20so17684323ljo.0;
        Sat, 31 Jul 2021 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tx4QIDj2b8nSMmqdedBogqNF+XkSAZXWaRA6r8AMMQ0=;
        b=UGDdC313UxBt0B1prkmf7X5eJ8sDH+Qf1joGI/pLnZPxr537SsvU0eHsCzmw2acVut
         +PNDZjla+YWmIc1iPBuB9vLBCqJDjleXlYHcxn8Ub3UopjbZcuJANTeyrRKZTXuSMDP5
         EA95OOTl0/Icb+9ItyCZIIPlEBeF3lubHrSXdlAV2vrLrS+kZ1y7Ju7/pq6alHjwpKBN
         bthvRG2C+Hf/5IoNpCuHxbBM15/jqNJ8WQLczjQ2xMj3i4gHv9XH7HbRaufoHrHZ/jZY
         7s5Y+MjnisEp2h2HGKkqUk/4Ns08wPr0L1UV0MUcnZVoLg49qXwnk6RVFsk78xLrQEJo
         BI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tx4QIDj2b8nSMmqdedBogqNF+XkSAZXWaRA6r8AMMQ0=;
        b=lrw1dUEJnaswBCsTFf5fEzqxkx/U/7+S5qeVCpJfTqvYIPRBsWLll3gOsSm96RHv2E
         gXYZi+1uGoGo1lAydMFg/P0/zIJTMSJEPxMfzp0vcuIl/Cggli282a3qxygPY6iVjJdE
         JWSM+PDRpBTmW+iP/AR4lkOYT6X9gPd9dyQmAPbrp6sWWFzf41L0eyGVnrcx8TmV7u5q
         WRfbYaVEo1xH2LEUXj8UwotqDeWfn7wX+30ZHWNeINMSRe8mZYbnhQSgcw/px6Hyptei
         clzA1+J1XeMi5KrX/dpdYM71GBWp0J+39PY8w8olfFY5Fz3afIr+f1rpiSvdFcKnsl2m
         lrhA==
X-Gm-Message-State: AOAM5339czSeIzDYgkBMI5xjEcur8XwxmcJ9BF+r5J+3sEWIy5dFjiwf
        XLB7Pgwa4xZ4/876qFS7zyc=
X-Google-Smtp-Source: ABdhPJyIYw26kkZ3eGiyn+Uw4xed+Gtn+TnJjeTsJME6QRUueoW3oHLYA+H+45AHKtQ4CHEl7y5V9w==
X-Received: by 2002:a2e:a4aa:: with SMTP id g10mr5545170ljm.348.1627753143367;
        Sat, 31 Jul 2021 10:39:03 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 08/12] power: supply: smb347-charger: Add missing pin control activation
Date:   Sat, 31 Jul 2021 20:38:38 +0300
Message-Id: <20210731173842.19643-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pin control needs to be activated by setting the enable bit, otherwise
hardware rejects all pin changes. Previously this stayed unnoticed on
Nexus 7 because pin control was enabled by default after rebooting from
downstream kernel, which uses driver that enables the bit and charger
registers are non-volatile until power supply (battery) is disconnected.
Configure the pin control enable bit. This fixes the potentially
never-enabled charging on devices that use pin control.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 27254e6efdde..1c9205ca0993 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -55,6 +55,7 @@
 #define CFG_PIN_EN_CTRL_ACTIVE_LOW		0x60
 #define CFG_PIN_EN_APSD_IRQ			BIT(1)
 #define CFG_PIN_EN_CHARGER_ERROR		BIT(2)
+#define CFG_PIN_EN_CTRL				BIT(4)
 #define CFG_THERM				0x07
 #define CFG_THERM_SOFT_HOT_COMPENSATION_MASK	0x03
 #define CFG_THERM_SOFT_HOT_COMPENSATION_SHIFT	0
@@ -726,6 +727,15 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	if (ret < 0)
 		goto fail;
 
+	/* Activate pin control, making it writable. */
+	switch (smb->enable_control) {
+	case SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW:
+	case SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH:
+		ret = regmap_set_bits(smb->regmap, CFG_PIN, CFG_PIN_EN_CTRL);
+		if (ret < 0)
+			goto fail;
+	}
+
 	/*
 	 * Make the charging functionality controllable by a write to the
 	 * command register unless pin control is specified in the platform
-- 
2.32.0

