Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8682E2AE597
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbgKKBPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgKKBPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:43 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F16C0613D1;
        Tue, 10 Nov 2020 17:15:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so718731wrb.9;
        Tue, 10 Nov 2020 17:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4xxkreIJbgC8EFiVFdpV6nY5vDKa+iyrBL3x6vFvF8=;
        b=g6gOJh1jjwealV3mKR/Dun5EQuRfa9WTYNQboVg1HmRA95s8fLDxATpNPx24sO7yka
         VNvQOplH4O9C1z2tSR+y1xu6V030ys92UvcK61Q2Vc3N/m9TPKxO8LaP9rhr3+u6tkB6
         fl2VQdV5vTPjBwcLIBqmMYGHMAzUWuQ14kVlS7bTc6ZF48HOU5QGrDM446i6ga8Fb1N1
         +iZdZAXljIzSYmTYyXrqnDsv/FLKLI5hf4tTnPILoUKuNTfu+7iMVXGA3gq0aJ/CyDVP
         Mq+dlGPasi2/eiHm/Xq1byDEoK5ubpxeWsEoeg9GIwsrss9nd/y+jkrhoiqupmeOMGf6
         ATnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4xxkreIJbgC8EFiVFdpV6nY5vDKa+iyrBL3x6vFvF8=;
        b=f0th4rBlQjvBl+5o/xLLdYDfStEV2sJSPrkDyNQrWIy5r359YWgtDA24mbB03On4zu
         xvcFPSuD9VLKRD6SOXnboNJNlcUV26b8s3zwRkd6bUvvaHhGM9rjiq2MaV+8QyvsCFw8
         IfKyBxAIt7eUiZqhgQHnBWzBuqOx4WNIDM2oOADJVsNdgBRjzmJGdVdwty5WSwwr82Wf
         s1qanyrmH7mSeU6BY5xjn+sJxhHS5YjV8cRMiy8sEkaQD5LyHUCHk+n8nksDOK9agiap
         z11GmeYDtnWqLPq9Engz6itqalRmuM4bXFH6v5aaKI3RwZgG9YYAWMdbKjyW+eydyLfh
         MQxg==
X-Gm-Message-State: AOAM530QWTUixoN80WnGH3fnf/VJV6Iu/BHjht5byZKEShWRZmF1SgSS
        BMKb7motnV9NKZSN0UjDKac=
X-Google-Smtp-Source: ABdhPJyIORm7fmfi7Ia+QnzhJraA0tEtiN8zTgAl81vfBixVs8x/NMoUEkntPyu2M9dyBYnduNiQ4g==
X-Received: by 2002:adf:f245:: with SMTP id b5mr27020581wrp.389.1605057341880;
        Tue, 10 Nov 2020 17:15:41 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:41 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 19/26] ARM: tegra: Correct EMC registers size in Tegra20 device-tree
Date:   Wed, 11 Nov 2020 04:14:49 +0300
Message-Id: <20201111011456.7875-20-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the size of Tegra20 EMC registers, which should be twice bigger.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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
2.29.2

