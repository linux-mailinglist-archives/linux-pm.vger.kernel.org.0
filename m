Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010881F1535
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgFHJRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 05:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgFHJRv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 05:17:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688F4C08C5C4
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 02:17:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j198so13839204wmj.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80rN4Yy/llOMe52Inz2Rf3Vg/VV/GbMwITSO8biBc4M=;
        b=VKp1v8JkbAxrUOZSvdERfeYsryZbG4ZALZU7H3E+o+6qhK0KqmrwmQfvLQLKo1lxT9
         geGP1GMMeDqB7Di3ltJnV1K7KMH2gzn2kIpY+gx+PlSRNsgyXsFHllVad/i+cGbo4CsS
         27YFviT9Pmq465c4nDOupAAw+2KBKbTKPxWxipemlZfAEqrpsEAwTZbxJ+3bO/tzk72B
         5AmZlWcI/UfSCYy3xhoexs9q34DQdcb0JO7LwJT8qSKtHMDjH9D2KqJ20XT74/wpZrlN
         W2ofL5I7munj2PmfKNFVxEmI+WqmdvjHx4gsUc+FQtiawDrWNi90aEXAnvwKn5M+H1KB
         AWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80rN4Yy/llOMe52Inz2Rf3Vg/VV/GbMwITSO8biBc4M=;
        b=Q0P7flpxYaKrXe/asxz6tzKcbkq3G47DgC389HB4D3ugPJqddiBiLjqajK+XLB5vgP
         oMPgb5TrmlDYEuKZRPVcPJNcPh9XM7JpzUlZt4uTlUWUYFfUtws9b5z2wA+5UAmgLnJ3
         gB9e841KjUkKl7t0OsyfNAakRclR6Iyd8lu1r2jPn5Ea1+LRnSl3bdbTC2AvPrsLOqmi
         KktnHOa81KtBjWps3FXj32B5e5HHO1kpSvBxzUu5gwGJIWZc0Tor8wguWfZC+zmTkB9D
         xn4DgHTiUNEv7w+fepYv/EFdp/2o3JLFqPrY69T7lyjuua+6w8dIGjnFuDKHTmbfFFRm
         E3dQ==
X-Gm-Message-State: AOAM530Zj7GMUnHDV+1TTT1yRnD2lQ1+H094c4t/crwc7Jjt2F+F2nQ1
        Kd+7/uDuXdQHNccN2qybiPijAg==
X-Google-Smtp-Source: ABdhPJwJa9Vo9lkGfwDogiFZQ0nVGFlp0w7rxsYeJta8zYKqW8uewQsscYdWko6YwfV9ExZreI/2qg==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr16162838wmb.137.1591607868962;
        Mon, 08 Jun 2020 02:17:48 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id t7sm22732326wrq.41.2020.06.08.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:17:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] MAINTAINERS: add myself as maintainer for Khadas MCU drivers
Date:   Mon,  8 Jun 2020 11:17:38 +0200
Message-Id: <20200608091739.2368-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200608091739.2368-1-narmstrong@baylibre.com>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Thermal driver along the MFD drivers and header as Maintained
by myself.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..29d35fe0f886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9436,6 +9436,15 @@ F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
 
+KHADAS MCU MFD DRIVER
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+F:	drivers/mfd/khadas-mcu.c
+F:	include/linux/mfd/khadas-mcu.h
+F:	drivers/thermal/khadas_mcu_fan.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
-- 
2.22.0

