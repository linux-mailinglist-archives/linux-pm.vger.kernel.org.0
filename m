Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5662D3FF9
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgLIKce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 05:32:34 -0500
Received: from foss.arm.com ([217.140.110.172]:60734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgLIKca (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Dec 2020 05:32:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD2A143D;
        Wed,  9 Dec 2020 02:31:12 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.24.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B666A3F718;
        Wed,  9 Dec 2020 02:31:09 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        ionela.voinescu@arm.com
Subject: [PATCH v3 5/5] drm/panfrost: Register devfreq cooling and attempt to add Energy Model
Date:   Wed,  9 Dec 2020 10:30:16 +0000
Message-Id: <20201209103016.10442-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209103016.10442-1-lukasz.luba@arm.com>
References: <20201209103016.10442-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Register devfreq cooling device and attempt to register Energy Model. This
will add the devfreq device to the Energy Model framework. It will create
a dedicated and unified data structures used i.e. in thermal framework.
The last NULL parameter indicates that the power model is simplified and
created based on DT 'dynamic-power-coefficient', voltage and frequency.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 78e9d82f7318..f44d28fad085 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -138,7 +138,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	}
 	pfdevfreq->devfreq = devfreq;
 
-	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
+	cooling = devfreq_cooling_em_register(devfreq, NULL);
 	if (IS_ERR(cooling))
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
 	else
-- 
2.17.1

