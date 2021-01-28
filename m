Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823FB307369
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 11:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhA1KHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 05:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhA1KH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 05:07:28 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22926C061573
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:06:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d13so3063970plg.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBZWaj2uywenUIUOK44qGD3Loy0e9/b1fubB3+jzn28=;
        b=m0qYlXosbEbrq5WcpnKWh2pXCVvx8OVVvmTthseHiHFztbqft21EEAdg/9qbaHOH9e
         2mkdmX8aSGd5a6SBHxsBU9mmCzT5AIKDgetRlPrFr22KOzwbBx2nCAIAON4xgjMu4n45
         nWG+Df7eoqxeyVA2UoH2omw6iMnxmx+9+VAJ7yYE5lo6j2Ri4cYMmTNqJNuqP9ohpXe7
         BoZhq+vP2Ha4qFO93BujdslZTaJr7soJW9R+Vs5OWV6+e4HcVUHlNCEgLHIip28A+6WK
         AedM7Qt86orOYOybD42Pwc4nC+NrrLzRtOCqDZvob7Uc7mFJI0IJeY1AVhlLNZkwUiW8
         m5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBZWaj2uywenUIUOK44qGD3Loy0e9/b1fubB3+jzn28=;
        b=cK/qOKNB16ivQvX3CE5+H2IDMXohGMCEpvPSmi6NB7MjW/bJSgut0SDZWb3namIZQw
         TXU1rG+4sCxC+Cks9S7a3SMYRwxOjnnuhKXMQ4iM96vri1/RWsVFDof4Qmi2Pufc1jn+
         oYvain2TNKJwt44oTcjv2waYaOUYyigz/IAhiUbb9fQ74OvmcgIGmdTLI3faH0ravlKk
         F0AAxhnWt686NU7pFTbv84G/vi0Q2adrSi2jaX7QSAE9WPvEmEoQ2cz48895GlWldvUc
         UPCyc7x/Z4JHzTYGSDvaies/27NtBTpyqxsTP11nhyev6KkET1RrnhlS9fbPALOa8h6n
         hesg==
X-Gm-Message-State: AOAM531Gb3G0gkHXzsEcIex1sQmIM0MGv9T8L0pIqWkRWr5qwC5joWXA
        GJcDiEUAvV4K4hGxGGyEuj4Hlh+aqqbXOA==
X-Google-Smtp-Source: ABdhPJxBDwVqMF7IIVucDTTS2NMNCchkkEh8PfPH1VqrxqgMI+pMf4U1EM1p2MEjrGuAJQf73xQCAA==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr10051363pjb.63.1611828407605;
        Thu, 28 Jan 2021 02:06:47 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q22sm5535066pgi.66.2021.01.28.02.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 02:06:46 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Update bandwidth requirements based on scaling up/down
Date:   Thu, 28 Jan 2021 15:36:39 +0530
Message-Id: <8b523d9f7f0a00f4353cb2f0d6c8c3ab2b7c9324.1611828360.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bandwidth must be scaled at a different point in the code flow based
on if we are scaling up or down the frequency, otherwise this may cause
undesired effects as the device will try to use more of the memory
bandwidth which may be shared across several devices. Much like how
regulators and required-opps are programmed.

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Reported-by: Akhil P Oommen <akhilpo@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e03600547b98..a518173fd64a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1015,8 +1015,16 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 	/* Scaling up? Configure required OPPs before frequency */
 	if (!scaling_down) {
 		ret = _set_required_opps(dev, opp_table, opp, true);
-		if (ret)
+		if (ret) {
+			dev_err(dev, "Failed to set required opps: %d\n", ret);
+			return ret;
+		}
+
+		ret = _set_opp_bw(opp_table, opp, dev);
+		if (ret) {
+			dev_err(dev, "Failed to set bw: %d\n", ret);
 			return ret;
+		}
 	}
 
 	if (opp_table->set_opp) {
@@ -1029,24 +1037,30 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
 	}
 
+	if (ret)
+		return ret;
+
 	/* Scaling down? Configure required OPPs after frequency */
-	if (!ret && scaling_down) {
+	if (scaling_down) {
+		ret = _set_opp_bw(opp_table, opp, dev);
+		if (ret) {
+			dev_err(dev, "Failed to set bw: %d\n", ret);
+			return ret;
+		}
+
 		ret = _set_required_opps(dev, opp_table, opp, false);
-		if (ret)
+		if (ret) {
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
+			return ret;
+		}
 	}
 
-	if (!ret) {
-		ret = _set_opp_bw(opp_table, opp, dev);
-		if (!ret) {
-			opp_table->enabled = true;
-			dev_pm_opp_put(old_opp);
+	opp_table->enabled = true;
+	dev_pm_opp_put(old_opp);
 
-			/* Make sure current_opp doesn't get freed */
-			dev_pm_opp_get(opp);
-			opp_table->current_opp = opp;
-		}
-	}
+	/* Make sure current_opp doesn't get freed */
+	dev_pm_opp_get(opp);
+	opp_table->current_opp = opp;
 
 	return ret;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

