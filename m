Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610D6EA570
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfJ3Vfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40933 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfJ3Vfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id u22so4332784lji.7;
        Wed, 30 Oct 2019 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=V/m0+yvu+XQPediAtxkB/QWeX/tegpDYhM3Inv8dWd0Kf/bfbLJiBakX570cQEw9tZ
         oaJbL5uNhMw5goVZuu6vAi0RX1M0WRbeo4wOcuXMuqg6iT9cG6LGi7ntzurpzxv/YIIn
         U6KcVwQWdW0HCQnW+x/0gmuLSnmo1YPmPC2fb0+hq6FRW6Pwp85P2ajApM63oMKYPYTQ
         gUei/RwNzU/y0q98OlzjNAkstbCi5crlEROlzPzjZST1MiPcSzE7s3PCIUrLfb0VxOUL
         9/+2w9LLpkQi7ep9AE9alBRNF5KEC4bckJk/VT2V7n+ygyRFhBIukcY4Js6GhRhiElFu
         x9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEJ200kbZVTsss1iDk6Wt5qRmYYgbTDuf+N828TJE+4=;
        b=czq1Dov/Ju9LQc6NZLL7K7f9jIf11RL9PDhf4vyqtrkUhjmjEu5hDs3ZC1Ier4jDuP
         +qxn9v6SpmIlGouUqHZkvl0iQO0b8atn85NLSD75/GrZ+rizav8If4TsEcaQ6DA+J30J
         xXAsp+uW4Boir/Qb6gkKOvIc8rDPNKmBp5a23Jj8OETYgRu7jCgbZ0PUMP3SWpnbV89j
         WHziGsfAoQO9dqFQBh3eD7kbiqYbuaQ8yQ/SZguu1N0YYqsxtywO8faqAcXQn3A1k6/E
         hcAs0Fr3WMMkn26wjbjitiSn6C0duqvm0n2+CkU4ws5lA9ykErqZ/z2an9zMbflOqWAI
         1hRw==
X-Gm-Message-State: APjAAAWWCbYW9Se5rTpO/NUNRlSi4zZUoxRtKwQeBZroTvE6az1mBeJG
        d15CaqHqT3fEfcNnEc2C0ik=
X-Google-Smtp-Source: APXvYqxqas7JJTy3po8gqA9lxcVBaMsPmryEn6NF2QLtfhQNuAfHsBPhKGocMJM10XASN29tgYQlow==
X-Received: by 2002:a2e:9888:: with SMTP id b8mr1125681ljj.167.1572471335206;
        Wed, 30 Oct 2019 14:35:35 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:34 -0700 (PDT)
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
Subject: [PATCH v3 10/10] ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
Date:   Thu, 31 Oct 2019 00:34:00 +0300
Message-Id: <20191030213400.29434-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
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

