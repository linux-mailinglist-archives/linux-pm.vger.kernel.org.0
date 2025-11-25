Return-Path: <linux-pm+bounces-38595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24161C853BE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B6124E9E84
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B623A564;
	Tue, 25 Nov 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LxdVuKl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D221C9F4
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078427; cv=none; b=SA5shFewE4Fwz2TYf4mUCgS4nWLolQQiOi06NNgOQCFBD0jyqK6KHaY7zvrh0gfy2G+O4Ci+0Z9EZYsLl3inyFRcsH0dkGLJ/h/Y3v48XV1bfv+w+YTZUtBfuTyrOa059bXC2xxsDCj2bcsLfIiVZr8KxU+zRK7BU8kSpx//qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078427; c=relaxed/simple;
	bh=KEQFU7OI2vOZ2XEN6wAtMfzsdlEWHw/1VFIzyeTL73I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adjgnUWS18yF4jFx+p92hr6T8w+QxPmjfbT0AazSKUH4MdunXZ4MBHMVX7w6VOoY1hIEAKHNXhhOTRbUQQZQeZA8/Yl0+O18mpOZS4i1QCE6vkSiLiCJ/lMPcyhuOb5/wn2EzpaOlWJsRkjuobceIEDI62A8RY1kq0ArIWI2/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LxdVuKl0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47118259fd8so48604005e9.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764078423; x=1764683223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuLUlee2qTjguKBRn8Jjr6ZSUtU+7Vzi8xHny+2sQtk=;
        b=LxdVuKl0OEF8xQ34gi5D214dQWIbTt1D+z/4PtHYA8gbBT7W61P8qpOxRD2pn3O1ew
         /+lhoEC3wGMOYrKy34pI1wywdBdyCscfQPq3K8qtRZRPWWSmzamAZq1sptn2Ow7bOFzb
         s9oy0cJBsrlLx0xFBEa0+YxzNJVeAGAOpERCOvRPjS4TdMNNEqr2+pJdrUH/E2xXUvQ5
         4S8pezkeqS6NbZV19/KrnO+FYGbpMbMNjXW0FnNmdwca5X2pdwv3b2nMrYi03e5NN0f8
         59nkrYtEjXZ2/1uwbp39UnTW7RavZcoM4RQMKGO90tVQ/tJMsIsjI6ci6/nsa6IVQC5e
         BUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078423; x=1764683223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuLUlee2qTjguKBRn8Jjr6ZSUtU+7Vzi8xHny+2sQtk=;
        b=rYkyn5KuPCLUivrdy+vNhHCxo3W7/17+BQTeqPHx3jP0VYM78lsDh+2E9CpKuZS0WW
         i5VJh0nmtAkUgT74ECdpZxaBHsktFxWUyTizgGr5x7L3y8v2bjHY0tMZo+ZbOMMEwCVP
         y46hJYkC/1634Hgw10oTUcecGEQiTB+0aqmm6bBYWZzfO3bOWwY40dRTyX3oPpvtiCgG
         /BKupUDEALIc7FdInpxbsF0ntpuHoWxn+i5tR2f05zp3dVaBJAUsNV5lNVAdFe3ufGwj
         XPB5K/LiltL/ILzIdyY3yLFw0+ghzkaf+c9VU+mNWn7r8ZzrOy+TAHD0RO9BYzEngPha
         ugvQ==
X-Gm-Message-State: AOJu0YzmZWWuwkgeK+64emLmnfVW5w4FvWXAHX9js4S7/ztISEcOXhIE
	uAB85gpmWqAlP8g4ZzGc02YJeYR+RFoxWdCFr/o2PPDEvCHUHVOCrKnV6mJ8I9KCt6RKVI1Ookx
	M2iy0
X-Gm-Gg: ASbGncuJa7pcabhwe2aWTuDm99Kslc5L4FfpFPXgaXOEsvWgyki614VNtSE/7MDhc2R
	qNJFi3idu1GGI8iYzea3eDUXicy/ytG/IDvRu3ULZGMVU/f2gLKEleD3AV7SzIiPb+z3bCOMZPH
	SHnbk0N1xNKV+efJueBsTTXzO5+x2slJc7eznJfDVn0W0HXKgxDQHW2h9SLGRj8xcIxjk1BFQd8
	HRHpovz0y+ikluXTapit3CROJN34e4MTg4MVW+q93cWdd2NtmFX0lsMXJHPdjK4UrVjOpw5v98M
	myWNIL2jkVr0ih1t246qQCGldStKaWhYOdRGDIlTNb5e0KrrOxSaO3gdnuu01CyaVb2AKjiu8TH
	5+zmpHyLN0O4ur8KHBwfG4zJvZjPYyiLPDXp9cfRDQYkPYeV6P8pb74E2tyFtHWmP1/QYc5dFal
	KW8hDq
X-Google-Smtp-Source: AGHT+IGi4EcMrjBlksCLyycdvlrg7Yix+I0DacooX0H+CkCNHSZBtY6zFdpBZ92P45uXfmddFlxV9Q==
X-Received: by 2002:a05:600c:255:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-47904ac44cbmr21213615e9.3.1764078423297;
        Tue, 25 Nov 2025 05:47:03 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:df0c:79ae:5345:c3b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e868bsm244973485e9.4.2025.11.25.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:47:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: use device_get_match_data()
Date: Tue, 25 Nov 2025 14:47:00 +0100
Message-ID: <20251125134700.29135-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the generic fwnode interface for retrieving device match data
instead of the OF-specific one.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 663d9a5370653..823f68ffebd1a 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/string.h>
@@ -373,7 +374,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 
 	ctx->of_node = dev->of_node;
 
-	ctx->pdata = of_device_get_match_data(dev);
+	ctx->pdata = device_get_match_data(dev);
 	if (!ctx->pdata)
 		return dev_err_probe(dev, -ENODEV,
 				     "Failed to obtain platform data\n");
-- 
2.51.0


