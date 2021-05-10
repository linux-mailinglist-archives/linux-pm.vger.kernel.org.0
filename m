Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66003798E5
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhEJVNC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhEJVNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:13:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B8C061763;
        Mon, 10 May 2021 14:11:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t11so25407116lfl.11;
        Mon, 10 May 2021 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0mhM5VOJlBFrF5T1QvpTzNjyhRksc+ReJ2SbVVWnBM=;
        b=uu/m7eQ/8JNpthgicesTvIUqFAGT/SESV51ET/Dy4Bj9UZB7Q2R/E0ZWR4NFEHvscm
         hkOYZcjD454dtkvZDk8lobuHaMkSk7TWFYeOJ4pYPo2OnP7i2K/AhBrs0BZEN09Y2bRY
         uV0V6MNzXWkhiecp1+7RGU4LiBSWZ9JfRt7qJmP7/GM+RLGOWo3IxaLibOd9Vr6jID9e
         Vl79CpL6Iw6qP+UU86TOD8kk0ksmgCzNv5x7Tr20Jkgr8OEBZvYq2pxYa0t/EqYBUcdM
         SKV3y58f8MFubjZPzXjM9zw/J3+/GXkNZjCWNFkeoBKtkm4Q+OB+Wr7GaGTya1XQZQaJ
         BKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0mhM5VOJlBFrF5T1QvpTzNjyhRksc+ReJ2SbVVWnBM=;
        b=nZ4fNVBzcNAEObceXdUFDhdKYKVOb7mLYO8L9NDaEmhz2qXXSPMJ+HCJe9Sjp/mIL2
         VL5DlsNsm4c7mRpgJ8Tuy/oLleAJMX6WMrMthZVqeIhevUVtJxpubN8qxR5BbVtXUgQ9
         PB5jTJV+vc9oWB0BZ0u6TTEG8aaM5kWeJ+ADJvNxw4UcACSm5A4h0rEVcqU/ilgm5jH8
         WLeSUI4Uq9sGlM0XYQyVur2UUhlrqO/PrvxwdYwTcIKcxJ+Uogz9ZejJsH+SW1kE6I9y
         25hrPzRIOhqQGiJqny+5lueT9ebu+HI0NJsnCaSPD5MVWi4XcT5+xRMCQP+EPkGPtOdV
         HY2Q==
X-Gm-Message-State: AOAM532Tlr0ubhXiXuQDEevHzSsfRuEYg7URh8o7blvfmsA/QCrzu5zl
        NhACewXj5zY8DcasDvfkxYgU1fuHqEM=
X-Google-Smtp-Source: ABdhPJzoFW9yJUJkLUcroWPTsUHs9lhnndXvIXHe0YPdHuXYh4O1M3Wv0dtyF+aPxMPpzomIY6z/EA==
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr18220313lfu.152.1620681114021;
        Mon, 10 May 2021 14:11:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.53
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
Subject: [PATCH v1 7/7] ARM: tegra: ouya: Enable memory frequency thermal throttling using ACTMON
Date:   Tue, 11 May 2021 00:10:08 +0300
Message-Id: <20210510211008.30300-8-digetx@gmail.com>
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
from ACTMON. Add ACTMON device to the thermal zone of Ouya in order to
use it as a cooling device which throttles memory freq on overheat.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-ouya.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index 9a10e0d69762..e767ac227a81 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -463,7 +463,8 @@ map1 {
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

