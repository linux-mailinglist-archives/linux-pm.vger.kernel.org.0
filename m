Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0636342450
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSSP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhCSSPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F6C06174A;
        Fri, 19 Mar 2021 11:15:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e7so11806904edu.10;
        Fri, 19 Mar 2021 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EysxgKaLoRz6qMaxq/7Ea5iaVnv0Q8ua2gGP/W4HA5E=;
        b=kkglcHVSKR+uJag2cEWqVQmjKFJCobu7tfpJ7X/v6W5BbjNP1RzfhDpuAJfy64dLZM
         /EDoqa/nyp+dky5GW1cUlvOGKzsoY+Hrb2XauW/Gr4WhuUj+DVsvNAaXz6OFMvpFz0cP
         k/1Y9QBbFxs855ucWR95zBBeoK4MXJySGq91XomD9vIlsFqsZZId1JxCb5ms2N7nEPQ7
         WvqXhxzNntct6+9T2qZCdWaLIeJ79zr0aRhvp5yIMHhATwg7D8K0ApPUHofMnaUR6aCl
         J4bDtK9ZtOupYOCCGVBpiA2NLvWSv4iGbdiQMhsdijLiK6sUJqCgsXGQYZXS5IRW7AIc
         6epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EysxgKaLoRz6qMaxq/7Ea5iaVnv0Q8ua2gGP/W4HA5E=;
        b=cVawhleqYpgUo4v7SRI3sNLk7J1bPAupSmN7japVusIVCzqYK/km0lpiOwenxHMcDC
         gSctLFdSJo+SsBqy1juOrc1pg0rXnrbUnMNrF+6a76Hi3eGmGLIblgUQnhS0yjuLcL33
         6Zd18o5StgXyowO8qnwoD4jN3gcyZ5yYrGzXUXxyvjKXCAnlSIpPd9qlacGewZwbVC15
         vszfcugvvJpKG+f70yAH47FWt65QMKBm88LeCm1GNydpAFuQqePbis+ZKbxqIDG+59jV
         nCElpFM1YC8KEBEnG9h5gTUP4IRjieyViyxb7MozXvdpeuRxzflEg++jsva9fjWntBNt
         VuIA==
X-Gm-Message-State: AOAM532wLzJJ+2wLvJWU5D5jkvDLdBl6KRdarm+LQH4LWz01r/+VaTO1
        599tkrwsu3BibAPSLJrTOXk=
X-Google-Smtp-Source: ABdhPJzw4TI8MNZbNW6ej9d/oQmez33EjU3SKrFgL/jDvVKNDltkMM8+dV8voWbJCNN1UAd1KWZiPA==
X-Received: by 2002:a05:6402:440d:: with SMTP id y13mr11160008eda.316.1616177736563;
        Fri, 19 Mar 2021 11:15:36 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:36 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 8/9] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Fri, 19 Mar 2021 19:15:11 +0100
Message-Id: <20210319181512.7757-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6da567de1db7..df04e96c2044 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -963,6 +963,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.30.2

