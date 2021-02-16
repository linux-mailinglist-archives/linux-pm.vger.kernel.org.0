Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7D31D164
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 21:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhBPUML (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 15:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBPUML (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 15:12:11 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE06C06174A
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 12:11:30 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c25so5250038qvb.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESU2v6PnWuuqrc3aBtGPRviCIYxee3TEkKh6dRFK5uo=;
        b=Gb3bXHKRAg/D7IARf3bWgbaQnVZPbDzZXMaW8ftiH2UDhv1Dze7XbrejZTpAghSOJQ
         eyJwEDlW3onw3k29tSH3mp7Ab2RBOAVYpkhTeomnvz0+WRqmFiEa5Uf0WP9eVB2v3eFB
         P3u29V2HepHJuKqgSy4HGcf1kukKcKKI/xlR/iebsRLPSajCIHprbjaNCv1U4uiep05H
         sk2rs4bfStcQI7IsirbvbBxXst6SYAMgjx1T7nkNS3mV41BBC0IKs6E6iPIulBL6GHKE
         iCEFPAilq4jv9bbsQ4ncj0asisko/+/Hnmc0C7OmIEv2drTF3exVkTNjX+LkxJBONs80
         42aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESU2v6PnWuuqrc3aBtGPRviCIYxee3TEkKh6dRFK5uo=;
        b=a5lgF3n6eKC+McyXaxNbDQQpNmkSRlVWkjWhbUPsVdLpcnvCU0MRNywE/Zx3iRFRbO
         21beSgXyB+U6BEr0dd8GeX3ZDGqae+RlKFVKhbudGl/wyzI7jAopb7eLZpjHOppLLhRE
         uzZnf1ygx2M6uDF9B+mdKoRM8lAoLwdgH0fPxc763G3hWEWp2R60HoLFhg7+fHGBZXnQ
         H1OT/1NL/U/f13W8cP6UWHPJtsvyqOIn/zRODVxJBTIVd6SjfnKAEtT2l5omujgteqeS
         qEYfYM7kS456k7egCyheFzZiJ800u8jCkF0uuSdDIZCCUIaKaXoDqAT7Lk1Gx+E2OgO+
         kC0g==
X-Gm-Message-State: AOAM531RYP00AYQzb2Spq1oO2qcYL6+I57fIss9vGH6AUt4XZTwALKMV
        pt7l4sJqFUcvtYkHPmugl/a3wA==
X-Google-Smtp-Source: ABdhPJzqz6Fnqc3dQq6MdJJTrMD4jpD2ItrVRYu0DaxtvxmCIOqvdeZ2BWlz+1iyg+y1MS2V463oRQ==
X-Received: by 2002:a05:6214:16cf:: with SMTP id d15mr21451336qvz.32.1613506289989;
        Tue, 16 Feb 2021 12:11:29 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id t6sm13790761qti.2.2021.02.16.12.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:11:29 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org (open list:OPERATING PERFORMANCE POINTS (OPP)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] opp: fix dev_pm_opp_set_rate for different frequency at the same opp level
Date:   Tue, 16 Feb 2021 15:10:29 -0500
Message-Id: <20210216201030.19152-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is not "nothing to do" when the opp is the same. The frequency can
be different from opp->rate.

Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/opp/core.c | 7 +++++--
 drivers/opp/opp.h  | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c3f3d9249cc5..f82cf72f433e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -986,6 +986,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		    struct dev_pm_opp *opp, unsigned long freq)
 {
 	struct dev_pm_opp *old_opp;
+	unsigned long old_freq;
 	int scaling_down, ret;
 
 	if (unlikely(!opp))
@@ -996,15 +997,16 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		_find_current_opp(dev, opp_table);
 
 	old_opp = opp_table->current_opp;
+	old_freq = opp_table->current_freq;
 
 	/* Return early if nothing to do */
-	if (opp_table->enabled && old_opp == opp) {
+	if (opp_table->enabled && old_opp == opp && old_freq == freq) {
 		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
 		return 0;
 	}
 
 	dev_dbg(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",
-		__func__, old_opp->rate, freq, old_opp->level, opp->level,
+		__func__, old_freq, freq, old_opp->level, opp->level,
 		old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
 		opp->bandwidth ? opp->bandwidth[0].peak : 0);
 
@@ -1061,6 +1063,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	/* Make sure current_opp doesn't get freed */
 	dev_pm_opp_get(opp);
 	opp_table->current_opp = opp;
+	opp_table->current_freq = freq;
 
 	return ret;
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9b9daf83b074..9f1d9c877380 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -186,6 +186,7 @@ struct opp_table {
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
+	unsigned long current_freq;
 
 	struct mutex genpd_virt_dev_lock;
 	struct device **genpd_virt_devs;
-- 
2.26.1

