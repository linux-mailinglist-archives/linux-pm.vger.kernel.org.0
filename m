Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A18525B71
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 08:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377204AbiEMGOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 02:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350874AbiEMGON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 02:14:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAF26FA22
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 23:14:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so4969973wmb.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAJqhZC1C/Q9FHKuHNivRCwHP2aLTusrcVUMg5OeoKQ=;
        b=pZngk5SldFVYgLXXBUjf0GnPLvqAwiuSj5OAwlHA/Uxop92U+gROcpDiOQyfUuKnFw
         KbgJnN7J55/tJMwkSCFuRws/4gbAvRxvUu8liqkyvPsMl15NtCNkftbBtlhimy1bV0X+
         i0K0JzbRIzik9Xqp93oD7s1lz3p7emwy6ZYeysit21s3N+1+eRzORU6c2bSldwf8VrJJ
         8QuNlBFUejvRkavEs+Hsxh3WnY097JhjmuzSPH4vLx3EDvd95ESyOiY6LuqlJerFQXJN
         mJUz2934SH6RwTS3GSKaQENADo94uF9B7WtrIB3jPzdntgoPx/Mr1hJgsVykZk847+VP
         SI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAJqhZC1C/Q9FHKuHNivRCwHP2aLTusrcVUMg5OeoKQ=;
        b=m/PadnFZCiWRAwdKrwwj33re9f9WIvRk6EscKdrgjRHMZylow8YdnVW9PnMTX4vOJ2
         w5CndrLczi1KROWo5B1B4AGqPhWRaZXXC6o2kR8xg40N3YAEoI6GD2V3iUybDKdXj59b
         pkG1YYyrjQ9cq9CcLfhjWwXy/XV9Z3Ygti3L4EpTDpKff736XPl4NlJQ5lm6UOC/dwWo
         kX2Vu2osYMSRaVnnYODzP4Jewm7xhBK45+BpYrGBTM4jlN0bNzDwHapLK5CrfovTo7Xi
         RlhKRU56kxez9+LZHbt7n9WsHRsbo35H2FUlXGw3qmNvnzMZQtk5KIV73DQxbbleKo7T
         mpqA==
X-Gm-Message-State: AOAM531Rwfhv603N2MwGeNcwYzLdD21HpIL5k8NpfmHZ0AhY8jgHqCJZ
        HX1fhP7IOr6/53i9tZYke+3rvQ==
X-Google-Smtp-Source: ABdhPJxSoqFZu5xWQFZQMJH5obw3FV3uE+uXkptGPzvYlWeY5QI75GpqhfaoLqhsUfXF3WXIIQ9wjQ==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id n2-20020a7bcbc2000000b00388faec2036mr3031170wmi.190.1652422449908;
        Thu, 12 May 2022 23:14:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020adfbc84000000b0020c5253d8f3sm1477760wrh.63.2022.05.12.23.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:14:09 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/7] ufs: set power domain performance state when scaling gears
Date:   Fri, 13 May 2022 08:13:40 +0200
Message-Id: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Hi,

Changes since v2
================
1. PM: Split PM OPP patch into two - getting clocks and rates. (Viresh)
2. PM: Do not set clock rates from PM OPPs but rely on set_opp helper. (Viresh)
3. PM: Use clk bulk operations in PM OPP for getting/releasing the clocks. (Bjorn)
4. UFS: Rework clock scalling to be called in the same place as old method, so
   pre/post changes notification will work. (Mani)
5. UFS: Bail out if both freq-table-hz and operating-points are provided. (Mani)
6. Add review tags.

Changes since v1
================
1. Patch #1 qcom,gcc-sdm845: fix typo (Stephen).
2. Patch #2 ufs dt-bindings: not adding Rob's review because patch
   changed significantly.
3. PM: add new code for handling multiple clocks.
4. UFS: deprecate freq-table-hz property and use PM opps instead.

Dependencies
============
The UFS patch depends on PM OPP patches adding multiple clocks/rates support.

Best regards,
Krzysztof

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Krzysztof Kozlowski (7):
  dt-bindings: clock: qcom,gcc-sdm845: add parent power domain
  dt-bindings: opp: accept array of frequencies
  dt-bindings: ufs: common: add OPP table
  arm64: dts: qcom: sdm845: control RPMHPD performance states with UFS
  PM: opp: allow control of multiple clocks
  PM: opp: parse multiple frequencies in each OPP
  ufs: use PM OPP when scaling gears

 .../bindings/clock/qcom,gcc-sdm845.yaml       |   3 +
 .../devicetree/bindings/opp/opp-v2-base.yaml  |  10 +
 .../devicetree/bindings/ufs/ufs-common.yaml   |  34 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  43 +++-
 drivers/opp/core.c                            | 207 +++++++++++++-----
 drivers/opp/of.c                              |  47 ++++
 drivers/opp/opp.h                             |   9 +-
 drivers/opp/ti-opp-supply.c                   |   6 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c              |  73 ++++++
 drivers/scsi/ufs/ufshcd.c                     | 150 ++++++++++---
 drivers/scsi/ufs/ufshcd.h                     |   6 +
 include/linux/pm_opp.h                        |  32 ++-
 12 files changed, 518 insertions(+), 102 deletions(-)

-- 
2.32.0

