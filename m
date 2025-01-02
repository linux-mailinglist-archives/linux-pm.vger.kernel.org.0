Return-Path: <linux-pm+bounces-19901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0449FF948
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 13:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E87B16101D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BC1B0F0A;
	Thu,  2 Jan 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DOjzHNj3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12A1A8419
	for <linux-pm@vger.kernel.org>; Thu,  2 Jan 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735820138; cv=none; b=c29U/g8qX64YOWiOXsCFeJ/oZHFsWLHN5+9z0g/knn78MEXZ1TODdbnCRcAYwjdBkvPswuW8fxsc2WyVFEwD1vu8/JkS0O8qCYSaWQz2xbBFwYJ/L9jsPrAaetRAnCiVgMXF1ySVicW8q/xY1/7jeN4eY+RwYPt9B+tmAXajFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735820138; c=relaxed/simple;
	bh=DXQ2A41Ak0f8c/Srx/US/xMIqRF+hrTTRWNqwbb/UY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDxBkuRPtZe4Z9WLpDQUWRz+ZGbx8t9yrcmlSonZDq2S4crX3Izm/0s6TwelJBmHr7LygFMua6d4UIkbdAuXUCac9gjAYZwBr8PE38wCXKFm2KLsX/Yc3FaBK+VkCpw42nuqyhwQAcGrbNCkmDQ+nt3iRey9wfoJnbUS8mhgIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DOjzHNj3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso5848636f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2025 04:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1735820133; x=1736424933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49Zbfez2Uv+GwEi9/KdRDU2/n1SiCvCfPSvq3xfobnQ=;
        b=DOjzHNj3pXuc5qguM8G1DfSHc1qrwHMe8r2yB3hPjLv3MS3UW+Z9CiERhCTHWxOkCs
         1djDjLtnEA9G0IpBsnF/ltuPT+bRIXaU/0jUH58ys6AWbbbEFhbxoKnSd7WeoKzQVZM+
         jSAl7fMH5+ysJyMoSO1R9um+NdvSq91J7oXOWVvzSueYV4GLSenri959pZnRnrKnAgD4
         8dVGdKhDMQEvWys8gpRGgb7XBGn5rzfJtUEK4ae6Th/r5ApZAtmV0VpD/o7+ua8ej3Z7
         5bEOKCi/ajdVQHx4th2G863Cx2cCGKoWv+bDLT6Mh4CTBbRAF1GiW3nf9BydIFSURAyW
         JIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735820133; x=1736424933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49Zbfez2Uv+GwEi9/KdRDU2/n1SiCvCfPSvq3xfobnQ=;
        b=pTY+QngpMQTjetbwU2tviGWmfq/T2B/1smEXrroyQpEcj4YknIj84u5qB6PnFmB2om
         a2dftVe0MUhDjP25rWbsAekLqua2hDon1n3LxKOBcKC86plV2JKrnFivqdvkGbnOue2+
         eY+sCWPJqMqF5IUkurHW4YIvVMV2A2dRzDN7V/HHtPYk802B7hg9IHGdKKP57GFSPBbF
         J3nffkgaVsm8tRtHGRsVh+X0Bkfm+yRAWtAmxRVuNxrqu/JScj17sMdCgqDTEFNxi7rp
         l0qeStXUxjisV5Q9czb+VB2/2e+Eh96dLh+zuAX093gMIjXdiHJS99DFftryIlTPg15J
         9VgQ==
X-Gm-Message-State: AOJu0YwbsEsimfmH7PW0H5eSjfbKBnVaRQNxhyXQ88+4Wx4mJarL5d7D
	PfCnMgMrUAUJ1917e6Gzr8mnl9/O6Cf49SzQo8thNhPnuOFIIi7/zrLPbR1bl9E=
X-Gm-Gg: ASbGncuXl5bTbYrR0njRbzpzD2Ncxg93kDq3Ng54LPa9Y/SoESmy8DOBYkehO12NbF7
	LXtbphUKDYdMgB6UUWlMAEWTp+WMFfa1Z6cvD8nlx0ItmgfU79HqGFk4WVp7XNAoD1Tn7KF0ifS
	1Sw/r2Fi+KAflQZBk9gQwfXJRaSgxXol8F8jrZ1l3wy7jSKyBrQtQ9REu6UIM2IooH32748bPkr
	K6siirUEchf8I2CHHCn90QDjzSK7PvfUJTEmRI+tnsDodA790dCf/Nj
X-Google-Smtp-Source: AGHT+IEQcymUaT5z7OHfgOJIsMrGBipMq4M5GLXMYW2IFgD9r2VMIYMv0E5DtI+X27G8zzsAsvqv/w==
X-Received: by 2002:a05:6000:1fac:b0:385:eecb:6f02 with SMTP id ffacd0b85a97d-38a2220045bmr34868448f8f.28.1735820133226;
        Thu, 02 Jan 2025 04:15:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:427d:f084:4f4e:ff78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm37475445f8f.30.2025.01.02.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 04:15:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack
Date: Thu,  2 Jan 2025 13:15:30 +0100
Message-ID: <20250102121530.26993-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the recent rework of the PCI power control code, the workaround for
the wlan-enable GPIO - where we don't set a default (low) state in the
power sequencing driver, but instead request the pin as-is - should no
longer be needed but some platforms still fail to probe the WLAN
controller. This is caused by the Qcom PCIe controller and needs a
workaround in the controller driver so add a FIXME to eventually remove
the hack from this driver once this is done.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- reword the FIXME comment as advised by Manivannan

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index cc03b5aaa8f2..e8f5030f2639 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -396,6 +396,13 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
+	/*
+	 * FIXME: This should actually be GPIOD_OUT_LOW, but doing so would
+	 * cause the WLAN power to be toggled, resulting in PCIe link down.
+	 * Since the PCIe controller driver is not handling link down currently,
+	 * the device becomes unusable. So we need to keep this workaround until
+	 * the link down handling is implemented in the controller driver.
+	 */
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
 						 GPIOD_ASIS);
 	if (IS_ERR(ctx->wlan_gpio))
-- 
2.45.2


