Return-Path: <linux-pm+bounces-10847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A401192B54E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CB8B24BEE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C6156236;
	Tue,  9 Jul 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ9oW5BD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE3156863;
	Tue,  9 Jul 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521003; cv=none; b=kOFFib9GxnfSrbCqB62+wPnbWc4MRjoPWuUzqX/P4N7GEw66dsjP/E56gso/WHIO5J2boxApZzqihbeldqSCqFkcNSjYjB6v8RdDfkz51ypkYLsiQRyUro+KjVolg3JKfM+IrK0tUYxN/PTC7FTU+Oa9vX4gegXBcE4uIjZT6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521003; c=relaxed/simple;
	bh=SnUV0K6qDtAT+Y6HCNIjj11XaFFz3qH7FTJvFlmmeX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQg2uU9CUBVGqBHxCp7JbtiNpfRK8t7m/Sv1x9K9PWgd1EzPAP/IKU97cLSl15plzwanhb1OmFt1bewHStCuZ44bdHySjizpS49Li6RTFVD4p8EkZu6RbFGuMm0zqM/JbelYjp/J8d2QBtvkzksaMOGplfM8dlQQKQ1ukNgJG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ9oW5BD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c080b521so548144266b.3;
        Tue, 09 Jul 2024 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720521000; x=1721125800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp7Zij3IvEhV+gNM9kJxQcnJkETPmzFIqYEJgaLeYcI=;
        b=SJ9oW5BD/4LMYnl2m2M6WQY3ibV9WnC6gFva0Fy4Yy/uL+EHbrkfHPcfbYezk8An+l
         0ihrjjTtGXqaQItGf46V20os6Vr5raMAnwDANly80M6SNeMl6s2EmirRfk3/epfVScRu
         ip7kLRCpAi8MC6pmSsiALV5HmCJjeW8YLep27XAAaZ3jWnveGHCSwqMXV9/zhz6nI2JA
         WiuYBRnUJbPHHhMyKTv3NrLBH2W2txxe+ejsK+TGGEk62vkED7qvC18W6OOnthE52nu2
         sfEuTEQFXK2Css6yXhAwAuJ2L5Bqx48alfN+f2pnjsniMqvSlVvnhuCWxkiAkj1KXnvI
         2XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521000; x=1721125800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp7Zij3IvEhV+gNM9kJxQcnJkETPmzFIqYEJgaLeYcI=;
        b=DHV3N8aRgBUw38qa/L0uy1EZ3ykECq9cBhEbd7kCda6oTFsTaHmynbmWzYBHPuzuBO
         WiJ3iy2Wb2ng4CS5mSfVYYJBQyyEomgjfsQflIuU47561Aw88qb35meRoNfZkSz/pPQp
         i0744nm1kmdlqH3NNFnJAarTNm5Ju6rZ95uATf9Sg17Cr1FeRVu+JVxzvQ63xK1MrM9R
         DWEmttJMNFTxqbsFBdEuoYIe3Hlmcrj7iCIxEkOZelbgnHfZnYmvjLEUCaly12OMZ7BN
         gx5GHzZ7qVrhArq30sq0hsKBC6VUWZWfZi1CbUP7VpfhqHcVQix0kg5AGTU0TwAkRsvX
         BGeg==
X-Forwarded-Encrypted: i=1; AJvYcCXQpqRo5/d+4vBDmyF+Qh4uD2jwdI0hTsJntSgXOvp8YL9pGkPCD/onSNwyK8IR2tomG6AqzxfbpmJPi5/PoDbeXbEbFIxUFLlYO1Mf6FT35YslW6uP2MVJOwjFYelENYPiAXUNlp2tRSl0QMrrQ4LO5/abUiqjfULYKOdMQEuSNdIpTg1yvciSqmQQhJD7lQCXiGLtODcqPSeS2UIe8mRlWA==
X-Gm-Message-State: AOJu0Yxafg1J9+u1RX78rYOBsXH/hF3KLyQ0aFoTyzoRhJZ3joOEdOup
	Azjcsg0JsJwN6wbLaioTUwMkpR/R7Lx0B1vZeiLwJirHmHEX6hdRAir2kg==
X-Google-Smtp-Source: AGHT+IGExf5ltcLYaIvktGYoQaXzZgQd73gQX5QwAQYi/NLgmmjLSw6ZNDpH8rtbEnfMK02c/KiuOw==
X-Received: by 2002:a17:906:b0d:b0:a77:d85c:86fa with SMTP id a640c23a62f3a-a780b6889c0mr128804866b.13.1720520999765;
        Tue, 09 Jul 2024 03:29:59 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:29:59 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 5/9] interconnect: qcom: qcs404: Mark AP-owned nodes as such
