Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A341361208B
	for <lists+linux-pm@lfdr.de>; Sat, 29 Oct 2022 07:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ2F3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Oct 2022 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2F3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Oct 2022 01:29:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4812AAE
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 22:29:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso11643395pjz.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 22:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31jSUXRLISfaTkdTilHUmaigZg3beIP3lhW1ioCvMJc=;
        b=Hg4K3nXPtmn2jY5q1GN364CBW72ksirv4hh/PBWxCK/ZY01a5Rdeid9hFy2urInLy+
         IOr7UQr5eJ+9+hjQBEuVSpPnp5uxsTcrhpM6DTWT2yPgU3YTa4SQxIq/g07IALFqYwLn
         Y7aYU7rW5o7Bfl4FNetBmUSqTvp/O7j6nnBKUhsYlFAMWe3pxVzR7i0E08YcZQa2QKI5
         UWK2uMfUPso8/0LzPtPX1pgBy0cmsAHvcm/cxlzgTgN97ISM5Vslx3DUe1XNiZcAmUas
         gYZwsyJrZcOZF3TChHRaIkr6txK73/SxLOzhph7/XbrIvGXjLvTFnxJnC6XrV0hHiDs6
         gH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31jSUXRLISfaTkdTilHUmaigZg3beIP3lhW1ioCvMJc=;
        b=PKd95VK6pTCmnCGBrT0ZxZpEf5+GVqpJwpeIFc298tY4vO48+4mRhU5rUBJL7+IKJc
         MTvqXpGK4lAyQA5+6UMkPBXAJEQha+73Z1F6i5H6AWHgGfKiAu+WJlKzm+6D7s6IYQmD
         gw9mIoJgfJHI2EmVpXlyjwjwOjOlxhUUlGSIzPXo1GDCLLNkMjvH+p4HgI+WcNkPb8+8
         fTTGXNqn5CMfuOc7+t9fa4Z2iPI19/3fl5xNIviVJ0jTJ9GvZwbtixhyC46DSLJrXGVU
         c7f7cyD6K8iHa5ifiy1ND4Akr/6CZxu914b2yP5i66+Xs3dCYy7CR6oG+3HmJ3NRxaAO
         nP3A==
X-Gm-Message-State: ACrzQf3MX7BJ4esE6eqUu7lZ88NQpfs6iNZuqaNqvWi9dy8Ilkyht4Uf
        IQPr9/EnmbNaSVVFGFGjNiuu
X-Google-Smtp-Source: AMsMyM7F45fd0XuqdXtDRXdSZs/vPMmxMT4eFOwr0RODL26jdgNRy7nZhOGXmcyDuM1KRzNErBYcwQ==
X-Received: by 2002:a17:90a:e7ca:b0:20a:966e:8480 with SMTP id kb10-20020a17090ae7ca00b0020a966e8480mr19849402pjb.100.1667021381004;
        Fri, 28 Oct 2022 22:29:41 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001785fa792f4sm373728plg.243.2022.10.28.22.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:29:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     amitk@kernel.org, thara.gopinath@gmail.com
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] thermal/drivers/qcom: Demote error log of thermal zone register to debug
Date:   Sat, 29 Oct 2022 10:59:33 +0530
Message-Id: <20221029052933.32421-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

devm_thermal_of_zone_register() can fail with -ENODEV if thermal zone for
the channel is not represented in DT. This is perfectly fine since not all
sensors needs to be used for thermal zones but only a few in real world.

So demote the error log to debug to avoid spamming users.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 1b2c43eab27d..ba73336d4d41 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -678,7 +678,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 						    &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
-				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
+				dev_dbg(adc_tm->dev, "thermal sensor on channel %d is not used\n",
 					 adc_tm->channels[i].channel);
 				continue;
 			}
-- 
2.25.1

