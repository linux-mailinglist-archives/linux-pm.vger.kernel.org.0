Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007BA496C8D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jan 2022 14:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiAVN0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jan 2022 08:26:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44492
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233108AbiAVN0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jan 2022 08:26:03 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D3313FFDE
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642857962;
        bh=BqbA7EkPEkiPvdyZCRRPSvgPxXK4nwiMlYWc8IskYBk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JVBmnUZdohntqKv6YtehxcysFpATEpMPwbqJ4y0e7blCiQ7sOaAuQ86HNrRAxm6KR
         xXIEhrQgYgahfRWcXCiw9N4GuOjsBRps3gEGzxnNrCtJd+IS6+2r21uuYzuYlOcGv0
         vG/f60nsu7ahNpiTWYfPueseavLefye7LoOfHsqrdoFNdGyDdFTBYq6acCo56OST/H
         aUUeIw1zQq0oELscqYytUzJ3ajosbUzjl+ZfqVJlo3J3lUmoOTupGnWd0Nbpi9kuCU
         hdNqIpJJcHnUoZZkttmbwA0l1vaYBa/YdRIABZ5kRRYNSQa2glv2+DTNiZm9U3ctGH
         PB1s2nPyPMq3A==
Received: by mail-ej1-f70.google.com with SMTP id d18-20020a1709063ed200b006a5eeb2ee4dso943404ejj.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 05:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqbA7EkPEkiPvdyZCRRPSvgPxXK4nwiMlYWc8IskYBk=;
        b=gEdeCvI0Z/w5o2+SKdP572KIH8a1uYMpIki1vdRWDzfX3W7FWwu0fq/ooTQQ6ODkZm
         YJ94Hdo3W2Muh7UWnaHaEa/EC5Bful9MnTxFfPMF8rqTIzr5MkoY1dy4crs/7ZbtXB7H
         lt4g7BSDg+ZweQ67aCWIJe+zjvXHO8yrnGTzKZfYdLrdsstefRgLssOwZtB2CmvbEGSu
         WzcvzPtKkk374KOuLnDxdbcZkYtxOprxlZwQNYw80qkzbjeqZBz4Thum9CAtrwpnz3kK
         Tun67WpHCx6fl3G+OLpkl4lcMrI+XuUSUf47Lvl+CQf3LJkmVNULTY4nFNoIso7MvA5k
         MsAw==
X-Gm-Message-State: AOAM531Jtc0NZrnScNw2i05zvZ5hFabF/XxbTlovPG/+xcPsuNdvy+7K
        VZpr9847cDxKxvJgGOzv+N3Dq+4Q2lPbAgISP0LUzXBagjOHGUx00JsOmRNYxRNJWBuPGIWZ+NO
        JUWv7jnrXZ+V0fyiiQXz16TMEBo+qiPdOwHr0
X-Received: by 2002:a17:907:96a3:: with SMTP id hd35mr6710104ejc.54.1642857961536;
        Sat, 22 Jan 2022 05:26:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCIMPDmVKcXXxAx4iet6N1pLQk9bbQfelsIWrYapFJ3WqFqZr3kDLh7HQhhUY2Ppfihyu2OQ==
X-Received: by 2002:a17:907:96a3:: with SMTP id hd35mr6710090ejc.54.1642857961371;
        Sat, 22 Jan 2022 05:26:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v2sm2373060ejb.114.2022.01.22.05.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 05:26:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: thermal: samsung: drop obsolete properties
Date:   Sat, 22 Jan 2022 14:25:54 +0100
Message-Id: <20220122132554.65192-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the Samsung Exynos SoC thermal driver entry to match reality and
add Krzysztof Kozlowski as co-maintainer (as he maintains entire Samsung
SoC).  The rationale:
1. Bartlomiej's Samsung email bounces, since he is not working in
   Samsung for some time.
2. The mentioned Lukasz Majewski's Git tree was not updated
   since 2015.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27730a5a6345..928fb4cebe09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17118,11 +17118,12 @@ S:	Supported
 F:	drivers/net/ethernet/samsung/sxgbe/
 
 SAMSUNG THERMAL DRIVER
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
-S:	Supported
-T:	git https://github.com/lmajewski/linux-samsung-thermal.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
 F:	drivers/thermal/samsung/
 
 SAMSUNG USB2 PHY DRIVER
-- 
2.32.0

