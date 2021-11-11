Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7973E44D96F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhKKPvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhKKPvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 10:51:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E421C0613F5
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 07:48:21 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so10215286lfb.5
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UATOFTcvot+ZWXEfZor6OUMDWQPBJNsNIf4HNN0yS0o=;
        b=FfiwWvwRx7BDv/kRc2WbSKnYanUGtAxObNt/Q0ebX5aTYkp+3aD5QPjzBYMPuopQ+f
         uzsSCF7b+Bkv2lprT7/MQiVNg+ax6fvKug8wR0zJjGrDqL7i8Sx3qLxnksPpI5YKlAxN
         FDzu7tyFFO1BMbyR4lxa0aOVfwW5jZ1f6g225/suzC48lgrHcHN77HJ1DBDXmzNlSbal
         BBKzx8OlBBBFiiKhP+zoZN8XtS8ekorAlIMiwuEIujwD6ihY0TbyRap85Zr43HbSron8
         g9y326cZJFU4FkYlIBA3of4WBDPRBhr5+Vcso/fDKxzoDVdWZ5qBwnecwspFMecTF5NT
         vUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UATOFTcvot+ZWXEfZor6OUMDWQPBJNsNIf4HNN0yS0o=;
        b=vksXRSyUJJh1BTBsAYxvbSOIPf40XF2g8cOzOLTlEC/EpJwiwMTDc0XYcDZQplHWo0
         u6noF2QrLoeIWzHR6LteCMdNmmSioVzQxNj+NV4zGy9gLJUow0dkQJ2NoIur8bUkINiA
         37O9MY0og2QZLhxy/eO5VzCJoiUfLpWJhUU987Ly3imGYwCAxCdIK9pPzn5LvjA5vgd3
         C7HW2PCg6heTYWj2Lfdz6bQIUE7DYczz1Z+7rmZcjCsJMzfCvNca5OyMqeOA2PsvoGHp
         L3NAGgQDNYVSgGriEv62dO8dtZN+c3piMN6zatv3RY1vmZgUpeJn+2u9UrJV9MgiuQJ+
         JwxA==
X-Gm-Message-State: AOAM533lH8SJ1U0VQIWMQQvrZkiokIA6Jv+m1k2ueJKaMQRhno6S2Mk2
        OAtAEZehDNaDIA2Epr96s2F/rA==
X-Google-Smtp-Source: ABdhPJwJpGSMbj3RqMzFeTwOry82hpJ8HROdgW1Uthoq60xCMLPIl7KSKSwCyhI3rzjskSgb2NdqAg==
X-Received: by 2002:a19:7902:: with SMTP id u2mr7426394lfc.644.1636645699998;
        Thu, 11 Nov 2021 07:48:19 -0800 (PST)
Received: from localhost.localdomain (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id t9sm317072lfe.88.2021.11.11.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:48:19 -0800 (PST)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH 1/3][RESEND] cpufreq: qcom-cpufreq-hw: Avoid stack buffer for IRQ name
Date:   Thu, 11 Nov 2021 17:48:06 +0200
Message-Id: <20211111154808.2024808-2-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Registering an IRQ requires the string buffer containing the name to
remain allocated, as the name is not copied into another buffer.

So let's add a irq_name field to the data struct instead, which is
guaranteed to have the appropriate lifetime.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
vzapolskiy: rebased, added all collected tags and resend the change from Ard

 drivers/cpufreq/qcom-cpufreq-hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a2be0df7e174..3b5835336658 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -46,6 +46,7 @@ struct qcom_cpufreq_data {
 	 */
 	struct mutex throttle_lock;
 	int throttle_irq;
+	char irq_name[15];
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
 	struct cpufreq_policy *policy;
@@ -375,7 +376,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
 	struct platform_device *pdev = cpufreq_get_driver_data();
-	char irq_name[15];
 	int ret;
 
 	/*
@@ -392,11 +392,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 	mutex_init(&data->throttle_lock);
 	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
 
-	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
+	snprintf(data->irq_name, sizeof(data->irq_name), "dcvsh-irq-%u", policy->cpu);
 	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
-				   IRQF_ONESHOT, irq_name, data);
+				   IRQF_ONESHOT, data->irq_name, data);
 	if (ret) {
-		dev_err(&pdev->dev, "Error registering %s: %d\n", irq_name, ret);
+		dev_err(&pdev->dev, "Error registering %s: %d\n", data->irq_name, ret);
 		return 0;
 	}
 
-- 
2.32.0

