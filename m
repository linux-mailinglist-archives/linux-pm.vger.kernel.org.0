Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA02B4C76
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgKPRSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 12:18:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32961 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKPRSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 12:18:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id k26so19624909oiw.0;
        Mon, 16 Nov 2020 09:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8nCjWUklv1uqL5YB3imQHkVHNrDBkeRqNKVQtv+q4E=;
        b=QrqI1gCD2NU1I5box1wQhY7XaOsPRrDNeHvHUiNtEch+26cgS3AlbLoYwblKhhS2q/
         vBuJwq69sBS6uQhVRwH/0zuJikucBL1trMBJnbfxqp1B+jO45OqMlr3c2F4bdzzdmsSS
         y1FqHiOHE9+evk55p9nqq+Yyp9+a1NwaJ9T3RpmQHR86JUpUdbJPWtbqBEamn/38vK50
         qstcQ6/0setMSk3+JsBmYY3KyRPl3II3IPG7SGjDUb96J+XRlTzkWzXTmEqFV8E5mcxx
         eav8yc0c4gEumAE/TwsWHup20XXSlT1PG/It5OAuKm6LbpW2psgXctyuKSxzwWXwlYul
         Q6+w==
X-Gm-Message-State: AOAM5310c/sdGHhZdfHlmS+cofkEVovP22Rjn1AnnU48N27VEFrxRc0J
        BTR8Xn2Hy38ctwNbi57aEfhnBjhJTvLMhBiRi/s=
X-Google-Smtp-Source: ABdhPJz5XPbFXE2ilVfkNa74UnNgwcDqoGYqP6YkthwqxGvtXSvOA2EjmjOb2Q4FzPkRp5O0dWClbJJV6D3zEd68cJQ=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr340787oif.69.1605547102222;
 Mon, 16 Nov 2020 09:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20201023060417.517246-1-josephjang@google.com> <X66J0plvSKqFbDIy@kroah.com>
In-Reply-To: <X66J0plvSKqFbDIy@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 18:18:11 +0100
Message-ID: <CAJZ5v0jVQWSawNuKOB+F+2rkneexsd4bYBLBzCkKRq8ssRapbw@mail.gmail.com>
Subject: Re: [PATCH v3] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joseph Jang <josephjang@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, jonglin@google.com,
        woodylin@google.com, Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 13, 2020 at 2:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 23, 2020 at 02:04:17PM +0800, Joseph Jang wrote:
> > Since dpm_watchdog just cover device power management, we proposed to
> > move it to core power suspend.c to cover not only device power management
> > hang issues, but also core power management hand issues.
> >
> > Since dpm_watchdog stands for device pm, we propose to use new name sleep
> > timer and new timeout handler to cover more sleep hang issues. The new
> > timeout handler will dump disk sleep task at first round timeout and
> > trigger kernel panic at second round timeout.
> > The default timer for each round is defined in
> > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> >
> > Signed-off-by: Joseph Jang <josephjang@google.com>
>
> It still seems odd you can't use a watchdog for this, as you really have
> just implemented the same thing here, but "open coded" the logic.
>
> I'll let Rafael chime in here too, as he knows this area much better
> than I as to if this is viable or not.

It is viable AFAICS.

Just make the existing thing work with dev == NULL and use it as needed.
