Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496C3A50B1
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jun 2021 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFLU5N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Jun 2021 16:57:13 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44828 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhFLU5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jun 2021 16:57:13 -0400
Received: by mail-ed1-f54.google.com with SMTP id u24so41244953edy.11
        for <linux-pm@vger.kernel.org>; Sat, 12 Jun 2021 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xlYaRle/KBZdVqyKagtdFiOjMnJM8/KeL165T0BBTEg=;
        b=nLnuFh+nLohBsNgJOKq3QzSPVUvugPaDxgYnt2VZ+eBlPslWYWK36n85rk8/UvLMya
         XJVrq1UIKXhjfGNABp1yb0njZG7gJ33ssBy3MM2DsrXVOLYXa8GpUbHehjcS1/JpRijH
         zlZXnNnTJ4UFa5CeX8ZdNQeducqGBoKcPnwMqq0uXdk+Tl282W4IShor4s9OaN2oFyiO
         zuY1i0SA3X2uVCV3I/6O7XBULWIxHwf7arBiKJ+VttLuy92xxar/WE8nc0Zop5TnqYh1
         NraCOEFuF9EheonwWjTY5GVD1+bbK/IE7BxMs9FJvyguxqW23elarID5HtyTr3OBD8Bx
         V4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xlYaRle/KBZdVqyKagtdFiOjMnJM8/KeL165T0BBTEg=;
        b=t+CMq4u8bokVZXZMLL1ag+UWghYMoxRXdIMAWn01mvsKjwQQBHEUvmmS+PjfuJSX6d
         o/RFzCUNwMBrvruOL8fDX3clWx1CWEdJVgM+U9Vs39nJkl+TfvD769blsNYtTRyh5y7+
         tDtiFylppzCb+aXtnRN5LrK9PJsErtQtHogWzix2TlkhQtCo/YaP2Ep7kM95wEnE0R63
         4ymwZEHG/dDC+ZcYLgNJj6uxRIBe8iOZ3uR34KVgCFHk0oByxVZg8Ad9JTHYIz5XIKTF
         kicsWxQ6HyjH/ryfUwTyUX7J/RzDzkEhczrXgOVj9AwM3pFCdlAsJlSmHd/Hso5WEQeg
         7Cog==
X-Gm-Message-State: AOAM533dRf1UOG7Q2KU2QQBaoFJJk3jYcy7TmP0r2VyvxXJMVn/tg8u+
        +a/I3sbw2HNB3ttff2egBIyfCA==
X-Google-Smtp-Source: ABdhPJwHLDuHPg0VtenGkHarKw2PiL5QrFckPZGZN3u9kgjd+y98eRZb2Haq00sfLN5PzJEr8eEBXg==
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr3672905edd.254.1623531237180;
        Sat, 12 Jun 2021 13:53:57 -0700 (PDT)
Received: from PackardBell (192038129059.mbb.telenor.dk. [192.38.129.59])
        by smtp.googlemail.com with ESMTPSA id a2sm3574362ejp.1.2021.06.12.13.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 13:53:56 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id fb2a5c75;
        Sat, 12 Jun 2021 20:53:45 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [RESEND PATCH v2 2/2] cpuidle: qcom: Add SPM register data for MSM8226
Date:   Sat, 12 Jun 2021 22:53:35 +0200
Message-Id: <20210612205335.9730-3-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612205335.9730-1-bartosz.dudziak@snejp.pl>
References: <20210612205335.9730-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add MSM8226 register data to SPM AVS Wrapper 2 (SAW2) power controller
driver.

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index adf91a6e4d..c0e7971da2 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -87,6 +87,18 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
 	.start_index[PM_SLEEP_MODE_SPC] = 3,
 };
 
+/* SPM register data for 8226 */
+static const struct spm_reg_data spm_reg_8226_cpu  = {
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
@@ -259,6 +271,8 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 }
 
 static const struct of_device_id spm_match_table[] = {
+	{ .compatible = "qcom,msm8226-saw2-v2.1-cpu",
+	  .data = &spm_reg_8226_cpu },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
-- 
2.25.1

