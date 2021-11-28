Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3927460A65
	for <lists+linux-pm@lfdr.de>; Sun, 28 Nov 2021 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhK1VwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 16:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbhK1VuP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 16:50:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD800C06175B;
        Sun, 28 Nov 2021 13:46:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu18so39531422lfb.0;
        Sun, 28 Nov 2021 13:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aW1opc2XMj6ECBMk4QPmwKIgh0Lk59SgGVK29sQZpz4=;
        b=R6llHYtE4v699Erxb4KgZm1YmXx0LPI6U6dhewPpQOeeGCMqroHi34e6Jyz1j+3vSq
         AlLo2ZMQ8g871ClBCNIpid/YzJlH/bUsn9AI3CuIt2+3LjHzsrHdjKoKSAr8kEFwq6xo
         Ap4TIreND/zXytshIK+kEI5vaHsuQ8pFp3R+2CE+Bt7LYnk4/jsNFr4UwdA2TDf3nezq
         RN9YRx5sH92WWWKVveWumH6Wweb1ufhuVG+5duuj+e0vqzld8tRJBKAOX57akik8MAYq
         i8Z/uFRQLaKyL1zqunSNCUUt5agrxipH4zb/0lg3rjvHRD+V+7KsUXIQ59G7KGkvtJtQ
         SGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aW1opc2XMj6ECBMk4QPmwKIgh0Lk59SgGVK29sQZpz4=;
        b=x6PdRMxF0EysPMWmlUDSlmohGsXOa0ju/lUeYdijV2Wpwyx0UMCY/tRIAO6UFTwr0Y
         VWWNGbt03jyHEzc2kC1eQS/PMTXhK95D7FVz88AV3sDZDcpNBeBEYcaX1MkSWXXOHSfH
         Q+bP/Yqtl+RPwhs3opSQb7R3+wx5OUMqvkIvD9SZbL64JZMZ70QL7F5F/YtVtFmHb3Rf
         MqF8pT/C5HRq1+TOPrVnDKsS1MUtZwysFWUXn+MwSttn63qAklIv6UZn6NnaE+MCtDKB
         DaPsBfnxPr2kGyLNC6i4cx61pdEsMSEIykEOY+6XKbd5nOyfLFBMmU/D3N4X7fWoXcXr
         gWiQ==
X-Gm-Message-State: AOAM532VkZTBoErYcj4pzHG0yL1brqKHTVQMCEZdt+mUK2Emw9IkIjX6
        cWcUAL/tfskr09knon5LgTU=
X-Google-Smtp-Source: ABdhPJw+hMc6eQam/JZYRHF9HLZpoWjG0svgOEXOY73j15pplGTRFuZF1Wl0BSdOjtI9NRkNxvu2gg==
X-Received: by 2002:ac2:4aca:: with SMTP id m10mr43666913lfp.437.1638136007089;
        Sun, 28 Nov 2021 13:46:47 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id m24sm1111027lfc.208.2021.11.28.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 13:46:46 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] thermal: intel_powerclamp: Constify static thermal_cooling_device_ops
Date:   Sun, 28 Nov 2021 22:46:41 +0100
Message-Id: <20211128214641.30953-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of powerclamp_cooling_ops is to pass its address to
thermal_cooling_device_register(), which takes a pointer to const struct
thermal_cooling_device_ops. Make it const to allow the compiler to put
it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 9b68489a2356..14256421d98c 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -641,7 +641,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 }
 
 /* bind to generic thermal layer as cooling device*/
-static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
+static const struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 	.get_max_state = powerclamp_get_max_state,
 	.get_cur_state = powerclamp_get_cur_state,
 	.set_cur_state = powerclamp_set_cur_state,
-- 
2.34.1

