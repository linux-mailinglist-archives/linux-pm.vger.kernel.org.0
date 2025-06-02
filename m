Return-Path: <linux-pm+bounces-27965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A1ACAED5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD4D1BA1184
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339EC221DA8;
	Mon,  2 Jun 2025 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBBxuLaJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F2221727;
	Mon,  2 Jun 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870399; cv=none; b=Z1YL8sQWwM/0wng0XGq7/1PGfIU35wN7MhZIyG4efxvN9vfd/rW9GVrT4UP4M55k9d4YJ7duWaqmSt6I8n+C6uptPpNsJ6oiXukOgOpRAQT12McpL2pHuk8ght7p7Re+2ffrVqQDQYugBzJSPIfO9fJ2giZzKG/HlDf04ipJBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870399; c=relaxed/simple;
	bh=oL2pBfAmXooSdMFJKON1dq1V6xiD8s5/TFtFSgq1qmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULfMtKsr+V5nPPIF5Jt/EI3H/TBD0Uz9qzng0NHjc+6uji4d58WniCVYaQethd4E2TNA+u+vBGAMyeodr3iaWWl+L46JuSJVsOyleYpvdQBgPpAbie1mZFWTEG0XFKoNf7wmwJ23H7qOc9hHZGic0Md0aiGSw1xxOTo/d9hF6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBBxuLaJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30e542e4187so3022915a91.3;
        Mon, 02 Jun 2025 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870397; x=1749475197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pcvAbNlPqy8avpN6kp5KhushkYLoqeoRe8/zurysr4=;
        b=hBBxuLaJOZGizMD+D4M2HtYBD8eNo1YubdbgOsjomVkFQUpQlyGU53vMK5V+Urf+o9
         zed8S9sxPQi/AJ3HXnx+XRWnoD48Jj4fOagmnPyX0PJDkHOlyltnlUH/4+xmNDBRwdx2
         Ya2oCzBqGmXUyUaLuSdEqqKZvqNQqMOawiRhfT4fdIeOKZ5luLffcLim9idq4K7UEqPk
         DJtRuwCCXZBpaZmGSVRuzeQKeI2v4kKkM0LJqI8dSQRHmDuL+j6DIq9eRt2pL1Xp6kvx
         BSRjNQ+uI/SLviAj13OW40TORp6R5WP5y8geJr5429kUHSq+0MUYeR8+k3zWlOpn/Rz1
         szKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870397; x=1749475197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pcvAbNlPqy8avpN6kp5KhushkYLoqeoRe8/zurysr4=;
        b=FktLp2RD8L7uSn1S2kUnBv4YpZ4bmtjFX5BY+A7weQEUD4ZtgVWDbGu8u4+uFuW+A/
         X/Y1NXk1RxYccA9VgyaEuFYjBqcPu2cNXtAfka9xszMpwzNirxvJ9Cz+728GkOLJFBrn
         X4aki6mibk3ER4G/kW+b0dtsnLQIgyy9hwM72fz8fuQsnRK5C2xsFlDIViigZQ1yvNS+
         0d39wkxmjhO+udpLE+Tx8IvYOnYBIWAIbXiWEjaZjZNHUE+Uwe1Ov6/8t+BqkpIKM0K5
         fW7UYFMC4ntv+MpuLHfd7u/7GUk6SyfaCt5qgKR1b/Rc+6f2o7znX5aSA+bU/3wf5F0u
         aW0A==
X-Forwarded-Encrypted: i=1; AJvYcCWO7A9uD4mDapy8grQw6P8x9kiE8/AVpi9YNuFo6hK7FKPnDtp1o4McJXNH9Ds0oDLQvrHb8QZ93WY0xMCBHmwrxg==@vger.kernel.org, AJvYcCXAzfCvkTiEL0nSymsFbGPWmAmfDUZXLO55/5KkqTlIgaW5bBYQFA4CGadhbgRjqjUHfPioJbcW1U/oTOQ=@vger.kernel.org, AJvYcCXbnd58JSGpxWwrrJnxKfdTf1DLMw8MtyL+mQORRL1jBH54k45mJ1ZaiZGmV281FElHKTDP72Rrw7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/DPu2+Qi6KOc2zH6Y/cubtbPK8CuikkbWjJTD3v1yzB2BvjN
	rM3CBRzxcudUMWzCu5GwGbL0BsOPBzg8kNo8SIouSTkM4FT54zzVaDLN92jHSGHQ
X-Gm-Gg: ASbGncuPug1oxwOG8OGyh2umpCquZ3IASFyl/AmuYUCtqbKOFZKdHraI3o1rmJ0ukKB
	PO2GR3GS1vkyA3DM4DRl7r4bwp+fyyqh5+5L7RwamW6rbGIIIS/T3+ldUAUWJBByNs+Tgfq4iTB
	GhawjYSd4Gbe+VpaJe8ntrUTDixvogxcwFTW1R0bBgWKreReAuIW3lJdPwK8oumUZC4WFxgGrx4
	wxHUSBZVaqAToJRNlXvoYR0af8GaZw+jrI9ScJrj2UzEGVUGLYdFuUZeXv+Mli7SWqrsWZIQFIh
	BS2zkZI8S3W5rnITLFBwVYBKJgss3A5OcSidNjCVCAVpmLZoWBaORRYcI4zDqLTOaNYflwVqgLf
	zQKAfzME3
X-Google-Smtp-Source: AGHT+IGmdU9yIWWKtV28WuEUnscGkG0AjD3tLXlSKHPKML0pCpHKekiyfiKqp/DGTPbox5idKuB7SA==
X-Received: by 2002:a17:90b:1a88:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-3124100ca0dmr20343807a91.4.1748870396838;
        Mon, 02 Jun 2025 06:19:56 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2b67bcsm6130983a91.8.2025.06.02.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:19:55 -0700 (PDT)
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
Subject: [PATCH v4 2/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Mon,  2 Jun 2025 10:19:04 -0300
Message-Id: <20250602131906.25751-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250602131906.25751-1-hiagofranco@gmail.com>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
by the bootloader, M-core and Linux are in same SCFW (System Controller
Firmware) partition, so linux has permission to control M-core.

But when M-core is started, the SCFW will automatically enable the clock
and configure the rate, and any users that want to enable the clock will
get error 'LOCKED' from SCFW. So current imx_rproc.c probe function
fails because clk_prepare_enable also fails. With that, the M-core power
domain is powered off when it is still running, causing a SCU (System
Controller Unit) fault reset, and the system restarts.

To address the issue, ignore handling the clk for i.MX8X and i.MX8 M-core,
because SCFW will automatically enable and configure the clock.

Suggested-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v4: Unchanged.
v3: Unchanged.
v2: Commit description updated, as suggested. Fixed Peng Fan email.
v1: https://lore.kernel.org/lkml/20250505154849.64889-2-hiagofranco@gmail.com/
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


