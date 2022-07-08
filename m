Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20D056B96F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiGHMMH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbiGHMMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 08:12:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1A9CE28
        for <linux-pm@vger.kernel.org>; Fri,  8 Jul 2022 05:12:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so614686wmf.2
        for <linux-pm@vger.kernel.org>; Fri, 08 Jul 2022 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I0vsy3nOfEBocgEXlD5YYOEw0Nm9b6yNglnomLM83zo=;
        b=OOsz3C5BvP0NXTwAX9N54ixPmgBTIJs9R6J9pNJVL/e4Pijs465wP4ayaG6F/qCHyw
         qAIzoyo1OuG+rRzTmEAB5t9b50Tf/JoYNOVWC0b85CeMXkVRupjEC8m/adKTREmx9JeX
         HLoN4zqIwt69vSc+CBquKIFjcGCWTiyOXxWExRCFRj9+dyjamLdFPtXn5b8aonzcDXw6
         zNoV5BcPeo2GnxgJrevso98knP85VON1Kc/7vlSgSHWphLErkUuEZqYmEQ2XZo2cnjdr
         KmJ/bAb/5TbYXKGrjmQSYayZwRBdZLCHmNKXHou/ZZErxznHGVKcEG4dLoXPs0fcMKit
         9VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0vsy3nOfEBocgEXlD5YYOEw0Nm9b6yNglnomLM83zo=;
        b=4zIG/GseKrelFAQo6I5A3KrQMeMabu5ygDE6vOb2w210mrN2zdvbQTCCSXh4wOneaE
         qIdAFFT4TrVE1BWmG+gHhBdzv3hTb4cwi1n5agyNS2Y4bmwKQneXF++1xBQIOb2ZxlcO
         Gk6qTAhYyU1Fk1CCSVEPnOhaI+2O1hXGMddWyWihAlX0uCDSTkm3jSnVPjQVAHEzmRhV
         udGDyEIULH3GqUI0wlXkRgXT0NaogYthqjdP0HXQEdhZPdpOxUqZdASCY5KH9BwQfz7F
         3uk+p0vhAHaXOaZ5Yh+98wHO+iTmFl3RLLjh+v3LqdmNiaa0vPB3RQiSHiqnasdQWwMI
         Srcg==
X-Gm-Message-State: AJIora8E6DOLZ7TP2AviMfg+eutA9sVOJePUKT7VdAvizCYE8K+V+PBo
        ACG0ff7MFrdYUzWoDJIr+dyfahTzF5dfgA==
X-Google-Smtp-Source: AGRyM1uMoiZK0a4NZMhSTPegyLZFhuMy4864g2L1I6VNwQ1TkVPaCd/8HQi9Y7NEUT336HZSpeQ8hA==
X-Received: by 2002:a05:600c:1e8e:b0:3a2:c1b4:922c with SMTP id be14-20020a05600c1e8e00b003a2c1b4922cmr3469421wmb.24.1657282322032;
        Fri, 08 Jul 2022 05:12:02 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c1d0300b003a03ae64f57sm2030549wms.8.2022.07.08.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 05:12:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, stephan@gerhold.net
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/3] dt-bindings: opp: Add msm8939 to the compatible list
Date:   Fri,  8 Jul 2022 13:11:56 +0100
Message-Id: <20220708121156.2165250-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708121156.2165250-1-bryan.odonoghue@linaro.org>
References: <20220708121156.2165250-1-bryan.odonoghue@linaro.org>
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

msm8939 will uses this driver instead of the generic dt-cpufreq. Add to the
compatible list.

Cc: ilia.lin@kernel.org
Cc: robh+dt@kernel.org
Cc: krzk+dt@kernel.org
Cc: devicetree@vger.kernel.org
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index b8b6cdc73209f..a11e1b867379a 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -25,6 +25,7 @@ select:
           - qcom,apq8064
           - qcom,apq8096
           - qcom,ipq8064
+          - qcom,msm8939
           - qcom,msm8960
           - qcom,msm8974
           - qcom,msm8996
-- 
2.36.1

