Return-Path: <linux-pm+bounces-8827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCF90177A
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CCB20EE1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB457C9C;
	Sun,  9 Jun 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABcuWkEb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719755C29;
	Sun,  9 Jun 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957309; cv=none; b=ioXBzWeQxSLDEmFnsicgOFI86evUaVP8bHsG88YPdSUmg3jNkiH99CJCLzsAIx+UEiQkco/EGNRCFKYMqSv7Q52X+K3ETAKyFtyX+jIhlmpPXx/Hn/2udfVa625gGkKDehxK1rl/Sx8pHDjHWci3kSIyUUu//5asFJHNFUsHl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957309; c=relaxed/simple;
	bh=f/MWTHna41N+m8Wn2onK20Tl7PJEkpPFvxTr2WP4e4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiFyaLFQ/YqhsPf7AbFxD1QPZOCZENGdm/m8UKKb37Wprd2ydnDXapio8hgPrEtiuH9vRvi7y2o4Cl8bKRZmyadapw4126Smy+yiyRO4DYQbxbJCizH4Z932H86M7YDg3kM2KeCHcJYEENeRJjWV3etPvUnSWP8t2Im7BqYVjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABcuWkEb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaea28868dso26760761fa.3;
        Sun, 09 Jun 2024 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957305; x=1718562105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCBOXlxAW6upddldnr67f5IFSYPd/pFRqdVbEJi1GYc=;
        b=ABcuWkEbxvtnEjxJyZkfeZzTjKtYj7rw4+PpHQoqD9aLOsQLVqUuBr6nlM6Ynfeg/L
         o0Zkvl8mkyIMmjmku/Mq8Kb6QHFktwGloF1xIe2bcMTCal6Bicco+sAujTGckx5nfmzm
         52nqcSrDdcqJt3xcgK9Zqq4UStYam2MByJqub6Rj0lifgsYYq8ufe2xO7CYCkNZWhTNt
         +B9XscElos6Wf+v0dl1vny/tfjA7ss+DrctiRApvJgAwAkidzMpnqABjzHwOFUfIgrSS
         e6wW4izXZmSWex9PiW99R16udMLzy+RAvgU4aFzy8XFjXxEaRWUqU/adDMw57eIMLoBD
         SsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957305; x=1718562105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCBOXlxAW6upddldnr67f5IFSYPd/pFRqdVbEJi1GYc=;
        b=q49wnCNYu5JqcXNqXzm7qFsLvZPer3ESwjPTRiBWJYr+2z01VkSlLHgBrWiqARz60S
         a/SqzqnzzJk5/oBi5ZyuY0Q+dWhNAOxn9vv4KtOxBmC72oAqhTkDbGX7CpyFhcgw7iJ2
         i/1ZVSdarsrd5RRe/IRU9vdLMNTasYQ7939d6z6jYoyBAR1v50LLuB0qTys3+XEhd1/7
         oMvEL0SZAcDPaEO7xGtAfZqRDGT6F0clLfdpuem4SF3XYqCkSy4m2gYpTIgsAgikfPV2
         oZ1Tbo3uJiF60611qLsQeNxPA7KI5C90UUWOGw68hUL26zFxGbS3Gh62+91M4aOC11fE
         HFzA==
X-Forwarded-Encrypted: i=1; AJvYcCVMjA10Wh/Ksi7ioch8mcIPMOB/Wgz8m4IZrCLuwbkt4H1IoG70La5IieKSQKGl3VLjjmFJZdVq1NUp1ADHu69hkXIRaKS1tHygW20QOuHaK1HKj1N+pqcJhWNLL9UGfZKQLkE/KPx6AgXGnc/eD3/4UVbcVTrW2j5vTPk7BaXbdVAzywrQ67AAeeCHOSN90mgz+Q6L+epCqRcr37YaORPj7w==
X-Gm-Message-State: AOJu0YxR12q6j09OpGQYUwW3oQFbpLw1EcBuL9RJXUtTn2WvVAR6tlzM
	pA9uRf/jIv82o+7LeRB0FCTebViJuBxim932V0YfJukaC+Pc1EmdkpsNjkxr
X-Google-Smtp-Source: AGHT+IFtjLblw6xgI0MyRtm6az8wi4JLU273QHrzWh7VUVSlInRZRTZeRYIJOdJdlIPs+OJLyPxPjQ==
X-Received: by 2002:a2e:9149:0:b0:2ea:ea79:4fa4 with SMTP id 38308e7fff4ca-2eaea7951a2mr46258431fa.30.1717957304493;
        Sun, 09 Jun 2024 11:21:44 -0700 (PDT)
Received: from localhost.localdomain (bza83.neoplus.adsl.tpnet.pl. [83.30.46.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd5a63bf2sm6679841fa.33.2024.06.09.11.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:21:43 -0700 (PDT)
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
Subject: [PATCH 5/7] interconnect: qcom: qcs404: Introduce AP-owned nodes
Date: Sun,  9 Jun 2024 20:20:58 +0200
Message-Id: <20240609182112.13032-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182112.13032-1-a39.skl@gmail.com>
References: <20240609182112.13032-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When driver was first sent it seems ap_owned nodes were not available,
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
2.45.1


