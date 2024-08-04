Return-Path: <linux-pm+bounces-11883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE5946C68
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 07:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C61B21A03
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 05:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61008225D9;
	Sun,  4 Aug 2024 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoYMb2ir"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8514A96
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750030; cv=none; b=X3niLP5m5DfnOHXmUH0Tp8+wvYuFn9cBX2AYcjuUWbFC2SVGIuDAl29b2qjiqLCo06Kg6rcSbuQ20FIDpkWqsUDav0KHkTy6fGPb+qtnP4d4aZsVlE2uExBH4oWfH2/7DjEe1fYJZ1yzoFrLPliYLOBGnI8mkOpw3M8D6YTvGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750030; c=relaxed/simple;
	bh=V2ZoMG0XQ7V5BO7EN50H81+c0HsVA7ayIuEkYqIPZQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s88RNAU1rBT1tePzf6yjUc6B/HYWqtNtEmNvaAS0j3P9YqQBVrWZluaJvimJnHk+oWY6HX9NDFVJpPqGKcUrCwAsvqOVK60QczF0JsOo2/QS7W83Tyn/LAjPY5/sXsBgovPeDjBRtQ4cBuB61bEATyj1ePT4OnpbRpn0uskWb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AoYMb2ir; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so11072942a12.1
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2024 22:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722750026; x=1723354826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiZnALWAQxF8iYVD1tb/bB08Yu0cJ6IHSObEO/DdoVE=;
        b=AoYMb2irAMhRg3m4uOr7m1NinecoTGoujn2f9YTIwscdvwbWohvM30VoS3YopBdzmy
         lHwG1WOa8HpLhm0dv+Z7iPqZmVvSd2BL7wXpe5i759bKgMcQEk+bKKBqTene8+kXRfhN
         HNKYyopmf6qlXYTOUY8kKiHE734OuZqSORAm/L+LKum00Sn4nRIKx2h8QGwJ2CzV79Kd
         1kQQ5pL293Ir6xU2dbL0Ei1evt0JsPdxfcOl7X4nT8fZD5vdPwEKLpaJldIyDpnjyhYo
         5iFEvjaX6Wdt4XAhxVWJra5x5k7UVbH2a5XhXKCbJcinbE7RKK0FKLrm2uytD4Pf6C6O
         iGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722750026; x=1723354826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiZnALWAQxF8iYVD1tb/bB08Yu0cJ6IHSObEO/DdoVE=;
        b=OGrb81yeZp+GWMA9xNR07vqkDnlkLoFNyouixIgsE/8Hq9592KT8SXBVNrBwur5IYK
         QHnsY0kOzbX7cvldMO1nfsmJwNbAdotyTCdWKghQrBtyfBsagZwxI1xBf6kpgA67gjRu
         bbpe550cCqaRnjalXUrAOZRZlezkkCgsCOPTt8o8cDW5epnfqNKwXB2atyO9xkuCvE3i
         /D7vY25aflvxNVLhGy1JeNL/18JlC2y3H0yiOuf7P1oit2z+qv9yn+PWkLWSZrgdKK75
         NRrgpqXxIfuYkhIyUxgDEfWLdR0whImvv057rn0E+zc1pklKC1Wp8OmWHaZQ6usoQZ8D
         718g==
X-Forwarded-Encrypted: i=1; AJvYcCV3nCHE8UVl3un1of0tfXB7ZGZNVv/Jl9sgWmeWmAYjzd+aqRECWaxK2hdm1ZjXvwv24FrMox52FZuWBZUxy2WzMQ10d4q+aJU=
X-Gm-Message-State: AOJu0YxdYpS1P8LWRDaRYNow5y2lWXhd5n7AdjP2qldAW2PTYvEq1nFT
	XOf6wAbRZwhoyoN1hGVz/iUUQ/pnt/Cih/A57bH4eMJG8llyJlkcgRWvwvo/fiE=
X-Google-Smtp-Source: AGHT+IFvfS/OgcbVrrYsEWO4JXW+fzZSh1xCZ71TmWnyRNpi6mH/DWeqN076lOEnJTaUEwR4OV6ixQ==
X-Received: by 2002:a17:907:3f8b:b0:a7a:9954:1fc1 with SMTP id a640c23a62f3a-a7dc4ea981cmr559390966b.24.1722750026376;
        Sat, 03 Aug 2024 22:40:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm292248466b.34.2024.08.03.22.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 22:40:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 04 Aug 2024 08:40:09 +0300
