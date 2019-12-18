Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9E125335
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLRUWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45524 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfLRUWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so2609903lfa.12;
        Wed, 18 Dec 2019 12:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdwll2I+0UIi7XhGuE9ZdnnXdDMdxuduY/8e8BdrqG0=;
        b=kHuQP2LHWukkPzJ/45IDQvB3gd/sszhYVcerwVPf3XxtIBkBOqYZmnnwdCHiWHbDpO
         vTfO3xLur/SZGCXjpWNpMdfPEkSNCrIL9/U7aE3EDL0QBie+ykrheURkxRb7p0h8tqJf
         oRpIYnOz5mavbBiEMlJdl5LFJcZT0XtbNqVU9JTXXSeJvGfF/jpVZOnwKhLW1xY1QUl2
         OPz7n0y8p7q7qRr9QI/JVZC8wI/Ijdw9NCJwEWVs+u2N96FQB9AeC5SMeJ27YXO56NY3
         /7oK0BaoQ/+XNIgCtKrskoXztqhPi5ah7014bySKHm2jJSJ988zwLgwL/ATpFpYjIed1
         sSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdwll2I+0UIi7XhGuE9ZdnnXdDMdxuduY/8e8BdrqG0=;
        b=T8sj8C2DgV7PHx9z1xknKh2mPvansmTwVkGI7mXWZRQe2KJua1xiC+BUB83BUwQhEe
         rRlh61OYahnpju6xhEP83oA5klhAoi/f8THVFGLf8mfGHX5f6GFfh2e86Q9kBjO1qXAI
         Yo/i+H2Fg20OT+tN8/+n4MVxRHY+94syJzcf05z1WF7Fh0LxZFFzq/uj0GJWu3aLgG98
         W5IVzK3AUXwKWeLEs/vtHHlex4gzcBlJopc2OITnHwDSfg9vFsNggkYolSpgwggKyijh
         AjZKod2UOPHfgo0YNuM7B+tUSHOqxZP+ZiZL4eyPdm/0eqJdDbAJg2JksdqA2p+918E4
         zKSw==
X-Gm-Message-State: APjAAAVd5p8irrQeIZK/O7NkYOjkoV0Lx6FSFV+uqGs4ITo+GE98H3Sw
        L0PgWZZApqzme7vIKcfu3eOvZTFj
X-Google-Smtp-Source: APXvYqwcL1Z0PzCBN6ROSM2Su43KblPjIZ8Qw8lJApa5QoC8wUXlEQTcoTTHRxEvfMz6QUIrVJIZzg==
X-Received: by 2002:ac2:599c:: with SMTP id w28mr3138290lfn.78.1576700530955;
        Wed, 18 Dec 2019 12:22:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:10 -0800 (PST)
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
Subject: [PATCH v6 12/12] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Wed, 18 Dec 2019 23:21:42 +0300
Message-Id: <20191218202142.11717-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
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

