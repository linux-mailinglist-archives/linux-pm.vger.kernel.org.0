Return-Path: <linux-pm+bounces-13803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3C96F919
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CC7285CE4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03191D4144;
	Fri,  6 Sep 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uJaLkb2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FA1D0DC3
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639312; cv=none; b=TS9cQSOsXZExLkR0aE3xDinoI0AMldAXBKyiLpupzxsw71PvGJ1P6jNIoKctNbpqeiJa3gwaElYTWObLID5o1M5XXJk+vnRF4Nbvsn1GpMcuf5Q8cy7hMJlL2DECAhJOWM2i2Si/JoWYMIUfNYa3EPfbXctWSkrNO5o/0nRGTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639312; c=relaxed/simple;
	bh=Z30ieLDM06mHqkwlhFkl2a4vKxiH7HFPI0x22ElrwLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLwQIqKN3X7HUHeoerP2P0nhySntPqTu2/AvKiBSqQlyblQ7B2IXedKsLXpcrxJTA8bywBCUl5iLJKR57X1dQklAWaMz33hd7qWW1iB+dOdxOmkqHjk6GfP/pviXjjlbMhn9jzLRZF7AtsSESSCjtm8QO1v7jNuuqiTf+J/BZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uJaLkb2t; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d985b6bbso695821b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725639310; x=1726244110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M23QSkkmj0U8+DRFhBewDD71q06y3alOAwKMp01rg4o=;
        b=uJaLkb2tAACQZZyj8dYypx4sSVTMYxHapD2G7fqxdgRRB2XIf3LopVRDVPSV2lBjYP
         GIk3xj77wBsLeytvH7gOBHNfyGbgdVRTNX300DqCyBo0MtQdcFjb2Y4BGNxzbBjV3fGo
         HSiyq1sKOhrVCylfGAdorDPM0Ub5Xt8nZyxk73+YdVrwFNm9JRn5ijPg71TF0vRNmf+Q
         kum8/HFCkm6h0Mw33Mqd6Be6oSLE70y/xodEj5fVAed5Ae0atjW/hGaKouYH+8xJge8Y
         1kC/icAHNUcNlFQmlpUnxP8bf8M5Kytr1hUtFaNrBj566kGDg95eLMC9C4r+FjTwG1TC
         DCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639310; x=1726244110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M23QSkkmj0U8+DRFhBewDD71q06y3alOAwKMp01rg4o=;
        b=Tkf+oWxShnX17XhdHHFewKDdceR7VLP3My8mnK0vpbNUJlO5MXN10gRkKEW0ew6eIw
         iWNhSFeyxRtahH0cMCbvVMGXL+Q7a0sleWf0Aq4mNq18wQkGvFHpXje2OHaQGuM+UnnB
         ktGFi0X3gSRsOaInMvEvOa40Iun0BqlXu7lRwIKMLLtXXBvv8Z7of6PnPbiggcje+1q1
         6FE5upDTTOPqskB82iadnzadBhOT9fHv4+JF3jOUuGGaHZANySSybCFkYqt9j+2kt5Sv
         6R2hcl3aWwlS7f6ENVYdmFCjGvj8FNOFQiAi50/k2gonbLclRMDlG9FOo4lmNKzNco3u
         aZnA==
X-Forwarded-Encrypted: i=1; AJvYcCXXO5jMF0IN3xpBp07Cgkp/wDDDVC+Z8eB8AMvB7V3cBtbfAU7EUBYL13lCOYdcIrpU9gKgJnQsiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWjNJSXMG/pkaW8UYYyjKn9XeOnprUPcIcsUimVtktlKYgBWY
	mP3xiSoGvEubnHzx2I0Ds/vv4bs1C2n03gP/S+2MxjgZ4N8dUnsoy5TfSCofpM4=
X-Google-Smtp-Source: AGHT+IG42XDdUECXdsVsjNHnNCea/VVAWmmRze3BgvuQbgKT9T3nq0761gcMU17mf5578jJTNXnTdA==
X-Received: by 2002:a05:6a20:ac44:b0:1cc:9ff8:eb3a with SMTP id adf61e73a8af0-1cf1d059a66mr3145797637.4.1725639309783;
        Fri, 06 Sep 2024 09:15:09 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717c95c5d4bsm1861053b3a.102.2024.09.06.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:15:09 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 06 Sep 2024 09:14:49 -0700
