Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4E1B5C02
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgDWM6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728286AbgDWM6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 08:58:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4AC08E934;
        Thu, 23 Apr 2020 05:57:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so6448123wmg.1;
        Thu, 23 Apr 2020 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dqaGCrrGdtqTHr8h7W7rgZUN4zoILX85Lt2ArDxobAw=;
        b=WvdmeSTm03f4OQVBbZ1iK+jbVgf/wF81xLfrlniB7emB2YICETx8QKNrBHjJ3D6B9S
         /kT220mEN9AJvYfMSrpreaeEy/xx6N3MHR3M8VBv44C1pQdCGOgVmWFPxZFaSEuLv1/p
         E4qk3+3tx+fACOucmXS+CoQzszk7ghP6MFuAjxXE1P7trrwLmBcLaPv2a2iSzAQERh53
         CfbJmFQcQxfS6lUrjZ7mp87/3hJaDeYj1cErhJKhxoyzwDwkCMZQxbIlbOs+5ug72kkB
         aj1dUEhlyHaTL58Br7RnRA3TGbkQihUatFh7dsfmq9SxzjAFh1VoBG6P/rVrEw09vhV9
         WXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dqaGCrrGdtqTHr8h7W7rgZUN4zoILX85Lt2ArDxobAw=;
        b=IpC24l/tAOtchxTShUBvlBD8Btwwm3eGgGCFkmavfyswTTnN7n0tjirNVVo8JU6rSf
         TNZkQZROYDgrNXHGQ92RqcMKzn0ZVsFG095T6rlhYCc1GPOI9YGsvd5VAVENlmMiUUic
         q+QSigCtSse5GFrl06ex3dkLIgMsLFsrdk+6uobLmeydTZ96kEcBF/Hr0Lhv7Xt9B3Ox
         jln6LGuwZbm+4TDQXru9ClO5f1h5YcuQaBZ6b4+DkS8Hu8keoS4M6DpFziArRWqVvYeq
         mSJpxUnMnk50GBiPa6eAyGa/wiEr4P5PoGdES7o95i/jSn+wlZChijYTkZzG9U8YpbF5
         LUGQ==
X-Gm-Message-State: AGi0PuZ1/bkZ++VwCBWS5XuSSaKbXM3Srfv8NFaCmGesTNzhIvslSN5n
        8ptEznObhuGqS4NoIzy5ufM=
X-Google-Smtp-Source: APiQypJo4EyDiMeYphl9h0zQtMu+AdWMwzAH0KkyGB6bL0c5tSeXt3hvIJunfcz2O6eUi0LXihVJGA==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr3951028wmo.35.1587646678480;
        Thu, 23 Apr 2020 05:57:58 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id 185sm4051252wmc.32.2020.04.23.05.57.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 05:57:57 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] thermal: ti-soc-thermal: avoid dereferencing ERR_PTR
Date:   Thu, 23 Apr 2020 13:57:57 +0100
Message-Id: <20200423125757.14057-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On error the function ti_bandgap_get_sensor_data() returns the error
code in ERR_PTR() but we only checked if the return value is NULL or
not. And, so we can dereference a error code inside ERR_PTR.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index d3e959d01606..1e2bf1f22dd1 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -196,7 +196,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 	}
-- 
2.11.0

