Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4A265C74
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKJ0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIKJ0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 05:26:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2696C061573
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 02:25:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so6857027pfa.10
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RXp4r+rCm7pJvosVuIzq7ZjCuJpbLHx9hsRre/KOYe8=;
        b=e854OLfxYenoEzfm8iviWmLWi/u1m41vcYP5RKNpQPsZ7XQee0Ymvu2XFYGi1TrQgF
         X7OIib1DUqiwhK4RG7vkq/Vi59NBlgdGFsJH+IRKR3h1BT8cFHsi3pLGtX7F1KVUY3kI
         MfhmOPidfcH0TB/hajqS4vmo168K0hu555VH+a2oesJkLxEfsn90DbBxCNBOcOSI8yiQ
         EGXQLagS8tzcyx3pPJKRdCWA4u0obJsw5B+jk4yZhO/ffZzCggMY/r2l7EBSCupJbJYT
         o0TlIIaYPX7UB00/QtCMeDH2KYkSks8fvCuHKQSpYZzyqBw9QbTW6LJ5cuDzX/jy/QCy
         Vmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXp4r+rCm7pJvosVuIzq7ZjCuJpbLHx9hsRre/KOYe8=;
        b=ABb96vp12nYVYDHxLXLp34yfV6YzqQzvPWnlP7VpD3wsZ+3pco9qVbFf+bRLW2p3kV
         bSFR/hPP9dTpCVDo9HjJKpf5qXXQ1TJQdp/0WQXKjUN9PW6Uk3VB1ucqHdn5fZ6AStG2
         OswSzdzpdIFUkO+rfyodNNwkRg2tl8eES8syhp73/dVtXUkdBXgplfv6FOyki2Ca2bv6
         C28VyCtD3Go2nrxHciFtLoPFwy4Fj8YXa6ZNImlJQiDI6DP3s2/8xN6kzDvG3HkCp8Uh
         ltx7WvcJMIjV3gHLEM34cbbh36HvQy09KwwzHnzPInXr9XTuI/zohczP9tLUGCpjPWQf
         cwrw==
X-Gm-Message-State: AOAM533Xd850embNg5UdYCrO/N7OOq0lV2nWOA55cUfV9aCA54rrdWtf
        54nEPaggEipw+dv6EagPadcjEA==
X-Google-Smtp-Source: ABdhPJync3zxDamw0VP66DnwVcdw9nZ7pA8IiL3kBW2lIpSsrnsV4qVXjFOy9oJz8fblj/k0/JZ1MA==
X-Received: by 2002:a63:d40c:: with SMTP id a12mr1036496pgh.256.1599816346162;
        Fri, 11 Sep 2020 02:25:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e125sm1677274pfe.154.2020.09.11.02.25.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 02:25:45 -0700 (PDT)
Date:   Fri, 11 Sep 2020 14:55:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200911092538.jexqm6joww67d4yv@vireshk-i7>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
 <20200827114422.GA1784@gerhold.net>
 <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
 <20200828095706.GA1865@gerhold.net>
 <20200911083455.GA1591@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911083455.GA1591@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-09-20, 10:34, Stephan Gerhold wrote:
> On Fri, Aug 28, 2020 at 11:57:28AM +0200, Stephan Gerhold wrote:
> > It seems to me that there is more work needed to make such a use case
> > really work, but it's hard to speculate without a real example.
> > 
> 
> So it seems like we have a real example now. :)

We told you :)

> As mentioned in my other mail [1] it turns out I actually have such a
> use case. I briefly explained it in [2], basically the clock that
> provides higher CPU frequencies has some voltage requirements that
> should be voted for using a power domain.
> 
> The clock that provides the lower CPU frequencies has no such
> requirement, so I need to scale (and power on) a power domain only for
> some of the OPPs.
> 
> [1]: https://lore.kernel.org/linux-pm/20200831154938.GA33622@gerhold.net/
> [2]: https://lore.kernel.org/linux-arm-msm/20200910162610.GA7008@gerhold.net/
> 
> So I think it would be good to discuss this use case first before we
> decide on this patch (how to enable power domains managed by the OPP
> core). I think there are two problems that need to be solved:
> 
> 1. How can we drop our performance state votes for some of the OPPs?
>    I explained that problem earlier already:
> 
> > 
> > I was thinking about something like that, but can you actually drop
> > your performance state vote for one of the power domains using
> > "required-opps"?
> > 
> > At the moment it does not seem possible. I tried adding a special OPP
> > using opp-level = <0> to reference that from required-opps, but the OPP
> > core does not allow this:
> > 
> > 	vddcx: Not all nodes have performance state set (7: 6)
> > 	vddcx: Failed to add OPP table for index 0: -2

