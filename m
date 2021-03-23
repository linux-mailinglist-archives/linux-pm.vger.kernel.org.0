Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74A345E56
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCWMkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 08:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCWMk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 08:40:28 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895CEC061574;
        Tue, 23 Mar 2021 05:40:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x27so10336937qvd.2;
        Tue, 23 Mar 2021 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KW/VgwalEKvjodOMBNGXrfCABwaE/Sl21ieATFA8Uyk=;
        b=Ydd7oXdr4iE/5ZP3voub9oYbvQmT1/robGJDPXhKDpzEOP9M8VcqeYEMRkBRfqHRHW
         GksnO6vVnbThoRZP1TI5tYK9Uk6xkXn/d4EUXXLGYMORmMtH3uYglfv5eHYelPI5pj0V
         Uw2MmDl4QptPBmSp61AdXPFSMY3UbZhbaA7xYZZ+OHnIgxEj6CULzsQkwRCT0h2kPA6Z
         +q65xDzXosQCO8WqGAZMOwEBRpxaD7891ICyaXMlFYlp3qStt5en8J4g1CuQgSpj62UR
         h1obV6wmtEPbpvnW2NbXZ5SpMvBP3qqkUH0Pk0v44nCJiipmdAS+Bs6qrG6t5hoz68FQ
         YrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KW/VgwalEKvjodOMBNGXrfCABwaE/Sl21ieATFA8Uyk=;
        b=fv2SOqAkq8KBAcyRN7G4eucUS1v2MNhYiURk288BWTgoW4kC7mTwX8uca9yCmVGRkt
         qBkvUinAZ/s9H43Lye91JHioo95SGi3Kk79kW4QZAs+FPtR11HBYMrV3DtAx3iptEzpj
         NpTjcXOB4fCez67p0x4Mjv61r95x2cwKINCS1L7GMX2lYg3Hj19ibYkwOgYqMc0f8mwI
         Tans21P+vPkL7bUk8M6m4EI8ramliOc3l4Znj3trmcssqTxpIKH0ZlgZQLr+2SROxkaI
         7C2FZYqJIBhlefAi6IcBZAmXyi/jT+vLV7D6nw+sfzgso5QnhswSD43Jgs34D6ozs5wz
         GR5w==
X-Gm-Message-State: AOAM530+T+dRe2ueXnmjAXNULjkNAXZqCu64OVuuur/ZrSGDOpnizv3c
        tneP7mhG8eQDHhDuHgxo6LFH97DfXm4mEwIr
X-Google-Smtp-Source: ABdhPJy2cvdCf7L9tnny0lItCItnmXHvPeTO/wNQt2Z8N9QSZKpZ1vxVtDsPZ9swJIdfJkvI1zeUOg==
X-Received: by 2002:a0c:a99a:: with SMTP id a26mr4589549qvb.2.1616503227821;
        Tue, 23 Mar 2021 05:40:27 -0700 (PDT)
Received: from Slackware.localdomain ([138.199.10.46])
        by smtp.gmail.com with ESMTPSA id 19sm13030685qkv.95.2021.03.23.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:40:27 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] power: supply: Trivial spelling fixes
Date:   Tue, 23 Mar 2021 18:12:06 +0530
Message-Id: <20210323124206.24813-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Few trivial spelling fixes .

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 79d4b5988360..1d7326cd8fc6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -131,7 +131,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	 *
 	 * When this cycle the battery gets charged to a higher (calculated)
 	 * capacity then the previous cycle then FullCAP will get updated
-	 * contineously once end-of-charge detection kicks in, so allow the
+	 * continuously once end-of-charge detection kicks in, so allow the
 	 * 2 to differ a bit.
 	 */

@@ -739,7 +739,7 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)

 /*
  * Block write all the override values coming from platform data.
- * This function MUST be called before the POR initialization proceedure
+ * This function MUST be called before the POR initialization procedure
  * specified by maxim.
  */
 static inline void max17042_override_por_values(struct max17042_chip *chip)
@@ -811,7 +811,7 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	 */
 	msleep(500);

-	/* Initialize configaration */
+	/* Initialize configuration */
 	max17042_write_config_regs(chip);

 	/* write cell characterization data */
@@ -855,7 +855,7 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	struct regmap *map = chip->regmap;
 	u32 soc, soc_tr;

-	/* program interrupt thesholds such that we should
+	/* program interrupt thresholds such that we should
 	 * get interrupt for every 'off' perc change in the soc
 	 */
 	regmap_read(map, MAX17042_RepSOC, &soc);
--
2.30.1

