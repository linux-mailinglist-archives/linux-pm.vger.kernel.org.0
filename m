Return-Path: <linux-pm+bounces-26827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF06AAE60A
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621489C65A6
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032DB28C848;
	Wed,  7 May 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maVuBc34"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130828C5D8;
	Wed,  7 May 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633719; cv=none; b=juni/gsRFy4kYEg+JOj731oNW3bfaW+XhNV6aGWllSjlbWr4YRWmpJOtZfQkEfXmDw54nbqHH3Nxsh1fLP8YbmvHEozuIRJiPCTxNnK9mNtIN+Y27yIS5MBwnqaCPu71rJ+8SJW3sm3Awk+jg6V7tURuc1mRqBgtryiu6ModNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633719; c=relaxed/simple;
	bh=n5VWoI8hwll6ATNrzxyGa1fhudrQz/wOOiEF2X2LP+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNNDrFGmzVLO3lSLnqlgmLQOL8EOXxefG0rfZbzQM5BB/9BvG0XqOvyqSFwAip2Q+/iq2L85FOb3D+xiqPYkISg2gvQ+SfqQoxxesyg3dG+N80YfDXh8aZ1wul3OJwyRVcjp6fj6UIsPI0UUzbgOiOOGdVmIeHznDUXYJiF8hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maVuBc34; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30828fc17adso104773a91.1;
        Wed, 07 May 2025 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746633718; x=1747238518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvziy4eou3QaoE99EKXIFfvgtdzshqQ6+XPSOJVwJnI=;
        b=maVuBc34Wiuaz3WUOJUXxWiFlRENhfLdHhPX1UfUe7cuRZgondsmql052V/PIF+w7O
         jpBzHdcZAGs2jwB7QLaBhSK5yiofb1ZteIugbPKOnz6nfsMvqxUneKp7fQHTvjecCeyv
         j3FmKaANHZZymM2C8Z/AJKXQ68vY+ACFvAWkW1I1DHXhgwuq/yUiNu6QbHt05a9jexCz
         6v+LZlIRFQZCZqIEDmhbKzl2sSqSIXY0Pz3dMV/IFHYja3y8QXd8SmuOumx+xLsZ1JPE
         wUhflUTRxu9vFfmmfhAcDYWnDxApB6JcOpStRVnFT6VKbtKf8kyJSDj0CguEBMnRvk8b
         nDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633718; x=1747238518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvziy4eou3QaoE99EKXIFfvgtdzshqQ6+XPSOJVwJnI=;
        b=hpODl4hfV6oyWsSpyEHwDoJFV6u7BdcomhXYdtSSniWWRZe6XYiwyih8er/eP/AbVf
         9JPUKpg4r4B1h05AFvKBUzdw8trqo83TIL1TiuC6qoOop6tqgHAZykJ0pHPD0FjhvEtS
         tEAsiAvoch0CIlQ8YSvVsUk2d0F2Jnxs8mqxtBJfTd4oROozU1H09/ctpJcB3vPsPwV0
         MHGExc/6OKoJHwJ2F8VUW+gJhHWFOL19S8z3K4ohTzwBAA6zYtzVSwCTzlRdy/LJXArv
         XFMVOm4AekXlwPsD+zYvWMWmu77e8F6F21igdipFR9wddQO1CnWElsC4sLfsdZSmROTz
         FBVA==
X-Forwarded-Encrypted: i=1; AJvYcCVD4Qakx2246QRddCDv33LrjrmFvXJsRBYCKA0/MUP/P9pr39jJzQDjXjFr9erIRF3uIGUVd3iKGlqg3vQ=@vger.kernel.org, AJvYcCXPvK/7CraE2PM5WYcUq0fZss2IYbu1Fr7SPcucSI4gtQDAnaekMl1y1KXXcazLumpK85OTl4F9KZo=@vger.kernel.org, AJvYcCXxHBDrGRUpzl5QQqSRrD6/PEi5wWvdz8hnxxrxSOaq/MMHbgUJSdKBNuwLK5pJ0pFUD0nMZ4oCSo7HMsrUxuM49g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp05l98yp2BPwbQHq4PBGfIBL9kC0L+tj0bLmetP2duzLgDn93
	Eo4uWzBXPATan2skH8HRQ3Gq160htAaJI1+V8ETbfTeBYdookoF2
X-Gm-Gg: ASbGncvBvrnm4NilkmoMIRQLUgrb/ybDK8tmcgbfvUUQUycGjgIYXYgGJpqg7nIF4KR
	FK5JYXYMk9P721xYFD7ub5/jOSs6Itx//HYxJ8zg0Dh8V70HCFkDZU9tx9ZFZ0MsT7O3REJVgs4
	3iFxKHQQaQiV6a8VDlA3Bj5xZnMWKLFBYwQ1TlpLTUu4d57SjLqwttslLz8b7uxnN8srcFyf50W
	4eFuPkfGoc0smKtAvI8dfgihMfbhqZBWdSXK3n/ji7M3hSrAFWnsGRV6HZrl0Ogz6ip81ZIVND8
	egvJWUjVLgweXMno5idJmzIvIJcmEb6s5OaHwwsTMAOlt7VCCDlvJmtI60NV3kw=
X-Google-Smtp-Source: AGHT+IEVQn8W2DCaOLJ8nt6une9BpBR+Zi5adCUsrGW+yDHxUa7uKGXONWqkOwz+Hr7bQ3bU6dYRUA==
X-Received: by 2002:a17:90b:2241:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-30aac2483e9mr5393663a91.31.1746633717323;
        Wed, 07 May 2025 09:01:57 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4f82b86sm327242a91.44.2025.05.07.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:01:56 -0700 (PDT)
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
Subject: [PATCH v2 2/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Wed,  7 May 2025 13:00:55 -0300
Message-Id: <20250507160056.11876-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507160056.11876-1-hiagofranco@gmail.com>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
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
v2: commit description updated, as suggested. Fixed Peng Fan email.
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


