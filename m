Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F1872E51A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbjFMODy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbjFMODj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 10:03:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0191BC7
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:03:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6801197e87.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665006; x=1689257006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp0my3X3srakQ2gSkCyau0ZBJnYvxg77x8rKqL14/Qo=;
        b=Vt45ZeFHL/MEQrwgcmfRUxpgBUDOpRaVJKnI3d1JFE4K9IEzfkhKsppW0x+X/2zMw2
         i/896xXoeQKqDsYQu3PLljOBLWQM2uEH6NKhRq5sv8KtH+a1cgxaVUMOA3WKshPNey+S
         LEbUnVNJqztLH9bIxXkhehDi7oVARqsWX+TA9rAdTsQrxjQsVNLVwCVtwxRfwO5qxsTZ
         BhcrxtOYviyRsSr5NVFRm8iJMc6Earr5WCmdxyU0zqDDmivtmdCmqLGIfvYNq1jXytD6
         TyxcazSpQPDTvrPxktPT1yQfsyo+dnRaHeRlG5vy5Ink3w58ML1M0ThwmA7gOvmUdAAD
         3Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665006; x=1689257006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp0my3X3srakQ2gSkCyau0ZBJnYvxg77x8rKqL14/Qo=;
        b=eKidMgFUK3NkaUPRHqFFPj66CNzCHZnofk62BmIOKwSQsREbItcGDhmAVjNj68E7CP
         hi0aZesAFqp/fx9g6TpvjCbOkECqoUmKujMUrs2v8MPoUzz9GW4EpgUZ4IiwLIWXLS2g
         szhmmG5T6AdnlrHEI/P4HjOgE3xoICyumUxUcUwVJGYt4VVOy2aV7To7f4sAJjJhIKGS
         kaHXYQQQo4PVD+QqH4bLKMz9UlTPs/MqA5o89YDcRJ5U/dp59x8XqpooIqTSI/Arp3Bq
         tNaHWgaov3yhrp0NTJjDYDbF+EJ3LB1kYdFLyfFxV4iUkFK4JpRYHvYscP0O9/X7iNvP
         KZYA==
X-Gm-Message-State: AC+VfDxsFrOjWqbelNpFcGrvFW6FQa5KO9NrsdhubvsAKo+opX3ByS/4
        PS39AxQogOsDdb/8Ncu2vJS+kw==
X-Google-Smtp-Source: ACHHUZ6EzjbNDdYW4o5hhb4rxeYLFL005pHs6ouje8QEkvmew+trteZ8IDtZau2eTj0y6lG53FFAaA==
X-Received: by 2002:a2e:740c:0:b0:2b2:bae:abe9 with SMTP id p12-20020a2e740c000000b002b20baeabe9mr5233313ljc.12.1686665005919;
        Tue, 13 Jun 2023 07:03:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:09 +0200
Subject: [PATCH v4 09/22] interconnect: qcom: Add missing headers in
 icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-9-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=801;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=y7ojOW0m+ud31Xe2zqdGaWMhwT49pgbSaQGLO6eV4ks=;
 b=Ci+0cbxBEY1o3HRek8iJZzubIudGAH/qJjSrTaMgxvxhUi7H/Y/bu5NFnjI/y2H/HBLN8p5x2
 nqxH39A+JawCwTMmtWsQUcV3Ps/X53bQ24ZYZNOCnfd2T1gZIwxvl/0
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
index 13ca0818ffbd..ee6ec7f2d0e1 100644
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

