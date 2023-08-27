Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B4789B1F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 05:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjH0D2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Aug 2023 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjH0D2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2023 23:28:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3DCD
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso3773952e87.0
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693106885; x=1693711685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48xtmF1RnTb+8jPIXovOcqZJ91keOMez755QP1H58RQ=;
        b=XWRUrkYylmdHJ+m4eo20x5wpsT8zClDJNCgFw/AyBsMmAzdCWa9qJ7gPcZU9/JLX0v
         wk1WCbbEpUTPKPUcU0tQYwJhLL6wt+0/NmYq26bbD8E5nZPV54Q0P8dLT/jHh4NRB/5P
         MkhZwNh/fihWnNKvX5rXIY4RvMbMmBdJmvwokHsiPttOCHLuY8s5yhFItiGYSyUfXGMx
         jTxAAL2zUYiuKFDeIdF2cdQNDu1kb+AvNGG33xrXDs1q2M8uje+M3QqXIfRzbFvSXJVp
         +wgR9zp5qtuA2wK5S+90Soh6+sp6yGTnPiLhOk/RoUtWwUGZQ6g3mquIO46rNwquUnRZ
         ViIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106885; x=1693711685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48xtmF1RnTb+8jPIXovOcqZJ91keOMez755QP1H58RQ=;
        b=LeQXVeyOCpng3zsYp6ExnHQ61ZycoaUK8Hc+ZyOscX3sM84RLJXjMlPQrJDRUJVC2D
         nBFgpYnvq/N3nqBXj4slnT1LK5nIrGt1JDPH7a5qlamK7a1ZIZyQKz51z/4b/+D6Y2dB
         KBnAIIDNjjRKu9zFVoQ+Iw3SAvx0y9ONqGMPFsACqxuD3AXhNVxSQGqtlN0kymWfjWUX
         NKoRiHz/oIHPAqFdsYySmG5i43ogwYJA81TtcJhLgBPPb337mXlQ1AvcqLRoZcInNLZ+
         Tyu1A8E4odU8TEAGZG27GFukDF+qA+sr9vJXhbZt6pugG3kl/2Wgq3VQcbFIoPYwi5PM
         siAg==
X-Gm-Message-State: AOJu0Yzca8QxEVhYwAPLwFu1I4Q5jUbmlUX0dFKGKXCGEqYSl0alkmYD
        4Lb8oKNoEQWMUeLCmajbj5lXtA==
X-Google-Smtp-Source: AGHT+IEP1TwgavtqGqI8GF+JZMvSgf4yFA5cu5rgQxO5fBAFgONeasxDuVAOx1984PXjxIsEg9lenw==
X-Received: by 2002:a05:6512:3ba2:b0:500:91f6:f129 with SMTP id g34-20020a0565123ba200b0050091f6f129mr6263855lfv.26.1693106884785;
        Sat, 26 Aug 2023 20:28:04 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm955709lfk.220.2023.08.26.20.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 20:28:04 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 0/6] cpufreq: qcom-nvmem: support apq8064 cpufreq scaling
Date:   Sun, 27 Aug 2023 06:27:57 +0300
Message-Id: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a split of APQ8064 cpufreq series, as requested by Viresh. This
series includes only opp and cpufreq parts, with the DT and soc parts
being split to a separate patchset.

Each core has independent power and frequency control. Additionally the
L2 cache is scaled to follow the CPU frequencies (failure to do so
results in strange semi-random crashes).

Core voltage is controlled through the SAW2 devices, one for each core.
The L2 has two regulators, vdd-mem and vdd-dig.

Dmitry Baryshkov (6):
  dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm Krait SoCs
  cpufreq: qcom-nvmem: create L2 cache device
  cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu
  cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
  cpufreq: qcom-nvmem: provide separate configuration data for apq8064
  cpufreq: qcom-nvmem: enable core voltage scaling for MSM8960

 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 12 ++-
 drivers/cpufreq/qcom-cpufreq-nvmem.c          | 80 +++++++++++++++++--
 2 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.39.2

