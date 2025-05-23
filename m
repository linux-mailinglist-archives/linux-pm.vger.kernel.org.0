Return-Path: <linux-pm+bounces-27578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1BAC2452
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC22E3A2836
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93829710C;
	Fri, 23 May 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VC1r5AUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D7296FD5
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007673; cv=none; b=jgxkLsln8Ui9o/W88MLTkDj1Cj4VEuGNdmZp/thgS2g6O8KpCU6zwjqwjHzOXfMTJ6BFMcjjwgDwVC8MBiP8vXCwiGUjjslshqvdVIV4pbv1IkckNrnmC65+0T5QqLby4sHxmNSs4lGrWI4anY1y6yvRy86MW765C/3j+t+cm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007673; c=relaxed/simple;
	bh=rJ1WF3jh53M3IFOFtyOo1l9fXgUPc2OdamLreAdGPrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTV0HQj71E835YvQq0Kw4CC2w44e8P2c63mBovcW4hR2wngSn1hO8D29Pb0LtzRKQqMnwM8S8x4DsafYvPWGCV8kCWpUKH2fQ6c897RnnDYY3MpgkuVJKc1MeZEFBPVmRAQqugDzBsx0tzJTBtWd/d6vuLj5VFGSO0JbJ9PDC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VC1r5AUx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-551fb4d153dso5527959e87.3
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007669; x=1748612469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTfJ/GeY/lTwR1D9VlQQIY/dt3W579Yxd9kJ3BXM+Hk=;
        b=VC1r5AUxPoDTsmH7yaDktjkCwQVJRgujT4RqqYiIfmycom5w2eToacpu7MevG+pDac
         M4JGRTFc/u3R4UzsymV+PTV4GMvTJTNHQRdyuKle0w/7QmHlSFYTRETrNUJu0nTV6fqw
         fxp6dXKs185yTlubedEleNlv6mmimn08Qq3++VHEtxvwnpXKR8ThXS+o+uQXs9shTBTf
         glux+tHh0ydLPHSI22Bnp7tJBLhl7t9jDZX4DZaJW019/VUywZrghUuiisNkH75l5Vxl
         dvk3UGYDzTL1WzVWJuKT6kYP29gMLEvpduSD1/VLABtjPshwC6Bs1CqC2V8vQOw8ctog
         v/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007669; x=1748612469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTfJ/GeY/lTwR1D9VlQQIY/dt3W579Yxd9kJ3BXM+Hk=;
        b=CIxIaE4sXGABa3+JJ+zxonCGd89AXRXKsNj29ZbFvLHaqD/NlHj1MVmeuF2AObLPw1
         bhH/U7IsjGk+kLDJ1cqujnOPiWBR7TAgAcrzsjvaoa/km62ixSb9P/YPmkZOL/oXpGP7
         8ypjFEDN6Scige+BgzlvZj5GWXVXIfwj2/ZnKaqurLwpH7jGGZpRZ8Jv5slOXYj5Ml3c
         qKDwzNMfEmZeRGV63el4NPXGMfOjCo5mCncBv9sPEz0fhHTlQNeeb2aO13lYsVOAv98K
         ItuORIkrc08CdEoNZ2e386mXrdzTL4GposxqNXEf8y/BX2jnFkQVb9ABcmccATEJMvzK
         KLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzZq98P6t0s2wy7zueXbSX0IBbk86MnYDhECxo24k80UDeH3KVSt0uZP7cWohDKzypTVQ18qzTQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybH6umEJlCTtZK2FU7NvwGvewKux12uiy87q6SgpM3bG1Q39Z8
	sJscIoHCeGpgwxmYSBksy+BP3RBkoOdrBikPEh53JLwg8c2z07wd0xQ8BS3QEiPtBDA=
X-Gm-Gg: ASbGncuzWdNGPI7d18eleexV2yPgqS2JHr+cw3OY6axK35Azl5r9PRUrsCNPjs0V6Qz
	0HopcTUd28WaJN3qcN4wzY7BnXLY+dfmQz8MEjk2Vz73WJ3C/jWQa2oGilSm1K6Gjjxwa6ZcLbr
	qnvPUFZ6lhnYfckYth73yWS/hyc0y1SdV9M7RQPtCnPlFFiZL54yn927ZAp42By/9NJ1ykptson
	6MCyxzekYHS9oF3iA7A35S3RP1Pn6qQDtllNjzZ0N8hacsB4BrpQwbWbRzElyuYtx3WvUOoDhpr
	IWfrUFgxMnxtcM14fNnI9RuF8sNIEDrtJffpnrgjmC0reM8Rr+MNIgrOvMJqMU7dV74exSbNqa5
	vH52z2eQmdn1Qzd5utNeGRz10MMNb6xdoaqe5
X-Google-Smtp-Source: AGHT+IFDLfxM01YaBSflhZJhg763sDEi77sCbELPLz/NKFACM48uG4bkUP+LayfK8+cXACHnwwnbIg==
X-Received: by 2002:a05:6512:4508:b0:54f:c049:4a54 with SMTP id 2adb3069b0e04-550e971afa4mr8711955e87.12.1748007668631;
        Fri, 23 May 2025 06:41:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:08 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/21] pmdomain: core: Leave powered-on genpds on until late_initcall_sync
Date: Fri, 23 May 2025 15:40:15 +0200
Message-ID: <20250523134025.75130-19-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Powering-off a genpd that was on during boot, before all of its consumer
devices have been probed, is certainly prone to problems.

As a step to improve this situation, let's prevent these genpds from being
powered-off until genpd_power_off_unused() gets called, which is a
late_initcall_sync().

Note that, this still doesn't guarantee that all the consumer devices has
been probed before we allow to power-off the genpds. Yet, this should be a
step in the right direction.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 10 ++++++++--
 include/linux/pm_domain.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index b39d06d3ad26..5d2ed4edffd7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -934,11 +934,12 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	 * The domain is already in the "power off" state.
 	 * System suspend is in progress.
 	 * The domain is configured as always on.
+	 * The domain was on at boot and still need to stay on.
 	 * The domain has a subdomain being powered on.
 	 */
 	if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
 	    genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
-	    atomic_read(&genpd->sd_count) > 0)
+	    genpd->stay_on || atomic_read(&genpd->sd_count) > 0)
 		return;
 
 	/*
@@ -1349,8 +1350,12 @@ static int __init genpd_power_off_unused(void)
 	pr_info("genpd: Disabling unused power domains\n");
 	mutex_lock(&gpd_list_lock);
 
-	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		genpd_lock(genpd);
+		genpd->stay_on = false;
+		genpd_unlock(genpd);
 		genpd_queue_power_off_work(genpd);
+	}
 
 	mutex_unlock(&gpd_list_lock);
 
@@ -2375,6 +2380,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
+	genpd->stay_on = !is_off;
 	genpd->sync_state = GENPD_SYNC_STATE_OFF;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index d68e07dadc99..99556589f45e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -199,6 +199,7 @@ struct generic_pm_domain {
 	unsigned int performance_state;	/* Aggregated max performance state */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
+	bool stay_on;			/* Stay powered-on during boot. */
 	enum genpd_sync_state sync_state; /* How sync_state is managed. */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
-- 
2.43.0


