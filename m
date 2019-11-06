Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033FDF1701
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfKFN2w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:28:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45960 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfKFN2w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:28:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so12849824pfn.12
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iZlXNo5QDi4Ku2OumCxTReBsuPP9X5fG3KsKTSejROc=;
        b=y54iMZhFsDkhFVspBHefTVsS0hpSeUoA3E6jZcdSI24ker0Pp8pVSHUKkHOnchnU2y
         bE3qmBDWjNZbAq+4XwhySlaLmsMnZ/V7IEwhs6HajcnVKTeVTuPwQcmh/HedpQx8YUgE
         4lZJmGpSURzeSqWHx3Cehn2x+RmRN8m0U3erKhQB2CDj4ScykGxNU4DmYjCNKxd5DbqR
         eOGiSGBesA+CLOh+by1tGNqI0KkNtofAJ6xCaueiAzznemhYiWztpVfVj7tH5tNqc4g8
         sTH+D/ReKhn2R0pteTZ0fOsKb8oNIbyMSIRcwCdwe7hceH3Be8Z4ysxaWGgd3bAvXFRt
         CGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iZlXNo5QDi4Ku2OumCxTReBsuPP9X5fG3KsKTSejROc=;
        b=ZzrXwnWdWsQoP/NiicQxery7UOBJK0bq8n5AbkFlklNMts1TiMtCppcg4AC676xqYf
         oZw7+Y7DMBmMhVS+2dw6DG+Upo+ch1sd3r8qGfGVDteGfoXVI0Ch6bDP3y0/oQqIWJxn
         GuHzcytkLsUgc6DbPpuFKLHdoR3LA0owMl32TLuaulSnuYBtaJv6ooqR888Kl4U4xuXF
         YZjnpMHa61TkH5MeHKNwtNmY6nu4Vi0SgmMkOlSSCxK2XhMFYpX8m4MYXwrMxfLOQm5U
         C+tNZhvXbr+/tS6sIB51x+QbLmHRd4as/6gtyVu9vs90Xhom/fTZKHzzjthJretTOitX
         59tg==
X-Gm-Message-State: APjAAAWGlB9knG7NcihILeAc0yNhtyGb7NyzEtAAddlCPpSjd/4wzJnl
        iJxhqVx9+1Fq6NIVQ1VvuTztOA==
X-Google-Smtp-Source: APXvYqylDq4LroSCnkG+NIJ7kCS82rA20ZZVdTUzOtMvXKS2/99tTZNfrdM2gL5LpglHl3+0dWxrbQ==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr3803290pjt.38.1573046931527;
        Wed, 06 Nov 2019 05:28:51 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id u20sm6015923pgo.50.2019.11.06.05.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:51 -0800 (PST)
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
Subject: [PATCH 04/11] thermal: devfreq_cooling: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:20 +0530
Message-Id: <fbaad8b0854e8127624e6b7bd5f1272eaf8aee85.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warnings with make W=1:

linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
function parameter 'dfc' description in 'devfreq_cooling_unregister'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff6..a87d4fa031c87 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -53,6 +53,7 @@ static DEFINE_IDA(devfreq_ida);
  *		'utilization' (which is	'busy_time / 'total_time').
  *		The 'res_util' range is from 100 to (power_table[state] * 100)
  *		for the corresponding 'state'.
+ * @capped_state:	index to cooling state with in dynamic power budget
  */
 struct devfreq_cooling_device {
 	int id;
@@ -587,7 +588,7 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
  * devfreq_cooling_unregister() - Unregister devfreq cooling device.
- * @dfc: Pointer to devfreq cooling device to unregister.
+ * @cdev: Pointer to devfreq cooling device to unregister.
  */
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-- 
2.17.1

