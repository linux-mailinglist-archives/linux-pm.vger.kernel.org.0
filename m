Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B353730D648
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhBCJ2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhBCJ0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 04:26:05 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EACC06178B
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 01:24:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w14so16279637pfi.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YBwKXZIAHM5O75qgqkZJUqkDsfjvCGWB4Ihiew6J+E=;
        b=ETNwtu1ZmDOZdrKuPYq2aSu+6XDPB8j3IGJZEojQZ9QEyMLBFOvJ8LchGtb3G/14/o
         KsdqcZ49CAKSR1t1HG6/OwyMHbIPHjIKzm/yyu/kDrjqkLNz1gxVZ7T9wpPJxkc07gGN
         34tftBwM35J4Y7cZQvDXNbqgSWAqPDcElU5JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YBwKXZIAHM5O75qgqkZJUqkDsfjvCGWB4Ihiew6J+E=;
        b=cQxbfFIvaeFMY1XlcDnYzZ0vx1Fgp69lSen0Drng8p3Of9cyw1M6u+7ZNykeOAeB6t
         +J05Xv+XkJppKosYTfGAQPMZxqGxstQ+hG+sfdTjzaTxCtCI3N/KD8oUKy3aRPOSYyCl
         QnbV/0YUo9GseRF8pHpoX0v+UaLITpi07F3tKqqbt5yAdnsapi4KH0D9ft5kPNdIcWBq
         IdscITjE5qoHkZbToE0HaznzHQ0egGdMF0k4pWiXr3NLHuGkNSj5eT+7i4E0J0JTYzPM
         M/8bc3YppAPLilCcHJpu17Ag1vhi1x9P9BIHMwul85ILu0XlpfSie4NEZRlodxgzBRtB
         l8Zg==
X-Gm-Message-State: AOAM53291j5M7pijuakMPFgMrxL1sWGntpaEFC+YqkSPbvtwR3AkahYJ
        egqGg35kB2uD5msROe3NeSaYFg==
X-Google-Smtp-Source: ABdhPJzn9NcUV4ulcmPDo2XoIO/8wiG2wV/vpqORSuLF06mHkmkpUrnO2XbJdABrNL4qEc8b2Hhvlg==
X-Received: by 2002:a63:43c6:: with SMTP id q189mr2641475pga.245.1612344252875;
        Wed, 03 Feb 2021 01:24:12 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id u20sm932294pjy.36.2021.02.03.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:24:12 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 3/3] PM / devfreq: Add required OPPs support to passive governor
Date:   Wed,  3 Feb 2021 17:24:00 +0800
Message-Id: <20210203092400.1791884-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210203092400.1791884-1-hsinyi@chromium.org>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 63332e4a65ae8..8d92b1964f9c3 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * list of parent device. Because in this case, *freq is temporary
 	 * value which is decided by ondemand governor.
 	 */
-	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
+	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
+	if (IS_ERR(p_opp)) {
+		ret = PTR_ERR(p_opp);
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	if (devfreq->opp_table && parent_devfreq->opp_table)
+		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
+						    devfreq->opp_table, p_opp);
+	if (opp) {
+		*freq = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.30.0.365.g02bc693789-goog

