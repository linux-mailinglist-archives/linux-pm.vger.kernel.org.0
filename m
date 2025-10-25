Return-Path: <linux-pm+bounces-36817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E698CC08AF3
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 06:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E86A54EA8C3
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5E92877E7;
	Sat, 25 Oct 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6SvKMbM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3726D4DD
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366779; cv=none; b=WilNEyS4AvmjKn9tCaaurh0pVqa+LCvHh863GbcHswOKWVxZ2sHbrQIEdZmLY31/pJ5b81Dis0IpN+QDjbk+2k5krlcphjOIEJk5fV7bhRdvGcMiMAqpMUYDzZUpuuwB1MlTC9g2k17YyKc6o3G9w/GODpXHFl0lN1Vp70I/qiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366779; c=relaxed/simple;
	bh=J/zzc1ja43MRTCgO8LF4bp6opHtC/iF4Lw9TqE0/ybQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsIb2RpahFm72RKq8Wa8RDQht//oj9L0uqYtd13MCWdlnM/mseD3hPRt7djrDFe81FEMLx582ES4OOFi6n26ciDCoSqXft3VihEZvxN3OSRLLIucmNiNARnOFwbpPBrvQarHubH8kbp59pjubi/p+ppX6Q0cBv8qdPoHIb3l8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6SvKMbM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d0920e6so44922901fa.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366775; x=1761971575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU3qD3/P4X3aGl+GxoTABgHAWYmZmNCs4mQEkZTLmtc=;
        b=g6SvKMbMx5mK95nUcQ8Jn+I/cpwcGYIi26wVqPU/lWP4xMdse69QnKDcbuOdGaD3w3
         PCX9I/W2jOcGx10GSufAvchvpuxcYRW/sAd6WlFe1s9fMZ5ysWtJ18Ntg+f9tba+q2lz
         UaNL9Vfbm+xVLgGh5FVvHaVq9fSBAtDp/SIw8w4K1fupzRiUb4UrKvtp3DJNeN9mXYbm
         GPCkTz4CtA1JunK1dW1hRisRsS5aiSQoPsJ2NM/k2YA45pRC0H1whuToVmW/h8d4/H74
         myoTCuaaaFlDnXZqctENXy+l6rO6UaqHrfxahBmcUirPcuiur3lhUlothbIOYD4dOwqy
         Nkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366775; x=1761971575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU3qD3/P4X3aGl+GxoTABgHAWYmZmNCs4mQEkZTLmtc=;
        b=ZrhwQ33Xle1JeEfA9KAY5nXYhEaobwtgBSd9xl6ROxNDmv9pe262iZBDcKuqkVhcpd
         S7XsHwf+Qt66PIVV6RFm8woaxstYzdIy+wubf1LlR9ud/8VOq07bywn3v2NFP8KdxSjM
         qi4L4cHQgyXyp9UMYkgKD9Eu6C8JF1Qxg9Sxsf43gp7TidQZYRdwGnI1BsOYSf6LvlzS
         s90tUuKBMYrFHcZ/ga1z3d1OkzQC7tDGJzhCYfL3YM3fYyimI0QPK0EP54/lbv1ybBYe
         JEMab8F4O9KnV/szwfSaNDsTewZGqwCYIzIx5vypvpZaq1Wr/JH/wi+A9T6yGrgBavBU
         zBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbspG90zDOtVybDERIBSwpm4HZcdEp/FOb/4XT8YBhIUbLhS/wSbJom0cojSVLFmuN2R9obXA3ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UUbEIVAKcmLr7jmNd5Mv7iYaCAB+ZqSqCpl/NFY3JNE4RG/f
	k0J0AlxYHA5Ly2ch+htKVIBsgNjz/kX6oViwgkhOY3me0EB0ZejMP9md
X-Gm-Gg: ASbGncvVdd/aM6o/1s1/EJiFAynq+TAVq4k6ggpYQu+1pwH3OmqByA4HNNlB+B2425O
	i+IsAdYfmXcQo0aSs5EmC28Cjcm5DXX87MugWFrEjU1PddtD9jqGmI97JQg4TExVdm6yLygIoUG
	Bg75dcZ30Cml48MXlb9M5cxc2/xIJCbj/B9gFqPn1RpDLaEEaxaCg4MiIijKwTvUr8hkarX2YOv
	ktfaJD6MHQu2KHgKCr6ALhHM2+WhV3M1uXoNAATxcAlKJSiyL7jWoWDIVBbBTpgqeTuFCuz555A
	Y1Q+YXQeo10pxVpfTj32tsO832Dj54CpHgS58RhFrEFxvOyFWJyIVTaW5nCjp6c7pdXxPtjOiey
	Ev06rxYTUM4DYgCKvkUo/bJcWTRwqIytJDjTMq9T1lwDehj0HbVlnTisdsuum5KgBIiFRWTyVBs
	m7
X-Google-Smtp-Source: AGHT+IH/eF1EDfMQXoqCn1NhnMmPtXp6P1wcPRtuabMRfy3u2y12SFECgEV2LqHRoicJ+PYpOzbYLg==
X-Received: by 2002:a2e:a916:0:b0:376:4430:b545 with SMTP id 38308e7fff4ca-378e4648542mr13765001fa.49.1761366774636;
        Fri, 24 Oct 2025 21:32:54 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:32:54 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] thermal/drivers/sun8i: get calibration data from two nvmem cells
Date: Sat, 25 Oct 2025 12:31:27 +0800
Message-ID: <20251025043129.160454-5-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has calibration data in two nvmem cell. To be able to
add support, the ability to add data from two cells into one array must be
added.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 77 ++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index aa496e1ba..d6d8e13e5 100644
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
+		calcell = of_nvmem_cell_get(np, cellname);
+		if (IS_ERR(calcell)) {
+			if (PTR_ERR(calcell) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			/*
+			 * Even if the external calibration data stored in sid is
+			 * not accessible, the THS hardware can still work, although
+			 * the data won't be so accurate.
+			 *
+			 * The default value of calibration register is 0x800 for
+			 * every sensor, and the calibration value is usually 0x7xx
+			 * or 0x8xx, so they won't be away from the default value
+			 * for a lot.
+			 *
+			 * So here we do not return error if the calibration data is
+			 * not available, except the probe needs deferring.
+			 */
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
2.51.0


