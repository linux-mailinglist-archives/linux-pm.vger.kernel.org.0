Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B172FA79
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbjFNKXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbjFNKWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:22:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DF1FDB
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b3451b3ea9so7022021fa.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738150; x=1689330150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMeAB8NggavhtPAodbQxMMfHHg0eK6NS0qxA7bar34M=;
        b=u7mg0gl6T6dvzGaemnNPkVmeKUtqKffHc5fJTjY9zitQcuLWW9qMRypervzcza/N/6
         6IXTg+vkMNRIn7C76UEOBtJYTR5qdhRs2NKMWNbAFsJ1rdrrp4qG7Rp+pV6dF9GZzpNc
         0TmSBZpOH6E56Zvxmj4yHWlidJxnKV+FUVAstG8yRKRPoyvM3wPSkX5AazfLmX7J9aeH
         wDT4cTD34tBxbhExMvb+a3mBzeK8CZs6kssjPdQ9H4gHDydTEhpymB8A0O9Cm0owFfDv
         01qmYQJXRtkB7dDdi5HbU1D6NlGZcfe6MxqfWAR+j9RKP4eaH8kJfUA9JKOjwSwo+AgO
         QopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738150; x=1689330150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMeAB8NggavhtPAodbQxMMfHHg0eK6NS0qxA7bar34M=;
        b=dGkoI8Njctn8MZsL67SVrd0UqbHkbW1Ge0FQIt4y98bZh5tF02VD3sAU8pMvTYZ9NN
         HlycMp2JnJWu+txiCQFZbIg5wqvbyexeSe5oXQHXxftWuQwp8dO2P7t+a3elRytA14Lk
         JIYoI0IPzfS35LgJDrAvS2EQPaYMnM5HwJD5c0PgS16vEGqvEuS32NAI44qszcrm5fQW
         X2hkYP096rZlJMEyM8sP31p/jOpagNZ+Blqivso9/GT2xRV0HQ6oDerQgHcp5KP++s87
         2Qj+7GVv/0SdPsCyAD9JyiiVezJ5b4PzuxHrKprg0LoUMAHaUg8XFt2AxLpMhWzsQhA0
         4UPg==
X-Gm-Message-State: AC+VfDxefseB+fE6ZOiWzM1CFxP+L6DPqx7BFljV+WuT3S3sA6nOZTgC
        WsYKF6S0MY8F0PayRDPZktcLpQ==
X-Google-Smtp-Source: ACHHUZ4WaeoyumQuMN8UGyOwnQwg9TqbJFYoJWE7H7Rj1LJIQ3rCUhoEUwLDazFrgET/Xsm86Qg07Q==
X-Received: by 2002:a2e:9846:0:b0:2b1:ac82:296 with SMTP id e6-20020a2e9846000000b002b1ac820296mr6623077ljj.34.1686738149872;
        Wed, 14 Jun 2023 03:22:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:20 +0200
Subject: [PATCH v5 09/22] interconnect: qcom: Add missing headers in
 icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-9-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=801;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/wElQJQGA2PmNr9/Z6eDTmsxdX4r+DV0cr/U6e1eUwQ=;
 b=ev/C4jG/PswbyAbtaZxNLmYPCT+12tzwDzErWPQHJUNWaM+3+H4vwU4KEfI8Kee0W64fqQlhP
 defP+GNlfwUBSnXQxy/8bGZkNchl14q+ju8kUD1oQszoS2kM4erOuT0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the header does not provide all the required dependencies.
Fix it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d857fb1efb75..0355e0250ccc 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/interconnect-provider.h>
+#include <linux/platform_device.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 #include <dt-bindings/interconnect/qcom,icc.h>

-- 
2.41.0

