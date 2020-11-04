Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773C42A6AF5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgKDQtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731442AbgKDQtl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:41 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C98C0613D3;
        Wed,  4 Nov 2020 08:49:41 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id l10so2704107lji.4;
        Wed, 04 Nov 2020 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FVv3BbkAu5vijvZy0/g8D/gSJwLwAaxtQyTiLpi4B8=;
        b=DEbFYKMcdoH48FN2/uyXUSKvK0hCwgs9jDu+ko+KosDrC62VOnUtAL/3lEG+UwTtTP
         CRRI84LwRW1IqzJ1qVLNHGzelsTrjKI13WiIYf0t9MJXDrgYs+LdiblQYIbQ5YiaSa78
         R/fC75sA6xgcPx0AjKdHm+/jXFgBrxjsxXQocUq38LrRsEDQaMN2eRB1gAr9bHzI0ye6
         p4yCRU+itdACg1YMCB4JYW0hYdlNm2I0VbGJUr1Se3mSy+LasQ9xc0LG1Mnl/knF9Xkh
         nGf7OUjL1fNakCeZSqPOavJMScyiXtPR9huMzU6AmR+yQZlDnbSbYeJgptPGZQR5GjT5
         mz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FVv3BbkAu5vijvZy0/g8D/gSJwLwAaxtQyTiLpi4B8=;
        b=LrDjb4Ac/+OkPmrIjj7rx3Bp59MUuXgH+9Iu3F0CMOCKY9VN54nDuISEmrscV2rpGt
         WPw4uvVdYMRhHAJVq+F8h6QvgwFGLWvMR6J78TsIAZk32fZ/sZvtn/0iZvtPvWGg6e8c
         5z9WJcbAD5U3+9Z9CIJaC7q05jh/eghleHmGSDLUfPp3Y/XUnfBV8RoibZEpkJOjgwrT
         j1N5S6F+Xd0HMvvVLvJ5TPmv7txdKpZvwOoAgyefyJs3jAffEQPng93B49OSTyHKwtC5
         NfMsGpXtRjRxvClJBZKoPTL4HUiikwMM4LJnEpKSvaYDq2ixTluLhCQ9hgq+ZxyMxOXl
         CHTg==
X-Gm-Message-State: AOAM533QBGIfomeHgoyEugI8xw0VS+tGKuVxA/NKCq7+XJroQVX/vDD7
        iBsoBqoBcSIzMQrpMh862/U=
X-Google-Smtp-Source: ABdhPJwyAlb0a8HWHX8gVPMOoMubt/guWwT7XX6botKnEiM48IOWNSbdR9Xn4p979LWrEeFoDHl99w==
X-Received: by 2002:a2e:580a:: with SMTP id m10mr2371255ljb.167.1604508579935;
        Wed, 04 Nov 2020 08:49:39 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 08/47] dt-bindings: memory: tegra20: emc: Document OPP table and voltage regulator
Date:   Wed,  4 Nov 2020 19:48:44 +0300
Message-Id: <20201104164923.21238-9-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SoC core voltage can't be changed without taking into account the
clock rate of External Memory Controller. Document OPP table that will
be used for dynamic voltage frequency scaling, taking into account EMC
voltage requirement. Document optional core voltage regulator, which is
optional because some boards may have a fixed core regulator and still
frequency scaling may be desired to have.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra20-emc.txt    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 82bc5b2ae7e5..67ac8d1297da 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -14,11 +14,25 @@ Properties:
 - clocks : Should contain EMC clock.
 - nvidia,memory-controller : Phandle of the Memory Controller node.
 - #interconnect-cells : Should be 0.
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+
+Optional properties:
+- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
 Example:
 
+	opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp@36000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <36000000>;
+		};
+		...
+	};
+
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
@@ -28,6 +42,8 @@ Example:
 		interrupts = <0 78 0x04>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		nvidia,memory-controller = <&mc>;
+		core-supply = <&core_vdd_reg>;
+		operating-points-v2 = <&opp_table>;
 	}
 
 
-- 
2.27.0

