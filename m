Return-Path: <linux-pm+bounces-30679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B7B01B25
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC0179C44
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08530293462;
	Fri, 11 Jul 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHFO21fS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0228B4EB
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234454; cv=none; b=tPe45PlhpKsavv19t+m2vNP+HYm0qQmlJxQ4eZFiSMwRSuncIlupuGxNyeC2jpGWsNsfsu9KbY1koIVPsos8OaA1nXzA2aXstBoxiHs8I0yxxtqpQRq5FJUWZ4RHMhSZ3db9HoBxj/6zakQ61bWEBYLtofks0v0XEmIBExn/tiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234454; c=relaxed/simple;
	bh=QJVaK3OzonhM172ouy0CpSbbwuoG2dejA4OnkSXs130=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyFeVdEbqgeh7WjDhldWbgYzClzw9Rs1hNHhy7YZjdagSWHl1DWrhmAY6pcqTizDgk2djCKPyrfbsWnpEDthujIAAuy90CeA5nffYesobuDk1F8GNaRZ5XTyvnE3leRA0oLKHf6zSetiyK/LrFMY0jg0b7TxrxVblGavlkRvPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHFO21fS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55516abe02cso2005629e87.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752234450; x=1752839250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRhFukVlfvQMsLzBFVuMG+Qi50dL1WntO88bS057RO0=;
        b=iHFO21fSeB6r0NI9Bn82bDDS8mZpmM3mfP7lbcTnFrvyFkVRYw6J+vgEdeyD22Y/au
         toTAc+SxPYaIJ4Oec2eOpBKdGKEyPnWUs2yno2f/QYSYbW+xcsV6xyZw10nKYj3pACcF
         HYXSaSTCNRDd5s/zAtMXywxrEoMVm9fef6hMkQq20T1EUEOFit2wX2baJIzDYQ/xVPEc
         BCKQjLNb6Z+jv2KPbX+VZM9FxI9my0H4yQsXm3sJ98RccjP5MFGLwcUROwEfIGTilEVm
         EosHI/RpkSeHABHQt/OysGmVQWtjjaUcv/3hY8ATMPy4H90Twi+SAXBbnuFP1Nro6ciM
         VhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234450; x=1752839250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRhFukVlfvQMsLzBFVuMG+Qi50dL1WntO88bS057RO0=;
        b=jOloNDJ7Lu5CDp5BtuUXCY4WazzNbB6pomGhyXfgNJrG8MBZjcVm1yJzuF39SfPvrz
         n7bpKEp69IBedRQ/HWKuunSogfGDhFUne2PEA13APpqF//Wi4ebTSlHPHL5SXx9PLgqo
         7WKr53p0FeQsMBj3n4q2cbJ0tDc+AXbOBDtpZ6yaKm2tL3uCJENnjuwz4xk8rKKrJJGr
         Vi604DQrhi6hRn+5qb5KN9wEYxFbhGibsuuqdjDFRkNUI5VMQvqDFuOXsDL7i0/l5Vl+
         X66z5/MQsc0Da82+gym4/xWTBExvH+jFqhVIS8QY8RcGJW/6VodvvO6Zij6INsRyKdJZ
         fBPw==
X-Forwarded-Encrypted: i=1; AJvYcCUt/TuBYaGUGHOfCuPu4VPIy3aAjmAwOj14GKca8mRVD61bCScwgzzslsd1b7On0Ecayc1LfvtFdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mUF54gvyxtVMmnSzcUxCOKs6TkgRAvwkhcObQm9u6PzLFfmB
	HgPds8QFzaebrd52PFOCEifZuAMrRFXQTduITE9vnrxdGJa+3dbr8wrI1hcUTdfzcOkEYSxChUX
	Hoqsg
X-Gm-Gg: ASbGnct/9uHwVOzSeAwaP4zk5xwMDgpLxF3kxne629Vwk/aqkZoNAdcHFCD8psaHPcG
	GFSvke5b/wlWI3VWz7A/xaxDyxQKdYUHe/42pyFNzx0CcBdb8PpVEgl4ftSt+49isyShOzvka3p
	BkeQ0MqDvZFduB7ra+4GjDTtNWE6FtJz1tjTPUGPgAZAnARoQxWPqNeNMOVZX/7/T7RQY33YMY1
	VDcpLPSyYWQXsq/I8JAme+K3aa46Y2qOwClS8QeRSzCka0FcylnwVTd+AIEaf6qEp22s02MAT0+
	9Moo9fhsEOODWc34P0owVS7pNqmIYvYHDtxctqYuS0GTPKKD+I+pvdQcGaReXK0WKOmZEwo3U/h
	XzH1p+anF86hlRTxuqJH+segoxzdD6iqjay/0KZGRWlYO7SYboWCTkw1feKuWDOTBFhLeCQwfxk
	yYQl+d6lY=
X-Google-Smtp-Source: AGHT+IG12UDrTXalEDU0YKI0OWyt7RE273XbDSoBAUX3pRGix+0Sj5LWHFUpgBtVPKp9Q0+KnL0ueA==
X-Received: by 2002:a05:6512:3405:b0:553:243c:c1d3 with SMTP id 2adb3069b0e04-5590071bca8mr2492286e87.18.1752234449986;
        Fri, 11 Jul 2025 04:47:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b60f09sm915928e87.154.2025.07.11.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:47:29 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state
Date: Fri, 11 Jul 2025 13:47:19 +0200
Message-ID: <20250711114719.189441-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's has been reported that some Samsung platforms fails to boot with
genpd's new sync_state support.

Typically the problem exists for platforms where bootloaders are turning on
the splash-screen and handing it over to be managed by the kernel. However,
at this point, it's not clear how to correctly solve the problem.

Although, to make the platforms boot again, let's add a temporary hack in
the samsung power-domain provider driver, which enforces a sync_state that
allows the power-domains to be reset before consumer devices starts to be
attached.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/all/212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 9b502e8751d1..5d478bb37ad6 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -147,6 +147,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
 				parent.np, child.np);
 	}
 
+	/*
+	 * Some Samsung platforms with bootloaders turning on the splash-screen
+	 * and handing it over to the kernel, requires the power-domains to be
+	 * reset during boot. As a temporary hack to manage this, let's enforce
+	 * a sync_state.
+	 */
+	if (!ret)
+		of_genpd_sync_state(np);
+
 	pm_runtime_enable(dev);
 	return ret;
 }
-- 
2.43.0


