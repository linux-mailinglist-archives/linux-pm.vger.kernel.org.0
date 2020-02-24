Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345BD16A6AA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBXM7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35921 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgBXM7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so5137956pgu.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yppLt986zP7O7xLvSSLQLlvFJY28BCNk54JkxNyWnDk=;
        b=bTz6qbor82mtycDyKzf3JPd0NDWF6X3c5Cv+6+4VBzxLKEn6fnu6l1Vu/Pn/Q+1qMr
         5AtCcdNhCCqVg8naCc3YBOzH0/lLYFfl36qNQ8EOQoowl/tJsG3rNePjDxek0WGNokDl
         k/X8pZh9KRE8bNki0mUIk7BpSsplRD+dujNz1j37i8Q1ZVpJC/jMEIwIiFp59SDP1ymg
         dAhQeJ4NJMWM0wSreAATTF7b15/3gutSd8am8Oqxg86dcgimoTzuxD7CmtPpExhNwUYh
         GRY3nLpudE8tFXWqloM106vHRyeGPdNAS4NKFbMEH5FmeCmSQLgtzOMKZWliU1RGeTh5
         CHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yppLt986zP7O7xLvSSLQLlvFJY28BCNk54JkxNyWnDk=;
        b=DfbIjZ1xfNoWlRSNxio1/vhVuazqX1hc1Dctn6KDU1ly+pzS2FIqxWzCMytG1Mv1rx
         QBiixT7YycCQaOLMkgq+vAY6PAwVWgshLLBE2PRofrt305DkPjuWiloZzWUm73YTIZ/8
         IIsROJwgvV/VFDRPXhU84wWb0pAjizuQVmO9kcDntnpvq/HddPV/5OFZONVIlwGj1kdl
         o5E8ZBr0DSXi86835RyrmIdIid/E58d9i6LwEB/1WBJwsRJANlOrRaaPsu0ypsNZqCda
         bSZAhS89o7vXsPqIU4dRmOmzTEaLUOo4K+3L5BccjGv80kCkPASh6A/qfZ0mnB7FdK3f
         gH2w==
X-Gm-Message-State: APjAAAU/PqXCjvx5onEKB40aai10Y0n95D45FnDlrasr6kWiPG1G40PS
        wNp7ioKWREv8sYlHeQyhWymIzg==
X-Google-Smtp-Source: APXvYqw+aTKw8nd0jX7s+EBsNkLN1X3i8SmLEGHqzK6eOTQrLZ9p/GoRByaGeYZvox38yV66v9kiLQ==
X-Received: by 2002:a63:e54c:: with SMTP id z12mr51521536pgj.415.1582549173602;
        Mon, 24 Feb 2020 04:59:33 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id j125sm12926717pfg.160.2020.02.24.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:32 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 8/8] drivers: thermal: tsens: Remove unnecessary irq flag
Date:   Mon, 24 Feb 2020 18:28:55 +0530
Message-Id: <03f36313db88f31177d1875bcdfb0be50efcd2ca.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
property. Remove it from code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6c6a75528b90..031a656fd2a8 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -104,7 +104,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	} else {
 		ret = devm_request_threaded_irq(&pdev->dev, irq,
 						NULL, thread_fn,
-						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						IRQF_ONESHOT,
 						dev_name(&pdev->dev), priv);
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
-- 
2.20.1

