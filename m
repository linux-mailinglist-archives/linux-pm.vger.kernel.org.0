Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D177D616
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbjHOWb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjHOWbg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 18:31:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB32116;
        Tue, 15 Aug 2023 15:31:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76731802203so404559885a.3;
        Tue, 15 Aug 2023 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692138692; x=1692743492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x985qIdmrH0usqAMcAD9wCIdI7RELSxxN3+uIdUUKkg=;
        b=sNCOVqhKtvhndRkUx8wluQobljW45YditB1nbO1rxhqFPVc0QwqgxtMtZsl8zoja1x
         mNf0yx3YPXYTP+PUCb58m9EPAGlMapfuf/mHK5TS0rEU74dReBGV70KkrcQO2m09f9Pa
         tBICrsUSOBlnYc+VRprKWUcx7BA+udT2bQefcy88Uq6QfokuJrybxPnhuyuN0pJfxJkG
         EGdNH1nikolG4+nTtBjBmjQqGsGHp6qgZZvrMSlyU6D8ha813iCgFneutHJumJiVamB7
         8f8PgWIRI9qh3B/r2SDgU6VzIsWh7swgsil/1eVKAd8j7F61Z4ry38mKQbtkO9UCWHqV
         pBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138692; x=1692743492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x985qIdmrH0usqAMcAD9wCIdI7RELSxxN3+uIdUUKkg=;
        b=Ly/aQWMFWpMQpOITGw54QSyQmseRCfpr1bqj2S2bSz2GQrQ9+cHZpVp2avfHLyKMRS
         V75045o3/S6UwEcwq55zYzq3M2hQPK00Sjk/A2D1D0pW6Us/1sOns3aWMCLITwmTdyir
         deO/0QBH2k6aIMySCJ1BhYIlJ1je+K+wRxbyoUHCtlfVo/k0xyJmY8OPjs0NCmY81IUn
         Sa3kkwWXEckUZpkcPEJqgX7Y/axJHd4jG/4cZ89R98qhLZOtP/7fy1JGcHxhZeQyU9uA
         97uxUIfVO96RzQD60gjUb93/GS2ELueELXnNXaBKJOzEpbaEEP6PHNLPgWl3eEVzVZ+v
         /5sA==
X-Gm-Message-State: AOJu0YxfeH7tYVAcr2GFMWsZIQfzBOQYt9xvWJOcLOe6Rs4dpEwWLnsa
        44lzgKmEPwXGdxlJzIGd6w0=
X-Google-Smtp-Source: AGHT+IGNncFF/fxCGsKiVn9SbbBNyJEaqiaoAU5f4SoK0YN4oCgHgbsZQKUCL66Bkx6AR6f8lmifDg==
X-Received: by 2002:a05:620a:290d:b0:76d:5126:65d8 with SMTP id m13-20020a05620a290d00b0076d512665d8mr287795qkp.6.1692138692628;
        Tue, 15 Aug 2023 15:31:32 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::bdee])
        by smtp.gmail.com with ESMTPSA id op29-20020a05620a535d00b0076c84240467sm4034442qkn.52.2023.08.15.15.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:31:31 -0700 (PDT)
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
Subject: [PATCH 0/3] SDM670 CPU frequency scaling: dtschema fixes
Date:   Tue, 15 Aug 2023 18:31:09 -0400
Message-ID: <20230815223108.306018-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds appropriate compatible strings to pass bindings checks.

Patch 1/3 is preserved from a previous series, as it was not applied to
linux-next yet and I wasn't notified that it was applied anywhere else:
https://lore.kernel.org/linux-arm-msm/20230724214209.208699-7-mailingradian@gmail.com/

Richard Acayan (3):
  dt-bindings: interconnect: add SDM670 OSM L3 compatible
  dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible
  arm64: dts: qcom: sdm670: add specific cpufreq compatible

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml  | 1 +
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi                            | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.41.0

