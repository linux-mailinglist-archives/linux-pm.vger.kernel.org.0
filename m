Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A302455059D
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jun 2022 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiFRPEA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Jun 2022 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiFRPD7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jun 2022 11:03:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5D95B4
        for <linux-pm@vger.kernel.org>; Sat, 18 Jun 2022 08:03:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w20so10950647lfa.11
        for <linux-pm@vger.kernel.org>; Sat, 18 Jun 2022 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IwEUucAXc9IRTosFn5vUfyqLZxY1Y2rjjUJJfMlBqk=;
        b=DkLeR798ijXB2mnUZ5DHNGkbC7MuEX8lnpWr8npSAdm8oxijRZwHDLmvP30GfSZnff
         CyFuoySrjteA3yOxR2khTmrRHqYtfa9jJhQWceXeNrw2WlfNSdj6sOsON+MLwiZIUZ3K
         4DAJ2MqJJsg8yLq5dz+DrTDd9c3AKP+MQjz025+yuPzSinuTifArYStlEBydmswva/Zp
         Y01hPy7IPvLbepOYPmXhNayI6OBxIF4p9KLT8gVYYbrhSipB64Ch+tFjnVpmwO23MnFb
         IhZrbO18WSscRtsVgKEGhIXSTTwk7BrH9ahKNtrZMK666+IBZOGzOj68OuVzeBanq2SW
         oNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IwEUucAXc9IRTosFn5vUfyqLZxY1Y2rjjUJJfMlBqk=;
        b=4DABjmObmCA0rTj/ZumLgRG0Wr2uaWW1aEm5xxc7xPFfQ4X13e1fXOBwbd3W7l1z+r
         sC4RD2fLX5YJta9tdSG3qHmB8G9OSK9hOpklKCvCKaTFDKtFNJMrkOpGL1A/HOeHr4tg
         rhlnbum3kJlW6X/RRYmYqfKYk8XUxXnGPXrjhlLeMBNhuGa4S6USbdtYc54XlNQ4u0TB
         nZYaQtDSdA7ck87ZT9DW9X9CPW0zRHjBX0olO6cW1shosnvawD3439zHcMKxJ2PCH/kR
         QPUNebYaZCzUI4YiNeRzz7tJcHkMOFfnFVGqbcNyjBzrjwocQvm0Jy/UC6izE9KWFlch
         QU3Q==
X-Gm-Message-State: AJIora+4X4MoIjcmPVezwY33KPnf0rVkv4xdm8zasqd/m3iPpK0E79is
        OQ4UkuVOXUsSCMIo5qPoFP+FnTKemyp22DgD/0utjhdJ
X-Google-Smtp-Source: AGRyM1sD20wgr8rxIu0wBwUl4Tum6Zp2MfmAfNIzkZMHyCFMdKL4nX17stg27X7elLIy69T5rTYD9LDdqqaVwPcIcWs=
X-Received: by 2002:a19:4914:0:b0:479:52ea:af4b with SMTP id
 w20-20020a194914000000b0047952eaaf4bmr8225303lfa.544.1655564636211; Sat, 18
 Jun 2022 08:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
 <20220614141742.j7lrj2q5b3suebb2@mercury.elektranox.org> <CAMMLpeSRQ4T=_J0uwjoh=NNeuO43-Nb3PkzfSoDdUhOfU8_TqQ@mail.gmail.com>
 <e2f00afe78432a13adc23fc879f0631ada49e122.camel@sipsolutions.net>
In-Reply-To: <e2f00afe78432a13adc23fc879f0631ada49e122.camel@sipsolutions.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 18 Jun 2022 09:03:42 -0600
Message-ID: <CAMMLpeSEJbChCHm9bWmpvo58RpM7HaNggQHAp4PQ3X4pZT05zg@mail.gmail.com>
Subject: Re: How to identify the primary battery (for Wine)
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Huw Davies <huw@codeweavers.com>, linux-pm@vger.kernel.org,
        Wine Devel <wine-devel@winehq.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 17, 2022 at 5:31 AM Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> On Tue, 2022-06-14 at 09:17 -0600, Alex Henrie wrote:
> > On Tue, Jun 14, 2022 at 8:17 AM Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > > On Tue, Jun 14, 2022 at 2:05 AM Benjamin Berg <benjamin@sipsolutions.net> wrote:
> > >
> > > > Wouldn't it make sense for Wine to use the UPower provided
> > > > DisplayDevice that can be queried through DBus?
> > >
> > > UPower does the required data aggregation for the 'DisplayDevice'.
> > > I don't know enough about the Wine codebase to recommend for or
> > > against using UPower.
> >
> > I also don't know if D-Bus would be a good choice here. It would
> > certainly be a bigger change than the patch that I've proposed. What
> > are the advantages and disadvantages of querying the battery through
> > D-Bus, besides it doing battery aggregation for us?
>
> Well, depends on what you need, it will:
>  1. Calculate a energy/power values if the HW reports charge/current
>  2. Try to generate a proper state (charging/discharging, etc.) if the
>     hardware does not provide it
>  3. Aggregate multiple batteries
>
> Actually, I think using UPower likely fixes bugs:
>  * You are currently not supporting modern hardware that reports
>    energy/power values (rather than charge/current).
>  * You are only reading one battery
>  * You are not estimating a rate if the HW does not provide one
>    (and not smoothing it which might be desirable).
>
> And, well, it should be easy. You can just query properties on a fixed
> DBus path. And if it fails, just assume you don't have a battery.

Thanks for the information! It looks like we're sticking with reading
from /sys directly for now, but it's good to know what we can get over
D-Bus for if we have more problems in the future.

-Alex