Subject: [PATCH 05/11] interconnect: qcom: sm8450: drop DISP nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-sm8350-fixes-v1-5-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7277;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=V2ZoMG0XQ7V5BO7EN50H81+c0HsVA7ayIuEkYqIPZQc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrxQ+0RdFIXikZu6YJ0gSar4zzgFVTzMIkQJ4W
 AbO6Ud9B/mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq8UPgAKCRCLPIo+Aiko
 1XBiB/41xzyh7/aKJoyKuLUdDakg2wC5+CZIw9wg05uFFdgtKNpXuKR2fY0/e9o/w1APgDN3pKK
 Joy9zkuMNGqg5nu9Hwoce1pry//4nj19uSs7lVp9GCtzTLA8xVA4KYRYGUMUExTgwpWeHIu+CMr
 z0p5MoNFZGtImsz7X1zv3vhnQhPP85zy7Y3hmgi6pj5GWghhwJHyFUo9guUSRro6gK0PnKc924Q
 uTZedEc6w7NmZc+bXnTlMXQe8royY5p6qpgymADstzag3KAuWss/Sbg2rSLLQrj63wpe6eAB31g
 4QWxMDrqDHnhPERb+X9jbFLk8t7jFvAub6aP9Z0Te/tyCWPl
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The msm-5.x kernels have additional display RSC and separate display BCM
voter. Since upstream kernel doesn't yet provide display RSC, we end up
duplicating several nodes, which can result in incorrect votes being
cast. Drop *_DISP nodes.

Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 145 -------------------------------------
 drivers/interconnect/qcom/sm8450.h |  12 ---
 2 files changed, 157 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index b3cd0087377c..1c61e606915f 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -580,60 +580,6 @@ static struct qcom_icc_node xm_gic = {
 	.links = { SM8450_SLAVE_SNOC_GEM_NOC_GC },
 };
 
-static struct qcom_icc_node qnm_mnoc_hf_disp = {
-	.name = "qnm_mnoc_hf_disp",
-	.id = SM8450_MASTER_MNOC_HF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node qnm_mnoc_sf_disp = {
-	.name = "qnm_mnoc_sf_disp",
-	.id = SM8450_MASTER_MNOC_SF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node qnm_pcie_disp = {
-	.name = "qnm_pcie_disp",
-	.id = SM8450_MASTER_ANOC_PCIE_GEM_NOC_DISP,
-	.channels = 1,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC_DISP },
-};
-
-static struct qcom_icc_node llcc_mc_disp = {
-	.name = "llcc_mc_disp",
-	.id = SM8450_MASTER_LLCC_DISP,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_EBI1_DISP },
-};
-
-static struct qcom_icc_node qnm_mdp_disp = {
-	.name = "qnm_mdp_disp",
-	.id = SM8450_MASTER_MDP_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_HF_MEM_NOC_DISP },
-};
-
-static struct qcom_icc_node qnm_rot_disp = {
-	.name = "qnm_rot_disp",
-	.id = SM8450_MASTER_ROTATOR_DISP,
-	.channels = 1,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC_DISP },
-};
-
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
 	.id = SM8450_SLAVE_A1NOC_SNOC,
@@ -1302,41 +1248,6 @@ static struct qcom_icc_node srvc_snoc = {
 	.num_links = 0,
 };
 
-static struct qcom_icc_node qns_llcc_disp = {
-	.name = "qns_llcc_disp",
-	.id = SM8450_SLAVE_LLCC_DISP,
-	.channels = 4,
-	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_LLCC_DISP },
-};
-
-static struct qcom_icc_node ebi_disp = {
-	.name = "ebi_disp",
-	.id = SM8450_SLAVE_EBI1_DISP,
-	.channels = 4,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
-static struct qcom_icc_node qns_mem_noc_hf_disp = {
-	.name = "qns_mem_noc_hf_disp",
-	.id = SM8450_SLAVE_MNOC_HF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_MNOC_HF_MEM_NOC_DISP },
-};
-
-static struct qcom_icc_node qns_mem_noc_sf_disp = {
-	.name = "qns_mem_noc_sf_disp",
-	.id = SM8450_SLAVE_MNOC_SF_MEM_NOC_DISP,
-	.channels = 2,
-	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_MNOC_SF_MEM_NOC_DISP },
-};
-
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = 0x8,
@@ -1498,46 +1409,6 @@ static struct qcom_icc_bcm bcm_sn7 = {
 	.nodes = { &qns_pcie_mem_noc },
 };
 
