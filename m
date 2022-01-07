Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B66487FB7
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jan 2022 00:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiAGXxw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jan 2022 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiAGXxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jan 2022 18:53:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61450C061747
        for <linux-pm@vger.kernel.org>; Fri,  7 Jan 2022 15:53:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v25so7030176pge.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jan 2022 15:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLiXD9EPxhuhl4swC8hQ6wdNP1ClmDuHZfS+mTSLPMY=;
        b=BYk2607hHPmSvHDebgSv5EvoUO2Eu+i/iAiOXw2Ta1ucl/Xw1m3CkSEWSoxLGk+krW
         8TtKDL2dq86sfn3/TjOaQjddauSgNqwTr6imn4sJv7/DFenryx+A4mrAadJMQkIItgqo
         NeS17kOoVGXrYbz/o9aQI9i05ftBJHeTTORPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLiXD9EPxhuhl4swC8hQ6wdNP1ClmDuHZfS+mTSLPMY=;
        b=SnU+XR5501IdLVjVZbOEux7tv1FlHWLzQqgVh8biR5pWKL35CSortKQBpXX3XWoRZC
         UbbX4zQzXFzShs/cOmiR0IGMBapVTeQ91v+vlrylTRllinXvvN9XVTNXjt1M3oymkPHQ
         3n9yR+OHCOXzsf30eron960MEkPIZMOiePInvfDi7YA8OzU1guDbdHiGN9F3aWWS3jSY
         L+FgzaPYcL4gSpp4spxP3DQFwduW06SrEfP6HSiVsr950b06uc8u9/fMn0pOI+7UJzlX
         MCusgx/UaLNv1qAV8nRGaZ1XnJWum3pMhp37YkXWPajcsRPBrSj4RUMesSBv6WWpoVNF
         BWSg==
X-Gm-Message-State: AOAM5337mydros7VyrLDgJMnn5GvG4RK6qrCXCiD2j/oBOf9uggTCfM3
        bF/jc16kCyqc/5wFQtseOp436Q==
X-Google-Smtp-Source: ABdhPJxec9Iz4K7SGQBxWwH4Aa43xT+erYjwZOOHGJsTnXVxoFwz2OkPS74l+sChFO3DcJQ2WklFNQ==
X-Received: by 2002:a05:6a00:26c5:b0:4bd:4ad6:9c71 with SMTP id p5-20020a056a0026c500b004bd4ad69c71mr482801pfw.45.1641599628943;
        Fri, 07 Jan 2022 15:53:48 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id y29sm56068pfa.54.2022.01.07.15.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:48 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 09/10] arm64: dts: rk3399: Add dfi and dmc nodes
Date:   Fri,  7 Jan 2022 15:53:19 -0800
Message-Id: <20220107155215.9.Ie97993621975c5463d7928a8646f3737c9f2921d@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

These are required to support DDR DVFS on RK3399 platforms.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This is based on a v5 posting from various authors:
https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
Much of that series was already merged, so I start over with the
numbering.

Change since Daniel's posting: reordered by unit address, per existing
style

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d3cdf6f42a30..86e2d87e008a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1295,6 +1295,25 @@ pwm3: pwm@ff420030 {
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
+	dmc: dmc {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		status = "disabled";
+	};
+
 	vpu: video-codec@ff650000 {
 		compatible = "rockchip,rk3399-vpu";
 		reg = <0x0 0xff650000 0x0 0x800>;
-- 
2.34.1.575.g55b058a8bb-goog

