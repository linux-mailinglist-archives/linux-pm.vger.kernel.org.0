Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE76D59FF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjDDHwB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Apr 2023 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjDDHv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2023 03:51:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D6C1722
        for <linux-pm@vger.kernel.org>; Tue,  4 Apr 2023 00:51:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i9so31782144wrp.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2023 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680594712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfDShCyKSzYNT7K7OjLzYFiwYG5pbbHJ2o04Zo0MgaA=;
        b=KprbWEn+q+mpmBmb87FEGrPAz2WkAVoT7fpbaZ4f0snB2Y6J1O/atZ/lRgJ8O3Opjs
         xumCO42xmTO0ra/iI+bCQn0G3lRy5axMVBTtTI2k7UVM23Waz2vVDhmxn80GXpDlNVrZ
         G9fxRMsFDkVaLLhWdY+GF+8wkGONn/xC284ndxslugzlNLJmGff2dguueLBQCekPcs/1
         875mp5IxbohU6kfX8pPSlcqXC8w4rBx7Hc5rd075FGNxsuOAFeoO+sW/ehHlIlGiBJib
         zVHxrKfP1fAGeVfXFAP4n2VdqO+ewgpviVjfIg/BhhpvP1AWUC3QUrW97qbkW1hOwl3f
         RiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680594712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfDShCyKSzYNT7K7OjLzYFiwYG5pbbHJ2o04Zo0MgaA=;
        b=dfgkPHJ11Oo7eYSYah9XH8ASTvhF32LyoUYwAZ/GAVQpEiKsbGlyF8CHOzpq2SEhP9
         DPb+0vSCu9tHjAa2rUMK+dQh9wh1HEODGFmRMWqh2a73L/vSM49FA+rhoLVvYBGB8ZI0
         z+nz7vJoQ6LWXlflfT27Ai0XnS6iCmUK3LDs0+WWWRpCM0NE6/rSNLI6TqkBfnbPy+8N
         YRSvuEaAMW2B3pvlVZdUovpjAXv/D6jiQZCjaj6iOna+aHH1tQzvV8UE4RNJHQ0h8tZ/
         1V/Oq9cLjEJ/7rLzlusV7W4LnMNlO7qc0wGlv13oSp2IXhGxxmzqQCJ8tFnOwn95ENfj
         kGiQ==
X-Gm-Message-State: AAQBX9dYvHkrmg3tsB7tnW0z8hc8RbPdFarBzIhH2WYTyy2zvdZpJFhP
        BWOagTvm/yT7Ywrl8e5A1WlsGYLJ26mxx0gptOY=
X-Google-Smtp-Source: AKy350ZfdSirVfqk3NCqaguZT3zdR7XuVIQv0b5pahpoCWEYkqfUdHBUpZ82Eay5owykXLcAb2rJ0Q==
X-Received: by 2002:adf:e40f:0:b0:2cf:efa5:5322 with SMTP id g15-20020adfe40f000000b002cfefa55322mr14880722wrm.14.1680594711896;
        Tue, 04 Apr 2023 00:51:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9754:a4ba:a0f5:8937])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b002e45f6ffe63sm11591561wro.26.2023.04.04.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 00:51:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Amit Kucheria <amitk@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 1/3] thermal/drivers/bcm2835: Remove buggy call to thermal_of_zone_unregister
Date:   Tue,  4 Apr 2023 09:51:35 +0200
Message-Id: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The driver is using the devm_thermal_of_zone_device_register().

In the error path of the function calling
devm_thermal_of_zone_device_register(), the function
devm_thermal_of_zone_unregister() should be called instead of
thermal_of_zone_unregister(), otherwise this one will be called twice
when the device is freed.

The same happens for the remove function where the devm_ guarantee the
thermal_of_zone_unregister() will be called, so adding this call in
the remove function will lead to a double free also.

Use devm_ variant in the error path of the probe function.

Remove thermal_of_zone_unregister() in the remove function.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V2:
     - Fixed wrong label call on the error path
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index a217d832f24e..3acc9288b310 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -275,7 +275,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	return 0;
 err_tz:
-	thermal_of_zone_unregister(tz);
+	devm_thermal_of_zone_unregister(&pdev->dev, tz);
 err_clk:
 	clk_disable_unprepare(data->clk);
 
@@ -285,10 +285,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 static int bcm2835_thermal_remove(struct platform_device *pdev)
 {
 	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
-	thermal_of_zone_unregister(tz);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
-- 
2.34.1

