Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343986E7551
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 10:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjDSIeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjDSIeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 04:34:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2796659B
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so1017979wmb.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893230; x=1684485230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AD5Mv81x1OfSGYx8Typ89SsCtnJrhePS3JykvPhl6k=;
        b=U1lPcV5heSygJ9ofWDeYojMVM95A+UuxL4ofk2x1ddaWC9Kj08sZlocP26Z78XqGzc
         fR3RK8uuFdQxxxb9muwhb/ZGMXblcIcZnOciZUhO5/P6g/EKCInzFLax4Wf/OQZc/h6d
         fKCjA8JpxGA0LwnDv2+vd5S17rpL1fCsNRAZc5yTZ2klDJUk6SUB0b8mlWSLk9teEMN2
         aoAsio/MzzgtWW+XasJJg/bOlCfIzRlbNWq6iUbodgAn2/1LArJnjC0c3C0nwCtWHB9g
         Q1XfK6L9EzupyDvj8UPWBtluCKNUWBlEzfpViqBaPvjCd2w61J1cyGx4fWEc5r1IhX/N
         P16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893230; x=1684485230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AD5Mv81x1OfSGYx8Typ89SsCtnJrhePS3JykvPhl6k=;
        b=XtfCMvJ1HCAp5kjgTO79klVdc0eLoSOTiPKJu3BNNGy9j4/EbNuajG0ZBh72Ad/7Vy
         nQUH8aDQDtaXNUgQX8D1N+IuHS1mjmEgaIprpixJgYvVxp8jBbkI61khG5X1C4gS707J
         fp9bMgu4+pfaJWvPM1AzQjZJIY39GNqI3eyspckuquNWtHUYbg39MYV1Z5XhXEwSodOt
         cUuwm5tQuhzAz8gRwa7mL9FtyR9yobzWKFbU9KrPG28fUzZn2CPATDfXRjB4oQufeoEr
         ylHcGn/7IDT9fhp7SIhCsn0bBkELJMEnVenCfCPzj6540kxNhrVPLitPwBGHON7hwRvH
         6mBQ==
X-Gm-Message-State: AAQBX9dosrINNMlNA1e+TBe9k75UjUtKGTBsiicvJ5urrgt/KomDHAVC
        27Q1lTlg8DS8JlSMa8qZYyWufjrX8c8dyIv3x7JBOQ==
X-Google-Smtp-Source: AKy350YLyeo8OtAXmyOcq9W+8fi63dp6387Bt1EC39fTL+s5ACJ9IyXM+qJSlsGGkBjLMoeN9poGOA==
X-Received: by 2002:a7b:c8d0:0:b0:3f1:6eaf:daa7 with SMTP id f16-20020a7bc8d0000000b003f16eafdaa7mr10106422wml.10.1681893230103;
        Wed, 19 Apr 2023 01:33:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Tim Zimmermann <tim@linux4.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v4 2/6] thermal/drivers/intel_pch_thermal: Use thermal driver device to write a trace
Date:   Wed, 19 Apr 2023 10:33:39 +0200
Message-Id: <20230419083343.505780-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pch_critical() callback accesses the thermal zone device structure
internals, it dereferences the thermal zone struct device and the 'type'.

Use the available accessors instead of accessing the structure directly.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dce50d239357..b3905e34c507 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -127,7 +127,8 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 
 static void pch_critical(struct thermal_zone_device *tzd)
 {
-	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
+	dev_dbg(thermal_zone_device(tzd), "%s: critical temperature reached\n",
+		thermal_zone_device_type(tzd));
 }
 
 static struct thermal_zone_device_ops tzd_ops = {
-- 
2.34.1

