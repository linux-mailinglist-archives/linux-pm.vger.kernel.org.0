Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52AE29848C
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418666AbgJYWVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419276AbgJYWSN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D038BC0613CE;
        Sun, 25 Oct 2020 15:18:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r127so9382791lff.12;
        Sun, 25 Oct 2020 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7uQYoSS+SwZKNve+DXt46n4S6SnUzemcLRL4Q3Aw4E=;
        b=DrSjShpsbPLiLJ37g+NjmBEJ3tWraX5OIaKpgKOFilWX9Lb6NUUaA9fG0b7RVZk6yI
         uYouwvAPszX8WSjT5cUP85vTPpvt+3bteYldfh4BNxypDCaCzaV24weL50SmMmcHc5ll
         8q78+eoo3CqEPEBJmsOMDbn7xcBcAyklsiy78vFFPMFLbHK5sViEHHQBbM85humEFxiD
         26tNvjMz/nIftPTi1dCsyLvidIZqugbJQWNwqPRCX5zLIDKGSDzfFpP0k5WVE+XZuMJW
         48U9wKJo/PfwA3dqkvJ4F60tajNJq1MaW9FpbBGyON6S19HBR90llLTBpeOWx0ACG25e
         xyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7uQYoSS+SwZKNve+DXt46n4S6SnUzemcLRL4Q3Aw4E=;
        b=SD6S7AQT1GcVlKRIyLD+WJrRPt5U9yrEjL7WzcxdW+Kje+CmLt4gyd86ib7WQqO9vh
         rW9h88QAP8lMX5uV2wvFqUOkzJxXf8GqHz43ClafQiSsSNGr14Je0NNLxps3C22mqdlQ
         rI76WEE2fIZ5dk3zbt2tFwDIevsW89JffGM+oSfSczOA6rSebJoxRgOSWo0QKmrj1bQ3
         yeQPgcPDPuAm9J2oxobJlBxUQ1EBzoEdw6jYnGsBD7lAqlAfEbRhZnrqnDAu1ODnCu+v
         8F2zkVYYSIEP+Xc3nRIcNHdSlHg3WPyl7zRFN6jEFuHjpu39hhVjTovUwtHWEFzJOO3j
         3K/Q==
X-Gm-Message-State: AOAM5332OEOyYBIdmB+OXmU9F68YFsgvoG98HJTySfdBU3RHTIPddB9V
        nMc9xBQ2ApiD/bFYAutgQHs=
X-Google-Smtp-Source: ABdhPJzJiCOjCLOQMQ9QluohaM2tJl9iJQnNOzR0iV7bi+VEwXEa8Esfh8YFYtw5t8p2Oeb3wHxmXw==
X-Received: by 2002:a19:8ac1:: with SMTP id m184mr3703988lfd.199.1603664291379;
        Sun, 25 Oct 2020 15:18:11 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:10 -0700 (PDT)
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
Subject: [PATCH v6 20/52] ARM: tegra: Correct EMC registers size in Tegra20 device-tree
Date:   Mon, 26 Oct 2020 01:17:03 +0300
Message-Id: <20201025221735.3062-21-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra20 EMC registers size should be twice bigger. This patch fixes
the size.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 72a4211a618f..9347f7789245 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -634,7 +634,7 @@ mc: memory-controller@7000f000 {
 
 	memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
-		reg = <0x7000f400 0x200>;
+		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
-- 
2.27.0

