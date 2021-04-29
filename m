Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8C36E645
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhD2Hvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Apr 2021 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhD2Hvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Apr 2021 03:51:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D4C06138D
        for <linux-pm@vger.kernel.org>; Thu, 29 Apr 2021 00:50:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr7so16041840pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Apr 2021 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTx/thG4WPqLujG9OHbuc45ghslhD/DJHZfDs/oHSh0=;
        b=oOKWpcEuBYKPRs26BuQsrMlUYswythWAXRWqRiEobuyNfwlILxiqnLBTq+qFKwQWPw
         QzsAVsSnnSdNjPohWkmZns64Inbbl9ccZ2sLoWOnA6R5kUWZ08nwFdKt6uSuf4zOkOVc
         oTTKkhNIEzcoFOPtIpVSYEb+e+EYgogDs+3ZNXCo6j9NFbkmGpTbrXW4z/oVeUVZb8BU
         aEIIUfFTcjH6WBK4lPmBfTiaMdBRdy/oUxdY9MjkLWSSzH/MHRud5WK7fXwmhOhh+j1j
         dsnlYTPdKgWKikICp0/5hOkDVFH7CuHzO0F/Iy2LPOTHJTs79t1IXwHqxb44Vkm4paNC
         B2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTx/thG4WPqLujG9OHbuc45ghslhD/DJHZfDs/oHSh0=;
        b=oZ+1TF3zbpwQ43zb9e1RjYhpIIj7JaDZugcDxazCl6i4S/XDucriyFwJbveO8L3Iip
         XfQ2Dj8duiQW8lr7X2Im2QGHdtAQSnxgF6Eul8TRSuBnm2EwD3AmJAuB16haTzY8zalp
         Xona/eylaUH31ITFeKzBydfIm9OBYpHeRTMQwsuDmrwLFoazt3p46LCqxva7/cgg9IWF
         qmovuNrIDXi7Gum8dsGuH+FU2JVGf/eTtRFitfaz4auA2oQFMGQDB3gNpWsPW2CE0k+r
         nFeJuWdSRJiXKAxr4AqD71P+S/2IVuB4bLJ1vcHKXoMww9E/LUzmNYbJISKPIlUUMAPg
         lw+g==
X-Gm-Message-State: AOAM532SoDXbuLC5+22QVgz1T3aDnREXuG+1Q/NFcH/GaXhJEvUoqNvi
        1XuuhI+H7wotLad+QmnuvRZspg==
X-Google-Smtp-Source: ABdhPJwwXEANuKHmnnDxb+3Y+tQzhO7ngCIEXVVT6C6z7FzUdn0wjWg/fZcqn9oaBUazh/6FS8HUOg==
X-Received: by 2002:a17:90a:448b:: with SMTP id t11mr36831576pjg.21.1619682657146;
        Thu, 29 Apr 2021 00:50:57 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id x2sm1653711pfu.77.2021.04.29.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:50:56 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:20:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com, parashar@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 3/3] i2c: i2c-qcom-geni: Add support for
 'assigned-performance-states'
Message-ID: <20210429075054.vrotcbldbaivfh2d@vireshk-i7>
References: <20201224111210.1214-1-rojay@codeaurora.org>
 <20201224111210.1214-4-rojay@codeaurora.org>
 <YAGqKfDfB7EEuZVn@builder.lan>
 <6bfec3e6-3d26-7ade-d836-032273856ce2@codeaurora.org>
 <CAPDyKFqF0NE3QRAEfiqj5QOXXH2om4CpyyeudeqoovANfvjsaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqF0NE3QRAEfiqj5QOXXH2om4CpyyeudeqoovANfvjsaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry Roja for dragging this too long, unfortunately I didn't have a
lot to add on. Lemme try start this thread again.

On 19-01-21, 12:02, Ulf Hansson wrote:
> On Mon, 18 Jan 2021 at 06:36, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >
> >
> > On 1/15/2021 8:13 PM, Bjorn Andersson wrote:
> > > On Thu 24 Dec 05:12 CST 2020, Roja Rani Yarubandi wrote:
> > >
> > >> @@ -629,6 +658,16 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
> > >>      struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> > >>
> > >>      disable_irq(gi2c->irq);
> > >> +
> > >> +    /* Drop the assigned performance state */
> > >> +    if (gi2c->assigned_pstate) {
> > >> +            ret = dev_pm_genpd_set_performance_state(dev, 0);
> > >> +            if (ret) {
> > >> +                    dev_err(dev, "Failed to set performance state\n");
> > >> +                    return ret;
> > >> +            }
> > >> +    }
> > >> +
> > >
> > > Ulf, Viresh, I think we discussed this at the time of introducing the
> > > performance states.
> > >
> > > The client's state does not affect if its performance_state should
> > > be included in the calculation of the aggregated performance_state, so
> > > each driver that needs to keep some minimum performance state needs to
> > > have these two snippets.
> > >
> > > Would it not make sense to on enable/disable re-evaluate the
> > > performance_state and potentially reconfigure the hardware
> > > automatically?
> >
> > I agree, this will be repeated across multiple drivers which would
> > need some minimal vote while they are active, handling this during
> > genpd enable/disable in genpd core makes sense.
> 
> Initially that's what we tried out, but we realized that it was
> difficult to deal with this internally in genpd, but more importantly
> it also removed some flexibility from consumers and providers. See
> commit 68de2fe57a8f ("PM / Domains: Make genpd performance states
> orthogonal to the idlestates").
> 
> As a matter of fact this was quite recently discussed [1], which also
> pointed out some issues when using the "required-opps" in combination,
> but perhaps that got resolved? Viresh?

So I looked again at that thread in detail today. The basic idea was
to enable/disable the genpd from within the OPP core and there were
doubts on how to do that efficiently as there are cases where domains
may be enabled for an OPP, but not for others.. etc. etc.

I am not sure if I consider that thread as part of the discussion we
are having here, they may be related, but that thread doesn't block
anything to be done in the genpd core.

> My concern is, if we would make this kind of change to the internals
> of genpd, it would lead to the following limitation: A consumer driver
> can no longer make its vote for its device to stick around, when the
> device becomes runtime suspended - and how do we know that we never
> need to support such a case?

What about doing this just for the assigned-performance-state case as
the clients don't want to play with it at all.

-- 
viresh
