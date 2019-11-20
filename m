Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B53103FC7
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfKTPph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:45:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37176 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbfKTPpf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:45:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so13998420plb.4
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4TmU0ibaD1fY5ibWJwV7zia/u/t/2yh9Lbt7NaMlJsw=;
        b=YEVFThbykDuFOr1GtEq6abY7duRfnHI4jaVcRFw7vzdDc2xf1gpAT3jNxbtyZtbPwZ
         aMtfdH26aYykzeg2IB4I2NafAVv3xFEIIRY7Zs43XTowRnDpQSNLtmf4Tsf8g1Iw7pGI
         nn/6oVBn+K0nhhX+xEIphl9eUlPv2NW8mhDmyVifedjB5F0z66LVt4bkzAJ76dgsG4S+
         8usbneTJfpUq5fAAj6kzBspsVXaqGx4KLxWjyL8whLq67PrEwVva1wYW27YodK3cU873
         2DXeWS/CagJITBLU8OB31P6nW7HponRuy+30OI4pi8a9Qv5CXnMP2XpGebOTKW/42S32
         /C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4TmU0ibaD1fY5ibWJwV7zia/u/t/2yh9Lbt7NaMlJsw=;
        b=m7xRjkXrxOAH1NR4m7xHEt4UD2A0AY/M4cKHE5HJkthJKYlbrD1S+1eAk0oNyGPMPG
         9apeNyexlcTYPyWSd8tL9ZWs3/9A1XKGgn/Ok9o8Z/nmnVccgMf3ukXbiIKUJiro5IfA
         dFHrUjUfkq9t8/uEGTHA9WlQOvzcM4Jo+LDbTPSnquzudVtDAx1SFj+RS+cs/bHarm69
         hgniLR36JNWXCFx4mua+T0p5mUtbLTN2y9zRFPktm+lXegt2vt9uWmeEOrcxG4bzwHgJ
         WOvO9Wozn/wFqrLA/jvcxdSt3UkHXDYLKA2wGJKolbdflKBoH2RUA4+g1/yMEMJ01ZFr
         sb+Q==
X-Gm-Message-State: APjAAAWhomcvuSXTiBfx9v+cHyKwcsuP6CmW8Vc0VR1YK9dbJvy5tNGP
        4HtkqVtYNVeTZbDeX36ePynd5g==
X-Google-Smtp-Source: APXvYqwqWn98sIzUoybOJYVYcRSWVhMeKAFe8/0u1dMDQwQ20DewYj1vMTc1Og9g9ggVyBX4J+5vcQ==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr3665919plq.27.1574264734625;
        Wed, 20 Nov 2019 07:45:34 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id b1sm7658518pjw.19.2019.11.20.07.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:34 -0800 (PST)
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
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 02/11] thermal: cpu_cooling: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:11 +0530
Message-Id: <ddb09e9728533c274edae7ff3da515b3cf7ef231.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Describe the function parameter to fix the following warning with make
W=1:

linux.git/drivers/thermal/cpu_cooling.c:92: warning: Function parameter
or member 'qos_req' not described in 'cpufreq_cooling_device'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 52569b27b426..53dd08f238d5 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -63,6 +63,7 @@ struct time_in_idle {
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
+ * @qos_req: PM QoS contraint to apply
  *
  * This structure is required for keeping information of each registered
  * cpufreq_cooling_device.
-- 
2.20.1

