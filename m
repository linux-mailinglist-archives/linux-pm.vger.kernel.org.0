Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AE973579E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjFSNEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjFSNEk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 09:04:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFABE71
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 06:04:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f86d8a8fd4so1697856e87.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179876; x=1689771876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=MEBJrQkTaE2Obc8iFNt7Np0xx6xXgxDi9DxIeY/OilZhfrJZ4+Eg6Zvj0gzKZQyrYh
         I2Y3B0QtAjxyUTM4j5ze9FqEyuHYOLQ4pUlFpZquFeqGt6eafEtmKW3tkOzhioovo6Ix
         +lfJysVGTKFE1np+TGIJMz5GyMGCH+205MEFkj3VcHG2TAxvBTCz0zvN12sNPUiO2E1/
         LJGGe2Ki0de1dOZTROdqNsyEnYdHvM8kogu7p4AKrkgBPStHCyfmCrfFScszfs+Qx2cE
         eK99k7b4MeNAcbTuDqCnSxY78MmiWMsbTenf3JR4IB15+LGC40fn5Ch4fmfjybE5XyZi
         pdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179876; x=1689771876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=jAXsQYbSIb9ggl5T+drqO6/39ANbKDe9ZVuJoYz/3MRFyx/fqMYtOO404h+jGPvz5u
         lr/J5Bj7MqB03r8p+hy9c/8B1C8WKeQt/V50wDmfuUSDNO6lIVqi68Rv7Xy08Y8/lnFl
         jEO3jFzo9wexSVlPsusUamqMuShd6n/D6+7rD4iH1rkZ3ERLX540mhEPIg7+IGoMdkkg
         QvD8uHX2qo6DEnUJxVwRzG0K1LWinIS2GJQp2p8XeZ4Ll8Ja6rGbOV/V57nbZ+DhREsg
         /i8ttetyoXaEEgWz2AuaLtB3SQhN8Ac4QYhA2hHK89f5/Aba2CVsHnesUoWCN+PW2eHz
         WRvg==
X-Gm-Message-State: AC+VfDxO22oagppcXNbS9hIwxfbgVBel1IdEClm1TtxXM53Kn9FdgT+6
        6cPZE83mZRGkmlk3istHOO67TjEy+E4L4qCqdgw=
X-Google-Smtp-Source: ACHHUZ54kgNnBNjpHY2VsTtPy5ciu6l8qVuZsnGtvLdG6i0qgSzWgT40fZXRT0Ox1MRURghfIhSgBA==
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id t20-20020a192d54000000b004f85e5fb368mr3294587lft.21.1687179875970;
        Mon, 19 Jun 2023 06:04:35 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:28 +0200
Subject: [PATCH v7 03/22] soc: qcom: smd-rpm: Use tabs for defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-3-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=691;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7uAPa6YDjXHLJZjqpcpTS8PIWFtwDRP9qtCSKC7URyY=;
 b=ldOEYlB+5a6jnmytwKqGkthK6sTw9h+3/ZdoITHelzcYHEORrrDlqcYa6guWQ2K/hdQhjGm7X
 6UbQLTcIxYrAG7uw/xjlX4I0dAN8P+xrC9032foOqR/ukm5OUKSqtUU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

