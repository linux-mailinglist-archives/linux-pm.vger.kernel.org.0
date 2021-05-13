Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB837FA32
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhEMPDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhEMPDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 11:03:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F7DC0613ED
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 08:02:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n25so31345552edr.5
        for <linux-pm@vger.kernel.org>; Thu, 13 May 2021 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCUUgkUDoigdypu4L5Fgp97vMcmPfYAXz+o8swnREuo=;
        b=KqREekiXMct59LPrsk4vsoTkoyjUWPhR5tEtKf3KuCFsAHyUfZOc29R5/rd/cFltO/
         r0PBjtuJ6Oa7Ve5ZDNwQ/PAEV3Kko08T1Ouz/XckbEnyIbZfZhM6pek1qjFKQhXSSJyL
         XUSNRPCUYRRVgg2KikHN40HSS8kTGUUt1imiNqLKZyCHH3IA8fKuSmmEWx/tHNSDWYz1
         OW1jAMEfKlwt3mq2BXUIAGmHaHhg2BJvv/w1AKDy+BsEyPNSCSEdXbRSqHyRipDO0E+r
         CVxbej7J/K9PN9ApLmxvnrucWHqMK2aiKQNKBXJqVw4wcgwq13MGhGthGqQXSukrgBp4
         2x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCUUgkUDoigdypu4L5Fgp97vMcmPfYAXz+o8swnREuo=;
        b=kFkS+C101lHmkLHVpD6HAqvCnuYDb/qoU6qNIP8ZH/I7pfyfnPve42odeNyynfxDjd
         k7HmIMWINP3oXxIWvvWv7nHkNjGb3XlV21I8ZRp0J0H38O74x4tuJKd7ukmZxemw8QhW
         8pS8HZ7kaY1mvkkOPtvy+OecHYVl1GBoAbZKwlKax2frHlUjERys6jzTdG5YZumB+brD
         yx8RHW/BVsxa8OqY3BD6qHSNv1xrtbyH4C+nydILG7CZRNdRnCD/rVc77Ye96rk3ArVx
         alPJ19OQ/wBijPq9fdafHs0w04N2LrCH+GP1soukKTuoPwWY9DstvbbItTeU2FiFgbF2
         fKgQ==
X-Gm-Message-State: AOAM531m3N6L/UQL5JWz2yyhv8ENOSuxs54PDJq1S++XOYx4CMpu9+e4
        TkGl1WmloEJH6XHnWh4BhJeEt0+04nsF9A3o
X-Google-Smtp-Source: ABdhPJwPFoR0Ucye6Pat2/zDqu/V7/gfCjqwoXuQRQLFaUTyeOzRo/CiBrLTvZTgu0xrXjGMdMEOag==
X-Received: by 2002:aa7:cf07:: with SMTP id a7mr50814123edy.261.1620918153993;
        Thu, 13 May 2021 08:02:33 -0700 (PDT)
Received: from PackardBell (192038133011.mbb.telenor.dk. [192.38.133.11])
        by smtp.googlemail.com with ESMTPSA id u8sm2411125edo.71.2021.05.13.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:02:33 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 35f5b0b5;
        Thu, 13 May 2021 15:02:17 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [PATCH 2/2] cpuidle: qcom: Add SPM register data for APQ8026 and MSM8226
Date:   Thu, 13 May 2021 17:01:50 +0200
Message-Id: <20210513150150.51464-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513150150.51464-1-bartosz.dudziak@snejp.pl>
References: <20210513150150.51464-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add APQ8026 and MSM8226 SoCs register data to SPM AVS Wrapper 2 (SAW2)
power controller driver.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index adf91a6e4d..9711a98d68 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -87,6 +87,18 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
 	.start_index[PM_SLEEP_MODE_SPC] = 3,
 };
 
+/* SPM register data for 8026, 8226 */
+static const struct spm_reg_data spm_reg_8x26_cpu  = {
+	.reg_offset = spm_reg_offset_v2_1,
+	.spm_cfg = 0x0,
+	.spm_dly = 0x3C102800,
+	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x10, 0x80, 0x30, 0x90,
+		0x5B, 0x60, 0x03, 0x60, 0x3B, 0x76, 0x76, 0x0B, 0x94, 0x5B,
+		0x80, 0x10, 0x26, 0x30, 0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 5,
+};
+
 static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x20,
@@ -259,6 +271,10 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 }
 
 static const struct of_device_id spm_match_table[] = {
+	{ .compatible = "qcom,apq8026-saw2-v2.1-cpu",
+	  .data = &spm_reg_8x26_cpu },
+	{ .compatible = "qcom,msm8226-saw2-v2.1-cpu",
+	  .data = &spm_reg_8x26_cpu },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
-- 
2.25.1

