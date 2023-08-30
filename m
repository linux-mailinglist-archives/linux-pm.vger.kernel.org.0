Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3478DAA0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjH3Sgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbjH3J64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 05:58:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1BBCDB
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 02:58:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so6952556a12.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693389531; x=1693994331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGoqMS3E9hTzuAlLYY6w0VLAfh40RFv1IavK9K8DmYI=;
        b=CjGFqdJfOF8HLg2x3svVkHLT1/f3rtrUo4CK7HQSGxhoVy20LmBAEj1L9Po+E3yu4n
         bi3IZ0cH3MEjXmQSsjkkAfmwagl6MH8sSwrwpPldrxYmzZudD5xz7PT0FXGIrMamye3N
         /U7rBjo/uQQyilCVC8cZOsiRlxkIo7wsKI0XCdANbVdncNhSI9vct5hraMG5elhCWADM
         4hNZGG3oiY5K8mn+YqjdtqILKHv719r91HgKOdHYg0iDiFQfIfEez69/cj4c6O1AsK6g
         tjy/PWkoG7jT3A5Kedvj72XTGWEoYjBiGF5P2z4PfJdcA5Zq0dp5dZExBJYLcISnYJBx
         TT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389531; x=1693994331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGoqMS3E9hTzuAlLYY6w0VLAfh40RFv1IavK9K8DmYI=;
        b=KOKxMfeW4aczqnJvREvdkrnXG7qhAMSZJDWfMLX3YLbIytGAf96TIG73OXUhwoYUPw
         0Zqwwnp/m2MPeu9ozt1ShZYufVi49ohEX9yX0S7TmIph8Hcl/LDJVRm/miAbCGCsrKGT
         Wi4lNjAVKyEKUnbe+K5x1cGVYuGfeFyZnN04s954nt/R7QwCdey8AWe7LLqBHjJMZcDw
         D0ngas48JSV0ttGmoIY4K/iUF7haqS01uF7k54Hy/RtFHxUZ+r0eZLTBTV/p0u1eR/Zr
         QDzy6McVjMeJCDnTL/xy9bauKhsUt+aBdg3LGwCGbrEej82R6gYD7AipFIxa22VueHul
         6Zbw==
X-Gm-Message-State: AOJu0Yz9+qXmec1HD+zGPExkH8X1wyaR+bVsM+hCMaWyR9D5O0mpvwx1
        173DR2PRfFslKOtPEJ4y9aJ4Mw==
X-Google-Smtp-Source: AGHT+IGEi+xlIOcDOFaLVY6bYdh1pBTkM7v6Adr6xHtbqgnNFa13d99vlQbglBCKCVSoJg9wbvFyPg==
X-Received: by 2002:a17:906:74d4:b0:9a5:d657:47ee with SMTP id z20-20020a17090674d400b009a5d65747eemr1227676ejl.58.1693389530986;
        Wed, 30 Aug 2023 02:58:50 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (5073ED84.static.ziggozakelijk.nl. [80.115.237.132])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709064ecf00b009a2202bfce5sm6957130ejv.118.2023.08.30.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:58:50 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Wed, 30 Aug 2023 11:58:31 +0200
Subject: [PATCH 06/11] dt-bindings: pinctrl: qcom,sc7280: Allow
 gpio-reserved-ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-fp5-initial-v1-6-5a954519bbad@fairphone.com>
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
In-Reply-To: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow the gpio-reserved-ranges property on SC7280 TLMM.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 368d44ff5468..c8735ab97e40 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -41,6 +41,10 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 88
+
   gpio-line-names:
     maxItems: 175
 

-- 
2.42.0

