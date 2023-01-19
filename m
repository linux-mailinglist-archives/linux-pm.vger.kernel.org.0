Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408D67391D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjASNAx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Jan 2023 08:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjASNAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2023 08:00:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11C64D82
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 05:00:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2970772wmb.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5iAatbMm50roXpPwJZoEAAqSTHxKtI+AETl8/m024c0=;
        b=WbZqGFOoZiOMxpFxHhCKw3j3d/vKrQIrHyP3xgYdIXxNoxugJGVY/MHZD7wlAEdia7
         Yo9AfX8dGT6lHOrOkIGaMEueXoMM73SFQDputJXfgI+NRZwrRC/sOOEiQNm+QL4eylXy
         0/snQVqSM0FPb7G9fDt6C0AjLal74lN28sQajowhHBQzlphGMwPsc9unQR21ICaJ5p0L
         caPVu2NMG5auwm33HDezJuyMFwyp+MaQ98hkVwFyKVg5a3pKkLH6LsiDXC7RUJ4H8gP5
         vR7of402OZVJh203N66pW4QBGs+YXZFueacOnO9AKWlQL7gc4EkgLqSBsfiKlAVZs9+E
         Qadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iAatbMm50roXpPwJZoEAAqSTHxKtI+AETl8/m024c0=;
        b=nzWTMEJJUsXvJq6mlv8YGO7wiDR2albTFOI+W0sJFMDwpnUNESdzEfXX3hZ7czQJXZ
         lDG/hafc/rae8HNy+3ExmDSuugA8nTTIXha+ydrq6SzOaZ7Nh68Gf/gQfeD1t4Lb9ser
         UhdI22+69cugU6kMuUH8wc+Z0CX+UwwDkuJSGV0puxM11BWxFhQBi1oI9HeDxglOVeCf
         Xp37bPvlG8xolaA8/FiURrWE25Kx64DU9YZiKeffrTr8xpuWcXqzzMfpJ+09mHoaNQX2
         O/6mfxsgxxyjMU9NHKgdhqw7VXXETy97DeAjWo14vYgeFik5uj1wUnCKw6i68tz9Rlv4
         ZZAg==
X-Gm-Message-State: AFqh2kqjdYOQA7rjvZwIFSgFb08oDSnNqzTHrqo5phAFjiTxlkamN+1C
        q1VTHVU385FqMM28SsOphpaGRQ==
X-Google-Smtp-Source: AMrXdXuhYv3zCBTXGGIkujjhqRrT2fRieE6U681od4zQ+xjM9g3Til1CcJMygyxEC8URaHm9fOjo+g==
X-Received: by 2002:a7b:cbcb:0:b0:3db:2ad:e330 with SMTP id n11-20020a7bcbcb000000b003db02ade330mr10159304wmi.5.1674133232206;
        Thu, 19 Jan 2023 05:00:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w1-20020a1cf601000000b003daf681d05dsm4823808wmc.26.2023.01.19.05.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:00:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: clock: qcom,sm8450-camcc: constrain required-opps
Date:   Thu, 19 Jan 2023 14:00:27 +0100
Message-Id: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Be specific how many required-opps are allowed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This change is independent, although logically is connected with my
dtschema pull:
https://github.com/devicetree-org/dt-schema/pull/95
---
 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index a52a83fe2831..87ae74166807 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -32,6 +32,7 @@ properties:
       A phandle and PM domain specifier for the MMCX power domain.
 
   required-opps:
+    maxItems: 1
     description:
       A phandle to an OPP node describing required MMCX performance point.
 
-- 
2.34.1

