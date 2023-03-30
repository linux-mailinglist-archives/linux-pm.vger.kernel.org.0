Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF266D09AF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjC3PdE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjC3Pcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 11:32:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF46E056
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 08:32:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s13so11167683wmr.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680190347; x=1682782347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJvFJnvniGp0mqyhPlqKU3t25JZ/J4PuAS7zcipJUK8=;
        b=JU2EDuI9Jtiy3UPWgwUdjP82KsZQU6Slx/z6CekiyYArfSjYTL6/HNQH3vUWsP0qmT
         gx20E9q3MRjVd2XXoQQf85szINPN8biuYdMX/5SaSXsGbENqwq/v6RF+gWLGVbTD5hNG
         5Ixn+J/H3H+uW20Tjy9fSLrMXsqj0BJ6Alhh3MZesj8bjd39CgGqPOIqsJw5y7Di6gtj
         2bOxd6toWkRAeMPgzkyKy4aHY3Tg4kH5kuWrO7eP9O/aONKd12cFlqNLa7brf1c2UFKm
         gNKjfS6Nn7m4/rlCC49f1Ye324ztfJ6NUryGwA/vny4JW0G9wGA2WIF5MfZZd2XSo6Ym
         rd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190347; x=1682782347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJvFJnvniGp0mqyhPlqKU3t25JZ/J4PuAS7zcipJUK8=;
        b=5Ck2b3T5gDYpZVGtmZcoyy9v6RAo72W5ZD7oEIdiHKk/n2CAs8VEf9szehsJa8Y+tv
         5RhlkUtP49JhpiTbVsuWGp3FMFthv7HulQ7j2yJIaXaujijC+SDtH/VRyRYjWpyVhTgs
         lUl+e7nYtDoDFwPW+uqwYrCho+wVpsqgxsNxDvV/+5d4jXkuHvNHrXja/6P7Auv+js6+
         yoL4p7O5QMGqvQnkquKoSotADPXpSBWEdzzQUREAcUU/Y1MCPj0y5LxIJ9EWo6b1WnDc
         rTGBrskvWhutUUpjpJO9rHJwuoH9exWwgNofd6y73ujZQiHUREy34fZ0oj07n5Hcffe/
         N8ow==
X-Gm-Message-State: AO0yUKVeeTAKJ/mpLWGEDkMfbYNoMIJEJ/iVUNOTJV7XDeCVHDujOU9G
        r1vuYkl31UCk1vWCopgTzKydRg==
X-Google-Smtp-Source: AK7set8gqEWaSRxexJRd55u6f3dBkognoejNZ3IZgXn/8mY+C3luS8+jvlx4gDBTTU4WXpu5fwkb3w==
X-Received: by 2002:a05:600c:2049:b0:3df:e6bb:768 with SMTP id p9-20020a05600c204900b003dfe6bb0768mr17641251wmg.24.1680190347040;
        Thu, 30 Mar 2023 08:32:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm33151794wrt.20.2023.03.30.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:32:26 -0700 (PDT)
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
Subject: [PATCH v8 1/5] dt-bindings: vendor-prefixes: Add Square
Date:   Thu, 30 Mar 2023 16:32:18 +0100
Message-Id: <20230330153222.2875121-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
References: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 5b7795766eab4..bd35c75b97dff 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1257,6 +1257,8 @@ patternProperties:
     description: SpinalHDL
   "^sprd,.*":
     description: Spreadtrum Communications Inc.
+  "^square,.*":
+    description: Square
   "^ssi,.*":
     description: SSI Computer Corp
   "^sst,.*":
-- 
2.39.2

