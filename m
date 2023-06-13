Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0D72DD60
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbjFMJNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbjFMJNj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 05:13:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859DF1A5
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:13:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3c5389fa2so14251445ad.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686647618; x=1689239618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVLgKJ+/ztP6rDlzmBLCpa1S2OTaKrSyjSOif3HUkaI=;
        b=OEwpsXiIRJmlz9qFFdRDZwkcpEPjkg3TUNJzZ8ZXpYV9ZY48SV9zcgypnqrY8zQHNd
         iXZA3Wk9/rE6OJvOXrQr84mxlwSnekzTyJU+R55wn8RBXjog5DNG635LhlOO+f/AloEv
         Krm9dbFHnuMZrF1OH1egYVBhAE5kTCqvbLDtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647618; x=1689239618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVLgKJ+/ztP6rDlzmBLCpa1S2OTaKrSyjSOif3HUkaI=;
        b=NJi9YUpsMtVvAvpWpG/U1oJHELrfLV2RmY7zEcXo2J8LFdMvDAjZFGkCr+xaQiTe2F
         UDUk19ShQLE5tBMRewVd8gX8Q5vM5V9AvuPb0Pxf+qqFncZMUSxWSYIBmsduZjk3ypBt
         StTE+E7A8FyKQ/NDBWC9dEKBYp2fH6cShDbT+ju76hweX0wKm6xn9yRi5GtSiGGDxYNJ
         v5Lt2OxNZlUl7bTvoctST4NSQxRWm/qIhNf6RNuqAEby5D2yO340RVpjRJ9wstyI+aok
         3McH47S8CvoMwW2kGl3JeXL/8/ZlXx0WIsBIbbVJqigjLQBrspE7awnZ32L0UVP/1Ip/
         yUGQ==
X-Gm-Message-State: AC+VfDxOD5INEmnwyBImtcD4VaE9sVlBWCCQfyLAAMpCAxiZDEjPE5oF
        LvWCo2k/vgfPANC8pCtNmcwND+Tw/YENL1MGLKk=
X-Google-Smtp-Source: ACHHUZ6VUb27J4x8NhmcoQRMvuZKEbUnF9eZx4ZCmSz/2hmzSN0Crm2A/KZzVy0DdOiIAR5OuuefOA==
X-Received: by 2002:a17:903:248:b0:1b2:4e00:a3a9 with SMTP id j8-20020a170903024800b001b24e00a3a9mr7971761plh.41.1686647617753;
        Tue, 13 Jun 2023 02:13:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2d00:6d98:ebb3:585])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902b60a00b001ae6e270d8bsm9686796pls.131.2023.06.13.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:13:37 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND] thermal/drivers/mediatek/lvts_thermal: Register thermal zones as hwmon sensors
Date:   Tue, 13 Jun 2023 17:13:16 +0800
Message-ID: <20230613091317.1691247-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884..1e11defe4f35 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -19,6 +19,8 @@
 #include <linux/thermal.h>
 #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
+#include "../thermal_hwmon.h"
+
 #define LVTS_MONCTL0(__base)	(__base + 0x0000)
 #define LVTS_MONCTL1(__base)	(__base + 0x0004)
 #define LVTS_MONCTL2(__base)	(__base + 0x0008)
@@ -996,6 +998,9 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 			return PTR_ERR(tz);
 		}
 
+		if (devm_thermal_add_hwmon_sysfs(dev, tz))
+			dev_warn(dev, "zone %d: Failed to add hwmon sysfs attributes\n", dt_id);
+
 		/*
 		 * The thermal zone pointer will be needed in the
 		 * interrupt handler, we store it in the sensor
-- 
2.41.0.162.gfafddb0af9-goog

