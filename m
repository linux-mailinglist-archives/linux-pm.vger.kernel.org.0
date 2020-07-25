Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4232422D93F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGYSOg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGYSOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B980C08C5C0;
        Sat, 25 Jul 2020 11:14:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so4842874ejw.12;
        Sat, 25 Jul 2020 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZq6iSEJzQZeX+KMbe5S3mYN5TR9xQ9TPOkKOJIdWx0=;
        b=r/XiTCA+zkvH4OnyU4VtR0E2aFGanWasmZfjjmN5UdpsmQIEEoUwWoFWOR0EZiyS0x
         BXwF1DycHWmaauX6QNsd8xFwFeSvvhG42U2Dpn3222fUTCVeANdWF+yICNtRthmQ+Nqr
         u4NN/CQ1ImTbkVsSpJKteRA28A+c7pF/0uKofx0bKUBt2XKOHZ6+Ld70sI4GYj0uzbcv
         2K9xcB1bxXYFdZsBsT6A/27UvGcVFDpcl/7P+U/kir4KRCH5VmU3oSsHyVHKzy4jlL81
         eRXg2ECNHjMxbDCU5F0hHWu+kJJzIoR/jNPJQ1Wph8gOMQksWLKK+XDrrHA9eC+W9UcP
         H2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZq6iSEJzQZeX+KMbe5S3mYN5TR9xQ9TPOkKOJIdWx0=;
        b=QXR8Vd09aktK5Jm28RdQvA2urjTT4zdh/dAF8Z0LVCwZ4KoXT4kfZu7S401H2Ok1HK
         ivq+qrag39cTYjbQfxsCG2jNcj9pGS0WmIfgt/vmmGYM6xv9L5dMEiMugBbmGCWqR3BZ
         yY19XRDr8AVSb+DCm53eimIzKpl3gNz4ORRI7jt4H/8z4YqWEIBnQx0rxZavdSb1MgZU
         n0a+ofzS4X/8Gg0XtDwasIjzofkRRIXohEHHyzPXqDKkeK6wMfNvQGhXk4Z+D54zJ6Wg
         /J09H0Gqd0duhMWI2X/cvU7or7BAi7636dSiByclTFDetBQH5k78j2/piPhHcxBnKPMF
         +23Q==
X-Gm-Message-State: AOAM532tDnHCJ3/bWkVDsvriNkctMIp6VEX7jzlsMjOAb63KHMDxIryA
        ADGXxoqGx0sH/rWdtxxdx+1lHzh7mug=
X-Google-Smtp-Source: ABdhPJxxhQmkDQzxbeUSbEaP7UAT+soJtg9Ycx2wVm26lIKihX6DGCl60a7Tbi2Br1m1tzg/jiJU7Q==
X-Received: by 2002:a17:906:3c02:: with SMTP id h2mr3345193ejg.437.1595700873777;
        Sat, 25 Jul 2020 11:14:33 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 5/7] drivers: thermal: tsens: Change calib_backup name for msm8960
Date:   Sat, 25 Jul 2020 20:14:01 +0200
Message-Id: <20200725181404.18951-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Follow standard naming for calib secondary rom and change calib_backup
to tsens_calsel.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 42ab8f79bf5b..b286641003aa 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -191,7 +191,7 @@ static int calibrate_8960(struct tsens_priv *priv)
 
 	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
-		data = qfprom_read(priv->dev, "calib_backup");
+		data = qfprom_read(priv->dev, "tsens_calsel");
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-- 
2.27.0

