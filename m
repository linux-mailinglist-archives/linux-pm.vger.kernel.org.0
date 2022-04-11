Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006294FC14C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbiDKPqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348151AbiDKPqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 11:46:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77409DDA
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 08:44:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so9287276ejr.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COpNw57lgu0himePeZKRGKWRjP8G0QfB49lG6bBArPo=;
        b=KijVpViNNcNMkejFTsh0iTzo1brscJx+JZ8eFgBlDRWQVtq4SZbHS5MNvUYGEU/MxN
         L0OGthoesxBuvzQyg0Cnl9iT5+5qP9g5jBm8ogfos9ZGsB79pSpWkKOCtnQKAm9bUhdh
         eP55Hmmlrqntt8SZjlMbut6phumsVchdb0lSgUxnPcTN7Qc1oa+2tqi2JLQ9v3AHQGV9
         evAjYVYW1IV/xOGj/nJG+UOCZClv19IRVB6bOVlirDbVucpLC6IPI0uWrHBK6XGrF7Hg
         qi+3QsbPeauFFmkw/Jjq0hz+qedquY0EjzKX3vwbECO2uvl/ZKNaZNn3KDsAc0CsX81O
         7ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COpNw57lgu0himePeZKRGKWRjP8G0QfB49lG6bBArPo=;
        b=DoGjZbNDSZ040Kr8AjE8O1uOdLDNqiqsbeV1D4SighIFbtbNxYPQcnSv8ZZnpSvICl
         HFSl6CpGm5Asi0n7QuS1xxxLms3sLoUbTyCcGtR3J8zYxDdLj/ZYyRmHmjg5b+3YDeY9
         bSd4lxML944YSH8d33Rcx/sBuEFg8ivEBfhr0Ye/LHz8GSw1pLr8jpJdhd5Mojtx6Do5
         yhaSt4mB38zb0fK/FeZvVonY7Rzn4j3dzQ1lNZ1leISb/wN/ojoUa4pR/JukLjxBHrvR
         T5emJFYYYlkypIhIi034vOYAf1abdoHCl7SWybXvmT9/fXFK/stzkgko3jr/rB7UN2pl
         8Ugg==
X-Gm-Message-State: AOAM532m1xNxHjjYQpvUKiRPvoZZ68zSB3nM0x8hLkW2nW2yJEyBzDu+
        8fE2VqhhbiBHH3rzgI+jpHK83Q==
X-Google-Smtp-Source: ABdhPJwMBgmWhN9Jcvz1+nkn4w/kwhwjVuDaMN+onbQcbN0Ysm3OfM9jnty6wEdQqJ/ZbGYwYFTzIA==
X-Received: by 2002:a17:907:9720:b0:6e8:3613:6224 with SMTP id jg32-20020a170907972000b006e836136224mr20084190ejc.421.1649691844019;
        Mon, 11 Apr 2022 08:44:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm12173177ejj.74.2022.04.11.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:44:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v2 0/6] ufs: set power domain performance state when scaling gears
Date:   Mon, 11 Apr 2022 17:43:41 +0200
Message-Id: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

This is a proof-of-concept/RFC for changing the performance state
of power rails when scaling gears.

Changes since v1
================
1. Patch #1 qcom,gcc-sdm845: fix typo (Stephen).
2. Patch #2 ufs dt-bindings: not adding Rob's review because patch
   changed significantly.
3. PM: add new code for handling multiple clocks.
4. UFS: deprecate freq-table-hz property and use PM opps instead.

Dependencies
============
The UFS patch depends on PM opp adding multiple clock support.

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  dt-bindings: clock: qcom,gcc-sdm845: add parent power domain
  dt-bindings: opp: accept array of frequencies
  dt-bindings: ufs: common: add OPP table
  PM: opp: allow control of multiple clocks
  ufs: use PM OPP when scaling gears
  arm64: dts: qcom: sdm845: control RPMHPD performance states with UFS

 .../bindings/clock/qcom,gcc-sdm845.yaml       |   3 +
 .../devicetree/bindings/opp/opp-v2-base.yaml  |   8 +
 .../devicetree/bindings/ufs/ufs-common.yaml   |  34 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  43 +++-
 drivers/opp/core.c                            | 205 ++++++++++++++----
 drivers/opp/of.c                              |  48 ++++
 drivers/opp/opp.h                             |   9 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c              |  69 ++++++
 drivers/scsi/ufs/ufshcd.c                     | 115 +++++++---
 drivers/scsi/ufs/ufshcd.h                     |   4 +
 include/linux/pm_opp.h                        |  23 ++
 11 files changed, 475 insertions(+), 86 deletions(-)

-- 
2.32.0

