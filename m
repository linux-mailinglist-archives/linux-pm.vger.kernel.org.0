Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81FA589766
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiHDFq7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 01:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiHDFq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 01:46:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6F5F984
        for <linux-pm@vger.kernel.org>; Wed,  3 Aug 2022 22:46:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x23so9753997pll.7
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zOu2PZnulUDHwvn/36naMjhNNhFcuItCNTLmTBuVNws=;
        b=iPPQdk+0soH3e21ZXJS3c2MpcNGCyaZNfC5bOV9pNVCDE+999II6qu9eMuNU4RAhcM
         L2spZ4GLPXBmLzn+CGaXoHYc78/X8TA5+AXZZynBJ03O8ecOqdamSohHD8BynWIW+Lb8
         pUMamgtE0MY/RkQP15y+et6Y09IQsKaA9AttKGr2CwWWYJRUJi6KnsFDCyffnwnYIZPF
         JYBr7i4JAZ+QiWVRxIr6LK0xKeLtbgv/CfZZoGzA/L0MF0UBTxCb0Gqbj+rGXxGsPfDg
         C+wD4GxBZ9pZSpq9uLAM3CIXWoABzrYXnrFGV9/JFZcrbJLNdIOWKiuHUfsMmU0NYcWS
         KybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zOu2PZnulUDHwvn/36naMjhNNhFcuItCNTLmTBuVNws=;
        b=rEktZKBaAdZOm5rE0S9vzY6XtCRbb4/UklOdpvGuYeawdCCbE1CUz8cs5vfPnF+amH
         jjt0ETzqEQc0JMboliDaasb8WJXJDHPpFWx0TbMntp6NxBxE8AkvzagmXzp87oEC90Uw
         9OSRhseWK1cLnT+iHC9Sy/18mVLIMRBHAQSaKr6/y12hiLI/lkEILqjSWOaPgWkA3s3w
         NMvYcRkrFhPXZNQqa8pelK/W8IP5vvotsOFvt3CbUT+C2r0k3VgS0eQ7U1jNSQ9hOQ4w
         NEkEi1gdU40zs+6nv/2DYrmYnm6Za2TaJWP5VmJ5uTy1KLKIuuxXpWkgv6FFz1sOiZ7x
         LaGg==
X-Gm-Message-State: ACgBeo0AtblOoYb9dcrftphSn1G4JpvQNmIu5B63UHD7/mSbLlqf0bRG
        S14yNW0JfSd92JCWznD+JbSKkTBuy2lZOw==
X-Google-Smtp-Source: AA6agR550/nQT2itwZL3twabTlLGdnUsWpNaElnagN7UPumzS2JuTU/cEyTdU0ERLazKtaxvGXSBzg==
X-Received: by 2002:a17:902:7049:b0:16c:b1f4:e00e with SMTP id h9-20020a170902704900b0016cb1f4e00emr308434plt.113.1659592010367;
        Wed, 03 Aug 2022 22:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:ddbf:1bd6:4443:9e5b:2aa2])
        by smtp.gmail.com with ESMTPSA id q25-20020aa78439000000b0052dcd14e3desm5375636pfn.183.2022.08.03.22.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:46:49 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v3 0/4] Add support for tsens controller reinit via trustzone
Date:   Thu,  4 Aug 2022 11:16:34 +0530
Message-Id: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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

Cc: bjorn.andersson@linaro.org
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
 drivers/thermal/qcom/tsens.c    | 200 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  18 ++-
 include/linux/qcom_scm.h        |   2 +
 6 files changed, 253 insertions(+), 1 deletion(-)

-- 
2.35.3

