Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E81F81C0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfKKU52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45192 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKKU5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so15301203ljg.12;
        Mon, 11 Nov 2019 12:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=UvEClIcN8WZ8RnOeSljmPiqtYRldJCcTvniINhrz4IZH9F5gKt1n3zylNvgNoqYjbm
         WUXvGEbe1YxJvnJm+dtM38/3CLrL/HrI6b04AeDMtgnfY8X5aAYtyNmllm7C1jcZpuhn
         NXwLaizPHXXg0W9Ro+fVA76dQcGkRcGLULdK/rbmvbVpA1Qy0jYC0X1hvL8SbiAYxVuC
         uMkujfWuemoMzd6QBbZB5jSGLlQ6idyUGf/BXpE7XLe692vApPgyco+baKWVTEIVL3ud
         eDnfBcYMl3DzU7CHrhr+sSCg5Bm4D3fc/VR7k2AXcLrdyPnuO/NIKQ+U9ywvS03oFl9l
         Qw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=mq4lh0uWqv79Daj/0fn13d612kBteLAZawJc+PIFfqS5pIh5G+mxA0mgfqewKQJ1ph
         9YIsFCh6F1FSs0xXd4Uzuhq+SQcwCrcHSuu3LbUqaDd5zDt9BHscx7LKk7KEx9MS+dpo
         aOWxG3C2cHx3U+45Kkj+yLAaRDRlU+5ppzXETBd+W5xk7V7mutiKdwIKLDRM5PWPPKe7
         jRMACGL5KxwVv2pxyLwH4553ZIrT3hMGYhbntTfDMzaiVVs1yzQ8PBd5cWY2iZP7Ql3q
         Trgv8yHMZtARK1WabHiXkPZRQMTXXhWn5T8gZNeavKr0RUrHqs5DLiNakojQJRruzsYI
         Wh7Q==
X-Gm-Message-State: APjAAAVWzXmkJhd/G1hX5bM3PJIEn4zAZFDWsFyohnPs/1Jyciq7DG8B
        cmX+cvrbrcnC3QWS6aIdViM=
X-Google-Smtp-Source: APXvYqx0AE7hJku7PB19jg39VXRzfIicaXFKyo3DiPAN1a5bI5RuU2L4MoDgdh2eE83w1Gq86Gcbfg==
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr17180281ljn.188.1573505836788;
        Mon, 11 Nov 2019 12:57:16 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:16 -0800 (PST)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/10] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Mon, 11 Nov 2019 23:54:18 +0300
Message-Id: <20191111205419.16768-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set min/max voltage and couple CPU/CORE regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index a3b0f3555cd2..6ebb3105af9e 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1806,9 +1806,14 @@
 
 				vddctrl_reg: vddctrl {
 					regulator-name = "vdd_cpu,vdd_sys";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
 					regulator-always-on;
+
+					nvidia,tegra-cpu-regulator;
 				};
 
 				vio_reg: vio {
@@ -1868,17 +1873,22 @@
 			};
 		};
 
-		tps62361@60 {
+		core_vdd_reg: tps62361@60 {
 			compatible = "ti,tps62361";
 			reg = <0x60>;
 
 			regulator-name = "tps62361-vout";
 			regulator-min-microvolt = <500000>;
 			regulator-max-microvolt = <1500000>;
+			regulator-coupled-with = <&vddctrl_reg>;
+			regulator-coupled-max-spread = <300000>;
+			regulator-max-step-microvolt = <100000>;
 			regulator-boot-on;
 			regulator-always-on;
 			ti,vsel0-state-high;
 			ti,vsel1-state-high;
+
+			nvidia,tegra-core-regulator;
 		};
 	};
 
-- 
2.23.0

