Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA544FC6C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 00:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKNXRH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Nov 2021 18:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhKNXRH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Nov 2021 18:17:07 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D864C061746
        for <linux-pm@vger.kernel.org>; Sun, 14 Nov 2021 15:14:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id br15so34704345lfb.9
        for <linux-pm@vger.kernel.org>; Sun, 14 Nov 2021 15:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5oMCRSEom2GDc4+zu+cp1ek9j+Tk35Eps2M8rna/y4=;
        b=XHEyt/EoTg6g0DwaxCmrqodUAo9ePnQNJxSqj+pfk7YIJerChlUY57t3moEnqbZuB5
         fyLxDCnDzrPCfTU9hEqG+mcNpGKJtLmCumEiY+FHSVnAxCMJKsGfMmhGY8iZj7p21K/I
         c1PTt0XBKzfcYGY36z1D2LfuIAi7yjGjzOnhUZTYO21vq1NUYeyuMbyAgHIblFDKmZx6
         Y4ndkVrDJjBnWHLem4z4hzDsvEoTUfTi/nF7M8TLRKQJSgPQS+aQ7SBglabbQuj8HxpL
         i1rjrAOkLyom27c9q0pjIIBwAqH63vCZFDYD8YcBOOXR9iecGreaKqkKQtDZCAUilZmu
         LhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5oMCRSEom2GDc4+zu+cp1ek9j+Tk35Eps2M8rna/y4=;
        b=wFbGD3d/DXtPqYTXk8vESuJdnYzMgIZ58UG7bZGjBg4RemJtQ3MYq+00daZHexnT0b
         06l2IK4ajY2OiXvnvdbEcBDn/ouXeqFQUkjPgBlaL5PK3GJFQlvEV8vjJNEtzC5psX49
         MeJoe7lcUgydtMBKnnT/icCbZfFzMspNMBaySA/EOyxWmScx2/LBkUj3Z60+/JcK1rHo
         nslIb42I4alz4odACRGB2BMMOuYb4qbbwxDUswvPLADBJDOhBId7ocxFMSFkuHG5+1sb
         R/PiB4GIXxR5oDED/QNE2N8vQ6j9s+yBav2znReTDYBrbteCP+aTK4jbQr1spPDCsOZk
         b2xw==
X-Gm-Message-State: AOAM5331KWa+NBd7kZ55E/gxDVooQm92StmexGxnJevAHg7JQCz/TaOv
        z75H/hGVgaG1DWbcVSkyHg0NM0iQZtLJKw==
X-Google-Smtp-Source: ABdhPJyHMEr/Eeef7Tf+pjfc87NXjmCiAnZ6Oj4ZqSMHKY2s6+N+a54cc5ijfCyWt6uWa1wUsqF8Ag==
X-Received: by 2002:a05:6512:4017:: with SMTP id br23mr24342991lfb.270.1636931650352;
        Sun, 14 Nov 2021 15:14:10 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id v14sm1227511lfb.264.2021.11.14.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 15:14:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH] power: supply: core: Break capacity loop
Date:   Mon, 15 Nov 2021 00:12:07 +0100
Message-Id: <20211114231207.1877495-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We should not go on looking for more capacity tables after
we realize we have looked at the last one in
power_supply_find_ocv2cap_table().

Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the battery OCV capacity table")
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 038e35ea7fbe..885c92dc0379 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -852,6 +852,10 @@ power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 		return NULL;
 
 	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
+		/* Out of capacity tables */
+		if (!info->ocv_table[i])
+			break;
+
 		temp_diff = abs(info->ocv_temp[i] - temp);
 
 		if (temp_diff < best_temp_diff) {
-- 
2.31.1

