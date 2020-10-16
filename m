Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C379F2909BB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408728AbgJPQch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 12:32:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46148 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406083AbgJPQch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 12:32:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id m11so2898261otk.13;
        Fri, 16 Oct 2020 09:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9XQDRvlQghLmc7cloRKPO4ZwvIGydiKXT9gnOHFNaU=;
        b=WpBaxjDRCU8o403mEhKdmmAQHFfNUp6gOMEEYoWrITUOmgoWKoHl8q555UoLdmkmsA
         0eaYgZGxG3Qo4GezZIy6106GrRVILzEMkaSv6nG3txXFPDk0P2kxygkzWnp2FBrqmoZJ
         CQ7l6FC9G7kCR7uRorzaf8/UdknUWuMcL5PglIpqbBrFzn4xopA36mMyyaaWss3uXjah
         kTtFeGrz6XkFjVf+pwgxswtUaHjoxQ8uLK9rKybHCjlHlapRA+QcB+hY7wiQPuIcfKYw
         CIy3Ub9u6UbHl2YGRXg79T4ieKCRbzWqjnswr9YkxfgUZPrX4LJWDsj0qPlnLE2zcYwz
         EPZw==
X-Gm-Message-State: AOAM532sL1BjxTbsCVRVmWSm8vkFHfp00oVPnR2mBtju00vn5OCWPkF+
        SVEF9a3+0gzhMz3OdfS5o07lainVCIV7fIHUj9vCFXjj
X-Google-Smtp-Source: ABdhPJyVa5xvQit4XVpGpV8fPylPi0PVhm+fR31NyyyS2G5P3wW52qGDipYpAdNnBfEZjL62o5+1ezlKqpXSCFEmjzU=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr3414504otk.260.1602865957805;
 Fri, 16 Oct 2020 09:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201015204722.18764-1-ilina@codeaurora.org> <CAJZ5v0ifjHRomAxEKTW5z+VEZLGeM5MN-NcRxUUgrFQvtB0seQ@mail.gmail.com>
 <20201016160724.GB16756@codeaurora.org> <CAJZ5v0gBb91rFHne26zLrMPOKcHTmcDERBRLiPAuVJo+H6BAzA@mail.gmail.com>
 <20201016162119.GC16756@codeaurora.org>
In-Reply-To: <20201016162119.GC16756@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 18:32:26 +0200
Message-ID: <CAJZ5v0ib0ou3+VK4G_Vo2h2po5zzw6R2yoU2Gk2e7K+XpCpEiQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM / Domains: enable domain idle state accounting
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 6:21 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Fri, Oct 16 2020 at 10:13 -0600, Rafael J. Wysocki wrote:
> >On Fri, Oct 16, 2020 at 6:07 PM Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> On Fri, Oct 16 2020 at 09:55 -0600, Rafael J. Wysocki wrote:
> >> >On Thu, Oct 15, 2020 at 10:47 PM Lina Iyer <ilina@codeaurora.org> wrote:
> >> >>
> >> >> To enable better debug of PM domains, let's keep a track of the success
> >> >> and rejections in entering each domain idle state.
> >> >>
> >> >> This statistics is exported in debugfs when reading the idle_states
> >> >> node, associated with each PM domain.
> >> >>
> >> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> >> ---
> >> >> Changes in v3:
> >> >>         - Rebased on top of mainline
> >> >
> >> >I still needed to rebase it to apply it to my tree, so please double
> >> >check the result in the bleeding-edge branch.
> >> >
> >> Okay, will rebase on that branch and post shortly.
> >
> >No need, it's been applied already, just please check the result in
> >bleeding-edge.
> >
> I think I may have the wrong bleeding-edge branch. Is it not
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=bleeding-edge
>
> Apologize for the confusion.

Yes, it is now. :-)

It was not pushed out before, sorry.