-static struct qcom_icc_bcm bcm_acv_disp = {
-	.name = "ACV",
-	.enable_mask = 0x1,
-	.num_nodes = 1,
-	.nodes = { &ebi_disp },
-};
-
-static struct qcom_icc_bcm bcm_mc0_disp = {
-	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_disp },
-};
-
-static struct qcom_icc_bcm bcm_mm0_disp = {
-	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf_disp },
-};
-
-static struct qcom_icc_bcm bcm_mm1_disp = {
-	.name = "MM1",
-	.enable_mask = 0x1,
-	.num_nodes = 3,
-	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
-		   &qns_mem_noc_sf_disp },
-};
-
-static struct qcom_icc_bcm bcm_sh0_disp = {
-	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_disp },
-};
-
-static struct qcom_icc_bcm bcm_sh1_disp = {
-	.name = "SH1",
-	.enable_mask = 0x1,
-	.num_nodes = 1,
-	.nodes = { &qnm_pcie_disp },
-};
-
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 };
 
@@ -1680,8 +1551,6 @@ static const struct qcom_icc_desc sm8450_config_noc = {
 static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh1,
-	&bcm_sh0_disp,
-	&bcm_sh1_disp,
 };
 
 static struct qcom_icc_node * const gem_noc_nodes[] = {
@@ -1699,10 +1568,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
 	[SLAVE_LLCC] = &qns_llcc,
 	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
-	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
-	[MASTER_MNOC_SF_MEM_NOC_DISP] = &qnm_mnoc_sf_disp,
-	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
-	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
 };
 
 static const struct qcom_icc_desc sm8450_gem_noc = {
@@ -1737,15 +1602,11 @@ static const struct qcom_icc_desc sm8450_lpass_ag_noc = {
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
-	&bcm_acv_disp,
-	&bcm_mc0_disp,
 };
 
 static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[MASTER_LLCC] = &llcc_mc,
 	[SLAVE_EBI1] = &ebi,
-	[MASTER_LLCC_DISP] = &llcc_mc_disp,
-	[SLAVE_EBI1_DISP] = &ebi_disp,
 };
 
 static const struct qcom_icc_desc sm8450_mc_virt = {
@@ -1758,8 +1619,6 @@ static const struct qcom_icc_desc sm8450_mc_virt = {
 static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
-	&bcm_mm0_disp,
-	&bcm_mm1_disp,
 };
 
 static struct qcom_icc_node * const mmss_noc_nodes[] = {
@@ -1777,10 +1636,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
 	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
-	[MASTER_MDP_DISP] = &qnm_mdp_disp,
-	[MASTER_ROTATOR_DISP] = &qnm_rot_disp,
-	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
-	[SLAVE_MNOC_SF_MEM_NOC_DISP] = &qns_mem_noc_sf_disp,
 };
 
 static const struct qcom_icc_desc sm8450_mmss_noc = {
diff --git a/drivers/interconnect/qcom/sm8450.h b/drivers/interconnect/qcom/sm8450.h
index a5790ec6767b..e1e91ed3f77e 100644
--- a/drivers/interconnect/qcom/sm8450.h
+++ b/drivers/interconnect/qcom/sm8450.h
@@ -153,17 +153,5 @@
 #define SM8450_SLAVE_PCIE_1				590
 #define SM8450_SLAVE_QDSS_STM				591
 #define SM8450_SLAVE_TCU				592
-#define SM8450_MASTER_LLCC_DISP				1000
-#define SM8450_MASTER_MDP_DISP				1001
-#define SM8450_MASTER_MDP0_DISP				SM8450_MASTER_MDP_DISP
-#define SM8450_MASTER_MDP1_DISP				SM8450_MASTER_MDP_DISP
-#define SM8450_MASTER_MNOC_HF_MEM_NOC_DISP		1002
-#define SM8450_MASTER_MNOC_SF_MEM_NOC_DISP		1003
-#define SM8450_MASTER_ANOC_PCIE_GEM_NOC_DISP		1004
-#define SM8450_MASTER_ROTATOR_DISP			1005
-#define SM8450_SLAVE_EBI1_DISP				1512
-#define SM8450_SLAVE_LLCC_DISP				1513
-#define SM8450_SLAVE_MNOC_HF_MEM_NOC_DISP		1514
-#define SM8450_SLAVE_MNOC_SF_MEM_NOC_DISP		1515
 
 #endif

-- 
2.39.2


