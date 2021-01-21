Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE12FE96F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbhAUL5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbhAULUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:20:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECFDC061796
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 31so1087606plb.10
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3q4F6fqDBoI1WPbxX2i+8B6qqJAH4SxSEXz0WavjCuM=;
        b=KPZnAalZ+8zh6lvLMEBZSaMYyoeR8ZqD+umfJrUDLFjwJNX85Vj//MjvUfsCfe4VG6
         zKZO18Ju7We5Q6IR7a/brqg4Yzjak5tSdoj+mMXoDEVoXWX08XLn+sjhivh9BE3dRwSX
         QXCJqmndJOHaPcru83M8zwkDEUVdie1rf6cTkwbUa78Mgj/6MxJ2LSWxrWdqSYThvKOq
         r17YUw9fmG7ac37k3QCpx4YN2oOBIfW0hoD3VuDM1g9/1ugSVV76bn6Ob28gVnq8QBZy
         /+UdVCvOpk7f/0TsQnrR49jopuOeRInCBYSPualUNh3IcWLrI+PCvaztx4uXMBcNPCir
         Zf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3q4F6fqDBoI1WPbxX2i+8B6qqJAH4SxSEXz0WavjCuM=;
        b=AYt45uzkvGdiZbZgGnNp6dXFNYzzPcsaxuvkgB7tbhxQ2EBsauKFwUbmA2p16DT9sV
         IyWo3L/mhO2q6ouRPBMaHETUdESt6Gfo5KD52hD73tL0E9VR6xa6iepgqmgpEWA2w7dI
         GJmVF48OHl+2T+mAYpKflbpgnYGL2YIC6fabEx7Mmc/PFtpKnmQ5SWeO/ldC9qWhB5m5
         vZ/8JCfmhzgKSpS8LcR2gOJ5Q90rF7AFadRvRTyEMSwlQ0V0fv8pZTbPlhuDU6ADWHCL
         L73VXf/SmGLGvH8vko0KRyjgWGyKXt8bJOVuS9MafVgrQmb445T8mPttesTkFuU0DQy6
         no0A==
X-Gm-Message-State: AOAM532WLY6GYU/yUOaNIM5xUrv7XNCrAgeqHXbkqrGr9gkjdqcGUACu
        LVI9ltVuhNSOGe726YQJeOfgnA==
X-Google-Smtp-Source: ABdhPJz22P2tWFOkcUwHY7BKv4TTjLUXRNax4HNk+svmsc6qCNBAsLI0X0TzxbDx9sH5y/pVn2KIZg==
X-Received: by 2002:a17:90a:ea02:: with SMTP id w2mr11249229pjy.228.1611227937583;
        Thu, 21 Jan 2021 03:18:57 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id c5sm5779986pjo.4.2021.01.21.03.18.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:18:57 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/13] opp: Allow _set_opp() to work for non-freq devices
Date:   Thu, 21 Jan 2021 16:47:45 +0530
Message-Id: <2f0956ab1ed075bc8551f68921791ecbc6032f83.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The _set_opp() helper will be used for devices which don't change frequency
(like power domains, etc.) later on, prepare for that by not relying on
frequency for making decisions here.

While at it, also update the debug print to contain all relevant
information.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5313dc322bdd..64424dbd23c1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -997,7 +997,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 {
 	struct dev_pm_opp *old_opp;
 	unsigned long old_freq;
-	int ret;
+	int scaling_down, ret;
 
 	if (unlikely(!opp))
 		return _disable_opp_table(dev, opp_table);
@@ -1015,11 +1015,17 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		return 0;
 	}
 
-	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
-		old_freq, freq);
+	dev_dbg(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",
+		__func__, old_freq, freq, old_opp->level, opp->level,
+		old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
+		opp->bandwidth ? opp->bandwidth[0].peak : 0);
+
+	scaling_down = _opp_compare_key(old_opp, opp);
+	if (scaling_down == -1)
+		scaling_down = 0;
 
 	/* Scaling up? Configure required OPPs before frequency */
-	if (freq >= old_freq) {
+	if (!scaling_down) {
 		ret = _set_required_opps(dev, opp_table, opp, true);
 		if (ret)
 			return ret;
@@ -1038,7 +1044,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	}
 
 	/* Scaling down? Configure required OPPs after frequency */
-	if (!ret && freq < old_freq) {
+	if (!ret && scaling_down) {
 		ret = _set_required_opps(dev, opp_table, opp, false);
 		if (ret)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
-- 
2.25.0.rc1.19.g042ed3e048af

