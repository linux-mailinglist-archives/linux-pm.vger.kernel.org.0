Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECC18306B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgCLMhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:37:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43986 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCLMhp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:37:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8so2616199plt.10
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBchukDJKQnY90F2ozsnSb5pJXMaYQQKSo79SHXxd9U=;
        b=E65ROswtkC/Tb78s+6ECzM36s9H66H66kO6F33KXuITiG2SR66cq8Vup8MPYOGvg5X
         EpRDBrvl6DI5StlOz4yerAbR9KgsFBM0IZlEn0sscbbuwlXdHxJJ1WVWa18hJhqtVYkX
         8QybeJJOf3q5vEEIJnldlz2cn3nsFQnmUGfgryFMySyDllTjSLdSJrnJCmqnT/LhxzDD
         4VuFCQ5ycdLJ56L8iwN3O87ZVJh5GCcqxKZ/uISLlyCWoT4WFhXhGlqJAL4XisnBnXOU
         2mu1Mut1lk8yZ4NgHeOy3rM/jnVjU6oAe85eSb9euc6n8lGz7uYTqAFwI+1TxsC3/QAi
         QH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBchukDJKQnY90F2ozsnSb5pJXMaYQQKSo79SHXxd9U=;
        b=F4yYXik/ynce/wgaPgyhr+GRk41EUS6sJCYw2fXvbrPmkLaptrQ1h0OkIdMqWCU3wi
         GRwTgORTpNqvLqj+pMFrRPGaBv5gO9t8XPFY7s2Bk/gWD0nk2FrW+Jah2WEsKKIu+etL
         9B7Uho98YU6AN5FSlpMsweQy5IdPIVrM7Ds13K0CEmBsBZLOZJLN1AR0zbu2++UMmUmv
         gJ4tKNe4pi5Y4NqAdLHQD9YYs8YzjikkOM7WZPIetHmo44iZcu0UWhkcOsH7aDGbZ0kX
         ZqzG6C+jS0s+a99QqlW9EL4nUheBRxIL73fXgzTG5OvMR/eizH0Qq9Le21RZ8d58/Kun
         VKMA==
X-Gm-Message-State: ANhLgQ2ZYDMLGismCNDOW7k4wGLbE7KM9DS8J0Ml6STHzYZn7VKk+4h6
        1ZTO6qdtN9AMOlsH5RRsRazW5A==
X-Google-Smtp-Source: ADFU+vsNmBdC+IpR5ascPNluLKrF4owJRmfZx+8wDGcZts7Z9w3HDvdGDm/ij2txqmuRd4SVcFlM8w==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr3933072pjb.194.1584016663366;
        Thu, 12 Mar 2020 05:37:43 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id 144sm58198495pfc.45.2020.03.12.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 7/8] drivers: thermal: tsens: kernel-doc fixup
Date:   Thu, 12 Mar 2020 18:07:04 +0530
Message-Id: <7ea9c9ead90a91205a3f1717c0c86db9a51780ce.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584015867.git.amit.kucheria@linaro.org>
References: <cover.1584015867.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/qcom/tsens.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ad7574fe0811d..f49e516b34588 100644
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

