Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082BE2DC480
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgLPQnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLPQnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 11:43:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CCDC0617A6
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 08:42:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t22so7549913pfl.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxeKk484FE197OUQVwNz0QTVE1MbXs6u0Yr28/1OUpc=;
        b=UPpL9wT7RdxjpvJ7B9+DNDks+0tCYHBcyEkfUmPSLvog2zikVgpaMjZ+0EB9VFg9Pe
         huDbOcnsVAOvyMligbJ9K66ultIpHJZJMk8vFicgY9m3W5TgzG6Gw+/b6LnVg6OEgURp
         h6AFsEZmAxNul7oRmQwSUfcr446uANtMzLUDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxeKk484FE197OUQVwNz0QTVE1MbXs6u0Yr28/1OUpc=;
        b=VycHTXdziK/dDDj8lYnoKiT1GB9ukH4HAc+lMfvwg7Z+eVyNZ++OZaM131z4o6nG1H
         QeoGgWTvC+VHUxNXTm8VNtD6PWW+jkuvwNEymX7YqmPTNPP+8cdp+X0cq4FR1l0LvHoG
         wyvVEVYUKykGNULnkP3CCOkzGKhp37iHzTp3UDKKxMPiHLvypjCYuxQmCrCUXnevcZ52
         mH0545xKiizsl939qm4RGySvDz8G7cL19WnFJ2UUdwqF7YlvykXi7/BwTtfFGm5mJAf0
         EEUnJxsisg0d/wjLXjPdxJotD9YTleTYME8ELeGkHLLxJexDSRi+FQLwsBAD/mX+w03c
         aJUg==
X-Gm-Message-State: AOAM532rE5KB/doitDQXGRMHUjKwLqLc7PKk++5BDK7LvEMmBpMlMXFz
        wMyc3fxckvxkAjZM2fT6ja1LPw==
X-Google-Smtp-Source: ABdhPJx5HUp5Qa6Kmgx4x20aZy6v8WoOvExp9mjEmHH8f4hoi5lY2CDsfBR/p2iAIvAfgSxV3zuMfg==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr22391110pgm.135.1608136951318;
        Wed, 16 Dec 2020 08:42:31 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id nk11sm2533723pjb.26.2020.12.16.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:42:30 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Wed, 16 Dec 2020 08:34:17 -0800
Message-Id: <20201216163416.2969209-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216163416.2969209-1-dnojiri@chromium.org>
References: <20201216163416.2969209-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6135321592b76c..f3bc1cb6891ba5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-pd-sysfs" },
 	{ .name = "cros-ec-sysfs", },
 	{ .name = "cros-ec-pd-update", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.29.2.684.gfbc64c5ab5-goog

