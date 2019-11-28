Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF210CC6F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfK1QDY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:03:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50575 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfK1QDY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:03:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so11511428wmh.0;
        Thu, 28 Nov 2019 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jiPFkJr8K+r185dz3meGF9Rkk5ahdrm7UQfYURLxxJE=;
        b=PB5LHoZshTGHaxfaPdX6fSYl+Me/Ge/gdvpmr49K3UIpK4gfRq/KpgCsQ1oq5HKSFw
         1zfeG/fGqvCfpmDSrXL73JkAnw2f0+umB9V8TBXB4OoTk9jER+lOm/GAysrxR8W2v46M
         uIfg11Ne+LX4ZRz/S1ACz4sOdbLfUxmYDPlu0fzS8sEU+uD7FvMKdm7VCAB852vUW7Qn
         VqPvGE+p7tCDAuFm4aR4F2alNFpDHpclNOEN5XrUmoOARu4MVcT9peAXQyntutLcMyNn
         BMjfUGJ4bDHlQQYe3PMTVoql96B6dNLYj1EgQgdz1068X63FWvet0T6ECffMCgZF0xtu
         PLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jiPFkJr8K+r185dz3meGF9Rkk5ahdrm7UQfYURLxxJE=;
        b=SoOylo9PxjsgG1IETcrofOK2/npAbflSmdLRjCsNhXDK0GpT3sM4CDRlE3iL0Z9Emx
         0t3O/HoQjPTcZfNV3iIX0ihx7Mto/GDKrdTcH6jUfyDK6qqn5ZCLcpfsD7RclpV3ef09
         50wyaJpcolThgNxvbJqhduvRyt54GgK7NiwlyFec/8Rg9KLCBVrqwiuthP0Dz1uX9R6a
         Ge69rm/PUs2igF7Z+0V1+A4Xc4nNU2NRjQWTteNgBvwmMuSuD4R6e0QqBScI2CNJazUn
         Lb2o6m+pMdALhLDyfdKKQw/PxX0MWgHYRRbRY9FQka24v8HfckRJ++bwmk/xHIyGUnAU
         Q3AQ==
X-Gm-Message-State: APjAAAVXIBvnGkdoK6BPHKzHIgyLKBNKLnPkoRhTO0I46BCWbm9YY7RG
        oBr6XE5kMfgVX4JBJf0o054=
X-Google-Smtp-Source: APXvYqx+k4JQZLKsE8o2E6bpXGMJN487dEZBP+g2+g5JjAWAcxUXYJTrNdAN+zermTFhePpO/HD/dg==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr9783029wmq.97.1574957001542;
        Thu, 28 Nov 2019 08:03:21 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id h15sm24670157wrb.44.2019.11.28.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:03:20 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] drm/tegra: Allow runtime suspend on system sleep
Date:   Thu, 28 Nov 2019 17:03:14 +0100
Message-Id: <20191128160314.2381249-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128160314.2381249-1-thierry.reding@gmail.com>
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

By default the PM core prevents devices from being runtime suspended
during system sleep. This is needed to avoid some common cases where
devices cannot be properly resumed because their parents are runtime
suspended at an unfortunate point in time.

However, there are cases where suspend/resume works in a way that it
becomes possible for devices to be runtime suspended at system sleep
time. In fact, for some devices runtime suspension can be equivalent
to their state in system sleep.

Typically this would be solved by making the runtime suspend/resume
callbacks the same as the system suspend/resume callbacks. For some
subsystems it isn't quite that simple, unfortunately.

For example, the DRM subsystem has subsystem-level suspend/resume
helpers that control how display pipelines are shut down on suspend
and brought up again on resume. This procedure is the same as their
operation under normal circumstances (when the user switches on/off
a subset of the displays in their configuration). These helpers are
carefully ordering the operations to make sure the right sequences
between connectors, encoders and display controllers are respected.

In order for suspend/resume to not get in the way of the sequencing
that's already happening at the subsystem level, allow the devices
involved in the display pipelines to runtime suspend during system
sleep.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c   | 1 +
 drivers/gpu/drm/tegra/dsi.c  | 1 +
 drivers/gpu/drm/tegra/hdmi.c | 1 +
 drivers/gpu/drm/tegra/hub.c  | 1 +
 drivers/gpu/drm/tegra/sor.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 2b9a25c977c0..386819b4662b 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2506,6 +2506,7 @@ static int tegra_dc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dc);
+	pm_runtime_always_allow(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	INIT_LIST_HEAD(&dc->client.list);
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index a5d47e301c5f..683a27f9ba52 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1552,6 +1552,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dsi);
+	pm_runtime_always_allow(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	INIT_LIST_HEAD(&dsi->client.list);
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 50269ffbcb6b..2562bf607be1 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1664,6 +1664,7 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, hdmi);
+	pm_runtime_always_allow(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	INIT_LIST_HEAD(&hdmi->client.list);
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index e56c0f7d3a13..aced537ac990 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -844,6 +844,7 @@ static int tegra_display_hub_probe(struct platform_device *pdev)
 		return err;
 
 	platform_set_drvdata(pdev, hub);
+	pm_runtime_always_allow(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	INIT_LIST_HEAD(&hub->client.list);
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index a68d3b36b972..20058f11bf81 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3833,6 +3833,7 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, sor);
+	pm_runtime_always_allow(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	/*
-- 
2.23.0

