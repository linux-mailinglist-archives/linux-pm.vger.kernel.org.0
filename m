Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CB2A6ADE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgKDQxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbgKDQtz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:55 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBAC0613D3;
        Wed,  4 Nov 2020 08:49:55 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m8so17654200ljj.0;
        Wed, 04 Nov 2020 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqzEltuN5moc9KsPy66tWe+lPEJWveWVX7/N9Iczqdg=;
        b=o4UnBK9ibQLU6a5PeuY3NJhfuI78mBN5N5b3ypqcs9Iq8a69jE87KBp/h5euFrzrMO
         8TTvjki2JeoiExtYHNfLOjrOm1PFy9hEdPGL7sigDc0KRXaG6wwWy3Vpc0m15WWY7dnR
         H5psVV7PaxohhErmm/PRDRxLixxoobSj515fy+X7zhQ6OT7UZ3dR3BWOtg88EiA4CZ4i
         pENxKZNq5rIL5mZ5rBUoEEpWJFovi04W2bd6nzt14hTAjKkH881oey9Nkhgrhnz6SYWc
         N3BqWVM8SyTodXb5pIFXyPRHSx72OJhpfc8UEaS1gBj8vAlW+E3skWiuk75+MdI+vMJ8
         Yfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqzEltuN5moc9KsPy66tWe+lPEJWveWVX7/N9Iczqdg=;
        b=iBbOGUpeH6JFu7eJ4ot+JMro1Bn9k+RbB+/vb5XC8Y+zXs1IAFLQ2YlyST5CpOdhAB
         TdoITgPyTpoXfzryBevCpfeywxm1wRAXWwZgMqKjl8GNoD35fxsLq6XMC6eJrg1AwiKb
         8ub8L1hohEnbzTyxkxkz2+h4HyyorXDJwCMuBfqsJgNv8UPCTObIQ+raneW4C5//hWKO
         xdzoFagpqxwF4bCv3OylkpuEDd0ZbVObZDFPfconplT0HDqxykFA+RVqkS8WRlpy3vK2
         ho5cYHXs9Axvfsjv5pVHS6s4CCTaFYeWmUib676N8mTgFkzE7/A+xHy7q0+lp79Y7ubx
         keOg==
X-Gm-Message-State: AOAM531mYF68gxvqfpqSJmLh66kuxugvE7hYafGPuly0c/Sd2XiYHhk1
        Mryl/0NJBZzc2jVtRBqKddI=
X-Google-Smtp-Source: ABdhPJyeX5Yfln+dusfWz3xKWppTsZIg6ArEcqN8glIFOwU51Lb09IzPCh9OsQa4/GpcEkLlbHZ3RA==
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr10424595ljo.34.1604508594027;
        Wed, 04 Nov 2020 08:49:54 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:53 -0800 (PST)
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
Subject: [PATCH v7 20/47] ARM: tegra: Correct EMC registers size in Tegra20 device-tree
Date:   Wed,  4 Nov 2020 19:48:56 +0300
Message-Id: <20201104164923.21238-21-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
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
2.27.0

