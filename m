Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3518892D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCQP3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 11:29:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46647 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQP3A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 11:29:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id 111so21976844oth.13
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 08:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emAY05bjeYY5Z+SsTfY1LZi/Lo2xoGD5YVrrYl9x09E=;
        b=m/QBmAQj96LCZ+Hp4gwTDspCYHbn5kolqZwuPhv8AkSPxdLSQLzFkBHHjY/bgiu8+Z
         2+Zs78+R3pw/gjeCIU/wnZsoYav7sRVBFm+/BSWDzCNSlkASt2orv26WxtkTbf/pRCoE
         VNvGPaaTTTKHa8YIDts4Hu7d/MHNTAbkQ6jb6BChthdHw71b2uDP0fqttHN2JXu4FYR6
         t9braptd/jeeuzWzuPoqxGBngtL6NuaN1whEKEBybtH2Om8/dwEbu5a/5Dpyv+GQxsfC
         kHGpgkF4nSC5QaY4jHX+LTcabUPDV4ZZqUT+nL6qayCBagUZ+VkejNBOqobHeYqYZJlJ
         owgg==
X-Gm-Message-State: ANhLgQ12XkOy2vpxIlmhNQdvi6BQEQjCwwwX7jeeL5/qJ3BzVqwYCCSO
        qNFnEY2UZywrM6Z3ItxX/yaftpwGzqGQg8P1Q8k3Fw==
X-Google-Smtp-Source: ADFU+vsoH5Fvp6kQbKaY9XAaVV+Jzj65sdJV03KyDcQvRwcF92QHzUApB3DVqryVY4afUjuOXfv914uUyU/s/qVFyI8=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr3940874otm.167.1584458938872;
 Tue, 17 Mar 2020 08:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
 <efee087b-756d-046b-f161-192682772ee3@freesources.org> <cfeff7f6-5a5c-433d-3906-2edae84f1ad9@freesources.org>
In-Reply-To: <cfeff7f6-5a5c-433d-3906-2edae84f1ad9@freesources.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Mar 2020 16:28:47 +0100
Message-ID: <CAJZ5v0iGL04DdXHHE0+XYj8Mr9k9O2if9JD4NGjfSOxTf8Cxzw@mail.gmail.com>
Subject: Re: RFH with debugging suspend issues
To:     Jonas Meurer <jonas@freesources.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Tim Dittler <tim.dittler@systemli.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 17, 2020 at 4:26 PM Jonas Meurer <jonas@freesources.org> wrote:
>
> Hello again,
>
> sorry for Cc'ing you directly, Rafael. But I'm not sure whether anybody
> reads the linux-pm mailinglist without beeing addressed directly ;)

It's better to keep a public record of the conversations that happen at least.

> Maybe you can point us to a better place to ask for help here?

This is the right place, but I've been somewhat distracted lately.
I'll get back to you later today or tomorrow, thanks!


> >> I'm searching for help with debugging a suspend issue:
> >>
> >> Apparently, on some devices (Lenovo laptops in particular), the kernel
> >> causes a I/O operation on the root filesystem when suspending the system
> >> - even though the final sync[1] is disabled thanks to setting
> >> `/sys/power/sync_on_suspend` to 0, see my corresponding patch that got
> >> accepted in Linux 5.6[2].
> >>
> >> My current guess it that some hardware-specific firmware is loaded
> >> during system suspend. But unfortunately, so far I failed to find what
> >> exactly it is despite following the 01.org debugging documentation[3].
> >> Maybe you can help me shed some light on it?
> >
> > I finally succeeded in reliably tracking this down to firmware loading.
> > With kernel boot parameters `initcall_debug ignore_loglevel`, the last
> > logs before my system freezes are:
> >
> > PM: suspend entry (deep)
> > (NULL device *): firmware: direct-loading firmware regulatory.db
> > (NULL device *): firmware: direct-loading firmware regulatory.db.p7s
> > (NULL device *): firmware: direct-loading firmware iwlwifi-8000C-36.ucode
> >
> > If I blacklist all modules that cause the kernel to load firmware (for
> > me, that's cfg80211, iwlwifi and some bluetooth modules), then the issue
> > is gone.
> >
> > So without further investigation I could imagine three possible solutions:
> >
> > 1. Provide all firmware files to the kernel from the chroot. That
> >    probably means to copy the firmware files to initramfs and to make
> >    the kernel aware of the new firmware path at
> >    `/sys/module/firmware_class/parameters/path`.
> > 2. Find a way to manually trigger the firmware loading operation before
> >    we luksSuspend the LUKS devices.
> > 3. Find a way do disable direct-loading of firmware by the kernel during
> >    suspend.
> >
> > Maybe someone with more inside knowledge could comment on whether
> > options 2 or 3 are possible at all and if not, whether kernel patches to
> > implement them would be acceptable.
>
> Any chance to get a comment on this?
