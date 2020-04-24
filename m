Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD81B7B52
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 18:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgDXQTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQTt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 12:19:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D815C09B046;
        Fri, 24 Apr 2020 09:19:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so11566139wrv.10;
        Fri, 24 Apr 2020 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tEMJE346iaELlYbOBZukFVqzIM6ZParrKkQhvnx79AY=;
        b=GkrTdfOwF3BWTNp6AqfVToOU5ymMLH6eY4OccPYKijf3pd3f2EyaURY4TnOOIV+hmF
         +BZuICsIU3Dl9U05Gw6sroJj1+3FDyvbtY2N50yUEEcVOcCFvePeCyuO+priGN9W93Mj
         YV5riKJjRC8lLKqaGCiSgicH6XfnWFONZ3A8Nf16Oq/T8hbCXjXwCBfH0zLtOQWlnXVv
         7ygZRO2EGqLe85Br9TDuwxeCwX0+7jtzqwgueueUxE5KSXzIAwFyFdEAdF8SjsDqNKY4
         EPQvVIW0WOjvwzHAOhUm9TtcJN47Qr9E7n98BAz7j9age3+ZlzeJ/1utsiUqeosdiWAP
         G4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tEMJE346iaELlYbOBZukFVqzIM6ZParrKkQhvnx79AY=;
        b=OCoBhRPtMz8lvcDlYHcrvNJr5sqUbO6ucF1ScTdjTbYzte432hq72zzM0E3cbGSfyn
         lom2Vj7ExWUN05+Q2J3Mon1QRRX9kQfSfvJXszs19U4oV+eA+xd00pXVEq6Yyuogv6/N
         CAyOgr55VuPh+1hJW+1LHNB4tvtljxBQnWt5NFmwZpUN5Hj1gnYxho16ucRumuXj7b2U
         688fzShmB1jmkc0J8n03z3LpcQ5kxDvObn1WjrJkT8L88GPMnanNokrHl3CeN/ZNl9rH
         12SEZ3I4i1GdzPvun8iRJJkRoKsvGfuHVhhsn57fftbzyvcVGzxmSVLge3+MSpqNYZnK
         ZCpA==
X-Gm-Message-State: AGi0PuYTCk0N9nnBLDp1jzwXTr5T0GaMbJH+KX7/CmB68pvSdg5drZ+m
        r/NCc3eoQoLILoK4SgIaLDc=
X-Google-Smtp-Source: APiQypIifbomWIJRPgHYqW7cg7ovdoirf1LfvSI9QXRktOFer9j5YhrN8TXWYXw8oKcmkfXwhHilSQ==
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr12914289wrh.172.1587745186232;
        Fri, 24 Apr 2020 09:19:46 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id 1sm3745165wmi.0.2020.04.24.09.19.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:19:45 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] thermal: ti-soc-thermal: avoid dereferencing ERR_PTR
Date:   Fri, 24 Apr 2020 17:19:44 +0100
Message-Id: <20200424161944.6044-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On error the function ti_bandgap_get_sensor_data() returns the error
code in ERR_PTR() but we only checked if the return value is NULL or
not. And, so we can dereference an error code inside ERR_PTR.
While at it, convert a check to IS_ERR_OR_NULL.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index d3e959d01606..85776db4bf34 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -169,7 +169,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (!data || IS_ERR(data))
+	if (!IS_ERR_OR_NULL(data))
 		data = ti_thermal_build_data(bgp, id);
 
 	if (!data)
@@ -196,7 +196,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 	}
@@ -262,7 +262,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data) {
+	if (!IS_ERR_OR_NULL(data)) {
 		cpufreq_cooling_unregister(data->cool_dev);
 		if (data->policy)
 			cpufreq_cpu_put(data->policy);
-- 
2.11.0

