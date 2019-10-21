Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE1DE20B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfJUCZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:25:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46243 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUCZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:25:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so7395677pfg.13
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzWdCtzmSYF/0RAS8/Kzf4oQ1nX/6cypQt9wzSvyGBo=;
        b=l8i7fCXcwlYpE+x6LM93AukPZTXrH3qEevxZGcqgVty19q3wDNePK6MLPRqb4Zkl+v
         9iTf0UjyN9f+EjvvymcW8sxb1fUOueiLxgASSLmbBlm+yg+2sUaYYYHCLZRVeaKeu1I4
         hwnUcC281iJloUkbZr0sPcNjtfoK2PYoMx1B0tpcwOtVXQW34pcb4MEOZncUbH3ucq7b
         WB3KTPU0Q1VHndOpVs7OU7E0Ehb9ieYw7VP6///xaAxgJ2JWMUEEyfBU4zXvgEVGCTOM
         Fdj/9OsQTfUjNFjR0wjqFaItPGJLFqH3D3OR1wnl0H36HJUyzg361PWiBK4aNEV9PF5Y
         RPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzWdCtzmSYF/0RAS8/Kzf4oQ1nX/6cypQt9wzSvyGBo=;
        b=gdad6ZqMjIPBlPNbr3LcA6p8byMv0tKJuVYYHY1lejCa4/VhReOQUbY8sE4/N9MsG6
         4A0unleJoKeuxwCbBXHB4jhBzv0q0bIHov5p89WFSmorosrEndQ4k7iV/geJTr0Ewm0R
         A3r0Ogf7cO1dkJwM7vrOE8Vsfx8assk6R9OKCz367nPdA6n069wjXmRAwJ8sgN0Fl8WT
         3G7WX4fu7UeynIYfx1uwiIwoA/qmw1tWHWoYXk2K9PflgpEBNtjquTXsp4WtZznotxO6
         R6TaI4P+Wl2mqWumEFH4UeOezcJ4ViotnMraIiX18Al+sFxE8wD1X0yzQi22CCksReWV
         4SPA==
X-Gm-Message-State: APjAAAXBSKZDvJ2dpaIbqkzXOaONiMNa4wl2OgCqeQys4l7vmghxyclP
        4a8+Z6sYt6gaxOKJwaGkoBpIjw==
X-Google-Smtp-Source: APXvYqxhfKqto7mTnoOArVy2mBC9Vr1S8AjFgffMAGgboDuM0dTTF+ed+TZaUWw/8IZ9/9zKA4BFPA==
X-Received: by 2002:a63:e145:: with SMTP id h5mr23188556pgk.447.1571624719092;
        Sun, 20 Oct 2019 19:25:19 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 64sm13903581pfx.31.2019.10.20.19.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:25:18 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:55:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
Message-ID: <20191021022516.gecunkpahu7okvm5@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <20191018211214.444D32089C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018211214.444D32089C@mail.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 14:12, Stephen Boyd wrote:
> Quoting Viresh Kumar (2019-10-18 02:28:41)
> > The list_kref reaches a count of 0 when all the static OPPs are removed,
> > for example when dev_pm_opp_of_cpumask_remove_table() is called, though
> > the actual OPP table may not get freed as it may still be referenced by
> > other parts of the kernel, like from a call to
> > dev_pm_opp_set_supported_hw(). And if we call
> > dev_pm_opp_of_cpumask_add_table() again at this point, we must
> > reinitialize the list_kref otherwise the kernel will hit a WARN() in
> > kref infrastructure for incrementing a kref with value 0.
> > 
> > Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/of.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 6dc41faf74b5..1cbb58240b80 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
> >                 return 0;
> >         }
> >  
> > +       /*
> > +        * Re-initialize list_kref every time we add static OPPs to the OPP
> > +        * table as the reference count may be 0 after the last tie static OPPs
> 
> s/tie/time/
> 
> > +        * were removed.
> > +        */
> > +       kref_init(&opp_table->list_kref);
> 
> It seems racy.

I am not sure if I see a race here, but maybe I am missing something.
Care to explain ?

> Why are we doing this vs. making an entirely new and
> different OPP structure? Or why is the count reaching 0 when something
> is obviously still referencing it?

The kref for the opp table is opp_table->kref and the one here is
different. This is list_kref which is used for freeing OPPs added
statically from the DT. The static OPPs get added to the OPP table
when one calls dev_pm_opp_of_cpumask_add_table() and must be removed
on a call to dev_pm_opp_of_cpumask_remove_table(). The opp table
structure may not get freed at this moment though as it is still
referenced by the caller of dev_pm_opp_set_supported_hw().

And now when we try to add the static OPPs again (re-insertion of
cpufreq module), we need to reinitialize the list_kref again as its
count reached 0 earlier and the resources (static OPPs) were freed.

-- 
viresh
