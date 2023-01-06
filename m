Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1A6607A8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 21:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAFUKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 15:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjAFUKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 15:10:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6A84092
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 12:10:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bq39so3579667lfb.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 12:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ld16vqaKUSxN5A0I4GN+9kByy6in7O9iVGRZjqiJhYQ=;
        b=Qqx1jPnzQSBBYjqqiJTAbL8U4eLPzKAXcL00ol0YYn37n5JyrsSoGzelaSV/NrN5s2
         EgWyv4CVSsaIh2+EJKyrMtuaAZxFY7EwlupBDfpFHl4xBWZbg2JOxwFWl0wX5VN2w1DP
         kS1DePzn/PZUrAHRw1msypXudCf2cRxzL65WJCZHGXuQJldUjPca8b2XokvqrzoHc4SL
         z1pGLTZnO6OiYVyQnP5jq3KHN8GTgfdl+mf8pToByODVQQeIFAZ5+jrwberPvyBOHxyk
         dYOfH/i4O6eQSfLPtGTfhV8Xy25O7m79Buph7nrg6085a9sqx9n6THRpgJ8NvvIBzYZg
         63ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld16vqaKUSxN5A0I4GN+9kByy6in7O9iVGRZjqiJhYQ=;
        b=iJ7Iou3y+OFwUmzd3SW9Kr2rwJtuj1J3q81CrpaOyZEOIsOLErN8vf/+kBHCfiRRQv
         AtqJ7LRdFZSuv50WXNWcYq8Tmyhb4LAJen7Uul951GIhQ36m5eDgtjX2JKATPBFXPSs+
         AeF2/jR1GmF+5ggjFDlWeTktoRH/gj2JmVaRqIvwplFH/61FQHLIdDcfACH3PISaJ+iB
         lxPXw/ymR16qzEa9M5TCz/VcbNILncbqkefrQz5Q8qCAdkjl2xiMPZVhUFvuPiSmYGsw
         RqFRJXDZWH7t1/P7YEVS96bo9Xij0TL5iG/07nzZ/IfKm2Zwj4NlBNFwz9bBhmMa36Zj
         hf4w==
X-Gm-Message-State: AFqh2kov4onwYnkKR98AL2qsJFvGfNf6C46d7ZDnw/Td96tbp8AL/Jqi
        fxSuz+8GVNqyvIrnp+SIpvXsnw==
X-Google-Smtp-Source: AMrXdXtAerNPCONkOwYvsQomNiPLyeo4G2kUzYvjFXBPPrs00CzWrY0VwrWzchXhTHFfAoOgE8iPHA==
X-Received: by 2002:a05:6512:2102:b0:4ca:f9bd:3390 with SMTP id q2-20020a056512210200b004caf9bd3390mr12515321lfr.31.1673035829961;
        Fri, 06 Jan 2023 12:10:29 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm260875lfv.128.2023.01.06.12.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:29 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/11] clk/interconnect: qcom: finish migration of IP0 to clocks
Date:   Fri,  6 Jan 2023 22:10:17 +0200
Message-Id: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
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

Commits 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0
interconnects") and 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0
interconnects") removed IP0 interconnects (and ipa-virt devices support)
in favour of the RPMH clocks. Follow this example for other platforms
defining IP0 RPMH resource. While we are at it, remove several leftover
from the mentioned patches.

Changes since v1:
- Reorder patches to put clock patch after the interconnect patches
  (Alex)
- Add comments in place of removed defines (Alex)
- Drop ipa-virt nodes from device trees
- Add removed ipa-virt nodes to the blacklist in of_count_icc_providers
  to let icc_sync_state work even with non-updated device trees.

Dmitry Baryshkov (11):
  interconnect: qcom: sdx55: drop IP0 remnants
  interconnect: qcom: sc7180: drop IP0 remnants
  interconnect: qcom: sm8150: Drop IP0 interconnects
  interconnect: qcom: sm8250: Drop IP0 interconnects
  interconnect: qcom: sc8180x: Drop IP0 interconnects
  interconnect: qcom: sc8280xp: Drop IP0 interconnects
  dt-bindings: interconnect: qcom: Remove ipa-virt compatibles
  dt-bindings: interconnect: qcom: drop IPA_CORE related defines
  clk: qcom: rpmh: define IPA clocks where required
  arm64: dts: qcom: sm8150: drop the virtual ipa-virt device
  arm64: dts: qcom: sm8250: drop the virtual ipa-virt device

 .../bindings/interconnect/qcom,rpmh.yaml      |  3 --
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  7 ----
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  7 ----
 drivers/clk/qcom/clk-rpmh.c                   |  4 ++
 drivers/interconnect/core.c                   |  3 ++
 drivers/interconnect/qcom/sc7180.h            |  4 +-
 drivers/interconnect/qcom/sc8180x.c           | 38 -------------------
 drivers/interconnect/qcom/sc8180x.h           |  4 +-
 drivers/interconnect/qcom/sc8280xp.c          | 25 ------------
 drivers/interconnect/qcom/sc8280xp.h          |  4 +-
 drivers/interconnect/qcom/sdx55.h             |  4 +-
 drivers/interconnect/qcom/sm8150.c            | 21 ----------
 drivers/interconnect/qcom/sm8150.h            |  4 +-
 drivers/interconnect/qcom/sm8250.c            | 21 ----------
 drivers/interconnect/qcom/sm8250.h            |  4 +-
 .../dt-bindings/interconnect/qcom,sc7180.h    |  3 --
 .../dt-bindings/interconnect/qcom,sc8180x.h   |  3 --
 .../dt-bindings/interconnect/qcom,sc8280xp.h  |  4 +-
 include/dt-bindings/interconnect/qcom,sdx55.h |  2 -
 .../dt-bindings/interconnect/qcom,sm8150.h    |  3 --
 .../dt-bindings/interconnect/qcom,sm8250.h    |  3 --
 21 files changed, 21 insertions(+), 150 deletions(-)

-- 
2.39.0

