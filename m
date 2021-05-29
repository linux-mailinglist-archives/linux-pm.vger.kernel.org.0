Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAA394979
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhE2AWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 20:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE2AWl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 20:22:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568BBC061574
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 17:21:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a5so7808609lfm.0
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62sqQhJj4rtXpoeH7WRautHOiasts0X3E3m2jlp8miA=;
        b=sBPxkkBvofnyGzsT4dsXEu74sgnAf9iFFxU2f0T4BxIMod9J7Y1gq5lQzWqnefvvPq
         LYsmQRy4AxXs2Zy4LoEFi0/T9wFAJbDwIPWh7M3EbzsPijszH4LD+YqLKIgwb1Ye0AEi
         NIrhyxv2a3wNQK7+qAw61huk0t66nJvJfMkzuRjwtUtU0GieS+ojm8XV3Cg5euieXNnr
         gjmzhETk8aUMhqWyX4eKYOUQn8VxDsKIRNIeruflKFx+0oFhXfMqg4jsl9LAM7JUDeBu
         YFDvFxP+u0gqVKFXQngKGOOsbOXpn2TXpPwk6c19JX+MDEkVKN37hL1Di+3QgFx4frAR
         +YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62sqQhJj4rtXpoeH7WRautHOiasts0X3E3m2jlp8miA=;
        b=NhQ/ogZrh84Cu8yfQ3MtNjA68kRVFGPHdAXvtbvANVVZPytw/6ZxBCijrGKgXiPquN
         goTvOMBsxLN5hvCDn5FPB7xG7smEfdHx+6/DOivIFuFcBc7b+grZk6ZScJ7rQso7KSwJ
         tviuGrnygwxD4zqqgRv1Yc9Yi2Zaug+htdajhB1lBEZ/zGif3cLoZXBGDFLEoXyp/cbG
         djsb0k4/ilqagd+dpBGQYHoxCDkb+noYzm9W9tJoiqlcmmZnC1+UIl8zjZGyIEysFUmK
         Js3JMgoTvYTSwo1yGC4m0m5TymYlCA8y51yirs75KZ4vcCgLkm/6uma4UU5tZ3NDx4Aj
         3+0w==
X-Gm-Message-State: AOAM530/qq956iTLFe3ILZwZMcNK9MtlUMTlPn0JiiwVXUjjkx3KmSN9
        s13gbYWt7IicnAcFlmJm5/a2gA==
X-Google-Smtp-Source: ABdhPJzMRdW564CPg8PWo4CBqDaHrS/FtRjmsUFowuP2jq+gaX8aqNEJJZPXD21PuM0s5tKUm0L9Xw==
X-Received: by 2002:a05:6512:3b93:: with SMTP id g19mr7613899lfv.548.1622247664622;
        Fri, 28 May 2021 17:21:04 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j27sm590898lfm.296.2021.05.28.17.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 17:21:04 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] power: supply: smb347-charger: Drop unused include
Date:   Sat, 29 May 2021 02:19:02 +0200
Message-Id: <20210529001902.468060-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver is including the legacy GPIO header <linux/gpio.h>
but not using any symbols from it. Delete the include.

Cc: David Heidelberg <david@ixit.cz>
Cc: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/smb347-charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 3376f42d46c3..df240420f2de 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -10,7 +10,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-- 
2.31.1

