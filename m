Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBE7693A1
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGaKyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjGaKxX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 06:53:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08CE76
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 03:52:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so6786432e87.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800747; x=1691405547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6y2HGow0UXdyse/6wVlFKmRzD523dhwnJrMfi/SezFc=;
        b=dicBxOFztkZvNgc13QHF7Eu2TRn50ntAR8oLYD74do1Oy43e5KGbV8muj5ay70dzWA
         QAEanZ9rbfrwFW4CWqCzKIJA/zg20tt5aDVbiUrJhktjaRG3XsDWMfKBQ+duSpIWgcNb
         FhBE7fWNc0huQMCHtt5RK4QkSmFwXsc5IVA8azVfGsLKS5cuTKfmQ21183VkMk8KJ0tc
         auABOwQCDNMKdryalEhOGrvOUwtVsvuY8b3veYP2/8TZfM/ltT8XJ88GbS3RnmZZ2Aa/
         akdw4f8jiZmjI/bfqQYDNegR6SQ1yJgf4SrVA4w73KW4SnOVpJJZbeP2vQIli3uTNSJ4
         +0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800747; x=1691405547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y2HGow0UXdyse/6wVlFKmRzD523dhwnJrMfi/SezFc=;
        b=B3slKdAYk9J/0KOyTBnjFCReX01AdjYeOsmjFdwGL4EfZJxYwJUWWCDSPkw0uylllW
         ZayNO7Y73WV/lZQyc6REvG9u2+MMRduDMRZgp2l56lRCBNdKzTC7LCXeHZSKnSu3q0e+
         35ziKiju/IU+it4XpjYCd/3UkkSBGt3zEQuNo+jhKAmtXUsaxhHRQ86U/97yrG4KbSlM
         4VodznXvoKqvkg81Z6tOZmCK/UYWut5GB7Zj4kQkrQMNFOCCA3yyPOxS0MIw5N2I59iB
         cb+GI/YC+h+PmrKSJEsW8SVaruoz3ARhDol4UtHE1xD5EWLPZ8VLJGsVPzsytaeNTKfG
         dUXQ==
X-Gm-Message-State: ABy/qLaJ8GOYhBseelMfwOFScro/hPb0qCmLCI9ClQ2B7NNq1wXhJHJM
        WM14JDfMxoXReeH5x3F6C3o9B+2LW1KwH83Ez2PiQw==
X-Google-Smtp-Source: APBJJlGCBLtBb+6/NoezgE/OIZ6IHW8KjOuAVGRXZ7G6acDHXAXQ8Un9F22hRaXaDCMKsZs3p5R0bA==
X-Received: by 2002:a19:4f53:0:b0:4fb:e06f:4cf0 with SMTP id a19-20020a194f53000000b004fbe06f4cf0mr5198142lfk.19.1690800747019;
        Mon, 31 Jul 2023 03:52:27 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/10] Fix up icc clock rate calculation on some
 platforms
Date:   Mon, 31 Jul 2023 12:52:16 +0200
Message-Id: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGCSx2QC/3WN0QqDIBRAfyXu8xxqy9We9h8jhprWhdC4ttgI/
 32u9z2eA4ezQ3KELsGt2oHchgljKCBPFdhJh9ExHAqD5LLmV6nYGhe0DK192ui8Z4Y39dBceGc
 6D6UyOjlmSAc7lS685rnIhZzH97F59IUnTGukz3HdxM/+H2yCcVYLJVSneCtae58xaIrnSCP0O
 ecvX3hDisQAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=2187;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MEmn4TdMUY6cSwKTGP5pVayS+gxapd+/H71puYX2uDk=;
 b=ppBEsnQzWYp0eimMdNSsp7hopNJK1hTAlo24R0kur3MbFhPwsMLKVdOCStEvXTt7mmha79K3p
 n50T1nTeLiQAo/g6tMPtQmeYVr/6KWSe+euAXXKTodreeoKmDJ5GJcV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Certain platforms require that some buses (or individual nodes) make
some additional changes to the clock rate formula, throwing in some
magic, Qualcomm-defined coefficients, to account for "inefficiencies".

Add the framework for it and utilize it on a couple SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Use the (arguably less favourable but necessary for precission) 100/x
  instead of x/100 for ib coefficient, update values in consequent
  patches to reflect that
- Rename "_percent" to "_coeff" because of /\
- Add the necessary code to support per-node clocks
- Add the necessary code to support per-node coefficients
- Hook up the CPUSS<->GNoC clock on QCM2290
- Update EBI node on QCM2290
- Link to v1: https://lore.kernel.org/r/20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org

---
Konrad Dybcio (10):
      interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients
      interconnect: qcom: icc-rpm: Separate out clock rate calulcations
      interconnect: qcom: icc-rpm: Let nodes drive their own bus clock
      interconnect: qcom: icc-rpm: Check for node-specific rate coefficients
      interconnect: qcom: qcm2290: Hook up MAS_APPS_PROC's bus clock
      interconnect: qcom: qcm2290: Set AB coefficients
      interconnect: qcom: qcm2290: Update EBI channel configuration
      interconnect: qcom: sdm660: Set AB/IB coefficients
      interconnect: qcom: msm8996: Set AB/IB coefficients
      clk: qcom: smd-rpm: Move CPUSS_GNoC clock to interconnect

 drivers/clk/qcom/clk-smd-rpm.c             | 16 ++++--
 drivers/interconnect/qcom/icc-rpm-clocks.c |  6 ++
 drivers/interconnect/qcom/icc-rpm.c        | 92 ++++++++++++++++++++++++------
 drivers/interconnect/qcom/icc-rpm.h        | 15 +++++
 drivers/interconnect/qcom/msm8996.c        |  8 ++-
 drivers/interconnect/qcom/qcm2290.c        |  9 ++-
 drivers/interconnect/qcom/sdm660.c         |  4 ++
 7 files changed, 124 insertions(+), 26 deletions(-)
---
base-commit: ec89391563792edd11d138a853901bce76d11f44
change-id: 20230726-topic-icc_coeff-b053d5409b9f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

