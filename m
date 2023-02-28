Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3A6A5A27
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjB1Noa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjB1No2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 08:44:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEE2CFE4
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 05:44:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y14so10281556ljq.4
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV1fhlo3d+5jqHbCH3aEpZYk1ZijM8P8h8hsb2YwO9c=;
        b=W7Sy/y2onzIyxmgt4z39SPajh86w0VHy6ae5q59uMRGlVZq2nBk+m2bQy1qI19zMJJ
         vkRjJzhH0rdtAsVNaQskpxS9tD6s9SLVMXI0n+7PbwQjiofnE3HoKPplOGIa0Nl80Z3B
         O50H3CJ6KPfHx1cRIK7PEHlPwQChFunOXa1J8Eoma2tds4ZV4VceY7WqD4Yi6XCmrZY7
         sHyk75z/DCZMZkou2nElWPktm/qLGwOZaXSUlEnFZu54VjYrCWUO+qY9Wnqj38wKq88L
         E5ClgbwidJcHajh47SuUz3h6FNGRzj6DQEI7Ll/1uu6XSUXVb1zCrDXEP4YLW4zLb8yJ
         SSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV1fhlo3d+5jqHbCH3aEpZYk1ZijM8P8h8hsb2YwO9c=;
        b=iDlhLwapxuglBCSOFFgnzvqatBmE8E+DISw+lyyN0dFA8W0oNGt7G+BcnX3WlnvKYV
         O1SsjlNdwKOociEK+yXwuy4coz8tbV9F07vdJVOdhmHdwwZiBkq0RbMq7R8hEeKYIPdh
         B/cvVCYQAmIN9VoS4sXz0CAqYW1/uIul8+/72vRKunuAqYnfM3Irr3daFuuyPI96GLki
         8goTjINn1ntqg2rQvZj6B8kv0gEa6iX4TCowP96yXSSDTw3zNpwPeM5dcR1iB89U5JpE
         JXF4/505klE9IdHRvVz0ZbOrPAAPAhUHuGvFwOpcePf28JdO0hnXTa+Qw0s20M/jo7wy
         oDCg==
X-Gm-Message-State: AO0yUKXkBufUdOJUAoQNGZJmQC9/eVlmNC+sUr301jXsJ4R4WdUdcypv
        rKQMqe4bwveGmjwgQrpVY6QWSA==
X-Google-Smtp-Source: AK7set/W3+UTuJlyeNhivmDLtdqcxP32//zQsiK9r2awwDh6eZfx/fgfpSdCnlRha8MITMrIIxAPEA==
X-Received: by 2002:a2e:b687:0:b0:290:6e3b:be34 with SMTP id l7-20020a2eb687000000b002906e3bbe34mr867728ljo.42.1677591865866;
        Tue, 28 Feb 2023 05:44:25 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:25 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:44:00 +0100
Subject: [PATCH v6 3/9] interconnect: qcom: Sort kerneldoc entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-3-3c37a349656f@linaro.org>
References: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
In-Reply-To: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=1082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5QScrGeiOGfZL7HfpuChoBRhoWNcpAGpYtvwcTxAXqc=;
 b=MjI6nH538sQxDeLAdiyxmWxIutkkkXPLtzw8UjcYfXgL47ublxVZT2Dj0MIxLTktyl3wtoiSVG5+
 EG2ru9cfDbb+EfUb053T1dKxU5dSwVArM+hJNHE8L9688wrXnvNp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sort the kerneldoc entries the same way the struct members are
sorted.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 8aed5400afda..21f440beda86 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -23,12 +23,12 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @type: the ICC provider type
- * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
+ * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
+ * @bus_clks: the clk_bulk_data table of bus clocks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;

-- 
2.39.2

