Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D67298496
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419347AbgJYWVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419251AbgJYWSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E4C0613D0;
        Sun, 25 Oct 2020 15:18:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x16so7737748ljh.2;
        Sun, 25 Oct 2020 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94ko1KEkvd/nrOtCbnF94w0cywfdZ0jax9HR6cDdRe0=;
        b=Qm1yEfa2PRYppyIYsSGsQ5TtAvsTjs/w1RG8K6rIejNzxR30xYJQIaNybveQYKGldC
         1RolfvORMYcSXn/MU5GwkomdntMip26KkF0gBqd9zExi0ApfuFwbCtO6kuWZPZrFcol5
         UfpyvLJ4AM8BcGoQ/cGi/MD5NZfRfPdeplexgkmtBWbCgxKy1ePnxluoDSsyC1nzOW/S
         1WcsWUjnRl9ofY6o5C3iHiVM6WDf1lclsKyUVZO2Y/8VasHw1spGbsInm5kqcpS8My+s
         a20XQAV11bXpp2oHV7nQYzQ/0veTQasRJWXCT755xiW8F/fznAamBv/4sv1fPUNPdaUf
         Oo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94ko1KEkvd/nrOtCbnF94w0cywfdZ0jax9HR6cDdRe0=;
        b=MVT6X3urNn/3HGAxdk5goXEwfQK9TEc/brUQAHfEJsBAkx2QZa+8s5K+RpbT0ffXla
         gYPkw41DHRDVm64FA8GyHfUTVdKOK0Y58xuu63gxkYOHjfuG+cCJodNjjCSm00Oysr55
         /4Ge/ZCs184NRrVpmbr+6uMlPieitxtg0/AF2QrOhCIs4q/eZJ3JXE1zyzMPJtve6v3v
         MV92QeuF/PYnkZEMjsiEEPA3Qld9kX1Pa0lt5ZQeakc7rpZ9G5GnrcKPP73jm4CI6kfW
         7IUpdzykxe1EitzuUAFre6jrgNyIUSWpm4p9E9aXMNHPSBiN1UFXmBHsBc+/iUgk+sTI
         Db3A==
X-Gm-Message-State: AOAM531BQ7AksbYOk8aCCN/e2HYAQQDhhpzXHvGVQFHYOGBUrDH5FPeF
        VOaAskniouCxYSjTm0K/9L4=
X-Google-Smtp-Source: ABdhPJxJP5vQ+dbu//2kEod4jKNlPCrGWMiwzB9P67Gj2wl/LtiawKQIxeELq3dtTUVaMOR+rGAZpw==
X-Received: by 2002:a2e:7803:: with SMTP id t3mr4225150ljc.156.1603664285788;
        Sun, 25 Oct 2020 15:18:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 15/52] dt-bindings: tegra30-actmon: Document OPP and interconnect properties
Date:   Mon, 26 Oct 2020 01:16:58 +0300
Message-Id: <20201025221735.3062-16-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document EMC DFS OPP table and interconnect paths that will be used
for scaling of system's memory bandwidth based on memory utilization
statistics. Previously ACTMON was supposed to drive EMC clock rate
directly, but now it should do it using interconnect framework in order
to support shared voltage scaling in addition to the frequency scaling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../arm/tegra/nvidia,tegra30-actmon.txt       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
index ea670a5d7ee3..412e939c65cb 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
@@ -18,8 +18,30 @@ clock-names. See ../../clock/clock-bindings.txt for details.
 ../../reset/reset.txt for details.
 - reset-names: Must include the following entries:
   - actmon
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- interconnects: Should contain entries for memory clients sitting on
+                 MC->EMC memory interconnect path.
+- interconnect-names: Should include name of the interconnect path for each
+                      interconnect entry. Consult TRM documentation for
+                      information about available memory clients, see MEMORY
+                      CONTROLLER section.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: bitfield indicating SoC speedo ID mask
+- opp-peak-kBps: peak bandwidth of the memory channel
 
 Example:
+	dfs_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		opp@12750000 {
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <51000>;
+		};
+		...
+	};
+
 	actmon@6000c800 {
 		compatible = "nvidia,tegra124-actmon";
 		reg = <0x0 0x6000c800 0x0 0x400>;
@@ -29,4 +51,7 @@ Example:
 		clock-names = "actmon", "emc";
 		resets = <&tegra_car 119>;
 		reset-names = "actmon";
+		operating-points-v2 = <&dfs_opp_table>;
+		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
+		interconnect-names = "cpu";
 	};
-- 
2.27.0

