Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6143E5600D2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiF2NDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiF2NDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 09:03:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325191164
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 06:03:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so22361444wra.5
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AwBtfOYMYv3MKFwS6XRJvYCb+XS7virm8BOPqSNmpo=;
        b=vXs1YtTUFgrXwv6BzDSmkZQIQSeDfXGrTalbB6cH5PWeIe7HkPMwx+ks9LDJC6GTy4
         YzHTzDVwBBc+kKdbj8FMBLFBr/2MNyCbRKkrKDggN1SKoFNOFP0nZEGjMDemeM9DuQel
         77MrWf6CIad1Hfa9gsNupl8VqH1+fO76WTLyTsKypsmOS5xYj7/pzvGQqWOAdTNbua35
         bgYggYiWPng0amd/AdTBDPJxcblljL1FR90gdWu9Kj0Pq9VdZ6uqpnY6lrGGMT/8xBqF
         PAkD8UQsNl+AlLqGSypOcKnmeCjrMbXUrXnH9bFUF7d+f7u9ZeH+9La8z2CyT0q81vIW
         DUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AwBtfOYMYv3MKFwS6XRJvYCb+XS7virm8BOPqSNmpo=;
        b=eriX8VGtUJG2alEwQ2OSzYM8u6SQoPeugEcwsb3LTTldjowwMC5n80os+Q30SmHxyE
         ysXML8WfcUS/lBE7xZ6KzIKckK+7lCOLUkIPiGXNdcww0jnIgqSNIkyrcDkgDSxOyFnz
         zxe7lLJ6tA0fK1gjCBMx8ZIROgBqRx9t7ho0EUICELO/MzrM0enpvQfWVlzOK5y5UMde
         CaG+n4TqFKoCkjEaMdy8mdFtnAUXeR4kzHAkqWZGLAu3wf3x7Bs8N4gVNjDCamwoC0c4
         QMi3FOYz9FdmEdc96yANZGKBIXCK5dspGN31RiKYYHrEbkZGYe3yZMNqcMExEyvnFcCW
         nXfw==
X-Gm-Message-State: AJIora9/ICK2m244VGpm1lmxNk8WHMAENmSzSVoGNIhGDS88MH/qqdtl
        LfK4zBa/ZLMLln3X4dsL9COtoA==
X-Google-Smtp-Source: AGRyM1vtGJPoJn0iOSIvDsybyER+K7qSelOxtXN41Z2C9n6cc4fqXeYEwm81M46uJWyE1Ul0QGBKFQ==
X-Received: by 2002:a5d:52c6:0:b0:21b:9f39:78de with SMTP id r6-20020a5d52c6000000b0021b9f3978demr3172858wrv.699.1656507787788;
        Wed, 29 Jun 2022 06:03:07 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b00213ba3384aesm17056979wrr.35.2022.06.29.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:03:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        krzk+dt@kernel.org, devicetree@vger.kernel.org
Subject: [RESEND PATCH 2/5] dt-bindings: opp: Add msm8939 to the compatible list
Date:   Wed, 29 Jun 2022 14:03:00 +0100
Message-Id: <20220629130303.3288306-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

msm8939 will uses this driver instead of the generic dt-cpufreq. Add to the
compatible list.

Cc: ilia.lin@kernel.org
Cc: robh+dt@kernel.org
Cc: krzk+dt@kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 5eb1dba13fe2b..7efae476c02e0 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -25,6 +25,7 @@ select:
           - qcom,apq8064
           - qcom,apq8096
           - qcom,ipq8064
+          - qcom,msm8939
           - qcom,msm8960
           - qcom,msm8974
           - qcom,msm8996
-- 
2.36.1

