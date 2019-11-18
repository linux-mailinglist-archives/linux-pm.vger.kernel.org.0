Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13B10099D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKRQrB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:47:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34095 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfKRQrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:47:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id l28so4907136lfj.1;
        Mon, 18 Nov 2019 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=IGVCd2jc4txLjHf/sfY4X+avJaXXVtxQiUXMfIumvdKaSAsNVzOtgcdtd+AHwpBqbO
         7n/eTuOLD2NtFqmwiRinl5eTiqFcO2MsujzbRHbZG4KoBVqdb2FRgFpvtz8plrhU2rrK
         0wItbJRA/PkavAFlXydHA8ROKZ1CfCqZVfbo5GkWzXMxYLWpvLGY2VHgwvX0ji8HKj1O
         cVmUMkz5AwoNLLUYqlsW9fuA7r9BFxvq0dkxEVRxJcVNLQe5qRfEtHYEc9VRv8t1+GVV
         HYT/BWiNOY5zamQOKShxM6d50RQ8FQayJ8RKvSIfoXfwRcP2qh7QNcIi5UPGgONFpW9m
         5oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=eb4u8p9y2boFvjHGb1+CObnkDiiw/dIDVwXpVW+CgFcxHcF5rL5YkXUbRdt1blVsXT
         ZE8GevYqG2EEhi5TubeROpiihh3vjVpI6iZzPDbEkMPHzIOo1LX8y2mBv4W/HXtydktW
         2KXUIHWSvQbTM2OTrFdEsgB0aveR7zkEDMeU7M04kn8CmT3pK5XN8vx6wrTM9e6Ow7Ox
         NRtCI0jn30IWeVR3u1RAzYFbRwgwgJuo/YCTpM6xBi49hPt1gK7AyqNIloSezTItj32K
         YWnVm3H7BuulJl7tgroNwk+EKGVy2s1kdn6W99xaK6EQJ+Zetiwo8Fi8MHAtjdFdhNrb
         q8pg==
X-Gm-Message-State: APjAAAWMfcKVuKx3HuOnCAwUSG35xeFC4L8jws6PzazKKAe6U2vZlgnO
        yEiTUPhMoU+B5A5nkBxw/Wc=
X-Google-Smtp-Source: APXvYqz478Bvh3VIehym/uGsiaTo42wDcevqvFNsiDJQj3upXVODL5mRJOxBSLNYfHEXEbPKE7y8Jg==
X-Received: by 2002:ac2:5deb:: with SMTP id z11mr261378lfq.35.1574095617798;
        Mon, 18 Nov 2019 08:46:57 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:57 -0800 (PST)
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
Subject: [PATCH v5 11/11] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Mon, 18 Nov 2019 19:45:12 +0300
Message-Id: <20191118164512.8676-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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

