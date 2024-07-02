Return-Path: <linux-pm+bounces-10337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF6923C9B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B96E1C22094
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12515B130;
	Tue,  2 Jul 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e1jGGGU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDA15B12A
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920471; cv=none; b=EwVKYL3VGz/K/2kF6hAjNXtpUEya6DmiVnqi+bK+5wVoyZieXegZCW8xXBYbGoQWhpZ5FmT6/5ZyZ+DbAlhe4FYp1/UQhOJYJ3AB9YjozS5qQeHE2o9dlpTOPh1oFGRVToruUIq07I5u29Jr9vtbB/dnqLOJGi7mQk5yiDjCyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920471; c=relaxed/simple;
	bh=EjhoZ8OblHPETlxZbG+8SNtqIJsd3VP1PTSzTC6gkK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzeUJAI7tyxiZ0DlTIszU4Kcius/XRm0GQzwhF90QpTBJKohpeofZbvke74kH6FL77qhjZgQ8dU0IBXDwXUO6yEdnwJDxJKCvGOsxWO8f7UkvyaUYVYAMwKsOV+pGp93gawJOHc81GRTiWSzbf9kj2ve6rSd0k1xGE53k9Kj/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e1jGGGU8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36786081ac8so292785f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719920469; x=1720525269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibYk2INHrDewcc6rOpyR3n0ptWH8fAE6FA5MquhF0qk=;
        b=e1jGGGU8RlUHnyAPyIBRgc5yHf3TIgwvt7LHI7nHCgyIt7Ia8OpI3FzKNk9vWP6Uxp
         Lsrg+Py+z1TqC7hQ/gw+tbjCpLaapT4tTrUCjukm87AEogzslWOu+NWnDNpLCQ/3I9Jr
         oCODDIp3A4LGjYB296VskdIbxiqjZL0W49R1uXXZbYbdSb5w2bWpn32cM0hQZ9YclsoS
         zdfcB2y2F1Ae1RXzEmn+Z1nHnk6l7h9UEwII0npyqMF6taWg0IRmr7MQb/PS7x+nEj3v
         M3Fo4gGYjbkbXNTaJlP9WtE7EM0SboN9dliHITapYSnFIFPfT9jIcsS4grAYcgVA7gtq
         /I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920469; x=1720525269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibYk2INHrDewcc6rOpyR3n0ptWH8fAE6FA5MquhF0qk=;
        b=J43Am5bK1zkSRI/XNRHXLmdJ6RgVlTIdvnwYmh2qtV7rHiglJ2Ln0+TCHtd6NPh2TL
         60gWOj0ASl0ClWdIg8UdtIEISN5F6DPoZt/TnfEvVbpKloUVTKyO8FiCztr6wK103uid
         d61lMGwdRLUE35lZK/JlcNzM60KpLovdFifXPDJGeL2IFw5CU+LbFeazNtriKt6k/RSU
         mOpPp7SIRsNVzQfkeWNn+Uj+AVO3Noifbj1pLJ1bu68p65qRdz6Jn9Zg5KC595FdmG1n
         g5pBXiKyDHxckWtkuXH9qxdABLNG1dIY0rX0X0cQCtBT5iBlDDH4+FUIuWxEQhzpmKsI
         8JWQ==
X-Gm-Message-State: AOJu0YzoH4n2BPP81wRiPQviK1ib8oC7UK9PnfCTit1MTfRZxNZx7/iS
	J2O7WTF61+BIzJto6O5VD5P/N3yILp1YjzuxM/9MzqQq/OdmDY1x5GIyOfWJayc=
X-Google-Smtp-Source: AGHT+IEU5xcCH/1EAfhOaWb9JMDGA6qsWvtR9LL9IGXqlYSEFIFdTaE5gkIzrS/Q7ZbPZLxOAp3Crg==
X-Received: by 2002:a05:6000:d43:b0:366:6ef0:e92 with SMTP id ffacd0b85a97d-367756b96a9mr6870973f8f.27.1719920468559;
        Tue, 02 Jul 2024 04:41:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:628b:5bc8:edc:9c60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1030c8sm12966271f8f.98.2024.07.02.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:41:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Amit Pundir <amit.pundir@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: don't request BT enable GPIOs for wcn7850
Date: Tue,  2 Jul 2024 13:41:03 +0200
Message-ID: <20240702114103.16068-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Due to having many existing users of wcn7850 in the kernel, conversion
of the hci_qca driver to using pwrseq exclusively must be done
carefully. Right now, the Bluetooth driver requests and controls the BT
enable GPIO and so the PMU pwrseq driver must not do it or we will run
into problems depending on the probe ordering.

Add a flag that tells the driver not to request the BT-enable GPIO. We
will remove it once the conversion of the Bluetooth driver is complete.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 42dacfda745e..68bcd6ec4269 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -22,6 +22,7 @@ struct pwrseq_qcom_wcn_pdata {
 	size_t num_vregs;
 	unsigned int pwup_delay_ms;
 	unsigned int gpio_enable_delay_ms;
+	bool no_bt_gpio;
 };
 
 struct pwrseq_qcom_wcn_ctx {
@@ -212,6 +213,11 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn7850_of_data = {
 	.vregs = pwrseq_wcn7850_vregs,
 	.num_vregs = ARRAY_SIZE(pwrseq_wcn7850_vregs),
 	.pwup_delay_ms = 50,
+	/*
+	 * FIXME: Remove it once the entire hci_qca driver is converted to
+	 * using the power sequencer.
+	 */
+	.no_bt_gpio = true,
 };
 
 static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
@@ -277,10 +283,13 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
-	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
-	if (IS_ERR(ctx->bt_gpio))
-		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
-				     "Failed to get the Bluetooth enable GPIO\n");
+	if (!ctx->pdata->no_bt_gpio) {
+		ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable",
+						       GPIOD_OUT_LOW);
+		if (IS_ERR(ctx->bt_gpio))
+			return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
+					     "Failed to get the Bluetooth enable GPIO\n");
+	}
 
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
 						 GPIOD_OUT_LOW);
-- 
2.43.0


