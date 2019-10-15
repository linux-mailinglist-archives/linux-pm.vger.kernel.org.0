Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFECDD819A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbfJOVRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44964 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfJOVRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so15592290lfc.11;
        Tue, 15 Oct 2019 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=Y9Qdf/yXecKQYqfhyrhF+OctANbgP6NhHJ/lHIUrGofkRlZ36WhCg36PjsdD+D1F87
         F1SR59HW3m/6cSdXm8++NRCgUOWBjizPw6+2MjEHLJI/UwbHgCjPcs90+oljKw4ekdG3
         87ahlNPrZXWXoz3lAHxcXV3URqbWf5RRIAjFiHofmseZl3o7FNSv3wSA3w9bRLgXB/8I
         ZMLA0bWZs0vlExfTgQe/fspp+DK/i5FsEXE5rGMPGUXim53rVXjnmP5WXrTxqoDGUhET
         XD2ZIZvCjN43Px3r8uOK0zzxGd5TtSlg2tN1a29EBxGDnNhDk2V+dbpAwCtlQJHjZb+h
         e1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=rvHYDB43QqIdRjz9kM9iiSPKpSE6PTwU/BKo1v+29IDwl6R371qHBRmDgne+9/r2iv
         AKVe0d/QkeK/MSL/S+mdCq88k0xJ5m/LqbMlhTZAZS1XvY+FMS/yoVXA2aI8MU4eFRBt
         I8oh/fMLt08TWfenzMBgFVFOl/hTpqzcwfjrE/bHrESJtJO7s4P0SJQ8H/yLQrjPJ7n4
         ErswsciCCXYV+Vp9pEhSaJHjEBE5lwolZ3hyila8q3vfgODp8E9diKweMLqM+z1skwbL
         v+xnlf+VXZYOhhTzsHEYicOPzLyV61nc+IJx7zha8h4RjYdjDa8Z/ktLor/dfhObEyFq
         Qcpw==
X-Gm-Message-State: APjAAAXLcWiUh7SE65QOFZbkiR3X+6afzDliXHvzXQROJxQjbhOpylHo
        FY8ZNuSEyR/0C5CaISVShRc=
X-Google-Smtp-Source: APXvYqxXjpimhV6kFhHokWelbNsb2M3y3hVRm7AQf1GvTkNMHFlyLgSIT1SSOJoE4AnEjlUXmaGe8w==
X-Received: by 2002:ac2:420a:: with SMTP id y10mr21823910lfh.65.1571174238100;
        Tue, 15 Oct 2019 14:17:18 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:17 -0700 (PDT)
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
Subject: [PATCH v1 17/17] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Wed, 16 Oct 2019 00:16:18 +0300
Message-Id: <20191015211618.20758-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on beaver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 6ebb3105af9e..86556622be25 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -2,6 +2,8 @@
 /dts-v1/;
 
 #include "tegra30.dtsi"
+#include "tegra30-cpu-opp.dtsi"
+#include "tegra30-cpu-opp-microvolt.dtsi"
 
 / {
 	model = "NVIDIA Tegra30 Beaver evaluation board";
@@ -2124,4 +2126,26 @@
 			 <&tegra_car TEGRA30_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@1 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@2 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@3 {
+			cpu-supply = <&vddctrl_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
 };
-- 
2.23.0

