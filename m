Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC818BFEA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCSTE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34432 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgCSTEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id s13so3803315ljm.1;
        Thu, 19 Mar 2020 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NDM3y718xZuy8aOtgXuzMNzfqLpqznJlVGk7yDXVsI=;
        b=oSCaS/SYuXxnhdgHKyWrJhoZyTBX5rU/amUONz2Ljsi/UiU7X9UhOb6QOCdMI9hK7Z
         Eg3hP/HymfYWM547Fz875jonQgbas/3ZQDC5ZoVellGkCAKC6iMxYLEZy2J7oCaiNMfO
         UH4+I/++JolujZGrZ3u0P+NaL0MOs+O3UH/4W41YsdjdP1mZUck7aEbkFrKmt4kg3fnB
         2jashczYx/oyzhIf+uB/NYO8Tg0tUBEML5MWUDykUxQUfPDf9IHYoI+AHBCMt/kHYmjr
         vx/lyT/ODByTEil/EPM2sM0/6PQi+94rfHaMEwPA5tI7OD+29A1P2F3RZQ9M0GSYohnw
         TdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NDM3y718xZuy8aOtgXuzMNzfqLpqznJlVGk7yDXVsI=;
        b=USLp0Dj/KUc5kAXvkiCGWeoVwZ/TmDqEfeqkYMmoc9dR/x/d1dsL/Fls0eV3CYIvnJ
         ngv9rrHN73I4yu1nY3qT/CuMP3R+/WdOdPklMhkEbHdgD2jGwyqWY1+EYAjVPgGrANza
         HWFADgzF37GZXNsTY5xFlRJPh5Cb/IHUxi0aTzwMwnj2xZat8vRrXU2rZdSmQGoqEL7c
         dUOQAQVrCdMN5IMNO7T9NMGjgWZ8y05taKEUsBiiFFQAQUY3JJNqSLsEbrgpSB8/kitW
         G4tbbPgMYAO0tCtWBtDktRpAhgiApP/cMiErnLWmUm1r/SDT2Hp93H1ycW0KVYUpyNot
         d+Vg==
X-Gm-Message-State: ANhLgQ3ZBGjC3CMQZRrV63OjFrwm1uwDXIjT54tiQ1k/o5ZwcYgQWNQj
        q3/mWv3SLm5tM6eL5NbIt9Q=
X-Google-Smtp-Source: ADFU+vsT7jEftmMyIkFi6InTDoQcYx/pXDz1dObMgQwcHj/ITyzMDqlO3CNcFOHP4By0rSwhidK8Pg==
X-Received: by 2002:a2e:860e:: with SMTP id a14mr2934829lji.218.1584644658471;
        Thu, 19 Mar 2020 12:04:18 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/12] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Thu, 19 Mar 2020 22:02:25 +0300
Message-Id: <20200319190229.32200-9-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device-tree binding that describes CPU frequency-scaling hardware
found on NVIDIA Tegra20/30 SoCs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../cpufreq/nvidia,tegra20-cpufreq.txt        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
new file mode 100644
index 000000000000..daeca6ae6b76
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
@@ -0,0 +1,56 @@
+Binding for NVIDIA Tegra20 CPUFreq
+==================================
+
+Required properties:
+- clocks: Must contain an entry for the CPU clock.
+  See ../clocks/clock-bindings.txt for details.
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: Two bitfields indicating:
+	On Tegra20:
+	1. CPU process ID mask
+	2. SoC speedo ID mask
+
+	On Tegra30:
+	1. CPU process ID mask
+	2. CPU speedo ID mask
+
+	A bitwise AND is performed against these values and if any bit
+	matches, the OPP gets enabled.
+
+- opp-microvolt: CPU voltage triplet.
+
+Optional properties:
+- cpu-supply: Phandle to the CPU power supply.
+
+Example:
+	regulators {
+		cpu_reg: regulator0 {
+			regulator-name = "vdd_cpu";
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@456000000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		...
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			clocks = <&tegra_car TEGRA20_CLK_CCLK>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			cpu-supply = <&cpu_reg>;
+			#cooling-cells = <2>;
+		};
+	};
-- 
2.25.1

