Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B416DB468
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDGTt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDGTtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 15:49:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D57EFD
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 12:49:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso4874377wmo.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680896950; x=1683488950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx4ZG1ko//+xYTTb+kTxJu31+DpqiDt4rv+DgOwHnaE=;
        b=ALcHgkfJG2QsUjJ0ooFlkRhktGrwItT5a6DC45zL5AMivy7azhy46Ss71dac8kQF+K
         tMH+nBK9JVKWGkj0lMMJdJvmJ/T0YD1EN1taikO/mfRy/JC1jwlqmEGBkabPJG1D7aS4
         LZJ+7fOJ4GDsas+yPUu2OuC/CbZHnbkVGOU3A+L0E/6uYSZITckU5EGSb+3U1GNgXNRj
         50ysd+o5oaytiYEhPRGiytZdwvj9GzWsN9giHHM/J06Aw3DvZ8Ag9d5L5i0E/C5z1bQ7
         CddePRMTCpiSY2kWvSK3/GPfVwekhOUVpkCe2FAwN4ilJeVnxmUFmJMD6TP7sNd0Q1bu
         Q8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896950; x=1683488950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx4ZG1ko//+xYTTb+kTxJu31+DpqiDt4rv+DgOwHnaE=;
        b=pCMURZz6eDhRE+hw6pOdyCYSFAHM2yRCPdId4WFzuIW6cUqqnf90ztKHHO6BePHH0n
         8NKTlRW052MSHTKYuLSDou3ialR7M5wEs9qMbVdQol10tDDQ/IsUqqg5Ow063IiLWMOj
         mdUU4bTg6UAqta+NBIZ4VSOErF7fIyExRux944bXxDUneCBp6yNs4p7fjVrBfQTi16El
         SXu+L4EXVfbNXMvkhLh9AUtSVHQeL+B8SD8qozJNCRz/OzwbqVb40/edtuH+qzaphk2C
         UrxMkw+IjIMcP1YK6luREiaO4MLUDQpquuaOukallN5oPV/TIpgDXlm4tmFDsUkJKXLu
         jdwA==
X-Gm-Message-State: AAQBX9eKs/SW/INoUtGZAzsmx5/iRW/hz/VJr256Z4zTfgTvte4tvZaI
        p35HOrBQ27maCeYqucwA8LGb7w==
X-Google-Smtp-Source: AKy350aPZgAYNKbxv1SlLlzpEwpihDK7ztXY/5kL/fPTimrolsxEyEp0uHp1sLN6D09qvIN+o73yig==
X-Received: by 2002:a7b:cb8a:0:b0:3ed:a07b:c591 with SMTP id m10-20020a7bcb8a000000b003eda07bc591mr2003657wmi.1.1680896950203;
        Fri, 07 Apr 2023 12:49:10 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm9429551wmo.44.2023.04.07.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:49:09 -0700 (PDT)
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
Subject: [PATCH v9 1/5] dt-bindings: vendor-prefixes: Add Square
Date:   Fri,  7 Apr 2023 20:49:01 +0100
Message-Id: <20230407194905.611461-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
References: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
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
index 055704dce3d1f..2efd185053bbb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1263,6 +1263,8 @@ patternProperties:
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

