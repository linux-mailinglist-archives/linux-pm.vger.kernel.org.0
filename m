Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723985332CD
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 23:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiEXVH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 17:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiEXVH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 17:07:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D61A3DDF9
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 14:07:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u23so32900552lfc.1
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ej/Gwv3v02Sp6PnkK198msqVXVsv982Ip6jblL40BwE=;
        b=CP2oSYXgFeucZhGUHRk4LIYBHt58l7xZk3k58Q/JQSyZknd/Fkj9mArjxG5rClcwNe
         a40Ro8+mHhi/Hx4CHbLhSj7XKyUz9AxwMdUQMd/BIniaUsucX6ZQt1HQ0tOpduMYU9pq
         imjsRWrvfDKVG1WK7Qf5s0fJGGTn0V9cQTifiX5QMs7mw9Zf4RB0dh3ffqTfD2xgMpa+
         HSaGsDu13/i2VTt1Pthb+hiefF0S6fRcarjjZF/Pb37MByTT7y+JjXAGEYxdIR3cqV3l
         EeCIw4t5Dq5aHL1EEYBGzcZuUc59XRk/J79F5LIFrF1dyY01YlpxtMO/WYRbvVXeQqkm
         XZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ej/Gwv3v02Sp6PnkK198msqVXVsv982Ip6jblL40BwE=;
        b=DFA6CYoDVXQN2nuWGg1PDs/jYdZcdI2gls0uHAY1CsEtaxC/DLN/2WMs70Mz0FovNN
         VvsaHefX9+0NJ1pjnIYtfXacCoDskLnqOvBSXRtiB2Riwx0GXXEhw05t6RMpNxLBsyyw
         YSWXb3wX9Y5gYYzW5fFLmZ+ha3bjDhnBW9NUBPbCVoLaX9v7NjGRwW1LgineAXviKUWj
         uD+ffgbf/7gMtvTggUaLTn15lmOJCY9a6Hp+udH289ya9Ioamz3jKsJmUtfHl29tpYQA
         uqixHKE67lUvydgZRyftlTZucZCS+54mtxahpbZc9Mgby2UP96+erlM+VWyF0KPbNC+n
         lSDQ==
X-Gm-Message-State: AOAM533eBB5hi47f7zqE5LX6PcymG7P1gGlF4g+qTgMXDA/VBVflNyGX
        gLIpR5QW0tPCdven08C3F63WcQ==
X-Google-Smtp-Source: ABdhPJyLBgUwSuWtwEI6/05cE4G1itSeyIeU5YZXoTeeOvHi06RRa01YPLzvddfIzhDGkYTf2G4rjA==
X-Received: by 2002:a05:6512:150d:b0:477:b1f6:9ebf with SMTP id bq13-20020a056512150d00b00477b1f69ebfmr20253098lfb.422.1653426443383;
        Tue, 24 May 2022 14:07:23 -0700 (PDT)
Received: from localhost.localdomain (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id f2-20020a056512228200b0047866f9b642sm1720928lfu.224.2022.05.24.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:07:23 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH] PM: domains: Decrement subdomain counter after powering it off
Date:   Wed, 25 May 2022 00:07:21 +0300
Message-Id: <20220524210721.2072317-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Over the code a counter of powered on subdomains is incremented before
an attempt to power some subdomain on, which makes a perfect sense,
however it is asymmetric to a decrement of the counter on power off,
which is also done before powering a subdomain off.

As a result of a race over powering off domains it might happen that
a parent power domain could get misinformed about actual power states
of its subdomains, and thus a parent power domain can be powered off
in front of its children domains, while an expected result is to
bail out with a busy state.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
I found this problem while debugging simultaneous and dependant parent
and children power domain operations, a parent domain can be turned off
right before its last still enabled child. While in my particular case
it does not lead to any noticeable issues, it seems that the change is
necessary to have anyway.

Sending with RFC tag and without Fixes, I would appreciate to get
feedback, thanks.

 drivers/base/power/domain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..ee66c54d87b1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -690,10 +690,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	genpd->states[genpd->state_idx].usage++;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
-		genpd_sd_counter_dec(link->parent);
 		genpd_lock_nested(link->parent, depth + 1);
 		genpd_power_off(link->parent, false, depth + 1);
 		genpd_unlock(link->parent);
+		genpd_sd_counter_dec(link->parent);
 	}
 
 	return 0;
@@ -748,10 +748,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	list_for_each_entry_continue_reverse(link,
 					&genpd->child_links,
 					child_node) {
-		genpd_sd_counter_dec(link->parent);
 		genpd_lock_nested(link->parent, depth + 1);
 		genpd_power_off(link->parent, false, depth + 1);
 		genpd_unlock(link->parent);
+		genpd_sd_counter_dec(link->parent);
 	}
 
 	return ret;
@@ -1096,8 +1096,6 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	genpd->status = GENPD_STATE_OFF;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
-		genpd_sd_counter_dec(link->parent);
-
 		if (use_lock)
 			genpd_lock_nested(link->parent, depth + 1);
 
@@ -1105,6 +1103,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 		if (use_lock)
 			genpd_unlock(link->parent);
+
+		genpd_sd_counter_dec(link->parent);
 	}
 }
 
-- 
2.33.0

