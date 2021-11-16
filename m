Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36C453A30
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbhKPTer (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 14:34:47 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46898 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhKPTeq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 14:34:46 -0500
Received: by mail-ot1-f51.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so171840otk.13;
        Tue, 16 Nov 2021 11:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPtQKIRcS+qWiNkh4FPrwPNJEjoLFSm+DQsqzMRzjmU=;
        b=iU99A7FXqTWEinyZifTVg0m94wzgf/SFzG+0pJYV/hoXo/CHWv7RRs5i6TRGu9/Uui
         eVyFGQYLbGWwsplVLhPzJAfuSZ05UAENnVj4/M47ZbvIsluQwmKWxb/j4wS/75sWdPmz
         yVqKDzEjr8vr1IPN8Vdu3CY98ChRnWkySzCfayuqC+mJkJ7IBxn27gXi35c4XNjYA0ru
         2+vFQqpBU9nsOSTSU36E9kkLixo8GoEYa3Y5bsFuHwPUAJ/GuhmbDa8KYERfZ6p/sLAE
         2TC/0FDiOetnBjN57xKJq3Uri8NQGPwEVnKnrNhygpR0Xro2xovajfZpy0WP9b/lpriN
         MymQ==
X-Gm-Message-State: AOAM532ottYpKQoOiE9QINQx4J2W4NhrlQbVjM0/U+/aKU5R8LYfSjaN
        zxPrhdcZK5NUEUe4SCXu+SKs4NP+k1MPbt34oOU=
X-Google-Smtp-Source: ABdhPJzpdXqeitf3sDPouuM8JusRK56qP6YJbKhus9sRokEStxX5OUwmQJKpWmzvp8Mc/bZY8L1r+RFA2r9bjYJibdc=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr8272453otj.16.1637091108883;
 Tue, 16 Nov 2021 11:31:48 -0800 (PST)
MIME-Version: 1.0
References: <1635883240-24293-1-git-send-email-manafm@codeaurora.org> <51de966a-9c9e-88a8-5c2c-96773a64d527@linaro.org>
In-Reply-To: <51de966a-9c9e-88a8-5c2c-96773a64d527@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 20:31:38 +0100
Message-ID: <CAJZ5v0gFC6RY6wStwHRaPY7zeMNRBex8GwqyrNrv10USJMxKkQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: Reset previous low and high trip during
 thermal zone init
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 5, 2021 at 7:49 PM Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
>
>
> On 11/2/21 4:00 PM, Manaf Meethalavalappu Pallikunhi wrote:
> > During the suspend is in process, thermal_zone_device_update bails out
> > thermal zone re-evaluation for any sensor trip violation without
> > setting next valid trip to that sensor. It assumes during resume
> > it will re-evaluate same thermal zone and update trip. But when it is
> > in suspend temperature goes down and on resume path while updating
> > thermal zone if temperature is less than previously violated trip,
> > thermal zone set trip function evaluates the same previous high and
> > previous low trip as new high and low trip. Since there is no change
> > in high/low trip, it bails out from thermal zone set trip API without
> > setting any trip. It leads to a case where sensor high trip or low
> > trip is disabled forever even though thermal zone has a valid high
> > or low trip.
> >
> > During thermal zone device init, reset thermal zone previous high
> > and low trip. It resolves above mentioned scenario.
> >
> > Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
>
> --
> Warm Regards
> Thara (She/Her/Hers)
>
> > ---
> >   drivers/thermal/thermal_core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 21db445..2b7a0b4 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -477,6 +477,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
> >   {
> >       struct thermal_instance *pos;
> >       tz->temperature = THERMAL_TEMP_INVALID;
> > +     tz->prev_low_trip = -INT_MAX;
> > +     tz->prev_high_trip = INT_MAX;
> >       list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> >               pos->initialized = false;
> >   }

Applied as 5.16-rc2 material, thanks!
