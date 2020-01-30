Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A414DBB4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 14:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgA3N1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 08:27:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51702 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgA3N1p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 08:27:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so1334998pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2020 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pomAiPgtoR9hWjv7O7J3D7woUIclgXwvwvp+FTh+Xkc=;
        b=ZgVGj+Xjty+b8TbQTeuSX4IRcaCODllhvIOAdUsKTcQGjerqKlWz/naS+7dHeVZ3v3
         bmfyYWU/EYGnBW5nmfLTXdJullrWqYDPckcERQUZfoZc0VnHqPnOYAEZRiK7zmHEQo6q
         1z9Hi8us5lF1vDdf4ZuRS1k7uAWGbtW59YtyUasoaFvIj2prirzeHdbLm4Rwe2aTziYt
         /kEERJXvs/aBq4ybV8XwT2Wtmqcfc+bYrZJY+hIBX2WAD262hGrLqRigK6CNvS8cjSCF
         iwDcYkRSU4nGfXZwTcq8xv7ngZMqzpJQXUG4UfyzgHdGxEPAuSAJSQuGKq93LQzzROYT
         ZcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pomAiPgtoR9hWjv7O7J3D7woUIclgXwvwvp+FTh+Xkc=;
        b=OZ3361xBGY+YxY0Uv5ZNhO9VoEoQRM8NtDZ1I0BgZ6h5AfQQ6kJb9K0c0NJgfEQ2Ng
         qL8rID2v9cRMVo/mlNYhE8ty8VlZFPFEChP5VpgE+wNate2fHQ4+7UtuhQscZHNp/5h9
         sXkkl4u89QhDLr3Tast6Yb/wZ5uTZH/RDy660yyQKQ+XUOLgCLt7Pbv0qG4Drtkg3/Wk
         gIjI0GvXDrZ8QogUSh98jAX5LB/RDuLN7mfifwmnTj/P86lcQHnGOkU04fA8TjaKKkb4
         5+ETHQ5zl1wGjjCX9Z3gnzAvVh4M8k5l4wJpAjcERMi7Bxu7d3F+bex/JH0PqHyX/93e
         n3aQ==
X-Gm-Message-State: APjAAAUYVSa7u8EjLp4OgpwL7sNPOpks0Jkcid8Pdss9eyKSTEP/yWfR
        oL0tCj5lm3xYsWtey03a22PDRg==
X-Google-Smtp-Source: APXvYqxhD3CwYxceVh8ePcp5J8g05jLBz0vgt4lcREJGnxcbxpgzim8BcdEJ/8KXfLQ+sRj82Y0LTg==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr6097193pjn.51.1580390865120;
        Thu, 30 Jan 2020 05:27:45 -0800 (PST)
Received: from localhost ([45.127.45.97])
        by smtp.gmail.com with ESMTPSA id gx2sm6625098pjb.18.2020.01.30.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:27:44 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 7/7] drivers: thermal: tsens: Remove unnecessary irq flag
Date:   Thu, 30 Jan 2020 18:57:10 +0530
Message-Id: <b6db92ea41420c907beb7643f82b6b8011645ac6.1580390127.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1580390127.git.amit.kucheria@linaro.org>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
property. Remove it from code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 5b003d598234..9ee00c67144c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -118,7 +118,7 @@ static int tsens_register(struct tsens_priv *priv)
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					NULL, tsens_irq_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					dev_name(&pdev->dev), priv);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
-- 
2.20.1

