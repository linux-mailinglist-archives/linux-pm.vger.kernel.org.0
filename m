Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6E294B61
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410108AbgJUKm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410106AbgJUKm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 06:42:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8763FC0613CE
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 03:42:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id d19so943620vso.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8fjyCMsI9nFBeCqIwV1iEyYXSiVeftxbO94d8CtzXE=;
        b=PTapo8jy6Ae3JV1/RCwNsoO/B4HSzgR2WFdrZOG7LoWPeHmvOnLckWKrGqdQAMtLFH
         wnfIbo8Lc2iVr1y6cdaap15/fVo5klVlnW3S5GUFrvf0IVMAu9HacTV6Wkb2h1cwYnOa
         d9/FrZpSK1lZU/2RUvBhbCawgY4S2rF1FVAPKDePUjR6xB4AcJqDJgcYZC3ZnwgdfdVP
         N336sZQa7y1Ju3J6vmb8yENPMeTVHQcmQL8/1gtg8Gt5uxqzVktodli+hbVNDly+s+Tg
         thJr4HFMdWL+bAHi3rP2+/VavoY66vswkcUI0VQKtBcFB0ka9eBv+prXQjwNh3YvE4u9
         Ts+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8fjyCMsI9nFBeCqIwV1iEyYXSiVeftxbO94d8CtzXE=;
        b=ZmmhcXATPf1v77yp94WhXeuDanBlzCtUWbGhtNf6oZRei8G4fvN9ps55mIEN1ue8+5
         2UYzMLJxQe1KElVoBB4fmWVVckCFE9uvvHHGLbuHIHnLw9xA9FSW7HT8M0MvqMv8NwgH
         hGYZLvlw0BTxoF1wmsY/os5MNsTRK2qu0U/Tr+0KORMNlP3WkuwdKfMWyogvGCcGl687
         8osFZdxI1paezH0hb570xO4lXFCw5tKHJepShULLMygP+3kAtU9aJtx+nMonx45zOtTL
         dy2gQkVMBtIrYRXbe/olk+cdLCpFu+Z5fgwqPk4I0228sYXfrPRp4DNdshS1iWjrSJF6
         pj/w==
X-Gm-Message-State: AOAM532QwFIjJndf4fCi3XEB9WHT6dwkHUIbiDkKkhsRgMl4LKGhEbbN
        aVVRLtrICXTMh8VqPJYgSfLl2UvUTDvM72NR1w1/fA==
X-Google-Smtp-Source: ABdhPJxeCF1pGQwmovXMGq1o2nbJ0oUiM7BGAZTxh+XknVV1A8LkQWQBbvmTiMJItHR8SZ56y2py7hSMil0ItowFGc0=
X-Received: by 2002:a67:6b07:: with SMTP id g7mr1185517vsc.48.1603276946613;
 Wed, 21 Oct 2020 03:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
 <CAJZ5v0iNQ51C5WYUy-ZhzpFGMLxSAVV8=xxYBfMX9ia6FOpg1Q@mail.gmail.com>
 <CAPDyKFrLTsYWVhR03hQgRJGGEkmTk5etGR5RcKgMW+Nj60+vhQ@mail.gmail.com> <CAJZ5v0i6CeUy4aQnyMmNyAHfdunWbbB2TsQwtX4QwNwYk+71jg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i6CeUy4aQnyMmNyAHfdunWbbB2TsQwtX4QwNwYk+71jg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Oct 2020 12:41:50 +0200
Message-ID: <CAPDyKFq4sym1V7EjEE4RArrtpBtXi2w1iCVLhNYgPEo4guCqiA@mail.gmail.com>
Subject: Re: [PATCH 0/4] power: avs: Move drivers to the soc directories and
 drop avs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 16 Oct 2020 at 18:30, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Oct 7, 2020 at 5:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > + Arnd
> >
> > On Wed, 7 Oct 2020 at 17:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Oct 6, 2020 at 6:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > The avs drivers in drivers/power/avs/* are all SoC specific drivers that
> > > > doesn't share any code. Instead they are located in a directory, mostly to keep
> > > > similar functionality together. From a maintenance point of view, it makes
> > > > better sense to collect SoC specific drivers like these, into the SoC specific
> > > > directories.
> > > >
> > > > Therefore, this series moves the drivers, one by one - and in the end, it
> > > > deletes the empty avs directory.
> > > >
> > > > It seems best to me, if this can be funneled via Rafael's linux-pm tree. Then
> > > > when going forward, each driver should be managed through the SoC maintainer's
> > > > trees.
> > >
> > > That's fine by me.
> > >
> > > I'd like to get an ACK from the arm-soc side on this, though.
> >
> > I have looped in Arnd, to get his opinion on this.
> >
> > Although, I think the people on cc already send pull requests to the
> > arm-soc maintainers (or perhaps it was these people you were referring
> > to), so just awaiting their acks should be fine, I guess.
>
> OK
>
> For now, I've taken patches [2-3/4] that have been ACKed.
>
> When the [1/4] is ACKed, I'll take it too and apply the last one.

Patch 1/4 has been acked now as well, so I think the remaining part of
this series is ready to go.

However, I noticed that Stephen Rothwell reported some merge conflicts
for arm-soc in linux-next. Quite trivial to resolve, though. Perhaps
an option to consider is to send this as material for v5.10-rc1 (or
maybe rc2) to avoid further conflicts during this release cycle? Just
an idea..

Kind regards
Uffe
