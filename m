Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60269562DE7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGAIXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiGAIWi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:22:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DFD7358B
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so1693353plo.10
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noUyypKftE40ROE3MTZpJWzx7cTIt4r0kQzFClbiivU=;
        b=anUlmuF/xY4AUURsJoVDq8a+6jE3vDG+mIzYb/pfyha56fzt1qv/ljhrQgm9o+bxve
         Zg0ABJUz/n+zxKw73Awhp/GQGUsZXYw7TDDlWjqgXybkdK0MERUWp/DkHyskqb5XPGe1
         /rT6mYQuDi5mQB1f2FwcTxYkYRoe0c8N347t6v6kuxFQiAHypSUnhxg162GHuKs7y1dl
         jiXER+GymjG9CHTkKUPKi8QGEkoblsvt7ZT3NLr4WCCoDU3eNAsPSvublTsus9S+2cAD
         mw4DNjfGPTozwMVO1IvEyIq+Wha2nniZQBmxW7pqJJ158/L866DL+fEUU50434hmeVwP
         rsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noUyypKftE40ROE3MTZpJWzx7cTIt4r0kQzFClbiivU=;
        b=P1gAFPcsb+imGqKx4zawdCc/prT66UCj1XRRQkHPiKOKNmTwxIKeKiZmIMwne7DI3D
         wTJkKgzDZPFu0jjorUNbkVv0q+XxwTUXpa5wZtKkr1lwiN7xOVrrtK/3BWJ8Pe/MgXbc
         HUv1Twbv5vtTySqDNZ2stSkU3VconRltxFeDqheUyEaxH/Qvq5SDR9dvY+tmInQWjntP
         SVEPBZfnlmlQN5h+G10sKA5Tl+l1le+AH9DmS0N4cgi4ns7nXw8k2UwLlmcn5TUWl3GH
         UUqMdvld/sWEW3zhFEd58AquTpq53J+jF/xJoyDngvegU4aeZqShPGCSM6gbdTx+p7yR
         EEdg==
X-Gm-Message-State: AJIora9QMJFMZQBgflp++yvdg1JPUpSKAuEsxkNTyW14y5P5oRtYUnWp
        mv4f9zN8TeTehPsY2hbJshuhmA==
X-Google-Smtp-Source: AGRyM1vPBHYPyEmnR6pJN+h8oaoYat/QQyCYYbGDGAZ6ThwRx3949kCJYsfczawiYp2t+ZlbH+644w==
X-Received: by 2002:a17:90a:f8d2:b0:1ec:b55b:2fdc with SMTP id l18-20020a17090af8d200b001ecb55b2fdcmr15087951pjd.115.1656663712055;
        Fri, 01 Jul 2022 01:21:52 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id y41-20020a056a001ca900b00518d06efbc8sm15099135pfw.98.2022.07.01.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:19 +0530
Message-Id: <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 4733a233bd0c..ab667838d082 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1347,6 +1347,10 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	int irq;
 	bool console = false;
 	struct uart_driver *drv;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "se" },
+		.clk_count = 1,
+	};
 
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
 		console = true;
@@ -1430,7 +1434,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514

