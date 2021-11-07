Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DEC4475A1
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhKGUXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhKGUXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:23:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF41C061714;
        Sun,  7 Nov 2021 12:20:24 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z8so2614657ljz.9;
        Sun, 07 Nov 2021 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaEwN38KPQC5X3iJYLBjuggPhksHSqM+0ytJkiTYsyE=;
        b=e4cwYV29kIQVowS2HL6/XHkv0/gdEdu36vvI9TeDv42qLeZzW+dhkPEAURmtAqvivn
         SV9CTsTQGMF3J13fCxenwtfCutHmCrTaUvpO2fJl3sAHHu/dZC3BiH07QfYDAb/6uMtC
         RtvGaqa73AIjOW5Qp9gFKObWgS5uNu+37kq7LuBqCV1VsElWof96gB0tGkqVwDeqs9ZW
         CNrGqby0HVlkMc9ee5rMqhJvNJfbOgJ0+683H0hlBbzqGhBBtARD+1Tui891lHsNj1ss
         hJ1x77KTOGnPEzYn/dW7OaZAb2J/jLoOp/gzY2sM4d3P0mKRhjObQsjC6JnJh+JQz7Fl
         X8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaEwN38KPQC5X3iJYLBjuggPhksHSqM+0ytJkiTYsyE=;
        b=rp45UchxTaDkY30Tz+R9ApZpi2zc95jkjG20x/wR/Rp7g6awm+f8lWuujgLW6PEJ1n
         P89USFCrzK/7C+utTgDP+TLoRs9FE3QmRWyEumXH8Cei74yIM5dvpGW7GHGYOGtqYOWi
         kPWg3Gh+jixtuilOsOMtJyZoO0RihJndhoCEznJ3O9tysRcobfFUrbrVBzBrFUSoya2W
         P4TLqldLWw/QumoYlGRmWUoWfrySn4CMPhEnFd5Cz5iHC/EgYJXvwabf2oA5ars307Ev
         27BGhXUtlwzJjt62SgJeA28XWIDdCBg3WzRFKTqoRrHk6yJh8Y6vnB4BepJhDfAYOui/
         z8aA==
X-Gm-Message-State: AOAM531Li9TX8mAZX2Xk4c2yB7xAl+h6K7Kn9fQ0hZo/4Jdsd5xy+B2p
        dYZxoEo1OEB3hAxl1hyFN6M=
X-Google-Smtp-Source: ABdhPJxTyLblFwRiGYFMWtSUwX6QSTCamvsug/AsyVF82mQ2VvBJdYlcqHI6iI3d1BdeZlINiFcPwA==
X-Received: by 2002:a2e:9994:: with SMTP id w20mr22090626lji.64.1636316423227;
        Sun, 07 Nov 2021 12:20:23 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id i13sm362816lfe.233.2021.11.07.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:20:22 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjoeM-000ED0-8y;
        Sun, 07 Nov 2021 23:20:22 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 4/4] bq25890_charger: Enable continuous conversion for ADC at charging
Date:   Sun,  7 Nov 2021 23:20:01 +0300
Message-Id: <20211107202001.54579-4-jekhor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211107202001.54579-1-jekhor@gmail.com>
References: <20211107202001.54579-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of one shot run of ADC at beginning of charging, run continuous
conversion to ensure that all charging-related values are monitored
properly (input voltage, input current, themperature etc.).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index fb2f1578503c..26ac7cde8c02 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -609,12 +609,12 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 
 	if (!new_state.online && bq->state.online) {	    /* power removed */
 		/* disable ADC */
-		ret = bq25890_field_write(bq, F_CONV_START, 0);
+		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
 		if (ret < 0)
 			goto error;
 	} else if (new_state.online && !bq->state.online) { /* power inserted */
 		/* enable ADC, to have control of charge current/voltage */
-		ret = bq25890_field_write(bq, F_CONV_START, 1);
+		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.33.1

