Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51EB401110
	for <lists+linux-pm@lfdr.de>; Sun,  5 Sep 2021 19:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhIERsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Sep 2021 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIERsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Sep 2021 13:48:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B16C061575;
        Sun,  5 Sep 2021 10:47:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a25so8545490ejv.6;
        Sun, 05 Sep 2021 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPTgk+6VDV7cqIzBWH9iHUKNBo8VRMuUrDVvx6Vhfv8=;
        b=oASsapjUASenmM8q7W3V51MhNIEfubjZdssi3Yxa6yRy2sTvPXno1aHYhPs9GZf3jf
         4IHzE8/yfCZ/Px7jdIJhanDC7qWoGWmvcRsqrcaX19A5cjME6xxJh6A9Hn17yVO+fzXM
         W1VAC0eQbnBLB+r+29KdOOrZ+ETe84ogZdCcpfqQAjFX4PyY+S5vAJ5rw8txEd7FBNgH
         5sLYH13xQaxi7KlCpFQcdjbj+fCU9MN8quhPthKOKJZhr3HuweXsnwq1Ddw5jSVzd6nn
         i1XE9MBo5jts04xH32mxsh4yiJGqQLBHuJ2KEVB8vnoFqthqds4rKxXL4D6XxbEgueuk
         DJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPTgk+6VDV7cqIzBWH9iHUKNBo8VRMuUrDVvx6Vhfv8=;
        b=ezzByBlwAhOjizsiowe/7svKk2g7HWg9+o6Ry9HuolWUaxdU0q/k9y9U741ukemrVS
         gPvlu92JosB9f4M6/nSAtF8w77SD97XuOhulaD9wbEo6h53GSVVOcJp6+5OlFISL3Nfp
         915TEfm9zzE7Yf0z/iVpgfjvUyrIDEirYsM63AActv4TgDp2QPiNzJ6O1Tfg2+mH/Dq1
         CRsQR13mzXcaBb4ef70Dqk5I9Sq+kujlTg/y9141bGenuZZywe/BfcOmkic4cPbDOGHk
         ZHhlSVP07yNE/BhEVhgP+4rMl0a9c/K7qtx6/g5kpQc8V2XEMPQ7MCvNG/bQSs8h7Wmj
         YvEA==
X-Gm-Message-State: AOAM530DI/lnbEncXKlVdBN65mm7SGfIKvOdmAqltNjtXq4X4diRGfNc
        MaZ7RNWwLk9bCwF1s6Luuxg=
X-Google-Smtp-Source: ABdhPJx7JIBrg3ilGgQPg/raeXGAXbys19569NsKbewQxY9jopCop/kqk9FumzaX3qto/kixLNMAaA==
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr9692505eje.341.1630864052971;
        Sun, 05 Sep 2021 10:47:32 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-19-158-155.retail.telecomitalia.it. [79.19.158.155])
        by smtp.googlemail.com with ESMTPSA id j13sm3165986edt.72.2021.09.05.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 10:47:32 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] drivers: thermal: tsens: fix wrong check for tzd in irq handlers
Date:   Sun,  5 Sep 2021 19:47:07 +0200
Message-Id: <20210905174708.4605-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some device can have some thermal sensor disabled from the factory. The
current 2 irq handler functions check all the sensor by default and the
check if the sensor was actually registered is wrong. The tzd is
actually never set if the registration fail hence the IS_ERR check is
wrong.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4c7ebd1d3f9c..b1162e566a70 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -417,7 +417,7 @@ static irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(s->tzd))
+		if (!s->tzd)
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
@@ -467,7 +467,7 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(s->tzd))
+		if (!s->tzd)
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
-- 
2.32.0