This should fix it.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 214c1619b445..2483e765318a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2117,9 +2117,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
        int dest_pstate = -EINVAL;
        int i;
 
-       if (!pstate)
-               return 0;
-
        /*
         * Normally the src_table will have the "required_opps" property set to
         * point to one of the OPPs in the dst_table, but in some cases the
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e72753be7dc7..1a9cb96484bb 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -842,7 +842,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
        struct device_node *np;
-       int ret, count = 0, pstate_count = 0;
+       int ret, count = 0;
        struct dev_pm_opp *opp;
 
        /* OPP table is already initialized for the device */
@@ -876,20 +876,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
                goto remove_static_opp;
        }
 
-       list_for_each_entry(opp, &opp_table->opp_list, node)
-               pstate_count += !!opp->pstate;
-
-       /* Either all or none of the nodes shall have performance state set */
-       if (pstate_count && pstate_count != count) {
-               dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
-                       count, pstate_count);
-               ret = -ENOENT;
-               goto remove_static_opp;
+       list_for_each_entry(opp, &opp_table->opp_list, node) {
+               if (opp->pstate) {
+                       opp_table->genpd_performance_state = true;
+                       break;
+               }
        }
 
-       if (pstate_count)
-               opp_table->genpd_performance_state = true;
-
        return 0;
 
 remove_static_opp:


> Not sure if it makes sense but I think somehow allowing the additional
> opp-level = <0> would be a simple solution. For example:
> 
> 	rpmpd: power-controller {
> 		rpmpd_opp_table: opp-table {
> 			compatible = "operating-points-v2";
> 
>             /*
>              * This one can be referenced to drop the performance state
>              * vote within required-opps.
>              */
>             rpmpd_opp_none: opp0 {
>                 opp-level = <0>;
>             };
> 
> 			rpmpd_opp_retention: opp1 {
> 				opp-level = <1>;
> 			};
> 
>             /* ... */
>         };
>     };                
> 
> 	cpu_opp_table: cpu-opp-table {
> 		compatible = "operating-points-v2";
> 		opp-shared;
> 
>         /* Power domain is only needed for frequencies >= 998 MHz */
> 		opp-200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 			required-opps = <&rpmpd_opp_none>; /* = drop perf state */
> 		};
> 		opp-998400000 {
> 			opp-hz = /bits/ 64 <998400000>;
> 			required-opps = <&rpmpd_opp_svs_soc>;
> 		};
> 		opp-1209600000 {
> 			opp-hz = /bits/ 64 <1209600000>;
> 			required-opps = <&rpmpd_opp_nominal>;
> 		};
> 	};	

Yes, makes sense.

> 2. Where/when to enable the power domains: I need to enable the power
>    domain whenever I have a vote for a performance state. In the example
>    above the power domain should get enabled for >= 998 MHz and disabled
>    otherwise.

- Why do you need to enable these power domains like this ?
- What will happen if you don't enable them at all ?
- What will happen if you enable them for ever ?

AFAIU, these are kind of virtual domains which are there just to vote in behalf
of the OS. Only if the accumulated vote is greater than zero, the actual power
domain will start consuming power. Otherwise it should be disabled.

Or is that wrong ?

>    At least for the CPUFreq case the "virt_devs" parameter does not
>    really help in this case...
>    dev_pm_opp_set_rate() is called within cpufreq-dt which is supposed
>    to be generic. So I can't enable the power domains myself from there.
>    Even if I made a custom cpufreq driver that has control over the
>    dev_pm_opp_set_rate() call - I don't really know exactly in the
>    driver for which frequencies a power domain is needed.
> 
>    On the other hand, the OPP core does have that information.
>    This brings me back to my PATCH v1 (where I used runtime PM functions
>    instead of device links). If I modify it to enable the power domain
>    whenever we have a performance state vote > 0 when setting an OPP,
>    it would do exactly what I need...
> 
>    I don't think it makes sense to do performance state votes without
>    enabling a power domain, so this approach sounds good to me...

-- 
viresh
