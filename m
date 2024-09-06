Return-Path: <linux-pm+bounces-13804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D329A96F91B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573001F2289C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27D1D415C;
	Fri,  6 Sep 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OXu0bamw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D611D048E
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639313; cv=none; b=susRM0LyIdz1R0+OKHkT9GyI8VOQgd5nGVBbfks2eTJEaf/tQ2pWol9gXd1WRrurACPoNJU9E5PzdRM+OjtZhGqZIpa3be2LDwYxcvSrbDtMT/yHjgKzrqH94p3flPMAdRnuY2JvEABQ5DfU0X1zeAnAJHJxqhagTc0aJantCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639313; c=relaxed/simple;
	bh=W1HLvNNrQ5aRbDnCoPuDJ9mQXm5CPHYILEXs8vfWbg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFgs2qIE/Mohhnu6YASwvkj0ZMTtTxZ1pkHro7zPWA9BzS13dkyOmBLpCc5sGxTVi9/N3GBlmkUPL12cfNdDv37SgbCFpijuiToPj64G5s0aPoZox3GyLugGTpX253cwsY1dheMptXEN6gaAtBqdb4wwVK8pER8ORiqahIHh+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OXu0bamw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2054e22ce3fso21731795ad.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725639311; x=1726244111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2aRXAwD8KrJpuKg+9Kk7rgQMra5BG+HeEZO3HX3uDc=;
        b=OXu0bamwVxUGaQrrPd/AL9Ge6+VtAIjBJ4INEYkXFCoj+3c66n7Rh32mCmWqW0j3nS
         yqcFPcELWBXpSpDe06VYTvUNi/h2e9Z2idQwdRz1RL1PhGBSkdMfzWGZlYNmF/2PSJXT
         gzEu5JBMykIJD8y31fareJlnXzeiQownVYUX0H80fZciB8TlhenedBJbojbYHs8xp3Jd
         wyjPEB0kkwQdBHcCgOdVx2U1EIBF5O3h4d1THJO0rhlfGugwf8XwJrE1em+hrzkZT18C
         foyl6PICUKVquxamCao/l2TePT9OwXbPkcc7GSf1U0exHwiM4XhdsFsxExqGK5p7oS4E
         0X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639311; x=1726244111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2aRXAwD8KrJpuKg+9Kk7rgQMra5BG+HeEZO3HX3uDc=;
        b=VYdKypLNE9EL4/OR6cmw0jKkcbqB080RM8PrjXCzWzzj0B98+lQzy5jhfnIEV0OjhW
         o38enxyx2nMKhsHGN4erYme93YFc3RgQxPBgLWuADDFypwoYjMZagehyBMUvY/V1MLwU
         bguRAlXUyok4cE1c5is3jWTf6TPGRhg/fjJD0IdX+N9IvSj3YEUYfvkR9wb1+vFt3rpJ
         wzxuSAHrlGS+RFgCmUi9vErG3VG01kDg249U98blRQM/JbqqcRTIcN5zVgSi7p5ZJzik
         SWWTm/vBjeEMB+R9rs++j+HDCMWyeZv//fKJJ/Q1RuRHjEheRRbi0sl59t3tliZxhnsw
         ykDw==
X-Forwarded-Encrypted: i=1; AJvYcCW5q2uISwmzUFfuAmibhazPFaWWDCeydDhTv9970RpW7i7RhY/al82GNHaXhJULVsXswJ/GwV2b8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwuXcsWfo2qx/h2ZdqpeF12X4QnmSibCxK0fQgWZ9S0sECp2w
	0ckp/4Eqcqh3L29Q8uEi1HON8/V0FpEuzR49ZaEr4l6afKShIxzKod7DEifthe0=
X-Google-Smtp-Source: AGHT+IHRAWOqa4vtw51vHKymkcBna51OsZjUMFHA5+x4d7b3lyErQUCwhi/Zf1+52AB9PHN69BgAZg==
X-Received: by 2002:a17:902:cf0a:b0:205:6d54:1ce6 with SMTP id d9443c01a7336-206f065b9afmr40654155ad.57.1725639310751;
        Fri, 06 Sep 2024 09:15:10 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea333dasm44777155ad.163.2024.09.06.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:15:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 06 Sep 2024 09:14:50 -0700
Subject: [PATCH v4 2/3] pmdomain: ti_sci: add wakeup constraint management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-lpm-v6-10-constraints-pmdomain-v4-2-4055557fafbc@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=W1HLvNNrQ5aRbDnCoPuDJ9mQXm5CPHYILEXs8vfWbg0=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2yqLsdfADWbiS7a65KXGYejPWS4mVPwOv9Z37
 CdRwYoZ9AeJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtsqiwAKCRBZNxia0/vG
 ZSlpD/4g0D6USz6yaus/cIGpB9stTfudQwizKsEkI7rgMBhQtGFHYKpx8BRaIOVShQpNLJqm2g5
 xminiI4LrPPru1vNYBLrVb9tsLbtejG9/w7XFxv3P56LYdOdyCZ6amGsez8lZZ7QJIcaKSWJYl/
 /vST951zmhT6NZZoratDwIbxflkz62dLjVKF9MKxJfF3Q3DLcBQ8N/+f4mdnU4KuqfFaEAmRNjX
 5RlJ+l4reF9zSbahjP630qCQ0gnXIhfTYqZbu9zky9pw0SYTmt5GRQucfJee+kgSRA7HT8XtWc/
 dae0VG/ZjwL4eK0ekdcx9R9pZCfYvzDTm3YmPCrnZn3ylj7fuYaMQXG0ENODmvOc8y8ecBbUFTW
 lok/oOBlD94p7P+4KDGFzIfAXKTBoCghVTC2br2nHKyT+7zbxVwlk8ZBCVPIzklKjA6y/zgLSZ9
 KfcsRj5Q+XkRWu5W27p0du/guhlBPLnJZaZ47D6BgcrstGzH3H3JV2hF26YwsI/IBqFtiewEYUF
 f0AkaW5G87N5ie9+XZll6o1mJb0x6tV9EFEm2g0tuJDBC1YTEvuWVmyeCfcRC3/ntDoj9GAgh5P
 O2xo5H7sVfn2cUpkSOT/gN3tIhcl4+WDDlMlrVsggWlabpv+PTNcSyRYlp+vAYnplztlc4Ehpzt
 WKYKkXG5FhQK3EQ==
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


