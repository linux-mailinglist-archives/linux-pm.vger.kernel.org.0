Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1B16A6AD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgBXM7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:30 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52522 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbgBXM7a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:30 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so4181559pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTVPYc3+6GOjF48jnWoYXVEwFehhmUaBh5lCn4S9znI=;
        b=sLkjMu7553ORnP9DJ7aLrkU6Z2C2zycxPOyrfASFt8u7ZIXJpnTq1luOAcz/XgN1vu
         NW6RO/ii4PsPJZVVhsCynqWo0ND4KCoK5O+4AldoGbc6rVhFNzzF7AMOsx9MWEcOQN+y
         UOnoVI+beQqV4/VMfLmsAaV734EpIB7VeuBvVoz1Vl8FQ3XoIy1eHryCvhkCDlR8OERR
         gCe8IwNGeMbSnmGiqUNl2od713vEn9sF1UuzE5qCA7QTG6rQzROnQH4eA98cX/k72QRB
         CN9ykLCVoCc8aUmwitdOE32+4ndnefvCqI0huYoPpU5LlggOAXf1U0hQnfsUf1Xtqmkg
         ZlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTVPYc3+6GOjF48jnWoYXVEwFehhmUaBh5lCn4S9znI=;
        b=Pu3Ce8rQQedCV8nmoBqFW4LDjTVu7MbdFGzlLQarkFMjVO+cJp6T+ZRgM0i7KVmGST
         5GzvDPTnsMDe2aq7veXDg3K/Z6/pfy/QFsc1csyf7txcG7veIj4BXOrw8u+fCXShSrR9
         bxao4P1Gi7RqviIPPni4uboR/tMKa8yDBbf0BDhADdUwzZl3XHPiLt3IK19MixP5EIeQ
         FmcwAM2WkFAM7q6Ga1SlX1C7e9h6ao6J38+lbIpOSrgxLB8HSDxVoqLJ0lw3SAAIH42l
         U2liQxEzl+qGC7caj1yHhQRhZkoD0eXL6FBJzcha5cmsMErp/Gjdu9FXvK2dlBA/3s9/
         k9AQ==
X-Gm-Message-State: APjAAAWSt/sjgktOAUwdkFNvNxfb4Q/ypulomXzBBvxd98HfTdBQb3Ig
        waMTG8culFDHiG+5wDnPg3OuSw==
X-Google-Smtp-Source: APXvYqyjsbZ8/4F54oqwd2JpQTvRApSRXfpJYVasx+tPbxXRJNEF1vB0Z0DVrITyiTM2WH3rZeNpUg==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr20356080pjv.100.1582549169665;
        Mon, 24 Feb 2020 04:59:29 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id p4sm12780031pgh.14.2020.02.24.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:28 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 7/8] drivers: thermal: tsens: kernel-doc fixup
Date:   Mon, 24 Feb 2020 18:28:54 +0530
Message-Id: <ced31499b244acd4243f288cf8dda861f37d15f4.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document ul_lock, threshold and control structure members and make
the following kernel-doc invocation happy:

$ scripts/kernel-doc -v -none drivers/thermal/qcom/*

drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for qpnp_tm_get_temp_stage
drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tsens_irq_data
drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_to_mC
drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_to_hw
drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set_interrupt
drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_threshold_violated
drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_critical_irq_thread
drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq_thread
drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sensor
drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_features
drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_plat_data
drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_context

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ad7574fe0811..f49e516b3458 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -526,6 +526,8 @@ struct tsens_plat_data {
 
 /**
  * struct tsens_context - Registers to be saved/restored across a context loss
+ * @threshold: Threshold register value
+ * @control: Control register value
  */
 struct tsens_context {
 	int	threshold;
@@ -540,6 +542,7 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @ul_lock: lock while processing upper/lower threshold interrupts
  * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
-- 
2.20.1

