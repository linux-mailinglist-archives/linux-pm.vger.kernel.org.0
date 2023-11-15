Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057ED7EBD58
	for <lists+linux-pm@lfdr.de>; Wed, 15 Nov 2023 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjKOHIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 02:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOHIT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 02:08:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F94F0
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 23:08:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so10000a12.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 23:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700032092; x=1700636892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjgDYCiVZoQHvB83kALIeM9OtG/SOdaCJiN+nH0BdL0=;
        b=PWFchHxOLnIDxyxQOW7xkwrUL4GrQYkU7STtHNvjjtK24qbbpOBVd6RqWcdQeOXWmk
         b/XrC2McPwJpyuC2lH0eDdK/NSd2Tx5lpY51GgWlNwZDIevaZADJp7saj2I3noNTkE/N
         bEczc7939AoxqKnpzqTF4wyrVrBX8z5OJ8wQZMYzc/ZyV75tX1WIdZ0f1URKw3v4XyF1
         73MZaarDAWBW2PWioeAB7lWGNSxB0r6d2rWvJKZZRBe/RbWk0h6RBbKPEv35qFPTccoR
         RM4HhthEvGjHhwnebUjwuSAuoOGAJNqOkRkaKkOK5HV7IZdlLtfuAoGg/dLexRdgIWMP
         11iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032092; x=1700636892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjgDYCiVZoQHvB83kALIeM9OtG/SOdaCJiN+nH0BdL0=;
        b=ES09pQNF5e8CxrgtPmIG485CptTMIZDYSD/WL2uUQwLR3pDsZGXFi5XWUl5CBrUr4J
         Sqpw4lrdfDhOEGvoId2YZJNrZbN24wzWWYeuUb5ZiwKeolzpLAlyOjmPNj1eOO2Wsu+z
         eqTwj/Fc44R6LNDK3aIELjevmkicZOa3DIRMR39leH94IdgtaLS/RjRIIew5MfyYQUaz
         PcI78xLC41gBxZMVW4kbMdTbaZJCCuCQb91szTERhgG6yqWE9uZ483RLkWLa9ycoXoQ0
         ct612HjfRLPLC5aY7uD5OXpBmh8QOnO3bTBCr4FCk7lyBH1GhmlHMdnEwg4BRJsC+snd
         +fcA==
X-Gm-Message-State: AOJu0Yw9xUEHOU1C+CbLmQbZwgnDAsEI+RNJ4ewPjDIjtz2u6A0WKxNU
        6LL6rVqKldZQSmBFWsP0iiBE4oyK7Sf3DwCbhISd3A==
X-Google-Smtp-Source: AGHT+IEe/GNSXejvYayQJoBdKOorcpj9IYPMyfVBFxUm3h3zM4PXIN9nobRvzoCrHFQpIYokeDhIZ64IC16bT6CHdfw=
X-Received: by 2002:a05:6402:1948:b0:546:d479:9c90 with SMTP id
 f8-20020a056402194800b00546d4799c90mr69953edz.5.1700032092427; Tue, 14 Nov
 2023 23:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20231031093921.755204-1-guanyulin@google.com> <f75d6cd2-fa9f-4820-969f-2a8839d78c9e@rowland.harvard.edu>
 <CAOuDEK0NcijUKAL3fGtO=Ks+Y38TRhJcVx+ff-QUyUA0LcQ1Bw@mail.gmail.com> <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu>
In-Reply-To: <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu>
From:   Guan-Yu Lin <guanyulin@google.com>
Date:   Wed, 15 Nov 2023 15:08:01 +0800
Message-ID: <CAOuDEK3UuVGgP63NG9HtuJ0D2ERZsFGBwF5+GNynk=P7zSVUhg@mail.gmail.com>
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org, len.brown@intel.com, pavel@ucw.cz,
        heikki.krogerus@linux.intel.com, mkl@pengutronix.de,
        hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pumahsu@google.com, raychi@google.com, albertccwang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 8, 2023 at 11:56=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Nov 08, 2023 at 04:45:43PM +0800, Guan-Yu Lin wrote:
> > Thanks for the questions. Let me first introduce my motivation for
> > proposing this feature. We can discuss the implementation details later=
.
> >
> > Motivation:
> > Currently, system PM operations always override runtime PM operations.
> > As runtime PM reflects the power status of devices, there is a
> > possibility that runtime PM states that a device is in use, but system
> > PM decides to suspend it. Up to now, we have assumed that a device can'=
t
> > function without resources from the system, so the device should acquir=
e
> > a wakelock to prevent this from happening. However, what if the device
>
> [From the fact that you mention wakelocks, I assume that you're trying
> to implement something for Android systems rather than Linux systems
> in general.]
>
> > does not need the system's support to function? Or only needs limited
> > resources (e.g., only limited power source or clock) to function? In th=
is
> > situation, we would like to keep the device on but allow the system to
> > suspend. This is an example where we would like devices to follow runti=
me
> > PM rather than system PM.
>
> To put it more simply, you want a way to leave some devices in an active
> state while the rest of the system is suspended.  It's not clear why you
> have dragged runtime PM into the discussion (apart from the obvious fact
> that you won't want to keep a device active if it isn't active already).
>

The determination of which device should remain active when the system
suspends can be based on various factors. One straightforward approach
is to consider the device's runtime pm state. Alternatively, we could
explore more elaborate techniques that consider additional criteria.

> This sounds like a major change, not something to be done with a simple
> override.  You should discuss it with Rafael Wysocki and the linux-pm
> mailing list before trying to implement anything.
>
> > Feature Supported:
> > 1. Devices could control the priority of system PM and runtime PM durin=
g
> >    runtime.
>
> This seems like a totally unnecessary side issue.  Forget about runtime
> PM for the time being and concentrate instead on which devices you want
> to keep active.
>
> > 2. The control should be at the device level, meaning that different
> >    devices should control their own priorities.
> >
> > Goal of This Patch:
> > 1. Design a framework to support features above.
> > 2. Apply it into usb for demonstration.
>
> You may find that it is easier (and less work in the long run) to design
> the general framework and get it working than to concentrate on one
> particular subsystem.
>
> Alan Stern

The big picture is "a way to leave some devices in an active state
while the rest of the system is suspended", I think it could be
separated into:
(1) Each system should be able to choose which device(s) is included
    in this feature.
(2) For devices chosen in (1), each of them should have the flexibility
    to determine when it will not suspend with the system, not just
    always being active when the system suspends.

Regards,
Guan-Yu
