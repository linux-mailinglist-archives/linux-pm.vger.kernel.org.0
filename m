Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5DD81B7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfJOVRR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:17 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42201 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbfJOVRP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:15 -0400
Received: by mail-lf1-f42.google.com with SMTP id c195so15614016lfg.9;
        Tue, 15 Oct 2019 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3W7MvB6E6Ny/9ddBeJGfjcJec5eVg0QAvTdQSwxlb8=;
        b=iORu0CoauOA1cYo/cz3PxpeNuzgDBOdtd7JSjxfseD0Y4UZbT0+nDYsofgVQ542Wxo
         vIxy/LHqam0b14L30Io1J55OCLl/UeEEj0VK+SAEr/A2XyBFtnpLpWjB0x04YIe8Hexo
         tbL6zG8L2jFVkFS5PDlpestwIUDISMI3ZQbSmHeIrA+cGGT0sMIYvsYNPWJ59lJDItU0
         WXdatpAFjR4VpFIewIrLYYo3+SeWGSEAoHgzTRK8/8Oji/4pmI8mSeOUIgrZheBkZUOG
         2/iWzLERYc54UdCqkeOGdPQT/Wm6/FZwEtxDHaQ/hRepnx/2TXm8rUI8EzUtVvgIHtRP
         ha2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3W7MvB6E6Ny/9ddBeJGfjcJec5eVg0QAvTdQSwxlb8=;
        b=WsyFd/S10v8phNENQi70tyJr49Z9eXa9KkY9sk36sgUnss5gYPcaI4Y77FL6dGaS0o
         7K1N/c58R53B0lrTxZC+CphPU5FjcU90ilnWdHSZXNIWGK6kKRXTFEojNvhp4+FlMu6w
         S4rs/V+0A+jEcDJDN9Kieg0ERpmoQbRpudp1YcoHQ95yliBLqrtj82aewaYvcoRxlUkf
         R0wuBQLjS4IETGwjm2wwnLZR6UWr3wk9Qh2DaK6PPX6lJACoSbwloxoYOEi2ovEVNeRC
         tuaDY86lOPQfKWMX7NloCZdLgFMAFhMJLEzpJ8zUs4ZFOJIhts2zP65oXSInTNFdIBIz
         FKLA==
X-Gm-Message-State: APjAAAUjbgLPVdrInltFl5MKr/xorgBuYyIV0vmFpKwhHSPVd8MBfSsV
        LcJa6L4wciv5o1QE3BseTbA395x9
X-Google-Smtp-Source: APXvYqxeqBhzZcZxqS5Eu03lHq6hP5IwAeffxXBZghJxlLPEoiArLYvXb7JjBhjCJUU+GV3Fgoqm2Q==
X-Received: by 2002:a19:641b:: with SMTP id y27mr19621349lfb.3.1571174231458;
        Tue, 15 Oct 2019 14:17:11 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/17] ARM: dts: tegra20: Add CPU Operating Performance Points
Date:   Wed, 16 Oct 2019 00:16:12 +0300
Message-Id: <20191015211618.20758-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
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

