Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81B539E18
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbiFAHTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350258AbiFAHT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:19:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E913D72
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:19:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f21so1814605ejh.11
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFHTTgpzWh1X2kU61LH+ozniVe7avF1oD6MyUb1nFlw=;
        b=JhClqqiGuZnkQDox/hUhOZMoOiJPzCcpVYaTRf4QcExfDNMhsi8myCeHESCpy+P4RS
         Y6cOsPuEG06xmppycyjaPVYMhy4ak4Tbwh8vddqZd0Cf7JNtj4bVtxwjyZ2uOXC2qKRc
         JAeRyS06bfesWcsWwbWMJUbzLldWxez+UxcGtqXD4Fdknd6JjTMGAA5hIQM1XAhdahYW
         +AM6YLJ5Hs92H5zZiCKcdSEoe6uOaHQ9QEJ1fvOYCieqePDtySNsaAXAygrM9oEPRTjI
         X6n0hYueQPCoQBYgn/urUM276E7cfonVUrwEy1ww41lI8jLfH8lAGh5FKdx6O+3B1zmr
         FO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFHTTgpzWh1X2kU61LH+ozniVe7avF1oD6MyUb1nFlw=;
        b=ImiVMgUrxiW9bEKSlqfjisbrMjA5mjgFUpaFkmJqqPW0WkHxESQNiEB5azflT4dNHF
         UK2d3JJjNAMImJE9rXsysDJ+ygdtE8pSk3w267dzrPcFnaGUPOZtR+ECdychd/iUEFMI
         LDgXaH24ZVvBPrJUXicg479qHJq1Db3iXKkqjJF5KYiwDRlr2wXN7bF+dFMFRdSL6But
         cspqK29M/N8Z5J5kb+/n4q/WUAvmn6Zeuu1MAjAXYxgVUui9W7M+2EQ1OnhwUj2LyUN+
         tpVCtmLWm+5UraCuKL7457FznybVg6GstmZFz19txsqt1Cb13oC/Pj1B4iaGP8yqETXx
         IliQ==
X-Gm-Message-State: AOAM530QSuJxZWcJ3/U+vIsE5wWLUeB1Hk4c8S39Vwp1Fi+AIVo0XK9x
        AUB2AGbmKNxjuu8gX0WYMGMMsg==
X-Google-Smtp-Source: ABdhPJyfshPk80g9xKAbLEuToIc9ClZTMcVqk9A86vdPPGtI2sruppsVdMnmbEn3HqQneIpreEv3cA==
X-Received: by 2002:a17:907:3f90:b0:6fe:cd08:dc21 with SMTP id hr16-20020a1709073f9000b006fecd08dc21mr44428596ejc.136.1654067964500;
        Wed, 01 Jun 2022 00:19:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090624db00b006f3ef214dcdsm358486ejb.51.2022.06.01.00.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:19:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: power: supply: bq24190: use regulator schema for child node
Date:   Wed,  1 Jun 2022 09:19:08 +0200
Message-Id: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'usb-otg-vbus' child node is a regulator so reference the regulator
schema for proper evaluation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 0d7cbbdf808b..402d9d2ed2b9 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -28,7 +28,7 @@ properties:
     maxItems: 1
 
   usb-otg-vbus:
-    type: object
+    $ref: /schemas/regulator/regulator.yaml#
     description: |
       Regulator that is used to control the VBUS voltage direction for
       either USB host mode or for charging on the OTG port
-- 
2.34.1

