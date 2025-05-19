Return-Path: <linux-pm+bounces-27370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF69ABC560
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374FD4A233E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95882874EF;
	Mon, 19 May 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV1pe4hY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385312882C6;
	Mon, 19 May 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674983; cv=none; b=A7u3ELZD1Xk2G1K4UdFdlAr6e2hZmvzgwYYyWgUuxTlPqGhD3RNbscc7erAMQEuRAxLMg12vPJFw+hahV1DmYQ0YLRjHef3IzVv0aTq9/L4USC3zs4l22fnmOFC6XWDxa/QrI57Zy2YHj8G7zRl9I25v1y9L2YEbwSLehMMgQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674983; c=relaxed/simple;
	bh=rQAwwHGSkb+3HPYT26JL1d2p9vSi54lvUjzrl/7T5w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnE+8a0T9mSIOca1RFTUfSFQK7Oji3+9MFB5Qq3+uwCqEMA9XB0z3w3xqTY24eYmq9NAxigDp1EcrgK7xqn0rXLNmYWPYyWoRq3L7ktp1myCp6+18QC0Ptgj6S9n2Mp0Se6dAO1/iGSE/Lx9o0q4eGl/ubPgqFMkJ1JZgKJz+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV1pe4hY; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so1263255241.0;
        Mon, 19 May 2025 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747674981; x=1748279781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGjXFGuWNPuMSkHVFxRqYuJrDQhGPryMypgumm+l/4k=;
        b=IV1pe4hYv2GLXU2P83u/f3VbPHbUgl/kVClB/eE+jVNWOtg6yvPUOsGG6mJt9IklFW
         hkqPdofcH5DD3hxNNmLICR7sYKESx6zWIxHYPqI150LcYoiSNuOIb1/L2tzB08sp2WZO
         gBnFDoqXlNAh9M3pV60JALI/YT8U7LSq1JZ+M3bvIx7wXCiF3VkZRDV/JfORSc4/KIDR
         KXMX3KXEKYf+85yRtFe+W7Vcvlwb9aeifnb03FaLWpXRi+Gu4nMNNL+vQlySStbQq62n
         WILzn4phWv+hpTpLDRuwzy95C6hrXgx58SXTKwxvf4GEzzlVDbDBpZN1360WJi6yH8Qt
         nAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674981; x=1748279781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGjXFGuWNPuMSkHVFxRqYuJrDQhGPryMypgumm+l/4k=;
        b=Sd0r/Sf8ViHWW1VufoPD/DtokXm+EZUKKZPPqcf/5qquHrdct2m9dMC2K+dD8X9dt3
         9Ewz+SGKGkNdjLNhu9oWRUOENFq0H1FAZlVQWGT7Xtn0j5rCzVQMX8OQ1av4f/jCiQzp
         VyKowRMMOOuAI1Mt2rQKdXAy+Vrguq9YPKb7HAvvoCgSSYEsD1/TawfqnMlyVKnPkhFp
         IjvEnxq5BpUlUOIHxWmi/5FeYqti+lygA1xZ2TaO8WTK2x+rFVLrfTAY9nfQrmOLa0+R
         SXoLtotmxaIuJR8lEl2dcjDyzqMcT0b78lwU2+xegDBurZnaWUOzfRvQgIDtpCBdPVDZ
         mdwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0s5GmAOW/SCwPXYnyfKGhUOeY0SIbrgoeNWh6vK07fLlylf0kgVoCiD2F6i3nZ6igzxcsOrsd0oKoC9mcyYBqdQ==@vger.kernel.org, AJvYcCVoJt5ie8Wd3LgvkX1Ur7alMWXKu1uUrM1BX39OKBtyhgpZWsN/XRIwWPtSdwxeG7s4jIjWg358IJg=@vger.kernel.org, AJvYcCWX7+YNBckJTqMYncn66s7mOO78FYIoGQTVXV5y0I2Nk+I/KxnvvaDcxK+/VOMH5MRNEhuCIcd3o+24yhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK8N0Ydu19j2P+89LS8D8Y6xfqi12QXK5srfHpAjWwT05B9Ej
	eCAb7TqJJJynYUW9DGeJLPqzFGWCzSuF0CRuQLkLzpkqAbhZHB3feYG/
X-Gm-Gg: ASbGncsK2uK/J1lhG7QxhCp9iP/MdZ1tHEpG/bh3KwOzFu7a9BKxOvJ3VO0CLaizn0b
	gPIK2W57anrCV+v2DICHJor/1v1zAUDhOA5TaVxEnLm8xj/C4CnQ4pKxPxLkK3aj+CWHoKwmyLl
	zWT85gZBt16zPPk9n6AovXIxQYetgyKl8/eR4kB8k5qrxGoZNCpf8mvRzXyXYbufJq5qQEojXQQ
	jaoyMz7yT2bi6of9BOJSj49NpNLSIJNMxQ1f8Cf1qK87GWU+K9YJ79n3iMNcnWJKP0ukrTdtaLT
	ZZSspdR4ELUsht/BHeHnKGbQHGAyiGAVbssyi79jRIp+AftZKecExMDAgdMEcuKqvq66KmFRCw=
	=
X-Google-Smtp-Source: AGHT+IH9BchR+WY1xG/OkUX8wAcOrhxgnJTryDQb39oorpQKhqyzK9wy1AtcbLqbWwTQkOs8cLfUHg==
X-Received: by 2002:a05:6122:2049:b0:52d:bbab:2055 with SMTP id 71dfb90a1353d-52dbbab9460mr8433938e0c.10.1747674981032;
        Mon, 19 May 2025 10:16:21 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e983sm7003647e0c.31.2025.05.19.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:16:20 -0700 (PDT)
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
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 2/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Mon, 19 May 2025 14:15:13 -0300
Message-Id: <20250519171514.61974-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519171514.61974-1-hiagofranco@gmail.com>
References: <20250519171514.61974-1-hiagofranco@gmail.com>
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

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Suggested-by: Peng Fan <peng.fan@nxp.com>
---
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


