Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4323CA696E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICNN2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 09:13:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34284 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICNN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 09:13:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so7898763plr.1;
        Tue, 03 Sep 2019 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5bkDAmHBMFK32nnuTqY8Dz+zY+pSRwll+hw9x/DOfxo=;
        b=bWgvdyFlvd/gBZHW1UM8pZEOW5gm/3vhTBtl5kvNL+GJQPZEwPL5XUDDNF6mBbI/3W
         2OkG0djgc+xn7fLgG8VnlW/VDNplJ4JMxUaNWH5awV+jnrfISRu5RPh6k09Mj+DQBysj
         /aJ6gWQmoyywBhzT9GqxXJOJgjbb3toQnTDWBR2YArAbEylAqJl1qbNk8LcxY8vmCgRG
         LwKhSWe4PZzuxJ79l5Gnd+wcwg/CDAtGNlY5DK3C4evcsOCEdRsvfbSvfO7uo1BE11qp
         Peh7u9lJ+JNYLcvjZ9z+xM4Bm5oIOseTdgHyk9h+IlpdP97eJ03+GGh7ahneq8jq5fq7
         qEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5bkDAmHBMFK32nnuTqY8Dz+zY+pSRwll+hw9x/DOfxo=;
        b=NiAg1DK1EElIexxzexZUpg9nBEPFKgJbTuWN40fXnkOlqNIu3Iojen6FBqf4ybM4zG
         7h5lkmX79Fwr+k56LgTHZpOuwKAa2HrkKsncLAlE44j3PG+MD7B0LMtJBIh3UiRa7VWU
         kHm+10fEy0Cofj+If2kytr/9Av8pt4nEX5qJk90AFBGiiti/oHYjNecD0LRaIfZC0CIE
         QkVwDI+kWahKGb2R8GlKzNM3yR0EB5LnQBDG5rf5k9FeGjUui+6IROHwJitrcFOf9PBt
         AED000DV2qn2nJdbSAt9VmGGP4jJTvQtxiDRyK0AyqvmC/jvaKSwXYMOE7PMT1ChcIsj
         Fb3A==
X-Gm-Message-State: APjAAAVvEbpcE3jFDBVjjRTiui/ttUOluaWsiCJXPbKoRwtwTXrqC/tN
        hC/ehz5QzAhXSMGbdUiTigU4qeL+SKdnC2G/np9xAbS7vfU=
X-Google-Smtp-Source: APXvYqx7JswKzeB3Zxp1QRSOlEKbG9I2BSeM7Z8hcpw+m/NQv4CPOiQGbxK6lTHzgn1znrx+lYDNTtn2uEELe1A+vko=
X-Received: by 2002:a17:902:426:: with SMTP id 35mr35833244ple.192.1567516407027;
 Tue, 03 Sep 2019 06:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com>
 <1567346932-16744-2-git-send-email-akinobu.mita@gmail.com> <CAJZ5v0g+NqasLwWRLA_LM+QEjrHquxzEgtvG4_P=4n=vzpOHWQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+NqasLwWRLA_LM+QEjrHquxzEgtvG4_P=4n=vzpOHWQ@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 3 Sep 2019 22:13:16 +0900
Message-ID: <CAC5umyhBkvWFaRpzJ=xtdnf_fLHe2OeJJ01sve8F6HA0=MuLMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM-runtime: allow userspace to monitor runtime_status changes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-leds@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B49=E6=9C=883=E6=97=A5(=E7=81=AB) 6:47 Rafael J. Wysocki <rafael=
@kernel.org>:
>
> On Sun, Sep 1, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrot=
e:
> >
> > This enables the /sys/devices/.../power/runtime_status attribute to
> > allow the user space to get notifications via poll/select when the devi=
ce
> > runtime PM status is changed.
> >
> > An example use case is to avoid unnecessary accesses for device statist=
ics
> > (e.g. diskstats for block devices) while the device is in runtime suspe=
nd
> > by user space LED device actitity trigger.
> >
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-devices-power | 2 ++
> >  drivers/base/power/power.h                    | 1 +
> >  drivers/base/power/runtime.c                  | 1 +
> >  drivers/base/power/sysfs.c                    | 5 +++++
> >  4 files changed, 9 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentat=
ion/ABI/testing/sysfs-devices-power
> > index 3e50536..47dc357 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-power
> > +++ b/Documentation/ABI/testing/sysfs-devices-power
> > @@ -269,3 +269,5 @@ Description:
> >                 the current runtime PM status of the device, which may =
be
> >                 "suspended", "suspending", "resuming", "active", "error=
" (fatal
> >                 error), or "unsupported" (runtime PM is disabled).
> > +               This attribute allows the user space to get notificatio=
ns via
> > +               poll/select when the device runtime PM status is change=
d.
> > diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> > index ec33fbdb..8891bf4 100644
> > --- a/drivers/base/power/power.h
> > +++ b/drivers/base/power/power.h
> > @@ -74,6 +74,7 @@ extern int pm_qos_sysfs_add_flags(struct device *dev)=
;
> >  extern void pm_qos_sysfs_remove_flags(struct device *dev);
> >  extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
> >  extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
> > +extern void sysfs_notify_runtime_status(struct device *dev);
> >
> >  #else /* CONFIG_PM */
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index b753355..3a3e413 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -94,6 +94,7 @@ static void __update_runtime_status(struct device *de=
v, enum rpm_status status)
> >  {
> >         update_pm_runtime_accounting(dev);
> >         dev->power.runtime_status =3D status;
> > +       sysfs_notify_runtime_status(dev);
>
> There are concerns about this.
>
> First off, it adds overhead for devices that change the PM-runtime
> status relatively often.  I'm not sure if that's sufficiently
> justified.
>
> Second, it is called for status changes from "active" to "suspending"
> and from "suspending" to "suspended" (and analogously for resume)
> which may not be particularly useful.  At least, user space may not
> have enough time to act on such notifications.
>
> Finally, it is racy, because at the time user space does something on
> a device PM-runtime status change, it very well may have changed the
> other way around already.

I withdraw this patch now.  I hope I'll retry with a real use case example
program.
