Return-Path: <linux-pm+bounces-24497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA666A70A8C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4732217A60C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26571DF98F;
	Tue, 25 Mar 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfS0eGJe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4719049A;
	Tue, 25 Mar 2025 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931043; cv=none; b=GWa3Q3ycOUcWSXNutsgeNQVoJT18rUPWY43pCTyhUV9Ydvsq54A2CC6bcMpHd5m1b3wYshsCo6DBMcqIe8syap1QBD8fcaQ9Kz95HgoeQFhDM0GiLFhr2Y6px3azp0QiHS7vNJ7BATZEwPU+BL+qAHJJBbXK/ldw26qUkl6Z4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931043; c=relaxed/simple;
	bh=V8M1FIqocDVgTg/Qhn+pCa3avFJiRNIIhW1vxEi3fyk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0M0+qlAbTPGyeK9SqvXgD9TQXRIZt6G7UPD9ZIKJxGv2PlaZFOjTLONtClVhREdOIgZcWyBF2C+hjQMacxW2qTwa1KpFJEghfbllufk76DAXeekqEXcM3J94XCbJnJJtUGuUmfAtpxGh7ILSRlNIJIpwtb9MpyGeXUwe6sifbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfS0eGJe; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c6ed7ec0a5so1679056fac.1;
        Tue, 25 Mar 2025 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931041; x=1743535841; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4W8NwGIv3g9q9bD90ERb4CwpLXg29q/gl0kZGMFw8mM=;
        b=VfS0eGJeFTdeJrV9qZN3LifrY1/PuswrTGeRCXGF3+a+ua9Ls1A3y1vU5Mm8seF9Mn
         kow7/dBf84SMK9L5iM1f8FT9QpOAwSz4i2KBb0x5Yyo2Xygs/zsmvkJeD2S9stIbOzH2
         p7gOygpuW4WpAlk4V9VRS4rX0q5x+f3Aj3gt/RuNFgsG0VIC+KqCCsqJiRS1tidMMKWA
         RC4hCA1NTUwYRt3fPmJRcFYBXEEUybYMyXMTCIx4zRDh/dxcCuTjpVzHkrPt/tGGYvwc
         7AiuR7WAH8LOgKEQCFQ5FdtozuFK5l5nwEgZEdE9Fba7vRTZYJqB4tyMwghC5zrTcH3v
         1hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931041; x=1743535841;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4W8NwGIv3g9q9bD90ERb4CwpLXg29q/gl0kZGMFw8mM=;
        b=d90AEH/1+fXPNnG1dnrLydxWF3RIH3vWNIT84pYeA4GwDt1FiKazPZGJGe+Vxe5giQ
         UfBQdvzYzjwPJCD6MqGSrnMCewzyay+dgJ06sqQkaIbqZ5YeK/q0Aq/t8iz0fk6YhWMB
         UUv8xm4iv4hZGM1pkDJGfbJIu9xkDVrAtaUT0GssjxM9TM4fxwlN/3YNorpnvFuzxsQY
         ob4pYC2t6ENeFA8w1CeN+AHv8TseWZhq3CGjNF4tzp0uUvxygiaVWy7MKvmLrja5f4/1
         pqsrXYacfLoH/aoYDJUSc5ci3mPyp/+reBjDps38xroLMdJRjuLhV0PRwXxA5DDXLz0D
         S52g==
X-Forwarded-Encrypted: i=1; AJvYcCUD9Pqbj9j0tZzeD+UjAjpWsPArUPnQ2VMSacsp6I9ReiOwii/oC6gYZqWyg1DSBj6dBaJbEAHJ8O4=@vger.kernel.org, AJvYcCUe3IcUAbir6HpU2YHKZTn6DR7HqNv7dZqvEFuspVDVJgv8w4+YYmjZJbgCTf5E++EsuXtRj2wQVwMcvBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GF/9+9MpPSGzdJju1vhBUYrI/oXUpCQwHvpC4Ve7ZjVGWHss
	iqkSdb3dKW4gUOWtEA7OslbmglsHYYKUiAp7VeEyW+4fy60MLOl7RZcCGgbb
