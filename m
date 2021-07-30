Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D501B3DB1FF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 05:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhG3DhC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 23:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhG3DhC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 23:37:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5AC061765
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 20:36:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a13so9770285iol.5
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 20:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1EKk6db6Y8vCs85qWDsaQdefuQvwKiDm0jlq66LwLk=;
        b=V/0drxt9megCv8w0kDJNaPEyTmBwWbF0FmUQQ6jUct64IS+vXU1mvsvzBy32FtXZB4
         p0CHybwKutlK9CO8+xTY5LnDGLonMZSBXkISqhvVy/BSqPThLtCMLeDL1bUsPliuVafW
         +EUbrG/bqLUPEmke5nDUtOZt5nd0yvfXI3VtP4LkEC0m2+1auhlIdqAekEQhrTBQ9lyp
         QK0m9GnrBXlvxWpIX6JIuEt7SNg9OyWGj8KLYFG/CwY/boN4dLbycNp2CAUl706X7gLk
         ToOkYStabPzB/48DZrw66c0aCHEU0tI8rU8fg+Fo0/5fnDIHc/5YcuheT4dpVEDyIlYc
         pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1EKk6db6Y8vCs85qWDsaQdefuQvwKiDm0jlq66LwLk=;
        b=uJbgLpMEw13OeHONXlaBTnc7GwEkdGOLdbvsJ6I9udr0ZEatw3ya/3ZjcicBMBRpnD
         nvMewYECI6PrjovUgJaejqbcoW6JWFvukX8k3Rbvn8s6LaDKoa83kks7Y/xPb8N+6ErA
         U/zqpcjUYxNb+FvAesKFERXttgzJf5ZAr5pR68HowgOSkF3wGdin0E5VP0hl3Lis+Qgy
         XSgQc9zOrz1VMpYEiPV4KRgInyOn/gEtE49awY/VdzKM+vzfeRJzPhA1a2X3uC7FXFaN
         nxf4KNtnZfIv84d7E/3q1gVIS/+HohxmESXRYSY+xZkVecLsB7HNSTJZA1ExdXYYb5cq
         523w==
X-Gm-Message-State: AOAM532ldVa8RiJe9eG4rYGbzhkZTYWANVVkwjR6rDW9zCdTMi/zi8nv
        BEZr9r1heeqmaofPT8FBQghdVDylmpvsxnXo/C8FQg==
X-Google-Smtp-Source: ABdhPJzUF9eqp23HlP2sqP5ldU19abiMWl+SYkIm6l1qXI26Szt+e1Rdmhy8esHBOdp8I1LlYRtib0EOTVkO2tpPf+A=
X-Received: by 2002:a5e:db02:: with SMTP id q2mr626895iop.172.1627616217421;
 Thu, 29 Jul 2021 20:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <1867445.PYKUYFuaPT@kreacher> <2178828.iZASKD2KPV@kreacher>
 <CAAYoRsVko5jG=xqH=KTochqQu95i7PDo_6f1LCPGvAP0=XdVTA@mail.gmail.com> <4334837.LvFx2qVVIh@kreacher>
In-Reply-To: <4334837.LvFx2qVVIh@kreacher>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 29 Jul 2021 20:36:49 -0700
Message-ID: <CAAYoRsUn853=yFbYtD+GkbGVTxw8pzo8iZGp1NWkab0vHGpanw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 29, 2021 at 9:14 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
... [snip]...
>
> This means that idle state 0 data are disregarded after disabling it
> and that most likely is because the second loop in teo_select() should
> be over all states down to idle state 0 (not only down to the first
> enabled one).
>
> So below is an updated patch (not tested yet).

Hi Rafael,

This updated patch works great / solves the problem.
Tested-by: Doug Smythies <dsmythies@telus.net>

Thank you very much.

... Doug

>
> ---
>  drivers/cpuidle/governors/teo.c |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/governors/teo.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> +++ linux-pm/drivers/cpuidle/governors/teo.c
> @@ -397,32 +397,34 @@ static int teo_select(struct cpuidle_dri
>                 intercept_sum = 0;
>                 recent_sum = 0;
>
> -               for (i = idx - 1; i >= idx0; i--) {
> +               for (i = idx - 1; i >= 0; i--) {
>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>                         s64 span_ns;
>
>                         intercept_sum += bin->intercepts;
>                         recent_sum += bin->recent;
>
> -                       if (dev->states_usage[i].disable)
> +                       if (dev->states_usage[i].disable && i > 0)
>                                 continue;
>
>                         span_ns = teo_middle_of_bin(i, drv);
> -                       if (!teo_time_ok(span_ns)) {
> -                               /*
> -                                * The current state is too shallow, so select
> -                                * the first enabled deeper state.
> -                                */
> -                               duration_ns = last_enabled_span_ns;
> -                               idx = last_enabled_idx;
> -                               break;
> -                       }
>
>                         if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
>                             (!alt_intercepts ||
>                              2 * intercept_sum > idx_intercept_sum)) {
> -                               idx = i;
> -                               duration_ns = span_ns;
> +                               if (!teo_time_ok(span_ns) ||
> +                                   dev->states_usage[i].disable) {
> +                                       /*
> +                                        * The current state is too shallow or
> +                                        * disabled, so select the first enabled
> +                                        * deeper state.
> +                                        */
> +                                       duration_ns = last_enabled_span_ns;
> +                                       idx = last_enabled_idx;
> +                               } else {
> +                                       idx = i;
> +                                       duration_ns = span_ns;
> +                               }
>                                 break;
>                         }
