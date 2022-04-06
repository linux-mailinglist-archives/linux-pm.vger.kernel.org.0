Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA14F5623
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiDFFht (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578407AbiDFEQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 00:16:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039F2B4A45
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 17:26:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e16so1249502lfc.13
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWsEvD55MkSgPt/PW3YvzfqgUnAHkT214mKs5UGjYz4=;
        b=dMWHpVdQ005sI4XU1e5nFitPDm5Z3cmPOxruAZ16PlNwzh7HFSNA01JyNAi7Na29bG
         Vt7gxl5UI5K04ssnMNwmfX1cfGgzAty7Pz6K5WXl/fEpxZP8sI1A41p7AkdgnDqdZjST
         iCK6/O2hD3h7WLf3LoAqVlh/yut15gXVlevk6lUhEHwW0Rsqy9XDqjDLChT07w0dU5MV
         NE9iMxWjUa9qwXkkf8KPZR3rRh3LR6mKr/DQaECPK0qPWt9anwd/MqgMcd7iRdFh7mA9
         foflWczm7HkdMZ3BHSLrvNzNuYYxIp/JAV7UoHX5N6NKF0DJ6U3cLS81oea0GWo413WH
         Sf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWsEvD55MkSgPt/PW3YvzfqgUnAHkT214mKs5UGjYz4=;
        b=5JIxQHbuG+674hoA9C14CQ5TPeXuQXCkuxEP51ChPBBZ7fqGlVBVDX5puMEh4kkzy2
         wCD2o+694vBPybGDKB2OMotpByzyPHoMc9K9EHnyOAXopxVoM2Mj509R6YGmGVrOIO8i
         UMduGWX3hFiwi5xqbjbskt9yUxlMqNpz/C/HMMQMeERGuSOZGtjDlw/+K217bnTF/IUe
         GkrjHgs0BlJJ9xSV1hNrUa7FsC2kYh3XalAf8GmWcE1MsQwr+8YTQsm/WzA+SztD/MBL
         xeVMdIyDNQE4dLPTi8k6z1TCjy7v6QTNhxhbPs6AjGAjtVEhjHXL1BsdQn9OWEfTCvPI
         EqyA==
X-Gm-Message-State: AOAM532w2Kr2xD5jeag6CPKH9Kq9qC4nzTNbzpLK8bTTZW5OwCffYbR5
        2HNRcXNb/a5Mq8ItOUiV6lDHQkof2YiUJw==
X-Google-Smtp-Source: ABdhPJwdTKEaaj1bfpQk7YyIeEr9Rzt+ZEqImN9ce08usAO1IqH6ck7wJsWycvIRyd9sQKyb8ODTng==
X-Received: by 2002:a05:6512:b11:b0:44a:2ead:daf2 with SMTP id w17-20020a0565120b1100b0044a2eaddaf2mr4294784lfu.642.1649204810445;
        Tue, 05 Apr 2022 17:26:50 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c21-20020a056512239500b0044aa21dadeasm1660270lfv.60.2022.04.05.17.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:26:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 0/4] arm: qcom: qcom-apq8064: add separate device node for tsens
Date:   Wed,  6 Apr 2022 03:26:44 +0300
Message-Id: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Currently gcc-msm8960 driver manually creates tsens device. Instantiate
the device using DT node instead. This follow the IPQ8064 device tree
schema.

Compatibility with the previous devices trees is kept intact.

Changes since v1:

- populate child devices in gcc-msm8960
- add syscon to the gcc device tree node

Dmitry Baryshkov (4):
  dt-bindings: thermal: qcom-tsens.yaml: add msm8960 compat string
  thermal/drivers/tsens: add compat string for the qcom,msm8960
  clk: qcom: gcc-msm8960: create tsens device if there are no child
    nodes
  arm: dts: qcom-apq8064: create tsens device node

 .../bindings/thermal/qcom-tsens.yaml          |  4 ++-
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 25 +++++++++++++------
 drivers/clk/qcom/gcc-msm8960.c                |  6 ++++-
 drivers/thermal/qcom/tsens.c                  |  3 +++
 4 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.35.1

