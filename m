Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7B69E703
	for <lists+linux-pm@lfdr.de>; Tue, 21 Feb 2023 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBUSJC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Feb 2023 13:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjBUSIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2023 13:08:35 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C62D140
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:07:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1775793wmq.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=pW1yNT7Ypg9QAveNHmxbuLVe8plx5zHWNfuqnEbVNmVkjEZnMiTHM3RZrGV2APV+zt
         nIjNeiG8/jhE1NvBaSrrDa8LhWWqZp3/e+M6Ph11H4/o+aUinOTRyMm6ww44anM+S1Pi
         F/kmLz79x0lFOH137vS5Fi38ai+Fsb7Qj2Y+gvOfrW84VlYmrYRWjQsG4MEMy841oSOi
         wF+Rp5QnlOrvhQ0e0zz9VWps1u4SARLhAV7Nm97TefGQX/0vvrhsKstdA4IppyymyB6h
         mEuX4CmpML6PyqvFAO+iWmWOL3f9ttKSMXvZHGObdygGamdmasq3IGshOmIplO7go+z6
         hhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=wgn9HWlgLnIjMNHW9vrfo+mG4hd3f8CJOQGWBv384OsQUyoINT32W0bNvuXorzmkvK
         U0tX8QVoY3t1cBHjofYL1eKoP9CdtovwxFEfV0TBcu5wv+HvK2XBdWkVUKNRDQSguNjB
         mOtCHVi12eAu5bgtAHmg40wUA35rzS+MIy+KxTV40YngC1lF9B/Q7ifjrzxkTMYGB23F
         DlbcMw8hq8BZmfK3JkrgLgTmozhK/9lWWu0G0O15C2sSHRJExOlUi4MA1zb0hT1e9y6C
         rEqL7Q2IhVQc1a5xKTfbsP3Tr7ZEtt1X/9v45HoQ0AxUFqbqhuUXD/Rw88d+/GEpVME0
         qWbg==
X-Gm-Message-State: AO0yUKXQegRQ4EjAgzyque5BU3CLBtPXVpgvCoUr7ZRk+/PHeQyT13QM
        v9vcEPe27m1cQYvVj7rUFPbQ9A==
X-Google-Smtp-Source: AK7set+9l12qHMXo5CMCIsJgjTPa/QxtFco0fmkL+uUNcV25BDUEEK4H9jR+vfidp7CoUY99d0jJQA==
X-Received: by 2002:a05:600c:4b2f:b0:3df:ee64:4814 with SMTP id i47-20020a05600c4b2f00b003dfee644814mr3493868wmp.20.1677002877095;
        Tue, 21 Feb 2023 10:07:57 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 07/16] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Tue, 21 Feb 2023 19:07:01 +0100
Message-Id: <20230221180710.2781027-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the spear associated device instead of the thermal zone device
which belongs to the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 653439b965c8..6e78616a576e 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -137,7 +137,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spear_thermal);
 
-	dev_info(&spear_thermal->device, "Thermal Sensor Loaded at: 0x%p.\n",
+	dev_info(&pdev->dev, "Thermal Sensor Loaded at: 0x%p.\n",
 			stdev->thermal_base);
 
 	return 0;
-- 
2.34.1

