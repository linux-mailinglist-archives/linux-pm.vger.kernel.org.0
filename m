Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D84B068A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfILBez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:34:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41303 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILBez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:34:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so14826482pfo.8;
        Wed, 11 Sep 2019 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAw3ZgfIAbV+DLrxuqn76+3d6iL0+a1iD8Du/3M3fWo=;
        b=QDwdEnFYOEjquzyvaZLLrev8sqjiI67CJmzTJoMStwWOKuXMenWkbHXyiUGr/MFY5+
         HPsXalNV/KvGQiwuaE6CVmeyeGcxopkzi5IAcyl4pj8YWIe+6w95KjqimeD2c5jGRTIf
         UzogCb4mDQb95Zcd3W7uhT+9PH/QJnhjQS4lgNm2aeiGnOlwjyKp5RqEyjkMiHaiM2L7
         nXfUxnyRC24FeCGkaxGfV0WVfdWaMUrPMBU8+oM/cOOzvg/gbZZyvn/dC1Czoh9vOd7J
         iBEgJoUqvdX+T7ReFCFMdPFH2NJruQHTIiXk09sKED3b/vHc+iE9IyHHaV8j7LRSCjX3
         6Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAw3ZgfIAbV+DLrxuqn76+3d6iL0+a1iD8Du/3M3fWo=;
        b=uXyaYFr8qhNYx0IeYKax8PFJ/PWGu+WKzaZqAwikD60p2eQC5QHPpD9lNTnMb2ljO5
         G13z7mj/8t2aHgvblNQ5FrNgqleyLk0NoL+wJMmVwZSsqbiDzZJZDHUjwJgpIKHTN80G
         pb4cKCQxYgSHGVCAkILIe2iT+Bk7jpoBslGVBBiJlUVx6cGNbxVSkoxk07n+/r+Ks7DH
         gWx5Brut8RvSgeMfFdZCVv1kE/D4eARWoMdEJ30g156DglgDv7I9fKVrf+I369ke3GKN
         WcjZyGMWPlbaJVATMGjmg2ZAr2VbekLOj8B8Ejlc4Bs2cR/tmNVF50XZCAU4aA2/TZtY
         K2CQ==
X-Gm-Message-State: APjAAAUjdE3D19sbDJ5dxk6CbH+jMZGeoOJBCMZcOLWAHNa+sokyM9Ax
        tTHb1L67WDl+IyGWQQe1RPE=
X-Google-Smtp-Source: APXvYqx7w5SdqbtZit/UJOQvKzOUmxY1sHB8IATpV9+rVYda5jx/hshNibVFAh0Ea5E5Fo9o24xS8g==
X-Received: by 2002:a17:90a:2464:: with SMTP id h91mr9248861pje.9.1568252094496;
        Wed, 11 Sep 2019 18:34:54 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b126sm35248236pfa.177.2019.09.11.18.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:34:53 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/12] thermal: qoriq: Drop unnecessary drvdata cleanup
Date:   Wed, 11 Sep 2019 18:34:42 -0700
Message-Id: <20190912013447.2977-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver data of underlying struct device will be set to NULL by Linux's
driver infrastructure. Clearing it here is unnecessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index af596c3342d0..8a28a4433d44 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -253,8 +253,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->clk);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
2.21.0

