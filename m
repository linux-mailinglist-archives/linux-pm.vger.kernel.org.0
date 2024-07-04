Return-Path: <linux-pm+bounces-10637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC8927E31
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A8928598B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52C144D1F;
	Thu,  4 Jul 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Guzffk88"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A471448FB;
	Thu,  4 Jul 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123460; cv=none; b=JdIrcYHcBzRwncncMnVjzb56S9JG+Wjlmz/rpqafE9EUasbpJSuBCwNvP+6y6C70PeMev0salMbNGr7n8fOxg11W34KGchqSfq7vrEzr84zkTIlZXU4ab0O1R9rk01ghdKX8cLHxDgP7ZjRJ5e3N5U70os6KeuyIE2kOG01OewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123460; c=relaxed/simple;
	bh=Bo+8vwjDQLHQRyezkFe8wTzncFjjp4ATpNyKNZ97028=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLW9OHwKOxW94JCRSbdo72nelleULLQqf8NyzInTSlb7S0+PNcYl5cxM08G3KXihb+VKvprypG2D4VSimcsqnXnPsF5VDRYP81/MgpRrEsSNCh6KMPOqbMe2Qth/n+O4coZX3nnVXRPwzFegji74cOuen1sSdOmI7BfCT8w19FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Guzffk88; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so1273731a12.2;
        Thu, 04 Jul 2024 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123456; x=1720728256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOYoImCISLmjV4V0lw2Fa8ZU/fZdwVwBDAKgyU4Yn7g=;
        b=Guzffk88PfhBlqffjmGCBNP3T5iXul6rmvU7p/7U6ZNj6QBSRe1To2XpjujzDd16AM
         mRtt4od/Bong36/MYroO0YagYA3slXRn0rCH/oZYpehHaYYpfBQmMwcGAEwkS4ZSkump
         s2/dHImIqRkNZw6JIbQ7u1ngFvWQTiV2mceKImnT0kPMg+7PIvUXjCrIfSTZALIMrtxE
         cRnSsMN3xadyvCP3w+GaLilW7qAtTQSFqoPrKGzWOhCjELDQ0hFz0aq1dFQtT5ZoA50E
         fvQ95588Og/sNIIMFxY61iQd6fETPZjPHIWjqCF8zgQPCLCtdqQDkF1Atu7sM6dhU+WM
         N5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123456; x=1720728256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOYoImCISLmjV4V0lw2Fa8ZU/fZdwVwBDAKgyU4Yn7g=;
        b=Z8AbM2XNdAdNAm/qHETzU5rRQMY+lY6s1/IzmXUOrShcHl5v+625faLFquq82FboaY
         KSqOiWZbaflRkLNAAzklCeu55hX6l+ifPEiijTyvS/psn2KTOu4fJLlWIxEwy0K7kME5
         c7vRgzD4bIwRm1Y+gIm4fMr4ytjpXKGSaELMZwwsaPiIT985mLIIArZjdNuxI1smTHCI
         gCqZeslYUwVT90wlL5TCErowN/PWmBeRVMp5A64LEZiIkGEq3tgMlj8CYoq5aQnOAdtB
         uKas53jygMVo4jdalDapUla/58IR9cxUOVUj2ws8YWfau7o7tnw31ny0xGwEDMbdcXjY
         sYEw==
X-Forwarded-Encrypted: i=1; AJvYcCWg9ijSm4kIUwIdLgm149Bm5wyfuNDNaJCr81PE2B/u4DqlpOqQqRYLzgr78xa0B59Pa8OqnMD0Ym9KC/Wo8EYS3mgp6OzkvFGB6JSC77tP6Fp0eGlF26jthrJVcMmTR9Cs+rzS0lBoORzaPCNY7EZ5uqALSNNojP9R/RiUn0eeGxSosvL+5Kq+1FGZ3/1r59KB0U9gwoYyb3htQUzjxRew+g==
X-Gm-Message-State: AOJu0YzIF2esuA9fsGKJe8cLJU5nPU1PGJU65LcKJ4UNwUjgLeeYYkuu
	F/VbDbbJEHg/C+6E2kFD4pNDzNgxtmqWVFqUHoRj5VT2Fjiuoj8VMwC6v4T7
X-Google-Smtp-Source: AGHT+IEQ0epqEPM0MikqeH8aAmHLNJeZQSF5YA/+un5O5FToYugx7qmrNaZT8r38fF7bTjEvyHTKhA==
X-Received: by 2002:a05:6402:4303:b0:58c:6edf:d5d1 with SMTP id 4fb4d7f45d1cf-58e5916d50dmr1803867a12.5.1720123456354;
        Thu, 04 Jul 2024 13:04:16 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:04:15 -0700 (PDT)
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
Subject: [PATCH v2 6/8] interconnect: qcom: qcs404: Add regmaps and more bus descriptions
Date: Thu,  4 Jul 2024 22:02:29 +0200
Message-Id: <20240704200327.8583-7-a39.skl@gmail.com>
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


