Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739865FC13
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjAFHeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjAFHd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:29 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4278148
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bq39so975291lfb.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMnUsGMyktU5tXP+S6owcB1l0/Pz8pgW25wFgOOYi7g=;
        b=oFt1TXhdV7ws1DbbJ1hQdQSIfevOXBfPBQsBn2Ew8WWnf1qIQ/Sbm1gOqAX264x7Hu
         ARN7fN+q4Q3j8ULbusWyDjhXFoDNnkJ9nhUrCYFtXcRHddJMQU6J6hjqu+UI9S+98ii/
         JT2BWCnENtEoHAte+VOlGfjy5nQxlflTe46PI4yssE2ZgU5+oxkZaY+jLiXrXEOHI6Hs
         O3yym41VxhNqsCaetRfr9YCSalx28LDNZ5N8vjtWw0KiU95aMb1naF5gEGHhVJZJjME0
         pRl7FvQl6K2WlyCXWARbcaBMpwlm0Yr8M2/nC4Giq62Lc7s+5aSFQBdYJpJ56wMJvE7e
         Ca1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMnUsGMyktU5tXP+S6owcB1l0/Pz8pgW25wFgOOYi7g=;
        b=lQry3x3SeJKXw3M22O1ZHLdoShdBt4gOhqA4B+VAANIOp27J2c+608bVmiXXfBM9W9
         e/8Xrg1ErT/dtmu+rrdve/ulB42MkOzqvd/ZZ+mr/LyhnuDyEkyltX164dm93K/wjsfa
         fK/zXKRL/8sM5PrR8B8dhT7q193egp9NloESgXql+IeCE3TZXWZllhG/gecOPzj07SkQ
         /9Dl43gubacVzpG900u6vZ3R/ycykK6bfJLmyseSF94bF/2SNGJRPiafvdmaWUja3sZF
         qfHzeSHkCJv0Wui36u9krFuoUPv0Ecj6BpKO1FGL4goQ1iq78LDM4zZ69PexiK3L6Jod
         XsJg==
X-Gm-Message-State: AFqh2krU3VMqFSvM3CHdpatGTyn1QmT26j8iEdNfxLFlfpOHsuBzDkC9
        c2hICaGYyvnuGkMEx537GzkAqcdeasPw2+Cp
X-Google-Smtp-Source: AMrXdXtis3+HHoYAaDDUWxHkSQv3cyyON5IU/dJbJYuokVsvJKB1BULKAyMOn5u9MKgDjPEn4N90FA==
X-Received: by 2002:a05:6512:2022:b0:4cb:22ab:ce02 with SMTP id s2-20020a056512202200b004cb22abce02mr7078493lfs.3.1672990402083;
        Thu, 05 Jan 2023 23:33:22 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:21 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 8/9] dt-bindings: interconnect: qcom: Remove sc7180/sdx55 ipa compatibles
Date:   Fri,  6 Jan 2023 09:33:12 +0200
Message-Id: <20230106073313.1720029-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
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

These interconnects are modeled as clks, not interconnects, therefore
remove the compatibles from the binding as they're unused.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index a429a1ed1006..4e8d950c2832 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -58,7 +58,6 @@ properties:
       - qcom,sc8180x-config-noc
       - qcom,sc8180x-dc-noc
       - qcom,sc8180x-gem-noc
-      - qcom,sc8180x-ipa-virt
       - qcom,sc8180x-mc-virt
       - qcom,sc8180x-mmss-noc
       - qcom,sc8180x-qup-virt
@@ -96,7 +95,6 @@ properties:
       - qcom,sm8150-config-noc
       - qcom,sm8150-dc-noc
       - qcom,sm8150-gem-noc
-      - qcom,sm8150-ipa-virt
       - qcom,sm8150-mc-virt
       - qcom,sm8150-mmss-noc
       - qcom,sm8150-system-noc
@@ -106,7 +104,6 @@ properties:
       - qcom,sm8250-config-noc
       - qcom,sm8250-dc-noc
       - qcom,sm8250-gem-noc
-      - qcom,sm8250-ipa-virt
       - qcom,sm8250-mc-virt
       - qcom,sm8250-mmss-noc
       - qcom,sm8250-npu-noc
-- 
2.39.0

