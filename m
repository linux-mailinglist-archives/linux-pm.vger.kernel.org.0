Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52800C3AA1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfJAQfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 12:35:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38447 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJAQfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 12:35:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so8387401pfe.5
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2019 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=atMkE3+ksZjOVD8COwMqPXYfvUwFAn8HGygWZmnodkw=;
        b=ddoHkIS2jNwy/leh8M6Pn55XjIVeRT7kNE2CgSfYK6DSixUkq4bdQSVEGIcnY1ua/c
         0atFBkR3Zfdo0KNu4LUiZAksyy7OtsN2gGLh12BSbhfl7TeVX4HnyKowU+95+gpj8VsS
         G5EDsbokGIjGKpCp9FGnrFm5A6BSBYfXVOKQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=atMkE3+ksZjOVD8COwMqPXYfvUwFAn8HGygWZmnodkw=;
        b=tF/LOuQXLCEMvk4N0bf3GYnnJHDoZ1I5m514066mrL1GLGDWbxSlIftDeL7FEzzXe7
         lfe9ygywsD38Mta2GS+ywVJHYWffJx5eO6ptwPXi81a3zlLM3QvxmIo5OfaWyXn0gAbS
         gKpNPaC8wD0c3rRHbJ76oyqeLttUpVNzMUWS562/uAoIvG+lQmdCJzp6cTbOCdsGbil0
         6V21MgjrHtSTspfTlrITHb3SDgHrS6WwALoePZ+OiMzcZ89047TsI0OQOtgY/4s1MS10
         RmdWsvZE/ShtTWlrmSad/Tvq9XDfkSBcbzFAby0VlGsqkN1IoRaOHoS2qFCAFKa+nfz9
         oHTw==
X-Gm-Message-State: APjAAAW4+yp6ne7u8sCa70U4Mv9kMHIuUtBlPv7803Dk2uxIgA06sGeD
        9qUY3AwS/qtauL3Iu6oS1paJ5g==
X-Google-Smtp-Source: APXvYqwZAmTy3spFW3KEZLKtOByAgOvBEuREAByP0PaoogzwFCJAY2pIj4bQ2yeV4p/lLCpUqSm8rw==
X-Received: by 2002:a62:e814:: with SMTP id c20mr29298154pfi.209.1569947744868;
        Tue, 01 Oct 2019 09:35:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q13sm5814074pjq.0.2019.10.01.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:35:44 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:35:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20191001163542.GB87296@google.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190927044239.589e7c4c@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 27, 2019 at 04:42:39AM -0400, Steven Rostedt wrote:
> On Thu, 26 Sep 2019 15:04:38 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Define genpd_power_on/off and genpd_set_performance_state
> > tracepoints and use them.
> 
> I agree with Greg about adding a "why" you need this. But, in case
> there's a good reason to have this, I have comments about the code
> below.

Thanks Greg and Steven for your comments.

How about this instead:

  Add tracepoints for genpd_power_on, genpd_power_off and
  genpd_set_performance_state. The tracepoints can help with
  understanding power domain behavior of a given device, which
  may be particularly interesting for battery powered devices
  and suspend/resume.

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  drivers/base/power/domain.c  | 27 +++++++++++++++++---
> >  include/trace/events/power.h | 49 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index cc85e87eaf05..aee988c112e5 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/suspend.h>
> >  #include <linux/export.h>
> >  #include <linux/cpu.h>
> > +#include <trace/events/power.h>
> >  
> >  #include "power.h"
> >  
> > @@ -329,6 +330,9 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> >  		goto err;
> >  
> >  	genpd->performance_state = state;
> > +
> > +	trace_genpd_set_performance_state(genpd);
> > +
> >  	return 0;
> >  
> >  err:
> > @@ -418,14 +422,21 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> >  	if (!genpd->power_on)
> >  		return 0;
> >  
> > -	if (!timed)
> > -		return genpd->power_on(genpd);
> > +	if (!timed) {
> > +		ret = genpd->power_on(genpd);
> > +		if (!ret)
> > +			trace_genpd_power_on(genpd);
> > +
> > +		return ret;
> > +	}
> >  
> >  	time_start = ktime_get();
> >  	ret = genpd->power_on(genpd);
> >  	if (ret)
> >  		return ret;
> >  
> > +	trace_genpd_power_on(genpd);
> > +
> >  	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
> >  	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
> >  		return ret;
> > @@ -448,14 +459,22 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
> >  	if (!genpd->power_off)
> >  		return 0;
> >  
> > -	if (!timed)
> > -		return genpd->power_off(genpd);
> > +	if (!timed) {
> > +		ret = genpd->power_off(genpd);
> > +		if (!ret)
> 
> Here
> 
> > +			trace_genpd_power_off(genpd);
> > +
> > +		return ret;
> > +	}
> >  
> >  	time_start = ktime_get();
> >  	ret = genpd->power_off(genpd);
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!ret)
> 
> And here add a conditional branch for only a tracepoint. To eliminate
> the branch when tracepoints are not enabled, please do it this way
> instead:
> 
> 	if (trace_genpd_power_off_enabled() && !ret)
> 
> The above is a static branch (nop when disabled, and jmp when enabled),
> and the above should move the conditional branch on !ret into the
> section that is only called when the tracepoint is enabled.

ok, will do in future versions.
