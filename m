Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B13A06D0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhFHWbu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 18:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhFHWbt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 18:31:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86339C0613A3
        for <linux-pm@vger.kernel.org>; Tue,  8 Jun 2021 15:29:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j189so21937351qkf.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cH/M8hML98gLh8w+CTkpmO+RznC7BLW0JshH/2U89MM=;
        b=gaeaJcXtCHi2LjfYTKJF92D0iJmI0eBUZX9Wx31ODbJw9wCkG5tuYU8pN+ru++udBq
         nEjWgm5txPHHjIEyBE3SGNPg+UqL6xIId7dWSYNSAKGTVb64gcmAt5YdnsuUh+22AthW
         4PolUglQk5HDQFTjr4tV4D2j97Bob8977MrxqyEugM57j4nhrkzKtuM+nQYmrFYqOy4n
         fN67xSra70Qzs9ygcL+4pD6+P931wRedwo8j/htyqSSfw+J5Xq3MEHsnPM7pNWerFj8p
         wPmWH/nRzhuXy5y9yusgL9VU7eZPZnlZl24HnJDh9t1dsbnIH/4gLhve23ailyT6sYKe
         aezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH/M8hML98gLh8w+CTkpmO+RznC7BLW0JshH/2U89MM=;
        b=fIsYVudzzz2CmSM19RZoai7BYek9Bj+gjuw1t2f7A5npB0WZwYGWw0aj+twzrUohEe
         DSS9TLt/WwKgrEmtZ0YWirV2T/71o0qljSJJobSmrxK4Geii69AAblgK95+9pGBSjsl9
         5NfExrip9qv4B1fKQsgXAsU84o3friK12jPDk+lman4xZh7ooIphLhHHzJIY94TFZqo4
         4DCta4xRg1NoUMb3A65uu3jpLhr47PflihZiV4DKDJz6Wn6780QT6xwDSYQzfDExtIuN
         M3x5n/tKLWMALvjIEs70mjt8v7g9TMaUJ5O2tbNZvs2HkA9pl7EqMYBw2lPlUTsIOIHn
         ZzOQ==
X-Gm-Message-State: AOAM532MqG2uVxfUrhQOi5QFojTm8RFqMyiQm4pXuq7Vx3DAutR0SMVb
        9ilzKFfBMCa6JNRyQmbucEKL6A==
X-Google-Smtp-Source: ABdhPJzzPv33n8TyS0JmOTg0ugsTAWEwo3D9m79ayv2QjS8XIcBIWdg90fzWkWpUKMDvYhe0lgAxjQ==
X-Received: by 2002:a05:620a:1454:: with SMTP id i20mr22818025qkl.91.1623191371612;
        Tue, 08 Jun 2021 15:29:31 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h19sm10450736qtq.5.2021.06.08.15.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:29:31 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/5] arm64: boot: dts: sdm45: Add support for LMh node
Date:   Tue,  8 Jun 2021 18:29:25 -0400
Message-Id: <20210608222926.2707768-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608222926.2707768-1-thara.gopinath@linaro.org>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add LMh nodes for cpu cluster0 and cpu cluster1. Also add interrupt
support in cpufreq node to capture the LMh interrupt and let the scheduler
know of the max frequency throttling.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..fdd8d816f728 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3646,6 +3646,24 @@ swm: swm@c85 {
 			};
 		};
 
+		lmh_cluster1: lmh@17d70800 {
+			compatible = "qcom,msm-hw-limits";
+			reg = <0 0x17d70800 0 0x401>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,lmh-cpu-id = <0x4>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@17d78800 {
+			compatible = "qcom,msm-hw-limits";
+			reg = <0 0x17d78800 0 0x401>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,lmh-cpu-id = <0x0>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		sound: sound {
 		};
 
@@ -4911,10 +4929,13 @@ cpufreq_hw: cpufreq@17d43000 {
 			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
+			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			qcom,support-lmh = <1>;
 		};
 
 		wifi: wifi@18800000 {
-- 
2.25.1

