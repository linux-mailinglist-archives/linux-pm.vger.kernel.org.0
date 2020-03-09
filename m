Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7434117E181
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgCINmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 09:42:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgCINmX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 09:42:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841EA7FA;
        Mon,  9 Mar 2020 06:42:22 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAE583F67D;
        Mon,  9 Mar 2020 06:42:11 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, lukasz.luba@arm.com,
        patrick.bellasi@matbug.net, orjan.eide@arm.com,
        rdunlap@infradead.org
Subject: [PATCH v4 4/4] drm/panfrost: Register devfreq cooling and attempt to add Energy Model
Date:   Mon,  9 Mar 2020 13:41:17 +0000
Message-Id: <20200309134117.2331-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309134117.2331-1-lukasz.luba@arm.com>
References: <20200309134117.2331-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Register devfreq cooling device and attempt to register Energy Model. This
will add the devfreq device to the Energy Model framework. It will create
a dedicated and unified data structures used i.e. in thermal framework.
The last NULL parameter indicates that the power model is simplified and
created based on DT 'dynamic-power-coefficient', voltage and frequency.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..8759a73db153 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -105,7 +105,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	}
 	pfdev->devfreq.devfreq = devfreq;
 
-	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
+	cooling = devfreq_cooling_em_register(devfreq, NULL);
 	if (IS_ERR(cooling))
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
 	else
-- 
2.17.1

