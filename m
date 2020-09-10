Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14568263F8F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgIJIVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgIJIUU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 04:20:20 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2544C061795
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 01:19:16 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r78so1348884vke.11
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uk61sTaccx0/hQSlwACkFUhiMOK87nMWadgiJgRmzUw=;
        b=Yq+j8D+Zda0smKuiw3v7rNXhIDyeTuPUck5pyNh+qPN84bKkTZfDzP+H/gRRv2m4HS
         6MWItL/yY2SrGp6RbOYgC9y93bfZqjXynvVA0V379DvvQR6SrL/WIt+PRnWlEBx0sV4/
         Go6Ly6CmM4x2XRnO5jPB8hlnWJyK2HnLylRmr4prouwyrAn17s+fVchnH3il+Mgl223a
         HovqDK05j7yg/prJUSWxLkZM74MXg+ylGZiLaZYLLDN99vLE0GPpPdYEHbho/R84JjVf
         GG7pGEyGrh4X/dg7sinQqugc9FzN25uG01lOmxt7jWSH6XLfhYoirBLTpZpHlyldpsyA
         +EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uk61sTaccx0/hQSlwACkFUhiMOK87nMWadgiJgRmzUw=;
        b=YEMlq7PtZtxrsc0VZL8wTyi6kcUx4WrOhUOFlX0H5s5EceeFX+wKLfSwd6PDgNbk2Y
         5UE1XOiQmVhqeDr7DaDAaNyi0Lb7kBzDmIC1mm/MmgQqzQ6vzUDISI0GMoyltjNv0yfv
         CIixIPW896mB/tKhldc+vVzNBEosw8aDApmo8GFG99f0CxCGHP5bGc2eFCnqwjlvY//G
         CUVs+jfgngdhS7Y4tgpJtTr+15IfdQ0JMnyi/Ye34erQKao3OIaT/3/jFGaW+ZSuFbMY
         OAANlUTtJZ6W8JdiEQ9sDQYQm+kWS5h2TcEb4UBK4RdVdcYXJGJpFzrGQjvmd7O4L/MZ
         lG4g==
X-Gm-Message-State: AOAM530kVQK7hYVLUkaE0y8YnAsDimMwJcFmiAVresBL+/mMbTXKdL11
        UMZHtD++e0jPHnpDAMREVedIFxMhxzzVYbrysD1kbQ==
X-Google-Smtp-Source: ABdhPJw3pZq9C5u57EnFxdNKPbvGPfqyEXBvz2ddeMDd27lufyfFe3J53FBP0DF2Cnb7F2JBXZFxeAbzyA1ZbcAMB6Q=
X-Received: by 2002:a1f:141:: with SMTP id 62mr3232992vkb.2.1599725954938;
 Thu, 10 Sep 2020 01:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200821204921.32536-1-sibis@codeaurora.org> <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
 <20200824164212.GA3715@yoga> <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
 <20200825175345.GC3715@yoga> <0101017476da3906-412a2e35-dc56-43ee-8644-83a998279c2d-000000@us-west-2.amazonses.com>
In-Reply-To: <0101017476da3906-412a2e35-dc56-43ee-8644-83a998279c2d-000000@us-west-2.amazonses.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Sep 2020 10:18:38 +0200
Message-ID: <CAPDyKFq=R9_4r+T8V7Fn2PvLr5HicKOTQMAGh4Lg3-Q=KaOiDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel-owner@vger.kernel.org, clew@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Sep 2020 at 09:23, Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-08-25 23:23, Bjorn Andersson wrote:
> > On Tue 25 Aug 02:20 CDT 2020, Stephen Boyd wrote:
> >> Quoting Bjorn Andersson (2020-08-24 09:42:12)
> >> > On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
> > [..]
> >> > > I find it odd that this is modeled as a power domain instead of some
> >> > > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
> >> > > there some sort of benefit the driver gets from using the power domain
> >> > > APIs for this vs. using a custom API?
> >> >
> >> > We need to send "up" and "down" notifications and this needs to happen
> >> > at the same time as other standard resources are enabled/disabled.
> >> >
> >> > Further more, at the time the all resources handled by the downstream
> >> > driver was either power-domains (per above understanding) or clocks, so
> >> > it made sense to me not to spin up a custom API.
> >> >
> >>
> >> So the benefit is not spinning up a custom API? I'm not Ulf, but it
> >> looks like this is hard to rationalize about as a power domain. It
> >> doesn't have any benefit to model it this way besides to make it
> >> possible to turn on with other power domains.
> >>
> >> This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
> >> SMEM APIs, so standing up another small qmp_remoteproc_booted() and
> >> qmp_remoteproc_shutdown() API would avoid adding a genpd flag here
> >> that
> >> probably will never be used outside of this corner-case. There is also
> >> some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
> >> would be possible to do this outside of power domains, and that seems
> >> better given that this isn't really a power domain to start with.
> >
> > In later platforms a few new users of the AOSS communication interface
> > is introduced that certainly doesn't fit any existing API/framework in
> > the kernel. So the plan was to pretty much expose qmp_send() to these
> > drivers.
> >
> > My worry with using this interface is that we'll probably have to come
> > up with some DT binding pieces and probably we'll end up adding yet
> > another piece of hard coded information in the remoteproc drivers.
> >
> > But I'm not against us doing this work in favor of not having to
> > introduce a one-off for this corner case.
>
> Bjorn/Stephen,
>
> So the consensus is to stop modelling
> aoss load_state as pds and expose qmp_send
> to drivers?

Would that mean qmp_send would have to be called from generic drivers?
Then, please no. We want to keep drivers portable.

Kind regards
Uffe
