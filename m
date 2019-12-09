Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5654116D86
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLINDn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 08:03:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINDn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 08:03:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so16049905wrj.12;
        Mon, 09 Dec 2019 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jfaKoGNvqeidEq8dhnq6AcI1xu7YSgIa7d+c2XneLU=;
        b=nJnMUsn5k0EcBUm25/tW8addzcqoMExr1GBznxenl12nfocviT8yg3YCirI4cZEfSM
         Ys+EQfOyjzoKQuYJEl6s+W+7nIYtYONdtIOLokPCDTj4Ao9d05RPeAcfT0tcrgwbmj40
         evUnAO9tr80xhcocvkFg3b6NCTHEc8yrP/jEDd8jfKc+9yX4knfT2iIO94xfWftK33Uw
         yQsHE0C7gYPF0j2fNJEMVnbMXm2ZrcNwTg+UmyekktvKcuqXyuHPz+QhssI6pbROBk7B
         ++0F77BDxUDR5iazuvBm4lOsktaWUq7DQdm9kaevFPVO7a5b694mzoBs2MmUUw9mBh5N
         bUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jfaKoGNvqeidEq8dhnq6AcI1xu7YSgIa7d+c2XneLU=;
        b=mTJH7ing8N2wntenDLcyWoBqVVt0H7KbsNmOBxLVMN0qevrTpsZO4jdsadar1IVb2q
         89D+mBTAwvzKQg4ag0+b2mzujtmn7NJxru99TnTYbrihCX8w85yk94URUacnFN7bGlNt
         N2zsU1e6zc9mgS2cGeIb00DrepbEqNfn1AiANmUVYBiqM6fnzHiJr1MJg2Tn94x8zVnl
         jia1DKqT0+SECCH4/6tUXoHAGN4Y1Z63NxC+cd+g4oSngWcR17gLuI+dGuYQXAXguQFB
         d3hr8JxBdLmBpmgsjxbnYZ9bxLmuvDVeoOwJl5QJiOGfF5uyVislAaX8ERz8BvIzQNKh
         Hgig==
X-Gm-Message-State: APjAAAUI/xc1n3rMhxueR8HwazYU67u7cdN8yje1sESw7tlkCmUT/1BF
        pZMOZcBLvWu3qq+1s1SApXw=
X-Google-Smtp-Source: APXvYqzQxD7lF922G6ERkcssqg3U35zr0pbQtJJBjIM1pBSgTT4U/Fucfb9nKcd4zVHcCxWucECksg==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr2193679wrv.9.1575896619466;
        Mon, 09 Dec 2019 05:03:39 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id 62sm11413220wmb.27.2019.12.09.05.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:03:38 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] gpu: host1x: Rename "parent" to "host"
