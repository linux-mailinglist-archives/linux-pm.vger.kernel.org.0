Return-Path: <linux-pm+bounces-18723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBA9E7B79
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 23:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2057316A463
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479B213E6E;
	Fri,  6 Dec 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mw4URXdL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E0212F9B
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523186; cv=none; b=Fu3IcNzRvlnK4oHlb+mwMygJOi6eu+Id8h+yeApDL9YEizR8buW4vsxC0dvsUoCN35a4qi8i8nWIjYXRCJ46CvlyRsqUZPLbxE1WFUMm5vr5vrkbHHvRXMnprh/3xzS4FtczgYauxBv6/Q1NJLPDh4T7zPk4QY9EM2+d0aN6EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523186; c=relaxed/simple;
	bh=MvYLl1dkczYVZlHhGI19Lnk7zfxJItmwrZlS8xz45cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cl6eTiB/VMOy9UuM/SWDE40LFWHRtZuZhIw5YMDjPv7Nj86Q6MDbhNxKc1KLTGIyORY0OaWBq6ukmAebznKBjk3W0eOCzDIcD1TqXzvkyCYJoYT5OrjuN3TYxYrTn2paD6p5OfPVu1eeC8lBou6PMkJTkJIDrmQMj2YB4eNthck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mw4URXdL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so8936835ad.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2024 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733523184; x=1734127984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1Ep2O9wbC6ZlfsCLYQrAmWucAGOrIVsXyOuKD+Yvgc=;
        b=mw4URXdLte/tCwznxgayVRACMg0HUt4ycrYtdboh8tlkc6cI1Uh6c6yB3Pq+843fKJ
         Vouo6BC1ajc9MWDNDIHusskdhPX9OzO0jOhgiONKQ31U+Mb8eynMLOCOmYPUaDDzy9i8
         U8JKm9OEJMOoOThmQksouMtq+E8esnXIqcXlBYgOXJcNBY1l5eSg7728Srgca5bw5Aby
         8xmHbOGwUK/ZQwkXBDwAC6gRVZba0eWMxSyVO9oDbr4uyjt14DyCUUMiYLPju2v40+Fa
         Jm5FqX6bqgcOHK+2tsu8qNIe1Txd3MoQ6jovZmmpb07j0GArDfLp7vNvKSxP5/hGuC8a
         BenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523184; x=1734127984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1Ep2O9wbC6ZlfsCLYQrAmWucAGOrIVsXyOuKD+Yvgc=;
        b=o82IYpLW4UQ3MDAmw9mb5bwo0RNTIgznGsJl2BUbnELU9AVQfLsAzAm+SwTx5nHHDS
         4mw7kVJ1nFa7nWgT6KndE6xM5C+Jy2oCHCvrZhoh5DQq7m5agYRQgYu/kresMRuomZ9F
         fGIActGkzv0aiH2rpK8/y8yXNQif2ZLnbuWuf+VJAFYzfb2U36rGCRowcXx7xX+aKNIN
         zL+MF2q+gZ+davenqD4bv6ixnULACbqsq59LV/OaE8dARkVUqBIEO1lBrCfIkN+tztKV
         DKraS9+s9drdTI1GEgDvBXOogDvdXBJli93Ynhn/8cbxGmSYu5SqZBLqvwDe7E6TUdUt
         6Dcw==
X-Forwarded-Encrypted: i=1; AJvYcCXPS/lozRPWP579lnJunD0FjfuTrzsrk0AuzAyA0h608Jyl5t/M/Dqo4se0Vdu+7Y2ZMsAFtkeDzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoArXpQ8y1izXBsXp0yKrd7LKrmoCIFXmpHa4LZ5094AEMJDGA
	xWgFese99yNpiwqk99LG+63rOkltd652QxoaOQC3n11aESNm+OMdZknuD109IiY=
