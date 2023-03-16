Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DF6BD1E4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Mar 2023 15:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjCPONG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Mar 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCPONF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2023 10:13:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE5A5CC1A
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 07:13:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z42so1811507ljq.13
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BpBLhF7aJ8XDaNEo3pgNtZLZiLgPvI+GpJaOKLbCqg=;
        b=YltE/VzWOhFVV9rC/25tW+AT2zTFZ/y6DSwBqhXQyEBAE/Y6OMFKBZZ5Q33bBe6qcP
         PE8YvHVXCTku0Kmz187ciG7Czwtj1HWxZ0TMMc3fG35wKA9FseDL2r3gXvwALVcF7vB3
         /GiqH6S6u/pqAj6H4CWgxJDCxuYQ8kVqHQAo18hON1uvyICjFmOcZ/qIawArKHJHvBCg
         0MZfJ5JJGtJYRGU6S4CzuOKW0acEtxKvY2bR4iEo4GLkr28qiFFVpGbhorzfnU48nC5p
         MUb/cBZDeC9QJ3KYUI73YoBgTDXzEOGdPcyC0ZQJPuqqDTnICnPLUIJiCU90vUbsyqoi
         wNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BpBLhF7aJ8XDaNEo3pgNtZLZiLgPvI+GpJaOKLbCqg=;
        b=YJunSfPIawM7n75ftC/XRv+49n0BZhQm/ImbWm/2MnZ/fqvRt6fweUsqUpPhdDPzho
         yZiVuxrXk2kqjXrwPzdzY6f3kdM4sVzIxAgZTvRReDafEJOuc222G+w7Mz/yUGeNth4c
         2/jcpSADg7wo51rvmUnr95BB3eCfMTd4wFqJlb+kt5BieHfJnmrJEhkqg2mQWjmJZegt
         MC6at6UVAQzDYf25/g7H2ExzK3wQ1vhR+5C/2crurA2z8pv0dJUJvcqf2nA8YUjlaQeo
         5OCcflYi0SPbz+d961ED0ksz6rve1h/IpLRnkyLEO2MBr9eN5ImjeiV729KeIsnC5egr
         sppQ==
X-Gm-Message-State: AO0yUKUYkgJKsHA601z5lCpbGyLIL0ehEFZkWm7IkyFbsErccy/FsRGh
        E5oVJa6ybg2dBbpvvC6i1xd8uQ==
X-Google-Smtp-Source: AK7set+B56+wMoBVdhJEio81s8i+HfKpgPcCBQPkW7htmyvgIRoRIWpgCi017xTSXgxRXJMBy4LaUA==
X-Received: by 2002:a2e:9281:0:b0:294:669a:6adc with SMTP id d1-20020a2e9281000000b00294669a6adcmr2024061ljh.3.1678975981240;
        Thu, 16 Mar 2023 07:13:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:50 +0100
Subject: [PATCH v2 01/14] dt-bindings: thermal: qcom-tsens: Add compatible
 for SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-1-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=944;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7yZwhGENX7kryEzh3vUpHmBmqtqu0DXIXAX7kaP5Nx0=;
 b=oemx7n8vVMQxmhebPZ66HcpC4qxeCouJUTM+2mDAsIFu7O+gMMlMiJ8qxeOr6iriomV1T9AVlMgR
 IrHeimFhCem38YQhwOHlNgM5ACQ1S+oDyKrnon/rpDdafYPuVwvi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM6375 platform has two instances of the tsens v2.8.0 block,
add a compatible for these instances.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 926e9c51c93c..d73b72dafcbc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -56,6 +56,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
+              - qcom,sm6375-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens

-- 
2.39.2

