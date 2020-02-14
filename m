Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5625F15D015
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 03:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBNCmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 21:42:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38755 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgBNCmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 21:42:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so8037174oii.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 18:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb54aW+yG+Az/OBoZh/+Q8ucLKJK4gIKkwvNE3BmAkA=;
        b=AnvE2hFIoK20rgu+1vrDSm7/MyKg0VTpi+/H+mR061EJODNY79P2jbBeD1Th9tjqKD
         3OP3hU4wPICUCXr3qDjOjHjm5izu1OGSCmeuQEByAQLqqIRMm18Gj6t76wGP/kYQWkW/
         zWgNqgmPRxI1GaW+kBzo8/Ts6habSAgLtZi3pQMO5ujhMaUMGZIDgoAEHC8ub8L3IxnJ
         gxary9YltpeZ678g/6cKIXLIaeozrnG4Yx8WDE/6adVBXo4AC55GEObgye+/qAMSA861
         XpAEpt9ILf4+9CQKB9nzmmEFzaZABow8Ds99RwI2+TUwtSIdvGub3qt+WBdSq0xTKtv4
         lDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb54aW+yG+Az/OBoZh/+Q8ucLKJK4gIKkwvNE3BmAkA=;
        b=QEbjkEo8w0ZSKlZy91lmhg4DIDjWknNdzqmK/D80HFI1VNb2CylroDxSZLmgZ2CTht
         ZwO3j8I7+6Xtg6wAhd75QvWicoWFhnczermgnD3Fm4RyY31PxVX7Z9A/3K379WlY0jQm
         rEw3IJ3c6vSXOJb/Dq3HrivZIf0LhDYvNUkU1vDQNJGLTKWK1M3MUE1E5C5Di3sbSYkg
         LLV5Py8/gHA47Oyu6HXf/cmdJR7fh+aDOOsNw7T0BjWwKmshNVfIsElQbEDhO+qtL0Hl
         xWEBoWFHHIjffFowNUVi3Ull8QUKwNZiSxNdtZP3PBAx4CgKhn+BO9wHFAZGI5L1LCBY
         hBYw==
X-Gm-Message-State: APjAAAX3LcQwrjOWBc97toQK1dLtX0MdS15+ckfcawnxNLfZK2Ca2OBr
        F3/28k91JZ1bgeY2a2+iVyZN0xKfQs87AAnjgsoY8Q==
X-Google-Smtp-Source: APXvYqyynZyVpLGLOpOvAwB2gyWSQn+oremBsTZD5ZaGsqFIs8mu92cC2I3zKOM79o+mNd/x+ev8z5JMZDeNp3GcDgo=
X-Received: by 2002:a05:6808:18:: with SMTP id u24mr480842oic.10.1581648124218;
 Thu, 13 Feb 2020 18:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20200214004413.12450-1-john.stultz@linaro.org> <CAL_Jsq+P0FZU9DnRhgYu6kvCFVbia=Z20VWNR2qi-Zwv=YtQhQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+P0FZU9DnRhgYu6kvCFVbia=Z20VWNR2qi-Zwv=YtQhQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 13 Feb 2020 18:41:50 -0800
Message-ID: <CALAqxLWN84baRzByTSfzz7-MpAexgKyY2YkrsPFG9BPBqQdhXw@mail.gmail.com>
Subject: Re: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     Rob Herring <robh@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Alexander Graf <agraf@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 5:51 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Feb 13, 2020 at 6:44 PM John Stultz <john.stultz@linaro.org> wrote:
> > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > at the end of initcall"), along with commit 25b4e70dcce9
> > ("driver core: allow stopping deferred probe after init") after
> > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > instead see an error causing the driver to fail to load.
> >
> > That change causes trouble when trying to use many clk drivers
> > as modules, as the clk modules may not load until much later
> > after init has started. If a dependent driver loads and gets an
> > error instead of EPROBE_DEFER, it won't try to reload later when
> > the dependency is met, and will thus fail to load.
> >
> > Instead of reverting that patch, this patch tries to extend the
> > time that EPROBE_DEFER is retruned by two minutes, to (hopefully)
> > ensure that everything has had a chance to load.
>
> I think regulators already has some delay like this. We should use the
> same timeouts.

Sounds good. My memory was a bit foggy from the time I initially
brought this up, and I looked briefly before sending this out and
didn't find the regulator change you had mentioned. If you have a
specific pointer (or patch name or something) let me know, otherwise
I'll dig around later tonight/tomorrow.

> We also have the 'deferred_probe_timeout' cmdline option. It's deemed
> a debug option currently, but we could change that and change the
> default.

I looked at that code, but couldn't really make heads or tails of it.
The initcalls_done is checked and returns before the
deferred_probe_timeout is looked at, so I was guessing the
deferred_probe_timeout was addressing a bit more subtle issue than
what I was going for. If its really the same functionality, I'm happy
to try to rework it.

> > Specifically, on db845c, this change allows us to set
> > SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
> > get a working system, where as without it the display will fail
> > to load.
> >
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Fixes: e01afc3250255 ("PM / Domains: Stop deferring probe at the end of initcall")
> > Fixes: 25b4e70dcce9 ("driver core: allow stopping deferred probe after init")
>
> We can debate the design, but those work as designed. So Fixes?
>

Well, clk module loading would have worked, and then stopped working
with e01afc3250255, so it is a regression of sorts.  And really the
tags are mostly for making sure patches get applied to trees that
backported these commits (and it's not my intention to shame a patch
as broken. :)

thanks
-john
