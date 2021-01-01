Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9299D2E85D7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jan 2021 23:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbhAAWdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jan 2021 17:33:19 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:37109 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbhAAWdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2021 17:33:19 -0500
Received: by mail-oo1-f47.google.com with SMTP id p72so5006852oop.4;
        Fri, 01 Jan 2021 14:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pFpOxZEPDAxEm8QR6gn2JbvYXZ4o937IyQlpy7zERw=;
        b=Vyw3GPkoK9sbcOjzz+lpt+QsFtUQh8z4G7o+038OGEMudZHS1ZMERpCVUfogjdgkt5
         0PNrvyt9QrJutoHT0C3j71O2HvZ2xKAsA8UIzeiXsBuDMU6N+QcGWGE2WqZi13GD7rEJ
         o65Dcp6NgADlF/ef2RLm2ro6pdgx4lHBolkbH8pvGj7lFrBdx537yFL+A2aQFo1NJZmy
         8cQhm8sQ+KA9Nro3egL6Nn6FqK634forEDUUtq+G7DFlALo8wsouWmm6pDDQalg4139m
         Vi0X32Hnf98E5/wfzKiTGpf1gjk6agn74HKR5R9Y1L9cOfN13WfXc5/p20XVJxJ0exiB
         msXw==
X-Gm-Message-State: AOAM532ki8O6rbBTbmfNqU5fqsS34+kkDOMAJE6ekbcWJqwm1SC0Ag9R
        WzFBgG1utfrHX+E+p+G8CNo3S6Au6e3vASTTwSQZS1ZB
X-Google-Smtp-Source: ABdhPJw0JPJIdz9ArV4cUVmC+o4DFsLdhTewrdgNjHF3HYgpwGbYBGO7Jx3Tq/Ht/Y81z30uax/n+NPcvYPGwpJWd5w=
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr28863320oop.2.1609540358434;
 Fri, 01 Jan 2021 14:32:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gTcaKg5NeP8Se-YekKDq=pT4Bu81G1RTdvhucBL3MaFg@mail.gmail.com>
 <CAHk-=wjoyBj-pfbS9OKkcGgZsPRNPg+dWckiFk90Bdw93GhVww@mail.gmail.com>
In-Reply-To: <CAHk-=wjoyBj-pfbS9OKkcGgZsPRNPg+dWckiFk90Bdw93GhVww@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Jan 2021 23:32:27 +0100
Message-ID: <CAJZ5v0iLJY9aVLWCAF-+zTPtkkv06bmvt5PS8+-u6xKeq9o5fg@mail.gmail.com>
Subject: Re: [GIT PULL] Power management updates for v5.11-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 1, 2021 at 10:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 1, 2021 at 8:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >  - Add new power capping facility called DTPM (Dynamic Thermal Power
> >    Management), based on the existing power capping framework, to
> >    allow aggregate power constraints to be applied to sets of devices
> >    in a distributed manner, along with a CPU backend driver based on
> >    the Energy Model (Daniel Lezcano).
>
> This seems very much a non-fix thing.

Well, that's right.

> Please explain why I should accept this outside the merge window.

This material has been in the works for quite a while and it missed
the merge window mostly due to unfavorable timing, so it is not a
last-minute thing.

It is self-contained and it doesn't interfere with the existing
features, so it is not likely to introduce regressions in my view.

I didn't think that there was much to gain by postponing it, because
it wouldn't change substantially between now and the next merge window
and the testing coverage of it in linux-next would be limited.  On the
other hand, having it in the tree would encourage people to build on
top of it, exercise it and provide feedback, so I decided to include
it here.

However, if you'd rather skip it this time, I'll be happy to resend
the pull request without it.

Rafael
