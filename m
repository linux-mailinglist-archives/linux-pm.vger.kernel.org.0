Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26ED24AD19
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 04:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHTC5g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 22:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTC5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 22:57:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E32C061757;
        Wed, 19 Aug 2020 19:57:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so472936pgl.3;
        Wed, 19 Aug 2020 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTZqKjSB9r2gJFW1JAilJsfMpODWTgE7quVxyG/JV0Q=;
        b=aqFB0hcmPtIdQdl+J4qqXU53QuOPGe7WR7ubHvNbF9GJBq/7dDalvoXa2k58qjTM5a
         fhpvWe5h1Sy9QkKke/8nIG4ri/XMB/AY5zt/+p0sXgV435iw62JkVFVH1I6z2NJe50AF
         /cDyK+Q7THqKwg2I+EL/Z2+6UUTc6XW4G96OLODqmmqvV05c/zYCtjLx64yPQELugoVd
         msO8GslO5Fzm5NVTHTzMjoHhTat6IjEKmE6Rs3FmVDV+4JCkyCg1gd4FVYTrrJ1adaei
         Sjj9OY1k6gphOPwX5WVZVly2/Xqu36XfZxaJDfo4miw90uWSlvaKt4GpQrscif7eAKzU
         lzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTZqKjSB9r2gJFW1JAilJsfMpODWTgE7quVxyG/JV0Q=;
        b=W81Yx6oQeZabOHog7YOKkSS37M8KlJ7ntX85olh2GZiwE+rHV5/fOOheD986g/0ran
         Z4N2jJubq8Rkt9JlQvn4FWh6TrVQS6yloBOMX7jLrm8MvuKOGdts6kMni9cAwp8x3pVk
         g1GHAwqEBH6jjDKFP2UfcmhM6Kh+QQk7BygjUF6g01N7ELbBwTsDHUqt1NuqF31NgMTA
         Ay3CUfZq0R+WAOJJpldlYpJ/n+fquoNXCm5kvge7Cdh3ImNoGOLZSqi3WokX0ncuRxzM
         HImjQXnItrntwWoRwCMyLXFRNzoUWpVtFNJXE2/UCC1gPK+nhE75nK7J0y3GyJADMq+R
         SUyQ==
X-Gm-Message-State: AOAM530OIFaW3bD4vyFC9iENemZ+S2dQDxvimBcxaKt8yB2mKwcPZE3S
        QWdhk3iY8YZ+2G+PSi9I4K9EXHU6LIQ=
X-Google-Smtp-Source: ABdhPJyTowlmnktuwtaN+RzZTK1LH2cdJ/Shx8X02gxe0krmkBiaNHaJGSquj+Gf88iJArRik46TbA==
X-Received: by 2002:a62:8cd3:: with SMTP id m202mr697054pfd.184.1597892255994;
        Wed, 19 Aug 2020 19:57:35 -0700 (PDT)
Received: from localhost ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id g9sm672596pfr.172.2020.08.19.19.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 19:57:35 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:57:36 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@yulong.com,
        zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200820105736.000019d4.zbestahu@gmail.com>
In-Reply-To: <CAHLCerPpsFoy=MZSQiHyCCoHLU2X=pT=NR6b0pkX93C+cd5uCg@mail.gmail.com>
References: <20200818063005.13828-1-zbestahu@gmail.com>
        <CAHLCerPpsFoy=MZSQiHyCCoHLU2X=pT=NR6b0pkX93C+cd5uCg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 19 Aug 2020 16:47:01 +0530
Amit Kucheria <amitk@kernel.org> wrote:

> On Tue, Aug 18, 2020 at 12:00 PM Yue Hu <zbestahu@gmail.com> wrote:
> >
> > From: Yue Hu <huyue2@yulong.com>
> >
> > We observed warning about kzalloc() when register thermal cooling device
> > in backlight_device_register(). backlight display can be a cooling device
> > since reducing screen brightness will can help reduce temperature.
> >
> > However, ->get_max_state of backlight will assign max brightness of 1024
> > to states. The memory size can be getting 1MB+ due to states * states.
> > That is so large to trigger kmalloc() warning.
> >
> > So, let's remove it and try vzalloc() if kzalloc() fails.
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index aa99edb..9bae0b6 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/mm.h>
> >  #include <linux/string.h>
> >  #include <linux/jiffies.h>
> >
> > @@ -919,7 +921,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >         var += sizeof(*stats->time_in_state) * states;
> >         var += sizeof(*stats->trans_table) * states * states;
> >
> > -       stats = kzalloc(var, GFP_KERNEL);
> > +       stats = kzalloc(var, GFP_KERNEL | __GFP_NOWARN);
> > +       if (!stats)
> > +               stats = vzalloc(var);  
> 
> Couldn't this be replaced by kvzalloc()?

Yes, it should be more better as kvzalloc has a vmalloc fallback.

Thx.

> 
> >         if (!stats)
> >                 return;
> >
> > @@ -938,7 +942,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >
> >  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
> >  {
> > -       kfree(cdev->stats);
> > +       kvfree(cdev->stats);
> >         cdev->stats = NULL;
> >  }
> >
> > --
> > 1.9.1
> >  

