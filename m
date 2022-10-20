Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE93606395
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJTOxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJTOxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 10:53:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5E153824
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 07:53:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so86035eja.6
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDGNVxNBG5DnP2O72JRwhZ79bFRdgRafb7U2+dHA6NI=;
        b=HQx6beIGe/7vsiKgB9fdxAVCuvcdbkQg+VQX6cKRsc+Gu2PI/mHpj5LeOPIAJXmziM
         +gSPF02UrS5CAMYnQTdZCGvU9PP6fjDkOTBfUlQ5yIN0VeNH2RbKyXy0un3FvjX+lHA1
         o6gpyV/iQBb3aFE3FpY9lGrCvezZA0rEW+Gk+OP9jc2i7nzek1ENKKOTWwYXa0FBeaS2
         DbyxcM7AIaKGFf0haYiX/biPZcdBTp+ORTfmCYyQeu6tZ/ZRziQBgp+tW1leWRQwo4DQ
         jhZ5azqVFMc2dtaPNro2vcAwaYNuSRvBE5cHnN/PL+CGBDY3eQHvu2UDa7KqwFLAvk0A
         IsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDGNVxNBG5DnP2O72JRwhZ79bFRdgRafb7U2+dHA6NI=;
        b=gPo2lDdOwzy4NseMyRrYh6vHYncl3jEw2MIRB2Yr4StrtccJdki0qqIt/0Ksdtr7An
         9Q3Q8z/4ubZmh9CVNoW4AWatlyjiMBT3SWhYsFFmrhIAXVUyE9YdZGPiOE+Zzrea20bk
         0gkMKsACgkVDgKOSsyxbZhNn516LEuZXGR4jZ/RHKegosOm7KE4o+zY5aXuFTBLlBdnA
         6JUMdMuAngsrx0IiucdcBfHDYteD/6kawDAFbxbS6VXPfQUD0EruZ1EQ8Q+hnL6D5Ylz
         Z/glOx7qpbAuGht1kGLPC33HibeXQXxEXFB6sPaN+hjqCJnWIpA3tkkainDiqvh7WrWg
         7UNg==
X-Gm-Message-State: ACrzQf3nFF9BXeDhhBVh8DZDZnSy+1ZkQcAUcck5l/zwLd5wl8qhdS4z
        2fXP8RV+ahhRenHWs/NPVfxLXA==
X-Google-Smtp-Source: AMsMyM6SH+STgAR7RMIyUn6RoKLYTwg+3oKL+R4KBRsq3rVx6bqFAsr50CDvjDox3CEvXE5KgDFlmA==
X-Received: by 2002:a17:907:c78e:b0:78d:138a:ec4b with SMTP id tz14-20020a170907c78e00b0078d138aec4bmr11231917ejc.381.1666277586545;
        Thu, 20 Oct 2022 07:53:06 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056402399a00b0044dbecdcd29sm12088479edb.12.2022.10.20.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 07:53:06 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/qcom/temp-alarm: fix inaccurate warning for gen2
Date:   Thu, 20 Oct 2022 16:52:37 +0200
Message-Id: <20221020145237.942146-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On gen2 chips the stage2 threshold is not 140 degC but 125 degC.

Make the warning message clearer by using this variable and also by
including the temperature that was checked for.

Fixes: aa92b3310c55 ("thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 1 PMIC peripherals")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index be785ab37e53..ad84978109e6 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -252,7 +252,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 			disable_s2_shutdown = true;
 		else
 			dev_warn(chip->dev,
-				 "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140 C! Configuring stage 2 shutdown at 140 C.\n");
+				 "No ADC is configured and critical temperature %d mC is above the maximum stage 2 threshold of %ld mC! Configuring stage 2 shutdown at %ld mC.\n",
+				 temp, stage2_threshold_max, stage2_threshold_max);
 	}
 
 skip:
-- 
2.38.1

