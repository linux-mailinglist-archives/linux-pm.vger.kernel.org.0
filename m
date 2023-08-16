Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A747B77EDA4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 01:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbjHPXGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbjHPXFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 19:05:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEA272E;
        Wed, 16 Aug 2023 16:05:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c656824c1so19614327b3.1;
        Wed, 16 Aug 2023 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692227118; x=1692831918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYx9iws2nClYMbUAf9YvAdzd7ShM6EtmZD702/MbwWg=;
        b=R77pa2H5q2Chu/1FyEBrcvHQ9uGjDDwm2rRE8idAuXxBzmD/1V/YwSqlloUKRf836X
         S7+UGTbmw9oQLoQYgFiqZiu1vPYTmxyIHVSEGnfEyF3I9euS87pD16HscoWcCIw2bni1
         nZbyIIsjt0JhysDjZGOZK2bpJ+oBq0h4t9uizDx9FZbEZOVYgpUIfZPZ4d+1jE3IW4vP
         7oaKEc6IVt/Zi5W7AK9OGFnrUXKsStAROeX3RYvpr1YJC7VZeXIrh9ABBglVAVhhsAvE
         tak+yqujdjYQO/4ZosZh/6FkfzhDFEoilZEUys8Gq4UQUZOv8lNDkWYB4FcCSaN0jJ6x
         PTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227118; x=1692831918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYx9iws2nClYMbUAf9YvAdzd7ShM6EtmZD702/MbwWg=;
        b=XnJwAw3bSR/WU0dj4egTXkrKIOxTMj7cXxlLoc69/9bwHoAlz/aujLM1SXYYjNZYnp
         1YMqcjUOno4KpCn4b5zb9ij21STNwdM0VWg2Fd+SNFrudmLSQIN4g+o3Pj3y7zYO6WXR
         LjWNpH6wZ5QxHB4ZTn8zte6tfaD3aPP6vLPibrtnf6N3Q7+9kO9Nq5SlO2ceLgXAOri5
         efwlk2pzLvX5R/Xlgi215DTb4HnLF0dwqv/Z/xziBba+ZqWXG33+Ps2vUHH+wiLD7Soy
         1P+INI2LjsA9GfLSW62vDMe1T2juLufwhFNeUatPgFRcmJ1i6cKTr+rRT+1h+h1etVQK
         8DVg==
X-Gm-Message-State: AOJu0YwPIvPy3lktNH2RoWOUCsPhaSwSSCGlPKZDaiaYpjhYlBKu11f4
        AK3M5q25QlVM73pJn+PnYPY=
X-Google-Smtp-Source: AGHT+IE9r73iETFP8CVz3qlC40gSCwC0lyM23W8Sji2G9+CnfkViSYSEaeEHpLfU9JjnSbSFGMDKUA==
X-Received: by 2002:a81:ab4e:0:b0:58c:6bcd:f562 with SMTP id d14-20020a81ab4e000000b0058c6bcdf562mr3901550ywk.20.1692227118566;
        Wed, 16 Aug 2023 16:05:18 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::5ee])
        by smtp.gmail.com with ESMTPSA id g63-20020a0dc442000000b0057a5302e2fesm4289463ywd.5.2023.08.16.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:05:17 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 0/3] SDM670 CPU frequency scaling: dtschema fixes
Date:   Wed, 16 Aug 2023 19:04:14 -0400
Message-ID: <20230816230412.76862-6-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v1 (20230815223108.306018-5-mailingradian@gmail.com):
 - add compatible to allOf area (2/3)
 - change subject line (Acked-by tag retained) (1/3)
 - add fixes tag (2/3)

This adds appropriate compatible strings to pass bindings checks.

Patch 1/3 is preserved from a previous series, as it was not applied to
linux-next yet and I wasn't notified that it was applied anywhere else:
https://lore.kernel.org/linux-arm-msm/20230724214209.208699-7-mailingradian@gmail.com/

Richard Acayan (3):
  dt-bindings: interconnect: OSM L3: add SDM670 compatible
  dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible
  arm64: dts: qcom: sdm670: add specific cpufreq compatible

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml  | 2 ++
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi                            | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.41.0

