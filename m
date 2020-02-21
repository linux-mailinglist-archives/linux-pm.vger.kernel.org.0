Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7535F1684B8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBURTa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:19:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40769 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgBURT3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 12:19:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so2654702otr.7
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 09:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFj7tYI0k/f8j7tYUdpdud7KpLh5j6ouKtsSoqEvszI=;
        b=YzgEvcaOL7wY8aO+jLfgHbjlVU2xxOJSB3+tw4wl4fh5uOdZSBNHo/iltx0MWip/dx
         EmTuDub5yPlgPH3bHf5Zz0dcdgGkjIUEsy71Jt8pUh7yhvxFxNSCOXr/6sOdr2B80kxv
         8Rp2Bs9lxT2sACVW1LTq3mJ1eHtNvRY4dxHL9l6QS2XrYWRcypud1ZZG3AQHWS8FfBNu
         SESXEQZR7Sf5hOVEpl2Y7jZZIzX77sTXqn/o5jSTY6+C3NsxB5EKu5h//4gqTaj3aest
         bhQC3td7VGOiHJJHqbjo3DXgSmmWovjvU9eaomChJmjbNFaN6EImUpYyfFyRsZJx0O8a
         6QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFj7tYI0k/f8j7tYUdpdud7KpLh5j6ouKtsSoqEvszI=;
        b=BG3RvsBqawpx8crqRpvcI7NXBwxmaD9AThlI1WexmkxqSJR0GUDxM6xufy1MXM9EXc
         caOXCdL8E3NwYzGviNLcgAvr0n7j6ILV5KIFIR54G0BGhn945FrAVQeUk6rGAMwZypYz
         07nqbmmOTjkXstwbvCgYA3SDEUXXIRd/4dQgOcAp+lMD2LVkrfQ4GIsB5lCXSYpg4NzG
         svR1YgFgXNVldHepWY+W1O6KB5RwvovS/28C7V5k/y5CKfoOt0AP+75RDC1bg997l5UE
         O8jQ+Um4P9rlH0337DO/1YMUzt7kwThW7eRn5PQBOP0g2tw7CoO9xbmdAN5W2guLTaW+
         L6pw==
X-Gm-Message-State: APjAAAXqSOyTEhz+UFBgYZTVgmlHhDPz1S4b1dsa6HU/s1GcNxHmjWkq
        Kl7L5wWOZORWoilkMdV9G/NTZG6KGyuYWDecs9GrsA==
X-Google-Smtp-Source: APXvYqxSTtKq6jL9E+diPzBIZDb2QUskTpf2GmcCBEObkgjrpqHE6Zct2GYZmNiSd+PjgI9aUQvm9vp2GioZkW3oYlo=
X-Received: by 2002:a9d:12af:: with SMTP id g44mr16732511otg.332.1582305568936;
 Fri, 21 Feb 2020 09:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-4-john.stultz@linaro.org> <CACRpkdYVQs0dDT8dn2GzQQXrbXATRi8iqHB41EQBMEwMiEFgzA@mail.gmail.com>
In-Reply-To: <CACRpkdYVQs0dDT8dn2GzQQXrbXATRi8iqHB41EQBMEwMiEFgzA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 21 Feb 2020 09:19:17 -0800
Message-ID: <CALAqxLVQ1MqEC6Sdm0DcWHQpuWnOMt5NxNrj_v+byeEa1cfang@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     Linus Walleij <linus.walleij@linaro.org>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 7:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 20, 2020 at 6:05 AM John Stultz <john.stultz@linaro.org> wrote:
>
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
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > Change-Id: If72682e0a7641b33edf56f188fc067c68bbc571e
>
> I sure trust that you know what you're doing here.

Classic mistake. :)

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I assume you will merge this through device core?

I guess? I'm going to resend it again as I think its a reasonable
cleanup, but the urgent need for it from me may be solved by
of_devlink Saravana's patch instead.

thanks
-john
