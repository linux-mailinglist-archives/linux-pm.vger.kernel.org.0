Return-Path: <linux-pm+bounces-24377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF13A6BD06
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BB189080D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187618858A;
	Fri, 21 Mar 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ltio/Pf3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE61C863C
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567652; cv=none; b=ur8ky53dWSOt8m6OeJCuUL6qXFPPL8grCBbnDIo4v0lbA8WJZYUPaiqrd1aDPH+0lQ3EVJASsVSjLGzRzaSf5oe4hzGxI9VA/XkNMX2Q8Ar5uwQhXkG+ZY+9f+jJZzNkCeUpopoPTtiAQOjyP7bTaPpGsEqpReYRe1AuS6Bq7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567652; c=relaxed/simple;
	bh=tlQRpQpjQvic1qXez0/nyHsRFfIfy8pmEkG+XWvnph0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EO+YZv4oMCKCwF6o79U6Je7OI464ZNiLA8caeieDrOc/DrwHhHzyzUJN4bTKPX0dh9e4Ydui9o+H/WzAJYpSkcugq/uwAds6snlbZogSC/4gUj3hbu1nyVXhiVuB6q+HyoSlRLitGa8uSdb72Lwg+EjfpuKxpa1ECcAH00Ehw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ltio/Pf3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39727fe912cso789100f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567649; x=1743172449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn5MV4p4HQ7G2Y8DIgL0c1yin6zEacSDQc7QrsuKG8A=;
        b=Ltio/Pf3s817w2OksunZj5dFPRNLvBhk9MxCJBk4AA4INGjXFYC3/t9dU9uLmUgez8
         klXGhhmR/puhRfNZKfi3vlKoT5aDjoOsGG87LN1LwaT500GLrVJf4ExC0nGFWNke+Z52
         EHKYx3tuiS/wciaI/HbvvBaIxXFqDayvmhv6uVnhGYPzEMxYeQGsEj4DOD2Xba+EqsWj
         rJDZTo5x0yMVLI/BWU/tzNYNwpugCA3T4nh2N20HwT+VQXip1ZdLjRZ52/wL5LzI0YYb
         7TdcCxqYfpijHKcxPSHwHYxey880umrMvn18MIOzX5E5nZA2YD41UnstS/fuXl0DGQrs
         9Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567649; x=1743172449;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dn5MV4p4HQ7G2Y8DIgL0c1yin6zEacSDQc7QrsuKG8A=;
        b=pXWfKMxZdn/KWURY939abrqlmIBjnjLNupbL3DAVIz5m50r+0C7g6cdhPeWuO1MbEa
         pPb4ayuK66vpbhjzLu3ay2Xv2JSnQgC5VrKOYF4nFYmFPbiATb2vqxpFADmzxbt9TBlO
         OqoelgO9FtVPgRk7Axs1N5kYBaHMTWRzXMFDzT+zp946twD0H8eup2N6rzpR2oTZtRRQ
         +YRw4049PnIGmMo0WZASW9C+uEzRPx+11GPJPqIcjXT6xHukEDxQtrhEGGcNa5P+jWSR
         kEPPfJxRv9VvHf/LDqkEgGGknyrEQqBXnkXEygFapvGbxO2jzUE8no6DwlukJ7e2czVW
         ia6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEUVu2xpvCgL3+R+93weo7ASCm/7mOEsRUGI8abvppCHd50BFHFjW5XiYG3NgEPb2ET0Dn57arQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2RuPo2nJqi7CVvhB6dob7a9CD0z6ppLJqj30c4mUC23tOm66
	brFCkG3I828iCWNuJmynJuJqDGwncKXh9PeUw29vyKhJ+BAK8wpmgg1UTAm/8/k=
X-Gm-Gg: ASbGncuMvX0fgYGyvkSVb756hVDUVz6Au5p8SF8Mw+MA3xwszizQKlKMyvZjaU+dMGJ
	9PQJxHKr6VeRLmze/76QXBGSHjcsvdeUYgvxGfVJZIua4lR9YeNLj6vS8LNcYABtlkKZXk4lwtZ
	zUxmMjGAMgbCLi47NUcAWBS8qsPOIW25m4dNNwoAP9t+BwDQvURWJGyOVThAEXpGn3t7yMlMM3n
	QB4rRdlv3q+GeGyBXf9vGMHeoUU3/YKlI4L2sGVFh50BjDFR5UixXN8rYHUfkS7xcPdj7yAXZf+
	gMH1yEAif53QRj6rGIHLukbiut+/80aGo4Saw1CMaP1h1HikNg==
X-Google-Smtp-Source: AGHT+IGxt6h0dPisO3HhNUj6iUzVe79pzrQ1FxQp78Ey1ug+TmaSuEtDysT8dPdfqLj+8Nbo4TB4bg==
X-Received: by 2002:a05:6000:1ac8:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-3997f937b82mr4553904f8f.53.1742567649021;
        Fri, 21 Mar 2025 07:34:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9b260fsm2484221f8f.43.2025.03.21.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:34:08 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:34:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: max77705: Fix workqueue error handling in
 probe
Message-ID: <547656e3-4a5f-4f2e-802b-4edcb7c576b0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>

The create_singlethread_workqueue() doesn't return error pointers, it
returns NULL.  Also cleanup the workqueue on the error paths.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/supply/max77705_charger.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index eec5e9ef795e..329b430d0e50 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -545,20 +545,28 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
-	if (IS_ERR(chg->wqueue))
-		return dev_err_probe(dev, PTR_ERR(chg->wqueue), "failed to create workqueue\n");
+	if (!chg->wqueue)
+		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
 
 	ret = devm_work_autocancel(dev, &chg->chgin_work, max77705_chgin_isr_work);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+		goto destroy_wq;
+	}
 
 	max77705_charger_initialize(chg);
 
 	ret = max77705_charger_enable(chg);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable charge\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to enable charge\n");
+		goto destroy_wq;
+	}
 
 	return devm_add_action_or_reset(dev, max77705_charger_disable, chg);
+
+destroy_wq:
+	destroy_workqueue(chg->wqueue);
+	return ret;
 }
 
 static const struct of_device_id max77705_charger_of_match[] = {
-- 
2.47.2


