Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3B232CCF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgG3ICF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:02:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:25948 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3ICE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596096120;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=n/qF6XkwQZ048amOMDhjZoS46CKxlEYFuVpG5WDcxyg=;
        b=LKR+bBGjh57RtT4olMQPPg8NJeLM+10MnfPU2Dz4KnRelAAZexkysltAkOUC4s5ipu
        TdVTdCOJ1bkuF7IWVcU3QyznoISLyRN7SI/GiXB3cLewAUHE5PR+mblBwHUXxy4RMqh6
        SLuasgnkvlV/5dMwsw4sOraqU6VySzs4JEppLx2TonzhE6PEnBg7A/Nb/B5IsukxDyXA
        6LzOe7Xu1VRfePjPMAbcC3OCQWon+cJ7x1OZajb5h2tKZdDc5SRYAyI9YZIDdNg4/0Mo
        YV6B/BaIW2qrCDOZp28F1TBtcKu/kaxUVMk6MIgkQQltqgk6SCGHh3MXkj2QPtIUb2uO
        LYTQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6NeHYC"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6U81xgup
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
Subject: [RFC PATCH 1/3] opp: Reduce code duplication in _set_required_opps()
Date:   Thu, 30 Jul 2020 10:01:44 +0200
Message-Id: <20200730080146.25185-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730080146.25185-1-stephan@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move call to dev_pm_genpd_set_performance_state() to a separate
function so we can avoid duplicating the code for the single and
multiple genpd case.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/opp/core.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9d7fb45b1786..f7a476b55069 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -781,6 +781,21 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	return opp_table->set_opp(data);
 }
 
+static int _set_required_opp(struct device *dev, struct device *pd_dev,
+			     struct dev_pm_opp *opp, int i)
+{
+	unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
+	int ret;
+
+	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
+	if (ret) {
+		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+			dev_name(pd_dev), pstate, ret);
+	}
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev,
 			      struct opp_table *opp_table,
@@ -788,22 +803,15 @@ static int _set_required_opps(struct device *dev,
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
 	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
-	unsigned int pstate;
+	struct device *pd_dev;
 	int i, ret = 0;
 
 	if (!required_opp_tables)
 		return 0;
 
 	/* Single genpd case */
-	if (!genpd_virt_devs) {
-		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
-		ret = dev_pm_genpd_set_performance_state(dev, pstate);
-		if (ret) {
-			dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
-				dev_name(dev), pstate, ret);
-		}
-		return ret;
-	}
+	if (!genpd_virt_devs)
+		return _set_required_opp(dev, dev, opp, 0);
 
 	/* Multiple genpd case */
 
@@ -814,17 +822,11 @@ static int _set_required_opps(struct device *dev,
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
-		pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
-
-		if (!genpd_virt_devs[i])
-			continue;
+		pd_dev = genpd_virt_devs[i];
 
-		ret = dev_pm_genpd_set_performance_state(genpd_virt_devs[i], pstate);
-		if (ret) {
-			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
-				dev_name(genpd_virt_devs[i]), pstate, ret);
+		ret = _set_required_opp(dev, pd_dev, opp, i);
+		if (ret)
 			break;
-		}
 	}
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
-- 
2.27.0

