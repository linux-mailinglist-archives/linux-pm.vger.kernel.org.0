Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346DC3798E6
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhEJVND (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhEJVNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:13:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273BC061574;
        Mon, 10 May 2021 14:11:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m11so9034338lfg.3;
        Mon, 10 May 2021 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thtwmlgqNARf4WCHwpmDn7oHaSs7U9z7qQuHG3u0utA=;
        b=M4y6Osg7i8DxbN1ZMfjEgIPfzTiBNVW95HPs8QIbvS+5pPrdy+0b7tHKEy6FM1m+Wp
         Rh1hYv3yjbDbGvqj0gAblil3f/iMlU6lqd1MzRQt9VvGeOiGtkv7lvU5IWijp/pET+d7
         UakshFo1NWuFurxWtxQAVsZCXaE5MCMyX0zU0h61gWxmjCiZVJm+wclrtP8DA3GqAFaD
         gJ4uVTqYMlYnMDdw108Yo8bbvYfWuunSgbThWaNg3ol9feXC5i6YIYw8760WfcDrivJK
         5RT4mos/8VHfdiU/4jlUdDSoulpBdqyX/jtEkdLVD9pUIwcLV0TyE6dQ4zTMFzsEB4tt
         O4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thtwmlgqNARf4WCHwpmDn7oHaSs7U9z7qQuHG3u0utA=;
        b=sDJ3XRmHBik1rxbHkf1NY3QxEdpY+wuPEi3k9RMx0dElSH6pUwv6ubwX3t3dWz3jgq
         M0CosAUQza7IP5vC5wlUO6SYZcXgf0ROYyohYBErb9xlhM76HzFNu8n8NpwIP+4WGevz
         w6P+IOcWnxjWtDDvVNACqc6nK3YPjR02v8LwOHfzU0Zb2chxkePZauP6hG4+dhc5ve5t
         WUm7zF8ZYy4gvzKltbs5+yc4uKCqcXcms12o2e538f86JwsUCNufUbzCLcPwrYg8cnZA
         IloGCLrxPDJq3Ze+wvqbl76ASyKVO7uowlN+2bPBsBNRoCNJmw8oJoJTgUJRAligvVZt
         J6dg==
X-Gm-Message-State: AOAM531U6T4QZ8fpvTMcNQFIg6NFx2xC/byDoMytd9RHbDMNOvqN0Ai1
        7mt5aavDrK0N40UvfBQ+xBhru81e0Fg=
X-Google-Smtp-Source: ABdhPJy2yYhjUwddgE90aXGaCgO3B8qDn2A/WihAOe1CxlXK4RwergQgTe8Hr9o11b26myxYzI11Xw==
X-Received: by 2002:a05:6512:3f02:: with SMTP id y2mr18452813lfa.355.1620681113344;
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 6/7] ARM: tegra: nexus7: Enable memory frequency thermal throttling using ACTMON
Date:   Tue, 11 May 2021 00:10:07 +0300
Message-Id: <20210510211008.30300-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACTMON module monitors activity of memory clients and then devfreq
driver makes decisions about a required memory frequency based on info
from ACTMON. Add ACTMON device to the thermal zone of Nexus 7 in order
to use it as a cooling device which throttles memory freq on overheat.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index c6264738f593..27adca7f4175 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -1279,7 +1279,8 @@ map0 {
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&actmon THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.30.2

