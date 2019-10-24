Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8EE2879
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 04:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbfJXC4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 22:56:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46553 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391577AbfJXC4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 22:56:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id b25so101438pfi.13
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dvriWE0Ri4yYKecmkqo5B7W02zBCeLQpMBsjbMKD0G0=;
        b=J5YqqPZRn+eJUvJ5pbTJ3bZ4gZKxBfm6hBNiQppjyOW+oeSQIMtuB6Djo8gpXWhoAF
         we4rAteiGbAkMxNxUAxdNQybrSq/gAcnZY5h4EYuxebgHkvxpfthDK3F8HSUPAv1YuSL
         pbwmjPiZxteiZyD/YURN/9LrN3/OEfYHftB9y0vbZiBKW8KDB49XBD4XskhZyrHdN5cg
         ilFrOToPHpGG33kt3XwBbDEXqAWse8detK3j9lZRKJ0JXEJDUHa4RfNoVPFKy6JAnpse
         oM7bau9C3bfAuTZfBFWtSYko2W8SQV0fRzsBRp27w24xXUhAxRKJcZ1LEXQp46gXjrAz
         LM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dvriWE0Ri4yYKecmkqo5B7W02zBCeLQpMBsjbMKD0G0=;
        b=scMo6fHXn4oUYJpTGzLPjhvcJL+o0Uq5+mXTQ76G3U41USh+1R4rgu4ZMXdPwP6x6y
         QwveNNJPgNWrQxvw63snmJuqELAXH4ttbJYpJBLfXYa9WGJUvai4zLApuyiCgV45CSvN
         bbaCcQDn1OnSlM+p36ZmSurZp5xl0PEEYs10h+tHfiimkGA9ZqTdfl3kYrgZUs/MQUPP
         NLzUOvz2WnAlPw0g3Y9owTjSn0gRrH244Zy1R7tFCjq50RB9oQRmo0C3LRF0cN/8MlkU
         U4zOY6GVJDZ4P4jLQJ/FW8P9O38DNGJr4buX9umBMvA7Cm2sEb/6Gz56wRt41M6CCSuo
         Ra0A==
X-Gm-Message-State: APjAAAV8Llq0smmc6ERTO8PNQihEARZB1wh8RA7P4FEgQGl+BUotBXrM
        mTuge59PqBS4rv0GQuCBUyIjKQ==
X-Google-Smtp-Source: APXvYqzmHErqih0DgWYtOnVVI91j5+trwCMTyuODEk/82Va7y1F65b+vIxAdFCcs1rQ+6SL84KK0rQ==
X-Received: by 2002:a17:90a:22c6:: with SMTP id s64mr4227508pjc.15.1571885808199;
        Wed, 23 Oct 2019 19:56:48 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y126sm8847533pfg.74.2019.10.23.19.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 19:56:47 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:26:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "v5 . 0+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: of: drop incorrect lockdep_assert_held()
Message-ID: <20191024025641.dknawrtzap4qwcm4@vireshk-i7>
References: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
 <20191023053005.m4y4bcebgi4km35q@vireshk-i7>
 <20191023120137.GA18078@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023120137.GA18078@centauri>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-19, 14:01, Niklas Cassel wrote:
> On Wed, Oct 23, 2019 at 11:00:05AM +0530, Viresh Kumar wrote:
> > On 10-10-19, 16:00, Viresh Kumar wrote:
> > > _find_opp_of_np() doesn't traverse the list of OPP tables but instead
> > > just the entries within an OPP table and so only requires to lock the
> > > OPP table itself.
> > > 
> > > The lockdep_assert_held() was added there by mistake and isn't really
> > > required.
> > > 
> > > Fixes: 5d6d106fa455 ("OPP: Populate required opp tables from "required-opps" property")
> > > Cc: v5.0+ <stable@vger.kernel.org> # v5.0+
> > > Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/opp/of.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > > index 1813f5ad5fa2..6dc41faf74b5 100644
> > > --- a/drivers/opp/of.c
> > > +++ b/drivers/opp/of.c
> > > @@ -77,8 +77,6 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
> > >  {
> > >  	struct dev_pm_opp *opp;
> > >  
> > > -	lockdep_assert_held(&opp_table_lock);
> > > -
> > >  	mutex_lock(&opp_table->lock);
> > >  
> > >  	list_for_each_entry(opp, &opp_table->opp_list, node) {
> > 
> > @Niklas, any inputs from your side  here would be appreciated :)
> 
> Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
> 
> After this patch, there is still a single lockdep_assert_held()
> left, inside _find_table_of_opp_np(), since you kept this,
> I assume that that one is still needed?

Yeah, that one is required as we are traversing the list of OPP tables
there.

-- 
viresh
