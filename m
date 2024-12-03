Return-Path: <linux-pm+bounces-18470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8E9E2774
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE250B26DA0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ACC1F4277;
	Tue,  3 Dec 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ioZjjVtK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986991E411D
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235187; cv=none; b=OV4dKGVDcx73CjmYyZMaUFjfngMs8xG29yP+ZZQD40HSQwhEW0HDdVS+U9qBp2YTfDoWCQ3/qtVWpaCwGb+xeRWUaHHbSMqgkknBRUGH6bS88ea/eEW+ebdm99KNSlld4+2I3qRe5YBta5oqVYV1lpNq9siNwam2Ah8KAYFB3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235187; c=relaxed/simple;
	bh=0bxsI4AI0INR0NHt3W9lttgxcRuou29i0QWVno7TzYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnzJSnd7Rw/aZEMnNFCrgjnjdvaEuWVYxmzFgKoxHDmQSsfjjtXXV3GmzFb8XzLb5rDAkrjy9l1fIqF3r+Trk6yTbUf0HvfvM+5VTpmo70OV5pVNzVAxKWGbZhg9n6xtWpB0VVVzyFxGpO3uBAxFLShq172X0OI6ZlcfLHfWGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ioZjjVtK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso6078672e87.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 06:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733235184; x=1733839984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRfctHU36B//m/17IuCPJ4O8WijMI9yeHi6VQvqDOh4=;
        b=ioZjjVtKXfgJ4lLOUluY+kKIM26dAJuZBpoxy4tQb8NdApDs36Sv4iDIPAkEZOEFAJ
         3oOau/dPnn2XK4VKL/lg2bGM7VBoqWFM4mktr5OKAOTNGxrS4pRP4MhcC22y0hJF+pBX
         gwdpNTcmv6nROzfisbjKg2NwuvSiTsOCEpvpIToRmd/fvfpJb/3are+3Bk8nBOEHBXyO
         l7UpjGJBYM3pjKweMWGK5LbxoeGWtQFrYR49D0ivmMRpCqxCdySOq15WlgZak4JB9IIm
         uM/PaS2HMqwNLDi7+rrMA2Dw4lUC3gDoSPjT5y1vYllzqZcDvNnThhs97NG1UbCnhMgU
         gWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235184; x=1733839984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRfctHU36B//m/17IuCPJ4O8WijMI9yeHi6VQvqDOh4=;
        b=VufoEAfNmYWpu23ucFWwpSagQuIUIYkKcT5pfQpStSra7DTAMjJS/E7WE7QClIe/Fu
         cvnIJW6pfBmC/HxIAsrR5s/eOnVr69SOCuOejbpG78j7MxXIsn0i9ptDCnGjfmdmDsEs
         Embnt3aYWQFS+pom46jcgFYHK3uX1utmKJp4p6LBCSWYuolQpih8c7BoTVt2gvuJZ4fG
         A/zsL+lRVZuwAlhf3IAIedDFWCnSyvOrv1cZOYvJTQEZ284KDCjDJXJ6hDpRho3AQHuv
         2FQqAXiX+dLu7y/lmmGhGJWUQ9nd6cGwk9VoxDu0iF4YPCHiH281oA8UnvhOn0Fgcl0b
         ImCg==
X-Gm-Message-State: AOJu0YwbOETd4hs0OcgyPRy76yl76Vhl6jUEnqQMZyBveQxPAmiSwkxo
	JsEJ+UzKeiv9z1Z0E25t7RVmVBEzz7FP9hsDrf4wdXTZNf2mnTh+XRI7XG7Ur1Y=
X-Gm-Gg: ASbGnctRp7LH5Yh3X629rcT8fws0Iv42urNfYZFs3W/Xs01QhTlqUpY3VFZkX8EgY3V
	FrRk7DRRrXz/u9LjWAhwACY9kMtIer253/9kkdrORajlOelisI+sxq8017zPuhSfDR6JtPox/C5
	TtNwxJMxo9WGZU9ZeHVikE2LYBkLvAGHgqzunDLyMLDeuQwNWfUt7CX0rJb+4R5gv/4MzoxpNHM
	o09HtHabMA5TfkdCt2o55xVYKZS9x1x8OdCJqylbezCIbL6DNbHuerWKMM4HIigZY1h7nDAHDl2
	pBMGWTTecQJuaw==
X-Google-Smtp-Source: AGHT+IGYkErt1vzCnl/QEMxSdD5HS1d3h+rMe7TWGlIe+ZMd9qjpsDjoipmrdzvNvya4uf+aC0BgJg==
X-Received: by 2002:a05:6512:81:b0:53e:12c3:a29 with SMTP id 2adb3069b0e04-53e12c30a8fmr899530e87.19.1733235183565;
        Tue, 03 Dec 2024 06:13:03 -0800 (PST)
Received: from brgl-uxlite.home (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6431229sm1860857e87.7.2024.12.03.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:13:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH] Revert "power: sequencing: request the WLAN enable GPIO as-is"
Date: Tue,  3 Dec 2024 15:12:51 +0100
Message-ID: <20241203141251.11735-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.

With the changes recently merged into the PCI/pwrctrl/ we now have
correct ordering between the pwrseq provider and the PCI-pwrctrl
consumers. With that, the pwrseq WCN driver no longer needs to leave the
GPIO state as-is and we can remove the workaround.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 682a9beac69eb..bb8c47280b7bc 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 				     "Failed to get the Bluetooth enable GPIO\n");
 
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
-						 GPIOD_ASIS);
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->wlan_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
-- 
2.30.2


