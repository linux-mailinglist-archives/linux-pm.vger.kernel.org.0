Return-Path: <linux-pm+bounces-13304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B6967810
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84709B21208
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20730183CB1;
	Sun,  1 Sep 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObAanHGz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EA33987;
	Sun,  1 Sep 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208044; cv=none; b=Wds3WF8egsQn0PRaB9GTkm+AAEe0uPvM92ZGG9AO18KwObjSsYs4y1dbqgSQ1EfS8/Z8JJxVcQ50oS+b5XJwnmGMLd3Brr6VxRciZRGxbEdJ6PcSf0GiPrW0jpclnnQVlCR13GAL6jfiySiN8/D432sKAjp00Orsq4Y0Yqt7E24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208044; c=relaxed/simple;
	bh=e/LKTV7hMZEHn95toU81B+LDFOUu3I/CSU0QsKDRkTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EmAgL64EbDTgzs2gR5cwkQLeoT5GPVs3ivqHJhXlpYGncSlA34OJk0NodFc8EpYl/YvHSeX5n5lENqarRkIfAyrjhb3KUIZJBEE8Ec/l1k/ZEm4dAdghonNxmkTc53cLRiTzBXCmU5+VurGiVERMPojq11eX2pqBkxgtQIJYdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObAanHGz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a869332c2c2so715811966b.0;
        Sun, 01 Sep 2024 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725208041; x=1725812841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYkCsoCLWLw24xCZo4xi+SGoWPofV3x//tQ3lm2KoZw=;
        b=ObAanHGzjcbcup/WE4wItwGjmP8KONktM1v75/IC1WB3bwKaDCAGQWUdY3RuqE5Sku
         E4o0HfoIukGtrXtU1HdqC9Vbmipe2XRpX9YRXayi/4oeJa6T99kx4dS3raUmqwKZWtyV
         nlQsaOgoUMmkGCx0YUyuEcwbhg3hdm1DKoL7HpYTx6fbYHs7GQMmw04+tZ16ZqtSHrQU
         rLLgj5eEOHPOMqPB/pHhgsMREC+nM2v8iNL+A0RaEhNUH5xqNis+uUHPgX1sJaO0OeIO
         DYf1SfEsQ4TtrC+d8e7ptfKMd3ytO8+gahYzXiqCwzWiSkNapeEXJfj5YRQ2QsM7YOt1
         svIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208041; x=1725812841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYkCsoCLWLw24xCZo4xi+SGoWPofV3x//tQ3lm2KoZw=;
        b=JKQ9bRAgjVGGCqpZoiR0iE5a3MowMNafWMV6POQWUZNg01zt8oXcLlVFraZO1oWW77
         mMLYmiIhq/5ZEoJqRyuZVv3xVVi0d3a5EOZThxYl+f9EZ1tHX9ytSnOwAjYg8MKLi8Ys
         YZ11Iqmgv4bGH65DzSsv50aWwAsg4VeTw1tdWt0sRZuGuRKgvIt/93g14TQw9VaGJcz5
         g1spqL8sutmaDSddE9R72ZnZ6h3fiAy5vaHkxCqDIEexBy8Wi4F/fHoRgysf9jm/GhiW
         I78tv/XdL/gqsAWsT8YveqyNxY95EJddU9Uqks/T+gcMk2XbXeYhMUuG0/MflIUhyvwK
         37hg==
X-Forwarded-Encrypted: i=1; AJvYcCUBFUv9WZv3emegbqTdWjB88ogSfQTZy+sIR4v7uGWZWrfGfpLdCVtEr7jcCeqBStPKlqFMpu2kbPnVBc8=@vger.kernel.org, AJvYcCX7/3fIcd8ywh1ZZziONLBu7JVLeaEYHLzLxhFe9Mh1A8MQDAmgtVsaKKb7L4JHvVxEBsbBevPUdA+uLZUUhzT4YvM=@vger.kernel.org, AJvYcCXJ86F/ty9D5k8lO/ECOBJAGUjOU03hWVnzM03VRM6oOWqSBqfFW5szFrHsY1QsUhl/46KXHF29LH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahfWo9c9iKczCSJuoJsUtyqVXWUNT+ajVJKdj7d2B1DfFjVfj
	n4QoG+qQLrbQ0WrZtFyeo4BbRRpr1/eOtcMD6Zt7k6hcYyenJKVt
X-Google-Smtp-Source: AGHT+IFWkGvJc84SLUoPtIrjnB5r9CffAAjDGAjDj4l24UeHZVQNZST9WvvOPNlCX/91/n8v2sc1OQ==
X-Received: by 2002:a17:906:d265:b0:a86:91a5:4d09 with SMTP id a640c23a62f3a-a89a2927b2fmr854988366b.26.1725208040548;
        Sun, 01 Sep 2024 09:27:20 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fefb60sm454888366b.43.2024.09.01.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:27:19 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal/drivers/renesas: Remove trailing space after \n newline
Date: Sun,  1 Sep 2024 17:27:19 +0100
Message-Id: <20240901162719.144406-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space after a newline in a dev_err message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/renesas/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 1e93f60b6d74..ddc8341e5c3f 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -447,7 +447,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
 				       IRQF_SHARED, dev_name(dev), common);
 		if (ret) {
-			dev_err(dev, "irq request failed\n ");
+			dev_err(dev, "irq request failed\n");
 			goto error_unregister;
 		}
 
-- 
2.39.2


