Return-Path: <linux-pm+bounces-19370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95CA9F4BFC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434F01896E12
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1141F472A;
	Tue, 17 Dec 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b/sEJ3gG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A041EE026
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440841; cv=none; b=SP0sWk3DSHbdMc8/LhuAvJMxNhd4iwa4Wyuu19S1cxNWsi0ucW5hAfnrG1JLs7odgs6xXolacHPwpULPCaWTcQ6Nv215hlpoUzaH/ysM7dJHACtt7PR0TgrAsno6ceNUyv7AsUGPwHJTJbm8K6VAxZLWPwUpVaOjh/NaKMtV4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440841; c=relaxed/simple;
	bh=tiFDbuiLhdgo9Mpr0DUuNilHyCSbQ7kNQKNgVyN9Ab4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSdY9jAtldPGw0tkgqKDfea3/YwADaFbogtLUFLuh5CpwF79gFVsL+/ew2N5+94QHPQ4h5TF7YRroRN+ErySC9bi6aTpRluEiFPYXg4oqUvE7/ZxqbKF789L9ZnyFfOZpIdsTMYccKCIbZiLjebtRANZIF1uySuBIRQ/l+EJsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b/sEJ3gG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3918259f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734440838; x=1735045638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKZH+3oGIzxnCr2Yt/BTYyEjHKZwxfdTXrPGk9BiJzI=;
        b=b/sEJ3gGgHTapuU0Djl6NbwvA10hokQ6/8jlaemZlGuCI0mzasiUTHyEYBBElGfbFo
         V0C5+LiaBkg5gCAAsZhaAcpkKJtSyiDo4NgHX8o/jMV5iCO5IxlNUWGCIJTxe3ohbiso
         lnTU0T9BybocVsdjBPu/GyHajCSkOR/yxzk3jr0f/EsdZxppHhGuK9WnLJCb65JajfF1
         4ghEiaY9ETW2QRQ/yp/XhpJFN/JyY1DVISXku1Xn7j1wz7KP4GorhvOrJVb5dzquW9hs
         PSVtgfeqBOEnQ0bTF55pEMRMCl+Fki/r3LPzMxuM1e/qmrvPdfHJfcRkEroqClYNtuD1
         c2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440838; x=1735045638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKZH+3oGIzxnCr2Yt/BTYyEjHKZwxfdTXrPGk9BiJzI=;
        b=lILO3k0t4Qw6oBboUWVB+IDP3YDgQ8T8qWqypQYOcy0uM7j0iwbSWEx1JrzP+bBl47
         GCvkZIv7Hd44tQubzNTWVTzPGez0P4YZxh+ZazawN5dhi42hMROn2O2aZW4oym9VxL9i
         DNu7ha3IMkfmZtgNHM0PQfiptuqT0kJfHENVaGhKqHAsMQbdXb5eO/UCiWy9jf+grYar
         nsxRCorSd4M/ROGu/MW77uLW1tZNvXRPjjmDunckbDdxglcipvBRiLfQvEkueO3xQvd8
         fL6bBQUy3C3qaZtBEhbCjarAuBNPVNXFLB70fDU02G+l4IYYPfd7vOjpFU85VVsJ0S2r
         uwrQ==
X-Gm-Message-State: AOJu0YxJ8XTBLZERI10nZAfUwjRDWwunTLCUeJaKAPvZolW5FQNUFnnU
	JmLF15uTOy39+D4IounkoTqzCwj1tzHZVJaQBbpsxvpoQ557sMHFtd4JcirHds8=
X-Gm-Gg: ASbGncvFsSIrlSGWF6H/3kAFfMd/YuC4ujHzGlz5mhrcqG/mI85LiF1OgmLUDei723A
	bEqBHj0ab90Aup0PBtSeebfg9jIBa+BjbZ5duYpSfi8ymhKadcUzFDqwFsWWqXauGmHMbqtMLk4
	FxIZoxO1cbaRwiOMqt1ZvuclqvcoMSwrPbf9R3bbT6xAXBK0v6iznOGaL5irCzbEsMTzFun7Cbm
	b3XQ6uMU7nuiZM99w9kGo4jRDVrBKWCb1bFzi5t5bUk4vwJyzQDAIKe
X-Google-Smtp-Source: AGHT+IEgPO9ABbOL7ucdASbUynPyCJFyYcZhfnFIvIt0jen9/oVFeATEDojSNgDCknf4p2ZBBQdeOw==
X-Received: by 2002:a5d:47a2:0:b0:385:e176:4420 with SMTP id ffacd0b85a97d-38880ac2e1emr13175713f8f.10.1734440837798;
        Tue, 17 Dec 2024 05:07:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:4699:6189:1775:3ce7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801bb00sm10970196f8f.62.2024.12.17.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:07:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack
Date: Tue, 17 Dec 2024 14:07:14 +0100
Message-ID: <20241217130714.51406-1-brgl@bgdev.pl>
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
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index cc03b5aaa8f2..9d6a68ac719f 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -396,6 +396,14 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
+	/*
+	 * FIXME: This should actually be GPIOD_OUT_LOW. The driver model can
+	 * correctly handle provider <-> consumer dependencies but there is a
+	 * known issue with Qcom PCIe controllers where, if the device is
+	 * powered off abrubtly (without controller driver noticing), the PCIe
+	 * link moves to link down state. Until the link-down handling is
+	 * addressed in the controller driver, we need to keep this workaround.
+	 */
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
 						 GPIOD_ASIS);
 	if (IS_ERR(ctx->wlan_gpio))
-- 
2.45.2