Subject: [PATCH v4 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-lpm-v6-10-constraints-pmdomain-v4-1-4055557fafbc@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3830; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Z30ieLDM06mHqkwlhFkl2a4vKxiH7HFPI0x22ElrwLA=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2yqLeioEVn+N9TW7gc9VPGmGj/Eky5GN6PguO
 KOykfS2nTWJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtsqiwAKCRBZNxia0/vG
 ZTM+D/oCriCt5fa8AcDFmDrbjCQCyI9IRqkn4tSiSYkSKsTPyY/fQglGec2YE5LyH94QgtSWOcT
 NvLxvQbBD2FoRtzgzaKJUAfxi2FIXNwK6uJlwFkSaebQMcjh5GXNKrijTD2EbgS2fBaTVoRME/u
 dLD0x1Yr9ZgrB2tmdsnPObD6pEIrHSk2oUaRUVqIgYPZ5l/I3/eXWWPfix5PiZHdBFgVC0b6JZS
 NiQ5s6x2BFI2SNOl0fFdWZkXS77zjSmRp2v2DtUZ/A6vzPa2/HWaEB4GfwcJEhmLtwaEwHRG9yX
 Tq5aFuJElx/ezGE4rnvGrkOcKDskhme5nIa6gfqjjdJu6lmzDowtDxjXFC9EkXG4zkhMF0aRLMC
 9t5S9YvWW5yzgB5FSLOn6Z9dnEUUCGiZR/MbNNAocRbxFECjLsTdRsO+QHaZ8Bq5ui+qzoBBjpB
 H1uI1ycR+kphQCzryIxKd2nxXViIPU50iL9n3VJgL2e/IoK9vKn/pPKhvckcnhXU5cy46i0bR0E
 XKaDARGTcc78FER5LhrSNc6vqvjyOVIrUs9gdlThAS2cBGIg6C+ri3xB+ZAA8lbt5NfcLHyeSAb
 1xoeETY7VCgXg6XQjb1UEelyudDQ4U5AFUZXkTnu5KXXi7YdVEBhhPReuaLzmF2zS2oACqYle/c
 DKCoED/lAEL3czA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

For each device in a TI SCI PM domain, check whether the device has
any resume latency constraints set via per-device PM QoS.  If
constraints are set, send them to DM via the new SCI constraints API.

Checking for constraints happen for each device before system-wide
suspend (via ->suspend() hook.)

An important detail here is that the PM domain driver inserts itself
into the path of both the ->suspend() and ->resume() hook path
of *all* devices in the PM domain.  This allows generic PM domain code
to handle the constraint management and communication with TI SCI.

Further, this allows device drivers to use existing PM QoS APIs to
add/update constraints.

DM firmware clears constraints during its resume, so Linux has
to check/update/send constraints each time system suspends.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..bb95c40ab3ea 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
@@ -51,6 +53,27 @@ struct ti_sci_pm_domain {
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
+static inline bool ti_sci_pd_is_valid_constraint(s32 val)
+{
+	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+
+static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
+	if (ret)
+		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
+			ret);
+	else
+		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
+			pd->idx, val);
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -79,6 +102,22 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+static int ti_sci_pd_suspend(struct device *dev)
+{
+	int ret;
+	s32 val;
+
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
+
+	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+	if (ti_sci_pd_is_valid_constraint(val))
+		ti_sci_pd_set_lat_constraint(dev, val);
+
+	return 0;
+}
+
 /*
  * ti_sci_pd_xlate(): translation service for TI SCI genpds
  * @genpdspec: DT identification data for the genpd
@@ -188,6 +227,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->pd.power_on = ti_sci_pd_power_on;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
+				/*
+				 * If SCI constraint functions are present, then firmware
+				 * supports the constraints API.
+				 */
+				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
+				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
+					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
 				pm_genpd_init(&pd->pd, NULL, true);
 

-- 
2.46.0


