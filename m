Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05523BF9CD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhGHMJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhGHMJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 08:09:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD88C061762
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 05:07:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id n9so4618496qtk.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2T81iWIL1908Vl2QtcUP1A5GcmnGaJTNEI2g+BHElzU=;
        b=u11BqaH8MRXzLVIuvlIRzdW+JPL3+AgArt5qNzVS7PkwHhq+QBuEQa5ObO21Q9WUh7
         oE+qOc+obZKmwb1NkLUGPn2D9NZJfMKckbrC1YKn5lVkUwlGOwFkGFvzeInfIWvTfCVa
         CQd7UVIwnZtXtGeJsPwNVXjLeqFXPKHpeUP2WIykh04pwilvYYVwdzTQpJv2+QdMJQaz
         1KOmBTEKUsVDqejN8h9L5EUdnf+iyZ5c/r4jokdEx/ME72DCjxbq6NXzijFcMXck46de
         l1b8zhl1Di6g4nhNQ2j5VyhB8gsWHAQnZIDYdLzw66jIDQ6itvT+9c6kB3CkEjsjRcch
         anQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2T81iWIL1908Vl2QtcUP1A5GcmnGaJTNEI2g+BHElzU=;
        b=qxf+28XBlnS/vUKfrfuDUZpdVGWwOaRK/slrxwvKDoY2URqE7JxhunfHFtDTw3cjC4
         Z0UuqsXn4PaTGC6t+gsc1JWoa+bRVLsx1Y6cmMBjF5/cTxr3BHWThXALjRCAecj54Kdg
         MNGRXbrm9jPbwuxLKbLzhJ/tx8iVEUd/yutrjI1xA+s9dQ1XUrrDT0K4ROeIYAY6I5iA
         FpDOtgR6WFmKOWpzEhQiIBcp9yR7M6GKEF1dmWW/kF/uwebND3OshzsXd/ITFzPQaO8q
         FMm7ClgtdpQR8KavUutxxR76nTz4Giip3G/vucbD/0YUOtUhs9zqoaKWj8Tk7wzuRNIU
         1lDw==
X-Gm-Message-State: AOAM533csgTPVPjfPnD1SVflOeUf0h2k+bsn51aoDVOqNqZGMqPnp0CX
        60ah7TIehI+UqntPewWc7WbOow==
X-Google-Smtp-Source: ABdhPJyb2Veuess13LTtJ56DljUn27ruByB7Fmqnh8pXjy9DCb+f2ByRMGtw7O19m+STxoCJGRW2KA==
X-Received: by 2002:ac8:7396:: with SMTP id t22mr24185372qtp.175.1625746022705;
        Thu, 08 Jul 2021 05:07:02 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i2sm912541qko.43.2021.07.08.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 05:07:02 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v3 5/6] arm64: boot: dts: qcom: sdm845: Remove cpufreq cooling devices for CPU thermal zones
Date:   Thu,  8 Jul 2021 08:06:55 -0400
Message-Id: <20210708120656.663851-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708120656.663851-1-thara.gopinath@linaro.org>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that Limits h/w is enabled to monitor thermal events around cpus and
throttle the cpu frequencies, remove cpufreq cooling device for the CPU
thermal zones which does software throttling of cpu frequencies.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v2->v3:
	- Improved the subject header and descrption to better reflect the
	  patch as per Matthias's review comments.

v1->v2:
	Removing only cooling maps for cpu specific thermal zones keeping the
	trip point definitions intact as per Daniel's suggestion. This is to
	ensure that thermal zone temparature and trip violation information is
	available to any userspace daemon monitoring these zones.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 136 ---------------------------
 1 file changed, 136 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 4da6b8f3dd7b..6185fff8859a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4994,23 +4994,6 @@ cpu0_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu0_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu0_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu1-thermal {
@@ -5038,23 +5021,6 @@ cpu1_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu1_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu1_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu2-thermal {
@@ -5082,23 +5048,6 @@ cpu2_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu2_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu2_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu3-thermal {
@@ -5126,23 +5075,6 @@ cpu3_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu3_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu3_alert1>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu4-thermal {
@@ -5170,23 +5102,6 @@ cpu4_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu4_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu4_alert1>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu5-thermal {
@@ -5214,23 +5129,6 @@ cpu5_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu5_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu5_alert1>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu6-thermal {
@@ -5258,23 +5156,6 @@ cpu6_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu6_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu6_alert1>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		cpu7-thermal {
@@ -5302,23 +5183,6 @@ cpu7_crit: cpu_crit {
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu7_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu7_alert1>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 
 		aoss0-thermal {
-- 
2.25.1

