Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4760D69671D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjBNOim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjBNOib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:38:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A792B616
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id n20so2705289edy.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z33GhR/weoldfPdNFE3B9Pq21vIvD0pApq29v3a6yUs=;
        b=ySmYQIamqXyQQfy3KF5JJo0QF9heP7EPzSm33XZvcY0zurxbqNpafTiodrXwZJ5Un3
         cTdSvwCm3Dt0QcrvvunDa6uEEGaOxHULrDexGmPLQdJZiaQmkQVrad7Y6x6ApKvhtaXm
         h+dXLgBx4NsrGwZTNoQPLK4YZiOHEZ6LREWIbEFgxiNVlGkwX279n5UlVuYBxt5MdA45
         7YUfU8augui2eVwpzvGzVN7KlEWmogok3N3MwrETTutz9PNk5ag4PHxjKKpiaEXpyYZl
         56gB8EKMPk7hbcPwxHvDTh8bveEKbORbjPAdVAeUyOi6QOglUL8dv9iLntvYL/zhon9G
         A5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z33GhR/weoldfPdNFE3B9Pq21vIvD0pApq29v3a6yUs=;
        b=zAMuJeFxvh5vOg+m1nWEwgMAoTx0LFYZ7fM5qPXn3i8rVcuf67xEOqAFPByEcYsUCv
         DdBeQH/fzbIIhDEFcjkZoJY+gEYKpfABSibWn7x7DIomAPxbQTXSwK0VzhizEakqE/FD
         5xjrYmd8uWGUvlkF4cQaIEVFaU+3xcf//er9Im85Lo7mWjlPqS8sBNB9AP2ew8t7RlFi
         iqe/Q8tqmzZqlsTQKTk4CslT0zUwuc0JE/YJ0UlTcLdZN/nCvCpsXsISRD3PQ+Pz7P68
         m6K/ThzwQxZBFAlboXqMm4mtIbte+z29c8n0B+jz0Fmb6SlZBhj+Yj1O6CVMTVfAlIXD
         /66A==
X-Gm-Message-State: AO0yUKUKU32lGvSawt6H78rrbOstKYZzx91i3A8krz/lnh1UxFkgIYwe
        y27UDYIhOOmAG00MHpjd85lCFQ==
X-Google-Smtp-Source: AK7set80uxf5pBfbb6lc75dlj4UDVpPHnvDxery5QD784awKrXQ28xl7ODeSqSqe2+QkaJ3B1/QA+w==
X-Received: by 2002:a50:9508:0:b0:4ab:4bf9:a10f with SMTP id u8-20020a509508000000b004ab4bf9a10fmr2741874eda.30.1676385493381;
        Tue, 14 Feb 2023 06:38:13 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] interconnect: qcom: icc-rpm: Introduce keep_alive
Date:   Tue, 14 Feb 2023 15:37:19 +0100
Message-Id: <20230214143720.2416762-12-konrad.dybcio@linaro.org>
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

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 10 ++++++++++
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index c1954584d6f0..88cad71688ec 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -51,6 +51,8 @@
 #define NOC_QOS_MODE_FIXED_VAL		0x0
 #define NOC_QOS_MODE_BYPASS_VAL		0x2
 
+#define ICC_BUS_CLK_MIN_RATE		19200000ULL
+
 static int qcom_icc_set_qnoc_qos(struct icc_node *src, u64 max_bw)
 {
 	struct icc_provider *provider = src->provider;
@@ -397,6 +399,13 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		do_div(rate, src_qn->buswidth);
 		rate = min_t(u64, rate, LONG_MAX);
 
+		/*
+		 * Downstream checks whether the requested rate is zero, but it makes little sense
+		 * to vote for a value that's below the lower threshold, so let's not do so.
+		 */
+		if (bucket == QCOM_ICC_BUCKET_WAKE && qp->keep_alive)
+			qp->bus_clk_rate[i] = max(ICC_BUS_CLK_MIN_RATE, qp->bus_clk_rate[i]);
+
 		if (qp->bus_clk_rate[i] == rate)
 			continue;
 
@@ -482,6 +491,7 @@ int qnoc_probe(struct platform_device *pdev)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_bus_clks = cd_num;
 
+	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 9dd631964b8c..77e263b93c27 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -29,6 +29,7 @@ enum qcom_icc_type {
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
+ * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @intf_clks: the clk_bulk_data table of interface clocks
  */
@@ -40,6 +41,7 @@ struct qcom_icc_provider {
 	struct regmap *regmap;
 	unsigned int qos_offset;
 	u64 bus_clk_rate[2];
+	bool keep_alive;
 	struct clk_bulk_data bus_clks[2];
 	struct clk_bulk_data intf_clks[];
 };
@@ -100,6 +102,7 @@ struct qcom_icc_desc {
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool has_bus_pd;
+	bool keep_alive;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
-- 
2.39.1

