Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCAEB72A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfJaSiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:38:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36723 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfJaSh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:37:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so3075507plp.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BcKGfqptsJMIyqg8m+kdv7mwKKvvYfua8/fbCWYYrS8=;
        b=yzuWC7DdKOymjQAIXS3fQpz/AFUyegTPXZiWYggYg5P3og3YOrYbQcc13K4j9/F7uQ
         7hopJ+Gyy5MsAFQeGMVaFz7WSVTAQWBLfJ+T5TkFLTjurRkCAD9SXbgiqgP0S66K9OSG
         cJ9rjMQuiz3+5TzGmdw5xgOc82lXWYwfB4fBTmcvi+OUHRau8VHiADvu80vBzGzPh/Lm
         u3nrGZIBtRPgS+mVNXOXZSx5mfyPbr0maiB80XTi0eFoEsp3VKW0Cws1uCudUxG3rKqs
         2BhXDJDV6z4X8NCLPnRP2yNCia8eNBrW5quyHRQMXq0XWFm76OhsTd3iCAHvWpN6DQWm
         ubbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BcKGfqptsJMIyqg8m+kdv7mwKKvvYfua8/fbCWYYrS8=;
        b=OGugAQBgNt2Px96EBDnzcO36qdtzf5ixluFWikvVZseE8GQPyUJLEUlzyLWjQ/RI8D
         VFEEkdO2Zvudh8VKkR/dA6VvSy/62YxZcLlSx/ex1HMmnKcpelkm5AcTYDfROcFY4uzK
         GiiuVxKjJ0inaNxQ+7t2Pl9HX9JyqPzDABPsQVCMqRFNsP2f9lKNGwY13O3dSj47f3Pq
         VrbIHdb3t6ek6SY99rt2v8p7SEPesMBM7feOLf3rEqQlAfnUwXpvP692NUSZSo7tK0Cz
         jWWaio+DNek+nJSf2+8/594vLoOHz7USMMHxI1FE3+Fggn+sr1DyApdzamftzsHj8rNN
         LL1w==
X-Gm-Message-State: APjAAAVns/rNJDHWDzcKgRsWvjLyDRVscwdobpUSqGaXFnT7ucZwEbeN
        0j5bQaZjhuHUDHIefiDDEMY7Zg==
X-Google-Smtp-Source: APXvYqwjuAbSlQyxe5ZCQ5B+ViJrkgEPcjuxRHWqMAHCoyh2zdIrt4AWP1G2yZ6uE0pPw5gnepChyw==
X-Received: by 2002:a17:902:b7cb:: with SMTP id v11mr116253plz.176.1572547078664;
        Thu, 31 Oct 2019 11:37:58 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id t15sm4237531pfh.31.2019.10.31.11.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:37:58 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v7 02/15] drivers: thermal: tsens: Simplify code flow in tsens_probe
Date:   Fri,  1 Nov 2019 00:07:26 +0530
Message-Id: <184422dcc1c12553e71a58c62e01425fd7d1172a.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move platform_set_drvdata up to avoid an extra 'if (ret)' check after
the call to tsens_register.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6ed687a6e53c..542a7f8c3d96 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -149,6 +149,8 @@ static int tsens_probe(struct platform_device *pdev)
 	priv->feat = data->feat;
 	priv->fields = data->fields;
 
+	platform_set_drvdata(pdev, priv);
+
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
 
@@ -167,11 +169,7 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = tsens_register(priv);
-
-	platform_set_drvdata(pdev, priv);
-
-	return ret;
+	return tsens_register(priv);
 }
 
 static int tsens_remove(struct platform_device *pdev)
-- 
2.17.1

