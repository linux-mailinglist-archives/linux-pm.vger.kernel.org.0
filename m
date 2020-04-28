Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82581BBD1B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD1MJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 28 Apr 2020 08:09:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44185 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgD1MJl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 08:09:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id j4so32183399otr.11;
        Tue, 28 Apr 2020 05:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ogZaRQ86QzPygdavyNb/kUDC1GjqiLxjA1gaKlnqA9E=;
        b=BJCHGwCRkkKpLIhVMtkPNLyW9qGaaRF3pQRQ9cZ8mewVf3WosjSgbrSPGRVD1yOG0D
         y2ooif0kq7CR/c1wkPsCbglRyj/HSZ8Ui+7+V+GVknyThr3XV6C/YFqQhpbEmvhCN5/8
         s8F+4XpetSw5VB+JEM4LxL49m7guxv+OEBwkq9TtfUKYi8wC5pkCCi+JS9nPLlTXDpwT
         OkXreY67wJeXHhIO3d7okmd2xCdE0jb9iuj2KmKyYpuevluUtx8Cj7D1IrP1ostk1wot
         ya0wm6gHW3L2ZKg/ntZLU5UtkHGuZyJ9/AWhlwPmn5jOloI5Drvsv+oJlHIgOVfNMA9j
         JGFw==
X-Gm-Message-State: AGi0PuYQ3bU8iEkYbwA7+C/Ran/XR11bN9gzUTHdX3WQFOdiFEVhHbjJ
        2cSpoFKs1IZVvD8wwKYggWTPJgKhQhwyoigrCko=
X-Google-Smtp-Source: APiQypIyL9avwD2oX8pSrvq4Apyl4sPaadyREjdcHjrWr9Gkkf4rUmYlAEygpEUgKfUggbYYkSA2qiyDgDW5rTK7KBE=
X-Received: by 2002:a9d:564:: with SMTP id 91mr22286712otw.250.1588075780739;
 Tue, 28 Apr 2020 05:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200305012721.425330-1-niklas.soderlund@ragnatech.se> <20200428120325.GB1372619@oden.dyn.berto.se>
In-Reply-To: <20200428120325.GB1372619@oden.dyn.berto.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Apr 2020 14:09:29 +0200
Message-ID: <CAMuHMdXdj8L1cue=-NUefjfHXCx4gxwsRW=w4000Sk9Lt0yzAQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Tue, Apr 28, 2020 at 2:03 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Soft ping on this patch. I'm unsure who to pester about this patch being
> picked up, should it go thru the thermal or Renesas tree?

IMHO, through the thermal tree.
If the thermal people feel otherwise, please ack, and I'll queue it in
renesas-devel.

> On 2020-03-05 02:27:21 +0100, Niklas Söderlund wrote:
> > From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > Add an entry to make myself a maintainer of the Renesas R-Car thermal
> > drivers.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
