Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2314118DFC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfLJQmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46723 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfLJQmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id k20so78604pll.13;
        Tue, 10 Dec 2019 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkuYRLy1ofAGSImjiPenlpmLUxwnT2nMpEQWVPZ5MwQ=;
        b=Y5TxFprYUtsGWcFEl4Lm6WMCQfOYOqTlZO0TqmCMJv52nHQuC65B7PwNGN/X7VUeDj
         4rZnFmto41tnf1t9hzvdjA3+/sP3Tky8i7sBk0Z0kAltU6o8zYHD2HrD8V7v1G0aDZku
         H290a57FG7kQpf4nip85l2o8uS1Lt1Xri1p8aIhNOViKU9xIRTou7SgJdEbfovylJdwg
         n8bxvEUKbX3Ct8sGH7m8qwaBypmXAF7wEOtM0/Q+XGIRw68c1k9O1g494pjW5+7nrX6C
         +PuSQ1+8kDh7ZCPTwphYuBsJYL3FRoh/RYwQv1oPZd3jRKpfuNguRteSnzctA2/GHVi7
         X+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkuYRLy1ofAGSImjiPenlpmLUxwnT2nMpEQWVPZ5MwQ=;
        b=NbMZ1Vd3MEvU0h8qfc1zEIMPUqvoMbGheiQw5ozgttQo1kkxq/KfSNcK0Nlfre0XcK
         /qTJ2Eve1tjF5bFfKsehno16+QMipuT5y90f0F8/1Bjb1+1LE6tmOcf7F8nK4Z2xUHO3
         bpCvOpPWiY5TMwA/iJ7DpKl9N8C7Gp/Wf/778tdbjzTnPcxzzbyLfemcBJMpjYwzBWXv
         WvWkkCnOL/yRPY0b7mmahoMvOUvwgr/PlCmsF4GhBkAwxwqMkkf+Qqr72qDM2PzBIrMT
         UgPuCmIN9gUBr29PEkgFMmXCddbtYiT4nq1MDJMrIZU70T2XB24Dal8w6d0mXk15IxGJ
         yIgQ==
X-Gm-Message-State: APjAAAUStGITNx9EegCTIW+ffo4T+YCGGLqwOqrK/ZzHC5j2wu825cVX
        En4EAEQEq7ORMqjzosVUwM8=
X-Google-Smtp-Source: APXvYqx3v7mWsEzAXUvxVt62oRQGZc8cbd6WMYs+ZDKa+d3C2QPfBf+QQDq+dFmxN3qGywPbrAgtPA==
X-Received: by 2002:a17:90a:948a:: with SMTP id s10mr6318285pjo.140.1575996136714;
        Tue, 10 Dec 2019 08:42:16 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:15 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/12] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Tue, 10 Dec 2019 08:41:46 -0800
Message-Id: <20191210164153.10463-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a platform device and then deriving it. This is
done as a first step to simplify resource deallocation code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9886daf8ac97..f024ac68e2ed 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -157,9 +157,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
@@ -169,7 +169,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   sensor,
 							   &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
@@ -303,7 +303,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.21.0

