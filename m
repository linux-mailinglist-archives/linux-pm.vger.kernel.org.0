Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E799B10099A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKRQq7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36322 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfKRQq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so7764193lff.3;
        Mon, 18 Nov 2019 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=IGenxVBBU8LnP/bn6cALCeeOJCueMq4zduqrvldKlmvivlcwCa8smtTaZmyVVzNMRe
         ZgKhnTsISUj2T7LXIWJAlzDzIMz2s51/aqbzIrI724WhJLZZX9a3c3m/Ah2oNXD5523H
         ZWTVNzDDBG0Mkt344R5so24cirr9CBcKBht6I54YA2nbTEW2Qvf+4XdU0zY66okkIQYQ
         vqMMXJyjpFKQh2VqRpmtQ6+m5NTG2jEo8Wvpo1mf4d1HamChVku9OBDqtytrVbRo7cbw
         PFXT5pOdMlPjsQyZMbdnt+h0GLbXu80USktjq+BOQEe+WVQ5X8FSWM2R2CC3FNPE0+wY
         qUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wI6f4nvMYsmBCMp+G12GdGK/taTCqKZ+wxQzPpgr3A=;
        b=U4e3zR9UyjFsdC2YPi5DOIyz4ngn5m80IbpCb64dhPG2liD2/W6yOTjJFeLWmztNEh
         q0m8kj/QTbLSwZgRPA20kkEMP8CCizSP3zDFYK43HNOnQVqvY9OSJ5Ii1E32CZXTwA2q
         5ELToFYWkb6kj0CsCrAfLkzzzKBW7pcL5Ua4IZXE3KYbFrSt78eMpF0nLcD2vUhepNHA
         b5S4odcFJV8jLjPj/KePpqUSno7Grr124ZZxClP0i4VaJJOYp0k+wzZIRmu5roWg9mOu
         1Dw4w6Ib7XPqcKwiTn5iHkAAJu0zaCsX4XG/B1mtZaSZv7idREIwEpPorLgpDH+z5ZWR
         C5DQ==
X-Gm-Message-State: APjAAAUd9SoM2RfiBKAAymaDFNK6Q97HhwXHXU99wDpGY4+8rKIGfqtK
        b/ORQ0Wkj8G7M2HFiMSZNAA=
X-Google-Smtp-Source: APXvYqxIxc0KerZe9XzlTaSytbGDBdMdiNmvzPW92uEueNFjjRSMlpqIrfzdQofXyHu3hiVn+IuQ/A==
X-Received: by 2002:a19:905:: with SMTP id 5mr235451lfj.123.1574095616462;
        Mon, 18 Nov 2019 08:46:56 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:56 -0800 (PST)
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
Subject: [PATCH v5 10/11] ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
Date:   Mon, 18 Nov 2019 19:45:11 +0300
Message-Id: <20191118164512.8676-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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

