Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6171C424DFE
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbhJGHVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbhJGHVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 03:21:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187FC061746;
        Thu,  7 Oct 2021 00:19:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x7so18677872edd.6;
        Thu, 07 Oct 2021 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6PW5fQZS6d4075owqkmplnQGMnVP81b2PiAGptmN6U=;
        b=osbogCzjdSShZcIpnm0FcSSkmScvYv4ctjczNQpiNbPqN80mxmsttJzCeUcgLvSgbh
         dqMG4JgD5NJVVPqbMZLz8OTSrOiWCiY8fkw+U1Qo+gmGU0gGFaQ8ElqQH0eFqugQF+Ms
         30h9D5u2gNZQ/kCeKh6SnG948pvHjvYq73qfLn4hIlU8Ge17ki+GYe3yPxDdgrE9TzuG
         2KFtqAL6jbYq6OZfOpaOp247drl3WoD1emL/Oe8lkfvtm8rGILg8aezUw1b/c8Xh2qBb
         +z2mokAzue18FO+NfRPTGR1UnosluN+ZwRout4rCwF2tgiwtwzHVzYGBWYBtZkSqfyYO
         iYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6PW5fQZS6d4075owqkmplnQGMnVP81b2PiAGptmN6U=;
        b=kpM/E1qvGGoRJShGXwmFOTgwUEsHeE03Qp7MeZcIW0DhmfUE48lzbb4lNWnuE7i8in
         elSBEv7XjfrOWeQ3SGjjMo+Kn8V33vgkYYCS48EO81PaSmGOFktGtJU/yaCoQ3DN4w1S
         cHU2CVIgj54TfdqIx29Krk4jGHI2armlzHJxwkKCoBBYIjOheBSREFH+pFmZEoaT3N8F
         9UfcgZpHnrFiFbkoa1qMjAa8xbueosZcwiHbgjz94IBujylAOGFPX2hSIX5rjk9wm810
         kM5Qe1yBLux2Lk/q2kHtIhVb8VAe56VQ34syV4oZuR00XMNjjLEv1k4onB8Ds5Z1/xOS
         kzJQ==
X-Gm-Message-State: AOAM531EBGFiiWr5IVR5C83WXco82HHxEcJfxpBE7VTq/JTJVolCWtAW
        UzIFEuCVdo7p82e2AfRcC/4W2O7HpumhXtcyfBA=
X-Google-Smtp-Source: ABdhPJxKOQk3/Mj7n3WwroXrqciMwty7VThQ0QiOEZ3kvboTK/bb8KS84oE9n1FuEkpRsSdm20X64eJL47k6dcMazjs=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr3628884ejc.69.1633591168573;
 Thu, 07 Oct 2021 00:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211007060253.17049-1-digetx@gmail.com>
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 10:18:52 +0300
Message-ID: <CAHp75VeHC5M-Rv+wvJQEvmtfX0k7fP6uremGHFMnd8kEqPnBpw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Introduce power off call chain API
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 7, 2021 at 9:05 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Introduce power off call chain API that is inspired by the restart API.
> It allows to have multiple power off handlers invoked along the chain

allows multiple

> until system is powered off. For the starter this series converts couple

the system
a couple

> NVIDIA Tegra drivers to the new API. Existing pm_power_off() method
> stays around and may be removed once all users will adopt the new API.

users adopt

>
> There were couple attempts in the past to add power off API from

a couple

> Guenter Roeck and Thierry Reding, but they were never completed. This
> is a somewhat simplified version which doesn't try to convert whole kernel
> to the new API at once, but solves immediate practical problem that we

problems

> have on Nexus 7 Android tablet where device needs to chain power off

tablets where the device

> methods.

Immediate question here is how do you see the plan of spreading this.
I.o.w. can you put an explanation that you have checked, let's say
>80% current users, and they may be converted like [example
placeholder] without any special tricks?

-- 
With Best Regards,
Andy Shevchenko
