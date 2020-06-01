Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F291E9C0B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 05:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgFADcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 23:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgFADcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 May 2020 23:32:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F1C08C5C0
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2020 20:32:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so3670563plv.9
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2020 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GiN6URCGOi3zRMrgGTBxhLW3I/ES5CEjKSS6Efx8Rn8=;
        b=ImCDKxj6g9w1zOY09EE2wYtZmGjUvkxmO/6oBVTbP0l962iXO11Pw3cB+X7Bl1LsOA
         9sow2JwLIVNGKEUSlIkOw4FwTSDp/NtcUACWvQ1jFMzHw2CrwjAHv70+qe9q8iMP3AFh
         RXaG0gWPDgxJHcI4T3YbvbJFVtQHbQAOWIGmfpps4TfOjDfc4VOIG0fMJDUMvNnRgihQ
         KQ7tsmVmb49D22qAruIdUn6UsUYZ5mis8hsWrYU4Z399XCzwcEPufqU1fuL+pw3MqRMg
         q3kiIlvoSzXONKofT1mkJu2md1IdV08xjSdJacVoORVljabL1hLinP8qKuuC86NR5zev
         doww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GiN6URCGOi3zRMrgGTBxhLW3I/ES5CEjKSS6Efx8Rn8=;
        b=PFBONNL8BVz1oYNWM4H0f+lmvZRslMTqm1Tn9c3hD2rtpQBNJk/dsmhhcpEYBBe8qr
         Ym1lpFYipbPo9hUP3p9tKlUBAZqdRFjPY5l3JejooQEDx1yazTj/WhXzYtEaKNnKvhTZ
         P3jnXDYNQPsp6oXllN3RnPV6sOQxsxnpg7410deH2BaYcHNa9+z7ux1yjAA7+8nSkoMt
         iak75zt87v9scH4vvZOJqrI6wtB9fJJxb2/KPErO7D3pWGEDo0gai46uyKVccyIFo79k
         RbEL1O/ij1+FLlSEWGAprVsUEd+knAUriMz2OjtzkdKHy+rfwG56HCXqFvSjNdH7tccr
         Osdw==
X-Gm-Message-State: AOAM531v+UME9jSPX0KkG80QtoUYUgKEQjlpnl7teRdzkU3+odfixlFJ
        DsdJ2mbfaN0xWM44Vsk1OJfZeQ==
X-Google-Smtp-Source: ABdhPJym07gd+NSj3jXYzvEjjDY2repB3sRc/S4lw1IVMp0MmA2Dg8j3uqQWKiFQIPm8IfYjGh4qhg==
X-Received: by 2002:a17:902:7618:: with SMTP id k24mr18753586pll.167.1590982330607;
        Sun, 31 May 2020 20:32:10 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id a5sm12895162pfk.210.2020.05.31.20.32.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 20:32:09 -0700 (PDT)
Date:   Mon, 1 Jun 2020 09:02:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] opp: avoid uninitialized-variable use
Message-ID: <20200601033207.ekro7fckvguguuxf@vireshk-i7>
References: <20200529201731.545859-1-arnd@arndb.de>
 <20200530092052.ksuncmgx3cahokzo@vireshk-i7>
 <CAK8P3a2dADAG9-NnsR8opP++xq6T_BB3C6i-wvkzrKvXNOghiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2dADAG9-NnsR8opP++xq6T_BB3C6i-wvkzrKvXNOghiQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-20, 14:40, Arnd Bergmann wrote:
> On Sat, May 30, 2020 at 11:21 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 29-05-20, 22:17, Arnd Bergmann wrote:
> > > An uninitialized pointer is passed into another function but
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -872,7 +872,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> > >                       goto put_opp_table;
> > >               }
> > >
> > > -             ret = _set_opp_bw(opp_table, opp, dev, true);
> > > +             ret = _set_opp_bw(opp_table, NULL, dev, true);
> > >               if (ret)
> > >                       return ret;
> > >
> >
> > Not sure why people are still seeing this, I pushed a fix for this 2
> > days back.
> 
> I was on next-20200528, which was the first version that was broken for me,
> and I sent all my fixes after I had tested them. Since a lot of things
> got broken
> at once that day, it took me until the end of 20200529 to get it all tested
> properly and then send them out.

Okay, I asked as around 3-4 people have already sent out this patch to
me :)

-- 
viresh
