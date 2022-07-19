Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73457928B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 07:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiGSFje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 01:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiGSFjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 01:39:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CCA24F05
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 22:39:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso419460pjq.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4mj/y3zzzOwIMyeEm4vzXsiFjJCLeFIn0BY8mFqYK8=;
        b=hz0E6J5Oo0K0ZNXDSkOcGl7/HazTGHtm0UtsngiLXK6kOcVZb+L82wSUkRVLmJ67Ua
         Kau4HqRr6zzqRNJK0od3FLR6NFsWf7QjdmYltgMyD3cUbY64J5STAlGJvcUmnKKF1HGh
         265mqvAGaaRCj3qLKCTle7fiMmelGZmL17ZtDTmAfBYw4i93dBsICFgMBv+JcZFAAmYk
         omHawabK/79a6V2o1eUp5PMRfuJ8LbNnXD3wiPIReGf3IKa45J0b71NBnFrUkMMNHs51
         mLx4G0/YRk7gPeDRkzAmlarvtc/hMTagXiFAcxtwgVCJv5CXJAZJEHrl9beWNz+DQ/XT
         9waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4mj/y3zzzOwIMyeEm4vzXsiFjJCLeFIn0BY8mFqYK8=;
        b=48Sxt1DqWhNmyRoKl//nY/l5iiT0fYZcTewKU5fGgWL8BOeijpUJJlqkupIP4FrXDs
         kBgtdV7A+ez3aD3zkpOImkpwlFaN9+rwVrUBQ9CXk/yzaoBp/rpEoaZ+hJXhl4/bPJpH
         nJmcAIe66HR4yRNtFpILqgTLAI84epXngXlpAROf4zeKgQlmd/ibLsrlqzj+Z95QEKoZ
         188GeOaj3BnM1rL3z2U95v2gJWmNoO9I7LUFlp8ZBPAouu89x6fd56XhfCoiAtXXmoOK
         uWzxSAONgGOZHIGLpM+IvAz3jbv6MH7AV+FODT5O5zTk0tFuFK/5ManMs9v9u1XCtGDW
         Jnmg==
X-Gm-Message-State: AJIora8K+UC84v1p/hqFr7QuYs0db/EhnVVG64LUcEOEiFEjLb4vt7m1
        usgyTD6tYALz1UeqDth9IIs5Jw0/2YMgHQ==
X-Google-Smtp-Source: AGRyM1uJVjsWWRPHHI2QdUrdatOqu+M1tt25VYsco4q/WAfG1niuOqJHLyt7DeXPYvQQ6dXWr+8x3A==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id p19-20020a170902a41300b00156015b524amr32758467plq.106.1658209171289;
        Mon, 18 Jul 2022 22:39:31 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b0016bee3caabesm10585015plh.270.2022.07.18.22.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:39:30 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:09:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] OPP: Fix refcount leak bug for opp
Message-ID: <20220719053927.j4xi6fjsjddaoub7@vireshk-i7>
References: <20220718133632.937290-1-windhl@126.com>
 <20220718133632.937290-2-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718133632.937290-2-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-22, 21:36, Liang He wrote:
> In _opp_add_static_v2(), we need call of_node_get() for the new
> reference created when "new_opp->np = np;" as new_opp is escaped out.
> Here we should also take care of the of_node_put() when 'new_opp' is
> freed based on the function description: "The opp can be controlled
> ... and may be removed by dev_pm_opp_remove".
> For example, _opp_add_static_v2() is called by _of_add_opp_table_v2()
> in a for_each_available_child_of_node() which will automatically
> increase and decrease the refcount. So we need an additional
> of_node_get() for the new reference created in _opp_add_static_v2().
> 
> Signed-off-by: Liang He <windhl@126.com>

Applied with few changes. Thanks.

commit 3466ea2cd6b66e4647a9af2381c0d0cd3d579354
Author: Liang He <windhl@126.com>
Date:   Mon Jul 18 21:36:32 2022 +0800

    OPP: Don't drop opp->np reference while it is still in use

    The struct dev_pm_opp contains a reference of the DT node, opp->np,
    throughout its lifetime. We should increase the refcount for the same
    from _opp_add_static_v2(), and drop it while removing the OPP finally.

    Signed-off-by: Liang He <windhl@126.com>
    [ Viresh: Updated subject / commit log, create _of_clear_opp() and drop
              reference from it]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  2 +-
 drivers/opp/of.c   | 12 +++++++++---
 drivers/opp/opp.h  |  6 ++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4f4a285886fa..77d1ba3a4154 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1553,7 +1553,7 @@ static void _opp_kref_release(struct kref *kref)
         * frequency/voltage list.
         */
        blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
-       _of_opp_free_required_opps(opp_table, opp);
+       _of_clear_opp(opp_table, opp);
        opp_debug_remove_one(opp);
        kfree(opp);
 }
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e4002b075422..7fa8263e38cb 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -254,8 +254,8 @@ void _of_clear_opp_table(struct opp_table *opp_table)
  * Release all resources previously acquired with a call to
  * _of_opp_alloc_required_opps().
  */
-void _of_opp_free_required_opps(struct opp_table *opp_table,
-                               struct dev_pm_opp *opp)
+static void _of_opp_free_required_opps(struct opp_table *opp_table,
+                                      struct dev_pm_opp *opp)
 {
        struct dev_pm_opp **required_opps = opp->required_opps;
        int i;
@@ -275,6 +275,12 @@ void _of_opp_free_required_opps(struct opp_table *opp_table,
        kfree(required_opps);
 }

+void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
+{
+       _of_opp_free_required_opps(opp_table, opp);
+       of_node_put(opp->np);
+}
+
 /* Populate all required OPPs which are part of "required-opps" list */
 static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
                                       struct dev_pm_opp *opp)
@@ -938,7 +944,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,

        new_opp->turbo = of_property_read_bool(np, "turbo-mode");

-       new_opp->np = np;
+       new_opp->np = of_node_get(np);
        new_opp->dynamic = false;
        new_opp->available = true;

diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 816009eaafee..3a6e077df386 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -267,14 +267,12 @@ static inline bool lazy_linking_pending(struct opp_table *opp_table)
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
 void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
-void _of_opp_free_required_opps(struct opp_table *opp_table,
-                               struct dev_pm_opp *opp);
+void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
-static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
-                                             struct dev_pm_opp *opp) {}
+static inline void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp) {}
 #endif

 #ifdef CONFIG_DEBUG_FS

