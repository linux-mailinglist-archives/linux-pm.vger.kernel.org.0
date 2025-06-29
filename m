Return-Path: <linux-pm+bounces-29804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A959AECF2B
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B871896604
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BA238C2F;
	Sun, 29 Jun 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpALvyYa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A1238C20;
	Sun, 29 Jun 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217945; cv=none; b=sMCr9uVHQIIUiTaZjb8rEqHT0oIEmYwA4RX5gReIhu5nb2CIINgXgQ15PqrlvarDHyoI7EM6HwCG+c4lI2IvMJHGlsRqbnqocICePveG57EoMPw+2HjUd9cXeootaqctZe8A5//J3YQlZBfDULFkorurnI1p8i+ciLaS/FxagpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217945; c=relaxed/simple;
	bh=tFhG1J9WX6lkOz2RvO67ATCtV9LPDz6zL613qycQaQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9oL3tdvlX08ls5+EUgVzruAKD7ti6aT6wLumprLC3MiLMBNzbqqiol3SIDn3PTqy3AlZ28eYPR/jY5lbAq9yBX/brUo0qy2/TMX5RwUGHrZ8JewDTSjgWqY20pivIy+0npxgf0vSsIhmzzKseXguOhZ9YgAKTzNc9UZM8iWJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpALvyYa; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a589b7dd5fso71691311cf.0;
        Sun, 29 Jun 2025 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751217942; x=1751822742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBbPPcEdQtei5+NuNnufcyttJ+zLeB0/TIiitwhS+8E=;
        b=FpALvyYar7kx8D+2iFMbwPEbReMpd9kh2OlG7Y+TBcfj5jnEnJ6AJvm9gCzIR240mp
         dj6ovgjj7Nn5eVIGkQMN7IjIEYgOVZW4cEb/E0iURuZmauyHrAd5QqR3D7kvEVO/ggdl
         twARtSM7bHGvR8ekQ5BWnru60o4QHVv0ZXKQCHzrKOp0yDF8T0mqxoo56fG8/0ASLgPb
         8L2Z17KbQ1CPy9zK5l+Jubf7tpPU1rSxgD1+dzhRBTjhGs9a0irxQ3sozABwXgvPs/aC
         wub1/rzanY/R5YfhtC5/iSy3fn0/aCEEcTguiZ4P5wHYZ1QRtEZZmxCsXh6VpKZLm0IY
         PeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751217942; x=1751822742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBbPPcEdQtei5+NuNnufcyttJ+zLeB0/TIiitwhS+8E=;
        b=Iq5sSNbBKnpJAXeuCSDLbDETjH1P2eN8wmznVWrIBxgWhSzz/7chiTHVBlXyCEKPSv
         0QZwjCcB+80fYoTceEBPno21zP6SLRly8w8S7DEhMs1iJ3ackcMW4vetfTRdBysDaUhP
         cSdYd332Z1cr6pYMd+nNR2gTqiY4rRfy6vhbSIig3Jx8JAhOCo2BzTxfQWBAiwKZ9nqu
         IUFDo7m9gl3bTj/Whj3uWUpPrKpp7qNqJsrhejzHb42kHE1qrhGvgQ8KssTHhtpix5M6
         gsS9BkL/1L8lv+qKnZp47CjvZnr/M3jCk5jVnH//akqYCdp408FEpfgmMnHObYl7we+y
         EwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZuG2yV7wd3dDObZ/L4u58fb/E4fAqrGEbhCA5ja53wm7vSQhyeED18Nj1aaj1JdEha/2yrkY41m8=@vger.kernel.org, AJvYcCVpItFB1cvmtchG+BL99RbfJ+UKve5po7GZtw0bj2P1qKExV/VsPk/Yf8MY9vC793/iY7mIB6Rvq6y54jk=@vger.kernel.org, AJvYcCWPfFDaS9C2j01JrYUjt/NEVgH0Ddvl29GqUFYuYiWmmrMjofxFkMx0QtcTU2ZGWSatw/5Se0kNb1ccBIHLpQOTOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypSiF44NyGo4o+qFSXC4um7z+RLpNWCEc2WU4zWZ0x7K3vZ8sr
	bmQo9atxaxHT1Jf0v8zIaX6u2x1HmtyW0LlrNrm7XbyfmSNm3YV7p/oB
X-Gm-Gg: ASbGncsXgRD5fitFzdxl46qs20yaOxoOtdIrhSUG7XA7Uew5/sILglXf2zdnx7ANAtL
	OgAXY3MCxadQ2VTwMbjzOFVW5n1XqExVyPaWD+FdlkscV322p3BkoZlHctMUyM2a/cOAdfTGNWc
	uixmLQdWnhsY1UtYoHBeXQYeqL4NecggSTGnkZv/OJnnykUC9MDTVQEts/CU9fQc6JEciO4s2bH
	bGI0hROoRxfBfFu5H2mgXdEf2Dmr2TPlhiDjPm4LzuTlL6/BV0PhWyjPFRoS82DeW2bRYpS6+gF
	pFxAKkyFRcguRxTWJI1ZjWWbHF6odZr8TaCdyCts08+MEYqf12frgrCIjpuNGpbw5g1FEQmwHjN
	05HU=
X-Google-Smtp-Source: AGHT+IH0oA4OuFF0x2nQSxRW9BOpq3H9adGI3VCEA8SilmvSk/JkXEeS26LmCye5qmOTPQlaP6fQKQ==
X-Received: by 2002:a05:622a:506:b0:4a7:f683:975d with SMTP id d75a77b69052e-4a7fcb3aacbmr184575131cf.49.1751217942253;
        Sun, 29 Jun 2025 10:25:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d7dcsm45549761cf.60.2025.06.29.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 10:25:41 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v7 2/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Sun, 29 Jun 2025 14:25:11 -0300
Message-Id: <20250629172512.14857-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629172512.14857-1-hiagofranco@gmail.com>
References: <20250629172512.14857-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

For the i.MX8X and i.MX8 family SoCs, when the Cortex-M core is powered
up and started by the Cortex-A core using the bootloader (e.g., via the
U-Boot bootaux command), both M-core and Linux run within the same SCFW
(System Controller Firmware) partition. With that, Linux has permission
to control the M-core.

But once the M-core is started by the bootloader, the SCFW automatically
enables its clock and sets the clock rate. If Linux later attempts to
enable the same clock via clk_prepare_enable(), the SCFW returns a
'LOCKED' error, as the clock is already configured by the SCFW. This
causes the probe function in imx_rproc.c to fail, leading to the M-core
power domain being shut down while the core is still running. This
results in a fault from the SCU (System Controller Unit) and triggers a
system reset.

To address this issue, ignore handling the clk for i.MX8X and i.MX8
M-core, as SCFW already takes care of enabling and configuring the
clock.

Suggested-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v6 -> v7:
 - Added Peng reviewed-by.
v5 -> v6:
 - Commit description improved, as suggested.
v4 -> v5:
 - Unchanged.
v3 -> v4:
 - Unchanged.
v2 -> v3:
 - Unchanged.
v1 -> v2:
 - Commit description updated, as suggested. Fixed Peng Fan email.
---
 drivers/remoteproc/imx_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 74299af1d7f1..627e57a88db2 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
 	struct device *dev = priv->dev;
 	int ret;
 
-	/* Remote core is not under control of Linux */
-	if (dcfg->method == IMX_RPROC_NONE)
+	/* Remote core is not under control of Linux or it is managed by SCU API */
+	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
 		return 0;
 
 	priv->clk = devm_clk_get(dev, NULL);
-- 
2.39.5


