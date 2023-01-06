Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1036607B1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 21:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjAFUK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 15:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjAFUKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 15:10:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72DF84090
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 12:10:33 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so3496763lfb.13
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkMG+K9H+pGjfaEipJupWJDRprpXoKUTvkDrtSa1M8g=;
        b=lYLgnUmFIUCTe1lsQi1+rAKkz/9Qlq2O6yt16Z1KqFnl5ZCqchG1b2I7xWmyciwQsR
         dfcOof5J9ckILmq0kMCRSuiyXYlbUTaO/7NwhIuxioZAaBoWKsrd7fWHxdr93BeDc9TP
         kjTmMwEZLUU8O/fPzeJQWeeP9i0R6mSs9l4raLskxyyup76u0qZEBGgPbEoML3VFFHa6
         WofAHqypTlQmCQ/F/OQkbs4hdiqBqsEyn0GgJmGKTcj2ZjwVMpl2pwKtpiAPQ3GGdWC3
         qJqh5kfps635WTYMEIoDpZ64IO/WA5h+EJ1cp/YpJ154VScMWzvjLJHHizy3Xr7KMHPg
         6SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkMG+K9H+pGjfaEipJupWJDRprpXoKUTvkDrtSa1M8g=;
        b=MOVx3dAS40RcheM6fmkpJpAD7llSGNMRNmnXtHIP5w4wKBD4ROt8Lr0tu1wLgdF04o
         CfVL4ZXU85ZLc6JlioIQ/oS8Sbk/GcIqwhvkt88e8e716tngJxwpSlWD3Sp4L76er31X
         fVIFZCH9EAOSjRP6Yce2piLjBrfrC+xEIUVDR+lzupCv3CR1HS2W6vm6GhpsoGosn4N2
         ZAW2x1hVf5GpXvDy6K9gNAmVmjj67ipV/nTZh2MdOfYJ7AZkJTNIEJ8oMppJaxMogbQQ
         pkO+Kz/V5xFypukoKWZOm9tDkK9Mq67kKf2b6Om+R/W+8oU+wv4SfGoF2v81NrgK9LSP
         tIZg==
X-Gm-Message-State: AFqh2kqMmU1L7OH4K7JrHvOnK7vo3YUiJK9aVwYdkMYkFFcCQ9KipRZF
        eMZ5asPcLR8U036EbzmBYIcGPg==
X-Google-Smtp-Source: AMrXdXu1IleT136NrHXp3lHCSqJTP6yDYCaHheatX5Nh4H6MXzVys56QlzDljZV4JOnHncdLrkM9LQ==
X-Received: by 2002:a05:6512:1054:b0:4bb:70b2:6f50 with SMTP id c20-20020a056512105400b004bb70b26f50mr17354617lfb.52.1673035831982;
        Fri, 06 Jan 2023 12:10:31 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm260875lfv.128.2023.01.06.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:31 -0800 (PST)
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
Subject: [PATCH v2 02/11] interconnect: qcom: sc7180: drop IP0 remnants
Date:   Fri,  6 Jan 2023 22:10:19 +0200
Message-Id: <20230106201028.1809541-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
References: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
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

