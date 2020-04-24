Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1A1B7AC7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgDXPyS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgDXPyR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 11:54:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA903C09B04B
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so11456457wrb.8
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uy2oj6y3Y9ZepBtVyGrxPJdvFRnE5kSrp0uZgALPNV4=;
        b=OxdX5jgd7SKKPIuY8VGckbJqb2B+N7u09WuNXoGJYbUWG2JB6mNN7dTTc33qF1v3/G
         Z2Y5KWSzxrN9tXX01IQLbyLm590DCvGUp6XMB038RrbEoQGi14QRE+DUxRgK22QRgVas
         XVMrmbZ7i6GZdjziEgZicw3ry83Y6NbQYNuRZAT3UrKE00ucz2r9zgfuWonfaojiPmgb
         rwbqPOOHF8bc+5juHlqsfNuW5R8w5HTUYJVBNqSXZQhM/6RzrkCJZ5LJ3uJRU9LXonPY
         /FuMz5u3+Rw2nKiWH+YdBfi9Ce8PZ51nGaZFRu3dgHJ+oe4bvLn5X7M4DQ9C6UJEvgvA
         p0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uy2oj6y3Y9ZepBtVyGrxPJdvFRnE5kSrp0uZgALPNV4=;
        b=VQWvd/oXdmmfZV95sTAH8fSnx1jjrQPCs/wzfffU38NMtHVwwU9uvnq0B2YgjGT3Kt
         apCGhAY8iy1nhMAwYmuO/0hxTXQ1XXwXJSYx6XhybgZAQfomfDn99agMJ92GqVQEFpiR
         nMSiPD9iV2buQyY/NpRcK6lZyvEACCMzmVPzTLKYU35POKYFgRNFxkfW/LupQMAwoCos
         xPfzzWY0KjofzgfI/3eB6k9SQqDJuOQhD2pVglR1jVlcjYxWAeRYPPaZjxzCAkiSSJY8
         zowEXDaEuEPjB9+MMK7YM43tHrE9tj9IH7LzBv4SvGCH1w2v9jmiRQWk3y4QECYIi77S
         ui5w==
X-Gm-Message-State: AGi0PuauKjOr2lLpGNczWndCAk5bWKO762xdeGTRW5aYgXzlVMTEFnAz
        Pzqs7HxZRhvLe+otmp39HXK5vg==
X-Google-Smtp-Source: APiQypJl0lxvUl8otBjfnNrZBi1i0wPxRdrGv+bf5EqXyr8Qz9S3Ed482nW4gdF1iumrebChk3/iwg==
X-Received: by 2002:adf:f986:: with SMTP id f6mr11676191wrr.221.1587743655453;
        Fri, 24 Apr 2020 08:54:15 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id z76sm3923583wmc.9.2020.04.24.08.54.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:54:14 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
Date:   Fri, 24 Apr 2020 18:54:03 +0300
Message-Id: <20200424155404.10746-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200424155404.10746-1-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the OPP bandwidth values are populated, we want to switch also the
interconnect bandwidth in addition to frequency and voltage.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v7:
* Addressed review comments from Viresh.

v2: https://lore.kernel.org/r/20190423132823.7915-5-georgi.djakov@linaro.org

 drivers/opp/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8e86811eb7b2..66a8ea10f3de 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -808,7 +808,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	unsigned long freq, old_freq, temp_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
-	int ret;
+	int ret, i;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -895,6 +895,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
+	if (!ret && opp_table->paths) {
+		for (i = 0; i < opp_table->path_count; i++) {
+			ret = icc_set_bw(opp_table->paths[i],
+					 opp->bandwidth[i].avg,
+					 opp->bandwidth[i].peak);
+			if (ret)
+				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
+					i, ret);
+		}
+	}
+
 put_opp:
 	dev_pm_opp_put(opp);
 put_old_opp:
