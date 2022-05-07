Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9C51E712
	for <lists+linux-pm@lfdr.de>; Sat,  7 May 2022 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384901AbiEGM7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 May 2022 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385034AbiEGM7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2022 08:59:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94A47385
        for <linux-pm@vger.kernel.org>; Sat,  7 May 2022 05:55:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so13419177wrn.8
        for <linux-pm@vger.kernel.org>; Sat, 07 May 2022 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtCARZin/PmV3bTH/FtMmIwn3I6K19ONhR2W8qlbYlg=;
        b=Ujq3AJIZ9J5xQbbB0LooDPmoMlTAuhjn4KK59BgX+MVQthU4frlLVXFTtF7TWnDeha
         JebkWLKMsN34kPyjLT7H/fBkoApLXaAtZZj1zO1Z3F/oc/o36MUAJi4GxdPr7N8dk/v1
         67pTpBfMWyaeYeFfIEXXThYkqvoEAxUsl0y1Q+nTZRkKf6Q0oi6TDtj2fo8fMu3oaRVF
         6/xv+hEe5uIE94vC36PKpbNoc2yGFv1GITPMOcktWGCNt+w5iIUnsvlwGW40DlfUyywU
         gx2lXYoYUT2CSdJm0C+A/U87mMHspCMcxmigMDjAl5p241ypWv/TSfHgMTi9FHbQgSNs
         W3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtCARZin/PmV3bTH/FtMmIwn3I6K19ONhR2W8qlbYlg=;
        b=jzwlMFg/KvuTAoCoQMRi7746v3ghrtaZaDyQ2LYKeFhHI11H1bDxdXcsTQ5p0Xo44Y
         puuadmKJRBHgwlCT9kNsM4/4Ndbo/TAytkIQVzUq8vySanToVlQxB6K+269rzlAkEkIx
         bcbP4mwOqnZFFYcYq1hNLCH+fVA0QMTmjO2s9HLdejyW5Lvp0LEZiMjTanm8hUyfrr2+
         inCpYYNuO/6rdmw21T1NZSZ0Xop9PzEyEUdU3fqxaQ89CghYP0M+W6o1Gbl+E1Z+Eeg0
         lacgz2BBM/J8MJX8a40I/+jI1pzDHpGYcKGjZ26MVogaBCq7T2Q5GxO/XezvzkXlcafU
         4HZA==
X-Gm-Message-State: AOAM5320koT0tY+YTDGpqrDLzijOJZXVCHaBJhUe5dDl7w4UHFD9gaj/
        Re4q1bNgEdIhfCEXIdQUgibGQQ==
X-Google-Smtp-Source: ABdhPJxBMgNESv6YzNF2tBnMFSrH5fg2OQ70C7DT2o1bfxMzOh6EU2u2HQhGSVgi6QJfYR1UVS7TPg==
X-Received: by 2002:adf:f6c1:0:b0:20a:daf6:9bd3 with SMTP id y1-20020adff6c1000000b0020adaf69bd3mr6467598wrp.425.1651928112048;
        Sat, 07 May 2022 05:55:12 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 06/14] thermal/of: Move thermal_trip structure to thermal.h
Date:   Sat,  7 May 2022 14:54:34 +0200
Message-Id: <20220507125443.2766939-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The structure thermal_trip is now generic and will be usable by the
different sensor drivers in place of their own structure.

Move its definition to thermal.h to make it accessible.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 12 ------------
 include/linux/thermal.h        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ff10cdda056c..60844e2d59bb 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -68,18 +68,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- */
-struct thermal_trip {
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-};
-
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
 
 struct thermal_instance *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 10dea654df6c..0b99b7707928 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -80,6 +80,18 @@ struct thermal_sensor_ops {
 	void (*critical)(struct thermal_zone_device *);
 };
 
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ */
+struct thermal_trip {
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
+
 struct thermal_sensor {
 	struct thermal_sensor_ops *ops;
 	struct device *dev;
-- 
2.25.1

