Return-Path: <linux-pm+bounces-29624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB3AEA938
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188F51C41570
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8840267713;
	Thu, 26 Jun 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YddFxxTR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B6267B61;
	Thu, 26 Jun 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975184; cv=none; b=cEDoGC0aTMryjKPVbrEzsj3beIjjPXATLvUEPa7D9m1T6e5e58e6nLVjMvAJx+4uYswH45lKvdsJ1d9vc4Q7FrkxAfVSWKDpM2BQ/004TmpG47L8zvtjbU03dlg5MV/nTs0UIZeYCXujEAR88WiXKTdFxnchxcDSDbDLgt3bLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975184; c=relaxed/simple;
	bh=HGCefvJVkJYHUUtIEx37dq0fjaTZbRZcwkr3/SvRe/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKa/HcnF1IIwYnNt8v3vAThO4+7ji1WcJlPQRrZCtaSwLsxlCs7ku1SWR+Jur5YkjtOp2+zKrZLYpT/ttpcnSdP32kh34pM/jQUobwg4NQr9r3LrOuxaSmh1cIr2ylEjo5O7bu5YNiJXTbNxolZFfGU8iJw4ABx2u7+hzl1G3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YddFxxTR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso20374145ad.0;
        Thu, 26 Jun 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750975181; x=1751579981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19+6eq/UcLTUhcGPnlhBGclygh3KIPHQ5cqQpFzjJBc=;
        b=YddFxxTRosLKsyqLu/Y5FjV75dEPfumkvM9Q+Y56Be/+DIAUfHBL02Qmsgu6QeKxru
         JHG6LYTXJLp61z2raVDno/8Nvt/uKPeENqlVZpJLVFxbDs1nDqGb1xcYjzvA0B9oUMN6
         PkfN1J6zVyOXCS6fDrapQzusTpEfiFJ4dJkbgysd9Ypf+ugV2nggdDNf0j7jiAq0O5YK
         wDvtuyCWBlyrdpY7jBQIawQORLQmCYgKL3IXitDLjXFoCDw2XzBkbYGcciHzVsfMXPHD
         mKq5ZypJAKEntcz2M15VnlxYJjvBUQGRbWqAiRyHEwuV8GKrHOsD0SDVVrGv6cNvgylp
         BUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750975181; x=1751579981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19+6eq/UcLTUhcGPnlhBGclygh3KIPHQ5cqQpFzjJBc=;
        b=bWklFbqJSbrI1pBpkVdgIV6Gn3kEuK/ACjUdCzlWc49ro+LpPHZ5vc/FFMaSxvni6S
         iUF9tLRiOSMygco5fX3kYtj0UBGe/3gQazVmzpr7MZEyqrwWF4aJBgVieK9RnAYs24We
         7DoDI1Z3lBEV3KzVMa93zJihARzqNx0/vkDXzSfMF6zyeOtwswNm/3XYgHXtD9tkAGNT
         D8TITgRqsZduiEdIA8C5iZ4ApZo16i+sRYozmOfz0u2tGQpxo2/DOdPw0mNhWEpl24hm
         E3D2yK4mFHwryZREJ5OQFgue9v7yTXXVveSi0OMNcelYrYsRPDlGoxo3Qp5tUKRjKyaN
         CgcA==
X-Forwarded-Encrypted: i=1; AJvYcCV4afO4xCyC9VX7q5zIU1wWhWCIJjQGW0VcIZ2TkeyCpimBCXUW/ZS3q7pD4YUPq8VLGHsqt6M7GEXKgpf35I17Xw==@vger.kernel.org, AJvYcCW3N/HOi9mZF8bzNYZfc//BMK3MmWLregRp0P+GD6zwBCKmnQ6j8j99GsPtaXkhN0AnYiMsh6Uqu3tQMqg=@vger.kernel.org, AJvYcCWo3Lx1+9cEbq1AtVeYCedQ2XWuoo0dxmqVNqOG+U8nN1FYc7YY5mFRlrBBKB+tMOl8G7gwpTRAagg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXpstjksk03bhW9SaYJn/MKp7CG6dCJtQbdPIdtqTiuJsCOUA
	yPYeA1jPxULU99NQ0TLr3Mru+Y04J9beGHHoa5XBzlWC4YyhytBlSfGi
X-Gm-Gg: ASbGnctvBsGRXYzjwisFQ88qFnRn3diVNl8NnmkCrb0+4rBV0yl1IMv7iblhMPVnvfs
	xFmA0JNgypj0UZdXaoT9F0uF6VC6posjNxxUTrCRg8VUR0mDbZzEt9iO4a/k+1E4v/mXx3f7giM
	ujKOX425BlXksYBQO3/AiBlsbUZ7C3hHwQ4bvCpjOiunoMkzzhFnaT6ZVsr1k2724xzy3Gk/34j
	Yj3oTH6s+dwIJaMbwQfKeq01UnAp1C0THfZbh/8KEeAnjh90S7+aoEhQzC5YDfE362U+YpS/sDJ
	VlWa2MA2QyoDeCkt4HgnvfbxpMwVEkvfxHinwMVrmptJHZDo/3Kpc2Cj2+kJ4hwbtmqxakod29B
	wsjo=
X-Google-Smtp-Source: AGHT+IFGHYw7pNh3YY2ppWd/GXJ7nll6kZo8n/rfheAtH7R1R5QnYe8TH6ojABszFWMLG+uP4MGkOg==
X-Received: by 2002:a17:902:ec89:b0:234:8a4a:adad with SMTP id d9443c01a7336-23ac46824a1mr12395525ad.26.1750975181615;
        Thu, 26 Jun 2025 14:59:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b8b9sm585275ad.118.2025.06.26.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:59:40 -0700 (PDT)
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
Subject: [PATCH v6 2/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Thu, 26 Jun 2025 18:59:10 -0300
Message-Id: <20250626215911.5992-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626215911.5992-1-hiagofranco@gmail.com>
References: <20250626215911.5992-1-hiagofranco@gmail.com>
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
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
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


