Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50859162DE4
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBRSMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 13:12:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38923 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBRSMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 13:12:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id 84so11045726pfy.6
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2g1a3kPECY0SwtktiXEAx2+VymT6TSEtxyFnQIHuwSE=;
        b=XYBtK0lDc+i9XpbQ3KXGLCZs9+u+sWHPT6T1LmGaOCH7G1NQ5X5lSoJgPuZZfK2O+L
         puVxOcavVuwMQ7t9EoegMH26Oac5NZWdOyuwj2HrWhbNiRuJTvRc4At3YOjl8my0totF
         ALzpbFhLtsHPUndNqscINNHtp0dTGHMw63/GI2GPTC5/5+MWCwx/MJwTyJaebzSQwdpP
         JVQhS4wb7Q3gS7yvcfBn8wE8ril+TnjldyzhsFDEJU/4esxNeEr70ODYfC3tYzy+LTHj
         /KmWUEflKZIwy2NZC+4zbmwYL5OUxqivWoRsv9gSeoccGCi8n7C76cAmNWyOIMWD6nrh
         tq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2g1a3kPECY0SwtktiXEAx2+VymT6TSEtxyFnQIHuwSE=;
        b=PBkbLpJmFqzr3QFiG+HA02JGag0wiXAUxvbxFsqEr/m2IuzRR+FKclMafPCkk+jWyL
         0lQ9QWw0xlSpohLaqV+XXjTVYwk0afovdDH+0mulHq9q+TyqX0U6SK8xdqkndL86YXdz
         rUOMUbAqsRwe8PBlOPEbulPgObAyWrZhparYHRpXE3fcZOL+fuMs70GWLnpsb/frofgg
         4YGxujmBP+/DsGaby3R6f51A3u0WJ1aGmMK/Dmw6Uhpk0zYOCP0cqMg//FO7iucEkoRB
         8BlZvCyPZiuB40opZ+Vzf4u4Wq/Pm0EXlyEE9KZQEyhShksw6EghmPNcE5JHMYPj4WJl
         weSQ==
X-Gm-Message-State: APjAAAWnym7wQlXuY//7Q3J+T+3clRCBGh6JgJ7qAODkXM5xl3eWJx0t
        DHdAc0ludzQdmS5sELLngXRNow==
X-Google-Smtp-Source: APXvYqx8P2zCz7bhavy9435/1qyFLHOrPScTrC7ZsvvXMwAlxLnGR9dlBAapR9f63mzLt/nZpsugtg==
X-Received: by 2002:a62:4e4e:: with SMTP id c75mr18956427pfb.227.1582049552272;
        Tue, 18 Feb 2020 10:12:32 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id 11sm5012088pfz.25.2020.02.18.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 3/8] drivers: thermal: tsens: use simpler variables
Date:   Tue, 18 Feb 2020 23:42:07 +0530
Message-Id: <6f95b3f0d39433c7e6b01094bdb200a7ac8e9f0d.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We already dereference the sensor and save it into a variable. Use the
variable directly to make the code easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c2df30a08b9e..1cbc5a6e5b4f 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -368,7 +368,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 			tsens_set_interrupt(priv, hw_id, UPPER, disable);
 			if (d.up_thresh > temp) {
 				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
-					priv->sensor[i].hw_id, __func__);
+					hw_id, __func__);
 				tsens_set_interrupt(priv, hw_id, UPPER, enable);
 			} else {
 				trigger = true;
@@ -379,7 +379,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 			tsens_set_interrupt(priv, hw_id, LOWER, disable);
 			if (d.low_thresh < temp) {
 				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
-					priv->sensor[i].hw_id, __func__);
+					hw_id, __func__);
 				tsens_set_interrupt(priv, hw_id, LOWER, enable);
 			} else {
 				trigger = true;
@@ -392,7 +392,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 		if (trigger) {
 			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
 				hw_id, __func__, temp);
-			thermal_zone_device_update(priv->sensor[i].tzd,
+			thermal_zone_device_update(s->tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 		} else {
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
@@ -435,7 +435,7 @@ int tsens_set_trips(void *_sensor, int low, int high)
 	spin_unlock_irqrestore(&priv->ul_lock, flags);
 
 	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
-		s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
+		hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
 
 	return 0;
 }
-- 
2.20.1

