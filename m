Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D45A2A2B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbiHZO5n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiHZO5k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 10:57:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA66A5726
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 07:57:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f12so1620036plb.11
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=49FbH9fhwp8y/uszTeozlNisIKriGJI0rkU4Q43uXpk=;
        b=lc87Iq6suxcr08Rewus/FQpCAwb7n6XxXBZs7iuUofU3aOT0hivPtFRxbQ1No/xGTe
         sJJMfxEhRo/8act27XOdB3lrqDmnmtB8916iQFEW4I1SVa+N4kTFLOAw84KFj91obeMP
         8zQl5TNsA3uvR/xK7tJg1VWfg9vnO2Ie1weEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=49FbH9fhwp8y/uszTeozlNisIKriGJI0rkU4Q43uXpk=;
        b=V+wc8uvEB4o+GaK2JFA5Chy9EcvUzc9kbuH+qRp4T9lDpxM5jpG6BHtKyxI+KPkLrZ
         u7KE/2Zj2Oht5RnwpyemsvHviKsV30aXBwb2XIhlbi8/f5RIxAXebstIB2HqUDFs0EWC
         VFie/uSbdwNRYOUJRqoSBqal91RZrDc/p53SrRRVkKqyQTDoYuFUgr98yoDrKTocta4j
         SeE9kOKoC6iCkVma7l4HJIAX8Loce2BOWEssPysZW1xqhZXwC3G3ak7luD2uINyPSNdK
         jdQZleXydyW0hifBdKpOmLIvRqQ7ymMMQYqS2uwg/e2zWX6stUkSSQvgOJSPrH1TOKir
         gHGw==
X-Gm-Message-State: ACgBeo350sxAv5t3xh6WyqGBLn9BdzlGwNXnHoSHEIoI3acakIRs59xJ
        +G2JwIJRUXvxg3psMo1Wpt329Q==
X-Google-Smtp-Source: AA6agR7/oFcLGBxOHbL2cxiQkAY9FoRDjgfEWFuS13wB9RAwOs3kWQfgwlgEmwiJ6ARdcOIc2/wWhA==
X-Received: by 2002:a17:90a:55:b0:1f7:4513:8cac with SMTP id 21-20020a17090a005500b001f745138cacmr4626092pjb.93.1661525857343;
        Fri, 26 Aug 2022 07:57:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:7487:fdf0:5cfa:b7ab])
        by smtp.gmail.com with ESMTPSA id w61-20020a17090a6bc300b001facb7bc1adsm1768424pjj.26.2022.08.26.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 07:57:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] opp: Expose voltage info in debugfs for OPPs w/out explicit regulators
Date:   Fri, 26 Aug 2022 07:56:59 -0700
Message-Id: <20220826075655.1.I2e4958048f30c3b44a01e31519092f7d3c9204e4@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On some cpufreq drivers we know the voltage associated with each
operating point but there is no explicit Linux "regulator" present. An
example is "qcom-cpufreq-hw.c". There the voltage is managed
automatically by the hardware but we still associate it with the OPP
table so we can do energy calculations for EAS.

The OPP framework handles this in general. In _opp_allocate() it can
be seen that we always allocate space for one supply even if
"regulator_count" is 0.

Let's handle this properly in debugfs.

NOTE: as a side effect of this a whole bunch of OPPs in the system may
get supply-related files exposed in debugfs that are mostly useless
(they'll just contain 0). I'd expect this to be OK but it's moderately
annoying. It seems better than trying to dynamically create debugfs
directories when the voltages are non-zero or adding extra complexity
in the code giving a hint to the OPP framework that voltages should be
exposed.

After this patch, on a sc7180-trogdor class device I can see voltages
for the CPU OPPs under /sys/kernel/debug/opp.

Fixes: dfbe4678d709 ("PM / OPP: Add infrastructure to manage multiple regulators")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/opp/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 96a30a032c5f..65234da41063 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -96,10 +96,11 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct opp_table *opp_table,
 				      struct dentry *pdentry)
 {
+	int supply_count = max(opp_table->regulator_count, 1);
 	struct dentry *d;
 	int i;
 
-	for (i = 0; i < opp_table->regulator_count; i++) {
+	for (i = 0; i < supply_count; i++) {
 		char name[15];
 
 		snprintf(name, sizeof(name), "supply-%d", i);
-- 
2.37.2.672.g94769d06f0-goog

