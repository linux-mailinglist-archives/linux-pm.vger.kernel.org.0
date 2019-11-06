Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC740F1716
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfKFN3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:29:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37177 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbfKFN3U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:29:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id p13so11431516pll.4
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ndl0P+VsTZD2v+P2v9bn/U9V2szmDcFpE9QaZn60GcY=;
        b=Jk++708LXyo/7ByqvgwlIhPiri1IenbjKc2cSae50LsdvVJ10VmxSRemddzrpMGYof
         ybKFnP4OZTKR+IWnxPv3rZ9SPmHwVgfII4zpEmSWVuBQrRmabm5c3d8DPoBhycjaN1E8
         wi1E4HvuUCTJKw0uZbJVmAD24BB6z6q6XQSkrwm6bh4+2zlfDBTWijbLLo+BwJ9Vgnlp
         lHWz+p3h9owUvqYFwwuS4MD/Emodoj4SNJ6y436+Vqyu2XrS8bkMQxSUvLOMM/jsVOIs
         KGo41pjh56vWYLWunJ2sIYBrwuf6HTjyenTCgPLhrmloOJzaCwR87IgyzvWh/5QJM4fm
         VeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ndl0P+VsTZD2v+P2v9bn/U9V2szmDcFpE9QaZn60GcY=;
        b=cczSzPvvWfq4GGxHu3b4wks2B/R/WAw1Y/1tpSlxvQ2FSE+MiDkSGFYX4eQ/FSzKax
         0wJxqbjaxd/+YKMW0EhoSwNpKMEhj3HUUuIwpWFfh+L1iJ3oIC/rfKXUNzdkjJj/+rzz
         RfNqZrJoQFVLz4RoJMV35L8/82jnIVulBiyGzDtkztVhoqgkvAtDc+ym10cbttZIreCN
         ayDtz7b6wA/djyEt5TLNke+F/0aPW3MdXQBUjEPM1pkKQWio5HZ//DCECYDdbs6dnm3v
         2ILySouRNksFgbLEC8G9HNDS/ZgOooBqg6u0dd/imxuF5Cw7Gs6Ldnm5VGRiB3HqnFxz
         TPQA==
X-Gm-Message-State: APjAAAXllfAeoiemgOZYKD4Ta04XYH8wJHXozVvmag/AM7Ws70YR6r1z
        aF8QrkmynFDbAp9WLMVup0DOVg==
X-Google-Smtp-Source: APXvYqzXrRMY/E/IAnXs8Uf12RYzyqlGrByEWUa6Sj8R2R4qoSFZoC7S4GJxnvAfOPq5HOOXQ9Tv9Q==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr688438plr.227.1573046959859;
        Wed, 06 Nov 2019 05:29:19 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id x20sm23088825pfa.186.2019.11.06.05.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:29:19 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 11/11] thermal: zx2967: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:27 +0530
Message-Id: <b8cca2b414eeb2db19f297571dd4654a733a2417.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/zx2967_thermal.c:57: warning: Function
parameter or member 'dev' not described in 'zx2967_thermal_priv'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/zx2967_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 7c8a82c8e1e92..8e3a2d3c2f9a3 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -45,6 +45,7 @@
  * @clk_topcrm: topcrm clk structure
  * @clk_apb: apb clk structure
  * @regs: pointer to base address of the thermal sensor
+ * @dev: struct device pointer
  */
 
 struct zx2967_thermal_priv {
-- 
2.17.1

