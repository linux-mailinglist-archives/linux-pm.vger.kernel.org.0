Return-Path: <linux-pm+bounces-30067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467F5AF7B2B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8466E3190
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE332EF9D0;
	Thu,  3 Jul 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQQAN55J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B52EBB8D;
	Thu,  3 Jul 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555624; cv=none; b=oLEIlzhDs5A2ki5waFgjmtejetFCLhCsEaMpD+Z77IFzXMn4bhXzP/WWXRg7Q8XXMwEao4iS/SOzw8+2oQKLq3+eA8WIGRnJsK8E/49BGR6ZrFZMDoej5Ie0Uo1EFVEqHDs1x3IFk3OMFKsDAWn+ncESvaoMQc6fCRi/OSaZV/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555624; c=relaxed/simple;
	bh=tt5pibkTiOylBDZcb5XG/k6MGyyVGkm7PBa6bP2UNZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDpst8GgY7Es05zLlM0pErNFknNV2yk9xSqx4Q4MHQPRaZOGnvhc6lDhRtagFQmTbCWSjYHyuXyn0y5QorL0IM0OKxEJ8LrdvdJBLEhvAhbMCvSgpbg6WjiIp2MEm1jHXs/eFhYmcxmfjbjAGnzSGBXF9iKn2oynmPvNH/h5NLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQQAN55J; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55511c3e203so15837e87.3;
        Thu, 03 Jul 2025 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555621; x=1752160421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTtCCKdSkgMTplzEICqTViHzDjQLzZrHGfmUBwRIypA=;
        b=dQQAN55JADZ9RyD0jfYWKtp5zHyKVXY0JUk7j+oX31ZWvq2g4dpXZld/vMftrDX1Pb
         YiQVPxs15Azt1O7UlhPxFFrzIc/W+om6K/6UBm+pcIpCOVfbFvSIvjjpyYpP7umGqHx6
         1s+XoKmq+vUOtXqazLPlSpHHR9SPe+049/+96dQarAX5v6sXXD6ABrA5Uy6bPucNg1lj
         CeGUH+eOzLv0uyRHfngrl6pOnrSNcX/OPeoWAYfo/4BlFZKV2TJ4jrL7oszGQttpqGEt
         VoC/s24g2gL46fwApNikyqHYQU/0ip/K6H5Fv05MTbWW2JhcGvavlqWPrMs6kT2JVVl6
         boHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555621; x=1752160421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTtCCKdSkgMTplzEICqTViHzDjQLzZrHGfmUBwRIypA=;
        b=oxC44H7wIL58UlIbzqw84nnR5hdAAH54vVnVzSgtUvGbPynW3kN+6drUMBjewZM4cu
         oKzOxYXvwK/DThQrQolYAhvoSbYGUrQaCVK/dqZkksLfxOkc7+NDJ23qwBzhnamjgX31
         WXM8hVA3Q9PMpM7W9Uw+SFo03vWQoWBiAwsH4bo8Y5qH3gbpfQiuU1QpAdwIhPzpB/gb
         4gHYUStsoqRYIxp8lH7KuBT3JPXSFx67PgkcK9qdT9oMnzNeFZpFyx3CWS9kgrgHNZ3o
         oLRrYP62vfedkAmsfcbxh4wYVoy1JAMFE0pDJPAetY7xV9sH0iMUByd3ANs/P4A8OIzK
         9mJg==
X-Forwarded-Encrypted: i=1; AJvYcCUyzPJ2jiZs/bYaVW177yaD3ICOqAVQHbhV/XU95W4IZfOAhXG6lrpa9CuCMmpqfvIIyPqf5/TFKxsBEJQd@vger.kernel.org, AJvYcCWbo237Y2mRyCgglhpJALX6xeGPHhhUnc9QfkaY3Dof7gEE3Ht8X3HRSkP1pdiAAmQGnVw9rTBKc+E=@vger.kernel.org, AJvYcCXb8SUqn79jYFrtd5dLIwhdM5Z/Zit79/uzV33sxPAfpp1m0+oLkJefnyTJQjl9IPvywP9fg7OauthK@vger.kernel.org
X-Gm-Message-State: AOJu0YweDmifv4IutRywZYIsDTxMXReyHMyai5JMpaZllQGu0JZKWz+H
	LOxgz7YMWLxirmVXkdqZ05OpvqPsaBS6g6NJaDk6Ai9dzs93Fbtx5qm8h/Wl8rl6+8KSrg==
