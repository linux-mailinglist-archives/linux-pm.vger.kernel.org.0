Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03402E3F0C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfJXWRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34800 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfJXWRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so176311ljf.1;
        Thu, 24 Oct 2019 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyeemQ0BD/0xxv0VoQdUNZMw7D9f8kOSyLfyEMsDjUQ=;
        b=HNJEUTLCzkiiAaCcmQY/I4yWcZUwITHxxqHK6Z+9aTuWM8Vn+WP11A2oXh8eFChrk2
         haWPbwVyudQ3VgxbBy85wWJWpRDyoyFmcO++c0cmn1NQrrSosINwks0u690ApnTAog8n
         Uye4n2Hp+lG6zCjS060lLdo5VlO0gmAX0yHhu/nIh7KTIXlQ6fVCZUQmSqLBEDFolZVr
         SzpfWbEfQSPWV1AVX8rpf2+76hN8h/pLt7BLycTFC/k/we+iZnuZjCB6338Naal0sFKr
         sSJfJPpoVNR9lRUW7up3ROuAx2vwXvw9C7e49EGCbi7D4rFHRYXnS7RVLIeT8sFvQ2dX
         xfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyeemQ0BD/0xxv0VoQdUNZMw7D9f8kOSyLfyEMsDjUQ=;
        b=pRZwsdvTOuD6NawI2vR38aGKIiWOgxjTUYfCyp0F800NIKPJS4xHZv2WWMIi5Nidmw
         BtagvdhuDnej9mJYewtzvGs0HAyARPEydwC/hAj8/8VYtX+1xDz920+qSpEBOP0BrZST
         Uj2iKx/gD0Wpz7l138m1aoZVaxKU3dub+h73xBMEYXAsQvzn2N6W1dn22UJ5TrhiVlQd
         UPD30q25HcejPm6TtWNbxRFjTjV9jQbtVcxkpdtu16e/IBE+BHvQgrl5asZTptBWZhDI
         ytWQcOTW3OJfohIgUrgAccsiTplkd6MB/tzAp1iKjOQTWczXElubHGT8SjKktLXx0fZi
         0ucQ==
X-Gm-Message-State: APjAAAUeSqjomvjfeZVyrJ/C1RePZZTLcTcUqC5FC9ToYa3p1wwCNwFp
        DOZiaE+u23AC+rDh16iRwrU=
X-Google-Smtp-Source: APXvYqzGBFWILbBXuJk4zP1hX3vM/oDGe/vddUp8mp6X7naSisZ0z1LuonO1gdP63m8hK6c52HbOVA==
X-Received: by 2002:a05:651c:8b:: with SMTP id 11mr54367ljq.100.1571955468324;
        Thu, 24 Oct 2019 15:17:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/17] ARM: dts: tegra20: Add CPU Operating Performance Points
Date:   Fri, 25 Oct 2019 01:14:10 +0300
Message-Id: <20191024221416.14197-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Operating Point are specified per HW version. The OPP voltages are kept
in a separate DTSI file because some boards may not define CPU regulator
in their device-tree if voltage scaling isn't necessary, like for example
in a case of tegra20-trimslice which is outlet-powered device.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   | 201 ++++++++++++
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi        | 302 ++++++++++++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi

diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
new file mode 100644
index 000000000000..e85ffdbef876
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	cpu0_opp_table: cpu_opp_table0 {
+		opp@216000000_750 {
+			opp-microvolt = <750000 750000 1125000>;
+		};
+
+		opp@216000000_800 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@312000000_750 {
+			opp-microvolt = <750000 750000 1125000>;
+		};
+
+		opp@312000000_800 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@456000000_750 {
+			opp-microvolt = <750000 750000 1125000>;
+		};
+
+		opp@456000000_800 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@456000000_800_2_2 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@456000000_800_3_2 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@456000000_825 {
+			opp-microvolt = <825000 825000 1125000>;
+		};
+
+		opp@608000000_750 {
+			opp-microvolt = <750000 750000 1125000>;
+		};
+
+		opp@608000000_800 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@608000000_800_3_2 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@608000000_825 {
+			opp-microvolt = <825000 825000 1125000>;
+		};
+
+		opp@608000000_850 {
+			opp-microvolt = <850000 850000 1125000>;
+		};
+
+		opp@608000000_900 {
+			opp-microvolt = <900000 900000 1125000>;
+		};
+
+		opp@760000000_775 {
+			opp-microvolt = <775000 775000 1125000>;
+		};
+
+		opp@760000000_800 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@760000000_850 {
+			opp-microvolt = <850000 850000 1125000>;
+		};
+
+		opp@760000000_875 {
+			opp-microvolt = <875000 875000 1125000>;
+		};
+
+		opp@760000000_875_1_1 {
+			opp-microvolt = <875000 875000 1125000>;
+		};
+
+		opp@760000000_875_0_2 {
+			opp-microvolt = <875000 875000 1125000>;
+		};
+
+		opp@760000000_875_1_2 {
+			opp-microvolt = <875000 875000 1125000>;
+		};
+
+		opp@760000000_900 {
+			opp-microvolt = <900000 900000 1125000>;
+		};
+
+		opp@760000000_975 {
+			opp-microvolt = <975000 975000 1125000>;
+		};
+
+		opp@816000000_800 {
+			opp-microvolt = <800000 800000 1125000>;
+		};
+
+		opp@816000000_850 {
+			opp-microvolt = <850000 850000 1125000>;
+		};
+
+		opp@816000000_875 {
+			opp-microvolt = <875000 875000 1125000>;
+		};
+
+		opp@816000000_950 {
+			opp-microvolt = <950000 950000 1125000>;
+		};
+
+		opp@816000000_1000 {
+			opp-microvolt = <1000000 1000000 1125000>;
+		};
+
+		opp@912000000_850 {
+			opp-microvolt = <850000 850000 1125000>;
+		};
+
+		opp@912000000_900 {
+			opp-microvolt = <900000 900000 1125000>;
+		};
+
+		opp@912000000_925 {
+			opp-microvolt = <925000 925000 1125000>;
+		};
+
+		opp@912000000_950 {
+			opp-microvolt = <950000 950000 1125000>;
+		};
+
+		opp@912000000_950_0_2 {
+			opp-microvolt = <950000 950000 1125000>;
+		};
+
+		opp@912000000_950_2_2 {
+			opp-microvolt = <950000 950000 1125000>;
+		};
+
+		opp@912000000_1000 {
+			opp-microvolt = <1000000 1000000 1125000>;
+		};
+
+		opp@912000000_1050 {
+			opp-microvolt = <1050000 1050000 1125000>;
+		};
+
+		opp@1000000000_875 {
+			opp-microvolt = <875000 875000 1125000>;
+		};
+
+		opp@1000000000_900 {
+			opp-microvolt = <900000 900000 1125000>;
+		};
+
+		opp@1000000000_950 {
+			opp-microvolt = <950000 950000 1125000>;
+		};
+
+		opp@1000000000_975 {
+			opp-microvolt = <975000 975000 1125000>;
+		};
+
+		opp@1000000000_1000 {
+			opp-microvolt = <1000000 1000000 1125000>;
+		};
+
+		opp@1000000000_1000_0_2 {
+			opp-microvolt = <1000000 1000000 1125000>;
+		};
+
+		opp@1000000000_1025 {
+			opp-microvolt = <1025000 1025000 1125000>;
+		};
+
+		opp@1000000000_1100 {
+			opp-microvolt = <1100000 1100000 1125000>;
+		};
+
+		opp@1200000000_1000 {
+			opp-microvolt = <1000000 1000000 1125000>;
+		};
+
+		opp@1200000000_1050 {
+			opp-microvolt = <1050000 1050000 1125000>;
+		};
+
+		opp@1200000000_1100 {
+			opp-microvolt = <1100000 1100000 1125000>;
+		};
+
+		opp@1200000000_1125 {
+			opp-microvolt = <1125000 1125000 1125000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/tegra20-cpu-opp.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
new file mode 100644
index 000000000000..c878f4231791
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	cpu0_opp_table: cpu_opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@216000000_750 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x0F 0x0003>;
+			opp-hz = /bits/ 64 <216000000>;
+		};
+
+		opp@216000000_800 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x0F 0x0004>;
+			opp-hz = /bits/ 64 <216000000>;
+		};
+
+		opp@312000000_750 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x0F 0x0003>;
+			opp-hz = /bits/ 64 <312000000>;
+		};
+
+		opp@312000000_800 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x0F 0x0004>;
+			opp-hz = /bits/ 64 <312000000>;
+		};
+
+		opp@456000000_750 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x0C 0x0003>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@456000000_800 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0006>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@456000000_800_2_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0004>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@456000000_800_3_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0004>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@456000000_825 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@608000000_750 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@608000000_800 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0006>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@608000000_800_3_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0004>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@608000000_825 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@608000000_850 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0006>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@608000000_900 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@760000000_775 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_800 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0004>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_850 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0006>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_875 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_875_1_1 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_875_0_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0004>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_875_1_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x02 0x0004>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_900 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_975 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@816000000_800 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0007>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@816000000_850 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@816000000_875 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0005>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@816000000_950 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0006>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@816000000_1000 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@912000000_850 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0007>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_900 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_925 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_950 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x02 0x0006>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_950_0_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0004>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_950_2_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0004>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_1000 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@912000000_1050 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@1000000000_875 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0007>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_900 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_950 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0004>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_975 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1000 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x02 0x0006>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1000_0_2 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0004>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1025 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1100 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1200000000_1000 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x08 0x0004>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1050 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x04 0x0004>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1100 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x02 0x0004>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1125 {
+			clock-latency-ns = <400000>;
+			opp-supported-hw = <0x01 0x0004>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+	};
+};
-- 
2.23.0

