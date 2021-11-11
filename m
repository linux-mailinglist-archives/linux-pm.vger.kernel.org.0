Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6634844D974
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhKKPvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhKKPvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 10:51:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1CC06120B
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 07:48:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y26so15104141lfa.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=As4SPU2HNw/uSYo3wiPhuwsWTw7UAIcN9Wz9SQIBTCw=;
        b=WPDt2PjpvXvhUb4Qn8/iS5ZAUWLLBe02tRrcpEl0VBY2D2k2VjCkorM4Gl5rui3bcP
         Z598mFkyBfKlobtGusehPxCMdmiAI+XaUgJ2gwLLtuu4/MweoICUDkHDsc7jFVeOmZFM
         TlfxqpZfXqiarroH0qecye5HlUgWkps6ju6/1x58ZarVhSY3nCuVHYtg/8r/BBgzvqrf
         SuNuUBLT0ki4owa4blQ9RXkB1rP2eNoYBCVPFWlu95n+9r91FEI9OKhOd4L+9qajbgTE
         qsteIXGfzF4DIJ25/OSDMn33CyW3CaOzyrJW0yOVOv23Yqw7P4A+M1d3lCxVDs2KN734
         6Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=As4SPU2HNw/uSYo3wiPhuwsWTw7UAIcN9Wz9SQIBTCw=;
        b=gT2XS39FlGrD9aVLYyjCZ+rL0GArT1xUI0F4c0d1A4eQsMCz8Ti33S+4fPU9ucSRJj
         vvfPYlgUovdSnmu5KVk228NVwAD7l2YTFC8k47SmCBgcmY09GJggAuOcLfmx1957aMB5
         vaAjO+tU9L8qsBeNdLM2s6Cq+LOuPlXLCiPOz6MsbCOuSVw32VhMKwoPdgk4sRsuBCKs
         q+QOrMDgbvdOEl2lIOMu7vJlVsZZUIzLuK0b2o6cQsn9KI4J+N6vJ6AbGiS+7STX7oY0
         hHn52XEUGe/Pdy7xTlsAEDeRK1y85C4W9qokaSUpEoh80slI6pKCZmX1kfZ4EelzESKK
         440Q==
X-Gm-Message-State: AOAM530OMPiRvHhCSg1FSu4HTj3sdXh3QSgapybJ7rMXAlcheg4pKFBc
        X/Dd4Lw2MOXpafI6nK7aTalXgQ==
X-Google-Smtp-Source: ABdhPJw3zHckNbYTIU+0HdQaGJZbCmNg9Jm8Ah+oEiUgBBZtePi7xoyI3Cg/WKmu/V+aY4JPCOTAxw==
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr7575602lfg.547.1636645701349;
        Thu, 11 Nov 2021 07:48:21 -0800 (PST)
Received: from localhost.localdomain (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id t9sm317072lfe.88.2021.11.11.07.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:48:21 -0800 (PST)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts
Date:   Thu, 11 Nov 2021 17:48:08 +0200
Message-Id: <20211111154808.2024808-4-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In runtime CPU cluster specific dcvsh interrupts may be handled on
unrelated CPU cores, it leads to an issue of too excessive number of
received and handled interrupts, but this is not observed, if CPU
affinity of the interrupt handler is set in accordance to CPU clusters.

The change reduces a number of received interrupts in about 10-100 times.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 5d55217caa8b..3967191836fb 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -400,6 +400,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 		return 0;
 	}
 
+	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
+			data->irq_name, data->throttle_irq);
+
 	return 0;
 }
 
-- 
2.32.0

