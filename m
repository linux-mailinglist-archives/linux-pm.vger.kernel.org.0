Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C551B44D970
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhKKPvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhKKPvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 10:51:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6457DC061203
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 07:48:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e11so12699411ljo.13
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vm/CQHumQ1uukLhv2xWgernc5RdPc12W87OkHQ+477Y=;
        b=XxYpt9ltP6c2AopfLgF2vjY1/uR0wJbA6FIaTCU0bHqBNAUESxTcjoMHGcQE44/F49
         g2/Eqp44C67yN0k1oYUAK0ezbq551E5kWKCklGqv/4Pr5akDOhsXFLcefNkUj1onGca6
         FFU6u5YoOgl6A9b8ZEuvakwMyXpvUIjzsA0LSJp9JqzP6HIrh8Nlnl3zySVIsTSuIoge
         y7bPGKFpsGgazAvZzhx4vt8Yym6jNbd8P1tnNGCpCjbCU5GpzrlER9PSeDG0K3TqMjpB
         cQBCatYgMqx6xvxvZSLmJAIBBF/qri4+U6FAKWejbwGDFOceBM5oW4wqnLlHIawVK3L+
         emsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vm/CQHumQ1uukLhv2xWgernc5RdPc12W87OkHQ+477Y=;
        b=B/3uekh+CiWefK00MWBgmCB+t9cyhIQDAI/d/Z0ypLkckfU+kM/3jAOPS03iWPoT+J
         IlLwWXL801lMo0T8UqgHD8PyYByJaLygrzISFpWyvz0leJFXIgzveaYkZ+ixtfd6dGv7
         H0zpdnsyEt9dFWJzLlRQZM75LANmHKc8ru2jzsnGZOFSzh+jQvhTAFlILF/B8vkZaZmU
         syJiUwubF8a8Vyqvv1WcTRVwHEWoNBFrRX+EGLM8i8lNN0BMn/hgHAa3d9kV49xXhcgQ
         dIfgBrVxnPqBzDiGBvJmgNhsKJiDOPY3TN3c777alSzSzzwtTSYrq76fYPVjsqRIi+Dr
         HO1w==
X-Gm-Message-State: AOAM531af63jRt3EbM3Q6zeVi8YaT/2Tun69+g3P5qhJsoDzm8Q4f3Vy
        xTqvQ3Ud70tVQMW92B+3S8ouxw==
X-Google-Smtp-Source: ABdhPJwsvEUTrt78lmjoUsS8uiF0aU5osIvGnEd7eZ3BWeyJKnI1IJJEq2bqsGLYoTTheTHAjmVI5w==
X-Received: by 2002:a2e:869a:: with SMTP id l26mr8408179lji.453.1636645700806;
        Thu, 11 Nov 2021 07:48:20 -0800 (PST)
Received: from localhost.localdomain (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id t9sm317072lfe.88.2021.11.11.07.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:48:20 -0800 (PST)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: qcom-hw: Fix probable nested interrupt handling
Date:   Thu, 11 Nov 2021 17:48:07 +0200
Message-Id: <20211111154808.2024808-3-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re-enabling an interrupt from its own interrupt handler may cause
an interrupt storm, if there is a pending interrupt and because its
handling is disabled due to already done entrance into the handler
above in the stack.

Also, apparently it is improper to lock a mutex in an interrupt contex.

Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 3b5835336658..5d55217caa8b 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -343,9 +343,9 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
 
 	/* Disable interrupt and enable polling */
 	disable_irq_nosync(c_data->throttle_irq);
-	qcom_lmh_dcvs_notify(c_data);
+	schedule_delayed_work(&c_data->throttle_work, 0);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static const struct qcom_cpufreq_soc_data qcom_soc_data = {
-- 
2.32.0