X-Gm-Gg: ASbGncvzbgp/DxzHxiUZUg35nkTwI5wWnhieri7w0g1+ECLeenc68YgyBytJuI4QEZu
	XBwgQeVj4LDf97XYikPv99iPviJB2Vw0z5QYSmB2tGL8enpBobafyZd5dw7BSF42vHC+MI4EYKO
	ATHo4C7DbuKpMdKmpiUsTlYWeVeQFvuTgWZq4wB0TKq++iPJJkc4VZnT7p2yJz3aP3N6DsYDylA
	/JMrudJI4rCSnlC1UmJgWruTIPbGqu0zHZTARVbOFQJkf2IwHT5188SKs1M0uEyYApKQUzepadt
	50lnnmNSbZtyDE+lwlzhXoiRh/S6fmXd6sAkooRJf+Bm0g==
X-Google-Smtp-Source: AGHT+IEwsieHitnF5P9+HL5fGRcvkWJOdtlW3j2FjuRo8vp7AE4y1CEzqZ9QMeBYn1I8NAM+YMV68Q==
X-Received: by 2002:a05:6871:8301:b0:29e:74a0:e03f with SMTP id 586e51a60fabf-2c7804c7e14mr11154768fac.24.1742931040920;
        Tue, 25 Mar 2025 12:30:40 -0700 (PDT)
Received: from debian ([200.92.175.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0f6825sm2644934fac.43.2025.03.25.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:30:40 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:30:44 -0600
From: Enrique Isidoro Vazquez Ramos <kike.correo99.f@gmail.com>
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: amlogic: Rename Uptat to uptat to follow kernel
 coding style
Message-ID: <Z-MEZNMLUmj75uxN@debian.debian>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The variable Uptat uses CamelCase, which violates the kernel's coding
style that mandates snake_case for variable names. This is a purely
cosmetic change with no functional impact.

Compilation tested with:
- checkpatch.pl --strict passed (no new warnings/errors).

Signed-off-by: Enrique Isidoro Vazquez Ramos <kike.correo99.f@gmail.com>
---
 drivers/thermal/amlogic_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 3c5f7dbddf2c..5448d772db12 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -7,10 +7,10 @@
  *
  * Register value to celsius temperature formulas:
  *	Read_Val	    m * U
- * U = ---------, Uptat = ---------
+ * U = ---------, uptat = ---------
  *	2^16		  1 + n * U
  *
- * Temperature = A * ( Uptat + u_efuse / 2^16 )- B
+ * Temperature = A * ( uptat + u_efuse / 2^16 )- B
  *
  *  A B m n : calibration parameters
  *  u_efuse : fused calibration value, it's a signed 16 bits value
@@ -112,7 +112,7 @@ static int amlogic_thermal_code_to_millicelsius(struct amlogic_thermal *pdata,
 	const struct amlogic_thermal_soc_calib_data *param =
 					pdata->data->calibration_parameters;
 	int temp;
-	s64 factor, Uptat, uefuse;
+	s64 factor, uptat, uefuse;
 
 	uefuse = pdata->trim_info & TSENSOR_TRIM_SIGN_MASK ?
 			     ~(pdata->trim_info & TSENSOR_TRIM_TEMP_MASK) + 1 :
@@ -121,12 +121,12 @@ static int amlogic_thermal_code_to_millicelsius(struct amlogic_thermal *pdata,
 	factor = param->n * temp_code;
 	factor = div_s64(factor, 100);
 
-	Uptat = temp_code * param->m;
-	Uptat = div_s64(Uptat, 100);
-	Uptat = Uptat * BIT(16);
-	Uptat = div_s64(Uptat, BIT(16) + factor);
+	uptat = temp_code * param->m;
+	uptat = div_s64(uptat, 100);
+	uptat = uptat * BIT(16);
+	uptat = div_s64(uptat, BIT(16) + factor);
 
-	temp = (Uptat + uefuse) * param->A;
+	temp = (uptat + uefuse) * param->A;
 	temp = div_s64(temp, BIT(16));
 	temp = (temp - param->B) * 100;
 
-- 
2.39.5