Date:   Mon,  9 Dec 2019 14:03:35 +0100
Message-Id: <20191209130336.2257506-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Rename the host1x clients' parent to "host" because that more closely
describes what it is. The parent can be confused with the parent device
in terms of the device hierarchy. Subsequent patches will add a new
member that refers to the parent in that hierarchy.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c   | 6 +++---
 drivers/gpu/drm/tegra/drm.c  | 4 ++--
 drivers/gpu/drm/tegra/dsi.c  | 2 +-
 drivers/gpu/drm/tegra/gr2d.c | 4 ++--
 drivers/gpu/drm/tegra/gr3d.c | 4 ++--
 drivers/gpu/drm/tegra/hdmi.c | 2 +-
 drivers/gpu/drm/tegra/hub.c  | 4 ++--
 drivers/gpu/drm/tegra/sor.c  | 2 +-
 drivers/gpu/drm/tegra/vic.c  | 8 ++++----
 drivers/gpu/host1x/bus.c     | 4 ++--
 drivers/gpu/host1x/syncpt.c  | 2 +-
 include/linux/host1x.h       | 2 +-
 12 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 2b9a25c977c0..2983eb33f2be 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2006,7 +2006,7 @@ static bool tegra_dc_has_window_groups(struct tegra_dc *dc)
 
 static int tegra_dc_init(struct host1x_client *client)
 {
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	unsigned long flags = HOST1X_SYNCPT_CLIENT_MANAGED;
 	struct tegra_dc *dc = host1x_client_to_dc(client);
 	struct tegra_drm *tegra = drm->dev_private;
@@ -2087,9 +2087,9 @@ static int tegra_dc_init(struct host1x_client *client)
 
 	/*
 	 * Inherit the DMA parameters (such as maximum segment size) from the
-	 * parent device.
+	 * parent host1x device.
 	 */
-	client->dev->dma_parms = client->parent->dma_parms;
+	client->dev->dma_parms = client->host->dma_parms;
 
 	return 0;
 
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index f455ce71e85d..aa9e49f04988 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -905,7 +905,7 @@ int tegra_drm_unregister_client(struct tegra_drm *tegra,
 int host1x_client_iommu_attach(struct host1x_client *client)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(client->dev);
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
 	struct iommu_group *group = NULL;
 	int err;
@@ -941,7 +941,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 
 void host1x_client_iommu_detach(struct host1x_client *client)
 {
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
 	struct iommu_domain *domain;
 
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index a5d47e301c5f..ec475d022fa0 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1030,7 +1030,7 @@ static const struct drm_encoder_helper_funcs tegra_dsi_encoder_helper_funcs = {
 
 static int tegra_dsi_init(struct host1x_client *client)
 {
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_dsi *dsi = host1x_client_to_dsi(client);
 	int err;
 
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 1fc4e56c7cc5..48363f744bb9 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -34,7 +34,7 @@ static inline struct gr2d *to_gr2d(struct tegra_drm_client *client)
 static int gr2d_init(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct drm_device *dev = dev_get_drvdata(client->host);
 	unsigned long flags = HOST1X_SYNCPT_HAS_BASE;
 	struct gr2d *gr2d = to_gr2d(drm);
 	int err;
@@ -76,7 +76,7 @@ static int gr2d_init(struct host1x_client *client)
 static int gr2d_exit(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct drm_device *dev = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = dev->dev_private;
 	struct gr2d *gr2d = to_gr2d(drm);
 	int err;
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 24fae0f64032..c0a528be0369 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -43,7 +43,7 @@ static inline struct gr3d *to_gr3d(struct tegra_drm_client *client)
 static int gr3d_init(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct drm_device *dev = dev_get_drvdata(client->host);
 	unsigned long flags = HOST1X_SYNCPT_HAS_BASE;
 	struct gr3d *gr3d = to_gr3d(drm);
 	int err;
@@ -85,7 +85,7 @@ static int gr3d_init(struct host1x_client *client)
 static int gr3d_exit(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct drm_device *dev = dev_get_drvdata(client->host);
 	struct gr3d *gr3d = to_gr3d(drm);
 	int err;
 
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 50269ffbcb6b..38bf1d16095f 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1424,8 +1424,8 @@ static const struct drm_encoder_helper_funcs tegra_hdmi_encoder_helper_funcs = {
 
 static int tegra_hdmi_init(struct host1x_client *client)
 {
-	struct drm_device *drm = dev_get_drvdata(client->parent);
 	struct tegra_hdmi *hdmi = host1x_client_to_hdmi(client);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	int err;
 
 	hdmi->output.dev = client->dev;
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index e56c0f7d3a13..5c7545ee5a5b 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -715,7 +715,7 @@ void tegra_display_hub_atomic_commit(struct drm_device *drm,
 static int tegra_display_hub_init(struct host1x_client *client)
 {
 	struct tegra_display_hub *hub = to_tegra_display_hub(client);
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
 	struct tegra_display_hub_state *state;
 
@@ -733,7 +733,7 @@ static int tegra_display_hub_init(struct host1x_client *client)
 
 static int tegra_display_hub_exit(struct host1x_client *client)
 {
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
 
 	drm_atomic_private_obj_fini(&tegra->hub->base);
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index a68d3b36b972..956bf5d680ad 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3053,7 +3053,7 @@ static const struct tegra_sor_ops tegra_sor_dp_ops = {
 
 static int tegra_sor_init(struct host1x_client *client)
 {
-	struct drm_device *drm = dev_get_drvdata(client->parent);
+	struct drm_device *drm = dev_get_drvdata(client->host);
 	const struct drm_encoder_helper_funcs *helpers = NULL;
 	struct tegra_sor *sor = host1x_client_to_sor(client);
 	int connector = DRM_MODE_CONNECTOR_Unknown;
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 3526c2892ddb..ade56b860cf9 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -161,7 +161,7 @@ static int vic_boot(struct vic *vic)
 static int vic_init(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct drm_device *dev = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = dev->dev_private;
 	struct vic *vic = to_vic(drm);
 	int err;
@@ -190,9 +190,9 @@ static int vic_init(struct host1x_client *client)
 
 	/*
 	 * Inherit the DMA parameters (such as maximum segment size) from the
-	 * parent device.
+	 * parent host1x device.
 	 */
-	client->dev->dma_parms = client->parent->dma_parms;
+	client->dev->dma_parms = client->host->dma_parms;
 
 	return 0;
 
@@ -209,7 +209,7 @@ static int vic_init(struct host1x_client *client)
 static int vic_exit(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct drm_device *dev = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = dev->dev_private;
 	struct vic *vic = to_vic(drm);
 	int err;
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 2c8559ff3481..50d500345d04 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -120,7 +120,7 @@ static void host1x_subdev_register(struct host1x_device *device,
 	mutex_lock(&device->clients_lock);
 	list_move_tail(&client->list, &device->clients);
 	list_move_tail(&subdev->list, &device->active);
-	client->parent = &device->dev;
+	client->host = &device->dev;
 	subdev->client = client;
 	mutex_unlock(&device->clients_lock);
 	mutex_unlock(&device->subdevs_lock);
@@ -156,7 +156,7 @@ static void __host1x_subdev_unregister(struct host1x_device *device,
 	 */
 	mutex_lock(&device->clients_lock);
 	subdev->client = NULL;
-	client->parent = NULL;
+	client->host = NULL;
 	list_move_tail(&subdev->list, &device->subdevs);
 	/*
 	 * XXX: Perhaps don't do this here, but rather explicitly remove it
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index dd1cd0142941..fce7892d5137 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -421,7 +421,7 @@ int host1x_syncpt_init(struct host1x *host)
 struct host1x_syncpt *host1x_syncpt_request(struct host1x_client *client,
 					    unsigned long flags)
 {
-	struct host1x *host = dev_get_drvdata(client->parent->parent);
+	struct host1x *host = dev_get_drvdata(client->host->parent);
 
 	return host1x_syncpt_alloc(host, client, flags);
 }
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 6edeb9228c4e..470a193a9fed 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -44,7 +44,7 @@ struct host1x_client_ops {
  */
 struct host1x_client {
 	struct list_head list;
-	struct device *parent;
+	struct device *host;
 	struct device *dev;
 	struct iommu_group *group;
 
-- 
2.23.0

