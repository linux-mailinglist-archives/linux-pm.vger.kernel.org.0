Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE422CB98
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgGXRBM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXRBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 13:01:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FEC0619D3;
        Fri, 24 Jul 2020 10:01:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so7515094edz.0;
        Fri, 24 Jul 2020 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N55p9HlPMBDczNO+FOx56BHvJH2h0tKoLCVXNpo9G3M=;
        b=WvZXqq7rAaJYphTzFQ9Vvq+Wn/RP5L3aKeqJOEyh76XpdQP96g1hniiru2fEFxQh8N
         cuh3EHmBNmH1rGSFaUj5+FPAsM+5jEG/yLcmCnQRpFBdjiYPJAXGXjEHnc/cdTBK9Ahb
         QMVvP7uBiXfNUvDmW7+QeaIFV2OhMP/QUyy5lnBqRVTgLzZmwNozq1QDzq7jjJzGGFCc
         iST4nAdSfktKCoFtR5wvPKP0mwn1E8eT7e5hl5b09dy0RCD2LG+5F4tMbuyuoA53DAWh
         esB7DuwLVNy/2QhZ+9q1iK7V7quoMDxV3BJSpSiWKeP+Ac4kXEnqbBHKLDISg5wweq0P
         M+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N55p9HlPMBDczNO+FOx56BHvJH2h0tKoLCVXNpo9G3M=;
        b=FeyTiHlRKkoqiIh+eLjt10Kx6Z9pAvrX7OpeEPDd43O01AHjYska2pmS4IFkL5vV+L
         ObikjYKnHBA6jJhrPlHFxiJ/zWVgWnk1hnC6NGdJEOxhIheo2u/inCWbW4iJIMWFSDs8
         U/WSCfPBOGbPl4HGvGP+0ald4trMGDNiwfEeZHequYu3am8TdWcTKctR08QSIZPrwhQQ
         V5JynQOY2Dw7xqiU2dQ2XKxsoF5Bkmm90nWx7GyThLZ1httuJe7+4iLID9jGKH1Q/FEA
         1j3rS1jIhvy2gNFsU7QorrCIN1f3uuZDsWfrb3ruUfAPEhblQMOU4XlV5JBbhVGYVb9E
         +zrg==
X-Gm-Message-State: AOAM532tbCy1ehH8a3uP64PSMUXgHTjJTaS/1PelaI49zU3hvemJj0DM
        8NZQTL1rD3ZAMmMi4P+GaE8pqrRX
X-Google-Smtp-Source: ABdhPJytnSuqN8Rq5+gISeWtuSvudKbnrUSIIGlRetE2zWQZ4mRgW3qWuBpdGiuYKSunbCD5BMDJqQ==
X-Received: by 2002:a50:ab5c:: with SMTP id t28mr9723421edc.209.1595610070636;
        Fri, 24 Jul 2020 10:01:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u60sm1066419edc.59.2020.07.24.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:01:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Fix zone lookup by ID
Date:   Fri, 24 Jul 2020 19:01:05 +0200
Message-Id: <20200724170105.2705467-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

When a thermal zone is looked up by an ID and no zone is found matching
that ID, the thermal_zone_get_by_id() function will return a pointer to
the thermal zone list head which isn't actually a valid thermal zone.

This can lead to a subsequent crash because a valid pointer is returned
to the called, but dereferencing that pointer as struct thermal_zone is
not safe.

Fixes: 329b064fbd13 ("thermal: core: Get thermal zone by id")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/thermal_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 007f9618e20a..9748fbb9a3a1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -751,16 +751,18 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id)
 {
-	struct thermal_zone_device *tz = NULL;
+	struct thermal_zone_device *tz, *match = NULL;
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->id == id)
+		if (tz->id == id) {
+			match = tz;
 			break;
+		}
 	}
 	mutex_unlock(&thermal_list_lock);
 
-	return tz;
+	return match;
 }
 
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
-- 
2.27.0