X-Gm-Gg: ASbGncvkhfQDsVHSbypFhKxLRkrZcLqYiqZ7RcwU1Fxm0KvIkrxMOKfoVPDwVNkXwuS
	6skpLM4sZToM+yD4ySDMX096LwXxmm0YziM00Ovwq2kM32FjQ981jjRdd3De8YjdpbAqHR1CRht
	Q5flUTG79jdhYTcX0IojjC5lJVUiltNRxP5mxEeOhb9iX7Qcr4D7Ph1k4BhX8GXj5VSW9l3eX0T
	wJ0e7L/iCQm/FttAP2hf9STA6hbN7ZsizF2a1EuffifzWxH4zqHEGZyuUYZ0yeaqy6WeViBg6ra
	CctGJRA3uTX+hYe5+5nqdQcj3JGxUgXpcT6bqPJIbTXaTzjgUoy8edkhLDa1WKY1RQdjO60=
X-Google-Smtp-Source: AGHT+IHEoQ3VBnGpUAKadTkkygNlVfx/f5KZwlHVuHvFboG/MKYSU/fiu0UHxdI8WmXTbNEBc9ufgw==
X-Received: by 2002:a05:6512:b12:b0:553:50f6:ebcd with SMTP id 2adb3069b0e04-5562ee80659mr1189950e87.10.1751555620488;
        Thu, 03 Jul 2025 08:13:40 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:13:40 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 5/8] thermal/drivers/sun8i: get calibration data from two nvmem cells
Date: Thu,  3 Jul 2025 23:11:29 +0800
Message-ID: <20250703151132.2642378-6-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has calibration data in two nvmem cell. To be able to add
support, the ability to add data from two cells into one array must be added.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 77 ++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index bdd15ee45..3f57f1a6b 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -303,43 +303,70 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
-	struct nvmem_cell *calcell;
+	struct nvmem_cell *calcell = NULL;
 	struct device *dev = tmdev->dev;
-	u16 *caldata;
-	size_t callen;
+	struct device_node *np = dev_of_node(dev);
+	struct property *prop;
+	const char *cellname;
+	u8 *caldata = NULL;
+	size_t callen = 0;
 	int ret = 0;
 
-	calcell = nvmem_cell_get(dev, "calibration");
-	if (IS_ERR(calcell)) {
-		if (PTR_ERR(calcell) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		/*
-		 * Even if the external calibration data stored in sid is
-		 * not accessible, the THS hardware can still work, although
-		 * the data won't be so accurate.
-		 *
-		 * The default value of calibration register is 0x800 for
-		 * every sensor, and the calibration value is usually 0x7xx
-		 * or 0x8xx, so they won't be away from the default value
-		 * for a lot.
-		 *
-		 * So here we do not return error if the calibration data is
-		 * not available, except the probe needs deferring.
-		 */
-		goto out;
+	of_property_for_each_string(np, "nvmem-cell-names", prop, cellname) {
+		size_t len;
+		u8 *caldatapart;
+
+  		calcell = of_nvmem_cell_get(np, cellname);
+  		if (IS_ERR(calcell)) {
+			if (PTR_ERR(calcell) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			/*
+			* Even if the external calibration data stored in sid is
+			* not accessible, the THS hardware can still work, although
+			* the data won't be so accurate.
+			*
+			* The default value of calibration register is 0x800 for
+			* every sensor, and the calibration value is usually 0x7xx
+			* or 0x8xx, so they won't be away from the default value
+			* for a lot.
+			*
+			* So here we do not return error if the calibration data is
+			* not available, except the probe needs deferring.
+			*/
+			goto out;
+		}
+
+		caldatapart = nvmem_cell_read(calcell, &len);
+		nvmem_cell_put(calcell);
+		calcell = NULL;
+		if (IS_ERR(caldatapart)) {
+			ret = PTR_ERR(caldatapart);
+			goto out;
+		}
+
+		caldata = devm_krealloc(dev, caldata, callen + len, GFP_KERNEL);
+		if (!caldata) {
+			kfree(caldatapart);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(caldata + callen, caldatapart, len);
+		callen += len;
+		kfree(caldatapart);
 	}
 
-	caldata = nvmem_cell_read(calcell, &callen);
 	if (IS_ERR(caldata)) {
 		ret = PTR_ERR(caldata);
 		goto out;
 	}
 
-	tmdev->chip->calibrate(tmdev, caldata, callen);
+	tmdev->chip->calibrate(tmdev, (u16 *)caldata, callen);
 
-	kfree(caldata);
+	devm_kfree(dev, caldata);
+	caldata = NULL;
 out:
-	if (!IS_ERR(calcell))
+	if (calcell && !IS_ERR(calcell))
 		nvmem_cell_put(calcell);
 	return ret;
 }
-- 
2.49.0


