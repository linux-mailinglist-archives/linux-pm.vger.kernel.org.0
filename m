Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902D6DCC4F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDJUxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDJUxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:53:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBFFED
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:53:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j11so9189161wrd.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160019; x=1683752019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIjogzcbB9NbNQDtYcUOxd5sO+Lh6rQ2yVngUMiZyBg=;
        b=xyL9hMXg0TC02Yn0shvpreWa/MOZ4/qCU40KHDFzbPk+etV+QUJO8sEhYs7Mh+qN5n
         z5TJ456A6E4aXcNG8guYtLeuTgnNIZoQrAPuWXDhMxF2qi2tDteBqX8XUVWYuxZ4+Z5E
         zsG/hJcbj7+u8aPTR1PtZFNSRLLs0zNP0atsamdIbWdaqZqX4IQVevcLtf4QYIhoGi+o
         YeoxsZSweg1dEovNzju9QRZDjaNuqJiRtCXFiv0nGrlYeBNnuLe+HMJtSW7TnZVXIh6C
         zeqOndIytiIiRGgysHB/uOZiZs+x6LIceOoxamu3W5w2n2avV2dp59Wf9kXToT4NWx57
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160019; x=1683752019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIjogzcbB9NbNQDtYcUOxd5sO+Lh6rQ2yVngUMiZyBg=;
        b=ICQjwrISJojA0mdMF3tw8bCVFvgRWoXbSiNrmoYAAfRq1JWeaPpXpVbyCDobyVadA8
         q5O8J0yRkGUVt74AH3QhEa8C30SIINoUY0S2ExVVdK2zIZxm0iikoqqK7qJhahM4jS8/
         qrHeBGSLjIIya5x9rfOE2Lqul4j6Un09s0tkzlxwr9/s1TZLD4MMcfUjcEz2QfaVCQR5
         U5c499sPnfYlc/JZ8PiR4nvgrjo0IKF/bUSEst3sNmtJD+sVXmRHMY2aoJP/g3d3qOyd
         2aPOtRX4JlQRn6NWcsqPH0Z+BMtV/Q2iMEoMoyrmne4Ked0XeGCUiTzXKE5mZTJ/pmIT
         orjQ==
X-Gm-Message-State: AAQBX9cpC2XO/dqwxd18LmUwpRMAsWR4XLdbu45wastL9Boxcy21c1eK
        4JVHjZLISuTGDKm1uXZy49SDGA==
X-Google-Smtp-Source: AKy350ZOay8K6RxDMjsDBpOYzrC/EljA9SFrUCAJHArSZtc+GmQNbptL513VsrXmsJ2ZzssVX6SmDQ==
X-Received: by 2002:a05:6000:1b0c:b0:2ce:ada5:325d with SMTP id f12-20020a0560001b0c00b002ceada5325dmr7589428wrz.37.1681160018690;
        Mon, 10 Apr 2023 13:53:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tim Zimmermann <tim@linux4.de>
Subject: [PATCH v2 1/7] thermal/drivers/intel_pch_thermal: Use thermal driver device to write a trace
Date:   Mon, 10 Apr 2023 22:52:59 +0200
Message-Id: <20230410205305.1649678-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pch_critical() callback accesses the thermal zone device structure
internals, it dereferences the thermal zone struct device and the 'type'.

For the former, the driver related device should be use instead and
for the latter an accessor already exists. Use them instead of
accessing the internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_pch_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dce50d239357..0de46057db2a 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -127,7 +127,10 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 
 static void pch_critical(struct thermal_zone_device *tzd)
 {
-	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
+	struct pch_thermal_device *ptd = thermal_zone_device_priv(tzd);
+
+	dev_dbg(&ptd->pdev->dev, "%s: critical temperature reached\n",
+		thermal_zone_device_type(tzd));
 }
 
 static struct thermal_zone_device_ops tzd_ops = {
-- 
2.34.1

