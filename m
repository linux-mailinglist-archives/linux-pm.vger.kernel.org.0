Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894376A0D14
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjBWPhG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Feb 2023 10:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjBWPhE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2023 10:37:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0B580FB
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 07:37:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c12so11003633wrw.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUvAJiwYybcfxuPaO1uSIiPaY9bXRmDYQO0thKgpZNw=;
        b=xfyHhN31SYkq+4nWRk+57GWnYNH4MtjAzPqAK2RL19Xj2/8H7kgWWMFsjm5S5f2UGR
         cMqUqEeei1F6mPBRa5L9/cG7nAX7DAVkKp05ybcHLnkDPhns0sXtLoLlLf7Vs82uZ5W9
         VMO5SnzN6+NEgm3uyjvXFoQLUIXu6fY3UNEeHTZcVU6XlQ+ob77itTyqgTUy3+M2nyzA
         rIuZC2Upcn1TVEg8/dccALdOuVXl/OqJmpBio9FYVxpRl+rMTCOA14Qv6yVtmw2aCV94
         kUu8gME6ZvThAFA73hduYFxwXRwaJxKO4ceWQCRnS6DRJgcBaInJrdUuAz7kIBJuITnt
         LgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUvAJiwYybcfxuPaO1uSIiPaY9bXRmDYQO0thKgpZNw=;
        b=m2OcXXx5438hF38Avei1Fb07Zwv3L3GGmmbPxV3l/Z/rr1jDVBzUL+yoMsEsgCjqHh
         2lYbKPLEdThmz9hccuRxrYcNm9MqlgmUsmExpS2UsksqFhoknmVDOuYuga6LzT2r00vv
         S+BxVL5T3oK0KAtUxCqfy72ei9OQxKGNBXvvwKpwFUBMy+8imNbVVAIBN2zUKlXVBGVx
         o/7kalqQoQde4xUQS2GAx+lNKFCrxyje6ArVIyTnYjTigVEy4BnkT32p7M2zB+h/dq0K
         QIlygh2+9/YhLCAcUz/u00fctl6Z8FTkG8MA+xa3qEnMT1vn3qrXrq0BRJErdPkQtgus
         nXjA==
X-Gm-Message-State: AO0yUKV/m9k7qckMpIOQp07kIFnNXHifpR4CK+gqRNyG3yC8PE3H+BKf
        0e+8cQ+Hn0fY+18q+8OvkYaTyg==
X-Google-Smtp-Source: AK7set8dR4zzoxnEnLUoJZ/nmlb/gM+R8h1iDGx7inK3P4oMolEEoBuEdlXd4lOg7kcx2jMKdobr8w==
X-Received: by 2002:adf:ce0b:0:b0:2c6:e827:21c1 with SMTP id p11-20020adfce0b000000b002c6e82721c1mr9365669wrn.50.1677166619227;
        Thu, 23 Feb 2023 07:36:59 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b003e733a973d2sm11076978wmq.39.2023.02.23.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:36:58 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: vendor-prefixes: Add Square
Date:   Thu, 23 Feb 2023 15:36:51 +0000
Message-Id: <20230223153655.262783-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add vendor prefix for Square (https://squareup.com).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca49..90b746d237d26 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1251,6 +1251,8 @@ patternProperties:
     description: SpinalHDL
   "^sprd,.*":
     description: Spreadtrum Communications Inc.
+  "^square,.*":
+    description: Square
   "^ssi,.*":
     description: SSI Computer Corp
   "^sst,.*":
-- 
2.39.1

