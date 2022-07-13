Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495F572E78
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 08:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiGMGxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 02:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiGMGxM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 02:53:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB655E0243
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 23:53:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id o12so9442676pfp.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5ZVa04kRBVsEindUIYNf6ytMtDp5QyGf3BkvnYuSLo=;
        b=QP/u/T0Zn0sbzDr0g4rRZI3+mPlW6nvAlDfIjKtlXGlhSDvWYp+TpvU0yegvocg1u2
         w4UDLxOm5HzPvn4r51loynKH5CaH0ImYuEnP1qk6DZ/P0gUJpMs+4DUQ/bMlAqDqUoPp
         FwLEvZmWYyJ27b2GtMOq3jJSi9rgFkkvAq/8hZQFETDA2udNvM//uK6+B3L9cuLbX+Bl
         5ve7JEpd4OEO6GWGizYazj9RhRPrBfFwUDifkcPYCAMmyg88KwUVTPyOyrg5JniWXBE/
         g8Hof0zhE1hs/PwLcuHyw3VGeImX263og4NrhCuDqfElX2ihvq/tpM/f8p8a96Q/gkY9
         2DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5ZVa04kRBVsEindUIYNf6ytMtDp5QyGf3BkvnYuSLo=;
        b=rjMndCOWu3dYbEH+mHUXgiAT17Xj36HS3uaUY/T4LeigVre9HtrteY7S4z60fuNojO
         Z0dB+gFZsGqLeoTngcX9zYqeIUBpR7mV1igqJ1kmJZNQ1JbaFj9TI6AKHCmoT1uuTOTI
         wmrX9Sk59I9agIGLV1K9LQIRrN7NuTcWiHrx94TXzQVurMMee2WpDsKZoxIGh5nuaIVV
         C80KKbcnmWtog8ellflHr5EQ5lBNbJq/JOtayaFvmbxRoi5QBKPSIM0uVebHwFJi7SZZ
         BTualsXkQ3fDEVS6prBzYxYBL3XNqjitBLXyVnyAyWNOMkeZujEAWGDyX770PfyHFJpU
         Mlzw==
X-Gm-Message-State: AJIora80LomidPq/6zfva8l+gyZ5lPi/TejwQpm7ZgXqjtYMxMpUEFjZ
        jBAvPl91TZ7Ve1rsMTRAlve5Tw==
X-Google-Smtp-Source: AGRyM1uTZpJm2P8dATZcH3RdrFjl8ifHeSxvTOCvASA8RYlc1lZ7b74RCRbcVk0iS4454/cUMBAlzA==
X-Received: by 2002:a63:ee0f:0:b0:412:b2e7:55d6 with SMTP id e15-20020a63ee0f000000b00412b2e755d6mr1744417pgi.554.1657695190221;
        Tue, 12 Jul 2022 23:53:10 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id i3-20020a639d03000000b003fd1deccd4dsm7182171pgd.59.2022.07.12.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:53:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 0/4] cpufreq: qcom-hw: Move clocks to CPU node
Date:   Wed, 13 Jul 2022 12:22:55 +0530
Message-Id: <cover.1657695140.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

Hi,

A recent patch series, targeting enhancements in the OPP core, ended up breaking
cpufreq on some of the Qualcomm platforms [1]. Necessary adjustments are made in
the OPP core, a bit hacky though, to get it working for now but it would be
better to solve the problem at hand in a cleaner way. And this patchset is an
attempt towards the same.

cpufreq-hw is a hardware engine, which takes care of frequency
management for CPUs. The engine manages the clocks for CPU devices, but
it isn't the end consumer of the clocks, which are the CPUs in this
case.

For this reason, it looks incorrect to keep the clock related properties
in the cpufreq-hw node. They should really be present at the end user,
i.e. the CPUs.

The case was simple currently as all the devices, i.e. the CPUs, that
the engine manages share the same clock names. What if the clock names
are different for different CPUs or clusters ? How will keeping the
clock properties in the cpufreq-hw node work in that case ?

This design creates further problems for frameworks like OPP, which
expects all such details (clocks) to be present in the end device node
itself, instead of another related node.

This patchset moves the clock properties to the node that uses them instead,
i.e. the CPU nodes and makes necessary adjustments at other places.

After this is applied, I can drop the unnecessary change from the OPP core, but
I wanted to discuss if this is a step in the right direction or not first and so
the RFC.

--
Viresh

[1] https://lore.kernel.org/lkml/YsxSkswzsqgMOc0l@hovoldconsulting.com/

Viresh Kumar (4):
  dt-bindings: cpufreq-qcom-hw: Move clocks to CPU nodes
  arm64: dts: qcom: Move clocks to CPU nodes
  cpufreq: qcom-cpufreq-hw: Clocks are moved to CPU nodes
  cpufreq: qcom-cpufreq-hw: Register config_clks helper

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 31 ++++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 19 ++++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 18 ++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 19 ++++-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 18 ++++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 19 ++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 18 ++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 19 ++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 18 ++++-
 drivers/cpufreq/qcom-cpufreq-hw.c             | 75 ++++++++++++++-----
 10 files changed, 199 insertions(+), 55 deletions(-)

-- 
2.31.1.272.g89b43f80a514

