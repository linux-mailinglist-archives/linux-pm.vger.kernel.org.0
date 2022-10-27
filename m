Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23460FC46
	for <lists+linux-pm@lfdr.de>; Thu, 27 Oct 2022 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiJ0Psz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Oct 2022 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiJ0Psy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2022 11:48:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391F1911C5
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2022 08:48:53 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j21so1224398qkk.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2022 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bd2o65SJMz3i5RcjHxiT/cYGibvGVX6duHYP/0Qh1k=;
        b=cm7aFwKkZHCD6OoM+YEoDZXCH9vzy1bIwzrlS6smcZCpQrIdbxy9i74nm7AGoqyZT+
         2kaHC1NJfIb1owR4fblwFtimEy/eOXTGf0hmBri7WeqZAipVA+CO8CKcdKGB4j3DTHad
         IhQ4yW+dYrHc8wdKHvVf4yT8ZiEkjN/laQY71NbN6/JeqHgMDXwVfv27J+/9/A0uOht5
         OG3V7CAqhlXbJaXscctXNiN7THcpgslGiYtkN0bxtCUrn0vvN+DlxXSh7GaAop1EXH2p
         RV6ki5ReDChYY3/M210eBDG1KQkVj3DVsBDp1QiGzWkK/7eAqGIj+e2bZcgWuOIHIVfH
         aXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bd2o65SJMz3i5RcjHxiT/cYGibvGVX6duHYP/0Qh1k=;
        b=hUZvxngUDCQkCREgSPyyHtqoDhtg9CV8erinlwuoZlLDtFzP+hpiTG32b0qoSjMorX
         ryrDS9mfffho+l0A3Hlyy8Ppe7mAVYosCeSqfxd3JxwJRFk9gIVCwbH/5KycUJccZ6/5
         fgxieUi9MSPdukwTmBn616T6gzcaIsESWNkpoHwZOsfu5FQ9TwSwhdI94BUm4ToA71RH
         WVKs0OI2dUd5uSPdZQrr7qZZHMKAe2yJ+0/3b8Ul4sMx/qC3gQH+vcJFp4U9Ix3/Twl8
         n7clvl+1MxpjwUKOHhWL4usGh7AGrmSOpoNPNrfz69jI0tHVW+k1YK7BCkP3NLkA8vEU
         ujxA==
X-Gm-Message-State: ACrzQf3uvH8ayX0OYrWFlMyU8mXf1tOzx2s9Al35lHj7GDnQY3BKIUhg
        lmocJ9iDKYzwEBAK6g1iv+30fQ==
X-Google-Smtp-Source: AMsMyM5qEVOnPgHTsEpHls014vI8BMePU6289s67Xrr/CbE3MVgIguufqEtjNgKAdTuipUmjjBJw7A==
X-Received: by 2002:a05:620a:29c6:b0:6ee:cf89:40cb with SMTP id s6-20020a05620a29c600b006eecf8940cbmr35399092qkp.107.1666885732747;
        Thu, 27 Oct 2022 08:48:52 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a095d00b006eecc4a0de9sm1168531qkw.62.2022.10.27.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:48:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] interconnect: qcom: sc7180: fix dropped const of qcom_icc_bcm
Date:   Thu, 27 Oct 2022 11:48:46 -0400
Message-Id: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Pointers to struct qcom_icc_bcm are const, but the change was dropped
during merge.

Fixes: 016fca59f95f ("Merge branch 'icc-const' into icc-next")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 35cd448efdfb..82d5e8a8c19e 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -369,7 +369,7 @@ static const struct qcom_icc_desc sc7180_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
-- 
2.34.1

