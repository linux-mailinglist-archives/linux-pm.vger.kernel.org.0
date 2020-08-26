Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5C252D08
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgHZLyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 07:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgHZLur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 07:50:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091CDC061797
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:50:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p11so838480pfn.11
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tryfDmsq8J+S8CIysHu14Sy9xIe8k9L5z/SAmRPWEvQ=;
        b=K9S6Gl/yPJf+4iRIOJURLX0jZIfzzKuoLqIWdhAwGNvRwUtT7rlO+a91+tpquF6m63
         TqKnKg0EmKJmU1iAU7ZRvzgTJhWy5MlAsKJ727GsNY7I3yeh4calb536VT5LQUKuKsME
         LJJerq2jwlelEqub3qvFIjfL7M8AcQEzhnOO0AwvM544Bqgbb3NVL9X3X0UWBJFGalye
         BGqrpBUU8y4ua1rv9gYqbfNfuXkc7qKOQol/C1JpQl02XwFgq6XBF52SrkhA8aHoi4Yv
         iTUGdM5pYqeVBft3p0T+exfAUm5tzMi0oDDaH+NWRLAdUTcUYp4O8ycUnR62H6rUFx0r
         +kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tryfDmsq8J+S8CIysHu14Sy9xIe8k9L5z/SAmRPWEvQ=;
        b=DbVETxLz0SY5QMOj1UxYDtGVslWCYZ3/aba9vyG2MMpKl5XbsQ0DnTG3ld1BYrNUq9
         z6BYyoME9icFG9QVeIWHsGXgltnwUp1Qx5CsMmlQgdFsTpP7sJqTwH2A3GEsT5W/pBHI
         ymHebpkzyX7UZSifzrpVVidWh4N4fLj+R1ncmti529nVKYJPbNHs/vU4pqRGrQAcp8uG
         7v/DaIB0HfPxOwk0BQdNp1C22HMkP7pMA4GHJQfihvQ19lvPZzgEIGIp3UZMvvTNyZu0
         3qPZlP6vpDqYxLrLv//f7RjY9C+wOtBF+pRR1FmYpmjfalzNLTIMhUadzYOVYiaSZ1wO
         t8kw==
X-Gm-Message-State: AOAM532wW3eV9EVkf2CE35xDU/VhuGvNdm23DbrzGhE5bFoxALoAOC2p
        ONQnTuZuAHSibvWWKVqFpn8l1w==
X-Google-Smtp-Source: ABdhPJztcwN8EHa6UOwG0fvOLxS69d/buMurM5WYvvacPyKM+b6A2zg2wIyMpy1yWByrjeHDs6epGA==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr9999244pgp.341.1598442646550;
        Wed, 26 Aug 2020 04:50:46 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id c8sm2632593pfc.203.2020.08.26.04.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:50:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] opp: Allow opp-supported-hw to contain multiple versions
Date:   Wed, 26 Aug 2020 17:20:29 +0530
Message-Id: <c4d59ad206394e4f73ab7547c6cd99d95c032128.1598442485.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598442485.git.viresh.kumar@linaro.org>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bindings allow multiple versions to be passed to "opp-supported-hw"
property, either of which can result in enabling of the OPP.

Update code to allow that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e39ddcc779af..5dac8bffd68c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -434,9 +434,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_icc_paths);
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
-	unsigned int count = opp_table->supported_hw_count;
-	u32 version;
-	int ret;
+	unsigned int levels = opp_table->supported_hw_count;
+	int count, versions, ret, i, j;
+	u32 val;
 
 	if (!opp_table->supported_hw) {
 		/*
@@ -451,21 +451,40 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			return true;
 	}
 
-	while (count--) {
-		ret = of_property_read_u32_index(np, "opp-supported-hw", count,
-						 &version);
-		if (ret) {
-			dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
-				 __func__, count, ret);
-			return false;
+	count = of_property_count_u32_elems(np, "opp-supported-hw");
+	if (count <= 0 || count % levels) {
+		dev_err(dev, "%s: Invalid opp-supported-hw property (%d)\n",
+			__func__, count);
+		return false;
+	}
+
+	versions = count / levels;
+
+	/* All levels in at least one of the versions should match */
+	for (i = 0; i < versions; i++) {
+		bool supported = true;
+
+		for (j = 0; j < levels; j++) {
+			ret = of_property_read_u32_index(np, "opp-supported-hw",
+							 i * levels + j, &val);
+			if (ret) {
+				dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
+					 __func__, i * levels + j, ret);
+				return false;
+			}
+
+			/* Check if the level is supported */
+			if (!(val & opp_table->supported_hw[j])) {
+				supported = false;
+				break;
+			}
 		}
 
-		/* Both of these are bitwise masks of the versions */
-		if (!(version & opp_table->supported_hw[count]))
-			return false;
+		if (supported)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
-- 
2.25.0.rc1.19.g042ed3e048af

