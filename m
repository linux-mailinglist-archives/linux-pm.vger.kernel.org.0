Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695AB24B0A2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHTH5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 03:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHTH4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 03:56:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B2C061344
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so611993pjx.5
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cAYVPl8VrNuz/qq2w1qboUHzBiXW9tB7aHazhnx+PM=;
        b=djA1hgKEGskSmARq3FIBrHUsYkkRYcjjVOCAopzAHSM3DdER8yOHcbaeLUYu5OrdvX
         29WLW6jF8w82pw3sGSWKV4gumuYQhCXS4+Uo4wB648aMj1oTtl9KY8tJIO2c6MlCAz4H
         XIkYwISLFxGmNwkmqb+OiuqROpFTHyyt33+A1MmQy3ItCODZx5ppQSlVAieEW8ahhIlX
         OhsoT3yiRmkfL2VoIorrNcAF64tNwrUkhFBh3gtPNX6a1XkdAB50b0NjhU/iZryBEP+p
         QYSe8XvJkTtiE6bt5CsFiWpW3o6QXx3WpQl+Yma5Qmee4izygCJael6hkfcplCxDECYN
         moKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cAYVPl8VrNuz/qq2w1qboUHzBiXW9tB7aHazhnx+PM=;
        b=uK9rgO6Sr4YGGD1VBcsRZ4cgciVn+zMZzPiZ/0G68Yi6Jo5LuB/LY0tphyjKoGOg0U
         BaSP6Hje2GNXe9x6hwLa/+v7nhoMH840o8/Uk+Uz+C8R9V2yv7g6Naw7cO3lzgThtoLH
         Re7mnb0ba2EUDF+8gbUZ1tHXsCgivffDPxizGmg7QBudwbk0BNoXYJW593iZ9mvGMspc
         RKqSauLD0SrZEKWYra+m3Xplxqf4C+JE5s8wZ48J12Mhl583ycu+fM0nOTaTjYCdAp2O
         WUBrS6LnBZe3yz6mtdbNaN324KrykMfSOLGQj61DlTxKfT5JQe83W7JmNJwzXAupsiZA
         aCWg==
X-Gm-Message-State: AOAM530foII9JuUp+svcsnkyM3s7C/1pjBc1JZRV0kWq/YDXOTaKVrmJ
        htHM8GhD54aab330976f2qyLnw==
X-Google-Smtp-Source: ABdhPJzRSKZYVMfP9/tr8oO0UXvoRbzfFJJfmGeZ3SD9CPHnYC/ddojFEpND02X48Kp8mtP708SYyQ==
X-Received: by 2002:a17:902:be0f:: with SMTP id r15mr156256pls.84.1597910206510;
        Thu, 20 Aug 2020 00:56:46 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id v10sm21351892pjy.3.2020.08.20.00.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] opp: Reuse the enabled flag in !target_freq path
Date:   Thu, 20 Aug 2020 13:26:32 +0530
Message-Id: <9cefccfbf124c49f32c905549aad9ab284957065.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core needs to track if the resources of devices are
enabled/configured or not, as it disables the resources when target_freq
is set to 0.

Handle that with the new enabled flag and remove otherwise complex
conditional statements.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6f43ef4945b7..0b437d483b75 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -886,22 +886,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
+		ret = 0;
+
+		if (!opp_table->enabled)
+			goto put_opp_table;
+
 		/*
 		 * Some drivers need to support cases where some platforms may
 		 * have OPP table for the device, while others don't and
 		 * opp_set_rate() just needs to behave like clk_set_rate().
 		 */
-		if (!_get_opp_count(opp_table)) {
-			ret = 0;
-			goto put_opp_table;
-		}
-
-		if (!opp_table->required_opp_tables && !opp_table->regulators &&
-		    !opp_table->paths) {
-			dev_err(dev, "target frequency can't be 0\n");
-			ret = -EINVAL;
+		if (!_get_opp_count(opp_table))
 			goto put_opp_table;
-		}
 
 		ret = _set_opp_bw(opp_table, NULL, dev, true);
 		if (ret)
@@ -931,14 +927,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	old_freq = clk_get_rate(clk);
 
 	/* Return early if nothing to do */
-	if (old_freq == freq) {
-		if (!opp_table->required_opp_tables && !opp_table->regulators &&
-		    !opp_table->paths) {
-			dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
-				__func__, freq);
-			ret = 0;
-			goto put_opp_table;
-		}
+	if (opp_table->enabled && old_freq == freq) {
+		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
+			__func__, freq);
+		ret = 0;
+		goto put_opp_table;
 	}
 
 	/*
-- 
2.25.0.rc1.19.g042ed3e048af

