Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB17267D81
	for <lists+linux-pm@lfdr.de>; Sun, 13 Sep 2020 05:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIMDqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Sep 2020 23:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgIMDqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Sep 2020 23:46:09 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12260C061574
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 20:46:08 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id m25so3220279oou.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l97SIHYcVviH6hXnJk1EAiHlHPp1GVZuGyZcGgSd9F8=;
        b=tW7ibLZS/nv3i49oxdNxKOdTe9/Vo2uRr+Oj9DML7mD5y/lkij63Zc7tKgFKKS3WKe
         lzywt31TUMAPYLHqgSdjZCoSuE5bE7CSqopkCh1pMGN0bgG13jzadBdxr7NcNk7qX1+M
         Nm8IvYILyzH+S628pBTTfIVS07hhtN6z+IyNPl0f8GTMkR2YuWJUlQofdwimXlEWE2ow
         OJ+7GXXdsqpzsKs7VjoGk94E877uMaZsO7sPYydEA2/0/toJRPSj/axeMRjTkO1L1UBv
         BEuc5GO0aDB+qdZkPN7vGZfa3e4EGRYk1CgSegDrsVRmCIZvov6VDOhoCbJSxZTJX5jU
         rWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l97SIHYcVviH6hXnJk1EAiHlHPp1GVZuGyZcGgSd9F8=;
        b=dNnaMqYG8ZpFKM/0n1whOD9w26FVSTD8sZ1eP/n8p60PagcpLRCOdgZYAnQV2RC7iC
         8YOMafbTJ8uZ4YGNVE65Rew4LshqfXBOLIMxp8T5b35r1VHh4Jfqf7katDgSugwMZHXD
         FyCmPB3VtSgxekcQ++scyE+YrB08ren9kPVKV3EmoTw/W40Dm/d3ZUzFmz4rJgDyhk5V
         xKfbzmvm1TSp72O7KF6tcNYTrA9jkYeN4W1UL1vdLZrhYUActhkxoarCL7kdiIcJjg4E
         NbHXZYFUxgzbU2fWmQJMXQLrm5X24njy+X9P40XqTr4RqLhTqUY2oUKC2ad/uO4Li2/N
         PW6g==
X-Gm-Message-State: AOAM531SiMjsxtHrwtCCb0mXkpZ3KFkVpihAityp96uI1htPqefh3Fxs
        JDkbQC8mhuKtI7GUwqo/LAFfRA==
X-Google-Smtp-Source: ABdhPJxqFt8JItM3PP/MnPVkF9HffiJEM4+BpfKZSqhWRMbyvAsysiGLcjIdD452HRWg5afH3wDQkw==
X-Received: by 2002:a4a:978a:: with SMTP id w10mr6382019ooi.69.1599968767801;
        Sat, 12 Sep 2020 20:46:07 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id f11sm1254670oot.4.2020.09.12.20.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 20:46:07 -0700 (PDT)
Date:   Sat, 12 Sep 2020 22:46:03 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
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
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME
 flags
Message-ID: <20200913034603.GV3715@yoga>
References: <20200821204921.32536-1-sibis@codeaurora.org>
 <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
 <20200824164212.GA3715@yoga>
 <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
 <20200825175345.GC3715@yoga>
 <0101017476da3906-412a2e35-dc56-43ee-8644-83a998279c2d-000000@us-west-2.amazonses.com>
 <CAPDyKFq=R9_4r+T8V7Fn2PvLr5HicKOTQMAGh4Lg3-Q=KaOiDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq=R9_4r+T8V7Fn2PvLr5HicKOTQMAGh4Lg3-Q=KaOiDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 10 Sep 03:18 CDT 2020, Ulf Hansson wrote:

> On Thu, 10 Sep 2020 at 09:23, Sibi Sankar <sibis@codeaurora.org> wrote:
> >
> > On 2020-08-25 23:23, Bjorn Andersson wrote:
> > > On Tue 25 Aug 02:20 CDT 2020, Stephen Boyd wrote:
> > >> Quoting Bjorn Andersson (2020-08-24 09:42:12)
> > >> > On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
> > > [..]
> > >> > > I find it odd that this is modeled as a power domain instead of some
> > >> > > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
> > >> > > there some sort of benefit the driver gets from using the power domain
> > >> > > APIs for this vs. using a custom API?
> > >> >
> > >> > We need to send "up" and "down" notifications and this needs to happen
> > >> > at the same time as other standard resources are enabled/disabled.
> > >> >
> > >> > Further more, at the time the all resources handled by the downstream
> > >> > driver was either power-domains (per above understanding) or clocks, so
> > >> > it made sense to me not to spin up a custom API.
> > >> >
> > >>
> > >> So the benefit is not spinning up a custom API? I'm not Ulf, but it
> > >> looks like this is hard to rationalize about as a power domain. It
> > >> doesn't have any benefit to model it this way besides to make it
> > >> possible to turn on with other power domains.
> > >>
> > >> This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
> > >> SMEM APIs, so standing up another small qmp_remoteproc_booted() and
> > >> qmp_remoteproc_shutdown() API would avoid adding a genpd flag here
> > >> that
> > >> probably will never be used outside of this corner-case. There is also
> > >> some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
> > >> would be possible to do this outside of power domains, and that seems
> > >> better given that this isn't really a power domain to start with.
> > >
> > > In later platforms a few new users of the AOSS communication interface
> > > is introduced that certainly doesn't fit any existing API/framework in
> > > the kernel. So the plan was to pretty much expose qmp_send() to these
> > > drivers.
> > >
> > > My worry with using this interface is that we'll probably have to come
> > > up with some DT binding pieces and probably we'll end up adding yet
> > > another piece of hard coded information in the remoteproc drivers.
> > >
> > > But I'm not against us doing this work in favor of not having to
> > > introduce a one-off for this corner case.
> >
> > Bjorn/Stephen,
> >
> > So the consensus is to stop modelling
> > aoss load_state as pds and expose qmp_send
> > to drivers?
> 
> Would that mean qmp_send would have to be called from generic drivers?
> Then, please no. We want to keep drivers portable.
> 

No, this is only called from Qualcomm specific drivers. So I'm okay with
that approach.

Regards,
Bjorn
