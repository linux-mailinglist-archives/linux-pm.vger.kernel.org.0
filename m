Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF2778E48
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjHKLzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHKLzW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 07:55:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212511F
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 04:55:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso2939269e87.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 04:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691754920; x=1692359720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAe/vav3Flxi3UD96RkxKJW2qOuPehZvJ7JYvfAnUEs=;
        b=wk0RwVAjem/v2tEiFWJVRFDBSmB0X6FKugHhJw2RtuQgeauKxIXhFligJcfrhycLDP
         Qc7Q1TJUFMOieWaCmx2cIq57dHSE+ceX1Apate2cVjFVbSY97vVXmDZpReinAUVJEjZk
         +CPQS/vYaqi90qhn0g+b98riHTg/SaHHo9uknLzeSS7NQnfJmsjzYtwwdh6lm7sCBLzL
         rtnclFg5vjAP0L/jK/pmk12nBF1q8HKRYsTA1fToMpf/1w6nyx6skoPwCqRX4tRnLX4l
         3PgNRhlVI30W9Cq9lX+E0uSP6whk9zR1RdQCPQpw9OgGpnsr8I0GdGjQIVCkpVVBpenc
         SAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691754920; x=1692359720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAe/vav3Flxi3UD96RkxKJW2qOuPehZvJ7JYvfAnUEs=;
        b=cX8xuXQZCbRf5B/8i0PxI33H7f9nBHT8xBflpzePADZCM+hZsTerPRvSQa6kfZjCp+
         bZGoS7fRvC/yo2pMnDV+todZ05h44auMbydwzMlTYoQfIBaCQRz2SkK7RPHo2kkw/pnW
         UXJyj/7z9Kpo0er79HNuZ1+m2zLAnE131z1Rk6APlRqxgnX81DSittFPSEY0BLpc0o0a
         zHx9RPan59Mzhaozr5r/AV2nWiaSAD+jGgqKqPBdT6RH4IVPJKAATkJ4bvD0nbsLtUdn
         nmvADUS3sQG8wlFdkbMRqfMDl/msBBx7ydLXbtbtntEJPGSJZyX0dyf7wjHu0mLCKRGw
         9qEQ==
X-Gm-Message-State: AOJu0YxvtCnDuC3d2u+yQKXm5mkrn/S/DOybF2GPQjmPpgQGEo0dDrzD
        BtigSlC6tcLxKyOAnGAcSR2iuw==
X-Google-Smtp-Source: AGHT+IHiLxZnaXmMUj7W+uwFsdS3Q4GoMpadA3fcsq0aQkPnCh4xdMZpKqAtMFgYQBsf8Fvr96aqvA==
X-Received: by 2002:a05:6512:3b8a:b0:4f8:7055:6f7e with SMTP id g10-20020a0565123b8a00b004f870556f7emr1670006lfv.44.1691754920481;
        Fri, 11 Aug 2023 04:55:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25631000000b004fe4a4c61f0sm691729lff.191.2023.08.11.04.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:55:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Improve enable_mask handling
Date:   Fri, 11 Aug 2023 13:55:06 +0200
Message-Id: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoh1mQC/x2NUQqEMAwFryL5NtCqsNWriEibjTYgVVpdFsS7b
 9jPGd7wbiichQsM1Q2ZP1JkTwq2roCiTyujvJWhMU1rnLV47ocQCtG8yHe2kbEzvu07F4xbXqB
 d8IUxZJ8oapmubVN5ZNb9/2icnucHS9JlBngAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691754919; l=852;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mEOUH5kNPx1NAQk/o0dFt8IISoI3HmKZcRnXf8SALfo=;
 b=H66ZL+MsvTV2BEwEdEArJgnijYYvLHrYUTi+4k/ElVp4aVVBLB+/DjUkDEuGahcWTk3yKftmf
 pEEzPl9glvcBr/731pv+nzca4ZahB62tzPxZY4BdQmkHMldECqM//Pw
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

As pointed out by Bjorn and Mike in [1], we can simplify the handling
of enable_mask-based BCMs. This series attemps to do so and fixes a bug
that snuck in.

Gave a quick spin on 8450, doesn't seem to have exploded.

[1] https://lore.kernel.org/linux-arm-msm/113b50f8-35f6-73fc-4fc9-302262927c5e@quicinc.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      interconnect: qcom: bcm-voter: Improve enable_mask handling
      interconnect: qcom: bcm-voter: Use enable_maks for keepalive voting

 drivers/interconnect/qcom/bcm-voter.c | 40 +++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)
---
base-commit: 535e616fd036bf8f2307b0f02a1912cf81deed4c
change-id: 20230811-topic-icc_fix_1he-40a3948b08f7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

