Return-Path: <linux-pm+bounces-13740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6296E590
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13CAB2196C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291C1B12DB;
	Thu,  5 Sep 2024 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q20Pk5bA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2121990CD
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573805; cv=none; b=lmHH6RklU1YpLdrQKq20VqzfkSwLNFLeLFiWSNbyj+dxMCe5hst9dpaLiP289+h83pIZzv6CbmDgdlurI2nEOtpLx3OmduEG91VlOxDQkjCO+E017LEVHRHkeCuVKeYHW/L1Qf5ByMwT/hf5Sis0S6/n4wmbyChr4oo79BNaMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573805; c=relaxed/simple;
	bh=swZQv+32F9CI/ZQkJsomr4F+HEjzkbq8crWIZokZMtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHIcvPdWqeDyQ0MvSt6OhZx7TR3DR8HS8pei1CfabCcCTe2yjvfrFGa4/ZSBSlh7zZYb6W4jZ76RK5Oxmsnk+aqOIi/+gP7E3sFVpImZXmUP52PjPlpoqmZeirThrCvvVbQc7B0SLs/tPFiUpp5a6VNid7aSWlJyt2SYVQwkVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q20Pk5bA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717986530ddso660860b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573804; x=1726178604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sc6ykz7pAchdOMHhEbbrDf/awas5HhLjGMs4xS7f/rM=;
        b=Q20Pk5bAeN2V5eWyxjyvPDpKSopnIKPepQYhqpNAFHiYVVL3ohIgfP0/XM4ePsOhmu
         G9WrN5SjBiyNMld1+EOuKTs2u3hUCKpXFJA0LTTrRofUAWPmuNjmoIfvSHFAtS7+/tzY
         16Nz8dZox0heVzKbS7I87usirM/KH4iIh/J/ldZ3JI/Ovi0FC45xZIdfS8Xr50ktsUvR
         VYCUf0FLi4S4nQQlfj0SHbvBbTb0ARHJgc0Rej2cFKWjXtwdQBJV5hNbgHNvNGCgYLXC
         iB1k/1QJX6D8W5ZtbEOKt7SGveNArtXCXABfZjXfLJ+skqhDN/aHWmWNR+vNMTGw+ebe
         5G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573804; x=1726178604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc6ykz7pAchdOMHhEbbrDf/awas5HhLjGMs4xS7f/rM=;
        b=MsGG6kOEln3/AorBFwzVTcicEPzWpan48aU96OMqRCUqbLFWHZmLH0jsejY/8hB7DP
         +qQBdjoFEgc2Ud5sWdayYSQXX32oPto8ggSEHPxw/e3OqTK5aHK3qa7KDzUiJCS0XzCh
         aDrl7j7iLEEsBSeDj7B1EAG2JnuOqEWWXbgsQVPGN2kyzXUJCZG6c9BgB7AV8wzdaRT2
         +VctzD71FWMsTSvaDWD6/+FS8yIxG2aN6UcNMlcLBRxrQRgj5HBIoCkyrT7oyAZ0nNjO
         xhqXwELzxtO1JoM+Emr+GCEk7+0fPCrtg6mBxApW0fX+QfHxdjrjjQ1OAAbcG26oqTE1
         lE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZftctgyHFfgrDaKgbpOD6b1EnAdqOOHAK9Ww3g+KOtkcXryLn9GP4KFU63W35UM0Hrdy5RMUUYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztITuHqhwKVSJ7hvkJDlsrA3fzuZAyVdSjsuqLkTC3vCSSHh9A
	PTpMgYpaP1GUuwUwZ06pKbSklq6A18nFWs8mSG2z1BEU84GZbGSki0d2C8UjjBw=
X-Google-Smtp-Source: AGHT+IHFrsZBGQdJYYGOPjjjAC19zc1JTjaAGcw/Wmj4frCMa9mnrDm/wtLkyPcB7KXhhAbpzOir+Q==
X-Received: by 2002:a17:902:e54e:b0:206:c5cf:9721 with SMTP id d9443c01a7336-206c5cf99f7mr71822995ad.1.1725573803768;
        Thu, 05 Sep 2024 15:03:23 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913363sm33104195ad.6.2024.09.05.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:03:23 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Thu, 05 Sep 2024 15:02:50 -0700
Subject: [PATCH v3 2/3] pmdomain: ti_sci: add wakeup constraint management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-lpm-v6-10-constraints-pmdomain-v3-2-e359cbb39654@baylibre.com>
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=swZQv+32F9CI/ZQkJsomr4F+HEjzkbq8crWIZokZMtI=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2iqpHOswXF88oDhZOs6DJGg50D+JNq/25gzHA
 NomnGVbc0eJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtoqqQAKCRBZNxia0/vG
 ZQZnD/sGt1adz0t+vhx0pzyqXNQn/9PwpwDm35NLi5FZQD8hwPalQ3gUqacez00E0OV3+61thCk
 7Phdb0Ri5qPXZsghfFrqP2KKrvpq8lW831JPhsla1l1OrGEwl53d2YSSRBk4L+D1LGqxaIccO2e
 MqU+PJXkv+OnCOUMuWOP5bPKN6Z80Mlwb8ElGWeRRDJyFN1pH0BrgFhSi7+Ti52u2RZlJNHNVsU
 N2w33NNK2Icrvg1/NaSC8sZeipc0ywsu1ortTIrjRxcLyRuUqojHGqIKwBLzSR26PabjFvzNYOa
 QvDARWLaEnQNcNr1OaGE9lIrPnKufbxzJ544TaIsTHh0mv26/hKIyCPU17H4Uzkt2WSb8L0Ph0X
 aNyJPs58xLsSS+jTZ0P/jOEgmkPH3VWwVDhgirQ3kfd6ztnp0TsveG/WqTFH7lisLWYFw8Xs65G
 cifEprKq+NxRLXflwObxKynW6Wdq8jEBK6p9d9N23iz/7DyVlZwAo+r4jnnkmCrqpoXvA9A8E+V
 dD9MCCX04YR0WCrnnlLcoEIYtY+YObkpn8q5wnQhLquN1a729LUPxFCe041TPqORI9J0YylN7ca
 KHzSWhC4gjZ/p19Khaz8Dwzd5BA/5ltpEDjJVTyXfLQ8uD/J0mV+l/kCmBaiAZ+xDO1puT7I8z7
 6Vx/0kQxtIPGBpA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

During system-wide suspend, check all devices connected to PM domain
to see if they are wakeup-enabled.  If so, set a TI SCI device
constraint.

Note: DM firmware clears all constraints on resume.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index bb95c40ab3ea..1ab1e46924ab 100644
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
@@ -115,6 +130,8 @@ static int ti_sci_pd_suspend(struct device *dev)
 	if (ti_sci_pd_is_valid_constraint(val))
 		ti_sci_pd_set_lat_constraint(dev, val);
 
+	ti_sci_pd_set_wkup_constraint(dev);
+
 	return 0;
 }
 

-- 
2.46.0


