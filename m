Return-Path: <linux-pm+bounces-10848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A219C92B552
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248EE1F21F3B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058DA155C8C;
	Tue,  9 Jul 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxvCoAmG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA820DE8;
	Tue,  9 Jul 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521029; cv=none; b=N8+eK3Yw3qUPOgvyQ1s2dz3D8js2EDnKQfJAurKi/7KOXnJ0bftzIJqa61cKeiYbtxXNHd21Ef4CclqWffCltVKvg1HP2Rvkw5DAZu+K8xHWi0G/h4rTB8gf3HmDeMk568TXqXa32OPcGcKaTo6jG3ORqx5aaTTYPpTSssIsInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521029; c=relaxed/simple;
	bh=Bo+8vwjDQLHQRyezkFe8wTzncFjjp4ATpNyKNZ97028=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF89nMLtEQ+jujbof6eGH3rocKlarUu6sVhhGx7EcWqt5ePlixugYQd5Yjt7L4r5jD3J2oaXEqX050yNHdWB8L05+3O9Gbds5Cd3ssWoNF+vacsLrkpxcqWvsU980NpGGfa7yzlr/rkZntjKg1qNMIPWp7HXZJDDS9klf27hKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxvCoAmG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso401736a12.0;
        Tue, 09 Jul 2024 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720521026; x=1721125826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOYoImCISLmjV4V0lw2Fa8ZU/fZdwVwBDAKgyU4Yn7g=;
        b=gxvCoAmGyumV+hjpafS0MOZLjAZWptAxMokINX/joBLA/GLHWwZbTQvDgg1yaXExZR
         7jX+gmKAbv9uEDT853D57b6wjWW6T/AFGRE48NUaewkiZ8ivnO6/onklFe+UbWKjFyi/
         kMp1cMuMvRTb2aC44uv/1BvLNnT52yupkLUnKQMbKnIJmMxb1L++BJJ84XbdUivX5dBW
         x0OcE8DNLaxxqdtkhbefN0akr4rD4NuKGy1NNjBEACGhcqyqr3ymNTUZF7XVP0qn4PNq
         jKRj01EChiNX91vehX4SCdV6yEiLbkdVz1bcQ9YTcR44Gzoz6YxhyTYevXCFoBfjBrNV
         gyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521026; x=1721125826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOYoImCISLmjV4V0lw2Fa8ZU/fZdwVwBDAKgyU4Yn7g=;
        b=NPXP+qxhvCG22+dDiMkTLdNP5b1+zi3RihEvYLRjkFq7CiGIGDygMb3cBE3JTqIHY1
         EzRbcqXSrnaGWQ9RZgURVa2gyxLY3qOCSiGsT+JscRYufXmH7eqDa/wvxrtOkIp3HUi8
         2xJ95scI9FqwKbQKlecWN70A8yymQZoO4ylUm9Jp+ZzhlUMmsc+j6Zm7SADcP0nXo+E3
         5T170DjieCNH7zZ7zOO3P81I3PMIwDO1VymYQMNd3dD8EaxihBZQ3hHSqTbQVSgu5N0n
         y5EuKWRPsP0A77OxfRXqz2oKyHw0vdQjnZcROIp/ni7OC+wAwdKGo1fosCfHBCcNuxOJ
         DDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUyWqJ8VjOSeHeqz9o2odatdIBFhyG0q0uDoZQnVcFeNZtH7da1MV4sMZ2zKZL0KLMV8d4VHUsSd5YgPX11kmvcEmvF1neKbMn4aHO22PevJnoM6akhm3KbfOdPRQhNpR9d2OzSillk4mxtAa/cSlMd3rMyl9qv6vLOdPc7TYR5mvfBIs5c/d4k1ISYWivWCTtHSSDreHmKPntOiJ38owX0Fw==
X-Gm-Message-State: AOJu0YxjPUvX5eqFu7BwvlR1AwbKvFCV7IJVuDalFBCveLU6IieyiLCK
	fkQ4ocqy6pNU1GRLt1IInbLWVwelONk6jGJX9kkQKaIIq38AmtERm0cS3g==
X-Google-Smtp-Source: AGHT+IFAVbp5Xhz+Qd9F332Ru+KEdrPyFW17706lzfARFQr/oCIyYBmSzobiJdVge44rwdBy/74mhg==
X-Received: by 2002:a17:907:10c2:b0:a75:2495:a6a3 with SMTP id a640c23a62f3a-a780b89d121mr167496666b.67.1720521026276;
        Tue, 09 Jul 2024 03:30:26 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:30:25 -0700 (PDT)
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
Subject: [PATCH v3 6/9] interconnect: qcom: qcs404: Add regmaps and more bus descriptions
Date: Tue,  9 Jul 2024 12:22:51 +0200
Message-ID: <20240709102728.15349-7-a39.skl@gmail.com>
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

Currently we are lacking descriptions of regmaps, bus clocks
and types of busses, provide them.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/interconnect/qcom/qcs404.c | 42 +++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 91b2ccc56a33..63e9ff223ac4 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 
 #include "icc-rpm.h"
@@ -1067,10 +1068,22 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
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
@@ -1122,10 +1135,22 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
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
@@ -1151,10 +1176,21 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
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
2.45.2


