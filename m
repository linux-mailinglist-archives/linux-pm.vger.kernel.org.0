Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7D232CD0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgG3ICI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:02:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:31352 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgG3ICF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 04:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596096121;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=HaJwBOdIkjvs8im4/IU2I0knSpAyk7I2vquFxeVH9ME=;
        b=tPj+che6PdMsJZIu4uEyy4FRuJ6xYfsz/4Yk62XyHhquRNQBi0twzgD8LZYK/+gKRL
        gEXRtJucChVLPL9Ibjmb1WYMp03P5lIp0Ua8VcDm9cnZM4vByEHqyilghG5hSIGlebM4
        F/ojWJDAcxtH+PzrAtOzK89KHg0SYTK4G6iBLQ3IwnaSicrevGjGyPKbtVeX83nqWQMc
        aHEG3HSJZMvnG5pJNfEMsc5Vm6/5Zr+ndMzSGPmhwQdNc3EMhdmEt0VMOAUXXuwlg+4E
        n/j6mNHPrkGZ6emI6Crhl8SL9Da5MiqsgWXcRoXbqAU4K8WFOY4YqKhgvUgh5oYXd+IG
        zLDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6NeHYC"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6U81xgut
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jul 2020 10:01:59 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [RFC PATCH 2/3] opp: Set required OPPs in reverse order when scaling down
Date:   Thu, 30 Jul 2020 10:01:45 +0200
Message-Id: <20200730080146.25185-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730080146.25185-1-stephan@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core already has well-defined semantics to ensure required
OPPs/regulators are set before/after the frequency change, depending
on if we scale up or down.

Similar requirements might exist for the order of required OPPs
when multiple power domains need to be scaled for a frequency change.

For example, on Qualcomm platforms using CPR (Core Power Reduction),
we need to scale the VDDMX and CPR power domain. When scaling up,
MX should be scaled up before CPR. When scaling down, CPR should be
scaled down before MX.

In general, if there are multiple "required-opps" in the device tree
I would expect that the order is either irrelevant, or there is some
dependency between the power domains. In that case, the power domains
should be scaled down in reverse order.

This commit updates _set_required_opps() to set required OPPs in
reverse order when scaling down.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Related discussion: https://lore.kernel.org/linux-arm-msm/20200525194443.GA11851@flawful.org/

The advantage of this approach is that the CPR driver does not need
to bother with the VDDMX power domain at all - the requirements
can be fully described within the device tree, see e.g. [1].
An alternative option would be to modify the CPR driver to make these votes.

[1]: https://lore.kernel.org/linux-arm-msm/20200507104603.GA581328@gerhold.net/2-msm8916-vdd-mx.patch
---
 drivers/opp/core.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f7a476b55069..f93f551c911e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -799,7 +799,7 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev,
 			      struct opp_table *opp_table,
-			      struct dev_pm_opp *opp)
+			      struct dev_pm_opp *opp, bool up)
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
 	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
@@ -821,12 +821,24 @@ static int _set_required_opps(struct device *dev,
 	 */
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
-	for (i = 0; i < opp_table->required_opp_count; i++) {
-		pd_dev = genpd_virt_devs[i];
+	if (up) {
+		/* Scaling up? Set required OPPs in normal order */
+		for (i = 0; i < opp_table->required_opp_count; i++) {
+			pd_dev = genpd_virt_devs[i];
 
-		ret = _set_required_opp(dev, pd_dev, opp, i);
-		if (ret)
-			break;
+			ret = _set_required_opp(dev, pd_dev, opp, i);
+			if (ret)
+				break;
+		}
+	} else {
+		/* Scaling down? Set required OPPs in reverse order */
+		for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
+			pd_dev = genpd_virt_devs[i];
+
+			ret = _set_required_opp(dev, pd_dev, opp, i);
+			if (ret)
+				break;
+		}
 	}
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
@@ -914,7 +926,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			opp_table->regulator_enabled = false;
 		}
 
-		ret = _set_required_opps(dev, opp_table, NULL);
+		ret = _set_required_opps(dev, opp_table, NULL, false);
 		goto put_opp_table;
 	}
 
@@ -973,7 +985,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Scaling up? Configure required OPPs before frequency */
 	if (freq >= old_freq) {
-		ret = _set_required_opps(dev, opp_table, opp);
+		ret = _set_required_opps(dev, opp_table, opp, true);
 		if (ret)
 			goto put_opp;
 	}
@@ -993,7 +1005,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Scaling down? Configure required OPPs after frequency */
 	if (!ret && freq < old_freq) {
-		ret = _set_required_opps(dev, opp_table, opp);
+		ret = _set_required_opps(dev, opp_table, opp, false);
 		if (ret)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
-- 
2.27.0

