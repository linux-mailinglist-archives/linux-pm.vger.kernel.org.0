Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8E5B041
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2019 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfF3PDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 11:03:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36899 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 11:03:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so11902393qtk.4;
        Sun, 30 Jun 2019 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NmpeLtv9CirMuphZn3UqpzSTC4xpI+G1gA6mWQX8+PQ=;
        b=nbqxbrj+r07X2rlsQr4Mv2uAwh7kymPo/8Bupi0yEcoWtQa+FlGsA8cKZBGU3Q2KwQ
         bSAkfNJFfLqRdTYrczpxaDidnkhWdHKPFZL8Yx5T6wyTERd0eFV8OaEDiAfbYuH1iH5z
         u7YVPu+WNVosDSkYdODjMvYHpfXi8ixCpARjBEv2daZZ9SYV1Q5wSnTKmr9PQj1nxhcH
         ur+ZQKtywVOBedMfXt/o/1MdN1n0F45H2wf9T3NDmDXf+jsxI82Ep2h/1BuWzI5GhS+y
         x16lO8jrQzqwcqs41LLAMbvyU2dAsWZBxHAE/lidF5DAyaCIp9Gho+wXbDEdfHQaKto1
         K/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmpeLtv9CirMuphZn3UqpzSTC4xpI+G1gA6mWQX8+PQ=;
        b=KpKc5Wdc+FvBJX3/5GR7PXAJxjnUOYC8SEI9moQ25iBGalrvcmnFmE0+SDJ759Xih0
         pYfYs8EeGRjOGfbvbYt3cFpT1ko7Y0H1JLx8iiJy4aRfDVeUJAnL/WOmmXqoBSzDsILY
         BjxOcj9zJxFCD3S0Z+JFLQHqxUsoa4RI2GPLGsp/FMUGkQYsz6QwYz9BfxaVmCBxUpHQ
         yYESH8mmJwSlxusXQw9L3p4VPgMJbN680sSMxBNyqyRz8ccttEjb/LP1kF3Q+IPs0o7k
         Yfwvg79iXcrGd5bmxVcbaYoGD6uixuPuvSczkmRwglUUPwR7voBU5QXa9sQJ41j70h4R
         tFDg==
X-Gm-Message-State: APjAAAUofnXhwHG39VfX1diDq9DrYW+tZMe3nbEFfs+ydyFNmiLXEkSe
        JN1DcEAR6q4R5p+Jzpm33fo=
X-Google-Smtp-Source: APXvYqy2S/mmZ9sDDpRM+wLOanixdy4o/K20sb/OVBDEHGR37wax6kuOVR5o8zOkEQY3ALeplyERDA==
X-Received: by 2002:a0c:d4b4:: with SMTP id u49mr17438483qvh.202.1561906982037;
        Sun, 30 Jun 2019 08:03:02 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id w62sm3820792qkd.30.2019.06.30.08.03.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 08:03:01 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/msm/dsi: split clk rate setting and enable
Date:   Sun, 30 Jun 2019 08:01:41 -0700
Message-Id: <20190630150230.7878-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630150230.7878-1-robdclark@gmail.com>
References: <20190630150230.7878-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Prep work for the following patch.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h      |  2 ++
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  |  3 +++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c | 38 ++++++++++++++++++++++--------
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 4dd2a9a79257..c4e3c4cf96c5 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -178,6 +178,8 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
 int msm_dsi_host_init(struct msm_dsi *msm_dsi);
 int msm_dsi_runtime_suspend(struct device *dev);
 int msm_dsi_runtime_resume(struct device *dev);
+int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host);
+int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host);
 int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
 int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
 void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 9ddf16380289..35e272c27780 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -129,6 +129,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 };
 
 const static struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
+	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
 	.link_clk_enable = dsi_link_clk_enable_v2,
 	.link_clk_disable = dsi_link_clk_disable_v2,
 	.clk_init_ver = dsi_clk_init_v2,
