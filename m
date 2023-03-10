Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0D6B5320
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 22:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCJVp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 16:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjCJVoz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 16:44:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6F12115E
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:43:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cy23so25966865edb.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VtdBZBHjdNz7Y46m59SHrmzEAnff5o2OBs5iW9CHcGo=;
        b=xF4Q47yj1z4o8N1c5ExKygycmKfV4vmuKm+QjVP/qyjMK83nq9YYLNODjBSgjhQDnT
         8jl1aMJl9sVn2DNo3QAlFGrjA0JOdHD8a8YmarriE5TTSSXjX29YNSyGeXM9CyOOMJ8L
         jjnuUjg747DVx5xycOXofQb0yyr9CiK5X9tAKnVtlR/dgGTWYXXrHCzbEshp1Ri5UNFD
         YUK9jzV0DVFPBQ64gFCPtBv1ErLLbjlry8lj9VOeLdFjcLXBqwdSyXjo7oHf6khjujln
         uJv1oX152EL4Vo/07Sf6Qp1Eisvmtlu0fxrtuetUoiJprcXLqSQgvTwuiKWPCP8nW9AV
         gy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtdBZBHjdNz7Y46m59SHrmzEAnff5o2OBs5iW9CHcGo=;
        b=Tn6kBZsm0cJuEo+tYxYHOSKqX0Bjf9CThkkOxLnnUkqZCMSS5+SvWbhkQ3kbKNHrPy
         9wbk/fGsX+rGEZRnvgeuZubsi4fV+Tu0ecYLqSwAr4hhkzWR/kgbEJtzIr5J9kzjkeyj
         2NTJySioMfP0C6W4cQ4wgXgri+0Z4Y/0G9NzEeJWX1y/FzXZPuaKcTIyifY7jOY7mlrH
         beRS2RPhFxalQYWxXCO/f9GdTzZ2vmDcEdvFLMcE5iAtj2knb6d8SzXFewXxjGWo4Vr5
         nyki2C9xJ4RV6/9GToUR4i/ZIcoaymvVrC0/DKtq4uce0L9w4wqAq+26WN4UKI06xSAL
         k9qA==
X-Gm-Message-State: AO0yUKUxp9qt7k49q2XRmvwpmOcM6lIvbOms5G3lBqojYipWMzmf8mWe
        e1i3Ujm9r6F7V2VJb9ta4FqbWQ==
X-Google-Smtp-Source: AK7set9ZnrYfuf8zWlLeHJSEk4HSH1D3c437QABGG/RfrwJXmg4A4Gxrs81DwgbcSe7Z36QyBFQkyg==
X-Received: by 2002:a17:907:8686:b0:8f7:5038:9896 with SMTP id qa6-20020a170907868600b008f750389896mr34069311ejc.70.1678484617366;
        Fri, 10 Mar 2023 13:43:37 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] ASoC: qcom: lpass-sc7280: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:43:24 +0100
Message-Id: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver is specific to ARCH_QCOM which depends on OF thus the driver
is OF-only.  Its of_device_id table is built unconditionally, thus
of_match_ptr() for ID table does not make sense.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/lpass-sc7280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
index d43f480cbae3..956b974e322e 100644
--- a/sound/soc/qcom/lpass-sc7280.c
+++ b/sound/soc/qcom/lpass-sc7280.c
@@ -443,7 +443,7 @@ MODULE_DEVICE_TABLE(of, sc7280_lpass_cpu_device_id);
 static struct platform_driver sc7280_lpass_cpu_platform_driver = {
 	.driver = {
 		.name = "sc7280-lpass-cpu",
-		.of_match_table = of_match_ptr(sc7280_lpass_cpu_device_id),
+		.of_match_table = sc7280_lpass_cpu_device_id,
 		.pm = &sc7280_lpass_pm_ops,
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
-- 
2.34.1

