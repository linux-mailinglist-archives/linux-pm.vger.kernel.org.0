Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066EB13523A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 05:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgAIEl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 23:41:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33452 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbgAIEl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 23:41:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so2006100plb.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 20:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRjoVo3zj4W4LfAs9dMN4fOiIUDjAiTixS2yPeXgoDQ=;
        b=muJ29tPvUK4BsxxgLvfXC/FDpAogqeNb4Yj0qnWwm3nQ5iHzd0PKghtKldnrwY4Asu
         R9cMGIY1nMK4gqmHJRBCFzunPvtZ1aCuNfMKGuPpOcAJkWUl9LINrRQtCqLLE47NCqjg
         sYTgbvZESm5lF9IUwWFAr7O8lCrPd1Lvwn2UrddOtwnUXLbvU/PgEFVxlc6kjaMFmZ/n
         y8OoG+fKyEX9Su9Fl54aMGkD1yPcJBC8lYi0/74jl7qyf6RBghWfE0RXNJH2nTcFpbms
         2U69QHRHaTBnPbhn1LpD82CuTXJ08AQ+fG4uK+J4boK3G2+CdK1sxstEeD2h7iq0TFPX
         jNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRjoVo3zj4W4LfAs9dMN4fOiIUDjAiTixS2yPeXgoDQ=;
        b=VMjVXFgJwMnC7k1jPOVms3uukUOMcrC9J9fcdomSn+5RDVG6ssT+FWXhOqiVbu1xN9
         jqnZ2Q0hQKDaqkZ6SjGbm0Ck2RS4Jj7CUmdIrNzMZTSAZ/o+IKvaNMAapNVC9zaHCEaj
         nAQI4g2iaZEV6GOF4IjzFs9TJfsgvQgWjuPFzTlQ7MRjblLMm34FUskhR05TKeoPSSTu
         x1g0CklLEjOtvgNI/4QqDwyWlzkMsOG1uhpI0fi/GxFI2KuW2BxgCTus2vesbu+eIy0d
         MOOHKltR4RfDqHzVCryxXA4EixVZD/ReKLqdY4P+5z77ctfgTvPLQwOy/M6iUkVGGPEH
         UT7g==
X-Gm-Message-State: APjAAAVIEycQDyXPQhMoZCt0mlHzpJqFyhMYzIRvR0MkWhcLDYKguBwk
        44CziTQ03orl29ZTg2Q2ky7evQ==
X-Google-Smtp-Source: APXvYqxjIkobJfEbVA0G149IgU2oFp/wmK3lj3C8cMWvXPKRJq96IVC+8GTQRvil/pY8LRz/7BA/FQ==
X-Received: by 2002:a17:90a:d804:: with SMTP id a4mr2930341pjv.11.1578544916616;
        Wed, 08 Jan 2020 20:41:56 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id r7sm5584790pfg.34.2020.01.08.20.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 20:41:55 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:11:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
Message-ID: <20200109044154.u3ypodoulygemaa6@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
 <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
 <CAGETcx8cro3FHqZhbia6ZUy41XGHwMMSTZgX7QN_2wToWa-Yww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8cro3FHqZhbia6ZUy41XGHwMMSTZgX7QN_2wToWa-Yww@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-01-20, 19:36, Saravana Kannan wrote:
> On Wed, Jan 8, 2020 at 4:58 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 06-12-19, 16:24, Saravana Kannan wrote:
> > > > The frequency OPP tables have helper functions to search for entries in the
> > > > table based on frequency and get the frequency values for a given (or
> > > > suspend) OPP entry.
> > > >
> > > > Add similar helper functions for bandwidth OPP tables to search for entries
> > > > in the table based on peak bandwidth and to get the peak and average
> > > > bandwidth for a given (or suspend) OPP entry.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/opp/core.c     | 301 +++++++++++++++++++++++++++++++++++------
> > > >  include/linux/pm_opp.h |  43 ++++++
> > > >  2 files changed, 305 insertions(+), 39 deletions(-)
> > > >
> > > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > > index c79bbfac7289..3ff33a08198e 100644
> > > > --- a/drivers/opp/core.c
> > > > +++ b/drivers/opp/core.c
> > > > @@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
> > > >
> > > > +/**
> > > > + * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
> > > > + * @opp:     opp for which peak bandwidth has to be returned for
> > >
> > > s/peak //
> >
> > Ack
> 
> Actually, isn't this correct as is? peak bandwidth is "returned".
> Average bandwidth is updated through the pointer.

I think we return two values here, peak and avg bw. Just that we can't
return two values from a routine, and so one is returned using a
pointer. And so I though writing just bw may be better.

-- 
viresh
