Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5436773B46
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHHPsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHHPqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 11:46:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32123590
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 08:41:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so12270580a12.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509254; x=1692114054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/O5Y0Ab6iaBrA/9OXoJTEQWxJ6aDOXFu3sTBHt6SbVg=;
        b=owj9zOiS+WpLwSuYIV2v/oDhHnbHVLlR/PjVPxGOD+SoCspViyS4RadNvwujC5mk7g
         vYJyCjZoLI68OyN5KJsfrLT9mm2oWF9b5Ag2VxqtJjuIzj0JaJ7Yt1jwEKZJ0HOxweBo
         sr3oYmAay/73MShIhTrqCm2Xwt9n7B0CFGmI3X6cwc3YcYqkSnvlM0ULIFvIPJZVhGOP
         /LtVk/khmlHksNKj2xdyTNCuU3lUyz8rvipoDcI286Z0QJua3SQqHC24y1i0w9m1F3DV
         ZCG7LXdgkNrL9P5Lz5XZXhRRTJ3W03Ba2z7Q63MlLeaubt2e4Go4sieiSnDdKHEoHqA/
         +cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509254; x=1692114054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/O5Y0Ab6iaBrA/9OXoJTEQWxJ6aDOXFu3sTBHt6SbVg=;
        b=TdJ+8C75ikkc4jpPS1mIO5RH+smyk3D+NgbOKdl2MY1aXjhrIfHE8qk0Ge6/dsf8xH
         TUOKj04jhBLprrhIZMEprBTorPY+hbKMVa5qHk2z7p/g5hHaB9F4rR21oYcoOmMC+sSM
         hTEtkZhqMJyrwTf8HngsYet4uzyFYhMJZhFjMSGUIxNrJzd4Cf/eI6tzxG7uHAhRDjbU
         V/Xc5enlL49fuKvTidE3/jNjvODY7qTOWhDpKGkWHyXIlxgYr3+5RpKaX4GEjY+hWWKz
         byB1hW2EJfo8a2sLHYb5W0ausexYtEsMisyXyEonc96z63+D/pzK1ElOpoEbLIzhZ8H0
         eqMg==
X-Gm-Message-State: AOJu0YxcBFQhnkGo46Tj3jLsPIjkqm8KQDB6NS5M6BA+MOasHco6p4Fi
        8ozGlYjcLweVIWWCCvIKEJkXVvWFzKN6DNfYX8Q=
X-Google-Smtp-Source: AGHT+IEKsgqAUkiOiaAlo6saAvwqonIwJGWfF8xIR9IDr27vL2re2F5DITPtclAWx6uO1jWvHZY5mA==
X-Received: by 2002:a05:6512:360d:b0:4fe:b97:e361 with SMTP id f13-20020a056512360d00b004fe0b97e361mr2685997lfs.18.1691495015550;
        Tue, 08 Aug 2023 04:43:35 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/10] Fix up icc clock rate calculation on some
 platforms
Date:   Tue, 08 Aug 2023 13:43:31 +0200
Message-Id: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMq0mQC/4WNywrCMBQFf6VkbSQPm7au/A8RSW4Te6EkJalBK
 f130+5ciMs5cGYWkmxEm8i5Wki0GRMGX0AeKgKD9g9LsS9MBBOSNULROUwIFAHuEKxz1LBa9vW
 JdaZzpLyMTpaaqD0M5eef41jGKVqHrz1zvRUeMM0hvvdq5tv6O5A5ZVRyxVWnWMtbuIzodQzHE
 B9kk2XxRyCKoIWOg4JGsUZ9CdZ1/QC5gVttBQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=2722;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XAhr1GRTTz11VXNGM0HJcweTRyuP6Ic8MAO173kSZZo=;
 b=uU3qPRoERGY/xei0GUD/LmqbFzELs1Kt4lOdOOMFgQzXC/ob46KMRct1oyF2A/us51ZC0pd+d
 4CWXccEf7nzCol5TgXFeAIurv4W1u961WTfupsjOxliRUIydPuFqn7E
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v3:
- Allocate the node bus clock on the stack, as dynamically allocating
  it actually wastes memory on systems with 64-bit pointers..
- Add the node bus clock struct member in the correct patch
- Simplify using coefficients by only checking the node-level ones, and
  setting them equal to the bus-specific ones at probe if absent
- Fix building on arm32
- Mention some references to the related downstream code
- Link to v2: https://lore.kernel.org/r/20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org

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

 drivers/clk/qcom/clk-smd-rpm.c             | 16 +++++--
 drivers/interconnect/qcom/icc-rpm-clocks.c |  6 +++
 drivers/interconnect/qcom/icc-rpm.c        | 76 +++++++++++++++++++++++++-----
 drivers/interconnect/qcom/icc-rpm.h        | 15 ++++++
 drivers/interconnect/qcom/msm8996.c        |  8 +++-
 drivers/interconnect/qcom/qcm2290.c        |  9 +++-
 drivers/interconnect/qcom/sdm660.c         |  4 ++
 7 files changed, 115 insertions(+), 19 deletions(-)
---
base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
change-id: 20230726-topic-icc_coeff-b053d5409b9f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

