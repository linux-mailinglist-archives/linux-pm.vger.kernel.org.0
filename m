Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01B96E71E1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 05:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDSDxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 23:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSDxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 23:53:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B059CC
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 20:53:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so2937680b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681876403; x=1684468403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuG+mHEDcNGckfbWxzbdrhtR8dat41v7FuzOgs4SHfE=;
        b=VE7Z2vQJN/HjyQloIex/L74YZVgkJqJ/aELUoYj0B7J1ZM19P91fbEuc/SfUCASJ85
         N5DDK51lbe/33k/rGLxVgKM0va0ejK+lk/1q+RuFM9W7/z2U+q0klyZzO7Kd9CSooJYo
         3o1zG2He66V+XXplmNsrGfIgNw8ghBStkheLpP/KzcCMFl/I3ilM/fkLI0h7p1S2lxbV
         9v8hDNg91irodW013MqxpUMbH/e23lzAT6qxv0v8i4CdrttZXXzvk3Vk640TnvRcoB34
         Ykqk7k8eFy+ZvTJNyZjTogMNYfRkInJlMdulUgrxexlcQccNSd6Kk8jcyrLeJg/Eg3O6
         LkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681876403; x=1684468403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuG+mHEDcNGckfbWxzbdrhtR8dat41v7FuzOgs4SHfE=;
        b=XPWBOtBesoz/oEXAT/X0TOqTSoIR36em0ZqmrCE4NhFvBE7Q3UUEmgiL7tf/x2yreM
         B688dut1etAOHH84vGgVDMSh/8aH2fadtMMHNo/gUIl7/fGqeCDJ11E1IMzMbLRuM/Il
         Ibxv1FOzlBVUt3y0yg4WUpeEqMk+S6lZR5THp4OyGD5JWET8lRVzB7m2joQcKvPDK8W8
         /c2zEZwV4gDzhtxoAx++7qN7FCjFZH5kZ3qubF3SXfXW0QJ2UQQzlTjncMo5UHehH5ZH
         RTaHA8wu9ZHmZZC3V5LR5NZG1XPb2h1jlRRxFNssz3v3zFp178GofbQmf0oTkBgTg6cf
         GfEA==
X-Gm-Message-State: AAQBX9c2X5r4zO1a3jmvrWmK8cG/XHHnhkuzjaRJMUQxkPZhtS9IFBb4
        fUBQxD1ee5zufjKNlwdqXqbLhEUW4QT/QEu1gBU=
X-Google-Smtp-Source: AKy350Z6pElFDvDgg0SLJ/QdN8f/0aE0zZVAaKudd1odnOoc8ETBE8V+/vh4UEieYzhcRjtHQEfCrQ==
X-Received: by 2002:a05:6a00:1a86:b0:63b:2102:a1c9 with SMTP id e6-20020a056a001a8600b0063b2102a1c9mr2110031pfv.22.1681876402942;
        Tue, 18 Apr 2023 20:53:22 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b0063b7a0b9cc5sm6758613pfo.186.2023.04.18.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:53:21 -0700 (PDT)
Date:   Wed, 19 Apr 2023 09:23:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.4
Message-ID: <20230419035319.gtsmvcwh7ygua5fs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.4

for you to fetch changes up to f41e1442ac5bd687389d6104d7b74766db821eb3:

  cpufreq: tegra194: add OPP support and set bandwidth (2023-04-18 16:07:50 +0530)

----------------------------------------------------------------
Updates for 6.4

- Add opp and bandwidth support to tegra194 cpufreq driver (Sumit
  Gupta).

- Use of_property_present() for testing DT property presence (Rob
  Herring).

- Remove MODULE_LICENSE in non-modules (Nick Alcock).

- Add SM7225 to cpufreq-dt-platdev blocklist (Luca Weiss).

- Optimizations and fixes for qcom-cpufreq-hw driver (Krzysztof
  Kozlowski, Konrad Dybcio, and Bjorn Andersson).

- DT binding updates for qcom-cpufreq-hw driver (Konrad Dybcio and
  Bartosz Golaszewski).

- Updates and fixes for mediatek driver (Jia-Wei Chang and
  AngeloGioacchino Del Regno).

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623

Bartosz Golaszewski (1):
      dt-bindings: cpufreq: qcom-hw: add a compatible for sa8775p

Bjorn Andersson (1):
      cpufreq: qcom-cpufreq-hw: Revert adding cpufreq qos

Jia-Wei Chang (3):
      cpufreq: mediatek: fix passing zero to 'PTR_ERR'
      cpufreq: mediatek: fix KP caused by handler usage after regulator_put/clk_put
      cpufreq: mediatek: raise proc/sram max voltage for MT8516

Konrad Dybcio (4):
      cpufreq: qcom-hw: Simplify counting frequency domains
      dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1 frequency domain
      dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290

Krzysztof Kozlowski (1):
      cpufreq: qcom-cpufreq-hw: fix double IO unmap and resource release on exit

Luca Weiss (1):
      cpufreq: Add SM7225 to cpufreq-dt-platdev blocklist

Nick Alcock (2):
      kbuild, cpufreq: tegra124: remove MODULE_LICENSE in non-modules
      kbuild, cpufreq: remove MODULE_LICENSE in non-modules

Rob Herring (1):
      cpufreq: Use of_property_present() for testing DT property presence

Sumit Gupta (1):
      cpufreq: tegra194: add OPP support and set bandwidth

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq-dt-platdev.c                           |   3 ++-
 drivers/cpufreq/freq_table.c                                   |   1 -
 drivers/cpufreq/imx-cpufreq-dt.c                               |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c                                |   4 ++--
 drivers/cpufreq/mediatek-cpufreq.c                             |  98 +++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 drivers/cpufreq/qcom-cpufreq-hw.c                              |  54 ++++++++-----------------------------------------
 drivers/cpufreq/scmi-cpufreq.c                                 |   2 +-
 drivers/cpufreq/tegra124-cpufreq.c                             |   1 -
 drivers/cpufreq/tegra194-cpufreq.c                             | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/cpufreq/tegra20-cpufreq.c                              |   2 +-
 11 files changed, 331 insertions(+), 111 deletions(-)

-- 
viresh
