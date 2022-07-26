Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7558129F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiGZMCX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbiGZMCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 08:02:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A52BE0D
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 05:02:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w15so14269758lft.11
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OjeeEKqmdO0aXjrcmTB3oh5E1K12ioI2MK+Jlc0qnk=;
        b=fcIAEvn+30kYNR7+C0fXkirctZWsFt20+FXogYSpLRYligq2mhXMSPDUI8Nc+Z/NVr
         mKfsIotLqtTMrO194t4MwC1mPcUjNH+505xXRGh5Rml93A/x/9gVh6urDKZXTapx/sVj
         pvrM4zilN0EEN1RHP2ZnXn2kjKri+aZWBJFUvWWriyRWu+i6toqrlo3E/C098/PWXaFg
         VBBqnl7mDqxEUwGmtJss7o4hqpqPtKOzuojLAJFpUghDPgoeNV/zydmqOlkIZ4ZEtMp0
         D0eyia4Jn6LSuRMaGoTesazpGVnPjhDFT9F0dviyv7HM/mqWDB5h+GbRC/Qj8ZDC8++O
         ZnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OjeeEKqmdO0aXjrcmTB3oh5E1K12ioI2MK+Jlc0qnk=;
        b=aSLBRz5IX2s/Qx7wU2Gafx5pGYSkwTmK6za1sD5HL9BCIUKy8bZiDfrJtpaMlzu1SL
         aGjt6s+kkHRh1w+ceVzVJMW8yOH0SKfi7HXKycAt4K7VW+s8MLiB6OW1Q2D5zbDDR17p
         pxj2OxqwqrX7N+jNMqnitkY2LbcFN9XhzDWz/O0U5SkNlrgWoVGmuzXGihh1htb9N8Gd
         xVt17sNueOZslui6hGuWDo7T1Q7smbc7j84fGXjugqyjs3oLuPGLEQM+ohxSA5j4Gd4j
         dTf56CLoBV3nqQ93Memccc5jXXHmQ7eMCX2qL7riKsNxfuWOGJk6XHiQs2Ox8N1xWoxj
         uSqQ==
X-Gm-Message-State: AJIora+smv1kPhBbNczCN++nPUhjEFBkksmPmRZU0QPDBu9rWlpfsrx6
        ifg4AN34uNBa/PPriaydu/eS7A==
X-Google-Smtp-Source: AGRyM1utfUTMqTxzhGdOwXaRAPG2WLJDIEoQDdDUh/HbNdYULwInxjOvmmUs8K8dm6dTpVUGBMH8eA==
X-Received: by 2002:a05:6512:1085:b0:48a:9d35:4b8 with SMTP id j5-20020a056512108500b0048a9d3504b8mr1937104lfg.3.1658836938640;
        Tue, 26 Jul 2022 05:02:18 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e804f000000b0025ddf9a5b9csm3221865ljg.72.2022.07.26.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:02:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] power/reset/watchdog: dt-bindings: minor clean and qcom,pm8916-wdt to dtschema
Date:   Tue, 26 Jul 2022 14:02:13 +0200
Message-Id: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Dependency
==========
Patch #2 watchdog depends by context on patch #1. Optionally I could split
these into two separate patchsets, but then we would have conflict when merging
to linux-next/Linus. Let me know if that is preferred.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  dt-bindings: power: reset: qcom,pon: use absolute path to other schema
  dt-bindings: watchdog: qcom,pm8916-wdt: convert to dtschema

 .../bindings/power/reset/qcom,pon.yaml        |  8 ++-
 .../bindings/watchdog/qcom,pm8916-wdt.txt     | 28 ----------
 .../bindings/watchdog/qcom,pm8916-wdt.yaml    | 51 +++++++++++++++++++
 3 files changed, 57 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml

-- 
2.34.1

