Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358B0194784
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 20:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgCZThe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 15:37:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46980 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZThe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:37:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so6600566oia.13;
        Thu, 26 Mar 2020 12:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQejYhkmJ8jpMQwP4np5/qfbpLG+c7Y/YgNN9D4Afuk=;
        b=bOKPLVf2Kxy+k9BiM2WIBR6i8oY2iE5Q98V9vwGLgMgDErNKZALvT0YzWkDH4pALms
         ildQnzfzIczfdpFModRwSOsYR0G3kqfECg0AIAh5EDZ8ZksElT2JEK+XsloEkC43vPnP
         PDrgurzbsddgI8bdoQ0HRb/ZKxqN7LLuJzyRpsZBoZJXoXH8ovF3h3AC5I7IMsl1elnE
         DYzXuPV8mLU+LyNRSaK7g++2Inrxg/GFlxxS7S76x1ecTsHvEr2ML2GAU2aHvTHQQ/3J
         wfP2C9QlLkwxmV2Vlbm5opTuy3odHTZFQZnlvQewIkUITHzfHXyZJdlmpvmpq/Equw8o
         ytGQ==
X-Gm-Message-State: ANhLgQ3+f3LKHT5UQKWm4OJTxyL0VU3+hfJhvHT2IRG8wY9/4UxwL8Mx
        UKAlwZmUNFw/sfZ/+IA1c6RlT9pZ/k9Hus9D2t0=
X-Google-Smtp-Source: ADFU+vvEZ/iZqdJiCJri8T3uuYRSdtllmwAZLQvwiAy+tAT0vyGcMSRRnwD384RTgRhlUh8bZass889rIRaKdFwVuXY=
X-Received: by 2002:aca:f07:: with SMTP id 7mr1415179oip.68.1585251453248;
 Thu, 26 Mar 2020 12:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200326144630.15011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iDuv0doOzFd140A17fhLKsdgZXbc_XMOuhUeDt70Jz+g@mail.gmail.com> <bb21941a-69ff-36fe-05dd-8f3eb63326dc@linaro.org>
In-Reply-To: <bb21941a-69ff-36fe-05dd-8f3eb63326dc@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Mar 2020 20:37:21 +0100
Message-ID: <CAJZ5v0ghHFJCfG5vxE=O6+bD4neyvyF2WD6ASGptBaptm2-5Ow@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/idle_inject: Specify idle state max latency
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 8:20 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/03/2020 20:14, Rafael J. Wysocki wrote:
> > On Thu, Mar 26, 2020 at 3:48 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Currently the idle injection framework uses the play_idle()
> >> function which puts the current CPU in an idle state. The idle
> >> state is the deepest one, as specified by the latency constraint
> >> when calling the subsequent play_idle_precise() function with the
> >> INT_MAX.
> >>
> >> The idle_injection is used by the cpuidle_cooling device which
> >> computes the idle / run duration to mitigate the temperature by
> >> injecting idle cycles. The cooling device has no control on the
> >> depth of the idle state.
> >>
> >> Allow finer control of the idle injection mechanism by allowing
> >> to specify the latency for the idle state. Thus the cooling
> >> device has the ability to have a guarantee on the exit latency of
> >> the idle states it is injecting.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org> ---
> >> drivers/powercap/idle_inject.c | 27 ++++++++++++++++++++++++++-
> >> include/linux/idle_inject.h    |  6 ++++++ 2 files changed, 32
> >> insertions(+), 1 deletion(-)
>
> [ ... ]
>
> >> + +void idle_inject_set_latency(struct idle_inject_device
> >> *ii_dev, +                            unsigned int latency_ns);
> >> + +unsigned int idle_inject_get_latency(struct idle_inject_device
> >> *ii_dev); + #endif /* __IDLE_INJECT_H__ */ --
> >
> > I would like to see a user of idle_inject_get_latency() before this
> > goes in.
>
> Do you mean a user for the set/get or the get only? If the latter,
> there is no user yet I just added it to have an usual get/set helpers,
> if that hurts, I can resend by removing it. If the former, there is a
> patch I'm about to send which depends on the 'set'.

So I wouldn't add the "get" thing at all if it has no users.

Also it would be better to send this patch along with the other one
depending on it.
