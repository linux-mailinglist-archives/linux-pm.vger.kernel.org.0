Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFF695238
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBMUuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 15:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMUuD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 15:50:03 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794CE1F5D9
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 12:50:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qb15so32918230ejc.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imnGfa1cPwcrAF1LbWbmEFRL7Cg9qGkZV/LdJAwktJE=;
        b=lY7kjkDDVPHYQJm2Cg3M+TbXaZTBvmZyCRyvU1aMuvl7cg6zcGWrBJwgATRMB3bhnq
         MbHNF7S0L2ZehFpkPYVZPc8F2x685CECLmPaq1sz1o41HFCyV2uxcitOcCPKUyu/gi9+
         K2IG9dGcuIC2535IDzys6DYswvi4z/YuoMj/bvqpESvkIH0j9Lfw6QRgikUbyvroiqQK
         vQ8uTsRu/j3hmez1CRGEdj5rk2ctQWDkdKMtJoZhav5daLJHouq50HDgC/JrL+QQgwVR
         4XztIoCD1Pl43/4tBeRg943lpPga6x+b13w+Gl2Za2SYle8cN9/VKkE/hvm/XsSsvEfx
         oW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imnGfa1cPwcrAF1LbWbmEFRL7Cg9qGkZV/LdJAwktJE=;
        b=xY7gACI6kDw/buOFI3oq5q0M3ov5jslitVsqbu3VpYPXXEG5bo4F7BfxcWD+p3wPDb
         RZQCtDrowqjJpL9AJWyG5FqHbWS5+Sm/++c+MPlrRpX+s18VilzNqiLbl6vykIlIO51C
         /Wd3ilZBlCNhTi/vKJX0iuFC2G+TOL68wKqBNeliGy56G4IMTrRJYyNXjjnbjvt20GE4
         /56Mw2vJDIG8hNlljR5DCoyKOMjUspnyliDoA6UZ594w7vG0Z2wHccPzE9LvOdyXtZKE
         7S8uC0NcQnrc+xrwQZac8KfgLnkRSI4yOxAAr9VVIdVJAH8IEMnokjwbQR0f6X9ZD73T
         Dshw==
X-Gm-Message-State: AO0yUKWj0pVYBS9zROwb4FZOAZHOFil7qwoWJix4wCGJ4hGQ1VYHr0Vu
        mDBttJjomwuLA9Uqtt9Kuws2AQ==
X-Google-Smtp-Source: AK7set8KBNhrN8JbTva/q58cO1gxouyl6/xAqySwNEO49npwGgw8l5Nye2w3PT7Zija18IS9KC0qOQ==
X-Received: by 2002:a17:906:53d4:b0:878:5d46:9ed2 with SMTP id p20-20020a17090653d400b008785d469ed2mr251326ejo.39.1676321401102;
        Mon, 13 Feb 2023 12:50:01 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906739500b008a94f69a1e7sm7303123ejl.163.2023.02.13.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:50:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: power: supply: pm8941-coincell: Don't require charging properties
Date:   Mon, 13 Feb 2023 21:49:49 +0100
Message-Id: <20230213204950.2100538-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
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

It's fine for these properties to be absent, as the driver doesn't fail
without them and functions with settings inherited from the reset/previous
stage bootloader state.

Fixes: 6c463222a21d ("dt-bindings: power: supply: pm8941-coincell: Convert to DT schema format")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml  | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
index b7b58aed3f3c..d62e3af55560 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
@@ -43,8 +43,6 @@ properties:
 required:
   - compatible
   - reg
-  - qcom,rset-ohms
-  - qcom,vset-millivolts
 
 additionalProperties: false
 
-- 
2.39.1

