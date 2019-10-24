Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E18E3F16
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfJXWSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:18:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43774 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfJXWRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so341316ljj.10;
        Thu, 24 Oct 2019 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUBAwOdtpZgi+MnUyIrnTd1TaWn9LHYTmkJ6UDbhmPk=;
        b=qlOKIAg+9h7JMf79ead3mG8od+HE2B6lqwkWN7QObknkN064QM/2eQmEv9MnfY2Ymm
         mtudoSl+3D5ZEHjaJ9nXY+7BvghQmaJsdxKAMBqCt+EEaOCkvSwIhJO8JTE2dLjkdLk7
         j/F6c2h66BeocJPghWgjt1W3dJ2xoyqMFPIgQDprkJKlTzAwFQg6GD1qxQmMl/tbi2/w
         mfkVcn+B5nEbZjdoFGzAY/NKPJtBq3CdxNdBqVNdB24i3QgkwO4LIYPSjzN4ZBRLhDpk
         Oe7l+njPvIXuFln6guAIgkqyTtCwikOmaDm4bC0VVLVVBRtUpg4Nl9v8WGX+XHZWcqTw
         UrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUBAwOdtpZgi+MnUyIrnTd1TaWn9LHYTmkJ6UDbhmPk=;
        b=rX38LuS7c1OgSpM7QoIp8MBasK08nnz0vUeoN5rML/VUOk2Qopwir4VTiB67s9nXw/
         vD8fZMFSkU1EvPofWxGXIEBqBHT5tsSsWa1h68m+PRr0Yih+oKCrxqfzWIItTClX2Guu
         v+tp5QTZkvAuZpBdiv4V3K/JaF3iVEF/MQVGHqCokQ7E4oVP17Dpnnnvo+dRGTDglAmm
         6/M9c78heuUi12Tas/howPbPo9pg0XihZp9gSZawzMHpyG1xGg++dyf2WdWOpD/PWvIw
         me4Zn8n0EnpRepdEiLBxs5UnGXdgA2VtmXUh642IPifQIwgXLW2XRUFnUr+VGEdQRsWw
         6RHA==
X-Gm-Message-State: APjAAAVzHtuDrJ0gvalgT6IVxgizbr7M4XzlagIlTmeHmH42f4DPnnDy
        aip3/QIVl+gtSyn7ikRhO1c=
X-Google-Smtp-Source: APXvYqyrwE6ZAMfgXVEVc2ajX9jgPWfEmziDOgkcV5Ev3xyizavemgAE/87OAHCZeoKXH5Nw//Txkw==
X-Received: by 2002:a2e:7312:: with SMTP id o18mr43108ljc.216.1571955472202;
        Thu, 24 Oct 2019 15:17:52 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] ARM: dts: tegra20: paz00: Add CPU Operating Performance Points
Date:   Fri, 25 Oct 2019 01:14:13 +0300
Message-Id: <20191024221416.14197-15-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize common Tegra20 CPU OPP table. CPU DVFS is available now on AC100.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 6e9fe192c648..85fce5bc72d6 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -3,6 +3,8 @@
 
 #include <dt-bindings/input/input.h>
 #include "tegra20.dtsi"
+#include "tegra20-cpu-opp.dtsi"
+#include "tegra20-cpu-opp-microvolt.dtsi"
 
 / {
 	model = "Toshiba AC100 / Dynabook AZ";
@@ -616,4 +618,16 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&cpu_vdd_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@1 {
+			cpu-supply = <&cpu_vdd_reg>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
 };
-- 
2.23.0

