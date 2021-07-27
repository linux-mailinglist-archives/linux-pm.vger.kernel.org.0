Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063F93D79B5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhG0P1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 11:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbhG0PZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 11:25:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286BC0617B9
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id az7so12687831qkb.5
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhlhtB6kcTQQKfLKjl8cL2UvZb7eka/OY6vEI3FE4BI=;
        b=ch3m5I9vvWoJ/eN211uiBVKn0bhgy0z2sv8uDTyS5JAqyv9nUrT2p9VdCtMLgZwt2s
         j+YULrB+kcoQi2FwA9+Mz785LM8gMTL11IXBtXb+UhiLVcOZEd23034RGEJ6JPhqePrK
         lPiVbLO3I5+lyi7LiuInHvd9WfcmE9msQYxB4OMdNKuR/PFQvBE2MJjjhSKXGk1sjNSQ
         DvFHur2ViI3namAnwmn2K6/HCt/mq6laIW4nC9M62zj9y7JMJJBiKJ6izPbFxhcJ8Lyd
         QQBeqcoWOJ7jjpKqQNBwveHPShUDYfH89sMWQd63MWGrg42wr+ahfFgRZ6JCvqrJc2FU
         LlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhlhtB6kcTQQKfLKjl8cL2UvZb7eka/OY6vEI3FE4BI=;
        b=SceWDsxqnB+sJb6Wjl19dBQJ3pIaJLqTRYZLf4Wfzr/Ng+ciPBCB+4aGQM25xA8iJO
         HRt+zGHCto+qyiBNdLa0JlZuWyQuSRbQ3xt4SRT9nvvQDQBVSzPRvLQzR0MWB4FF9iBw
         FCLI/jNTRFjwlBbqy55mTr29Kwtnnup4gH5KqowBisCRgRQMF7CyHSD5fKEZiUREexOY
         fqZPTCw3hALimcnieiAkKB3r3Jva/YE0k1p1CJ4bPbwmVRahkJ1fOy6h/u/ZDA2dGsnw
         vSJ+2XFGPg3as1tEOnQ0nP73W7lpcysDxK52m03cABOfGdvlYV1IS1Kh3TrgO6PHyrH8
         oBAg==
X-Gm-Message-State: AOAM533X2RTu0JR0z2YE7psxM8ZqGrs6wB7ATh4APZDwmwbMG9aOpEiJ
        a9o/f3KvWip79gj4eyHcSqkESA==
X-Google-Smtp-Source: ABdhPJzxnlsUnJKMIHmhyPxDtifd5wNtNbqXOEsV4tRtSIBBGzdd8t6gb2x5el0WmUqn4+KbOUTXCg==
X-Received: by 2002:a05:620a:448c:: with SMTP id x12mr22864423qkp.39.1627399518539;
        Tue, 27 Jul 2021 08:25:18 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id q4sm1539663qtr.20.2021.07.27.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:25:18 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [Patch v4 5/6] arm64: dts: qcom: sdm845: Remove cpufreq cooling devices for CPU thermal zones
Date:   Tue, 27 Jul 2021 11:25:11 -0400
Message-Id: <20210727152512.1098329-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727152512.1098329-1-thara.gopinath@linaro.org>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that Limits h/w is enabled to monitor thermal events around cpus and
throttle the cpu frequencies, remove cpufreq cooling device for the CPU
thermal zones which does software throttling of cpu frequencies.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
index 0bf98f072921..14dc41c4a98b 100644
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

