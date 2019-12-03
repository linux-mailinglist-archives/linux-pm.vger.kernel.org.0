Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170CD1103E4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 18:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfLCR4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 12:56:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42564 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLCR4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 12:56:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so4826971ljo.9
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=xKJZIaHtKKjuYtXbsDuWM2Dl2PKeFrJbutUCYZbgryc=;
        b=vY+fK0/0iOXoXphfCYAqMfmDz09jvFcyg+NSgTRbjfMEFLh5TTHOygTc+OAlKgbFtl
         KP1JeWTXn6Nbz87qpP1lDqVKuyLJ2K9Dr2085WxZsQaVHqX0QI5r67HxcGEEu8v+dUeE
         0sqhAcsXEiDpV38F0K+QhAgOALvhB0pXKauCiYIq9P72XGNM5ujpjdXycWrvzZXQCjC4
         3HMwrTyvWM8l5hx7ffuhz81FeTembMKmirRAsU68ad1RDy+dlCCdlWpuwlL9k0SsxizK
         +Z3q4tE7QyoYz0Bo4AELFwQFBjD39mqRda3XpcYC4Y6Brjwq+ZwBndwIh20jKwdI2Pq5
         NFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=xKJZIaHtKKjuYtXbsDuWM2Dl2PKeFrJbutUCYZbgryc=;
        b=DHMl4E27E27RUcLL5my8+mczbf1evSjEIk+3jI+u91lwAMgXeo9bq63Qq2qoqm9kbL
         eBFL18wc0EGsvVv78ROLlMpVrN9FwKyU75NtEvPOTeKDTPOwlkN2m7JL8GADJHmVjgUS
         12T2UHVBi7wkxQYMA1if5fisW1fI9qkJOqY6rXFUeLSJ41S0zR2Rn1aet9K8wGEUdDdf
         un/FCkWguD0cSmxoaza05NSJ41/oui9bpKCA6AcRR2gNRGC24CSjAeBh6mym8pXuxKLs
         q/DYy7IXPKIn13FEbp4QWmn2eH1j3tcW9QoaE/8YpTLhmhF6/gnbrZIp7zVReL9BJKgs
         2SdQ==
X-Gm-Message-State: APjAAAV+sHCdOf7Z/PayrmI3bTab88FpcUUOPLZz8Fngj3aZBz4/cFfX
        9cPNCC+LVQPKKAFKATX/TbwVzjSokGKbnYWZ0cvHlT72uQo=
X-Received: by 2002:a2e:97cf:: with SMTP id m15mt2980335ljj.130.1575395779796;
 Tue, 03 Dec 2019 09:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20191112203154.101534-1-wvw@google.com> <20191112204223.115589-1-wvw@google.com>
 <57162b7c-cf34-2b55-a17c-40d96a0ab105@linaro.org>