Date: Tue,  9 Jul 2024 12:22:50 +0200
Message-ID: <20240709102728.15349-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709102728.15349-1-a39.skl@gmail.com>
References: <20240709102728.15349-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When driver was upstreamed it seems ap_owned nodes were not available,
bring them now.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/interconnect/qcom/qcs404.c | 85 ++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 11b49a89c03d..91b2ccc56a33 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -101,6 +101,11 @@ static struct qcom_icc_node mas_apps_proc = {
 	.buswidth = 8,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 0,
 	.num_links = ARRAY_SIZE(mas_apps_proc_links),
 	.links = mas_apps_proc_links,
 };
@@ -116,6 +121,11 @@ static struct qcom_icc_node mas_oxili = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 2,
 	.num_links = ARRAY_SIZE(mas_oxili_links),
 	.links = mas_oxili_links,
 };
@@ -131,6 +141,11 @@ static struct qcom_icc_node mas_mdp = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 1,
+	.qos.qos_port = 4,
 	.num_links = ARRAY_SIZE(mas_mdp_links),
 	.links = mas_mdp_links,
 };
@@ -145,6 +160,10 @@ static struct qcom_icc_node mas_snoc_bimc_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 76,
 	.slv_rpm_id = -1,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 5,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_1_links),
 	.links = mas_snoc_bimc_1_links,
 };
@@ -160,6 +179,11 @@ static struct qcom_icc_node mas_tcu_0 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 2,
+	.qos.qos_port = 6,
 	.num_links = ARRAY_SIZE(mas_tcu_0_links),
 	.links = mas_tcu_0_links,
 };
@@ -174,6 +198,8 @@ static struct qcom_icc_node mas_spdm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(mas_spdm_links),
 	.links = mas_spdm_links,
 };
@@ -231,6 +257,11 @@ static struct qcom_icc_node mas_crypto = {
 	.buswidth = 8,
 	.mas_rpm_id = 23,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 0,
 	.num_links = ARRAY_SIZE(mas_crypto_links),
 	.links = mas_crypto_links,
 };
@@ -287,6 +318,11 @@ static struct qcom_icc_node mas_qpic = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 14,
 	.num_links = ARRAY_SIZE(mas_qpic_links),
 	.links = mas_qpic_links,
 };
@@ -301,6 +337,11 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 1,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
 	.links = mas_qdss_bam_links,
 };
@@ -348,6 +389,11 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 0,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
 	.links = mas_qdss_etr_links,
 };
@@ -363,6 +409,11 @@ static struct qcom_icc_node mas_emac = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 17,
 	.num_links = ARRAY_SIZE(mas_emac_links),
 	.links = mas_emac_links,
 };
@@ -378,6 +429,11 @@ static struct qcom_icc_node mas_pcie = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 8,
 	.num_links = ARRAY_SIZE(mas_pcie_links),
 	.links = mas_pcie_links,
 };
@@ -393,6 +449,11 @@ static struct qcom_icc_node mas_usb3 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 16,
 	.num_links = ARRAY_SIZE(mas_usb3_links),
 	.links = mas_usb3_links,
 };
@@ -491,6 +552,8 @@ static struct qcom_icc_node pcnoc_s_2 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(pcnoc_s_2_links),
 	.links = pcnoc_s_2_links,
 };
@@ -626,6 +689,8 @@ static struct qcom_icc_node qdss_int = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 	.num_links = ARRAY_SIZE(qdss_int_links),
 	.links = qdss_int_links,
 };
@@ -704,6 +769,8 @@ static struct qcom_icc_node slv_spdm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_pdm = {
@@ -752,6 +819,8 @@ static struct qcom_icc_node slv_disp_ss_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_gpu_cfg = {
@@ -760,6 +829,8 @@ static struct qcom_icc_node slv_gpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_blsp_1 = {
@@ -784,6 +855,8 @@ static struct qcom_icc_node slv_pcie = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_ethernet = {
@@ -792,6 +865,8 @@ static struct qcom_icc_node slv_ethernet = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_blsp_2 = {
@@ -816,6 +891,8 @@ static struct qcom_icc_node slv_tcu = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_pmic_arb = {
@@ -894,6 +971,8 @@ static struct qcom_icc_node slv_kpss_ahb = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_wcss = {
@@ -954,6 +1033,8 @@ static struct qcom_icc_node slv_cats_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_cats_1 = {
@@ -962,6 +1043,8 @@ static struct qcom_icc_node slv_cats_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node slv_lpass = {
@@ -970,6 +1053,8 @@ static struct qcom_icc_node slv_lpass = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
 static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
-- 
2.45.2


