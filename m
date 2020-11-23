Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1842BFD8C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKWAbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgKWAb3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:29 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56FCC061A4B;
        Sun, 22 Nov 2020 16:31:28 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so21452264lfh.2;
        Sun, 22 Nov 2020 16:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4xxkreIJbgC8EFiVFdpV6nY5vDKa+iyrBL3x6vFvF8=;
        b=j5wtTWEksHtugVjQDOV918l/wpNPSChF6purMHsBn8LAeCu6ZVIAv+SaMnPF83CBOq
         neARTqolFKtUVM/vZrAFOZGX2MGc+6qL9/vaEuauG5I4ZkNQIi1TUkecubOeJYJmRr8x
         Dugrxd2zjESzX2HVknnUsPrPdGj2MjSqnEXB0QhBzyNnQtfGyFT/8vAx2H6Ppy/wjUPJ
         wzSHgl9LSGl8qRb0DHy3la817qASIj3Dp6M0IhxgzjdjY1q4dCypbDZg+2bPKWtAVmfg
         YtU0a5vZ2nSmUdF7H1gyIy+O/4ckxL/aftH8UqIBM3NXQHqXzAULgzpEBpkmj/IZVxVS
         kNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4xxkreIJbgC8EFiVFdpV6nY5vDKa+iyrBL3x6vFvF8=;
        b=i2e53J1JL1w9hXb7+SfJ61tTp0gZ/xNzDwpVSXhf8PWBFiTJJxTvLZL+lMuOpUFdsr
         5xZEX/E6ezGG6y/eCtHZmwZz9lID66aK1z2XtJJCdyw8XW0FRNrHiZMQgvb2iBbDZWU0
         b+VCxiWrknVPuhcQw646g/TcX4dGPOOTAyYdaPK6Y/sN8tvfSYIZwvtw/U/AK2F2/9XN
         h2OP1N6tfZwiTNX+L/pjdsV10V+AQEmS3rEWBm85wcKR8wzTlLQQ6Ke2BA3lmoDh76iG
         qZuRQvY+jm4IC1UlaqEBsAvB36GqKLRMoqQG+jGlPxF5PU5f7h5MN5ju99JEObgeIWMe
         fLIg==
X-Gm-Message-State: AOAM532vawZTNnhX9oWqq71nKocJsndsDqR6zESs+4anytNWwvhiXGI5
        W0yHxkLLfY1Jnjm2bqCfjak=
X-Google-Smtp-Source: ABdhPJyFo4qSHkHAs9XJqnPtJw51GVAKpIxJ00HuVbUW+dPFnqlzeHjCgSXu56dW7MZHwFGjow3kbg==
X-Received: by 2002:ac2:4d89:: with SMTP id g9mr11864282lfe.341.1606091487351;
        Sun, 22 Nov 2020 16:31:27 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:26 -0800 (PST)
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
Subject: [PATCH v10 12/19] ARM: tegra: Correct EMC registers size in Tegra20 device-tree
Date:   Mon, 23 Nov 2020 03:27:16 +0300
Message-Id: <20201123002723.28463-13-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
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