@@ -140,6 +141,7 @@ const static struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
 };
 
 const static struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
+	.link_clk_set_rate = dsi_link_clk_set_rate_6g,
 	.link_clk_enable = dsi_link_clk_enable_6g,
 	.link_clk_disable = dsi_link_clk_disable_6g,
 	.clk_init_ver = NULL,
@@ -151,6 +153,7 @@ const static struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
 };
 
 const static struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
+	.link_clk_set_rate = dsi_link_clk_set_rate_6g,
 	.link_clk_enable = dsi_link_clk_enable_6g,
 	.link_clk_disable = dsi_link_clk_disable_6g,
 	.clk_init_ver = dsi_clk_init_6g_v2,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index a6a3d2bad263..7c1bc174537d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -33,6 +33,7 @@ struct msm_dsi_config {
 };
 
 struct msm_dsi_host_cfg_ops {
+	int (*link_clk_set_rate)(struct msm_dsi_host *msm_host);
 	int (*link_clk_enable)(struct msm_dsi_host *msm_host);
 	void (*link_clk_disable)(struct msm_dsi_host *msm_host);
 	int (*clk_init_ver)(struct msm_dsi_host *msm_host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index d03212ef4853..87119d0afb91 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -503,7 +503,7 @@ int msm_dsi_runtime_resume(struct device *dev)
 	return dsi_bus_clk_enable(msm_host);
 }
 
-int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
+int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
@@ -513,13 +513,13 @@ int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 	ret = clk_set_rate(msm_host->byte_clk, msm_host->byte_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate byte clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	ret = clk_set_rate(msm_host->pixel_clk, msm_host->pixel_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate pixel clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	if (msm_host->byte_intf_clk) {
@@ -528,10 +528,18 @@ int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 		if (ret) {
 			pr_err("%s: Failed to set rate byte intf clk, %d\n",
 			       __func__, ret);
-			goto error;
+			return ret;
 		}
 	}
 
+	return 0;
+}
+
+
+int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
+{
+	int ret;
+
 	ret = clk_prepare_enable(msm_host->esc_clk);
 	if (ret) {
 		pr_err("%s: Failed to enable dsi esc clk\n", __func__);
@@ -571,7 +579,7 @@ int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 	return ret;
 }
 
-int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
+int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
@@ -582,27 +590,34 @@ int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
 	ret = clk_set_rate(msm_host->byte_clk, msm_host->byte_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate byte clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	ret = clk_set_rate(msm_host->esc_clk, msm_host->esc_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate esc clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	ret = clk_set_rate(msm_host->src_clk, msm_host->src_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate src clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	ret = clk_set_rate(msm_host->pixel_clk, msm_host->pixel_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate pixel clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
+	return 0;
+}
+
+int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
+{
+	int ret;
+
 	ret = clk_prepare_enable(msm_host->byte_clk);
 	if (ret) {
 		pr_err("%s: Failed to enable dsi byte clk\n", __func__);
@@ -1997,6 +2012,7 @@ int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
 	 * mdp clock need to be enabled to receive dsi interrupt
 	 */
 	pm_runtime_get_sync(&msm_host->pdev->dev);
+	cfg_hnd->ops->link_clk_set_rate(msm_host);
 	cfg_hnd->ops->link_clk_enable(msm_host);
 
 	/* TODO: vote for bus bandwidth */
@@ -2345,7 +2361,9 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
 	}
 
 	pm_runtime_get_sync(&msm_host->pdev->dev);
-	ret = cfg_hnd->ops->link_clk_enable(msm_host);
+	ret = cfg_hnd->ops->link_clk_set_rate(msm_host);
+	if (!ret)
+		ret = cfg_hnd->ops->link_clk_enable(msm_host);
 	if (ret) {
 		pr_err("%s: failed to enable link clocks. ret=%d\n",
 		       __func__, ret);
-- 
2.20.1

