Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B60489CBB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jan 2022 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiAJPvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jan 2022 10:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiAJPvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jan 2022 10:51:00 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0ACC06173F
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 07:51:00 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s73so19313030oie.5
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2n4Mxe58gHLUEnPXE5oeDtI7K/YB+n1aglZeR3Rn/W4=;
        b=QyaqqwhPNk2QapI3TCYdd0SyoXpwXXIqLTKkB6NI/+njxuIWipqu1/dUbfIhl4DRce
         dAmrxVJ8Cko1MhjzEyO3v89+dSA3U6BAmArjcinBB/50+AOIaFJT7KaatxLWmkKDJnPH
         bQINXIG6QWR1tLDzbcI0tpIFFkFQ01WJsm+uMXjDvxAZHbXSI+iaqtKH2RVa0MxNh1Rs
         MIAz6i/jLdx/Kz/OvoNOnU9NjOhrqvSbl+Wtj3Hgmpkks1B68ec3xP4QublKnCOFiZLW
         oKaLjmmXTpCFOgt94wJYgqStV/z+6vAsJ4V8d8bQV6dPHFcYxh4PExMVrX+hvxXKOGr3
         OM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2n4Mxe58gHLUEnPXE5oeDtI7K/YB+n1aglZeR3Rn/W4=;
        b=sImAbjr/Rq8I9/ILD1Vm5Uu7RM4xu1+iwVABlA1G8fFOM242dEvKN7+OiQ2gK53RyZ
         QSYmFQxXEKOwCAb63AajA0J+KN8+6Lgvc3EBQ2NqdEBCE67L5A0RmiCox4ooiMQ7F+LL
         WxsFQItNMAoWCMN5EOxV9BpIdA1+N9mb1wfYAKeqtC0SlEhmRzf8h5amrJl2jB2Xdpul
         1nsjR4iVBUtbQ/bSLIlhO0AVTqDwez9LBkT9Vl/h1Aeo5fyAZfSAbKnKaBviYutcQbsF
         0UohoKHIc6BkXmBQMq2T1YggN6p1cKKgn5ydQEZtKFesxzgr9Lr80f/EZIqF3jl/wd8l
         iLgw==
X-Gm-Message-State: AOAM531wPXIU3ShEAzSEPn7Q0c+iArgDSl3QkC+W8Bi/H3930OxL3De7
        VQkTYCC0zrlYGCW4VhJQ3MxVy2qEeNA/Dew7OotOeA==
X-Google-Smtp-Source: ABdhPJxVjlxJzkR+kQYNgsdp35b6EFDFfGPq6nn0DGflwGrWihs76DtzgvQWoCz2iSVqgsXWVzILrPNDQyQPzS4VZ2w=
X-Received: by 2002:a05:6808:19a5:: with SMTP id bj37mr63940oib.132.1641829860102;
 Mon, 10 Jan 2022 07:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20220106131931.GA32698@kili>
In-Reply-To: <20220106131931.GA32698@kili>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Jan 2022 16:50:48 +0100
Message-ID: <CACRpkdZZ+LXW5RF=xfFciZX3LshpGHh7uOReVzWCE3M2rCVgeQ@mail.gmail.com>
Subject: Re: [bug report] power: supply_core: Pass pointer to battery info
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 6, 2022 at 2:19 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The patch 25fd330370ac: "power: supply_core: Pass pointer to battery
> info" from Dec 15, 2021, leads to the following Smatch static checker
> warning:
>
>         drivers/power/supply/bq256xx_charger.c:1529 bq256xx_hw_init()
>         error: potentially dereferencing uninitialized 'bat_info'.
(...)
>     1525         ret = power_supply_get_battery_info(bq->charger, &bat_info);
>
> If the first allocation in power_supply_get_battery_info() fails then
> bat_info is uninitialized.  (It's not really possible unless you do
> failure injection).
>
>     1526         if (ret) {
>     1527                 dev_warn(bq->dev, "battery info missing, default values will be applied\n");
>     1528
> --> 1529                 bat_info->constant_charge_current_max_ua =

Ouch, that one was easy to miss! I sent a fixup patch.

Yours,
Linus Walleij
