Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFE1D4AAC
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEOKOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 06:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgEOKOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 06:14:44 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB16C061A0C;
        Fri, 15 May 2020 03:14:44 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id j127so437216vke.4;
        Fri, 15 May 2020 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ6OfaKWMNYLsq/vPPXTECTxhgHBG6tG/ll2X5nosuY=;
        b=CMChNp0FChPCbFs3F+MPjQ8mCacNZi+APaqwCEJMony0vvfP4fzBL/plYi1PTDsgjK
         3QT3ITHBA23ywLRg/M8uhZvZvgMqYwefgNad/vATXqp5pZCAy5KnBj2Lnm47dp+fm07g
         luF6VNtLHrIuV7oxuc2jQ2uEQe2HUEvZOr72HWZhEgMhQVS6Bb+jTOtbmSis2Q9HU4km
         Rw+76lFSY3QaXJQmOnNFPR7Ya4yfLqY9yugsS076acxRvt1+K6DjB6LbVYs0KpcOtdd8
         k2Ke3achgeQ0U5rXPq3LNHZ6+oXMPBlKrgMuI0+qhdU3YD3/GsU9mbdxp1MmB+3gVpQz
         7Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ6OfaKWMNYLsq/vPPXTECTxhgHBG6tG/ll2X5nosuY=;
        b=cmcjLLwcd73W5X5R0ekQqwNoiAcQcHJfgKH2O9BF2GPfPPfpdTb10pwwvjIw5kjgpE
         6fm6kAhzo9nNFHyOMGorOYHK+uF0dI4wWo+sxRhvY7pFNcFV/+1b2pbrOHag8Q3Lg0O7
         nwHJANsHX/HqdXE23K5QWLi99ibmLOzt8rQJ0gKfIf26cjDmFhR4HeEDwDNsCKzsFM45
         nK3eHto45lx/m4kfsuI+49uzojwFRUpysQQXaQfmIpM0V3ZhTrLrniCAbAYuoV5wZMF0
         kL0w6xLkpkbg8KbN6d05iUnL4XO5mAfcRmRiTRtcF1ytHn1SE4bdlzZncK0fRCerF6Ma
         FOWw==
X-Gm-Message-State: AOAM530Z/9pwK5ctqvDMgFY6YhcFhv7IzMJ4CyuGF+7b86E+S9+SRZV3
        1IKboODpQFsWc/ZpxUCW+rSdcMtGPJXugmbmnH4=
X-Google-Smtp-Source: ABdhPJwySImY4STiLUyhyA0RYWBwnXcjZprr971z+NO8BgHmDKAA0Y4ycqtqtV/2t6BMdwfeII55n5dCjcYyTEMlNyk=
X-Received: by 2002:a1f:2f91:: with SMTP id v139mr2005615vkv.22.1589537682435;
 Fri, 15 May 2020 03:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
 <20200513214351.2138580-10-emil.l.velikov@gmail.com> <CAJZ5v0iM5H03=RTtk2sZtUzaW0XJ+AaX1M00C8QjvaNz0ZE3bQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iM5H03=RTtk2sZtUzaW0XJ+AaX1M00C8QjvaNz0ZE3bQ@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 15 May 2020 11:11:57 +0100
Message-ID: <CACvgo52myKJ+3s8pYPnqNBxWqg6bCHQXqGJrLwmrSvocuqU=pg@mail.gmail.com>
Subject: Re: [PATCH 10/11] kernel/power: constify sysrq_key_op
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 May 2020 at 12:21, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 11:46 PM Emil Velikov <emil.l.velikov@gmail.com> wrote:
> >
> > With earlier commits, the API no longer discards the const-ness of the
> > sysrq_key_op. As such we can add the notation.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
Thanks

> and I'm assuming that this is going to be applied along with the rest
> of the series.
>
I believe so, although I have not heard anything from the TTY maintainers yet.

-Emil
