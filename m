Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940172FA60
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbjFNKWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbjFNKW0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:22:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3F10D8
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so6970691fa.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738141; x=1689330141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=IaNpcdlSsewK5MnmMqhxBLis+uWSHq2jaQn6PRaOhh4wwVHHHyBXQrsU/T0OmVlvdw
         CpsUyEh+FofeZCR8SgyzgKCxOUpX3+1pIR+wonDJpi707JtmyzZm60SnIWEPMGsJpUWV
         gv3q+qhwTZxfgoUN30JKzDprJygEmcrab4uL2QeUJJyNRC8hgd46uUFs/D6FlR53beDQ
         PpDzxRs5B4iWWY5UbbK/AWM5CxzZ+KmSgCZ6hWv+KlNuevv3/RvcLx/fb3lBSGqKwfWK
         dwSLQQeNf9oUk3YGjNDasu5niXf32ggphb8x7iDTpouQtnFF2a0PnQ4pjgFXn65xAmIi
         uJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738141; x=1689330141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=M80o13ynYhkqfEmiBmsiVcIDNqNEthwccw6gOM1YesDw/tgkwm8IP5TRTiFqysZWsr
         vTALeGKexW/Xl5mOlm2y/3vRNilrcosJXO+OAq+4vl5AKK+txOn/BPYmrkOyM6vv3udq
         dlLIu+0tzs3L73F5EQ0jMX8VaIbUROUY2zOiddmfUWSeFlPXvWpAEE2776MavHGoCp7B
         iR6nPSlTNCG9YCtHKKQiPjwqjontNoasjwa7NWP7fUQAAmUFgzOA2MQX4yB+fUW5rXly
         z46jiP2o5bEXYKap2E5nnAOYB99ALznMneMixEFBI5hkRiMxfI91I96soVujwLLxXJlE
         MOhg==
X-Gm-Message-State: AC+VfDxwn9hNWJOMHqV+SCvj1Os/EzgtgDqOj8zaJdo9N68XXUTZwTP2
        psMq6vEp64EhoP4E2cbogogS/Q==
X-Google-Smtp-Source: ACHHUZ5dyzvRxN8MlMMT8sPEpV4zHOiKDdnfOOLs65PL6a/jT8ID8WF+NYlGczgyiEKx1TJKEX1AAw==
X-Received: by 2002:a2e:960c:0:b0:2b1:d5d0:f164 with SMTP id v12-20020a2e960c000000b002b1d5d0f164mr5912020ljh.13.1686738141329;
        Wed, 14 Jun 2023 03:22:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:14 +0200
Subject: [PATCH v5 03/22] soc: qcom: smd-rpm: Use tabs for defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-3-eeaa09d0082e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=691;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7uAPa6YDjXHLJZjqpcpTS8PIWFtwDRP9qtCSKC7URyY=;
 b=luRAt8WeZ0LpKB5nfOzJZGKhoAG08DyQ+JzDX33AzKA+1YHx7Ykr/FOuajWrfa+FBpi0NLGu2
 hmWHpWiwMVrC4x1+bJSsnVDkuACukxzR1hVSjFXvCzdI7fwXK9tBDlT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use tabs for defines to make things spaced consistently.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index e468f94fa323..99499e4b080e 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -4,8 +4,8 @@
 
 struct qcom_smd_rpm;
 
-#define QCOM_SMD_RPM_ACTIVE_STATE        0
-#define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_ACTIVE_STATE	0
+#define QCOM_SMD_RPM_SLEEP_STATE	1
 #define QCOM_SMD_RPM_STATE_NUM		2
 
 /*

-- 
2.41.0

