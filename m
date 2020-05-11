Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288E01CE1D8
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgEKRhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbgEKRhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 13:37:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A22C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 10:37:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so10697437wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayLvqeYWqATA5bQj5fLg2I6fTjHGqPLDoJtYi9Y4aHA=;
        b=B2YQfZ19SBrL5s1ahzAUpJSVLXy9s0SsBFwF1UcljeCMcGn0wLwifkm4A/3ecmjxML
         gWETSy6fbvlo6FjWebqHF+P//ryGUkSow86brx1106ZlQLFag/Em52Dwd0OyMAddcv1y
         itq9Nww5HyA34cSU0Jywv137IapwB7iESAAvMbWlTStydWrCUAEfqIazzcxPr7mJbjen
         pv4llM3jGDFQ6AFI18pciXCqiPfM1iSWp160RFSxziDb7HsSAJGBANgm1gSBZsIbyI4G
         vy7ENmB5xmiei8MgtvGCJM8/MEzfDwMIsY3Ntsknw8AeMOYsaQf/xOLNMWeZPV9XtCmq
         dNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayLvqeYWqATA5bQj5fLg2I6fTjHGqPLDoJtYi9Y4aHA=;
        b=HxI0YR5pLJjS+KbMC8KuLUZ/AYGxY8wvJ8wFS1Vz9TThc0ZNYlfnDmcf/rdghag2wA
         /buzkWtWRa8vqjZQlCuOIniulYkOcewHhSU1EWBcxd3qCotzldYjrTUtqvSl5bjJkwQq
         3Fsu5F6Ks7//wNE4oBgbvuUO+/cmlR13umX9c3gPhwmYoG/uWU6j0ztN0MWjgfmAbrgw
         zw5t/gXpis7JL0NiX24+RV7KrWlErPxd6bPev2JXLrjBbhKlAWBRH6ZRKSiXrFUsWR3Y
         4mIJz1oHSNYRK+E0iU1ALv5g+azcOUdhvgWF27YSN+AQ8QTnk3QZrJ4HQXbzONnvskyv
         JBdg==
X-Gm-Message-State: AGi0Pua55kr748H1MtJyPdoH/G8hRkXerLOi/l0S/tsMMWxRlgplqFHf
        vpQoSTMtThyBOthnJbXam/ijxfPfKjGyY0sLWiLUyNjcNLrsVw==
X-Google-Smtp-Source: APiQypIF6nqq/7vCoLfa1X1WanpXbwBnw1Za2yLXPvvMhDu120RyEQEp17GHICnVxafC6+h9VF05sZ2qDIvyRoJ5QN0=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr32007969wmy.168.1589218641278;
 Mon, 11 May 2020 10:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Mon, 11 May 2020 11:37:04 -0600
Message-ID: <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
Subject: Re: 5.7 sleep/wake regression
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> >
> > Got an older Macbook Pro that does suspend to RAM and wake OK with
> > 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> > it has a black screen, gets hot, fans go to high, and it turns into a
> > hair dryer. So it's a regression.
>
> There is a known issue addressed by this patch:
>
> https://patchwork.kernel.org/patch/11538065/
>
> so can you please try it?

Patch applied, but the problem remains.

CPU is i7-2820QM and dmesg for the working sleep+wake case:
https://paste.centos.org/view/ea5b913d

In the failed wake case, I note the following: the fade-in/out sleep
indicator light on the laptop is pulsing, suggests it did actually
enter sleep OK. When waking by spacebar press, this sleep indicator
light stops pulsing, the backlight does not come on, the laptop does
not respond to either ssh or ping. Following  a power reset and
reboot, the journal's last line is

[   61.678347] fmac.local kernel: PM: suspend entry (deep)

Let me know if I should resume bisect.


-- 
Chris Murphy
