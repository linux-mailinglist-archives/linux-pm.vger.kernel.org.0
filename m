Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F445A951A
	for <lists+linux-pm@lfdr.de>; Thu,  1 Sep 2022 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiIAKye (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Sep 2022 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiIAKyc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2022 06:54:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF29A12CB20
        for <linux-pm@vger.kernel.org>; Thu,  1 Sep 2022 03:54:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m2so16737993pls.4
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2022 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2j/euuewrJLsmuH7PP5LuRSskWex4MK4oenY2YNmi7o=;
        b=TbZl7S2tkGZvo64LY0ebTP/BW0w7CEo9wRD3fni+bu2LoIcaSC3RsN1j2a9D5p4Cte
         l4YM+fizu2O9DwG/CDcZ1Re5rMqXlRMnOE0W2TrlA77q52LVDnmgf/l4NGOoe9ritQxe
         2DjHFEva0mj3FCO6L4ZhH0fBoMlLX65aQ55hjmtq0J6MAtklj3VVReWDD88Yz+bUpzy+
         Ek1vJ4FVAxbYYr0mA3aU8pi2TE4AUitLfieLTueKMzMMN8m25PMpM8VXpsfuDcIr0LSw
         eR46jCvJ2av61H3vVKJfFyYWKme0iGc2+l9UQ4eZOBFTTavnr+wkDmaS8/F56QTcYx0S
         xmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2j/euuewrJLsmuH7PP5LuRSskWex4MK4oenY2YNmi7o=;
        b=tGop0XG3RChzfv14BDCd8k9XMWqIfRnfn0SQVjJOVneFeMWYazd3WJtIgALq9CDQ9T
         JCBD9eAL+FMTf4aypL5oN9EfF0A0jSG+kaqa16g3yYwv9EEorL2J4/wZB5QdHBW5TspD
         q5hsU0bg94kH9AfAkAqFq0xMEzdC3CjWtURO24gglCwBCchnnIAyojp4D47pGtCdVWSW
         OLaNEEJN+5MT+VV4dhyN0sgvquzRaNfzntL41zm+/YED+qF4G5OcRddSEqMMkOcZLgZS
         NkwlGlfdDgpvM+Jz0bGvf98+AEB8dXREyxvcRTL41gjk88kLgln19I3BToFs3dLiswbf
         wRNQ==
X-Gm-Message-State: ACgBeo0u4aLLIMJ2uhTPkgRl0sCOqJBpoUqqwVP4hyc7RZxs+4DNhRCB
        UeQ3/zTTHtjoqINYY1uuWTUD5cOJlLydvA==
X-Google-Smtp-Source: AA6agR4X3IrGw9Bu8aLpEws0oDKUEuYQZPfL9DS3huamNRggIRsK5P/pRA3DqtdZdhsdCAc6I+RCTg==
X-Received: by 2002:a17:90b:3907:b0:1fe:34a0:e760 with SMTP id ob7-20020a17090b390700b001fe34a0e760mr6671416pjb.45.1662029668590;
        Thu, 01 Sep 2022 03:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:8069:f46:34af:eb19])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0016c57657977sm13508910plb.41.2022.09.01.03.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:54:28 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 0/4] Add support for tsens controller reinit via trustzone
Date:   Thu,  1 Sep 2022 16:24:10 +0530
Message-Id: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
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

Changes since v3:
-----------------
- v3 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220804054638.3197294-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Bjorn regarding early exit paths, spin
  lock being held while returning from func, etc.
- Also added Bjorn's R-Bs for v3 patches.
- Rebased on latest linux-next (master branch) tip.

Changes since v2:
-----------------
- v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220724122424.2509021-1-bhupesh.sharma@linaro.org/
- Dropped sm6375 specific patch from v3, as suggested by Konrad.
- Rebased on latest linux-next (master branch) tip.

Changes since v1:
-----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220701145815.2037993-1-bhupesh.sharma@linaro.org/
- Addressed several comments from Bjorn regarding locking, serialization
  etc received on v1.
- Addressed Konrad's concerns about the tsens controller found on sm6375
  SoC which seems to start in a bad state or is disabled when entering
  the linux world.
- This series would depend on sm6375 tsens controller changes being
  added by Konrad. It is based on linux-next (master branch) tip.

Some versions of Qualcomm tsens controller might enter a
'bad state' causing sensor temperatures/interrupts status
to be in an 'invalid' state.

It is recommended to re-initialize the tsens controller
via trustzone (secure registers) using scm call(s) when that
happens.

This patchset adds the support for the same.

Cc: andersson@kernel.org
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

Bhupesh Sharma (4):
  firmware: qcom: scm: Add support for tsens reinit workaround
  thermal: qcom: tsens: Add hooks for supplying platform specific reinit
    quirks
  thermal: qcom: tsens: Add driver support for re-initialization quirk
  thermal: qcom: tsens: Add reinit quirk support for tsens v2
    controllers

 drivers/firmware/qcom_scm.c     |  15 +++
 drivers/firmware/qcom_scm.h     |   4 +
 drivers/thermal/qcom/tsens-v2.c |  15 +++
 drivers/thermal/qcom/tsens.c    | 193 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  18 ++-
 include/linux/qcom_scm.h        |   2 +
 6 files changed, 246 insertions(+), 1 deletion(-)

-- 
2.37.1

