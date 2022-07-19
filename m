Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EA5792B3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 07:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiGSFtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 01:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiGSFtq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 01:49:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F730545
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 22:49:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q7so16126958lji.12
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lu2f/RUqKmEFqPL/kDzBfQuqWdQ8J2yKeAq9MQAfieU=;
        b=M+S6gAxBuGjDweoZMIsYt4GfCowiYbKNqewdpDkPVHCOXDlmPT4FqWA0kXgTfEsSxG
         m0MDdI53C+TLNeee3g0a/W0dDXGwUYu8Ckhwdk1ST07Ilp6E5x+8UXqtD0h5wu3u2r/b
         jhXDbBK9AbwxPHzDvD3bmRt34iw5CJfK7Af/jXzsZwpgBGeBae6Hqp2dkTuJ/lgkUOiU
         4H9JE8FDw8C0a1dQosPPiNKvh4yR9c0998IMF0B9Vo4VHHuEQiWPJreFdxymO9aEtfyQ
         qsqkj0eRc9Yq2rAjVs1reBUKwA1RM0W1uqWdSgDovHq3QhkSud2lMWefxVHpGqNnj/at
         A1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lu2f/RUqKmEFqPL/kDzBfQuqWdQ8J2yKeAq9MQAfieU=;
        b=3XWC0SLo/sLCVtEsmiDHMucNrsziIWfVJPfoaeC0RnjB/N6MV61x8mOhiumSyGn6/r
         tNqKDXpw7NqMk46FtZegUAemLCCrYDSRodKoWR4skgWpljqgZ6pZqGdhbrqiRUBv3fEb
         gsRx97r+jUbAhuOT0CXXVkI6c8pJg7Oqm1juouWwJi5qmmZqrs3ap59zZ+6Yxh1mE30+
         tHZdHMwnEsbKyNyDOScBcMBBFQEgw3Fycx4eDJg7ogS2qKhoyXkvTwRW2FQ0KXkPn8YB
         uHthtobQwXHlTmO+z/xXcFV3Cg9XSANxFDidAWJe1Zc5XYaVMC7gYpcsAqyrHiupWU7T
         shtA==
X-Gm-Message-State: AJIora//A7S3PIxnjp7LLEu2nyqpqHZZUXZ/s0EY4FceFriBjezt8+Ds
        oHmR/nvM7784Icjb5oqKZ78z9Q==
X-Google-Smtp-Source: AGRyM1si3O6JCpnUTqZjjBq5+e6I5A/DPpxxJDSNQS8ULgxtmDWyueUN0DxTmhjEWeqKDvUzRDhUAQ==
X-Received: by 2002:a2e:9095:0:b0:25d:643a:28dd with SMTP id l21-20020a2e9095000000b0025d643a28ddmr14510584ljg.322.1658209783306;
        Mon, 18 Jul 2022 22:49:43 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s10-20020a195e0a000000b0048137a6486bsm3005120lfb.228.2022.07.18.22.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:49:42 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] thermal/drivers/qcom/spmi-adc-tm5: register thermal zones as hwmon sensors
Date:   Tue, 19 Jul 2022 08:49:40 +0300
Message-Id: <20220719054940.755907-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
References: <20220719054940.755907-1-dmitry.baryshkov@linaro.org>
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

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index d9c9c975f931..073943cbcc2b 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -20,6 +20,8 @@
 #include <linux/thermal.h>
 #include <asm-generic/unaligned.h>
 
+#include "../thermal_hwmon.h"
+
 /*
  * Thermal monitoring block consists of 8 (ADC_TM5_NUM_CHANNELS) channels. Each
  * channel is programmed to use one of ADC channels for voltage comparison.
@@ -687,6 +689,9 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
+		if (devm_thermal_add_hwmon_sysfs(tzd))
+			dev_warn(adc_tm->dev,
+				 "Failed to add hwmon sysfs attributes\n");
 	}
 
 	return 0;
-- 
2.35.1

