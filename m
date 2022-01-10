Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83DC489CCB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jan 2022 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiAJPwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jan 2022 10:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiAJPwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jan 2022 10:52:16 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320CAC06173F
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 07:52:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g11so45892949lfu.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 07:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9oscDRUz09eJBlYMQ+GFaF3Av2nTuV83GgDwBRBIkk=;
        b=mae59CCT+x47GjPLwMpv41s9VRF1KHGh4PhYnUt2SXS30Ht0DFdBtWbRowl/wKpfHZ
         cbK2TCUEIdNgPcLBvxG8IwUnfguRz857KeptqmzgFLzDshOjrQsmsCOcbOmsj57R/0Dl
         aBQIePjDisLiUUAidenHHmHgfS14d8yBySWPTmKAPeCoV8e711KxbHyWB3H1ARM+Mwyd
         m1Y5dELzmpsIbNcUjzJjhJ3qbV88dVajszq0Qo5E4LgXiEG0VrH+qkPVJ8Gnv69t+47c
         9lIYMWusw+gu2+UVmbMUjcNAZg9ClMLMnjtPOK+tAsuSuG6XSwwdN+SNwAO1DpcrLHQ4
         FUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9oscDRUz09eJBlYMQ+GFaF3Av2nTuV83GgDwBRBIkk=;
        b=mAzgSPZzas7oxsB9JBR8rIAnjytZrOBnAj2omtPsH62dPXintUavUYHg8OL87QZ8C+
         q1qaX46xuGLBxv2gSUv0sMuWl7ydqvyG6Taq2raqgNbu0eWyp0UHh+4kX4e2aL2JB8WR
         HQ1NFTSBOLHj3gWbA1X4WV8cfz3U4n1d/jH8baMyxlKTawmuwTid/SGqqyqNkSHKM5kH
         ayuCyE6litrXf5hydqFIO/gTrhVM4KBWPWlGFVCNYm3pAPorn2NvS7PhW9c3V1s0nUEb
         /LDY3C5rZj61gLVyOtGbB+2qy1OPMTPCOrwTSe/DjiNtlfbNBUq7HcqHil79L53cN7iZ
         HWRA==
X-Gm-Message-State: AOAM531yenfNCdENEzeKgc3oBsk8jkfzjavHORpvOlLrZ1V6mS5KQPEr
        Tzn3PJjU7eGH2fasKHZjMY9baA==
X-Google-Smtp-Source: ABdhPJx9qKBXyl7BwE1fDJSkHy0zuuy5xSlOGS+LxufGumvA3VvWxq7L15QL158YT+sgn25Ejbtnow==
X-Received: by 2002:a05:6512:4c3:: with SMTP id w3mr233037lfq.165.1641829933933;
        Mon, 10 Jan 2022 07:52:13 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t17sm935320lfq.80.2022.01.10.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:52:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] power: supply: bq256xx: Handle OOM correctly
Date:   Mon, 10 Jan 2022 16:50:07 +0100
Message-Id: <20220110155007.1216836-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since we now return a pointer to an allocated object we need
to account for memory allocation failure in a separate
error path.

Fixes: 25fd330370ac ("power: supply_core: Pass pointer to battery info")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/bq256xx_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index b274942dc46a..01ad84fd147c 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1523,6 +1523,9 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 						BQ256XX_WDT_BIT_SHIFT);
 
 	ret = power_supply_get_battery_info(bq->charger, &bat_info);
+	if (ret == -ENOMEM)
+		return ret;
+
 	if (ret) {
 		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
 
-- 
2.31.1

