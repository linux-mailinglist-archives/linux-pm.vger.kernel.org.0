Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2215B510
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgBLXqr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38854 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgBLXqq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4432697ljh.5;
        Wed, 12 Feb 2020 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdwll2I+0UIi7XhGuE9ZdnnXdDMdxuduY/8e8BdrqG0=;
        b=DPJAFE4Xa0zWnM4wQBIUIw+9iy542KOe40KcuQLCRhxoMVl6zFobIkvzwIeFRTpd0z
         NNmpDp2C4rpRYwl5z9hq6RzpwXXJupuSzW65NTMjHUrO1U9UsuyliLiItt4GEnuljSjY
         ANL2x3l5c/D+xLDYZW+NGcZoXj4k5QI/Mx6KUie7HQZl9UJu4+QXDIqrd4ISmpWMpuUd
         w44TWa/ctADXqby1JOlga4Hdnk8QCe3Mrzd1XPlnnvzHdI4hJ+7K4itvOVW3oYNxg1aR
         +6N0yuF0a57AFRH0xk1hx40nE3SmJ13xJEAV7rWlLB/M+iGZGFU0W/VrS/oMhzBaaMvo
         cD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdwll2I+0UIi7XhGuE9ZdnnXdDMdxuduY/8e8BdrqG0=;
        b=OSvHqD50wigET06TYzG8lV6QSJSss3FzZAy0BtwrXkseZW0dBPpcTj9VgqUJGWx8Ij
         An5xWBr6r5TNJs7ddnHukTM02efn6Ma8cK2f/OsI/yMoGoDY77ZNp4UsKmJXUlJXWDBS
         znzVwKnRgUSuJNwhJRK4jsl2VzidJk/KEwudXSasBwbbXhNLqKJrDIOoooK5S8W5mdTQ
         daWm92mrnnm145HsW2VFffoxdgix7I/QyI3+L8kqTe70526v0iSbtVxmfhBwOLt1VVta
         mL2pOfkauTLTRb5Wy/2+FZYGSe0keCD8tEqi0mwiW1fMPl8I3bnrHK3uoI9Lbjmo787P
         5EXA==
X-Gm-Message-State: APjAAAVbKLqGaHD2xTCkDVRwQOtiEVdsqS6W1zoh/m08WJTx0U2q71Jj
        FfrcdB3PYxUF9xVj2z25QGQ=
X-Google-Smtp-Source: APXvYqyzrEP3eOlPkO2+R7iNd00URCRT1RLgY23Okr2hcs4KDOBHef8XQdAAXw/pMjkkAafdhVyj5Q==
X-Received: by 2002:a2e:90f:: with SMTP id 15mr8787275ljj.120.1581551203538;
        Wed, 12 Feb 2020 15:46:43 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:43 -0800 (PST)
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
Subject: [PATCH v7 12/12] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Thu, 13 Feb 2020 02:46:07 +0300
Message-Id: <20200212234607.11521-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
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
@@ -2124,4 +2126,26 @@ sound {
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
2.24.0

