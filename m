Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0781C28F3
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 01:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEBXd5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 19:33:57 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:40028 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgEBXd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 19:33:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49F56V5c3Nz9vC9Y
        for <linux-pm@vger.kernel.org>; Sat,  2 May 2020 23:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WQPJiuchO0r4 for <linux-pm@vger.kernel.org>;
        Sat,  2 May 2020 18:33:54 -0500 (CDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49F56V4GTGz9vC9N
        for <linux-pm@vger.kernel.org>; Sat,  2 May 2020 18:33:54 -0500 (CDT)
Received: by mail-qt1-f198.google.com with SMTP id q57so16050602qte.3
        for <linux-pm@vger.kernel.org>; Sat, 02 May 2020 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5Ok6v3QTS7jskLU7bXRb5zaNyLJwMRDHy874gWet09s=;
        b=DsWF8qvZsx5RG9xuqF3JePeNDEacJrPwkOZyQswTfIjPVYFTsuAOC9Fjvz4d5Hkq6L
         9YnvkpVqcSo7VISqviBMZ9tw1gh1BFLBSaOVGqgzpSF9sOBgsQCgXtfAxSyw57jey6At
         u+zqXyCC8GdmAFOrtl2lsIH2CbWWL28yN46ZXvgCxzDM5ceGaZPGdCUiO+Hua/yof0vb
         QVUVuxycX/oUpwrI3vZCAnDCvDgdhUAziu7Lch0nnOG+pHCLs9g55WEpw4j6Svcz1ifp
         cmQqHT4k8jMDVTRbuHOzqcqiazsAIyt/th0LmxuvIRZjLrHAqtWHL7+Szv/MdmVXPApG
         c2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ok6v3QTS7jskLU7bXRb5zaNyLJwMRDHy874gWet09s=;
        b=kZHcbWVSKGoPG5BO4BoapXYAo7yXRhXzyST9EtsJgEmt3DFrCkz/PlsoI8fQTMng50
         jwmPafEVbAID/q5yKcCO5r43fWhLNyFQ7js5k+YfzbH/QzkJ8bfNWsdJXu3zDNEuatOh
         Pz72bS3EeQbRFNviMt6LSlAEORKM/wNfcKfSvmVXGB4YP6MzK0ki4w32Bfv9Sn0gUfUv
         wYTlu+cyAR2zMnqcTCExUROGxNUtibEgSm5LBVuQ8Pgw0gK0BmJGU4WVlSUq4crFvyP9
         cV4bbPr2vG6rhP50Xtdz9u3z0j6dwxdKGx+5kAyEpUS5lx8f9WMkyiiKPjSKnd2H1/HP
         uxeA==
X-Gm-Message-State: AGi0PuYkKzBt1FRvrphqDOj1i+wuBhw3qtgNEP/GMFQAR5nyEYxF/DG3
        UPwwru2zpFLWetTpLF529jDux+UjaHPG8ULZWQDrk1x35Il+g7nvNkOwGSpWn9G6jEVMK8AkfYK
        M9RQXVVuAr6iTpjMxv/0Byxk=
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr9951156qkz.182.1588462434009;
        Sat, 02 May 2020 16:33:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIp6mvb+J23R0t0JtGB8uh+DMZjcNiEF5oMT/5zh8Qusv1Wa3sgrkzYFNCQpRU3ptC4oHe+7g==
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr9951138qkz.182.1588462433574;
        Sat, 02 May 2020 16:33:53 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id u11sm6708645qtj.10.2020.05.02.16.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 16:33:52 -0700 (PDT)
From:   wu000273@umn.edu
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] power: supply: fix memory leaks (v2)
Date:   Sat,  2 May 2020 18:33:38 -0500
Message-Id: <20200502233338.9188-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function power_supply_add_hwmon_sysfs(), psyhw->props is
allocated by bitmap_zalloc(). But this pointer is not deallocated
when devm_add_action fail,  which lead to a memory leak bug. To fix
this, we replace devm_add_action with devm_add_action_or_reset.

v2:
  - Prevent introducing double-free.
  - Added fixes tag

Fixes: e67d4dfc9ff19 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/power/supply/power_supply_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 75cf861ba492..7c8296ea0c34 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -304,7 +304,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		goto error;
 	}
 
-	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
+	ret = devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
 			      psyhw->props);
 	if (ret)
 		goto error;
-- 
2.17.1

