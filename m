Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECD3F81BB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKKU52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40153 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKKU5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so15324889ljg.7;
        Mon, 11 Nov 2019 12:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=qOXt9iKFr6xDFBoRl5SK08VLRff6TgxB2rYOoxCnGnD9ts6+XwNII6M3acbMna2hdm
         rtmkqVd7RqhlKm74cDnJ33qNeeB4Lt0lZ2LjKmOfYqoV6VLIO/sdSC2Q98+4SMLuYYdw
         I4CsKrhL2tFpd533/RmENck9GGLadx3xITeW9TUtnFNM3CdVcrAVhRfQ6+ykzRRhG0ix
         5g+dphPPoJVHJXb8pYHuRuyvvRKDeip0NFFjrz5oQhztZpQHjEpvL76UkQm0AS8OLE/9
         NhT21CVpE1HY/46aqLg9AqaxoT+HawSuOpPm2RB49eLgU6SdgQNzhJuZFPZ8m9PHb6yu
         HEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=aDu+ghao32Tn1uGuj+u0+tlbuSX/JfgZ3KebArLJCaBPUOxUcMqRVkquL8Pkp7e78Y
         JmVQwx4WSvhsIpmbXC4I8FD5X5jjVosUQuGl/q6VvKJ+0duzQaF5p0boHksEDatYryLR
         MqTQvorjHELwfW6ckGF01XC1+ploWtR61zp4H6jprbyLML+8mn4Vs89o6qLu/C3vQFEi
         QoqoX5b9+YEmmvuKdRGq3whhB+dXV4EYRuqgyuaruy0rJW4SVtvbMjBGJaXzvGIk0unX
         2kb+W1za2HLRmb9ri2Y8whcSDfWWDe0iDpmgYu8ScWkHEuNIaHVEb1laVIaemM++2pXS
         ni6A==
X-Gm-Message-State: APjAAAXQdcE1HmXO+uiCClrFEEfsk4rXHEKb6qG969gLAeqEOjgGWN44
        zidd/vd01i+0A4YKjnr4fDc=
X-Google-Smtp-Source: APXvYqw7eSx5xIx3Pz7djTsqEWoIjJUneZL+QJcwMA6cb31frF+zzEu5E30djLMcC9WQg50DT+3ngw==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr17898135ljn.88.1573505837820;
        Mon, 11 Nov 2019 12:57:17 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:17 -0800 (PST)
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
Subject: [PATCH v4 10/10] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Mon, 11 Nov 2019 23:54:19 +0300
Message-Id: <20191111205419.16768-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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

