Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F19362A40B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Nov 2022 22:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiKOV0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Nov 2022 16:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiKOVZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2022 16:25:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A5A1BE
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 13:25:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l14so26576722wrw.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+RQYtZdy4bFUQhGXuI62wI3n3sEiXL3rrLvArp8C0KQ=;
        b=sEuBdlDm+Fd/WLiW0/FG+MxIwi5frs55d4RDhx5o/mCxy6wfIG51/944gZCkDVqndN
         udhKfEzWcdQuVodXWzp48g2ABToxWqwnzf9APbjlvKiM81u8WcD7OxNeiY9g7pb71paF
         ZmVS/FV7iu2WF4ccHx9+lpnx1caDtd2i4GO9EwlHqzRZmkIV8MafYjvcB+enC8KTM8zl
         XYzyP9RNZbTaI9WmwAUZ/Om1GQJE2JSmppCbBwoOpDBMmya6Hzzxl8uWjDvJuqBpwRUu
         x/H7b0zbCqpjyUTUd6uhwBY99CL0sdy+oIKU58KkVdqGxjNEif/eyVDOctl8z7ycbrvQ
         wmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RQYtZdy4bFUQhGXuI62wI3n3sEiXL3rrLvArp8C0KQ=;
        b=7wEpkoJ/aQQKJF8jbs4zFWcOQadRP35AJkSX2ZBXlMONlGaQ/6CwRDDb20leNrIooT
         IOksj58xyGnZWdeIKKgFzJGR+6UrBluAO9CNEjCEUAyrnlYbK2GxG/mfJshPAwnYNuhF
         UhevvVU4rMygFbDrxc5cvfcKlkPromDZJ6ArlrJnsRwlGtnslcjxIBew4TzPqmbpuulS
         0oBg8kJHvg/AR8dC543Gkbk98yPJ7loRa8ae1T//8Viw4h52TIhAiyXK8SIUwiW19QCg
         Tocvunm5UW+Lez8OD2txIGgHI4IqzzeYgZJhgB7zeBJuywef28LjGPCia3iXAHmuaHyF
         EtaQ==
X-Gm-Message-State: ANoB5pkCof9sBJiNqfqnmyN9Pu+8mpKcJ7v5QrRaiDf1vRVnzXhl3lWN
        S1jZfgBbl7P2yJnyOAVk+tt7dA==
X-Google-Smtp-Source: AA0mqf4Z5kW/mmVJi82pAXIix3yGil/wtSk+5owjAXaWwkoPht0cu1OaAnDVhSOBeccoo+RTjQa5Kg==
X-Received: by 2002:adf:fcce:0:b0:236:6ab6:a51c with SMTP id f14-20020adffcce000000b002366ab6a51cmr12438387wrs.54.1668547551445;
        Tue, 15 Nov 2022 13:25:51 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x4-20020a1c7c04000000b003cf7055c014sm25406wmc.1.2022.11.15.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:25:51 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] PM: domains: Reverse the order of performance and enabling ops
Date:   Tue, 15 Nov 2022 23:25:43 +0200
Message-Id: <20221115212543.1745498-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ->set_performance_state() needs to be called before ->power_on()
when a genpd is powered on, and after ->power_off() when a genpd is
powered off. Do this in order to let the provider know to which
performance state to power on the genpd, on the power on sequence, and
also to maintain the performance for that genpd until after powering off,
on power off sequence.

There is no scenario where a consumer would need its genpd enabled and
then its performance state increased. Instead, in every scenario, the
consumer needs the genpd to be enabled from the start at a specific
performance state.

And same logic applies to the powering down. No consumer would need its
genpd performance state dropped right before powering down.

Now, there are currently two vendors which use ->set_performance_state()
in their genpd providers. One of them is Tegra, but the only genpd provider
(PMC) that makes use of ->set_performance_state() doesn't implement the
->power_on() or ->power_off(), and so it will not be affected by the ops
reversal.

The other vendor that uses it is Qualcomm, in multiple genpd providers
actually (RPM, RPMh and CPR). But all Qualcomm genpd providers that make
use of ->set_performance_state() need the order between enabling ops and
the performance setting op to be reversed. And the reason for that is that
it currently translates into two different voltages in order to power on
a genpd to a specific performance state. Basically, ->power_on() switches
to the minimum (enabling) voltage for that genpd, and then
->set_performance_state() sets it to the voltage level required by the
consumer.

By reversing the call order, we rely on the provider to know what to do
on each call, but most popular usecase is to cache the performance state
and postpone the voltage setting until the ->power_on() gets called.

As for the reason of still needing the ->power_on() and ->power_off() for a
provider which could get away with just having ->set_performance_state()
implemented, there are consumers that do not (nor should) provide an
opp-table. For those consumers, ->set_performance_state() will not be
called, and so they will enable the genpd to its minimum performance state
by a ->power_on() call. Same logic goes for the disabling.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 - Added performance state drop on power on failure, like Ulf suggested

 drivers/base/power/domain.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e5f4e5a2eb9e..967bcf9d415e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -964,8 +964,8 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
+	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -1003,9 +1003,8 @@ static int genpd_runtime_resume(struct device *dev)
 		goto out;
 
 	genpd_lock(genpd);
+	genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	ret = genpd_power_on(genpd, 0);
-	if (!ret)
-		genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	genpd_unlock(genpd);
 
 	if (ret)
@@ -1043,8 +1042,8 @@ static int genpd_runtime_resume(struct device *dev)
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
 		genpd_lock(genpd);
-		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_power_off(genpd, true, 0);
+		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_unlock(genpd);
 	}
 
@@ -2733,17 +2732,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
-	if (power_on) {
-		genpd_lock(pd);
-		ret = genpd_power_on(pd, 0);
-		genpd_unlock(pd);
-	}
-
-	if (ret) {
-		genpd_remove_device(pd, dev);
-		return -EPROBE_DEFER;
-	}
-
 	/* Set the default performance state */
 	pstate = of_get_required_opp_performance_state(dev->of_node, index);
 	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
@@ -2755,6 +2743,24 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			goto err;
 		dev_gpd_data(dev)->default_pstate = pstate;
 	}
+
+	if (power_on) {
+		genpd_lock(pd);
+		ret = genpd_power_on(pd, 0);
+		genpd_unlock(pd);
+	}
+
+	if (ret) {
+		/* Drop the default performance state */
+		if (dev_gpd_data(dev)->default_pstate) {
+			dev_pm_genpd_set_performance_state(dev, 0);
+			dev_gpd_data(dev)->default_pstate = 0;
+		}
+
+		genpd_remove_device(pd, dev);
+		return -EPROBE_DEFER;
+	}
+
 	return 1;
 
 err:
-- 
2.34.1

