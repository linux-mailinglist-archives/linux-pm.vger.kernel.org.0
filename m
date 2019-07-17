Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93D36B4BD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 04:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfGQCwW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 22:52:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfGQCwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 22:52:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so11124387pla.7
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wuLqDfULAB39YnZgj7k2QkDp3/RJGX96MN015DTBiZc=;
        b=mbX7R/Y+HcSnVUJoumXkghmrx0t/XVHfKQJQxJC6eEUDONiWV6YG/TyT4FMw1JvsRo
         Xh7hVU/BQr52QZMk6EGRO6OLHW8/JNG9TXBBsJuXZvwk6DoXuU/+yKfVlGuKc8X8wHQu
         CdauH0erBit85KKhWgSkcXvRN3ATEwHK2pGQ6N9NMkl+HMmBzg16MXIjzYbg3io5YE7O
         JbuqhaXObx0BSp5zT4XGURP9BQdRO7NMg95Su55vtYHvhuzErBPeP6hwKaVk66onEBGS
         H/c2bL3X3NK8m3M8SPBIzUTKfk71dFzc9cbIK/iuk3fpeOforZs1Ln+sKntlwiGzbKow
         Ndjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wuLqDfULAB39YnZgj7k2QkDp3/RJGX96MN015DTBiZc=;
        b=EJNRA5zAWRKKYl5m7BBAZYRpZ933TZl/l00SitNYp96b0/vxrYL9eNN6KhaYz+dfEF
         P335uwT6CetkqWJB392h5lRBGxL/KD2YGdptq0UIpsOur2kJj+bWlPfjcAzeogU1vAoE
         8egEIpk5CVy5SuJe0r+P1iGU+RuC2LeVXvkI2EXDUjqowMSuyAI9c4JugW89VoU50QUg
         6gjmMBn+8aG6SvCw4Dk8gVuuvlug27LTQAmbYeK6KzTat1BNbwXn7KRf7gBC305T8dC7
         Y+k3hLhub2PfOPemPI1bB4wkK6hXBeeUc8cfKxBSm37lBQrZ1l4TMJSBb7Q8zwpJpSlD
         x3JA==
X-Gm-Message-State: APjAAAVX/L+51w9Z2RHC90wpRmqMpD73HBPu2brPr0ItVI/R2BJK3zSC
        CSGvBQjo61dEz6K8dXOzfe6uvw==
X-Google-Smtp-Source: APXvYqwxnQ1mFrdFRTTHdBHioQD0o56X9gJ6F7T6d2RGVvDbh2Msrrxo1WT6eUlBcVDRxXfZ1kdWxg==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12mr5778512plr.202.1563331940824;
        Tue, 16 Jul 2019 19:52:20 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id b190sm8122147pga.37.2019.07.16.19.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 19:52:19 -0700 (PDT)
Date:   Wed, 17 Jul 2019 08:22:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
Message-ID: <20190717025217.ne5tf2le2lj7oxbf@vireshk-i7>
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
 <20190716104354.GA13780@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716104354.GA13780@centauri>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-07-19, 12:43, Niklas Cassel wrote:
> On Mon, Jul 08, 2019 at 11:30:11AM +0530, Viresh Kumar wrote:
> > The cpufreq drivers don't need to do runtime PM operations on the
> > virtual devices returned by dev_pm_domain_attach_by_name() and so the
> > virtual devices weren't shared with the callers of
> > dev_pm_opp_attach_genpd() earlier.
> > 
> > But the IO device drivers would want to do that. This patch updates the
> > prototype of dev_pm_opp_attach_genpd() to accept another argument to
> > return the pointer to the array of genpd virtual devices.
> > 
> > Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > @Rajendra: Can you please test this one ? I have only compile tested it.
> > 
> >  drivers/opp/core.c     | 5 ++++-
> >  include/linux/pm_opp.h | 4 ++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 2958cc7bbb58..07b6f1187b3b 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1775,6 +1775,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >   * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
> >   * @dev: Consumer device for which the genpd is getting attached.
> >   * @names: Null terminated array of pointers containing names of genpd to attach.
> > + * @virt_devs: Pointer to return the array of virtual devices.
> >   *
> >   * Multiple generic power domains for a device are supported with the help of
> >   * virtual genpd devices, which are created for each consumer device - genpd
> > @@ -1789,7 +1790,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >   * This helper needs to be called once with a list of all genpd to attach.
> >   * Otherwise the original device structure will be used instead by the OPP core.
> >   */
> > -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
> > +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> > +		const char **names, struct device ***virt_devs)
> >  {
> >  	struct opp_table *opp_table;
> >  	struct device *virt_dev;
> > @@ -1850,6 +1852,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
> >  		name++;
> >  	}
> >  
> > +	*virt_devs = opp_table->genpd_virt_devs;
> 
> Could we perhaps only do this if (virt_devs), that way callers can send in
> NULL if they don't care about the genpd virtual devices.

That was the idea and I failed to add it :(

-- 
viresh
