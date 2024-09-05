Return-Path: <linux-pm+bounces-13706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C217296DDB8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9228C75D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFDA7F7FC;
	Thu,  5 Sep 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4hurzOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959A757FC
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549402; cv=none; b=JnjjHYASyHB0u7b0FKQYhek7AunIwJr11h4LbdTN9AoVc5wFVx54/vyiAinfwGB6XdxNV05HOhzqfUv36wvS5Uvu1e/S2uWeXJ9T7LkkUoU8NftKI3O1LOFK8es8JLa1RP6OMTTOJ9PmFNEUQF3Km99uWjZ0qtMTgwUXaIRrkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549402; c=relaxed/simple;
	bh=ekPdpG7oyzJtXPp+xFvsL02Ww7Tof9pw8p/Ac8jNKvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9VVM8lLfGdmwcS6knScQIxDrQZjjRTNGwKSF51FOCPll/te2+ZwTEJjY6PgCvf/X2muYf7sPbvZWx6mXw7AVuy4zfMgR+CElKQ9Aq1FiKartIOZ9kyhXx9epGsu9ZYazrFdqJ5DitcWWJDgcW0WsE3W6bQL1ngWlWq/aNkBfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4hurzOO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbc8d9455so1176385e9.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725549399; x=1726154199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbqQMJHY0wP1Gv+M3FnecbwVctkR8rJv1ZT1Z1xP6vc=;
        b=V4hurzOOG0jmrI3N7imHNPugDOKpqWArtBgEqnWVjGRC8w1tcTaEbjfXMrLxgdnjMv
         clHxMGkjY7BnuW9W6b3VRsf09yaMJHsWkcX/oTSbDe3hxw4c5hH1aagf2BhbV64dyhoS
         jgbQOn7iHYywxxfrzR9O4uoSXUeEA5M8WdKYJPHOZfCRJRZaogntbAbHGGi35o9fZYKm
         bzgDzVb78RlTqkCTSyibQF7hHTRh7B8nhkwuC+oi6d/3eyi0p1FwVCRzFqzY9LLHf1UF
         NZ3rWHWYvYRvXZKLbRXW2YLzuROWMy7k5KdRPZatIe4WteGVl9bu+VjTGxOdEjlNOZA2
         5o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549399; x=1726154199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbqQMJHY0wP1Gv+M3FnecbwVctkR8rJv1ZT1Z1xP6vc=;
        b=p4wukr5VwQ4uZ3d4nZj9kJ7EmcdyGS0nfQwDdsTm9IcOWlsCXx6lpGFDAx5AJZYdDW
         Ss5ig2w6ZQa+fH2lGCNPX6q+muSd/1WmbU/mbdjwGvb/RrIYT71urMqX3TLscUocBXRM
         7D5FOObZD3pDNopjF57ahvF/NTOugJVVQ/2AH1dzb9/125nap0KAoNq/blK+OLRq0d3d
         OSlbME9OZFWBdyC7kD8GMlKvZcdrKYpgGiY+WYHNl7uxqTgQ/SeKlmGrSk45PgN7Hhn/
         NKmwir8A/1vKrd3zQ6At8um1cJanv1C25/iJ3iMKAcCwnQDqW8mLKB5ZdPI5+l8n5/nS
         lgKg==
X-Forwarded-Encrypted: i=1; AJvYcCUiRbq4z5ggOdvc5Uih68j+zbAzZ6erw/Q9oY3iQnleH6TijHA4Zgn7gXUyFD0MIvQZG6C8tBDlgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/V3EjSS/sg3cJAX4VvcqkbBT3ACiCjYP8KZtxFrwBPkNGZIC
	887hTBtnerHu63lE8DYaR5cGGWyfJFeks5fSoO1+GmKNnvPQ2JlR+08o8CDHNL8=
X-Google-Smtp-Source: AGHT+IGrqnC4Fav20HZ0B43mlW3Q7hCc6eUOmNpGzWD39vmPmtHqiCHTNhSqc6PSx7LNERIQuu47nw==
X-Received: by 2002:a05:600c:3b21:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42bbb0a2ed9mr82336185e9.0.1725549398958;
        Thu, 05 Sep 2024 08:16:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf15b9b1sm195072195e9.10.2024.09.05.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:16:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] interconnect: qcom: msm8937: constify pointer to qcom_icc_node
Date: Thu,  5 Sep 2024 17:16:36 +0200
Message-ID: <20240905151636.280065-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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
 drivers/interconnect/qcom/msm8937.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8937.c b/drivers/interconnect/qcom/msm8937.c
index 052b14c28ef8..d9f8ba69b329 100644
--- a/drivers/interconnect/qcom/msm8937.c
+++ b/drivers/interconnect/qcom/msm8937.c
@@ -1175,7 +1175,7 @@ static struct qcom_icc_node slv_lpass = {
 	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
-static struct qcom_icc_node *msm8937_bimc_nodes[] = {
+static struct qcom_icc_node * const msm8937_bimc_nodes[] = {
 	[MAS_APPS_PROC] = &mas_apps_proc,
 	[MAS_OXILI] = &mas_oxili,
 	[MAS_SNOC_BIMC_0] = &mas_snoc_bimc_0,
@@ -1204,7 +1204,7 @@ static const struct qcom_icc_desc msm8937_bimc = {
 	.ab_coeff = 154,
 };
 
-static struct qcom_icc_node *msm8937_pcnoc_nodes[] = {
+static struct qcom_icc_node * const msm8937_pcnoc_nodes[] = {
 	[MAS_SPDM] = &mas_spdm,
 	[MAS_BLSP_1] = &mas_blsp_1,
 	[MAS_BLSP_2] = &mas_blsp_2,
@@ -1268,7 +1268,7 @@ static const struct qcom_icc_desc msm8937_pcnoc = {
 	.regmap_cfg = &msm8937_pcnoc_regmap_config,
 };
 
-static struct qcom_icc_node *msm8937_snoc_nodes[] = {
+static struct qcom_icc_node * const msm8937_snoc_nodes[] = {
 	[MAS_QDSS_BAM] = &mas_qdss_bam,
 	[MAS_BIMC_SNOC] = &mas_bimc_snoc,
 	[MAS_PCNOC_SNOC] = &mas_pcnoc_snoc,
@@ -1304,7 +1304,7 @@ static const struct qcom_icc_desc msm8937_snoc = {
 	.qos_offset = 0x7000,
 };
 
-static struct qcom_icc_node *msm8937_snoc_mm_nodes[] = {
+static struct qcom_icc_node * const msm8937_snoc_mm_nodes[] = {
 	[MAS_JPEG] = &mas_jpeg,
 	[MAS_MDP] = &mas_mdp,
 	[MAS_VENUS] = &mas_venus,
-- 
2.43.0


