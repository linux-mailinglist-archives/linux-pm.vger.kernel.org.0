Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45A6B615
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 07:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfGQFrS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 01:47:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfGQFrR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 01:47:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so10248682pfb.13
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtZ0UgdNHJWDVHHoxzF6IAqcb8s3MALQMghduEE8rY4=;
        b=oQntnTM77gszwZAh+WwmoqmvQ7CACqNjN326diAE1Fe0GO7JzQDYUxX37i2S+nc82J
         U4EZGqkd+98Dsjku3puKP9lIBAE0jCTKDHs0/XwA4/zqWJxEtdGXLocUHR/zTBxKAdFq
         fXXO8IdoXolGB4stPKIPuz5lEuvqF2lu63KfXhQ2ll7Upu5cN+BxgJDHd1mqj0p8RIC5
         9OdIj1Uh9qJ8BJHmZcB+6RYGPSuZlW4y4BN6W34rSBheaLOdWB057Dh3iqsLsZa+ZluU
         MEkZrAROptBjWXTKMKXWhg/Pp/oiCoITMI+fhr5u01IYYpGaG6wWuOijL+IwVaAm1Ita
         XPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtZ0UgdNHJWDVHHoxzF6IAqcb8s3MALQMghduEE8rY4=;
        b=rnWswR9UzEbPHQvwLmdGiK83+DDDWNTod2vVDE4P3E2CFxD+LdEtbrVqHvS8dB04av
         +MCbDjYzPB2M226WOOXQ74H6Kbfjzx7eril+n6bHTcY8scJ37RFnQNBukJCchShWQDJA
         rfYxkdnV0RPXmznyXMV3FUsfcicu9lrYxLs3o9LV5Fa4BktERS2NjcW+FtG7NciYPTQu
         RaIy0eYDfURVSKJfL9DsLX5ECLBS3W8HCKxqzc9PtS+Dj/CSpYuR2YIA9rud5dZMmxfR
         vx+Gv1k9rbpewegEs4x4NQJj9RUFa+WTEIblmOrIIAMT1mqDSdI3D+oOy01JaTj2O1Ha
         OuTA==
X-Gm-Message-State: APjAAAW6Cc7LNs/GV1Z23u3TaNmAhfQOmpLU1TmODGWHimyN44+CXLhD
        1qpX//ffn58EmdeItwc1hYqItg==
X-Google-Smtp-Source: APXvYqxT3LdyBnPGX8def6EOLQvEhKwYdEp10ZmFFPutwAzP8gjxeqXrIKbG/dDV5XFVnvALjbQElQ==
X-Received: by 2002:a63:1046:: with SMTP id 6mr40084422pgq.111.1563342436937;
        Tue, 16 Jul 2019 22:47:16 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id w14sm24599914pfn.47.2019.07.16.22.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 22:47:15 -0700 (PDT)
Date:   Wed, 17 Jul 2019 11:17:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
Message-ID: <20190717054713.vn65cfiqebhzdvjq@vireshk-i7>
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
 <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-07-19, 15:09, Rajendra Nayak wrote:
> Sorry for the delay

Same here :)

> I seem to have completely missed this patch.
> I just gave this a try and here are some observations,
> 
> I have a case where I have one device with 2 power domains, one of them
> is scale-able (supports perf state) and the other one supports only being
> turned on and off.
> 
> 1. In the driver I now need to use dev_pm_domain_attach_by_name/id to attach the
> power domain which supports only on/off and then use dev_pm_opp_attach_genpd()
> for the one which supports perf states.
> 
> 2. My OPP table has only 1 required_opps, so the required_opp_count for the OPP table is 1.
> Now if my device tree has my scale-able powerdomain at index 1 (it works if its at index 0)
> then I end up with this error
> 
> [    2.858628] ufshcd-qcom 1d84000.ufshc: Index can't be greater than required-opp-count - 1, rpmh_pd (1 : 1)
> 
> so it looks like a lot of the OPP core today just assumes that if a device has multiple power domains,
> all of them are scale-able which isn't necessarily true.

I don't think a lot of OPP core has these problems, but maybe only
this place. I was taking care of this since the beginning just forgot
it now.

What about this over this commit:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d76ead4eff4c..1f11f8c92337 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1789,13 +1789,16 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  *
  * This helper needs to be called once with a list of all genpd to attach.
  * Otherwise the original device structure will be used instead by the OPP core.
+ *
+ * The order of entries in the names array must match the order in which
+ * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
                const char **names, struct device ***virt_devs)
 {
        struct opp_table *opp_table;
        struct device *virt_dev;
-       int index, ret = -EINVAL;
+       int index = 0, ret = -EINVAL;
        const char **name = names;
 
        opp_table = dev_pm_opp_get_opp_table(dev);
@@ -1821,14 +1824,6 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
                goto unlock;
 
        while (*name) {
-               index = of_property_match_string(dev->of_node,
-                                                "power-domain-names", *name);
-               if (index < 0) {
-                       dev_err(dev, "Failed to find power domain: %s (%d)\n",
-                               *name, index);
-                       goto err;
-               }
-
                if (index >= opp_table->required_opp_count) {
                        dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
                                *name, opp_table->required_opp_count, index);
@@ -1849,6 +1844,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
                }
 
                opp_table->genpd_virt_devs[index] = virt_dev;
+               index++;
                name++;
        }
 

-- 
viresh
