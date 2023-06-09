Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305372A45C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFIUT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFIUTo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 16:19:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EC30F2
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 13:19:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f642a24555so2791035e87.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341961; x=1688933961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEM3N0iLIlvYLepw85JsPFibfyRzMkZ98OPjRwmkvbs=;
        b=n1invhpMx1ccyojiJAoc/FICf8qzZg8AvL9wLKjV9deTw4HRMh45dXjnAVoSy1Y61/
         E742sFH9M/rXwqA2ei32FgwEEwDmIGETQaBI7raKSlmLlsHfqKKwkUaT1w39+KXR/LQO
         uAPAGu6bfCxGUNCSzG2o1vfhuHbYlmo51FD/9AYk0oW3DcqoRXTC9CtZtMQUDyJUUijI
         H3LC52CBKTNXkOKPOFiW6TYgrf+bgWGZGpc2Z8B3C1mAiqplfwhZgahsxCRvDb+7KBtK
         g4ou98GIZakBFD2bKrp5oVrXdXJX5eI8aEl7qkjeITXqgocayABX8W0yZBEskCaVkU9n
         QIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341961; x=1688933961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEM3N0iLIlvYLepw85JsPFibfyRzMkZ98OPjRwmkvbs=;
        b=DHOFuwkfmwpjb1Os4ETnPrvBeP3CibA/y44NdoPkN4+f2TPmNpD6j0K+P8uhSK5Jz0
         KJMAdIz5UFRYCS0hlgVq6saCudj0G2b/Z8yG7lcGhjOOz5oe7/UumnOg6cmDfEd6YNvG
         AUb8RVS/RMMmr7sV18BBuihihKUoYrGOKSEH+E836MW4K6qqlCIZL7tvgfVfZ+c5GeWS
         HRo5rX3ezLo0E+RI7CPRJYb0+UA/rI8opIlChd52AsO6XwL68Xyx6IwI0GBLyVa+iE+b
         xKZPoX4UUa/+FSLbcNkKvwoy2i9Pbor6/cOLuJwZTcaPDaF5VhYMPXaCRyuM1ApKL1DN
         OYFA==
X-Gm-Message-State: AC+VfDwnv0I2zxj72AXAZC3LgspD7d2/i1OShSJ3kzafvmG6rc8wiPqK
        wxHv4Qf/XQhpUFo7/SBqrPijpQ4YBo9iIzDX80o=
X-Google-Smtp-Source: ACHHUZ4E9CRrlu8/QHiIFgZN4bMEzOQJhgvO+8HfM3+sDZXij/QAJiGSGa9cV/kLDVjg0QcqqTGZPw==
X-Received: by 2002:a19:9106:0:b0:4f3:a99c:fbbe with SMTP id t6-20020a199106000000b004f3a99cfbbemr1417540lfd.14.1686341961573;
        Fri, 09 Jun 2023 13:19:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:10 +0200
Subject: [PATCH v2 05/22] interconnect: qcom: icc-rpm: Introduce keep_alive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-5-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=3661;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=g6kESh9vFn5cUExPwamnhleED6tFd+S7dtFe11cmEVE=;
 b=N0GZFd1D6lY98LSYi6TjN77PBSwUCLkJMaQklefTtlImuAIykZ8MVuwn2levHNt36jVkfRPX+
 KTMOHPcIZCCD27uzyhX1OwB4BEm+ERzRFSS+A8pteqBB3lGg//fxlRt
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

The downstream kernel employs the concept of "keeping the bus alive"
by voting for the minimum (XO/19.2MHz) rate at all times on certain
(well, most) buses. This is a very important thing to have, as if we
either have a lackluster/wrong DT that doesn't specify a (high enough)
vote on a certain bus, we may lose access to the entire bus altogether.
This is very apparent when we only start introducing interconnect
support on a given platform and haven't yet introduced voting on all
peripherals.

The same can happen if we only have a single driver casting a vote on
a certain bus and that driver exits/crashes/suspends.

The keepalive vote is limited to the ACTIVE bucket, as keeping a
permanent vote on the SLEEP one could prevent the platform from properly
entering low power mode states.

Introduce the very same concept, with a slight twist: the vendor
kernel checks whether the rate is zero before setting the minimum
vote, but that's rather silly, as in doing so we're at the mercy
of CCF. Instead, explicitly clamp the rates to always be >= 19.2 MHz
for providers with keep_alive=true.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 10 ++++++++++
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6acc7686ed38..863e8ba1daa2 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -50,6 +50,8 @@
 #define NOC_QOS_MODE_FIXED_VAL		0x0
 #define NOC_QOS_MODE_BYPASS_VAL		0x2
 
+#define ICC_BUS_CLK_MIN_RATE		19200000ULL
+
 static int qcom_icc_set_qnoc_qos(struct icc_node *src)
 {
 	struct icc_provider *provider = src->provider;
@@ -380,6 +382,13 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		do_div(rate, src_qn->buswidth);
 		rate = min_t(u64, rate, LONG_MAX);
 
+		/*
+		 * Downstream checks whether the requested rate is zero, but it makes little sense
+		 * to vote for a value that's below the lower threshold, so let's not do so.
+		 */
+		if (bucket == QCOM_ICC_BUCKET_WAKE && qp->keep_alive)
+			rate = max(ICC_BUS_CLK_MIN_RATE, rate);
+
 		if (qp->bus_clk_rate[i] == rate)
 			continue;
 
@@ -453,6 +462,7 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < qp->num_bus_clks; i++)
 		qp->bus_clks[i].id = bus_clocks[i];
 
+	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index ee705edf19dd..d2c04c400cad 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -33,6 +33,7 @@ enum qcom_icc_type {
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @intf_clks: a clk_bulk_data array of interface clocks
+ * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
@@ -45,6 +46,7 @@ struct qcom_icc_provider {
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
 	struct clk_bulk_data *intf_clks;
+	bool keep_alive;
 	bool is_on;
 };
 
@@ -102,6 +104,7 @@ struct qcom_icc_desc {
 	const char * const *bus_clocks;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
+	bool keep_alive;
 	bool no_clk_scaling;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;

-- 
2.41.0

