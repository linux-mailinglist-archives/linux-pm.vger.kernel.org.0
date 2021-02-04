Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F730F1FC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 12:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhBDLXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhBDLXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 06:23:30 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43845C061788
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 03:22:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x23so422773pfn.6
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 03:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLPiUGe2JfnMJOEbNg5zlg1nIqrKgmzt6+aWsIXvJ60=;
        b=INwTIjT4bjYk+pdg0C5zt7VyXoUWxP1+GjvAIyHgnFZ0TtgKWo+PMoc4TVW9q0rAok
         Qp4dfx0Bx4EFCseDmINXsM1z0C7kLroY/viwjQIqOAiDK81KHeLvQI5emacNuLQI02Vz
         /Bt0zrboIoxSy4wtFS8O0Uo8D3ux6YVd9L3lN9AolCJYnnxeEqpwZAsj8NH7Qxh9fWtV
         eEcZ/xKhfcOqV+vaFIhPEuojiyYJDy95szcDHu6EWjAoOFSdi9TpB8Lf+XZx4EgL++gf
         opNG7n41Bgdn5vgIB01dM/2af+aitOynX1BlyJAEVlpcYbEthygXR0sq1DHM14CyTdom
         xEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLPiUGe2JfnMJOEbNg5zlg1nIqrKgmzt6+aWsIXvJ60=;
        b=TmaXdXehZDW/QFiNNwDVcHhlqE90rxdwrdTGFdg6W9rK9NDu7/V7zWtMrWPXVFXPNU
         TEFJkqylKR49LXnUHoYehIxUx7/77IVrOx8Qtm1J+txp4CIJ/mq76QDo4al938qSsNk+
         4Y8YrVQX66LrKNfXRX2QsDjSp8u431y+v/X5Mq7F1XjmcHrTVYVZTOeVMl2VSR1eeVfR
         /RjRRVIfyc9LI3UjMq2Kf/lMoS4cogGgG/ptYsp/bLjclv/nHb4IJGcH1LRrCtNkANJB
         mmKDOK7qN0cXR3Op1e2HGDZFevDWxWBYW2/X/IFBf8Lgxy1EyPtXBq+v1hsv/z73G+Hs
         q/KQ==
X-Gm-Message-State: AOAM532CTaLGgexKi5kGhIJXWR+cspVrZXsSmiLq5Pr+t3Vb8C8+/eAL
        4bXMK1vGs9y9xaKk4UsCFk67j6cjbhXmOA==
X-Google-Smtp-Source: ABdhPJxUYLNYiFxorNwBAEAuZl+tA8doYlbnY6d89h1pK8+cTNhpwD6TlPjoN1OJVWm97V94qINThQ==
X-Received: by 2002:a63:c501:: with SMTP id f1mr8432194pgd.1.1612437769734;
        Thu, 04 Feb 2021 03:22:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u3sm6156425pfm.144.2021.02.04.03.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:22:48 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:52:46 +0530
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
Subject: Re: [PATCH v6 3/3] PM / devfreq: Add required OPPs support to
 passive governor
Message-ID: <20210204112246.yewojjxv7sy3bhky@vireshk-i7>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
 <20210204081424.2219311-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204081424.2219311-4-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-02-21, 16:14, Hsin-Yi Wang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Look at the required OPPs of the "parent" device to determine the OPP that
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even when
> they don't have the same number of OPPs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/devfreq/governor_passive.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)

I have made changes to this patch as well, though I didn't wanted to
do initially :)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 8fd51cc9b991..b094132bd20b 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -19,18 +19,16 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
                        = (struct devfreq_passive_data *)devfreq->data;
        struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
        unsigned long child_freq = ULONG_MAX;
-       struct dev_pm_opp *opp, *p_opp = ERR_PTR(-ENODEV);
-       int i, count, ret = 0;
+       struct dev_pm_opp *opp, *p_opp;
+       int i, count;
 
        /*
         * If the devfreq device with passive governor has the specific method
         * to determine the next frequency, should use the get_target_freq()
         * of struct devfreq_passive_data.
         */
-       if (p_data->get_target_freq) {
-               ret = p_data->get_target_freq(devfreq, freq);
-               return ret;
-       }
+       if (p_data->get_target_freq)
+               return p_data->get_target_freq(devfreq, freq);
 
        /*
         * If the parent and passive devfreq device uses the OPP table,
@@ -56,35 +54,35 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
         * list of parent device. Because in this case, *freq is temporary
         * value which is decided by ondemand governor.
         */
-       p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-       if (IS_ERR(p_opp)) {
-               ret = PTR_ERR(p_opp);
-               return ret;
-       }
-
        if (devfreq->opp_table && parent_devfreq->opp_table) {
+               p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
+                                               freq, 0);
+               if (IS_ERR(p_opp))
+                       return PTR_ERR(p_opp);
+
                opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
                                                    devfreq->opp_table, p_opp);
-               if (!IS_ERR(opp)) {
-                       *freq = dev_pm_opp_get_freq(opp);
-                       dev_pm_opp_put(opp);
-               } else
-                       ret = PTR_ERR(opp);
-               goto out;
+               dev_pm_opp_put(p_opp);
+
+               if (IS_ERR(opp))
+                       return PTR_ERR(opp);
+
+               *freq = dev_pm_opp_get_freq(opp);
+               dev_pm_opp_put(opp);
+
+               return 0;
        }
 
        /*
-        * Get the OPP table's index of decided freqeuncy by governor
+        * Get the OPP table's index of decided frequency by governor
         * of parent device.
         */
        for (i = 0; i < parent_devfreq->profile->max_state; i++)
                if (parent_devfreq->profile->freq_table[i] == *freq)
                        break;
 
-       if (i == parent_devfreq->profile->max_state) {
-               ret = -EINVAL;
-               goto out;
-       }
+       if (i == parent_devfreq->profile->max_state)
+               return -EINVAL;
 
        /* Get the suitable frequency by using index of parent device. */
        if (i < devfreq->profile->max_state) {
@@ -97,10 +95,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
        /* Return the suitable frequency for passive device. */
        *freq = child_freq;
 
-out:
-       dev_pm_opp_put(p_opp);
-
-       return ret;
+       return 0;
 }
 
 static int devfreq_passive_notifier_call(struct notifier_block *nb,


-- 
viresh
