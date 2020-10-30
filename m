Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EDA29F9C8
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJ3Afs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 20:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3Afr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 20:35:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39FC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 17:35:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y184so3726490lfa.12
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P84cAM8B/s6EMIPcX7opAA/0mD9GxZu49bIRTvOQCDA=;
        b=abXjsHeluHrJrgxujA0iTHCX3jWVbxqFRdsmgFavNOnJnwwKZ6WSrcpzU9PLJGTTX3
         jnww4aVYtk+psUO5qiesfrO7DqsabVuMSjUEG2KzZNVAxwKWFPqfFdEwhQVJD25DcP3O
         vQh/2MTzUPU1C0hks6CAm2E3BAwN6ORZPrrjD5cLHcKxbFSOMonqGyLCrY/Z9rHoC5IV
         cOMuHIe19CdrdQlwU/IS7AKCmIXEC+UIv99Vaeq1tsyzJKKFXTSzPaGpEfKaq9eglY7w
         l6J90F9PTIfCauI0u3IF/WSC/lzihZaremWgGC66Ui5nkXDqJQv0+Iq2btSE82N8ui5p
         45Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P84cAM8B/s6EMIPcX7opAA/0mD9GxZu49bIRTvOQCDA=;
        b=Dx66lQhDdvQ6lUPSEJUYXXbBR6ZZ3h1dofAT5dQ5RxcBs2ffZ9/BgGe2rRtTiV4RZj
         MUIRYeIKJX942UPKgv/2roTJdxxoZDA0fRK4k5Y/ZCRogigvSVLi6xm27FqFH96oGKzT
         BnVI6DagWRLzIKiHO1nKpVsPQinxM1o8O5MY3PtAn2AgjqfeZBZ/WlRpMR10NsrpQmp6
         HJj43gVtpR29XyA7LThkpIS6DWHyXBpZsiOwkozcCa8Nbk5yo0O9S7Q6oq1zFLvfn06+
         oh37UdpMlHsRWguMCAvZRGayl/JrpOt0WyDuCyjqs5cEB+USBUatDDfzkutmasP77Pv7
         bV6g==
X-Gm-Message-State: AOAM533+kIMTtVYt4CWgVj0cpY3l4UiGG+H5LoLMwaQplKpMHQmo/HS8
        UFZqOMLnJPickafzta9x9C0x8Q==
X-Google-Smtp-Source: ABdhPJxtfpX47JUM0w4I2VX2MuMNjAac18HDknaTSNxkkrIikVq69879ufwpw0ApryASqffHAe+SBw==
X-Received: by 2002:ac2:443c:: with SMTP id w28mr2404386lfl.405.1604018145190;
        Thu, 29 Oct 2020 17:35:45 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id n3sm441705lfi.37.2020.10.29.17.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:35:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: bq24190_charger: Drop unused include
Date:   Fri, 30 Oct 2020 01:33:36 +0100
Message-Id: <20201030003336.7323-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver includes <linux/gpio.h> but fails to use any
symbols from the file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/bq24190_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index d14186525e1e..4c6b3648a701 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -16,7 +16,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/workqueue.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/extcon-provider.h>
 
-- 
2.26.2

