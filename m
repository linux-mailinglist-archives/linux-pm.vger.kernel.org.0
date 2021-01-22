Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB7300746
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbhAVP11 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbhAVO6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:58:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6404C0617AA;
        Fri, 22 Jan 2021 06:56:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j18so4572331wmi.3;
        Fri, 22 Jan 2021 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRiSzjbPGSuciDDwZK/ZEDlRzVvbEgMvnG2EnKEi2b8=;
        b=L6Ygo3hK0BX1f3+JDGOMBtHh+qr8OWGp7hGmkGE3+w/e+knL6x+oTl2BV0sSqO+a5F
         TA1tWDw43iMxVR5C10gDvsGnkOnWRspKb4tvCES3y6A5racbtxoZPkeroJpCkDBAS8MT
         psGxTuIJ/jTzDVzkt4OBouoK9mfTJT2gta+kiaPxnH95J6Iw1qCqnM8xMFfY5vdWbrDg
         vgE4njiu6DpSoWyTKXiCOZpnADC0rJjT1865LBH2CJZ0yJ+iCtD95gXs8Ifvoydywzx0
         wGPRqQhQ3Dwq67kIvmI+/cpiu9IiQPWZ1tvyeQreqnM0kE5csocdQi/b825Z/dCmN7QA
         9DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRiSzjbPGSuciDDwZK/ZEDlRzVvbEgMvnG2EnKEi2b8=;
        b=L11xWiaDQvOJCwEydJje4nd/k5o6HxPYDvx4XyDHDjd49XU38IjC0WybmnB4Cqs0in
         6/3pezk0TyD4Sbm1BHRAqzn9wjobEjTw1wOwJux3E+Z27wQjcyYciZaITG84H7Ntm7j6
         tvTs7vAdWVOdZUsUjuaUiFXnTjM9PunBkqWx72AI3Fp0vS1S8dLUbsEpl+zPtkQHd7jw
         P/JWdaX2L3Qb70yffahKaJn6MfDr8YUPNLkwXrRCH1HZnxS1ogAg3iBOdz/6U4yGG8Ea
         8v+UOU3r4BqL9vARIUN+lcEKvCT22jLuoP2rJeWjQ09MvRfY0Wg+x/rv21s3gl9izo80
         pX0Q==
X-Gm-Message-State: AOAM530czRtbmZKe1UEzssUSAjF2S+uxjrn49tz+TjSdWeLecQWzRLul
        4CgEkzhbmh8g9cM3h2Gif24=
X-Google-Smtp-Source: ABdhPJxFShSH4Koq6q9pe58TzCj1QaVOsfdgQV2tiwpaANLabv9sCSYTZGjenu2JNEr93hee4eE/qg==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr4318428wmf.120.1611327379576;
        Fri, 22 Jan 2021 06:56:19 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:19 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/8] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Fri, 22 Jan 2021 15:55:56 +0100
Message-Id: <20210122145558.4982-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index dd9b41157894..586b90962605 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1010,6 +1010,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.29.2

