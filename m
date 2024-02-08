Return-Path: <linux-pm+bounces-3601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31184DEA3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6257C1F23C23
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5F6EB6D;
	Thu,  8 Feb 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kixrAS9f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9406DCFB
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389465; cv=none; b=FjERNVsIg+6GRWkmhxM3kfhqV3/UyXhKk/LZroe9oTvY8YzJyQHj/9KKpWloBQ9Ad17RDRIzbWifwyXHVF/kD3mxTZwSfMmzTXbIA7x6FA7+XHJ8DZC5rATM4NSUIxUlyr5wG0LQQQLamGo3oESiY5dNPe/dWsXy/xD1P952DA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389465; c=relaxed/simple;
	bh=Wdi61ffUtMGjl+wRYrk2Fw25htDwrtpUXzDFtcSRNCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naaro7EElPsosCxSkTMxes+Ic2FUmXybgsGz/vjJIZ1MOgPosxIWkJXR6iTu6AXKvxxg97Xut+PxuZNmNiZG9w4+PPZFw3k4kNEuOo6+knhEKR2ug/pacBg2hm9e+6uRNblRy81DXZ2v7x920z67I7fdy2mNK61NTxU+XgFk9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kixrAS9f; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4101fc00832so10222385e9.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2024 02:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389462; x=1707994262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYDFfFg7RSvtFP7frlyaf+j5dtEyxVJJ7Vm/zJ75QMc=;
        b=kixrAS9fPXiGfoBGR41sFgNLyMLhR/m8kSI2p/pl/2Mc7CmlLFQBSBYVLgjrOdLyGf
         jvnanPsJELx19bZygFDRnPbPkkQHpS8qq581Vb2xnlOI3otQVLRHSB9wm4MnD+Sg4uGR
         RtP5eHY+6aReWd0GhYZmS1zOP6g9f/iIR+xuKFOGc4Y7mrdzl+x7ajaTAeY13CwSL30m
         YsytAn/ceithySg8fRCLWe1umlCL11OhF27SGrdwVQWFX+guLyeHKXLA4l3k96GsloxV
         NOks2fk1i02lrk3TTqMsGmzlD1JMWutbS44bjAKUpTqSyb+EUyFnzM61+5l4W25SEVks
         O/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389462; x=1707994262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYDFfFg7RSvtFP7frlyaf+j5dtEyxVJJ7Vm/zJ75QMc=;
        b=pc3qctBH+83mBMvhU6wcDbkJOYBiGliPr5qwn8ihqHDKU0JMH0ZL4kUZ8XManJlHRV
         BrPAlJyCHoDV7Iy2im+0ndzOO5s0ql4k6giaN6DwDsbl9ZiNT4hQPMa/CkrYTgXCwrhV
         SLHvc+4UJMcJdERZdGnG9g0R+odfKji3buJTx94mI4AXZg0ScbRpI43LJxBuHEokt9Hm
         ikPdjweH/P+xHWvaIHbvqlkeTWoYy/5a/BSAnYr5SP8K8ROVYN209X9WEYETlnUZ8SX4
         6COBTZOiI+U25KzdWTqD6H33YJIcCOalnWoek1db+ZcY+3ItMBEeL3zjzWxNulIqicb0
         f+0Q==
X-Gm-Message-State: AOJu0Yy+3PcLyzkMr9nNS0ipLG0g+/xxSozonrDD8a6CthWQdFmtHPrI
	Msv5D+d4Gx+iuPvfOeOGT/t9tAFvCDs7jIyTz7hEYtZvZPMB8P4/0rbwGVKisis=
X-Google-Smtp-Source: AGHT+IHKriCvV01tTYAqtfDV/l8y7JvTkry++OGa2oTiiUHzAdwdMFOLSuTJk8zLwawmpE93lr6sCw==
X-Received: by 2002:a05:6000:1246:b0:33b:2fba:1eab with SMTP id j6-20020a056000124600b0033b2fba1eabmr4969578wrx.30.1707389462054;
        Thu, 08 Feb 2024 02:51:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURHwTUXhL4gN2IpLIx2PZR+X7r+y7iDOfWT8GJBOeX27YM0XlUWhhBcOiG0xSAanvnDAaAmn2gnSd45WqNrBwRIj9MybfztiDMTt/Rj04LgG0golMzvFnV4lzPq+re/Yb+cnbuquq2h147Y67SqU50zTZ4R0Zj+hyAgWMYewCbHpnzZtrm6ew5AxHYWzOc3k8o5JdZtIcd+Y4NaaPf+2TCX8c2yg9A2wwYOxFvOr02BhUt
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d69c1000000b0033b4719eb6esm3308283wrw.27.2024.02.08.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] interconnect: qcom: msm8909: constify pointer to qcom_icc_node
Date: Thu,  8 Feb 2024 11:50:51 +0100
Message-Id: <20240208105056.128448-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointers to struct qcom_icc_node are const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/msm8909.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8909.c b/drivers/interconnect/qcom/msm8909.c
index 23b1a818d774..0d0cd7282f5b 100644
--- a/drivers/interconnect/qcom/msm8909.c
+++ b/drivers/interconnect/qcom/msm8909.c
@@ -1167,7 +1167,7 @@ static struct qcom_icc_node slv_cats_1 = {
 	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
-static struct qcom_icc_node *msm8909_bimc_nodes[] = {
+static struct qcom_icc_node * const msm8909_bimc_nodes[] = {
 	[MAS_APPS_PROC] = &mas_apps_proc,
 	[MAS_OXILI] = &mas_oxili,
 	[MAS_SNOC_BIMC_0] = &mas_snoc_bimc_0,
@@ -1196,7 +1196,7 @@ static const struct qcom_icc_desc msm8909_bimc = {
 	.ab_coeff = 154,
 };
 
-static struct qcom_icc_node *msm8909_pcnoc_nodes[] = {
+static struct qcom_icc_node * const msm8909_pcnoc_nodes[] = {
 	[MAS_AUDIO] = &mas_audio,
 	[MAS_SPDM] = &mas_spdm,
 	[MAS_DEHR] = &mas_dehr,
@@ -1263,7 +1263,7 @@ static const struct qcom_icc_desc msm8909_pcnoc = {
 	.qos_offset = 0x7000,
 };
 
-static struct qcom_icc_node *msm8909_snoc_nodes[] = {
+static struct qcom_icc_node * const msm8909_snoc_nodes[] = {
 	[MAS_QDSS_BAM] = &mas_qdss_bam,
 	[MAS_BIMC_SNOC] = &mas_bimc_snoc,
 	[MAS_MDP] = &mas_mdp,
-- 
2.34.1


