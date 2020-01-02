Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DDB12E775
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgABOyw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 09:54:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32872 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgABOyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 09:54:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so22163312pfk.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjOF1oUSrrO0URh0mj4+ZNJlrmQRUgZsgYN9DFASUmw=;
        b=OUjZ+/Z3trmas3K38X08vZdhWSVxLFcdDC4Vc//HoLDX4rxQqVIf4Tb47d0OzLNuZm
         Bc6LZxRWPBdGnRsSgXqCsD4UAPQbo0QsBAYNby6WycX4c0ykyK3P1NfIIzP/wlyVopec
         4jP+WrTcitu+1Up81c4GyLcsDBl54OWLS1RY3bpXdp0xmhf+5vxMrCiSHGwu5W7j1gNk
         s4xnHuCqEz8RRhamhtFWya22394C75t2zX2d4vCVM65A7T3lkIh2yQS2Mt7KizoUVksf
         mcnbxEbY+Kwx+W+/xGKKfW0mZKdbXO8zUT25WBiJ1d2hMelHiPZZG2F4++H5uLy9lTlN
         EVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjOF1oUSrrO0URh0mj4+ZNJlrmQRUgZsgYN9DFASUmw=;
        b=iHis7CDMhFWw3xDdE3AGIah/qMi02jsSPkWOuZLZknmmJpEEsh5q7p1RWh8HQG3Tlu
         buu/XolsxTZ55gxvh/KX2IdA+eHr045p8pp1tygl54/+9Oy7KtcbkbqtW9H9mPHHs1s8
         Wlbx5UwW7UyY+jdzJgUh8TK4WrYW91+kKC7WhhSc1mqXrWqDZS1EVDAhm167CcXDVp/o
         zduCKJ2uTbE/hQPAK3dc0bXobkytlaLbPVP4ZdGecftHmrfEGzdQct42ockbqG2PekxA
         X6wgnEzQQBH5r+pCKBRAUjrEPh0dIuc6pcU9k3n9Teb9xhSWn+hWnBnv6PXpoY2GrvDe
         MY+Q==
X-Gm-Message-State: APjAAAWRicnygpual/0oVDS9PD4kchJGeshe9tbheUkku9oK9RikTwPT
        FIA2gEHXtwSZ8IuwI85TyKLDWA==
X-Google-Smtp-Source: APXvYqwlvaympWHfPGjB6g1AcZQTDfAAvQcu0Ua50SZ5Ouow2P0IMHFFkmzhdtLSzyH2/OMx+0G9jQ==
X-Received: by 2002:a63:d108:: with SMTP id k8mr88808304pgg.434.1577976891078;
        Thu, 02 Jan 2020 06:54:51 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id b42sm11581627pjc.27.2020.01.02.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:54:50 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/9] drivers: thermal: tsens: use simpler variables
Date:   Thu,  2 Jan 2020 20:24:28 +0530
Message-Id: <09ac47eea963e84bd3eb630897c2b77f3868b90b.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577976221.git.amit.kucheria@linaro.org>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We already dereference the sensor and save it into a variable. Use the
variable directly to make the code easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