X-Gm-Gg: ASbGncsw7F8xbed6Z33dF1PcaPBW3/CwGkzhO2lGBnyErSYUjjN4vVSIoAcLQkNDDzz
	HDWUEcPZ0rZl2H25fi2dXmSG6Wq8oEY9Clv+TJNrnBUpaFZyPPCC5qIGD1odBbaSIuyTS0/FCQn
	DobN0ZStEw8KjHJTeTOTE7PQRlSiYnzLT3TBcxSIfylVp+Vp0VM4BIhMzfs+R3QLMQH/YiCrl7G
	P4Y78yoYIb/lcm5W3iYfGJFoGbQqaC77KJertZ+HIWoiSzT
X-Google-Smtp-Source: AGHT+IHV64TQ1MOmZpTLIsCVD0ziIh77UI09rSBXDq+X4jwn5nrPeDN6Vm4VrpDkqcW6GWDyrxNBiQ==
X-Received: by 2002:a17:903:249:b0:205:4721:19c with SMTP id d9443c01a7336-21614dcda61mr70577895ad.37.1733523184271;
        Fri, 06 Dec 2024 14:13:04 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09120sm33444155ad.177.2024.12.06.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 14:13:03 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 06 Dec 2024 14:12:52 -0800
Subject: [PATCH v6 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-lpm-v6-10-constraints-pmdomain-v6-3-833980158c68@baylibre.com>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=MvYLl1dkczYVZlHhGI19Lnk7zfxJItmwrZlS8xz45cc=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnU3bsod2B2Q8ODRoP42LqdWQ/Hgb2ui7QUvDSt
 j6QUnJ9692JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZ1N27AAKCRBZNxia0/vG
 ZWpiD/wN88P5QYO0MxFMU/+oEkdJG9BPIJa59vyGq6XcClgTY3P1szdPJum+NRMgyjYE8GeXT9F
 Ou6dZP5N/1KV8FAnqUkVJI4kuopqiGzO/F2jW6vY047ixx6MQrpBuhIDKowMEzItRjJxfZMRb4X
 AvOJhHUihsPkVHICxUdUYEoaKpdlbPl7NFTDuzLM5eoOFbmtwl5riyz8q9tnKsKC79nwBJ6o4Ko
 avT8z9TAefa3XBuOMrI9M2LYMA+bua+Yh5VYLHYmm1Vs3VdIowjoKPJ0ThUMz4OFq8sEbBspG5i
 24O25Zd+q+dqR3xflEDHcVhxkb/VYlmGqkIY/awyW3IsMFiPgoPb2c2FJYktQVl/wjJfnVb/4UX
 PoINOLb+w7juAtJKByKaUxvUQBd4Z6U1m3ePJVfqXAik5KvUX/3jo2JpGoJozlMxppAxp66NpTn
 GwK4Yj8hCtPd2ELxnYpPv5y1c3IFZ495IjzVbemGzHjHWQ3PnjcLZv7KcDZdkoZYc9I2ljyoZV6
 ew5zdI4DBoZ4eIhajTwKrekEHg6LEqJJhjwFYyZ7N1+gTum/WH1wZXGtePL5OE6oEPIr2nquWTn
 HZQaMqJdLZ2es2OZP+MGBkXEBWVhOfCBjdzQN67NQk7qLd0L0/CY5bo4d/CoL+nu5/q3apBAvc9
 L4PxM9YgNeY4bIQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

When a device supports IO daisy-chain wakeups, it uses a dedicated
wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
wakeup constraints since these can happen even from deep power states,
so should not prevent the DM from picking deep power states.

Wake IRQs are set with dev_pm_set_wake_irq() or
dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
when the interrupts-extended property is used to describe the
dedicated wakeup interrupt.

Detect these wake IRQs in the suspend path, and if set, skip sending
constraint.

Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 587961519dcc9e13c32efe76cdaf801281f72f67..3fb78343d4388a7087dab5061c1127586968ef19 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -87,6 +87,15 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using IO daisy chain wakeups,
+		 * we do not want to set a constraint.
+		 */
+		if (dev->power.wakeirq) {
+			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
+			return;
+		}
+
 		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
 							       TISCI_MSG_CONSTRAINT_SET);
 		if (!ret)

-- 
2.46.2


