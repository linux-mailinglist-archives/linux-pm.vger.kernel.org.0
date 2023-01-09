Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD79661B61
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjAIA3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjAIA3l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A3C749
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d30so5704912lfv.8
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkMG+K9H+pGjfaEipJupWJDRprpXoKUTvkDrtSa1M8g=;
        b=wqduT1R5LrCWxZz2kAjG67pviB7V6Dm1m6enAewPqhUpa/IfItDXMMKIr8wPXYoGPW
         wmkzitgbO7/549EE73NlHdPG/Oew6KGx1RbbjfkujDyjBPnihhcTGy/do6g5pvOCeSYu
         z4F9jkgsmH+lcwQGBZ02FidrkyrbOmZAy66LDUlMI5ThV2yhQ4DALuRa1fh8TsJmR1Mk
         8ENA03LRF8tgV8mdo1mKjiEmygDMcBRqmK35fla2drTR1Rv2zeH2Y5/M8Z9NVAxuH8aK
         G7sV/ujiMcnVOs4/2cSHY2dowkoU5mXtUtAc9fYibVdU+RSBivTD4Elgm3UbdZszO9Jd
         8yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkMG+K9H+pGjfaEipJupWJDRprpXoKUTvkDrtSa1M8g=;
        b=COOLXQg3ViXmvfFtNcQ4a0MW57V+N9F5uezOB/KLsVsHGRgPr/pIT/aOMdS6FLOFj3
         FH4brtE01Na0Ea7vNslZNmbHCa50VVjcpf2V8pQXEvc25U7V45uAzsQk7jpfa4K9MyzM
         SFl3A6/bo7pCX1o/11bhK1ucQ4r42kMvuBw4uMo4sF8Rm/3KHFR2Z/czNH6BSHJihJc8
         6BJKuDHBXYsPwfleIrAfvHPYq/mpOa73688t3i83kqjzZ8M9bbtvGf2XsM7NsVC72zbN
         Nwqycl0Lv+Msi/tr/Qhc2ZcyU+Q5Xs6ewnU4S/v6ETf3psEQ4S64YtFAHIWxWGjQy4JI
         2v8g==
X-Gm-Message-State: AFqh2kqBoa8pk207BdfJSTXBweE6SZKCIbx1h1wkRqVeUd9JtzHBwqf3
        G/DjwPLI6y95uzmZxiYfSKfwfw==
X-Google-Smtp-Source: AMrXdXvzXzAp+pfOkAYXNni8+9k5QlRcujYQxSmxgYhrouPTLdtV5w0IhXVIJrtxD8EGgs8bgRoxkQ==
X-Received: by 2002:a05:6512:261a:b0:4ca:f432:3e45 with SMTP id bt26-20020a056512261a00b004caf4323e45mr18035490lfb.33.1673224177976;
        Sun, 08 Jan 2023 16:29:37 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:37 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 02/12] interconnect: qcom: sc7180: drop IP0 remnants
Date:   Mon,  9 Jan 2023 02:29:25 +0200
Message-Id: <20230109002935.244320-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
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

Drop two defines leftover from the commit 2f3724930eb4 ("interconnect:
qcom: sc7180: Drop IP0 interconnects"), which dropped handling of the
IP0 resource in favour of handling it in the clk-rpmh driver.

Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 interconnects")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
index c6212a10c2f6..7a2b3eb00923 100644
--- a/drivers/interconnect/qcom/sc7180.h
+++ b/drivers/interconnect/qcom/sc7180.h
@@ -11,7 +11,7 @@
 #define SC7180_MASTER_APPSS_PROC			0
 #define SC7180_MASTER_SYS_TCU				1
 #define SC7180_MASTER_NPU_SYS				2
-#define SC7180_MASTER_IPA_CORE				3
+/* 3 was used by MASTER_IPA_CORE, now represented as RPMh clock */
 #define SC7180_MASTER_LLCC				4
 #define SC7180_MASTER_A1NOC_CFG				5
 #define SC7180_MASTER_A2NOC_CFG				6
@@ -58,7 +58,7 @@
 #define SC7180_MASTER_USB3				47
 #define SC7180_MASTER_EMMC				48
 #define SC7180_SLAVE_EBI1				49
-#define SC7180_SLAVE_IPA_CORE				50
+/* 50 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SC7180_SLAVE_A1NOC_CFG				51
 #define SC7180_SLAVE_A2NOC_CFG				52
 #define SC7180_SLAVE_AHB2PHY_SOUTH			53
-- 
2.39.0

