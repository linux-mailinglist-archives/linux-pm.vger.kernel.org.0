Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CE30F184
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhBDLEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 06:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbhBDLER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 06:04:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0501C0613ED
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 03:03:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g15so1580937pjd.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 03:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=it3wy07edebQ9hk+ROqiwGhtErfJY9Cs78unbURg/p8=;
        b=c1kksw3PiMsFz5TVTRhRNWciiaIvWVLutZHU+mfDfE3vQ6+nuThfep76r2wZUx1iTw
         0518BmBwICcMfELJZbDD6ElxTXCN/z6cY9Ks5bVrZB3vIEhNrUBqEU8P4UXTvIklFJvS
         FbEcw+rzWhcIhhlZcjvZRHO3lEyuCBmc4qizhjrIPDYZCyyhqvftFvY0e/qDt9BDgeIB
         khRSEonddDO4AI51+oC+QuDQeNmrnpwjJljbgmeTVHn6DwuH7isxFTaXxyQ9vgTjpVR+
         jRq3tYmLpDMoCPlIWZg4FSWk2Dbcg3oOWt6fC0vRAMTrqQpYRwG/hHgPjHU52bp7zpaB
         rgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=it3wy07edebQ9hk+ROqiwGhtErfJY9Cs78unbURg/p8=;
        b=VuRthUUTk7SIuh9rcImkgYFFG51hPkV/lZ532S5bkUczd1lLJ5AvZEOX2vE4QBfHk2
         ZvQzPVMKB/FaAeQQlyv62QQCpP4+6Oj21ZPUo+xdJcZZ3hYqAswBcVjZjyjSKL/gy9Fv
         S/RzbjJxpnR7fkAYStoZwucqzHHW2TKQY6zRVCQH+SA2MqCe9xBWIxO2xM0zKXOKWf9z
         1jFTtmda59o1F/dGYR8K5FhT3SSLgyaoXbPNSa3UbRL7LzDyNbYS47Al/b5jAELhZ1UR
         XFR2vt7X1/LTuY5dgajHrhPWf6y0KSaWxyLoEQW7SDBxe+ZybeAoeqR6bwHsOCu0D+tu
         joPA==
X-Gm-Message-State: AOAM530Xb38qDnjIGjdriuHPBTivmkX7OigQ6HkF4R+w00lLq0CdKpP8
        ycHT+Ca0ukNkf1AGHZv3+sBjig==
X-Google-Smtp-Source: ABdhPJy0C5LpIC4vPl+2xdvMvTEiuZ2cbHz70Ml1jUMrLSYxuoYAOls6Zzbto9HOTHIkVzyNBWT8uA==
X-Received: by 2002:a17:902:e846:b029:da:d44d:1968 with SMTP id t6-20020a170902e846b02900dad44d1968mr7402754plg.47.1612436617289;
        Thu, 04 Feb 2021 03:03:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a14sm6344845pfl.169.2021.02.04.03.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:03:36 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:33:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 1/3] OPP: Add function to look up required OPP's for a
 given OPP
Message-ID: <20210204110334.kbsf2wvyv5tvkf46@vireshk-i7>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
 <20210204081424.2219311-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204081424.2219311-2-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-02-21, 16:14, Hsin-Yi Wang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Add a function that allows looking up required OPPs given a source OPP
> table, destination OPP table and the source OPP.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/opp/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  7 +++++
>  2 files changed, 66 insertions(+)

I made some changes while applying:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fba67ae40aef..c3f3d9249cc5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2402,21 +2402,21 @@ EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
  * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
  * @src_table: OPP table which has @dst_table as one of its required OPP table.
  * @dst_table: Required OPP table of the @src_table.
+ * @src_opp: OPP from the @src_table.
  *
  * This function returns the OPP (present in @dst_table) pointed out by the
- * "required-opps" property of the OPP (present in @src_table).
+ * "required-opps" property of the @src_opp (present in @src_table).
  *
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  *
- * Return: destination table OPP on success, otherwise -EINVAL or -ENODEV based
- * on errors.
+ * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
  */
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
                                                 struct opp_table *dst_table,
                                                 struct dev_pm_opp *src_opp)
 {
-       struct dev_pm_opp *opp, *dest_opp = ERR_PTR(-EINVAL);
+       struct dev_pm_opp *opp, *dest_opp = ERR_PTR(-ENODEV);
        int i;
 
        if (!src_table || !dst_table || !src_opp ||
@@ -2425,37 +2425,33 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 
        /* required-opps not fully initialized yet */
        if (lazy_linking_pending(src_table))
-               return ERR_PTR(-EINVAL);
+               return ERR_PTR(-EBUSY);
 
        for (i = 0; i < src_table->required_opp_count; i++) {
-               if (src_table->required_opp_tables[i] == dst_table)
+               if (src_table->required_opp_tables[i] == dst_table) {
+                       mutex_lock(&src_table->lock);
+
+                       list_for_each_entry(opp, &src_table->opp_list, node) {
+                               if (opp == src_opp) {
+                                       dest_opp = opp->required_opps[i];
+                                       dev_pm_opp_get(dest_opp);
+                                       break;
+                               }
+                       }
+
+                       mutex_unlock(&src_table->lock);
                        break;
-       }
-
-       if (unlikely(i == src_table->required_opp_count)) {
-               pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
-                      __func__, src_table, dst_table);
-               return ERR_PTR(-ENODEV);
-       }
-
-       mutex_lock(&src_table->lock);
-
-       list_for_each_entry(opp, &src_table->opp_list, node) {
-               if (opp == src_opp) {
-                       dest_opp = opp->required_opps[i];
-                       dev_pm_opp_get(dest_opp);
-                       goto unlock;
                }
        }
 
-       pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
-              dst_table);
-
-unlock:
-       mutex_unlock(&src_table->lock);
+       if (IS_ERR(dest_opp)) {
+               pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__,
+                      src_table, dst_table);
+       }
 
        return dest_opp;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_xlate_required_opp);
 
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.


-- 
viresh
