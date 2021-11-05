Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A644659F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhKEPZo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 11:25:44 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41966 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhKEPZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 11:25:43 -0400
Received: by mail-ot1-f53.google.com with SMTP id t21-20020a9d7295000000b0055bf1807972so5423926otj.8;
        Fri, 05 Nov 2021 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUOR2W6epBW6+U1h+LpOGs060WBlxf7sh7/SU6woHic=;
        b=aQLlMOObhoD6v1Pu77pFMOse/LJT0fXop2AWprBKOdQ+HQd89btyPmdhWFRF/XilWy
         CY3iSV8d18gkYZVLlQ77kTek7tYM80cwjYilJo52Ma3+G+19mkj6GImMQ65s0INqyc0O
         hFBIytSiINU1hojnam4p03cYlA5LCti/8Re8rT7M44mr5hoipH2s0qdaPB0xRx1/ra2V
         LaHVx1kGRXyf5WYsy1q4eFRM81/ncDwVNVsMmHP/4RNZuljZyO/1Z62JZqE0F4XAtbnl
         5IM+PLVFthFrmbgmLI87EIzsgf0FSVEVTJ0ODPlDtOtuQQCJIS2r19KDdFQP7xL0UR2g
         DrJg==
X-Gm-Message-State: AOAM532rnA2RP4Xxz0eqfdoZnysmZFGQZJAf7bYMUdrEZSDO9grcPxvN
        Xo2BhAootBuyMFkXE9jybtlmnj/6Y+VSfpPkPS7t1PlQ
X-Google-Smtp-Source: ABdhPJw2b+hg8/ljlOK8CW+rX8VGfxTaLR5OxYRua0ANxZaXyC4c6jABhyO/xki0BV2vrAhPM61AoipCgjFZ9qv8mn0=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr38420884otg.198.1636125783557;
 Fri, 05 Nov 2021 08:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <1635883240-24293-1-git-send-email-manafm@codeaurora.org>
In-Reply-To: <1635883240-24293-1-git-send-email-manafm@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 16:22:52 +0100
Message-ID: <CAJZ5v0g-N0WOASc7RzFpSYC+Y8nFdiw6DmPHcYr5Y7HQeCetkA@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: Reset previous low and high trip during
 thermal zone init
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 2, 2021 at 9:01 PM Manaf Meethalavalappu Pallikunhi
<manafm@codeaurora.org> wrote:
>
> During the suspend is in process, thermal_zone_device_update bails out
> thermal zone re-evaluation for any sensor trip violation without
> setting next valid trip to that sensor. It assumes during resume
> it will re-evaluate same thermal zone and update trip. But when it is
> in suspend temperature goes down and on resume path while updating
> thermal zone if temperature is less than previously violated trip,
> thermal zone set trip function evaluates the same previous high and
> previous low trip as new high and low trip. Since there is no change
> in high/low trip, it bails out from thermal zone set trip API without
> setting any trip. It leads to a case where sensor high trip or low
> trip is disabled forever even though thermal zone has a valid high
> or low trip.
>
> During thermal zone device init, reset thermal zone previous high
> and low trip. It resolves above mentioned scenario.

Makes sense to me.

Daniel?

> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  drivers/thermal/thermal_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 21db445..2b7a0b4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -477,6 +477,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
>  {
>         struct thermal_instance *pos;
>         tz->temperature = THERMAL_TEMP_INVALID;
> +       tz->prev_low_trip = -INT_MAX;

Why not use INT_MIN instead?

> +       tz->prev_high_trip = INT_MAX;
>         list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>                 pos->initialized = false;
>  }
> --
