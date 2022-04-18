Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF6505C5C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbiDRQZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbiDRQZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 12:25:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D962ED5C
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:22:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e21so19101279wrc.8
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87fivufv+so6yKZtxUBhcGonieGouXYN8K2+TCVK0ss=;
        b=PeItOQ6+HTRiACn1qDrDWjBev3e8pjsy0JJwE69tnHzKfIlask4Y2mJf5Ok/6OHPvJ
         wKJKH//k8pTKkAGqWfM7dh2HXdpjX64qz1CoccHT1Q5uSph7HWJQ1CEyxEqXGeeno7e0
         HSfcvWIuRCbipz9k4bDuqRwJcEMjLT1JUGOTd9iBL093bLskSExhM9lg7XHebMU+Kgge
         wJ4RzTRn3IGhPoiRGFoztzRXQfsZz6L5nS6c8Je9ZecmRgQIai5i1t1WsH403y2/iSxW
         3PBD6GiNSOcPF86XyzhaNo1pvZcNwoK37mg0CtrCGxNaKKpTzGGBmKY2oEkezCFG6KJ4
         JZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87fivufv+so6yKZtxUBhcGonieGouXYN8K2+TCVK0ss=;
        b=7+rVBh73cuRLCn3ktRhQr8WGx6xY5Ps0cdvrg85yjVXRmWcK+PByE/jpHpZ4tQ1aKW
         F4/JfCmPL/awD1yB04+OAYluPDX+biEVaEwENYqg+0BA7AHzg1uwEeOoLxlV+e+aZn64
         3NfYRtHiXSLo/1fUgDqOYTthijjcNmMdFQZrotsZsEIeXkgs7R/lLl+u66WL2freJ8Jf
         CC02kT8D2V77E2J/RXUb8C4jGPWU3HR3//tX3JqY/Md/v7Fuca21MN6CW8QwDph+/eve
         5qq/x24UdcpXb3ad03r4TTA36M6LSg4vzTtasXqtAjoNqXbTz5ZnyJ350xAUzceW68H8
         U9Mw==
X-Gm-Message-State: AOAM533czOHEVLYHmnSS3RoCK3i6UR/Y6gV1OMpqHRM8/kdvr7YWGD6R
        hf4E4c9dEjO6O5xi4sK4kSYGOw==
X-Google-Smtp-Source: ABdhPJwQc9dV88o70RWZPUPICkBZwssgDGng+SnWVz63m3b3vZJ87go4O1jhRoU9FYgVh+pDubEWoA==
X-Received: by 2002:a5d:5487:0:b0:20a:8f45:8f34 with SMTP id h7-20020a5d5487000000b0020a8f458f34mr6361256wrv.699.1650298948651;
        Mon, 18 Apr 2022 09:22:28 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 205-20020a1c02d6000000b003928c42d02asm8460853wmc.23.2022.04.18.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:22:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ilia.lin@kernel.org,
        rafael@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 0/5] qcom-cpufreq-nvmem: Add msm8939 with some fixups
Date:   Mon, 18 Apr 2022 17:22:21 +0100
Message-Id: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up some missing compat strings for the qcom-cpufreq-nvmem yaml.
Add in msm8939 as a compatible qcom-cpufreq-nvmem.

Bryan O'Donoghue (5):
  dt-bindings: opp: Add missing compat devices
  dt-bindings: opp: Add msm8939 to the compatible list
  cpufreq: blocklist Qualcomm msm8939 in cpufreq-dt-platdev
  cpufreq: qcom-cpufreq-nvmem: Rename qcs404 data to cpr_genpd
  cpufreq: qcom-cpufreq-nvmem: Add msm8939 as cpr_genpd

 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 8 ++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c                     | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c                     | 9 +++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.35.1

