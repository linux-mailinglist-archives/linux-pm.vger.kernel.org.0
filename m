Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D02744D5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390566AbfGYFWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 01:22:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38794 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390542AbfGYFWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 01:22:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so22902059plb.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xZxGXc0Ivxqr92bf1BipffjFV4zTI0LPpEMDctA4sg=;
        b=rSsfQjeJREPnV1Zd0y8XVUwIPaLW1Mk6hoim+fB9ibMquuACj+uIFH7x/+VzUt7CrZ
         2HDtB9T4fLvxla0hXbinFc02wCSXsdSPMKZl3kvALhMtFnskG7Q2pOeZIgEQG0EcRJcO
         W4TPnwHjb9Z6z4YqYfry9+yDoNPMkTOVJPuamGW/LGaddBvDctGgZ9Y28ozdwu98yWLv
         bL4ul3ZDkofYEDajqCyMmSUP0aNFNZtV7tVcBvh4JCElexCsucFGb4YJqcpEFBkqoBsN
         shJ5FfukcfpaHy05XzzxmqamcvmTPcP0/jphlSUIZBOlbzVzVqP8yGwyRfEznpWcfo9l
         obnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xZxGXc0Ivxqr92bf1BipffjFV4zTI0LPpEMDctA4sg=;
        b=sOf0JJbcuV5H/FKJshdiK0jVr7d+AqOGSoqeyC2ZrqZggrc8Gwtc2xIAfvxaTG6/pl
         efTuW/wMo1Ls8Bvs9aPUaP5sT70Kw2KuYs7Cn8lZFpUyJJiH4Zr6Vw/+nQNuooGJDaXv
         IlJlVO0USaw7CKIbOHfQcch3BON/LscVfL+TONlA6j6yuBD4e55ybp2gcgxpHuOKuX27
         Q7r1QBIUTFoOM/cyGhOB94ck5VZm8D+hrdPZ5UdUTge4MOY3MLfLctRNkXs4ek02+g/z
         aWEJspImEEptxPIgQoTWXXyI8Xuj+2tQfnqFykzkM7yaaAMj9UGohkVchkNTt6qEaWAc
         kwMg==
X-Gm-Message-State: APjAAAVWD5amo1dqGnSMhzMGkBTJjhSgv4NfUrjL13jFPOATstyNAy8R
        DzQGC5jgH44hRghCz95yk4Ibaw==
X-Google-Smtp-Source: APXvYqzsumr0UqkwlGeOG7n6Wk6nxVjmT7yfiqwz9Ib4PjshFHVHMFgbschdLdFDiNL9McSo8p6NTg==
X-Received: by 2002:a17:902:2ac8:: with SMTP id j66mr85115769plb.273.1564032152747;
        Wed, 24 Jul 2019 22:22:32 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id u134sm45825640pfc.19.2019.07.24.22.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 22:22:31 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:52:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
Message-ID: <20190725052229.znf6asnvl44rjqxg@vireshk-i7>
References: <20190724014222.110767-1-saravanak@google.com>
 <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
 <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-07-19, 20:40, Saravana Kannan wrote:
> On Wed, Jul 24, 2019 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 23-07-19, 18:42, Saravana Kannan wrote:
> > > The devfreq passive governor scales the frequency of a "child" device based
> > > on the current frequency of a "parent" device (not parent/child in the
> > > sense of device hierarchy). As of today, the passive governor requires one
> > > of the following to work correctly:
> > > 1. The parent and child device have the same number of frequencies
> > > 2. The child device driver passes a mapping function to translate from
> > >    parent frequency to child frequency.
> >
> > > v3 -> v4:
> > > - Fixed documentation comments
> > > - Fixed order of functions in .h file
> > > - Renamed the new xlate API
> > > - Caused _set_required_opps() to fail if all required opps tables aren't
> > >   linked.
> >
> > We are already in the middle of a discussion for your previous version
> > and I haven't said yet that I am happy with what you suggested just 2
> > days back. Why send another version so soon ?
> 
> I wanted you to see how I addressed your comments.

Sure, but that is just half the comments.

> It didn't look like
> you were going to make more comments on the code.

I posted some queries and you posted your opinions on them. Now
shouldn't I get a chance to reply again to see if I agree with your
replies or if we can settle to something else ? I only got one day in
between where I was busy with other stuff and so couldn't come back to
it. Please wait a little longer specially when the comments aren't
minor in nature.

Anyway, lets get over it now. Lets continue our discussion on V3 and
then we can have a V5 :)

Have a good day Saravana.

-- 
viresh
