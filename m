Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC527A198
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgI0PKI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PKI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 11:10:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3165C0613CE;
        Sun, 27 Sep 2020 08:10:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so3873677wmi.3;
        Sun, 27 Sep 2020 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1v7I4XPINcsYoLjVYjg/trmmo2v0jQccnOxIjDhNkY=;
        b=inaom1v/j0In/+L2dXCWCvrkS8KCLXpWQyFFaYYQYHOLS2yiX/XRVJCLTw4ltDLiGN
         UGklcA0NGK3NVaDZdZXfbVfI+TkIBl/1OK8xAWcZ/8NHaSDukkEHT+PGpZKzEcWEgusk
         Ez3C9UCNuzaXLpOnFh0LnDMZ5HtsWKN+sxG9odAr5ClkBRLdSQ23oJeIlAYF00G8OVs2
         h5DZu9RqltJ84Ca7Eh4AIqAjJEEnve1+HY4ElfbUxOezyUDNwgjmnO67URmXemImhOWw
         5MYKZFV26EmPJG+HPUhgJsujY7Cf3uiVyDk9Y+UcvrCJJxVnMP8Js3x+OvbzH3knzG05
         hc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1v7I4XPINcsYoLjVYjg/trmmo2v0jQccnOxIjDhNkY=;
        b=nWphKWPxSJ3I2noRU9rUpbqxU5OsWQxKKKwbYDRZuoOxSn6dPDkZRVnle20BZCi2uh
         YUOXiL3a1E6/mQgymZ5qDlFLQcd5Lcs+q1JajYIuta2hJZ53/4yHfpJM0m0FN6p2QLDj
         68g3d04Ig2PyZDiOXA2gsd2D2g/B95W3mYW9FzAGxl/x12uTGete8zonELLAJb+J5z8Y
         pVICCU3z8b1w7Ei9CVCqDuBOtskmNLe0wox5V6YPGpZrr7xTVYMfVas+NwcXxfFgyub+
         dJcg09yuKZqYUctb5tY8IXm/JKM7e4VzpdyrgCSYWgGIiVg0/nFZuZrEslfs1pRgUbBs
         t6xA==
X-Gm-Message-State: AOAM532jlDSIaYrwZ1UP20R8VbOjaju9GW8fS9U4P9oak2NnDIuJN/WZ
        eaI+1TR80s4DBtJQa5q879o=
X-Google-Smtp-Source: ABdhPJzetvO/vp3JE6rgLvWSdmmfu+pDIrUmB1Q0Evdct9VETa0BtOWPqYF5BH124IyUprIuurphgg==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr7157834wmc.148.1601219406490;
        Sun, 27 Sep 2020 08:10:06 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-nic-1-212-171.w2-15.abo.wanadoo.fr. [2.15.59.171])
        by smtp.gmail.com with ESMTPSA id s11sm9565114wrt.43.2020.09.27.08.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 08:10:05 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v2 5/6] arm64: tegra: Add missing hot temperatures to tegra210 thermal-zones
Date:   Sun, 27 Sep 2020 17:09:55 +0200
Message-Id: <20200927150956.34609-6-kwizart@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
References: <20200927150956.34609-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to dmesg, thermal-zones for mem and cpu are missing hot
temperatures properties.

  throttrip: pll: missing hot temperature
...
  throttrip: mem: missing hot temperature
...

Adding them will clear the messages.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index c518292ee3f5..9e8ddec52651 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1639,6 +1639,12 @@ dram_throttle: mem-throttle-trip {
 					type = "active";
 				};
 
+				mem-hot-trip {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
 				mem-shutdown-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
@@ -1701,6 +1707,12 @@ pllx-shutdown-trip {
 					hysteresis = <0>;
 					type = "critical";
 				};
+
+				pllx-throttle-trip {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
-- 
2.25.4

