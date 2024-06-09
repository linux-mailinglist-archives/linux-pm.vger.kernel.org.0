Return-Path: <linux-pm+bounces-8828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CED90177D
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB6CB20CFC
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48D6BFCA;
	Sun,  9 Jun 2024 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edjMIEDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A25C8FC;
	Sun,  9 Jun 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957311; cv=none; b=CZNCh3NUvWjhGK7N6BDt1VFDpEG+KRKcfzwpuhLwD/Q3Txyc/ErdFgpy+hXnHV74q0hg0LNlFg/eJzcaVQA/IAGcgSqfbOnbU5cwA2/H5HmgygAlZmBPFE8BEd6By2TghEk/YDK45cY96KTkDXM23SCdo/Kf4nx3QyouekPB5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957311; c=relaxed/simple;
	bh=49NIrx6iEwmU7QlEqnIzslRrjtAjcvfG52aOoP/2WZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFTzEdiPl+33JgX2t1TYe2hRHgFUVrt5EKi6f/muPpbO08qS20ywiuaiIf81iuzmaowYlBqY6tTdjAAxr26BT3S+uB221kVmT3LyO1DG12Y+aKoI8idtHd8cNQyBqSF4sr2lx98ECUwHraSkLLlZnlf8Mba21w8ms06l8dBPYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edjMIEDS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so5013861fa.3;
        Sun, 09 Jun 2024 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957308; x=1718562108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gZSh9n4VoihrqMJsLyugkkv17qMI/zEJG5hw5YFK4o=;
        b=edjMIEDSKvSZRSr45u+Q3+wQab8/Ss0/jxoTpymeMUyLLOOLc6ZRbOYlDilNjvZd6C
         Kj5vUoRcNkDh7LPwwbGrUZoMGgBc/9+gBuyDF6LuuW5PlArD2Bcmy/pnTz3FmAOSOoyu
         2R42gwQs1/FWauU9hy/l6lxMwrWz0KugkkN3GD+qYLHZIJcKvlw4mqZpVMqJZvh3jhl4
         m2Q3+j56mPb6uwAnHKalYmhZOdHt46GMBPOTYOqkYXaZVMjRGKJG6QK6jn4hqLxePaCo
         g3NMrl9/8liM/7j7+1WUQTrLkhtaCQUj8D2XBX/53tjkBf0NPUfB8QrB5Sh0w1mWJQjm
         R45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957308; x=1718562108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gZSh9n4VoihrqMJsLyugkkv17qMI/zEJG5hw5YFK4o=;
        b=khATeflfF6XDkwn/sv4TTLGAWI939N7NkPL4fAl4BI7IZOr9PUmgn7P3Vs6dixb87k
         u/ro8l4DodfURvRDJFuqqugjykBDJUiHeyslvtWJhzrqPACNtisptfUZqZ8cg24/ui1R
         3dWViXeUXsnjERixqjf8Con7xENkilQ8IEm55p8V4NZbR916c94U/USEpNp1OzmB3+Yv
         wJCejCnI3XWlzHkJiorzVaZA/Lxlh6lOdrTN/jILjCWpD1XgI6NaYD08WcegC4NclYOA
         bmUDEkjrwyORgjxyLZQfqp1TsOhSIuemNt/j3eSHIWkvQaeZvoJSffFZZXxO6bQ+TGKx
         F5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUSuptMfX+mygn3s9hyWYQNxOaFVqdolUNmNYpfNgVVxFT4bwcVhe+QoQyUaEYMvQwGZ/OkWlbruIf1rStCCp4bpZ1+rUM7lZ89utuokBeeJOCYAufArAvHSDEjOC5yJWKINyJXq9vJeaGkOTpsWMCqF8AA1yj4XiM+ybH/FjiLgC5gTBD2H4lGOvTZ4iLdlYYA4eiRnP6VWz3WaXBWA69abA==
X-Gm-Message-State: AOJu0Yyu9oXR8YPi6mamGhr9+aSdhh5Lxj3RVjCxFuUl+tgiy7hnl3T6
	iMw5yJx1Y+qBa0IU/smWJ8+6v0uzPSVYgwk/W6SqPxhOE/PWgxUJWYYr/6DK
X-Google-Smtp-Source: AGHT+IERZlSV4D0f/oG/OJ2ZZFssWujtbyloMDYynbbXgLuaU9nKXHMhKGis4O2ichQBIZJI9lWFog==
X-Received: by 2002:a2e:bc09:0:b0:2eb:dd68:b522 with SMTP id 38308e7fff4ca-2ebdd68b898mr20280901fa.41.1717957307656;
        Sun, 09 Jun 2024 11:21:47 -0700 (PDT)
Received: from localhost.localdomain (bza83.neoplus.adsl.tpnet.pl. [83.30.46.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd5a63bf2sm6679841fa.33.2024.06.09.11.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:21:47 -0700 (PDT)
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
Subject: [PATCH 6/7] interconnect: qcom: qcs404: Add regmaps and more bus descriptions
Date: Sun,  9 Jun 2024 20:20:59 +0200
Message-Id: <20240609182112.13032-7-a39.skl@gmail.com>
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

Currently we are lacking descriptions of regmaps and buses,
provide them.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/interconnect/qcom/qcs404.c | 41 +++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 91b2ccc56a33..f9b508a56588 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -1067,10 +1067,22 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 	[SLAVE_BIMC_SNOC] = &slv_bimc_snoc,
 };
 
+static const struct regmap_config qcs404_bimc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x80000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs404_bimc = {
-	.bus_clk_desc = &bimc_clk,
+	.type = QCOM_ICC_BIMC,
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
+	.regmap_cfg = &qcs404_bimc_regmap_config,
+	.qos_offset = 0x8000,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
@@ -1122,10 +1134,22 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 	[SLAVE_PCNOC_SNOC] = &slv_pcnoc_snoc,
 };
 
+static const struct regmap_config qcs404_pcnoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs404_pcnoc = {
-	.bus_clk_desc = &bus_0_clk,
+	.type = QCOM_ICC_NOC,
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
+	.qos_offset = 0x7000,
+	.keep_alive = true,
+	.regmap_cfg = &qcs404_pcnoc_regmap_config,
 };
 
 static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
@@ -1151,10 +1175,21 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 	[SLAVE_LPASS] = &slv_lpass,
 };
 
+static const struct regmap_config qcs404_snoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x23080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs404_snoc = {
-	.bus_clk_desc = &bus_1_clk,
+	.type = QCOM_ICC_NOC,
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
+	.qos_offset = 0x11000,
+	.regmap_cfg = &qcs404_snoc_regmap_config,
 };
 
 
-- 
2.45.1


