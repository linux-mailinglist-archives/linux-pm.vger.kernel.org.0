Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E357D46C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiGUTzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 15:55:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436172A27C
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 12:55:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d7-20020a17090a564700b001f209736b89so6319025pji.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwPz+i/LG1npAqFgCS0nUkNdl/zj2ZuwSHgiAEN72PQ=;
        b=tcMlhiQhCfKSehHUrvfZZfCRCvFdTrWHYm8OYgdiRemIZsBQKPYTrFHIl1PX5pndNh
         yRKQNJTriGy1XVdt/j6zBlhFuJ7ZxFYEkl6UmHTqEHwzCh1a7Xw7MmM08xPnlVY5yL3I
         NsQXucNgL1ukprRdFr//EP5NoqNk41sgZE2BTTLx67SAjZoA8I3Zdosl10j0FDyYdgqY
         xOVmj+aw6LBEslA0kxB4DPKRO8er9OsXahZtQ1YC6U2m5NXrqJyFK5+GOB6WxClZXFz5
         u3Vjk3Anf/pOITehD6J8KsCyesZTnunQKLhfMu+I5XnhVM4b9HEXKcIcJOzOHdqvwYfa
         lAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwPz+i/LG1npAqFgCS0nUkNdl/zj2ZuwSHgiAEN72PQ=;
        b=xR7ck9PFba++pst5C4xiovAr2VM53dbJ1sX93o8jXadmaYqEOQLHhIAtxKsXnLTIrj
         pujSKUCPgcTB6o2vpeLRDlsPh+kVTVJQ+1d1OmSr8lFpTulQLrx5oQ8uBIt00stBIHa8
         UEhYhAuNsnL5s9+hOzojw8qChkhHTOmCSn2mztA3YouC85f8eEUQL9F6jZGoU1RIccup
         bl4X5rk7og+T7HEmOoENyFmGTeT1C8lS1pwucj0HiF4/ytHFA/lJHYKwnd9iRBfDWsxR
         00g4gylBb+myp5cDC0Af+KIttVZHxlVmKuNudZmdt7qJy3udMcyi3LInkAbmvgn61QxZ
         9Ahg==
X-Gm-Message-State: AJIora+a340b0lTVH2aCeXp506zPW02FLxPfXu/+kYjJsCIf1TkQadiz
        tY01hV+m/vOPYczkqrKkcCoo7w==
X-Google-Smtp-Source: AGRyM1vU03uK1i/NXCDdKaWUdFYwqXL5N9UW+/hUGudfMZ7kJaKURIUIYTp4nvLkuvMigm6/a5GcCg==
X-Received: by 2002:a17:902:ec8b:b0:16c:1cc2:6794 with SMTP id x11-20020a170902ec8b00b0016c1cc26794mr44269518plg.17.1658433315613;
        Thu, 21 Jul 2022 12:55:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id o9-20020a62cd09000000b0052abfc4b4a4sm2232356pfg.12.2022.07.21.12.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:55:15 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org, pavel@ucw.cz
Subject: [PATCH] dt-bindings: leds: Describe optional 'reg' property used for Qualcomm LPG nodes
Date:   Fri, 22 Jul 2022 01:25:02 +0530
Message-Id: <20220721195502.1525214-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
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

As Bjorn noted in [1], it is useful to describe the optional
'reg' property for Qualcomm LPG nodes as it is used in
some Qualcomm dts files.

This fixes the following 'make dtbs_check' error reported for
pm8350c & sc8280xp pwm nodes:

arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
 pwm@e800: 'reg' does not match any of the regexes:
 '^led@[0-9a-f]$', 'pinctrl-[0-9]+'

[1]. https://lore.kernel.org/linux-arm-msm/Ytg3tIaL5h5b9ewH@builder.lan/

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: robh@kernel.org
Cc: pavel@ucw.cz
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index fe336fa16518..f394ab7a757b 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -27,6 +27,9 @@ properties:
       - qcom,pmi8994-lpg
       - qcom,pmi8998-lpg
 
+  reg:
+    maxItems: 1
+
   "#pwm-cells":
     const: 2
 
-- 
2.35.3

