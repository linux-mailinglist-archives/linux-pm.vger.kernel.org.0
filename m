Return-Path: <linux-pm+bounces-25636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D3AA91F86
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079C619E7DBD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7462517A3;
	Thu, 17 Apr 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pizVthba"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355212505D6
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899937; cv=none; b=DM6d3CwjHwWtQ+LbxylwqVMThmkiWQPCJJ7/2lYXjQuE0iurdqojsoNv9fWVX5BXOGdA/ynmaVvPoZlrjS8FRJHtr9fuzCVZ/890ZW3RwcvWapCtsX9KgnkyXtbpT+6exGfiw6ilkB292EyQXFIMSFRJsGbXKrAZVR6usfEWskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899937; c=relaxed/simple;
	bh=Cori/y8yi7jlnunZM7z+pNAx55LfzsPSrBTLfWbNPD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADsWOnEGvgbdoASUkStkLDYYfypv5LgdqTGqik2djliwvOL/A86yyAhP6COv8+2nO/2n3xgEikCrz7WdSE/S613CsuZOuJCDA08lpp15tDS0/InEJcxxwoAxc6Sn5PsCHV6QLHXixeqfZ1UuhxpiNDgFEIOZf1yZ6PhWPHFHVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pizVthba; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54b0d638e86so1047936e87.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899933; x=1745504733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLoMIJgubi/4cvpvs3WmBPRGnJMeyrBZc1JViSgU2O8=;
        b=pizVthba8+pnJGt3T9nM9h26Ez1wiFVShQPbS0AWEbGogg5JwrNginydzARfIEP2/D
         31ITHCc/Icsdf/bN7qO7Iw1VsAfQ2iwvrcDQxsmgvv8LSQskweK+tcOP9vremxfEjYkO
         U5EGjuUdvrcdzZH/6zrxgmf3pkPop+cdsSKeuN2FyGla7NJteGkY2BnUZps+rmzOxl4O
         NaxuMuHN+xu0DjCbn0In0q5b/GMzb1PAtlTpXXFGo31uCBZ4mA7FLv2IIfO9xvXkDHr0
         5kBU2/njNCeQ7365zeTGAVAqp+vW69WZsoL633xLjsKTV8cgQR4AmfA32QIZFgx2A8Bc
         sKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899933; x=1745504733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLoMIJgubi/4cvpvs3WmBPRGnJMeyrBZc1JViSgU2O8=;
        b=plaACuzJk4yeJDCvFLi2VEDiVosEyjIvSoQWyN5K3az2UvBxZ0f6rTPlipopBkG8fW
         cQ/ahJ8HDzdf5oRp5OUN5bNoJiMhTWzPXxFC7jbbH0BFz46ET4tRgpta4VBtaU2wVHcT
         Zq/Moqim6/ifcPWQqVe/Ysmkh0TG1u2/jx67tq/ufjkV4pIWEbtKOFr4X+BYhDrgYLtr
         xCDfM8DpluSE8T/dxitGQxcT//Q85/AeL/8RBkwnut5I5ijgwmiZLBVigizw4jZza63q
         DnalW6VaFeVY+2CFzllLLqkbpIu9Jd0A/C3qCDlnQifdfEmhf/Bs4B8U+VdhXx5x/4ky
         X3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6zFBhGpuWfbJsdcVYBn7DCW4kcAO8hbon7UP+sxf8cfgBmfNnuv5O4edJuTyWMB+0YCwuGfoOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaca/2arAgjMNG+KDBZVK3li1L/Y692YMigmS3AJ418KnPQSPI
	ZGvZXqT532pbRqUvNXMhDH6NxatE6Y8p6/RzuZ2C0biIpc/PXr+6ob4PPiDCqAE=
X-Gm-Gg: ASbGncsiF3wEQ9AYS4fp9XwOxOGoDj1PzWel3DlXw71r7dzKVx955/g+dRStKBMPOmd
	55qwOmGT/fehrHCz0X+0beox+jyrM7qEvUluyA5V9x4WWhmCsiVnLJoUOSUyuoahm4fBhF5OJoG
	ZX5CgSGVz7hWblPcWl/f/2aMLLKRnFJrGe2S1OuAykfdDe0AKplEhDAUIVE2JI9olUUfvkr7Q2w
	OndeZqowXfmDrchzN6hAAZAC5TPDyuRdwRThLzx4RDaMbzqS+9ub1mo6AjeCo18SemG1r53Oa24
	esSIPIF0SKEMt6QOycJ2+yAWvqVFfvnkcJetIjZO+PYE05ZAu6QTkvZlF7vUoIblj00d/BOXPZ+
	rcA2f47Y7O5x23gA=
X-Google-Smtp-Source: AGHT+IGEHywzk0Uvrr5vva6qwKhkHAMRzineGZ+Ie2tYZ9oqV2dzLL/IgZ7exOPJtd8mc3KpgoduVg==
X-Received: by 2002:a05:6512:3a93:b0:549:8809:ee32 with SMTP id 2adb3069b0e04-54d64a9d570mr2067636e87.22.1744899933071;
        Thu, 17 Apr 2025 07:25:33 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:32 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] pmdomain: core: Convert genpd_power_off() to void
Date: Thu, 17 Apr 2025 16:24:59 +0200
Message-ID: <20250417142513.312939-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At some point it made sense to have genpd_power_off() to return an error
code. That hasn't been the case for quite some time, so let's convert it
into a static void function and simplify some of the corresponding code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 3523d0331cec..574a0de1696a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -908,13 +908,12 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
  */
-static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
-			   unsigned int depth)
+static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
+			    unsigned int depth)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended = 0;
-	int ret;
 
 	/*
 	 * Do not try to power off the domain in the following situations:
@@ -922,7 +921,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	 * (2) System suspend is in progress.
 	 */
 	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
-		return 0;
+		return;
 
 	/*
 	 * Abort power off for the PM domain in the following situations:
@@ -932,7 +931,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (genpd_is_always_on(genpd) ||
 			genpd_is_rpm_always_on(genpd) ||
 			atomic_read(&genpd->sd_count) > 0)
-		return -EBUSY;
+		return;
 
 	/*
 	 * The children must be in their deepest (powered-off) states to allow
@@ -943,7 +942,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
 		struct generic_pm_domain *child = link->child;
 		if (child->state_idx < child->state_count - 1)
-			return -EBUSY;
+			return;
 	}
 
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
@@ -957,15 +956,15 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 
 		/* The device may need its PM domain to stay powered on. */
 		if (to_gpd_data(pdd)->rpm_always_on)
-			return -EBUSY;
+			return;
 	}
 
 	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
-		return -EBUSY;
+		return;
 
 	if (genpd->gov && genpd->gov->power_down_ok) {
 		if (!genpd->gov->power_down_ok(&genpd->domain))
-			return -EAGAIN;
+			return;
 	}
 
 	/* Default to shallowest state. */
@@ -974,12 +973,11 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 
 	/* Don't power off, if a child domain is waiting to power on. */
 	if (atomic_read(&genpd->sd_count) > 0)
-		return -EBUSY;
+		return;
 
-	ret = _genpd_power_off(genpd, true);
-	if (ret) {
+	if (_genpd_power_off(genpd, true)) {
 		genpd->states[genpd->state_idx].rejected++;
-		return ret;
+		return;
 	}
 
 	genpd->status = GENPD_STATE_OFF;
@@ -992,8 +990,6 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 		genpd_power_off(link->parent, false, depth + 1);
 		genpd_unlock(link->parent);
 	}
-
-	return 0;
 }
 
 /**
-- 
2.43.0


