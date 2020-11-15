Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07612B39A7
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgKOVdv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgKOVd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:29 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBDBC0613D1;
        Sun, 15 Nov 2020 13:33:28 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so17795781ljo.11;
        Sun, 15 Nov 2020 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4xxkreIJbgC8EFiVFdpV6nY5vDKa+iyrBL3x6vFvF8=;
        b=YlwiH2JRr5bSFW9JIO9QC6RKVFPTv6JbO869PCUOaBUfr16W5w/2JdAXZ9YViqKl8P
         638BJI9/6Pb5VHfiFgZkbEbGBt5e1NNfF28VsAReYz1l6DASxEeJSSxu1u1+jXV1Hsqa
         vaZEFahiG+5Sxm0EukE47xHPHb8C0S0lI7zw9yXHuJ4BwWBbmY8ShngrxU+PT+zwPANJ
         hSq16e9XcbLNO2/QvJ/CqOVPXhBqMPOuQqPQiJNIctWqu2Ox5JY/aBrZ2sccHv1o27oL
         ijkQSnznpFX5pHgVbQmkYOsC52E4M/1+SBQpRafUQr/F4k0RH27CinqIGV/K+GPtyu5A
         yh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4xxkreIJbgC8EFiVFdpV6nY5vDKa+iyrBL3x6vFvF8=;
        b=i+hJIYMUA/e57oG4EZooqsB0D6CpIya1919AYnDekXEgVrL7IXLWolzQ8WXweHaYSQ
         rW5MFBvdRU8jzkdcuwIdJ66tfxa7Pd/DC85tVj0KiSU4mVGxUUrzCTHh15UrnGhme9eH
         IZnmeVE03j7pKaXcG0BAK02nnk9wa5+5FYwWc6SvaiKusBod/eVeNlriXEFtsbktpVnn
         qk3u7nmBnTiRvnLYCJjH/cZgayW1slL3w4j5/KGyqPZECb9jaXaX0tYO94rWGlRtu7IB
         kpNloEU2yrD81qtzrD2mIEz3g7++V1I6ffzbgZY8vH2TYrMhvACXOx8yW24HnhfhImIr
         wBaw==
X-Gm-Message-State: AOAM533I/eecTwu4CaSANdbLuH2wFCQJgxE7UmFhfI1DclAEfcN79UJ+
        arb9anGAhoMmI1c3Em48g7U=
X-Google-Smtp-Source: ABdhPJwT1yXAc8mfECjj/fFM0wDUTIIL+HT+QyBtPbqYsgwqFnnTJaDqcl0g8suvWTJZKWM5Reublg==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr4653278ljj.373.1605476007267;
        Sun, 15 Nov 2020 13:33:27 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:26 -0800 (PST)
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
Subject: [PATCH v9 10/17] ARM: tegra: Correct EMC registers size in Tegra20 device-tree
Date:   Mon, 16 Nov 2020 00:29:15 +0300
Message-Id: <20201115212922.4390-11-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
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

