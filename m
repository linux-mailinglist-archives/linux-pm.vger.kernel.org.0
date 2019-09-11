Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A015AF6A3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfIKHQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 03:16:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfIKHQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 03:16:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so11037623pgm.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BcKGfqptsJMIyqg8m+kdv7mwKKvvYfua8/fbCWYYrS8=;
        b=o7pSB/lBJepCsIAK9wwEl+41gBqxhzj1JE5Xk93Xw+PiLLGCJiaRXIgX89oRURyZnw
         l3RtJSgM55DVzGJjWn4+MDNVoP63T55tIwc6Q5UURuq4/Y3FFS5V23mHe1sVX1K7hWed
         oQ2vD5nDD4cKYHQMqs1ShVZ7s1ZcieLRdx12COreB9e9vazjIAfQH0qkMOxgbAvMis7H
         /3XEpCvRHuhZx7j6J3FmzwjCMwDqLMzZd/sIa4LxZhl+TIQWHZbDva4KqVoad2s5xT7S
         x0eDDX5jO85RYBiiXqBTADEBhZwbO15EZfMLKNsiNqF+bExaugY7uXjyl2+5UEzDL894
         EKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BcKGfqptsJMIyqg8m+kdv7mwKKvvYfua8/fbCWYYrS8=;
        b=pNcpU3rUWoC5+zSg/xfmyBzKunwhxXgU5YG+lpfdtKb9w9V4biaO6MQ7Ci1PGoM1wJ
         Tn2Idzyqzk0uosW1Ywqmxp7qcrBYVQ4xtpYnTaXqC5l2au8Tx6mmaoMMJcVbLIJFTfjw
         zok29MitfUr+49N6RZQN6WBC5Y74T/fl3Vkn362kiQf1q589tZZCAaSh9W93EckCTTh8
         hPdC+n8XiAXV9iZN4z6wYWcc5LKnn7QGtMVbFJDOl8ZtKLiUCF+4tClAe0xuXrqkvTSW
         vB3gBsq4I8w6488Bv6PnYV1ll8dWyu35D3LRK2Ieq3Tl1o24/NmC0KJh7ZnUJhXW0DfW
         ak4Q==
X-Gm-Message-State: APjAAAVrwEsX9N5t8RW09f4M8kT4bz0i/G8vSRhkTaCfh3U1qPaftQEx
        Ij477fQNC7AI12uCZlXSjw+MLw==
X-Google-Smtp-Source: APXvYqzuDX6VHtcQh0PUvMrGvJDnEXpgaLZvpgIkZ3I0Se0OK+dS/HGC/5ZNZQgJPkc+n6GUjwf73w==
X-Received: by 2002:a62:e508:: with SMTP id n8mr20353567pff.199.1568186207721;
        Wed, 11 Sep 2019 00:16:47 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id 20sm24094678pfh.72.2019.09.11.00.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:16:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 02/15] drivers: thermal: tsens: Simplify code flow in tsens_probe
Date:   Wed, 11 Sep 2019 12:46:19 +0530
Message-Id: <dc5468cdf64e5acccd37fa9b5e849f423874764a.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
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

