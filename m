Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF87696705
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjBNOiL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjBNOiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:38:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F052241F5
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w3so10688589edc.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGJSq0Wr4uz9FI0u0GqF9NY+B8XZsAQlpMrzNgb5opk=;
        b=x3LuLpnNBnfsU4LihWq8n2PcnDwSP+CxBmabMAGb5IarPQOFyAPYvq3Xn70Do32byu
         xyefB30eO+cLDPp5hpDBwsB7MdHGFlUm5gbFLgytUlff0zMlP5Ttz5Sq5zY6GWx56XYH
         K54KzbpOTa3DX4hxOVuouAvuo1ODmRv7dmqd2FQt0kVjW57fqH0Q7qJw2KcD2e9I8iJs
         HgtdWMbivg4BeifLRntY7xYv5E0Sqy8mIO3h02jqSlPhCXda0tYwdyMTWPZCAmBxuYEl
         is240G5X0sf2ApZ9JKcjDVxmp+ej/W3yn5hGNAQHQdwRZpkia/UvmTjHS1N3Zi9koly3
         W45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGJSq0Wr4uz9FI0u0GqF9NY+B8XZsAQlpMrzNgb5opk=;
        b=YQtDHpjT6sDxCfDlSyzJfPJJdv8WWKCR4J2nusTtpuyIIZKN+WIBmSG6Pe51QF4fk1
         PvKOQ5TM4IKj8WrfuyetbvMd9arUBL9JpGFunIBErq1qTxOVCPuSsuDKA0Qiv5ZSCvk3
         uEphVzxZm3ad4KNQaJeLFiNYioOK4kGBcIzdtv9Z4w03PGO0MXWKEv22HvNWzf51DewC
         GGip9rO6DvVKkeiEt5l0yUhub0SrNEKNY0TYxYGjVJ9egAaETfVJy6Go6ihozbJyfBqa
         UcC4IkkcVs3GX8SzySq2VwAKb0DS9eVeK3n+62jW6wMXE8pxsJy8aEW4vr/doGymxU9B
         OQFw==
X-Gm-Message-State: AO0yUKW0luRtgtUrMAsL8oUDLnUbzJo1II8heogbQNE5+MRdH9pTA9kp
        jUQEUQ2z15hY+ce58ZEAj/i/Zw==
X-Google-Smtp-Source: AK7set8ttxvC56SA3QdeV2HRvV4e9YxvWA09t2k4mtxTcVKnHV2+MvqsOgTGUp9gizyYkaFiCdzOPA==
X-Received: by 2002:a50:9ea7:0:b0:4ac:bc4e:767 with SMTP id a36-20020a509ea7000000b004acbc4e0767mr2950705edf.5.1676385484127;
        Tue, 14 Feb 2023 06:38:04 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/12] interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
Date:   Tue, 14 Feb 2023 15:37:12 +0100
Message-Id: <20230214143720.2416762-5-konrad.dybcio@linaro.org>
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

Rename the "clocks" (and _names) fields of qcom_icc_desc to
"bus_clocks" in preparation for introducing handling of clocks that
need to be enabled but not voted on with aggregate frequency.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c |  6 +++---
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 drivers/interconnect/qcom/msm8996.c | 12 ++++++------
 drivers/interconnect/qcom/sdm660.c  |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7fcc2d86117b..37a299f4de6a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -441,9 +441,9 @@ int qnoc_probe(struct platform_device *pdev)
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	if (desc->num_clocks) {
-		cds = desc->clocks;
-		cd_num = desc->num_clocks;
+	if (desc->num_bus_clocks) {
+		cds = desc->bus_clocks;
+		cd_num = desc->num_bus_clocks;
 	} else {
 		cds = bus_clocks;
 		cd_num = ARRAY_SIZE(bus_clocks);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 21f440beda86..d6b4c56bf02c 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -91,8 +91,8 @@ struct qcom_icc_node {
 struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
-	const char * const *clocks;
-	size_t num_clocks;
+	const char * const *bus_clocks;
+	size_t num_bus_clocks;
 	bool has_bus_pd;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 25a1a32bc611..69fc50a6fa5c 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1821,8 +1821,8 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a0noc_nodes,
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
-	.clocks = bus_a0noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a0noc_clocks),
+	.bus_clocks = bus_a0noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a0noc_clocks),
 	.has_bus_pd = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
@@ -1866,8 +1866,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.clocks = bus_a2noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.bus_clocks = bus_a2noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2005,8 +2005,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
-	.clocks = bus_mm_clocks,
-	.num_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.bus_clocks = bus_mm_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config
 };
 
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 8d879b0bcabc..a22ba821efbf 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1516,8 +1516,8 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
-	.clocks = bus_a2noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.bus_clocks = bus_a2noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
 };
 
@@ -1659,8 +1659,8 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
-	.clocks = bus_mm_clocks,
-	.num_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.bus_clocks = bus_mm_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
 };
 
-- 
2.39.1

