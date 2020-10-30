Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5A29F9D7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 01:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ3Ajh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 20:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3Ajg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 20:39:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A811C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 17:39:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l2so5737506lfk.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28ZuSo2cqkEQIZKFywv+Qj/Yz4AHHBqrr5LfqXKUmPU=;
        b=uZgE3/pBJGSNq8THZWsjv1EjndsQpSSFCyNCp8kXDoD0EEk0k/JzM70ZHduyifNlMf
         kJHK/sjgNSms89zo5rmn8FemKbWbkwxdwAsYYnA4EBOtbdC41CiU97nI2Qy7PpnZ/5Ra
         izoluzi4OCWpX1Pv2c/sst8bTeogmwCO45h7t+lLmY45020PDNPFhCfsf/GpV+8Jede9
         CLXkzl4W1S9Cit+7vnClPgxP1g+mEC1dM08Pp4okbg3nBNFJ8GUplAiagFNy35zrox+L
         rL7Cv1/KcxJ+PmMOfi7HafmljJJBzYpJyc+Ci2wI0p3vv7I5OI4vizaNciKoaa+mLiMd
         uulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28ZuSo2cqkEQIZKFywv+Qj/Yz4AHHBqrr5LfqXKUmPU=;
        b=Qu7E5Y3CCxXnzcfslMGLMFphZMQsW5KIKbp34wjYVv7c7c1aFkBOE0NfppYQNR4Z3M
         72P78K+IkBpT7VEWCC+tmxk67UTLzEQH/NEiz9y6Fd8OOnnemc7C5Vlxct5H+OdEXXMz
         gqPZzxsNV3RoCHSMkdgBvxUnigvIAco2seoRa4vKidrkbPw49S9LIQGCxNdfLxB/mj/D
         z/romheQ4B74JtbZTjU/24MVMfgkjFrniajzaX8+2KZ52BQYDzfL+RNi0/qIyDp6aNoD
         zFnteeiTArkMQsqoLYqI+C7gN2jxQ3Lb1Mb/7S3pElYgyg+KAhg+3T+xIdwXRtfXHZZM
         jVUg==
X-Gm-Message-State: AOAM533ggWu32Sa0Zf+FtK+Qq0b2KHhdR3W0ahWjfNZLB9ZM/OrXrIZH
        RWYE0bSAdd1jR7cDJGObjl7YiQ==
X-Google-Smtp-Source: ABdhPJy/HkS3poy+elW4gMqwV7jmz8a5OZSp+uI+iUl+j1CzXyN05bjBl6JqgJ9AO/2aFd5apiDUDQ==
X-Received: by 2002:ac2:4566:: with SMTP id k6mr1044306lfm.161.1604018374864;
        Thu, 29 Oct 2020 17:39:34 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x18sm497210ljx.2.2020.10.29.17.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:39:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH] power: supply: bq24735: Drop unused include
Date:   Fri, 30 Oct 2020 01:37:32 +0100
Message-Id: <20201030003732.7828-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver include <linux/gpio.h> but actually only use
<linux/gpio/consumer.h> which is includes below. Drop the
surplus legacy header include.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/bq24735-charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 6931e1d826f5..ab2f4bf8f603 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.26.2

