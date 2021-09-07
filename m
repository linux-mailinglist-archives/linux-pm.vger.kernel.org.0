Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8F403043
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbhIGV1N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 17:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbhIGV1M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 17:27:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7C4C061575;
        Tue,  7 Sep 2021 14:26:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h9so964262ejs.4;
        Tue, 07 Sep 2021 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=us7ujJHgaYuUoPocxxSs28LNDWD7NW64na2pc5RbyoE=;
        b=c9V3Gn59/DxBekqd6S8IF0FAcHSkubEzHWLRpwDGTf7jHGKdw+5BNIeitVNlXxaSF3
         I7XLNRiwD9hICJz3psfihthkDMktBskxfLpMg39of6vRTdVYaHmX4FM7Px57Wd/WfMp/
         ANgKFUj1RDrP040u0YOoSR7MqKZV+yJCcGxE3Kcp2ClW6PzPNVVFku53ls4jKUryQ47O
         im+fyAHlYJDGLH0fN/Y4fzUm5qrJQFab4hfLt4POOyAmXQO8pE8OvXtl0YvbBUuAjw2H
         mQyl8xrxnHSrHgpVpvOekfkjsT1Sb7ssAKjMI1+feAu0y4AtzdlH9n2FERYzlWxiLn1i
         tuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=us7ujJHgaYuUoPocxxSs28LNDWD7NW64na2pc5RbyoE=;
        b=gtvZZ8NsjbCOL+skeOJgT7H2iE5NTa+AU7t4em13Pu909BU/Y5eVlcj8c37CCfYyQJ
         rNs8vny0t2cg3Fv7fnGLaNkG1ZwaKkJtIbw4qm3raqFsw1CQytzfwgaVj+1Jx8Stxxtz
         kRGTVLMRfuRMA4zO/NhpHiugm5bxkpzpU1Rt4WS7phpfVveFfC6i/wqMivjXljTmDLLD
         kdliwkq1Zeiinz30LekQYm7Q9QOv2aEr7qMN3+fXO2CuXxEvrkBm5J311aNGh30IQUKd
         4g0Uuu7WHgcksvhUHX8a+NTG//q3pNpENADuV9np7Jt5DIRIKxqqMA0Fh9zNrIrpr0Bd
         C0QQ==
X-Gm-Message-State: AOAM530oTN2tE6b7iijKufLLfULnIVTTjYXuZlFhTxoIMA7UOR9WUu6c
        gaQJ7nc52rn7IR83fR/HsZI=
X-Google-Smtp-Source: ABdhPJxDeIHUDSJes6BnCpg/P/wJI3qYMzlKI4gVzOP4vSGrTzPsiYbPIF+SXZgxA0YEwDOHFD6Sxg==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr385709eje.240.1631049964524;
        Tue, 07 Sep 2021 14:26:04 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-87-0-193-30.retail.telecomitalia.it. [87.0.193.30])
        by smtp.googlemail.com with ESMTPSA id k6sm105954edv.77.2021.09.07.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:26:04 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/2] drivers: thermal: tsens: fix wrong check for tzd in irq handlers
Date:   Tue,  7 Sep 2021 23:25:42 +0200
Message-Id: <20210907212543.20220-1-ansuelsmth@gmail.com>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

