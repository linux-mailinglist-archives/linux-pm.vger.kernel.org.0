Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D416F58D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 03:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBZCOD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 21:14:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46020 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgBZCOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 21:14:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so1426033oic.12
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 18:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJC4mlslET9V3IuYmEEX9Cjes6kXcianVh7OiRR3yKs=;
        b=d0RRnNpncoFvqVEOoPn57Cq0cQ6PP9iVVlgC459m4EF5RlkVaZq4Vyp5rsQf6f20qJ
         pULtmfEK3Rjsw6M3LZ7+RAEf64JSLzN+gBP8dXqFagLo4ItQJSuBGBIysYwWLWcX2dUw
         qBSF11x36vp5nfLUa3chKy7OyHBXhVu6ceBQT2DJISVIlsQ5MUNX4YQjtIMWz6C7H4/t
         OI5a/ft8aQ+gGx+ar7p2TnQNMQVY/hogBsjShOxD1j5BFZk3IgBjKYOjMeTnny7ETs0a
         AdQgP3XXeBX3AMMfl9Qms/YL+VskXMWz0wEmmvrv6spZdsuJEWKbAFEYOSoliE24xo7q
         JZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJC4mlslET9V3IuYmEEX9Cjes6kXcianVh7OiRR3yKs=;
        b=nTrRzlo+UHZIwwyEuOFzzvsRoK96/tlUlKZvOemGNszYMt9bIOjAciID9rvkeHtpgC
         fG4c2c1oaLZEPN5BJcQeRQcTxZdas9uFiUzn1TdQJ4utWgq3+RyMZQ1urJ3KqZpwhEaQ
         yjskAQqYWfufoXFD06jrpcXe+gguE752KR/qeQSnQFl7X+oJUTfS1rV6SJvN+oCCKKsV
         /Fgl+B8EdHVeq0IvhhsqN8lCX4lS9/gKHiILxQn5JwfImxrJh66Go/EuP/v/ZpXgkcTN
         M8zNBmrYYL8kPdIRqRnZugI1TPNv50FG4Bp3BjyJ56jvzpQpqGem7FpzZ5dXhvi9eJCM
         cWIg==
X-Gm-Message-State: APjAAAWRxiVVNsW3DDG5Qamae87N4FD0dwQlfhNg9x49HZDpi0EXUH4E
        hIlvBIpwx8ioloIJytfF54OuoB+Whs98bMspSkDLBg==
X-Google-Smtp-Source: APXvYqyyvLae4My4lNLNDs9nPDn8upLsZw9bgLJTlpOIxxkhcVnvBO6xnKhinNtsF6ILSLQo1EgLO08HJPbQisL58MQ=
X-Received: by 2002:aca:c0c5:: with SMTP id q188mr1315752oif.169.1582683239774;
 Tue, 25 Feb 2020 18:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200225050828.56458-4-john.stultz@linaro.org> <CAGETcx_x4O_M4OJvCSZNu_wroYoyog9nAW7OivS56qzEhFmnHg@mail.gmail.com>
In-Reply-To: <CAGETcx_x4O_M4OJvCSZNu_wroYoyog9nAW7OivS56qzEhFmnHg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Feb 2020 18:13:48 -0800
Message-ID: <CALAqxLUMjF4vx0EAd0bQOixyP5SLZ0pESpC0TXoHbSTyTqQLYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     Saravana Kannan <saravanak@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 6:11 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 24, 2020 at 9:08 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > With the earlier sanity fixes to
> > driver_deferred_probe_check_state() it should be usable for the
> > pinctrl logic here.
> >
> > So tweak the logic to use driver_deferred_probe_check_state()
> > instead of driver_deferred_probe_check_state_continue()
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/pinctrl/devicetree.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> > index 9357f7c46cf3..1ed20ac2243f 100644
> > --- a/drivers/pinctrl/devicetree.c
> > +++ b/drivers/pinctrl/devicetree.c
> > @@ -127,11 +127,12 @@ static int dt_to_map_one_config(struct pinctrl *p,
> >                 np_pctldev = of_get_next_parent(np_pctldev);
> >                 if (!np_pctldev || of_node_is_root(np_pctldev)) {
> >                         of_node_put(np_pctldev);
> > +                       ret = driver_deferred_probe_check_state(p->dev);
> >                         /* keep deferring if modules are enabled unless we've timed out */
> > -                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
> > -                               return driver_deferred_probe_check_state_continue(p->dev);
> > -
> > -                       return driver_deferred_probe_check_state(p->dev);
> > +                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
>
> Is this IS_ENABLED(CONFIG_MODULES) still necessary? At the end of this
> series, doesn't driver_deferred_probe_check_state() already return
> -EPROBE_DEFER if modules are enabled and timeout hasn't happened?
>

Yea, good point. With the reworked logic in v5, the
IS_ENABLED(CONFIG_MODULES) check could go.

thanks
-john
