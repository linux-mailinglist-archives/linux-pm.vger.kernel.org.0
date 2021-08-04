Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BCF3DFDCA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhHDJS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhHDJSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 05:18:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F9C06179E
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 02:18:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z4so1410282wrv.11
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN5L8qgaMlhbixKVT8x+IFvwOIZrIEWv5/cRqTSdyn0=;
        b=V2TTIebazihcW6g3TugX7/QHrxJV3cYQyVykcnOBRwAqnTtrkOwGUwqbu/aIquNnz4
         K5nSg1OsZkz9kSwjNoFmpf8R31DdRL+WZAF/0nJAgFpI3S6fLBkp8/UZ7gGX41Qdp2Uj
         LY1UMM6mWD99L5q/g79zHEYArf3Kso6gilC9NgibLH50GNMK9IgycAH5Qc/Doymc2fRd
         l2IclE3S+lDcHm+bJWCNGSijm3iVe2IHr5+zy33MFHhzu2xF8Hp81vKRN8m/oKa5FTQ2
         b9uJbOHpCNy8XFAx/0K2kp47WEuxkEctaNRSGDzr63FB7CdWoPaf0o3POE8uRZtG3uGX
         j1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN5L8qgaMlhbixKVT8x+IFvwOIZrIEWv5/cRqTSdyn0=;
        b=hkmYcWhT2wqiBYaD5Y2rVlvM/xUZp4VSS0KRGSaWsv/jQdMrZUrcelMFfpg3BCWZpN
         ITz8c2UzhhnHR6BpWHHKLjuO7IKJy7/6+vhtel7x7yxMZmBI4sjlt2ffqejTpBILTmRY
         XK1+qeMpbQMJn9SjERKKr/Xega6taiXQ2j8BkMLqXyE2fUqTL/t+EutJ06UbjboYuhBl
         675LXGS8fsq6JHLZgzyNGVQh4RgBimOVlL+9bK9qZ3n+5yQbqGvSuHH6Vl33RzmkelWh
         8nMTLXKDbkRAzkKkAvLUHBb7a5dgb0Fq1bMyw8ApdH0ztYt+6rdVzkcD0N8yNiI5l0ZC
         6JhA==
X-Gm-Message-State: AOAM530BKoYd9VmcKq4OfjULdGu/ZMdLYeMlLfPqrfaYWpRgjYZIxdOe
        +Hqucao729Gtl1UMwAUR8UaL3w==
X-Google-Smtp-Source: ABdhPJwzFJkGhDMjJiTZ43STuFX1kh7fazOHR6ylJHye3NgGEIkZZ3uILn57OWp4w/LHOPIcA9VseQ==
X-Received: by 2002:adf:8169:: with SMTP id 96mr27120773wrm.424.1628068719204;
        Wed, 04 Aug 2021 02:18:39 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2222.dip0.t-ipconnect.de. [79.202.34.34])
        by smtp.googlemail.com with ESMTPSA id f74sm1653172wmf.16.2021.08.04.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:18:38 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/2] thermal: rcar_gen3_thermal: Store TSC id as unsigned int
Date:   Wed,  4 Aug 2021 11:18:18 +0200
Message-Id: <20210804091818.2196806-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The TSC id and number of TSC ids should be stored as unsigned int as
they can't be negative. Fix the datatype of the loop counter 'i' and
rcar_gen3_thermal_tsc.id to reflect this.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Fix rcar_gen3_thermal_tsc.id and dev_info() as pointed out by Geert.
- Update commit message to better capture the new data members pointed
  out in v1.
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e49593437edeb3ca..85228d308dd35b19 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -84,7 +84,7 @@ struct rcar_gen3_thermal_tsc {
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
 	int tj_t;
-	int id; /* thermal channel id */
+	unsigned int id; /* thermal channel id */
 };
 
 struct rcar_gen3_thermal_priv {
@@ -398,7 +398,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	const int *ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
-	int ret, i;
+	unsigned int i;
+	int ret;
 
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
@@ -467,7 +468,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
-		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
+		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
 	}
 
 	priv->num_tscs = i;
-- 
2.32.0

