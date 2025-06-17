Return-Path: <linux-pm+bounces-28921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C288EADDC79
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 21:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A461C402AB1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179D2EBB8B;
	Tue, 17 Jun 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIjl7q3a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81F28981A;
	Tue, 17 Jun 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188971; cv=none; b=G46SX9ZoBFliSuQpfaNNsRHVqpN4P6ISxZEXtzaZy/9HbDS/RQr1vrp29qZDezPm4bRudVeOGYRo4IOd8w+PmFxZFeSrvlyJ0wCjRiQeinHQ2XCKK+32BcFJYXJGdAMh/oMQ8jR7X8O+62NXtyCymjvHph9CrPDlMgeqqkmNbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188971; c=relaxed/simple;
	bh=KpSwTl4wyM18BdoPd4qTfDpifdr5k6KgAwhnWNQ3dRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+eO8r2oLRUc6HMID9OZRHLxuLiiQ8KQG8Xr83aSfhto4ZPDXSb2s/RjcCGiJsrRN1Os+kDCuo8BFBB6/mBbJXjCRm8hLKgcpA2tHftShmlwOa//o9GaUxOdtxgSlnnAso8eCLUB1LlKSyCFbw35JO/1a2TLPIUkpRkUllXdnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIjl7q3a; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fd59851baso4027669a12.0;
        Tue, 17 Jun 2025 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188968; x=1750793768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1scGrWmFNF+u0XSYuCytdGqLKRqsOgk+ZZqdhXd5JD8=;
        b=TIjl7q3aYrB/R6zlIVf3mev+jBZSzD5VDtEk6VV867pQIXwadyOIV0ir3+XDQGAery
         FZWeFlsfL/TQDLR3fNAmEJb1IynRNAf8iJlibKPF09G41xC0z2Fz98WfcpxRRbL+ZxgJ
         l0xMHIZG9xVqiEcCGlxs1nMAdp25pRFodgdhQcRaBtZWQpshyJfnzeQ963yt1e1jXlSp
         vYZw2QzGvNOmPRGEtmdsj/kr8fgpzZfeXuuqxXoMGMctEcQ3rcQKgQyPkEzDLQ4rNnBK
         JM9V28H7dCz4yO0lMCFpmjXnAk7zfPfkH0laZ49W0ys0waIKP1xdqPcx4LFQIkARVu53
         2bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188968; x=1750793768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1scGrWmFNF+u0XSYuCytdGqLKRqsOgk+ZZqdhXd5JD8=;
        b=Xi6VcqLnHX7sfzcvrBicjl8Ms9HGRgHYf0cmxUnxRm1R6qtvSoQsN5puCj0kJTGxPv
         NRP3emHE6QRJ+Xa8S+yXllqM2e5knVJFQNP6/sgUrhm8e+0RjklSSWvFodDO/M1O4RY6
         6J4dlRG3GtXUqWCszs3yTzEKK+movGO6Af97D+i3avsW3jpIuni1eCWD6pSrG+iK9mga
         zgSx790GQJd0UsyUVgSwj23lDjRtDLCZid3GMOCndrbaiPgcgaxmYpWugErRqCOcq2eC
         tJEydhqRDdJ0z6qIZ1lhNScqMzb6Mbh/EExIE5r7VDazuSGGrCBazHlHfQ57cXDU9nBu
         JADg==
X-Forwarded-Encrypted: i=1; AJvYcCURkus/KFEv/rnhupFMJEBuMpBoImqBb+iOAUWKvjiaVdYiIo60NJh8CJ5gjgNHVqemybm+c9SgCFok/vg=@vger.kernel.org, AJvYcCWql3L1Lh9kk/7DOOZybnJ77y4Sf/TO5UqReFxoyuf8Nhr5KA1HJvuXt5gO5On1uimNtldgmYvTLXs=@vger.kernel.org, AJvYcCXwJwVsqkcKnES9FTsm0HfXae/VMYDFY+6zDSTu9Ow2nPkUxs7+08v81sBKtRf8Xo2uvLUsBbmex6e0F7GswYh2Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKZa/zKl5I2R8WcVLve9f4PbyaSDS1IMj3CuH8dwUl77xinly
	K3z36Lh+9+angmYcZu14v0R958zHKEuqCr9m3Bw5uCQpxX24nhfKHfrc
X-Gm-Gg: ASbGncsLRfZ0M+0toXWwaebRJHETBtDwKD3svo3wbpBqexm7Uzk5/u/GkK7QN0j3tPm
	d3glFCe7CRylZpLLjNLOlPb7L+e3zoYFCiSqBa3xm6GsKL/nDC/efDBNX5l3P6TlqhLc5kOd9tG
	ymoSxj1yX6wAix5N10Ot/LiNLg7PciXWnZIAuRokIQQDocBofI4GF3visqyErs/zEFU5RNXY5+B
	YaoZcIUPg1RQ3ZETEwcea1mMIA4AJiaNuer5DRWls/4L6L6LRYqVtOPybXcFPwLLAx1tWQuqhDx
	DMmd9jZbrC1NnqpwI+Y/AYchpodWFdwExfIiwIRA4rSFpU12E3WzCGOJonOCY7x0OZ6cEnHCKa+
	b6tHa0+lF
X-Google-Smtp-Source: AGHT+IF/rndT3pqVzap/b+BUcpqjMIETJYig28EKMkQ28U1cw4wJ+jDydO+2ebPcgPtnZZvK5fdPAg==
X-Received: by 2002:a05:6a20:2591:b0:1f5:769a:a4be with SMTP id adf61e73a8af0-21fbd59fb65mr24359112637.36.1750188968258;
        Tue, 17 Jun 2025 12:36:08 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d7340sm9648582b3a.179.2025.06.17.12.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:36:07 -0700 (PDT)
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
Subject: [PATCH v5 2/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Tue, 17 Jun 2025 16:34:49 -0300
Message-Id: <20250617193450.183889-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617193450.183889-1-hiagofranco@gmail.com>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
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


