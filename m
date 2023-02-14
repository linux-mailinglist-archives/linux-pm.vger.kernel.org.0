Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50401696700
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjBNOiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjBNOiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:38:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8623320
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w3so10688484edc.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xya4N6V99R7wqs6ZB8AIcG0kln00FcHSqxn/UQPegiI=;
        b=EiKX90X5fNy6Nz388HaVIX5jCbaMOoZ3lyT6vGA9izzswRrk84eWbViJSEZRmUi3Gi
         94y1It23vgAqwGQrE+SSetmPTORcz56fR2R0M9eaYQCBQvNkJhYjvTertdPnMvx8FOaF
         ZO3A81QM2XO3zC+fxlBsNPt4K6WbqaRBQt+rtDWhogu+HfDqY94cDCtIflO9wcBXE3AU
         V2QMdZhRgU9e1+B41q2dyfzla/RAWLG5Kybd+Gae3ta2qdtZ+VOKPqldXktsVgYwKPeK
         /38J2E28nQig1q53uIa3Ug2maU0Mt/38e2RD5wO4egr0G6kYw3X4gnroRfE2pmHogOhB
         8/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xya4N6V99R7wqs6ZB8AIcG0kln00FcHSqxn/UQPegiI=;
        b=mzgud2MQje3R8G4fFE9qRMDOlE50Xe6bnKXjITJQkilY0UDC9tdTz5x39n7C6QoKy1
         /3wsKfGFoiXw3GCpFm8HZeGkoA3jMGUwEjfAL1s/bliZrQNd/13MqXcppMHjHl0CRPMv
         xUhK+M5pAE+NXQNjrNQEQvtbVc5HiyF70XWHAWTweqs8rNj4BvJD1+BENvCXEuElLMqh
         CLg82kwZbg+H10ExhLXZNZgKd0beNdmvci94ZpX9WKG4x8j+OlyCtqjEUxhXxuGK/LzI
         Jqhgwggtkz9rpQhKjMG2K7pn36Os4i43xiUBliYIbsxKL2fMDfOFQ7KaVhVzbJC5JW2w
         jeJA==
X-Gm-Message-State: AO0yUKX9GQqXMccJdpuobKXosBSpi4kUvgCpgZZI8Uv3JPfdxyMUiCGa
        12ydszToPc1yg3+uLVUoGtT2wom8ASP2+okI
X-Google-Smtp-Source: AK7set9+F319gWN9LYU+7iuxl9Jcf1eXJx0wdcHhLh+ez5xkj5LQywaE0O0LpQTkdbn1KdAjU7rXgw==
X-Received: by 2002:a50:f690:0:b0:4aa:cc30:b858 with SMTP id d16-20020a50f690000000b004aacc30b858mr2817345edn.7.1676385482814;
        Tue, 14 Feb 2023 06:38:02 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/12] interconnect: qcom: Sort kerneldoc entries
Date:   Tue, 14 Feb 2023 15:37:11 +0100
Message-Id: <20230214143720.2416762-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
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
2.39.1

