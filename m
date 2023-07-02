Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D67744EDE
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGBRnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGBRm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:42:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707BCE6E
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:42:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so54316421fa.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319773; x=1690911773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39CekJt2bg+dTnou8ZXeVeRak2YiAVNMpxW8X6GTBtU=;
        b=SYaLI0sRwYzEXv1YOqBHrHz5jHOXzvMDYIVWjpHumY8xNxwg0rESkWXjs+1bpBsm5w
         MFWPKjo8CIPTQKu9SvQWOHi7Kn9tAbgyoZGU84T/BnlSV3Ya1s+QlJ1pVXS+LzYQPNwC
         0YoXdi/P+8ry5sxfcmSJyv8LjPrRUIwp3m3ztRWCm7dl/jWS3Ql1SQfxxw+QFnXeV4tX
         hTDtELrxeP005G1EX3Owk4nJlswwruLGXGFGbtkyRUOqJT2QXKX/Op+kMQGT9OJr5alE
         KOJounmL+Kbo89ffdRzP6sksOEHTMRwjYoTnkVoprhqwU+h255kvWI4Qmurl+j6okOX7
         A15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319773; x=1690911773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39CekJt2bg+dTnou8ZXeVeRak2YiAVNMpxW8X6GTBtU=;
        b=XD2RyRXWVjLp/DlKfmxbZnTmBNhah9mlHSS1U01GqFZd1qgIs/UdXVJQ0QcnW8REk9
         327AmA8b1gmqVVgkvNs51RmFvDECr6KBVtOYIjHikgtTArTATIGQSD6XBsceP4BpZdt8
         J/qi0FfcIrxIfCo7jBn8RMzmBop6qNq/mZxcBAuaMwv/fJhjQHIPxfVFpA+SaIPedz9c
         MB96JdMcwDleQlfm3jJguw0OBt4E23bB4knLqRORYCfwRwAY2sP327TlVABmNmzfnH7H
         vEnqQIOjfXFT5AjbFO/BxoMCYPBY4cMX3uQCcblUx3CniHK5Pg+z5R3eUZ939BCUTQC0
         +1Dw==
X-Gm-Message-State: ABy/qLaoo6iJRFjZbLYwbBefsixNBrrZYixlqoxqst+FD85oWpdRNszT
        IxFzo/7YtvYdDY8o6yIsQl03pw==
X-Google-Smtp-Source: APBJJlFns2ZlWmvV1ijFsjEvZawVgLE8JsepTypFQwk9MsQcbGqyIUh1LeVAE9vplaO3AyKKCEcGlA==
X-Received: by 2002:a2e:800b:0:b0:2b4:7380:230 with SMTP id j11-20020a2e800b000000b002b473800230mr5268977ljg.13.1688319773490;
        Sun, 02 Jul 2023 10:42:53 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:42:52 -0700 (PDT)
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
Subject: [PATCH v3 06/28] interconnect: icc-clk: add support for scaling using OPP
Date:   Sun,  2 Jul 2023 20:42:24 +0300
Message-Id: <20230702174246.121656-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sometimes it might be required to scale the clock using the OPP
framework (e.g. to scale regulators following the required clock rate).
Extend the interconnec-clk framework to handle OPP case in addition to
scaling the clock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/icc-clk.c   | 13 +++++++++++--
 include/linux/interconnect-clk.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 4d43ebff4257..c7962acdcee7 100644
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

