Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF27D6503
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJYI1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJYI1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 04:27:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8BB111
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 01:27:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso82878651fa.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222466; x=1698827266; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YdybnlHVQhlUwWTwyP6WjRjWuDz6ZtBHqXIcPdO3x+E=;
        b=KZLXZVZcmPNGipRhoCyLCk/z22MlXI1aAP7aNGQDLIhb5KgwWX8HL6mKYKBUO2i5cZ
         jCA+4qOT99RCQWWziWn+zDjnqF+cr3K9CN6Jq0VGVy9JK7D8IEay6aZt9/LF/etndGAr
         n5rlXcjh/7jPwjtTMr0+vfijFpHvffI9M4BMxnMtMOqk2xnMJmZCpwiQUk+lteS2stEp
         h+U5AcT3ddxav7bIXUkxQ1g2SRlHJNTpYKHgvP4ZBFowFzcEpzAV2yvauIrjvRvc9fKT
         w1WxsK3sQ/bhxXtBJvna5IcQ+aCauJMxTjkH8Tdjmjou4oTsO1iRVgi97XWPONMBJ0k4
         LsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222466; x=1698827266;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdybnlHVQhlUwWTwyP6WjRjWuDz6ZtBHqXIcPdO3x+E=;
        b=EZ4Y56/4IS6UUFqa+VP/HngWzgI5MwNn5aCRZ1nsbCqPa6OF0ZpOlkKtk1UgmQBNje
         TSE80VY2QDe/NDiGzMCMFxLSCDtj5KhG2zfFbHAd1hKXwDtlrpntExb98MeVF3BAEnOZ
         7WZ0DXwu46s+ytqDdepRdxBjC6b+pGAik1nh3SA0thQjl917E2pz2tQ1eFvcFxawrQAh
         toKmH8xeKfXqOgrZSS9o//HEgfKenbosvvcvtU/QkJZQGLV7MRO9WbWwoI1I5IvTWxP5
         LIvyWVGMEKaOmnv/lmVB5d0Ooay6TJMWx/DQfbOQK6q0tFI4xUMYz5aPtD7whWvoGgjF
         h85g==
X-Gm-Message-State: AOJu0Yyb1h+ovFqimoY3YUytmhwG0VobdcZibnWEbpZePdWjMpcQR75A
        bveSuxnkvW3qf8agCVudDUzrDA==
X-Google-Smtp-Source: AGHT+IGzeZr0NiqkRpew3s44Z7dxJlaM4+4Im32rKox7iZILWhhf3AdAL9aDjRepyHsWEYZHtFMHLA==
X-Received: by 2002:a2e:a68f:0:b0:2c5:56b:cbd1 with SMTP id q15-20020a2ea68f000000b002c5056bcbd1mr10329803lje.10.1698222466115;
        Wed, 25 Oct 2023 01:27:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b003fc16ee2864sm13919032wmb.48.2023.10.25.01.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:27:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 10:27:44 +0200
Subject: [PATCH v2] dt-bindings: cpufreq: qcom-hw: document SM8650 CPUFREQ
 Hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-cpufreq-v2-1-340e1c583f53@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH/ROGUC/43NSw6CMBSF4a2Qjr2mLY8SR+7DMKjtLdxEWmyBa
 Ah7txIX4PA/g/NtLGEkTOxSbCziSomCzyFPBTOD9j0C2dxMclkKLhqYw0QG0tg2NYdlSnNEPcK
 dvCXfJzDT4iI+QTuOXCollHQsn00RHb0O6NblHijNIb4PdxXf9UfI+l9iFSCgFBZN1bbKiur6I
 K9jOIfYs27f9w8uBuzq3QAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HRSTjiL7M/7kacXAGDPOiR1CJf7M6oYwiJbmviX+bRE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlONGAN617Wr9eYB8EdljFtYjooFxCsFdaH+FXNaw6
 YVTrfCGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjRgAAKCRB33NvayMhJ0THJD/
 9eodO/CC8G2ooerubjt/I1DlPTIv9TNIxIaNT7T29MaAVRwP0BjbvKpaUlrNNUXNb8CaG+s0ybH96Y
 exXRQ9CJv2mUVdwzYUq5hFtcK2rvbf6vxacqRY/Tx6FmBd3UWFKvEiKA9jtbFxUe1Ypp+sCozVOClt
 OmXLtx9+/xxKu2HGt/7eYSjHELmBq/8ynWMG3LcpSli0iqkTVBhNR09QEJcFFFUeCMuYE+Xut4WU1G
 yyxys9ubiHIBy7vPPqmocINGy73RViDGUuINtHotd9zsASpknycC9kXt9zCrEFIWLWBqrL0xIKLTie
 cbVWnM1ewaVzQyfJO7jUoADRg8AO1lWBcrbG8D5lIbcOF83IB21wGjTi1dSDvsncXo1VNlO8I9mvXD
 SbVAmGxNeTfq1taNOwVF5GayEiiuCaK0d7fDijQpSa636xkNrY8Lo/F9drGIDd3hXfZac/4ijbT0Se
 /KlP1V3Vpkt/QEa60/GMeY/vmsDpuND9aNewwPqqzUEbdYQy9ZyYQEej9ARcx1V1JyOAbxAuAIEd+6
 kR6eVhlOPAAYLNr1ZXUO/QHS5DGIkacDb5MVamQ5YOccrskWkyUHzNQLQp3vxn2haqx4HqnXhyJ82N
 bcvw+jSciWUSXsR8gfthXGScov1FpSyasVFFObfQii2hFPtSmox2HuQbD4kA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the CPUFREQ Hardware on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
Changes in v2:
- Fixed typo in subject
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 0177d1ef0bf9..56fc71d6a081 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -43,6 +43,7 @@ properties:
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss
               - qcom,sm8550-cpufreq-epss
+              - qcom,sm8650-cpufreq-epss
           - const: qcom,cpufreq-epss
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-cpufreq-af0e0277172f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

