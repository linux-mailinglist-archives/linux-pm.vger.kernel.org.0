Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F4715B8D
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjE3KVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjE3KUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 06:20:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E19194
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4592972e87.2
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442020; x=1688034020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oOyAKKv2aOi4dKdwVFK9Ufi2xXYxVx7Z2+Xnm7A04A=;
        b=QK2WdGImMQjZWoIlY2/1FYYpgv/kGn+DHmSGuw8I0SKFn3eAMP+7yHCdSbia+x5jag
         GgnBkWlvuuvXdqVPd3+uy0+LRNwRVM2l6UV80mHRKsB5PjG59fanRBYnBQSU2KKaed7B
         ICEponkcYeWglhOaH2VaFkhkDSfpFKWhlNBVQOL5l10bD9UvQ+aa7r0HnP8OjW6/wEXk
         nG85wGqBVUkqex0a16fKQzoPxBkmH4Dfy/RbqnG3S/dN95hPoyj3K+NmBf3r1FPkmq12
         R22x+WjLfwkmYbgntk/5Q2bn6/yYuVNbcDbjiYrVrAEjEAoWFG0n/DC18NC0lb4RAMDR
         +bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442020; x=1688034020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oOyAKKv2aOi4dKdwVFK9Ufi2xXYxVx7Z2+Xnm7A04A=;
        b=SXp90MI/93jEm3pRcjBZl1uZLpiDqEbb2ZbRF29xEzY5la9CkZ6g4nL5WPlY7AubKc
         a7df3nrXrcgiiDBfmrZnooO+Y8H0lqzjfh3SVapMzRQJ54q1lVfITCrcPHRwmmwmzlxw
         T9heJC3CP4H9+bHsdtuipNt26e3O5VvQJJ3ThmuQTZ5b30rx7AWQ9XwpWsTQUz3XdcGv
         Riek+b/Foh8VfToVHfkL6ZE1bvwT3upw05KhpUc9tmMu4ksYI+CiLXCF+HzKqgzgHiJK
         Tssk964K8i0b5LyVfX+1EaWMNHesUCsuR86pP9mXS63infDDrzNIi9AP7W/zIHCD03kf
         6vxQ==
X-Gm-Message-State: AC+VfDzE4dcJnWHbv6bzG4CMT95Ut9Myc1bpttppciKvOhnGB/84Zd6R
        xib9R4bcnzdHB/Shsm45GvkZFg==
X-Google-Smtp-Source: ACHHUZ7JeQCHDQ4LE8kIc/nYDjeZGqQZOsixQd8CL5/ONOUeZy0cP5muPAfsM5kjKQawzjKV3qXKAA==
X-Received: by 2002:ac2:5303:0:b0:4f3:93d4:2bc7 with SMTP id c3-20020ac25303000000b004f393d42bc7mr556595lfh.36.1685442020786;
        Tue, 30 May 2023 03:20:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:12 +0200
Subject: [PATCH 13/20] interconnect: qcom: qcs404: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-13-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=1230;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T8n09Sxnfaf4a9P8gR8uI0Eqx4cTlCAqOBT58LgHFQo=;
 b=CHJefv1YEpkMoX2ECAe54VJMyXIa8aGNkGU89yAoN5AYy4D/HXF6I0WAi3xDdxRaZkC9C1GW2
 oMhzv/PoNZKAD2Q0FkNrTPdxiZ5HpdHshk0h+KVB5ltezUfEGUutjMD
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 938283ddd0e3..9deb4d81104e 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -984,6 +984,7 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_bimc = {
+	.bus_clk_desc = &bimc_clk,
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
@@ -1038,6 +1039,7 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_pcnoc = {
+	.bus_clk_desc = &bus_0_clk,
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
@@ -1066,6 +1068,7 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_snoc = {
+	.bus_clk_desc = &bus_1_clk,
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };

-- 
2.40.1