In-Reply-To: <57162b7c-cf34-2b55-a17c-40d96a0ab105@linaro.org>
From:   Wei Wang <wei.vince.wang@gmail.com>
Date:   Tue, 3 Dec 2019 09:55:43 -0800
Message-ID: <CAMFybE4aSo7AK20T0Hkjo-R-BkjaYtqz-FMF8pS_p_GeLg5tJA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: Fix deadlock in thermal thermal_zone_device_check
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 3, 2019 at 9:15 AM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
> On 12/11/2019 21:42, Wei Wang wrote:
> > commit [2] changed cancel_delayed_work to cancel_delayed_work_sync to
> > avoid a use-after-free issue. However, cancel_delayed_work_sync could b=
e
> > called insides the WQ causing deadlock [1].
> >
> > [1]
> > [54109.642398] c0   1162 kworker/u17:1   D    0 11030      2 0x00000000
> > [54109.642437] c0   1162 Workqueue: thermal_passive_wq thermal_zone_dev=
ice_check
> > [54109.642447] c0   1162 Call trace:
> > [54109.642456] c0   1162  __switch_to+0x138/0x158
> > [54109.642467] c0   1162  __schedule+0xba4/0x1434
> > [54109.642480] c0   1162  schedule_timeout+0xa0/0xb28
> > [54109.642492] c0   1162  wait_for_common+0x138/0x2e8
> > [54109.642511] c0   1162  flush_work+0x348/0x40c
> > [54109.642522] c0   1162  __cancel_work_timer+0x180/0x218
> > [54109.642544] c0   1162  handle_thermal_trip+0x2c4/0x5a4
> > [54109.642553] c0   1162  thermal_zone_device_update+0x1b4/0x25c
> > [54109.642563] c0   1162  thermal_zone_device_check+0x18/0x24
> > [54109.642574] c0   1162  process_one_work+0x3cc/0x69c
> > [54109.642583] c0   1162  worker_thread+0x49c/0x7c0
> > [54109.642593] c0   1162  kthread+0x17c/0x1b0
> > [54109.642602] c0   1162  ret_from_fork+0x10/0x18
> > [54109.643051] c0   1162 kworker/u17:2   D    0 16245      2 0x00000000
> > [54109.643067] c0   1162 Workqueue: thermal_passive_wq thermal_zone_dev=
ice_check
> > [54109.643077] c0   1162 Call trace:
> > [54109.643085] c0   1162  __switch_to+0x138/0x158
> > [54109.643095] c0   1162  __schedule+0xba4/0x1434
> > [54109.643104] c0   1162  schedule_timeout+0xa0/0xb28
> > [54109.643114] c0   1162  wait_for_common+0x138/0x2e8
> > [54109.643122] c0   1162  flush_work+0x348/0x40c
> > [54109.643131] c0   1162  __cancel_work_timer+0x180/0x218
> > [54109.643141] c0   1162  handle_thermal_trip+0x2c4/0x5a4
> > [54109.643150] c0   1162  thermal_zone_device_update+0x1b4/0x25c
> > [54109.643159] c0   1162  thermal_zone_device_check+0x18/0x24
> > [54109.643167] c0   1162  process_one_work+0x3cc/0x69c
> > [54109.643177] c0   1162  worker_thread+0x49c/0x7c0
> > [54109.643186] c0   1162  kthread+0x17c/0x1b0
> > [54109.643195] c0   1162  ret_from_fork+0x10/0x18
> > [54109.644500] c0   1162 cat             D    0  7766      1 0x00000001
> > [54109.644515] c0   1162 Call trace:
> > [54109.644524] c0   1162  __switch_to+0x138/0x158
> > [54109.644536] c0   1162  __schedule+0xba4/0x1434
> > [54109.644546] c0   1162  schedule_preempt_disabled+0x80/0xb0
> > [54109.644555] c0   1162  __mutex_lock+0x3a8/0x7f0
> > [54109.644563] c0   1162  __mutex_lock_slowpath+0x14/0x20
> > [54109.644575] c0   1162  thermal_zone_get_temp+0x84/0x360
> > [54109.644586] c0   1162  temp_show+0x30/0x78
> > [54109.644609] c0   1162  dev_attr_show+0x5c/0xf0
> > [54109.644628] c0   1162  sysfs_kf_seq_show+0xcc/0x1a4
> > [54109.644636] c0   1162  kernfs_seq_show+0x48/0x88
> > [54109.644656] c0   1162  seq_read+0x1f4/0x73c
> > [54109.644664] c0   1162  kernfs_fop_read+0x84/0x318
> > [54109.644683] c0   1162  __vfs_read+0x50/0x1bc
> > [54109.644692] c0   1162  vfs_read+0xa4/0x140
> > [54109.644701] c0   1162  SyS_read+0xbc/0x144
> > [54109.644708] c0   1162  el0_svc_naked+0x34/0x38
> > [54109.845800] c0   1162 D 720.000s 1->7766->7766 cat [panic]
> >
> > Fixes commit 1851799e1d29 ("thermal: Fix use-after-free when
> > unregistering thermal zone device") [2]
>
> It does not fix the problem actually. It is preferable to revert the
> commit 1851799e1d29.
>
The problem as you mentioned is "This one (WQ) blocks because
cancel_delayed_work_sync is owning the lock which in turn waits for
the work to end"
AFAICT, thermal_zone_device_unregister should not take tz->lock and
either be called in WQ context.

>
> The cancel delayed work sync takes the mutex while a cat
> /sys/class/thermal/thermal_zone0/temp happens which takes the mutex also
> and at the same moment a thermal_zone_device_update() call is done in
> the workqueue context. This one blocks because cancel_delayed_work_sync
> is owning the lock which in turn waits for the work to end.
>
> IMO, that deserves a deeper investigation with the mutex. Probably the
> fix would be to refcount the thermal zone device and see if we can get
> rid of the mutex in some places. If the refcounting is used, the
> function thermal_zone_device_unregister() will be called with the
> guarantee nobody will use it and the mutex can be removed.
>
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  drivers/thermal/thermal_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index d4481cc8958f..c28271817e43 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -304,7 +304,7 @@ static void thermal_zone_device_set_polling(struct =
thermal_zone_device *tz,
> >                                &tz->poll_queue,
> >                                msecs_to_jiffies(delay));
> >       else
> > -             cancel_delayed_work_sync(&tz->poll_queue);
> > +             cancel_delayed_work(&tz->poll_queue);
> >  }
> >
> >  static void monitor_thermal_zone(struct thermal_zone_device *tz)
> > @@ -1414,7 +1414,7 @@ void thermal_zone_device_unregister(struct therma=
l_zone_device *tz)
> >
> >       mutex_unlock(&thermal_list_lock);
> >
> > -     thermal_zone_device_set_polling(tz, 0);
> > +     cancel_delayed_work_sync(&tz->poll_queue);
> >
> >       thermal_set_governor(tz, NULL);
> >
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
