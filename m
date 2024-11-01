Return-Path: <linux-pm+bounces-16882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF59B9485
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 16:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64AB8B21708
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7F1C8FD2;
	Fri,  1 Nov 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oSh9/6T3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511531C6F6C
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475410; cv=none; b=g+QnuFmKmuNJC1h1DrHaJurLQHeLsvV/Bh9CMgSXyAyrSgNZCAy0XC42u/tCM8924H8/euT+510lys9P3Xi5xXomSoC+X25oQHWoMhHG5C+j12QRzxvvbcOUMy5rTvudtiyfZm/I8/ZqMy4mVuWokwcbwKqLfHwB+UYblXFL6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475410; c=relaxed/simple;
	bh=j2mcJH9DFAs4uPVxByFXW0cY1Bip8MTsLuwf/lpgjjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rs9YcZwwPvgzNKDd30JLoyKyH3vZ/LTqDG88+phqqPl+ebv8jzqhSRG/afUkguZud/70Go3JGLjHHCEwgBxG52kf4df3KeNJaHdlJx6NnRtmJYCkCKG3q5Et7v5oHuckSEUlzxihXHCRy5W8DfJynCEVQhLf0C2tlP1PZm7WOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oSh9/6T3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1717732b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730475407; x=1731080207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAkCsjd64377nzOHo9/POEtdFNrxXL0RDJBoIc/E4JI=;
        b=oSh9/6T3bbWlMTZ2Mo07IcEwzYaYR3LY6TZ/xL3hf23BG8NAT9gtumPayPxgAMpyv1
         A5CZjS51XUC17bap4+XsCxTTCzDAbyo1x+tyeONAB4SZZ2uVb0f+Pvah9oR98fTsJUR8
         ED5hlREjz43DT7IlxjYcShu3LE6luGu7vdlwbIzZftDH4kmsqtyWovfcTin7qEK/zZ8h
         QDVbSMuqguPxACBRxrceAIbiTfYTMy0EKK9QLfT05OFIS2LBVBd+lWAuHk7ASOC6xMOs
         MdTXEco1DPWRA1fa5FSioglNFIZvY3ySaWjYBdK+X1FU0kZD78nY088JApB3/7vnB4ko
         DOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475407; x=1731080207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAkCsjd64377nzOHo9/POEtdFNrxXL0RDJBoIc/E4JI=;
        b=r9SwcO2E0XpgKVMKLifgND0RrsgaHjfiNK/Tmf5Kwe1aa5rfUiRKm66Vws5hmxnPSb
         KdIbO42tLixURrGkzKl3Q+dmWwRsojbpDh8LmGeRl8xD9+j8ezKwRTNNUgGB9GPv/cE3
         OAA1V0WBKxqZJl8KmXfRfGzh0Ll2d2NSXEJ2VAE87XXk5b5NmlkEmFW+El6PQCiSdfUu
         s0Tlfi0rQAlhPWJR6fsDwgBpL0bS71H5V6xbP2VfC7BLm7yDVJR6ThXQpTa3rrOQDmX7
         wEVUlcbjEqwKA+dI5PyYmiLEVUjChvpF9fWOrIUc4XR4YCWZkyeRVMRLXMMyjFRRxYEy
         TLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/UzVnVgyLX0T0Yfnf5MyjUtGz688UNQyJ5uZOFvaCIJa2AxxZ15xKbCZ6WElQ5R5ERBSqLkVRTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2evuijO2jHgCb1BSdk61T1suT7glDlfDyNehbB05JyAZkzXB
	XjoFwbTgS2p+eDrGyxXJzXdv3n0F2Rz86O21D/ZG6hABYR+809PAC1o6+wccu7KdCNdNE7Aeq1k
	VM7X3/g==
X-Google-Smtp-Source: AGHT+IEFdgOZoHFIXn49wGqPLZ3SYk/IIboTgwbEWgDk6aBN4zZ9JHMpc9Eu70cGhL1y3h2fXMaZ2A==
X-Received: by 2002:a05:6a21:6e41:b0:1cf:38cf:df92 with SMTP id adf61e73a8af0-1dba54358b0mr5218831637.30.1730475407408;
        Fri, 01 Nov 2024 08:36:47 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452b1643sm2605552a12.38.2024.11.01.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:36:46 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 01 Nov 2024 08:36:21 -0700
Subject: [PATCH v5 2/3] pmdomain: ti_sci: add wakeup constraint management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-lpm-v6-10-constraints-pmdomain-v5-2-3011aa04622f@baylibre.com>
References: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
In-Reply-To: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-cb14d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=j2mcJH9DFAs4uPVxByFXW0cY1Bip8MTsLuwf/lpgjjg=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnJPWMwEgrEwQIThMQCDH53Co+Dy+UFgtBlPq02
 yv5jNKxjgmJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZyT1jAAKCRBZNxia0/vG
 ZVatD/9PIphhgrCdu4GvT0ZcoFVEWMYN/GveHyxQaVTgA7X8q9UnYzf4iDUabsgz2qdYYSriQJ4
 LY9xLT5hNSDxrWndcYZWxPKlUY8LuFEnObdQgxSkF5ZIPQmZJDN67Aod2KvBS3eAE5R8oy5mg5m
 ztXHqiCZQLWsDmDrcIDn/tjPKJsbKsW6DJInNMWJE9lZxA1LUKU+zTttiVgdV98s+Ru/PniTjj4
 heSjrtcAhLdbIE9g9V6beNrAoZef121yLyLGP9AqvtLz8DviR8uzHCxlSBuLdynS6WIzanAyNlt
 ijhsBPK/VaS2MM4IKHuNEI7ANMn8KFRG5ei6zCecMhtFKB0YUemewj6a+TvytfAosgoJmsa17xH
 1dE387VUYyG/uxpPRRCLe3xEwAKx6O5N0ns9PM5eXngnq012v5Y9n+HlI5v8yQ4/rGMCaBbyCHj
 SPznTY2WdHrxB3FdhZPRz24njIsujGuZAFTaFzTfW/cHe7BABPQ2K+pAgMWWpeO1WCFsxWebf/9
 EFm6sla20f+w/sUAQEV6FYK8HKTWD+iQxOqfo7ba4fhgAv2zLQoVXkc+4uBjgcxJ1P7tsK+pM3z
 B9Il7J3Kkv6vQniLQ59Uvq7ko8/Zy9c5R/0NZXOb+JS/Wu/MBxK5FipqemkpKR37ROfqBqyCPXS
 3VBbw8YpsedLQTg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

During system-wide suspend, check all devices connected to PM domain
to see if they are wakeup-enabled.  If so, set a TI SCI device
constraint.

Note: DM firmware clears all constraints on resume.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index c976a382d64c807daea72fa1ea9d6c11c8773762..ff529fa2d6135cc2fb32ae8a3ca26ac055f66cf5 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -74,6 +74,21 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
 			pd->idx, val);
 }
 
+static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	if (device_may_wakeup(dev)) {
+		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
+							       TISCI_MSG_CONSTRAINT_SET);
+		if (!ret)
+			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
+	}
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -116,6 +131,8 @@ static int ti_sci_pd_suspend(struct device *dev)
 	if (ti_sci_pd_is_valid_constraint(val))
 		ti_sci_pd_set_lat_constraint(dev, val);
 
+	ti_sci_pd_set_wkup_constraint(dev);
+
 	return 0;
 }
 #else

-- 
2.46.2


