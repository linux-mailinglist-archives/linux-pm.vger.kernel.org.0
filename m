Return-Path: <linux-pm+bounces-3606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AA84DEB0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC64E1C23B21
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABB73172;
	Thu,  8 Feb 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnZep+P1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04271B32
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389473; cv=none; b=fvN0RtmbgKF6MrEsRp1Legw4rlqQX+aCozhSna1M6wqoo/WfPuSI+Foe4fsM6RJm4GSsjIUGjnd1shyFXE1EEHI4pD09sCV/BdaRlifV3W4vOfZCksmo80nC1ZUtpEt9TlK0iIV2CihkQfr6DxNYqrVOixOrVsqRmpFGvPKd+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389473; c=relaxed/simple;
	bh=xJfnEJ+zVsCbj3Czpg60LPhMDPo5+HXP6lXubKlhf+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtV0OfFgVBDDad1ppVXuxJL00VvZBnoJZTZgJwHLYFWD8ovGwkGnamvzrvVCqU9Qcup6UhSWvgwx5FoL53BRgCunPdQBK36dqQHzVO2ytKdGIdtzEsc39YLMx22Csl2y1n1sZhOaDa7jMXUvD/sOnkfjIMkQLdLeGS46vme/gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnZep+P1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4102f273c46so6450665e9.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2024 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389469; x=1707994269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkWzwIjo/uZaIYjgKgDNcnhcc1cwlKLdvZXvoZJLBm8=;
        b=WnZep+P1F4+Nsn24SCC7jw8PnKUaajsse5HmxzZGZUM6Ye058QFnSXydVHVWcUkFax
         oZhe5S/sPfWSN6QKYmUtDnBQIZJnEs4Z4f5kWGxSWSYvyfFyqCx/sF6w4NL4AsObpgJ+
         wMvRChH86mLXAsEQkayxx8GYVc7DXOiad3/aDRH06NA/S6BAB7GIdCv2ZF6046n+d2CP
         XeGzLpH434DX3b6Gq6/NnY38f69jBjBCsL9ndwZUhPlYZNaTOTtwdpE5S1GORK1BgHZr
         eQwT3O9zc9xG4FncJbSRIn3D/UiEGo0zwPq/pqN+sFd3L1a0VnS0dXHbmEs4oZxwfQgn
         l79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389469; x=1707994269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkWzwIjo/uZaIYjgKgDNcnhcc1cwlKLdvZXvoZJLBm8=;
        b=AF/1vpLc6nyr8LkPUweHTio8UDF45JlIn4dpW6I5Wb+xPwzivEdEtIqaYaeDflveGL
         Oq9cTVQSDayWv+GiegNfxCbTMoSh12yq6ijwGFzyJPE0rPyNSzgvO7SAKhGvOZz43oSE
         z0RFsVlPwUNIC3RzkUHZkiLQB41fnu1gXxt1X+lZCZEd4uNcm1uAy/aBHH2r2FwchMTm
         VkJQNno9ARS0kKUekuS9J1A0Ya30tSQuFiZp+DMKarOZ4YoK713fi982nQfVsnKM+41G
         xYFaFoNDgMA4Dq8i7VwNCYbfsCbh4GEMpx9UY9IMVA/eOCfQs0Nnfj1tsawp+H8FMGq8
         7Wxg==
X-Forwarded-Encrypted: i=1; AJvYcCVho2t3PMX0IKd0BnD0Q47VWh7jNel9CBEYXNyBNpQG5+JON0neo90GIBMAKOLZ3DEfJASENoKBZ0/e6ipTR5UbITZx+nSiH5M=
X-Gm-Message-State: AOJu0YzLqQC+V96Pl7P1HPY+xf8kXRbCC1jMjYgh9jEDRpewutMjTmoc
	s+cnxXU7MBW1VrRNjvqB292Z0yJ6bflgiG3k/hvtG1JTU3iamZZIHv+5iGCh2xM=
X-Google-Smtp-Source: AGHT+IEDQm5VMj88QgMa7T2443WaR0z1L0cupYZAj6nJd5Y/yuIH6Y5K3aV/K/rbrptqrKJPbyMfpw==
X-Received: by 2002:adf:a3d0:0:b0:33b:2100:3a44 with SMTP id m16-20020adfa3d0000000b0033b21003a44mr5785649wrb.39.1707389469321;
        Thu, 08 Feb 2024 02:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXdJz84ovdU6pVqpNw60wd7HVwL15lYcM+n6oKgtk++P2/cWs0wiEm4kCDeoSC295ABHv6ze6F0PqI/Vog2Kl9f5nws8pWwqCTIDOdU3oqLsabsMlEJt3WF7y93IGweLBiR6AAK3/44S/b9d9jJwhVUl0Gwp1olFjo978YBfnrMyvovgy4r9By/4HqInf/JKChViz9WnRTL4m5SbOAmlSP1O+CicgzP78T8B9TiCk/JRJ8
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d69c1000000b0033b4719eb6esm3308283wrw.27.2024.02.08.02.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] interconnect: qcom: x1e80100: constify pointer to qcom_icc_bcm
Date: Thu,  8 Feb 2024 11:50:56 +0100
Message-Id: <20240208105056.128448-7-krzysztof.kozlowski@linaro.org>
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

Pointers to struct qcom_icc_bcm are const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/x1e80100.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 281295a9a077..99824675ee3f 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1542,7 +1542,7 @@ static struct qcom_icc_bcm bcm_sn4 = {
 	.nodes = { &qnm_usb_anoc },
 };
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
@@ -1730,7 +1730,7 @@ static const struct qcom_icc_desc x1e80100_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
@@ -1871,7 +1871,7 @@ static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
 	.num_bcms = ARRAY_SIZE(pcie_north_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *pcie_south_anoc_bcms[] = {
+static struct qcom_icc_bcm * const pcie_south_anoc_bcms[] = {
 };
 
 static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
@@ -1890,7 +1890,7 @@ static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
 	.num_bcms = ARRAY_SIZE(pcie_south_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn2,
 	&bcm_sn3,
@@ -1928,7 +1928,7 @@ static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
 	.num_bcms = ARRAY_SIZE(usb_center_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *usb_north_anoc_bcms[] = {
+static struct qcom_icc_bcm * const usb_north_anoc_bcms[] = {
 };
 
 static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
@@ -1944,7 +1944,7 @@ static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
 	.num_bcms = ARRAY_SIZE(usb_north_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *usb_south_anoc_bcms[] = {
+static struct qcom_icc_bcm * const usb_south_anoc_bcms[] = {
 };
 
 static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
-- 
2.34.1


