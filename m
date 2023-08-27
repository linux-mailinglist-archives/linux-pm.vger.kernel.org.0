Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5B789D7B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjH0LvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjH0Lur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5093CC0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50087d47d4dso3700801e87.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137039; x=1693741839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE7HOe0pcemwQjf6HadDywbH9N0H3cGYSXkFuYxT2Qk=;
        b=shSk0f0FHs/9hv48+jI6S+O+GL1A2N0XfyOsF0BKvw2XRUECnHATfhqyxlOGAILHTG
         TdXxwufhz4wW3drK9QQoccPaM6dt/b4s0H2kUaYGqjlViDg+kPJEN8XHd4JApbPlGHnN
         bKtWRRL9Hqb/udg2WEB05f0PAmh5o0+DDuW9NgS8hQgNA4t4fEXX3fkwsVlf8ubBkhOg
         r/L+a3Mr1LIQ+jZL02r/mnaK0q/7Lg/qvg+GxUeTsLmcFliHM267Uk9CgeCdtSrpKn1t
         q6RTc1uDKEkMBq7oALwzET/rDbDIyWWjAXzLlpWBFphdxLVxvvMei8WtIJjHECp/HZCE
         k0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137039; x=1693741839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE7HOe0pcemwQjf6HadDywbH9N0H3cGYSXkFuYxT2Qk=;
        b=kR6F462jtUyxxTnrNxSlRDJB3Z8Dao1vcSUap6VawEnbptZgRrq6f6112NzGUtQeqd
         tFzxEqJtg+LpZsUf8VUrrF0BjpHn60Njq5LM5KDZzb07fufTgjEY+T1n1xRwSFRxAlGS
         QnOjDlrwOjFE9ns/p3Lh90Bj06Pxmi2crQVytDf2yjx+D8Ci4guqRTLCMtaVqYxaoypO
         IFm5YPidIjtsHgr3TVkFYVVGX13RgrXc5nc3QypDei10B8o8ypiWZUduInQfRC27QpuM
         eRUhb9WCFjc7SbF1RImNd2mbGg+AezfhvQVMhZTCr0PqhOsbZbdb5be46DfwV1MIyOHZ
         QhkA==
X-Gm-Message-State: AOJu0YzuoOqx8ov/290WHQ5Ohd/Di6yJ2oCbXejWfgSRFfGo4D7KsKat
        Lv4peZJ5Da/S9vJrlSa3/5fPVA==
X-Google-Smtp-Source: AGHT+IEPJHYwp4cS/Ene382b2GGakTS+bBTqFA1XKuPxc0KSNbgoOKH7eGQQvy0xVSJaTV5xSgVjXQ==
X-Received: by 2002:a19:7617:0:b0:4fd:fd97:a77b with SMTP id c23-20020a197617000000b004fdfd97a77bmr15120494lff.50.1693137038977;
        Sun, 27 Aug 2023 04:50:38 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 05/23] interconnect: icc-clk: add support for scaling using OPP
Date:   Sun, 27 Aug 2023 14:50:15 +0300
Message-Id: <20230827115033.935089-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sometimes it might be required to scale the clock using the OPP
framework (e.g. to scale regulators following the required clock rate).
Extend the interconnec-clk framework to handle OPP case in addition to
scaling the clock.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/icc-clk.c   | 13 +++++++++++--
 include/linux/interconnect-clk.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index d787f2ea36d9..45ffb068979d 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -7,10 +7,13 @@
 #include <linux/device.h>
 #include <linux/interconnect-clk.h>
 #include <linux/interconnect-provider.h>
+#include <linux/pm_opp.h>
 
 struct icc_clk_node {
+	struct device *dev;
 	struct clk *clk;
 	bool enabled;
+	bool opp;
 };
 
 struct icc_clk_provider {
@@ -25,12 +28,16 @@ struct icc_clk_provider {
 static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct icc_clk_node *qn = src->data;
+	unsigned long rate = icc_units_to_bps(src->peak_bw);
 	int ret;
 
 	if (!qn || !qn->clk)
 		return 0;
 
-	if (!src->peak_bw) {
+	if (qn->opp)
+		return dev_pm_opp_set_rate(qn->dev, rate);
+
+	if (!rate) {
 		if (qn->enabled)
 			clk_disable_unprepare(qn->clk);
 		qn->enabled = false;
@@ -45,7 +52,7 @@ static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
 		qn->enabled = true;
 	}
 
-	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
+	return clk_set_rate(qn->clk, rate);
 }
 
 static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
@@ -106,7 +113,9 @@ struct icc_provider *icc_clk_register(struct device *dev,
 	icc_provider_init(provider);
 
 	for (i = 0, j = 0; i < num_clocks; i++) {
+		qp->clocks[i].dev = dev;
 		qp->clocks[i].clk = data[i].clk;
+		qp->clocks[i].opp = data[i].opp;
 
 		node = icc_node_create(first_id + j);
 		if (IS_ERR(node)) {
diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
index 0cd80112bea5..c695e5099901 100644
--- a/include/linux/interconnect-clk.h
+++ b/include/linux/interconnect-clk.h
@@ -11,6 +11,7 @@ struct device;
 struct icc_clk_data {
 	struct clk *clk;
 	const char *name;
+	bool opp;
 };
 
 struct icc_provider *icc_clk_register(struct device *dev,
-- 
2.39.2

