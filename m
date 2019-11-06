Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B88F1706
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfKFN3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:29:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41999 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731803AbfKFN3A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:29:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so1694581pgt.9
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2JC2BSAON2aTYfWnY286zBqdcBgF1dUkhFpgqH52P8A=;
        b=GmREb2gAFzVBw1JzE2epBfRKDBD9/8BHb4WsdWVr5lOtzpidmIw5GF3ZoJMBmiR2Lc
         hkiJAEHW0blLAPRX292U+12+AsV/FjNwUbuecXH9XavsxZR5ZGdmfy8qUOiga8JBaCHQ
         rCdQcLyLGFupMzXBlQpqtMxOpCb8qylIQELk0s8wrkVmGkfF79umn2K6WDk4xLVOpiLI
         5RJyH9RUJzoadMkubpIwpy0T4PfwtaRawxNZF/W2TAMXRAOFzifYXQJu6tRRIoAW2IM2
         ZhYtAHd6FSX09lWSsG6PADFFgZ4VKpmYAIPfmwW7hzVEJ1wgNQYi8uk7j2YsIzi3VNI/
         dNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2JC2BSAON2aTYfWnY286zBqdcBgF1dUkhFpgqH52P8A=;
        b=FT7xos9IiPMT+I9FmVZxJlYldtUqrDWsZgU0sBcjsxvsDyYbLdFnPM78a23+foScE8
         CaRxNsgf9fAFDkDOkhzUHU249p/seDpahpCXabVy0d1HKCAbhkUk2OurmUvh81yRxkMp
         1RbLWAQ0iISlB1SH2Lq8mlWuUm3V9uLOHIpYqUAvNDJtWBPROBU/yVrCBxC52OmmrQgx
         Krczv55beyEuwOQxgno3+p0y2eQI+WN05ko3hwuZagyX4/0EY4rQHjIWXCUkaXdB0VJm
         iI/oq7oaa16Z23hXMF0Cc46t+YjwK79R5GMQnA05DkhgOv6GcmtgSlUTmNSQnVHPQuhc
         MY6A==
X-Gm-Message-State: APjAAAVjqQIUaPkJqRK4QGqb5k+z1wwJILjyHRGP3ahtm4yQjDuVoSlc
        30tIUMUWHyuLLL1pJC7KUsDpQw==
X-Google-Smtp-Source: APXvYqzT7yY171Uj3lkOCncUrwz2j9jISfZ79+XTPrykw/o8bUa0kJNh8nso8pz12NOQBzd7gSDYaw==
X-Received: by 2002:aa7:9192:: with SMTP id x18mr3340660pfa.229.1573046939554;
        Wed, 06 Nov 2019 05:28:59 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id q8sm20785909pgg.15.2019.11.06.05.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:59 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/11] thermal: mediatek: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:22 +0530
Message-Id: <2961e4ac4b32ea7db8b5f6916751a5c02ee85960.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace a comment starting with /** by simply /* to avoid having it
interpreted as a kernel-doc comment. Describe missing function
parameters where needed.

Fixes up the following warnings when compiled with make W=1:

linux.git/drivers/thermal/mtk_thermal.c:374: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt8173_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:413: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt2701_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:443: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt2712_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:499: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt8183_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:529: warning: Function parameter
or member 'sensno' not described in 'raw_to_mcelsius'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/mtk_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index acf4854cbb8b8..76e30603d4d58 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -358,7 +358,7 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
 static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
 
-/**
+/*
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
  * temperature sensors. We use each bank to measure a certain area of the
@@ -400,7 +400,7 @@ static const struct mtk_thermal_data mt8173_thermal_data = {
 	.sensor_mux_values = mt8173_mux_values,
 };
 
-/**
+/*
  * The MT2701 thermal controller has one bank, which can read up to
  * three temperature sensors simultaneously. The MT2701 has a total of 3
  * temperature sensors.
@@ -430,7 +430,7 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
 	.sensor_mux_values = mt2701_mux_values,
 };
 
-/**
+/*
  * The MT2712 thermal controller has one bank, which can read up to
  * four temperature sensors simultaneously. The MT2712 has a total of 4
  * temperature sensors.
@@ -484,7 +484,7 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.sensor_mux_values = mt7622_mux_values,
 };
 
-/**
+/*
  * The MT8183 thermal controller has one bank for the current SW framework.
  * The MT8183 has a total of 6 temperature sensors.
  * There are two thermal controller to control the six sensor.
@@ -495,7 +495,6 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
  * data, and this indeed needs the temperatures of the individual banks
  * for making better decisions.
  */
-
 static const struct mtk_thermal_data mt8183_thermal_data = {
 	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
 	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
@@ -519,7 +518,8 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
 
 /**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
- * @mt:		The thermal controller
+ * @mt:	The thermal controller
+ * @sensno:	sensor number
  * @raw:	raw ADC value
  *
  * This converts the raw ADC value to mcelsius using the SoC specific
-- 
2.17.1

