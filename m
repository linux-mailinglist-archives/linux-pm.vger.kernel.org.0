Return-Path: <linux-pm+bounces-13805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A662496F91D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F29E28601F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC11D45E1;
	Fri,  6 Sep 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qMDIGnAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886981D365D
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639314; cv=none; b=kQ4WJxLzGQdZQmgfZ8gmEBJLtBxaI2MeujcEYPvpt5At3K2X4EzjBiHMw7YU+uNIBJ7GrcaOgTzeicfN8hucm9LL2qJSe8Gb692k/lRxlqVMza3SsEpBgzCElUAy9UN74/biLmxgNoqu0llw3JL9fBArh/PAqVCAnGQ+37sbbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639314; c=relaxed/simple;
	bh=9FdOyIfVNqdxWITOueSVvAjoQfrL1FwTK+07Gro9K44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPDApnYPhKTpMaNfCxoX5ypXCseO/aolx0MYrdiTlUkvhXul9mcSr7FgW2bY827yOW8pKZq9OTMQvsctNV2I4sF5Z1mvAIwmpY4UeYMl93DLd1A/girXoDdwoqF4PVLeqUDdOSVMniwHhNJjn0Vw4B8TVb0pWgrZUd6/lvs82+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qMDIGnAp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d5af11a4so21133785ad.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725639312; x=1726244112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHpYPG0F7ARkJaF7S/WPtuawc45vlNVeHmm3gtL++pA=;
        b=qMDIGnAppe8EAd0KyIHcTCQWGamVvACBZ1R8kuiai46yvEvbBQpeHDeND+RnwW8Q01
         TzuDVXMqnRiAkVkVoc4fAZPAb0i0scpPQXbJQVLx3Y0Y9i940x5wjJknWDvnGlk8PzYO
         bpk3L7Lvl0ofa2tpRtb2JwOHYc8ZKODa7B7cgozAhyBQx0RLgvq7tds0c3zYEYnXxXfF
         DaCbyVXTqGUe0tctoNYYg5OlYgEVEPRAWrHsaGrZ90+xtILvsIUQyW+q6ucAnWRP3zJT
         fEtsfWD41VvgQpj3LCVzL0g4Rcrt+bw5SCr4+99hoxGIX6vRFphRSTe0zIb+GAFBxBwK
         MaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639312; x=1726244112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHpYPG0F7ARkJaF7S/WPtuawc45vlNVeHmm3gtL++pA=;
        b=rQrr+3EzNzbEtuCv4Go+TRHwgpX3+Ehar7jEJGG6/tGdNvmelo8u+qtxrJwWtBz3XU
         Zs0666u0nDSgv+1YeVzuwgWDD5uZIP6r9ZAYETDi9RHl+i6dfEj7UJGCJaVZekhNHfsp
         bJcHLj8RGoGFos/aOiZVjSuR3JqyIHZJzJpuzskB8YX7LjcWV6A/Kk60+VGHVy9IXPle
         LJnGkU12G69/bS/ohpvp6aQ9bDZXTUxfTFjx++/OUPckEYP/fjl0wtCDt8ARgGGCtW2r
         FVqCFL/qFtNczBjUcyvuarDQlM/FsVepE6uP9WLBD6G3LtM1wigms99mu/bS9rTs8gFL
         XvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsA/1XqpxRLepS7MBEgX2WmXfjZUqhbLwB6yhqRqke4Sz8AoHdcr8iKE654pQ6C+3C5pMld2VulQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweEY1N72zaXksKROYjdYzECmh1q1FUQ0rAUj5KFtVHJiKADpeU
	b4EDildncQSpSkxhPhifhG4XZktEqVXLW3RxHhc3aGaAkFe1GLWq2ZzERFDBgus=
X-Google-Smtp-Source: AGHT+IESwuJ5dl0Z6KD7hUnigeZrm7cUkuRf9V0jjKkRN2+AzCtxauGn4MqXh2z3XQDnxgcU4F8gcw==
X-Received: by 2002:a17:902:f709:b0:206:cc5b:ad0c with SMTP id d9443c01a7336-206f053479amr36155775ad.28.1725639311833;
        Fri, 06 Sep 2024 09:15:11 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54e7bsm44826065ad.183.2024.09.06.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:15:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 06 Sep 2024 09:14:51 -0700
Subject: [PATCH v4 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-lpm-v6-10-constraints-pmdomain-v4-3-4055557fafbc@baylibre.com>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
In-Reply-To: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=9FdOyIfVNqdxWITOueSVvAjoQfrL1FwTK+07Gro9K44=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2yqL/PIURu2uNA/h3Fwo/1sgpktG8Pixx/6mQ
 DAnA057AgGJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtsqiwAKCRBZNxia0/vG
 ZWE8D/wIk6Ofc+XVqFuDQ0NyitdIu9sTbMxYy2i+0cqK1UaRlvQ3Jk0fNkebAHDh03LT0y2OKbu
 UpUdE6GUxbfPx32hl4Xlq4OmowhHI8SVOzW5VoCrqPhf6H1gCgL2cBp9sMlXfAMX9/1MMOKxX9W
 K1eQNh8BlZp/xjhU+jKY2GEw0h7uhb/dCC9Sr/YjHng/LIwFK50wJghGLf5ce/krvwSjBEjJ2xB
 hRKhbmzV8Wm6Kb276Afm31RPPuW59JI2BwtGPR7GxBhFIXg5wPKlXaqawt1mol76ErBE7EH5YsE
 oa6EwAgpI+RAgSjUPSjYT8r/PQryjwEYeRe98O1hot4r5kuIoLpKUhm9aYRW/djKuXR5KzAWtif
 /FZWROQDFCvyYyR9liyjiex88DIOdeL9ywLDvwNUtTYrxjmk9Kxq0LDgCl9Apvww0xJnifCzT1U
 f8xOpc4YTgKdor1/d+pK8czdxq8JBKRgqAuyqHjWfZkCkbnNK2cN7hn4/du6O/90aqzpLR6a+58
 FUaASt50dqSLB5p5qZbQg7z3TD0fQHTVQlp8zgjJbN4mjF4jzmjjWHqwcrLNehFv751mOS0bgxb
 zBdBE5nMU0CKYhAir9AZewEg7SCS+tJ806Rkg1TYKzIjjNSZ5v0vjRgKUhSKpSGsnc9fwbWV4pS
 2XF7jXvOcur+sVw==
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
index 1ab1e46924ab..566af9f055b8 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -82,6 +82,15 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
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
2.46.0


