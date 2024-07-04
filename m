Return-Path: <linux-pm+bounces-10636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEEE927E2B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBDE1C21461
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C181448E2;
	Thu,  4 Jul 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSAlYj9b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF2144304;
	Thu,  4 Jul 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123457; cv=none; b=W8uEWf4+c3kikB881I/6ntShdzcOguExgfEqHcoiWWeTExmAkaxJmf64vpbAABvQ7VZBaLZbrZgTuvwCuOlYY2TTaQgoaTrYkMRtIJF9aR5XuWEywkpUHNgL39hWJ6DAH9nfbA5Ilqa6+OKX9rqspQ40KwVixUFRSMX1lxESxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123457; c=relaxed/simple;
	bh=SnUV0K6qDtAT+Y6HCNIjj11XaFFz3qH7FTJvFlmmeX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qL+A7QKCV94xrW9+Ttb2s0tZcDlqRH28jm/8fj6zK98oUv4tjuQ7ZlO9hvC3V45ty8pk2AQGkp3YdkcCbef0q1WdG0YCb5fEMmD6ZnY61zdHPIXi6Vy4HiCBp1vPsGk06OBSO/aX81UdayhnEy01WbDyzB4R4EImjyMf8l9Tuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSAlYj9b; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso1279000a12.2;
        Thu, 04 Jul 2024 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123453; x=1720728253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp7Zij3IvEhV+gNM9kJxQcnJkETPmzFIqYEJgaLeYcI=;
        b=jSAlYj9bgksdC4fohwW8deAPMpG01bThaxlc88xif4tLpujwjrsT2nsbMYcd5+61dt
         JHKIHWQ2SO/8D6lUZ5I7yWLmpefvWuDbVNm7+titLMSfLJvo1d2GPLcLQ1ATUf9j/oWo
         BCOczEHS/CkbBX6gAsZ3Bm0WgSr1MT82EirJ0RnloqzqBtwlnnjrOZ/9TB+tmZ8k8HYC
         072Mnyt5OQkHXH/RNmMBxJYhULn/EaN24yWmmp1bIPUJ74EoLji3qRrVIFXTMw0xWG2w
         kZNTsE5xYVeItDECOoVtokXzEE+G4yGzzjr1lFLdXrSd3u6p8W1CS2aD5wfMcc9Gaf+7
         9ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123453; x=1720728253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp7Zij3IvEhV+gNM9kJxQcnJkETPmzFIqYEJgaLeYcI=;
        b=wNusHH55HBTAQNB39t5tgDf6V2emCD3ydyorZv3Qawm3Uz8UUPnOhQA2uH1VaEqpCC
         ez/u9xjjFnzmXo/nNj5Bn3/v/EPDUOlaUYKVZUfpNN4sMjzFgX8/MIUN2guBARoLIOew
         6nU9wpk3h9sCkW9L0EjFhyZR/6JHwUhVOKXAu3B6d+bXe7bJ+0nNnGQFVk28cjDU2kd1
         NTNV0/P/Z7p4haOuIKvEHdjqputd2E+i7a9e7qDBZgHsJzOrwqN+H96q5nRjBU8D7a+m
         Ca/gS96jHOyeLbqFr+PLF3YhzlO8zSd2wPsiUF/kM27AMxQlf2hgGfZSPaJqvlW0Y3yw
         uhdg==
X-Forwarded-Encrypted: i=1; AJvYcCVA1xeYcrNimCV8AN5+TgFnmPiFHawEBtXZwLG7G6Piy1+X9xsWZy5RNLoRFp4dryh13YdmoJtikQcf0y/oaVaOhNfMqq66LVQ53qQtKnlD762RCwCmdxSvFYBvN0+XvOlG029e6b3CzSlryYd97Wt4KKvaxtsVUGqT2NghN5KA7ehxBNa143H8dl8R7a2if340XlQfRuyRobYA2de0bKewSQ==
X-Gm-Message-State: AOJu0Yx4/mj9GXv7ukHKoMxVV9O1gs0UF1I0xq/4rTdjWS8Hh99t8Ymp
	x3YAWPMMaYOUPSBJ6Ims/ipBwlBy+J1lrp+OZ+rSj6eHmKBbA1mVYANzKsut
X-Google-Smtp-Source: AGHT+IEXGNpZZNU6JHd4axF9RN0sN5Iytd42cfslEe9J4VdGV4DAOs8uWrxWUmjKQYf4NDn1H+Gocw==
X-Received: by 2002:a05:6402:280d:b0:57c:c2b6:176d with SMTP id 4fb4d7f45d1cf-58e5c826881mr1888441a12.32.1720123453107;
        Thu, 04 Jul 2024 13:04:13 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:04:12 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] interconnect: qcom: qcs404: Mark AP-owned nodes as such
Date: Thu,  4 Jul 2024 22:02:28 +0200
Message-Id: <20240704200327.8583-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704200327.8583-1-a39.skl@gmail.com>
References: <20240704200327.8583-1-a39.skl@gmail.com>
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


